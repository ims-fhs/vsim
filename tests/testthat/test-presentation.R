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

testthat::test_that("rmd_display_vereinbarungen_chancen works", {

  html <- rmd_display_vereinbarungen_chancen(alist_2a = test_rmd_display_vereinbarungen_chancen_alist2a_01,
                                             qlist = test_rmd_display_vereinbarungen_chancen_qlist_01,
                                             bol_vorgesetzter = test_rmd_display_vereinbarungen_chancen_bolvg_01)
  testthat::expect_equal(html, test_rmd_display_vereinbarungen_chancen_expected_html_01)

  html <- rmd_display_vereinbarungen_chancen(alist_2a = test_rmd_display_vereinbarungen_chancen_alist2a_02,
                                             qlist = test_rmd_display_vereinbarungen_chancen_qlist_02,
                                             bol_vorgesetzter = test_rmd_display_vereinbarungen_chancen_bolvg_02)
  testthat::expect_equal(html, test_rmd_display_vereinbarungen_chancen_expected_html_02)
})

testthat::test_that("unquestion works", {
  a <- unquestion("Möchten Sie einen Hund kaufen?", "Möchten Sie")
  testthat::expect_equal(a, "Einen Hund kaufen.")
})

testthat::test_that("unanswer works", {
  a <- unanswer("Ja, ich möchte die Kinder mehr selbst betreuen als bisher")
  testthat::expect_equal(a, "Ich möchte die Kinder mehr selbst betreuen als bisher")
})
