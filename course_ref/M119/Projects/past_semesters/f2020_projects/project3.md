---
title: "Project 3 Instructions"
author: ""
date: "Updated "
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



## Background and Data

How much exploxive material remains in the soil? The military is concerned about amount of explosives that remain in the soils of training ranges because soldiers are out on the training range and explosive residues are carcinogns. Collecting a representative sample from the training ranges is difficult to do and scientists are working on developing, refining, and validating sampling methods. This work relies on assumptions and use of probability distribution (or models of measurement). 
(Source:  https://serdp-estcp.org/content/download/5167/73264/file/ER-0628-FR.pdf)

In this project we will (1) fit probability distributions to data, (2) create simulated samples from those probability distributions, and (3) use the probability distributions to provide probability information about explosive residue in the surface soil of a training range.

When you read in the data, one vector called Ng will be created in R. The vector contains the measurements Nitroglycerin (Ng) in mg/kg found in 100 samples.

Environment Protection Agency (EPA) specifies regulartory levels of Nitrog concentrations for human heath. For this project, we will use 10 mg/kg as the toxicity threshold for surface soil of this training range.
(Source: https://cfpub.epa.gov/ncea/pprtv/documents/Nitroglycerin.pdf)

[Footnote] This number is a simplified story for illustrative purposes.






## Project Outline
To complete this project you will need to provide an analysis by completing the following tasks. An analysis is a detailed examination of something. In this case the "something" is explosive data, a question, several assumed models, and the understanding the data and models can provide related to the question including the consequences of assuming a model. As the author it is your job is to create plots, provide detailed calculations, and make connections for your reader. You need to draw your readers' attention to specific and important details that can be seen in the plots and calculations you provide. You need to tell your reader why these details are important and how they provide information related to the question being explored.

This outline provides you a structure as you create plots and work through calculations relevant to the question described in the background information above. Make sure you meet **ALL** the specifications (General Specs and Project Standards listed above). If **any** of the specifications are not met you will receive feedback identifying the specification(s) that still require(s) work in order to complete the project.

### Focus on the Data

- **Task 1a:** Create a histogram of the data. 
(BE EXPLICIT, what data? what measurements?)

- **Task 1b:** Calculate the sample mean and the sample standard deviation for the data.
LINK to `?mean` and `?sd` documentation pages.


### Focus on the Model (a family of models)
Consider the probability (density) model, [INSERT A SVG of the equation]
$$f_1(x) = \frac{\lambda^r}{\Gamma(r)}x^{r-1}e^{-\lambda x}$$ with $x \geq 0$, $r>0$, and $\lambda > 0$. This is called the gamma distribution. 

- **Task 2a:** Experiement with different values of parameters and pay attention to how changing the parameters of the model (or distribution) changes the behavior of the model (or distribution or density function). Plot the distribution for at least three choices of the parameters.  Make sure you clearly indicate which parameter values you used in each plot. Summarize (describe) what you learned about the effect of each parameter on the behavior of the function referencing specific features in your plots. 	

- **Task 2b:** Calculate the mean and standard deviation of the model (or distribution) as a function of the parameters using Mathematica.
Tell students to use the code from class.

### Select and Use a Model (from the Family)

- **Task 3:** Estimate the values of the parameters using the given data. Write down the system of equations you need to solve using the sample mean, sample standard deviation, and the mean and standard deviation of the distribution as functions of the parameters. Solve the system of equations.

- Simulate data using the model (the specific model given the parameter values you found by solving the equation in Task 3) and compare the simulated data with the real data. 
(We want students to see that a probability model can be explored in more ways than just a graph of the density or corresponding CDF.)

    - **Task 4a:**[ADD: USE THE FOLLOWING CODE with the parameter values you found that fit the data] to create a sample of 2500 random measurements using the model.

    - **Task 4b:** Plot a histogram of your simulated data.

    - **Task 4c:** Calculate the sample mean and sample standard deviation of your simulated data. 
    
    - **Task 4d:** How does the sample mean and sample standard deviation of yoru simulated data compare with the sample mean and sample standard deviation of the real data?

- **Task 5:** Answer the following questions using the appropriate probability calculations.

    1. What is the probability that the amount of explosive in a sample will be between 0.1 and 0.3? Write down the integral you need to calculate and then compute the value.
  
    2. What is the probability that the amount of explosive in a sample will be more than 0.5? Write down the integral you need to calculate and then compute the value.

    3. What is the 99$^{\text{th}}$ percentile of the distribution? Write down the equation you need to solve, it will include an integral, and then solve the equation.


### A Model is an Assumption
- **Task 6a:** In class we completed Task 2, Task 3, and Task 5 for $f_2(x) = \frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{1}{2}(\frac{x-\mu}{\sigma})^2}$ with $-\infty < x < \infty$, $\mu > 0$, and $\sigma > 0$. This is called the normal distribution. Repeat Task 2, Task 3, and Task 5 for $f_4(x) = \frac{1}{b-a}$ with $a < x < b$ and $-\infty < a < b <\infty$. This is called the uniform distribution.

- **Task 6b:** How do the probabilities calculated in Task 5 depend on the assumption made about which general model (distribution with unknown parameters) is used? Which distribution shape (gamma, $f_1$; normal, $f_2$; or uniform, $f_4$) do you think best describes the given data? Make sure to provide support for your answer. 


### Conclusions

- **Task 7:** Answer the question, "Are the Nitrogicern levels within the soil at this training range below the Environmental Protection Agencys toxicity threshold?" Make sure to provide support for your conclusion. 


### Reflection

- **Task 8:** Reflect on your work for this project. In 1-2 paragraphs, identify/explain 2-3 key mathematical  ideas you learned (and would like to remember) and 1-3 soft skills you needed/improved/learned while working on the project.

## Template File
- [Project 3 .Rmd template](project3_template.Rmd)
