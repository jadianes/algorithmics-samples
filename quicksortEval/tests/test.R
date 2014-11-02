## read numbers from file
a <- read.csv("./QuickSort.txt", header=FALSE)
a10 <- read.csv("./10.txt", header=FALSE)
a100 <- read.csv("./100.txt", header=FALSE)
a1000 <- read.csv("./1000.txt", header=FALSE)

## sort and count
res_first <- quicksort_counter(a[[1]], PIVOTFUN=pivot_first) 
res_last <- quicksort_counter(a[[1]], PIVOTFUN=pivot_last)
res_median_3 <- quicksort_counter(a[[1]], PIVOTFUN=pivot_median_3)
res_random <- quicksort_counter(a[[1]], PIVOTFUN=pivot_random)