library(shiny)
library(knitr)
library(dplyr)
library(kableExtra)

# define encoding settings
file_encoding <- getOption("shiny.site.encoding", default = "UTF-8")
# source R scripts
source("R/colors.R", encoding = file_encoding, local = TRUE)
source("R/icons.R", encoding = file_encoding, local = TRUE)
source("R/presentation.R", encoding = file_encoding, local = TRUE)
source("R/rules.R", encoding = file_encoding, local = TRUE)
source("R/sims.R", encoding = file_encoding, local = TRUE)

# read the survey questions
Qlist_1 <- read.csv("data/Qlist_Teil1.csv", sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
Qlist_1[is.na(Qlist_1)] <- ""

Qlist_2b <- read.csv("data/QInputlist_Teil2b.csv", sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
Qlist_2b[is.na(Qlist_2b)] <- ""

Qlist_2c <- read.csv("data/Qlist_Teil2c.csv", sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
Qlist_2c[is.na(Qlist_2c)] <- ""

Glist <- read.csv('data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)
QInputlist_Teil2a <- read.csv('data/QInputlist_Teil2a.csv', sep = ";", stringsAsFactors = FALSE, encoding = file_encoding)

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
  # initialize Qlist_2a with placebo data. Only needed for quesiton-number
  # estimation (question-id's / progressbar tracking; content is irrelevant).
  # But var must be declared on session-level, since data will
  # be polulated with user-input:
  Qlist_2a <- data.frame(1:6)

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
    Survey_Sections <<- list(Teil1_intro = 0,
                            Teil1_first_question = 1,
                            Teil1_last_question = nrow(Qlist_1),
                            Teil1_end_statement = nrow(Qlist_1) + 1,
                            Teil1_summary = nrow(Qlist_1) + 2,
                            Teil2a_intro = nrow(Qlist_1) + 3,
                            Teil2a_first_question = nrow(Qlist_1) + 3 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2a_last_question = nrow(Qlist_1) + nrow(Qlist_2a) + 2 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2a_end_statement = nrow(Qlist_1) + nrow(Qlist_2a) + 3 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2b_intro = nrow(Qlist_1) + nrow(Qlist_2a) + 4 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2b_first_question = nrow(Qlist_1) + nrow(Qlist_2a) + 5 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2b_last_question = nrow(Qlist_1) + nrow(Qlist_2a) + 5 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2b_end_statement = nrow(Qlist_1) + nrow(Qlist_2a) + 6 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2c_intro = nrow(Qlist_1) + nrow(Qlist_2a) + 7 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2c_first_question = nrow(Qlist_1) + nrow(Qlist_2a) + 8 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2c_last_question = nrow(Qlist_1) + nrow(Qlist_2a) + nrow(Qlist_2c) + 7 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil2c_end_statement =  nrow(Qlist_1) + nrow(Qlist_2a) + nrow(Qlist_2c) + 8 + ifelse(nrow(Qlist_2a)>0, 1,0),
                            Teil3_final_evaluation =  nrow(Qlist_1) + nrow(Qlist_2a) + nrow(Qlist_2c) + 9 + ifelse(nrow(Qlist_2a)>0, 1,0))
  }

  Survey_Sections <- calc_survey_question_ids()

  # if previous-button is clicked, decrement question-id and re-render mainpanel / progressbar panel
  observeEvent(input$prev_button, {question_id <<- max(Survey_Sections$Teil1_intro, question_id - 1); renderMainPanel(); renderProgressbar()})
  # if previous-button is clicked, increment question-id and re-render mainpanel / progressbar panel
  observeEvent(input$next_button, {question_id <<- question_id + 1; renderMainPanel(); renderProgressbar()})

  renderMainPanel <- function() {
    if (question_id <= Survey_Sections$Teil1_summary) {
      source("render_main_panel_1.R", encoding = file_encoding, local = TRUE)[1]
    } else if (question_id <= Survey_Sections$Teil2a_end_statement) {
      source("render_main_panel_2a.R", encoding = file_encoding, local = TRUE)[1]
    } else if (question_id <= Survey_Sections$Teil2b_end_statement) {
      source("render_main_panel_2b.R", encoding = file_encoding, local = TRUE)[1]
    } else if (question_id <= Survey_Sections$Teil2c_end_statement) {
      source("render_main_panel_2c.R", encoding = file_encoding, local = TRUE)[1]
    } else {
      source("render_main_panel_3.R", encoding = file_encoding, local = TRUE)[1]
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
        if (question_id <= Survey_Sections$Teil1_summary) {
          shiny_render_navbar_entry(col_lebenslage(), icon_lebenslage,
                                    "Teil 1:", "Lebenslage", question_id,
                                    Survey_Sections$Teil3_final_evaluation)
        } else if (question_id <= Survey_Sections$Teil2a_end_statement) {
          shiny_render_navbar_entry(col_vereinbarung(), icon_vereinbarung,
                                    "Teil 2a:", "Planung 'Vereinbarungen'",
                                    question_id, Survey_Sections$Teil3_final_evaluation)
        } else if (question_id <= Survey_Sections$Teil2b_end_statement) {
          shiny_render_navbar_entry(col_zeitverwendung(), icon_zeitverwendung,
                                    "Teil 2b:", "Planung 'Zeitverwendung'", question_id,
                                    Survey_Sections$Teil3_final_evaluation)
        } else if (question_id <= Survey_Sections$Teil2c_end_statement) {
          shiny_render_navbar_entry(col_unterstuetzung_und_entlastung(), icon_unterstuetzung_und_entlastung,
                                    "Teil 2c:", "Unterstützung & Entlastung",
                                    question_id, Survey_Sections$Teil3_final_evaluation)
        } else {
          shiny_render_navbar_entry(col_plan(), icon_plan,
                                    "Teil 3:", "Auswertung", question_id,
                                    Survey_Sections$Teil3_final_evaluation)
        }
      })
  }

  # render page for the first time
  renderMainPanel()
  renderProgressbar()

}
