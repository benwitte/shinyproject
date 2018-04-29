




shinyServer(function(input, output) {
  #map
  output$MapPlot1 <- renderLeaflet({
    # Create a map
    leaflet(kivamap, 'name', input$selected) %>% 
      addProviderTiles(providers$Stamen.TonerLite) %>%  
      setView(lng = 13.00, lat = 00.00, zoom=1.5) %>%  
      addPolygons(color = "#444444", weight = 1, 
                  # opacity = 0.5, 
                  fillOpacity = 0.7,
                  fillColor = ~pal(kivamap$loan_total),
                  popup = country_popup) %>%
      addLegend("bottomright", pal = pal, values = ~input$selected, 
                opacity = 1,
                title = "Sum of Loans by Country")
  })
  output$maxBox <- renderInfoBox({
    max_value <- max(kivamap[,input$selected])
    max_country <- 
      kivamap$name[kivamap[,input$selected]==max_value]
    infoBox(max_country, max_value, icon = icon("arrow-up"))
  })
  output$minBox <- renderInfoBox({
    min_value <- min(kivamap[,input$selected])
    min_country <- 
      kivamap$name[kivamap[,input$selected]==min_value]
    infoBox(min_country, min_value, icon = icon("arrow-down"))
  })
  output$avgBox <- renderInfoBox({
    infoBox(paste("AVG.", input$selected),
            mean(kivamap[,input$selected]), 
            icon = icon("calculator"), fill = TRUE)
  })
  
  #output$loansummpi = renderPlot({
   # ggplot(data = Kivaclean, aes(x = country, y= loan_total)) + geom_bar(stat = 'identity')
})
  #Globe generation
  #output$globe = renderGlobe({
   # kivaglob()
  #})
#  })

#ui <- fluidPage(leafletOutput('kivamap')),

  
  