library(here)
library(tidyverse)
library(janitor)
library(lubridate)


Q1 <- read_csv(here("data", "QuebradaCuenca1-Bisley.csv")) |> 
  janitor::clean_names()

Q2 <- read_csv(here("data", "QuebradaCuenca2-Bisley.csv")) |> 
  janitor::clean_names()

Q3 <- read_csv(here("data", "QuebradaCuenca3-Bisley.csv")) |> 
  janitor::clean_names()

PRM <- read_csv(here("data", "RioMameyesPuenteRoto.csv")) |> 
  janitor::clean_names()

#Merge all datasets together with full join 

Q1_Q2 <- Q1 |> 
  full_join(Q2)

Q1_Q2_Q3 <- Q1_Q2 |> 
  full_join(Q3)

Q1_Q2_Q3_PRM<- Q1_Q2_Q3 |> 
  full_join(PRM)

#Selecting for columns  

cleaned <- Q1_Q2_Q3_PRM |> 
  select(sample_id, sample_date, nh4_n, ca, mg, no3_n, k)

#creating dataframe with respect to sample_id

Q1_clean <- cleaned |> 
  filter(sample_id == "Q1") |> 
  sapply()

Q2_clean <- cleaned |> 
  filter(sample_id == "Q2")

Q3_clean <- cleaned |> 
  filter(sample_id == "Q3")

PRM_clean <- cleaned |> 
  filter(sample_id == "MPR")

