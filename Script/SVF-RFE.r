library(e1071)
library(kernlab)
library(caret)

set.seed(111)
inputFile="input.txt"

data=read.table(inputFile, header=T, sep="\t", check.names=F, row.names=1)
data=t(data)
group=gsub("(.*)\\_(.*)", "\\2", row.names(data))


Profile=rfe(x=data,
            y=as.numeric(as.factor(group)),
            sizes = c(1,2,3,4,5,6,7,8,9,seq(10,40,by=2)),
            rfeControl = rfeControl(functions = caretFuncs, method = "cv"),
            methods="svmRadial")
pdf(file="SVM-RFE.pdf", width=8, height=8)
par(las=1)
x = Profile$results$Variables
y = Profile$results$RMSE
plot(x, y, xlab="Variables", ylab="RMSE (Cross-Validation)", col="darkgreen")
lines(x, y, col="darkgreen")
wmin=which.min(y)
wmin.x=x[wmin]
wmin.y=y[wmin]
points(wmin.x, wmin.y, col="blue", pch=16)
text(wmin.x, wmin.y, paste0('N=',wmin.x), pos=1,  col=1)
dev.off()

featureGenes=Profile$optVariables
write.csv(file="SVM-RFE.gene.csv", featureGenes,  row.names=F)

