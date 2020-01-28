#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Meteroites impacts on earth"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("mass_size",
                        "Size of the included mass",
                        min = 1,
                        max = 500000,
                        value = 10000,
                        step = 1000)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Histogram"),
           plotOutput("World"),
           plotOutput("Classes")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$Histogram <- renderPlot({
        # generate bins based on input$bins from ui.R
        mass_size <- input$mass_size + 1000
        # draw the histogram with the specified number of bins
        meteroitesHist(mass_size)

    })

    output$World <- renderPlot({
        meteroitesWorld()
    })

    output$Classes <- renderPlot({
        meteroites.plotClass()
    })

}

# Run the application
shinyApp(ui = ui, server = server)
