# plumber.R

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}


#* Plot a histogram
#* @png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}


#* return some random words
#* @param n The number of words
#* @get /names
function(n = 1) {
  
  nms <- randomNames(n = n, 
                     ethnicity = "White",
                     name.sep = " ", 
                     name.order = "first.last")  
  list(names = nms)
}


#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  list(
    sum = as.numeric(a) + as.numeric(b)
  )
}


#* Process name results
#* @param names Array of selected names
#* @post /names-selected
function(names) {
  
  # l <- jsonlite::fromJSON(req$postBody)
  
  list(
    names = names,
    info = paste("API received and processed", length(names), "selected names.")
    # raw = l
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





