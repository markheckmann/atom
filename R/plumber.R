# plumber.R


#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  list(
    sum = as.numeric(a) + as.numeric(b)
  )
}


# generate random ids
generate_id <- function(n) 
{
  replicate(n, paste(sample(LETTERS, 6, T), collapse = ""), simplify = T)  
}


#* return some random words including an id
#* @param n The number of words
#* @get /names
function(n = 1) {
  
  nms <- randomNames(n = n, 
                     ethnicity = "White",
                     name.sep = " ", 
                     name.order = "first.last")  
  ids <- generate_id(length(nms))
  
  data.frame(id = ids, 
             name = nms)
}




#* Process name results
#* @param names Array of selected names becomes dataframe
#* @post /names-selected
function(names) {

  list(
    names = names,
    info = paste("API received and processed", length(names$name), "selected names.")
  )

}


# # POST variable content
# ls(envir = req)
# [1] "args"                 "CONTENT_LENGTH"       "cookies"             
# [4] "HEADERS"              "HTTP_ACCEPT"          "HTTP_ACCEPT_ENCODING"
# [7] "HTTP_CACHE_CONTROL"   "HTTP_CONNECTION"      "HTTP_CONTENT_LENGTH" 
# [10] "HTTP_HOST"            "HTTP_POSTMAN_TOKEN"   "HTTP_USER_AGENT"     
# [13] "httpuv.version"       "PATH_INFO"            "postBody"            
# [16] "QUERY_STRING"         "REMOTE_ADDR"          "REMOTE_PORT"         
# [19] "REQUEST_METHOD"       "rook.errors"          "rook.input"          
# [22] "rook.url_scheme"      "rook.version"         "SCRIPT_NAME"         
# [25] "SERVER_NAME"          "SERVER_PORT"  



## enable cross origin ressource sharing (CORS)

#* @filter cors
cors <- function(req, res) {
  
  res$setHeader("Access-Control-Allow-Origin", "*")
  
  if (req$REQUEST_METHOD == "OPTIONS") {
    res$setHeader("Access-Control-Allow-Methods","*")
    res$setHeader("Access-Control-Allow-Headers", req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
    res$status <- 200 
    return(list())
  } else {
    plumber::forward()
  }
  
}





