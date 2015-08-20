#' Partitions an input vector a around a pivot at position pindex
#'
#' @param a A positive integer numeric vector
#' @param pindex The position of the pivot
#' @return A list with the input array where all elements less than or equal to 
#' the pivot element will be located before the pivot, together with the new 
#' position for the pivot element
#' @author Jose A. Dianes
#' @details TODO
#' @export
partition <- function(a,pindex) {
    # swap pivot with first element if needed
    if ( pindex!= 1) {
        aux <- a[pindex]
        a[pindex] <- a[1]
        a[1] <- aux
        pindex <- 1
    }
    p <- a[1]
    i <- 2
    # partition loop
    for (j in 1:length(a)) {
        if (a[j] < p) { ## if a[j] is less than the pivot, swap
            aux <- a[i]
            a[i] <- a[j]
            a[j] <- aux
            i <- i+1
        }
    }
    a[1] <- a[i-1]
    a[i-1] <- p
    
    return (list(a,i-1))
}