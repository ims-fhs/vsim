test_vereinbarungen_chancen_alist_2a <-
  structure(list(Frage = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zuk?nftig weniger berufliche Verpflichtungen von zu Hause aus erledigen, welche Belastungen k?nnen Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angeh?rigen vereinbaren, dass Sie zuk?nftig weniger private Verpflichtungen w?hrend der Arbeitszeit erledigen, welche Belastungen k?nnen Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zuk?nftig weniger von zu Hause aus arbeiten, welche Belastungen k?nnen Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angeh?rigen vereinbaren, dass Sie zuk?nftig unter ver?nderten Bedingungen (klare Arbeitszeiten, wenig St?rung, ruhiger Arbeitsort, klar abgetrennter Raum, etc.) von zu Hause aus arbeiten, welche Belastungen k?nnen Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie Ihre Arbeitszeit zuk?nftig weniger flexibel (regelm?ssige Arbeitszeiten, klar festgelegte Aufgaben, etc.) organisieren, welche Belastungen k?nnen Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angeh?rigen vereinbaren, dass Sie Ihre privaten Verpflichtungen zuk?nftig geregelter organisieren, welche Belastungen k?nnen Ihrer Meinung nach reduziert werden?"
), Antwort = c("Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen"
), Kommentar = c("2a kommentar 29", "2a kommentar 30", "2a kommentar 31",
"2a kommentar 32", "2a kommentar 33", "2a kommentar 34")), .Names = c("Frage",
"Antwort", "Kommentar"), class = "data.frame", row.names = c(3L,
4L, 7L, 8L, 11L, 12L))

test_vereinbarungen_chancen_expected <-
  c("Belastung Abschalten", "Belastung private Verpflichtungen",
"Belastung berufliche Verpflichtungen", "Belastung Gleichzeitigkeiten",
"Belastung durch Switchen")
