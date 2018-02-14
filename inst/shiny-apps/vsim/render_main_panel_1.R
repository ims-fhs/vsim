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
                h4("Der Vereinbarkeitssimulator ist eine Software, die Wünsche an ihre zukünftige Work-Life-Balance erfasst. Basierend darauf können Arbeitsorganisationsmodelle geplant werden. Die Software geht dabei folgende Schritte durch:"),
                img(src='simulator.png', height = 60),
                h4("Im", strong("ersten Schritt"),"erfragt der Vereinbarkeitssimulator ihre Lebenslage. Im Anschluss daran erfolgt eine Auswertung der von ihnen angegebenen Daten über ihre momentane Lebenssituation. Hier werden Unzufriedenheiten und Belastungen verdeutlicht."),
                h4("Im ", strong("zweiten Schritt"), "werden Ideen und Hilfsmassnahmen festgelegt mit denen die ermittelten Unzufriedenheiten und Belastungen vermindert werden können."),
                h4("Im", strong("dritten Schritt"),  "erarbeitet der Vereinbarkeitssimulator mit ihnen zusammen eine Planung. Hierbei werden Möglichkeiten zum Zeitmanagement und betrieblicher Hilfen (Teilzeit, flexible Arbeitszeit, Weiterbildungen etc.) aufgezeigt. Zum Abschluss erhalten Sie eine Zusammenfassung ihrer Planungsideen.",
                   "Mehr Informationen zu den drei Schritten finden Sie in ", shiny::HTML(text = "<a target='_blank' href='https://www.youtube.com/watch?v=vaNSLevObc0&feature=youtu.be'>diesem Erklärvideo</a>"), "."),
                br(),
                h4(strong("Hinweis: "), "Es werden keine Daten gespeichert. Sobald Sie das Fenster schliessen, sind ihre Angaben verloren. Wir empfehlen ihnen daher, die Auswertungen als PDF zu speichern."),
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
        h4("Die Erfassung Ihrer Lebenslage ist nun abgeschlossen."),
        br(),
        br(),
        h4("Klicken Sie bitte auf 'Weiter' um zur Auswertung Ihrer Angaben zu gelangen.")
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
