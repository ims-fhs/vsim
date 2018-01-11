context("rules_extract")

test_that("gaps are extracted correctly from Alist.", {
  Alist <- read.csv('../../inst/shiny-apps/vsim/data/Alist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")
  Glist <- read.csv('../../inst/shiny-apps/vsim/data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")
  expect_error(rule_extract_gaps(Alist[1, ], Glist))
  expect_equal(rule_extract_gaps(Alist[1, ], Glist[1, ]), "Unzufriedenheit mit dem beruflichen Zeitmanagement")
})

test_that("rule_extract_belastungen", {
  expect_equal(rule_extract_belastungen(c("nix", "eine Belastung")), "eine Belastung")
  expect_equal(rule_extract_belastungen(c("nix")), "Aktuell keine Belastungen")
  expect_is(rule_extract_belastungen(c("nix", "eine Belastung")), "character")
  expect_error(rule_extract_belastungen(1))
  expect_equal(rule_extract_belastungen(c("nix", "Belastung: Maus"), strip_prefix = TRUE), "Maus")
  expect_equal(rule_extract_belastungen(c("nix", "Belastung: Maus")), "Belastung: Maus")
})

test_that("rule_extract_unzufriedenheiten", {
  expect_equal(rule_extract_unzufriedenheiten(c("nix", "eine Unzufriedenheit")), "eine Unzufriedenheit")
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
  chancen <- rule_extract_chancen_per_vereinbarung(vereinbarungen[1], alist_2a)
  testthat::expect_equal(chancen, test_vereinbarungen_chancen_expected)
})

test_that("rule_extract_vereinbarungen", {
  result <- rule_extract_vereinbarungen(test_vereinbarungen_chancen_alist_2a)
  testthat::expect_equal(nrow(result), 4)
  testthat::expect_equal(ncol(result), 2)
})

test_that("rule_extract_vereinbarungen_kommentare", {
  expected <- c("2a kommentar 29", "2a kommentar 30", "2a kommentar 31", "2a kommentar 32",
                "2a kommentar 33", "2a kommentar 34")
  result <- rule_extract_vereinbarungen_kommentare(test_vereinbarungen_chancen_alist_2a)
  testthat::expect_equal(result, expected)
})

test_that("rule_extract_vereinbarungen", {
  result <- rule_extract_unterstuetzung_entlastung(test_unterstuetzung_entlastung_alist_2c)
  testthat::expect_equal(nrow(result), 3)
  testthat::expect_equal(ncol(result), 3)
})

test_that("rule_extract_zeitverwendung", {
  result <- rule_extract_zeitverwendung(test_zeitverwendung_alist_2b,
                                        test_zeitverwendung_relevant_gaps)
  testthat::expect_equal(nrow(result), 4)
  testthat::expect_equal(ncol(result), 4)
})


