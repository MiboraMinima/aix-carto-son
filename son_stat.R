library(tidyverse)
library(hrbrthemes)
install.packages("hrbrthemes")

df_son_ap <- as_tibble(bal_son_ap)
df_son_soir <- as_tibble(bal_son_soir)
son_stat <- left_join(df_son_ap, df_son_soir, "label") 

son_stat %<>%
  select(label, son_dom.x, son_dom.y, amb_pay.x, sous_cat.x, sous_cat.y) %>%
  rename(
    son_dom_ap = son_dom.x,
    son_dom_soir = son_dom.y,
    sous_cat_ap = sous_cat.x,
    sous_cat_soir = sous_cat.y,
    amb_pay = amb_pay.x
  ) %>%
  filter(!(label %in% c("Z_0", "Z_1", "Z_2")))

## Son dominant ----
son_dom_stat <- son_stat %>%
  select(son_dom_ap, son_dom_soir) %>%
  pivot_longer(
    cols = 1:2,
    names_to = "horaire"
  ) %>%
  count(horaire, value)

son_dom_stat$horaire <- factor(son_dom_stat$horaire, levels = c("son_dom_ap", "son_dom_soir"), labels = c("Après-midi (14h)", "Soir (21h30)"))

ggplot(son_dom_stat, aes(x=value, y=n, fill=horaire)) +
  geom_bar(position="dodge",
           stat="identity") +
  labs(
    title="Nature du son dominant pour les deux ballades",
    y = "Nombre",
    x = "Nature du son"
  )
  
## Sous Cat ----
sous_cat_stat <- son_stat %>%
  select(sous_cat_ap, sous_cat_soir) %>%
  pivot_longer(
    cols = 1:2,
    names_to = "horaire"
  ) %>%
  count(horaire, value)

sous_cat_stat$horaire <- factor(sous_cat_stat$horaire, levels = c("sous_cat_ap", "sous_cat_soir"), labels = c("Après-midi (14h)", "Soir (21h30)"))

ggplot(sous_cat_stat, aes(x=value, y=n, fill=horaire))+
  geom_bar(position="dodge",
           stat="identity") +
  labs(
    title="Nature du son dominant pour les deux ballades",
    y = "Nombre",
    x = "Nature du son"
  ) +
  coord_flip()


# Test chi2

test_chi <- son_stat %>%
  filter(amb_pay != "fosse_stCa")

fisher.test(table(test_chi$son_dom_ap, test_chi$amb_pay))

t_son_dom_stat <- table(son_stat$son_dom_ap, son_stat$amb_pay)

fisher.test(table(son_stat$son_dom_ap, son_stat$amb_pay))

library(kableExtra)
library(kable)
t_son_dom_stat %>%
  kbl()

devtools::install_github("haozhu233/kableExtra")
install.packages("devtools")



