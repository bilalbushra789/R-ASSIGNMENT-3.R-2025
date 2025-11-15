# load only DBI + RMariaDB (and data.table)
library(DBI)
library(RMariaDB)
library(data.table)

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
#Q5
q5 <- payment[
  staff,
  on = "staff_id",
  .(
    payment_id,
    amount,
    payment_date,
    staff_name = paste(i.first_name, i.last_name)
  )
]
q5
#Q5
#rented film_ids
rented_film_ids <- unique(
  inventory[rental, on = "inventory_id", film_id]
)
source("Assignment3.R")