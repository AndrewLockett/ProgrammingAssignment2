##Some basic tests of the cachematrix function

##matrix multiplication example 
#(without using our makeCacheMatix or CacheSolve functions)
x <- matrix(rnorm(3^3), nrow=3,ncol=3) ##create a 3*3 matrix with random numbers
x
y <-solve(x) ##the inverse of x
y
x * y ##simple multiplication of elements

idm <-x %*% y ##true matrix multiplication (should return the identity matrix)

round(idm,2) ##rounds idm (should be diagonal of 1's and 0's elsewhere)


#testing cacheSolve function
##create the 'special' matrix (to create mm)
mm <- makeCacheMatrix(x)

##show inverse (first run calculated, subsequently retrieved from cache)
cacheSolve(mm)

##show the identity matrix based on the cacheSolve inverse
idm2 <-x %*% cacheSolve(mm)
round(idm2,2)