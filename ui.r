# Define UI for application


shinyUI(
  #fluidPage(theme = shinytheme("superhero"),
  dashboardPage(
    #shinyDashboardThemes(
    # theme = "grey_dark"
    #),
    dashboardHeader(title= "Kiva Loans by Country"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Introduction", tabName = "intro", icon = icon("globe")),
        menuItem("Map", tabName = "Map"),
        menuItem('Data', tabName = 'Data')
      )
    ),
    dashboardBody(
      tags$head(
        tags$link(rel = 'stylesheet', type = 'text/css', href = 'custom.css')
      ),
      
      tabItems(
        tabItem(tabName = 'intro',
                h4('Kiva is an NGO that operates worldwide, using crowdfunding to 
                                  provide individuals with micro loans. Each loan is 
                                  underwritten by a Kiva field agent and posted to Kiva’s 
                                  website. Creditors loan money to debtors. 
                                  Borrowers work with Kiva to determine an appropriate 
                                  amount of time to repay the loan. The principal is 
                                  returned to the creditor; in addition, a small interest 
                                  is charged. This interest goes to keep funding Kiva.',
                   
                   'MPI is a complex, weighted global poverty index.',
                   
                   'Questions: Are Kiva loans going to countries with higher 
                                  MPI’s? Are borrowers returning to use Kiva again?')),
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
                                                    countrychoice,
                                                    multiple = TRUE,
                                                    selected = "All")),
                                 column(width = 4,
                                        infoBoxOutput("avgBox"))),
                        fluidRow(box(htmlOutput("map"), width = 18)),
                        # Output: Verbatim text for data summary ----
                        fluidRow(box(tableOutput("global_summary"), width = 18)
                                 #box(htmlOutput("hist"), height = 300)))#,
                        )
                )
        ),
        tabItem(tabName = 'Data',
                dataTableOutput('all_kiva_data')
      )
    )
  )
)
)