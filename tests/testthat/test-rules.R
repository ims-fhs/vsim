context("rules_extract")

test_that("gaps are extracted correctly from Alist.", {
  Alist <- read.csv('../../inst/shiny-apps/vsim/data/Alist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")
  Glist <- read.csv('../../inst/shiny-apps/vsim/data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")

  expect_error(rule_extract_gaps(Alist[1, ], Glist))
  expect_equal(rule_extract_gaps(Alist[1, ], Glist[1, ]), "Differenz im Zeithandeln Erwerbsarbeit")
})

test_that("rule_extract_belastungen", {
  expect_equal(rule_extract_belastungen(c("nix", "eine Belastung")), "eine Belastung")
  expect_equal(rule_extract_belastungen(c("nix")), "Aktuell keine Belastungen")
  expect_is(rule_extract_belastungen(c("nix", "eine Belastung")), "character")
  expect_error(rule_extract_belastungen(1))
})

test_that("rule_extract_unzufriedenheiten", {
  expect_equal(rule_extract_unzufriedenheiten(c("nix", "eine Unzufriedenheit")), "eine Unzufriedenheit")
  expect_equal(rule_extract_unzufriedenheiten(c("nix", "eine Differenz")), "eine Differenz")
  expect_equal(rule_extract_unzufriedenheiten(c("nix")), "Aktuell keine Unzufriedenheiten")
  expect_is(rule_extract_unzufriedenheiten(c("nix", "eine Unzufriedenheit")), "character")
  expect_error(rule_extract_unzufriedenheiten(1))
})


context("rules_identify")

test_that("rule_identify_belastungen", {
  expect_equal(rule_identify_belastungen(c("nix", "eine Belastung")), c(FALSE, TRUE))
  expect_equal(rule_identify_belastungen(c("nix")), c(FALSE))
  expect_is(rule_identify_belastungen(c("nix", "eine Belastung")), "logical")
  expect_error(rule_identify_belastungen(1))
})

test_that("rule_identify_unzufriedenheiten", {
  expect_equal(rule_identify_unzufriedenheiten(c("nix", "eine Unzufriedenheit")), c(FALSE, TRUE))
  expect_equal(rule_identify_unzufriedenheiten(c("nix", "eine Differenz")), c(FALSE, TRUE))
  expect_equal(rule_identify_unzufriedenheiten(c("nix")), c(FALSE))
  expect_is(rule_identify_unzufriedenheiten(c("nix", "eine Unzufriedenheit")), "logical")
  expect_error(rule_identify_unzufriedenheiten(1))
})

test_that("rule_identify_situation_switchen", {
  c("Vereinbarkeitstätigkeit Switchen wird angewandt", "Belastung durch Switchen")
  expect_false(rule_identify_situation_switchen(c(""), "problem"))
  expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt"), "problem"))
  expect_true(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt", "Belastung durch Switchen")
                                                , "problem"))
  expect_true(rule_identify_situation_switchen(c(""), "chance"))
  expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt"), "chance"))
  expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt", "Belastung durch Switchen")
                                               , "chance"))
})


test_that("rule_identify_chance_or_problem", {
  expect_error(rule_identify_chance_or_problem(TRUE, TRUE, "Nicht 'chance' oder 'problem'"))
  expect_is(rule_identify_chance_or_problem(TRUE, TRUE, "chance"), "logical")
  expect_true(rule_identify_chance_or_problem(FALSE, FALSE, "chance"))
  expect_false(rule_identify_chance_or_problem(TRUE, FALSE, "chance"))
  expect_false(rule_identify_chance_or_problem(FALSE, TRUE, "chance"))
  expect_false(rule_identify_chance_or_problem(TRUE, TRUE, "chance"))
  expect_false(rule_identify_chance_or_problem(FALSE, FALSE, "problem"))
  expect_false(rule_identify_chance_or_problem(TRUE, FALSE, "problem"))
  expect_false(rule_identify_chance_or_problem(FALSE, TRUE, "problem"))
  expect_true(rule_identify_chance_or_problem(TRUE, TRUE, "problem"))
})
