library(rbenchmark)
a <- sample(1:100000,100000)

bm <- benchmark(replications = 5,
    quicksort_mc(a,ncores=1),
    quicksort_mc(a,ncores=2),
    quicksort_mc(a,ncores=4),
    quicksort_mc(a,ncores=8)
)

print(bm)
