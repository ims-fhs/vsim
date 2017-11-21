#' rule_extract_gaps: Extrahiert die aktuellen Gaps aus Alist und Glist
#'
#' @param Alist aktuelle Alist
#' @param Glist aktuelle Glist
#'
#' @return gaps
#'
#' @examples
rule_extract_gaps <- function(Alist, Glist, unique_only = TRUE) {
  assertthat::assert_that(class(Alist) == "data.frame")
  assertthat::assert_that(class(Glist) == "data.frame")
  assertthat::assert_that(nrow(Alist) == nrow(Glist))

  gaps_user <- sapply(1:nrow(Glist), function(i) grepl(Alist[i,3], Glist[i,4]))
  gaps_user <- Glist[gaps_user, 3]
  if (unique_only) {
    gaps_user <- unique(gaps_user)
  }
  assertthat::is.string(gaps_user)
  return(gaps_user)
}

#' rule_extract_belastungen: Extrahiert die aktuellen Belastungen
#'
#' @param gaps A character vector
#'
#' @return belastungen A character vector
#'
#' @examples rule_extract_belastungen(c("nix", "eine Belastung"))
#' # [1] "eine Belastung"
#' rule_extract_belastungen(c("nix", "eine Belastung"))
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

#' rule_extract_unzufriedenheiten: Extrahiert die aktuellen Unzufriedenheiten
#'
#' @param gaps A character vector
#'
#' @return belastungen A character vector
#'
#' @examples rule_extract_unzufriedenheiten(c("Differenz im Haus", "Unzufrieden mit Laus"))
rule_extract_unzufriedenheiten <- function(gaps) {
  assertthat::assert_that(is.character(gaps))

  if (length(gaps[grepl("Unzufrieden", gaps) | grepl("Differenz", gaps)]) > 0) {
    unzufriedenheiten <- gaps[rule_identify_unzufriedenheiten(gaps)]
  } else {
    unzufriedenheiten <- "Aktuell keine Unzufriedenheiten"
  }
  return(unzufriedenheiten)
}

#' rule_extract_vereinbarungen: bereitet die Vereinbarungen auf, indem nicht
#' verwertbare antwort-optionen ausgeschlossen werden und gibt ein verwertbares
#' dataframe zurück
#'
#' @param alist_2a
#'
#' @return dataframe mit alist_2a
#'
#' @examples rule_extract_vereinbarungen(test_vereinbarungen_chancen_alist_2a)
rule_extract_vereinbarungen <- function(alist_2a ) {
  alist_2a  <- alist_2a [!grepl("denn nützen?", alist_2a [, 3]), ]
  alist_2a  <- alist_2a [!grepl("weiss nicht", alist_2a [, 3]), ]
  alist_2a  <- alist_2a [, -1]
  names(alist_2a )[names(alist_2a ) == "Question"] <- "Frage"
  return(alist_2a)
}

#' rule_extract_vereinbarungen_fragen: ermittelt die Fragen für getroffene
#' Vereinbarungen, welchen Chancen zugewiesen wurden.
#'
#' @param alist_2a
#'
#' @return vereinbarungen
#'
#' @examples rule_extract_vereinbarungen_fragen(test_vereinbarungen_chancen_alist_2a)
rule_extract_vereinbarungen_fragen <- function(alist_2a) {
  assertthat::assert_that(all(colnames(alist_2a) %in% c("Frage", "Antwort",
                                                        "Kommentar")))
  answered <- which(!is.na(alist_2a$Antwort))
  assertthat::assert_that(is.numeric(answered))
  retval <- character()
  if (length(answered) > 0) {
    retval <- alist_2a[answered, ]$Frage
  }
  return(retval)
}

#' rule_extract_vereinbarungen_fragen: ermittelt die Fragen für getroffene
#' Vereinbarungen, welchen Chancen zugewiesen wurden.
#'
#' @param alist_2a
#'
#' @return abgegebene kommentare zu beantworteten fragen
#'
#' @examples rule_extract_vereinbarungen_kommentare(test_vereinbarungen_chancen_alist_2a)
rule_extract_vereinbarungen_kommentare <- function(alist_2a) {
  assertthat::assert_that(all(colnames(alist_2a) %in% c("Frage", "Antwort",
                                                        "Kommentar")))
  answered <- which(!is.na(alist_2a$Antwort))
  assertthat::assert_that(is.numeric(answered))
  retval <- character()
  if (length(answered) > 0) {
    retval <- alist_2a[answered, ]$Kommentar
  }
  return(retval)
}

