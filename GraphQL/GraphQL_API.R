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

# authorization string to be edded to header
auth = paste("Bearer", token$access_token)

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


res <- POST(Sys.getenv("HOSTNAME"), add_headers(Authorization = auth, "Content-Type" = "application/graphql"), 
     body = '{"query": "{
       stations(first: 1000 lat:49.483076 long:8.468409 distance:1000) {
         totalCount
         elements {
           ... on Station {
             hafasID
             longName
           }
         }
       }
     }"}')
content(res)
str(res)


