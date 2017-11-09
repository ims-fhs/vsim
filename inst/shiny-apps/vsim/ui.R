fluidPage(
  theme = "bootstrap.min.css",
  
  titlePanel("Vereinbarkeitssimulator"),
  
  sidebarLayout(
    div(class="hidden-print",
    sidebarPanel(style="background-color:#ffeeee",
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