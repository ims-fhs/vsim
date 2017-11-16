# Dynamic UI is the interface which changes as the survey
# progresses.

# this function is called in order to prepare variables for the next questionary
# after this questionary has been completed
questionaryPostProcessing <- function() {
  # nop
}

# This renderUI function holds the primary actions of the
# survey area.
output$mainPanel <- renderUI( {
  # Initially it shows a welcome message.
  if (question_id == Survey_Sections$Teil2c_intro) {
    return(
      list(
        h3("..Erklärungstext für Teil 2c... TBD oder komplett entfernen")
      )
    )
  } else if (question_id > Survey_Sections$Teil2c_intro & question_id <= Survey_Sections$Teil2c_last_question) {
    selected <- get_selected_value(results2c[question_id - Survey_Sections$Teil2c_intro], "weiss nicht")
    return(
      list(
        h4(textOutput("question")),
        h4(radioButtons("survey", "",
                     c(option_list(), "weiss nicht"), selected = selected), width = "600"),
        textInput("kommentar", "Kommentar", value = ifelse(length(kommentare2c[question_id - Survey_Sections$Teil2c_intro])>0, kommentare2c[question_id - Survey_Sections$Teil2c_intro], ""))
      )
    )
  } else if (question_id == Survey_Sections$Teil2c_end_statement) {
    return(
      list(
        h3("Die Planung 'Unterstützung und Entlastung' ist nun abgeschlossen. Somit hast du in den drei Handlungsfeldern 'Vereinbarungen', 'Zeitverwendung' und 'Unterstützung und Entlastung' Massnahmen identifizieren können, welche dir helfen deine Belastungen und Unzufriedenheiten anzugehen. Klicke auf 'weiter', um deinen Plan im Überblick anzuzeigen.")
      )
    )
  }
})

# This reactive function is concerned primarily with
# saving the results of the survey for this individual.
output$save_results <- renderText({
  # After each click, save the results of the radio buttons.
  if (question_id >= Survey_Sections$Teil2c_first_question & question_id <= Survey_Sections$Teil2c_last_question) {
    try(results2c[question_id - Survey_Sections$Teil2c_intro] <<- ifelse(length(input$survey)>0, input$survey, NA))
    try(kommentare2c[question_id - Survey_Sections$Teil2c_intro] <<- ifelse(length(input$kommentar)>0, input$kommentar, NA))
  }
  # try is used because there is a brief moment in which
  # the if condition is true but input$survey = NULL

  # If the user has clicked through all of the survey questions
  # then R saves the results to the survey file.
  if (question_id == Survey_Sections$Teil2c_end_statement) {
    Alist <- Qlist_2c
    Alist <- Alist[, 1:3]
    Alist[,3] <- results2c
    Alist[,4] <- kommentare2c
    names(Alist)[3] <- "Antwort"
    names(Alist)[4] <- "Kommentar"
    # write.table(Alist, file = "../../data/Alist_Teil2c.csv",quote = FALSE, row.names = FALSE, na = "", sep = ";", fileEncoding = "UTF-8")
    # instead of writing a file we store the data in the memory for later access
    result_coll$Alist_2c <<- Alist
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
  qlist <- Qlist_2c[question_id - Survey_Sections$Teil2c_intro,3:ncol(Qlist_2c)]
  # Remove items from the qlist if the option is empty.
  # Also, convert the option list to matrix.
  as.matrix(qlist[qlist != ""])
})

# This function show the question number (Q:)
# Followed by the question text.
output$question <- renderText({
  paste0(
    "Frage ", (question_id - (Survey_Sections$Teil2c_first_question - Survey_Sections$Teil2b_last_question +5)),": ",
    Qlist_2c[question_id - Survey_Sections$Teil2c_intro, 2]
  )
})
