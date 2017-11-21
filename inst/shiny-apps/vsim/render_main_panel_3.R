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
  if (question_id >= Survey_Sections$Teil3_final_evaluation) {
    a <- inclRmd("rmds/auswertung3.rmdy")
    output$mainPanel <- renderUI(HTML(a))
    questionaryPostProcessing();
  }
})
