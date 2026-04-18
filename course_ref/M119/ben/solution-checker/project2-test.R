# library(shiny)
# ui <- fluidPage()
# server <- function(input, output) {}
# shinyApp(ui = ui, server = server)



library(shiny)
library(data4led)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Check your coefficients for the 5 models from Project 2 Task 3"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Number Input for Seed
      numericInput(inputId = "seed",
                   label = "Your assigned seed:", 
                   value = 1234),
      numericInput(inputId = "a1.1",
                   label = "The coefficient a1 in function f1:", 
                   value = 0),
      numericInput(inputId = "a1.2",
                   label = "The coefficient a1 in function f2:", 
                   value = 0),
      numericInput(inputId = "a2.2",
                   label = "The coefficient a2 in function f2:", 
                   value = 0),
      numericInput(inputId = "a1.4",
                   label = "The coefficient a1 in function f4:", 
                   value = 0),
      numericInput(inputId = "a2.4",
                   label = "The coefficient a2 in function f4:", 
                   value = 0),
      numericInput(inputId = "a1.5",
                   label = "The coefficient a1 in function f5:", 
                   value = 0),
      numericInput(inputId = "a1.6",
                   label = "The coefficient a1 in function f6:", 
                   value = 0),
      numericInput(inputId = "a2.6",
                   label = "The coefficient a2 in function f6:", 
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
  
  
  my_message <- eventReactive(input$check_sol, {
    my_seed <- input$seed
    sol <- coef_from_seed(my_seed)
    possible <- c(input$a1.1,input$a1.2,input$a2.2,input$a1.4,input$a2.4,input$a1.5,input$a1.6,input$a2.6)
    my_error <- abs((sol$value - possible)/sol$value)
    my_bool <- my_error < 0.005
    my_int <- as.integer(my_bool)+1
    my_message <- c("Not Yet.","You got it!")
    
    results <- sapply(my_int, function(x){my_message[x]})
    data.frame("Coefficient" = sol$coef, "Result" = results)
  } )

  output$table <- renderTable(my_message())
  
  #Add two plots. 
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
