material_page(
  title = "SolarDB : nb of missing data by days",
  nav_bar_color = "indigo darken-2",
  tags$br(),
  material_row(
    material_column(width = 3,
        material_card(title = "Options :", depth = 4,
            tags$br(),
            material_dropdown(input_id = "siteChoice", label = "Site", choices = sdb_sites()),
            material_dropdown(input_id = "sensorChoice", label = "Sensor", choices = "")
        )
    ),
    material_column(width = 9,
      material_card(title = "", depth = 4,
        htmlOutput("view")
      )
    )
  )
)
