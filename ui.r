# Define UI for application that draws a histogram
shinyUI(dashboardPage(
  dashboardHeader(title= "Kiva Loans by Country"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "intro", icon = icon("globe")),
      menuItem("Map", tabName = "Map",
               selectizeInput("selected",
                              "Select Category",
                              userchoice))
    )
  ),
  dashboardBody(
    #fluidRow(box(leafletOutput("MapPlot1"), width = 12))
    #total loaned as $ and mpi by country and category 
    #global map
    tags$head(
      tags$link(rel = 'stylesheet', type = 'text/css', href = 'custom.css')
    ),
    tabItems(
      tabItem(tabName = "Map",
              # gvisGeoChart
              tabItem(tabName = "Map",
                      fluidRow(infoBoxOutput("maxBox"),
                               infoBoxOutput("minBox"),
                               infoBoxOutput("avgBox")),
                      fluidRow(box(leafletOutput("MapPlot1"), width = 18)#,
                               #box(htmlOutput("hist"), height = 300)))#,
                      )))))))#,
    #tabItem(tabName = "data",
              # datatable
       #       fluidRow(box(DT::dataTableOutput("table"),
        #                   width = 12))))
