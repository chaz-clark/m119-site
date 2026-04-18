#put the shiny url here.
#https://shiny.byui.edu/content/c9943577-414e-4446-b81a-751ac1d48f91

library(shiny)
library(data4led)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Math 119 Project 2 - Check Your Work"),
  HTML("<p>For each of the 5 models from Project 2, your assigment was to  predict the intensity of a light bulb as a percent of the original intensity after 25,000 hours, and also find the time at which each model reached 80% intensity. Enter these values below, and then click \"Check Solution.\" This app will tell you which values are correct.<p><br>"),
  
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      #Two things needed. intensity and time.  
      #int.i
      #time.i
      # Input: Number Input for Seed
      numericInput(inputId = "seed",
                   label = "Your assigned seed:", 
                   value = 1234),
      numericInput(inputId = "int.1",
                   label = "The intensity after 25000 hours for f1:", 
                   value = 0),
      HTML("<p>The time to reach 80% intensity for f1 is negative.  Skip entering this value.</p>"),
      numericInput(inputId = "int.2",
                   label = "The intensity after 25000 hours for f2:", 
                   value = 0),
      numericInput(inputId = "time.2",
                   label = "The time to reach 80% intensity for f2:", 
                   value = 0),
      numericInput(inputId = "int.3",
                   label = "The intensity after 25000 hours for f4:", 
                   value = 0),
      numericInput(inputId = "time.3",
                   label = "The time to reach 80% intensity for f4:", 
                   value = 0),
      numericInput(inputId = "int.4",
                   label = "The intensity after 25000 hours for f5:", 
                   value = 0),
      numericInput(inputId = "time.4",
                   label = "The time to reach 80% intensity for f5:", 
                   value = 0),
      numericInput(inputId = "int.5",
                   label = "The intensity after 25000 hours for f6:", 
                   value = 0),
      numericInput(inputId = "time.5",
                   label = "The time to reach 80% intensity for f6:", 
                   value = 0),
      actionButton(inputId = "check_sol", 
                   label = "Check Solution"),
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      tableOutput(outputId = "table")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  ###################################################
  #These functions return the coefficients from MLE. 
  #They use Cramer's rule for ease of parsing the code.
  #These functions can be sources in a separate file. 
  #They require passing both t and y, so no global variables are stored. 
  ###################################################
  cramers.rule.2d <- function(a,b,c,d,e,f){
    #solves ax+by=c, dx+ey=f, 
    #returns c(x,y)
    c(c*e-b*f,a*f-c*d)/(a*e-b*d)
  }
  cramers.rule.1d <- function(a,b){
    #solves ax=b,  
    #returns x
    b/a
  }
  fit.1 <- function(t,y){
    C1.1 <- sum(t*(y-100))
    C2.1 <- sum(t^2)
    cramers.rule.1d(C2.1,C1.1)
  }
  fit.2 <- function(t,y){
    C1.2 <- sum((y-100)*t)
    C2.2 <- sum(t^2)
    C3.2 <- sum(t^3)
    C4.2 <- sum((y-100)*t^2)
    C5.2 <- sum(t^4)
    cramers.rule.2d(C2.2, C3.2, C1.2, C3.2, C5.2, C4.2)
  }
  fit.4 <- function(t,y){
    C1.4 <- sum(t*(y-100))
    C2.4 <- sum(t^2)
    C3.4 <- sum(t*log(0.005*t+1))
    C4.4 <- sum((y-100)*log(0.005*t+1))
    C5.4 <- sum((log(0.005*t+1))^2)
    cramers.rule.2d(C2.4,C3.4,C1.4,C3.4,C5.4,C4.4)
  }
  fit.5 <- function(t,y){
    C1.5 <- sum(t*(y-100*exp(-0.00005*t))*exp(-0.00005*t))
    C2.5 <- sum((t*exp(-0.00005*t))^2)
    cramers.rule.1d(C2.5,C1.5)
  }
  fit.6 <- function(t,y){
    C1.6 <- sum((y-100)*t)
    C2.6 <- sum(t^2)
    C3.6 <- sum(t*(1-exp(-0.0003*t)))
    C4.6 <- sum((y-100)*(1-exp(-0.0003*t)))
    C5.6 <- sum((1-exp(-0.0003*t))^2)
    cramers.rule.2d(C2.6,C3.6,C1.6,C3.6,C5.6,C4.6)
  }
  
  ##############################################
  # Now we can just specify what we wish to fit
  ##############################################
  
  coef_from_seed <- function(seed = 2021){
    bulb <- led_bulb(1,seed=seed)
    
    t <- bulb$hours
    y <- bulb$percent_intensity
    
    values <- c()
    values[1]<-fit.1(t,y)
    values[2:3]<-fit.2(t,y)
    values[4:5]<-fit.4(t,y)
    values[6]<-fit.5(t,y)
    values[7:8]<-fit.6(t,y)
    data.frame("coef"=c("a1 in f1", "a1 in f2", "a2 in f2", "a1 in f4", "a2 in f4", "a1 in f5", "a1 in f6", "a2 in f6"),"value"=values)
  }
  
  ##############################################
  # Here we define the functions
  ##############################################
  f1 <- function(x,a1,   LHS=0){100 + a1*x - LHS}
  f2 <- function(x,a1,a2,LHS=0){100 + a1*x + a2*x^2 - LHS}
  f4 <- function(x,a1,a2,LHS=0){100 + a1*x + a2*log(0.005*x + 1) - LHS}
  f5 <- function(x,a1,   LHS=0){(100 + a1*x)*exp(-0.00005*x) - LHS}
  f6 <- function(x,a1,a2,LHS=0){100 + a1*x + a2*(1 - exp(-0.0003*x)) - LHS}
  
  ####
  
  my_message <- eventReactive(input$check_sol, {
    my_seed <- input$seed
    sol <- coef_from_seed(my_seed)
    a1.f1 <- sol$value[1]
    a1.f2 <- sol$value[2]
    a2.f2 <- sol$value[3]
    a1.f4 <- sol$value[4]
    a2.f4 <- sol$value[5]
    a1.f5 <- sol$value[6]
    a1.f6 <- sol$value[7]
    a2.f6 <- sol$value[8]

    #The correct values for fi(25000)
    # f1(25000,a1.f1)
    # f2(25000,a1.f2,a2.f2)
    # f4(25000,a1.f4,a2.f4)
    # f5(25000,a1.f5)
    # f6(25000,a1.f6,a2.f6)
    #Here I need to compute each function at the correct coefficient.
    # 
    # bulb <- led_bulb(1,seed=123)
    # 
    # t <- bulb$hours
    # y <- bulb$percent_intensity
    # plot(t,y)
    # x <- seq(0,80000,2)
    # plot(x,f4(x,a1.f4,a2.f4),type = "l")
    # points(t,y)
    
    #uniroot(f1,c(0,9999999),a1.f1,      LHS=80)$root 
    #Don't use f1. There is no solution with a positive value. 
    
    question <- c(
      "The intensity after 25000 hours for f1:",
      "The intensity after 25000 hours for f2:",
      "The time to reach 80% intensity for f2:",
      "The intensity after 25000 hours for f4:",
      "The time to reach 80% intensity for f4:",
      "The intensity after 25000 hours for f5:",
      "The time to reach 80% intensity for f5:",
      "The intensity after 25000 hours for f6:",
      "The time to reach 80% intensity for f6:"
    )
    
    ###############################
    # Problem. We need a layer that captures errors from uniroot and handles them. 
    # With seed 4117 there is no solution to f4 = 80. 
    ###############################
    
    my_uniroot <- function(f, interval, ..., LHS=80) {
      objective <- function(x) f(x, ..., LHS=80)
      res <- tryCatch({
        uniroot(objective, interval)$root
      }, error = function(e) {
        # Log the error for debugging if needed
        warning(paste("Root finding failed:", e$message))
        return(NA) # Return NA so the app stays alive
      })
      
      return(res)
    }
    sol <- c(
      f1(25000,a1.f1)      ,
      f2(25000,a1.f2,a2.f2),my_uniroot(f2,c(0,10000000),a1.f2,a2.f2,LHS=80),
      f4(25000,a1.f4,a2.f4),my_uniroot(f4,c(0,10000000),a1.f4,a2.f4,LHS=80),
      f5(25000,a1.f5      ),my_uniroot(f5,c(0,10000000),a1.f5,      LHS=80),
      f6(25000,a1.f6,a2.f6),my_uniroot(f6,c(0,10000000),a1.f6,a2.f6,LHS=80)
    )
    # old_sol <- c(
    #   f1(25000,a1.f1)      ,
    #   f2(25000,a1.f2,a2.f2),uniroot(f2,c(0,10000000),a1.f2,a2.f2,LHS=80)$root,
    #   f4(25000,a1.f4,a2.f4),uniroot(f4,c(0,10000000),a1.f4,a2.f4,LHS=80)$root,
    #   f5(25000,a1.f5      ),uniroot(f5,c(0,10000000),a1.f5,      LHS=80)$root,
    #   f6(25000,a1.f6,a2.f6),uniroot(f6,c(0,10000000),a1.f6,a2.f6,LHS=80)$root
    # )
    possible <- c(
      input$int.1,
      input$int.2,input$time.2,
      input$int.3,input$time.3,
      input$int.4,input$time.4,
      input$int.5,input$time.5
    )
    my_error <- abs((sol - possible)/sol)
    my_bool <- my_error < 0.005
    my_int <- as.integer(my_bool)+1
    my_message <- c("Not Yet.","You got it!")
    
    results <- sapply(my_int, function(x){my_message[x]})
    data.frame("Question" = question, "Entered" = possible ,"Result" = results)
  } )
  
  output$table <- renderTable(my_message())
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
