install.packages("broom")

# (2) ライブラリの読み出し
library("tidyverse")
library("broom")

# (3) データの読み込み
email_data <- read_csv("http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv")

# (4) 女性向けメールが配信されたデータを削除したデータを作成
male_df <- email_data %>%
  filter(segment != "Womens E-Mail") %>% # 女性向けメールが配信されたデータを削除
  mutate(treatment = ifelse(segment == "Mens E-Mail", 1, 0)) # 介入を表すtreatment変数を追加
