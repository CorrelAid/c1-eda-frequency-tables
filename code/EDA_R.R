
# challenge 1 - generate frequency table ---------------------------------


# setup supabase ----------------------------------------------------------

df_q <- DBI::dbReadTable(con, "q_response_labelled_en_v1")
df_d <- DBI::dbReadTable(con, "d_response_v1")
df_r <- DBI::dbReadTable(con, "respondent_v1")
df_qg <- DBI::dbReadTable(con, "question_group_v1")
df_qi <- DBI::dbReadTable(con, "question_item_v1")
df_qr_v1 <- DBI::dbReadTable(con, "q_response_v1")


# setup -------------------------------------------------------------------

library(tidyverse)
view(df_q)
view(df_d)


# Overall N --------------------------------------------------------------

# count n of table "respondent_v1"
df_r %>% summarise(n = n())


# question based N --------------------------------------------------------

# Version 1 (frequencies for all values)
df_q %>% count(question_item_id)
df_qr_v1 %>% count(question_item_id)


# Version 2 (frequencies without NAs)
df_qr_v1 %>%
  filter(!is.na(value)) %>%
  count(question_item_id)


# frequency plot for each single question (question or subquestion) ----

# example plot question 1
df_q %>%
  filter(question_item_id == "q1") %>%
  count(value_label) %>%
  ggplot(aes(value_label, n, fill = value_label)) +
  geom_col() +
  coord_flip()


# function for frequency plot
freq_plot <- function(question_id, dataset) {
  id <- str_c(question_id, "", sep = "")
  df <- dataset
  df %>%
    filter(question_item_id == id) %>%
    count(value_label) %>%
    ggplot(aes(value_label, n, fill = value_label)) +
    geom_col() +
    coord_flip()
}

# example for question 1 (id = "q1") for "q_response_labelled_en_v1"
freq_plot("q1", df_q)

# example table question 1
df_q %>%
  filter(question_item_id == "q1") %>%
  count(value_label)

# function for frequency table (Version 1)
freq_table_v1 <- function(question_id, dataset) {
  id <- str_c(question_id, "", sep = "")
  df <- dataset
  df %>%
    filter(question_item_id == id) %>%
    count(value_label)
}

# function for frequency table (Version 2)
freq_table_v2 <- function(question_id, dataset) {
  id <- str_c(question_id, "", sep = "")
  df <- dataset
  df %>%
    filter(question_item_id == id,
           !is.na(value)) %>%
    count(value) # when problems change variable "value" to "value_label"
}

# test
freq_table_v1("q1", df_q)
freq_table_v2("q1", df_qr_v1)


# grouped frequency table -------------------------------------------------

# example for question "q11x2"
df_q %>%
  filter(question_item_id == "q11x2") %>%
  group_by(subquestion_id) %>%
  count(value_label)

# function for grouped frequency table (Version 1)
grouped_freq_table <- function(question_id, dataset) {
  id <- str_c(question_id, "", sep = "")
  df <- dataset
  df %>%
    filter(question_item_id == id) %>%
    group_by(subquestion_id) %>%
    count(value_label)
}


# function for grouped frequency table (Version 1)
grouped_freq_table <- function(question_id, dataset) {
  id <- str_c(question_id, "", sep = "")
  df <- dataset
  df %>%
    filter(question_item_id == id) %>%
    group_by(subquestion_id) %>%
    count(value_label)
}


# example for question "q11x2" from "q_response_labelled_en_v1"
grouped_freq_table("q11x2", df_q)


# matrix question group ---------------------------------------------------

# join the response table with the table about info of question type
df_qr_v1_mtrx <-
  left_join(df_qi, df_qr_v1, by = "question_item_id") %>%
    filter(type_major == "Matrix")

# compute table
df_qr_v1_mtrx %>%
  group_by(question_item_id) %>%
  count(value)


# room for testing ----------------------------------------------------

