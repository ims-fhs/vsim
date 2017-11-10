#' rule_identify_belastungen: Identifiziert die aktuellen Belastungen
#'
#' @param gaps A character vector
#'
#' @return belastungen A character vector
#' @export
#'
#' @examples rule_identify_belastungen(c("nix", "eine Belastung"))
#' # [1] "eine Belastung"
#' rule_identify_belastungen(c("nix", "eine Belastung"))
#' # [1] "Aktuell keine Belastungen"
rule_extract_belastungen <- function(gaps) {
  assertthat::assert_that(is.character(gaps))

  if (length(gaps[grepl("Belastung", gaps)]) > 0 ) {
    belastungen <- gaps[rule_identify_belastungen(gaps)]
  } else {
    belastungen <- "Aktuell keine Belastungen"
  }
  return(belastungen)
}

rule_extract_unzufriedenheiten <- function(gaps) {
  assertthat::assert_that(is.character(gaps))

  if (length(gaps[grepl("Unzufrieden", gaps) | grepl("Differenz", gaps)]) > 0) {
    unzufriedenheiten <- gaps[rule_identify_unzufriedenheiten(gaps)]
  } else {
    unzufriedenheiten <- "Aktuell keine Unzufriedenheiten"
  }
  return(unzufriedenheiten)
}


rule_identify_belastungen <- function(gaps) {
  assertthat::assert_that(is.character(gaps))
  gaps <- grepl("Belastung", gaps)
  assertthat::assert_that(is.logical(gaps))
  return(gaps)
}

rule_identify_unzufriedenheiten <- function(gaps) {
  assertthat::assert_that(is.character(gaps))
  gaps <- grepl("Unzufrieden", gaps) | grepl("Differenz", gaps)
  assertthat::assert_that(is.logical(gaps))
  return(gaps)
}

rule_identify_vereinbarkeitstaetigkeiten <- function(gaps) {
  assertthat::assert_that(is.character(gaps))
  gaps <- grepl("Vereinbarkeitstätigkeit", gaps)
  assertthat::assert_that(is.logical(gaps))
  return(gaps)
}

