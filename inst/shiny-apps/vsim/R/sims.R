#' calc_relevant_questions_2a: takes the Alist (and the global Glist and
#' QInputlist_Teil2a) and returns the Qlist_Teil2a with the relevant questions.
#'
#' @param Alist the Alist containing the answered questions from part 1
#'
#' @return the Qlist_Teil2a containing the relevant questions for Teil2a
#'
#' @examples
calc_relevant_questions_2a <- function(Alist) {
  Qlist_Teil2a <- data.frame(Qnum = integer(), Question = character(),
                             Massnahme = character(), Answer1 = character(),
                             Answer2 = character(), Answer3 = character(),
                             Answer4 = character(),Answer5 = character(),
                             stringsAsFactors=FALSE)

  relevant_questions <- logical(length = 12)

  #Welche Gaps hat der User angegeben?
  gaps_user <- rule_extract_gaps(Alist, Glist, unique_only = TRUE)

  belastungen <- rule_extract_belastungen(gaps_user)
  unzufriedenheiten <- rule_extract_unzufriedenheiten(gaps_user)

  #Sensibilisierungstypen für Fragen Teil2a bestimmen;Typen = Problematik; nichts; Chance
  #Massnahme 1: Switchen

  #Chancen SWITCHEN
  if(rule_identify_situation_switchen(gaps_user, "chance"))
  {#Gap
    relevant_questions[c(1,2)] <- TRUE
    Qlist_Teil2a[1, ] <- c(QInputlist_Teil2a[1, c(1:3)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:8]
    Qlist_Teil2a[2, ] <- c(QInputlist_Teil2a[2, c(1:3)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:8]
  }

  #Problem Switchen
  if(rule_identify_situation_switchen(gaps_user, "problem"))
  {#Gap
    relevant_questions[c(3,4)] <- TRUE
    Qlist_Teil2a[3, ] <- c(QInputlist_Teil2a[3, c(1:3)], c(belastungen), c(NA, NA, NA, NA))[1:8]
    Qlist_Teil2a[4, ] <- c(QInputlist_Teil2a[4, c(1:3)], c(belastungen), c(NA, NA, NA, NA))[1:8]
  }

  #2. Home Office

  #Chancen HOME OFFICE
  if(rule_identify_situation_homeoffice(gaps_user, "chance"))
  {#Gap
    relevant_questions[c(5,6)] <- TRUE
    Qlist_Teil2a[5, ] <- c(QInputlist_Teil2a[5, c(1:3)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:8]
    Qlist_Teil2a[6, ] <- c(QInputlist_Teil2a[6, c(1:3)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:8]
  }

  #Problem HOME OFFICE
  if(rule_identify_situation_homeoffice(gaps_user, "problem"))
  {#Gap
      relevant_questions[c(7,8)] <- TRUE
      Qlist_Teil2a[7, ] <- c(QInputlist_Teil2a[7, c(1:3)], c(belastungen), c(NA, NA, NA, NA))[1:8]
      Qlist_Teil2a[8, ] <- c(QInputlist_Teil2a[8, c(1:3)], c(belastungen), c(NA, NA, NA, NA))[1:8]
  }

  #3. Flexible Zeiten

  #Chancen flexible Zeiten
  if(rule_identify_situation_flexibilisierung(gaps_user, "chance"))
  {#Gap
    relevant_questions[c(9,10)] <- TRUE
    Qlist_Teil2a[9, ] <- c(QInputlist_Teil2a[9, c(1:3)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:8]
    Qlist_Teil2a[10, ] <- c(QInputlist_Teil2a[10, c(1:3)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:8]
  }

  #Problem flexible Zeiten
  if(rule_identify_situation_flexibilisierung(gaps_user, "problem"))
  {#Gap
    relevant_questions[c(11,12)] <- TRUE
    Qlist_Teil2a[11, ] <- c(QInputlist_Teil2a[11, c(1:3)], c(belastungen), c(NA, NA, NA, NA))[1:8]
    Qlist_Teil2a[12, ] <- c(QInputlist_Teil2a[12, c(1:3)], c(belastungen), c(NA, NA, NA, NA))[1:8]
  }

  Qlist_Teil2a <- Qlist_Teil2a[relevant_questions, ]
  Qlist_Teil2a[is.na(Qlist_Teil2a)] <- ""
  return(Qlist_Teil2a)
}

#' calc_relevant_gaps_2b: takes the Alist (and the global Glist) and returns the
#' Qlist_Teil2a with the relevant questions.
#'
#' @param Alist the Alist containing the answered questions from part 1
#'
#' @return the relevant_gaps containing the relevant questions for Teil2a
#'
#' @examples
calc_relevant_gaps_2b <- function(Alist) {
  #Welche Gaps hat der User angegeben?
  gaps_user <- rule_extract_gaps(Alist, Glist, unique_only = TRUE)
  relevant_gaps <- character(5)
  relevant_gaps[1] <- ifelse(
    length(gaps_user[grepl("Erwerb", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0,
    paste(c(gaps_user[grepl("Erwerb", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "),
    "-")
  relevant_gaps[2] <- ifelse(
    length(gaps_user[grepl("privaten Zeitmanagement", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0,
    paste(c(gaps_user[grepl("privaten Zeitmanagement", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "),
    "-")
  relevant_gaps[3] <- ifelse(
    length(gaps_user[grepl("Kind", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0,
    paste(c(gaps_user[grepl("Kind", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "),
    "-")
  relevant_gaps[4] <- ifelse(
    length(gaps_user[grepl("Sozial", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0,
    paste(c(gaps_user[grepl("Sozial", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "),
    "-")
  relevant_gaps[5] <- ifelse(
    length(gaps_user[grepl("selbst", gaps_user)]) > 0,
    paste(c(gaps_user[grepl("selbst", gaps_user)]), collapse = ", "),
    "-")
  return(relevant_gaps)
}
