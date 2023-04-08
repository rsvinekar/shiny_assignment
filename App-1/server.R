#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)

# Define server logic required to draw a histogram
function(input, output, session) {
  ## means theoretical sd = std error
  output$plot1 <- renderPlotly({
    lambda <- input$lambda
    replicates <- input$bins
    num <- input$num
    th_mean <- 1/lambda
    th_variance <- 1/lambda^2
    rex <- rexp(num,lambda)
    mns <- NULL
#    for (i in 1 : values) mns = c(mns, mean(rexp(replicates,lambda)))
    mns_th_mean <- th_mean ## means theoretical mean
    mns_th_variance <- th_variance / replicates ## means theoretical variance
    mns_th_sd <- sqrt(mns_th_variance)  ## means theoretical sd = std error
    plottitle <- paste("Exponential Distribution rex len=",num)
    g <- ggplot() + geom_histogram(
      mapping = aes(x = rex),
      col="grey40", fill = "lightblue", 
      bins = replicates )+
      labs(
        title = plottitle,
        x = "value",
        y = "occurences" )+
      stat_function(
        mapping = aes(), 
        fun = function(x) 
          dexp(x = x, lambda)*length(rex))+
      geom_vline(aes(xintercept=th_mean, color="theoretical"),    
                 linetype="dotted", linewidth = 0.3)+
      geom_vline(aes(xintercept=mean(rex), color="calculated"), 
                 linetype="dotdash", linewidth = 0.3)+
      scale_color_manual(name = "mean", values = 
                           c(calculated = "blue", 
                             theoretical = "red"))
    ggplotly(g)
    })
    output$plot2 <- renderPlotly({
      lambda <- input$lambda
      replicates <- input$bins
      num <- input$num
      th_mean <- 1/lambda
      th_variance <- 1/lambda^2
      rex <- rexp(num,lambda)
      mns <- NULL
      for (i in 1 : num) mns = c(mns, mean(rexp(replicates,lambda)))
      mns_th_mean <- th_mean ## means theoretical mean
      mns_th_variance <- th_variance / replicates ## means theoretical variance
      mns_th_sd <- sqrt(mns_th_variance)  ## means theoretical sd = std error
      plottitle <- paste("Distribution of means/",replicates,"len=",num)
        g <- ggplot() +
        geom_histogram(
          mapping = aes(x = mns,y=after_stat(density)),
          col="grey", fill = "lightblue", 
          bins = replicates)+   
        stat_function(  mapping = aes(), fun = function(x) 
          dnorm(x = x, mean=mns_th_mean, sd = mns_th_sd))+
        labs(   title = plottitle,
                x = "value", y = "occurences"             )+
        geom_vline( aes(xintercept=mns_th_mean, color="th_mean"),    
                    linetype="dotted", linewidth = 0.5)+
        geom_vline( aes(xintercept=mean(mns), color="mns_mean"),         
                    linetype="dotdash", linewidth = 0.5)+
        geom_vline( aes(xintercept=qnorm(0.9,mean=mns_th_mean, 
                                         sd = mns_th_sd),          
                        color="th_90"),
                    linetype="dotdash", linewidth = 0.5)+
        geom_vline( aes(xintercept=qnorm(0.95,mean=mns_th_mean, 
                                         sd = mns_th_sd),          
                        color="th_95"),
                    linetype="dotdash", linewidth = 0.5)+
        geom_vline( aes(xintercept=qnorm(0.975,mean=mns_th_mean, 
                                         sd = mns_th_sd),          
                        color="th_97.5"),
                    linetype="dotdash", linewidth = 0.5)+
        geom_vline(aes(xintercept=quantile(mns,0.9), color="mns_90"),
                   linetype="dotdash", linewidth = 0.5)+
        geom_vline(aes(xintercept=quantile(mns,0.95), color="mns_95"),
                   linetype="dotdash", linewidth = 0.5)+
        geom_vline(aes(xintercept=quantile(mns,0.975), color="mns_97.5"),
                   linetype="dotdash", linewidth = 0.5)+
        scale_color_manual(name = "mean and quantiles", 
                           values = c(th_mean = "blue", mns_mean = "red",
                                      th_90="green",mns_90="orange",
                                      th_95 = "darkblue", mns_95 = "darkred",
                                      th_97.5="darkgreen",mns_97.5="purple"))
      ggplotly(g)
    })
}
