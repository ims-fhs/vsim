# Dynamic UI is the interface which changes as the survey
# progresses.

# this function is called in order to prepare variables for the next questionary
# after this questionary has been completed
questionaryPostProcessing <- function() {
  Alist <- result_coll$Alist
  relevant_gaps <<- calc_relevant_gaps_2b(Alist)
  result_coll$relevant_gaps <<- relevant_gaps
  calc_survey_question_ids()

  # ****** Data part 2b
  if (is.null(results2b)) {
    results2b <<- rep("", length(choices))
    kommentare2b <<- rep("", length(choices))
  }
}

# This renderUI function holds the primary actions of the
# survey area.
output$mainPanel <- renderUI( {
  # print(paste0("Rendering Question ", question_id))
  # Initially it shows a welcome message.
  if (question_id == Survey_Sections$Teil2a_intro) {
    return(
      list(
        p("..hier kommt noch das Bild 'Wegleitung durch den Simulator'.."),
        h4("Mit Blick auf die im vorigen Teil ermittelten Belastungsfaktoren und Unzufriedenheiten treten in Teil 2 des Vereinbarkeitssimulators mögliche Lösungsansätze in den Vordergrund."),
        h4("Sie haben im gesamten Teil 2 die Möglichkeit, die Lösungsvorschläge durch persönliche Anmerkungen zu ergänzen. Damit können Sie die Lösungsvorschläge personalisieren und um wichtige Details ergänzen."),
        br(),
        h4("Im Teil 2a geht es darum festzulegen, in welchen Bereichen durch verbindliche Vereinbarungen eine Verbesserung ihrer privaten oder beruflichen Situation in Aussicht gestellt werden kann."),
        br(),
        br(),
        h4("Zum Fortfahren klicken Sie bitte auf 'Weiter'.")
      )
    )
  } else if (question_id > Survey_Sections$Teil2a_intro & question_id <= Survey_Sections$Teil2a_last_question) {
    # Once the next button has been clicked once we see each question
    # of the survey.

    # memorize last answer to set answer correct for redisplaying the question
    selected <- get_selected_checkbox_values(results2[question_id - Survey_Sections$Teil2a_intro])
    kommentar <- kommentare2[question_id - Survey_Sections$Teil2a_intro]

    return(
      list(
        h4(textOutput("question")),
        h4(checkboxGroupInput("survey", "", choices = c(option_list(), "Ich sehe keinen Nutzen in dieser Vereinbarung"), selected = selected, width = "600")),
        h4(textInput("kommentar", "Persönliche Anmerkungen", kommentar))
      )
    )
  } else if (question_id == Survey_Sections$Teil2a_end_statement) {
    return(
      list(
        h4("Die Erfassung potentieller Vereinbarungsmöglichkeiten ist nun abgeschlossen."),
        br(),
        br(),
        h4("Klicken Sie bitte aus 'Weiter' um zum Teil 2b 'Einschätzung Ihrer zukünftigen Zeitplanung' zu gelangen. ")
      )
    )
  }
})

# This reactive function is concerned primarily with
# saving the results of the survey for this individual.
output$save_results <- renderText({
  # After each click, save the results of the radio buttons.
  if ((question_id > Survey_Sections$Teil2a_intro) & question_id <= Survey_Sections$Teil2a_last_question) {
    try(results2[question_id - Survey_Sections$Teil2a_intro] <<- ifelse(length(input$survey)>0, paste(input$survey, collapse = ", "), NA))
    try(kommentare2[question_id - Survey_Sections$Teil2a_intro] <<- ifelse(length(input$kommentar)>0, input$kommentar, NA))
  }
  # try is used because there is a brief moment in which
  # the if condition is true but input$survey = NULL

  # If the user has clicked through all of the survey questions
  # then R saves the results to the survey file.
  if (question_id == Survey_Sections$Teil2a_end_statement) {
    Alist <- Qlist_2a
    Alist <- Alist[, 1:4]
    if (!is.null(results2)) {
      # Bug? verschiedn grosse listen!?
      Alist[,3] <- results2
    }
    if (!is.null(kommentare2)) {
      Alist[,4] <- kommentare2
    }
    names(Alist)[3] <- "Antwort"
    names(Alist)[4] <- "Kommentar"
    result_coll$Alist_2a <<- Alist
    questionaryPostProcessing();
  }
  # Because there has to be a UI object to call this
  # function I set up render text that distplays the content
  # of this funciton.
  ""
})

# The option list is a reactive list of elements that
# updates itself when the click counter is advanced.
option_list <- reactive({
  qlist <- Qlist_2a[question_id - Survey_Sections$Teil2a_intro,4:ncol(Qlist_2a)]
  # Remove items from the qlist if the option is empty.
  # Also, convert the option list to matrix.
  as.matrix(qlist[qlist != ""])
})

# This function show the question number (Q:)
# Followed by the question text.
output$question <- renderText({
  paste0(
    "Frage ", (question_id - (Survey_Sections$Teil2a_first_question - Survey_Sections$Teil1_last_question - 1)),": ",
    Qlist_2a[question_id - Survey_Sections$Teil2a_intro, 2]
  )
})
