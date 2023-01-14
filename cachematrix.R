rm(list=ls())
## This is an exercise to better understand R's Lexical Scoping.
## By storing computed values outside the current environment and then retrieving
## them again, we can avoid unnecessary calculations. #Below are two functions
## that show this concept.

## This function takes a matrix as an argument. The contained list of functions
## caches the inverse of the matrix outside the current environment.

makeCacheMatrix <- function(x = matrix()) {
      s <- NULL
      set <- function(y) {
            x <<- y
            s <<- NULL
      }
      get <- function() x
      setsolve <- function(solve) s <<- solve
      getsolve <- function() s
      list(set = set, get = get,
           setsolve = setsolve,
           getsolve = getsolve)
}


## This function solves the matrix from the first function, but first checks
## if the calculation has already been done. In that case, it fetches the
## cached data.

cacheSolve <- function(x, ...) {
        s <- x$getsolve()
        if(!is.null(s)){
                message("Fetching Cached Data")
                return(s)
        }
        data <- x$get()
        s <- solve(data, ...)
        x$setsolve(s)
        s
}
