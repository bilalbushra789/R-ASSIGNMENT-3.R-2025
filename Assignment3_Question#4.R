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


colnames(store)    # should show: store_id, address_id
colnames(address)  # should show: address_id, city_id
colnames(city)     # should show: city_id, city

store_address <- merge(store, address, by = "address_id", all.x = TRUE)
head(store_address)
"city_id" %in% colnames(store_address)  # should return TRUE
colnames(store_address)

store_city <- merge(store_address, city, by = "city_id", all.x = TRUE)
store_city <- store_city[, .(store_id, city)]
head(store_city)


q4_with_city <- customer[
  store_city,
  on = "store_id",
  .(
    customer_id,
    customer_name = paste(first_name, last_name),
    store_id,
    city
  )
]

head(q4_with_city)

source("Assignment3_Q4.R")




  