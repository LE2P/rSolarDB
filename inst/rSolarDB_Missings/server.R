function(input, output, session) {
  observe({
    s <- sdb_sensors(sites = input$siteChoice)
    update_material_dropdown(session, "sensorChoice", choices = s, value = s[1])
  })

  output$view <- renderGvis({
    sdb_daily_counts(input$siteChoice, input$sensorChoice) |> getgcal()
  })
}
