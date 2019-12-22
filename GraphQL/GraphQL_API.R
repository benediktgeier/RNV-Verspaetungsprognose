# devtools::install_github("ropensci/ghql")
library(ghql)
library(httr)

auth_url <- paste0("https://login.microsoftonline.com/", Sys.getenv("TENANT_ID"), "/oauth2/token")
body <- list(grant_type = "client_credentials")

token <- content(
  POST(auth_url, authenticate(Sys.getenv("CLIENT_ID"), Sys.getenv("CLIENT_SECRET")), body=body)
)
token

## Up to here: WORKING

## REST: NOT YET WORKING

# authorization string to be added to header
# somehow it is not working with the token from above but only with the token copied from Postman (replace below with the current one)
auth = paste("Bearer", token$access_token)
auth = paste("Bearer", "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6InBpVmxsb1FEU01LeGgxbTJ5Z3FHU1ZkZ0ZwQSIsImtpZCI6InBpVmxsb1FEU01LeGgxbTJ5Z3FHU1ZkZ0ZwQSJ9.eyJhdWQiOiIxNDg0MjEyZi1lZGNlLTQ1MmEtYWFlOS00NjE0MWJhZTkxYWYiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC84N2NkM2M0Zi0xZTBhLTQzNTAtODg5ZS0zOTY5Y2Q0NjE2YzkvIiwiaWF0IjoxNTc3MDQ2MDAwLCJuYmYiOjE1NzcwNDYwMDAsImV4cCI6MTU3NzA0OTkwMCwiYWlvIjoiNDJWZ1lOQ2JLNTdobHIxMGt1anlYUFZwTm1ML0FRPT0iLCJhcHBpZCI6IjlhZmU1M2EyLWU1MGYtNDYzNS05ZmU4LTU1Mzc5ZWM5NWNhZSIsImFwcGlkYWNyIjoiMSIsImlkcCI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0Lzg3Y2QzYzRmLTFlMGEtNDM1MC04ODllLTM5NjljZDQ2MTZjOS8iLCJvaWQiOiJhZTA4MGYxZC1lMTNkLTQ1ZWEtOTZiZi1jOTE3NWU5NWIxMTMiLCJzdWIiOiJhZTA4MGYxZC1lMTNkLTQ1ZWEtOTZiZi1jOTE3NWU5NWIxMTMiLCJ0aWQiOiI4N2NkM2M0Zi0xZTBhLTQzNTAtODg5ZS0zOTY5Y2Q0NjE2YzkiLCJ1dGkiOiJmWEJyOHdCRjdreW9GSXdmR1pOT0FBIiwidmVyIjoiMS4wIn0.DK813eIfVlJtPTgT6PFxS9R5eFhpl74FsuYiCW7eoCuaJnw9oUpHKGqOmSk8CDnY79GTFWOtwPcjPc5QNIygygLdDGnZylsZE9ild_X7CDigDarU5Z93yjbOWlGbKFI2cW0ksWTZfOW9zHWGJOgPh0SUoyllYkNBdfR4mn7Ww-iIohOJi9xqaobObBrHKZMSBlEkcXnGl4XCfR7tIzw16zsYytSn9xFmBT5qRvtY8XFX4_B1C59ICl4mQW9axcLoZLyaWcT0o7FZj1qIZ50TgNO-LdifWvkbk0KJh5NdqjWrFe0WWSyt2vtnmG8MbVV2B2JLiNpDL0IVTAAupCbYVA")

# Try with ghql package -> Not yet working
cli <- GraphqlClient$new(
  url = Sys.getenv("HOSTNAME"),
  headers = add_headers(Authorization = auth)
)

qry <- Query$new()
qry$query('myquery', '{
  stations(first: 1000 lat:49.483076 long:8.468409 distance:1000) {
    totalCount
    elements {
      ... on Station {
        hafasID
        longName
      }
    }
  }
}')

cli$exec(qry$queries$myquery)


## Token from above not working for some reason
res <- POST(Sys.getenv("HOSTNAME"), add_headers(Authorization = auth, "Content-Type" = "application/json"), 
     body = {"query" : "{
     stations(first: 1000 lat:49.483076 long:8.468409 distance:1000) {
         totalCount
         elements {
           ... on Station {
             hafasID
             longName
           }
         }
       }
     }"})
content(res)
str(res)



