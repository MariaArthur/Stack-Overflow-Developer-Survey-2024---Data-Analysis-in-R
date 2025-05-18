# 📊 **Stack Overflow Developer Survey 2024 - Data Analysis in R**

This repository contains the code and analysis for my **Data Analytics in R** project, where I explore insights from the **Stack Overflow Developer Survey 2024**. The project covers various aspects like **developer demographics**, **programming languages**, **employment trends**, and **compensation**.

In this project, I practiced **data cleaning**, **text analysis**, **data visualization**, and **statistical analysis** using **R programming**.

---

## 📅 **Dataset**
The data used in this project is from the **[Stack Overflow Annual Developer Survey 2024](https://www.kaggle.com/datasets/berkayalan/stack-overflow-annual-developer-survey-2024)**, which contains responses from thousands of developers worldwide.

---

## ✨ **What I Did**

### 📊 **Data Cleaning and Preparation**
- Removed rows with missing country, employment, or compensation data.
- Added a **`survey_year`** column to differentiate responses for the 2024 survey.

### 📝 **Summary Statistics and Demographics**
- Total number of survey responses.
- Top 10 countries by number of responses.

### 💻 **Programming Languages Analysis**
- Identified the top 10 most popular programming languages developers have worked with.

### 😊 **Sentiment Analysis**
- Extracted developer types and analyzed their sentiment using the **Bing** sentiment lexicon.
- Identified the top 10 most positive and negative words.

### 💵 **Compensation Analysis**
- Calculated average salary based on years of experience.
- Analyzed average compensation by country.

### 📈 **Employment Trends**
- Visualized employment type trends over the survey year.

---

## 📈 **Key Insights**
- 🌎 **Top Responding Countries:**  
  The top 10 countries with the highest number of responses reflect the global reach of the developer community.

- 📝 **Popular Programming Languages:**  
  The analysis highlights the most commonly used programming languages in the industry.

- 😊 **Sentiment Distribution:**  
  Developer roles vary widely in sentiment, reflecting different challenges and experiences.

- 💰 **Compensation Insights:**  
  The data reveals significant salary variations based on years of experience and country.

---

## 🛠️ **Tools and Technologies**
- **Programming Language:**  
  R

- **Libraries Used:**  
  - `ggplot2`
  - `dplyr`
  - `tidyr`
  - `janitor`
  - `tidytext`
  - `textdata`
  - `scales`

---

## 📄 **Files in the Repository**
- **`analysis_script.R`** - R script containing the full data analysis workflow.
- **`plots/`** - Folder for saving generated plots.

---

## ⚙️ **Installation and Setup**

To replicate the analysis, clone this repository and install the required R packages by running the following:

```r
install.packages(c("readr", "dplyr", "ggplot2", "janitor", "tidyr", "tidytext", "textdata", "scales"))
