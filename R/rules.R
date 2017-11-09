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
rule_identify_belastungen <- function(gaps) {
  assertthat::assert_that(is.character(gaps))

  if (length(gaps[grepl("Belastung", gaps)]) > 0 ) {
    belastungen <- gaps[grepl("Belastung", gaps)]
  } else {
    belastungen <- "Aktuell keine Belastungen"
  }
  return(belastungen)
}

