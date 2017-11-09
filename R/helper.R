#' returns a string-array containing the selected options
#'
#' @param selected_options_string a string containing the radio-options text as
#' a comma separated list
#'
#' @return string array containing selected options
#' @export
#'
#' @examples get_selected_options("Aktuell keine Konflikte und Schieflagen, Was soll das denn nützen?")
get_selected_options <- function(selected_options_string) {
  selected_options_string <- as.character(selected_options_string)
  retval <- strsplit(selected_options_string, ", ")
  retval <- as.character(unlist(retval))
  return(retval)
}

testthat::test_that("testing get_selected_option", {
  sample <- "Aktuell keine Konflikte und Schieflagen, Was soll das denn nützen?"
  result <- get_selected_options(sample)
  expected_result <- c("Aktuell keine Konflikte und Schieflagen",
                       "Was soll das denn nützen?")
  testthat::expect_equal(result, expected_result)
})
