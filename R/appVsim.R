source("inst/shiny-apps/vsim/R/colors.R", encoding = "UTF-8", local = TRUE)
source("inst/shiny-apps/vsim/R/icons.R", encoding = "UTF-8", local = TRUE)
source("inst/shiny-apps/vsim/R/presentation.R", encoding = "UTF-8", local = TRUE)
source("inst/shiny-apps/vsim/R/rules.R", encoding = "UTF-8", local = TRUE)
source("inst/shiny-apps/vsim/R/sims.R", encoding = "UTF-8", local = TRUE)

#' run_app: Start a valid sim911 app.
#'
#' @param name The name of a sim911 app
#'
#' @export
run_app <- function(name) {
  # locate all the shiny apps that exist
  valid_apps <- list.files(system.file("shiny-apps", package = "vsim"))

  valid_apps_msg <-
    paste0(
      "Valid apps are: '",
      paste(valid_apps, collapse = "', '"),
      "'")

  # if an invalid example is given, throw an error
  if (missing(name) || !nzchar(name) ||
      !name %in% valid_apps) {
    stop(
      'Please run `run_app()` with a valid vsim app-name as an argument.\n',
      valid_apps_msg,
      call. = FALSE)
  }

  # find and launch the app
  app_dir <- system.file("shiny-apps", name, package = "vsim")
  shiny::runApp(app_dir, display.mode = "normal")
}
