#' places a kable-table in the rmd-output based on the passed dataframe df an
#' the selected rows based on an external filter. if no rows are selected,
#' the empty_message is displayed
#'
#' @param df
#' @param rows
#' @param empty_message
#' @param color
#'
#' @return
#' @export
#'
#' @examples
rmd_display_table <- function(df, rows, empty_message, color = "") {
  if (any(rows)) {
    if (color != "") {
      kable(as.data.frame(df[rows, ]),row.names = FALSE, col.names = "",  format = "html")%>%
        kable_styling(bootstrap_options = c("striped", "hover")) %>%
        row_spec(1, background = color)
    } else {
      kable(as.data.frame(df[rows, ]),row.names = FALSE, col.names = "",  format = "html")%>%
        kable_styling(bootstrap_options = c("striped", "hover"))
    }
  } else {
    if (color != "") {
      kable(as.data.frame(empty_message),row.names = FALSE, col.names = "", format = "html") %>%
        kable_styling(bootstrap_options = c("striped", "hover")) %>%
        row_spec(1, background = color)
    } else {
      kable(as.data.frame(empty_message),row.names = FALSE, col.names = "", format = "html") %>%
        kable_styling(bootstrap_options = c("striped", "hover"))
    }
  }
}

