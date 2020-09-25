# RES602 Experimental Design and Data Analysis R workshops 2020
Axel Nohturfft  
St. George's University of London  
25-September-2020  

## Topics covered  

1. 25-Sep-20: Using the RStudio IDE  


## Preparation for the workshop  

### Installing R and RStudio  

If you haven't already done so, [install first R](https://www.r-project.org/), then [RStudio](https://rstudio.com/products/rstudio/download/) on your computer. That way you can try out the code we'll cover during the practice breaks. Of course, you may choose to just follow the presentation.  

### Accessing R/Rstudio Server  

If you prefer to access RStudio Server online, please go to [https://stats3.sgul.ac.uk/rstudio/](https://stats3.sgul.ac.uk/rstudio/).  
Note that you will need a good amount of disk space allowance for your H drive.  
You might need to first connect to the university's VPN or open the tool on [mydesktop](mydesktop.sgul.ac.uk).  


## To create a copy of this repository in RStudio follow these steps:  

1. Start RStudio  
2. File menu > New project...  
3. Choose: Version Control > Git  
4. Paste the following address into the "Repository URL" field: https://github.com/nohturfft/RES602_2020    
5. Press tab key ("Project directory name" field will be filled automatically)  
6. Choose a desired folder in the "Create project as subdirectory of..." field  
7. Click the "Create project" button  
8. Open the first script ...

## Installing packages  

We will be using a number of different R packages.  
Please install these by running the following code from the command prompt (note: _**tidyverse includes 26 packages in total; so the installation may take a few minutes**_):  

```
install.packages("magrittr")
install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
install.packages("rmarkdown")
install.packages("esquisse")
install.packages("knitr")
install.packages("DT")
```

Alternatively, you can install packages using the RStudio `Tools > Install Packages...` menu.  


## Downloading Covid19 data from the internet  

```
# Define the URL  
url.jh <- paste0("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/",
                 "csse_covid_19_data/csse_covid_19_time_series/",
                 "time_series_covid19_deaths_global.csv")

# Download the data  
df.jh.raw <- readr::read_csv(url.jh)

# Have a look:
head(df.jh.raw)

# Save a local copy:
write.table(df.jh.raw, sep="\t", file = "covid19_data_uk_raw.txt", row.names = F, col.names = T)
```

## Generate a plot from Covid19 data
```
```{r plot covid19}
df.jh.processed <- df.jh.raw %>% 
  dplyr::rename(Country="Country/Region") %>% 
  dplyr::rename(Province="Province/State") %>% 
  dplyr::filter(Country == "United Kingdom") %>% 
  dplyr::filter(is.na(Province)) %>% 
  dplyr::select(-Province, -Lat, -Long) %>% 
  tidyr::pivot_longer(-Country, names_to = "Date", values_to = "Deaths") %>% 
  dplyr::mutate(Date = lubridate::mdy(Date)) %>% 
  dplyr::filter(Deaths > 0)

gg <- ggplot2::ggplot(data=df.jh.processed, aes(x=Date, y=Deaths)) +
  geom_line() + scale_y_log10() +
  labs(title = "UK Deaths from Covid19",
       subtitle = paste0("(Data: Johns Hopkins, ", max(df.jh.processed$Date), ")"))
gg
```
```