shinyServer(function(input, output) {
  #map
  # observeEvent( c(input$countries,input$categories), {
  #  filtered_map = kiva_clean
  # filtered_map =  filtered_map %>% filter(.,country == input$countries)
  # filtered_map = filtered_map[,input$categories]
  # print(filtered_map)
  
  
  # output$map <- renderGvis({
  #   gvisGeoChart(kiva_clean, "country", input$categories, #input$countries,
  #                options = list(
  #                  width = 'auto',
  #                  height = 'auto'
  #               ))
  
  
  observeEvent(input$countries, {
    #Filter the data accordingly
    if(input$countries == 'All') { 
      filtered_map = kiva_clean
    } else {
    filtered_map = filtered_map %>% filter(.,country == input$countries)
    }
    
    
    output$map <- renderGvis({
      gvisGeoChart(filtered_map, "country", input$categories, #input$countries,
                   options = list(
                     width = 'auto',
                     height = 'auto'
                   ))
      
    })
    output$avgBox <- renderInfoBox({
      infoBox(paste("AVG.", input$categories),
              round(mean(kiva_clean[,input$categories], na.rm = T), digits = 2),
              icon = icon("calculator"), fill = TRUE)
    })
    #textOutput(intro, d)
    
    #output$intro = renderText({
    # 'tgfjgdfdjfgjhjgkugkest'
    #})
    #Filter by country
    #output$loansummpi = renderPlot({
    # ggplot(data = Kivaclean, aes(x = country, y= loan_total)) + geom_bar(stat = 'identity')
  })
})
