test_vereinbarungen_chancen_alist_2a <-
  structure(list(Frage = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zukünftig weniger berufliche Verpflichtungen von zu Hause aus erledigen, welche Belastungen können Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie zukünftig weniger private Verpflichtungen während der Arbeitszeit erledigen, welche Belastungen können Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zukünftig weniger von zu Hause aus arbeiten, welche Belastungen können Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie zukünftig unter veränderten Bedingungen (klare Arbeitszeiten, wenig Störung, ruhiger Arbeitsort, klar abgetrennter Raum, etc.) von zu Hause aus arbeiten, welche Belastungen können Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie Ihre Arbeitszeit zukünftig weniger flexibel (regelmässige Arbeitszeiten, klar festgelegte Aufgaben, etc.) organisieren, welche Belastungen können Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie Ihre privaten Verpflichtungen zukünftig geregelter organisieren, welche Belastungen können Ihrer Meinung nach reduziert werden?"
), Antwort = c("Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"Belastung Abschalten, Belastung private Verpflichtungen, Belastung berufliche Verpflichtungen, Belastung Gleichzeitigkeiten, Belastung durch Switchen",
"weiss nicht",
"Ich sehe keinen Nutzen in dieser Vereinbarung"
), Kommentar = c("2a kommentar 29", "2a kommentar 30", "2a kommentar 31",
"2a kommentar 32", "2a kommentar 33", "2a kommentar 34")), .Names = c("Frage",
"Antwort", "Kommentar"), class = "data.frame", row.names = c(3L,
4L, 7L, 8L, 11L, 12L))

test_rule_extract_chancen_per_vereinbarung_chancen_expected <-
c("Unzufriedenheit mit dem beruflichen Zeitmanagement", "Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung",
"Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Karriereentwicklung"
)

# test 1: 1 nein,4 oft ,7 überhaupt nicht ,15 voll/ganz, 16 voll/ganz,26 voll/ganz,27 voll/ganz
test_calc_relevant_questions_2a_01 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("Nein, ich möchte gern weniger Zeit dafür verwenden",
"weiss nicht", "weiss nicht", "Oft", "weiss nicht", "weiss nicht",
"Trifft überhaupt nicht zu", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "Trifft voll und ganz zu",
"Trifft voll und ganz zu", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "Trifft voll und ganz zu", "Trifft voll und ganz zu",
"weiss nicht")), .Names = c("Qnum", "Question", "Answer"), row.names = c(NA,
-28L), class = "data.frame")

test_calc_relevant_questions_2a_expected_result_01 <-
structure(list(Qnum = c(3.1, 3.2, 5.1, 5.2), Question = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zukünftig vermehrt von zu Hause aus arbeiten, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie zukünftig vermehrt von zu Hause aus arbeiten, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie Ihre Arbeitszeit zukünftig flexibler und selbstständiger organisieren, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie Ihre privaten Verpflichtungen zukünftig flexibler organisieren, wo sehen Sie Chancen für eine Verbesserung?"
), Massnahme = c("Vereinbarung Home Office mit der vorgesetzten Person",
"Vereinbarung Home Office im privaten Bereich", "Flexiblere Arbeitszeiten",
"Haus- und Betreuungsarbeiten flexibler gestalten"), Answer1 = c("Unzufriedenheit mit dem beruflichen Zeitmanagement",
"Unzufriedenheit mit dem beruflichen Zeitmanagement", "Unzufriedenheit mit dem beruflichen Zeitmanagement",
"Unzufriedenheit mit dem beruflichen Zeitmanagement"), Answer2 = c("Unzufriedenheit mit sozialen Beziehungen",
"Unzufriedenheit mit sozialen Beziehungen", "Unzufriedenheit mit sozialen Beziehungen",
"Unzufriedenheit mit sozialen Beziehungen"), Answer3 = c("",
"", "", ""), Answer4 = c("", "", "", ""), Answer5 = c("", "",
"", "")), .Names = c("Qnum", "Question", "Massnahme", "Answer1",
"Answer2", "Answer3", "Answer4", "Answer5"), row.names = c(5L,
6L, 9L, 10L), class = "data.frame")

# test2: antworten alles leer -> alle fragen in teil 2a!
test_calc_relevant_questions_2a_02 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht")), .Names = c("Qnum",
"Question", "Answer"), row.names = c(NA, -28L), class = "data.frame")

