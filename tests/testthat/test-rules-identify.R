context("rules_identify")

test_that("Belastungen are identified", {
  expect_equal(rule_identify_belastungen(c("nix", "eine Belastung")), c(FALSE, TRUE))
  expect_equal(rule_identify_belastungen(c("nix")), c(FALSE))
  expect_is(rule_identify_belastungen(c("nix", "eine Belastung")), "logical")
  expect_error(rule_identify_belastungen(1))
})

test_that("Unzufriedenheiten are identified", {
  expect_equal(rule_identify_unzufriedenheiten(c("nix", "eine Unzufriedenheit")), c(FALSE, TRUE))
  expect_equal(rule_identify_unzufriedenheiten(c("nix")), c(FALSE))
  expect_is(rule_identify_unzufriedenheiten(c("nix", "eine Unzufriedenheit")), "logical")
  expect_error(rule_identify_unzufriedenheiten(1))
})

test_that("rule_identify_situation_switchen", {
  expect_false(rule_identify_situation_switchen(c(""), "problem"))
  expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt"), "problem"))
  expect_true(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt", "Belastung: Häufiges Hin- und Herschalten zwischen Privatem und Beruflichem (Switchen)")
                                                , "problem"))
  expect_true(rule_identify_situation_switchen(c(""), "chance"))
  expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt"), "chance"))
  expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt", "Belastung: Häufiges Hin- und Herschalten zwischen Privatem und Beruflichem (Switchen)")
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

test_that("possible Burnout-Situations are identified.", {
  expect_true(rule_identify_belastungen_psychische_gesundheit(c("Psychische", "psychische")))
  expect_true(rule_identify_belastungen_psychische_gesundheit(c(
    "Belastung: Psychische oder emotionale Situation",
    "Belastung: Psychische oder emotionale Situation")))
  expect_false(rule_identify_belastungen_psychische_gesundheit("Belastung: Psychische oder emotionale Situation"))
  expect_false(rule_identify_belastungen_psychische_gesundheit(""))
})
