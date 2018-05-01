shinyServer(function(input, output, session) {
  
  observeEvent(input$countries, {
    #Filter the data accordingly
    if(length(input$countries) == 1 & input$countries == 'All') { 
      filtered_map = kiva_clean
    } else if (length(input$countries) > 1 & 'All' %in% input$countries) {
      countries <- countrychoice [! countrychoice %in% c("All")]
      updateSelectInput(session, "countries", choices=countries)
    } else {
      filtered_map = filtered_map %>% filter(.,country %in% input$countries)
    }
    
    output$map <- renderGvis({
      gvisGeoChart(filtered_map, "country", input$categories,
                   options = list(
                     width = 'auto',
                     height = 'auto',
                     colorAxis="{colors:['green','yellow', 'red']}",
                     backgroundColor="lightblue",
                     defaultColor = 'lightgrey'
                   ))
    })
  
  output$avgBox <- renderInfoBox({
    infoBox(paste("AVG.", input$categories),
            mean(kiva_clean[,input$categories], na.rm = T),
            icon = icon("calculator"))
  })
  # Generate a summary of the dataset ----
  print(input$countries)
  kiva_selected_country_output = kiva_clean %>% filter(., country %in% input$countries)
  kiva_selected_country_output$Region = NULL
  kiva_selected_country_output$country = NULL
  if (input$countries == 'All') {
    output$global_summary = renderTable({kivasummaryasdf})
  } else {
    kiva_selected_country_output = transpose(data.frame(kiva_selected_country_output))
    kiva_selected_country_output$Measure = c('Sum of Loans', 
                                             'Number of borrowers', 
                                             'Number of Repeat Borrowers', 
                                             'Repeat/First Time Borrower Ratio',
                                             'MPI',
                                             'Percent in Poverty')
    kivasum_w_input = merge(kivasummaryasdf,kiva_selected_country_output)
    colnames(kivasum_w_input) = c('Measures', 'Global Average', input$countries)
    output$global_summary = renderTable({kivasum_w_input})
  }
  #output$selected_summary = renderTable({kiva_selected_country_output})
  #output$global_summary = renderTable({kivasummaryasdf})
  })
  output$all_kiva_data = renderDataTable({kiva_clean})
})



# Create an extra column in my existing data table, or make a new data table,
# containing  Sum of Loans', 'Number of borrowers', 'Number of Repeat Borrowers', 'Repeat to First Time Borrower Ratio'