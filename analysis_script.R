# --------------------------------
# Load Necessary Libraries
# --------------------------------
library(readr)
library(dplyr)
library(ggplot2)
library(janitor)
library(tidyr)
library(tidytext)
library(textdata)
library(scales)  # For better number formatting

# --------------------------------
# Load and Clean Data
# --------------------------------
df <- read_csv("C:/Users/Maya/OneDrive/Documents/Uni/Certificates/Data Analytic in R/Project/Stack overflow analysis/survey_results_public.csv")
df <- df %>% clean_names()
df_clean <- df %>%
  filter(!is.na(country), !is.na(employment), !is.na(converted_comp_yearly))
df_clean$converted_comp_yearly <- as.numeric(df_clean$converted_comp_yearly)

# Add survey_year column (set to 2024 because it's 2024 survey data)
df_clean <- df_clean %>%
  mutate(survey_year = 2024)

# --------------------------------
# Summary Statistics and Basic Demographics
# --------------------------------
total_responses <- nrow(df_clean)
cat("Total Responses:", total_responses, "\n")

# --------------------------------
# Top 10 Countries by Number of Responses
# --------------------------------
top_countries <- df_clean %>%
  count(country, sort = TRUE) %>%
  slice_max(n, n = 10)

ggplot(top_countries, aes(x = reorder(country, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Top 10 Countries by Number of Responses",
    x = "Country",
    y = "Number of Responses"
  ) +
  theme_minimal()

# --------------------------------
# Top 10 Programming Languages Worked With
# --------------------------------
if ("language_have_worked_with" %in% colnames(df_clean)) {
  skills <- df_clean %>%
    filter(!is.na(language_have_worked_with)) %>%
    separate_rows(language_have_worked_with, sep = ";") %>%
    count(language_have_worked_with, sort = TRUE) %>%
    slice_max(n, n = 10)
  
  ggplot(skills, aes(x = reorder(language_have_worked_with, n), y = n)) +
    geom_bar(stat = "identity", fill = "#8A2BE2") +
    coord_flip() +
    labs(
      title = "Top 10 Programming Languages Worked With",
      x = "Programming Language",
      y = "Number of Respondents"
    ) +
    theme_minimal()
}

# --------------------------------
# Sentiment Analysis on Text Data
# --------------------------------
text_column <- "dev_type"

if (text_column %in% colnames(df_clean)) {
  df_text <- df_clean %>%
    filter(!is.na(.data[[text_column]])) %>%
    separate_rows(.data[[text_column]], sep = ";") %>%
    unnest_tokens(word, .data[[text_column]]) %>%
    inner_join(get_sentiments("bing"), by = "word") %>%
    count(word, sentiment, sort = TRUE) %>%
    pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
    mutate(sentiment_score = positive - negative)
  
  # Top 10 positive and negative words
  top_positive <- df_text %>% arrange(desc(sentiment_score)) %>% head(10)
  top_negative <- df_text %>% arrange(sentiment_score) %>% head(10)
  
  print(top_positive)
  print(top_negative)
  
  # Plot sentiment distribution
  df_text %>%
    mutate(sentiment_category = ifelse(sentiment_score >= 0, "Positive", "Negative")) %>%
    count(sentiment_category) %>%
    ggplot(aes(x = sentiment_category, y = n, fill = sentiment_category)) +
    geom_bar(stat = "identity", show.legend = FALSE) +
    scale_fill_manual(values = c("Positive" = "forestgreen", "Negative" = "firebrick")) +
    labs(
      title = "Sentiment Distribution in Developer Types",
      x = "Sentiment",
      y = "Count"
    ) +
    theme_minimal()
}

# --------------------------------
# Average Salary by Years of Experience
# --------------------------------
salary_experience <- df_clean %>%
  filter(!is.na(work_exp)) %>%
  group_by(work_exp) %>%
  summarise(avg_salary = mean(converted_comp_yearly, na.rm = TRUE)) %>%
  filter(!is.na(work_exp))

ggplot(salary_experience, aes(x = as.factor(work_exp), y = avg_salary)) +
  geom_col(fill = "#0073C2FF") +
  labs(
    title = "Average Salary by Years of Experience",
    x = "Years of Experience",
    y = "Average Annual Salary (USD)"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = dollar) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# --------------------------------
# Employment Trend Over Years
# --------------------------------
employment_trend <- df_clean %>%
  group_by(survey_year, employment) %>%
  summarise(count = n(), .groups = "drop") %>%
  group_by(survey_year) %>%
  mutate(percentage = count / sum(count) * 100)

ggplot(employment_trend, aes(x = survey_year, y = percentage, color = employment, group = employment)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Employment Type Trends Over Years",
    x = "Survey Year",
    y = "Percentage of Respondents"
  ) +
  theme_minimal()

# --------------------------------
# Average Compensation by Country
# --------------------------------
avg_salary_country <- df_clean %>%
  group_by(country) %>%
  summarise(
    avg_salary = mean(converted_comp_yearly, na.rm = TRUE),
    count = n(),
    .groups = "drop"
  ) %>%
  filter(count >= 20) %>%
  arrange(desc(avg_salary))

ggplot(avg_salary_country, aes(x = reorder(country, avg_salary), y = avg_salary)) +
  geom_col(fill = "#4B0082") +
  coord_flip() +
  labs(
    title = "Average Annual Compensation by Country",
    x = "Country",
    y = "Average Compensation (USD)"
  ) +
  theme_minimal() +
  scale_y_continuous(labels = dollar)
