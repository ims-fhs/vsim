context("rules_extract")

test_that("gaps are extracted correctly from Alist.", {

  Alist <- import_from_excel(path = "../../inst/shiny-apps/vsim/data/outputs/Testcase_aeltere_Arbeitnehmer_Arbeit.xlsx", give_me = "A1")
  Glist <- import_from_excel(path = "../../inst/shiny-apps/vsim/data/outputs/Testcase_aeltere_Arbeitnehmer_Arbeit.xlsx", give_me = "G1")
  Gtypelist <- import_from_excel(path = "../../inst/shiny-apps/vsim/data/outputs/Testcase_aeltere_Arbeitnehmer_Arbeit.xlsx", give_me = "Gtype")

  expect_error(rule_extract_gaps(Alist[1, ], Glist, Gtypelist))
  expect_equal(rule_extract_gaps(Alist[1, ], Glist[1, ], Gtypelist[1,]), "Unzufriedenheit mit der beruflichen Zeitverwendung")
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
  vereinbarungen_fragen <- rule_extract_vereinbarungen_fragen(
    alist_2a = test_rmd_display_vereinbarungen_chancen_alist2a_01,
    qlist = test_rmd_display_vereinbarungen_chancen_qlist_01,
    type = "Frage")
  testthat::expect_equal(vereinbarungen_fragen, test_rmd_display_vereinbarungen_chancen_alist2a_01$Frage)

  vereinbarungen_massnahmen <- rule_extract_vereinbarungen_fragen(
    alist_2a = test_rmd_display_vereinbarungen_chancen_alist2a_01,
    qlist = test_rmd_display_vereinbarungen_chancen_qlist_01,
    type = "Massnahme")
  testthat::expect_equal(vereinbarungen_massnahmen, test_rmd_display_vereinbarungen_chancen_qlist_01$Massnahme)
})

test_that("rule_extract_chancen_per_vereinbarung", {
  vereinbarungen_fragen <- rule_extract_vereinbarungen_fragen(
    alist_2a = test_rmd_display_vereinbarungen_chancen_alist2a_01,
    qlist = test_rmd_display_vereinbarungen_chancen_qlist_01,
    type = "Frage")
  chancen <- rule_extract_chancen_per_vereinbarung(vereinbarungen_fragen[1],
                                                   test_rmd_display_vereinbarungen_chancen_alist2a_01)
  testthat::expect_equal(chancen, test_rule_extract_chancen_per_vereinbarung_chancen_expected)
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


