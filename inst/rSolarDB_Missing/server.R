shinyServer(function(input, output, session) {
  observe({
    s <- sensors(sites = input$siteChoice)
    update_material_dropdown(session, "sensorChoice", choices = s, value = s[1])
  })

  output$view <- renderGvis({
    thisData <- getDataCountByDay(input$siteChoice, input$sensorChoice)
    getgcal(thisData)
  })
})
