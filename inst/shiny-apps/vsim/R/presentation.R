#' determines the selected checkbox-values based on a comma-separated list
#' (caution: current implementation does not allow commas within the texts!
#' if this occurrs, we'd have to implement the function with regex i.e. taking
#' initial capital letters into account). returns a string-array containing the
#' selected options as required by the shiny::checkboxGroupInput.
#'
#' @param selected_options_string a string containing the radio-options text as
#' a comma separated list
#'
#' @return string array containing selected checkboxes
#' @export
#'
#' @examples get_selected_checkbox_values("Aktuell keine Konflikte und Schieflagen, Was soll das denn nützen?")
get_selected_checkbox_values <- function(selected_options_string) {
  retval <- ""
  if (!is.null(selected_options_string) && !is.na(selected_options_string)) {
    selected_options_string <- as.character(selected_options_string)
    retval <- strsplit(selected_options_string, ", ")
    retval <- as.character(unlist(retval))
  }
  return(retval)
}

#' determines the selected radio or select-box value based on the current
#' radio- or selectbox-value and a given default value.
#'
#' @param selected_value
#' @param default_value
#'
#' @return
#' @export
#'
#' @examples get_selected_value("", "weiss nicht")
get_selected_value <- function(selected_value, default_value = "") {
  cond_empty <- is.null(selected_value) || is.na(selected_value) || selected_value == ""
  retval <- ifelse(cond_empty, default_value, selected_value)
  return(retval)
}

#' rmd_display_belastungen_unzufriedenheiten
#' places a kable-table in the rmd-output based on the passed rows of text and
#' in the given color_strain if data are passed in belastungen_oder_unzufriedenheiten.
#' if the belastungen_oder_unzufriedenheiten only contain one String starting with
#' 'Aktuell keine*', the no-data-message is displayed in the color_no_data
#'
#' HINT:
#' the "rmd_"-prefix indicates, that this method is intended to be called from
#' rmd-files (where as "shiny_"-prefixed methods are intended to be called from
#' dynamic r-code generating dynamic shiny-output). the rmd-chunk must be
#' marked with "results='asis'" in order to render correctly!
#'
#' @param belastungen char vector containing the strains
#' @param color_strain the hex background color-code (i.e. '#FFFFFF') for strains
#' @param color_no_data the hex background color-code for messages
#'
rmd_display_belastungen_unzufriedenheiten <- function(belastungen_oder_unzufriedenheiten,
                                                      color_strain,
                                                      color_no_data = "#FFFFFF") {
  bg_color = color_strain
  if (length(belastungen_oder_unzufriedenheiten) == 1 &&
      grepl("Aktuell keine", belastungen_oder_unzufriedenheiten[1])) {
    bg_color <- color_no_data
  }
  font_color <- "#000000"

  if (color_strain != "") {
    kable(as.data.frame(belastungen_oder_unzufriedenheiten),row.names = FALSE, col.names = "",  format = "html")%>%
      kable_styling(bootstrap_options = c("striped", "hover"), full_width = F, position = "left") %>%
      row_spec(1:length(belastungen_oder_unzufriedenheiten), background = bg_color, color = font_color)
  } else {
    kable(as.data.frame(belastungen_oder_unzufriedenheiten),row.names = FALSE, col.names = "",  format = "html")%>%
      kable_styling(bootstrap_options = c("striped", "hover"), full_width = F, position = "left")
  }
}



#' New version to display table of all gaps
#'
#' Create a table with three columns. 1. = gaptype (Lebensbereich - UND-Blume)
#' 2. = score (Zufriedenheit), 3. = gaps (Baustellen)
#'
#' @param gaps A character vector with an attribute "score" in [0,1]
#' @param gaptype A character
#' @param color_strain
#' @param color_no_data