test_calc_relevant_questions_2a_expected_result_02 <-
structure(list(Qnum = integer(0), Question = character(0), Massnahme = character(0),
    Answer1 = character(0), Answer2 = character(0), Answer3 = character(0),
    Answer4 = character(0), Answer5 = character(0)), .Names = c("Qnum",
"Question", "Massnahme", "Answer1", "Answer2", "Answer3", "Answer4",
"Answer5"), row.names = integer(0), class = "data.frame")

# test3: antworten 5, 6, 20 positiv -> keine frage in teil 2a!
test_calc_relevant_questions_2a_03 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"Oft", "Oft", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "Trifft voll und ganz zu",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht")), .Names = c("Qnum",
"Question", "Answer"), row.names = c(NA, -28L), class = "data.frame")

test_calc_relevant_questions_2a_expected_result_03 <-
structure(list(Qnum = integer(0), Question = character(0), Massnahme = character(0),
    Answer1 = character(0), Answer2 = character(0), Answer3 = character(0),
    Answer4 = character(0), Answer5 = character(0)), .Names = c("Qnum",
"Question", "Massnahme", "Answer1", "Answer2", "Answer3", "Answer4",
"Answer5"), row.names = integer(0), class = "data.frame")

# test4: 5 nie, 11 überhaupt nicht
test_calc_relevant_questions_2a_04 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"Nie", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "Trifft überhaupt nicht zu", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht"
)), .Names = c("Qnum", "Question", "Answer"), row.names = c(NA,
-28L), class = "data.frame")

test_calc_relevant_questions_2a_expected_result_04 <-
structure(list(Qnum = c(1.1, 1.2, 3.1, 3.2, 5.1, 5.2), Question = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zukünftig vermehrt von zu Hause aus arbeiten, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie zukünftig vermehrt von zu Hause aus arbeiten, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie Ihre Arbeitszeit zukünftig flexibler und selbstständiger organisieren, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie Ihre privaten Verpflichtungen zukünftig flexibler organisieren, wo sehen Sie Chancen für eine Verbesserung?"
), Massnahme = c("Switchen am Arbeitsplatz zugunsten privater Angelegenheiten",
"Switchen am Arbeitsplatz zugunsten privater Angelegenheiten",
"Vereinbarung Home Office mit der vorgesetzten Person", "Vereinbarung Home Office im privaten Bereich",
"Flexiblere Arbeitszeiten", "Haus- und Betreuungsarbeiten flexibler gestalten"
), Answer1 = c("Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge",
"Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge",
"Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge"
), Answer2 = c("", "", "", "", "", ""), Answer3 = c("", "", "",
"", "", ""), Answer4 = c("", "", "", "", "", ""), Answer5 = c("",
"", "", "", "", "")), .Names = c("Qnum", "Question", "Massnahme",
"Answer1", "Answer2", "Answer3", "Answer4", "Answer5"), row.names = c(1L,
2L, 5L, 6L, 9L, 10L), class = "data.frame")

# test5: 5 oft, 22 voll
test_calc_relevant_questions_2a_05 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"Oft", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "Trifft voll und ganz zu",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht")), .Names = c("Qnum", "Question", "Answer"), row.names = c(NA,
-28L), class = "data.frame")

test_calc_relevant_questions_2a_expected_result_05 <-
structure(list(Qnum = c(4.1, 4.2), Question = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zukünftig weniger von zu Hause aus arbeiten, welche Belastungen können Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie zukünftig unter veränderten Bedingungen (klare Arbeitszeiten, wenig Störung, ruhiger Arbeitsort, klar abgetrennter Raum, etc.) von zu Hause aus arbeiten, welche Belastungen können Ihrer Meinung nach reduziert werden?"
), Massnahme = c("Vereinbarung zur Reduktion von Home Office mit der vorgesetzten Person",
"Vereinbarung Home Office im privaten Bereich"), Answer1 = c("Belastung: Störungen beim Arbeiten im Home Office",
"Belastung: Störungen beim Arbeiten im Home Office"), Answer2 = c("",
""), Answer3 = c("", ""), Answer4 = c("", ""), Answer5 = c("",
"")), .Names = c("Qnum", "Question", "Massnahme", "Answer1",
"Answer2", "Answer3", "Answer4", "Answer5"), row.names = 7:8, class = "data.frame")

