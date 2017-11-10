context("rules_extract")

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

