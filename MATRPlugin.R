  library(DEGseq)


dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {
  print("HH")
  geneExpFile <- paste(pfix, parameters["geneexp", 2], sep="/")
  val1 <- as.integer(readLines(paste(pfix, parameters["val1", 2], sep="/")))
  val2 <- as.integer(readLines(paste(pfix, parameters["val2", 2], sep="/")))
  print(val1)
  print(val2)
  group1 <- parameters["grp1", 2]
  group2 <- parameters["grp2", 2]
  replicate1 <- parameters["rep1", 2]
  replicate2 <- parameters["rep2", 2]
  geneExpMatrix1 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=val1)
  geneExpMatrix2 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=val2)
  layout(matrix(c(1,2,3,4,5,6), 3, 2, byrow=TRUE))
  par(mar=c(2, 2, 2, 2))
  print("HI")
  DEGexp(geneExpMatrix1=geneExpMatrix1, expCol1=2, groupLabel1=group1,
       geneExpMatrix2=geneExpMatrix2, expCol2=2, groupLabel2=group2,
       replicateExpMatrix1=geneExpMatrix1, expColR1=3, replicateLabel1=replicate1,
       replicateExpMatrix2=geneExpMatrix1, expColR2=4, replicateLabel2=replicate2,
       method="MATR", outputDir=outputfile)

  #geneExpFile <- system.file("extdata", "GeneExpExample5000.txt", package="DEGseq")
  #geneExpMatrix1 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=c(7,9,12,15,18))
  #geneExpMatrix2 <- readGeneExp(file=geneExpFile, geneCol=1, valCol=c(8,10,11,13,16))
  #layout(matrix(c(1,2,3,4,5,6), 3, 2, byrow=TRUE))
  #par(mar=c(2, 2, 2, 2))
  #DEGexp(geneExpMatrix1=geneExpMatrix1, geneCol1=1, expCol1=c(2,3,4,5,6), groupLabel1="kidney",
  #     geneExpMatrix2=geneExpMatrix2, geneCol2=1, expCol2=c(2,3,4,5,6), groupLabel2="liver",
  #     method="MARS")
}