#' rule_extract_chancen_per_vereinbarung: ermittelt für eine getroffene Vereinbarung
#' die zugewiesenen Chancen.
#'
#' @param vereinbarung
#' @param alist_2a
#'
#' @return die Chancen, welche der Vereinbarung zugewiesen wurden
#'
#' @examples rule_extract_chancen_per_vereinbarung(test_vereinbarungen_chancen_alist_2a$Frage[1],
#'                                                 test_vereinbarungen_chancen_alist_2a)
rule_extract_chancen_per_vereinbarung <- function(vereinbarung, alist_2a,
                                                  type=stop(c("Differenz","Unzufriedenheit","Belastung"))) {
  assertthat::assert_that(all(colnames(alist_2a) %in% c("Frage", "Antwort",
                                                        "Kommentar")))
  assertthat::assert_that(type %in% c("Differenz","Unzufriedenheit","Belastung"))
  vereinbarung_id <- which(alist_2a$Frage == vereinbarung)
  assertthat::assert_that(is.numeric(vereinbarung_id) && vereinbarung_id > 0)
  retval <- unlist(strsplit(alist_2a$Antwort[vereinbarung_id], ", "))
  retval <- retval[grepl(type, retval)]
  return(retval)
}

#' rule_identify_belastungen: Identifiziert, ob Belastungen vorhanden sind und
#' gibt einen logischen vektor zurück.
#'
#' @param gaps A character vector
#'
#' @return logical vector
#'
#' @examples rule_identify_belastungen(c("nix", "eine Belastung"))
rule_identify_belastungen <- function(gaps) {
  assertthat::assert_that(is.character(gaps))
  gaps <- grepl("Belastung", gaps)
  assertthat::assert_that(is.logical(gaps))
  return(gaps)
}

#' rule_identify_unzufriedenheiten: Identifiziert, ob Unzufriedenheiten vorhanden
#' sind und gibt einen logischen vektor zurück.
#'
#' @param gaps A character vector
#'
#' @return logical vector
#'
#' @examples rule_identify_unzufriedenheiten(c("nix", "Unzufrieden mit Laus"))
rule_identify_unzufriedenheiten <- function(gaps) {
  assertthat::assert_that(is.character(gaps))
  gaps <- grepl("Unzufrieden", gaps) | grepl("Differenz", gaps)
  assertthat::assert_that(is.logical(gaps))
  return(gaps)
}

#' rule_identify_vereinbarkeitstaetigkeiten: Identifiziert, ob Vereinbarkeitstaetigkeiten
#' vorhanden genutzt werden und gibt einen logischen vektor zurück.
#'
#' @param gaps A character vector
#'
#' @return logical vector
#'
#' @examples rule_identify_vereinbarkeitstaetigkeiten(c("nix", "Vereinbarkeitstätigkeit mit Maus"))
rule_identify_vereinbarkeitstaetigkeiten <- function(gaps) {
  assertthat::assert_that(is.character(gaps))
  gaps <- grepl("Vereinbarkeitstätigkeit", gaps)
  assertthat::assert_that(is.logical(gaps))
  return(gaps)
}

#' rule_identify_situation_switchen: Identifiziert abhängig vom Parameter situation,
#' ob switchen Chancen haben könnte oder bereits Probleme bietet und gibt einen
#' logischen skalaren wert zurück.
#'
#' @param gaps A character vector
#'
#' @return logical scalar value
#'
#' @examples rule_identify_situation_switchen(c("Alles im Grünen", "nix"), "chance")
rule_identify_situation_switchen <- function(gaps, situation = stop("One of 'chance', 'problem'")) {
  assertthat::assert_that(situation %in% c("chance", "problem"))
  use_measure <- any(grepl("Vereinbarkeitstätigkeit Switchen wird angewandt", gaps))#oft, selten
  problem <- any(grepl("Belastung durch Switchen", gaps))
  retval <- rule_identify_chance_or_problem(use_measure, problem, situation)
  return(retval)
}