# test6: 11 überhaupt nicht
test_calc_relevant_questions_2a_06 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "Trifft überhaupt nicht zu", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht"
)), .Names = c("Qnum", "Question", "Answer"), row.names = c(NA,
-28L), class = "data.frame")

test_calc_relevant_questions_2a_expected_result_06 <-
structure(list(Qnum = c(1.1, 1.2, 3.1, 3.2, 5.1, 5.2), Question = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie zukünftig vermehrt von zu Hause aus arbeiten, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie zukünftig vermehrt von zu Hause aus arbeiten, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie Ihre Arbeitszeit zukünftig flexibler und selbstständiger organisieren, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie Ihre privaten Verpflichtungen zukünftig flexibler organisieren, wo sehen Sie Chancen für eine Verbesserung?"
), Massnahme = c("Switchen am Arbeitsplatz zugunsten privater Angelegenheiten",
"Switchen am Arbeitsplatz zugunsten privater Angelegenheiten",
"Vereinbarung Home Office mit der vorgesetzten Person", "Vereinbarung Home Office im privaten Bereich",
"Flexiblere Arbeitszeiten", "Haus- und Betreuungsarbeiten flexibler gestalten"
), Answer1 = c("Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge",
"Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge",
"Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge"
), Answer2 = c("", "", "", "", "", ""), Answer3 = c("", "", "",
"", "", ""), Answer4 = c("", "", "", "", "", ""), Answer5 = c("",
"", "", "", "", "")), .Names = c("Qnum", "Question", "Massnahme",
"Answer1", "Answer2", "Answer3", "Answer4", "Answer5"), row.names = c(1L,
2L, 5L, 6L, 9L, 10L), class = "data.frame")

# test7: 6 oft, 21 voll
test_calc_relevant_questions_2a_07 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "Oft", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "Trifft voll und ganz zu", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht"
)), .Names = c("Qnum", "Question", "Answer"), row.names = c(NA,
-28L), class = "data.frame")

test_calc_relevant_questions_2a_expected_result_07 <-
structure(list(Qnum = c(6.1, 6.2), Question = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie Ihre Arbeitszeit zukünftig weniger flexibel (regelmässige Arbeitszeiten, klar festgelegte Aufgaben, etc.) organisieren, welche Belastungen können Ihrer Meinung nach reduziert werden?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie Ihre privaten Verpflichtungen zukünftig geregelter organisieren, welche Belastungen können Ihrer Meinung nach reduziert werden?"
), Massnahme = c("Weniger flexible Arbeitszeiten", "Haus- und Betreuungsarbeiten klarer regeln"
), Answer1 = c("Belastung: Keine klar festgelegeten Arbeitszeiten (Flexibilisierung)",
"Belastung: Keine klar festgelegeten Arbeitszeiten (Flexibilisierung)"
), Answer2 = c("", ""), Answer3 = c("", ""), Answer4 = c("",
""), Answer5 = c("", "")), .Names = c("Qnum", "Question", "Massnahme",
"Answer1", "Answer2", "Answer3", "Answer4", "Answer5"), row.names = 11:12, class = "data.frame")

# test b_1: 1 nein, gerne weniger, 5 oft ,8 überhaupt nicht ,13 voll/ganz, 26 voll/ganz, 28 voll/ganz
test_calc_relevant_gaps_2b_01 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("Nein, ich möchte gern weniger Zeit dafür verwenden",
"weiss nicht", "weiss nicht", "weiss nicht", "Oft", "weiss nicht",
"weiss nicht", "Trifft überhaupt nicht zu", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "Trifft voll und ganz zu", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "Trifft voll und ganz zu", "weiss nicht", "Trifft voll und ganz zu"
)), .Names = c("Qnum", "Question", "Answer"), row.names = c(NA,
-28L), class = "data.frame")

test_calc_relevant_gaps_2b_expected_result_01 <-
  c("Unzufriedenheit mit dem beruflichen Zeitmanagement", "-", "-", "-", "-")

