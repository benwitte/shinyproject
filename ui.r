# Define UI for application


shinyUI(
  fluidPage(#theme = shinythemes::shinytheme("superhero"), #where should this go??
    dashboardPage(
      dashboardHeader(title= "Kiva Loans by Country"),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Introduction", tabName = "intro", icon = icon("globe")),
          menuItem("Map", tabName = "Map")
        )
      ),
      dashboardBody(
        tags$head(
          tags$link(rel = 'stylesheet', type = 'text/css', href = 'custom.css')
        ),
        
        tabItems(
          tabItem(tabName = 'intro',
                  tabsetPanel(h4('Kiva is an NGO that operates worldwide, using crowdfunding to 
                                  provide individuals with micro loans. Each loan is 
                                  underwritten by a Kiva field agent and posted to Kiva’s 
                                  website. Creditors loan money to debtors. 
                                  Borrowers work with Kiva to determine an appropriate 
                                  amount of time to repay the loan. The principal is 
                                  returned to the creditor; in addition, a small interest 
                                  is charged. This interest goes to keep funding Kiva.
                                  
                                  MPI is a complex, weighted global poverty index.
                                  
                                  Questions: Are Kiva loans going to countries with higher 
                                  MPI’s? Are borrowers '))),
          tabItem(tabName = "Map",
                  # gvisGeoChart
                  tabItem(tabName = "Map",
                          fluidRow(column(width = 4, 
                                          selectInput("categories",
                                                      "Select Category",
                                                      userchoice)),
                                   column(width = 4,
                                          selectInput('countries',
                                                      "Select Country",
                                                      countrychoice)),
                                   column(width = 4,
                                          infoBoxOutput("avgBox"))),
                          fluidRow(box(htmlOutput("map"), width = 18)#,
                                   #box(htmlOutput("hist"), height = 300)))#,
                          )
                  )
          )
        )
      )
    )
  )
)