library(DBI)
library(RPostgres)
library(readr)

readRenviron(".Renviron")

# extract environment variables
db_name <- Sys.getenv("COOLIFY_DB")
db_host <- Sys.getenv("COOLIFY_HOST")
db_port <- Sys.getenv("COOLIFY_PORT")
db_user <- Sys.getenv("COOLIFY_USER")
db_password <- Sys.getenv("COOLIFY_PASSWORD")

# create connection
con <- DBI::dbConnect(drv = RPostgres::Postgres(),
                 host = db_host,
                 port = db_port,
                 dbname = db_name,
                 user = db_user,
                 password = db_password)

DBI::dbListTables(con)



# replace table_name with the name of the table you need to use
# df <- DBI::dbReadTable(con, "table_name")
#
# readr::write_rds(df, here::here("data", "raw", "data.rds"))
#
# # code to show how to reimport data file - copy to your code if needed
# df <- readr::read_rds(here::here("data", "raw", "data.rds"))
#
# DBI::dbDisconnect(con)