#'
#' @return
#' @export
#'
#' @examples
#' gaps <- structure(c("Unzufriedenheit mit der beruflichen Zeitverwendung",
#' "Unzufriedenheiten: Mangelnde Wertschätzung", "Belastung: Hoher Zeitdruck bei der Arbeit",
#' "Belastung: Eigene Erwartungen an Hausarbeit/Betreuung von Angehörigen nicht erfüllen können ",
#' "Belastung: Keine klar festgelegeten Arbeitszeiten (Flexibilisierung)",
#' "Belastung: Organisierung des Alltags kompliziert"), score = 0.571428571428571)
#'
#' rmd_display_belastungen_unzufriedenheiten_2(gaps, "Beruf")
rmd_display_belastungen_unzufriedenheiten_2 <- function(gaps, gaptype,
                                                        color_no_data = "#FFFFFF") {
  font_color <- "#000000"
  my_colors <- get_color_ramp() # 1 = red / 50 = green
  bg_color <- my_colors[round(1 + 49*attr(gaps, "score"))] # We map the score [0,1] to the color indexes [1,50]
  if (length(gaps) == 0) {
    gaps <- structure(c("Aktuell keine Belastung o. Unzufriedenheit"), score = 1)
    bg_color <- color_no_data
  }

  # create the table to plot
  n_gaps <- length(gaps); my_score <- attr(gaps, "score")
  lebensbereich <- c(gaptype, rep("", n_gaps - 1))
  # 0 - 0.33 -> Belastung "hoch" / 0.33 - 0.66 -> Belastung "mittel" / 0.66 - 1 -> Belastung "tief"
  zufriedenheit <- ifelse(my_score > 0.33, ifelse(my_score > 0.66, "tief", "mittel"), no = "hoch")
  zufriedenheit <- c(zufriedenheit, rep("", n_gaps -1))
  df <- data.frame(lebensbereich = lebensbereich,
                   zufriedenheit = zufriedenheit,
                   baustellen = gaps)

  kable(df, row.names = FALSE, format = "html",
        col.names = c("Lebensbereich", "Unzufriedenheit/Belastung", "Baustellen")) %>%
    kable_styling(bootstrap_options = c("striped", "hover"), full_width = T, position = "left") %>%
    row_spec(1:n_gaps, background = bg_color, color = font_color)

}



#' rmd_display_vereinbarungen_chancen
#' renders the vereinbarungen table based on the alist_2a provided
#'
#' HINT:
#' the "rmd_"-prefix indicates, that this method is intended to be called from
#' rmd-files (where as "shiny_"-prefixed methods are intended to be called from
#' dynamic r-code generating dynamic shiny-output). the rmd-chunk must be
#' marked with "results='asis'" in order to render correctly!
#'
#' @param alist_2a the Alist containing the Questions and the user's Answers
#' from part 2a
#' @param qlist the Qlist conaining
#' @param bol_vorgesetzter
#'
#' @examples rmd_display_vereinbarungen_chancen(test_vereinbarungen_chancen_alist_2a)
rmd_display_vereinbarungen_chancen <- function(alist_2a, qlist,
                                               bol_vorgesetzter = TRUE) {
  fragen <- rule_extract_vereinbarungen_fragen(alist_2a, qlist, "Frage")
  vereinbarungen <- rule_extract_vereinbarungen_fragen(alist_2a, qlist, "Massnahme")
  kommentare <- rule_extract_vereinbarungen_kommentare(alist_2a)
  # subset for boss/relatives
  if (bol_vorgesetzter) {
    ids <- which(grepl("Ihrem/Ihrer Vorgesetzten", fragen))
  } else {
    ids <- which(grepl("Ihren Angeh.+rigen", fragen))
  }
  fragen <- fragen[ids]
  vereinbarungen <- vereinbarungen[ids]
  kommentare <- kommentare[ids]

  assertthat::are_equal(length(vereinbarungen), length(kommentare))
  html <- paste0("<table cellpadding='10' cellspacing='10' width='100%'>",
                 "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC; background: #CCCCCC;' >",
                 "<th width='40%'><b>Geplante Vereinbarung</b></th>",
                 "<th width='*'><b>Bestehende Unzufriedenheit</b></th><th><b>Anmerkungen&nbsp;&nbsp;</b></th></tr>")
  if (length(vereinbarungen) > 0) {
    for (i in 1:length(vereinbarungen)) {
      vereinbarung <- vereinbarungen[i]
      kommentar <- kommentare[i]
      html <- paste0(html, "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td>",
                     "<div style='border-radius: 15px;background: ",
                     col_vereinbarung(),
                     ";padding: 12px; width: 400px; align: center; ",
                     "border: 2px solid #FFFFFF;'>",
                     vereinbarung, "</div></td><td>")
      chancen_belastungen <- rule_extract_chancen_per_vereinbarung(fragen[i], alist_2a)
      if (length(chancen_belastungen) > 0) {
        for (j in 1:length(chancen_belastungen)) {
          chance <- chancen_belastungen[j]
          html <- paste0(html, "&nbsp;<div style='border-radius: 15px;background: ",
                         col_belastung(),
                         ";padding: 12px; width: 200px; align: center;",
                         " float: left;border: 2px solid #FFFFFF;'>",
                         chance, "</div>&nbsp;")
        }
      }
      # Add comment, if available
      html <- paste0(html, "<td style='background: ",col_evaluation_comment(),"'>",kommentar , "</td>")
      html <- paste0(html, "</td></tr>")
    }
  } else {
      html <- paste0(html, "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td colspan='3'> Keine Vereinbarungen geplant.</td></tr>")
  }
  html <- paste0(html, "</table>")
  return(html)
}

