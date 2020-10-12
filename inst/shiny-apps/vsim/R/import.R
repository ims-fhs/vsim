#' import questionnary data from given exel
#'
#' @param path a character, path to excel file
#' @param give_me a character, in c("Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c")
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun {
#' setwd(paste0(getwd(),"/inst/shiny-apps/vsim/"))
#' Q1 <- import_from_excel(path = "data/vsim_question_lists.xlsx", give_me = "Q1")
#' A1 <- import_from_excel(give_me = "A1")
#' G1 <- import_from_excel(give_me = "G1")
#' Gtype <- import_from_excel(give_me = "Gtype")
#' Q2a <- import_from_excel(give_me = "Q2a")
#' Q2b <- vsim:::import_from_excel(give_me = "Q2b")
#' Q2c <- import_from_excel(give_me = "Q2c")}
import_from_excel <- function(path = "data/vsim_question_lists_kinderbetreuung.xlsx",
                              give_me = c("Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c")) {
  assertthat::assert_that(is.character(give_me))
  assertthat::assert_that(length(give_me) == 1)
  assertthat::assert_that(give_me %in% c("Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c"))

  lookup <- data.frame(name = c("Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c"),
                       sheet = c("QAGlist_Teil1", "QAGlist_Teil1", "QAGlist_Teil1", "QAGlist_Teil1",
                                 "Qlist_Teil2a", "Qlist_Teil2b", "Qlist_Teil2c"),
                       stringsAsFactors = FALSE)
  df <- as.data.frame(readxl::read_xlsx(path = path, sheet = lookup$sheet[lookup$name == give_me]),
                      stringsAsFactors = FALSE)
  df[is.na(df)] <- ""

  if(give_me == "Q1") {df <- df[ c(1:7)]}
  if(give_me == "A1") {df <- df[ c(1,2,8)]}
  if(give_me == "G1") {df <- df[ c(1,2,9:12)]}
  if(give_me == "Gtype") {df <- df[ c(9,13)]}

  return(df)
}
