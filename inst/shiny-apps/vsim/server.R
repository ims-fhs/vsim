library(shiny)
library(knitr)
library(dplyr)
library(kableExtra)

# define encoding settings
file_encoding <- getOption("shiny.site.encoding", default = "UTF-8")

# read the survey questions
Qlist_1 <- read.csv("data/Qlist_Teil1.csv", sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
Qlist_1[is.na(Qlist_1)] <- ""

Qlist_2b <- read.csv("data/Qinputlist_Teil2b.csv", sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
Qlist_2b[is.na(Qlist_2b)] <- ""

Qlist_2c <- read.csv("data/Qlist_Teil2c.csv", sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
Qlist_2c[is.na(Qlist_2c)] <- ""

choices <- c(
  "viel weniger als bisher",
  "weniger als bisher",
  "gleich viel wie bisher",
  "mehr als bisher",
  "viel mehr als bisher"
)

# hier weiter: analyse, wieso bei part 2a bei ein paar negativen antworten bei
# part 1 nicht immer alle fragen kommen / mechano zum bestimmen der frage-
# indexes korrigieren / anpassen

function(input, output, session) {
  # declare Session Variables
  # part 1: declaration and initialization
  # collection to collect the different overall-survey results
  result_coll <- list()
  # Create an empty vector to hold survey results
  results <- rep("", nrow(Qlist_1))
  # Name each element of the vector based on the
  # second column of the Qlist_1
  names(results)  <- Qlist_1[,2]
  # initialize Qlist_2a with initial (unreal) data. Only needed for realistic
  # quesiton-number estimation (question-id's / progressbar tracking; content
  # is irrelevant). But var must be declared on session-level, since data will
  # be replaced with user-input:
  Qlist_2a <- read.csv("data/Qlist_Teil2a.csv", sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
  Qlist_2a[is.na(Qlist_2a)] <- ""

  # part 2..n: declaration
  relevant_gaps <- NULL
  results2 <- NULL
  kommentare2 <- NULL
  results2b <- NULL
  kommentare2b <- NULL
  results2c <- NULL
  kommentare2c <- NULL

  # initialize question_id
  question_id <- 0

  # prepare section-variables for question-id's
  calc_survey_question_ids <- function() {
    Survey_Sections <- list(Teil1_intro = 0,
                            Teil1_first_question = 1,
                            Teil1_last_question = nrow(Qlist_1),
                            Teil1_end_statement = nrow(Qlist_1) + 1,
                            Teil1_summary = nrow(Qlist_1) + 2,
                            Teil2a_intro = nrow(Qlist_1) + 3,
                            Teil2a_first_question = nrow(Qlist_1) + 4,
                            Teil2a_last_question = nrow(Qlist_1) + nrow(Qlist_2a) + 3,
                            Teil2a_end_statement = nrow(Qlist_1) + nrow(Qlist_2a) + 4,
                            Teil2b_intro = nrow(Qlist_1) + nrow(Qlist_2a) + 5,
                            Teil2b_first_question = nrow(Qlist_1) + nrow(Qlist_2a) + 6,
                            Teil2b_last_question = nrow(Qlist_1) + nrow(Qlist_2a) + 6,
                            Teil2b_end_statement = nrow(Qlist_1) + nrow(Qlist_2a) + 7,
                            Teil2c_intro = nrow(Qlist_1) + nrow(Qlist_2a) + 8,
                            Teil2c_first_question = nrow(Qlist_1) + nrow(Qlist_2a) + 9,
                            Teil2c_last_question = nrow(Qlist_1) + nrow(Qlist_2a) + nrow(Qlist_2c) + 8,
                            Teil2c_end_statement =  nrow(Qlist_1) + nrow(Qlist_2a) + nrow(Qlist_2c) + 9,
                            Teil3_final_evaluation =  nrow(Qlist_1) + nrow(Qlist_2a) + nrow(Qlist_2c) + 10)
  }

  Survey_Sections <- calc_survey_question_ids()

  # if previous-button is clicked, decrement question-id and re-render mainpanel / progressbar panel
  observeEvent(input$prev_button, {question_id <<- max(Survey_Sections$Teil1_intro, question_id - 1); renderMainPanel(); renderProgressbar()})
  # if previous-button is clicked, increment question-id and re-render mainpanel / progressbar panel
  observeEvent(input$next_button, {question_id <<- question_id + 1; renderMainPanel(); renderProgressbar()})

  # TODO:
  # beim zurück clicken müssten die result-arrays wieder initialisiert werden
  # anhand der overall arrays, falls fragebogen-grenzen überschritten werden (sollen)

  renderMainPanel <- function() {
    if (question_id <= Survey_Sections$Teil1_summary) {
      source("render_main_panel_1.R", encoding = file_encoding, local = TRUE)[1]
    } else if (question_id <= Survey_Sections$Teil2a_end_statement) {
      source("render_main_panel_2a.R", encoding = file_encoding, local = TRUE)[1]
    } else if (question_id <= Survey_Sections$Teil2b_end_statement) {
      source("render_main_panel_2b.R", encoding = file_encoding, local = TRUE)[1]
    } else if (question_id <= Survey_Sections$Teil2c_end_statement) {
      source("render_main_panel_2c.R", encoding = file_encoding, local = TRUE)[1]
    } else if (question_id <= Survey_Sections$Teil3_final_evaluation) {
      source("render_main_panel_3.R", encoding = file_encoding, local = TRUE)[1]
    } else {
      stopApp()
    }
  }

  # Source by Vincent Nijs: https://github.com/vnijs/shiny-site/blob/master/global.R
  # render RMD
  inclRmd <- function(path, r_env = parent.frame()) {
    paste(
      readLines(path, warn = FALSE, encoding = file_encoding),
      collapse = '\n'
    ) %>%
    knitr::knit2html(
      text = .,
      fragment.only = TRUE,
      envir = r_env,
      options = "",
      stylesheet = "",
      encoding = file_encoding,
      quiet = TRUE
    ) %>%
    gsub("&lt;!--/html_preserve--&gt;","",.) %>%  ## knitr adds this
    gsub("&lt;!--html_preserve--&gt;","",.) %>%   ## knitr adds this
    HTML
  }

  renderProgressbar <- function() {
      output$progressbar <- renderUI({
        if (question_id <= Survey_Sections$Teil1_end_statement) {
            tagList(
                img(src="icon_lebenslage.png", width="50%"),
                h4("Teil 1:"),
                h4("Lebenslage"),
                br(),
                h5("Fortschritt"),
                tags$div(HTML(
                  paste0("<progress value=", question_id * 2, " max='100' ></progress>")
                )))
        } else if (question_id <= Survey_Sections$Teil1_summary) {
            tagList(
                img(src="icon_lebenslage_auswertung.png", width="50%"),
                h4("Teil 1:"),
                h4("Lebenslage"),
                br(),
                h5("Fortschritt"),
                tags$div(HTML(
                  paste0("<progress value=", question_id * 2, " max='100' ></progress>")
                )))
        } else if (question_id <= Survey_Sections$Teil2a_end_statement) {
          tagList(
                img(src="icon_vereinbarung.png", width="50%"),
                h4("Teil 2a:"),
                h4("Vereinbarkeits-Tätigkeiten"),
                br(),
                h5("Fortschritt"),
                tags$div(HTML(
                  paste0("<progress value=", question_id * 2, " max='100' ></progress>")
                )))
        } else if (question_id <= Survey_Sections$Teil2b_end_statement) {
          tagList(
                img(src="icon_zeitverwendung.png", width="50%"),
                h4("Teil 2b:"),
                h4("Anpassung Zeitverwendung"),
                br(),
                h5("Fortschritt"),
                tags$div(HTML(
                  paste0("<progress value=", question_id * 2, " max='100' ></progress>")
                )))
        } else if (question_id <= Survey_Sections$Teil2c_end_statement) {
          tagList(
                img(src="icon_unterstuetzung_und_entlastung.png", width="50%"),
                h4("Teil 2c:"),
                h4("Ressourcen & Entlastung"),
                br(),
                h5("Fortschritt"),
                tags$div(HTML(
                  paste0("<progress value=", question_id * 2, " max='100' ></progress>")
                )))
        } else {
          tagList(
                img(src="icon_plan.png", width="50%"),
                h4("Teil 3:"),
                h4("Auswertung"),
                br(),
                h5("Fortschritt"),
                tags$div(HTML(
                  paste0("<progress value=", question_id * 2, " max='100' ></progress>")
                )))
        }
      })
  }

  # render page for the first time
  renderMainPanel()
  renderProgressbar()

}
