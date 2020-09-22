context("simulator tests")

test_that("calc_relevant_questions_2a", {
  # setwd(paste0(getwd(),"/tests/testthat/"))
  Glist <<- import_from_excel(path = "../../inst/shiny-apps/vsim/data/vsim_question_lists.xlsx", give_me = "G1")
  Qlist_2a <<- import_from_excel(path = "../../inst/shiny-apps/vsim/data/vsim_question_lists.xlsx", give_me = "Q2a")

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
  Glist <<- import_from_excel(path = "../../inst/shiny-apps/vsim/data/vsim_question_lists.xlsx", give_me = "G1")

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