#' rmd_display_zeitverwendung: renders the zeitverwendung table based
#' on the alist_2b provided
#'
#' HINT:
#' the "rmd_"-prefix indicates, that this method is intended to be called from
#' rmd-files (where as "shiny_"-prefixed methods are intended to be called from
#' dynamic r-code generating dynamic shiny-output). the rmd-chunk must be
#' marked with "results='asis'" in order to render correctly!
#'
#' @param alist_2b the Alist containing the Questions and the user's Answers
#' from part 2a
#'
#' @examples rmd_display_zeitverwendung
rmd_display_zeitverwendung <- function(alist_2b) {
  assertthat::assert_that(all(c("Zeit für was", "Bedürfnis") %in% names(alist_2b)))

  html <- paste0("<table cellpadding='10' cellspacing='10' width='100%'>",
                 "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC; background: #CCCCCC;' >",
                 "<th><b>Zeit für was</b></th>",
                 "<th><b>Bedürfnis</b></th><th><b>Ihre relevanten Belastungen und Unzufriedenheiten</b></th>",
                 "<th><b>Anmerkungen</b></th></tr>")
  if (nrow(alist_2b) > 0) {
    for (i in 1:nrow(alist_2b)) {
      zeitfuerwas <- alist_2b[i, 1]
      beduerfnis <- alist_2b[i, 2]
      kommentar <- alist_2b[i, 3]
      belunz <- alist_2b[i, 4]
      belunz <- gsub("Belastung: ", "", belunz)
      html <- paste0(html, "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td>",
                     "<div style='border-radius: 15px;background: ",
                     col_zeitverwendung(),
                     ";padding: 12px; width: 200px; align: center; ",
                     "border: 2px solid #FFFFFF;'>",
                     zeitfuerwas, "</div></td><td>")
      html <- paste0(html, "<div style='border-radius: 15px;background: ",
                     col_zeitverwendung(),
                     ";padding: 12px; width: 200px; align: center; ",
                     "border: 2px solid #FFFFFF;'>",
                     beduerfnis, "</div></td><td>")
      html <- ifelse (belunz != "-",
                     paste0(html, "<div style='border-radius: 15px;background: ",
                     col_belastung(),
                     ";padding: 12px; width: 200px; align: center; ",
                     "border: 2px solid #FFFFFF;'>",
                     belunz, "</div></td><td style='background: ", col_evaluation_comment(),"'>"),
                     paste0(html, "&nbsp;</td><td style='background: ", col_evaluation_comment(),"'>"))
      html <- paste0(html, kommentar, "</td>")
      html <- paste0(html, "</td></tr>")
    }
  } else {
      html <- paste0(html, "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td colspan='4'> Keine Anpassung der Zeitverwendung geplant.</td></tr>")
  }
  html <- paste0(html, "</table>")
  cat(html)
}

