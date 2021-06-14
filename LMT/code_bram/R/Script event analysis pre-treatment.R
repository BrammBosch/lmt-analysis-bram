###Analysis of LMT activity data of the Ehmt1 Memantine study (2017-0048-002)
###Sqlite databases were processed with the preProcessDataBase in Icy 
###and the Rebuild_All_Event.py script (F. de Chaumont, 13 sept 2017) respectively.
###Subsequently, the databases were merged using the merge_events_iterative.py
###script (B. Bosch)

library(ggplot2)
library(stats)
library(tidyr)
library(plyr)

###-----------set working directory and read in Activity datasets----------------------------------

setwd("C:/Users/Bram/Downloads")

Events <- read.table("Eventdata_pre-treatment_for_analysis.txt",
                       as.is=T,header=T,sep="\t",quote='',na.strings=c('NA',''),fill=T)

Gr1 <- Events[Events$Group == "M1", ]
Gr1_Move_iso <- Gr1[Gr1$Event == "Move_isolated", ]
mean_nb <- mean(Gr1_Move_iso[Gr1_Move_iso$Genotype == "WT", "Amount"])
Gr1_Move_iso$Norm_amount <- c((Gr1_Move_iso$Amount[[1]]/mean_nb),
                              (Gr1_Move_iso$Amount[[2]]/mean_nb),
                              (Gr1_Move_iso$Amount[[3]]/mean_nb),
                              (Gr1_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Move_iso[Gr1_Move_iso$Genotype == "WT", "Total_time"])
Gr1_Move_iso$Norm_time <- c((Gr1_Move_iso$Total_time[[1]]/mean_time),
                              (Gr1_Move_iso$Total_time[[2]]/mean_time),
                              (Gr1_Move_iso$Total_time[[3]]/mean_time),
                              (Gr1_Move_iso$Total_time[[4]]/mean_time))

Gr1_Stop_iso <- Gr1[Gr1$Event == "Stop_isolated", ]
mean_nb <- mean(Gr1_Stop_iso[Gr1_Stop_iso$Genotype == "WT", "Amount"])
Gr1_Stop_iso$Norm_amount <- c((Gr1_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr1_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr1_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr1_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Stop_iso[Gr1_Stop_iso$Genotype == "WT", "Total_time"])
Gr1_Stop_iso$Norm_time <- c((Gr1_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr1_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr1_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr1_Stop_iso$Total_time[[4]]/mean_time))

Gr1_Rear_iso <- Gr1[Gr1$Event == "Rear_isolated", ]
mean_nb <- mean(Gr1_Rear_iso[Gr1_Rear_iso$Genotype == "WT", "Amount"])
Gr1_Rear_iso$Norm_amount <- c((Gr1_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr1_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr1_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr1_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Rear_iso[Gr1_Rear_iso$Genotype == "WT", "Total_time"])
Gr1_Rear_iso$Norm_time <- c((Gr1_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr1_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr1_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr1_Rear_iso$Total_time[[4]]/mean_time))

Gr1_Huddling <- Gr1[Gr1$Event == "Huddling", ]
mean_nb <- mean(Gr1_Huddling[Gr1_Huddling$Genotype == "WT", "Amount"])
Gr1_Huddling$Norm_amount <- c((Gr1_Huddling$Amount[[1]]/mean_nb),
                              (Gr1_Huddling$Amount[[2]]/mean_nb),
                              (Gr1_Huddling$Amount[[3]]/mean_nb),
                              (Gr1_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Huddling[Gr1_Huddling$Genotype == "WT", "Total_time"])
Gr1_Huddling$Norm_time <- c((Gr1_Huddling$Total_time[[1]]/mean_time),
                            (Gr1_Huddling$Total_time[[2]]/mean_time),
                            (Gr1_Huddling$Total_time[[3]]/mean_time),
                            (Gr1_Huddling$Total_time[[4]]/mean_time))

Gr1_WallJump <- Gr1[Gr1$Event == "WallJump", ]
mean_nb <- mean(Gr1_WallJump[Gr1_WallJump$Genotype == "WT", "Amount"])
Gr1_WallJump$Norm_amount <- c((Gr1_WallJump$Amount[[1]]/mean_nb),
                              (Gr1_WallJump$Amount[[2]]/mean_nb),
                              (Gr1_WallJump$Amount[[3]]/mean_nb),
                              (Gr1_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_WallJump[Gr1_WallJump$Genotype == "WT", "Total_time"])
Gr1_WallJump$Norm_time <- c((Gr1_WallJump$Total_time[[1]]/mean_time),
                            (Gr1_WallJump$Total_time[[2]]/mean_time),
                            (Gr1_WallJump$Total_time[[3]]/mean_time),
                            (Gr1_WallJump$Total_time[[4]]/mean_time))

Gr1_SAP <- Gr1[Gr1$Event == "SAP", ]
mean_nb <- mean(Gr1_SAP[Gr1_SAP$Genotype == "WT", "Amount"])
Gr1_SAP$Norm_amount <- c((Gr1_SAP$Amount[[1]]/mean_nb),
                         (Gr1_SAP$Amount[[2]]/mean_nb),
                         (Gr1_SAP$Amount[[3]]/mean_nb),
                         (Gr1_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_SAP[Gr1_SAP$Genotype == "WT", "Total_time"])
Gr1_SAP$Norm_time <- c((Gr1_SAP$Total_time[[1]]/mean_time),
                       (Gr1_SAP$Total_time[[2]]/mean_time),
                       (Gr1_SAP$Total_time[[3]]/mean_time),
                       (Gr1_SAP$Total_time[[4]]/mean_time))

Gr1_Move_contact <- Gr1[Gr1$Event == "Move_contact", ]
mean_nb <- mean(Gr1_Move_contact[Gr1_Move_contact$Genotype == "WT", "Amount"])
Gr1_Move_contact$Norm_amount <- c((Gr1_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr1_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr1_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr1_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Move_contact[Gr1_Move_contact$Genotype == "WT", "Total_time"])
Gr1_Move_contact$Norm_time <- c((Gr1_Move_contact$Total_time[[1]]/mean_time),
                                (Gr1_Move_contact$Total_time[[2]]/mean_time),
                                (Gr1_Move_contact$Total_time[[3]]/mean_time),
                                (Gr1_Move_contact$Total_time[[4]]/mean_time))

Gr1_Stop_contact <- Gr1[Gr1$Event == "Stop_contact", ]
mean_nb <- mean(Gr1_Stop_contact[Gr1_Stop_contact$Genotype == "WT", "Amount"])
Gr1_Stop_contact$Norm_amount <- c((Gr1_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr1_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr1_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr1_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Stop_contact[Gr1_Stop_contact$Genotype == "WT", "Total_time"])
Gr1_Stop_contact$Norm_time <- c((Gr1_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr1_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr1_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr1_Stop_contact$Total_time[[4]]/mean_time))

Gr1_Rear_contact <- Gr1[Gr1$Event == "Rear_contact", ]
mean_nb <- mean(Gr1_Rear_contact[Gr1_Rear_contact$Genotype == "WT", "Amount"])
Gr1_Rear_contact$Norm_amount <- c((Gr1_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr1_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr1_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr1_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Rear_contact[Gr1_Rear_contact$Genotype == "WT", "Total_time"])
Gr1_Rear_contact$Norm_time <- c((Gr1_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr1_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr1_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr1_Rear_contact$Total_time[[4]]/mean_time))

Gr1_SbS_contact <- Gr1[Gr1$Event == "SbS_contact", ]
mean_nb <- mean(Gr1_SbS_contact[Gr1_SbS_contact$Genotype == "WT", "Amount"])
Gr1_SbS_contact$Norm_amount <- c((Gr1_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr1_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr1_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr1_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_SbS_contact[Gr1_SbS_contact$Genotype == "WT", "Total_time"])
Gr1_SbS_contact$Norm_time <- c((Gr1_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr1_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr1_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr1_SbS_contact$Total_time[[4]]/mean_time))

Gr1_SbSO_contact <- Gr1[Gr1$Event == "SbSO_contact", ]
mean_nb <- mean(Gr1_SbSO_contact[Gr1_SbSO_contact$Genotype == "WT", "Amount"])
Gr1_SbSO_contact$Norm_amount <- c((Gr1_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr1_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr1_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr1_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_SbSO_contact[Gr1_SbSO_contact$Genotype == "WT", "Total_time"])
Gr1_SbSO_contact$Norm_time <- c((Gr1_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr1_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr1_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr1_SbSO_contact$Total_time[[4]]/mean_time))

Gr1_OO_contact <- Gr1[Gr1$Event == "OO_contact", ]
mean_nb <- mean(Gr1_OO_contact[Gr1_OO_contact$Genotype == "WT", "Amount"])
Gr1_OO_contact$Norm_amount <- c((Gr1_OO_contact$Amount[[1]]/mean_nb),
                                (Gr1_OO_contact$Amount[[2]]/mean_nb),
                                (Gr1_OO_contact$Amount[[3]]/mean_nb),
                                (Gr1_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_OO_contact[Gr1_OO_contact$Genotype == "WT", "Total_time"])
Gr1_OO_contact$Norm_time <- c((Gr1_OO_contact$Total_time[[1]]/mean_time),
                              (Gr1_OO_contact$Total_time[[2]]/mean_time),
                              (Gr1_OO_contact$Total_time[[3]]/mean_time),
                              (Gr1_OO_contact$Total_time[[4]]/mean_time))

Gr1_OG_contact <- Gr1[Gr1$Event == "OG_contact", ]
mean_nb <- mean(Gr1_OG_contact[Gr1_OG_contact$Genotype == "WT", "Amount"])
Gr1_OG_contact$Norm_amount <- c((Gr1_OG_contact$Amount[[1]]/mean_nb),
                                (Gr1_OG_contact$Amount[[2]]/mean_nb),
                                (Gr1_OG_contact$Amount[[3]]/mean_nb),
                                (Gr1_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_OG_contact[Gr1_OG_contact$Genotype == "WT", "Total_time"])
Gr1_OG_contact$Norm_time <- c((Gr1_OG_contact$Total_time[[1]]/mean_time),
                              (Gr1_OG_contact$Total_time[[2]]/mean_time),
                              (Gr1_OG_contact$Total_time[[3]]/mean_time),
                              (Gr1_OG_contact$Total_time[[4]]/mean_time))

Gr1_Social_approach <- Gr1[Gr1$Event == "Social_approach", ]
mean_nb <- mean(Gr1_Social_approach[Gr1_Social_approach$Genotype == "WT", "Amount"])
Gr1_Social_approach$Norm_amount <- c((Gr1_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr1_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr1_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr1_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Social_approach[Gr1_Social_approach$Genotype == "WT", "Total_time"])
Gr1_Social_approach$Norm_time <- c((Gr1_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr1_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr1_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr1_Social_approach$Total_time[[4]]/mean_time))

Gr1_Approach_rear <- Gr1[Gr1$Event == "Approach_rear", ]
mean_nb <- mean(Gr1_Approach_rear[Gr1_Approach_rear$Genotype == "WT", "Amount"])
Gr1_Approach_rear$Norm_amount <- c((Gr1_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr1_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr1_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr1_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Approach_rear[Gr1_Approach_rear$Genotype == "WT", "Total_time"])
Gr1_Approach_rear$Norm_time <- c((Gr1_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr1_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr1_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr1_Approach_rear$Total_time[[4]]/mean_time))

Gr1_Contact <- Gr1[Gr1$Event == "Contact", ]
mean_nb <- mean(Gr1_Contact[Gr1_Contact$Genotype == "WT", "Amount"])
Gr1_Contact$Norm_amount <- c((Gr1_Contact$Amount[[1]]/mean_nb),
                             (Gr1_Contact$Amount[[2]]/mean_nb),
                             (Gr1_Contact$Amount[[3]]/mean_nb),
                             (Gr1_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Contact[Gr1_Contact$Genotype == "WT", "Total_time"])
Gr1_Contact$Norm_time <- c((Gr1_Contact$Total_time[[1]]/mean_time),
                           (Gr1_Contact$Total_time[[2]]/mean_time),
                           (Gr1_Contact$Total_time[[3]]/mean_time),
                           (Gr1_Contact$Total_time[[4]]/mean_time))

Gr1_Get_away <- Gr1[Gr1$Event == "Get_away", ]
mean_nb <- mean(Gr1_Get_away[Gr1_Get_away$Genotype == "WT", "Amount"])
Gr1_Get_away$Norm_amount <- c((Gr1_Get_away$Amount[[1]]/mean_nb),
                              (Gr1_Get_away$Amount[[2]]/mean_nb),
                              (Gr1_Get_away$Amount[[3]]/mean_nb),
                              (Gr1_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Get_away[Gr1_Get_away$Genotype == "WT", "Total_time"])
Gr1_Get_away$Norm_time <- c((Gr1_Get_away$Total_time[[1]]/mean_time),
                            (Gr1_Get_away$Total_time[[2]]/mean_time),
                            (Gr1_Get_away$Total_time[[3]]/mean_time),
                            (Gr1_Get_away$Total_time[[4]]/mean_time))

Gr1_Break_contact <- Gr1[Gr1$Event == "Break_contact", ]
mean_nb <- mean(Gr1_Break_contact[Gr1_Break_contact$Genotype == "WT", "Amount"])
Gr1_Break_contact$Norm_amount <- c((Gr1_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr1_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr1_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr1_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Break_contact[Gr1_Break_contact$Genotype == "WT", "Total_time"])
Gr1_Break_contact$Norm_time <- c((Gr1_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr1_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr1_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr1_Break_contact$Total_time[[4]]/mean_time))

Gr1_Train2 <- Gr1[Gr1$Event == "Train2", ]
mean_nb <- mean(Gr1_Train2[Gr1_Train2$Genotype == "WT", "Amount"])
Gr1_Train2$Norm_amount <- c((Gr1_Train2$Amount[[1]]/mean_nb),
                            (Gr1_Train2$Amount[[2]]/mean_nb),
                            (Gr1_Train2$Amount[[3]]/mean_nb),
                            (Gr1_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Train2[Gr1_Train2$Genotype == "WT", "Total_time"])
Gr1_Train2$Norm_time <- c((Gr1_Train2$Total_time[[1]]/mean_time),
                          (Gr1_Train2$Total_time[[2]]/mean_time),
                          (Gr1_Train2$Total_time[[3]]/mean_time),
                          (Gr1_Train2$Total_time[[4]]/mean_time))

Gr1_Group3make <- Gr1[Gr1$Event == "Group3make", ]
mean_nb <- mean(Gr1_Group3make[Gr1_Group3make$Genotype == "WT", "Amount"])
Gr1_Group3make$Norm_amount <- c((Gr1_Group3make$Amount[[1]]/mean_nb),
                                (Gr1_Group3make$Amount[[2]]/mean_nb),
                                (Gr1_Group3make$Amount[[3]]/mean_nb),
                                (Gr1_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Group3make[Gr1_Group3make$Genotype == "WT", "Total_time"])
Gr1_Group3make$Norm_time <- c((Gr1_Group3make$Total_time[[1]]/mean_time),
                              (Gr1_Group3make$Total_time[[2]]/mean_time),
                              (Gr1_Group3make$Total_time[[3]]/mean_time),
                              (Gr1_Group3make$Total_time[[4]]/mean_time))

Gr1_Group3break <- Gr1[Gr1$Event == "Group3break", ]
mean_nb <- mean(Gr1_Group3break[Gr1_Group3break$Genotype == "WT", "Amount"])
Gr1_Group3break$Norm_amount <- c((Gr1_Group3break$Amount[[1]]/mean_nb),
                                 (Gr1_Group3break$Amount[[2]]/mean_nb),
                                 (Gr1_Group3break$Amount[[3]]/mean_nb),
                                 (Gr1_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Group3break[Gr1_Group3break$Genotype == "WT", "Total_time"])
Gr1_Group3break$Norm_time <- c((Gr1_Group3break$Total_time[[1]]/mean_time),
                               (Gr1_Group3break$Total_time[[2]]/mean_time),
                               (Gr1_Group3break$Total_time[[3]]/mean_time),
                               (Gr1_Group3break$Total_time[[4]]/mean_time))

Gr1_Group4make <- Gr1[Gr1$Event == "Group4make", ]
mean_nb <- mean(Gr1_Group4make[Gr1_Group4make$Genotype == "WT", "Amount"])
Gr1_Group4make$Norm_amount <- c((Gr1_Group4make$Amount[[1]]/mean_nb),
                                (Gr1_Group4make$Amount[[2]]/mean_nb),
                                (Gr1_Group4make$Amount[[3]]/mean_nb),
                                (Gr1_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Group4make[Gr1_Group4make$Genotype == "WT", "Total_time"])
Gr1_Group4make$Norm_time <- c((Gr1_Group4make$Total_time[[1]]/mean_time),
                              (Gr1_Group4make$Total_time[[2]]/mean_time),
                              (Gr1_Group4make$Total_time[[3]]/mean_time),
                              (Gr1_Group4make$Total_time[[4]]/mean_time))

Gr1_Group4break <- Gr1[Gr1$Event == "Group4break", ]
mean_nb <- mean(Gr1_Group4break[Gr1_Group4break$Genotype == "WT", "Amount"])
Gr1_Group4break$Norm_amount <- c((Gr1_Group4break$Amount[[1]]/mean_nb),
                                 (Gr1_Group4break$Amount[[2]]/mean_nb),
                                 (Gr1_Group4break$Amount[[3]]/mean_nb),
                                 (Gr1_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr1_Group4break[Gr1_Group4break$Genotype == "WT", "Total_time"])
Gr1_Group4break$Norm_time <- c((Gr1_Group4break$Total_time[[1]]/mean_time),
                               (Gr1_Group4break$Total_time[[2]]/mean_time),
                               (Gr1_Group4break$Total_time[[3]]/mean_time),
                               (Gr1_Group4break$Total_time[[4]]/mean_time))

Gr1_norm <- rbind(Gr1_Move_iso,Gr1_Stop_iso,Gr1_Rear_iso,Gr1_Huddling,
                  Gr1_WallJump,Gr1_SAP, Gr1_Move_contact,Gr1_Stop_contact,
                  Gr1_Rear_contact,Gr1_SbS_contact,Gr1_SbSO_contact,
                  Gr1_OO_contact,Gr1_OG_contact,Gr1_Social_approach,
                  Gr1_Approach_rear,Gr1_Contact,Gr1_Get_away,
                  Gr1_Break_contact,Gr1_Train2,Gr1_Group3make,
                  Gr1_Group3break,Gr1_Group4make,Gr1_Group4break)

rm(Gr1_Move_iso,Gr1_Stop_iso,Gr1_Rear_iso,Gr1_Huddling,
                  Gr1_WallJump,Gr1_SAP, Gr1_Move_contact,Gr1_Stop_contact,
                  Gr1_Rear_contact,Gr1_SbS_contact,Gr1_SbSO_contact,
                  Gr1_OO_contact,Gr1_OG_contact,Gr1_Social_approach,
                  Gr1_Approach_rear,Gr1_Contact,Gr1_Get_away,
                  Gr1_Break_contact,Gr1_Train2,Gr1_Group3make,
                  Gr1_Group3break,Gr1_Group4make,Gr1_Group4break)

Gr2 <- Events[Events$Group == "M2", ]
Gr2_Move_iso <- Gr2[Gr2$Event == "Move_isolated", ]
mean_nb <- mean(Gr2_Move_iso[Gr2_Move_iso$Genotype == "WT", "Amount"])
Gr2_Move_iso$Norm_amount <- c((Gr2_Move_iso$Amount[[1]]/mean_nb),
                              (Gr2_Move_iso$Amount[[2]]/mean_nb),
                              (Gr2_Move_iso$Amount[[3]]/mean_nb),
                              (Gr2_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Move_iso[Gr2_Move_iso$Genotype == "WT", "Total_time"])
Gr2_Move_iso$Norm_time <- c((Gr2_Move_iso$Total_time[[1]]/mean_time),
                            (Gr2_Move_iso$Total_time[[2]]/mean_time),
                            (Gr2_Move_iso$Total_time[[3]]/mean_time),
                            (Gr2_Move_iso$Total_time[[4]]/mean_time))

Gr2_Stop_iso <- Gr2[Gr2$Event == "Stop_isolated", ]
mean_nb <- mean(Gr2_Stop_iso[Gr2_Stop_iso$Genotype == "WT", "Amount"])
Gr2_Stop_iso$Norm_amount <- c((Gr2_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr2_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr2_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr2_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Stop_iso[Gr2_Stop_iso$Genotype == "WT", "Total_time"])
Gr2_Stop_iso$Norm_time <- c((Gr2_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr2_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr2_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr2_Stop_iso$Total_time[[4]]/mean_time))

Gr2_Rear_iso <- Gr2[Gr2$Event == "Rear_isolated", ]
mean_nb <- mean(Gr2_Rear_iso[Gr2_Rear_iso$Genotype == "WT", "Amount"])
Gr2_Rear_iso$Norm_amount <- c((Gr2_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr2_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr2_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr2_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Rear_iso[Gr2_Rear_iso$Genotype == "WT", "Total_time"])
Gr2_Rear_iso$Norm_time <- c((Gr2_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr2_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr2_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr2_Rear_iso$Total_time[[4]]/mean_time))

Gr2_Huddling <- Gr2[Gr2$Event == "Huddling", ]
mean_nb <- mean(Gr2_Huddling[Gr2_Huddling$Genotype == "WT", "Amount"])
Gr2_Huddling$Norm_amount <- c((Gr2_Huddling$Amount[[1]]/mean_nb),
                              (Gr2_Huddling$Amount[[2]]/mean_nb),
                              (Gr2_Huddling$Amount[[3]]/mean_nb),
                              (Gr2_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Huddling[Gr2_Huddling$Genotype == "WT", "Total_time"])
Gr2_Huddling$Norm_time <- c((Gr2_Huddling$Total_time[[1]]/mean_time),
                            (Gr2_Huddling$Total_time[[2]]/mean_time),
                            (Gr2_Huddling$Total_time[[3]]/mean_time),
                            (Gr2_Huddling$Total_time[[4]]/mean_time))

Gr2_WallJump <- Gr2[Gr2$Event == "WallJump", ]
mean_nb <- mean(Gr2_WallJump[Gr2_WallJump$Genotype == "WT", "Amount"])
Gr2_WallJump$Norm_amount <- c((Gr2_WallJump$Amount[[1]]/mean_nb),
                              (Gr2_WallJump$Amount[[2]]/mean_nb),
                              (Gr2_WallJump$Amount[[3]]/mean_nb),
                              (Gr2_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_WallJump[Gr2_WallJump$Genotype == "WT", "Total_time"])
Gr2_WallJump$Norm_time <- c((Gr2_WallJump$Total_time[[1]]/mean_time),
                            (Gr2_WallJump$Total_time[[2]]/mean_time),
                            (Gr2_WallJump$Total_time[[3]]/mean_time),
                            (Gr2_WallJump$Total_time[[4]]/mean_time))

Gr2_SAP <- Gr2[Gr2$Event == "SAP", ]
mean_nb <- mean(Gr2_SAP[Gr2_SAP$Genotype == "WT", "Amount"])
Gr2_SAP$Norm_amount <- c((Gr2_SAP$Amount[[1]]/mean_nb),
                         (Gr2_SAP$Amount[[2]]/mean_nb),
                         (Gr2_SAP$Amount[[3]]/mean_nb),
                         (Gr2_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_SAP[Gr2_SAP$Genotype == "WT", "Total_time"])
Gr2_SAP$Norm_time <- c((Gr2_SAP$Total_time[[1]]/mean_time),
                       (Gr2_SAP$Total_time[[2]]/mean_time),
                       (Gr2_SAP$Total_time[[3]]/mean_time),
                       (Gr2_SAP$Total_time[[4]]/mean_time))

Gr2_Move_contact <- Gr2[Gr2$Event == "Move_contact", ]
mean_nb <- mean(Gr2_Move_contact[Gr2_Move_contact$Genotype == "WT", "Amount"])
Gr2_Move_contact$Norm_amount <- c((Gr2_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr2_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr2_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr2_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Move_contact[Gr2_Move_contact$Genotype == "WT", "Total_time"])
Gr2_Move_contact$Norm_time <- c((Gr2_Move_contact$Total_time[[1]]/mean_time),
                                (Gr2_Move_contact$Total_time[[2]]/mean_time),
                                (Gr2_Move_contact$Total_time[[3]]/mean_time),
                                (Gr2_Move_contact$Total_time[[4]]/mean_time))

Gr2_Stop_contact <- Gr2[Gr2$Event == "Stop_contact", ]
mean_nb <- mean(Gr2_Stop_contact[Gr2_Stop_contact$Genotype == "WT", "Amount"])
Gr2_Stop_contact$Norm_amount <- c((Gr2_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr2_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr2_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr2_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Stop_contact[Gr2_Stop_contact$Genotype == "WT", "Total_time"])
Gr2_Stop_contact$Norm_time <- c((Gr2_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr2_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr2_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr2_Stop_contact$Total_time[[4]]/mean_time))

Gr2_Rear_contact <- Gr2[Gr2$Event == "Rear_contact", ]
mean_nb <- mean(Gr2_Rear_contact[Gr2_Rear_contact$Genotype == "WT", "Amount"])
Gr2_Rear_contact$Norm_amount <- c((Gr2_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr2_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr2_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr2_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Rear_contact[Gr2_Rear_contact$Genotype == "WT", "Total_time"])
Gr2_Rear_contact$Norm_time <- c((Gr2_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr2_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr2_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr2_Rear_contact$Total_time[[4]]/mean_time))

Gr2_SbS_contact <- Gr2[Gr2$Event == "SbS_contact", ]
mean_nb <- mean(Gr2_SbS_contact[Gr2_SbS_contact$Genotype == "WT", "Amount"])
Gr2_SbS_contact$Norm_amount <- c((Gr2_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr2_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr2_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr2_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_SbS_contact[Gr2_SbS_contact$Genotype == "WT", "Total_time"])
Gr2_SbS_contact$Norm_time <- c((Gr2_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr2_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr2_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr2_SbS_contact$Total_time[[4]]/mean_time))

Gr2_SbSO_contact <- Gr2[Gr2$Event == "SbSO_contact", ]
mean_nb <- mean(Gr2_SbSO_contact[Gr2_SbSO_contact$Genotype == "WT", "Amount"])
Gr2_SbSO_contact$Norm_amount <- c((Gr2_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr2_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr2_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr2_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_SbSO_contact[Gr2_SbSO_contact$Genotype == "WT", "Total_time"])
Gr2_SbSO_contact$Norm_time <- c((Gr2_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr2_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr2_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr2_SbSO_contact$Total_time[[4]]/mean_time))

Gr2_OO_contact <- Gr2[Gr2$Event == "OO_contact", ]
mean_nb <- mean(Gr2_OO_contact[Gr2_OO_contact$Genotype == "WT", "Amount"])
Gr2_OO_contact$Norm_amount <- c((Gr2_OO_contact$Amount[[1]]/mean_nb),
                                (Gr2_OO_contact$Amount[[2]]/mean_nb),
                                (Gr2_OO_contact$Amount[[3]]/mean_nb),
                                (Gr2_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_OO_contact[Gr2_OO_contact$Genotype == "WT", "Total_time"])
Gr2_OO_contact$Norm_time <- c((Gr2_OO_contact$Total_time[[1]]/mean_time),
                              (Gr2_OO_contact$Total_time[[2]]/mean_time),
                              (Gr2_OO_contact$Total_time[[3]]/mean_time),
                              (Gr2_OO_contact$Total_time[[4]]/mean_time))

Gr2_OG_contact <- Gr2[Gr2$Event == "OG_contact", ]
mean_nb <- mean(Gr2_OG_contact[Gr2_OG_contact$Genotype == "WT", "Amount"])
Gr2_OG_contact$Norm_amount <- c((Gr2_OG_contact$Amount[[1]]/mean_nb),
                                (Gr2_OG_contact$Amount[[2]]/mean_nb),
                                (Gr2_OG_contact$Amount[[3]]/mean_nb),
                                (Gr2_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_OG_contact[Gr2_OG_contact$Genotype == "WT", "Total_time"])
Gr2_OG_contact$Norm_time <- c((Gr2_OG_contact$Total_time[[1]]/mean_time),
                              (Gr2_OG_contact$Total_time[[2]]/mean_time),
                              (Gr2_OG_contact$Total_time[[3]]/mean_time),
                              (Gr2_OG_contact$Total_time[[4]]/mean_time))

Gr2_Social_approach <- Gr2[Gr2$Event == "Social_approach", ]
mean_nb <- mean(Gr2_Social_approach[Gr2_Social_approach$Genotype == "WT", "Amount"])
Gr2_Social_approach$Norm_amount <- c((Gr2_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr2_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr2_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr2_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Social_approach[Gr2_Social_approach$Genotype == "WT", "Total_time"])
Gr2_Social_approach$Norm_time <- c((Gr2_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr2_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr2_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr2_Social_approach$Total_time[[4]]/mean_time))

Gr2_Approach_rear <- Gr2[Gr2$Event == "Approach_rear", ]
mean_nb <- mean(Gr2_Approach_rear[Gr2_Approach_rear$Genotype == "WT", "Amount"])
Gr2_Approach_rear$Norm_amount <- c((Gr2_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr2_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr2_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr2_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Approach_rear[Gr2_Approach_rear$Genotype == "WT", "Total_time"])
Gr2_Approach_rear$Norm_time <- c((Gr2_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr2_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr2_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr2_Approach_rear$Total_time[[4]]/mean_time))

Gr2_Contact <- Gr2[Gr2$Event == "Contact", ]
mean_nb <- mean(Gr2_Contact[Gr2_Contact$Genotype == "WT", "Amount"])
Gr2_Contact$Norm_amount <- c((Gr2_Contact$Amount[[1]]/mean_nb),
                             (Gr2_Contact$Amount[[2]]/mean_nb),
                             (Gr2_Contact$Amount[[3]]/mean_nb),
                             (Gr2_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Contact[Gr2_Contact$Genotype == "WT", "Total_time"])
Gr2_Contact$Norm_time <- c((Gr2_Contact$Total_time[[1]]/mean_time),
                           (Gr2_Contact$Total_time[[2]]/mean_time),
                           (Gr2_Contact$Total_time[[3]]/mean_time),
                           (Gr2_Contact$Total_time[[4]]/mean_time))

Gr2_Get_away <- Gr2[Gr2$Event == "Get_away", ]
mean_nb <- mean(Gr2_Get_away[Gr2_Get_away$Genotype == "WT", "Amount"])
Gr2_Get_away$Norm_amount <- c((Gr2_Get_away$Amount[[1]]/mean_nb),
                              (Gr2_Get_away$Amount[[2]]/mean_nb),
                              (Gr2_Get_away$Amount[[3]]/mean_nb),
                              (Gr2_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Get_away[Gr2_Get_away$Genotype == "WT", "Total_time"])
Gr2_Get_away$Norm_time <- c((Gr2_Get_away$Total_time[[1]]/mean_time),
                            (Gr2_Get_away$Total_time[[2]]/mean_time),
                            (Gr2_Get_away$Total_time[[3]]/mean_time),
                            (Gr2_Get_away$Total_time[[4]]/mean_time))

Gr2_Break_contact <- Gr2[Gr2$Event == "Break_contact", ]
mean_nb <- mean(Gr2_Break_contact[Gr2_Break_contact$Genotype == "WT", "Amount"])
Gr2_Break_contact$Norm_amount <- c((Gr2_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr2_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr2_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr2_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Break_contact[Gr2_Break_contact$Genotype == "WT", "Total_time"])
Gr2_Break_contact$Norm_time <- c((Gr2_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr2_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr2_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr2_Break_contact$Total_time[[4]]/mean_time))

Gr2_Train2 <- Gr2[Gr2$Event == "Train2", ]
mean_nb <- mean(Gr2_Train2[Gr2_Train2$Genotype == "WT", "Amount"])
Gr2_Train2$Norm_amount <- c((Gr2_Train2$Amount[[1]]/mean_nb),
                            (Gr2_Train2$Amount[[2]]/mean_nb),
                            (Gr2_Train2$Amount[[3]]/mean_nb),
                            (Gr2_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Train2[Gr2_Train2$Genotype == "WT", "Total_time"])
Gr2_Train2$Norm_time <- c((Gr2_Train2$Total_time[[1]]/mean_time),
                          (Gr2_Train2$Total_time[[2]]/mean_time),
                          (Gr2_Train2$Total_time[[3]]/mean_time),
                          (Gr2_Train2$Total_time[[4]]/mean_time))

Gr2_Group3make <- Gr2[Gr2$Event == "Group3make", ]
mean_nb <- mean(Gr2_Group3make[Gr2_Group3make$Genotype == "WT", "Amount"])
Gr2_Group3make$Norm_amount <- c((Gr2_Group3make$Amount[[1]]/mean_nb),
                                (Gr2_Group3make$Amount[[2]]/mean_nb),
                                (Gr2_Group3make$Amount[[3]]/mean_nb),
                                (Gr2_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Group3make[Gr2_Group3make$Genotype == "WT", "Total_time"])
Gr2_Group3make$Norm_time <- c((Gr2_Group3make$Total_time[[1]]/mean_time),
                              (Gr2_Group3make$Total_time[[2]]/mean_time),
                              (Gr2_Group3make$Total_time[[3]]/mean_time),
                              (Gr2_Group3make$Total_time[[4]]/mean_time))

Gr2_Group3break <- Gr2[Gr2$Event == "Group3break", ]
mean_nb <- mean(Gr2_Group3break[Gr2_Group3break$Genotype == "WT", "Amount"])
Gr2_Group3break$Norm_amount <- c((Gr2_Group3break$Amount[[1]]/mean_nb),
                                 (Gr2_Group3break$Amount[[2]]/mean_nb),
                                 (Gr2_Group3break$Amount[[3]]/mean_nb),
                                 (Gr2_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Group3break[Gr2_Group3break$Genotype == "WT", "Total_time"])
Gr2_Group3break$Norm_time <- c((Gr2_Group3break$Total_time[[1]]/mean_time),
                               (Gr2_Group3break$Total_time[[2]]/mean_time),
                               (Gr2_Group3break$Total_time[[3]]/mean_time),
                               (Gr2_Group3break$Total_time[[4]]/mean_time))

Gr2_Group4make <- Gr2[Gr2$Event == "Group4make", ]
mean_nb <- mean(Gr2_Group4make[Gr2_Group4make$Genotype == "WT", "Amount"])
Gr2_Group4make$Norm_amount <- c((Gr2_Group4make$Amount[[1]]/mean_nb),
                                (Gr2_Group4make$Amount[[2]]/mean_nb),
                                (Gr2_Group4make$Amount[[3]]/mean_nb),
                                (Gr2_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Group4make[Gr2_Group4make$Genotype == "WT", "Total_time"])
Gr2_Group4make$Norm_time <- c((Gr2_Group4make$Total_time[[1]]/mean_time),
                              (Gr2_Group4make$Total_time[[2]]/mean_time),
                              (Gr2_Group4make$Total_time[[3]]/mean_time),
                              (Gr2_Group4make$Total_time[[4]]/mean_time))

Gr2_Group4break <- Gr2[Gr2$Event == "Group4break", ]
mean_nb <- mean(Gr2_Group4break[Gr2_Group4break$Genotype == "WT", "Amount"])
Gr2_Group4break$Norm_amount <- c((Gr2_Group4break$Amount[[1]]/mean_nb),
                                 (Gr2_Group4break$Amount[[2]]/mean_nb),
                                 (Gr2_Group4break$Amount[[3]]/mean_nb),
                                 (Gr2_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr2_Group4break[Gr2_Group4break$Genotype == "WT", "Total_time"])
Gr2_Group4break$Norm_time <- c((Gr2_Group4break$Total_time[[1]]/mean_time),
                               (Gr2_Group4break$Total_time[[2]]/mean_time),
                               (Gr2_Group4break$Total_time[[3]]/mean_time),
                               (Gr2_Group4break$Total_time[[4]]/mean_time))

Gr2_norm <- rbind(Gr2_Move_iso,Gr2_Stop_iso,Gr2_Rear_iso,Gr2_Huddling,
                  Gr2_WallJump,Gr2_SAP, Gr2_Move_contact,Gr2_Stop_contact,
                  Gr2_Rear_contact,Gr2_SbS_contact,Gr2_SbSO_contact,
                  Gr2_OO_contact,Gr2_OG_contact,Gr2_Social_approach,
                  Gr2_Approach_rear,Gr2_Contact,Gr2_Get_away,
                  Gr2_Break_contact,Gr2_Train2,Gr2_Group3make,
                  Gr2_Group3break,Gr2_Group4make,Gr2_Group4break)

rm(Gr2_Move_iso,Gr2_Stop_iso,Gr2_Rear_iso,Gr2_Huddling,
   Gr2_WallJump,Gr2_SAP, Gr2_Move_contact,Gr2_Stop_contact,
   Gr2_Rear_contact,Gr2_SbS_contact,Gr2_SbSO_contact,
   Gr2_OO_contact,Gr2_OG_contact,Gr2_Social_approach,
   Gr2_Approach_rear,Gr2_Contact,Gr2_Get_away,
   Gr2_Break_contact,Gr2_Train2,Gr2_Group3make,
   Gr2_Group3break,Gr2_Group4make,Gr2_Group4break)

Gr3 <- Events[Events$Group == "M3", ]
Gr3_Move_iso <- Gr3[Gr3$Event == "Move_isolated", ]
mean_nb <- mean(Gr3_Move_iso[Gr3_Move_iso$Genotype == "WT", "Amount"])
Gr3_Move_iso$Norm_amount <- c((Gr3_Move_iso$Amount[[1]]/mean_nb),
                              (Gr3_Move_iso$Amount[[2]]/mean_nb),
                              (Gr3_Move_iso$Amount[[3]]/mean_nb),
                              (Gr3_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Move_iso[Gr3_Move_iso$Genotype == "WT", "Total_time"])
Gr3_Move_iso$Norm_time <- c((Gr3_Move_iso$Total_time[[1]]/mean_time),
                            (Gr3_Move_iso$Total_time[[2]]/mean_time),
                            (Gr3_Move_iso$Total_time[[3]]/mean_time),
                            (Gr3_Move_iso$Total_time[[4]]/mean_time))

Gr3_Stop_iso <- Gr3[Gr3$Event == "Stop_isolated", ]
mean_nb <- mean(Gr3_Stop_iso[Gr3_Stop_iso$Genotype == "WT", "Amount"])
Gr3_Stop_iso$Norm_amount <- c((Gr3_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr3_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr3_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr3_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Stop_iso[Gr3_Stop_iso$Genotype == "WT", "Total_time"])
Gr3_Stop_iso$Norm_time <- c((Gr3_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr3_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr3_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr3_Stop_iso$Total_time[[4]]/mean_time))

Gr3_Rear_iso <- Gr3[Gr3$Event == "Rear_isolated", ]
mean_nb <- mean(Gr3_Rear_iso[Gr3_Rear_iso$Genotype == "WT", "Amount"])
Gr3_Rear_iso$Norm_amount <- c((Gr3_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr3_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr3_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr3_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Rear_iso[Gr3_Rear_iso$Genotype == "WT", "Total_time"])
Gr3_Rear_iso$Norm_time <- c((Gr3_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr3_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr3_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr3_Rear_iso$Total_time[[4]]/mean_time))

Gr3_Huddling <- Gr3[Gr3$Event == "Huddling", ]
mean_nb <- mean(Gr3_Huddling[Gr3_Huddling$Genotype == "WT", "Amount"])
Gr3_Huddling$Norm_amount <- c((Gr3_Huddling$Amount[[1]]/mean_nb),
                              (Gr3_Huddling$Amount[[2]]/mean_nb),
                              (Gr3_Huddling$Amount[[3]]/mean_nb),
                              (Gr3_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Huddling[Gr3_Huddling$Genotype == "WT", "Total_time"])
Gr3_Huddling$Norm_time <- c((Gr3_Huddling$Total_time[[1]]/mean_time),
                            (Gr3_Huddling$Total_time[[2]]/mean_time),
                            (Gr3_Huddling$Total_time[[3]]/mean_time),
                            (Gr3_Huddling$Total_time[[4]]/mean_time))

Gr3_WallJump <- Gr3[Gr3$Event == "WallJump", ]
mean_nb <- mean(Gr3_WallJump[Gr3_WallJump$Genotype == "WT", "Amount"])
Gr3_WallJump$Norm_amount <- c((Gr3_WallJump$Amount[[1]]/mean_nb),
                              (Gr3_WallJump$Amount[[2]]/mean_nb),
                              (Gr3_WallJump$Amount[[3]]/mean_nb),
                              (Gr3_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_WallJump[Gr3_WallJump$Genotype == "WT", "Total_time"])
Gr3_WallJump$Norm_time <- c((Gr3_WallJump$Total_time[[1]]/mean_time),
                            (Gr3_WallJump$Total_time[[2]]/mean_time),
                            (Gr3_WallJump$Total_time[[3]]/mean_time),
                            (Gr3_WallJump$Total_time[[4]]/mean_time))

Gr3_SAP <- Gr3[Gr3$Event == "SAP", ]
mean_nb <- mean(Gr3_SAP[Gr3_SAP$Genotype == "WT", "Amount"])
Gr3_SAP$Norm_amount <- c((Gr3_SAP$Amount[[1]]/mean_nb),
                         (Gr3_SAP$Amount[[2]]/mean_nb),
                         (Gr3_SAP$Amount[[3]]/mean_nb),
                         (Gr3_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_SAP[Gr3_SAP$Genotype == "WT", "Total_time"])
Gr3_SAP$Norm_time <- c((Gr3_SAP$Total_time[[1]]/mean_time),
                       (Gr3_SAP$Total_time[[2]]/mean_time),
                       (Gr3_SAP$Total_time[[3]]/mean_time),
                       (Gr3_SAP$Total_time[[4]]/mean_time))

Gr3_Move_contact <- Gr3[Gr3$Event == "Move_contact", ]
mean_nb <- mean(Gr3_Move_contact[Gr3_Move_contact$Genotype == "WT", "Amount"])
Gr3_Move_contact$Norm_amount <- c((Gr3_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr3_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr3_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr3_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Move_contact[Gr3_Move_contact$Genotype == "WT", "Total_time"])
Gr3_Move_contact$Norm_time <- c((Gr3_Move_contact$Total_time[[1]]/mean_time),
                                (Gr3_Move_contact$Total_time[[2]]/mean_time),
                                (Gr3_Move_contact$Total_time[[3]]/mean_time),
                                (Gr3_Move_contact$Total_time[[4]]/mean_time))

Gr3_Stop_contact <- Gr3[Gr3$Event == "Stop_contact", ]
mean_nb <- mean(Gr3_Stop_contact[Gr3_Stop_contact$Genotype == "WT", "Amount"])
Gr3_Stop_contact$Norm_amount <- c((Gr3_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr3_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr3_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr3_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Stop_contact[Gr3_Stop_contact$Genotype == "WT", "Total_time"])
Gr3_Stop_contact$Norm_time <- c((Gr3_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr3_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr3_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr3_Stop_contact$Total_time[[4]]/mean_time))

Gr3_Rear_contact <- Gr3[Gr3$Event == "Rear_contact", ]
mean_nb <- mean(Gr3_Rear_contact[Gr3_Rear_contact$Genotype == "WT", "Amount"])
Gr3_Rear_contact$Norm_amount <- c((Gr3_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr3_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr3_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr3_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Rear_contact[Gr3_Rear_contact$Genotype == "WT", "Total_time"])
Gr3_Rear_contact$Norm_time <- c((Gr3_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr3_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr3_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr3_Rear_contact$Total_time[[4]]/mean_time))

Gr3_SbS_contact <- Gr3[Gr3$Event == "SbS_contact", ]
mean_nb <- mean(Gr3_SbS_contact[Gr3_SbS_contact$Genotype == "WT", "Amount"])
Gr3_SbS_contact$Norm_amount <- c((Gr3_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr3_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr3_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr3_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_SbS_contact[Gr3_SbS_contact$Genotype == "WT", "Total_time"])
Gr3_SbS_contact$Norm_time <- c((Gr3_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr3_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr3_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr3_SbS_contact$Total_time[[4]]/mean_time))

Gr3_SbSO_contact <- Gr3[Gr3$Event == "SbSO_contact", ]
mean_nb <- mean(Gr3_SbSO_contact[Gr3_SbSO_contact$Genotype == "WT", "Amount"])
Gr3_SbSO_contact$Norm_amount <- c((Gr3_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr3_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr3_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr3_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_SbSO_contact[Gr3_SbSO_contact$Genotype == "WT", "Total_time"])
Gr3_SbSO_contact$Norm_time <- c((Gr3_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr3_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr3_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr3_SbSO_contact$Total_time[[4]]/mean_time))

Gr3_OO_contact <- Gr3[Gr3$Event == "OO_contact", ]
mean_nb <- mean(Gr3_OO_contact[Gr3_OO_contact$Genotype == "WT", "Amount"])
Gr3_OO_contact$Norm_amount <- c((Gr3_OO_contact$Amount[[1]]/mean_nb),
                                (Gr3_OO_contact$Amount[[2]]/mean_nb),
                                (Gr3_OO_contact$Amount[[3]]/mean_nb),
                                (Gr3_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_OO_contact[Gr3_OO_contact$Genotype == "WT", "Total_time"])
Gr3_OO_contact$Norm_time <- c((Gr3_OO_contact$Total_time[[1]]/mean_time),
                              (Gr3_OO_contact$Total_time[[2]]/mean_time),
                              (Gr3_OO_contact$Total_time[[3]]/mean_time),
                              (Gr3_OO_contact$Total_time[[4]]/mean_time))

Gr3_OG_contact <- Gr3[Gr3$Event == "OG_contact", ]
mean_nb <- mean(Gr3_OG_contact[Gr3_OG_contact$Genotype == "WT", "Amount"])
Gr3_OG_contact$Norm_amount <- c((Gr3_OG_contact$Amount[[1]]/mean_nb),
                                (Gr3_OG_contact$Amount[[2]]/mean_nb),
                                (Gr3_OG_contact$Amount[[3]]/mean_nb),
                                (Gr3_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_OG_contact[Gr3_OG_contact$Genotype == "WT", "Total_time"])
Gr3_OG_contact$Norm_time <- c((Gr3_OG_contact$Total_time[[1]]/mean_time),
                              (Gr3_OG_contact$Total_time[[2]]/mean_time),
                              (Gr3_OG_contact$Total_time[[3]]/mean_time),
                              (Gr3_OG_contact$Total_time[[4]]/mean_time))

Gr3_Social_approach <- Gr3[Gr3$Event == "Social_approach", ]
mean_nb <- mean(Gr3_Social_approach[Gr3_Social_approach$Genotype == "WT", "Amount"])
Gr3_Social_approach$Norm_amount <- c((Gr3_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr3_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr3_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr3_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Social_approach[Gr3_Social_approach$Genotype == "WT", "Total_time"])
Gr3_Social_approach$Norm_time <- c((Gr3_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr3_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr3_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr3_Social_approach$Total_time[[4]]/mean_time))

Gr3_Approach_rear <- Gr3[Gr3$Event == "Approach_rear", ]
mean_nb <- mean(Gr3_Approach_rear[Gr3_Approach_rear$Genotype == "WT", "Amount"])
Gr3_Approach_rear$Norm_amount <- c((Gr3_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr3_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr3_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr3_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Approach_rear[Gr3_Approach_rear$Genotype == "WT", "Total_time"])
Gr3_Approach_rear$Norm_time <- c((Gr3_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr3_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr3_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr3_Approach_rear$Total_time[[4]]/mean_time))

Gr3_Contact <- Gr3[Gr3$Event == "Contact", ]
mean_nb <- mean(Gr3_Contact[Gr3_Contact$Genotype == "WT", "Amount"])
Gr3_Contact$Norm_amount <- c((Gr3_Contact$Amount[[1]]/mean_nb),
                             (Gr3_Contact$Amount[[2]]/mean_nb),
                             (Gr3_Contact$Amount[[3]]/mean_nb),
                             (Gr3_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Contact[Gr3_Contact$Genotype == "WT", "Total_time"])
Gr3_Contact$Norm_time <- c((Gr3_Contact$Total_time[[1]]/mean_time),
                           (Gr3_Contact$Total_time[[2]]/mean_time),
                           (Gr3_Contact$Total_time[[3]]/mean_time),
                           (Gr3_Contact$Total_time[[4]]/mean_time))

Gr3_Get_away <- Gr3[Gr3$Event == "Get_away", ]
mean_nb <- mean(Gr3_Get_away[Gr3_Get_away$Genotype == "WT", "Amount"])
Gr3_Get_away$Norm_amount <- c((Gr3_Get_away$Amount[[1]]/mean_nb),
                              (Gr3_Get_away$Amount[[2]]/mean_nb),
                              (Gr3_Get_away$Amount[[3]]/mean_nb),
                              (Gr3_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Get_away[Gr3_Get_away$Genotype == "WT", "Total_time"])
Gr3_Get_away$Norm_time <- c((Gr3_Get_away$Total_time[[1]]/mean_time),
                            (Gr3_Get_away$Total_time[[2]]/mean_time),
                            (Gr3_Get_away$Total_time[[3]]/mean_time),
                            (Gr3_Get_away$Total_time[[4]]/mean_time))

Gr3_Break_contact <- Gr3[Gr3$Event == "Break_contact", ]
mean_nb <- mean(Gr3_Break_contact[Gr3_Break_contact$Genotype == "WT", "Amount"])
Gr3_Break_contact$Norm_amount <- c((Gr3_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr3_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr3_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr3_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Break_contact[Gr3_Break_contact$Genotype == "WT", "Total_time"])
Gr3_Break_contact$Norm_time <- c((Gr3_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr3_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr3_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr3_Break_contact$Total_time[[4]]/mean_time))

Gr3_Train2 <- Gr3[Gr3$Event == "Train2", ]
mean_nb <- mean(Gr3_Train2[Gr3_Train2$Genotype == "WT", "Amount"])
Gr3_Train2$Norm_amount <- c((Gr3_Train2$Amount[[1]]/mean_nb),
                            (Gr3_Train2$Amount[[2]]/mean_nb),
                            (Gr3_Train2$Amount[[3]]/mean_nb),
                            (Gr3_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Train2[Gr3_Train2$Genotype == "WT", "Total_time"])
Gr3_Train2$Norm_time <- c((Gr3_Train2$Total_time[[1]]/mean_time),
                          (Gr3_Train2$Total_time[[2]]/mean_time),
                          (Gr3_Train2$Total_time[[3]]/mean_time),
                          (Gr3_Train2$Total_time[[4]]/mean_time))

Gr3_Group3make <- Gr3[Gr3$Event == "Group3make", ]
mean_nb <- mean(Gr3_Group3make[Gr3_Group3make$Genotype == "WT", "Amount"])
Gr3_Group3make$Norm_amount <- c((Gr3_Group3make$Amount[[1]]/mean_nb),
                                (Gr3_Group3make$Amount[[2]]/mean_nb),
                                (Gr3_Group3make$Amount[[3]]/mean_nb),
                                (Gr3_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Group3make[Gr3_Group3make$Genotype == "WT", "Total_time"])
Gr3_Group3make$Norm_time <- c((Gr3_Group3make$Total_time[[1]]/mean_time),
                              (Gr3_Group3make$Total_time[[2]]/mean_time),
                              (Gr3_Group3make$Total_time[[3]]/mean_time),
                              (Gr3_Group3make$Total_time[[4]]/mean_time))

Gr3_Group3break <- Gr3[Gr3$Event == "Group3break", ]
mean_nb <- mean(Gr3_Group3break[Gr3_Group3break$Genotype == "WT", "Amount"])
Gr3_Group3break$Norm_amount <- c((Gr3_Group3break$Amount[[1]]/mean_nb),
                                 (Gr3_Group3break$Amount[[2]]/mean_nb),
                                 (Gr3_Group3break$Amount[[3]]/mean_nb),
                                 (Gr3_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Group3break[Gr3_Group3break$Genotype == "WT", "Total_time"])
Gr3_Group3break$Norm_time <- c((Gr3_Group3break$Total_time[[1]]/mean_time),
                               (Gr3_Group3break$Total_time[[2]]/mean_time),
                               (Gr3_Group3break$Total_time[[3]]/mean_time),
                               (Gr3_Group3break$Total_time[[4]]/mean_time))

Gr3_Group4make <- Gr3[Gr3$Event == "Group4make", ]
mean_nb <- mean(Gr3_Group4make[Gr3_Group4make$Genotype == "WT", "Amount"])
Gr3_Group4make$Norm_amount <- c((Gr3_Group4make$Amount[[1]]/mean_nb),
                                (Gr3_Group4make$Amount[[2]]/mean_nb),
                                (Gr3_Group4make$Amount[[3]]/mean_nb),
                                (Gr3_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Group4make[Gr3_Group4make$Genotype == "WT", "Total_time"])
Gr3_Group4make$Norm_time <- c((Gr3_Group4make$Total_time[[1]]/mean_time),
                              (Gr3_Group4make$Total_time[[2]]/mean_time),
                              (Gr3_Group4make$Total_time[[3]]/mean_time),
                              (Gr3_Group4make$Total_time[[4]]/mean_time))

Gr3_Group4break <- Gr3[Gr3$Event == "Group4break", ]
mean_nb <- mean(Gr3_Group4break[Gr3_Group4break$Genotype == "WT", "Amount"])
Gr3_Group4break$Norm_amount <- c((Gr3_Group4break$Amount[[1]]/mean_nb),
                                 (Gr3_Group4break$Amount[[2]]/mean_nb),
                                 (Gr3_Group4break$Amount[[3]]/mean_nb),
                                 (Gr3_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr3_Group4break[Gr3_Group4break$Genotype == "WT", "Total_time"])
Gr3_Group4break$Norm_time <- c((Gr3_Group4break$Total_time[[1]]/mean_time),
                               (Gr3_Group4break$Total_time[[2]]/mean_time),
                               (Gr3_Group4break$Total_time[[3]]/mean_time),
                               (Gr3_Group4break$Total_time[[4]]/mean_time))

Gr3_norm <- rbind(Gr3_Move_iso,Gr3_Stop_iso,Gr3_Rear_iso,Gr3_Huddling,
                  Gr3_WallJump,Gr3_SAP, Gr3_Move_contact,Gr3_Stop_contact,
                  Gr3_Rear_contact,Gr3_SbS_contact,Gr3_SbSO_contact,
                  Gr3_OO_contact,Gr3_OG_contact,Gr3_Social_approach,
                  Gr3_Approach_rear,Gr3_Contact,Gr3_Get_away,
                  Gr3_Break_contact,Gr3_Train2,Gr3_Group3make,
                  Gr3_Group3break,Gr3_Group4make,Gr3_Group4break)

rm(Gr3_Move_iso,Gr3_Stop_iso,Gr3_Rear_iso,Gr3_Huddling,
   Gr3_WallJump,Gr3_SAP, Gr3_Move_contact,Gr3_Stop_contact,
   Gr3_Rear_contact,Gr3_SbS_contact,Gr3_SbSO_contact,
   Gr3_OO_contact,Gr3_OG_contact,Gr3_Social_approach,
   Gr3_Approach_rear,Gr3_Contact,Gr3_Get_away,
   Gr3_Break_contact,Gr3_Train2,Gr3_Group3make,
   Gr3_Group3break,Gr3_Group4make,Gr3_Group4break)

Gr4 <- Events[Events$Group == "M4", ]
Gr4_Move_iso <- Gr4[Gr4$Event == "Move_isolated", ]
mean_nb <- mean(Gr4_Move_iso[Gr4_Move_iso$Genotype == "WT", "Amount"])
Gr4_Move_iso$Norm_amount <- c((Gr4_Move_iso$Amount[[1]]/mean_nb),
                              (Gr4_Move_iso$Amount[[2]]/mean_nb),
                              (Gr4_Move_iso$Amount[[3]]/mean_nb),
                              (Gr4_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Move_iso[Gr4_Move_iso$Genotype == "WT", "Total_time"])
Gr4_Move_iso$Norm_time <- c((Gr4_Move_iso$Total_time[[1]]/mean_time),
                            (Gr4_Move_iso$Total_time[[2]]/mean_time),
                            (Gr4_Move_iso$Total_time[[3]]/mean_time),
                            (Gr4_Move_iso$Total_time[[4]]/mean_time))

Gr4_Stop_iso <- Gr4[Gr4$Event == "Stop_isolated", ]
mean_nb <- mean(Gr4_Stop_iso[Gr4_Stop_iso$Genotype == "WT", "Amount"])
Gr4_Stop_iso$Norm_amount <- c((Gr4_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr4_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr4_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr4_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Stop_iso[Gr4_Stop_iso$Genotype == "WT", "Total_time"])
Gr4_Stop_iso$Norm_time <- c((Gr4_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr4_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr4_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr4_Stop_iso$Total_time[[4]]/mean_time))

Gr4_Rear_iso <- Gr4[Gr4$Event == "Rear_isolated", ]
mean_nb <- mean(Gr4_Rear_iso[Gr4_Rear_iso$Genotype == "WT", "Amount"])
Gr4_Rear_iso$Norm_amount <- c((Gr4_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr4_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr4_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr4_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Rear_iso[Gr4_Rear_iso$Genotype == "WT", "Total_time"])
Gr4_Rear_iso$Norm_time <- c((Gr4_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr4_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr4_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr4_Rear_iso$Total_time[[4]]/mean_time))

Gr4_Huddling <- Gr4[Gr4$Event == "Huddling", ]
mean_nb <- mean(Gr4_Huddling[Gr4_Huddling$Genotype == "WT", "Amount"])
Gr4_Huddling$Norm_amount <- c((Gr4_Huddling$Amount[[1]]/mean_nb),
                              (Gr4_Huddling$Amount[[2]]/mean_nb),
                              (Gr4_Huddling$Amount[[3]]/mean_nb),
                              (Gr4_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Huddling[Gr4_Huddling$Genotype == "WT", "Total_time"])
Gr4_Huddling$Norm_time <- c((Gr4_Huddling$Total_time[[1]]/mean_time),
                            (Gr4_Huddling$Total_time[[2]]/mean_time),
                            (Gr4_Huddling$Total_time[[3]]/mean_time),
                            (Gr4_Huddling$Total_time[[4]]/mean_time))

Gr4_WallJump <- Gr4[Gr4$Event == "WallJump", ]
mean_nb <- mean(Gr4_WallJump[Gr4_WallJump$Genotype == "WT", "Amount"])
Gr4_WallJump$Norm_amount <- c((Gr4_WallJump$Amount[[1]]/mean_nb),
                              (Gr4_WallJump$Amount[[2]]/mean_nb),
                              (Gr4_WallJump$Amount[[3]]/mean_nb),
                              (Gr4_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_WallJump[Gr4_WallJump$Genotype == "WT", "Total_time"])
Gr4_WallJump$Norm_time <- c((Gr4_WallJump$Total_time[[1]]/mean_time),
                            (Gr4_WallJump$Total_time[[2]]/mean_time),
                            (Gr4_WallJump$Total_time[[3]]/mean_time),
                            (Gr4_WallJump$Total_time[[4]]/mean_time))

Gr4_SAP <- Gr4[Gr4$Event == "SAP", ]
mean_nb <- mean(Gr4_SAP[Gr4_SAP$Genotype == "WT", "Amount"])
Gr4_SAP$Norm_amount <- c((Gr4_SAP$Amount[[1]]/mean_nb),
                         (Gr4_SAP$Amount[[2]]/mean_nb),
                         (Gr4_SAP$Amount[[3]]/mean_nb),
                         (Gr4_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_SAP[Gr4_SAP$Genotype == "WT", "Total_time"])
Gr4_SAP$Norm_time <- c((Gr4_SAP$Total_time[[1]]/mean_time),
                       (Gr4_SAP$Total_time[[2]]/mean_time),
                       (Gr4_SAP$Total_time[[3]]/mean_time),
                       (Gr4_SAP$Total_time[[4]]/mean_time))

Gr4_Move_contact <- Gr4[Gr4$Event == "Move_contact", ]
mean_nb <- mean(Gr4_Move_contact[Gr4_Move_contact$Genotype == "WT", "Amount"])
Gr4_Move_contact$Norm_amount <- c((Gr4_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr4_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr4_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr4_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Move_contact[Gr4_Move_contact$Genotype == "WT", "Total_time"])
Gr4_Move_contact$Norm_time <- c((Gr4_Move_contact$Total_time[[1]]/mean_time),
                                (Gr4_Move_contact$Total_time[[2]]/mean_time),
                                (Gr4_Move_contact$Total_time[[3]]/mean_time),
                                (Gr4_Move_contact$Total_time[[4]]/mean_time))

Gr4_Stop_contact <- Gr4[Gr4$Event == "Stop_contact", ]
mean_nb <- mean(Gr4_Stop_contact[Gr4_Stop_contact$Genotype == "WT", "Amount"])
Gr4_Stop_contact$Norm_amount <- c((Gr4_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr4_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr4_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr4_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Stop_contact[Gr4_Stop_contact$Genotype == "WT", "Total_time"])
Gr4_Stop_contact$Norm_time <- c((Gr4_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr4_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr4_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr4_Stop_contact$Total_time[[4]]/mean_time))

Gr4_Rear_contact <- Gr4[Gr4$Event == "Rear_contact", ]
mean_nb <- mean(Gr4_Rear_contact[Gr4_Rear_contact$Genotype == "WT", "Amount"])
Gr4_Rear_contact$Norm_amount <- c((Gr4_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr4_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr4_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr4_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Rear_contact[Gr4_Rear_contact$Genotype == "WT", "Total_time"])
Gr4_Rear_contact$Norm_time <- c((Gr4_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr4_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr4_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr4_Rear_contact$Total_time[[4]]/mean_time))

Gr4_SbS_contact <- Gr4[Gr4$Event == "SbS_contact", ]
mean_nb <- mean(Gr4_SbS_contact[Gr4_SbS_contact$Genotype == "WT", "Amount"])
Gr4_SbS_contact$Norm_amount <- c((Gr4_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr4_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr4_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr4_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_SbS_contact[Gr4_SbS_contact$Genotype == "WT", "Total_time"])
Gr4_SbS_contact$Norm_time <- c((Gr4_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr4_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr4_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr4_SbS_contact$Total_time[[4]]/mean_time))

Gr4_SbSO_contact <- Gr4[Gr4$Event == "SbSO_contact", ]
mean_nb <- mean(Gr4_SbSO_contact[Gr4_SbSO_contact$Genotype == "WT", "Amount"])
Gr4_SbSO_contact$Norm_amount <- c((Gr4_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr4_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr4_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr4_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_SbSO_contact[Gr4_SbSO_contact$Genotype == "WT", "Total_time"])
Gr4_SbSO_contact$Norm_time <- c((Gr4_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr4_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr4_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr4_SbSO_contact$Total_time[[4]]/mean_time))

Gr4_OO_contact <- Gr4[Gr4$Event == "OO_contact", ]
mean_nb <- mean(Gr4_OO_contact[Gr4_OO_contact$Genotype == "WT", "Amount"])
Gr4_OO_contact$Norm_amount <- c((Gr4_OO_contact$Amount[[1]]/mean_nb),
                                (Gr4_OO_contact$Amount[[2]]/mean_nb),
                                (Gr4_OO_contact$Amount[[3]]/mean_nb),
                                (Gr4_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_OO_contact[Gr4_OO_contact$Genotype == "WT", "Total_time"])
Gr4_OO_contact$Norm_time <- c((Gr4_OO_contact$Total_time[[1]]/mean_time),
                              (Gr4_OO_contact$Total_time[[2]]/mean_time),
                              (Gr4_OO_contact$Total_time[[3]]/mean_time),
                              (Gr4_OO_contact$Total_time[[4]]/mean_time))

Gr4_OG_contact <- Gr4[Gr4$Event == "OG_contact", ]
mean_nb <- mean(Gr4_OG_contact[Gr4_OG_contact$Genotype == "WT", "Amount"])
Gr4_OG_contact$Norm_amount <- c((Gr4_OG_contact$Amount[[1]]/mean_nb),
                                (Gr4_OG_contact$Amount[[2]]/mean_nb),
                                (Gr4_OG_contact$Amount[[3]]/mean_nb),
                                (Gr4_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_OG_contact[Gr4_OG_contact$Genotype == "WT", "Total_time"])
Gr4_OG_contact$Norm_time <- c((Gr4_OG_contact$Total_time[[1]]/mean_time),
                              (Gr4_OG_contact$Total_time[[2]]/mean_time),
                              (Gr4_OG_contact$Total_time[[3]]/mean_time),
                              (Gr4_OG_contact$Total_time[[4]]/mean_time))

Gr4_Social_approach <- Gr4[Gr4$Event == "Social_approach", ]
mean_nb <- mean(Gr4_Social_approach[Gr4_Social_approach$Genotype == "WT", "Amount"])
Gr4_Social_approach$Norm_amount <- c((Gr4_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr4_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr4_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr4_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Social_approach[Gr4_Social_approach$Genotype == "WT", "Total_time"])
Gr4_Social_approach$Norm_time <- c((Gr4_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr4_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr4_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr4_Social_approach$Total_time[[4]]/mean_time))

Gr4_Approach_rear <- Gr4[Gr4$Event == "Approach_rear", ]
mean_nb <- mean(Gr4_Approach_rear[Gr4_Approach_rear$Genotype == "WT", "Amount"])
Gr4_Approach_rear$Norm_amount <- c((Gr4_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr4_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr4_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr4_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Approach_rear[Gr4_Approach_rear$Genotype == "WT", "Total_time"])
Gr4_Approach_rear$Norm_time <- c((Gr4_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr4_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr4_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr4_Approach_rear$Total_time[[4]]/mean_time))

Gr4_Contact <- Gr4[Gr4$Event == "Contact", ]
mean_nb <- mean(Gr4_Contact[Gr4_Contact$Genotype == "WT", "Amount"])
Gr4_Contact$Norm_amount <- c((Gr4_Contact$Amount[[1]]/mean_nb),
                             (Gr4_Contact$Amount[[2]]/mean_nb),
                             (Gr4_Contact$Amount[[3]]/mean_nb),
                             (Gr4_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Contact[Gr4_Contact$Genotype == "WT", "Total_time"])
Gr4_Contact$Norm_time <- c((Gr4_Contact$Total_time[[1]]/mean_time),
                           (Gr4_Contact$Total_time[[2]]/mean_time),
                           (Gr4_Contact$Total_time[[3]]/mean_time),
                           (Gr4_Contact$Total_time[[4]]/mean_time))

Gr4_Get_away <- Gr4[Gr4$Event == "Get_away", ]
mean_nb <- mean(Gr4_Get_away[Gr4_Get_away$Genotype == "WT", "Amount"])
Gr4_Get_away$Norm_amount <- c((Gr4_Get_away$Amount[[1]]/mean_nb),
                              (Gr4_Get_away$Amount[[2]]/mean_nb),
                              (Gr4_Get_away$Amount[[3]]/mean_nb),
                              (Gr4_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Get_away[Gr4_Get_away$Genotype == "WT", "Total_time"])
Gr4_Get_away$Norm_time <- c((Gr4_Get_away$Total_time[[1]]/mean_time),
                            (Gr4_Get_away$Total_time[[2]]/mean_time),
                            (Gr4_Get_away$Total_time[[3]]/mean_time),
                            (Gr4_Get_away$Total_time[[4]]/mean_time))

Gr4_Break_contact <- Gr4[Gr4$Event == "Break_contact", ]
mean_nb <- mean(Gr4_Break_contact[Gr4_Break_contact$Genotype == "WT", "Amount"])
Gr4_Break_contact$Norm_amount <- c((Gr4_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr4_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr4_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr4_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Break_contact[Gr4_Break_contact$Genotype == "WT", "Total_time"])
Gr4_Break_contact$Norm_time <- c((Gr4_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr4_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr4_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr4_Break_contact$Total_time[[4]]/mean_time))

Gr4_Train2 <- Gr4[Gr4$Event == "Train2", ]
mean_nb <- mean(Gr4_Train2[Gr4_Train2$Genotype == "WT", "Amount"])
Gr4_Train2$Norm_amount <- c((Gr4_Train2$Amount[[1]]/mean_nb),
                            (Gr4_Train2$Amount[[2]]/mean_nb),
                            (Gr4_Train2$Amount[[3]]/mean_nb),
                            (Gr4_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Train2[Gr4_Train2$Genotype == "WT", "Total_time"])
Gr4_Train2$Norm_time <- c((Gr4_Train2$Total_time[[1]]/mean_time),
                          (Gr4_Train2$Total_time[[2]]/mean_time),
                          (Gr4_Train2$Total_time[[3]]/mean_time),
                          (Gr4_Train2$Total_time[[4]]/mean_time))

Gr4_Group3make <- Gr4[Gr4$Event == "Group3make", ]
mean_nb <- mean(Gr4_Group3make[Gr4_Group3make$Genotype == "WT", "Amount"])
Gr4_Group3make$Norm_amount <- c((Gr4_Group3make$Amount[[1]]/mean_nb),
                                (Gr4_Group3make$Amount[[2]]/mean_nb),
                                (Gr4_Group3make$Amount[[3]]/mean_nb),
                                (Gr4_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Group3make[Gr4_Group3make$Genotype == "WT", "Total_time"])
Gr4_Group3make$Norm_time <- c((Gr4_Group3make$Total_time[[1]]/mean_time),
                              (Gr4_Group3make$Total_time[[2]]/mean_time),
                              (Gr4_Group3make$Total_time[[3]]/mean_time),
                              (Gr4_Group3make$Total_time[[4]]/mean_time))

Gr4_Group3break <- Gr4[Gr4$Event == "Group3break", ]
mean_nb <- mean(Gr4_Group3break[Gr4_Group3break$Genotype == "WT", "Amount"])
Gr4_Group3break$Norm_amount <- c((Gr4_Group3break$Amount[[1]]/mean_nb),
                                 (Gr4_Group3break$Amount[[2]]/mean_nb),
                                 (Gr4_Group3break$Amount[[3]]/mean_nb),
                                 (Gr4_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Group3break[Gr4_Group3break$Genotype == "WT", "Total_time"])
Gr4_Group3break$Norm_time <- c((Gr4_Group3break$Total_time[[1]]/mean_time),
                               (Gr4_Group3break$Total_time[[2]]/mean_time),
                               (Gr4_Group3break$Total_time[[3]]/mean_time),
                               (Gr4_Group3break$Total_time[[4]]/mean_time))

Gr4_Group4make <- Gr4[Gr4$Event == "Group4make", ]
mean_nb <- mean(Gr4_Group4make[Gr4_Group4make$Genotype == "WT", "Amount"])
Gr4_Group4make$Norm_amount <- c((Gr4_Group4make$Amount[[1]]/mean_nb),
                                (Gr4_Group4make$Amount[[2]]/mean_nb),
                                (Gr4_Group4make$Amount[[3]]/mean_nb),
                                (Gr4_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Group4make[Gr4_Group4make$Genotype == "WT", "Total_time"])
Gr4_Group4make$Norm_time <- c((Gr4_Group4make$Total_time[[1]]/mean_time),
                              (Gr4_Group4make$Total_time[[2]]/mean_time),
                              (Gr4_Group4make$Total_time[[3]]/mean_time),
                              (Gr4_Group4make$Total_time[[4]]/mean_time))

Gr4_Group4break <- Gr4[Gr4$Event == "Group4break", ]
mean_nb <- mean(Gr4_Group4break[Gr4_Group4break$Genotype == "WT", "Amount"])
Gr4_Group4break$Norm_amount <- c((Gr4_Group4break$Amount[[1]]/mean_nb),
                                 (Gr4_Group4break$Amount[[2]]/mean_nb),
                                 (Gr4_Group4break$Amount[[3]]/mean_nb),
                                 (Gr4_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr4_Group4break[Gr4_Group4break$Genotype == "WT", "Total_time"])
Gr4_Group4break$Norm_time <- c((Gr4_Group4break$Total_time[[1]]/mean_time),
                               (Gr4_Group4break$Total_time[[2]]/mean_time),
                               (Gr4_Group4break$Total_time[[3]]/mean_time),
                               (Gr4_Group4break$Total_time[[4]]/mean_time))

Gr4_norm <- rbind(Gr4_Move_iso,Gr4_Stop_iso,Gr4_Rear_iso,Gr4_Huddling,
                  Gr4_WallJump,Gr4_SAP, Gr4_Move_contact,Gr4_Stop_contact,
                  Gr4_Rear_contact,Gr4_SbS_contact,Gr4_SbSO_contact,
                  Gr4_OO_contact,Gr4_OG_contact,Gr4_Social_approach,
                  Gr4_Approach_rear,Gr4_Contact,Gr4_Get_away,
                  Gr4_Break_contact,Gr4_Train2,Gr4_Group3make,
                  Gr4_Group3break,Gr4_Group4make,Gr4_Group4break)

rm(Gr4_Move_iso,Gr4_Stop_iso,Gr4_Rear_iso,Gr4_Huddling,
   Gr4_WallJump,Gr4_SAP, Gr4_Move_contact,Gr4_Stop_contact,
   Gr4_Rear_contact,Gr4_SbS_contact,Gr4_SbSO_contact,
   Gr4_OO_contact,Gr4_OG_contact,Gr4_Social_approach,
   Gr4_Approach_rear,Gr4_Contact,Gr4_Get_away,
   Gr4_Break_contact,Gr4_Train2,Gr4_Group3make,
   Gr4_Group3break,Gr4_Group4make,Gr4_Group4break)

Gr5 <- Events[Events$Group == "M5", ]
Gr5_Move_iso <- Gr5[Gr5$Event == "Move_isolated", ]
mean_nb <- mean(Gr5_Move_iso[Gr5_Move_iso$Genotype == "WT", "Amount"])
Gr5_Move_iso$Norm_amount <- c((Gr5_Move_iso$Amount[[1]]/mean_nb),
                              (Gr5_Move_iso$Amount[[2]]/mean_nb),
                              (Gr5_Move_iso$Amount[[3]]/mean_nb),
                              (Gr5_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Move_iso[Gr5_Move_iso$Genotype == "WT", "Total_time"])
Gr5_Move_iso$Norm_time <- c((Gr5_Move_iso$Total_time[[1]]/mean_time),
                            (Gr5_Move_iso$Total_time[[2]]/mean_time),
                            (Gr5_Move_iso$Total_time[[3]]/mean_time),
                            (Gr5_Move_iso$Total_time[[4]]/mean_time))

Gr5_Stop_iso <- Gr5[Gr5$Event == "Stop_isolated", ]
mean_nb <- mean(Gr5_Stop_iso[Gr5_Stop_iso$Genotype == "WT", "Amount"])
Gr5_Stop_iso$Norm_amount <- c((Gr5_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr5_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr5_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr5_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Stop_iso[Gr5_Stop_iso$Genotype == "WT", "Total_time"])
Gr5_Stop_iso$Norm_time <- c((Gr5_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr5_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr5_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr5_Stop_iso$Total_time[[4]]/mean_time))

Gr5_Rear_iso <- Gr5[Gr5$Event == "Rear_isolated", ]
mean_nb <- mean(Gr5_Rear_iso[Gr5_Rear_iso$Genotype == "WT", "Amount"])
Gr5_Rear_iso$Norm_amount <- c((Gr5_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr5_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr5_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr5_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Rear_iso[Gr5_Rear_iso$Genotype == "WT", "Total_time"])
Gr5_Rear_iso$Norm_time <- c((Gr5_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr5_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr5_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr5_Rear_iso$Total_time[[4]]/mean_time))

Gr5_Huddling <- Gr5[Gr5$Event == "Huddling", ]
mean_nb <- mean(Gr5_Huddling[Gr5_Huddling$Genotype == "WT", "Amount"])
Gr5_Huddling$Norm_amount <- c((Gr5_Huddling$Amount[[1]]/mean_nb),
                              (Gr5_Huddling$Amount[[2]]/mean_nb),
                              (Gr5_Huddling$Amount[[3]]/mean_nb),
                              (Gr5_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Huddling[Gr5_Huddling$Genotype == "WT", "Total_time"])
Gr5_Huddling$Norm_time <- c((Gr5_Huddling$Total_time[[1]]/mean_time),
                            (Gr5_Huddling$Total_time[[2]]/mean_time),
                            (Gr5_Huddling$Total_time[[3]]/mean_time),
                            (Gr5_Huddling$Total_time[[4]]/mean_time))

Gr5_WallJump <- Gr5[Gr5$Event == "WallJump", ]
mean_nb <- mean(Gr5_WallJump[Gr5_WallJump$Genotype == "WT", "Amount"])
Gr5_WallJump$Norm_amount <- c((Gr5_WallJump$Amount[[1]]/mean_nb),
                              (Gr5_WallJump$Amount[[2]]/mean_nb),
                              (Gr5_WallJump$Amount[[3]]/mean_nb),
                              (Gr5_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_WallJump[Gr5_WallJump$Genotype == "WT", "Total_time"])
Gr5_WallJump$Norm_time <- c((Gr5_WallJump$Total_time[[1]]/mean_time),
                            (Gr5_WallJump$Total_time[[2]]/mean_time),
                            (Gr5_WallJump$Total_time[[3]]/mean_time),
                            (Gr5_WallJump$Total_time[[4]]/mean_time))

Gr5_SAP <- Gr5[Gr5$Event == "SAP", ]
mean_nb <- mean(Gr5_SAP[Gr5_SAP$Genotype == "WT", "Amount"])
Gr5_SAP$Norm_amount <- c((Gr5_SAP$Amount[[1]]/mean_nb),
                         (Gr5_SAP$Amount[[2]]/mean_nb),
                         (Gr5_SAP$Amount[[3]]/mean_nb),
                         (Gr5_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_SAP[Gr5_SAP$Genotype == "WT", "Total_time"])
Gr5_SAP$Norm_time <- c((Gr5_SAP$Total_time[[1]]/mean_time),
                       (Gr5_SAP$Total_time[[2]]/mean_time),
                       (Gr5_SAP$Total_time[[3]]/mean_time),
                       (Gr5_SAP$Total_time[[4]]/mean_time))

Gr5_Move_contact <- Gr5[Gr5$Event == "Move_contact", ]
mean_nb <- mean(Gr5_Move_contact[Gr5_Move_contact$Genotype == "WT", "Amount"])
Gr5_Move_contact$Norm_amount <- c((Gr5_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr5_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr5_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr5_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Move_contact[Gr5_Move_contact$Genotype == "WT", "Total_time"])
Gr5_Move_contact$Norm_time <- c((Gr5_Move_contact$Total_time[[1]]/mean_time),
                                (Gr5_Move_contact$Total_time[[2]]/mean_time),
                                (Gr5_Move_contact$Total_time[[3]]/mean_time),
                                (Gr5_Move_contact$Total_time[[4]]/mean_time))

Gr5_Stop_contact <- Gr5[Gr5$Event == "Stop_contact", ]
mean_nb <- mean(Gr5_Stop_contact[Gr5_Stop_contact$Genotype == "WT", "Amount"])
Gr5_Stop_contact$Norm_amount <- c((Gr5_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr5_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr5_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr5_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Stop_contact[Gr5_Stop_contact$Genotype == "WT", "Total_time"])
Gr5_Stop_contact$Norm_time <- c((Gr5_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr5_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr5_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr5_Stop_contact$Total_time[[4]]/mean_time))

Gr5_Rear_contact <- Gr5[Gr5$Event == "Rear_contact", ]
mean_nb <- mean(Gr5_Rear_contact[Gr5_Rear_contact$Genotype == "WT", "Amount"])
Gr5_Rear_contact$Norm_amount <- c((Gr5_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr5_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr5_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr5_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Rear_contact[Gr5_Rear_contact$Genotype == "WT", "Total_time"])
Gr5_Rear_contact$Norm_time <- c((Gr5_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr5_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr5_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr5_Rear_contact$Total_time[[4]]/mean_time))

Gr5_SbS_contact <- Gr5[Gr5$Event == "SbS_contact", ]
mean_nb <- mean(Gr5_SbS_contact[Gr5_SbS_contact$Genotype == "WT", "Amount"])
Gr5_SbS_contact$Norm_amount <- c((Gr5_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr5_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr5_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr5_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_SbS_contact[Gr5_SbS_contact$Genotype == "WT", "Total_time"])
Gr5_SbS_contact$Norm_time <- c((Gr5_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr5_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr5_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr5_SbS_contact$Total_time[[4]]/mean_time))

Gr5_SbSO_contact <- Gr5[Gr5$Event == "SbSO_contact", ]
mean_nb <- mean(Gr5_SbSO_contact[Gr5_SbSO_contact$Genotype == "WT", "Amount"])
Gr5_SbSO_contact$Norm_amount <- c((Gr5_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr5_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr5_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr5_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_SbSO_contact[Gr5_SbSO_contact$Genotype == "WT", "Total_time"])
Gr5_SbSO_contact$Norm_time <- c((Gr5_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr5_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr5_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr5_SbSO_contact$Total_time[[4]]/mean_time))

Gr5_OO_contact <- Gr5[Gr5$Event == "OO_contact", ]
mean_nb <- mean(Gr5_OO_contact[Gr5_OO_contact$Genotype == "WT", "Amount"])
Gr5_OO_contact$Norm_amount <- c((Gr5_OO_contact$Amount[[1]]/mean_nb),
                                (Gr5_OO_contact$Amount[[2]]/mean_nb),
                                (Gr5_OO_contact$Amount[[3]]/mean_nb),
                                (Gr5_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_OO_contact[Gr5_OO_contact$Genotype == "WT", "Total_time"])
Gr5_OO_contact$Norm_time <- c((Gr5_OO_contact$Total_time[[1]]/mean_time),
                              (Gr5_OO_contact$Total_time[[2]]/mean_time),
                              (Gr5_OO_contact$Total_time[[3]]/mean_time),
                              (Gr5_OO_contact$Total_time[[4]]/mean_time))

Gr5_OG_contact <- Gr5[Gr5$Event == "OG_contact", ]
mean_nb <- mean(Gr5_OG_contact[Gr5_OG_contact$Genotype == "WT", "Amount"])
Gr5_OG_contact$Norm_amount <- c((Gr5_OG_contact$Amount[[1]]/mean_nb),
                                (Gr5_OG_contact$Amount[[2]]/mean_nb),
                                (Gr5_OG_contact$Amount[[3]]/mean_nb),
                                (Gr5_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_OG_contact[Gr5_OG_contact$Genotype == "WT", "Total_time"])
Gr5_OG_contact$Norm_time <- c((Gr5_OG_contact$Total_time[[1]]/mean_time),
                              (Gr5_OG_contact$Total_time[[2]]/mean_time),
                              (Gr5_OG_contact$Total_time[[3]]/mean_time),
                              (Gr5_OG_contact$Total_time[[4]]/mean_time))

Gr5_Social_approach <- Gr5[Gr5$Event == "Social_approach", ]
mean_nb <- mean(Gr5_Social_approach[Gr5_Social_approach$Genotype == "WT", "Amount"])
Gr5_Social_approach$Norm_amount <- c((Gr5_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr5_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr5_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr5_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Social_approach[Gr5_Social_approach$Genotype == "WT", "Total_time"])
Gr5_Social_approach$Norm_time <- c((Gr5_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr5_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr5_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr5_Social_approach$Total_time[[4]]/mean_time))

Gr5_Approach_rear <- Gr5[Gr5$Event == "Approach_rear", ]
mean_nb <- mean(Gr5_Approach_rear[Gr5_Approach_rear$Genotype == "WT", "Amount"])
Gr5_Approach_rear$Norm_amount <- c((Gr5_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr5_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr5_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr5_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Approach_rear[Gr5_Approach_rear$Genotype == "WT", "Total_time"])
Gr5_Approach_rear$Norm_time <- c((Gr5_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr5_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr5_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr5_Approach_rear$Total_time[[4]]/mean_time))

Gr5_Contact <- Gr5[Gr5$Event == "Contact", ]
mean_nb <- mean(Gr5_Contact[Gr5_Contact$Genotype == "WT", "Amount"])
Gr5_Contact$Norm_amount <- c((Gr5_Contact$Amount[[1]]/mean_nb),
                             (Gr5_Contact$Amount[[2]]/mean_nb),
                             (Gr5_Contact$Amount[[3]]/mean_nb),
                             (Gr5_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Contact[Gr5_Contact$Genotype == "WT", "Total_time"])
Gr5_Contact$Norm_time <- c((Gr5_Contact$Total_time[[1]]/mean_time),
                           (Gr5_Contact$Total_time[[2]]/mean_time),
                           (Gr5_Contact$Total_time[[3]]/mean_time),
                           (Gr5_Contact$Total_time[[4]]/mean_time))

Gr5_Get_away <- Gr5[Gr5$Event == "Get_away", ]
mean_nb <- mean(Gr5_Get_away[Gr5_Get_away$Genotype == "WT", "Amount"])
Gr5_Get_away$Norm_amount <- c((Gr5_Get_away$Amount[[1]]/mean_nb),
                              (Gr5_Get_away$Amount[[2]]/mean_nb),
                              (Gr5_Get_away$Amount[[3]]/mean_nb),
                              (Gr5_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Get_away[Gr5_Get_away$Genotype == "WT", "Total_time"])
Gr5_Get_away$Norm_time <- c((Gr5_Get_away$Total_time[[1]]/mean_time),
                            (Gr5_Get_away$Total_time[[2]]/mean_time),
                            (Gr5_Get_away$Total_time[[3]]/mean_time),
                            (Gr5_Get_away$Total_time[[4]]/mean_time))

Gr5_Break_contact <- Gr5[Gr5$Event == "Break_contact", ]
mean_nb <- mean(Gr5_Break_contact[Gr5_Break_contact$Genotype == "WT", "Amount"])
Gr5_Break_contact$Norm_amount <- c((Gr5_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr5_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr5_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr5_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Break_contact[Gr5_Break_contact$Genotype == "WT", "Total_time"])
Gr5_Break_contact$Norm_time <- c((Gr5_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr5_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr5_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr5_Break_contact$Total_time[[4]]/mean_time))

Gr5_Train2 <- Gr5[Gr5$Event == "Train2", ]
mean_nb <- mean(Gr5_Train2[Gr5_Train2$Genotype == "WT", "Amount"])
Gr5_Train2$Norm_amount <- c((Gr5_Train2$Amount[[1]]/mean_nb),
                            (Gr5_Train2$Amount[[2]]/mean_nb),
                            (Gr5_Train2$Amount[[3]]/mean_nb),
                            (Gr5_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Train2[Gr5_Train2$Genotype == "WT", "Total_time"])
Gr5_Train2$Norm_time <- c((Gr5_Train2$Total_time[[1]]/mean_time),
                          (Gr5_Train2$Total_time[[2]]/mean_time),
                          (Gr5_Train2$Total_time[[3]]/mean_time),
                          (Gr5_Train2$Total_time[[4]]/mean_time))

Gr5_Group3make <- Gr5[Gr5$Event == "Group3make", ]
mean_nb <- mean(Gr5_Group3make[Gr5_Group3make$Genotype == "WT", "Amount"])
Gr5_Group3make$Norm_amount <- c((Gr5_Group3make$Amount[[1]]/mean_nb),
                                (Gr5_Group3make$Amount[[2]]/mean_nb),
                                (Gr5_Group3make$Amount[[3]]/mean_nb),
                                (Gr5_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Group3make[Gr5_Group3make$Genotype == "WT", "Total_time"])
Gr5_Group3make$Norm_time <- c((Gr5_Group3make$Total_time[[1]]/mean_time),
                              (Gr5_Group3make$Total_time[[2]]/mean_time),
                              (Gr5_Group3make$Total_time[[3]]/mean_time),
                              (Gr5_Group3make$Total_time[[4]]/mean_time))

Gr5_Group3break <- Gr5[Gr5$Event == "Group3break", ]
mean_nb <- mean(Gr5_Group3break[Gr5_Group3break$Genotype == "WT", "Amount"])
Gr5_Group3break$Norm_amount <- c((Gr5_Group3break$Amount[[1]]/mean_nb),
                                 (Gr5_Group3break$Amount[[2]]/mean_nb),
                                 (Gr5_Group3break$Amount[[3]]/mean_nb),
                                 (Gr5_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Group3break[Gr5_Group3break$Genotype == "WT", "Total_time"])
Gr5_Group3break$Norm_time <- c((Gr5_Group3break$Total_time[[1]]/mean_time),
                               (Gr5_Group3break$Total_time[[2]]/mean_time),
                               (Gr5_Group3break$Total_time[[3]]/mean_time),
                               (Gr5_Group3break$Total_time[[4]]/mean_time))

Gr5_Group4make <- Gr5[Gr5$Event == "Group4make", ]
mean_nb <- mean(Gr5_Group4make[Gr5_Group4make$Genotype == "WT", "Amount"])
Gr5_Group4make$Norm_amount <- c((Gr5_Group4make$Amount[[1]]/mean_nb),
                                (Gr5_Group4make$Amount[[2]]/mean_nb),
                                (Gr5_Group4make$Amount[[3]]/mean_nb),
                                (Gr5_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Group4make[Gr5_Group4make$Genotype == "WT", "Total_time"])
Gr5_Group4make$Norm_time <- c((Gr5_Group4make$Total_time[[1]]/mean_time),
                              (Gr5_Group4make$Total_time[[2]]/mean_time),
                              (Gr5_Group4make$Total_time[[3]]/mean_time),
                              (Gr5_Group4make$Total_time[[4]]/mean_time))

Gr5_Group4break <- Gr5[Gr5$Event == "Group4break", ]
mean_nb <- mean(Gr5_Group4break[Gr5_Group4break$Genotype == "WT", "Amount"])
Gr5_Group4break$Norm_amount <- c((Gr5_Group4break$Amount[[1]]/mean_nb),
                                 (Gr5_Group4break$Amount[[2]]/mean_nb),
                                 (Gr5_Group4break$Amount[[3]]/mean_nb),
                                 (Gr5_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr5_Group4break[Gr5_Group4break$Genotype == "WT", "Total_time"])
Gr5_Group4break$Norm_time <- c((Gr5_Group4break$Total_time[[1]]/mean_time),
                               (Gr5_Group4break$Total_time[[2]]/mean_time),
                               (Gr5_Group4break$Total_time[[3]]/mean_time),
                               (Gr5_Group4break$Total_time[[4]]/mean_time))

Gr5_norm <- rbind(Gr5_Move_iso,Gr5_Stop_iso,Gr5_Rear_iso,Gr5_Huddling,
                  Gr5_WallJump,Gr5_SAP, Gr5_Move_contact,Gr5_Stop_contact,
                  Gr5_Rear_contact,Gr5_SbS_contact,Gr5_SbSO_contact,
                  Gr5_OO_contact,Gr5_OG_contact,Gr5_Social_approach,
                  Gr5_Approach_rear,Gr5_Contact,Gr5_Get_away,
                  Gr5_Break_contact,Gr5_Train2,Gr5_Group3make,
                  Gr5_Group3break,Gr5_Group4make,Gr5_Group4break)

rm(Gr5_Move_iso,Gr5_Stop_iso,Gr5_Rear_iso,Gr5_Huddling,
   Gr5_WallJump,Gr5_SAP, Gr5_Move_contact,Gr5_Stop_contact,
   Gr5_Rear_contact,Gr5_SbS_contact,Gr5_SbSO_contact,
   Gr5_OO_contact,Gr5_OG_contact,Gr5_Social_approach,
   Gr5_Approach_rear,Gr5_Contact,Gr5_Get_away,
   Gr5_Break_contact,Gr5_Train2,Gr5_Group3make,
   Gr5_Group3break,Gr5_Group4make,Gr5_Group4break)

Gr6 <- Events[Events$Group == "M6", ]
Gr6_Move_iso <- Gr6[Gr6$Event == "Move_isolated", ]
mean_nb <- mean(Gr6_Move_iso[Gr6_Move_iso$Genotype == "WT", "Amount"])
Gr6_Move_iso$Norm_amount <- c((Gr6_Move_iso$Amount[[1]]/mean_nb),
                              (Gr6_Move_iso$Amount[[2]]/mean_nb),
                              (Gr6_Move_iso$Amount[[3]]/mean_nb),
                              (Gr6_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Move_iso[Gr6_Move_iso$Genotype == "WT", "Total_time"])
Gr6_Move_iso$Norm_time <- c((Gr6_Move_iso$Total_time[[1]]/mean_time),
                            (Gr6_Move_iso$Total_time[[2]]/mean_time),
                            (Gr6_Move_iso$Total_time[[3]]/mean_time),
                            (Gr6_Move_iso$Total_time[[4]]/mean_time))

Gr6_Stop_iso <- Gr6[Gr6$Event == "Stop_isolated", ]
mean_nb <- mean(Gr6_Stop_iso[Gr6_Stop_iso$Genotype == "WT", "Amount"])
Gr6_Stop_iso$Norm_amount <- c((Gr6_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr6_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr6_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr6_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Stop_iso[Gr6_Stop_iso$Genotype == "WT", "Total_time"])
Gr6_Stop_iso$Norm_time <- c((Gr6_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr6_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr6_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr6_Stop_iso$Total_time[[4]]/mean_time))

Gr6_Rear_iso <- Gr6[Gr6$Event == "Rear_isolated", ]
mean_nb <- mean(Gr6_Rear_iso[Gr6_Rear_iso$Genotype == "WT", "Amount"])
Gr6_Rear_iso$Norm_amount <- c((Gr6_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr6_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr6_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr6_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Rear_iso[Gr6_Rear_iso$Genotype == "WT", "Total_time"])
Gr6_Rear_iso$Norm_time <- c((Gr6_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr6_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr6_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr6_Rear_iso$Total_time[[4]]/mean_time))

Gr6_Huddling <- Gr6[Gr6$Event == "Huddling", ]
mean_nb <- mean(Gr6_Huddling[Gr6_Huddling$Genotype == "WT", "Amount"])
Gr6_Huddling$Norm_amount <- c((Gr6_Huddling$Amount[[1]]/mean_nb),
                              (Gr6_Huddling$Amount[[2]]/mean_nb),
                              (Gr6_Huddling$Amount[[3]]/mean_nb),
                              (Gr6_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Huddling[Gr6_Huddling$Genotype == "WT", "Total_time"])
Gr6_Huddling$Norm_time <- c((Gr6_Huddling$Total_time[[1]]/mean_time),
                            (Gr6_Huddling$Total_time[[2]]/mean_time),
                            (Gr6_Huddling$Total_time[[3]]/mean_time),
                            (Gr6_Huddling$Total_time[[4]]/mean_time))

Gr6_WallJump <- Gr6[Gr6$Event == "WallJump", ]
mean_nb <- mean(Gr6_WallJump[Gr6_WallJump$Genotype == "WT", "Amount"])
Gr6_WallJump$Norm_amount <- c((Gr6_WallJump$Amount[[1]]/mean_nb),
                              (Gr6_WallJump$Amount[[2]]/mean_nb),
                              (Gr6_WallJump$Amount[[3]]/mean_nb),
                              (Gr6_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_WallJump[Gr6_WallJump$Genotype == "WT", "Total_time"])
Gr6_WallJump$Norm_time <- c((Gr6_WallJump$Total_time[[1]]/mean_time),
                            (Gr6_WallJump$Total_time[[2]]/mean_time),
                            (Gr6_WallJump$Total_time[[3]]/mean_time),
                            (Gr6_WallJump$Total_time[[4]]/mean_time))

Gr6_SAP <- Gr6[Gr6$Event == "SAP", ]
mean_nb <- mean(Gr6_SAP[Gr6_SAP$Genotype == "WT", "Amount"])
Gr6_SAP$Norm_amount <- c((Gr6_SAP$Amount[[1]]/mean_nb),
                         (Gr6_SAP$Amount[[2]]/mean_nb),
                         (Gr6_SAP$Amount[[3]]/mean_nb),
                         (Gr6_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_SAP[Gr6_SAP$Genotype == "WT", "Total_time"])
Gr6_SAP$Norm_time <- c((Gr6_SAP$Total_time[[1]]/mean_time),
                       (Gr6_SAP$Total_time[[2]]/mean_time),
                       (Gr6_SAP$Total_time[[3]]/mean_time),
                       (Gr6_SAP$Total_time[[4]]/mean_time))

Gr6_Move_contact <- Gr6[Gr6$Event == "Move_contact", ]
mean_nb <- mean(Gr6_Move_contact[Gr6_Move_contact$Genotype == "WT", "Amount"])
Gr6_Move_contact$Norm_amount <- c((Gr6_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr6_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr6_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr6_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Move_contact[Gr6_Move_contact$Genotype == "WT", "Total_time"])
Gr6_Move_contact$Norm_time <- c((Gr6_Move_contact$Total_time[[1]]/mean_time),
                                (Gr6_Move_contact$Total_time[[2]]/mean_time),
                                (Gr6_Move_contact$Total_time[[3]]/mean_time),
                                (Gr6_Move_contact$Total_time[[4]]/mean_time))

Gr6_Stop_contact <- Gr6[Gr6$Event == "Stop_contact", ]
mean_nb <- mean(Gr6_Stop_contact[Gr6_Stop_contact$Genotype == "WT", "Amount"])
Gr6_Stop_contact$Norm_amount <- c((Gr6_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr6_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr6_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr6_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Stop_contact[Gr6_Stop_contact$Genotype == "WT", "Total_time"])
Gr6_Stop_contact$Norm_time <- c((Gr6_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr6_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr6_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr6_Stop_contact$Total_time[[4]]/mean_time))

Gr6_Rear_contact <- Gr6[Gr6$Event == "Rear_contact", ]
mean_nb <- mean(Gr6_Rear_contact[Gr6_Rear_contact$Genotype == "WT", "Amount"])
Gr6_Rear_contact$Norm_amount <- c((Gr6_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr6_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr6_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr6_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Rear_contact[Gr6_Rear_contact$Genotype == "WT", "Total_time"])
Gr6_Rear_contact$Norm_time <- c((Gr6_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr6_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr6_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr6_Rear_contact$Total_time[[4]]/mean_time))

Gr6_SbS_contact <- Gr6[Gr6$Event == "SbS_contact", ]
mean_nb <- mean(Gr6_SbS_contact[Gr6_SbS_contact$Genotype == "WT", "Amount"])
Gr6_SbS_contact$Norm_amount <- c((Gr6_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr6_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr6_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr6_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_SbS_contact[Gr6_SbS_contact$Genotype == "WT", "Total_time"])
Gr6_SbS_contact$Norm_time <- c((Gr6_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr6_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr6_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr6_SbS_contact$Total_time[[4]]/mean_time))

Gr6_SbSO_contact <- Gr6[Gr6$Event == "SbSO_contact", ]
mean_nb <- mean(Gr6_SbSO_contact[Gr6_SbSO_contact$Genotype == "WT", "Amount"])
Gr6_SbSO_contact$Norm_amount <- c((Gr6_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr6_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr6_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr6_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_SbSO_contact[Gr6_SbSO_contact$Genotype == "WT", "Total_time"])
Gr6_SbSO_contact$Norm_time <- c((Gr6_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr6_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr6_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr6_SbSO_contact$Total_time[[4]]/mean_time))

Gr6_OO_contact <- Gr6[Gr6$Event == "OO_contact", ]
mean_nb <- mean(Gr6_OO_contact[Gr6_OO_contact$Genotype == "WT", "Amount"])
Gr6_OO_contact$Norm_amount <- c((Gr6_OO_contact$Amount[[1]]/mean_nb),
                                (Gr6_OO_contact$Amount[[2]]/mean_nb),
                                (Gr6_OO_contact$Amount[[3]]/mean_nb),
                                (Gr6_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_OO_contact[Gr6_OO_contact$Genotype == "WT", "Total_time"])
Gr6_OO_contact$Norm_time <- c((Gr6_OO_contact$Total_time[[1]]/mean_time),
                              (Gr6_OO_contact$Total_time[[2]]/mean_time),
                              (Gr6_OO_contact$Total_time[[3]]/mean_time),
                              (Gr6_OO_contact$Total_time[[4]]/mean_time))

Gr6_OG_contact <- Gr6[Gr6$Event == "OG_contact", ]
mean_nb <- mean(Gr6_OG_contact[Gr6_OG_contact$Genotype == "WT", "Amount"])
Gr6_OG_contact$Norm_amount <- c((Gr6_OG_contact$Amount[[1]]/mean_nb),
                                (Gr6_OG_contact$Amount[[2]]/mean_nb),
                                (Gr6_OG_contact$Amount[[3]]/mean_nb),
                                (Gr6_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_OG_contact[Gr6_OG_contact$Genotype == "WT", "Total_time"])
Gr6_OG_contact$Norm_time <- c((Gr6_OG_contact$Total_time[[1]]/mean_time),
                              (Gr6_OG_contact$Total_time[[2]]/mean_time),
                              (Gr6_OG_contact$Total_time[[3]]/mean_time),
                              (Gr6_OG_contact$Total_time[[4]]/mean_time))

Gr6_Social_approach <- Gr6[Gr6$Event == "Social_approach", ]
mean_nb <- mean(Gr6_Social_approach[Gr6_Social_approach$Genotype == "WT", "Amount"])
Gr6_Social_approach$Norm_amount <- c((Gr6_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr6_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr6_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr6_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Social_approach[Gr6_Social_approach$Genotype == "WT", "Total_time"])
Gr6_Social_approach$Norm_time <- c((Gr6_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr6_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr6_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr6_Social_approach$Total_time[[4]]/mean_time))

Gr6_Approach_rear <- Gr6[Gr6$Event == "Approach_rear", ]
mean_nb <- mean(Gr6_Approach_rear[Gr6_Approach_rear$Genotype == "WT", "Amount"])
Gr6_Approach_rear$Norm_amount <- c((Gr6_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr6_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr6_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr6_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Approach_rear[Gr6_Approach_rear$Genotype == "WT", "Total_time"])
Gr6_Approach_rear$Norm_time <- c((Gr6_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr6_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr6_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr6_Approach_rear$Total_time[[4]]/mean_time))

Gr6_Contact <- Gr6[Gr6$Event == "Contact", ]
mean_nb <- mean(Gr6_Contact[Gr6_Contact$Genotype == "WT", "Amount"])
Gr6_Contact$Norm_amount <- c((Gr6_Contact$Amount[[1]]/mean_nb),
                             (Gr6_Contact$Amount[[2]]/mean_nb),
                             (Gr6_Contact$Amount[[3]]/mean_nb),
                             (Gr6_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Contact[Gr6_Contact$Genotype == "WT", "Total_time"])
Gr6_Contact$Norm_time <- c((Gr6_Contact$Total_time[[1]]/mean_time),
                           (Gr6_Contact$Total_time[[2]]/mean_time),
                           (Gr6_Contact$Total_time[[3]]/mean_time),
                           (Gr6_Contact$Total_time[[4]]/mean_time))

Gr6_Get_away <- Gr6[Gr6$Event == "Get_away", ]
mean_nb <- mean(Gr6_Get_away[Gr6_Get_away$Genotype == "WT", "Amount"])
Gr6_Get_away$Norm_amount <- c((Gr6_Get_away$Amount[[1]]/mean_nb),
                              (Gr6_Get_away$Amount[[2]]/mean_nb),
                              (Gr6_Get_away$Amount[[3]]/mean_nb),
                              (Gr6_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Get_away[Gr6_Get_away$Genotype == "WT", "Total_time"])
Gr6_Get_away$Norm_time <- c((Gr6_Get_away$Total_time[[1]]/mean_time),
                            (Gr6_Get_away$Total_time[[2]]/mean_time),
                            (Gr6_Get_away$Total_time[[3]]/mean_time),
                            (Gr6_Get_away$Total_time[[4]]/mean_time))

Gr6_Break_contact <- Gr6[Gr6$Event == "Break_contact", ]
mean_nb <- mean(Gr6_Break_contact[Gr6_Break_contact$Genotype == "WT", "Amount"])
Gr6_Break_contact$Norm_amount <- c((Gr6_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr6_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr6_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr6_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Break_contact[Gr6_Break_contact$Genotype == "WT", "Total_time"])
Gr6_Break_contact$Norm_time <- c((Gr6_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr6_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr6_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr6_Break_contact$Total_time[[4]]/mean_time))

Gr6_Train2 <- Gr6[Gr6$Event == "Train2", ]
mean_nb <- mean(Gr6_Train2[Gr6_Train2$Genotype == "WT", "Amount"])
Gr6_Train2$Norm_amount <- c((Gr6_Train2$Amount[[1]]/mean_nb),
                            (Gr6_Train2$Amount[[2]]/mean_nb),
                            (Gr6_Train2$Amount[[3]]/mean_nb),
                            (Gr6_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Train2[Gr6_Train2$Genotype == "WT", "Total_time"])
Gr6_Train2$Norm_time <- c((Gr6_Train2$Total_time[[1]]/mean_time),
                          (Gr6_Train2$Total_time[[2]]/mean_time),
                          (Gr6_Train2$Total_time[[3]]/mean_time),
                          (Gr6_Train2$Total_time[[4]]/mean_time))

Gr6_Group3make <- Gr6[Gr6$Event == "Group3make", ]
mean_nb <- mean(Gr6_Group3make[Gr6_Group3make$Genotype == "WT", "Amount"])
Gr6_Group3make$Norm_amount <- c((Gr6_Group3make$Amount[[1]]/mean_nb),
                                (Gr6_Group3make$Amount[[2]]/mean_nb),
                                (Gr6_Group3make$Amount[[3]]/mean_nb),
                                (Gr6_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Group3make[Gr6_Group3make$Genotype == "WT", "Total_time"])
Gr6_Group3make$Norm_time <- c((Gr6_Group3make$Total_time[[1]]/mean_time),
                              (Gr6_Group3make$Total_time[[2]]/mean_time),
                              (Gr6_Group3make$Total_time[[3]]/mean_time),
                              (Gr6_Group3make$Total_time[[4]]/mean_time))

Gr6_Group3break <- Gr6[Gr6$Event == "Group3break", ]
mean_nb <- mean(Gr6_Group3break[Gr6_Group3break$Genotype == "WT", "Amount"])
Gr6_Group3break$Norm_amount <- c((Gr6_Group3break$Amount[[1]]/mean_nb),
                                 (Gr6_Group3break$Amount[[2]]/mean_nb),
                                 (Gr6_Group3break$Amount[[3]]/mean_nb),
                                 (Gr6_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Group3break[Gr6_Group3break$Genotype == "WT", "Total_time"])
Gr6_Group3break$Norm_time <- c((Gr6_Group3break$Total_time[[1]]/mean_time),
                               (Gr6_Group3break$Total_time[[2]]/mean_time),
                               (Gr6_Group3break$Total_time[[3]]/mean_time),
                               (Gr6_Group3break$Total_time[[4]]/mean_time))

Gr6_Group4make <- Gr6[Gr6$Event == "Group4make", ]
mean_nb <- mean(Gr6_Group4make[Gr6_Group4make$Genotype == "WT", "Amount"])
Gr6_Group4make$Norm_amount <- c((Gr6_Group4make$Amount[[1]]/mean_nb),
                                (Gr6_Group4make$Amount[[2]]/mean_nb),
                                (Gr6_Group4make$Amount[[3]]/mean_nb),
                                (Gr6_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Group4make[Gr6_Group4make$Genotype == "WT", "Total_time"])
Gr6_Group4make$Norm_time <- c((Gr6_Group4make$Total_time[[1]]/mean_time),
                              (Gr6_Group4make$Total_time[[2]]/mean_time),
                              (Gr6_Group4make$Total_time[[3]]/mean_time),
                              (Gr6_Group4make$Total_time[[4]]/mean_time))

Gr6_Group4break <- Gr6[Gr6$Event == "Group4break", ]
mean_nb <- mean(Gr6_Group4break[Gr6_Group4break$Genotype == "WT", "Amount"])
Gr6_Group4break$Norm_amount <- c((Gr6_Group4break$Amount[[1]]/mean_nb),
                                 (Gr6_Group4break$Amount[[2]]/mean_nb),
                                 (Gr6_Group4break$Amount[[3]]/mean_nb),
                                 (Gr6_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr6_Group4break[Gr6_Group4break$Genotype == "WT", "Total_time"])
Gr6_Group4break$Norm_time <- c((Gr6_Group4break$Total_time[[1]]/mean_time),
                               (Gr6_Group4break$Total_time[[2]]/mean_time),
                               (Gr6_Group4break$Total_time[[3]]/mean_time),
                               (Gr6_Group4break$Total_time[[4]]/mean_time))

Gr6_norm <- rbind(Gr6_Move_iso,Gr6_Stop_iso,Gr6_Rear_iso,Gr6_Huddling,
                  Gr6_WallJump,Gr6_SAP, Gr6_Move_contact,Gr6_Stop_contact,
                  Gr6_Rear_contact,Gr6_SbS_contact,Gr6_SbSO_contact,
                  Gr6_OO_contact,Gr6_OG_contact,Gr6_Social_approach,
                  Gr6_Approach_rear,Gr6_Contact,Gr6_Get_away,
                  Gr6_Break_contact,Gr6_Train2,Gr6_Group3make,
                  Gr6_Group3break,Gr6_Group4make,Gr6_Group4break)

rm(Gr6_Move_iso,Gr6_Stop_iso,Gr6_Rear_iso,Gr6_Huddling,
   Gr6_WallJump,Gr6_SAP, Gr6_Move_contact,Gr6_Stop_contact,
   Gr6_Rear_contact,Gr6_SbS_contact,Gr6_SbSO_contact,
   Gr6_OO_contact,Gr6_OG_contact,Gr6_Social_approach,
   Gr6_Approach_rear,Gr6_Contact,Gr6_Get_away,
   Gr6_Break_contact,Gr6_Train2,Gr6_Group3make,
   Gr6_Group3break,Gr6_Group4make,Gr6_Group4break)

Gr7 <- Events[Events$Group == "M7", ]
Gr7_Move_iso <- Gr7[Gr7$Event == "Move_isolated", ]
mean_nb <- mean(Gr7_Move_iso[Gr7_Move_iso$Genotype == "WT", "Amount"])
Gr7_Move_iso$Norm_amount <- c((Gr7_Move_iso$Amount[[1]]/mean_nb),
                              (Gr7_Move_iso$Amount[[2]]/mean_nb),
                              (Gr7_Move_iso$Amount[[3]]/mean_nb),
                              (Gr7_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Move_iso[Gr7_Move_iso$Genotype == "WT", "Total_time"])
Gr7_Move_iso$Norm_time <- c((Gr7_Move_iso$Total_time[[1]]/mean_time),
                            (Gr7_Move_iso$Total_time[[2]]/mean_time),
                            (Gr7_Move_iso$Total_time[[3]]/mean_time),
                            (Gr7_Move_iso$Total_time[[4]]/mean_time))

Gr7_Stop_iso <- Gr7[Gr7$Event == "Stop_isolated", ]
mean_nb <- mean(Gr7_Stop_iso[Gr7_Stop_iso$Genotype == "WT", "Amount"])
Gr7_Stop_iso$Norm_amount <- c((Gr7_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr7_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr7_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr7_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Stop_iso[Gr7_Stop_iso$Genotype == "WT", "Total_time"])
Gr7_Stop_iso$Norm_time <- c((Gr7_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr7_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr7_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr7_Stop_iso$Total_time[[4]]/mean_time))

Gr7_Rear_iso <- Gr7[Gr7$Event == "Rear_isolated", ]
mean_nb <- mean(Gr7_Rear_iso[Gr7_Rear_iso$Genotype == "WT", "Amount"])
Gr7_Rear_iso$Norm_amount <- c((Gr7_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr7_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr7_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr7_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Rear_iso[Gr7_Rear_iso$Genotype == "WT", "Total_time"])
Gr7_Rear_iso$Norm_time <- c((Gr7_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr7_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr7_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr7_Rear_iso$Total_time[[4]]/mean_time))

Gr7_Huddling <- Gr7[Gr7$Event == "Huddling", ]
mean_nb <- mean(Gr7_Huddling[Gr7_Huddling$Genotype == "WT", "Amount"])
Gr7_Huddling$Norm_amount <- c((Gr7_Huddling$Amount[[1]]/mean_nb),
                              (Gr7_Huddling$Amount[[2]]/mean_nb),
                              (Gr7_Huddling$Amount[[3]]/mean_nb),
                              (Gr7_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Huddling[Gr7_Huddling$Genotype == "WT", "Total_time"])
Gr7_Huddling$Norm_time <- c((Gr7_Huddling$Total_time[[1]]/mean_time),
                            (Gr7_Huddling$Total_time[[2]]/mean_time),
                            (Gr7_Huddling$Total_time[[3]]/mean_time),
                            (Gr7_Huddling$Total_time[[4]]/mean_time))

Gr7_WallJump <- Gr7[Gr7$Event == "WallJump", ]
mean_nb <- mean(Gr7_WallJump[Gr7_WallJump$Genotype == "WT", "Amount"])
Gr7_WallJump$Norm_amount <- c((Gr7_WallJump$Amount[[1]]/mean_nb),
                              (Gr7_WallJump$Amount[[2]]/mean_nb),
                              (Gr7_WallJump$Amount[[3]]/mean_nb),
                              (Gr7_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_WallJump[Gr7_WallJump$Genotype == "WT", "Total_time"])
Gr7_WallJump$Norm_time <- c((Gr7_WallJump$Total_time[[1]]/mean_time),
                            (Gr7_WallJump$Total_time[[2]]/mean_time),
                            (Gr7_WallJump$Total_time[[3]]/mean_time),
                            (Gr7_WallJump$Total_time[[4]]/mean_time))

Gr7_SAP <- Gr7[Gr7$Event == "SAP", ]
mean_nb <- mean(Gr7_SAP[Gr7_SAP$Genotype == "WT", "Amount"])
Gr7_SAP$Norm_amount <- c((Gr7_SAP$Amount[[1]]/mean_nb),
                         (Gr7_SAP$Amount[[2]]/mean_nb),
                         (Gr7_SAP$Amount[[3]]/mean_nb),
                         (Gr7_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_SAP[Gr7_SAP$Genotype == "WT", "Total_time"])
Gr7_SAP$Norm_time <- c((Gr7_SAP$Total_time[[1]]/mean_time),
                       (Gr7_SAP$Total_time[[2]]/mean_time),
                       (Gr7_SAP$Total_time[[3]]/mean_time),
                       (Gr7_SAP$Total_time[[4]]/mean_time))

Gr7_Move_contact <- Gr7[Gr7$Event == "Move_contact", ]
mean_nb <- mean(Gr7_Move_contact[Gr7_Move_contact$Genotype == "WT", "Amount"])
Gr7_Move_contact$Norm_amount <- c((Gr7_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr7_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr7_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr7_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Move_contact[Gr7_Move_contact$Genotype == "WT", "Total_time"])
Gr7_Move_contact$Norm_time <- c((Gr7_Move_contact$Total_time[[1]]/mean_time),
                                (Gr7_Move_contact$Total_time[[2]]/mean_time),
                                (Gr7_Move_contact$Total_time[[3]]/mean_time),
                                (Gr7_Move_contact$Total_time[[4]]/mean_time))

Gr7_Stop_contact <- Gr7[Gr7$Event == "Stop_contact", ]
mean_nb <- mean(Gr7_Stop_contact[Gr7_Stop_contact$Genotype == "WT", "Amount"])
Gr7_Stop_contact$Norm_amount <- c((Gr7_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr7_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr7_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr7_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Stop_contact[Gr7_Stop_contact$Genotype == "WT", "Total_time"])
Gr7_Stop_contact$Norm_time <- c((Gr7_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr7_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr7_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr7_Stop_contact$Total_time[[4]]/mean_time))

Gr7_Rear_contact <- Gr7[Gr7$Event == "Rear_contact", ]
mean_nb <- mean(Gr7_Rear_contact[Gr7_Rear_contact$Genotype == "WT", "Amount"])
Gr7_Rear_contact$Norm_amount <- c((Gr7_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr7_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr7_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr7_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Rear_contact[Gr7_Rear_contact$Genotype == "WT", "Total_time"])
Gr7_Rear_contact$Norm_time <- c((Gr7_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr7_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr7_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr7_Rear_contact$Total_time[[4]]/mean_time))

Gr7_SbS_contact <- Gr7[Gr7$Event == "SbS_contact", ]
mean_nb <- mean(Gr7_SbS_contact[Gr7_SbS_contact$Genotype == "WT", "Amount"])
Gr7_SbS_contact$Norm_amount <- c((Gr7_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr7_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr7_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr7_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_SbS_contact[Gr7_SbS_contact$Genotype == "WT", "Total_time"])
Gr7_SbS_contact$Norm_time <- c((Gr7_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr7_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr7_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr7_SbS_contact$Total_time[[4]]/mean_time))

Gr7_SbSO_contact <- Gr7[Gr7$Event == "SbSO_contact", ]
mean_nb <- mean(Gr7_SbSO_contact[Gr7_SbSO_contact$Genotype == "WT", "Amount"])
Gr7_SbSO_contact$Norm_amount <- c((Gr7_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr7_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr7_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr7_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_SbSO_contact[Gr7_SbSO_contact$Genotype == "WT", "Total_time"])
Gr7_SbSO_contact$Norm_time <- c((Gr7_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr7_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr7_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr7_SbSO_contact$Total_time[[4]]/mean_time))

Gr7_OO_contact <- Gr7[Gr7$Event == "OO_contact", ]
mean_nb <- mean(Gr7_OO_contact[Gr7_OO_contact$Genotype == "WT", "Amount"])
Gr7_OO_contact$Norm_amount <- c((Gr7_OO_contact$Amount[[1]]/mean_nb),
                                (Gr7_OO_contact$Amount[[2]]/mean_nb),
                                (Gr7_OO_contact$Amount[[3]]/mean_nb),
                                (Gr7_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_OO_contact[Gr7_OO_contact$Genotype == "WT", "Total_time"])
Gr7_OO_contact$Norm_time <- c((Gr7_OO_contact$Total_time[[1]]/mean_time),
                              (Gr7_OO_contact$Total_time[[2]]/mean_time),
                              (Gr7_OO_contact$Total_time[[3]]/mean_time),
                              (Gr7_OO_contact$Total_time[[4]]/mean_time))

Gr7_OG_contact <- Gr7[Gr7$Event == "OG_contact", ]
mean_nb <- mean(Gr7_OG_contact[Gr7_OG_contact$Genotype == "WT", "Amount"])
Gr7_OG_contact$Norm_amount <- c((Gr7_OG_contact$Amount[[1]]/mean_nb),
                                (Gr7_OG_contact$Amount[[2]]/mean_nb),
                                (Gr7_OG_contact$Amount[[3]]/mean_nb),
                                (Gr7_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_OG_contact[Gr7_OG_contact$Genotype == "WT", "Total_time"])
Gr7_OG_contact$Norm_time <- c((Gr7_OG_contact$Total_time[[1]]/mean_time),
                              (Gr7_OG_contact$Total_time[[2]]/mean_time),
                              (Gr7_OG_contact$Total_time[[3]]/mean_time),
                              (Gr7_OG_contact$Total_time[[4]]/mean_time))

Gr7_Social_approach <- Gr7[Gr7$Event == "Social_approach", ]
mean_nb <- mean(Gr7_Social_approach[Gr7_Social_approach$Genotype == "WT", "Amount"])
Gr7_Social_approach$Norm_amount <- c((Gr7_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr7_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr7_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr7_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Social_approach[Gr7_Social_approach$Genotype == "WT", "Total_time"])
Gr7_Social_approach$Norm_time <- c((Gr7_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr7_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr7_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr7_Social_approach$Total_time[[4]]/mean_time))

Gr7_Approach_rear <- Gr7[Gr7$Event == "Approach_rear", ]
mean_nb <- mean(Gr7_Approach_rear[Gr7_Approach_rear$Genotype == "WT", "Amount"])
Gr7_Approach_rear$Norm_amount <- c((Gr7_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr7_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr7_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr7_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Approach_rear[Gr7_Approach_rear$Genotype == "WT", "Total_time"])
Gr7_Approach_rear$Norm_time <- c((Gr7_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr7_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr7_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr7_Approach_rear$Total_time[[4]]/mean_time))

Gr7_Contact <- Gr7[Gr7$Event == "Contact", ]
mean_nb <- mean(Gr7_Contact[Gr7_Contact$Genotype == "WT", "Amount"])
Gr7_Contact$Norm_amount <- c((Gr7_Contact$Amount[[1]]/mean_nb),
                             (Gr7_Contact$Amount[[2]]/mean_nb),
                             (Gr7_Contact$Amount[[3]]/mean_nb),
                             (Gr7_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Contact[Gr7_Contact$Genotype == "WT", "Total_time"])
Gr7_Contact$Norm_time <- c((Gr7_Contact$Total_time[[1]]/mean_time),
                           (Gr7_Contact$Total_time[[2]]/mean_time),
                           (Gr7_Contact$Total_time[[3]]/mean_time),
                           (Gr7_Contact$Total_time[[4]]/mean_time))

Gr7_Get_away <- Gr7[Gr7$Event == "Get_away", ]
mean_nb <- mean(Gr7_Get_away[Gr7_Get_away$Genotype == "WT", "Amount"])
Gr7_Get_away$Norm_amount <- c((Gr7_Get_away$Amount[[1]]/mean_nb),
                              (Gr7_Get_away$Amount[[2]]/mean_nb),
                              (Gr7_Get_away$Amount[[3]]/mean_nb),
                              (Gr7_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Get_away[Gr7_Get_away$Genotype == "WT", "Total_time"])
Gr7_Get_away$Norm_time <- c((Gr7_Get_away$Total_time[[1]]/mean_time),
                            (Gr7_Get_away$Total_time[[2]]/mean_time),
                            (Gr7_Get_away$Total_time[[3]]/mean_time),
                            (Gr7_Get_away$Total_time[[4]]/mean_time))

Gr7_Break_contact <- Gr7[Gr7$Event == "Break_contact", ]
mean_nb <- mean(Gr7_Break_contact[Gr7_Break_contact$Genotype == "WT", "Amount"])
Gr7_Break_contact$Norm_amount <- c((Gr7_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr7_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr7_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr7_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Break_contact[Gr7_Break_contact$Genotype == "WT", "Total_time"])
Gr7_Break_contact$Norm_time <- c((Gr7_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr7_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr7_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr7_Break_contact$Total_time[[4]]/mean_time))

Gr7_Train2 <- Gr7[Gr7$Event == "Train2", ]
mean_nb <- mean(Gr7_Train2[Gr7_Train2$Genotype == "WT", "Amount"])
Gr7_Train2$Norm_amount <- c((Gr7_Train2$Amount[[1]]/mean_nb),
                            (Gr7_Train2$Amount[[2]]/mean_nb),
                            (Gr7_Train2$Amount[[3]]/mean_nb),
                            (Gr7_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Train2[Gr7_Train2$Genotype == "WT", "Total_time"])
Gr7_Train2$Norm_time <- c((Gr7_Train2$Total_time[[1]]/mean_time),
                          (Gr7_Train2$Total_time[[2]]/mean_time),
                          (Gr7_Train2$Total_time[[3]]/mean_time),
                          (Gr7_Train2$Total_time[[4]]/mean_time))

Gr7_Group3make <- Gr7[Gr7$Event == "Group3make", ]
mean_nb <- mean(Gr7_Group3make[Gr7_Group3make$Genotype == "WT", "Amount"])
Gr7_Group3make$Norm_amount <- c((Gr7_Group3make$Amount[[1]]/mean_nb),
                                (Gr7_Group3make$Amount[[2]]/mean_nb),
                                (Gr7_Group3make$Amount[[3]]/mean_nb),
                                (Gr7_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Group3make[Gr7_Group3make$Genotype == "WT", "Total_time"])
Gr7_Group3make$Norm_time <- c((Gr7_Group3make$Total_time[[1]]/mean_time),
                              (Gr7_Group3make$Total_time[[2]]/mean_time),
                              (Gr7_Group3make$Total_time[[3]]/mean_time),
                              (Gr7_Group3make$Total_time[[4]]/mean_time))

Gr7_Group3break <- Gr7[Gr7$Event == "Group3break", ]
mean_nb <- mean(Gr7_Group3break[Gr7_Group3break$Genotype == "WT", "Amount"])
Gr7_Group3break$Norm_amount <- c((Gr7_Group3break$Amount[[1]]/mean_nb),
                                 (Gr7_Group3break$Amount[[2]]/mean_nb),
                                 (Gr7_Group3break$Amount[[3]]/mean_nb),
                                 (Gr7_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Group3break[Gr7_Group3break$Genotype == "WT", "Total_time"])
Gr7_Group3break$Norm_time <- c((Gr7_Group3break$Total_time[[1]]/mean_time),
                               (Gr7_Group3break$Total_time[[2]]/mean_time),
                               (Gr7_Group3break$Total_time[[3]]/mean_time),
                               (Gr7_Group3break$Total_time[[4]]/mean_time))

Gr7_Group4make <- Gr7[Gr7$Event == "Group4make", ]
mean_nb <- mean(Gr7_Group4make[Gr7_Group4make$Genotype == "WT", "Amount"])
Gr7_Group4make$Norm_amount <- c((Gr7_Group4make$Amount[[1]]/mean_nb),
                                (Gr7_Group4make$Amount[[2]]/mean_nb),
                                (Gr7_Group4make$Amount[[3]]/mean_nb),
                                (Gr7_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Group4make[Gr7_Group4make$Genotype == "WT", "Total_time"])
Gr7_Group4make$Norm_time <- c((Gr7_Group4make$Total_time[[1]]/mean_time),
                              (Gr7_Group4make$Total_time[[2]]/mean_time),
                              (Gr7_Group4make$Total_time[[3]]/mean_time),
                              (Gr7_Group4make$Total_time[[4]]/mean_time))

Gr7_Group4break <- Gr7[Gr7$Event == "Group4break", ]
mean_nb <- mean(Gr7_Group4break[Gr7_Group4break$Genotype == "WT", "Amount"])
Gr7_Group4break$Norm_amount <- c((Gr7_Group4break$Amount[[1]]/mean_nb),
                                 (Gr7_Group4break$Amount[[2]]/mean_nb),
                                 (Gr7_Group4break$Amount[[3]]/mean_nb),
                                 (Gr7_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr7_Group4break[Gr7_Group4break$Genotype == "WT", "Total_time"])
Gr7_Group4break$Norm_time <- c((Gr7_Group4break$Total_time[[1]]/mean_time),
                               (Gr7_Group4break$Total_time[[2]]/mean_time),
                               (Gr7_Group4break$Total_time[[3]]/mean_time),
                               (Gr7_Group4break$Total_time[[4]]/mean_time))

Gr7_norm <- rbind(Gr7_Move_iso,Gr7_Stop_iso,Gr7_Rear_iso,Gr7_Huddling,
                  Gr7_WallJump,Gr7_SAP, Gr7_Move_contact,Gr7_Stop_contact,
                  Gr7_Rear_contact,Gr7_SbS_contact,Gr7_SbSO_contact,
                  Gr7_OO_contact,Gr7_OG_contact,Gr7_Social_approach,
                  Gr7_Approach_rear,Gr7_Contact,Gr7_Get_away,
                  Gr7_Break_contact,Gr7_Train2,Gr7_Group3make,
                  Gr7_Group3break,Gr7_Group4make,Gr7_Group4break)

rm(Gr7_Move_iso,Gr7_Stop_iso,Gr7_Rear_iso,Gr7_Huddling,
   Gr7_WallJump,Gr7_SAP, Gr7_Move_contact,Gr7_Stop_contact,
   Gr7_Rear_contact,Gr7_SbS_contact,Gr7_SbSO_contact,
   Gr7_OO_contact,Gr7_OG_contact,Gr7_Social_approach,
   Gr7_Approach_rear,Gr7_Contact,Gr7_Get_away,
   Gr7_Break_contact,Gr7_Train2,Gr7_Group3make,
   Gr7_Group3break,Gr7_Group4make,Gr7_Group4break)

Gr8 <- Events[Events$Group == "M8", ]
Gr8_Move_iso <- Gr8[Gr8$Event == "Move_isolated", ]
mean_nb <- mean(Gr8_Move_iso[Gr8_Move_iso$Genotype == "WT", "Amount"])
Gr8_Move_iso$Norm_amount <- c((Gr8_Move_iso$Amount[[1]]/mean_nb),
                              (Gr8_Move_iso$Amount[[2]]/mean_nb),
                              (Gr8_Move_iso$Amount[[3]]/mean_nb),
                              (Gr8_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Move_iso[Gr8_Move_iso$Genotype == "WT", "Total_time"])
Gr8_Move_iso$Norm_time <- c((Gr8_Move_iso$Total_time[[1]]/mean_time),
                            (Gr8_Move_iso$Total_time[[2]]/mean_time),
                            (Gr8_Move_iso$Total_time[[3]]/mean_time),
                            (Gr8_Move_iso$Total_time[[4]]/mean_time))

Gr8_Stop_iso <- Gr8[Gr8$Event == "Stop_isolated", ]
mean_nb <- mean(Gr8_Stop_iso[Gr8_Stop_iso$Genotype == "WT", "Amount"])
Gr8_Stop_iso$Norm_amount <- c((Gr8_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr8_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr8_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr8_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Stop_iso[Gr8_Stop_iso$Genotype == "WT", "Total_time"])
Gr8_Stop_iso$Norm_time <- c((Gr8_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr8_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr8_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr8_Stop_iso$Total_time[[4]]/mean_time))

Gr8_Rear_iso <- Gr8[Gr8$Event == "Rear_isolated", ]
mean_nb <- mean(Gr8_Rear_iso[Gr8_Rear_iso$Genotype == "WT", "Amount"])
Gr8_Rear_iso$Norm_amount <- c((Gr8_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr8_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr8_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr8_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Rear_iso[Gr8_Rear_iso$Genotype == "WT", "Total_time"])
Gr8_Rear_iso$Norm_time <- c((Gr8_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr8_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr8_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr8_Rear_iso$Total_time[[4]]/mean_time))

Gr8_Huddling <- Gr8[Gr8$Event == "Huddling", ]
mean_nb <- mean(Gr8_Huddling[Gr8_Huddling$Genotype == "WT", "Amount"])
Gr8_Huddling$Norm_amount <- c((Gr8_Huddling$Amount[[1]]/mean_nb),
                              (Gr8_Huddling$Amount[[2]]/mean_nb),
                              (Gr8_Huddling$Amount[[3]]/mean_nb),
                              (Gr8_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Huddling[Gr8_Huddling$Genotype == "WT", "Total_time"])
Gr8_Huddling$Norm_time <- c((Gr8_Huddling$Total_time[[1]]/mean_time),
                            (Gr8_Huddling$Total_time[[2]]/mean_time),
                            (Gr8_Huddling$Total_time[[3]]/mean_time),
                            (Gr8_Huddling$Total_time[[4]]/mean_time))

Gr8_WallJump <- Gr8[Gr8$Event == "WallJump", ]
mean_nb <- mean(Gr8_WallJump[Gr8_WallJump$Genotype == "WT", "Amount"])
Gr8_WallJump$Norm_amount <- c((Gr8_WallJump$Amount[[1]]/mean_nb),
                              (Gr8_WallJump$Amount[[2]]/mean_nb),
                              (Gr8_WallJump$Amount[[3]]/mean_nb),
                              (Gr8_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_WallJump[Gr8_WallJump$Genotype == "WT", "Total_time"])
Gr8_WallJump$Norm_time <- c((Gr8_WallJump$Total_time[[1]]/mean_time),
                            (Gr8_WallJump$Total_time[[2]]/mean_time),
                            (Gr8_WallJump$Total_time[[3]]/mean_time),
                            (Gr8_WallJump$Total_time[[4]]/mean_time))

Gr8_SAP <- Gr8[Gr8$Event == "SAP", ]
mean_nb <- mean(Gr8_SAP[Gr8_SAP$Genotype == "WT", "Amount"])
Gr8_SAP$Norm_amount <- c((Gr8_SAP$Amount[[1]]/mean_nb),
                         (Gr8_SAP$Amount[[2]]/mean_nb),
                         (Gr8_SAP$Amount[[3]]/mean_nb),
                         (Gr8_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_SAP[Gr8_SAP$Genotype == "WT", "Total_time"])
Gr8_SAP$Norm_time <- c((Gr8_SAP$Total_time[[1]]/mean_time),
                       (Gr8_SAP$Total_time[[2]]/mean_time),
                       (Gr8_SAP$Total_time[[3]]/mean_time),
                       (Gr8_SAP$Total_time[[4]]/mean_time))

Gr8_Move_contact <- Gr8[Gr8$Event == "Move_contact", ]
mean_nb <- mean(Gr8_Move_contact[Gr8_Move_contact$Genotype == "WT", "Amount"])
Gr8_Move_contact$Norm_amount <- c((Gr8_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr8_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr8_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr8_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Move_contact[Gr8_Move_contact$Genotype == "WT", "Total_time"])
Gr8_Move_contact$Norm_time <- c((Gr8_Move_contact$Total_time[[1]]/mean_time),
                                (Gr8_Move_contact$Total_time[[2]]/mean_time),
                                (Gr8_Move_contact$Total_time[[3]]/mean_time),
                                (Gr8_Move_contact$Total_time[[4]]/mean_time))

Gr8_Stop_contact <- Gr8[Gr8$Event == "Stop_contact", ]
mean_nb <- mean(Gr8_Stop_contact[Gr8_Stop_contact$Genotype == "WT", "Amount"])
Gr8_Stop_contact$Norm_amount <- c((Gr8_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr8_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr8_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr8_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Stop_contact[Gr8_Stop_contact$Genotype == "WT", "Total_time"])
Gr8_Stop_contact$Norm_time <- c((Gr8_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr8_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr8_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr8_Stop_contact$Total_time[[4]]/mean_time))

Gr8_Rear_contact <- Gr8[Gr8$Event == "Rear_contact", ]
mean_nb <- mean(Gr8_Rear_contact[Gr8_Rear_contact$Genotype == "WT", "Amount"])
Gr8_Rear_contact$Norm_amount <- c((Gr8_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr8_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr8_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr8_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Rear_contact[Gr8_Rear_contact$Genotype == "WT", "Total_time"])
Gr8_Rear_contact$Norm_time <- c((Gr8_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr8_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr8_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr8_Rear_contact$Total_time[[4]]/mean_time))

Gr8_SbS_contact <- Gr8[Gr8$Event == "SbS_contact", ]
mean_nb <- mean(Gr8_SbS_contact[Gr8_SbS_contact$Genotype == "WT", "Amount"])
Gr8_SbS_contact$Norm_amount <- c((Gr8_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr8_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr8_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr8_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_SbS_contact[Gr8_SbS_contact$Genotype == "WT", "Total_time"])
Gr8_SbS_contact$Norm_time <- c((Gr8_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr8_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr8_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr8_SbS_contact$Total_time[[4]]/mean_time))

Gr8_SbSO_contact <- Gr8[Gr8$Event == "SbSO_contact", ]
mean_nb <- mean(Gr8_SbSO_contact[Gr8_SbSO_contact$Genotype == "WT", "Amount"])
Gr8_SbSO_contact$Norm_amount <- c((Gr8_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr8_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr8_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr8_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_SbSO_contact[Gr8_SbSO_contact$Genotype == "WT", "Total_time"])
Gr8_SbSO_contact$Norm_time <- c((Gr8_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr8_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr8_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr8_SbSO_contact$Total_time[[4]]/mean_time))

Gr8_OO_contact <- Gr8[Gr8$Event == "OO_contact", ]
mean_nb <- mean(Gr8_OO_contact[Gr8_OO_contact$Genotype == "WT", "Amount"])
Gr8_OO_contact$Norm_amount <- c((Gr8_OO_contact$Amount[[1]]/mean_nb),
                                (Gr8_OO_contact$Amount[[2]]/mean_nb),
                                (Gr8_OO_contact$Amount[[3]]/mean_nb),
                                (Gr8_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_OO_contact[Gr8_OO_contact$Genotype == "WT", "Total_time"])
Gr8_OO_contact$Norm_time <- c((Gr8_OO_contact$Total_time[[1]]/mean_time),
                              (Gr8_OO_contact$Total_time[[2]]/mean_time),
                              (Gr8_OO_contact$Total_time[[3]]/mean_time),
                              (Gr8_OO_contact$Total_time[[4]]/mean_time))

Gr8_OG_contact <- Gr8[Gr8$Event == "OG_contact", ]
mean_nb <- mean(Gr8_OG_contact[Gr8_OG_contact$Genotype == "WT", "Amount"])
Gr8_OG_contact$Norm_amount <- c((Gr8_OG_contact$Amount[[1]]/mean_nb),
                                (Gr8_OG_contact$Amount[[2]]/mean_nb),
                                (Gr8_OG_contact$Amount[[3]]/mean_nb),
                                (Gr8_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_OG_contact[Gr8_OG_contact$Genotype == "WT", "Total_time"])
Gr8_OG_contact$Norm_time <- c((Gr8_OG_contact$Total_time[[1]]/mean_time),
                              (Gr8_OG_contact$Total_time[[2]]/mean_time),
                              (Gr8_OG_contact$Total_time[[3]]/mean_time),
                              (Gr8_OG_contact$Total_time[[4]]/mean_time))

Gr8_Social_approach <- Gr8[Gr8$Event == "Social_approach", ]
mean_nb <- mean(Gr8_Social_approach[Gr8_Social_approach$Genotype == "WT", "Amount"])
Gr8_Social_approach$Norm_amount <- c((Gr8_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr8_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr8_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr8_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Social_approach[Gr8_Social_approach$Genotype == "WT", "Total_time"])
Gr8_Social_approach$Norm_time <- c((Gr8_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr8_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr8_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr8_Social_approach$Total_time[[4]]/mean_time))

Gr8_Approach_rear <- Gr8[Gr8$Event == "Approach_rear", ]
mean_nb <- mean(Gr8_Approach_rear[Gr8_Approach_rear$Genotype == "WT", "Amount"])
Gr8_Approach_rear$Norm_amount <- c((Gr8_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr8_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr8_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr8_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Approach_rear[Gr8_Approach_rear$Genotype == "WT", "Total_time"])
Gr8_Approach_rear$Norm_time <- c((Gr8_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr8_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr8_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr8_Approach_rear$Total_time[[4]]/mean_time))

Gr8_Contact <- Gr8[Gr8$Event == "Contact", ]
mean_nb <- mean(Gr8_Contact[Gr8_Contact$Genotype == "WT", "Amount"])
Gr8_Contact$Norm_amount <- c((Gr8_Contact$Amount[[1]]/mean_nb),
                             (Gr8_Contact$Amount[[2]]/mean_nb),
                             (Gr8_Contact$Amount[[3]]/mean_nb),
                             (Gr8_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Contact[Gr8_Contact$Genotype == "WT", "Total_time"])
Gr8_Contact$Norm_time <- c((Gr8_Contact$Total_time[[1]]/mean_time),
                           (Gr8_Contact$Total_time[[2]]/mean_time),
                           (Gr8_Contact$Total_time[[3]]/mean_time),
                           (Gr8_Contact$Total_time[[4]]/mean_time))

Gr8_Get_away <- Gr8[Gr8$Event == "Get_away", ]
mean_nb <- mean(Gr8_Get_away[Gr8_Get_away$Genotype == "WT", "Amount"])
Gr8_Get_away$Norm_amount <- c((Gr8_Get_away$Amount[[1]]/mean_nb),
                              (Gr8_Get_away$Amount[[2]]/mean_nb),
                              (Gr8_Get_away$Amount[[3]]/mean_nb),
                              (Gr8_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Get_away[Gr8_Get_away$Genotype == "WT", "Total_time"])
Gr8_Get_away$Norm_time <- c((Gr8_Get_away$Total_time[[1]]/mean_time),
                            (Gr8_Get_away$Total_time[[2]]/mean_time),
                            (Gr8_Get_away$Total_time[[3]]/mean_time),
                            (Gr8_Get_away$Total_time[[4]]/mean_time))

Gr8_Break_contact <- Gr8[Gr8$Event == "Break_contact", ]
mean_nb <- mean(Gr8_Break_contact[Gr8_Break_contact$Genotype == "WT", "Amount"])
Gr8_Break_contact$Norm_amount <- c((Gr8_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr8_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr8_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr8_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Break_contact[Gr8_Break_contact$Genotype == "WT", "Total_time"])
Gr8_Break_contact$Norm_time <- c((Gr8_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr8_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr8_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr8_Break_contact$Total_time[[4]]/mean_time))

Gr8_Train2 <- Gr8[Gr8$Event == "Train2", ]
mean_nb <- mean(Gr8_Train2[Gr8_Train2$Genotype == "WT", "Amount"])
Gr8_Train2$Norm_amount <- c((Gr8_Train2$Amount[[1]]/mean_nb),
                            (Gr8_Train2$Amount[[2]]/mean_nb),
                            (Gr8_Train2$Amount[[3]]/mean_nb),
                            (Gr8_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Train2[Gr8_Train2$Genotype == "WT", "Total_time"])
Gr8_Train2$Norm_time <- c((Gr8_Train2$Total_time[[1]]/mean_time),
                          (Gr8_Train2$Total_time[[2]]/mean_time),
                          (Gr8_Train2$Total_time[[3]]/mean_time),
                          (Gr8_Train2$Total_time[[4]]/mean_time))

Gr8_Group3make <- Gr8[Gr8$Event == "Group3make", ]
mean_nb <- mean(Gr8_Group3make[Gr8_Group3make$Genotype == "WT", "Amount"])
Gr8_Group3make$Norm_amount <- c((Gr8_Group3make$Amount[[1]]/mean_nb),
                                (Gr8_Group3make$Amount[[2]]/mean_nb),
                                (Gr8_Group3make$Amount[[3]]/mean_nb),
                                (Gr8_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Group3make[Gr8_Group3make$Genotype == "WT", "Total_time"])
Gr8_Group3make$Norm_time <- c((Gr8_Group3make$Total_time[[1]]/mean_time),
                              (Gr8_Group3make$Total_time[[2]]/mean_time),
                              (Gr8_Group3make$Total_time[[3]]/mean_time),
                              (Gr8_Group3make$Total_time[[4]]/mean_time))

Gr8_Group3break <- Gr8[Gr8$Event == "Group3break", ]
mean_nb <- mean(Gr8_Group3break[Gr8_Group3break$Genotype == "WT", "Amount"])
Gr8_Group3break$Norm_amount <- c((Gr8_Group3break$Amount[[1]]/mean_nb),
                                 (Gr8_Group3break$Amount[[2]]/mean_nb),
                                 (Gr8_Group3break$Amount[[3]]/mean_nb),
                                 (Gr8_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Group3break[Gr8_Group3break$Genotype == "WT", "Total_time"])
Gr8_Group3break$Norm_time <- c((Gr8_Group3break$Total_time[[1]]/mean_time),
                               (Gr8_Group3break$Total_time[[2]]/mean_time),
                               (Gr8_Group3break$Total_time[[3]]/mean_time),
                               (Gr8_Group3break$Total_time[[4]]/mean_time))

Gr8_Group4make <- Gr8[Gr8$Event == "Group4make", ]
mean_nb <- mean(Gr8_Group4make[Gr8_Group4make$Genotype == "WT", "Amount"])
Gr8_Group4make$Norm_amount <- c((Gr8_Group4make$Amount[[1]]/mean_nb),
                                (Gr8_Group4make$Amount[[2]]/mean_nb),
                                (Gr8_Group4make$Amount[[3]]/mean_nb),
                                (Gr8_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Group4make[Gr8_Group4make$Genotype == "WT", "Total_time"])
Gr8_Group4make$Norm_time <- c((Gr8_Group4make$Total_time[[1]]/mean_time),
                              (Gr8_Group4make$Total_time[[2]]/mean_time),
                              (Gr8_Group4make$Total_time[[3]]/mean_time),
                              (Gr8_Group4make$Total_time[[4]]/mean_time))

Gr8_Group4break <- Gr8[Gr8$Event == "Group4break", ]
mean_nb <- mean(Gr8_Group4break[Gr8_Group4break$Genotype == "WT", "Amount"])
Gr8_Group4break$Norm_amount <- c((Gr8_Group4break$Amount[[1]]/mean_nb),
                                 (Gr8_Group4break$Amount[[2]]/mean_nb),
                                 (Gr8_Group4break$Amount[[3]]/mean_nb),
                                 (Gr8_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr8_Group4break[Gr8_Group4break$Genotype == "WT", "Total_time"])
Gr8_Group4break$Norm_time <- c((Gr8_Group4break$Total_time[[1]]/mean_time),
                               (Gr8_Group4break$Total_time[[2]]/mean_time),
                               (Gr8_Group4break$Total_time[[3]]/mean_time),
                               (Gr8_Group4break$Total_time[[4]]/mean_time))

Gr8_norm <- rbind(Gr8_Move_iso,Gr8_Stop_iso,Gr8_Rear_iso,Gr8_Huddling,
                  Gr8_WallJump,Gr8_SAP, Gr8_Move_contact,Gr8_Stop_contact,
                  Gr8_Rear_contact,Gr8_SbS_contact,Gr8_SbSO_contact,
                  Gr8_OO_contact,Gr8_OG_contact,Gr8_Social_approach,
                  Gr8_Approach_rear,Gr8_Contact,Gr8_Get_away,
                  Gr8_Break_contact,Gr8_Train2,Gr8_Group3make,
                  Gr8_Group3break,Gr8_Group4make,Gr8_Group4break)

rm(Gr8_Move_iso,Gr8_Stop_iso,Gr8_Rear_iso,Gr8_Huddling,
   Gr8_WallJump,Gr8_SAP, Gr8_Move_contact,Gr8_Stop_contact,
   Gr8_Rear_contact,Gr8_SbS_contact,Gr8_SbSO_contact,
   Gr8_OO_contact,Gr8_OG_contact,Gr8_Social_approach,
   Gr8_Approach_rear,Gr8_Contact,Gr8_Get_away,
   Gr8_Break_contact,Gr8_Train2,Gr8_Group3make,
   Gr8_Group3break,Gr8_Group4make,Gr8_Group4break)

Gr9 <- Events[Events$Group == "M9", ]
Gr9_Move_iso <- Gr9[Gr9$Event == "Move_isolated", ]
mean_nb <- mean(Gr9_Move_iso[Gr9_Move_iso$Genotype == "WT", "Amount"])
Gr9_Move_iso$Norm_amount <- c((Gr9_Move_iso$Amount[[1]]/mean_nb),
                              (Gr9_Move_iso$Amount[[2]]/mean_nb),
                              (Gr9_Move_iso$Amount[[3]]/mean_nb),
                              (Gr9_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Move_iso[Gr9_Move_iso$Genotype == "WT", "Total_time"])
Gr9_Move_iso$Norm_time <- c((Gr9_Move_iso$Total_time[[1]]/mean_time),
                            (Gr9_Move_iso$Total_time[[2]]/mean_time),
                            (Gr9_Move_iso$Total_time[[3]]/mean_time),
                            (Gr9_Move_iso$Total_time[[4]]/mean_time))

Gr9_Stop_iso <- Gr9[Gr9$Event == "Stop_isolated", ]
mean_nb <- mean(Gr9_Stop_iso[Gr9_Stop_iso$Genotype == "WT", "Amount"])
Gr9_Stop_iso$Norm_amount <- c((Gr9_Stop_iso$Amount[[1]]/mean_nb),
                              (Gr9_Stop_iso$Amount[[2]]/mean_nb),
                              (Gr9_Stop_iso$Amount[[3]]/mean_nb),
                              (Gr9_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Stop_iso[Gr9_Stop_iso$Genotype == "WT", "Total_time"])
Gr9_Stop_iso$Norm_time <- c((Gr9_Stop_iso$Total_time[[1]]/mean_time),
                            (Gr9_Stop_iso$Total_time[[2]]/mean_time),
                            (Gr9_Stop_iso$Total_time[[3]]/mean_time),
                            (Gr9_Stop_iso$Total_time[[4]]/mean_time))

Gr9_Rear_iso <- Gr9[Gr9$Event == "Rear_isolated", ]
mean_nb <- mean(Gr9_Rear_iso[Gr9_Rear_iso$Genotype == "WT", "Amount"])
Gr9_Rear_iso$Norm_amount <- c((Gr9_Rear_iso$Amount[[1]]/mean_nb),
                              (Gr9_Rear_iso$Amount[[2]]/mean_nb),
                              (Gr9_Rear_iso$Amount[[3]]/mean_nb),
                              (Gr9_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Rear_iso[Gr9_Rear_iso$Genotype == "WT", "Total_time"])
Gr9_Rear_iso$Norm_time <- c((Gr9_Rear_iso$Total_time[[1]]/mean_time),
                            (Gr9_Rear_iso$Total_time[[2]]/mean_time),
                            (Gr9_Rear_iso$Total_time[[3]]/mean_time),
                            (Gr9_Rear_iso$Total_time[[4]]/mean_time))

Gr9_Huddling <- Gr9[Gr9$Event == "Huddling", ]
mean_nb <- mean(Gr9_Huddling[Gr9_Huddling$Genotype == "WT", "Amount"])
Gr9_Huddling$Norm_amount <- c((Gr9_Huddling$Amount[[1]]/mean_nb),
                              (Gr9_Huddling$Amount[[2]]/mean_nb),
                              (Gr9_Huddling$Amount[[3]]/mean_nb),
                              (Gr9_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Huddling[Gr9_Huddling$Genotype == "WT", "Total_time"])
Gr9_Huddling$Norm_time <- c((Gr9_Huddling$Total_time[[1]]/mean_time),
                            (Gr9_Huddling$Total_time[[2]]/mean_time),
                            (Gr9_Huddling$Total_time[[3]]/mean_time),
                            (Gr9_Huddling$Total_time[[4]]/mean_time))

Gr9_WallJump <- Gr9[Gr9$Event == "WallJump", ]
mean_nb <- mean(Gr9_WallJump[Gr9_WallJump$Genotype == "WT", "Amount"])
Gr9_WallJump$Norm_amount <- c((Gr9_WallJump$Amount[[1]]/mean_nb),
                              (Gr9_WallJump$Amount[[2]]/mean_nb),
                              (Gr9_WallJump$Amount[[3]]/mean_nb),
                              (Gr9_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_WallJump[Gr9_WallJump$Genotype == "WT", "Total_time"])
Gr9_WallJump$Norm_time <- c((Gr9_WallJump$Total_time[[1]]/mean_time),
                            (Gr9_WallJump$Total_time[[2]]/mean_time),
                            (Gr9_WallJump$Total_time[[3]]/mean_time),
                            (Gr9_WallJump$Total_time[[4]]/mean_time))

Gr9_SAP <- Gr9[Gr9$Event == "SAP", ]
mean_nb <- mean(Gr9_SAP[Gr9_SAP$Genotype == "WT", "Amount"])
Gr9_SAP$Norm_amount <- c((Gr9_SAP$Amount[[1]]/mean_nb),
                         (Gr9_SAP$Amount[[2]]/mean_nb),
                         (Gr9_SAP$Amount[[3]]/mean_nb),
                         (Gr9_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_SAP[Gr9_SAP$Genotype == "WT", "Total_time"])
Gr9_SAP$Norm_time <- c((Gr9_SAP$Total_time[[1]]/mean_time),
                       (Gr9_SAP$Total_time[[2]]/mean_time),
                       (Gr9_SAP$Total_time[[3]]/mean_time),
                       (Gr9_SAP$Total_time[[4]]/mean_time))

Gr9_Move_contact <- Gr9[Gr9$Event == "Move_contact", ]
mean_nb <- mean(Gr9_Move_contact[Gr9_Move_contact$Genotype == "WT", "Amount"])
Gr9_Move_contact$Norm_amount <- c((Gr9_Move_contact$Amount[[1]]/mean_nb),
                                  (Gr9_Move_contact$Amount[[2]]/mean_nb),
                                  (Gr9_Move_contact$Amount[[3]]/mean_nb),
                                  (Gr9_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Move_contact[Gr9_Move_contact$Genotype == "WT", "Total_time"])
Gr9_Move_contact$Norm_time <- c((Gr9_Move_contact$Total_time[[1]]/mean_time),
                                (Gr9_Move_contact$Total_time[[2]]/mean_time),
                                (Gr9_Move_contact$Total_time[[3]]/mean_time),
                                (Gr9_Move_contact$Total_time[[4]]/mean_time))

Gr9_Stop_contact <- Gr9[Gr9$Event == "Stop_contact", ]
mean_nb <- mean(Gr9_Stop_contact[Gr9_Stop_contact$Genotype == "WT", "Amount"])
Gr9_Stop_contact$Norm_amount <- c((Gr9_Stop_contact$Amount[[1]]/mean_nb),
                                  (Gr9_Stop_contact$Amount[[2]]/mean_nb),
                                  (Gr9_Stop_contact$Amount[[3]]/mean_nb),
                                  (Gr9_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Stop_contact[Gr9_Stop_contact$Genotype == "WT", "Total_time"])
Gr9_Stop_contact$Norm_time <- c((Gr9_Stop_contact$Total_time[[1]]/mean_time),
                                (Gr9_Stop_contact$Total_time[[2]]/mean_time),
                                (Gr9_Stop_contact$Total_time[[3]]/mean_time),
                                (Gr9_Stop_contact$Total_time[[4]]/mean_time))

Gr9_Rear_contact <- Gr9[Gr9$Event == "Rear_contact", ]
mean_nb <- mean(Gr9_Rear_contact[Gr9_Rear_contact$Genotype == "WT", "Amount"])
Gr9_Rear_contact$Norm_amount <- c((Gr9_Rear_contact$Amount[[1]]/mean_nb),
                                  (Gr9_Rear_contact$Amount[[2]]/mean_nb),
                                  (Gr9_Rear_contact$Amount[[3]]/mean_nb),
                                  (Gr9_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Rear_contact[Gr9_Rear_contact$Genotype == "WT", "Total_time"])
Gr9_Rear_contact$Norm_time <- c((Gr9_Rear_contact$Total_time[[1]]/mean_time),
                                (Gr9_Rear_contact$Total_time[[2]]/mean_time),
                                (Gr9_Rear_contact$Total_time[[3]]/mean_time),
                                (Gr9_Rear_contact$Total_time[[4]]/mean_time))

Gr9_SbS_contact <- Gr9[Gr9$Event == "SbS_contact", ]
mean_nb <- mean(Gr9_SbS_contact[Gr9_SbS_contact$Genotype == "WT", "Amount"])
Gr9_SbS_contact$Norm_amount <- c((Gr9_SbS_contact$Amount[[1]]/mean_nb),
                                 (Gr9_SbS_contact$Amount[[2]]/mean_nb),
                                 (Gr9_SbS_contact$Amount[[3]]/mean_nb),
                                 (Gr9_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_SbS_contact[Gr9_SbS_contact$Genotype == "WT", "Total_time"])
Gr9_SbS_contact$Norm_time <- c((Gr9_SbS_contact$Total_time[[1]]/mean_time),
                               (Gr9_SbS_contact$Total_time[[2]]/mean_time),
                               (Gr9_SbS_contact$Total_time[[3]]/mean_time),
                               (Gr9_SbS_contact$Total_time[[4]]/mean_time))

Gr9_SbSO_contact <- Gr9[Gr9$Event == "SbSO_contact", ]
mean_nb <- mean(Gr9_SbSO_contact[Gr9_SbSO_contact$Genotype == "WT", "Amount"])
Gr9_SbSO_contact$Norm_amount <- c((Gr9_SbSO_contact$Amount[[1]]/mean_nb),
                                  (Gr9_SbSO_contact$Amount[[2]]/mean_nb),
                                  (Gr9_SbSO_contact$Amount[[3]]/mean_nb),
                                  (Gr9_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_SbSO_contact[Gr9_SbSO_contact$Genotype == "WT", "Total_time"])
Gr9_SbSO_contact$Norm_time <- c((Gr9_SbSO_contact$Total_time[[1]]/mean_time),
                                (Gr9_SbSO_contact$Total_time[[2]]/mean_time),
                                (Gr9_SbSO_contact$Total_time[[3]]/mean_time),
                                (Gr9_SbSO_contact$Total_time[[4]]/mean_time))

Gr9_OO_contact <- Gr9[Gr9$Event == "OO_contact", ]
mean_nb <- mean(Gr9_OO_contact[Gr9_OO_contact$Genotype == "WT", "Amount"])
Gr9_OO_contact$Norm_amount <- c((Gr9_OO_contact$Amount[[1]]/mean_nb),
                                (Gr9_OO_contact$Amount[[2]]/mean_nb),
                                (Gr9_OO_contact$Amount[[3]]/mean_nb),
                                (Gr9_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_OO_contact[Gr9_OO_contact$Genotype == "WT", "Total_time"])
Gr9_OO_contact$Norm_time <- c((Gr9_OO_contact$Total_time[[1]]/mean_time),
                              (Gr9_OO_contact$Total_time[[2]]/mean_time),
                              (Gr9_OO_contact$Total_time[[3]]/mean_time),
                              (Gr9_OO_contact$Total_time[[4]]/mean_time))

Gr9_OG_contact <- Gr9[Gr9$Event == "OG_contact", ]
mean_nb <- mean(Gr9_OG_contact[Gr9_OG_contact$Genotype == "WT", "Amount"])
Gr9_OG_contact$Norm_amount <- c((Gr9_OG_contact$Amount[[1]]/mean_nb),
                                (Gr9_OG_contact$Amount[[2]]/mean_nb),
                                (Gr9_OG_contact$Amount[[3]]/mean_nb),
                                (Gr9_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_OG_contact[Gr9_OG_contact$Genotype == "WT", "Total_time"])
Gr9_OG_contact$Norm_time <- c((Gr9_OG_contact$Total_time[[1]]/mean_time),
                              (Gr9_OG_contact$Total_time[[2]]/mean_time),
                              (Gr9_OG_contact$Total_time[[3]]/mean_time),
                              (Gr9_OG_contact$Total_time[[4]]/mean_time))

Gr9_Social_approach <- Gr9[Gr9$Event == "Social_approach", ]
mean_nb <- mean(Gr9_Social_approach[Gr9_Social_approach$Genotype == "WT", "Amount"])
Gr9_Social_approach$Norm_amount <- c((Gr9_Social_approach$Amount[[1]]/mean_nb),
                                     (Gr9_Social_approach$Amount[[2]]/mean_nb),
                                     (Gr9_Social_approach$Amount[[3]]/mean_nb),
                                     (Gr9_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Social_approach[Gr9_Social_approach$Genotype == "WT", "Total_time"])
Gr9_Social_approach$Norm_time <- c((Gr9_Social_approach$Total_time[[1]]/mean_time),
                                   (Gr9_Social_approach$Total_time[[2]]/mean_time),
                                   (Gr9_Social_approach$Total_time[[3]]/mean_time),
                                   (Gr9_Social_approach$Total_time[[4]]/mean_time))

Gr9_Approach_rear <- Gr9[Gr9$Event == "Approach_rear", ]
mean_nb <- mean(Gr9_Approach_rear[Gr9_Approach_rear$Genotype == "WT", "Amount"])
Gr9_Approach_rear$Norm_amount <- c((Gr9_Approach_rear$Amount[[1]]/mean_nb),
                                   (Gr9_Approach_rear$Amount[[2]]/mean_nb),
                                   (Gr9_Approach_rear$Amount[[3]]/mean_nb),
                                   (Gr9_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Approach_rear[Gr9_Approach_rear$Genotype == "WT", "Total_time"])
Gr9_Approach_rear$Norm_time <- c((Gr9_Approach_rear$Total_time[[1]]/mean_time),
                                 (Gr9_Approach_rear$Total_time[[2]]/mean_time),
                                 (Gr9_Approach_rear$Total_time[[3]]/mean_time),
                                 (Gr9_Approach_rear$Total_time[[4]]/mean_time))

Gr9_Contact <- Gr9[Gr9$Event == "Contact", ]
mean_nb <- mean(Gr9_Contact[Gr9_Contact$Genotype == "WT", "Amount"])
Gr9_Contact$Norm_amount <- c((Gr9_Contact$Amount[[1]]/mean_nb),
                             (Gr9_Contact$Amount[[2]]/mean_nb),
                             (Gr9_Contact$Amount[[3]]/mean_nb),
                             (Gr9_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Contact[Gr9_Contact$Genotype == "WT", "Total_time"])
Gr9_Contact$Norm_time <- c((Gr9_Contact$Total_time[[1]]/mean_time),
                           (Gr9_Contact$Total_time[[2]]/mean_time),
                           (Gr9_Contact$Total_time[[3]]/mean_time),
                           (Gr9_Contact$Total_time[[4]]/mean_time))

Gr9_Get_away <- Gr9[Gr9$Event == "Get_away", ]
mean_nb <- mean(Gr9_Get_away[Gr9_Get_away$Genotype == "WT", "Amount"])
Gr9_Get_away$Norm_amount <- c((Gr9_Get_away$Amount[[1]]/mean_nb),
                              (Gr9_Get_away$Amount[[2]]/mean_nb),
                              (Gr9_Get_away$Amount[[3]]/mean_nb),
                              (Gr9_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Get_away[Gr9_Get_away$Genotype == "WT", "Total_time"])
Gr9_Get_away$Norm_time <- c((Gr9_Get_away$Total_time[[1]]/mean_time),
                            (Gr9_Get_away$Total_time[[2]]/mean_time),
                            (Gr9_Get_away$Total_time[[3]]/mean_time),
                            (Gr9_Get_away$Total_time[[4]]/mean_time))

Gr9_Break_contact <- Gr9[Gr9$Event == "Break_contact", ]
mean_nb <- mean(Gr9_Break_contact[Gr9_Break_contact$Genotype == "WT", "Amount"])
Gr9_Break_contact$Norm_amount <- c((Gr9_Break_contact$Amount[[1]]/mean_nb),
                                   (Gr9_Break_contact$Amount[[2]]/mean_nb),
                                   (Gr9_Break_contact$Amount[[3]]/mean_nb),
                                   (Gr9_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Break_contact[Gr9_Break_contact$Genotype == "WT", "Total_time"])
Gr9_Break_contact$Norm_time <- c((Gr9_Break_contact$Total_time[[1]]/mean_time),
                                 (Gr9_Break_contact$Total_time[[2]]/mean_time),
                                 (Gr9_Break_contact$Total_time[[3]]/mean_time),
                                 (Gr9_Break_contact$Total_time[[4]]/mean_time))

Gr9_Train2 <- Gr9[Gr9$Event == "Train2", ]
mean_nb <- mean(Gr9_Train2[Gr9_Train2$Genotype == "WT", "Amount"])
Gr9_Train2$Norm_amount <- c((Gr9_Train2$Amount[[1]]/mean_nb),
                            (Gr9_Train2$Amount[[2]]/mean_nb),
                            (Gr9_Train2$Amount[[3]]/mean_nb),
                            (Gr9_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Train2[Gr9_Train2$Genotype == "WT", "Total_time"])
Gr9_Train2$Norm_time <- c((Gr9_Train2$Total_time[[1]]/mean_time),
                          (Gr9_Train2$Total_time[[2]]/mean_time),
                          (Gr9_Train2$Total_time[[3]]/mean_time),
                          (Gr9_Train2$Total_time[[4]]/mean_time))

Gr9_Group3make <- Gr9[Gr9$Event == "Group3make", ]
mean_nb <- mean(Gr9_Group3make[Gr9_Group3make$Genotype == "WT", "Amount"])
Gr9_Group3make$Norm_amount <- c((Gr9_Group3make$Amount[[1]]/mean_nb),
                                (Gr9_Group3make$Amount[[2]]/mean_nb),
                                (Gr9_Group3make$Amount[[3]]/mean_nb),
                                (Gr9_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Group3make[Gr9_Group3make$Genotype == "WT", "Total_time"])
Gr9_Group3make$Norm_time <- c((Gr9_Group3make$Total_time[[1]]/mean_time),
                              (Gr9_Group3make$Total_time[[2]]/mean_time),
                              (Gr9_Group3make$Total_time[[3]]/mean_time),
                              (Gr9_Group3make$Total_time[[4]]/mean_time))

Gr9_Group3break <- Gr9[Gr9$Event == "Group3break", ]
mean_nb <- mean(Gr9_Group3break[Gr9_Group3break$Genotype == "WT", "Amount"])
Gr9_Group3break$Norm_amount <- c((Gr9_Group3break$Amount[[1]]/mean_nb),
                                 (Gr9_Group3break$Amount[[2]]/mean_nb),
                                 (Gr9_Group3break$Amount[[3]]/mean_nb),
                                 (Gr9_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Group3break[Gr9_Group3break$Genotype == "WT", "Total_time"])
Gr9_Group3break$Norm_time <- c((Gr9_Group3break$Total_time[[1]]/mean_time),
                               (Gr9_Group3break$Total_time[[2]]/mean_time),
                               (Gr9_Group3break$Total_time[[3]]/mean_time),
                               (Gr9_Group3break$Total_time[[4]]/mean_time))

Gr9_Group4make <- Gr9[Gr9$Event == "Group4make", ]
mean_nb <- mean(Gr9_Group4make[Gr9_Group4make$Genotype == "WT", "Amount"])
Gr9_Group4make$Norm_amount <- c((Gr9_Group4make$Amount[[1]]/mean_nb),
                                (Gr9_Group4make$Amount[[2]]/mean_nb),
                                (Gr9_Group4make$Amount[[3]]/mean_nb),
                                (Gr9_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Group4make[Gr9_Group4make$Genotype == "WT", "Total_time"])
Gr9_Group4make$Norm_time <- c((Gr9_Group4make$Total_time[[1]]/mean_time),
                              (Gr9_Group4make$Total_time[[2]]/mean_time),
                              (Gr9_Group4make$Total_time[[3]]/mean_time),
                              (Gr9_Group4make$Total_time[[4]]/mean_time))

Gr9_Group4break <- Gr9[Gr9$Event == "Group4break", ]
mean_nb <- mean(Gr9_Group4break[Gr9_Group4break$Genotype == "WT", "Amount"])
Gr9_Group4break$Norm_amount <- c((Gr9_Group4break$Amount[[1]]/mean_nb),
                                 (Gr9_Group4break$Amount[[2]]/mean_nb),
                                 (Gr9_Group4break$Amount[[3]]/mean_nb),
                                 (Gr9_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr9_Group4break[Gr9_Group4break$Genotype == "WT", "Total_time"])
Gr9_Group4break$Norm_time <- c((Gr9_Group4break$Total_time[[1]]/mean_time),
                               (Gr9_Group4break$Total_time[[2]]/mean_time),
                               (Gr9_Group4break$Total_time[[3]]/mean_time),
                               (Gr9_Group4break$Total_time[[4]]/mean_time))

Gr9_norm <- rbind(Gr9_Move_iso,Gr9_Stop_iso,Gr9_Rear_iso,Gr9_Huddling,
                  Gr9_WallJump,Gr9_SAP, Gr9_Move_contact,Gr9_Stop_contact,
                  Gr9_Rear_contact,Gr9_SbS_contact,Gr9_SbSO_contact,
                  Gr9_OO_contact,Gr9_OG_contact,Gr9_Social_approach,
                  Gr9_Approach_rear,Gr9_Contact,Gr9_Get_away,
                  Gr9_Break_contact,Gr9_Train2,Gr9_Group3make,
                  Gr9_Group3break,Gr9_Group4make,Gr9_Group4break)

rm(Gr9_Move_iso,Gr9_Stop_iso,Gr9_Rear_iso,Gr9_Huddling,
   Gr9_WallJump,Gr9_SAP, Gr9_Move_contact,Gr9_Stop_contact,
   Gr9_Rear_contact,Gr9_SbS_contact,Gr9_SbSO_contact,
   Gr9_OO_contact,Gr9_OG_contact,Gr9_Social_approach,
   Gr9_Approach_rear,Gr9_Contact,Gr9_Get_away,
   Gr9_Break_contact,Gr9_Train2,Gr9_Group3make,
   Gr9_Group3break,Gr9_Group4make,Gr9_Group4break)

Gr10 <- Events[Events$Group == "M10", ]
Gr10_Move_iso <- Gr10[Gr10$Event == "Move_isolated", ]
mean_nb <- mean(Gr10_Move_iso[Gr10_Move_iso$Genotype == "WT", "Amount"])
Gr10_Move_iso$Norm_amount <- c((Gr10_Move_iso$Amount[[1]]/mean_nb),
                               (Gr10_Move_iso$Amount[[2]]/mean_nb),
                               (Gr10_Move_iso$Amount[[3]]/mean_nb),
                               (Gr10_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Move_iso[Gr10_Move_iso$Genotype == "WT", "Total_time"])
Gr10_Move_iso$Norm_time <- c((Gr10_Move_iso$Total_time[[1]]/mean_time),
                             (Gr10_Move_iso$Total_time[[2]]/mean_time),
                             (Gr10_Move_iso$Total_time[[3]]/mean_time),
                             (Gr10_Move_iso$Total_time[[4]]/mean_time))

Gr10_Stop_iso <- Gr10[Gr10$Event == "Stop_isolated", ]
mean_nb <- mean(Gr10_Stop_iso[Gr10_Stop_iso$Genotype == "WT", "Amount"])
Gr10_Stop_iso$Norm_amount <- c((Gr10_Stop_iso$Amount[[1]]/mean_nb),
                               (Gr10_Stop_iso$Amount[[2]]/mean_nb),
                               (Gr10_Stop_iso$Amount[[3]]/mean_nb),
                               (Gr10_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Stop_iso[Gr10_Stop_iso$Genotype == "WT", "Total_time"])
Gr10_Stop_iso$Norm_time <- c((Gr10_Stop_iso$Total_time[[1]]/mean_time),
                             (Gr10_Stop_iso$Total_time[[2]]/mean_time),
                             (Gr10_Stop_iso$Total_time[[3]]/mean_time),
                             (Gr10_Stop_iso$Total_time[[4]]/mean_time))

Gr10_Rear_iso <- Gr10[Gr10$Event == "Rear_isolated", ]
mean_nb <- mean(Gr10_Rear_iso[Gr10_Rear_iso$Genotype == "WT", "Amount"])
Gr10_Rear_iso$Norm_amount <- c((Gr10_Rear_iso$Amount[[1]]/mean_nb),
                               (Gr10_Rear_iso$Amount[[2]]/mean_nb),
                               (Gr10_Rear_iso$Amount[[3]]/mean_nb),
                               (Gr10_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Rear_iso[Gr10_Rear_iso$Genotype == "WT", "Total_time"])
Gr10_Rear_iso$Norm_time <- c((Gr10_Rear_iso$Total_time[[1]]/mean_time),
                             (Gr10_Rear_iso$Total_time[[2]]/mean_time),
                             (Gr10_Rear_iso$Total_time[[3]]/mean_time),
                             (Gr10_Rear_iso$Total_time[[4]]/mean_time))

Gr10_Huddling <- Gr10[Gr10$Event == "Huddling", ]
mean_nb <- mean(Gr10_Huddling[Gr10_Huddling$Genotype == "WT", "Amount"])
Gr10_Huddling$Norm_amount <- c((Gr10_Huddling$Amount[[1]]/mean_nb),
                               (Gr10_Huddling$Amount[[2]]/mean_nb),
                               (Gr10_Huddling$Amount[[3]]/mean_nb),
                               (Gr10_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Huddling[Gr10_Huddling$Genotype == "WT", "Total_time"])
Gr10_Huddling$Norm_time <- c((Gr10_Huddling$Total_time[[1]]/mean_time),
                             (Gr10_Huddling$Total_time[[2]]/mean_time),
                             (Gr10_Huddling$Total_time[[3]]/mean_time),
                             (Gr10_Huddling$Total_time[[4]]/mean_time))

Gr10_WallJump <- Gr10[Gr10$Event == "WallJump", ]
mean_nb <- mean(Gr10_WallJump[Gr10_WallJump$Genotype == "WT", "Amount"])
Gr10_WallJump$Norm_amount <- c((Gr10_WallJump$Amount[[1]]/mean_nb),
                               (Gr10_WallJump$Amount[[2]]/mean_nb),
                               (Gr10_WallJump$Amount[[3]]/mean_nb),
                               (Gr10_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_WallJump[Gr10_WallJump$Genotype == "WT", "Total_time"])
Gr10_WallJump$Norm_time <- c((Gr10_WallJump$Total_time[[1]]/mean_time),
                             (Gr10_WallJump$Total_time[[2]]/mean_time),
                             (Gr10_WallJump$Total_time[[3]]/mean_time),
                             (Gr10_WallJump$Total_time[[4]]/mean_time))

Gr10_SAP <- Gr10[Gr10$Event == "SAP", ]
mean_nb <- mean(Gr10_SAP[Gr10_SAP$Genotype == "WT", "Amount"])
Gr10_SAP$Norm_amount <- c((Gr10_SAP$Amount[[1]]/mean_nb),
                          (Gr10_SAP$Amount[[2]]/mean_nb),
                          (Gr10_SAP$Amount[[3]]/mean_nb),
                          (Gr10_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_SAP[Gr10_SAP$Genotype == "WT", "Total_time"])
Gr10_SAP$Norm_time <- c((Gr10_SAP$Total_time[[1]]/mean_time),
                        (Gr10_SAP$Total_time[[2]]/mean_time),
                        (Gr10_SAP$Total_time[[3]]/mean_time),
                        (Gr10_SAP$Total_time[[4]]/mean_time))

Gr10_Move_contact <- Gr10[Gr10$Event == "Move_contact", ]
mean_nb <- mean(Gr10_Move_contact[Gr10_Move_contact$Genotype == "WT", "Amount"])
Gr10_Move_contact$Norm_amount <- c((Gr10_Move_contact$Amount[[1]]/mean_nb),
                                   (Gr10_Move_contact$Amount[[2]]/mean_nb),
                                   (Gr10_Move_contact$Amount[[3]]/mean_nb),
                                   (Gr10_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Move_contact[Gr10_Move_contact$Genotype == "WT", "Total_time"])
Gr10_Move_contact$Norm_time <- c((Gr10_Move_contact$Total_time[[1]]/mean_time),
                                 (Gr10_Move_contact$Total_time[[2]]/mean_time),
                                 (Gr10_Move_contact$Total_time[[3]]/mean_time),
                                 (Gr10_Move_contact$Total_time[[4]]/mean_time))

Gr10_Stop_contact <- Gr10[Gr10$Event == "Stop_contact", ]
mean_nb <- mean(Gr10_Stop_contact[Gr10_Stop_contact$Genotype == "WT", "Amount"])
Gr10_Stop_contact$Norm_amount <- c((Gr10_Stop_contact$Amount[[1]]/mean_nb),
                                   (Gr10_Stop_contact$Amount[[2]]/mean_nb),
                                   (Gr10_Stop_contact$Amount[[3]]/mean_nb),
                                   (Gr10_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Stop_contact[Gr10_Stop_contact$Genotype == "WT", "Total_time"])
Gr10_Stop_contact$Norm_time <- c((Gr10_Stop_contact$Total_time[[1]]/mean_time),
                                 (Gr10_Stop_contact$Total_time[[2]]/mean_time),
                                 (Gr10_Stop_contact$Total_time[[3]]/mean_time),
                                 (Gr10_Stop_contact$Total_time[[4]]/mean_time))

Gr10_Rear_contact <- Gr10[Gr10$Event == "Rear_contact", ]
mean_nb <- mean(Gr10_Rear_contact[Gr10_Rear_contact$Genotype == "WT", "Amount"])
Gr10_Rear_contact$Norm_amount <- c((Gr10_Rear_contact$Amount[[1]]/mean_nb),
                                   (Gr10_Rear_contact$Amount[[2]]/mean_nb),
                                   (Gr10_Rear_contact$Amount[[3]]/mean_nb),
                                   (Gr10_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Rear_contact[Gr10_Rear_contact$Genotype == "WT", "Total_time"])
Gr10_Rear_contact$Norm_time <- c((Gr10_Rear_contact$Total_time[[1]]/mean_time),
                                 (Gr10_Rear_contact$Total_time[[2]]/mean_time),
                                 (Gr10_Rear_contact$Total_time[[3]]/mean_time),
                                 (Gr10_Rear_contact$Total_time[[4]]/mean_time))

Gr10_SbS_contact <- Gr10[Gr10$Event == "SbS_contact", ]
mean_nb <- mean(Gr10_SbS_contact[Gr10_SbS_contact$Genotype == "WT", "Amount"])
Gr10_SbS_contact$Norm_amount <- c((Gr10_SbS_contact$Amount[[1]]/mean_nb),
                                  (Gr10_SbS_contact$Amount[[2]]/mean_nb),
                                  (Gr10_SbS_contact$Amount[[3]]/mean_nb),
                                  (Gr10_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_SbS_contact[Gr10_SbS_contact$Genotype == "WT", "Total_time"])
Gr10_SbS_contact$Norm_time <- c((Gr10_SbS_contact$Total_time[[1]]/mean_time),
                                (Gr10_SbS_contact$Total_time[[2]]/mean_time),
                                (Gr10_SbS_contact$Total_time[[3]]/mean_time),
                                (Gr10_SbS_contact$Total_time[[4]]/mean_time))

Gr10_SbSO_contact <- Gr10[Gr10$Event == "SbSO_contact", ]
mean_nb <- mean(Gr10_SbSO_contact[Gr10_SbSO_contact$Genotype == "WT", "Amount"])
Gr10_SbSO_contact$Norm_amount <- c((Gr10_SbSO_contact$Amount[[1]]/mean_nb),
                                   (Gr10_SbSO_contact$Amount[[2]]/mean_nb),
                                   (Gr10_SbSO_contact$Amount[[3]]/mean_nb),
                                   (Gr10_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_SbSO_contact[Gr10_SbSO_contact$Genotype == "WT", "Total_time"])
Gr10_SbSO_contact$Norm_time <- c((Gr10_SbSO_contact$Total_time[[1]]/mean_time),
                                 (Gr10_SbSO_contact$Total_time[[2]]/mean_time),
                                 (Gr10_SbSO_contact$Total_time[[3]]/mean_time),
                                 (Gr10_SbSO_contact$Total_time[[4]]/mean_time))

Gr10_OO_contact <- Gr10[Gr10$Event == "OO_contact", ]
mean_nb <- mean(Gr10_OO_contact[Gr10_OO_contact$Genotype == "WT", "Amount"])
Gr10_OO_contact$Norm_amount <- c((Gr10_OO_contact$Amount[[1]]/mean_nb),
                                 (Gr10_OO_contact$Amount[[2]]/mean_nb),
                                 (Gr10_OO_contact$Amount[[3]]/mean_nb),
                                 (Gr10_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_OO_contact[Gr10_OO_contact$Genotype == "WT", "Total_time"])
Gr10_OO_contact$Norm_time <- c((Gr10_OO_contact$Total_time[[1]]/mean_time),
                               (Gr10_OO_contact$Total_time[[2]]/mean_time),
                               (Gr10_OO_contact$Total_time[[3]]/mean_time),
                               (Gr10_OO_contact$Total_time[[4]]/mean_time))

Gr10_OG_contact <- Gr10[Gr10$Event == "OG_contact", ]
mean_nb <- mean(Gr10_OG_contact[Gr10_OG_contact$Genotype == "WT", "Amount"])
Gr10_OG_contact$Norm_amount <- c((Gr10_OG_contact$Amount[[1]]/mean_nb),
                                 (Gr10_OG_contact$Amount[[2]]/mean_nb),
                                 (Gr10_OG_contact$Amount[[3]]/mean_nb),
                                 (Gr10_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_OG_contact[Gr10_OG_contact$Genotype == "WT", "Total_time"])
Gr10_OG_contact$Norm_time <- c((Gr10_OG_contact$Total_time[[1]]/mean_time),
                               (Gr10_OG_contact$Total_time[[2]]/mean_time),
                               (Gr10_OG_contact$Total_time[[3]]/mean_time),
                               (Gr10_OG_contact$Total_time[[4]]/mean_time))

Gr10_Social_approach <- Gr10[Gr10$Event == "Social_approach", ]
mean_nb <- mean(Gr10_Social_approach[Gr10_Social_approach$Genotype == "WT", "Amount"])
Gr10_Social_approach$Norm_amount <- c((Gr10_Social_approach$Amount[[1]]/mean_nb),
                                      (Gr10_Social_approach$Amount[[2]]/mean_nb),
                                      (Gr10_Social_approach$Amount[[3]]/mean_nb),
                                      (Gr10_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Social_approach[Gr10_Social_approach$Genotype == "WT", "Total_time"])
Gr10_Social_approach$Norm_time <- c((Gr10_Social_approach$Total_time[[1]]/mean_time),
                                    (Gr10_Social_approach$Total_time[[2]]/mean_time),
                                    (Gr10_Social_approach$Total_time[[3]]/mean_time),
                                    (Gr10_Social_approach$Total_time[[4]]/mean_time))

Gr10_Approach_rear <- Gr10[Gr10$Event == "Approach_rear", ]
mean_nb <- mean(Gr10_Approach_rear[Gr10_Approach_rear$Genotype == "WT", "Amount"])
Gr10_Approach_rear$Norm_amount <- c((Gr10_Approach_rear$Amount[[1]]/mean_nb),
                                    (Gr10_Approach_rear$Amount[[2]]/mean_nb),
                                    (Gr10_Approach_rear$Amount[[3]]/mean_nb),
                                    (Gr10_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Approach_rear[Gr10_Approach_rear$Genotype == "WT", "Total_time"])
Gr10_Approach_rear$Norm_time <- c((Gr10_Approach_rear$Total_time[[1]]/mean_time),
                                  (Gr10_Approach_rear$Total_time[[2]]/mean_time),
                                  (Gr10_Approach_rear$Total_time[[3]]/mean_time),
                                  (Gr10_Approach_rear$Total_time[[4]]/mean_time))

Gr10_Contact <- Gr10[Gr10$Event == "Contact", ]
mean_nb <- mean(Gr10_Contact[Gr10_Contact$Genotype == "WT", "Amount"])
Gr10_Contact$Norm_amount <- c((Gr10_Contact$Amount[[1]]/mean_nb),
                              (Gr10_Contact$Amount[[2]]/mean_nb),
                              (Gr10_Contact$Amount[[3]]/mean_nb),
                              (Gr10_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Contact[Gr10_Contact$Genotype == "WT", "Total_time"])
Gr10_Contact$Norm_time <- c((Gr10_Contact$Total_time[[1]]/mean_time),
                            (Gr10_Contact$Total_time[[2]]/mean_time),
                            (Gr10_Contact$Total_time[[3]]/mean_time),
                            (Gr10_Contact$Total_time[[4]]/mean_time))

Gr10_Get_away <- Gr10[Gr10$Event == "Get_away", ]
mean_nb <- mean(Gr10_Get_away[Gr10_Get_away$Genotype == "WT", "Amount"])
Gr10_Get_away$Norm_amount <- c((Gr10_Get_away$Amount[[1]]/mean_nb),
                               (Gr10_Get_away$Amount[[2]]/mean_nb),
                               (Gr10_Get_away$Amount[[3]]/mean_nb),
                               (Gr10_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Get_away[Gr10_Get_away$Genotype == "WT", "Total_time"])
Gr10_Get_away$Norm_time <- c((Gr10_Get_away$Total_time[[1]]/mean_time),
                             (Gr10_Get_away$Total_time[[2]]/mean_time),
                             (Gr10_Get_away$Total_time[[3]]/mean_time),
                             (Gr10_Get_away$Total_time[[4]]/mean_time))

Gr10_Break_contact <- Gr10[Gr10$Event == "Break_contact", ]
mean_nb <- mean(Gr10_Break_contact[Gr10_Break_contact$Genotype == "WT", "Amount"])
Gr10_Break_contact$Norm_amount <- c((Gr10_Break_contact$Amount[[1]]/mean_nb),
                                    (Gr10_Break_contact$Amount[[2]]/mean_nb),
                                    (Gr10_Break_contact$Amount[[3]]/mean_nb),
                                    (Gr10_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Break_contact[Gr10_Break_contact$Genotype == "WT", "Total_time"])
Gr10_Break_contact$Norm_time <- c((Gr10_Break_contact$Total_time[[1]]/mean_time),
                                  (Gr10_Break_contact$Total_time[[2]]/mean_time),
                                  (Gr10_Break_contact$Total_time[[3]]/mean_time),
                                  (Gr10_Break_contact$Total_time[[4]]/mean_time))

Gr10_Train2 <- Gr10[Gr10$Event == "Train2", ]
mean_nb <- mean(Gr10_Train2[Gr10_Train2$Genotype == "WT", "Amount"])
Gr10_Train2$Norm_amount <- c((Gr10_Train2$Amount[[1]]/mean_nb),
                             (Gr10_Train2$Amount[[2]]/mean_nb),
                             (Gr10_Train2$Amount[[3]]/mean_nb),
                             (Gr10_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Train2[Gr10_Train2$Genotype == "WT", "Total_time"])
Gr10_Train2$Norm_time <- c((Gr10_Train2$Total_time[[1]]/mean_time),
                           (Gr10_Train2$Total_time[[2]]/mean_time),
                           (Gr10_Train2$Total_time[[3]]/mean_time),
                           (Gr10_Train2$Total_time[[4]]/mean_time))

Gr10_Group3make <- Gr10[Gr10$Event == "Group3make", ]
mean_nb <- mean(Gr10_Group3make[Gr10_Group3make$Genotype == "WT", "Amount"])
Gr10_Group3make$Norm_amount <- c((Gr10_Group3make$Amount[[1]]/mean_nb),
                                 (Gr10_Group3make$Amount[[2]]/mean_nb),
                                 (Gr10_Group3make$Amount[[3]]/mean_nb),
                                 (Gr10_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Group3make[Gr10_Group3make$Genotype == "WT", "Total_time"])
Gr10_Group3make$Norm_time <- c((Gr10_Group3make$Total_time[[1]]/mean_time),
                               (Gr10_Group3make$Total_time[[2]]/mean_time),
                               (Gr10_Group3make$Total_time[[3]]/mean_time),
                               (Gr10_Group3make$Total_time[[4]]/mean_time))

Gr10_Group3break <- Gr10[Gr10$Event == "Group3break", ]
mean_nb <- mean(Gr10_Group3break[Gr10_Group3break$Genotype == "WT", "Amount"])
Gr10_Group3break$Norm_amount <- c((Gr10_Group3break$Amount[[1]]/mean_nb),
                                  (Gr10_Group3break$Amount[[2]]/mean_nb),
                                  (Gr10_Group3break$Amount[[3]]/mean_nb),
                                  (Gr10_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Group3break[Gr10_Group3break$Genotype == "WT", "Total_time"])
Gr10_Group3break$Norm_time <- c((Gr10_Group3break$Total_time[[1]]/mean_time),
                                (Gr10_Group3break$Total_time[[2]]/mean_time),
                                (Gr10_Group3break$Total_time[[3]]/mean_time),
                                (Gr10_Group3break$Total_time[[4]]/mean_time))

Gr10_Group4make <- Gr10[Gr10$Event == "Group4make", ]
mean_nb <- mean(Gr10_Group4make[Gr10_Group4make$Genotype == "WT", "Amount"])
Gr10_Group4make$Norm_amount <- c((Gr10_Group4make$Amount[[1]]/mean_nb),
                                 (Gr10_Group4make$Amount[[2]]/mean_nb),
                                 (Gr10_Group4make$Amount[[3]]/mean_nb),
                                 (Gr10_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Group4make[Gr10_Group4make$Genotype == "WT", "Total_time"])
Gr10_Group4make$Norm_time <- c((Gr10_Group4make$Total_time[[1]]/mean_time),
                               (Gr10_Group4make$Total_time[[2]]/mean_time),
                               (Gr10_Group4make$Total_time[[3]]/mean_time),
                               (Gr10_Group4make$Total_time[[4]]/mean_time))

Gr10_Group4break <- Gr10[Gr10$Event == "Group4break", ]
mean_nb <- mean(Gr10_Group4break[Gr10_Group4break$Genotype == "WT", "Amount"])
Gr10_Group4break$Norm_amount <- c((Gr10_Group4break$Amount[[1]]/mean_nb),
                                  (Gr10_Group4break$Amount[[2]]/mean_nb),
                                  (Gr10_Group4break$Amount[[3]]/mean_nb),
                                  (Gr10_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr10_Group4break[Gr10_Group4break$Genotype == "WT", "Total_time"])
Gr10_Group4break$Norm_time <- c((Gr10_Group4break$Total_time[[1]]/mean_time),
                                (Gr10_Group4break$Total_time[[2]]/mean_time),
                                (Gr10_Group4break$Total_time[[3]]/mean_time),
                                (Gr10_Group4break$Total_time[[4]]/mean_time))

Gr10_norm <- rbind(Gr10_Move_iso,Gr10_Stop_iso,Gr10_Rear_iso,Gr10_Huddling,
                   Gr10_WallJump,Gr10_SAP, Gr10_Move_contact,Gr10_Stop_contact,
                   Gr10_Rear_contact,Gr10_SbS_contact,Gr10_SbSO_contact,
                   Gr10_OO_contact,Gr10_OG_contact,Gr10_Social_approach,
                   Gr10_Approach_rear,Gr10_Contact,Gr10_Get_away,
                   Gr10_Break_contact,Gr10_Train2,Gr10_Group3make,
                   Gr10_Group3break,Gr10_Group4make,Gr10_Group4break)

rm(Gr10_Move_iso,Gr10_Stop_iso,Gr10_Rear_iso,Gr10_Huddling,
   Gr10_WallJump,Gr10_SAP, Gr10_Move_contact,Gr10_Stop_contact,
   Gr10_Rear_contact,Gr10_SbS_contact,Gr10_SbSO_contact,
   Gr10_OO_contact,Gr10_OG_contact,Gr10_Social_approach,
   Gr10_Approach_rear,Gr10_Contact,Gr10_Get_away,
   Gr10_Break_contact,Gr10_Train2,Gr10_Group3make,
   Gr10_Group3break,Gr10_Group4make,Gr10_Group4break)

Gr11 <- Events[Events$Group == "O2", ]
Gr11_Move_iso <- Gr11[Gr11$Event == "Move_isolated", ]
mean_nb <- mean(Gr11_Move_iso[Gr11_Move_iso$Genotype == "WT", "Amount"])
Gr11_Move_iso$Norm_amount <- c((Gr11_Move_iso$Amount[[1]]/mean_nb),
                               (Gr11_Move_iso$Amount[[2]]/mean_nb),
                               (Gr11_Move_iso$Amount[[3]]/mean_nb),
                               (Gr11_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Move_iso[Gr11_Move_iso$Genotype == "WT", "Total_time"])
Gr11_Move_iso$Norm_time <- c((Gr11_Move_iso$Total_time[[1]]/mean_time),
                             (Gr11_Move_iso$Total_time[[2]]/mean_time),
                             (Gr11_Move_iso$Total_time[[3]]/mean_time),
                             (Gr11_Move_iso$Total_time[[4]]/mean_time))

Gr11_Stop_iso <- Gr11[Gr11$Event == "Stop_isolated", ]
mean_nb <- mean(Gr11_Stop_iso[Gr11_Stop_iso$Genotype == "WT", "Amount"])
Gr11_Stop_iso$Norm_amount <- c((Gr11_Stop_iso$Amount[[1]]/mean_nb),
                               (Gr11_Stop_iso$Amount[[2]]/mean_nb),
                               (Gr11_Stop_iso$Amount[[3]]/mean_nb),
                               (Gr11_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Stop_iso[Gr11_Stop_iso$Genotype == "WT", "Total_time"])
Gr11_Stop_iso$Norm_time <- c((Gr11_Stop_iso$Total_time[[1]]/mean_time),
                             (Gr11_Stop_iso$Total_time[[2]]/mean_time),
                             (Gr11_Stop_iso$Total_time[[3]]/mean_time),
                             (Gr11_Stop_iso$Total_time[[4]]/mean_time))

Gr11_Rear_iso <- Gr11[Gr11$Event == "Rear_isolated", ]
mean_nb <- mean(Gr11_Rear_iso[Gr11_Rear_iso$Genotype == "WT", "Amount"])
Gr11_Rear_iso$Norm_amount <- c((Gr11_Rear_iso$Amount[[1]]/mean_nb),
                               (Gr11_Rear_iso$Amount[[2]]/mean_nb),
                               (Gr11_Rear_iso$Amount[[3]]/mean_nb),
                               (Gr11_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Rear_iso[Gr11_Rear_iso$Genotype == "WT", "Total_time"])
Gr11_Rear_iso$Norm_time <- c((Gr11_Rear_iso$Total_time[[1]]/mean_time),
                             (Gr11_Rear_iso$Total_time[[2]]/mean_time),
                             (Gr11_Rear_iso$Total_time[[3]]/mean_time),
                             (Gr11_Rear_iso$Total_time[[4]]/mean_time))

Gr11_Huddling <- Gr11[Gr11$Event == "Huddling", ]
mean_nb <- mean(Gr11_Huddling[Gr11_Huddling$Genotype == "WT", "Amount"])
Gr11_Huddling$Norm_amount <- c((Gr11_Huddling$Amount[[1]]/mean_nb),
                               (Gr11_Huddling$Amount[[2]]/mean_nb),
                               (Gr11_Huddling$Amount[[3]]/mean_nb),
                               (Gr11_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Huddling[Gr11_Huddling$Genotype == "WT", "Total_time"])
Gr11_Huddling$Norm_time <- c((Gr11_Huddling$Total_time[[1]]/mean_time),
                             (Gr11_Huddling$Total_time[[2]]/mean_time),
                             (Gr11_Huddling$Total_time[[3]]/mean_time),
                             (Gr11_Huddling$Total_time[[4]]/mean_time))

Gr11_WallJump <- Gr11[Gr11$Event == "WallJump", ]
mean_nb <- mean(Gr11_WallJump[Gr11_WallJump$Genotype == "WT", "Amount"])
Gr11_WallJump$Norm_amount <- c((Gr11_WallJump$Amount[[1]]/mean_nb),
                               (Gr11_WallJump$Amount[[2]]/mean_nb),
                               (Gr11_WallJump$Amount[[3]]/mean_nb),
                               (Gr11_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_WallJump[Gr11_WallJump$Genotype == "WT", "Total_time"])
Gr11_WallJump$Norm_time <- c((Gr11_WallJump$Total_time[[1]]/mean_time),
                             (Gr11_WallJump$Total_time[[2]]/mean_time),
                             (Gr11_WallJump$Total_time[[3]]/mean_time),
                             (Gr11_WallJump$Total_time[[4]]/mean_time))

Gr11_SAP <- Gr11[Gr11$Event == "SAP", ]
mean_nb <- mean(Gr11_SAP[Gr11_SAP$Genotype == "WT", "Amount"])
Gr11_SAP$Norm_amount <- c((Gr11_SAP$Amount[[1]]/mean_nb),
                          (Gr11_SAP$Amount[[2]]/mean_nb),
                          (Gr11_SAP$Amount[[3]]/mean_nb),
                          (Gr11_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_SAP[Gr11_SAP$Genotype == "WT", "Total_time"])
Gr11_SAP$Norm_time <- c((Gr11_SAP$Total_time[[1]]/mean_time),
                        (Gr11_SAP$Total_time[[2]]/mean_time),
                        (Gr11_SAP$Total_time[[3]]/mean_time),
                        (Gr11_SAP$Total_time[[4]]/mean_time))

Gr11_Move_contact <- Gr11[Gr11$Event == "Move_contact", ]
mean_nb <- mean(Gr11_Move_contact[Gr11_Move_contact$Genotype == "WT", "Amount"])
Gr11_Move_contact$Norm_amount <- c((Gr11_Move_contact$Amount[[1]]/mean_nb),
                                   (Gr11_Move_contact$Amount[[2]]/mean_nb),
                                   (Gr11_Move_contact$Amount[[3]]/mean_nb),
                                   (Gr11_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Move_contact[Gr11_Move_contact$Genotype == "WT", "Total_time"])
Gr11_Move_contact$Norm_time <- c((Gr11_Move_contact$Total_time[[1]]/mean_time),
                                 (Gr11_Move_contact$Total_time[[2]]/mean_time),
                                 (Gr11_Move_contact$Total_time[[3]]/mean_time),
                                 (Gr11_Move_contact$Total_time[[4]]/mean_time))

Gr11_Stop_contact <- Gr11[Gr11$Event == "Stop_contact", ]
mean_nb <- mean(Gr11_Stop_contact[Gr11_Stop_contact$Genotype == "WT", "Amount"])
Gr11_Stop_contact$Norm_amount <- c((Gr11_Stop_contact$Amount[[1]]/mean_nb),
                                   (Gr11_Stop_contact$Amount[[2]]/mean_nb),
                                   (Gr11_Stop_contact$Amount[[3]]/mean_nb),
                                   (Gr11_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Stop_contact[Gr11_Stop_contact$Genotype == "WT", "Total_time"])
Gr11_Stop_contact$Norm_time <- c((Gr11_Stop_contact$Total_time[[1]]/mean_time),
                                 (Gr11_Stop_contact$Total_time[[2]]/mean_time),
                                 (Gr11_Stop_contact$Total_time[[3]]/mean_time),
                                 (Gr11_Stop_contact$Total_time[[4]]/mean_time))

Gr11_Rear_contact <- Gr11[Gr11$Event == "Rear_contact", ]
mean_nb <- mean(Gr11_Rear_contact[Gr11_Rear_contact$Genotype == "WT", "Amount"])
Gr11_Rear_contact$Norm_amount <- c((Gr11_Rear_contact$Amount[[1]]/mean_nb),
                                   (Gr11_Rear_contact$Amount[[2]]/mean_nb),
                                   (Gr11_Rear_contact$Amount[[3]]/mean_nb),
                                   (Gr11_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Rear_contact[Gr11_Rear_contact$Genotype == "WT", "Total_time"])
Gr11_Rear_contact$Norm_time <- c((Gr11_Rear_contact$Total_time[[1]]/mean_time),
                                 (Gr11_Rear_contact$Total_time[[2]]/mean_time),
                                 (Gr11_Rear_contact$Total_time[[3]]/mean_time),
                                 (Gr11_Rear_contact$Total_time[[4]]/mean_time))

Gr11_SbS_contact <- Gr11[Gr11$Event == "SbS_contact", ]
mean_nb <- mean(Gr11_SbS_contact[Gr11_SbS_contact$Genotype == "WT", "Amount"])
Gr11_SbS_contact$Norm_amount <- c((Gr11_SbS_contact$Amount[[1]]/mean_nb),
                                  (Gr11_SbS_contact$Amount[[2]]/mean_nb),
                                  (Gr11_SbS_contact$Amount[[3]]/mean_nb),
                                  (Gr11_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_SbS_contact[Gr11_SbS_contact$Genotype == "WT", "Total_time"])
Gr11_SbS_contact$Norm_time <- c((Gr11_SbS_contact$Total_time[[1]]/mean_time),
                                (Gr11_SbS_contact$Total_time[[2]]/mean_time),
                                (Gr11_SbS_contact$Total_time[[3]]/mean_time),
                                (Gr11_SbS_contact$Total_time[[4]]/mean_time))

Gr11_SbSO_contact <- Gr11[Gr11$Event == "SbSO_contact", ]
mean_nb <- mean(Gr11_SbSO_contact[Gr11_SbSO_contact$Genotype == "WT", "Amount"])
Gr11_SbSO_contact$Norm_amount <- c((Gr11_SbSO_contact$Amount[[1]]/mean_nb),
                                   (Gr11_SbSO_contact$Amount[[2]]/mean_nb),
                                   (Gr11_SbSO_contact$Amount[[3]]/mean_nb),
                                   (Gr11_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_SbSO_contact[Gr11_SbSO_contact$Genotype == "WT", "Total_time"])
Gr11_SbSO_contact$Norm_time <- c((Gr11_SbSO_contact$Total_time[[1]]/mean_time),
                                 (Gr11_SbSO_contact$Total_time[[2]]/mean_time),
                                 (Gr11_SbSO_contact$Total_time[[3]]/mean_time),
                                 (Gr11_SbSO_contact$Total_time[[4]]/mean_time))

Gr11_OO_contact <- Gr11[Gr11$Event == "OO_contact", ]
mean_nb <- mean(Gr11_OO_contact[Gr11_OO_contact$Genotype == "WT", "Amount"])
Gr11_OO_contact$Norm_amount <- c((Gr11_OO_contact$Amount[[1]]/mean_nb),
                                 (Gr11_OO_contact$Amount[[2]]/mean_nb),
                                 (Gr11_OO_contact$Amount[[3]]/mean_nb),
                                 (Gr11_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_OO_contact[Gr11_OO_contact$Genotype == "WT", "Total_time"])
Gr11_OO_contact$Norm_time <- c((Gr11_OO_contact$Total_time[[1]]/mean_time),
                               (Gr11_OO_contact$Total_time[[2]]/mean_time),
                               (Gr11_OO_contact$Total_time[[3]]/mean_time),
                               (Gr11_OO_contact$Total_time[[4]]/mean_time))

Gr11_OG_contact <- Gr11[Gr11$Event == "OG_contact", ]
mean_nb <- mean(Gr11_OG_contact[Gr11_OG_contact$Genotype == "WT", "Amount"])
Gr11_OG_contact$Norm_amount <- c((Gr11_OG_contact$Amount[[1]]/mean_nb),
                                 (Gr11_OG_contact$Amount[[2]]/mean_nb),
                                 (Gr11_OG_contact$Amount[[3]]/mean_nb),
                                 (Gr11_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_OG_contact[Gr11_OG_contact$Genotype == "WT", "Total_time"])
Gr11_OG_contact$Norm_time <- c((Gr11_OG_contact$Total_time[[1]]/mean_time),
                               (Gr11_OG_contact$Total_time[[2]]/mean_time),
                               (Gr11_OG_contact$Total_time[[3]]/mean_time),
                               (Gr11_OG_contact$Total_time[[4]]/mean_time))

Gr11_Social_approach <- Gr11[Gr11$Event == "Social_approach", ]
mean_nb <- mean(Gr11_Social_approach[Gr11_Social_approach$Genotype == "WT", "Amount"])
Gr11_Social_approach$Norm_amount <- c((Gr11_Social_approach$Amount[[1]]/mean_nb),
                                      (Gr11_Social_approach$Amount[[2]]/mean_nb),
                                      (Gr11_Social_approach$Amount[[3]]/mean_nb),
                                      (Gr11_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Social_approach[Gr11_Social_approach$Genotype == "WT", "Total_time"])
Gr11_Social_approach$Norm_time <- c((Gr11_Social_approach$Total_time[[1]]/mean_time),
                                    (Gr11_Social_approach$Total_time[[2]]/mean_time),
                                    (Gr11_Social_approach$Total_time[[3]]/mean_time),
                                    (Gr11_Social_approach$Total_time[[4]]/mean_time))

Gr11_Approach_rear <- Gr11[Gr11$Event == "Approach_rear", ]
mean_nb <- mean(Gr11_Approach_rear[Gr11_Approach_rear$Genotype == "WT", "Amount"])
Gr11_Approach_rear$Norm_amount <- c((Gr11_Approach_rear$Amount[[1]]/mean_nb),
                                    (Gr11_Approach_rear$Amount[[2]]/mean_nb),
                                    (Gr11_Approach_rear$Amount[[3]]/mean_nb),
                                    (Gr11_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Approach_rear[Gr11_Approach_rear$Genotype == "WT", "Total_time"])
Gr11_Approach_rear$Norm_time <- c((Gr11_Approach_rear$Total_time[[1]]/mean_time),
                                  (Gr11_Approach_rear$Total_time[[2]]/mean_time),
                                  (Gr11_Approach_rear$Total_time[[3]]/mean_time),
                                  (Gr11_Approach_rear$Total_time[[4]]/mean_time))

Gr11_Contact <- Gr11[Gr11$Event == "Contact", ]
mean_nb <- mean(Gr11_Contact[Gr11_Contact$Genotype == "WT", "Amount"])
Gr11_Contact$Norm_amount <- c((Gr11_Contact$Amount[[1]]/mean_nb),
                              (Gr11_Contact$Amount[[2]]/mean_nb),
                              (Gr11_Contact$Amount[[3]]/mean_nb),
                              (Gr11_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Contact[Gr11_Contact$Genotype == "WT", "Total_time"])
Gr11_Contact$Norm_time <- c((Gr11_Contact$Total_time[[1]]/mean_time),
                            (Gr11_Contact$Total_time[[2]]/mean_time),
                            (Gr11_Contact$Total_time[[3]]/mean_time),
                            (Gr11_Contact$Total_time[[4]]/mean_time))

Gr11_Get_away <- Gr11[Gr11$Event == "Get_away", ]
mean_nb <- mean(Gr11_Get_away[Gr11_Get_away$Genotype == "WT", "Amount"])
Gr11_Get_away$Norm_amount <- c((Gr11_Get_away$Amount[[1]]/mean_nb),
                               (Gr11_Get_away$Amount[[2]]/mean_nb),
                               (Gr11_Get_away$Amount[[3]]/mean_nb),
                               (Gr11_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Get_away[Gr11_Get_away$Genotype == "WT", "Total_time"])
Gr11_Get_away$Norm_time <- c((Gr11_Get_away$Total_time[[1]]/mean_time),
                             (Gr11_Get_away$Total_time[[2]]/mean_time),
                             (Gr11_Get_away$Total_time[[3]]/mean_time),
                             (Gr11_Get_away$Total_time[[4]]/mean_time))

Gr11_Break_contact <- Gr11[Gr11$Event == "Break_contact", ]
mean_nb <- mean(Gr11_Break_contact[Gr11_Break_contact$Genotype == "WT", "Amount"])
Gr11_Break_contact$Norm_amount <- c((Gr11_Break_contact$Amount[[1]]/mean_nb),
                                    (Gr11_Break_contact$Amount[[2]]/mean_nb),
                                    (Gr11_Break_contact$Amount[[3]]/mean_nb),
                                    (Gr11_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Break_contact[Gr11_Break_contact$Genotype == "WT", "Total_time"])
Gr11_Break_contact$Norm_time <- c((Gr11_Break_contact$Total_time[[1]]/mean_time),
                                  (Gr11_Break_contact$Total_time[[2]]/mean_time),
                                  (Gr11_Break_contact$Total_time[[3]]/mean_time),
                                  (Gr11_Break_contact$Total_time[[4]]/mean_time))

Gr11_Train2 <- Gr11[Gr11$Event == "Train2", ]
mean_nb <- mean(Gr11_Train2[Gr11_Train2$Genotype == "WT", "Amount"])
Gr11_Train2$Norm_amount <- c((Gr11_Train2$Amount[[1]]/mean_nb),
                             (Gr11_Train2$Amount[[2]]/mean_nb),
                             (Gr11_Train2$Amount[[3]]/mean_nb),
                             (Gr11_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Train2[Gr11_Train2$Genotype == "WT", "Total_time"])
Gr11_Train2$Norm_time <- c((Gr11_Train2$Total_time[[1]]/mean_time),
                           (Gr11_Train2$Total_time[[2]]/mean_time),
                           (Gr11_Train2$Total_time[[3]]/mean_time),
                           (Gr11_Train2$Total_time[[4]]/mean_time))

Gr11_Group3make <- Gr11[Gr11$Event == "Group3make", ]
mean_nb <- mean(Gr11_Group3make[Gr11_Group3make$Genotype == "WT", "Amount"])
Gr11_Group3make$Norm_amount <- c((Gr11_Group3make$Amount[[1]]/mean_nb),
                                 (Gr11_Group3make$Amount[[2]]/mean_nb),
                                 (Gr11_Group3make$Amount[[3]]/mean_nb),
                                 (Gr11_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Group3make[Gr11_Group3make$Genotype == "WT", "Total_time"])
Gr11_Group3make$Norm_time <- c((Gr11_Group3make$Total_time[[1]]/mean_time),
                               (Gr11_Group3make$Total_time[[2]]/mean_time),
                               (Gr11_Group3make$Total_time[[3]]/mean_time),
                               (Gr11_Group3make$Total_time[[4]]/mean_time))

Gr11_Group3break <- Gr11[Gr11$Event == "Group3break", ]
mean_nb <- mean(Gr11_Group3break[Gr11_Group3break$Genotype == "WT", "Amount"])
Gr11_Group3break$Norm_amount <- c((Gr11_Group3break$Amount[[1]]/mean_nb),
                                  (Gr11_Group3break$Amount[[2]]/mean_nb),
                                  (Gr11_Group3break$Amount[[3]]/mean_nb),
                                  (Gr11_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Group3break[Gr11_Group3break$Genotype == "WT", "Total_time"])
Gr11_Group3break$Norm_time <- c((Gr11_Group3break$Total_time[[1]]/mean_time),
                                (Gr11_Group3break$Total_time[[2]]/mean_time),
                                (Gr11_Group3break$Total_time[[3]]/mean_time),
                                (Gr11_Group3break$Total_time[[4]]/mean_time))

Gr11_Group4make <- Gr11[Gr11$Event == "Group4make", ]
mean_nb <- mean(Gr11_Group4make[Gr11_Group4make$Genotype == "WT", "Amount"])
Gr11_Group4make$Norm_amount <- c((Gr11_Group4make$Amount[[1]]/mean_nb),
                                 (Gr11_Group4make$Amount[[2]]/mean_nb),
                                 (Gr11_Group4make$Amount[[3]]/mean_nb),
                                 (Gr11_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Group4make[Gr11_Group4make$Genotype == "WT", "Total_time"])
Gr11_Group4make$Norm_time <- c((Gr11_Group4make$Total_time[[1]]/mean_time),
                               (Gr11_Group4make$Total_time[[2]]/mean_time),
                               (Gr11_Group4make$Total_time[[3]]/mean_time),
                               (Gr11_Group4make$Total_time[[4]]/mean_time))

Gr11_Group4break <- Gr11[Gr11$Event == "Group4break", ]
mean_nb <- mean(Gr11_Group4break[Gr11_Group4break$Genotype == "WT", "Amount"])
Gr11_Group4break$Norm_amount <- c((Gr11_Group4break$Amount[[1]]/mean_nb),
                                  (Gr11_Group4break$Amount[[2]]/mean_nb),
                                  (Gr11_Group4break$Amount[[3]]/mean_nb),
                                  (Gr11_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr11_Group4break[Gr11_Group4break$Genotype == "WT", "Total_time"])
Gr11_Group4break$Norm_time <- c((Gr11_Group4break$Total_time[[1]]/mean_time),
                                (Gr11_Group4break$Total_time[[2]]/mean_time),
                                (Gr11_Group4break$Total_time[[3]]/mean_time),
                                (Gr11_Group4break$Total_time[[4]]/mean_time))

Gr11_norm <- rbind(Gr11_Move_iso,Gr11_Stop_iso,Gr11_Rear_iso,Gr11_Huddling,
                   Gr11_WallJump,Gr11_SAP, Gr11_Move_contact,Gr11_Stop_contact,
                   Gr11_Rear_contact,Gr11_SbS_contact,Gr11_SbSO_contact,
                   Gr11_OO_contact,Gr11_OG_contact,Gr11_Social_approach,
                   Gr11_Approach_rear,Gr11_Contact,Gr11_Get_away,
                   Gr11_Break_contact,Gr11_Train2,Gr11_Group3make,
                   Gr11_Group3break,Gr11_Group4make,Gr11_Group4break)

rm(Gr11_Move_iso,Gr11_Stop_iso,Gr11_Rear_iso,Gr11_Huddling,
   Gr11_WallJump,Gr11_SAP, Gr11_Move_contact,Gr11_Stop_contact,
   Gr11_Rear_contact,Gr11_SbS_contact,Gr11_SbSO_contact,
   Gr11_OO_contact,Gr11_OG_contact,Gr11_Social_approach,
   Gr11_Approach_rear,Gr11_Contact,Gr11_Get_away,
   Gr11_Break_contact,Gr11_Train2,Gr11_Group3make,
   Gr11_Group3break,Gr11_Group4make,Gr11_Group4break)

Gr12 <- Events[Events$Group == "O3", ]
Gr12_Move_iso <- Gr12[Gr12$Event == "Move_isolated", ]
mean_nb <- mean(Gr12_Move_iso[Gr12_Move_iso$Genotype == "WT", "Amount"])
Gr12_Move_iso$Norm_amount <- c((Gr12_Move_iso$Amount[[1]]/mean_nb),
                               (Gr12_Move_iso$Amount[[2]]/mean_nb),
                               (Gr12_Move_iso$Amount[[3]]/mean_nb),
                               (Gr12_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Move_iso[Gr12_Move_iso$Genotype == "WT", "Total_time"])
Gr12_Move_iso$Norm_time <- c((Gr12_Move_iso$Total_time[[1]]/mean_time),
                             (Gr12_Move_iso$Total_time[[2]]/mean_time),
                             (Gr12_Move_iso$Total_time[[3]]/mean_time),
                             (Gr12_Move_iso$Total_time[[4]]/mean_time))

Gr12_Stop_iso <- Gr12[Gr12$Event == "Stop_isolated", ]
mean_nb <- mean(Gr12_Stop_iso[Gr12_Stop_iso$Genotype == "WT", "Amount"])
Gr12_Stop_iso$Norm_amount <- c((Gr12_Stop_iso$Amount[[1]]/mean_nb),
                               (Gr12_Stop_iso$Amount[[2]]/mean_nb),
                               (Gr12_Stop_iso$Amount[[3]]/mean_nb),
                               (Gr12_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Stop_iso[Gr12_Stop_iso$Genotype == "WT", "Total_time"])
Gr12_Stop_iso$Norm_time <- c((Gr12_Stop_iso$Total_time[[1]]/mean_time),
                             (Gr12_Stop_iso$Total_time[[2]]/mean_time),
                             (Gr12_Stop_iso$Total_time[[3]]/mean_time),
                             (Gr12_Stop_iso$Total_time[[4]]/mean_time))

Gr12_Rear_iso <- Gr12[Gr12$Event == "Rear_isolated", ]
mean_nb <- mean(Gr12_Rear_iso[Gr12_Rear_iso$Genotype == "WT", "Amount"])
Gr12_Rear_iso$Norm_amount <- c((Gr12_Rear_iso$Amount[[1]]/mean_nb),
                               (Gr12_Rear_iso$Amount[[2]]/mean_nb),
                               (Gr12_Rear_iso$Amount[[3]]/mean_nb),
                               (Gr12_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Rear_iso[Gr12_Rear_iso$Genotype == "WT", "Total_time"])
Gr12_Rear_iso$Norm_time <- c((Gr12_Rear_iso$Total_time[[1]]/mean_time),
                             (Gr12_Rear_iso$Total_time[[2]]/mean_time),
                             (Gr12_Rear_iso$Total_time[[3]]/mean_time),
                             (Gr12_Rear_iso$Total_time[[4]]/mean_time))

Gr12_Huddling <- Gr12[Gr12$Event == "Huddling", ]
mean_nb <- mean(Gr12_Huddling[Gr12_Huddling$Genotype == "WT", "Amount"])
Gr12_Huddling$Norm_amount <- c((Gr12_Huddling$Amount[[1]]/mean_nb),
                               (Gr12_Huddling$Amount[[2]]/mean_nb),
                               (Gr12_Huddling$Amount[[3]]/mean_nb),
                               (Gr12_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Huddling[Gr12_Huddling$Genotype == "WT", "Total_time"])
Gr12_Huddling$Norm_time <- c((Gr12_Huddling$Total_time[[1]]/mean_time),
                             (Gr12_Huddling$Total_time[[2]]/mean_time),
                             (Gr12_Huddling$Total_time[[3]]/mean_time),
                             (Gr12_Huddling$Total_time[[4]]/mean_time))

Gr12_WallJump <- Gr12[Gr12$Event == "WallJump", ]
mean_nb <- mean(Gr12_WallJump[Gr12_WallJump$Genotype == "WT", "Amount"])
Gr12_WallJump$Norm_amount <- c((Gr12_WallJump$Amount[[1]]/mean_nb),
                               (Gr12_WallJump$Amount[[2]]/mean_nb),
                               (Gr12_WallJump$Amount[[3]]/mean_nb),
                               (Gr12_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_WallJump[Gr12_WallJump$Genotype == "WT", "Total_time"])
Gr12_WallJump$Norm_time <- c((Gr12_WallJump$Total_time[[1]]/mean_time),
                             (Gr12_WallJump$Total_time[[2]]/mean_time),
                             (Gr12_WallJump$Total_time[[3]]/mean_time),
                             (Gr12_WallJump$Total_time[[4]]/mean_time))

Gr12_SAP <- Gr12[Gr12$Event == "SAP", ]
mean_nb <- mean(Gr12_SAP[Gr12_SAP$Genotype == "WT", "Amount"])
Gr12_SAP$Norm_amount <- c((Gr12_SAP$Amount[[1]]/mean_nb),
                          (Gr12_SAP$Amount[[2]]/mean_nb),
                          (Gr12_SAP$Amount[[3]]/mean_nb),
                          (Gr12_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_SAP[Gr12_SAP$Genotype == "WT", "Total_time"])
Gr12_SAP$Norm_time <- c((Gr12_SAP$Total_time[[1]]/mean_time),
                        (Gr12_SAP$Total_time[[2]]/mean_time),
                        (Gr12_SAP$Total_time[[3]]/mean_time),
                        (Gr12_SAP$Total_time[[4]]/mean_time))

Gr12_Move_contact <- Gr12[Gr12$Event == "Move_contact", ]
mean_nb <- mean(Gr12_Move_contact[Gr12_Move_contact$Genotype == "WT", "Amount"])
Gr12_Move_contact$Norm_amount <- c((Gr12_Move_contact$Amount[[1]]/mean_nb),
                                   (Gr12_Move_contact$Amount[[2]]/mean_nb),
                                   (Gr12_Move_contact$Amount[[3]]/mean_nb),
                                   (Gr12_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Move_contact[Gr12_Move_contact$Genotype == "WT", "Total_time"])
Gr12_Move_contact$Norm_time <- c((Gr12_Move_contact$Total_time[[1]]/mean_time),
                                 (Gr12_Move_contact$Total_time[[2]]/mean_time),
                                 (Gr12_Move_contact$Total_time[[3]]/mean_time),
                                 (Gr12_Move_contact$Total_time[[4]]/mean_time))

Gr12_Stop_contact <- Gr12[Gr12$Event == "Stop_contact", ]
mean_nb <- mean(Gr12_Stop_contact[Gr12_Stop_contact$Genotype == "WT", "Amount"])
Gr12_Stop_contact$Norm_amount <- c((Gr12_Stop_contact$Amount[[1]]/mean_nb),
                                   (Gr12_Stop_contact$Amount[[2]]/mean_nb),
                                   (Gr12_Stop_contact$Amount[[3]]/mean_nb),
                                   (Gr12_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Stop_contact[Gr12_Stop_contact$Genotype == "WT", "Total_time"])
Gr12_Stop_contact$Norm_time <- c((Gr12_Stop_contact$Total_time[[1]]/mean_time),
                                 (Gr12_Stop_contact$Total_time[[2]]/mean_time),
                                 (Gr12_Stop_contact$Total_time[[3]]/mean_time),
                                 (Gr12_Stop_contact$Total_time[[4]]/mean_time))

Gr12_Rear_contact <- Gr12[Gr12$Event == "Rear_contact", ]
mean_nb <- mean(Gr12_Rear_contact[Gr12_Rear_contact$Genotype == "WT", "Amount"])
Gr12_Rear_contact$Norm_amount <- c((Gr12_Rear_contact$Amount[[1]]/mean_nb),
                                   (Gr12_Rear_contact$Amount[[2]]/mean_nb),
                                   (Gr12_Rear_contact$Amount[[3]]/mean_nb),
                                   (Gr12_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Rear_contact[Gr12_Rear_contact$Genotype == "WT", "Total_time"])
Gr12_Rear_contact$Norm_time <- c((Gr12_Rear_contact$Total_time[[1]]/mean_time),
                                 (Gr12_Rear_contact$Total_time[[2]]/mean_time),
                                 (Gr12_Rear_contact$Total_time[[3]]/mean_time),
                                 (Gr12_Rear_contact$Total_time[[4]]/mean_time))

Gr12_SbS_contact <- Gr12[Gr12$Event == "SbS_contact", ]
mean_nb <- mean(Gr12_SbS_contact[Gr12_SbS_contact$Genotype == "WT", "Amount"])
Gr12_SbS_contact$Norm_amount <- c((Gr12_SbS_contact$Amount[[1]]/mean_nb),
                                  (Gr12_SbS_contact$Amount[[2]]/mean_nb),
                                  (Gr12_SbS_contact$Amount[[3]]/mean_nb),
                                  (Gr12_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_SbS_contact[Gr12_SbS_contact$Genotype == "WT", "Total_time"])
Gr12_SbS_contact$Norm_time <- c((Gr12_SbS_contact$Total_time[[1]]/mean_time),
                                (Gr12_SbS_contact$Total_time[[2]]/mean_time),
                                (Gr12_SbS_contact$Total_time[[3]]/mean_time),
                                (Gr12_SbS_contact$Total_time[[4]]/mean_time))

Gr12_SbSO_contact <- Gr12[Gr12$Event == "SbSO_contact", ]
mean_nb <- mean(Gr12_SbSO_contact[Gr12_SbSO_contact$Genotype == "WT", "Amount"])
Gr12_SbSO_contact$Norm_amount <- c((Gr12_SbSO_contact$Amount[[1]]/mean_nb),
                                   (Gr12_SbSO_contact$Amount[[2]]/mean_nb),
                                   (Gr12_SbSO_contact$Amount[[3]]/mean_nb),
                                   (Gr12_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_SbSO_contact[Gr12_SbSO_contact$Genotype == "WT", "Total_time"])
Gr12_SbSO_contact$Norm_time <- c((Gr12_SbSO_contact$Total_time[[1]]/mean_time),
                                 (Gr12_SbSO_contact$Total_time[[2]]/mean_time),
                                 (Gr12_SbSO_contact$Total_time[[3]]/mean_time),
                                 (Gr12_SbSO_contact$Total_time[[4]]/mean_time))

Gr12_OO_contact <- Gr12[Gr12$Event == "OO_contact", ]
mean_nb <- mean(Gr12_OO_contact[Gr12_OO_contact$Genotype == "WT", "Amount"])
Gr12_OO_contact$Norm_amount <- c((Gr12_OO_contact$Amount[[1]]/mean_nb),
                                 (Gr12_OO_contact$Amount[[2]]/mean_nb),
                                 (Gr12_OO_contact$Amount[[3]]/mean_nb),
                                 (Gr12_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_OO_contact[Gr12_OO_contact$Genotype == "WT", "Total_time"])
Gr12_OO_contact$Norm_time <- c((Gr12_OO_contact$Total_time[[1]]/mean_time),
                               (Gr12_OO_contact$Total_time[[2]]/mean_time),
                               (Gr12_OO_contact$Total_time[[3]]/mean_time),
                               (Gr12_OO_contact$Total_time[[4]]/mean_time))

Gr12_OG_contact <- Gr12[Gr12$Event == "OG_contact", ]
mean_nb <- mean(Gr12_OG_contact[Gr12_OG_contact$Genotype == "WT", "Amount"])
Gr12_OG_contact$Norm_amount <- c((Gr12_OG_contact$Amount[[1]]/mean_nb),
                                 (Gr12_OG_contact$Amount[[2]]/mean_nb),
                                 (Gr12_OG_contact$Amount[[3]]/mean_nb),
                                 (Gr12_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_OG_contact[Gr12_OG_contact$Genotype == "WT", "Total_time"])
Gr12_OG_contact$Norm_time <- c((Gr12_OG_contact$Total_time[[1]]/mean_time),
                               (Gr12_OG_contact$Total_time[[2]]/mean_time),
                               (Gr12_OG_contact$Total_time[[3]]/mean_time),
                               (Gr12_OG_contact$Total_time[[4]]/mean_time))

Gr12_Social_approach <- Gr12[Gr12$Event == "Social_approach", ]
mean_nb <- mean(Gr12_Social_approach[Gr12_Social_approach$Genotype == "WT", "Amount"])
Gr12_Social_approach$Norm_amount <- c((Gr12_Social_approach$Amount[[1]]/mean_nb),
                                      (Gr12_Social_approach$Amount[[2]]/mean_nb),
                                      (Gr12_Social_approach$Amount[[3]]/mean_nb),
                                      (Gr12_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Social_approach[Gr12_Social_approach$Genotype == "WT", "Total_time"])
Gr12_Social_approach$Norm_time <- c((Gr12_Social_approach$Total_time[[1]]/mean_time),
                                    (Gr12_Social_approach$Total_time[[2]]/mean_time),
                                    (Gr12_Social_approach$Total_time[[3]]/mean_time),
                                    (Gr12_Social_approach$Total_time[[4]]/mean_time))

Gr12_Approach_rear <- Gr12[Gr12$Event == "Approach_rear", ]
mean_nb <- mean(Gr12_Approach_rear[Gr12_Approach_rear$Genotype == "WT", "Amount"])
Gr12_Approach_rear$Norm_amount <- c((Gr12_Approach_rear$Amount[[1]]/mean_nb),
                                    (Gr12_Approach_rear$Amount[[2]]/mean_nb),
                                    (Gr12_Approach_rear$Amount[[3]]/mean_nb),
                                    (Gr12_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Approach_rear[Gr12_Approach_rear$Genotype == "WT", "Total_time"])
Gr12_Approach_rear$Norm_time <- c((Gr12_Approach_rear$Total_time[[1]]/mean_time),
                                  (Gr12_Approach_rear$Total_time[[2]]/mean_time),
                                  (Gr12_Approach_rear$Total_time[[3]]/mean_time),
                                  (Gr12_Approach_rear$Total_time[[4]]/mean_time))

Gr12_Contact <- Gr12[Gr12$Event == "Contact", ]
mean_nb <- mean(Gr12_Contact[Gr12_Contact$Genotype == "WT", "Amount"])
Gr12_Contact$Norm_amount <- c((Gr12_Contact$Amount[[1]]/mean_nb),
                              (Gr12_Contact$Amount[[2]]/mean_nb),
                              (Gr12_Contact$Amount[[3]]/mean_nb),
                              (Gr12_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Contact[Gr12_Contact$Genotype == "WT", "Total_time"])
Gr12_Contact$Norm_time <- c((Gr12_Contact$Total_time[[1]]/mean_time),
                            (Gr12_Contact$Total_time[[2]]/mean_time),
                            (Gr12_Contact$Total_time[[3]]/mean_time),
                            (Gr12_Contact$Total_time[[4]]/mean_time))

Gr12_Get_away <- Gr12[Gr12$Event == "Get_away", ]
mean_nb <- mean(Gr12_Get_away[Gr12_Get_away$Genotype == "WT", "Amount"])
Gr12_Get_away$Norm_amount <- c((Gr12_Get_away$Amount[[1]]/mean_nb),
                               (Gr12_Get_away$Amount[[2]]/mean_nb),
                               (Gr12_Get_away$Amount[[3]]/mean_nb),
                               (Gr12_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Get_away[Gr12_Get_away$Genotype == "WT", "Total_time"])
Gr12_Get_away$Norm_time <- c((Gr12_Get_away$Total_time[[1]]/mean_time),
                             (Gr12_Get_away$Total_time[[2]]/mean_time),
                             (Gr12_Get_away$Total_time[[3]]/mean_time),
                             (Gr12_Get_away$Total_time[[4]]/mean_time))

Gr12_Break_contact <- Gr12[Gr12$Event == "Break_contact", ]
mean_nb <- mean(Gr12_Break_contact[Gr12_Break_contact$Genotype == "WT", "Amount"])
Gr12_Break_contact$Norm_amount <- c((Gr12_Break_contact$Amount[[1]]/mean_nb),
                                    (Gr12_Break_contact$Amount[[2]]/mean_nb),
                                    (Gr12_Break_contact$Amount[[3]]/mean_nb),
                                    (Gr12_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Break_contact[Gr12_Break_contact$Genotype == "WT", "Total_time"])
Gr12_Break_contact$Norm_time <- c((Gr12_Break_contact$Total_time[[1]]/mean_time),
                                  (Gr12_Break_contact$Total_time[[2]]/mean_time),
                                  (Gr12_Break_contact$Total_time[[3]]/mean_time),
                                  (Gr12_Break_contact$Total_time[[4]]/mean_time))

Gr12_Train2 <- Gr12[Gr12$Event == "Train2", ]
mean_nb <- mean(Gr12_Train2[Gr12_Train2$Genotype == "WT", "Amount"])
Gr12_Train2$Norm_amount <- c((Gr12_Train2$Amount[[1]]/mean_nb),
                             (Gr12_Train2$Amount[[2]]/mean_nb),
                             (Gr12_Train2$Amount[[3]]/mean_nb),
                             (Gr12_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Train2[Gr12_Train2$Genotype == "WT", "Total_time"])
Gr12_Train2$Norm_time <- c((Gr12_Train2$Total_time[[1]]/mean_time),
                           (Gr12_Train2$Total_time[[2]]/mean_time),
                           (Gr12_Train2$Total_time[[3]]/mean_time),
                           (Gr12_Train2$Total_time[[4]]/mean_time))

Gr12_Group3make <- Gr12[Gr12$Event == "Group3make", ]
mean_nb <- mean(Gr12_Group3make[Gr12_Group3make$Genotype == "WT", "Amount"])
Gr12_Group3make$Norm_amount <- c((Gr12_Group3make$Amount[[1]]/mean_nb),
                                 (Gr12_Group3make$Amount[[2]]/mean_nb),
                                 (Gr12_Group3make$Amount[[3]]/mean_nb),
                                 (Gr12_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Group3make[Gr12_Group3make$Genotype == "WT", "Total_time"])
Gr12_Group3make$Norm_time <- c((Gr12_Group3make$Total_time[[1]]/mean_time),
                               (Gr12_Group3make$Total_time[[2]]/mean_time),
                               (Gr12_Group3make$Total_time[[3]]/mean_time),
                               (Gr12_Group3make$Total_time[[4]]/mean_time))

Gr12_Group3break <- Gr12[Gr12$Event == "Group3break", ]
mean_nb <- mean(Gr12_Group3break[Gr12_Group3break$Genotype == "WT", "Amount"])
Gr12_Group3break$Norm_amount <- c((Gr12_Group3break$Amount[[1]]/mean_nb),
                                  (Gr12_Group3break$Amount[[2]]/mean_nb),
                                  (Gr12_Group3break$Amount[[3]]/mean_nb),
                                  (Gr12_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Group3break[Gr12_Group3break$Genotype == "WT", "Total_time"])
Gr12_Group3break$Norm_time <- c((Gr12_Group3break$Total_time[[1]]/mean_time),
                                (Gr12_Group3break$Total_time[[2]]/mean_time),
                                (Gr12_Group3break$Total_time[[3]]/mean_time),
                                (Gr12_Group3break$Total_time[[4]]/mean_time))

Gr12_Group4make <- Gr12[Gr12$Event == "Group4make", ]
mean_nb <- mean(Gr12_Group4make[Gr12_Group4make$Genotype == "WT", "Amount"])
Gr12_Group4make$Norm_amount <- c((Gr12_Group4make$Amount[[1]]/mean_nb),
                                 (Gr12_Group4make$Amount[[2]]/mean_nb),
                                 (Gr12_Group4make$Amount[[3]]/mean_nb),
                                 (Gr12_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Group4make[Gr12_Group4make$Genotype == "WT", "Total_time"])
Gr12_Group4make$Norm_time <- c((Gr12_Group4make$Total_time[[1]]/mean_time),
                               (Gr12_Group4make$Total_time[[2]]/mean_time),
                               (Gr12_Group4make$Total_time[[3]]/mean_time),
                               (Gr12_Group4make$Total_time[[4]]/mean_time))

Gr12_Group4break <- Gr12[Gr12$Event == "Group4break", ]
mean_nb <- mean(Gr12_Group4break[Gr12_Group4break$Genotype == "WT", "Amount"])
Gr12_Group4break$Norm_amount <- c((Gr12_Group4break$Amount[[1]]/mean_nb),
                                  (Gr12_Group4break$Amount[[2]]/mean_nb),
                                  (Gr12_Group4break$Amount[[3]]/mean_nb),
                                  (Gr12_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr12_Group4break[Gr12_Group4break$Genotype == "WT", "Total_time"])
Gr12_Group4break$Norm_time <- c((Gr12_Group4break$Total_time[[1]]/mean_time),
                                (Gr12_Group4break$Total_time[[2]]/mean_time),
                                (Gr12_Group4break$Total_time[[3]]/mean_time),
                                (Gr12_Group4break$Total_time[[4]]/mean_time))

Gr12_norm <- rbind(Gr12_Move_iso,Gr12_Stop_iso,Gr12_Rear_iso,Gr12_Huddling,
                   Gr12_WallJump,Gr12_SAP, Gr12_Move_contact,Gr12_Stop_contact,
                   Gr12_Rear_contact,Gr12_SbS_contact,Gr12_SbSO_contact,
                   Gr12_OO_contact,Gr12_OG_contact,Gr12_Social_approach,
                   Gr12_Approach_rear,Gr12_Contact,Gr12_Get_away,
                   Gr12_Break_contact,Gr12_Train2,Gr12_Group3make,
                   Gr12_Group3break,Gr12_Group4make,Gr12_Group4break)

rm(Gr12_Move_iso,Gr12_Stop_iso,Gr12_Rear_iso,Gr12_Huddling,
   Gr12_WallJump,Gr12_SAP, Gr12_Move_contact,Gr12_Stop_contact,
   Gr12_Rear_contact,Gr12_SbS_contact,Gr12_SbSO_contact,
   Gr12_OO_contact,Gr12_OG_contact,Gr12_Social_approach,
   Gr12_Approach_rear,Gr12_Contact,Gr12_Get_away,
   Gr12_Break_contact,Gr12_Train2,Gr12_Group3make,
   Gr12_Group3break,Gr12_Group4make,Gr12_Group4break)

Gr13 <- Events[Events$Group == "O4", ]
Gr13_Move_iso <- Gr13[Gr13$Event == "Move_isolated", ]
mean_nb <- mean(Gr13_Move_iso[Gr13_Move_iso$Genotype == "WT", "Amount"])
Gr13_Move_iso$Norm_amount <- c((Gr13_Move_iso$Amount[[1]]/mean_nb),
                               (Gr13_Move_iso$Amount[[2]]/mean_nb),
                               (Gr13_Move_iso$Amount[[3]]/mean_nb),
                               (Gr13_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Move_iso[Gr13_Move_iso$Genotype == "WT", "Total_time"])
Gr13_Move_iso$Norm_time <- c((Gr13_Move_iso$Total_time[[1]]/mean_time),
                             (Gr13_Move_iso$Total_time[[2]]/mean_time),
                             (Gr13_Move_iso$Total_time[[3]]/mean_time),
                             (Gr13_Move_iso$Total_time[[4]]/mean_time))

Gr13_Stop_iso <- Gr13[Gr13$Event == "Stop_isolated", ]
mean_nb <- mean(Gr13_Stop_iso[Gr13_Stop_iso$Genotype == "WT", "Amount"])
Gr13_Stop_iso$Norm_amount <- c((Gr13_Stop_iso$Amount[[1]]/mean_nb),
                               (Gr13_Stop_iso$Amount[[2]]/mean_nb),
                               (Gr13_Stop_iso$Amount[[3]]/mean_nb),
                               (Gr13_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Stop_iso[Gr13_Stop_iso$Genotype == "WT", "Total_time"])
Gr13_Stop_iso$Norm_time <- c((Gr13_Stop_iso$Total_time[[1]]/mean_time),
                             (Gr13_Stop_iso$Total_time[[2]]/mean_time),
                             (Gr13_Stop_iso$Total_time[[3]]/mean_time),
                             (Gr13_Stop_iso$Total_time[[4]]/mean_time))

Gr13_Rear_iso <- Gr13[Gr13$Event == "Rear_isolated", ]
mean_nb <- mean(Gr13_Rear_iso[Gr13_Rear_iso$Genotype == "WT", "Amount"])
Gr13_Rear_iso$Norm_amount <- c((Gr13_Rear_iso$Amount[[1]]/mean_nb),
                               (Gr13_Rear_iso$Amount[[2]]/mean_nb),
                               (Gr13_Rear_iso$Amount[[3]]/mean_nb),
                               (Gr13_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Rear_iso[Gr13_Rear_iso$Genotype == "WT", "Total_time"])
Gr13_Rear_iso$Norm_time <- c((Gr13_Rear_iso$Total_time[[1]]/mean_time),
                             (Gr13_Rear_iso$Total_time[[2]]/mean_time),
                             (Gr13_Rear_iso$Total_time[[3]]/mean_time),
                             (Gr13_Rear_iso$Total_time[[4]]/mean_time))

Gr13_Huddling <- Gr13[Gr13$Event == "Huddling", ]
mean_nb <- mean(Gr13_Huddling[Gr13_Huddling$Genotype == "WT", "Amount"])
Gr13_Huddling$Norm_amount <- c((Gr13_Huddling$Amount[[1]]/mean_nb),
                               (Gr13_Huddling$Amount[[2]]/mean_nb),
                               (Gr13_Huddling$Amount[[3]]/mean_nb),
                               (Gr13_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Huddling[Gr13_Huddling$Genotype == "WT", "Total_time"])
Gr13_Huddling$Norm_time <- c((Gr13_Huddling$Total_time[[1]]/mean_time),
                             (Gr13_Huddling$Total_time[[2]]/mean_time),
                             (Gr13_Huddling$Total_time[[3]]/mean_time),
                             (Gr13_Huddling$Total_time[[4]]/mean_time))

Gr13_WallJump <- Gr13[Gr13$Event == "WallJump", ]
mean_nb <- mean(Gr13_WallJump[Gr13_WallJump$Genotype == "WT", "Amount"])
Gr13_WallJump$Norm_amount <- c((Gr13_WallJump$Amount[[1]]/mean_nb),
                               (Gr13_WallJump$Amount[[2]]/mean_nb),
                               (Gr13_WallJump$Amount[[3]]/mean_nb),
                               (Gr13_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_WallJump[Gr13_WallJump$Genotype == "WT", "Total_time"])
Gr13_WallJump$Norm_time <- c((Gr13_WallJump$Total_time[[1]]/mean_time),
                             (Gr13_WallJump$Total_time[[2]]/mean_time),
                             (Gr13_WallJump$Total_time[[3]]/mean_time),
                             (Gr13_WallJump$Total_time[[4]]/mean_time))

Gr13_SAP <- Gr13[Gr13$Event == "SAP", ]
mean_nb <- mean(Gr13_SAP[Gr13_SAP$Genotype == "WT", "Amount"])
Gr13_SAP$Norm_amount <- c((Gr13_SAP$Amount[[1]]/mean_nb),
                          (Gr13_SAP$Amount[[2]]/mean_nb),
                          (Gr13_SAP$Amount[[3]]/mean_nb),
                          (Gr13_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_SAP[Gr13_SAP$Genotype == "WT", "Total_time"])
Gr13_SAP$Norm_time <- c((Gr13_SAP$Total_time[[1]]/mean_time),
                        (Gr13_SAP$Total_time[[2]]/mean_time),
                        (Gr13_SAP$Total_time[[3]]/mean_time),
                        (Gr13_SAP$Total_time[[4]]/mean_time))

Gr13_Move_contact <- Gr13[Gr13$Event == "Move_contact", ]
mean_nb <- mean(Gr13_Move_contact[Gr13_Move_contact$Genotype == "WT", "Amount"])
Gr13_Move_contact$Norm_amount <- c((Gr13_Move_contact$Amount[[1]]/mean_nb),
                                   (Gr13_Move_contact$Amount[[2]]/mean_nb),
                                   (Gr13_Move_contact$Amount[[3]]/mean_nb),
                                   (Gr13_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Move_contact[Gr13_Move_contact$Genotype == "WT", "Total_time"])
Gr13_Move_contact$Norm_time <- c((Gr13_Move_contact$Total_time[[1]]/mean_time),
                                 (Gr13_Move_contact$Total_time[[2]]/mean_time),
                                 (Gr13_Move_contact$Total_time[[3]]/mean_time),
                                 (Gr13_Move_contact$Total_time[[4]]/mean_time))

Gr13_Stop_contact <- Gr13[Gr13$Event == "Stop_contact", ]
mean_nb <- mean(Gr13_Stop_contact[Gr13_Stop_contact$Genotype == "WT", "Amount"])
Gr13_Stop_contact$Norm_amount <- c((Gr13_Stop_contact$Amount[[1]]/mean_nb),
                                   (Gr13_Stop_contact$Amount[[2]]/mean_nb),
                                   (Gr13_Stop_contact$Amount[[3]]/mean_nb),
                                   (Gr13_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Stop_contact[Gr13_Stop_contact$Genotype == "WT", "Total_time"])
Gr13_Stop_contact$Norm_time <- c((Gr13_Stop_contact$Total_time[[1]]/mean_time),
                                 (Gr13_Stop_contact$Total_time[[2]]/mean_time),
                                 (Gr13_Stop_contact$Total_time[[3]]/mean_time),
                                 (Gr13_Stop_contact$Total_time[[4]]/mean_time))

Gr13_Rear_contact <- Gr13[Gr13$Event == "Rear_contact", ]
mean_nb <- mean(Gr13_Rear_contact[Gr13_Rear_contact$Genotype == "WT", "Amount"])
Gr13_Rear_contact$Norm_amount <- c((Gr13_Rear_contact$Amount[[1]]/mean_nb),
                                   (Gr13_Rear_contact$Amount[[2]]/mean_nb),
                                   (Gr13_Rear_contact$Amount[[3]]/mean_nb),
                                   (Gr13_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Rear_contact[Gr13_Rear_contact$Genotype == "WT", "Total_time"])
Gr13_Rear_contact$Norm_time <- c((Gr13_Rear_contact$Total_time[[1]]/mean_time),
                                 (Gr13_Rear_contact$Total_time[[2]]/mean_time),
                                 (Gr13_Rear_contact$Total_time[[3]]/mean_time),
                                 (Gr13_Rear_contact$Total_time[[4]]/mean_time))

Gr13_SbS_contact <- Gr13[Gr13$Event == "SbS_contact", ]
mean_nb <- mean(Gr13_SbS_contact[Gr13_SbS_contact$Genotype == "WT", "Amount"])
Gr13_SbS_contact$Norm_amount <- c((Gr13_SbS_contact$Amount[[1]]/mean_nb),
                                  (Gr13_SbS_contact$Amount[[2]]/mean_nb),
                                  (Gr13_SbS_contact$Amount[[3]]/mean_nb),
                                  (Gr13_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_SbS_contact[Gr13_SbS_contact$Genotype == "WT", "Total_time"])
Gr13_SbS_contact$Norm_time <- c((Gr13_SbS_contact$Total_time[[1]]/mean_time),
                                (Gr13_SbS_contact$Total_time[[2]]/mean_time),
                                (Gr13_SbS_contact$Total_time[[3]]/mean_time),
                                (Gr13_SbS_contact$Total_time[[4]]/mean_time))

Gr13_SbSO_contact <- Gr13[Gr13$Event == "SbSO_contact", ]
mean_nb <- mean(Gr13_SbSO_contact[Gr13_SbSO_contact$Genotype == "WT", "Amount"])
Gr13_SbSO_contact$Norm_amount <- c((Gr13_SbSO_contact$Amount[[1]]/mean_nb),
                                   (Gr13_SbSO_contact$Amount[[2]]/mean_nb),
                                   (Gr13_SbSO_contact$Amount[[3]]/mean_nb),
                                   (Gr13_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_SbSO_contact[Gr13_SbSO_contact$Genotype == "WT", "Total_time"])
Gr13_SbSO_contact$Norm_time <- c((Gr13_SbSO_contact$Total_time[[1]]/mean_time),
                                 (Gr13_SbSO_contact$Total_time[[2]]/mean_time),
                                 (Gr13_SbSO_contact$Total_time[[3]]/mean_time),
                                 (Gr13_SbSO_contact$Total_time[[4]]/mean_time))

Gr13_OO_contact <- Gr13[Gr13$Event == "OO_contact", ]
mean_nb <- mean(Gr13_OO_contact[Gr13_OO_contact$Genotype == "WT", "Amount"])
Gr13_OO_contact$Norm_amount <- c((Gr13_OO_contact$Amount[[1]]/mean_nb),
                                 (Gr13_OO_contact$Amount[[2]]/mean_nb),
                                 (Gr13_OO_contact$Amount[[3]]/mean_nb),
                                 (Gr13_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_OO_contact[Gr13_OO_contact$Genotype == "WT", "Total_time"])
Gr13_OO_contact$Norm_time <- c((Gr13_OO_contact$Total_time[[1]]/mean_time),
                               (Gr13_OO_contact$Total_time[[2]]/mean_time),
                               (Gr13_OO_contact$Total_time[[3]]/mean_time),
                               (Gr13_OO_contact$Total_time[[4]]/mean_time))

Gr13_OG_contact <- Gr13[Gr13$Event == "OG_contact", ]
mean_nb <- mean(Gr13_OG_contact[Gr13_OG_contact$Genotype == "WT", "Amount"])
Gr13_OG_contact$Norm_amount <- c((Gr13_OG_contact$Amount[[1]]/mean_nb),
                                 (Gr13_OG_contact$Amount[[2]]/mean_nb),
                                 (Gr13_OG_contact$Amount[[3]]/mean_nb),
                                 (Gr13_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_OG_contact[Gr13_OG_contact$Genotype == "WT", "Total_time"])
Gr13_OG_contact$Norm_time <- c((Gr13_OG_contact$Total_time[[1]]/mean_time),
                               (Gr13_OG_contact$Total_time[[2]]/mean_time),
                               (Gr13_OG_contact$Total_time[[3]]/mean_time),
                               (Gr13_OG_contact$Total_time[[4]]/mean_time))

Gr13_Social_approach <- Gr13[Gr13$Event == "Social_approach", ]
mean_nb <- mean(Gr13_Social_approach[Gr13_Social_approach$Genotype == "WT", "Amount"])
Gr13_Social_approach$Norm_amount <- c((Gr13_Social_approach$Amount[[1]]/mean_nb),
                                      (Gr13_Social_approach$Amount[[2]]/mean_nb),
                                      (Gr13_Social_approach$Amount[[3]]/mean_nb),
                                      (Gr13_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Social_approach[Gr13_Social_approach$Genotype == "WT", "Total_time"])
Gr13_Social_approach$Norm_time <- c((Gr13_Social_approach$Total_time[[1]]/mean_time),
                                    (Gr13_Social_approach$Total_time[[2]]/mean_time),
                                    (Gr13_Social_approach$Total_time[[3]]/mean_time),
                                    (Gr13_Social_approach$Total_time[[4]]/mean_time))

Gr13_Approach_rear <- Gr13[Gr13$Event == "Approach_rear", ]
mean_nb <- mean(Gr13_Approach_rear[Gr13_Approach_rear$Genotype == "WT", "Amount"])
Gr13_Approach_rear$Norm_amount <- c((Gr13_Approach_rear$Amount[[1]]/mean_nb),
                                    (Gr13_Approach_rear$Amount[[2]]/mean_nb),
                                    (Gr13_Approach_rear$Amount[[3]]/mean_nb),
                                    (Gr13_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Approach_rear[Gr13_Approach_rear$Genotype == "WT", "Total_time"])
Gr13_Approach_rear$Norm_time <- c((Gr13_Approach_rear$Total_time[[1]]/mean_time),
                                  (Gr13_Approach_rear$Total_time[[2]]/mean_time),
                                  (Gr13_Approach_rear$Total_time[[3]]/mean_time),
                                  (Gr13_Approach_rear$Total_time[[4]]/mean_time))

Gr13_Contact <- Gr13[Gr13$Event == "Contact", ]
mean_nb <- mean(Gr13_Contact[Gr13_Contact$Genotype == "WT", "Amount"])
Gr13_Contact$Norm_amount <- c((Gr13_Contact$Amount[[1]]/mean_nb),
                              (Gr13_Contact$Amount[[2]]/mean_nb),
                              (Gr13_Contact$Amount[[3]]/mean_nb),
                              (Gr13_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Contact[Gr13_Contact$Genotype == "WT", "Total_time"])
Gr13_Contact$Norm_time <- c((Gr13_Contact$Total_time[[1]]/mean_time),
                            (Gr13_Contact$Total_time[[2]]/mean_time),
                            (Gr13_Contact$Total_time[[3]]/mean_time),
                            (Gr13_Contact$Total_time[[4]]/mean_time))

Gr13_Get_away <- Gr13[Gr13$Event == "Get_away", ]
mean_nb <- mean(Gr13_Get_away[Gr13_Get_away$Genotype == "WT", "Amount"])
Gr13_Get_away$Norm_amount <- c((Gr13_Get_away$Amount[[1]]/mean_nb),
                               (Gr13_Get_away$Amount[[2]]/mean_nb),
                               (Gr13_Get_away$Amount[[3]]/mean_nb),
                               (Gr13_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Get_away[Gr13_Get_away$Genotype == "WT", "Total_time"])
Gr13_Get_away$Norm_time <- c((Gr13_Get_away$Total_time[[1]]/mean_time),
                             (Gr13_Get_away$Total_time[[2]]/mean_time),
                             (Gr13_Get_away$Total_time[[3]]/mean_time),
                             (Gr13_Get_away$Total_time[[4]]/mean_time))

Gr13_Break_contact <- Gr13[Gr13$Event == "Break_contact", ]
mean_nb <- mean(Gr13_Break_contact[Gr13_Break_contact$Genotype == "WT", "Amount"])
Gr13_Break_contact$Norm_amount <- c((Gr13_Break_contact$Amount[[1]]/mean_nb),
                                    (Gr13_Break_contact$Amount[[2]]/mean_nb),
                                    (Gr13_Break_contact$Amount[[3]]/mean_nb),
                                    (Gr13_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Break_contact[Gr13_Break_contact$Genotype == "WT", "Total_time"])
Gr13_Break_contact$Norm_time <- c((Gr13_Break_contact$Total_time[[1]]/mean_time),
                                  (Gr13_Break_contact$Total_time[[2]]/mean_time),
                                  (Gr13_Break_contact$Total_time[[3]]/mean_time),
                                  (Gr13_Break_contact$Total_time[[4]]/mean_time))

Gr13_Train2 <- Gr13[Gr13$Event == "Train2", ]
mean_nb <- mean(Gr13_Train2[Gr13_Train2$Genotype == "WT", "Amount"])
Gr13_Train2$Norm_amount <- c((Gr13_Train2$Amount[[1]]/mean_nb),
                             (Gr13_Train2$Amount[[2]]/mean_nb),
                             (Gr13_Train2$Amount[[3]]/mean_nb),
                             (Gr13_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Train2[Gr13_Train2$Genotype == "WT", "Total_time"])
Gr13_Train2$Norm_time <- c((Gr13_Train2$Total_time[[1]]/mean_time),
                           (Gr13_Train2$Total_time[[2]]/mean_time),
                           (Gr13_Train2$Total_time[[3]]/mean_time),
                           (Gr13_Train2$Total_time[[4]]/mean_time))

Gr13_Group3make <- Gr13[Gr13$Event == "Group3make", ]
mean_nb <- mean(Gr13_Group3make[Gr13_Group3make$Genotype == "WT", "Amount"])
Gr13_Group3make$Norm_amount <- c((Gr13_Group3make$Amount[[1]]/mean_nb),
                                 (Gr13_Group3make$Amount[[2]]/mean_nb),
                                 (Gr13_Group3make$Amount[[3]]/mean_nb),
                                 (Gr13_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Group3make[Gr13_Group3make$Genotype == "WT", "Total_time"])
Gr13_Group3make$Norm_time <- c((Gr13_Group3make$Total_time[[1]]/mean_time),
                               (Gr13_Group3make$Total_time[[2]]/mean_time),
                               (Gr13_Group3make$Total_time[[3]]/mean_time),
                               (Gr13_Group3make$Total_time[[4]]/mean_time))

Gr13_Group3break <- Gr13[Gr13$Event == "Group3break", ]
mean_nb <- mean(Gr13_Group3break[Gr13_Group3break$Genotype == "WT", "Amount"])
Gr13_Group3break$Norm_amount <- c((Gr13_Group3break$Amount[[1]]/mean_nb),
                                  (Gr13_Group3break$Amount[[2]]/mean_nb),
                                  (Gr13_Group3break$Amount[[3]]/mean_nb),
                                  (Gr13_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Group3break[Gr13_Group3break$Genotype == "WT", "Total_time"])
Gr13_Group3break$Norm_time <- c((Gr13_Group3break$Total_time[[1]]/mean_time),
                                (Gr13_Group3break$Total_time[[2]]/mean_time),
                                (Gr13_Group3break$Total_time[[3]]/mean_time),
                                (Gr13_Group3break$Total_time[[4]]/mean_time))

Gr13_Group4make <- Gr13[Gr13$Event == "Group4make", ]
mean_nb <- mean(Gr13_Group4make[Gr13_Group4make$Genotype == "WT", "Amount"])
Gr13_Group4make$Norm_amount <- c((Gr13_Group4make$Amount[[1]]/mean_nb),
                                 (Gr13_Group4make$Amount[[2]]/mean_nb),
                                 (Gr13_Group4make$Amount[[3]]/mean_nb),
                                 (Gr13_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Group4make[Gr13_Group4make$Genotype == "WT", "Total_time"])
Gr13_Group4make$Norm_time <- c((Gr13_Group4make$Total_time[[1]]/mean_time),
                               (Gr13_Group4make$Total_time[[2]]/mean_time),
                               (Gr13_Group4make$Total_time[[3]]/mean_time),
                               (Gr13_Group4make$Total_time[[4]]/mean_time))

Gr13_Group4break <- Gr13[Gr13$Event == "Group4break", ]
mean_nb <- mean(Gr13_Group4break[Gr13_Group4break$Genotype == "WT", "Amount"])
Gr13_Group4break$Norm_amount <- c((Gr13_Group4break$Amount[[1]]/mean_nb),
                                  (Gr13_Group4break$Amount[[2]]/mean_nb),
                                  (Gr13_Group4break$Amount[[3]]/mean_nb),
                                  (Gr13_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr13_Group4break[Gr13_Group4break$Genotype == "WT", "Total_time"])
Gr13_Group4break$Norm_time <- c((Gr13_Group4break$Total_time[[1]]/mean_time),
                                (Gr13_Group4break$Total_time[[2]]/mean_time),
                                (Gr13_Group4break$Total_time[[3]]/mean_time),
                                (Gr13_Group4break$Total_time[[4]]/mean_time))

Gr13_norm <- rbind(Gr13_Move_iso,Gr13_Stop_iso,Gr13_Rear_iso,Gr13_Huddling,
                   Gr13_WallJump,Gr13_SAP, Gr13_Move_contact,Gr13_Stop_contact,
                   Gr13_Rear_contact,Gr13_SbS_contact,Gr13_SbSO_contact,
                   Gr13_OO_contact,Gr13_OG_contact,Gr13_Social_approach,
                   Gr13_Approach_rear,Gr13_Contact,Gr13_Get_away,
                   Gr13_Break_contact,Gr13_Train2,Gr13_Group3make,
                   Gr13_Group3break,Gr13_Group4make,Gr13_Group4break)

rm(Gr13_Move_iso,Gr13_Stop_iso,Gr13_Rear_iso,Gr13_Huddling,
   Gr13_WallJump,Gr13_SAP, Gr13_Move_contact,Gr13_Stop_contact,
   Gr13_Rear_contact,Gr13_SbS_contact,Gr13_SbSO_contact,
   Gr13_OO_contact,Gr13_OG_contact,Gr13_Social_approach,
   Gr13_Approach_rear,Gr13_Contact,Gr13_Get_away,
   Gr13_Break_contact,Gr13_Train2,Gr13_Group3make,
   Gr13_Group3break,Gr13_Group4make,Gr13_Group4break)

Gr14 <- Events[Events$Group == "O5", ]
Gr14_Move_iso <- Gr14[Gr14$Event == "Move_isolated", ]
mean_nb <- mean(Gr14_Move_iso[Gr14_Move_iso$Genotype == "WT", "Amount"])
Gr14_Move_iso$Norm_amount <- c((Gr14_Move_iso$Amount[[1]]/mean_nb),
                               (Gr14_Move_iso$Amount[[2]]/mean_nb),
                               (Gr14_Move_iso$Amount[[3]]/mean_nb),
                               (Gr14_Move_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Move_iso[Gr14_Move_iso$Genotype == "WT", "Total_time"])
Gr14_Move_iso$Norm_time <- c((Gr14_Move_iso$Total_time[[1]]/mean_time),
                             (Gr14_Move_iso$Total_time[[2]]/mean_time),
                             (Gr14_Move_iso$Total_time[[3]]/mean_time),
                             (Gr14_Move_iso$Total_time[[4]]/mean_time))

Gr14_Stop_iso <- Gr14[Gr14$Event == "Stop_isolated", ]
mean_nb <- mean(Gr14_Stop_iso[Gr14_Stop_iso$Genotype == "WT", "Amount"])
Gr14_Stop_iso$Norm_amount <- c((Gr14_Stop_iso$Amount[[1]]/mean_nb),
                               (Gr14_Stop_iso$Amount[[2]]/mean_nb),
                               (Gr14_Stop_iso$Amount[[3]]/mean_nb),
                               (Gr14_Stop_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Stop_iso[Gr14_Stop_iso$Genotype == "WT", "Total_time"])
Gr14_Stop_iso$Norm_time <- c((Gr14_Stop_iso$Total_time[[1]]/mean_time),
                             (Gr14_Stop_iso$Total_time[[2]]/mean_time),
                             (Gr14_Stop_iso$Total_time[[3]]/mean_time),
                             (Gr14_Stop_iso$Total_time[[4]]/mean_time))

Gr14_Rear_iso <- Gr14[Gr14$Event == "Rear_isolated", ]
mean_nb <- mean(Gr14_Rear_iso[Gr14_Rear_iso$Genotype == "WT", "Amount"])
Gr14_Rear_iso$Norm_amount <- c((Gr14_Rear_iso$Amount[[1]]/mean_nb),
                               (Gr14_Rear_iso$Amount[[2]]/mean_nb),
                               (Gr14_Rear_iso$Amount[[3]]/mean_nb),
                               (Gr14_Rear_iso$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Rear_iso[Gr14_Rear_iso$Genotype == "WT", "Total_time"])
Gr14_Rear_iso$Norm_time <- c((Gr14_Rear_iso$Total_time[[1]]/mean_time),
                             (Gr14_Rear_iso$Total_time[[2]]/mean_time),
                             (Gr14_Rear_iso$Total_time[[3]]/mean_time),
                             (Gr14_Rear_iso$Total_time[[4]]/mean_time))

Gr14_Huddling <- Gr14[Gr14$Event == "Huddling", ]
mean_nb <- mean(Gr14_Huddling[Gr14_Huddling$Genotype == "WT", "Amount"])
Gr14_Huddling$Norm_amount <- c((Gr14_Huddling$Amount[[1]]/mean_nb),
                               (Gr14_Huddling$Amount[[2]]/mean_nb),
                               (Gr14_Huddling$Amount[[3]]/mean_nb),
                               (Gr14_Huddling$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Huddling[Gr14_Huddling$Genotype == "WT", "Total_time"])
Gr14_Huddling$Norm_time <- c((Gr14_Huddling$Total_time[[1]]/mean_time),
                             (Gr14_Huddling$Total_time[[2]]/mean_time),
                             (Gr14_Huddling$Total_time[[3]]/mean_time),
                             (Gr14_Huddling$Total_time[[4]]/mean_time))

Gr14_WallJump <- Gr14[Gr14$Event == "WallJump", ]
mean_nb <- mean(Gr14_WallJump[Gr14_WallJump$Genotype == "WT", "Amount"])
Gr14_WallJump$Norm_amount <- c((Gr14_WallJump$Amount[[1]]/mean_nb),
                               (Gr14_WallJump$Amount[[2]]/mean_nb),
                               (Gr14_WallJump$Amount[[3]]/mean_nb),
                               (Gr14_WallJump$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_WallJump[Gr14_WallJump$Genotype == "WT", "Total_time"])
Gr14_WallJump$Norm_time <- c((Gr14_WallJump$Total_time[[1]]/mean_time),
                             (Gr14_WallJump$Total_time[[2]]/mean_time),
                             (Gr14_WallJump$Total_time[[3]]/mean_time),
                             (Gr14_WallJump$Total_time[[4]]/mean_time))

Gr14_SAP <- Gr14[Gr14$Event == "SAP", ]
mean_nb <- mean(Gr14_SAP[Gr14_SAP$Genotype == "WT", "Amount"])
Gr14_SAP$Norm_amount <- c((Gr14_SAP$Amount[[1]]/mean_nb),
                          (Gr14_SAP$Amount[[2]]/mean_nb),
                          (Gr14_SAP$Amount[[3]]/mean_nb),
                          (Gr14_SAP$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_SAP[Gr14_SAP$Genotype == "WT", "Total_time"])
Gr14_SAP$Norm_time <- c((Gr14_SAP$Total_time[[1]]/mean_time),
                        (Gr14_SAP$Total_time[[2]]/mean_time),
                        (Gr14_SAP$Total_time[[3]]/mean_time),
                        (Gr14_SAP$Total_time[[4]]/mean_time))

Gr14_Move_contact <- Gr14[Gr14$Event == "Move_contact", ]
mean_nb <- mean(Gr14_Move_contact[Gr14_Move_contact$Genotype == "WT", "Amount"])
Gr14_Move_contact$Norm_amount <- c((Gr14_Move_contact$Amount[[1]]/mean_nb),
                                   (Gr14_Move_contact$Amount[[2]]/mean_nb),
                                   (Gr14_Move_contact$Amount[[3]]/mean_nb),
                                   (Gr14_Move_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Move_contact[Gr14_Move_contact$Genotype == "WT", "Total_time"])
Gr14_Move_contact$Norm_time <- c((Gr14_Move_contact$Total_time[[1]]/mean_time),
                                 (Gr14_Move_contact$Total_time[[2]]/mean_time),
                                 (Gr14_Move_contact$Total_time[[3]]/mean_time),
                                 (Gr14_Move_contact$Total_time[[4]]/mean_time))

Gr14_Stop_contact <- Gr14[Gr14$Event == "Stop_contact", ]
mean_nb <- mean(Gr14_Stop_contact[Gr14_Stop_contact$Genotype == "WT", "Amount"])
Gr14_Stop_contact$Norm_amount <- c((Gr14_Stop_contact$Amount[[1]]/mean_nb),
                                   (Gr14_Stop_contact$Amount[[2]]/mean_nb),
                                   (Gr14_Stop_contact$Amount[[3]]/mean_nb),
                                   (Gr14_Stop_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Stop_contact[Gr14_Stop_contact$Genotype == "WT", "Total_time"])
Gr14_Stop_contact$Norm_time <- c((Gr14_Stop_contact$Total_time[[1]]/mean_time),
                                 (Gr14_Stop_contact$Total_time[[2]]/mean_time),
                                 (Gr14_Stop_contact$Total_time[[3]]/mean_time),
                                 (Gr14_Stop_contact$Total_time[[4]]/mean_time))

Gr14_Rear_contact <- Gr14[Gr14$Event == "Rear_contact", ]
mean_nb <- mean(Gr14_Rear_contact[Gr14_Rear_contact$Genotype == "WT", "Amount"])
Gr14_Rear_contact$Norm_amount <- c((Gr14_Rear_contact$Amount[[1]]/mean_nb),
                                   (Gr14_Rear_contact$Amount[[2]]/mean_nb),
                                   (Gr14_Rear_contact$Amount[[3]]/mean_nb),
                                   (Gr14_Rear_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Rear_contact[Gr14_Rear_contact$Genotype == "WT", "Total_time"])
Gr14_Rear_contact$Norm_time <- c((Gr14_Rear_contact$Total_time[[1]]/mean_time),
                                 (Gr14_Rear_contact$Total_time[[2]]/mean_time),
                                 (Gr14_Rear_contact$Total_time[[3]]/mean_time),
                                 (Gr14_Rear_contact$Total_time[[4]]/mean_time))

Gr14_SbS_contact <- Gr14[Gr14$Event == "SbS_contact", ]
mean_nb <- mean(Gr14_SbS_contact[Gr14_SbS_contact$Genotype == "WT", "Amount"])
Gr14_SbS_contact$Norm_amount <- c((Gr14_SbS_contact$Amount[[1]]/mean_nb),
                                  (Gr14_SbS_contact$Amount[[2]]/mean_nb),
                                  (Gr14_SbS_contact$Amount[[3]]/mean_nb),
                                  (Gr14_SbS_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_SbS_contact[Gr14_SbS_contact$Genotype == "WT", "Total_time"])
Gr14_SbS_contact$Norm_time <- c((Gr14_SbS_contact$Total_time[[1]]/mean_time),
                                (Gr14_SbS_contact$Total_time[[2]]/mean_time),
                                (Gr14_SbS_contact$Total_time[[3]]/mean_time),
                                (Gr14_SbS_contact$Total_time[[4]]/mean_time))

Gr14_SbSO_contact <- Gr14[Gr14$Event == "SbSO_contact", ]
mean_nb <- mean(Gr14_SbSO_contact[Gr14_SbSO_contact$Genotype == "WT", "Amount"])
Gr14_SbSO_contact$Norm_amount <- c((Gr14_SbSO_contact$Amount[[1]]/mean_nb),
                                   (Gr14_SbSO_contact$Amount[[2]]/mean_nb),
                                   (Gr14_SbSO_contact$Amount[[3]]/mean_nb),
                                   (Gr14_SbSO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_SbSO_contact[Gr14_SbSO_contact$Genotype == "WT", "Total_time"])
Gr14_SbSO_contact$Norm_time <- c((Gr14_SbSO_contact$Total_time[[1]]/mean_time),
                                 (Gr14_SbSO_contact$Total_time[[2]]/mean_time),
                                 (Gr14_SbSO_contact$Total_time[[3]]/mean_time),
                                 (Gr14_SbSO_contact$Total_time[[4]]/mean_time))

Gr14_OO_contact <- Gr14[Gr14$Event == "OO_contact", ]
mean_nb <- mean(Gr14_OO_contact[Gr14_OO_contact$Genotype == "WT", "Amount"])
Gr14_OO_contact$Norm_amount <- c((Gr14_OO_contact$Amount[[1]]/mean_nb),
                                 (Gr14_OO_contact$Amount[[2]]/mean_nb),
                                 (Gr14_OO_contact$Amount[[3]]/mean_nb),
                                 (Gr14_OO_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_OO_contact[Gr14_OO_contact$Genotype == "WT", "Total_time"])
Gr14_OO_contact$Norm_time <- c((Gr14_OO_contact$Total_time[[1]]/mean_time),
                               (Gr14_OO_contact$Total_time[[2]]/mean_time),
                               (Gr14_OO_contact$Total_time[[3]]/mean_time),
                               (Gr14_OO_contact$Total_time[[4]]/mean_time))

Gr14_OG_contact <- Gr14[Gr14$Event == "OG_contact", ]
mean_nb <- mean(Gr14_OG_contact[Gr14_OG_contact$Genotype == "WT", "Amount"])
Gr14_OG_contact$Norm_amount <- c((Gr14_OG_contact$Amount[[1]]/mean_nb),
                                 (Gr14_OG_contact$Amount[[2]]/mean_nb),
                                 (Gr14_OG_contact$Amount[[3]]/mean_nb),
                                 (Gr14_OG_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_OG_contact[Gr14_OG_contact$Genotype == "WT", "Total_time"])
Gr14_OG_contact$Norm_time <- c((Gr14_OG_contact$Total_time[[1]]/mean_time),
                               (Gr14_OG_contact$Total_time[[2]]/mean_time),
                               (Gr14_OG_contact$Total_time[[3]]/mean_time),
                               (Gr14_OG_contact$Total_time[[4]]/mean_time))

Gr14_Social_approach <- Gr14[Gr14$Event == "Social_approach", ]
mean_nb <- mean(Gr14_Social_approach[Gr14_Social_approach$Genotype == "WT", "Amount"])
Gr14_Social_approach$Norm_amount <- c((Gr14_Social_approach$Amount[[1]]/mean_nb),
                                      (Gr14_Social_approach$Amount[[2]]/mean_nb),
                                      (Gr14_Social_approach$Amount[[3]]/mean_nb),
                                      (Gr14_Social_approach$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Social_approach[Gr14_Social_approach$Genotype == "WT", "Total_time"])
Gr14_Social_approach$Norm_time <- c((Gr14_Social_approach$Total_time[[1]]/mean_time),
                                    (Gr14_Social_approach$Total_time[[2]]/mean_time),
                                    (Gr14_Social_approach$Total_time[[3]]/mean_time),
                                    (Gr14_Social_approach$Total_time[[4]]/mean_time))

Gr14_Approach_rear <- Gr14[Gr14$Event == "Approach_rear", ]
mean_nb <- mean(Gr14_Approach_rear[Gr14_Approach_rear$Genotype == "WT", "Amount"])
Gr14_Approach_rear$Norm_amount <- c((Gr14_Approach_rear$Amount[[1]]/mean_nb),
                                    (Gr14_Approach_rear$Amount[[2]]/mean_nb),
                                    (Gr14_Approach_rear$Amount[[3]]/mean_nb),
                                    (Gr14_Approach_rear$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Approach_rear[Gr14_Approach_rear$Genotype == "WT", "Total_time"])
Gr14_Approach_rear$Norm_time <- c((Gr14_Approach_rear$Total_time[[1]]/mean_time),
                                  (Gr14_Approach_rear$Total_time[[2]]/mean_time),
                                  (Gr14_Approach_rear$Total_time[[3]]/mean_time),
                                  (Gr14_Approach_rear$Total_time[[4]]/mean_time))

Gr14_Contact <- Gr14[Gr14$Event == "Contact", ]
mean_nb <- mean(Gr14_Contact[Gr14_Contact$Genotype == "WT", "Amount"])
Gr14_Contact$Norm_amount <- c((Gr14_Contact$Amount[[1]]/mean_nb),
                              (Gr14_Contact$Amount[[2]]/mean_nb),
                              (Gr14_Contact$Amount[[3]]/mean_nb),
                              (Gr14_Contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Contact[Gr14_Contact$Genotype == "WT", "Total_time"])
Gr14_Contact$Norm_time <- c((Gr14_Contact$Total_time[[1]]/mean_time),
                            (Gr14_Contact$Total_time[[2]]/mean_time),
                            (Gr14_Contact$Total_time[[3]]/mean_time),
                            (Gr14_Contact$Total_time[[4]]/mean_time))

Gr14_Get_away <- Gr14[Gr14$Event == "Get_away", ]
mean_nb <- mean(Gr14_Get_away[Gr14_Get_away$Genotype == "WT", "Amount"])
Gr14_Get_away$Norm_amount <- c((Gr14_Get_away$Amount[[1]]/mean_nb),
                               (Gr14_Get_away$Amount[[2]]/mean_nb),
                               (Gr14_Get_away$Amount[[3]]/mean_nb),
                               (Gr14_Get_away$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Get_away[Gr14_Get_away$Genotype == "WT", "Total_time"])
Gr14_Get_away$Norm_time <- c((Gr14_Get_away$Total_time[[1]]/mean_time),
                             (Gr14_Get_away$Total_time[[2]]/mean_time),
                             (Gr14_Get_away$Total_time[[3]]/mean_time),
                             (Gr14_Get_away$Total_time[[4]]/mean_time))

Gr14_Break_contact <- Gr14[Gr14$Event == "Break_contact", ]
mean_nb <- mean(Gr14_Break_contact[Gr14_Break_contact$Genotype == "WT", "Amount"])
Gr14_Break_contact$Norm_amount <- c((Gr14_Break_contact$Amount[[1]]/mean_nb),
                                    (Gr14_Break_contact$Amount[[2]]/mean_nb),
                                    (Gr14_Break_contact$Amount[[3]]/mean_nb),
                                    (Gr14_Break_contact$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Break_contact[Gr14_Break_contact$Genotype == "WT", "Total_time"])
Gr14_Break_contact$Norm_time <- c((Gr14_Break_contact$Total_time[[1]]/mean_time),
                                  (Gr14_Break_contact$Total_time[[2]]/mean_time),
                                  (Gr14_Break_contact$Total_time[[3]]/mean_time),
                                  (Gr14_Break_contact$Total_time[[4]]/mean_time))

Gr14_Train2 <- Gr14[Gr14$Event == "Train2", ]
mean_nb <- mean(Gr14_Train2[Gr14_Train2$Genotype == "WT", "Amount"])
Gr14_Train2$Norm_amount <- c((Gr14_Train2$Amount[[1]]/mean_nb),
                             (Gr14_Train2$Amount[[2]]/mean_nb),
                             (Gr14_Train2$Amount[[3]]/mean_nb),
                             (Gr14_Train2$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Train2[Gr14_Train2$Genotype == "WT", "Total_time"])
Gr14_Train2$Norm_time <- c((Gr14_Train2$Total_time[[1]]/mean_time),
                           (Gr14_Train2$Total_time[[2]]/mean_time),
                           (Gr14_Train2$Total_time[[3]]/mean_time),
                           (Gr14_Train2$Total_time[[4]]/mean_time))

Gr14_Group3make <- Gr14[Gr14$Event == "Group3make", ]
mean_nb <- mean(Gr14_Group3make[Gr14_Group3make$Genotype == "WT", "Amount"])
Gr14_Group3make$Norm_amount <- c((Gr14_Group3make$Amount[[1]]/mean_nb),
                                 (Gr14_Group3make$Amount[[2]]/mean_nb),
                                 (Gr14_Group3make$Amount[[3]]/mean_nb),
                                 (Gr14_Group3make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Group3make[Gr14_Group3make$Genotype == "WT", "Total_time"])
Gr14_Group3make$Norm_time <- c((Gr14_Group3make$Total_time[[1]]/mean_time),
                               (Gr14_Group3make$Total_time[[2]]/mean_time),
                               (Gr14_Group3make$Total_time[[3]]/mean_time),
                               (Gr14_Group3make$Total_time[[4]]/mean_time))

Gr14_Group3break <- Gr14[Gr14$Event == "Group3break", ]
mean_nb <- mean(Gr14_Group3break[Gr14_Group3break$Genotype == "WT", "Amount"])
Gr14_Group3break$Norm_amount <- c((Gr14_Group3break$Amount[[1]]/mean_nb),
                                  (Gr14_Group3break$Amount[[2]]/mean_nb),
                                  (Gr14_Group3break$Amount[[3]]/mean_nb),
                                  (Gr14_Group3break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Group3break[Gr14_Group3break$Genotype == "WT", "Total_time"])
Gr14_Group3break$Norm_time <- c((Gr14_Group3break$Total_time[[1]]/mean_time),
                                (Gr14_Group3break$Total_time[[2]]/mean_time),
                                (Gr14_Group3break$Total_time[[3]]/mean_time),
                                (Gr14_Group3break$Total_time[[4]]/mean_time))

Gr14_Group4make <- Gr14[Gr14$Event == "Group4make", ]
mean_nb <- mean(Gr14_Group4make[Gr14_Group4make$Genotype == "WT", "Amount"])
Gr14_Group4make$Norm_amount <- c((Gr14_Group4make$Amount[[1]]/mean_nb),
                                 (Gr14_Group4make$Amount[[2]]/mean_nb),
                                 (Gr14_Group4make$Amount[[3]]/mean_nb),
                                 (Gr14_Group4make$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Group4make[Gr14_Group4make$Genotype == "WT", "Total_time"])
Gr14_Group4make$Norm_time <- c((Gr14_Group4make$Total_time[[1]]/mean_time),
                               (Gr14_Group4make$Total_time[[2]]/mean_time),
                               (Gr14_Group4make$Total_time[[3]]/mean_time),
                               (Gr14_Group4make$Total_time[[4]]/mean_time))

Gr14_Group4break <- Gr14[Gr14$Event == "Group4break", ]
mean_nb <- mean(Gr14_Group4break[Gr14_Group4break$Genotype == "WT", "Amount"])
Gr14_Group4break$Norm_amount <- c((Gr14_Group4break$Amount[[1]]/mean_nb),
                                  (Gr14_Group4break$Amount[[2]]/mean_nb),
                                  (Gr14_Group4break$Amount[[3]]/mean_nb),
                                  (Gr14_Group4break$Amount[[4]]/mean_nb))
mean_time <- mean(Gr14_Group4break[Gr14_Group4break$Genotype == "WT", "Total_time"])
Gr14_Group4break$Norm_time <- c((Gr14_Group4break$Total_time[[1]]/mean_time),
                                (Gr14_Group4break$Total_time[[2]]/mean_time),
                                (Gr14_Group4break$Total_time[[3]]/mean_time),
                                (Gr14_Group4break$Total_time[[4]]/mean_time))

Gr14_norm <- rbind(Gr14_Move_iso,Gr14_Stop_iso,Gr14_Rear_iso,Gr14_Huddling,
                   Gr14_WallJump,Gr14_SAP, Gr14_Move_contact,Gr14_Stop_contact,
                   Gr14_Rear_contact,Gr14_SbS_contact,Gr14_SbSO_contact,
                   Gr14_OO_contact,Gr14_OG_contact,Gr14_Social_approach,
                   Gr14_Approach_rear,Gr14_Contact,Gr14_Get_away,
                   Gr14_Break_contact,Gr14_Train2,Gr14_Group3make,
                   Gr14_Group3break,Gr14_Group4make,Gr14_Group4break)

rm(Gr14_Move_iso,Gr14_Stop_iso,Gr14_Rear_iso,Gr14_Huddling,
   Gr14_WallJump,Gr14_SAP, Gr14_Move_contact,Gr14_Stop_contact,
   Gr14_Rear_contact,Gr14_SbS_contact,Gr14_SbSO_contact,
   Gr14_OO_contact,Gr14_OG_contact,Gr14_Social_approach,
   Gr14_Approach_rear,Gr14_Contact,Gr14_Get_away,
   Gr14_Break_contact,Gr14_Train2,Gr14_Group3make,
   Gr14_Group3break,Gr14_Group4make,Gr14_Group4break)


####----------------------Combine all datasets into one----------------

Events_norm <- rbind(Gr1_norm,Gr2_norm,Gr3_norm,Gr4_norm,Gr5_norm,
                     Gr6_norm,Gr7_norm,Gr8_norm,Gr9_norm,Gr10_norm,
                     Gr11_norm,Gr12_norm,Gr13_norm,Gr14_norm)

rm(Gr1_norm,Gr2_norm,Gr3_norm,Gr4_norm,Gr5_norm,
   Gr6_norm,Gr7_norm,Gr8_norm,Gr9_norm,Gr10_norm,
   Gr11_norm,Gr12_norm,Gr13_norm,Gr14_norm)
rm(Gr1,Gr2,Gr3,Gr4,Gr5,
   Gr6,Gr7,Gr8,Gr9,Gr10,
   Gr11,Gr12,Gr13,Gr14)

####-----------------Create separate datasets for plotting---------------

Events_norm$Sex <- factor(Events_norm$Sex, levels = c("M","F"), ordered=T)
Events_norm$Genotype <- factor(Events_norm$Genotype, levels = c("WT","HET"), ordered=T)

Individual <- Events_norm[Events_norm$Event == "Move_isolated" |
                          Events_norm$Event == "Stop_isolated" |
                          Events_norm$Event == "Rear_isolated" |
                          Events_norm$Event == "Huddling" |
                          Events_norm$Event == "WallJump" |
                          Events_norm$Event == "SAP", ]
Individual$Event <- factor(Individual$Event,
                           levels = c("Move_isolated","Stop_isolated",
                                      "Rear_isolated","Huddling",
                                      "WallJump","SAP"), ordered=T)

Dyadic_static <- Events_norm[Events_norm$Event == "Move_contact" |
                            Events_norm$Event == "Stop_contact" |
                            Events_norm$Event == "Rear_contact" |
                            Events_norm$Event == "SbS_contact" |
                            Events_norm$Event == "SbSO_contact" |
                            Events_norm$Event == "OO_contact" |
                            Events_norm$Event == "OG_contact", ]
Dyadic_static$Event <- factor(Dyadic_static$Event,
                           levels = c("Move_contact","Stop_contact",
                                      "Rear_contact","SbS_contact",
                                      "SbSO_contact","OO_contact",
                                      "OG_contact"), ordered=T)

Dyadic_dynamic <- Events_norm[Events_norm$Event == "Social_approach" |
                               Events_norm$Event == "Approach_rear" |
                               Events_norm$Event == "Contact" |
                               Events_norm$Event == "Get_away" |
                               Events_norm$Event == "Break_contact" |
                               Events_norm$Event == "Train2", ]
Dyadic_dynamic$Event <- factor(Dyadic_dynamic$Event,
                              levels = c("Social_approach","Approach_rear",
                                         "Contact","Get_away",
                                         "Break_contact","Train2"),
                                         ordered=T)

Group <- Events_norm[Events_norm$Event == "Group3make" |
                    Events_norm$Event == "Group3break" |
                    Events_norm$Event == "Group4make" |
                    Events_norm$Event == "Group4break", ]
Group$Event <- factor(Group$Event,
                      levels = c("Group3make","Group3break",
                                 "Group4make","Group4break"),ordered=T)
                               
                                          
                               
                               
Individual_M <- Individual[Individual$Sex == "M", ]
Individual_F <- Individual[Individual$Sex == "F", ]
Dyadic_static_M <- Dyadic_static[Dyadic_static$Sex == "M", ]
Dyadic_static_F <- Dyadic_static[Dyadic_static$Sex == "F", ]
Dyadic_dynamic_M <- Dyadic_dynamic[Dyadic_dynamic$Sex == "M", ]
Dyadic_dynamic_F <- Dyadic_dynamic[Dyadic_dynamic$Sex == "F", ]
Group_M <- Group[Group$Sex == "M", ]
Group_F <- Group[Group$Sex == "F", ]


####----------------------Plotting-------------------------------------

ggplot(Individual, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Individual behavioural events pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Individual events pre-treatment.pdf") 

ggplot(Individual_M, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Individual behavioural events pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Individual events pre-treatment males.pdf")

ggplot(Individual_F, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Individual behavioural events pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Individual events pre-treatment females.pdf") 


ggplot(Dyadic_static, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic static behavioural events pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic static events pre-treatment.pdf") 

ggplot(Dyadic_static_M, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic static behavioural events pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic static events pre-treatment males.pdf")

ggplot(Dyadic_static_F, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic static behavioural events pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic static events pre-treatment females.pdf")

ggplot(Dyadic_dynamic, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic dynamic behavioural events pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic dynamic events pre-treatment.pdf") 

ggplot(Dyadic_dynamic_M, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic dynamic behavioural events pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic dynamic events pre-treatment males.pdf") 

ggplot(Dyadic_dynamic_F, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic dynamic behavioural events pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic dynamic events pre-treatment females.pdf") 

ggplot(Group, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Group behavioural events pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Group events pre-treatment.pdf") 

ggplot(Group_M, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Group behavioural events pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Group events pre-treatment males.pdf") 

ggplot(Group_F, aes(x=Event, y=Norm_amount, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Group behavioural events pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Group events pre-treatment females.pdf") 


#####--------------Plots event duration------------------------------

ggplot(Individual, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Individual behavioural events duration pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Individual events pre-treatment duration .pdf") 

ggplot(Individual_M, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Individual behavioural events duration pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Individual events pre-treatment duration males.pdf")

ggplot(Individual_F, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Individual behavioural events duration pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Individual events pre-treatment duration females.pdf") 


ggplot(Dyadic_static, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic static behavioural events duration pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic static events pre-treatment duration.pdf") 

ggplot(Dyadic_static_M, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic static behavioural events duration pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic static events pre-treatment duration males.pdf")

ggplot(Dyadic_static_F, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic static behavioural events duration pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic static events pre-treatment duration females.pdf")

ggplot(Dyadic_dynamic, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic dynamic behavioural events duration pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic dynamic events pre-treatment duration.pdf") 

ggplot(Dyadic_dynamic_M, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic dynamic behavioural events duration pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic dynamic events pre-treatment duration males.pdf") 

ggplot(Dyadic_dynamic_F, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Dyadic dynamic behavioural events duration pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Dyadic dynamic events pre-treatment duration females.pdf") 

ggplot(Group, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Group behavioural events duration pre-treatment") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Group events pre-treatment duration.pdf") 

ggplot(Group_M, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Group behavioural events duration pre-treatment males") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Group events pre-treatment duration males.pdf") 

ggplot(Group_F, aes(x=Event, y=Norm_time, col=Genotype)) +
  geom_boxplot() +
  scale_color_manual(values=c("black", "firebrick3")) +
  ggtitle("Group behavioural events duration pre-treatment females") +
  xlab("Event type") +
  ylab("Individual value/mean value WT") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(aspect.ratio = 1/3) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("Group events pre-treatment duration females.pdf")