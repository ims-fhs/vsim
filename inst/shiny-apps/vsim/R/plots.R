#' plot a "mean" for Belastung & Unzufriedenheit per category (Arbeit, Haushalt &
#' Selbstsorge, Soziales Umfeld)
#'
#' @param QAGlist A data.frame, containing columns "Gap1_type", "Answer_given" and "Indikator1"
#' @param by a character, either Arbeit, Haushalt & Selbstsorge or Soziales Umfeld
#'
#' @return
#'
#' @examples
#' \dontrun{
#' old_wd <- getwd()
#' setwd(paste0(getwd(),"/inst/shiny-apps/vsim/"))
#' tc_arbeit <- import_from_excel(path = "data/outputs/Testcase_Arbeit.xlsx", give_me = "QAG1")
#' plot_summary_teil_1(tc_arbeit, by = "Arbeit")
#' setwd(old_wd)
#' }
plot_summary_teil_1 <- function(QAGlist, by = c("Arbeit", "Haushalt & Selbstsorge",
                                                "Soziales Umfeld")) {
  # browser()
  assertthat::assert_that(length(by) == 1)
  assertthat::assert_that(by %in% c("Arbeit", "Haushalt & Selbstsorge", "Soziales Umfeld"))
  # Only look at relevant rows for Arbeit, Haushalt & Selbstsorge and Soziales Umfeld
  relevant_rows <- grepl(by, QAGlist$Gap1_type)
  df <- QAGlist[relevant_rows,]
  # Find out where the given answer matches the indicator and calculate a percentage score
  cond_match <- apply(df, 1, function(x) {grepl(x["Answer_given"], x["Indikator1"])})
  score <- sum(cond_match)/nrow(df)

  # plot the grafic
  par(mar = c(3,4,4,2) + 0.1)
  x <- seq(0,1,length.out = 50);
  color <- colorRampPalette(c("green4","grey80", "red"))(50)
  plot(x, rep(1, length(x)), cex = 1.5, pch=15, col=color, ylim= c(0.65,1.15),
       main = paste(by, ": Belastungen & Unzufriedenheiten"), cex.main = 1.3,
       xlab = "",  ylab = "", yaxt="n", xaxt = "n")
  text(x = c(0, 1), y = 0.75, labels = c("Tief", "Hoch"), cex = 1.3)
  points(x = score, y = 1, pch = 13, cex = 5, lwd = 2)
  # arrows(x0 = score, y0 = 1.25, x1 = score, y1 = 1.1, lwd = 2)

}


# # ------------------------------------------------------------------------------
#
# # Import Testcases
# source("inst/shiny-apps/vsim/R/import.R", encoding = "UTF-8", local = TRUE)
# path <- "inst/shiny-apps/vsim/data/outputs/"
# tc_arbeit <- import_from_excel(paste0(path,"Testcase_Arbeit.xlsx"), give_me = "QAG1")
# tc_haushalt_selbstsorge <- import_from_excel(paste0(path,"Testcase_Haushalt_Selbstsorge.xlsx"), give_me = "QAG1")
# tc_random <- import_from_excel(paste0(path,"Testcase_Random.xlsx"), give_me = "QAG1")
# tc_soziales_umfeld <- import_from_excel(paste0(path,"Testcase_Soziales_Umfeld.xlsx"), give_me = "QAG1")
#
# par(mfrow = c(3,1))
#
# # Testcase Arbeit
# # --> (the way i filled-in the questionnary "Arbeit" should have high values)
# plot_summary_teil_1(tc_arbeit, by = "Arbeit")
# plot_summary_teil_1(tc_arbeit, by = "Haushalt & Selbstsorge")
# plot_summary_teil_1(tc_arbeit, by = "Soziales Umfeld")
#
# # Testcase Haushalt & Selbstsorge
# # --> (the way i filled-in the questionnary "Haushalt & Selbstsorge" should have high values)
# plot_summary_teil_1(tc_haushalt_selbstsorge, by = "Arbeit")
# plot_summary_teil_1(tc_haushalt_selbstsorge, by = "Haushalt & Selbstsorge")
# plot_summary_teil_1(tc_haushalt_selbstsorge, by = "Soziales Umfeld")
#
# # Testcase Soziales Umfeld
# # --> (the way i filled-in the questionnary "Soziales Umfeld" should have high values)
# plot_summary_teil_1(tc_soziales_umfeld, by = "Arbeit")
# plot_summary_teil_1(tc_soziales_umfeld, by = "Haushalt & Selbstsorge")
# plot_summary_teil_1(tc_soziales_umfeld, by = "Soziales Umfeld")
#
# # Testcase random
# plot_summary_teil_1(tc_random, by = "Arbeit")
# plot_summary_teil_1(tc_random, by = "Haushalt & Selbstsorge")
# plot_summary_teil_1(tc_random, by = "Soziales Umfeld")