#' rmd_display_zeitverwendung: renders the zeitverwendung table based
#' on the alist_2b provided
#'
#' HINT:
#' the "rmd_"-prefix indicates, that this method is intended to be called from
#' rmd-files (where as "shiny_"-prefixed methods are intended to be called from
#' dynamic r-code generating dynamic shiny-output). the rmd-chunk must be
#' marked with "results='asis'" in order to render correctly!
#'
#' @param alist_2c the Alist containing the Questions and the user's Answers
#' from part 2c
#'
#' @examples rmd_display_unterstuetzung_entlastung
rmd_display_unterstuetzung_entlastung <- function(alist_2c) {
  assertthat::assert_that(all(c("Handlungsfeld", "Geplante Strategie") %in% names(alist_2c)))
  html <- paste0("<table cellpadding='10' cellspacing='10' width='100%'>",
                 "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC; background: #CCCCCC;' >",
                 "<th><b>Handlungsfeld</b></th>",
                 "<th><b>Geplante Strategie</b></th>",
                 "<th><b>Anmerkungen</b></th></tr>")

  if (nrow(alist_2c) > 0) {
    for (i in 1:nrow(alist_2c)) {
      frage <- alist_2c[i, 1]
      antwort <- alist_2c[i, 2]
      kommentar <- alist_2c[i, 3]
      html <- paste0(html, "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td>",
                     "<div style='border-radius: 15px;background: ",
                     col_evaluation_comment(),
                     ";padding: 12px; width: 500px; align: center; ",
                     "border: 2px solid #FFFFFF;'>",
                     unquestion(frage, "Möchten Sie"), "</div></td><td>")
      html <- paste0(html, "<div style='border-radius: 15px;background: ",
                     col_unterstuetzung_und_entlastung(),
                     ";padding: 12px; width: 300px; align: center; ",
                     "border: 2px solid #FFFFFF;'>",
                     unanswer(antwort), "</div></td><td style='background: ", col_evaluation_comment(),"'>")
      html <- paste0(html, kommentar, "</td>")
      html <- paste0(html, "</td></tr>")
    }
  } else {
      html <- paste0(html, "<tr style='border-bottom:2px solid #CCCCCC; border-top:2px solid #CCCCCC;'><td colspan='3'> Keine Unterstützungs- und/oder Entlastungsmassnahmen geplant.</td></tr>")
  }
  html <- paste0(html, "</table>")
  cat(html)
}


#' unquestion
#' transfer a question into a statement by removing the prefix and starting the
#' leftover with initcap, and replacing the questionmark by a period.
#'
#' @param question
#' @param prefix
#'
#' @return the leftover Statement
#' @export
#'
#' @examples unquestion("Möchten Sie einen Hund kaufen?", "Möchten Sie")
unquestion <- function(question, prefix) {
  stmt <- question
  if (startsWith(question, prefix)) {
    stmt <- gsub(pattern = paste0(prefix, " *"), replacement = "", question)
    # make initcap
    stmt <- paste0(toupper(substr(x = stmt, 1, 1)), substr(x = stmt, 2, nchar(stmt)-1), ".")
  }
  return (stmt)
}

