# load only DBI + RMariaDB (and data.table)
library(DBI)
library(RMariaDB)
library(data.table)
library(ggplot2)

con <- dbConnect(
  RMariaDB::MariaDB(),
  host = "127.0.0.1",
  port = 3306,
  user = "ruser",
  password = "bilalbushra6969",
  dbname = "sakila"
)

# quick test
dbListTables(con)

library(data.table)

# Load sakila tables
film      <- as.data.table(dbReadTable(con, "film"))
language  <- as.data.table(dbReadTable(con, "language"))
customer  <- as.data.table(dbReadTable(con, "customer"))
store     <- as.data.table(dbReadTable(con, "store"))
staff     <- as.data.table(dbReadTable(con, "staff"))
payment   <- as.data.table(dbReadTable(con, "payment"))
inventory <- as.data.table(dbReadTable(con, "inventory"))
rental    <- as.data.table(dbReadTable(con, "rental"))
address   <- as.data.table(dbReadTable(con, "address"))
city      <- as.data.table(dbReadTable(con, "city"))
# Create avg_rate_by_rating
avg_rate_by_rating <- film[, .(avg_rental_rate = mean(rental_rate)), by = rating]

ggplot(avg_rate_by_rating, aes(x = rating, y = avg_rental_rate, fill = rating)) +
  geom_col() +
  labs(
    title = "Average Rental Rate by Rating",
    x = "Rating",
    y = "Average Rental Rate"
  )
source("Assignment3_Q7.R")

source("Assignment3_Q7.R")

