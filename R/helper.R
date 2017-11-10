#' determines the selected checkbox-values based on a comma-separated list
#' (caution: current implementation does not allow commas within the texts!
#' if this occurrs, we'd have to implement the function with regex i.e. taking
#' initial capital letters into account). returns a string-array containing the
#' selected options as required by the shiny::checkboxGroupInput.
#'
#' @param selected_options_string a string containing the radio-options text as
#' a comma separated list
#'
#' @return string array containing selected checkboxes
#' @export
#'
#' @examples get_selected_checkbox_values("Aktuell keine Konflikte und Schieflagen, Was soll das denn nützen?")
get_selected_checkbox_values <- function(selected_options_string) {
  retval <- ""
  if (!is.null(selected_options_string) && !is.na(selected_options_string)) {
    selected_options_string <- as.character(selected_options_string)
    retval <- strsplit(selected_options_string, ", ")
    retval <- as.character(unlist(retval))
  }
  return(retval)
}

testthat::test_that("get_selected_checkbox_values works", {
  sample <- "Aktuell keine Konflikte und Schieflagen, Was soll das denn nützen?"
  result <- get_selected_checkbox_values(sample)
  expected_result <- c("Aktuell keine Konflikte und Schieflagen",
                       "Was soll das denn nützen?")
  testthat::expect_equal(result, expected_result)
})

#' determines the selected radio value based on the current radio-value and a
#' given default value.
#'
#' @param selected_radio_value
#' @param default_value
#'
#' @return
#' @export
#'
#' @examples
get_selected_radio_value <- function(selected_radio_value, default_value = "") {
  cond_empty <- is.null(selected_radio_value) || is.na(selected_radio_value) || selected_radio_value == ""
  retval <- ifelse(cond_empty, default_value, selected_radio_value)
  return(retval)
}

testthat::test_that("get_selected_radio_value works", {
  # 1) test empty radio selection / check if default value works
  sample <- ""
  default <- "default"
  expected <- default
  result <- get_selected_radio_value(sample, default)
  testthat::expect_equal(result, expected)

  # 2) test given radio selection / check if default value works
  sample <- "Nein, das hat keinen Einfluss auf die Umsetzung des Plans"
  default <- "weiss nicht"
  expected <- sample
  result <- get_selected_radio_value(sample, default)
  testthat::expect_equal(result, expected)
})
