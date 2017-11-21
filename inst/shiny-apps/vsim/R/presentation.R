#' places a kable-table in the rmd-output based on the passed rows of text and
#' in the given color.
#'
#' HINT:
#' the "rmd_"-prefix indicates, that this method is intended to be called from
#' rmd-files (where as "shiny_"-prefixed methods are intended to be called from
#' dynamic r-code generating dynamic shiny-output). the rmd-chunk must be
#' marked with "results='asis'" in order to render correctly!
#'
#' @param rows the textrows (character) to be displayed
#' @param color the hex-color-code to color the table-lines
#'
rmd_display_table <- function(rows, color = "") {
  if (color != "") {
    kable(as.data.frame(rows),row.names = FALSE, col.names = "",  format = "html")%>%
      kable_styling(bootstrap_options = c("striped", "hover")) %>%
      row_spec(1:length(rows), background = color, color = "white")
  } else {
    kable(as.data.frame(rows),row.names = FALSE, col.names = "",  format = "html")%>%
      kable_styling(bootstrap_options = c("striped", "hover"))
  }
}

#' rmd_display_vereinbarungen_chancen: renders the vereinbarungen table based
#' on the alist_2a provided
#'
#' HINT:
#' the "rmd_"-prefix indicates, that this method is intended to be called from
#' rmd-files (where as "shiny_"-prefixed methods are intended to be called from
#' dynamic r-code generating dynamic shiny-output). the rmd-chunk must be
#' marked with "results='asis'" in order to render correctly!
#'
#' @param alist_2a the Alist containing the Questions and the user's Answers
#' from part 2a
#'
#' @examples rmd_display_vereinbarungen_chancen(test_vereinbarungen_chancen_alist_2a)
rmd_display_vereinbarungen_chancen <- function(alist_2a) {
  vereinbarungen <- rule_extract_vereinbarungen_fragen(alist_2a)
  kommentare <- rule_extract_vereinbarungen_kommentare(alist_2a)
  assertthat::are_equal(length(vereinbarungen), length(kommentare))
  html <- paste0("<table cellpadding='10' cellspacing='10' width='100%' ",
                 "style='font-size: 1.15em;'><tr style='border-bottom:1px solid #CCCCCC'>",
                 "<th width='40%'><b>Geplante Vereinbarung</b></th>",
                 "<th width='*'><b>Chancen</b></th><th><b>Kommentar</b></th></tr>")
  if (length(vereinbarungen) > 0) {
    for (i in 1:length(vereinbarungen)) {
      vereinbarung <- vereinbarungen[i]
      kommentar <- kommentare[i]
      html <- paste0(html, "<tr style='border-bottom:1px solid #CCCCCC'><td>",
                     "<div style='border-radius: 15px;background: ",
                     col_vereinbarung(),
                     ";padding: 12px; width: 400px; align: center; ",
                     "border: 2px solid #FFFFFF;'>",
                     vereinbarung, "</div></td><td>")
      chancen_belastungen <- rule_extract_chancen_per_vereinbarung(vereinbarung, alist_2a, "Belastung")
      chancen_unzufriedenheiten <- rule_extract_chancen_per_vereinbarung(vereinbarung, alist_2a, "Unzufriedenheit")
      chancen_differenzen <- rule_extract_chancen_per_vereinbarung(vereinbarung, alist_2a, "Differenz")
      if (length(chancen_belastungen) > 0) {
        for (j in 1:length(chancen_belastungen)) {
          chance <- chancen_belastungen[j]
          html <- paste0(html, "&nbsp;<div style='border-radius: 15px;background: ",
                         col_belastung(),
                         ";padding: 12px; width: 200px; height: 60px; align: center;",
                         " float: left;border: 2px solid #FFFFFF;'>",
                         chance, "</div>&nbsp;")
        }
      }
      if (length(chancen_unzufriedenheiten) > 0) {
        for (j in 1:length(chancen_unzufriedenheiten)) {
          chance <- chancen_unzufriedenheiten[j]
          html <- paste0(html, "&nbsp;<div style='border-radius: 15px;background: ",
                         col_unzufriedenheit(),
                         ";padding: 12px; width: 200px; height: 60px; align: center; float: left;border: 2px solid #FFFFFF;'>",
                         chance, "</div>&nbsp;")
        }
      }
      if (length(chancen_differenzen) > 0) {
        for (j in 1:length(chancen_differenzen)) {
          chance <- chancen_differenzen[j]
          html <- paste0(html, "&nbsp;<div style='border-radius: 15px;background: ",
                         col_differenz(),
                         ";padding: 12px; width: 200px; height: 60px; align: center; float: left;border: 2px solid #FFFFFF;'>",
                         chance, "</div>&nbsp;")
        }
      }
      # Add comment, if available
      html <- paste0(html, "<td>",kommentar , "</td>")
      html <- paste0(html, "</td></tr>")
    }
  } else {
      html <- paste0(html, "<tr style='border-bottom:1px solid #CCCCCC'><td colspan='3'> Keine Vereinbarungen geplant.</td></tr>")
  }
  html <- paste0(html, "</table>")
  cat(html)
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