# test b_2: 1 nein, weniger, 2 nein, weniger, 7-14 überhaupt nicht, 15-28 voll und ganz
test_calc_relevant_gaps_2b_02 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("Nein, ich möchte gern weniger Zeit dafür verwenden",
"Nein, ich möchte gern weniger Zeit dafür verwenden", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "Trifft überhaupt nicht zu",
"Trifft überhaupt nicht zu", "Trifft überhaupt nicht zu", "Trifft überhaupt nicht zu",
"Trifft überhaupt nicht zu", "Trifft überhaupt nicht zu", "Trifft überhaupt nicht zu",
"Trifft überhaupt nicht zu", "Trifft voll und ganz zu", "Trifft voll und ganz zu",
"Trifft voll und ganz zu", "Trifft voll und ganz zu", "Trifft voll und ganz zu",
"Trifft voll und ganz zu", "Trifft voll und ganz zu", "Trifft voll und ganz zu",
"Trifft voll und ganz zu", "Trifft voll und ganz zu", "Trifft voll und ganz zu",
"Trifft voll und ganz zu", "Trifft voll und ganz zu", "Trifft voll und ganz zu"
)), .Names = c("Qnum", "Question", "Answer"), row.names = c(NA,
-28L), class = "data.frame")

test_calc_relevant_gaps_2b_expected_result_02 <- c("Unzufriedenheit mit dem beruflichen Zeitmanagement, Belastung: Hohe zeitliche Beanspruchung",
"Unzufriedenheit mit dem privaten Zeitmanagement, Belastung: Hohe zeitliche Beanspruchung",
"Belastung: Hohe zeitliche Beanspruchung", "Belastung: Hohe zeitliche Beanspruchung",
"-")

