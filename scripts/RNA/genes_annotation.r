#setwd("/home/alex3/Спец/Старение/Раасчёты с Глебом/")
setwd("D:/data")

ds<-read.csv("merged_data_annotation_full.csv")
# 
table(ds$sex)
# 
table(ds$GSE)
# 
table(is.na(ds$sex))
# 
ds_nosex<-ds[is.na(ds$sex),]
table(ds_nosex$GSE)
# 
# 
ds2<-ds[ds$GSE=="GSE56047",]
plot(density(ds2$age))
# 
ds3<-ds[ds$GSE=="GSE56033",]
plot(density(ds3$age))
# 
# 
# # с презентации
# -GSE65907
# -GSE53165
# 
# +GSE75511
# +GSE30483
# +GSE47353
# +GSE68759


y_genes<-read.csv("y-genes.html.csv",sep="\t")

y_genes<-sort(unique(y_genes$Symbol))

gene<-y_genes[1]

## GSE16717 

#d1<-read.csv("GSE16717_annotated.csv")
d1<-read.csv("GSE56047_annotated.csv")


genes<-d1$ID_REF

genes<-genes[!is.na(genes)]



#table(genes=gene)

genes2<-c()

for (g in y_genes)
{
  if ((g %in% d1$ID_REF)) 
   {
      cat(g,(g %in% d1$ID_REF),"\n")
      genes2<-c(genes2,g)
  }
}


#  gene<-y_genes[2]
#  (gene %in% d1$ID_REF)

genes2<-c(genes2,"SRY")
genes2<-c(genes2,"PRY")




pdf("ygenes.pdf")
id_1<-"TXLNGY−1"
id_2<-"RBMY1A3P−1"
#RBMY2EP − 1

id_3<-"RBMY2EP−1"
id_4<-"SRY−1"



lst<-list()
for (gene in genes2)
{
    
    #gene<-"TXLNGY"
    
    #gene<-"SRY"
    
    id<-(d1$ID_REF==gene)
    
    
    table(id)
    
    id2<-id
    id2[is.na(id2)]<-F
    #table(id2)
    
    v<-d1[id2,]
    
    #if (nrow(v)>1) v<-v[1,]
    
    for (j in 1:nrow(v))
    {
        
        id_<-paste0(gene,"−",j)
        v2<-v[j,]
        
        
        v2$ID_REF<-NULL
        v2<-as.numeric(v2)
        
        if (id_ %in% c(id_1,id_2,id_3,id_4))  
        {
          cat(id_) 
          lst[[id_]]<-v2
        }
        cat("=")
        
        plot(density(v2,na.rm = T),main=paste0(gene," - ",j))
    }
}
dev.off()

df_tst<-as.data.frame(lst)

#plot(df_tst)

# Compute k-means with k = 4
set.seed(123)
n<-4
km.res <- kmeans(scale(df_tst), n)#, nstart = 25)

cl<-km.res$cluster
table(cl)

col<-rainbow(n)

names(col)<-1:n

col_<-col[cl]

#plot(df_tst[,c(1,2)],col=col_)
#plot(df_tst[,c(2,4)],col=col_)
plot(df_tst[,c(3,4)],col=col_)

names(df_tst)



gene<-"TXLNGY"
j<-1

id_<-paste0(gene,"−",j)
v2<-v[j,]


v2$ID_REF<-NULL
v2<-as.numeric(v2)
# 
# if (id_ %in% c(id_1,id_2)) 
# {
#   cat(id_) 
#   lst[[id_]]<-v2
# }
# cat("=")

plot(density(v2,na.rm = T),main=paste0(gene," - ",j))
x1<-8.58
x2<-5.26
x_m<-(x1+x2)/2
abline(v=c(x1,x2,x_m))

plot(df_tst,col=cols2)
abline(h=x_m)

#RBMY2EP − 1


#install.packages("GEOquery")

use_bin<-T
if (use_bin) load("ras.bin") else {
    #BiocManager::install("GEOquery")
    library(GEOquery)
    
    gpl <- getGEO('GSE56047', destdir=".")
    
    gse<-gpl
    
    racegendersite<-gse$`GSE56047-GPL10558_series_matrix.txt.gz`$characteristics_ch1.3
    gsms<-gse$`GSE56047-GPL10558_series_matrix.txt.gz`$geo_accession
    
    library(stringr)
    ras<-str_sub(racegendersite, 17)
    ras<-as.numeric(ras)
    save(ras,file = "ras.bin")
}
table(ras)

