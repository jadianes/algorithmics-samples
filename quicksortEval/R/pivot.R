#' Selects the first element as a pivot
#'
#' @param a A positive integer numeric vector
#' @return The index 1 
#' @author Jose A. Dianes
#' @details TODO
#' @export
pivot_first <- function(a) {
    return(1)
}

#' Selects the last element as a pivot
#'
#' @param a A positive integer numeric vector
#' @return The index lengt(a) 
#' @author Jose A. Dianes
#' @details TODO
#' @export
pivot_last <- function(a) {
    return(length(a))
}

#' Selects a random element as a pivot, using sample()
#'
#' @param a A positive integer numeric vector
#' @return A random index using sample() 
#' @author Jose A. Dianes
#' @details TODO
#' @export
pivot_random <- function(a) {
    return (sample(1:(length(a)-1),1))
}

#' Selects the median of the first, last, and middle elements as a pivot
#'
#' @param a A positive integer numeric vector
#' @return The median of the first, last, and middle elements as a pivot
#' @author Jose A. Dianes
#' @details TODO
#' @export
pivot_median_3 <- function(a) {
    first <- a[1]
    last <- a[length(a)]
    if ( (length(a)%%2) == 0) {
        mid <- a[length(a)/2]
    } else {
        mid <- a[length(a)/2 + 1]
    }
    
    sorted3 <- sort(c(first,last,mid))
    return (which(a==sorted3[2]))
}