# test b_3: 1 nein, mehr, 3 nein, weniger, 8 überhaupt nicht, 11 überhaupt nicht, 14 voll und ganz, 17 voll und ganz
test_calc_relevant_gaps_2b_03 <-
structure(list(Qnum = c(1.1, 1.2, 1.3, 2.1, 2.2, 2.3, 3.1, 3.2,
3.3, 3.4, 3.5, 3.6, 4.1, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8,
5.9, 5.1, 5.11, 5.12, 6.1, 6.2, 6.3), Question = c("Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Erwerbsarbeit (incl. Pendeln, Übernachtungen, Pausen und Mittagszeiten) zuständig sind?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für Hausarbeiten wie Putzen, Kochen, Reparieren, Gartenarbeit, Zahlungen, Einkaufen, Waschen etc. verwenden?",
"Finden Sie es in Ordnung, wie viel Zeit Sie pro Woche für die Kinderbetreuung verwenden?",
"Wie häufig erledigen Sie während der Arbeitszeit zwischendurch oder zu Randzeiten private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern)? ",
"Wie häufig arbeiten Sie von zu Hause aus?", "Wie häufig führen private Verpflichtungen (z.B. Einkäufe erledigen, Mittagessen zubereiten, Versorgen von Kindern) dazu, dass Sie Ihren Arbeitsplatz früher verlassen bzw. später eintreffen?",
"Ich verbringe genügend Zeit mit meinem/meinen Kind(ern), um zu spielen, basteln, Sport treiben, lesen oder Ähnliches.",
"Wenn ich mit meinen Kindern spiele, bastle, Sport treibe, lese oder ähliche Tätigkeiten unternehme, bin ich zufrieden.",
"Ich verbringe genügend Zeit zu zweit mit meiner Partnerin/meinem Partner.",
"Ich bin zufrieden mit der Zeit, welche ich mit meiner Partnerin/meinem Partner zu zweit verbringe. ",
"In meiner Freizeit verbringe ich genügend Zeit mit Aktivitäten wie Wandern, Spazieren, Velofahren, Lesen, Fernsehen, Ausruhen und/oder Ähnlichem.",
"In meiner Freizeit verbringe ich genügend Zeit mit Freunden oder Verwandten oder in Vereinen, Feuerwehr, Sportclubs und/oder Ähnlichem.",
"Ich bin zufrieden mit meinen aktuellen Möglichkeiten zur Karriereentwicklung (Mein Arbeitgeber unterstützt mich darin mich weiterzuentwickeln oder weiterzubilden und meine familiäre Situation lässt dies zu).",
"In meiner Freizeit kann ich gut von meinen beruflichen Pflichten abschalten.",
"Ich fühle mich oft belastet, weil ich in meiner Freizeit viele Besorgungen, Termine, etc. erledigen muss, dies aber oftmals nicht in der gegebenen Zeit schaffe.",
"Ich fühle mich oft belastet, weil ich wichtige Arbeiten (in der Firma) oftmals nur mit Mühe rechtzeitig erledigen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von privaten Verpflichtungen die Erwartungen meines Arbeitgebers oftmals nicht erfüllen kann.",
"Ich habe oft ein schlechtes Gewissen, weil ich aufgrund von beruflichen Verpflichtungen meine Erwartungen bezüglich Haushalt und Kinderbetreuung nicht erfüllen kann.  ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oder in der Freizeit oftmals verschiedene Dinge gleichzeitig erledigen muss. ",
"Ich fühle mich oft belastet, weil ich während der Arbeit oftmals auch privaten Verpflichtungen nachkommen muss.",
"Ich fühle mich oft belastet, weil ich zu Hause oftmals auch beruflichen Verpflichtungen nachkommen muss.  ",
"Ich fühle mich während des Home Office belastet, weil oftmals private Aufgaben dazwischen kommen.",
"Ich fühle mich oft belastet, weil die zeitliche Beanspruchung von Arbeit und privaten Verpflichtungen insgesamt zu hoch ist.",
"Ich fühle mich oft belastet, weil die finanzielle Situation in meinem Haushalt angespannt ist.",
"Ich fühle mit oft belastet, weil ich gesundheitlich angeschlagen bin.",
"Ich fühle mich durch meine Arbeit frustriert und habe das Interesse an meiner Arbeit verloren.",
"Ich habe das Gefühl, manche KundenInnen/GeschäftspartnerInnen/KollegInnen unpersönlich zu behandeln und es interessiert mich nicht wirklich, was mit manchen meiner KundenInnen/GeschäftspartnerInnen/KollegInnen geschieht.",
"Ich fühle mich machtlos, meine Arbeitssituation zu verändern."
), Answer = c("Nein, ich möchte gern mehr Zeit dafür verwenden",
"weiss nicht", "Nein, ich möchte gern weniger Zeit dafür verwenden",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "Trifft überhaupt nicht zu",
"weiss nicht", "weiss nicht", "Trifft überhaupt nicht zu", "weiss nicht",
"weiss nicht", "Trifft voll und ganz zu", "weiss nicht", "weiss nicht",
"Trifft voll und ganz zu", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht")), .Names = c("Qnum",
"Question", "Answer"), row.names = c(NA, -28L), class = "data.frame")

test_calc_relevant_gaps_2b_expected_result_03 <- c("Unzufriedenheit mit dem beruflichen Zeitmanagement", "-", "Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung",
"-", "-")

# test c_1
test_unterstuetzung_entlastung_alist_2c <- structure(list(Qnum = 1:8, Question = c("Wäre es für die finanzielle Umsetzung dieses Plans hilfreich, die Zuständigkeiten für das Geld verdienen in Ihrem Haushalt neu zu verhandeln?",
"Wäre es für die zeitliche und finanzielle Umsetzung dieses Plans hilfreich, wenn Ihre Kinder neu oder in einem anderen Umfang als bisher durch Krippen, Tagesschulen, Spielgruppen oder ähnliche Organisationen betreut würden?",
"Wäre es für die zeitliche und finanzielle Umsetzung dieses Plans hilfreich, wenn Ihre Kinder neu oder in einem anderen Umfang als bisher durch Grosseltern, andere Verwandte, Freunde oder Nachbarn betreut würden?",
"Wäre es für die Umsetzung dieses Plans hilfreich, wenn Sie Hausarbeiten in einem anderen Umfang als bisher an bezahlte Drittpersonen auslagern würden (z.B. Haushaltshilfe, Gärtner, Essen bestellen)?",
"Wäre es für die zeitliche und finanzielle Umsetzung dieses Plans hilfreich, wenn sich der Umfang der anfallenden Hausarbeiten insgesamt verändern würden (z.B. kleinere oder grössere Wohnung/Haus, weniger oder mehr Umschwung, tiefere Ansprüche bezüglich Sauberkeit)?",
"Wäre es für die Umsetzung dieses Plans hilfreich, wenn Sie in Ihrem Haushalt allgemein weniger Geld ausgeben würde (z.B. eine günstigere Wohnung nehmen, weniger Ausgaben für Konsumgüter)?",
"Wäre es für die Umsetzung dieses Plans hilfreich, wenn Ihr beruflicher Aufgabenbereich angepasst würde (z.B. mehr oder weniger Aufgaben, bessere Vereinbarkeit von Beruf und Familie)?",
"Wäre es im Zusammenhang mit Ihrer Planung sinnvoll, wenn Sie Ihre Ziele für die berufliche Weiterentwicklung oder für Weiterbildungen anpassen würden (in Absprache mit Ihrem/Ihrer Vorgesetzten und/oder Ihren Angehörigen)?"
), Antwort = c("Ja, es wäre hilfreich, wenn ich einen kleineren Teil und meine Angehörigen einen grösseren Teil beitragen würde",
"Ja, weniger als bisher", "Ja, neu/mehr als bisher", "weiss nicht",
"weiss nicht", "weiss nicht", "weiss nicht", "weiss nicht"),
    Kommentar = c("", "", "", "", "", "", "", "")), row.names = c(NA,
-8L), .Names = c("Qnum", "Question", "Antwort", "Kommentar"), class = "data.frame")

test_zeitverwendung_alist_2b <- structure(list(Qnum = 1:5, Question = c("für den Job (Erwerbsarbeit)",
"für Hausarbeiten", "für Kinderbetreuung", "für soziale Kontakte",
"für Sie selbst"), Antwort = c("viel weniger als bisher", "weniger als bisher",
"gleich viel wie bisher", "mehr als bisher", "viel mehr als bisher"
), Kommentar = c("", "", "", "", "")), row.names = c(NA, -5L), .Names = c("Qnum",
"Question", "Antwort", "Kommentar"), class = "data.frame")

test_zeitverwendung_relevant_gaps <- c("Belastung: Hohe zeitliche Beanspruchung", "Belastung: Hohe zeitliche Beanspruchung",
"Belastung: Hohe zeitliche Beanspruchung", "Belastung: Hohe zeitliche Beanspruchung",
"-")

# test presentation rmd_display_vereinbarungen_chancen
# test 1: vorgesetzter
test_rmd_display_vereinbarungen_chancen_alist2a_01 <-
structure(list(Frage = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?"
), Antwort = c("Unzufriedenheit mit dem beruflichen Zeitmanagement, Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung, Unzufriedenheit mit der Selbstsorge, Unzufriedenheit mit der Karriereentwicklung",
"Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung, Unzufriedenheit mit der Selbstsorge, Unzufriedenheit mit der Karriereentwicklung"
), Kommentar = c("", "")), .Names = c("Frage", "Antwort", "Kommentar"
), class = "data.frame", row.names = 1:2)

