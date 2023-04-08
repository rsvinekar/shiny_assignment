#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Exploring the Central Limit Theorem"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        
        sidebarPanel(
            p("The sliders are used to adjust lambda, bins and samples"),
            p("Play around these values and check what happens to the two histograms on the right"),
            sliderInput("lambda",
                        "Exponential distrib lambda:",
                        min = 0.1,
                        max = 5,
                        value = 0.2),
            sliderInput("bins",
                        "Number of bins:",
                        min = 5,
                        max = 100,
                        value = 40),
            sliderInput("num",
                        "Number of samples:",
                        min = 100,
                        max = 10000,
                        value = 1000),
            p("The basic idea is to gauge the validity of the central limit theorem"),
            p("We generate an exponential distribution with lambda value and number of samples"),
            
            p("Then we generate a distribution of means by generating bins*samples values from the exponential distribution, and take the mean of 'bins' number of values to get 'samples' number of means"),
            p("Then we plot a histogram of the means. We should get a normal distribution according to the Central Limit Theorem"),
            
            p("The explanation is confusing, but here's how : if bins=40 and samples = 1000, we generate 40*1000 samples, split these into 40 parts and take the mean of each part containing 40 values to get 1000 means")),
             
        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("plot1"),
          plotOutput("plot2"), 
          p("This example is based on an assignment done by me in the Datascience course 'Statistical inference' on Coursera. The linked pdf can give more information and also code which is used here."),
          a(href="https://coursera-assessments.s3.amazonaws.com/assessments/1678738410615/573c8ae6-f2b4-4942-947c-874d03556571/Statistical_Inference.pdf","This is the link to the PDF"),
          p("Author: Rithvik Vinekar, date: 9 April 2023")
        )
    )
)
