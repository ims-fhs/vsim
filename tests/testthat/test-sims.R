context("simulator tests")

test_that("calc_relevant_questions_2a", {
  # setwd(paste0(getwd(),"/tests/testthat/"))
  Glist <<- as.data.frame(readxl::read_xlsx(path = "../../inst/shiny-apps/vsim/data/vsim_question_lists.xlsx", sheet = "Glist_Teil1"),
                          stringsAsFactors = FALSE)
  Qlist_2a <<- as.data.frame(readxl::read_xlsx(path = "../../inst/shiny-apps/vsim/data/vsim_question_lists.xlsx", sheet = "Qlist_Teil2a"),
                             stringsAsFactors = FALSE)

  # test1
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_01)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_01)

  # test2
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_02)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_02)

  # test3
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_03)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_03)

  # test4: chancen home office
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_04)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_04)

  # test5: problem home office
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_05)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_05)

  # test 6: Chancen flexible Zeiten
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_06)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_06)

  # # test 7: Problem flexible Zeiten
  result <- calc_relevant_questions_2a(test_calc_relevant_questions_2a_07)
  expect_equal(result, test_calc_relevant_questions_2a_expected_result_07)

})

test_that("calc_relevant_gaps_2b", {
  Glist <<- as.data.frame(readxl::read_xlsx(path = "../../inst/shiny-apps/vsim/data/vsim_question_lists.xlsx", sheet = "Glist_Teil1"),
                         stringsAsFactors = FALSE)
  # test1
  result <- calc_relevant_gaps_2b(test_calc_relevant_gaps_2b_01)
  expect_equal(result, test_calc_relevant_gaps_2b_expected_result_01)

  # test2
  result <- calc_relevant_gaps_2b(test_calc_relevant_gaps_2b_02)
  expect_equal(result, test_calc_relevant_gaps_2b_expected_result_02)

  # test3
  result <- calc_relevant_gaps_2b(test_calc_relevant_gaps_2b_03)
  expect_equal(result, test_calc_relevant_gaps_2b_expected_result_03)

})
