
library(shiny)
library(data4led)

ui <- fluidPage(
  
  # App title ----
  titlePanel("Project 3 Task 1 Checker"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Number Input for Seed
      numericInput(inputId = "seed",
                   label = "Your assigned seed:", 
                   value = 2021),
      numericInput(inputId = "alpha",
                   label = "alpha:", 
                   value = 1),
      numericInput(inputId = "beta",
                   label = "beta:", 
                   value = 1),
      numericInput(inputId = "p2",
                   label = "Using f2, the approximate probability that the amount of explosive in this sample will be more than 10 mg/kg.:", 
                   value = 0),
      numericInput(inputId = "lambda",
                   label = "lambda:", 
                   value = 1),
      numericInput(inputId = "p3",
                   label = "Using f3, the approximate probability that the amount of explosive in this sample will be more than 10 mg/kg.:", 
                   value = 0),
      actionButton(inputId = "check_sol", 
                   label = "Check Solution")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      tableOutput(outputId = "table")
    )
  )
)

server <- function(input, output) {

  ##############################################
  # Now we can just specify what we wish to fit
  ##############################################
  
  solutions <- function(seed = 2021,alpha,beta,lambda){
    
    set.seed(seed)
    tmp2 <- rgamma(25000, shape = alpha, rate = beta)
    prob2 <- length(which(tmp2 > 10))/25000

    set.seed(seed)
    tmp3 <- rexp(25000, rate = lambda)
    prob3 <- length(which(tmp3 > 10))/25000
    
    data.frame("Quantity"=c("Probablity using f2", "Probablity using f3"),"value"=c(prob2,prob3))
  }
  
  
  my_message <- eventReactive(input$check_sol, {
    my_seed <- input$seed
    my_alpha <- input$alpha
    my_beta <- input$beta
    my_lambda <- input$lambda
    my_p2 <-  input$p2
    my_p3 <-  input$p3
    
    sol <- solutions(my_seed,my_alpha,my_beta,my_lambda)
    possible <- c(my_p2,my_p3)
    
    is_close <- function(x,y,tol=0.005) {
      if(x==0){x==y}else{
        if(y==0){x==y}else{
         abs(x-y)/x < tol 
        }
      }
    }
    
    is_close(4e-05,0)
    
    my_bool <- c(is_close(sol$value[1],possible[1]), is_close(sol$value[2],possible[2]))
    my_int <- as.integer(my_bool)+1
    my_message <- c("Not Yet.","You got it!")
    
    results <- sapply(my_int, function(x){my_message[x]})
    #data.frame("Quantity" = sol$Quantity, "Result" = results,"Answer" = sol$value )
    data.frame("Quantity" = sol$Quantity, "Result" = results )
  } )
  
  output$table <- renderTable(my_message())
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
