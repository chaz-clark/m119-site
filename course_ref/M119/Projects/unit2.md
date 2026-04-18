---
title: "Unit 2 Project"
author: "YOUR NAME"
date: "August 24, 2020"
output:
  html_document:  
    keep_md: true
    toc: true
    toc_float: true
    code_folding: hide
    fig_height: 6
    fig_width: 12
    fig_align: 'center'
---






```r
# Use this R-Chunk to import all your datasets!
set.seed(NULL) #The seed will be different for each student when the student replaces "NULL" with their seed. (each student will have their own data)
devtools::install_github('byuidatascience/data4led')
library(data4led)

ids <- unique(led_study$id)
bulb <- sample(ids,1)
idx <- which(led_study == bulb)
bulb.data = 100*led_study$percent_intensity[idx]
```
<!-- #Color Format -->
<!-- colText = function(x,color){ -->
<!--   outputFormat = knitr::opts_knit$get("rmarkdown.pandoc.to") -->
<!--   if(outputFormat == 'latex') -->
<!--     paste("\\textcolor{",color,"}{",x,"}",sep="") -->
<!--   else if(outputFormat == 'html') -->
<!--     paste("<font color='",color,"'>",x,"</font>",sep="") -->
<!--   else -->
<!--     x -->
<!-- } -->


<!-- ## BackGround -->


<!-- #Week 1 -->
##Statistic -- A number that summarizes information from data.






<!-- #Week 2 -->
##Optimize Likelihood Function



<!-- #Week 3 -->
##Use the Model
  



<!-- #Week 4 -->
##Assume a Different Functional Form for the Model




## Conclusions


## Reflection
