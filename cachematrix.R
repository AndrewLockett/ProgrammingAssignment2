##R Prog assignment 2: Lexical Scoping 
##This script creates two functions to calculate the inverse of a matrix
##On first calculation the inverse matrix is cached
##Subsequent runs of CacheSolve will then retrieve the cached inverse matrix
##The intention of the excercise is to demonstrate lexical scoping in R

##makeCacheMatrix creates a list containing 4 functions
#these functions set & retrive the matrix & inverse matrix
#these functions are called by cacheSolve (using named attributes)
makeCacheMatrix <- function(x = matrix()) {
        
        #initialise the inverse matrix as null
        im <- NULL
        
        #reset the matrix & clear the inverse
        #note: this function is not used in this assignment script (ie. it is not called from cacheSolve)
        reset <- function(y) {
                x <<- y # set the matrix (x) to y (y, being the new matrix passed when calling this function)
                im <<- NULL # set the inverse matrix (im) to null
        }
        
        #cache the inverse matrix (when it has been solved by cacheSolve function)
        setinverse <- function(inverseM) im <<- inverseM
        
        #get the original matrix (this is used by cacheSolve when first calculating the inverse)
        getmatrix <- function() x
        
        #get the inverse matrix (when it has already been cached on subsequent calls)
        getinverse <- function() im
        
        #return a list containing 4 functions corresponding to the functions defined above
        #these are called using the named attributes
        #(the r_ prefix is just to differentiate the returned list element from the function definition above)
        list(r_reset = reset, 
             r_setinverse = setinverse,
             r_getmatrix = getmatrix,
             r_getinverse = getinverse)
}


## cacheSolve returns the inverse of the matrix provided
#however the matrix input (x argument) is actually the result of the makeCacheMatrix function
#the function first checks to see if the inverse of x has already been cached
#if so the cached inverse matrix is returned
#else the inverse is computed (using solve), and the inverse set in makeCacheMatrix
cacheSolve <- function(x) {

        #returns the cached inverse matrix (by calling the get inverse function)
        im <- x$r_getinverse()
        
        #if the inverse matrix (im) is not null then returns the cached im
        if(!is.null(im)) {
                message("getting cached data")
                return(im)
        }
        
        #else (if inverse matrix has not already been cached) then solves 
        data <- x$r_getmatrix() #gets the original matrix
        im <- solve(data) #solves to find the inverse matrix (accepting the defaults)
        x$r_setinverse(im) #calls the setinverse function to cache the inverse matrix
        im #returns the inverse matrix
}
