---
title: "EDA and Recommendation System Donors Choose"
author: "Bukun"
output:
  html_document:
    number_sections: true
    toc: true
    fig_width: 10
    code_folding: hide
    fig_height: 4.5
    theme: cosmo
    highlight: tango
---


The **EDA** part of the Kernel is in this Kernel. The **Recommendations Engine** has been [here](https://www.kaggle.com/ambarish/recommendation-system-donors-choose)


#Introduction



This is a `beginner` level tutorial on `Exploratory Data Analysis` and `Similiarities for Recommendation`. This is written  in a simple and lucid style with `small code chunks` which are gentle but a pragmatic way to do detailed analysis.         





This uses the `DonorsChoose` dataset. A description of the dataset from the `Competition Page` is provided below



> Founded in 2000 by a Bronx history teacher, DonorsChoose.org has raised $685 million for America's classrooms. Teachers at three-quarters of all the public schools in the U.S. have come to DonorsChoose.org to request what their students need, making DonorsChoose.org the leading platform for supporting public education.



> To date, 3 million people and partners have funded 1.1 million DonorsChoose.org projects. But teachers still spend more than a billion dollars of their own money on classroom materials. To get students what they need to learn, the team at DonorsChoose.org needs to be able to connect donors with the projects that most inspire them.



<hr/>



**Summary**



<hr/>





* The Donors Choose has information about `donations` , `donors` , `projects` , `resources` , `schools` and `teachers`           





* The `median` amount of Donations is $25 , `mean` amount is $60.66 , `largest` amount is $60000.00     



* `California` , `New York` , `Texas` and `Florida` are the states with the maximum number of donors.      



* `Chicago` , `New York` , `Brooklyn` , `Los Angeles`  and `San Francisco` are the cities with the highest number of  donors                   



* `California` , `New York` , `Texas` and `Florida` are the states with the maximum number of schools.      



* There are more schools in `suburban` and `urban` areas rather than in `rural` areas       



* `New York City` has the highest number of schools followed by `Houston` , `Chicago` , `Los Angeles` and `San Antonio`               



* `Los Angeles` , `Cook` , `Harris` , `Orange` and `Maricopa` are the counties which have the highest number of schools          



* `New York City Department` , `Los Angeles Unif Sch Dist` , `Miami Dade Co Public Sch Dist` , `Texas Dept of Education` , `Philiadelphia City School District` are the districts which have the highest number of schools       



* Most of the projects in the dataset are `Fully Funded`          



* `98%` of the Projects are `Teacher Led`           



* `Literacy and Language` , `Math and Science` are the categories of projects which are most requested            



* `Literacy,Mathematics` , `Literacy` , `Literacy , Literature and Writing` are the subcategories of projects which are most requested         



* `Pre K-2` is the most popular grade category followed by  `3-5` , `6-8` and `9-12`           



* `Supplies` ,`Technology` and `Books` are the Top Resource categories requested in projects.         



* The `median` project cost is around $450 , `mean` is around $485 and the `maximum` cost is $1000       



* `Learning` , `Classroom` , `Technology` , `Reading`, `students` , `books` are the main project titles      



* `Wonder` is the most popular item followed by `Scolastic News Grade 2` , `Scolastic News Grade 5/6` , `Scolastic News Grade 1`  and `Scolastic News Grade 3`         



* `Amazon Business` is the leading Resource Vendor followed by `Lakeshore Learning Materials` , `AKJ Education` , `Best Buy Education` and `School Speciality`              



* `Mrs` is the most Popular Teacher Prefix followed by `Ms` and `Mr.`           



* `District of Columbia` , `Missippi`, `Louisiana` , `New Mexico` , `Georgia`  are the states with the Highest Free Lunch Percentage        



* `Wisconsin` , `New Jersey` , `Vermont` , `Massachusetts` , `Iowa` are the states with Lowest free Lunch Percentage         



* `Lincoln Elementary School` , `Washington Elementary School` , `Central Elementary School` , `Jefferson Elementary School` and `Dawes Elementary School` are schools with most Fully Funded projects.           



* `California` , `Texas` , `New York` , `Florida` and `Illinois` are the States with the most Fully Funded projects            





<hr/>



**Project Title and Project Summary analysis**



<hr/>



* `Piano` , `iditarod` , `drums` , `sensorimeter` and `tubano` are the most important words.           



* `books` , `reading` , `readers` , `read` and `book` are the five most important words for the Category **Literacy and Language**     



* `science` , `math` , `calculators` , `coding` and `stem` are the five most important words for the category **Math and Science**         



* `low income` , `students love` , `english language` , `grade students` and  `grade level` are the five most important **Bigrams**  



* `english language learners` , `students receive free`, `title 1 school` , `reduced price lunch` , `low income families`  are the five most important **Trigrams**      





#Load Libraries



```{r,message=FALSE,warning=FALSE}



library(tidyverse) #  data manipulation and graphs

library(caret)

library(data.table)

library(stringr)

library(lubridate)



#For maps

library(leaflet)

library(rgdal)



library(tidytext)

library(wordcloud)



library(text2vec)

library(Matrix)





```





#Glimpse of the data{.tabset .tabset-fade .tabset-pills}



```{r,message=FALSE,warning=FALSE,echo=FALSE,results=FALSE}



rm(list=ls())



fillColor = "#FFA07A"

fillColor2 = "#F1C40F"

fillColorLightCoral = "#F08080"





donations <- as.tibble(fread("../input/io/Donations.csv"))



donors <- as.tibble(fread("../input/io/Donors.csv"))



projects <- read_csv("../input/io/Projects.csv",col_types = cols(

   X1 = col_integer(),

  `Project ID` = col_character(),

  `School ID` = col_character(),

  `Teacher ID` = col_character(),

  `Teacher Project Posted Sequence` = col_integer(),

  `Project Type` = col_character(),

  `Project Title` = col_character(),

  `Project Essay` = col_character(),

  `Project Subject Category Tree` = col_character(),

  `Project Subject Subcategory Tree` = col_character(),

  `Project Grade Level Category` = col_character(),

  `Project Resource Category` = col_character(),

  `Project Cost` = col_character(),

  `Project Posted Date` = col_date(format = ""),

  `Project Current Status` = col_character(),

  `Project Fully Funded Date` = col_date(format = "")))



resources <- read_csv("../input/io/Resources.csv")



schools <- read_csv("../input/io/Schools.csv")



teachers <- read_csv("../input/io/Teachers.csv")



#Read Latitudes and Longitudes of Zip Codes

schools_lat_long <- read_csv("../input/usa-zip-codes-to-locations/US Zip Codes from 2013 Government Data.csv")





```





##Donations



```{r,message=FALSE,warning=FALSE}



glimpse(donations)



```



##Donors



```{r,message=FALSE,warning=FALSE}



glimpse(donors)



```



##Projects



```{r,message=FALSE,warning=FALSE}



glimpse(projects)



```



##Resources



```{r,message=FALSE,warning=FALSE}



glimpse(resources)



```



##Schools



```{r,message=FALSE,warning=FALSE}



glimpse(schools)



```



##Teachers



```{r,message=FALSE,warning=FALSE}



glimpse(teachers)



```









#Distribution of Donations



The `median` amount of Donations is $25 , `mean` amount is $60.66 , `largest` amount is $60000.00         





```{r,message=FALSE,warning=FALSE}



donations <- donations %>%

  rename(DonationAmount = `Donation Amount` )



donations %>%

  filter(DonationAmount <= 250) %>%

  ggplot(aes(x = DonationAmount)) +

  geom_histogram(bins = 30,fill = fillColor2) +

  labs(x= 'Donation Amount',y = 'Count', title = paste("Distribution of", ' Donation Amount ')) +

  theme_bw()



summary(donations$DonationAmount)



```





#Donors Count Percentage Analysis



A summary of the donor counts is provided below       



```{r,message=FALSE,warning=FALSE}

donor_count <- donations %>%

  rename(DonorID = `Donor ID`) %>%

  group_by(DonorID) %>%

  summarise(Count = n()) 



TotalNoOfRows <- nrow(donor_count)



summary(donor_count$Count)



```



##Percentage of donors and Number of  donations



The following plot shows the Number of donations and  the Percentage of donors associated with donations.



More than `72%` donors donate only once. Only `0.96%` donate 6 times.          







```{r,message=FALSE,warning=FALSE}



getDonorCount <- function(donor_count, n,TotalNoOfRows) {

  donor_count_n <- donor_count %>%

    filter(Count == n)

  

  return(nrow(donor_count_n)/TotalNoOfRows *100)

}



donor_count_df <-   data.frame(no_of_donations = as.numeric(),Percentage = as.numeric())



CalculatePercentageDonations <- function(donor_count, TotalNoOfRows, donor_count_df,no_of_donations) {

  

  Percentage = getDonorCount(donor_count,no_of_donations,TotalNoOfRows)

  donor_count_df <- rbind(donor_count_df,data.frame(no_of_donations= no_of_donations,Percentage))

  

  return(donor_count_df)

}



donor_count_df <- CalculatePercentageDonations(donor_count,TotalNoOfRows,donor_count_df,1)

donor_count_df <- CalculatePercentageDonations(donor_count,TotalNoOfRows,donor_count_df,2)

donor_count_df <- CalculatePercentageDonations(donor_count,TotalNoOfRows,donor_count_df,3)

donor_count_df <- CalculatePercentageDonations(donor_count,TotalNoOfRows,donor_count_df,4)

donor_count_df <- CalculatePercentageDonations(donor_count,TotalNoOfRows,donor_count_df,5)

donor_count_df <- CalculatePercentageDonations(donor_count,TotalNoOfRows,donor_count_df,6)



donor_count_df %>%

  arrange(desc(Percentage)) %>%

  mutate(no_of_donations = reorder(no_of_donations,Percentage)) %>%

  

  ggplot(aes(x = no_of_donations,y = Percentage)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = no_of_donations, y = 1, label = paste0("( ",round(Percentage,2)," )",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'No of Donations', 

       y = 'Percentage', 

       title = 'No of Donations and Percentage') +

  coord_flip() +

  theme_bw()



donor_count_df %>%

  kable()



```





#Donors Analysis



`California` , `New York` , `Texas` and `Florida` are the states with the maximum number of donors.         





##Distribution of Donors Statewise



```{r,message=FALSE,warning=FALSE}



donors <- donors %>%

  rename(DonorState = `Donor State`) 



donors %>%

  filter(!is.na(DonorState)) %>%

  group_by(DonorState) %>%

  summarise(Count = n()/1e3) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(DonorState = reorder(DonorState,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = DonorState,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = DonorState, y = 1, label = paste0("( ",round(Count,2)," Thousands)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'States', 

       y = 'Count', 

       title = 'States and Count') +

   coord_flip() +

     theme_bw()





```



##Donors in a Map



We plot the donors in the US Map.        





```{r,message=FALSE,warning=FALSE}



us <- map_data("state")



state2abb <- tibble(

  region = state.name,

  state = state.abb

)



state_center <- tibble(

  name = state.abb,

  region = state.name,

  lat = state.center$y,

  long = state.center$x

) %>%

  filter(name != "HI" & name != "AK")



DonorStates= donors %>%

  filter(!is.na(DonorState)) %>%

  group_by(DonorState) %>%

  summarise(CountOfDonors = n())



DonorStates$DonorState = as.character(DonorStates$DonorState)



DonorStates <- left_join(state2abb, DonorStates, by = c("region" = "DonorState")) %>%

  mutate(region =str_to_lower(region))



us %>%

  left_join(DonorStates,by = "region") %>%

  

  ggplot() + 

  geom_polygon(aes(x = long, y = lat, fill = CountOfDonors, group = group), color = "white") +

  geom_text(data=state_center, aes(long, lat, label = name), size=4, color = "grey30") +

  coord_fixed(1.3) +

  scale_fill_gradient2(low='#FFA07A', high='#CD5C5C') +

  labs(fill = 'Number of Donors') +

  theme_void() +

  ggtitle("Number of Donors per US state")



```





##Distribution of Donors CityWise            



`Chicago` , `New York` , `Brooklyn` , `Los Angeles`  and `San Francisco` are the cities with the highest number of  donors



```{r,message=FALSE,warning=FALSE}



donors <- donors %>%

  rename(DonorCity = `Donor City`) 



donors %>%

  filter(!is.na(DonorCity)) %>%

  group_by(DonorCity) %>%

  summarise(Count = n()/1e3) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(DonorCity = reorder(DonorCity,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = DonorCity,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = DonorCity, y = 1, label = paste0("( ",round(Count,2)," Thousands)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'City', 

       y = 'Count', 

       title = 'City and Count') +

   coord_flip() +

     theme_bw()





```



#States and Donations



The following plot shows the states with the maximum donations. `California` , `New York` , `Texas` ,`Illinois` and `Florida` are the states with the maximum donations.              





```{r,message=FALSE,warning=FALSE}



donations_donors = left_join(donations,donors)



donations_donors %>%

   filter(DonorState !="") %>%

  group_by(DonorState) %>%

  summarise(DonationAmountDonorState = sum(DonationAmount,na.rm=TRUE)/1e6) %>%

  arrange(desc(DonationAmountDonorState)) %>%

  head(10) %>%

  mutate(DonorState = reorder(DonorState,DonationAmountDonorState)) %>%

  

  

  ggplot(aes(x = DonorState,y = DonationAmountDonorState)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = DonorState, y = 0.2, label = paste0("( ",round(DonationAmountDonorState,2)," Million)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'DonorState', 

       y = 'DonationAmount', 

       title = 'DonorState and DonationAmount') +

  coord_flip() +

  theme_bw()



```





#Cities and Donations



The following plot shows the cities with the maximum donations. `New York City` , `Chicago`,`San Francisco`,`Brooklyn`,`Los Angeles` are the cities with the maximum donations.            





```{r,message=FALSE,warning=FALSE}



donations_donors = left_join(donations,donors)



donations_donors %>%

  filter(DonorCity !="") %>%

  group_by(DonorCity) %>%

  summarise(DonationAmountDonorCity = sum(DonationAmount,na.rm=TRUE)/1e6) %>%

    arrange(desc(DonationAmountDonorCity)) %>%

    head(10) %>%

    mutate(DonorCity = reorder(DonorCity,DonationAmountDonorCity)) %>%

  

    

    ggplot(aes(x = DonorCity,y = DonationAmountDonorCity)) +

    geom_bar(stat='identity',fill= fillColorLightCoral) +

    geom_text(aes(x = DonorCity, y = 0.2, label = paste0("( ",round(DonationAmountDonorCity,2)," Million)",sep="")),

              hjust=0, vjust=.5, size = 4, colour = 'black',

              fontface = 'bold') +

    labs(x = 'DonorCity', 

         y = 'DonationAmount', 

         title = 'DonorCity and DonationAmount') +

    coord_flip() +

    theme_bw()



```



#Schools Analysis





##Distribution of Schools Statewise



`California` , `New York` , `Texas` and `Florida` are the states with the maximum number of schools.    





```{r,message=FALSE,warning=FALSE}



schools %>%

  rename(SchoolState = `School State`) %>%

  filter(!is.na(SchoolState)) %>%

  group_by(SchoolState) %>%

  summarise(Count = n()) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(SchoolState = reorder(SchoolState,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = SchoolState,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = SchoolState, y = 1, label = paste0("( ",round(Count,2),")",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'School', 

       y = 'Count', 

       title = 'School and Count') +

  coord_flip() +

  theme_bw()



```





##Schools and Map



This shows the number of schools per US state. The following code snippet gains inspiration from `HeadorTails` kernel of the previous DonorChoose competition.        





```{r,message=FALSE,warning=FALSE}



SchoolStates <-  schools %>%

  rename(SchoolState = `School State`) %>%

  filter(!is.na(SchoolState)) %>%

  group_by(SchoolState) %>%

  summarise(CountOfSchools = n())





SchoolStates <- left_join(state2abb, SchoolStates, by = c("region" = "SchoolState")) %>%

  mutate(region =str_to_lower(region))



us %>%

  left_join(SchoolStates,by = "region") %>%

  

ggplot() + 

  geom_polygon(aes(x = long, y = lat, fill = CountOfSchools, group = group), color = "white") +

  geom_text(data=state_center, aes(long, lat, label = name), size=4, color = "grey30") +

  coord_fixed(1.3) +

  scale_fill_continuous(low='lightblue', high='darkblue', guide='colorbar') +

  labs(fill = 'Number of Schools') +

  theme_void() +

  ggtitle("Number of Schools per US state")





```







##Distribution of Schools and Metro Types



There are more schools in `suburban` and `urban` areas rather than in `rural` areas        





```{r,message=FALSE,warning=FALSE}



TotalNoOfRows = nrow(schools)



schools %>%

  rename(MetroType = `School Metro Type`) %>%

  filter(!is.na(MetroType)) %>%

  group_by(MetroType) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(MetroType = reorder(MetroType,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = MetroType,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = MetroType, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'MetroType', 

       y = 'Percentage', 

       title = 'MetroType and Percentage') +

  coord_flip() +

  theme_bw()



```





##Distribution of Schools and City



`New York City` has the highest number of schools followed by `Houston` , `Chicago` , `Los Angeles` and `San Antonio`               





```{r,message=FALSE,warning=FALSE}



schools %>%

  rename(SchoolCity = `School City`) %>%

  filter(!is.na(SchoolCity)) %>%

  group_by(SchoolCity) %>%

  summarise(Count = n()) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(SchoolCity = reorder(SchoolCity,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = SchoolCity,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = SchoolCity, y = 1, label = paste0("( ",round(Count),"  )",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'SchoolCity', 

       y = 'Count', 

       title = 'SchoolCity and Count') +

  coord_flip() +

  theme_bw()



```



##Distribution of Schools and County



`Los Angeles` , `Cook` , `Harris` , `Orange` and `Maricopa` are the counties which have the highest number of schools            





```{r,message=FALSE,warning=FALSE}



schools %>%

  rename(SchoolCounty = `School County`) %>%

  filter(!is.na(SchoolCounty)) %>%

  group_by(SchoolCounty) %>%

  summarise(Count = n()) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(SchoolCounty = reorder(SchoolCounty,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = SchoolCounty,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = SchoolCounty, y = 1, label = paste0("( ",round(Count),"  )",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'SchoolCounty', 

       y = 'Count', 

       title = 'SchoolCounty and Count') +

  coord_flip() +

  theme_bw()







```



##Distribution of Schools and District



`New York City Department` , `Los Angeles Unif Sch Dist` , `Miami Dade Co Public Sch Dist` , `Texas Dept of Education` , `Philiadelphia City School District` are the districts which have the highest number of schools     





```{r,message=FALSE,warning=FALSE}



schools %>%

  rename(SchoolDistrict = `School District`) %>%

  filter(!is.na(SchoolDistrict)) %>%

  group_by(SchoolDistrict) %>%

  summarise(Count = n()) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(SchoolDistrict = reorder(SchoolDistrict,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = SchoolDistrict,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = SchoolDistrict, y = 1, label = paste0("( ",round(Count),"  )",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'SchoolDistrict', 

       y = 'Count', 

       title = 'SchoolDistrict and Count') +

  coord_flip() +

  theme_bw()



```



##Distribution of Schools in California with Cluster Markers



`Los Angeles` and `SanFrancisco` shows the high number of schools.              



```{r,message=FALSE,warning=FALSE}





schools$`School Zip` = as.numeric(as.character(schools$`School Zip`))

schools_lat_long$ZIP = as.numeric(as.character(schools_lat_long$ZIP))



schools_coords <- left_join(schools,schools_lat_long,by=c("School Zip" = "ZIP"))



schools_coords_CA = schools_coords %>%

  filter(`School State`== "California")



center_lon = median(schools_coords_CA$LNG,na.rm = TRUE)

center_lat = median(schools_coords_CA$LAT,na.rm = TRUE)



schools_coords_CA %>% leaflet() %>% addProviderTiles("Esri.OceanBasemap") %>% 

  addMarkers(lng = ~LNG, lat = ~LAT,clusterOptions = markerClusterOptions()) %>%

  # controls

  setView(lng=center_lon, lat=center_lat,zoom = 6) 





```



##Distribution of Schools in Florida with Cluster Markers



`Tampa` , `Orlando` and `Miami` have a high number of schools.           



```{r,message=FALSE,warning=FALSE}





schools_coords_FL = schools_coords %>%

  filter(`School State`== "Florida")



center_lon = median(schools_coords_FL$LNG,na.rm = TRUE)

center_lat = median(schools_coords_FL$LAT,na.rm = TRUE)



schools_coords_FL %>% leaflet() %>% addProviderTiles("Esri.OceanBasemap") %>% 

  addMarkers(lng = ~LNG, lat = ~LAT,clusterOptions = markerClusterOptions()) %>%

  # controls

  setView(lng=center_lon, lat=center_lat,zoom = 6) 



```



##Distribution of Schools in Texas with Cluster Markers



`Austin` , `San Antonio` and `Dallas` have a high number of schools.           



```{r,message=FALSE,warning=FALSE}





schools_coords_TX = schools_coords %>%

  filter(`School State`== "Texas")



center_lon = median(schools_coords_TX$LNG,na.rm = TRUE)

center_lat = median(schools_coords_TX$LAT,na.rm = TRUE)



schools_coords_TX %>% leaflet() %>% addProviderTiles("Esri.OceanBasemap") %>% 

  addMarkers(lng = ~LNG, lat = ~LAT,clusterOptions = markerClusterOptions()) %>%

  # controls

  setView(lng=center_lon, lat=center_lat,zoom = 6) 



```



##School Percentage Free Lunch Analysis





### Distribution of School Percentage Free Lunch Analysis



```{r,message=FALSE,warning=FALSE}



schools %>%

  rename(FreeLunch = `School Percentage Free Lunch`) %>%

  ggplot(aes(x = FreeLunch)) +

  geom_histogram(bins = 30,fill = fillColor) +

  labs(x= 'School Percentage Free Lunch',y = 'Count', title = paste("Distribution of", ' School Percentage Free Lunch ')) +

  theme_bw()



summary(schools %>%

          rename(FreeLunch = `School Percentage Free Lunch`) %>%

          select(FreeLunch) )



```



### States with the Highest Free Lunch Percentage



`District of Columbia` , `Missippi`, `Louisiana` , `New Mexico` , `Georgia`  are the states with the Highest Free Lunch Percentage            





```{r,message=FALSE,warning=FALSE}



schools %>%

  rename(FreeLunch = `School Percentage Free Lunch`,

         SchoolState = `School State`) %>%

  filter(!is.na(FreeLunch)) %>%

  filter(!is.na(SchoolState)) %>%

  group_by(SchoolState) %>%

  summarise(MedianSchoolLunch = median(FreeLunch,na.rm = TRUE)) %>%

  arrange(desc(MedianSchoolLunch)) %>%

  ungroup() %>%

  mutate(SchoolState = reorder(SchoolState,MedianSchoolLunch)) %>%

  head(10) %>%

  

  ggplot(aes(x = SchoolState,y = MedianSchoolLunch)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = SchoolState, y = 0.2, label = paste0("( ",round(MedianSchoolLunch,2)," )",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'SchoolState', 

       y = 'Median Free Luch Percentage', 

       title = 'SchoolState and Median Free Lunch Percentage') +

  coord_flip() +

  theme_bw()

```



### States with the Lowest Free Lunch Percentage



`Wisconsin` , `New Jersey` , `Vermont` , `Massachusetts` , `Iowa` are the states with Lowest free Lunch Percentage        



```{r,message=FALSE,warning=FALSE}



schools %>%

  rename(FreeLunch = `School Percentage Free Lunch`,

         SchoolState = `School State`) %>%

  filter(!is.na(FreeLunch)) %>%

  filter(!is.na(SchoolState)) %>%

  group_by(SchoolState) %>%

  summarise(MedianSchoolLunch = median(FreeLunch,na.rm = TRUE)) %>%

  arrange(desc(MedianSchoolLunch)) %>%

  ungroup() %>%

  mutate(SchoolState = reorder(SchoolState,MedianSchoolLunch)) %>%

  tail(10) %>%

  

  ggplot(aes(x = SchoolState,y = MedianSchoolLunch)) +

  geom_bar(stat='identity',fill= fillColorLightCoral) +

  geom_text(aes(x = SchoolState, y = 0.2, label = paste0("( ",round(MedianSchoolLunch,2)," )",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'SchoolState', 

       y = 'Median Free Luch Percentage', 

       title = 'SchoolState and Median Free Lunch Percentage') +

  coord_flip() +

  theme_bw()



```





#Projects Analysis



```{r,message=FALSE,warning=FALSE}



projects <- projects %>%

  rename(ProjectType = `Project Type`) %>%

  rename(Category = `Project Subject Category Tree`) %>%

  rename(SubCategory =`Project Subject Subcategory Tree`) %>%

  rename(Grade =`Project Grade Level Category`) %>%

  rename(ResourceCategory = `Project Resource Category`) %>%

  rename(Cost = `Project Cost`) %>%

  rename(PostedDate = `Project Posted Date`) %>%

  rename(CurrentStatus = `Project Current Status`) %>%

  rename(FullyFundedDate = `Project Fully Funded Date`)

  



TotalNoOfRows = nrow(projects)



```





##Project Current Status distribution



Most of the projects in the dataset are `Fully Funded`          



```{r,message=FALSE,warning=FALSE}



projects %>%

  filter(!is.na(CurrentStatus)) %>%

  group_by(CurrentStatus) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(CurrentStatus = reorder(CurrentStatus,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = CurrentStatus,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = CurrentStatus, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Project Current Status', 

       y = 'Percentage', 

       title = 'Project Current Status and Percentage') +

   coord_flip() +

     theme_bw()





```





##Project Type distribution



`98%` of the Projects are `Teacher Led`           





```{r,message=FALSE,warning=FALSE}



unique(projects$ProjectType)





projects %>%

  filter(ProjectType %in% c("Teacher-Led","Professional Development","Student-Led","Supplies",

                            "Special Needs","Classroom Basics","Environmental Science, Literacy")) %>%

  group_by(ProjectType) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(ProjectType = reorder(ProjectType,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = ProjectType,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = ProjectType, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'ProjectType', 

       y = 'Percentage', 

       title = 'ProjectType and Percentage') +

   coord_flip() +

     theme_bw()



```



##Project Category Distribution               



`Literacy and Language` , `Math and Science` are the categories of projects which are most requested            





```{r,message=FALSE,warning=FALSE}



projects %>%

  filter(!is.na(Category)) %>%

  group_by(Category) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(Category = reorder(Category,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = Category,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = Category, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Project Category', 

       y = 'Percentage', 

       title = 'Project Category and Percentage') +

   coord_flip() +

     theme_bw()





```





##Project SubCategory Distribution    



`Literacy,Mathematics` , `Literacy` , `Literacy , Literature and Writing` are the subcategories of projects which are most requested         



```{r,message=FALSE,warning=FALSE}



projects %>%

  filter(!is.na(SubCategory)) %>%

  group_by(SubCategory) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(SubCategory = reorder(SubCategory,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = SubCategory,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = SubCategory, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Project SubCategory', 

       y = 'Percentage', 

       title = 'Project SubCategory and Percentage') +

   coord_flip() +

     theme_bw()





```



##Project Grade Distribution    



`Pre K-2` is the most popular grade category followed by  `3-5` , `6-8` and `9-12`               



```{r,message=FALSE,warning=FALSE}



projects %>%

  filter(!is.na(Grade)) %>%

  group_by(Grade) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(Grade = reorder(Grade,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = Grade,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = Grade, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Project Grade', 

       y = 'Percentage', 

       title = 'Project Grade and Percentage') +

   coord_flip() +

     theme_bw()





```





##Project ResourceCategory Distribution



`Supplies` ,`Technology` and `Books` are the Top Resource categories requested in projects.         





```{r,message=FALSE,warning=FALSE}



projects %>%

  filter(!is.na(ResourceCategory)) %>%

  group_by(ResourceCategory) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(ResourceCategory = reorder(ResourceCategory,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = ResourceCategory,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = ResourceCategory, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Project ResourceCategory', 

       y = 'Percentage', 

       title = 'Project ResourceCategory and Percentage') +

   coord_flip() +

     theme_bw()





```



##Distribution of Project Cost



The `median` project cost is around $450 , `mean` is around $485            





```{r,message=FALSE,warning=FALSE}



projects$Cost = str_replace(projects$Cost,"\\$","")



projects$Cost = as.numeric(projects$Cost)



projects %>%

filter( Cost <= 1e3) %>%

  ggplot(aes(x = Cost)) +

  geom_histogram(bins = 30,fill = fillColor2) +

  labs(x= 'Project Cost',y = 'Count', title = paste("Distribution of", ' Project Cost ')) +

  theme_bw()



summary(projects$Cost)



```



## Projects and Fully Funded Year



We display the projects and their fully funded year



```{r,message=FALSE,warning=FALSE}



projects %>%

  filter(!is.na(FullyFundedDate)) %>%

  mutate(year = year(ymd(FullyFundedDate)))  %>%

  group_by(year) %>%

  summarise(Count = n()/1e3) %>%

  

  ggplot(aes(x = year,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  labs(x = 'Year', 

       y = 'Project Count Funded in Thousands', 

       title = 'Year at which Projects are Fully Funded') +

  theme_bw()

  



```





## Projects and Fully Funded Month



We display the projects and their fully funded month



```{r,message=FALSE,warning=FALSE}



projects %>%

  filter(!is.na(FullyFundedDate)) %>%

  mutate(month = month.abb[month(ymd(FullyFundedDate))])  %>%

  group_by(month) %>%

  summarise(Count = n()/1e3) %>%

  

  ggplot(aes(x = month,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  labs(x = 'Month', 

       y = 'Project Count Funded in Thousands', 

       title = 'Month at which Projects are Fully Funded') +

  theme_bw()





```







#Project Title WordCloud



`Learning` , `Classroom` , `Technology` , `Reading`, `students` , `books` are the main project titles           



```{r,message=FALSE,warning=FALSE}



projects <- projects %>%

  rename(ProjectTitle = `Project Title`)



createWordCloud = function(train)

{

  train %>%

    unnest_tokens(word, ProjectTitle) %>%

    filter(!word %in% stop_words$word) %>%

    count(word,sort = TRUE) %>%

    ungroup()  %>%

    head(30) %>%

    

    with(wordcloud(word, n, max.words = 30,colors=brewer.pal(8, "Dark2")))

}



createWordCloud(projects)





```



#Project Essay Analysis





##TF-IDF



We wish to find out the important words based on `Project Category`. Example for your young child , the most important word is mom. Example for a bar tender , important words would be related to drinks.



We would explore this using a fascinating concept known as Term Frequency - Inverse Document Frequency. Quite a mouthful, but we will unpack it and clarify each and every term.



A document in this case is the set of lines associated with a `Project category`.



Therefore we have different documents for each `Project category`





##Twenty Most Important words



Here using **TF-IDF** , we investigate the **Twenty** Most Important words. `Piano` , `iditarod` , `drums` , `sensorimeter` and `tubano` are the most important words.           





```{r,message=FALSE,warning=FALSE}



projects_sample <- sample_n(projects,5e3)



projects_sampleWords <- projects_sample %>%

  unnest_tokens(word, `Project Essay`) %>%

  filter(!word %in% stop_words$word) %>%

  count(Category, word, sort = TRUE) %>%

  ungroup()



total_words <- projects_sampleWords %>% 

  group_by(Category) %>% 

  summarize(total = sum(n))



projects_sampleWords <- left_join(projects_sampleWords, total_words)



#Now we are ready to use the bind_tf_idf which computes the tf-idf for each term. 

projects_sampleWords <- projects_sampleWords %>%

  filter(!is.na(Category)) %>%

  bind_tf_idf(word, Category, n)





plot_projects_sampleWords <- projects_sampleWords %>%

  arrange(desc(tf_idf)) %>%

  mutate(word = factor(word, levels = rev(unique(word))))



plot_projects_sampleWords %>% 

  top_n(20) %>%

  ggplot(aes(word, tf_idf)) +

  geom_col(fill = fillColor) +

  labs(x = NULL, y = "tf-idf") +

  coord_flip() +

  theme_bw()





```



##Ten most important words Category Literacy and Language



`books` , `reading` , `readers` , `read` and `book` are the five most important words for the Category **Literacy and Language**          





```{r,message=FALSE,warning=FALSE}



plot_projects_sampleWords <- projects_sampleWords %>%

  filter(Category == 'Literacy & Language') %>%

  arrange(desc(tf_idf)) %>%

  mutate(word = factor(word, levels = rev(unique(word))))



plot_projects_sampleWords %>% 

  top_n(10) %>%

  ggplot(aes(word, tf_idf)) +

  geom_col(fill = fillColorLightCoral) +

  labs(x = NULL, y = "tf-idf") +

  coord_flip() +

  theme_bw()



```



##Ten most important words Category Math and Science        



`science` , `math` , `calculators` , `coding` and `stem` are the five most important words for the category **Math and Science**         





```{r,message=FALSE,warning=FALSE}



plot_projects_sampleWords <- projects_sampleWords %>%

  filter(Category == 'Math & Science') %>%

  arrange(desc(tf_idf)) %>%

  mutate(word = factor(word, levels = rev(unique(word))))



plot_projects_sampleWords %>% 

  filter(Category == 'Math & Science') %>%

  top_n(10) %>%

  ggplot(aes(word, tf_idf)) +

  geom_col(fill = fillColor2) +

  labs(x = NULL, y = "tf-idf") +

  coord_flip() +

  theme_bw()



```





##Most Common Bigrams



A Bigram is a collection of Two words. We examine the most common Bigrams and plot them in a bar plot. 



`low income` , `students love` , `english language` , `grade students` and  `grade level` are the five most important **Bigrams**  



```{r,message=FALSE,warning=FALSE}



count_bigrams <- function(dataset) {

  dataset %>%

    unnest_tokens(bigram, `Project Essay`, token = "ngrams", n = 2) %>%

    separate(bigram, c("word1", "word2"), sep = " ") %>%

    filter(!word1 %in% stop_words$word,

           !word2 %in% stop_words$word) %>%

    count(word1, word2, sort = TRUE)

}





visualize_bigrams <- function(bigrams) {

  set.seed(2016)

  a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

  

  bigrams %>%

    graph_from_data_frame() %>%

    ggraph(layout = "fr") +

    geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = a) +

    geom_node_point(color = "lightblue", size = 5) +

    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +

    theme_void()

  

}



visualize_bigrams_individual <- function(bigrams) {

  set.seed(2016)

  a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

  

  bigrams %>%

    graph_from_data_frame() %>%

    ggraph(layout = "fr") +

    geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = a,end_cap = circle(.07, 'inches')) +

    geom_node_point(color = "lightblue", size = 5) +

    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +

    theme_void()

}



projects_sample %>%

  unnest_tokens(bigram, `Project Essay`, token = "ngrams", n = 2) %>%

  separate(bigram, c("word1", "word2"), sep = " ") %>%

  filter(!word1 %in% stop_words$word,

         !word2 %in% stop_words$word) %>%

  unite(bigramWord, word1, word2, sep = " ") %>%

  group_by(bigramWord) %>%

  tally() %>%

  ungroup() %>%

  arrange(desc(n)) %>%

  mutate(bigramWord = reorder(bigramWord,n)) %>%

  head(10) %>%

  

  ggplot(aes(x = bigramWord,y = n)) +

  geom_bar(stat='identity',colour="white", fill = fillColor) +

  geom_text(aes(x = bigramWord, y = 1, label = paste0("(",n,")",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Bigram', 

       y = 'Count', 

       title = 'Bigram and Count') +

  coord_flip() + 

  theme_bw()



```



#Most Common Trigrams



A **Trigram** is a collection of Three words. We examine the most common Trigrams and plot them in a bar plot.



`english language learners` , `students receive free`, `title 1 school` , `reduced price lunch` , `low income families`  are the five most important trigrams    



```{r,message=FALSE,warning=FALSE}



projects_sample %>%

  unnest_tokens(trigram, `Project Essay`, token = "ngrams", n = 3) %>%

  separate(trigram, c("word1", "word2","word3"), sep = " ") %>%

  filter(!word1 %in% stop_words$word,

         !word2 %in% stop_words$word,

         !word3 %in% stop_words$word) %>%

  unite(trigramWord, word1, word2, word3,sep = " ") %>%

  group_by(trigramWord) %>%

  tally() %>%

  ungroup() %>%

  arrange(desc(n)) %>%

  mutate(trigramWord = reorder(trigramWord,n)) %>%

  head(10) %>%

  

  ggplot(aes(x = trigramWord,y = n)) +

  geom_bar(stat='identity',colour="white", fill = fillColor2) +

  geom_text(aes(x = trigramWord, y = 1, label = paste0("(",n,")",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Trigram', 

       y = 'Count', 

       title = 'Trigram and Count') +

  coord_flip() + 

  theme_bw()



```







#Resource Analysis





##Most Popular Item



`Wonder` is the most popular item followed by `Scolastic News Grade 2` , `Scolastic News Grade 5/6` , `Scolastic News Grade 1`  and `Scolastic News Grade 3`         





```{r,message=FALSE,warning=FALSE}



resources <- resources %>%

  rename(UnitPrice = `Resource Unit Price`) %>%

  rename(Qty =`Resource Quantity`) %>%

  rename(ItemName = `Resource Item Name`) 

  

resources %>%

  filter(!is.na(ItemName)) %>%

  group_by(ItemName) %>%

  summarise(TotalCount = sum(Qty)) %>%

  arrange(desc(TotalCount)) %>%

  ungroup() %>%

  mutate(ItemName = reorder(ItemName,TotalCount)) %>%

  head(10) %>%

  

  ggplot(aes(x = ItemName,y = TotalCount)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = ItemName, y = 1, label = paste0("( ",TotalCount,")",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'ItemName', 

       y = 'Count', 

       title = 'ItemName and Count') +

  coord_flip() +

  theme_bw()



```



##Costliest Items



The plot shows the Top 10 Costliest Items with their Unit Price.               





```{r,message=FALSE,warning=FALSE}



resources %>%

  filter(!is.na(UnitPrice)) %>%

  group_by(ItemName) %>%

  summarise(MedianUnitPrice =  median(UnitPrice,na.rm = TRUE)) %>%

  arrange(desc(MedianUnitPrice)) %>%

  mutate(ItemName = reorder(ItemName,MedianUnitPrice)) %>%

  head(10) %>%

  

  ggplot(aes(x = ItemName,y = MedianUnitPrice)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = ItemName, y = 1, label = paste0("( ",MedianUnitPrice,")",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'ItemName', 

       y = 'Unit Price', 

       title = 'Costliest Items') +

  coord_flip() +

  theme_bw()



```





##Resource Vendor Name Distribution    



`Amazon Business` is the leading Resource Vendor followed by `Lakeshore Learning Materials` , `AKJ Education` , `Best Buy Education` and `School Speciality`              





```{r,message=FALSE,warning=FALSE}



TotalNoOfRows = nrow(resources)



resources %>%

  rename(ResourceVendorName = `Resource Vendor Name`) %>%

  filter(!is.na(ResourceVendorName)) %>%

  group_by(ResourceVendorName) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(ResourceVendorName = reorder(ResourceVendorName,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = ResourceVendorName,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = ResourceVendorName, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'Resource Vendor Name', 

       y = 'Percentage', 

       title = 'Resource Vendor Name and Percentage') +

   coord_flip() +

     theme_bw()





```





#Teachers Analysis





##Teacher Prefix Distribution    



`Mrs` is the most Popular Teacher Prefix followed by `Ms` and `Mr.`



```{r,message=FALSE,warning=FALSE}



TotalNoOfRows = nrow(teachers)



teachers %>%

  rename(TeacherPrefix = `Teacher Prefix`) %>%

  filter(!is.na(TeacherPrefix)) %>%

  group_by(TeacherPrefix) %>%

  summarise(Count = n()/TotalNoOfRows *100) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(TeacherPrefix = reorder(TeacherPrefix,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = TeacherPrefix,y = Count)) +

  geom_bar(stat='identity',fill= fillColor) +

  geom_text(aes(x = TeacherPrefix, y = 1, label = paste0("( ",round(Count,2)," %)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'TeacherPrefix', 

       y = 'Percentage', 

       title = 'TeacherPrefix and Percentage') +

   coord_flip() +

     theme_bw()





```



#Projects and School Analysis



##Schools with most Fully Funded Projects



`Lincoln Elementary School` , `Washington Elementary School` , `Central Elementary School` , `Jefferson Elementary School` and `Dawes Elementary School` are schools with most Fully Funded projects.           





```{r,message=FALSE,warning=FALSE}



projects_schools = left_join(projects,schools,by="School ID")



projects_schools %>%

  rename(SchoolName = `School Name`) %>%

  filter(!is.na(SchoolName)) %>%

  filter(CurrentStatus == "Fully Funded") %>%

  group_by(SchoolName) %>%

  summarise(Count = n()/1e3) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(SchoolName = reorder(SchoolName,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = SchoolName,y = Count)) +

  geom_bar(stat='identity',fill= fillColor2) +

  geom_text(aes(x = SchoolName, y = 0.2, label = paste0("( ",round(Count,2)," Thousands)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'SchoolName', 

       y = 'Fully Funded Projects Count', 

       title = 'SchoolName and Fully Funded Projects Count') +

  coord_flip() +

  theme_bw()



```





##States with most Fully Funded Projects



`California` , `Texas` , `New York` , `Florida` and `Illinois` are the States with the most Fully Funded projects            



```{r,message=FALSE,warning=FALSE}



projects_schools %>%

  rename(SchoolState = `School State`) %>%

  filter(!is.na(SchoolState)) %>%

  filter(CurrentStatus == "Fully Funded") %>%

  group_by(SchoolState) %>%

  summarise(Count = n()/1e3) %>%

  arrange(desc(Count)) %>%

  ungroup() %>%

  mutate(SchoolState = reorder(SchoolState,Count)) %>%

  head(10) %>%

  

  ggplot(aes(x = SchoolState,y = Count)) +

  geom_bar(stat='identity',fill= fillColorLightCoral) +

  geom_text(aes(x = SchoolState, y = 0.2, label = paste0("( ",round(Count,2)," Thousands)",sep="")),

            hjust=0, vjust=.5, size = 4, colour = 'black',

            fontface = 'bold') +

  labs(x = 'SchoolState', 

       y = 'Fully Funded Projects Count', 

       title = 'SchoolState and Fully Funded Projects Count') +

  coord_flip() +

  theme_bw()



```





