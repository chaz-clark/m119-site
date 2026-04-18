
library(shiny)
library(data4led)

ui <- fluidPage(
  
  # App title ----
  titlePanel("Project 3 Task 2 Checker"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Number Input for Seed
      # numericInput(inputId = "seed",
      #              label = "Your assigned seed:", 
      #              value = 2021),
      numericInput(inputId = "a",
                   label = "a in f0:", 
                   value = 0),
      numericInput(inputId = "b",
                   label = "b in f0:", 
                   value = 0),
      numericInput(inputId = "lambda",
                   label = "lambda in f3:", 
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
  
  my_message <- eventReactive(input$check_sol, {
    my_a <- input$a
    my_b <- input$b
    my_lambda <- input$lambda

    sol <- data.frame(
      "Quantity" = c("a in f0","b in f0","lambda in f3"),
      "value" = c(-2.94748,8.53076,0.358212)
    )
    possible <- c(my_a,my_b,my_lambda)
    
    is_close <- function(x,y,tol=0.001) {
      if(x==0){x==y}else{
        if(y==0){x==y}else{
         abs(x-y)/abs(x) < tol 
        }
      }
    }
    
    my_bool <- c(
      is_close(sol$value[1],possible[1]), 
      is_close(sol$value[2],possible[2]), 
      is_close(sol$value[3],possible[3])
      )
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