test_rmd_display_vereinbarungen_chancen_qlist_01 <-
structure(list(Qnum = c(1.1, 1.2), Question = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?"
), Massnahme = c("Switchen am Arbeitsplatz zugunsten privater Angelegenheiten",
"Switchen am Arbeitsplatz zugunsten privater Angelegenheiten"
), Answer1 = c("Unzufriedenheit mit dem beruflichen Zeitmanagement",
"Unzufriedenheit mit dem beruflichen Zeitmanagement"), Answer2 = c("Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung",
"Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung"
), Answer3 = c("Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge"
), Answer4 = c("Unzufriedenheit mit der Karriereentwicklung",
"Unzufriedenheit mit der Karriereentwicklung"), Answer5 = c("",
"")), .Names = c("Qnum", "Question", "Massnahme", "Answer1",
"Answer2", "Answer3", "Answer4", "Answer5"), row.names = 1:2, class = "data.frame")

test_rmd_display_vereinbarungen_chancen_bolvg_01 <- TRUE

test_rmd_display_vereinbarungen_chancen_expected_html_01 <-
"<table cellpadding='10' cellspacing='10' width='100%'><tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC; background: #CCCCCC;' ><th width='40%'><b>Geplante Vereinbarung</b></th><th width='*'><b>Bestehende Unzufriedenheit</b></th><th><b>Eigene Ideen&nbsp;&nbsp;</b></th></tr><tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td><div style='border-radius: 15px;background: #AEDBCC;padding: 12px; width: 400px; align: center; border: 2px solid #FFFFFF;'>Switchen am Arbeitsplatz zugunsten privater Angelegenheiten</div></td><td>&nbsp;<div style='border-radius: 15px;background: #F17579;padding: 12px; width: 200px; align: center; float: left;border: 2px solid #FFFFFF;'>Unzufriedenheit mit dem beruflichen Zeitmanagement</div>&nbsp;&nbsp;<div style='border-radius: 15px;background: #F17579;padding: 12px; width: 200px; align: center; float: left;border: 2px solid #FFFFFF;'>Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung</div>&nbsp;&nbsp;<div style='border-radius: 15px;background: #F17579;padding: 12px; width: 200px; align: center; float: left;border: 2px solid #FFFFFF;'>Unzufriedenheit mit der Selbstsorge</div>&nbsp;&nbsp;<div style='border-radius: 15px;background: #F17579;padding: 12px; width: 200px; align: center; float: left;border: 2px solid #FFFFFF;'>Unzufriedenheit mit der Karriereentwicklung</div>&nbsp;<td style='background: #FFFFFF'></td></td></tr></table>"

