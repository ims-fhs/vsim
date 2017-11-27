# Dynamic UI is the interface which changes as the survey
# progresses.

# this function is called in order to prepare variables for the next questionary
# after this questionary has been completed
questionaryPostProcessing <- function() {
  Alist <- result_coll$Alist
  Qlist_2a <<- calc_relevant_questions_2a(Alist)
  result_coll$Qlist_2a <<- Qlist_2a
  calc_survey_question_ids()
  # ****** Data part 2a
  # Create an empty vector to hold survey results
  if (!exists("results2", envir = parent.env(environment()) )) {
    results2 <<- rep("", nrow(Qlist_2a))
    kommentare2 <<- rep("", nrow(Qlist_2a))
    # Name each element of the vector based on the
    # second column of the Qlist_2a
    names(results2)  <<- Qlist_2a[,2]
  }
}

output$mainPanel <- renderUI({
  # Initially it shows a welcome message.
  if (question_id == Survey_Sections$Teil1_intro) {
    return(list(h3("Willkommen zum Vereinbarkeitssimulator"),
                h4("Der Vereinbarkeitssimulator ist ein softwarebasiertes Instrument, welches die spezifischen Lebenslagen von Mitarbeitenden und ihre Wünsche an ihre zukünftige Work-Life-Balance erfasst. So soll ein Dialog zwischen der Unternehmensführung und den Mitarbeitenden inklusive ihrer Angehörigen ermöglicht und Entscheidungsgrundlagen für die Wahl von Arbeitsorganisationsmodellen geschaffen werden."),
                h4("Im", strong("ersten Schritt"),"erfragt der Vereinbarkeitssimulator Ihre spezifische Lebenslage. Auf Grund der von Ihnen angegebenen Daten erfolgt dann eine Bewertung der momentanen Ausgangssituation (Ist-Zustand)."),
                h4("Mit Blick auf den Ist-Zustand werden im ", strong("zweiten Schritt"), "Wünsche und Bedürfnisse festgelegt (Soll-Zustand). In diesem Teil des Vereinbarkeitssimulators können Ideen und Vorgaben erfasst werden, welche Ihnen als Hilfestellung zum Erreichen Ihrer angestrebten Ziele dienen."),
                h4("Im", strong("dritten Schritt"),  "erarbeitet der Vereinbarkeitssimulator mit Ihnen zusammen Lösungsansätze. Hierbei werden Möglichkeiten zur Zielerreichung mittels betrieblicher Hilfen (unternehmensspezifische Angebote wie Teilzeit, flexible Arbeitszeit, Weiterbildungen etc.), Wünsche zur Zeitverwendung sowie individuelle Unterstützungs- und Entlastungsmöglichkeiten aufgezeigt."),
                h4("Zum Abschluss erhalten Sie eine Zusammenfassung ihrer Lebenslage, ihren Wünschen und Ideen."),
                br(),
                h4("Zum Starten des Vereinbarkeitssimulators klicken Sie bitte auf 'Weiter'. Durch das Anklicken von 'Zurück' haben Sie ausserdem die Möglichkeit, einen Schritt retour zu gehen.")
                   ))
  } else if (question_id > Survey_Sections$Teil1_intro & question_id <= Survey_Sections$Teil1_last_question) {
    # Once the next button has been clicked once we see each question
    # of the survey.
    # memorize last answer to set answer correct for redisplaying the question
      selected <- results[[question_id]]
    selected <- ifelse(selected == "", "weiss nicht", selected)
    return(list(
        h4(textOutput("question")),
        h4(
        radioButtons("survey", "", c(option_list(), "weiss nicht"), selected = selected))
      ))
  } else if (question_id == Survey_Sections$Teil1_end_statement) {
    return(list(
        h4("Die Erfassung Ihrer Lebenslage ist nun abgeschlossen. Klicken Sie bitte auf 'Weiter' um zur Auswertung Ihrer Angaben zu gelangen.")
    ))
  } else if (question_id == Survey_Sections$Teil1_summary) {
    questionaryPostProcessing();
    return(inclRmd("rmds/gaps_user.rmdy"))
  }
})

# This reactive function is concerned primarily with
# saving the results of the survey for this individual.
output$save_results <- renderText({
  # After each click, save the results of the radio buttons.
  if ((question_id > Survey_Sections$Teil1_intro) & (question_id <= Survey_Sections$Teil1_last_question))
    try(results[question_id] <<- ifelse(length(input$survey)>0, input$survey, NA))
  # try is used because there is a brief moment in which
  # the if condition is true but input$survey = NULL

  # If the user has clicked through all of the survey questions
  # then R saves the results to the survey file.
  if (question_id == Survey_Sections$Teil1_end_statement) {
    Alist <- Qlist_1
    Alist <- Alist[, 1:3]
    Alist[,3] <- results
    names(Alist)[3] <- "Answer"
    # store the data in the memory for later access
    result_coll$Alist <<- Alist
  }
  # Because there has to be a UI object to call this
  # function I set up render text that distplays the content
  # of this funciton.
  return("")
})

# The option list is a reactive list of elements that
# updates itself when the click counter is advanced.
option_list <- reactive({
  qlist <- Qlist_1[question_id,3:ncol(Qlist_1)]
  # Remove items from the qlist if the option is empty.
  # Also, convert the option list to matrix.
  as.matrix(qlist[qlist != ""])
})

# This function show the question number (Q:)
# Followed by the question text.
output$question <- renderText({
  paste0(
    "Frage ", question_id,": ",
    Qlist_1[question_id,2]
  )
})
