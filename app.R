
install.packages("shinyWidgets")
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycustomloader)
import::from(shinyWidgets, actionBttn)

ui <- dashboardPage(
    options = list(sidebarExpandOnHover = TRUE),
    header = dashboardHeader(
        title = "Stock Prices Forecasting",
        tags$li(
            tags$style("#startButton{margin-top: 10px; margin-right: 10px}"),
            class = "dropdown",
            actionBttn(
                inputId = "startButton",
                label = "Start Forecasting",
                color = "default",
                style = "simple",
                icon = icon("play"),
                size = "sm",
                block = FALSE
            )
        )
    ),
    
    sidebar = dashboardSidebar(
        minified = FALSE,
        collapsed = TRUE,
        textInput("inputIndex", "Company", "AAPL")
    ),
    
    body = dashboardBody(
        plotlyOutput("plotPricesEvolution", height = "auto"),
        br(),
        plotOutput("plotSVMForecast")
    ),
    
    controlbar = dashboardControlbar(
        overlay = FALSE,
        textInput("inputSVMType", "Type", "eps-regression"),
        textInput("inputSVMKernel", "Kernel", "linear"),
        numericInput("inputSVMCost", "Cost", 10),
        numericInput("inputSVMGamma", "Gamma", 1)
    ),
    title = "Stock Prices"
)

source("get_index.R")
source("candle_stick_plot.R")
source("generate_date_features.R")
source("train_test_split.R")

server <- function(input, output, session) {
    from <- Sys.Date() - 730
    to <-  Sys.Date()
    
    prices <- eventReactive(input$startButton, {get_index(input$inputIndex, from, to)})
    output$plotPricesEvolution <- renderPlotly({candle_stick_plot(prices(), input$inputIndex, from, to)})
    svm_outputs <- eventReactive(input$startButton, {
        svm_forecast(prices(), input$inputSVMType, input$inputSVMKernel, input$inputSVMCost, input$inputSVMGamma)
        })
    output$plotSVMForecast <- renderPlot({svm_outputs()$plot})
}

shinyApp(ui = ui, server = server)
