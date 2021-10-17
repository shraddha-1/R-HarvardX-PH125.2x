
# Creating data for the graph.  
v <-  c(19, 23, 11, 5, 16, 21, 32, 14, 19, 27, 39, 120, 40, 70, 90) 

# Creating the histogram.  
hist(v, xlab = "Weight", ylab ="Frequency", xlim = c(50, 100),
     col = "darkmagenta", border = "pink", 
     breaks = c(5, 55, 60, 70, 75, 80, 100, 140))  