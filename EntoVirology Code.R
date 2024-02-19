devtools::install_github("https://github.com/CDCgov/PooledInfRate",build_vignettes = TRUE)

library(tidyverse)
library(dplyr)
library(gtsummary)
library(psych)
library(lubridate)
library(haven)
library(readxl)
library(openxlsx)
library(broom)
library(broom.helpers)
library(ggplot2)
library(RColorBrewer)
library(kableExtra)
library(tinytex)
library(pandoc)
library(gt)
library(DataExplorer)
library(esquisse)
library(PooledInfRate)

#Infection rate calculation

IRdf1 <- read_excel("Infection Rate dataset.xlsx")

IRdf1.1 <- IRdf1 |>
  mutate(Positive = case_when(Pos == "Negativo" ~ 0,
                              Pos == "Positivo" ~ 1))

str(IRdf1.1)

EntoVir <- pIR(Positive ~ PoolSize | Location, IRdf1.1, scale = 1000) # One-sample estimation or perfect test

summary(EntoVir)
plot(EntoVir)

VIvirology <- vectorIndex(Positive ~ PoolSize | Location / Specie:Hours, IRdf1.1)

summary(VIvirology)


#End of infection rate analysis