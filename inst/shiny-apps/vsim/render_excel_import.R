
output$mainPanel <- renderUI({
  fluidPage(
    fluidRow(actionButton("start_from_beginning", label = "Von vorne durchklicken")),
    br(),
    fluidRow(actionButton("use_default_excel", label = "Vorgefertigtes Excel verwenden -> Zwischenauswertung")),
    br(),
    fluidRow(fileInput('file1', '.xlsx upload : -> Zwischenauswertung',accept = c(".xlsx")))
    )


  })

