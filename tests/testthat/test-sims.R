context("simulator tests")

test_that("calc_relevant_questions_2a", {
  Glist <<- read.csv('../../inst/shiny-apps/vsim/data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")
  QInputlist_Teil2a <<- read.csv('../../inst/shiny-apps/vsim/data/QInputlist_Teil2a.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")

  # test1
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_01)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_01)

  # test2
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_02)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_02)

  # test3
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_03)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_03)

})

test_that("calc_relevant_gaps_2b", {
  Glist <<- read.csv('../../inst/shiny-apps/vsim/data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")

  # test1
  result <- calc_relevant_gaps_2b(test_calc_relevant_gaps_2b_01)
  expect_equal(result, test_calc_relevant_gaps_2b_expected_result_01)

  # test2
  result <- calc_relevant_gaps_2b(test_calc_relevant_gaps_2b_02)
  expect_equal(result, test_calc_relevant_gaps_2b_expected_result_02)

})
