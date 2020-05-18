# shinygCAPTCHAv3
Package to use Google reCAPTCHAv3 in RShiny web applications.

How to install
--------------

Run the below command to install the package

``` r
devtools::install_github("sarthi2395/shinygCAPTCHAv3")
```

Sample App
----------

``` r
library(shiny)
library(shinyjs)
library(shinygCAPTCHAv3)

ui <- fluidPage(
  useShinyjs(),
  GreCAPTCHAv3Ui("6LdtJfkUAAAAAFlCBbG6Nr0b98Q2q3fIaZyfdVrf","homepage","responseReceived")
)

server <- function(input, output, session) {
  
  observeEvent(input$responseReceived,{

    result <- GreCAPTCHAv3Server("6LdtJfkUAAAAAOyIvfSlRzJ3x8PALVjTJzGuwaKt",input$responseReceived)
    
    if(result$success){
      
      info(result)

    }
  })
  
}

shinyApp(ui, server)
````
