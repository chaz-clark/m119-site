
library(shiny)
library(data4led)

ui <- fluidPage(
  
  # App title ----
  titlePanel("Project 3 Final Submission Checker"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Number Input for Seed
      # numericInput(inputId = "seed",
      #              label = "Your assigned seed:", 
      #              value = 2021),
      numericInput(inputId = "p05f0",
                   label = "P(0<=X<=5) for f0:", 
                   value = 0),
      numericInput(inputId = "p05f3",
                   label = "P(0<=X<=5) for f3:", 
                   value = 0),
      numericInput(inputId = "perf1",
                   label = "99 %ile for f1:", 
                   value = 0),
      numericInput(inputId = "perf3",
                   label = "99 %ile for f3:", 
                   value = 0),
      numericInput(inputId = "p10f0",
                   label = "P(X>10) for f0:", 
                   value = 0),
      numericInput(inputId = "p10f1",
                   label = "P(X>10) for f1:", 
                   value = 0),
      numericInput(inputId = "p10f2",
                   label = "P(X>10) for f2:", 
                   value = 0),
      numericInput(inputId = "p10f3",
                   label = "P(X>10) for f3:", 
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
    my_p05f0 <- input$p05f0
    my_p05f3 <- input$p05f3
    my_perf1 <- input$perf1
    my_perf3 <- input$perf3
    my_p10f0 <- input$p10f0
    my_p10f1 <- input$p10f1
    my_p10f2 <- input$p10f2
    my_p10f3 <- input$p10f3
    
    sol <- data.frame(
      "Quantity" = c(
        "P(0<=X<=5) for f0",
        "P(0<=X<=5) for f3",
        "99 %ile for f1:",
        "99 %ile for f3:",
        "P(X>10) for f0:",
        "P(X>10) for f1:",
        "P(X>10) for f2:",
        "P(X>10) for f3:"
      ),
      "value" = c(0.435607,0.833217,
                  10.4999,12.856,
                  0,0.0147976,0.0429819,0.0278166)
    )
    possible <- 
      c(
        my_p05f0,
        my_p05f3,
        my_perf1,
        my_perf3,
        my_p10f0,
        my_p10f1,
        my_p10f2,
        my_p10f3
      )
    
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
      is_close(sol$value[3],possible[3]),
      is_close(sol$value[4],possible[4]),
      is_close(sol$value[5],possible[5]),
      is_close(sol$value[6],possible[6]),
      is_close(sol$value[7],possible[7]),
      is_close(sol$value[8],possible[8])
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
