pkgs <- c("shiny", "shinymaterial", "rSolarDB", "magrittr", "googleVis")
for (pkg in pkgs)
  if (!require(pkg, character.only = T))
    install.packages(pkg)

login()

buildCount <- function(ele)  data.frame(
  date = ele$dates %>% as.POSIXct(format = "%Y-%m-%dT%H:%M:%SZ") - 1, ## count en amont
  nNA = 1440 - ele$values
)

getgcal <- function(ele){
  d <- buildCount(ele)
  n <- format(d$date, "%Y") %>%  unique  %>% length
  gvisCalendar(
    d, datevar = "date", numvar = "nNA",
    options = list(
      width = "100%",
      height = 40 + 180 * n,
      colorAxis =  "{colors:['#2DD93D','#F2B705', '#F29F05', '#BF3604', '#D9190F'], values:['0', '1', '20', '99', '1440']}",
      calendar = "{cellSize:20, focusedCellColor:{stroke:'red'}, monthLabel:{fontSize:12}}"),
    chartid = paste0("id")
  )
}
