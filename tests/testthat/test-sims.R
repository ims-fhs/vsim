context("simulator tests")

test_that("calc_relevant_questions_2a", {
  Glist <- read.csv('data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")
  QInputlist_Teil2a <- read.csv('data/QInputlist_Teil2a.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")

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