col2<-rainbow(18)
names(col2)<-1:18

cols2<-col2[ras]

use<-c(4,7,8,15,18)

cols2[!(as.numeric(names(cols2)) %in% use)]<-NA
plot(df_tst[,c(3,4)],col=cols2)

abline(v = mean(df_tst[, 4], na.rm = TRUE), col = "red")


data_table <- data.frame(X = df_tst[, 3], Y = df_tst[, 4], Color = cols2)
clean_data_table <- na.omit(data_table)


unique_colors <- unique(data_table$Color)

for (color in unique_colors) {
  subset_data <- data_table[data_table$Color == color, ]
  plot(subset_data$X, subset_data$Y, col = color, main = paste("Points with color", color), asp = 1)
}

# Фильтрация строк с отсутствующими значениями Color
clean_data_table <- na.omit(data_table)

sample_1_colors <- c("#FFFF00", "#AA00FF")
sample_2_colors <- c("#00FF55", "#FF0055", "#00FF00")

sample_1 <- clean_data_table[clean_data_table$Color %in% sample_1_colors, ]
sample_2 <- clean_data_table[clean_data_table$Color %in% sample_2_colors, ]

Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

mode_X_sample_1 <- Mode(sample_1$X)
mode_X_sample_2 <- Mode(sample_2$X)
print(paste("Среднее модальное значение по X для 1 выборки:", mode_X_sample_1))
print(paste("Среднее модальное значение по X для 2 выборки:", mode_X_sample_2))

mean_mode_X <- mean(c(mode_X_sample_1, mode_X_sample_2))
print(paste("Среднее модальное значение по X для обеих выборок:", mean_mode_X))


unique_ras <- unique(ras)
num_colors <- length(unique_ras)
palette <- rainbow(num_colors)

for (i in 1:length(unique_ras)) {
  subset_df <- df_tst[ras == unique_ras[i], ]
  cols_subset <- palette[i]
  plot(subset_df[, c(3, 4)], col = cols_subset, main = paste("racegendersite =", unique_ras[i]))
}

pdf("plots.pdf") # Открываем PDF-файл для сохранения графиков

par(mfrow = c(6, 3), mar = c(3, 3, 1, 1)) # Устанавливаем параметры маргинов и сетки

unique_ras <- unique(ras)
num_colors <- length(unique_ras)
palette <- rainbow(num_colors)

mean_mode_X <- 7.225
mode_X_sample_1 <- 5.97
mode_X_sample_2 <- 8.479


for (i in 1:length(unique_ras)) {
  subset_df <- df_tst[ras == unique_ras[i], ]
  cols_subset <- palette[i]
  plot(subset_df[, c(3, 4)], col = cols_subset, main = paste("racegendersite =", unique_ras[i]), xlim = c(0, 10), ylim = c(4, 6))
  abline(v = mean_mode_X, col = "blue", lwd = 2)
  abline(v = mode_X_sample_1, col = "red", lty = 2)
  abline(v = mode_X_sample_2, col = "green", lty = 3)
}

par(mfrow = c(1, 1)) # Возвращаемся к одному графику на странице (по умолчанию)

dev.off()



pdf("plots.pdf") # Открываем PDF-файл для сохранения графиков

par(mfrow = c(6, 3), mar = c(3, 3, 1, 1)) # Устанавливаем параметры маргинов и сетки

unique_ras <- unique(ras)
num_colors <- length(unique_ras)
palette <- rainbow(num_colors)

for (i in 1:length(unique_ras)) {
  subset_df <- df_tst[ras == unique_ras[i], ]
  cols_subset <- palette[i]
  plot(subset_df[, c(3, 4)], col = cols_subset, main = paste("racegendersite =", unique_ras[i]))
}

par(mfrow = c(1, 1)) # Возвращаемся к одному графику на странице (по умолчанию)

dev.off() # Закрываем PDF-файл
# 
#tail(gsms)
# 
#tail(colnames(d1))
# 
#annotation_data <- Table(gpl)
# 
# 
# 
# if (is.null(annotation_data)) {
#   stop("Failed to load annotation data. Please check the platform ID and try again.")
# }
# 
# id_to_symbol <- setNames(annotation_data$GB_LIST, annotation_data$ID)
# 
# df <- read.csv("GSE113957.csv")
# 
# df$ID_REF <- id_to_symbol[as.character(df$X.ID_REF)]
# 
# write.csv(df, "annotated_GSE113957.csv", row.names = FALSE)

