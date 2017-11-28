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

test_that("rule_extract_vereinbarungen_fragen", {
  alist_2a <- test_vereinbarungen_chancen_alist_2a
  vereinbarungen <- rule_extract_vereinbarungen_fragen(alist_2a)
  testthat::expect_equal(vereinbarungen, alist_2a$Frage)
})

test_that("rule_extract_chancen_per_vereinbarung", {
  alist_2a <- test_vereinbarungen_chancen_alist_2a
  vereinbarungen <- rule_extract_vereinbarungen_fragen(alist_2a)
  chancen <- rule_extract_chancen_per_vereinbarung(vereinbarungen[1], alist_2a, "Belastung")
  testthat::expect_equal(chancen, test_vereinbarungen_chancen_expected)
})

test_that("rule_extract_vereinbarungen", {
  result <- rule_extract_vereinbarungen(test_vereinbarungen_chancen_alist_2a)
  testthat::expect_equal(nrow(result), 6)
  testthat::expect_equal(ncol(result), 2)
})

test_that("rule_extract_vereinbarungen_kommentare", {
  expected <- c("2a kommentar 29", "2a kommentar 30", "2a kommentar 31", "2a kommentar 32",
                "2a kommentar 33", "2a kommentar 34")
  result <- rule_extract_vereinbarungen_kommentare(test_vereinbarungen_chancen_alist_2a)
  testthat::expect_equal(result, expected)
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
  expect_false(rule_identify_situation_switchen(c(""), "problem"))
  expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt"), "problem"))
  expect_true(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt", "Belastung: Häufiges Hin- und Herschalten zwischen Privatem und Beruflichem (Switchen)")
                                                , "problem"))
  # expect_true(rule_identify_situation_switchen(c(""), "chance"))
  # expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt"), "chance"))
  # expect_false(rule_identify_situation_switchen(c("Vereinbarkeitstätigkeit Switchen wird angewandt", "Belastung: Häufiges Hin- und Herschalten zwischen Privatem und Beruflichem (Switchen)")
  #                                              , "chance"))
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

test_that("rule_identify_vereinbarungen_chancen", {
  retval <- rule_identify_vereinbarungen_chancen(test_vereinbarungen_chancen_alist_2a, "Belastung")
  expect_true(retval)
})

test_that("possible Burnout-Situations are identified.", {
  expect_true(rule_identify_belastungen_psychische_gesundheit(c("Psychische", "psychische")))
  expect_true(rule_identify_belastungen_psychische_gesundheit(c(
    "Belastung: Psychische oder emotionale Situation",
    "Belastung: Psychische oder emotionale Situation")))
  expect_false(rule_identify_belastungen_psychische_gesundheit("Belastung: Psychische oder emotionale Situation"))
  expect_false(rule_identify_belastungen_psychische_gesundheit(""))
})
