col_lebenslage <- function() {return(rgb(240, 240, 240, max = 255))}
col_belastung <- function() {return(rgb(241, 117, 121, max = 255))}
col_unzufriedenheit <- function() {return(col_belastung())}
col_differenz <- function() {return(col_belastung())}
col_vereinbarung <- function() {return(rgb(174, 219, 204, max = 255))}
col_zeitverwendung <- function() {return(rgb(132, 194, 240, max = 255))}
col_unterstuetzung_und_entlastung <- function() {return(rgb(147, 157, 205, max = 255))}
col_plan <- function() {return(rgb(204, 204, 204, max = 255))}
col_evaluation_comment <- function() {return(rgb(255, 255, 255, max = 255))}
col_achtung <- function() {return(rgb(240, 50, 26, max = 255))}

library(testthat)

test_that("col_()", {
  expect_is(class(col_lebenslage()), "character")
  expect_is(class(col_belastung()), "character")
  expect_is(class(col_unzufriedenheit()), "character")
  expect_is(class(col_differenz()), "character")
  expect_is(class(col_vereinbarung()), "character")
  expect_is(class(col_zeitverwendung()), "character")
  expect_is(class(col_unterstuetzung_und_entlastung()), "character")
  expect_is(class(col_plan()), "character")
  expect_is(class(col_evaluation_comment()), "character")
  expect_is(class(col_achtung()), "character")
})
