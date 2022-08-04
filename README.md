# R-trees

Collection of scripts, functions, methods for building tree diagrams in R.



Tips and Notes:


If a tree is hard to read, transform the edge lengths by sqrt (this keeps relative lengths whilst making nodes easier to see)

tree$edge.length <- sqrt(tree$edge.length)
