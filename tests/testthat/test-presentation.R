context("presentation tests")

testthat::test_that("get_selected_checkbox_values works", {
  sample <- "Aktuell keine Konflikte und Schieflagen, Was soll das denn nützen?"
  result <- get_selected_checkbox_values(sample)
  expected_result <- c("Aktuell keine Konflikte und Schieflagen",
                       "Was soll das denn nützen?")
  testthat::expect_equal(result, expected_result)
})

testthat::test_that("get_selected_value works", {
  # 1) test empty radio selection / check if default value works
  sample <- ""
  default <- "default"
  expected <- default
  result <- get_selected_value(sample, default)
  testthat::expect_equal(result, expected)

  # 2) test given radio selection / check if default value works
  sample <- "Nein, das hat keinen Einfluss auf die Umsetzung des Plans"
  default <- "weiss nicht"
  expected <- sample
  result <- get_selected_value(sample, default)
  testthat::expect_equal(result, expected)
})
