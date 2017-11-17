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
#' @export
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

rmd_display_vereinbarungen_chancen <- function(alist_2a) {
  vereinbarungen <- rule_extract_vereinbarungen(alist_2a)
  html <- "<table cellpadding='10' cellspacing='10' width='100%' style='border: 3px solid #CCCCCC'><tr><th width='40%'>Geplante Vereinbarung</th><th width='*'>Chancen</th></tr>"
  if (length(vereinbarungen) > 0) {
    for (i in 1:length(vereinbarungen)) {
      vereinbarung <- vereinbarungen[i]
      html <- paste0(html, "<tr><td><div style='border-radius: 15px;background: ", col_vereinbarung(), ";padding: 12px; width: 400px; align: center; border: 2px solid #FFFFFF;'>", vereinbarung, "</div></td><td>")
      chancen <- rule_extract_chancen_per_vereinbarung(vereinbarung, alist_2a)
      for (j in 1:length(chancen)) {
        chance <- chancen[j]
        html <- paste0(html, "&nbsp;<div style='border-radius: 15px;background: ", col_unzufriedenheit(), ";padding: 12px; width: 200px; height: 60px; align: center; float: left;border: 2px solid #FFFFFF;'>", chance, "</div>&nbsp;")
      }
      html <- paste0(html, "</td></tr>")
    }
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
#' @export
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
#' @export rmd_display_icon(icon_belastung, "right")
rmd_display_icon <- function(icon, align = stop("one of 'center', 'left' or 'right'"),
                             width = "100%", height = "100%",
                             bgcolor = "#ffffff") {
  html <- paste0("<div style='background-color:", bgcolor,
                   "' align='", align, "'><img src='", icon,
                   "' width='", width, "' height='", height,"'></div>")
  cat(html)
}

