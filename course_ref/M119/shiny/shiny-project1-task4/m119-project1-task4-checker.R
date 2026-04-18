#https://shiny.byui.edu/connect/#/apps/9391c443-8eee-43d5-9fa9-b67eba178a1e/access
library(shiny)
library(data4led)

ui <- fluidPage(
  titlePanel("Math 119 Project 1 Task 4 - Check Your Work"),
  HTML("<p>Choose your function, enter your chosen parameter values and solution to fi(t)=80, and then click \"Check Solution.\" <p><br>"),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "seed",
                  label = "Your assigned seed:", 
                  value = 123),
      
      selectInput(inputId = "f",
                  label = "Select your function:", 
                  choices = c("f0","f1","f2","f3","f4","f5")
                  ),

      # numericInput(inputId = "lhs",
      #              label = "Left hand side (0 or 80)", 
      #              value = 80),
      
      numericInput(inputId = "a0",
                   label = "Your value for a0 (zero if not used):", 
                   value = 100),
      numericInput(inputId = "a1",
                   label = "Your value for a1 (zero if not used):", 
                   value = 0),
      numericInput(inputId = "a2",
                   label = "Your value for a2 (zero if not used):", 
                   value = 0),
      
      selectInput(inputId = "got_solution",
                  label = "Did you get a solution from uniroot for fi(t)=80?", 
                  choices = c("Yes","No")),
      
      numericInput(inputId = "t",
                   label = "Your solution for t:", 
                   value = 0),
      
      actionButton(inputId = "check_sol", 
                   label = "Check Solution"),
    ),
    
    mainPanel(
      textOutput(outputId = "myValues"),
      HTML("<br><br>"),
      plotOutput(outputId = "myPlot")
    )
  )
)

server <- function(input, output) {
  fn <- function(x,p0,p1,p2,type){
    switch (type,
            f0 = p0 + 0*x,
            f1 = p0 + p1*x,
            f2 = p0 + p1*x + p2*x^2,
            f3 = p0 + p1*exp(-p2*x),
            #f3 = 100 - p1 + p1*exp(-p2*x),
            f4 = p0 + p1*x + p2*log(0.005*x+1),
            f5 =(p0 + p1*x)*exp(-p2*x),
    )
  }
  
  my_message <- eventReactive(input$check_sol, {
    my_type <- input$f
    got_solution <- input$got_solution

    if(my_type == "f0"){
      if(got_solution == "Yes"){return("Check your work. Something is wrong.")}
      else{return("Correct. The function f0 is constant and has value f0(x) =100 for all non negative x.")}
    }
    
    a0 <- input$a0
    a1 <- input$a1
    a2 <- input$a2
    # L <- input$lhs
    L <- 80
    
    no_a <- 0
    no_b <- 500000

    my_tryCatch <- function(expr){
      tryCatch(expr,
               error = function(e){},
               warning = function(w){},
               finally = {})
    }

    if(got_solution == "No"){
      ans <- my_tryCatch(
        uniroot(function(x){fn(x,p0=a0,p1=a1,p2=a2,type = my_type)-L},c(no_a,no_b))$root
      )
      if(!is.null(ans)){return("Something is wrong. Uniroot found a zero. Check your work.")}
      return("Using the parameters you provided, uniroot was unable to find a solution as well. Provided the visual fit shown above is appropriate, you got it.")
    }
    
    #We now know that got_solution == "Yes"
    my_t <- input$t
    my_a <- my_t-1000
    my_b <- my_t+1000
    
    ans <- my_tryCatch(
      uniroot(function(x){fn(x,p0=a0,p1=a1,p2=a2,type = my_type)-L},c(my_a,my_b))$root
    )
    if(is.null(ans)){
      if(my_t<0){return("Something when wrong with Uniroot.  In addition, check the domain of the function.")}
      return("Something when wrong with Uniroot.  Check your work.")
    }
    
    check <- signif(ans,digits = 7)-my_t
    epsilon <- 0.00001*my_t
    correct <- abs(check) < epsilon

    if(my_t<0){
      if(correct){return("You appear to be using uniroot correctly.  However, check the domain of the function. ")}
      return("Check the domain of the function, and check your uniroot code. ")
    }
  
    if(correct){"You got it!"}
    else{"Check your work again. Uniroot found an answer, but your answer is too far away."}
  } )
  
  my_plots <- eventReactive(input$check_sol, {
    my_type <- input$f
    my_seed<-input$seed
    bulb <- led_bulb(1,seed=my_seed)
    a0 <- input$a0
    a1 <- input$a1
    a2 <- input$a2
    plot_t <- bulb$hours
    plot_y<- bulb$percent_intensity
    plot_x <- seq(0,80000,5)
    par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
    plot(plot_t,plot_y,xlab="Hour ", ylab="Intensity(%) ", pch=16,main=my_type)
    lines(plot_x,fn(plot_x,p0=a0,p1=a1,p2=a2,type = my_type), col=2)
    plot(plot_t,plot_y,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(0,80000),ylim = c(-10,120))
    lines(plot_x,fn(plot_x,p0=a0,p1=a1,p2=a2,type = my_type), col=2)
  })
  
  output$myValues <- renderText(my_message())
  output$myPlot <- renderPlot(my_plots())
  
}

shinyApp(ui = ui, server = server)
