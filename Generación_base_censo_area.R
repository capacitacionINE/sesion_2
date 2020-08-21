library(readxl)
library(openxlsx)
library(dplyr)

censo <- read_excel(path = "data/Resultados_censo.xls",
                    sheet = 2)
mujeres1 <- censo %>%
  select(CÓDIGO_REGIÓN,
         EDAD,
         MUJERES_RURAL) %>%
  mutate(area = 2,
         sexo = 2) %>%
  filter(CÓDIGO_REGIÓN != "País" & EDAD != "Total País" & EDAD != "Total Región") %>%
  rename(n = MUJERES_RURAL)
mujeres2 <- censo %>%
  select(CÓDIGO_REGIÓN,
         EDAD,
         MUJERES_URBANA) %>%
  mutate(area = 1,
         sexo = 2) %>%
  filter(CÓDIGO_REGIÓN != "País" & EDAD != "Total País" & EDAD != "Total Región") %>%
  rename(n = MUJERES_URBANA)
mujeres <-  rbind(mujeres1,mujeres2)
hombres1 <- censo %>%
  select(CÓDIGO_REGIÓN,
         EDAD,
         HOMBRES_RURAL) %>%
  mutate(area = 2,
         sexo = 1) %>%
  filter(CÓDIGO_REGIÓN != "País" & EDAD != "Total País" & EDAD != "Total Región") %>%
  rename(n = HOMBRES_RURAL)
hombres2 <- censo %>%
  select(CÓDIGO_REGIÓN,
         EDAD,
         HOMBRES_URBANA) %>%
  mutate(area = 1,
         sexo = 1) %>%
  filter(CÓDIGO_REGIÓN != "País" & EDAD != "Total País" & EDAD != "Total Región") %>%
  rename(n = HOMBRES_URBANA)
hombres <-  rbind(hombres1,hombres2)

base  <-  rbind(mujeres,hombres)
names(base) <- toupper(names(base))

save(list = c("base"),file = "data/Censo_area.RData")