fluidPage(
  theme = "bootstrap.min.css",

  titlePanel("Vereinbarkeitssimulator"),

  sidebarLayout(
    div(class="hidden-print",
    sidebarPanel(style="background-color:#f0f0f0",
      uiOutput("progressbar"), width = 3,
      tags$br(),
      actionButton("prev_button", label = "Zurück"),
      actionButton("next_button", label = "Weiter")
    )),

    mainPanel(
      h6(textOutput("save_results")),
      uiOutput("mainPanel")
    )
  )
)
