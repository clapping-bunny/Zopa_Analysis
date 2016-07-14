#check required packages
source('packages.R')

#Load in data to R
loan_book <- read_csv('../data/loan_book.csv')

#Munge column names in a usable format
colnames(loan_book) <- colnames(loan_book) %>% strsplit(" ") %>% map(function(.)paste(., collapse='_'))

#Convert dates to date format
loan_book <-  loan_book %>% type_convert(col_types=list(Acquired=col_date('%d-%m-%Y'), Scheduled_end_date=col_date('%d-%m-%Y'), Loan_start_date=col_date('%d-%m-%Y')))

#Create Summaries of all variables
book_summarise <- loan_book %>% map(summary)

#Identify unique values for each variable
book_unique <- loan_book %>% map(unique)

#data contains no missing values - check
Missing_data <- nrow(loan_book) -nrow(na.omit(loan_book)) 
if (Missing_data != 0) warning(paste('Data contains missing values (', Missing_data, ')', sep=''))

