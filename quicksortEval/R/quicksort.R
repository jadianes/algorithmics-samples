#' Sorts the input numeric vector using QUICKSORT and counts the number of comparisons
#' Intended to be used to compare different strategies of pivot selection
#'
#' @param a An integer numeric vector
#' @param PIVOTFUN The function that selects the pivot element index
#' @return A list with the input vector already sorted and a count of the 
#' number of comparisons
#' @author Jose A. Dianes
#' @details TODO
#' @export
quicksort_counter <- function(a, PIVOTFUN=pivot_median_3) {

    if (length(a) <= 1) {
        return ( list(a, 0) )   
    } else {
        # select pivot
        pindex <- PIVOTFUN(a)
        pelem <- a[pindex]

        # partition array
        apartandpindex <- partition(a,pindex)
        apart <- apartandpindex[[1]]
        pindex <- apartandpindex[[2]]

        # quick sort recursively, checking edge cases
        if (pindex>=length(a)) {
            b <- apart[1:(pindex-1)]
            apart1 <- quicksort_counter(b, PIVOTFUN)
            return ( list (
                c( apart1[[1]],pelem ),
                length(a)-1 + apart1[[2]]
            ))
        } else if (pindex<=1) {
            c <- apart[(pindex+1):length(a)]
            apart2 <- quicksort_counter(c, PIVOTFUN)
            return ( list( 
                c( pelem, apart2[[1]] ),
                length(a)-1 + apart2[[2]]
            ))
        } else {
            b <- apart[1:(pindex-1)]
            c <- apart[(pindex+1):length(a)]
            apart1 <- quicksort_counter(b, PIVOTFUN)
            apart2 <- quicksort_counter(c, PIVOTFUN)
            return ( list( 
                c( apart1[[1]], pelem, apart2[[1]] ),
                length(a)-1 + apart1[[2]] + apart2[[2]]
            ))
        }
    }
}


#' Sorts the input numeric vector using QUICKSORT and foreach parallel
#'
#' @param a An integer numeric vector
#' @param PIVOTFUN The function that selects the pivot element index
#' @return A list with the input vector already sorted 
#' @author Jose A. Dianes
#' @details TODO
#' @importFrom foreach foreach %dopar%
#' @importFrom doMC registerDoMC
#' @importFrom rbenchmark benchmark
#' @export
quicksort_mc <- function(a, PIVOTFUN=pivot_median_3, ncores=2) {
    registerDoMC(cores=ncores)
    res <- quicksort_par_impl(a, PIVOTFUN, ncores)
    return (res)
}

quicksort_par_impl <- function(a, PIVOTFUN, num.cores) {
    if (length(a) <= 1) {
        return (a)   
    } else {
        # select pivot
        pindex <- PIVOTFUN(a)
        pelem <- a[pindex]

        # partition array
        apartandpindex <- partition(a, pindex)
        apart <- apartandpindex[[1]]
        pindex <- apartandpindex[[2]]
        
        if (num.cores>1) {
            # quicksort in parallel
            if (pindex>=length(a)) {
                from.index <- c(1,pindex)
                to.index <- c(pindex-1,pindex)
            } else if (pindex<=1) {
                from.index <- c(pindex,pindex+1)
                to.index <- c(pindex,length(a))
            } else {
                from.index <- c(1,pindex,pindex+1)
                to.index <- c(pindex-1,pindex,length(a))
            }

            # do par
            num.cores <- num.cores-length(from.index)
            sorted_parts <- 
                foreach( 
                    from=from.index,
                    to=to.index
                ) %dopar% 
                    quicksort_par_impl(apart[from:to], PIVOTFUN, num.cores)
            num.cores <- num.cores+length(from.index)
            return (unlist(sorted_parts))
        } else {
            # quick sort recursively, checking edge cases
            if (pindex>=length(a)) {
                return ( 
                    c(
                        quicksort_par_impl(apart[1:(pindex-1)], PIVOTFUN, num.cores), 
                        pelem
                    ) 
                )
            } else if (pindex<=1) {
                return ( 
                    c(
                        pelem, 
                        quicksort_par_impl(apart[(pindex+1):length(a)], PIVOTFUN, num.cores)
                    ) 
                )
            } else {
                return ( 
                    c( 
                        quicksort_par_impl(apart[1:(pindex-1)], PIVOTFUN, num.cores), 
                        pelem, 
                        quicksort_par_impl(apart[(pindex+1):length(a)], PIVOTFUN, num.cores)
                    )
                )
            }
        }
    }

}