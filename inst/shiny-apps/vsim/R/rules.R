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
#' @param strip_prefix A boolean indicating, whether the 'Belastung: ' - Prefix
#' should be stripped (TRUE) or not (FALSE)
#'
#' @return belastungen A character vector
#'
#' @examples rule_extract_belastungen(c("nix", "eine Belastung"))
#' # [1] "eine Belastung"
#' rule_extract_belastungen(c("nix", "eine Belastung"))
#' # [1] "Aktuell keine Belastungen"
rule_extract_belastungen <- function(gaps, strip_prefix = FALSE) {
  assertthat::assert_that(is.character(gaps))

  if (length(gaps[grepl("Belastung", gaps)]) > 0 ) {
    belastungen <- gaps[rule_identify_belastungen(gaps)]
    if (strip_prefix) {
      belastungen <- gsub("Belastung: ", "", belastungen)
    }
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
#' @examples rule_extract_unzufriedenheiten(c("Unzufriedenheit im Haus", "Unzufrieden mit Laus"))
rule_extract_unzufriedenheiten <- function(gaps) {
  assertthat::assert_that(is.character(gaps))

  if (length(gaps[grepl("Unzufrieden", gaps)]) > 0) {
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
  alist_2a  <- alist_2a[!grepl("Ich sehe keinen Nutzen in dieser Vereinbarung", alist_2a[, "Antwort"]), ]
  alist_2a  <- alist_2a[!grepl("weiss nicht", alist_2a[, "Antwort"]), ]
  alist_2a  <- alist_2a[, -1]
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

#' rule_extract_unterstuetzung_entlastung
#' ermittelt die Fragen für getroffene Unterstützungen und Entlastungen,
#' welchen "Ja" in der Antwort enthalten.
#'
#' @param Alist_2c Alist_2c data.frame mit allen Antworten zu Unterstützung
#' & Entlastungen
#'
#' @return Alist_2c data.frame mit den vorbereiteten Unterstützungen &
#' Entlastungen, deren Antwort "Ja" enthielt
#' @export
#'
#' @examples rule_extract_unterstuetzung_entlastung(test_unterstuetzung_entlastung_alist_2c)
rule_extract_unterstuetzung_entlastung <- function(Alist_2c) {
  assertthat::assert_that(all(c("Question", "Antwort") %in% names(Alist_2c)))
  Alist_2c <- Alist_2c[grepl("Ja", Alist_2c[, 3]), ]
  Alist_2c <- Alist_2c[, -1]
  names(Alist_2c)[names(Alist_2c) == "Question"] <- "Handlungsfeld"
  names(Alist_2c)[names(Alist_2c) == "Antwort"] <- "Geplante Strategie"
  return(Alist_2c)
}

#' rule_extract_zeitverwendung
#' ermittelt die Antworten mit angepasster Zeitverwendung
#'
#' @param Alist_2b data.frame mit den aktuellen Zeitverwendungen
#' @param relevant_gaps character-vektor mit den relevant gaps
#'
#' @return Alist_2b data.frame mit den Antworten mit angepasster Zeitverwendung
#' vorbereitet für die Darstellung (Spaltennamen angepasst)
#' @export
#'
#' @examples rule_extract_zeitverwendung(test_zeitverwendung_alist_2b,
#'                                       test_zeitverwendung_relevant_gaps)
rule_extract_zeitverwendung <- function(Alist_2b, relevant_gaps) {
  assertthat::assert_that(all(c("Question", "Antwort") %in% names(Alist_2b)))
  Alist_2b <- Alist_2b[, -1]
  names(Alist_2b)[names(Alist_2b) == "Question"] <- "Zeit für was"
  names(Alist_2b)[names(Alist_2b) == "Antwort"] <- "Bedürfnis"
  Alist_2b[, "Ihre relevanten Belastungen und Unzufriedenheiten"] <- relevant_gaps
  # remove time-usage without changes
  Alist_2b <- Alist_2b[!grepl("gleich", Alist_2b[, 2]), ]
  return(Alist_2b)
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
rule_extract_chancen_per_vereinbarung <- function(vereinbarung, alist_2a) {
  assertthat::assert_that(all(colnames(alist_2a) %in% c("Frage", "Antwort",
                                                        "Kommentar")))
  vereinbarung_id <- which(alist_2a$Frage == vereinbarung)
  assertthat::assert_that(is.numeric(vereinbarung_id) && vereinbarung_id > 0)
  retval <- unlist(strsplit(alist_2a$Antwort[vereinbarung_id], ", "))
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
  gaps <- grepl("Unzufrieden", gaps)
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
  # HINT: regex match to prevent 'umlaute'-issue on windows / r constellation
  use_measure <- any(grepl("Vereinbarkeitst.+tigkeit Switchen wird angewandt", gaps))#oft, selten
  problem <- any(grepl("Belastung: H.+ufiges Hin- und Herschalten zwischen Privatem und Beruflichem .+Switchen.+", gaps))
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
#' @examples rule_identify_situation_homeoffice(c("Belastung durch Home Office", "Vereinbarkeitstätigkeit Home Office wird angewandt"), "problem")
rule_identify_situation_homeoffice <- function(gaps, situation = stop("One of 'chance', 'problem'")) {
  assertthat::assert_that(situation %in% c("chance", "problem"))
  # HINT: regex match to prevent 'umlaute'-issue on windows / r constellation
  use_measure <- any(grepl("Vereinbarkeitst.+tigkeit Home Office wird angewandt", gaps))#oft, selten
  problem <- any(grepl("Belastung: St.+rungen beim Arbeiten im Home Office", gaps))
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
  # HINT: regex match to prevent 'umlaute'-issue on windows / r constellation
  use_measure <- any(grepl("Vereinbarkeitst.+tigkeit Flexible Arbeitszeiten wird angewandt", gaps))#oft, selten
  problem <- any(grepl("Flexibilisierung", gaps))
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
  retval <- length(gaps) > 0 && sum(grepl("psychische", gaps, ignore.case = TRUE)) > 1
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
#' @examples rule_identify_vereinbarungen_chancen(test_vereinbarungen_chancen_alist_2a, "Belastung")
rule_identify_vereinbarungen_chancen <- function(alist_2a,
              type = stop(c("Belastung", "Unzufriedenheit"))) {
  assertthat::assert_that(type %in% c("Belastung", "Unzufriedenheit"))
  assertthat::assert_that("Antwort" %in% names(alist_2a))
  chancen <- unique(unlist(strsplit(paste(alist_2a$Antwort[complete.cases(alist_2a$Antwort)],
                                          collapse = ", "), ", ")))
  return (any(grepl(type, chancen)))
}
