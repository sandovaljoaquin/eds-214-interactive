library(here)
library(tidyverse)
library(janitor)
library(lubridate)
library(zoo)
library(patchwork)

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


cleaner <- cleaned |> 
group_by(sample_id) |> 
  filter(sample_date > "1988-01-01" & sample_date < "1995-01-01") |> 
  mutate(nh4_avg = rollmean(nh4_n, k = 1, fill = 0))|> 
  mutate(ca_avg = rollmean(ca, k = 9, fill = 0)) |> 
  mutate(mg_avg = rollmean(mg, k = 9, fill = 0)) |> 
  mutate(no3_n_avg = rollmean(no3_n, k = 9, fill = 0)) |> 
  mutate(k_avg = rollmean(k, k = 9, fill = 0))
  

#NH4

nh4_plot <- ggplot(data = cleaner, 
       aes(x = sample_date, 
           y = nh4_avg)) + 
         geom_line(aes(color = sample_id)) + 
  geom_vline(xintercept = as.Date("1989-09-10"), linetype = "solid")
  
#Ca

ca_plot <- ggplot(data = cleaner, 
       aes(x = sample_date, 
           y = ca_avg)) + 
  geom_line(aes(color = sample_id)) + 
  geom_vline(xintercept = as.Date("1989-09-10"), linetype = "solid")


#Mg

mg_plot <- ggplot(data = cleaner, 
       aes(x = sample_date, 
           y = mg_avg)) + 
  geom_line(aes(color = sample_id)) + 
  geom_vline(xintercept = as.Date("1989-09-10"), linetype = "solid")

#NO3

no3_plot <- ggplot(data = cleaner, 
       aes(x = sample_date, 
           y = no3_n_avg)) + 
  geom_line(aes(color = sample_id))+ 
  geom_vline(xintercept = as.Date("1989-09-10"), linetype = "solid")

#K

k_plot <- ggplot(data = cleaner, 
       aes(x = sample_date, 
           y = k_avg)) + 
  geom_line(aes(color = sample_id)) + 
  geom_vline(xintercept = as.Date("1989-09-10"), linetype = "solid")

#all together 
k_plot/ no3_plot / mg_plot / ca_plot / nh4_plot #CREATING MERGE CONFLICT


