
# coding: utf-8

# ### The solution

# We will follow a *divide & conquer* strategy where firs we find all the pairs for `(a,b)`, then we do the same for `(c,d)`, and then we find the maximum pair of the intersection.

# In[2]:

def find_biggest_pair(a, b, c, d):
    pairs_a_b = find_all_pairs(a, b)
    pairs_c_d = find_all_pairs(c, d)
    common_pairs = pairs_a_b.intersection(pairs_c_d)
    if (common_pairs == set()):
        return {'pairs':set(), 'max_pair':None, 'sum_max_pair':0}
    else:
        return {'pairs':common_pairs, 'max_pair':max(common_pairs), 'sum_max_pair':sum(max(common_pairs))}


# The `find_all_pairs` function is a *recursive* one that adds the calling pair `(a,b)` to the result of finding all pairs for a subcase of substracting `a` from `b` or `b` from `a` depending on how do they compare to each other. The base cases are:  
# * No pairs when either `a` or `b` are negative.  
# * the pair itself `(a,b)` if either `a` or `b` is zero.  
# 
# The later base case is explained by the fact that the only way of reaching a pair `(a,b)` of that kind is the pair itself, since we cannot reach zero adding positive numbers.

# In[3]:

def find_all_pairs(a, b):
    if (a<0) | (b<0):
        res = set()
    elif (a==0) | (b==0):
        res = set()
        res.add((a,b))
    elif (a>b):
        res = find_all_pairs(a-b,b)
        res.add((a,b))
    else:
        res = find_all_pairs(a,b-a)
        res.add((a,b))
    return res


# ### Tests

# Let's give `find_all_pairs` a few tries.

# In[4]:

find_all_pairs(5,2)


# In[5]:

find_all_pairs(2,5)


# In[6]:

find_all_pairs(0,0)


# In[7]:

find_all_pairs(0,1)


# In[8]:

find_all_pairs(1,1)


# In[9]:

find_all_pairs(2,2)


# Now let's do the same with the main function `find_biggest_pair`

# In[10]:

find_biggest_pair(7,11,13,21)


# In[11]:

find_biggest_pair(1,1,2,2)


# In[12]:

find_biggest_pair(5,2,1,1)


# In[13]:

find_biggest_pair(2,5,5,2)


# In[17]:

find_biggest_pair(215,534,215,319)


# In[14]:



