quicksortEval
=============

A set of functions to evaluate different strategies when using Quicksort

### Installation  

First, we need to install `devtools`:  

    install.packages(devtools)
    library(devtools)
   
Then we just call  

    install_github(username="jadianes", repo="quicksortEval")


### Pivot selection evaluation  

The function `quicksort_counter` sorts an input numeric vector and counts the
number of comparisons performed. It accepts a pivot selection function as an 
argument. Up to four ready pivot selection functions are available already in
the package:  

* `pivot_first` selects the first element.  
* `pivot_last` selects the last.  
* `pivot_random` samples from all the indexes.  
* `pivot_median_3` performs a median of three using the first, last, and middle 
elements of the input vector.  

### Quicksort Multi-core  

The function `quicksort_mc` gets again an input vector and a number of cores
and sorts the vector using `foreach` up to the number of cores in parallel.  

The script in `test/benchmark.R` measures the improvement of using multiple cores, 
from 1 to 8 when using the function to sort 10000 number vectors.  

### Future works  

* Provide functions to evaluate different disfributions schemas.  

