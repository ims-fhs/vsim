cp <- function() {
  pal <- wesanderson::wes_palette(21, name = "Zissou", type = "continuous")
  pal
  pal <- pal[c(1,11,14,16, 19, 20)]
  pal <- c(pal, "darkgreen")
  # image(volcano, col = pal)
  # image(volcano, col = adjustcolor(pal, offset = c(0, .1, .1, .1)))
  # image(volcano, col = adjustcolor(pal, alpha.f = .8))
  # pal <- adjustcolor(pal, offset = c(0, .1, .1, .1))
  # pal <- adjustcolor(pal, alpha.f = .8)
  return(pal)
}

col_lebenslage <- function() {return(cp()[1])}
col_belastung <- function() {return(cp()[6])}
col_unzufriedenheit <- function() {return(cp()[5])}
col_differenz <- function() {return(cp()[5])}
col_vereinbarung <- function() {return(cp()[4])}
col_zeitverwendung <- function() {return(cp()[3])}
col_unterstuetzung_und_entlastung <- function() {return(cp()[2])}
col_plan <- function() {return(cp()[7])}

library(testthat)

test_that("cp() and col_()", {
  expect_is(class(cp()), "character")
  expect_length(cp(), 7)
  expect_is(class(col_lebenslage()), "character")
  expect_is(class(col_belastung()), "character")
  expect_is(class(col_unzufriedenheit()), "character")
  expect_is(class(col_vereinbarung()), "character")
  expect_is(class(col_zeitverwendung()), "character")
  expect_is(class(col_unterstuetzung_und_entlastung()), "character")
  expect_is(class(col_plan()), "character")
})
