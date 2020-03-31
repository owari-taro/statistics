#bias 
install.packages("tidyverse")
# (2) ライブラリの読み出し
library("tidyverse")
# (3) データの読み込み
email_data <- read_csv("http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv")


#%>%はlinuxのパイプラインみたいなもの
#woman を除外
male_df<-email_data%>%filter(segment!="Womans E-Mail") %>% 
    mutate(treatment=ifelse(segment=="Mens E-Mail",1,0))



#treamtあるなしでsummary
summary_by_segment<-male_df %>%group_by(treatment)%>%
    summarize(conversion_rate=mean(conversion),
    spend_mean=mean(spend),count=n())


#mailもらったひとの消費額
mens_mail_spend<-male_df%>%filter(treatment==1)%>%pull(spend)
#mailなしの消費額
no_mail_spend<-male_df %>%filter(treatment==0)%>%
    pull(spend)


var(mens_mail_spend)
var(no_mail_spned)


#等分散でのt検定
ttest<-t.test(mens_mail_spend,no_mail_spend,var.equal=T)
#等分散じゃないときも念のため
ttest_alt<-t.test(mens_mail_spend,no_mail_spend,var.equal=F)








#############################

## (b)メールが配信されなかったグループの購買データを得る
no_mail <- male_df %>%
  filter(treatment == 0) %>%
  pull(spend)

## (a)(b)の平均の差に対して有意差検定を実行する
rct_ttest <- t.test(mens_mail, no_mail, var.equal = T)

# (7) セレクションバイアスのあるデータの作成
## seedを固定する
set.seed(1)

## 条件に反応するサンプルの量を半分にする
obs_rate_c <- 0.5
obs_rate_t <- 0.5

## バイアスのあるデータの作成
biased_data <- male_df %>%
  mutate(obs_rate_c =
           ifelse( (history > 300) | (recency < 6) |
                     (channel == "Multichannel"), obs_rate_c, 1),
         obs_rate_t =
           ifelse( (history > 300) | (recency < 6) |
                     (channel == "Multichannel"), 1, obs_rate_t),
         random_number = runif(n = NROW(male_df))) %>%
  filter( (treatment == 0 & random_number < obs_rate_c ) |
            (treatment == 1 & random_number < obs_rate_t) )

# (8) セレクションバイアスのあるデータで平均を比較
## group_byとsummairseを使って集計(Biased)
summary_by_segment_biased <- biased_data %>%
  group_by(treatment) %>%
  summarise(conversion_rate = mean(conversion),
            spend_mean = mean(spend),
            count = n())

# (9) Rの関数であるt.testを使ってt検定を行う(Biased)
## (a)男性向けメールが配信されたグループの購買データを得る
mens_mail_biased <- biased_data %>%
  filter(treatment == 1) %>%
  pull(spend)