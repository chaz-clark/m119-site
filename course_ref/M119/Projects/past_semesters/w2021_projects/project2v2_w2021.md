---
title: "Project 2 Instructions"
author: ""
date: "Updated Feb 27"
output: 
  html_document:
    code_folding: hide
---




# Project Outline
This project outline and background information have been provided to assist you as you complete your project. You should assume the reader of your work has no knowledge or access to this information.

![Phillips LED Bulbs - [source](https://en.wikipedia.org/wiki/File:Philips_LED_bulbs.jpg)](https://upload.wikimedia.org/wikipedia/commons/4/4e/Philips_LED_bulbs.jpg){width=150px}

How long does an LED light bulb last? The US Department of Energy launched the Bright Tomorrow Lighting Prize (or L Prize) in 2008 to "spur lighting manufacturers to develop high-quality, high-efficiency solid-state lighting products to replace the common incandescent light bulb." In addition to requiring less than 10 watts, the winning bulb needed to have a lifetime longer than 25,000 hours.  For this project, we will use 80% of the initial intensity[^note] as the threshold for determining the lifetime of a light bulb.

Phillips won the prize in 2011, after undergoing 18 months of rigorous testing.  Note however that there are only 8760 hours in a year (24 hours a day for 365 days), which means 18 months of testing is only 13,140 hours much less than the 25,000 hours required to win the prize. And the data we are using, not the Phillips data, only has measurement for 5010 hours. How do we know the bulb met the requirements to win with only 18 months (or in our case only about 208 days) of testing? We use mathematical models. 

When you first turn on an LED bulb, the lumen output slightly increases for a while, going above 100% of the initial brightness. After peaking above 100%,the lumen output stays relatively constant before it starts a slow decent downwards.  

In this project, we'll be fitting the data to deterministic models by maximizing the loglikelihood of the errors. Each of the deterministic models are functions $f(t)$ that describe the average behavior of lumen output of LED bulbs (as a percent of the initial lumens) after $t$ hours.

## Task 1: Determine the Objective Function
- Create an R Markdown file.
- Consider the following general models.
    - $f_1(t; a_1) = 100 + a_1t$
    - $f_2(t; a_1,a_2) = 100 + a_1t + a_2t^2$
    - $f_4(t; a_1,a_2) = 100 + a_1t + a_2\ln(0.005t+1)$
    - $f_5(t; a_1) = 100e^{-0.00005t} + a_1te^{-0.00005t}$
    - $f_6(t; a_1,a_2) = 100 + a_1t - a_2(1-e^{-0.0003t})$
- Write down the loglikelihood function for the errors. Assume the errors are independent and normally distributed (with mean of 0 and standard deviation of 1).
- Organize your work into a **cohesive analysis** and submit it to Canvas.

## Task 2: Derivatives
- Create a new R Markdown file.
- Find the first and second derivatives of $\ell_1(a_1; \mathbf{t}, \mathbf{y})$, the loglikelihood function for errors from the general model $f_1$, with respect to $a_1$.
- Find all the first partials and second partials of $\ell_4(a_1, a_2; \mathbf{t}, \mathbf{y})$, the loglikelihood function for errors from the general model $f_4$.
- Find the first and second derivatives of $\ell_5(a_1; \mathbf{t}, \mathbf{y})$, the loglikelihood function for errors from the general model $f_5$, with respect to $a_1$.
- Organize your work into a **cohesive analysis** and submit it to Canvas.

## Task 3: Fit the Model ("Maximum Likelihood" Method)
- Create a new R Markdown file.
- Use the `seed=` argument in the `led_bulb()` function to set the seed and use the following code to read in the light bulb data.
    
    ```r
    # Use this R-Chunk to load all your libraries!
    
    # run this line once in the console to get package
        #devtools::install_github('byuidatascience/data4led') 
    library(data4led)
    ```
    
    
    ```r
    # Use this R-Chunk to import all your datasets!
    
    #Enter the seed as your birthday MMDD.
    #bulb <- led_bulb(1,seed=MMDD)
    ```
This code creates a data frames is called "bulb". The bulb data frame contains measurements for one randomly selected bulb at many time points. You will need to set the seed so that you will have your own random, but reproducible, data with which to work. Please set the seed as the four digit number corresponding to your birthday month and date, MMDD.  
The bulb data frame include the columns (1) "id", the identification number for the bulb, (2) "hours", the number of hours since the first measurement, (3) "intensity", the lumen output of the bulb, and (4) "percent_intensity", the percent light output -- recorded as a proportion -- based on the first measured intensity of the bulb.  

The deterministic models we will be fitting gives the lumen output of LED bulbs (as a percent of the initial lumens) after $t$ hours. So we need to replace the proportion in column 4 of the data frame with a percent.

- Change the units of "percent_intensity" column to be a percent rather than a proportion (multiply by 100).
- Set the first derivative of $\ell_1(a_1; \mathbf{t}, \mathbf{y})$ with respect to $a_1$ equal to zero and solve for $a_1$.
  - Use the second derivative test to confirm you have actually found a maximum of the associated loglikelihood function.
- Set the partial derivatives of $\ell_4(a_1, a_2; \mathbf{t}, \mathbf{y})$ to zero and solve the resulting system of equations for $a_1$ and $a_2$. 
  - Use the second derivative test to confirm you have actually found a maximum of the associated loglikelihood function.
- Set the first derivative of $\ell_5(a_1; \mathbf{t}, \mathbf{y})$ with respect to $a_1$ equal to zero and solve for $a_1$.
  - Use the second derivative test to confirm you have actually found a maximum of the associated loglikelihood function.
- Write down each of the fitted models, $f_i(t)$ where $i = 1, 2, 4, 5, 6$, with the parameters values rounded to 3 decimal places as needed. 
  - The computation for fitting $f_2$ and $f_6$ were completed in class (or provided to you). Use code provide in class to find the fitted models $f_2$ and $f_6$.
  - Note when using fitted models it is best practice not to round in any preliminary calculations so make sure you use all known decimal places for the parameter values, NOT the rounded values, when you use the fitted model.
- Organize your work into a **cohesive analysis** and submit it to Canvas.



## Project 2: Bringing it All Together (and answer a question)
- Create a new R Markdown file.
- Answer the question, "How long does an LED light bulb last?" 
    - Begin with background and an introduction to the question(s) you will be answering with the light bulb data.
    - Introduce the given data.
    - Introduce the five general models.
        - Restrict the domain for all models to be nonnegative.
    - Describe how you will fit the models (maybe what it means to fit those models).
    - Provide the fitted models.
        - The work to fit $f_2(t)$ and $f_6(t)$ was completed in class and the code only needs to be adapted to find the fits to your specific data.
    - Use each of the five fitted models to predict the intensity of a light bulb as a percent of the original intensity after 25,000 hours. 
    - Use the `uniroot()` function in R to find the approximate solution for where each of your five fitted models is at 80% of the initial intensity, solve the equation $f_i(t) = 80$ for each of the five fitted models.
    - Describe in 4-6 sentences how the information you get from the data depends on the general model you assume. Why is this an important concept to understand when working with models and data?
    - If a fitted model is inconsistent with known truth about a situation, it should not be used as a model in that situation. Are any of your fitted models inconsistent with the information we know about the behavior of LED bulbs (provided in the introductory information of this project)?
- Organize your work into a **cohesive analysis** and submit it to Canvas. Your narrative should stand alone apart from the "project instructions" (meaning your reader should not need the instructions for the project to understand what you are doing or explaining) and separate from the individual Tasks (meaning you should not assume your reader has read any of your previous narratives). It is your job in the narrative to lead your reader from the background and question to given data and 5 general models, fitting those models, and answering a question about the data using those fitted models.

- Reflect on your work for this project. At the bottom of your report include the following in a brief (1-2 paragraph) reflection.
    - Identify/explain 2-3 key mathematical  ideas you learned (and would like to remember).
    - Identify/explain 1-3 soft skills you needed/improved/learned while working on the project.
        - List of some Soft Skills
            - Dedication
            - Following Directions
            - Motivation
            - Self-directed
            - Organization
            - Planning
            - Time Management
            - Willing to Accept Feedback
            - Perseverance
            - Good attitude
            - Meets deadlines
            - Willingness to learn



[^note]: This number is a simplified story for illustrative purposes only.
