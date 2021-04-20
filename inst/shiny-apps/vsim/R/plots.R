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
#' tc_arbeit <- import_from_excel(path = "data/outputs/Testcase_aeltere_Arbeitnehmer_Arbeit.xlsx", give_me = "QAG1")
#' plot_summary_teil_1(tc_arbeit, by = "Arbeit")
#' setwd(old_wd)
#' }
plot_summary_teil_1 <- function(QAGlist, by = c("Ich", "Soz.Bez.", "Haushalt", "Beruf", "Gemeinwohl")) {
  # browser()
  assertthat::assert_that(all(by == c("Ich", "Soz.Bez.", "Haushalt", "Beruf", "Gemeinwohl")))

  # plot the basic grafic
  par(mar = c(3,4,4,2) + 0.1) # default = c(5, 4, 4, 2) + 0.1.
  x <- seq(0,1,length.out = 50);
  color <- colorRampPalette(c("green4","gold", "red"))(50)

  plot(x, rep(1.5, length(x)), cex = 1.5, pch=15, col=color, main = "Belastungen und Unzufriedenheiten pro Lebensinhalt",
       cex.main = 1.3,
       xlab = "",  ylab = "", yaxt="n", xaxt = "n",
       xlim = c(-0.2,1), ylim= c(0.5,6))
  points(rep(x,4), rep(seq(2,5)+0.5, each = length(x)), cex = 1.5, pch=15, col=color)
  abline(v = -0.02, h = seq(1,6))

  text(x = c(0.1, 0.9), y = 0.65, labels = c("Tief", "Hoch"), cex = 1.3)
  text(x = rep(-0.12, 5), y = 0.5 + seq(1,5), labels = rev(by), cex = 1.2)

  for (i in seq(1,5)) {
    # Only look at relevant rows for Arbeit, Haushalt & Selbstsorge and Soziales Umfeld
    relevant_rows <- grepl(by[i], QAGlist$Gap1_type)
    df <- QAGlist[relevant_rows,]
    # Find out where the given answer matches the indicator and calculate a percentage score
    cond_match <- apply(df, 1, function(x) {grepl(x["Answer_given"], x["Indikator1"])})
    score <- sum(cond_match)/nrow(df)

    points(x = score, y = 6.5-i, pch = 13, cex = 5, lwd = 2)
    # arrows(x0 = score, y0 = 1.25, x1 = score, y1 = 1.1, lwd = 2)
  }
}


# # ------------------------------------------------------------------------------
#
# # Import Testcases
# source("inst/shiny-apps/vsim/R/import.R", encoding = "UTF-8", local = TRUE)
# path <- "inst/shiny-apps/vsim/data/outputs/"
# tc_random_UND <- import_from_excel(paste0(path,"Testcase_aeltere_Arbeitnehmer_Random_UND.xlsx"), give_me = "QAG1")
#
# # Testcase Random
# # --> (the questionarry was filled randomly)
# plot_summary_teil_1(tc_random_UND)
