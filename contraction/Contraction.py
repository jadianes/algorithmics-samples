
# coding: utf-8

# Let's define a function that gets the adjacency list from the file into a dictionary for later access.

# In[1]:

import csv

def read_adjacency_file(file_name):
    res = {}
    with open(file_name) as adjacency_file:
        for line in csv.reader(adjacency_file,delimiter="\t"):
            res[line[0]] = line[1:(len(line)-1)]
    return res


# Since we are going to merge vertices, let's define a function that, given our map and two vertices indices 'i' and 'j', does the merging into 'i' and remove 'j'.

# In[2]:

def merge_vertices(adjacency_map, i, j):
    adjacency_map[i].extend(adjacency_map[j])
    # point j references to i
    for edge_to_j in adjacency_map[j]:
        adjacency_map[edge_to_j].remove(j)
        adjacency_map[edge_to_j].append(i)
    # remove j and self loops
    del adjacency_map[j]
    # remove self loops
    while (adjacency_map[i].count(i)>0):
        adjacency_map[i].remove(i)
    while (adjacency_map[i].count(j)>0):
        adjacency_map[i].remove(j)


# The contraction algorithm basically keeps randomly selecting vertices and merging them until there are just 2 remaining.

# In[3]:

import random

def contraction(adjacency_map):
    if (len(adjacency_map) <= 2):
        return len(adjacency_map[adjacency_map.keys()[0]])
    else:
        # get a vertex
        ix = random.randint(0, len(adjacency_map)-1)
        i = adjacency_map.keys()[ix]
        # get an edge
        jx = random.randint(0, len(adjacency_map[i])-1)
        j = adjacency_map[i][jx]
        # merge
        merge_vertices(adjacency_map, i, j)
        # call contraction recursively 
        return contraction(adjacency_map)


# Let's call contraction with our file read map.

# In[4]:



min_cuts = set()
for i in range(1000):
    adjacency_map = read_adjacency_file("./kargerMinCut.txt")
    min_cuts.add(contraction(adjacency_map))
print(min(min_cuts))

