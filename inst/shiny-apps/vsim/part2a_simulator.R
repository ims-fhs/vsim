#Fragen, Antworten Teil 1 einlesen; Gapliste und Fragenliste einlesen
# Qlist <- Qlist_1
Alist <- result_coll$Alist
Glist <- read.csv('./data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
QInputlist_Teil2a <- read.csv('./data/QInputlist_Teil2a.csv', sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
Qlist_Teil2a <- data.frame(Qnum = integer(),Question = character(), Answer1 = character(),Answer2 = character(),Answer3 = character(),Answer4 = character(),Answer5 = character(),stringsAsFactors=FALSE)

relevant_questions <- logical(length = 12)

#Welche Gaps hat der User angegeben?
gaps_user <- sapply(1:nrow(Glist), function(i) grepl(Alist[i,3], Glist[i,4]))
gaps_user <- unique(Glist[gaps_user, 3])

belastungen <- rule_extract_belastungen(gaps_user)
unzufriedenheiten <- rule_extract_unzufriedenheiten(gaps_user)

#Sensibilisierungstypen für Fragen Teil2a bestimmen;Typen = Problematik; nichts; Chance
#Massnahme 1: Switchen
use_measure <- any(grepl("Vereinbarkeitstätigkeit Switchen wird angewandt", gaps_user))#oft, selten
problem <- any(grepl("Belastung durch Switchen", gaps_user))

#Chancen SWITCHEN
if(!use_measure & !problem)
{#Gap
  relevant_questions[c(1,2)] <- TRUE
  Qlist_Teil2a[1, ] <- c(QInputlist_Teil2a[1, c(1,2)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:7]
  Qlist_Teil2a[2, ] <- c(QInputlist_Teil2a[2, c(1,2)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:7]
}

#Problem Switchen
if(use_measure & problem)
{#Gap
  relevant_questions[c(3,4)] <- TRUE
  Qlist_Teil2a[3, ] <- c(QInputlist_Teil2a[3, c(1,2)], c(belastungen), c(NA, NA, NA, NA))[1:7]
  Qlist_Teil2a[4, ] <- c(QInputlist_Teil2a[4, c(1,2)], c(belastungen), c(NA, NA, NA, NA))[1:7]
}

#2. Home Office
use_measure <- any(grepl("Vereinbarkeitstätigkeit Home Office wird angewandt", gaps_user))#oft, selten
problem <- any(grepl("Belastung durch Flexibilisierung", gaps_user))

#Chancen HOME OFFICE
if(!use_measure & !problem)
{#Gap
  relevant_questions[c(5,6)] <- TRUE
  Qlist_Teil2a[5, ] <- c(QInputlist_Teil2a[5, c(1,2)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:7]
  Qlist_Teil2a[6, ] <- c(QInputlist_Teil2a[6, c(1,2)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:7]
}


#Problem HOME OFFICE
if(use_measure & problem)
{#Gap
    relevant_questions[c(7,8)] <- TRUE
    Qlist_Teil2a[7, ] <- c(QInputlist_Teil2a[7, c(1,2)], c(belastungen), c(NA, NA, NA, NA))[1:7]
    Qlist_Teil2a[8, ] <- c(QInputlist_Teil2a[8, c(1,2)], c(belastungen), c(NA, NA, NA, NA))[1:7]
}


#3. Flexible Zeiten
use_measure <- any(grepl("Vereinbarkeitstätigkeit Flexible Arbeitszeiten wird angewandt", gaps_user))#oft, selten
problem <- any(grepl("Belastung durch Flexibilisierung", gaps_user))

#Chancen flexible Zeiten
if(!use_measure & !problem)
{#Gap
  relevant_questions[c(9,10)] <- TRUE
  Qlist_Teil2a[9, ] <- c(QInputlist_Teil2a[9, c(1,2)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:7]
  Qlist_Teil2a[10, ] <- c(QInputlist_Teil2a[10, c(1,2)], c(unzufriedenheiten), c(NA, NA, NA, NA))[1:7]
}

#Problem flexible Zeiten
if(use_measure & problem)
{#Gap
  relevant_questions[c(11,12)] <- TRUE
  Qlist_Teil2a[11, ] <- c(QInputlist_Teil2a[11, c(1,2)], c(belastungen), c(NA, NA, NA, NA))[1:7]
  Qlist_Teil2a[12, ] <- c(QInputlist_Teil2a[12, c(1,2)], c(belastungen), c(NA, NA, NA, NA))[1:7]
}

Qlist_Teil2a <- Qlist_Teil2a[relevant_questions, ]

# write.table(Qlist_Teil2a,file = "data/Qlist_Teil2a.csv",quote = FALSE, row.names = FALSE, na = "", sep = ";", fileEncoding = "UTF-8")
Qlist_Teil2a[is.na(Qlist_Teil2a)] <- ""
result_coll$Qlist_2a <<- Qlist_Teil2a