#' unanswer
#' transfers an answer into a statement by removing the prefix and starting the
#' leftover with initcap.
#'
#' @param answer
#'
#' @return the leftover Statement
#' @export
#'
#' @examples unanswer("Ja, ich möchte die Kinder mehr selbst betreuen als bisher")
unanswer <- function(answer) {
  stmt <- answer
  if (startsWith(answer, "Ja, ")) {
    stmt <- gsub(pattern = "Ja, ", replacement = "", answer)
    # make initcap
    stmt <- paste0(toupper(substr(x = stmt, 1, 1)), substr(x = stmt, 2, nchar(stmt)))
  }
  return (stmt)
}

#' places an icon in shiny-rendered dynamic output based on the passed icon-name.
#' HINT: call this function within shiny-render-functions to add dynamic html-
#' content (don't call this function from within an rmd-file).
#'
#' @param icon the icon's filename to be displayed
#' @param width the icon's rendered width
#' @param height the icon's rendered height
#'
#' @return the shiny image-object
shiny_display_icon <- function(icon, width = "100%", height = "100%") {
  retval <- shiny::img(src = icon, width = width, height = height)
  return(retval)
}

#' adds some HTML source code to the enclosing rmd representing the image based
#' on the passed icon-name.
#' HINT: call this function within an rmd to add dynamic html-
#' content (don't call this function from within shiny-render-functions).
#' the rmd-chunk must be marked with "results='asis'" in order to render
#' correctly!
#'
#' @param icon the icon's filename to be displayed
#' @param align the allign param (one of 'center', 'left' or 'right')
#' @param width the icon's rendered width
#' @param height the icon's rendered height
#' @param bgcolor the hex-background-color (i.e. '#ffffff)
#'
#' @example rmd_display_icon(icon_belastung, "right")
rmd_display_icon <- function(icon, align = stop(c("center", "left", "right")),
                             width = "100%", height = "100%",
                             bgcolor = "#ffffff", tooltip = "") {
  html <- paste0("<div title='",tooltip,"' style='background-color:", bgcolor,
                   "; align: ", align,
                   "; float: left; border: 2px solid #FFFFFF; border-radius: 15px;display:table-cell; vertical-align:middle; text-align:center '><img src='",
                   icon, "' width='", width, "' height='", height,"' title='",
                   tooltip,"'></div>")
  cat(html)
}

#' render a navbarentry and return the according shiny::tagList.
#'
#' @param background_color the navbar's background color
#' @param icon_name the icon to be shown
#' @param title_main the main title
#' @param title_sub the subtitle
#' @param question_id the current question_id (needed for progressbar indicator)
#' @param last_id the id of the last 'question' / 'screen' to be shown
#'
#' @return the tagList
shiny_render_navbar_entry <- function(background_color, icon_name, title_main, title_sub,
                                      question_id, last_id) {
  retval <- tagList(
                div(style=paste0("background-color:", background_color),
                br(),
                div(align="center",
                img(src=icon_name, width="50%")),
                h4(title_main),
                h4(title_sub),
                br(),
                h5("Fortschritt"),
                tags$div(HTML(
                  paste0("<progress value=", question_id * 2, " max='", last_id * 2
                         ,"' ></progress>")
                ))))
  return (retval)
}

rmd_display_weniger_ea <- function(alist_2b, relevant_gaps) {
  assertthat::assert_that(all(c("Zeit für was", "Bedürfnis") %in% names(alist_2b)))
  if (nrow(alist_2b) > 0) {
    if (alist_2b[1, 4] == "-") {
      grund <- "mehr Freiraum für andere Tätigkeiten zu schaffen."
    } else {
      grund <- paste0("der ", alist_2b[1, 4],
                 " entgegen zu wirken.")
    }

    # if (grepl("weniger", alist_2b[1, 2])) {
    #   cat(paste0("<center><table width='100%'><tr><td width='20%' align='center'><img src='",
    #              icon_achtung,"', width = '40px', height = '40px' >",
    #              "</td><td>Die für Erwerbsarbeit aufgewendete Zeit soll reduziert werden, um ",
    #              grund,
    #              "</td></tr></table></center>"))
    # }
  }
}
