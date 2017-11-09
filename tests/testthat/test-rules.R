context("rules_identify")

test_that("rule_identify", {
  expect_equal(rule_identify_belastungen(c("nix", "eine Belastung")), "eine Belastung")
  expect_equal(rule_identify_belastungen(c("nix")), "Aktuell keine Belastungen")
  expect_is(rule_identify_belastungen(c("nix", "eine Belastung")), "character")
  expect_error(rule_identify_belastungen(1))
})
