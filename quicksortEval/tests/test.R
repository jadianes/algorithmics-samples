## read numbers from file
a10 <- read.csv("./10.txt", header=FALSE)
a100 <- read.csv("./100.txt", header=FALSE)
a1000 <- read.csv("./1000.txt", header=FALSE)
a10000 <- read.csv("./10000.txt", header=FALSE)

## sort and count
res_first <- quicksort_counter(a10000[[1]], PIVOTFUN=pivot_first) 
res_last <- quicksort_counter(a10000[[1]], PIVOTFUN=pivot_last)
res_median_3 <- quicksort_counter(a10000[[1]], PIVOTFUN=pivot_median_3)
res_random <- quicksort_counter(a10000[[1]], PIVOTFUN=pivot_random)

cat(res_first[[2]], "comparisons performed by First Pivot Selection\n")
cat(res_last[[2]], "comparisons performed by Last Pivot Selection\n")
cat(res_median_3[[2]], "comparisons performed by Median-of-3 Pivot Selection\n")
cat(res_random[[2]], "comparisons performed by Random Pivot Selection\n")