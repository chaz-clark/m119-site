#https://shiny.byui.edu/connect/#/apps/0d605bec-7069-4d67-8129-8716269e8816/access
#https://shiny.byui.edu/content/0d605bec-7069-4d67-8129-8716269e8816

#Edit url
  #https://posit.byui.edu/connect/#/apps/3a0f6399-4101-4b80-bebc-b7f35c95eec8/access
#Student Access url
  #https://posit.byui.edu/content/3a0f6399-4101-4b80-bebc-b7f35c95eec8

library(shiny)
library(data4led)

ui <- fluidPage(
  titlePanel("Math 119 Project 1 Task 3 - Check Your Work"),
  HTML("<p>Choose your function, enter your chosen parameter values, and then click \"Check Solution.\" This app will tell you if your value for a0 was correct, and then provide a graph similar to the one you were asked to make.<p><br>"),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "seed",
                  label = "Your assigned seed:", 
                  value = 123),
      
      selectInput(inputId = "f",
                  label = "Select your function:", 
                  choices = c("f0","f1","f2","f3","f4","f5")
                  ),

      numericInput(inputId = "a0",
                   label = "Your value for a0 (zero if not used):", 
                   value = 100),
      numericInput(inputId = "a1",
                   label = "Your value for a1 (zero if not used):", 
                   value = 0),
      numericInput(inputId = "a2",
                   label = "Your value for a2 (zero if not used):", 
                   value = 0),
      
      actionButton(inputId = "check_sol", 
                   label = "Check Solution"),
    ),
    
    mainPanel(
      textOutput(outputId = "myMessage"),
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
            f4 = p0 + p1*x + p2*log(0.005*x+1),
            f5 =(p0 + p1*x)*exp(-p2*x),
    )
  }
  
  my_message <- eventReactive(input$check_sol, {
    if (input$f == "f3"){
      if(input$a0 + input$a1==100){"Your value for a0 is correct. Your figure should look similar to the one below. "}
      else{"ERROR: Your value for a0 is incorrect. Notice that the function does not pass through (0,100) in the plots below."}
    }
    else {
      if(input$a0==100){"Your value for a0 is correct. Your figure should look similar to the one below. "}
      else{ "ERROR: Your value for a0 is incorrect. Notice that the function does not pass through (0,100) in the plots below."}
      }
  })
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
    par(mfrow=c(1,2),mar=c(5.5,4.5,1,0.5))
    plot(plot_t,plot_y,
         xlab="Hour ", 
         ylab="Intensity(%) ", 
         pch=16)
    lines(plot_x,fn(plot_x,p0=a0,p1=a1,p2=a2,type = my_type), col=2)
    plot(plot_t,plot_y,
         xlab="Hour ", 
         ylab="Intensity(%) ", 
         pch=16, 
         xlim = c(0,80000),
         ylim = c(-10,120))
    lines(plot_x,fn(plot_x,p0=a0,p1=a1,p2=a2,type = my_type), col=2)
    mtext("The zoomed in window is on the left, the zoomed out on the right.", side = 1, line = -1, outer = TRUE)
    mtext("This figure is used for checking your work.", side = 1, line = -7, outer = TRUE)
  })
  
  output$myPlot <- renderPlot(my_plots())
  output$myMessage <- renderText(my_message())
  
}

shinyApp(ui = ui, server = server)
