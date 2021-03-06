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
        h4("Im nun folgenden Teil 2b legen Sie fest, wie Sie Ihre Zeit neu planen wollen."),
        br(),
        br(),
        h4("Zum Fortfahren klicken Sie bitte auf 'Weiter'. ")
      )
    )
  } else if (question_id == Survey_Sections$Teil2b_first_question) {
    return(
      fluidPage(
        fluidRow(h4("Möglicherweise ist Ihnen beim Ausfüllen der Fragen klargeworden, dass Sie mit der Planung/Einteilung ihrer Zeit zufrieden sind. Möglicherweise möchten Sie Ihre Zeiteinteilung aber auch anpassen."),
                  h4("Das kann mit Unterstützung Ihrer/Ihres Vorgesetzten, Ihres Teams und Ihrer Angehörigen gelingen. Überlegen Sie sich, für welche Aktivitäten Sie in der nächsten Zeit mehr oder weniger Zeit als bisher verwenden wollen und wählen Sie im Dropdown-Menu die für Sie passenden Vorschläge aus."), br(), br()),
        fluidRow(
          column(2, HTML("<h4><b>Zeit für was</b></h4>")),
          column(4, HTML("<h4><b>Ihre relevanten Belastungen und Unzufriedenheiten</b></h4>")),
          column(4, HTML("<h4><b>Zeitmenge</b></h4>")),
          column(2, HTML("<h4><b>Anmerkungen</b></h4>"))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für den Job (Erwerbsarbeit)")),
          column(4, h4(gsub("-", "keine", relevant_gaps[1]))),
          column(4, h4(selectInput('select1', '', choices = choices, selected = get_selected_value(results2b[1], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar1", "", value = ifelse(length(kommentare2b[1])>0, kommentare2b[1], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für Hausarbeiten")),
          column(4, h4(gsub("-", "keine", relevant_gaps[2]))),
          column(4, h4(selectInput('select2', '', choices = choices, selected = get_selected_value(results2b[2], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar2", "", value = ifelse(length(kommentare2b[2])>0, kommentare2b[2], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2,h4("für Kinderbetreuung")),
          column(4, h4(gsub("-", "keine", relevant_gaps[3]))),
          column(4, h4(selectInput('select3', '', choices = choices, selected = get_selected_value(results2b[3], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar3", "", value = ifelse(length(kommentare2b[3])>0, kommentare2b[3], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für soziale Kontakte")),
          column(4, h4(gsub("-", "keine", relevant_gaps[4]))),
          column(4, h4(selectInput('select4', '', choices = choices, selected = get_selected_value(results2b[4], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar4", "", value = ifelse(length(kommentare2b[4])>0, kommentare2b[4], ""))))
        ),
        fluidRow(hr()),
        fluidRow(
          column(2, h4("für Sie selbst")),
          column(4, h4(gsub("-", "keine", relevant_gaps[5]))),
          column(4, h4(selectInput('select5', '', choices = choices, selected = get_selected_value(results2b[5], "gleich viel wie bisher")))),
          column(2, h4(textInput("kommentar5", "", value = ifelse(length(kommentare2b[5])>0, kommentare2b[5], ""))))
        ),
        fluidRow(br()),
        fluidRow(br()),
        fluidRow(br()),
        fluidRow(br()),
        fluidRow(br()),
        fluidRow(br()),
        fluidRow(br()),
        fluidRow(br())
      )
    )
  } else if (question_id == Survey_Sections$Teil2b_end_statement) {
    return(
      list(
        h4("Die Erfassung Ihrer Zeitplanung ist nun abgeschlossen."),
        br(),
        br(),
        h4("Klicken Sie bitte auf 'Weiter' um zum Teil 2c 'Unterstützung, Entlastung, Entwicklung' zu gelangen.")
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
    kommentare2b <<- c(as.character(input$kommentar1),
                    as.character(input$kommentar2),
                    as.character(input$kommentar3),
                    as.character(input$kommentar4),
                    as.character(input$kommentar5))
  }
  if (question_id == Survey_Sections$Teil2b_end_statement) {
    Alist <- Qlist_2b
    Alist[,3] <- results2b
    if (is.null(kommentare2b) || any(is.na(kommentare2b))) {
      Alist[,4] <- ""
    } else {
      Alist[,4] <- kommentare2b
    }
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
