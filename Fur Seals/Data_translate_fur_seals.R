#########################################################################
##1. Reads in the fur seal data provided by Clive McMahon.
##2. Removes non-branded indivudals
##3. Produces 2 data sets for JSTL analysis: one that is standard and one that produces recycled individuals.
############################################################################
ntag=2;

setwd("/Users/lcowen/Documents/Fur Seals")

data.inp=read.table(file="Tagloss_Survival_nohead_onlyB.txt", colClasses="character")

ngroup= dim(data.inp)[2]-2;#number of groups in model
group
count<- as.numeric(unlist(data.inp$V2));
count
nsample= nchar(data.inp$V2[1]); #number of sample times used in experiment
nsample

history <- matrix(as.numeric(unlist(strsplit(rep(data.inp$V2,times=1), ""))),ncol=nchar(data.inp$V2[1]), byrow=TRUE)  ##the capture history for each individual

nobs_total= length(history[,1]);#number of animals observed in experiment
nobs_total
                   
                   
tag_stat<- matrix(as.character(unlist(strsplit(data.inp$V3, ""))),ncol=nchar(data.inp$V3[1]), byrow=TRUE)  ##the tag status for each individual

tag_hist<-matrix(rep(0,nsample*2*nobs_total), ncol=nsample*2)

# Set the Tag A to have the same history as the capture history
for(i in 1:nobs_total){
  index=1
  for(j in 1:nsample){
     tag_hist[i,index]<-history[i,j]
     index=index+2
  }
}

# Set the Tag B to have a 1 if 2 tags were seen in the tag_stat matrix
for(i in 1:nobs_total){
  index=1
  for(j in 1:nsample){
    ifelse(tag_stat[i,j]=="2", tag_hist[i,index+1]<-1,tag_hist[i,index+1]<-0) 
    index=index+2
  }
}
tag_hist[182,]
