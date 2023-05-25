library(readr)
library(ggplot2)
library(patchwork)

# Read in data 
Table1_data <- read_csv("Crum_Langer_Table1_data.csv")

# Calculate SE from SD
Table1_data$weight_se <- Table1_data$weight_sd/sqrt(Table1_data$N)
Table1_data$bmi_se <- Table1_data$bmi_sd/sqrt(Table1_data$N)
Table1_data$body_fat_se <- Table1_data$body_fat_sd/sqrt(Table1_data$N)
Table1_data$waist_to_hip_ratio_se <- Table1_data$waist_to_hip_ratio_sd/sqrt(Table1_data$N)
Table1_data$systolic_bp_se <- Table1_data$systolic_bp_sd/sqrt(Table1_data$N)
Table1_data$diastolic_bp_se <- Table1_data$diastolic_bp_sd/sqrt(Table1_data$N)

# Make a function to plot each subplot 
plotCrum <- function (mydata, yVar, ySE, yLabel){
  ggplot(data = mydata, aes(x=time, y={{yVar}}, group = condition, colour=condition)) + 
    geom_errorbar(aes(ymin={{yVar}}-{{ySE}}, ymax={{yVar}}+{{ySE}}), width=.1) +
    geom_line() +
    geom_point()+
    scale_color_grey() +
    ylab(yLabel) +
    scale_x_discrete(labels = c("Time 1", "Time 2"))+ 
    labs(x = "")+
    theme_classic()
} 
# This is currently not working and I don't know why, GRRR
## UPDATE! The answer was curly brackets round the variables, go figure! 


# Weight 

 weight_plot <- plotCrum(Table1_data, weight, weight_se, "Weight (lb)") +  theme(legend.position="none")  

# BMI

bmi_plot <- plotCrum(Table1_data, bmi, bmi_se, "Body Mass Index")+   ylim(25, 28) +  theme(legend.position="none")  

# Body fat percentage

body_fat_plot <- plotCrum(Table1_data, body_fat, body_fat_se, "Percentage Body Fat")

# Waist to hip ratio

waist_hip_plot <- plotCrum(Table1_data, waist_to_hip_ratio, waist_to_hip_ratio_se, "Waist to hip ratio")+  theme(legend.position="none")  

# Systolic BP

systolic_plot <- plotCrum(Table1_data, systolic_bp, systolic_bp_se, "Systolic blood pressure")+  theme(legend.position="none")  

# Diastolic BP

diastolic_plot <- plotCrum(Table1_data, diastolic_bp, diastolic_bp_se, "Diastolic blood pressure")+  theme(legend.position="none")  


# Put plots together using patchwork package 
weight_plot + bmi_plot + body_fat_plot + waist_hip_plot + systolic_plot + diastolic_plot
