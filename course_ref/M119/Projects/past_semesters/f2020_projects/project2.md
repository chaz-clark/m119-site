---
title: "Project 2 Instructions"
author: ""
date: "Updated November 16"
output: html_document
---

## Specs List
- General Specs
    - All plots and calculations are introduced, explained, interpreted, and described using complete sentences (and paragraphs). Provide an analysis.
    - Mathematical notation and terminology is used properly.
    - Project is ready for review.
        - Instructions followed.
        - Good faith effort evident for all tasks.
        - The writing is almost free, if not entirely free, of distracting spelling or grammatical errors (incomplete sentences, subject-verb disagreement, and misuse of punctuation).
    - Enough information is included so that work is reproducible.
        - R code is included in html submission with hide/show button.
        - Enough steps of calculations included so that thinking can be traced.
    - The work was completed by the student.
- Project Standards
    - Demonstrates understanding of sum notation and almost all, if not all, the requested sums are expanded correctly.
    - Demonstrates ability to calculate statistics using R (given a formula and data) and almost all, if not all, the requested statistics are correctly calculated.
    - Demonstrates an understanding of the concept of a loglikelihood function by providing the correct formulas for the loglikelihood functions specified ($f_6$ and $f_5$.
    - Demonstrates ability to find a partial derivative and the required partial derivatives are correct.
    - Demonstrates ability to solve systems of equations ~~using R~~ and the solutions are correct.
    - Demonstrates ability to plot functions in R and the required plots of the fitted models show at least a visual fit to the data.
    - Demonstrates the ability to use a (fitted) model to answer questions about data and the answers presented are reasonable, consistent, and correct.
    - Demonstrates understanding that the information we identify using our data depends on which model (or function family, for example $f_6$ or $f_5$ ~~$f$, $f_0$, $f_1$ or $f_2$~~) we assume describes the relationship seen in the data and this understanding is demonstrated by an relevant and consistent comparision. 

## BackGround and Data

![Phillips LED Bulbs - [source](https://en.wikipedia.org/wiki/File:Philips_LED_bulbs.jpg)](https://upload.wikimedia.org/wikipedia/commons/4/4e/Philips_LED_bulbs.jpg){width=250px}

How long does an LED light bulb last? The US Department of Energy launched the Bright Tomorrow Lighting Prize (or L Prize) in 2008 to "spur lighting manufacturers to develop high-quality, high-efficiency solid-state lighting products to replace the common incandescent light bulb." In addition to requiring less than 10 watts, the winning bulb needed to have a lifetime longer than 25,000 hours.  Phillips won the prize in 2011, after undergoing 18 months of rigorous testing.  Note however that there are only 8760 hours in a year (24 hours a day for 365 days), which means it takes almost 100% uptime for 3 years to hit 25,000 hours. How do we know the bulb met the hours requriment with only 18 months of testing? This is where modeling comes into play. 

It turns out that when you first turn on an LED bulb, the lumen output slightly increases for a while, going above 100% of the initial brightness. After peaking above 100%,the lumen output stays relatively constant before it starts a slow decent downwards.  

In this project, we'll be using the data to analyze the function $f(t)$ that gives the lumen output of LED bulbs (as a percent of the original lumens) after $t$ hours.

When you read in the data, one data frame will be created in R. This data frame is called "bulb". The bulb data frame contains measurements for one randomly selected bulb at many time points. 

You will need to set the seed so that you will have your own random but reproducible data with which to work. Please set the seed as the four digit number corresponding to your birthday month and date, MMDD. You set the seed in code chunk at the top of the template around line 35. 

The data frame named "bulb" includes the columns (1) "id", the identification number for the bulb, (2) "hours", the number of hours since the first measurement, (3) "intensity", the lumen output of the bulb, and (4) "percent_intensity", the percent light output -- recorded as a decimal percent -- based on the first measured intensity of the bulb. In order to compare the functions and the data you will need to pay attention to the units of measurements for both the data and the functions.






## Project Outline
To complete this project you will need to provide an analysis by completing the following tasks. An analysis is a detailed examination of something. In this case the "something" is light bulb data, a question, several assumed models, and the understanding the data and models can provide related to the question including the consequences of assuming a model. As the author it is your job is to create plots, provide detailed calculations, and make connections for your reader. You need to draw your readers' attention to specific and important details that can be seen in the plots and calculations you provide. You need to tell your reader why these details are important and how they provide information related to the question being explored.

This outline provides you a structure as you create plots and work through calculations relevant to the question described in the background information above. Make sure you meet **ALL** the specifications (General Specs and Project Standards listed above). If **any** of the specifications are not met you will receive feedback identifying the specification(s) that still require(s) work in order to complete the project.

### Statistic  -- A number that summarizes information from data.

- **Task 1a:** Using the data for one light bulb, the data frame named "bulb", for each of the formulas below write down the expanded sums, both in general and for your specific data. Include at least the first three terms, the ellipsis (...), and at least the last two terms. 

An example of expanding a sum in general is, ![](/Users/katjohnson/Documents/git/M119/docs/1a_ex1_project2.svg){width=450px}. Given a data\$input vector, or list, (7.2, 3, 4.22, 1.5, ..., 12, 16, 16, 4.152), an example of expanding a sum for specific data is, ![](/Users/katjohnson/Documents/git/M119/docs/1a_ex2_project2.svg){width=450px}. 

Each of these formulas is a formula for a statistic, a number that summarizes information from data. In this project, we are continuing our work with the light bulbs and the L-Prize. We will be fitting models, functions $f(t)$ that give the lumen output of LED bulbs (as a percent of the original lumens) after $t$ hours, to the data. When you see $x_i$ it refers to the input variable or the independent variable or the explanitory variable (so $x_i$ and $t_i$ have the same meaning in this context). When you see $y_i$ it refers to the output variable or the dependent variable or the response variable.

![](/Users/katjohnson/Documents/git/M119/docs/eq1a_project2.svg){width=40px}

![](/Users/katjohnson/Documents/git/M119/docs/eq1b_project2_updated.svg){width=40px}

![](/Users/katjohnson/Documents/git/M119/docs/eq1c_project2.svg){width=55px}

![](/Users/katjohnson/Documents/git/M119/docs/eq1d_project2.svg){width=40px}

![](/Users/katjohnson/Documents/git/M119/docs/eq1e_project2.svg){width=40px}

![](/Users/katjohnson/Documents/git/M119/docs/eq1f_project2.svg){width=55px}

![](/Users/katjohnson/Documents/git/M119/docs/eq1g_project2.svg){width=65px}

![](/Users/katjohnson/Documents/git/M119/docs/eq1h_project2.svg){width=65px}

<!-- 
  - $\displaystyle \sum_{i=1}^{n} x_i$
  
  - $\displaystyle \sum_{i=0}^{n} y_i$
  
  - $\displaystyle \sum_{i=1}^{n} x_iy_i$
  
  - $\displaystyle \sum_{i=1}^{n} x_i^2$
  
  - $\displaystyle \sum_{i=1}^{n} y_i^2$
  
  - $\displaystyle \frac{1}{n}\sum_{i=1}^{n} x_i$
  
  - $\displaystyle \sum_{i=1}^{n} e^{-0.04x_i}$
  
  - $\displaystyle \sum_{i=1}^{n} x_ie^{-2x_i}$
  -->

- **Task 1b:** Using the same data, use R to calculate the value for each of the statistics listed in "Task 1a".


### Optimize Likelihood Function

- **Task 2a:** Consider the function $f_6(t) = (100 - a_2) + a_1t + a_2e^{-0.0003t}$, assume the errors are normally distributed with mean of zero and standard deviation of one, write down the loglikelihood function.

~~Consider the function $f(t) = (100 - a_1) + a_1e^{-a_2t}$, assume the errors are normally distributed with mean of zero and standard deviation of one, write down the loglikelihood function.~~

- **Task 2b:** Write down the partial derivatives (with respect to each parameter in the model) of the loglikelihood function. *Note, there are two parameters so we are looking for two partial derivatives.*

- **Task 2c:** Set the partial derivative(s) to zero and ~~use R to numerically~~ solve the resulting system of equations. 

~~*Extension Question: Could this system of equations be solved analytically? (You do not have to answer this question as part of your analysis. It is here to probe your thinking.)*~~


### Using the Fitted Model

- **Task 3a:** Create a plot with both the data (a time vs. intensity as a percent of original lumens scatterplot) and your fitted model from "Task 2". Make sure you clearly indicate which parameter values you are using. *Make sure the selected model is at least a visual fit to the data.*

- **Task 3b:** Use the model to predict when the luminescence of given light bulb will be less than 75% of the original luminescence. *Note, 75% of the original luminescence means $f(t) = 75$ when measuring luminescence as a percent of the original lumens.*

### Assume a Different Functional Form for the Model

- **Task 4a:** Repeat "Task 2" and "Task 3" for the ~~3 of the~~ following model.

    - ~~$\displaystyle f_0(t) = (100 + a_1t)e^{-a_2t}$~~
    
    - ~~$\displaystyle f_4(t) = 100 + a_1t + a_2\ln(t+1)$~~

    - ~~$\displaystyle f_0(t) = a_1 + a_2 t$~~

    - ~~$\displaystyle f_2(t) = 100 + a_2 t$~~
    
    - $\displaystyle f_5(t) = (100 + a_1 t)e^{-0.00005t}$

- **Task 4b:** Compare and contrast the results from your $f_6$ and $f_5$ fitted models ~~your four fitted models~~. How does the assumption (or choice), you make as a mathematician regarding which model to fit, influence the information you learn from the data. Make sure to explain your observations about the consequences of your model assumption in the context of the light bulbs.


### Conclusions

- **Task 5:** Answer the question, ``Do these light bulbs appear to meet the requirements for the L Prize?" Make sure to provide support for your answer using the models and your data.


### Reflections

- **Task 6:** Reflect on your work for this project. In 1-2 paragraphs, identify/explain 2-3 key mathematical  ideas you learned (and would like to remember) and 1-3 soft skills you needed/improved/learned while working on the project.

## Template File
- [Project 2 .Rmd template](project2_template.Rmd)

