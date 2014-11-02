
pivot_first <- function(a) {
    return(1)
}

pivot_last <- function(a) {
    return(length(a))
}

pivot_random <- function(a) {
    return (sample(1:(length(a)-1),1))
}

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

quicksort_counter <- function(a, PIVOTFUN) {

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