# test 2: angehörige
test_rmd_display_vereinbarungen_chancen_alist2a_02 <-
structure(list(Frage = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?"
), Antwort = c("Unzufriedenheit mit dem beruflichen Zeitmanagement, Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung, Unzufriedenheit mit der Selbstsorge, Unzufriedenheit mit der Karriereentwicklung",
"Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung, Unzufriedenheit mit der Selbstsorge, Unzufriedenheit mit der Karriereentwicklung"
), Kommentar = c("", "")), .Names = c("Frage", "Antwort", "Kommentar"
), class = "data.frame", row.names = 1:2)

test_rmd_display_vereinbarungen_chancen_qlist_02 <-
structure(list(Qnum = c(1.1, 1.2), Question = c("Wenn Sie mit Ihrem/Ihrer Vorgesetzten vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?",
"Wenn Sie mit Ihren Angehörigen vereinbaren, dass Sie private Verpflichtungen in Zukunft vermehrt vom Arbeitsplatz aus oder in Arbeitspausen erledigen, wo sehen Sie Chancen für eine Verbesserung?"
), Massnahme = c("Switchen am Arbeitsplatz zugunsten privater Angelegenheiten",
"Switchen am Arbeitsplatz zugunsten privater Angelegenheiten"
), Answer1 = c("Unzufriedenheit mit dem beruflichen Zeitmanagement",
"Unzufriedenheit mit dem beruflichen Zeitmanagement"), Answer2 = c("Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung",
"Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung"
), Answer3 = c("Unzufriedenheit mit der Selbstsorge", "Unzufriedenheit mit der Selbstsorge"
), Answer4 = c("Unzufriedenheit mit der Karriereentwicklung",
"Unzufriedenheit mit der Karriereentwicklung"), Answer5 = c("",
"")), .Names = c("Qnum", "Question", "Massnahme", "Answer1",
"Answer2", "Answer3", "Answer4", "Answer5"), row.names = 1:2, class = "data.frame")

test_rmd_display_vereinbarungen_chancen_bolvg_02 <- FALSE

test_rmd_display_vereinbarungen_chancen_expected_html_02 <-
"<table cellpadding='10' cellspacing='10' width='100%'><tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC; background: #CCCCCC;' ><th width='40%'><b>Geplante Vereinbarung</b></th><th width='*'><b>Bestehende Unzufriedenheit</b></th><th><b>Eigene Ideen&nbsp;&nbsp;</b></th></tr><tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td><div style='border-radius: 15px;background: #AEDBCC;padding: 12px; width: 400px; align: center; border: 2px solid #FFFFFF;'>Switchen am Arbeitsplatz zugunsten privater Angelegenheiten</div></td><td>&nbsp;<div style='border-radius: 15px;background: #F17579;padding: 12px; width: 200px; align: center; float: left;border: 2px solid #FFFFFF;'>Unzufriedenheit mit der zeitlichen Organisation der Kinderbetreuung</div>&nbsp;&nbsp;<div style='border-radius: 15px;background: #F17579;padding: 12px; width: 200px; align: center; float: left;border: 2px solid #FFFFFF;'>Unzufriedenheit mit der Selbstsorge</div>&nbsp;&nbsp;<div style='border-radius: 15px;background: #F17579;padding: 12px; width: 200px; align: center; float: left;border: 2px solid #FFFFFF;'>Unzufriedenheit mit der Karriereentwicklung</div>&nbsp;<td style='background: #FFFFFF'></td></td></tr></table>"
