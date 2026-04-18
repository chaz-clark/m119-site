# library(shiny)
# ui <- fluidPage()
# server <- function(input, output) {}
# shinyApp(ui = ui, server = server)



library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Check your output"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # # Input: Slider for the number of bins ----
      # sliderInput(inputId = "bins",
      #             label = "Number of bins:",
      #             min = 1,
      #             max = 50,
      #             value = 30),
      
      # Input: Number Input for Seed
      numericInput(inputId = "seed",
                  label = "Your assigned seed:", 
                  value = 1234),
      
      selectInput(inputId = "f",
                  label = "Select your function:", 
                  choices = c("f0","f1","f2","f3","f4","f5")
                  ),

      numericInput(inputId = "lhs",
                   label = "Left hand side (0 or 80)", 
                   value = 80),
      
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
                  label = "Did you get a solution from uniroot?", 
                  choices = c("Yes","No")
      ),
      
      numericInput(inputId = "t",
                   label = "Your solution for t:", 
                   value = 0),
      
      actionButton(inputId = "check_sol", 
                   label = "Check Solution"),
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      # plotOutput(outputId = "distPlot"),
      textOutput(outputId = "myvalues")
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # my_seed<-input$seed
  fn <- function(x,p0,p1,p2,type){
    switch (type,
            f0 = p0 + 0*x,
            f1 = p0 + p1*x,
            f2 = p0 + p1*x + p2*x^2,
            f3 = 100 - p1 + p1*exp(-p2*x),
            f4 = p0 + p1*x + p2*log(0.005*x+1),
            f5 =(p0 + p1*x)*exp(-p2*x),
    )
  }
  
  my_message <- eventReactive(input$check_sol, {
    my_type <- input$f
    a0 <- input$a0
    a1 <- input$a1
    a2 <- input$a2
    L <- input$lhs
    got_solution <- input$got_solution
    my_t <- input$t
    if(my_t<0){return("Check the domain of the function.")}
    my_a <- my_t-1000 #Hopefully OK based on nature of nice functions.
    my_b <- my_t+1000
    no_a <- 0
    no_b <- 500000

    my_tryCatch <- function(expr){
      tryCatch(expr,
               error = function(e){},
               warning = function(w){},
               finally = {})
    }

    # return(
    #   paste(my_type,a0,a1,a2,L,got_solution,my_t,my_a,my_b)
    # )

    ans <- my_tryCatch(
      uniroot(function(x){fn(x,p0=a0,p1=a1,p2=a2,type = my_type)-L},c(no_a,no_b))$root
    )
    if(is.null(ans)){return("Something when wrong with Uniroot.  Check your work.")}
    
    check <- signif(ans,digits = 7)-my_t
    #If check is zero (or within a small tolerance), we should return feedback ("answer correct") otherwise we should return feedback ("answer incorrect") or something like that...
    epsilon <- 0.00001*my_t
    correct <- abs(check) < epsilon
    if(correct){"You got it!"}
    else{"Check your work again. Uniroot found an answer, but your answer too far away."}
  } )

  #If they enter a negative answer that is correct for the wrong function domain, then let them know to check domain.  Otherwise, just return "Incorrect. Check your solution and your code. If you repeatedly get this error message, seek help." 
  
  #Using the students answers we compute...
  #The argument f2s needs to be made general...
  # ans <- uniroot(f,c(a,b),p0=a0,p1=a1,p2=a2,LHS=L)$root
  # signif(ans,digits = 7)
  #Script already fails on F2. 

  # check <- signif(ans,digits = 7)-t
  #If check is zero (or within a small tolerance), we should return feedback ("answer correct") otherwise we should return feedback ("answer incorrect") or something like that...
  # check
  # epsilon <- 0.00001*t
  # epsilon
  # correct <- abs(check)<epsilon
  # correct
  
  
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  
  # x <- eventReactive(input$check_sol, {faithful$waiting} )
  # 
  # output$distPlot <- renderPlot({
  # 
  #   bins <- seq(min(x()), max(x()), length.out = input$bins + 1)
  #   
  #   hist(x(), breaks = bins, col = "#75AADB", border = "white",
  #        xlab = "Waiting time to next eruption (in mins)",
  #        main = "Histogram of waiting times")
  #   
  # })
  
  output$myvalues <- renderPrint(my_message())
  
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
