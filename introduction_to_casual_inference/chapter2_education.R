install.packages("devtools")
devtools::install_github("itamarcaspi/experimentdatar")
#dataをimport
library("experimentdatar")
library("broom")
library("tidyverse")
data(vouchers)
vouchers


# (1) 利用するデータを持つライブラリのインストール（初回のみ）
install.packages("devtools")
devtools::install_github("itamarcaspi/experimentdatar")
# (2) ライブラリとデータの読み込み
library("experimentdatar")
library("broom")
library("tidyverse")
data(vouchers)
vouchers




formula_x_base<-"VOUCH0"
formula_x_covariate <- "SVY + HSVISIT + AGE + STRATA1 + STRATA2 + STRATA3 + STRATA4 + STRATA5 + STRATA6 + STRATAMS + D1993 + D1995 + D1997 + DMONTH1 + DMONTH2 + DMONTH3 + DMONTH4 + DMONTH5 + DMONTH6 + DMONTH7 + DMONTH8 + DMONTH9 + DMONTH10 + DMONTH11 + DMONTH12 + SEX2"
formula_y <- c("TOTSCYRS","INSCHL","PRSCH_C","USNGSCH","PRSCHA_1","FINISH6","FINISH7","FINISH8","REPT6","REPT","NREPT",
               "MARRIED","HASCHILD","HOURSUM","WORKING3")

#covariateなし/複数回帰式が生成
base_reg_formula <- paste(formula_y, "~", formula_x_base)
names(base_reg_formula) <- paste(formula_y, 
    "base", sep = "_")



### covariateあり　
covariate_reg_formula <-
  paste(formula_y, "~", formula_x_base, "+", formula_x_covariate)
class(covariate_reg_formula)
names(covariate_reg_formula) <-
  paste(formula_y, "covariate", sep = "_")

table3_fomula <- c(base_reg_formula, covariate_reg_formula)









# (3) Angrist(2002)のTable 3. bogota 1995の再現
## 回帰式の準備
### 回帰式で使う文字列の準備
formula_x_base <- "VOUCH0"
formula_x_covariate <- "SVY + HSVISIT + AGE + STRATA1 + STRATA2 + STRATA3 + STRATA4 + STRATA5 + STRATA6 + STRATAMS + D1993 + D1995 + D1997 + DMONTH1 + DMONTH2 + DMONTH3 + DMONTH4 + DMONTH5 + DMONTH6 + DMONTH7 + DMONTH8 + DMONTH9 + DMONTH10 + DMONTH11 + DMONTH12 + SEX2"
formula_y <- c("TOTSCYRS","INSCHL","PRSCH_C","USNGSCH","PRSCHA_1","FINISH6","FINISH7","FINISH8","REPT6","REPT","NREPT",
               "MARRIED","HASCHILD","HOURSUM","WORKING3")

### formula_yの各要素に対して共変量を含まない回帰式を作成
base_reg_formula <- paste(formula_y, "~", formula_x_base)
names(base_reg_formula) <- paste(formula_y, "base", sep = "_")

### formula_yの各要素に対して共変量を含む回帰式を作成
covariate_reg_formula <-
  paste(formula_y, "~", formula_x_base, "+", formula_x_covariate)
names(covariate_reg_formula) <-
  paste(formula_y, "covariate", sep = "_")

### モデル式のベクトルを作成

### モデル式のベクトルをデータフレーム化する
models <- table3_fomula %>%
  enframe(name = "model_index", value = "formula")

## 回帰分析を実行
### bogota 1995のデータを抽出する
regression_data <- vouchers %>% filter(TAB3SMPL == 1, BOG95SMP == 1)

### まとめて回帰分析を実行
df_models <- models %>%
  mutate(model = map(.x = formula,
                     .f = lm,
                     data = regression_data)) %>%
  mutate(lm_result = map(.x = model, .f = tidy))