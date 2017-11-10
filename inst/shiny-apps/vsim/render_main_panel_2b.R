# Dynamic UI is the interface which changes as the survey
# progresses.

# this function is called in order to prepare variables for the next questionary
# after this questionary has been completed
questionaryPostProcessing <- function() {
  calc_survey_question_ids()

  # ****** Data part 2c
  if (is.null(results2c)) {
    results2c <<- rep("", nrow(Qlist_2c))
    kommentare2c <<- rep("", nrow(Qlist_2c))
    # Name each element of the vector based on the
    # second column of the Qlist
    names(results2c)  <<- Qlist_2c[,2]
  }
}

# This renderUI function holds the primary actions of the
# survey area.
output$mainPanel <- renderUI( {
  # Initially it shows a welcome message.
  if (question_id == Survey_Sections$Teil2b_intro) {
    return(
      list(
        h3("Willkommen zum Vereinbarkeitssimulator - Teil 2b. In diesem Teil geht es darum, Anpassungen an der Zeitverwendung vorzunehmen.")
      )
    )
  } else if (question_id == Survey_Sections$Teil2b_first_question) {
    return(
      fluidPage(
        fluidRow(p(h4("Möglicherweise ist für Sie beim Ausfüllen der Fragen klargeworden, dass Sie zufrieden damit sind, wofür Sie Ihre Zeit einsetzen. Möglicherweise möchten Sie Ihre Zeiteinteilung aber auch anpassen. Das kann mit Unterstützung Ihres Vorgesetzten, Ihres Teams, Ihrer Familie und Ihres Umfelds gelingen. Überlegen Sie sich, für welche Aktivitäten Sie im nächsten Jahr mehr oder weniger Zeit als bisher verwenden wollen.")), br(), br()),
        fluidRow(
          column(2, h4("Zeit für was")),
          column(4, h4("Relevante Angaben aus Teil 1")),
          column(4, h4("Zeitmenge")),
          column(2, h4("Kommentar"))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für den Job (Erwerbsarbeit)")),
          column(4, h4(relevant_gaps[1])),
          column(4, h4(selectInput('select1', '', choices = choices, selected = get_selected_value(results2b[1], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar1", "", value = ifelse(length(kommentare2b[1])>0, kommentare2b[1], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für Hausarbeiten")),
          column(4, h4(relevant_gaps[2])),
          column(4, h4(selectInput('select2', '', choices = choices, selected = get_selected_value(results2b[2], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar2", "", value = ifelse(length(kommentare2b[2])>0, kommentare2b[2], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2,h4("für Kinderbetreuung")),
          column(4, h4(relevant_gaps[3])),
          column(4, h4(selectInput('select3', '', choices = choices, selected = get_selected_value(results2b[3], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar3", "", value = ifelse(length(kommentare2b[3])>0, kommentare2b[3], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für soziale Kontakte")),
          column(4, h4(relevant_gaps[4])),
          column(4, h4(selectInput('select4', '', choices = choices, selected = get_selected_value(results2b[4], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar4", "", value = ifelse(length(kommentare2b[4])>0, kommentare2b[4], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für Sie selbst")),
          column(4, h4(relevant_gaps[5])),
          column(4, h4(selectInput('select5', '', choices = choices, selected = get_selected_value(results2b[5], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar5", "", value = ifelse(length(kommentare2b[5])>0, kommentare2b[5], ""))))
        )
      )
    )
  } else if (question_id == Survey_Sections$Teil2b_end_statement) {
    return(
      list(
        h3("Teil 2b ist nun fertig. Klicken Sie auf 'weiter', um zum letzten Teil der Befragung zu gelangen.")
      )
    )
  }
})


# This reactive function is concerned primarily with
# saving the results of the survey for this individual.
output$save_results <- renderText({
  if (question_id >= Survey_Sections$Teil2b_first_question & question_id <= Survey_Sections$Teil2b_last_question) {
    results2b <<- c(input$select1,
                 input$select2,
                 input$select3,
                 input$select4,
                 input$select5)
    kommentare2b <<- c(input$kommentar1,
                    input$kommentar2,
                    input$kommentar3,
                    input$kommentar4,
                    input$kommentar5)
  }

  if (question_id == Survey_Sections$Teil2b_end_statement) {
    Alist <- Qlist_2b
    Alist[,3] <- results2b
    # BUG: <-.data.frame: new columns would leave holes after existing columns
    # pattern of occurrence not yet determined. :/
    Alist[,4] <- kommentare2b
    names(Alist)[3] <- "Antwort"
    names(Alist)[4] <- "Kommentar"
    result_coll$Alist_2b <<- Alist
    questionaryPostProcessing();
  }

  # Because there has to be a UI object to call this
  # function I set up render text that distplays the content
  # of this funciton.
  ""
})

# # The option list is a reactive list of elements that
# # updates itself when the click counter is advanced.
# option_list <- reactive({
#   qlist <- Qlist_2b[question_id - Survey_Sections$Teil2b_intro,3:ncol(Qlist_2b)]
#   # Remove items from the qlist if the option is empty.
#   # Also, convert the option list to matrix.
#   as.matrix(qlist[qlist != ""])
# })
#
# # This function show the question number (Q:)
# # Followed by the question text.
# output$question <- renderText({
#   paste0(
#     "Frage ", (question_id - (Survey_Sections$Teil2b_first_question - Survey_Sections$Teil2a_last_question - 1)),": ",
#     Qlist_2b[question_id - Survey_Sections$Teil2b_intro, 2]
#   )
# })
