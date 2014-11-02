
# coding: utf-8

# ## Algorithms: Design and Analysis
# ### Programing task I - Inversions
# 

# Given an array `A` containing the numbers `1,2,...,n` in some arbitrary order, determine the *number of inversions* or number of pairs `(i,j)` of array indices with `i<j` and `A[i]>A[j]`.

# Let us first define the main `sort_and_count` function that will take an input array `a` and will return the array sorted and the number of inversions.

# In[1]:

def sort_and_count(a):
    n = len(a)
    if n==1:
        return (a, 0)
    else:
        (b, x) = sort_and_count(a[0:n/2])
        (c, y) = sort_and_count(a[n/2:n])
        (d, z) = count_split_inv(b,c)
        return (d, x+y+z)


# We can see how we are using a *divide & conquer* approach where:  
# 1. We determine the number of inversions for the first half with a recursive call to `sort_and_count`, getting the sorted half of the array as well.
# 2. We do the same with the second half.
# 3. In order to determine inversions affecting both halves, we define the function `count_split_inv` as follows.

# In[2]:

def count_split_inv(b, c):
    n = len(b) + len(c)
    i = 0
    j = 0
    inversions = 0
    d = range(n)
    for k in range(n):
        if (i<len(b)) & (j<len(c)):
            if (b[i] < c[j]):
                d[k] = b[i]
                i = i+1
            else:
                d[k] = c[j]
                j = j+1
                inversions = inversions + (len(b)-i)
        elif i<len(b):
            d[k] = b[i]
            i = i+1
        else:
            d[k] = c[j]
            j = j+1
    return (d,inversions)


# The function takes both sorted halves (`b` and `c`) and compares them element by element in order to insert them sorted in the final result (`d`). For each element in the second half `c` that goes into the final result `d`, we count as many inversions as elements remaining in the first half (`len(b)-i`). This is so because the whole first half `b` is supposed to be smaller than the second half `c`. Each time an element in `c` gets into `d` means that there are as many elements remaining in `b` with `i<j` and `A[i]>A[j]` as explained in the problem definition.

# Let's try some quick examples:

# In[3]:

sort_and_count(range(10))


# In[4]:

sort_and_count([2,1,3])


# In[5]:

sort_and_count([3,1,2])


# In[6]:

sort_and_count([6,5,2,3])


# In[7]:

sort_and_count([6,5,2,3,1])


# Next, we read the input file and create a list of numbers:

# In[8]:

numbers_file = file("./IntegerArray.txt","r")
a = [int(line) for line in numbers_file.readlines()]


# Call `sort_and_count` and store results:

# In[9]:

(d,z) = sort_and_count(a)


# In[10]:

print(z)


# In[10]:



