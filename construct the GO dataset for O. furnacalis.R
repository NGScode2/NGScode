#########################Constructing a GO database for Asian corn borer##########

setwd("D:\\ofu\\orgdb\\database\\ofu")
library(openxlsx)
library(clusterProfiler)
library(dplyr)
library(stringr)
library(AnnotationForge)
options(stringsAsFactors = F)

BiocManager::install("AnnotationForge")

#########Reading protein annotation files (For detailed information on the construction method, please refer to the "Materials and Methods" section.)#########

egg_ofu  <-  "ofu.GO.xlsx"
egg  <-  read.xlsx(egg_ofu, sep = "\t")
head(egg)
egg[egg==""]<-NA

#########Extracting protein names (Query) and egg annotation information (seed_ortholog)#########
gene_info <- egg %>% dplyr::select(GID = query, EGGannot = seed_ortholog, SYMBOL=Gene_Symbol, ENTREZID=ENTREZ_ID) %>% na.omit()

#########Extracting protein names (Query) and GO annotation information (GO_terms)#########
gterms <- egg %>% dplyr::select(GID = query,GO_terms = GO_terms) %>% na.omit()
gene2go <- data.frame(GID = character(),
                      GO = character(),
                      EVIDENCE = character())
for (row in 1:nrow(gterms)) {
  gene_terms <- str_split(gterms[row,"GO_terms"], ",", simplify = FALSE)[[1]]  
  gene_id <- gterms[row, "GID"][[1]]
  tmp <- data.frame(GID = rep(gene_id, length(gene_terms)),
                    GO = gene_terms,
                    EVIDENCE = rep("IEA", length(gene_terms)))
  gene2go <- rbind(gene2go, tmp)} 

#########Building a database for storage#########
genus = "Ostrinia furnacalis"
species = "ofu"
makeOrgPackage(gene_info=gene_info,go=gene2go,
               version="0.1",
               maintainer = 'Ofu_maker',
               author = 'Ofu_maker',
               outputDir = "i:\\ofu\\orgdb\\ofu\\",
               tax_id = "93504",
               genus = genus,
               species = species,
               goTable="go")
org.Oofu <- str_c("org.", str_to_upper(str_sub(genus, 1, 1)) , species, ".eg.db", sep = "")



