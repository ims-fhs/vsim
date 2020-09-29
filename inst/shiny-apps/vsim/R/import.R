#' import questionnary data from given exel
#'
#' @param path a character, path to excel file
#' @param give_me a character, in c("Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c")
#'
#' @return A data.frame
#'
#' @examples
#' \dontrun {
#' setwd(paste0(getwd(),"/inst/shiny-apps/vsim/"))
#' Q1 <- import_from_excel(path = "data/vsim_question_lists.xlsx", give_me = "Q1")
#' A1 <- import_from_excel(give_me = "A1")
#' G1 <- import_from_excel(give_me = "G1")
#' QAG1 <- import_from_excel(give_me = "QAG1")
#' Gtype <- import_from_excel(give_me = "Gtype")
#' Q2a <- import_from_excel(give_me = "Q2a")
#' Q2b <- import_from_excel(give_me = "Q2b")
#' Q2c <- import_from_excel(give_me = "Q2c")}
import_from_excel <- function(path = "data/vsim_question_lists.xlsx",
                              give_me = c("QAG1", "Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c")) {
  assertthat::assert_that(is.character(give_me))
  assertthat::assert_that(length(give_me) == 1)
  assertthat::assert_that(give_me %in% c("QAG1", "Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c"))
  # lookup to match give_me argument to excel-sheets.
  lookup <- data.frame(name = c("QAG1", "Q1", "A1", "G1", "Gtype", "Q2a", "Q2b", "Q2c"),
                       sheet = c("QAGlist_Teil1", "QAGlist_Teil1", "QAGlist_Teil1", "QAGlist_Teil1",
                                 "QAGlist_Teil1", "Qlist_Teil2a", "Qlist_Teil2b", "Qlist_Teil2c"),
                       stringsAsFactors = FALSE)

  df <- as.data.frame(readxl::read_xlsx(path = path, sheet = lookup$sheet[lookup$name == give_me]),
                      stringsAsFactors = FALSE)
  df[is.na(df)] <- ""

  if(give_me == "Q1") {df <- df[ c(1:7)]}
  if(give_me == "A1") {df <- df[ c(1,2,8)]}
  if(give_me == "G1") {df <- df[ c(1,2,9:12)]}
  if(give_me == "Gtype") {df <- df[ c(9,13)]
    # Check all unique elements -> comma-separation (without space) is allowed for df$Gap1_type
    types_unique <- unique(unlist(strsplit(x = unique(df$Gap1_type), split = ",")))
    if (!all(types_unique %in% c("Arbeit", "Haushalt & Selbstsorge","Soziales Umfeld"))) {
      stop("Not all entries in column 'Gap1_type' in QAGlist_Teil1 are allowed.
  We only allow four (comma-separated) entries ('Arbeit', 'Haushalt & Selbstsorge','Soziales Umfeld')")
    }
  }
  return(df)
}



#' Export answers into excel as complete QAG1-List.
#'
#' this function is used in See render_main_panel_1.R -> questionaryPostProcessing
#'
#' @param Alist_Answer a data.frame, the answer-list after
#' @param path a character
export_to_excel <- function(Alist_Answer, path = "data/outputs/") {
  # standard path is set to "data/outputs/" because the function is called from within render_main_panel_1.R
  empty_list <- import_from_excel(path = "data/vsim_question_lists.xlsx", give_me = "QAG1")
  empty_list$Answer_given <- Alist_Answer
  path_to_file <- paste0(path, format(Sys.time(), "%Y_%m_%d"),"_Answer_list_",
                         format(Sys.time(), "%H_%M_%S"),".xlsx")

  xlsx::write.xlsx(x = empty_list, file =  path_to_file, sheetName = "QAGlist_Teil1",
                   row.names = FALSE)
}
