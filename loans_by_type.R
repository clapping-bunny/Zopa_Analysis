## Packages
library(readxl)
library(tidyverse)
library(scales)
library(viridis)
library(hrbrthemes)
library(purrr)
library(lubridate)

## Load in loanbook
loanbook <- read_csv("data/my_all_time_loan_book_21092017.csv")

## Look at loanbook
glimpse(loanbook)
summary(loanbook)

## Quick clean
loanbook <- loanbook %>% 
  mutate(`Loan start date` = dmy(`Loan start date`)) %>% 
  mutate(Year = year(`Loan start date`)) %>% 
  mutate(Market = Market %>% 
           factor(levels = c("A*", "A", "A1", "A2", "B", "C1", "D", "E"))
  )

## How much has been lent
plot <- loanbook %>% 
  group_by(Year, Market) %>% 
  summarise(`Loan size` = sum(`Loan size`)) %>% 
  ggplot(aes(x = Year, y = `Loan size`, fill = Market)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = comma) + 
  labs(title = "Zopa Loan Originations (£)",
       subtitle = "Stratified by Market") +
  scale_fill_viridis_d()
 
 ggplotly(plot)
##What proportion of loans in each year were in each risk band
plot2 <- loanbook %>% 
  group_by(Year, Market) %>% 
  summarise(`Loan size` = sum(`Loan size`)) %>% 
  ggplot(aes(x = Year, y = `Loan size`, fill = Market)) +
  geom_bar(stat = "identity", position = "fill") +
  scale_y_continuous(labels = percent) + 
  labs(title = "Zopa Loan Originations (%)",
       subtitle = "Proportion of Loans by Market") + 
  scale_fill_viridis_d()

plot2