#' rule_identify_situation_homeoffice: Identifiziert abhängig vom Parameter situation,
#' ob Homeoffice Chancen haben könnte oder bereits Probleme bietet und gibt einen
#' logischen skalaren wert zurück.
#'
#' @param gaps A character vector
#'
#' @return logical scalar value
#'
#' @examples rule_identify_situation_homeoffice(c("Belastung durch Flexibilisierung", "Vereinbarkeitstätigkeit Home Office wird angewandt"), "problem")
rule_identify_situation_homeoffice <- function(gaps, situation = stop("One of 'chance', 'problem'")) {
  assertthat::assert_that(situation %in% c("chance", "problem"))
  use_measure <- any(grepl("Vereinbarkeitstätigkeit Home Office wird angewandt", gaps))#oft, selten
  problem <- any(grepl("Belastung durch Flexibilisierung", gaps))
  retval <- rule_identify_chance_or_problem(use_measure, problem, situation)
  return(retval)
}

#' rule_identify_situation_flexibilisierung: Identifiziert abhängig vom Parameter situation,
#' ob Flexibilisierung Chancen haben könnte oder bereits Probleme bietet und
#' gibt einen logischen skalaren Wert zurück.
#'
#' @param gaps A character vector
#'
#' @return logical scalar value
#'
#' @examples rule_identify_situation_flexibilisierung(c("alles im Grünen", "nix"), "chance")
rule_identify_situation_flexibilisierung <- function(gaps, situation = stop("One of 'chance', 'problem'")) {
  assertthat::assert_that(situation %in% c("chance", "problem"))
  use_measure <- any(grepl("Vereinbarkeitstätigkeit Flexible Arbeitszeiten wird angewandt", gaps))#oft, selten
  problem <- any(grepl("Belastung durch Flexibilisierung", gaps))
  retval <- rule_identify_chance_or_problem(use_measure, problem, situation)
  return(retval)
}

#' rule_identify_chance_or_problem: Identifiziert, ob eine Vereinbarkeitstätigkeit eine Chance bietet, oder, ob
#' bereits Probleme damit bestehen. Eine Chance besteht dann, wenn die Massnahme nicht angewandt wird und es noch
#' keine Probleme damit gibt. Ein Problem besteht dann, wenn die Massnahme angewandt wird und es damit Probleme gibt.
#'
#' @param use_measure A boolean
#' @param problem A boolean
#' @param situation A character, one of 'chance' or 'problem'
#'
#' @return retval A boolean
rule_identify_chance_or_problem <- function(use_measure, problem, situation = stop("One of 'chance', 'problem'")) {
  assertthat::assert_that(situation %in% c("chance", "problem"))
  assertthat::assert_that(class(use_measure) == "logical")
  assertthat::assert_that(class(problem) == "logical")
  if (situation == "chance") {
    retval <- !use_measure & !problem
  } else {
    retval <- use_measure & problem
  }
  return(retval)
}

#' rule_identify_belastungen_psychische_gesundheit: Identifiziert, ob psychische
#' Belastungen existieren.
#'
#' @return A boolean
#'
#' @examples rule_identify_belastungen_psychische_gesundheit(c("Belastung switchen", "Belastung psychische Gesundheit"))
rule_identify_belastungen_psychische_gesundheit <- function(gaps) {
  assertthat::assert_that(is.character(gaps))
  retval <- length(gaps) > 0 && sum(grepl("psychische", gaps)) > 1
  assertthat::assert_that(is.logical(retval))
  return(retval)
}

#' rule_identify_vereinbarungen_chancen: ermittelt, ob die alist_2a chancen enthält,
#' welche vom typ type sind.
#'
#' @param alist_2a antworten aus teil 2a
#' @param type chancen typ
#'
#' @return boolean
#'
#' @examples rule_identify_vereinbarungen_chancen(test_vereinbarungen_chancen_alist_2a, "Differenz")
rule_identify_vereinbarungen_chancen <- function(alist_2a,
              type = stop(c("Belastung", "Unzufriedenheit", "Differenz"))) {
  assertthat::assert_that(type %in% c("Belastung", "Unzufriedenheit", "Differenz"))
  assertthat::assert_that("Antwort" %in% names(alist_2a))
  chancen <- unique(unlist(strsplit(paste(alist_2a$Antwort[complete.cases(alist_2a$Antwort)],
                                          collapse = ", "), ", ")))
  return (any(grepl(type, chancen)))
}
