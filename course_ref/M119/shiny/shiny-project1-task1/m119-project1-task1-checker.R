#The app is located at
#https://shiny.byui.edu/connect/#/apps/6b2eeece-fca9-4e59-92fd-62e3ab3c2782/access
#https://shiny.byui.edu/content/6b2eeece-fca9-4e59-92fd-62e3ab3c2782

#https://posit.byui.edu/connect/#/apps/c693ece0-3b49-4d51-b479-6abb1e85c44d/access
#https://posit.byui.edu/content/c693ece0-3b49-4d51-b479-6abb1e85c44d

library(shiny)
library(data4led)

ui <- fluidPage(
  titlePanel("Math 119 Project 1 Task 1 - Check Your Work"),
  HTML("<p>Enter your seed (see I-Learn) and then click \"Check Solution.\" Your plot should be similar to the one that appears"),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "seed",
                  label = "Your assigned seed:", 
                  value = 0123),

      actionButton(inputId = "check_sol", 
                   label = "Check Solution"),
    ),
    
    mainPanel(
      plotOutput(outputId = "myPlot")
    )
  )
)

server <- function(input, output) {

  my_plots <- eventReactive(input$check_sol, {
    my_seed<-input$seed
    bulb <- led_bulb(1,seed=my_seed)
    plot_t <- bulb$hours
    plot_y<- bulb$percent_intensity
    plot(plot_t,plot_y,
         xlab="Hours ", 
         ylab="Intensity(%) ", 
         pch=16, 
         main = "Check your plot against this one")
  })

  output$myPlot <- renderPlot(my_plots())
  
}

shinyApp(ui = ui, server = server)
