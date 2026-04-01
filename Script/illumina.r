library(limma)
data <- read.ilmn("GSE60438_non_normalized_WG6v3_GPL6884.txt",probeid="ID_REF",other.columns="Detection Pval")
data1 <- neqc(data,detection.p="Detection Pval") 
exp1 <- data1$E
write.csv(exp1,"GSE60438_control_normalized.csv")
