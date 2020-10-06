fluidPage(
  theme = "bootstrap.min.css",

  titlePanel(title = div("Vereinbarkeitssimulator", img(src="OST.png", height = 50, style = 'position:absolute; right:50px'))),

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







# library(shinydashboard)
#
# dashboardPage(skin = "blue",
#   dashboardHeader(title = "Vsim V2.0",
#                   titleWidth = 300, disable = FALSE), # set disable = TRUE to disable the header
#                   # tags$li(img(src = 'OST.png', height = "50px"), class = "dropdown")),
#
#   dashboardSidebar(width = 300, collapsed = TRUE,
#                    sidebarMenu(
#                      br(),
#                      img(src="OST.png",width="90%"),
#                      br(), br(), br(), br(), br(),
#                      menuItem(text = "Tab 1", tabName = "dashboard1", icon = icon("th")),
#                      menuItem(text = "Tab 2", tabName =  "dashboard2", icon = icon("th")),
#                      menuItem(text = "Tab 3", tabName =  "dashboard3", icon = icon("dashboard")))
#   ),
#
#   dashboardBody(
#     # see https://stackoverflow.com/questions/52198452/how-to-change-the-background-color-of-the-shiny-dashboard-body
#     tags$head(tags$style(HTML( # logo of main-header/
#                                 ".skin-blue .main-header .logo {
#                                 background-color: #dedede;
#                                 }",
#
#                                 #navbar (rest of the header)
#                                 ".skin-blue .main-header .navbar {
#                                 background-color: #b3b3b3;
#                                 }",
#
#                                 # main sidebar
#                                 ".skin-blue .main-sidebar {
#                                 background-color: #b3b3b3;
#                                 }",
#
#                                 # main sidebar text color  -> doesn't work
#                                 ".skin-blue .main-sidebar .sidebar{
#                                 color: #2dbd54;
#                                 }",
#
#                                 # body
#                                 ".content-wrapper, .right-side {
#                                 background-color: #dedede;
#                                 }",
#
#
#                                 ))),
#
#     tabItems(
#       #First tab content
#       tabItem(tabName = "dashboard1",
#               fluidPage(
#                 theme = "bootstrap.min.css",
#
#                 titlePanel("Vereinbarkeitssimulator"),
#
#                 sidebarLayout(
#                   div(class="hidden-print",
#                       sidebarPanel(style="background-color:#f0f0f0",
#                                    uiOutput("progressbar"), width = 3,
#                                    tags$br(),
#                                    actionButton("prev_button", label = "Zurück"),
#                                    actionButton("next_button", label = "Weiter")
#                       )),
#
#                   mainPanel(
#                     h6(textOutput("save_results")),
#                     uiOutput("mainPanel")
#                   )
#                 )
#               )
#       ),
#
#       #Secound tab content
#       tabItem(tabName = "dashboard2",
#               sliderInput("dummyinput1", h4("Michi's Dummy Input 1"), 3,
#                           min = 1, max = 20, step = 1, width = "90%")
#       ),
#
#
#       tabItem(tabName = "dashboard3",
#               sliderInput("dummyinput2", h4("Michi's Dummy Input 2"), 7,
#                           min = 1, max = 20, step = 1, width = "90%")
#
#       )
#     )
#   )
# )
