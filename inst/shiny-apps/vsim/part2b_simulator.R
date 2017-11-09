# Relevante Angaben finden
Glist <- read.csv('./data/Glist_Teil1.csv', sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8")
Alist <- result_coll$Alist 

gaps_user <- sapply(1:nrow(Glist), function(i) grepl(Alist[i,3], Glist[i,4]))
gaps_user <- unique(Glist[gaps_user, 3])

relevant_gaps <- character(5)
relevant_gaps[1] <- ifelse(
  length(gaps_user[grepl("Erwerb", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0, 
  paste(c(gaps_user[grepl("Erwerb", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "), 
  "-")
relevant_gaps[2] <- ifelse(
  length(gaps_user[grepl("Haus", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0, 
  paste(c(gaps_user[grepl("Haus", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "), 
  "-")
relevant_gaps[3] <- ifelse(
  length(gaps_user[grepl("Kind", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0, 
  paste(c(gaps_user[grepl("Kind", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "), 
  "-")
relevant_gaps[4] <- ifelse(
  length(gaps_user[grepl("Sozial", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]) > 0, 
  paste(c(gaps_user[grepl("Sozial", gaps_user) | grepl("zeitliche Beanspruchung", gaps_user)]), collapse = ", "), 
  "-")
relevant_gaps[5] <- ifelse(
  length(gaps_user[grepl("selbst", gaps_user)]) > 0, 
  paste(c(gaps_user[grepl("selbst", gaps_user)]), collapse = ", "), 
  "-")

# write.table(relevant_gaps,file = "data/relevant_gaps.csv",quote = FALSE, row.names = FALSE, na = "", sep = ";", fileEncoding = "UTF-8")
result_coll$relevant_gaps <<- relevant_gaps
