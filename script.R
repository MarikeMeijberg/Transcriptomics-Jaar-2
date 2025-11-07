setwd("C:/Users/meijb/OneDrive/Documenten/Marike R/Casus Transcriptomics/")
getwd()

unzip("Data_casus.zip", exdir = "reuma_data") 

install.packages('BiocManager')
library(BiocManager)

BiocManager::install('Rsubread')
library(Rsubread)

setwd("C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/")

buildindex(
  basename = 'ref_human',
  reference = 'Homo_sapiens.GRCh38.dna.toplevel.fa.gz',
  memory = 10000,
  indexSplit = TRUE)
getwd()

align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785819_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785819_2_subset40k.fastq", output_file = "normaal1.BAM")
align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785820_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785820_2_subset40k.fastq", output_file = "normaal2.BAM")
align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785828_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785828_2_subset40k.fastq", output_file = "normaal3.BAM")
align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785831_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785831_2_subset40k.fastq", output_file = "normaal4.BAM")
align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785979_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785979_2_subset40k.fastq", output_file = "Reuma1.BAM")
align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785980_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785980_2_subset40k.fastq", output_file = "Reuma2.BAM")
align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785986_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785986_2_subset40k.fastq", output_file = "Reuma3.BAM")
align.human <- align(index = "C:/Users/meijb/OneDrive/Documenten/Marike R/Genooms/ref_human", readfile1 = "reuma_data/Data_RA_raw/SRR4785988_1_subset40k.fastq", readfile2 = "reuma_data/Data_RA_raw/SRR4785988_2_subset40k.fastq", output_file = "Reuma4.BAM")

BiocManager::install("readr")
BiocManager::install("dplyr")
BiocManager::install("Rsamtools")

library(readr)
library(dplyr)
library(Rsamtools)
library(Rsubread)

# Inlezen en filteren van GFF3-bestand
gff <- read_tsv("reuma_data/Homo_sapiens.GRCh38.110.gtf.gz", comment = "#", col_names = FALSE)

# Kolomnamen toevoegen
colnames(gff) <- c("seqid", "source", "type", "start", "end", "score", "strand", "phase", "attributes")

# Alleen genregels selecteren
gff_gene <- gff %>% filter(type == "gene")

# 'type' aanpassen naar 'exon' zodat featureCounts het accepteert
gff_gene$type <- "exon"

# Extraheer de chromosoomnaam uit BAM-header
bam_chr <- names(scanBamHeader("eth1.BAM")[[1]]$targets)[1]
gff_gene$seqid <- bam_chr

samtools quickcheck -v normaal1.BAM


# Je definieert een vector met namen van BAM-bestanden. Elke BAM bevat reads van een RNA-seq-experiment (bijv. behandeld vs. controle).

allsamples <- c("normaal1.BAM", "normaal2.BAM", "normaal3.BAM", "normaal4.BAM", "Reuma1.BAM", "Reuma2.BAM", "Reuma3.BAM", "Reuma4.BAM")

count_matrix <- featureCounts(
  files = allsamples,
  annot.ext = "reuma_data/Homo_sapiens.GRCh38.110.gtf.gz",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE)

head(count_matrix$annotation)
head(count_matrix$counts)

# Bekijk eerst de structuur van het object
str(count_matrix)

# Haal alleen de matrix met tellingen eruit
counts <- count_matrix$counts



colnames(counts) <- c("GeneID", "Controle_1", "Controle_2", "Controle_3", "Controle_4", "Rheuma_1", "Rheuma_2", "Rheuma_3", "Rheuma_4")
rownames(counts) <- counts[, 1]

write.csv(counts, "bewerkt_countmatrix.csv")

head(counts)

countsgroot <- read.table("count_matrix.txt", row.names = 1)

head(countsgroot)

groepering <- c("Normaal", "Normaal", "Normaal", "Normaal", "Rheuma", "Rheuma", "Rheuma", "Rheuma")
treatment_table <- data.frame(groepering)
rownames(treatment_table) <- c('SRR4785819', 'SRR4785820', 'SRR4785828', 'SRR4785831', 'SRR4785979', 'SRR4785980', 'SRR4785986', 'SRR4785988')

BiocManager::install('DESeq2')
BiocManager::install('KEGGREST')

library(DESeq2)
library(KEGGREST)

countsgroot <- round(countsgroot)

# Maak DESeqDataSet aan
dds <- DESeqDataSetFromMatrix(countData = countsgroot,
                              colData = treatment_table,
                              design = ~ groepering)

# Voer analyse uit
dds <- DESeq(dds)
resultaten <- results(dds)

# Resultaten opslaan in een bestand
#Bij het opslaan van je tabel kan je opnieuw je pad instellen met `setwd()` of het gehele pad waar je de tabel wilt opslaan opgeven in de code.

write.table(resultaten, file = 'ResultatenCasus.csv', row.names = TRUE, col.names = TRUE)

read.csv("ResultatenCasus.csv")

resultaten <- read.csv("ResultatenCasus.csv")

sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]

head(laagste_p_waarde)

if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) {
  BiocManager::install("EnhancedVolcano")
}
library(EnhancedVolcano)

EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj')

# Alternatieve plot zonder p-waarde cutoff (alle genen zichtbaar)
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0)


dev.copy(png, 'VolcanoplotWC.png', 
         width = 8,
         height = 10,
         units = 'in',
         res = 500)
dev.off()


BiocManager::install("goseq", force = TRUE)
BiocManager::install("org.Hs.eg.db", force = TRUE)  # b, menselijke annotatie
BiocManager::install("geneLenDataBase", force = TRUE)  # lengte-informatie
BiocManager::install("BiocParallel", force = TRUE)  # lengte-informatie
BiocManager::install("GO.db", force = TRUE)


library(geneLenDat)
library(goseq)
library(org.Dm.eg.db)
library(g)
library(BiocParallel)



head(resultaten)

ALL <- rownames(resultaten)
DEG <- resultaten %>%
  filter(padj < 0.05)
DEG <- rownames(DEG)

DEG

gene.vector <- as.integer(ALL %in% DEG)
names(gene.vector) <- ALL

pwf <- nullp(gene.vector, "hg19", "geneSymbol")  # of "ensGene" als je Ensembl gebruikt

GO.wall <- goseq(pwf, "hg19", "geneSymbol")
# of "ensGene" afhankelijk van je gen-ID's

enriched.GO <- GO.wall$category[GO.wall$over_represented_pvalue < 0.05]
length(enriched.GO)

enriched.GO.fdr <- GO.wall$category[p.adjust(GO.wall$over_represented_pvalue, method = "BH") < 0.05]

library(ggplot2)
library(dplyr)
library(GO.db)

GO.wall$FDR <- p.adjust(GO.wall$over_represented_pvalue, method = "BH")
top_GO <- GO.wall[GO.wall$FDR < 0.05, ]  # of kies top N:
top_GO <- top_GO[order(top_GO$FDR), ][1:20, ]
library(GO.db)

top_GO$Term <- sapply(top_GO$category, function(go_id) {
  term <- tryCatch(Term(GOTERM[[go_id]]), error = function(e) NA)
  ifelse(is.na(term), go_id, term)
})

library(ggplot2)

ggplot(top_GO, aes(x = reorder(Term, -log10(FDR)), y = -log10(FDR))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top verrijkte GO-termen (FDR < 0.05)",
       x = "GO-term",
       y = expression(-log[10](FDR))) +
  theme_minimal(base_size = 13)

if (!requireNamespace("pathview", quietly = TRUE)) {
  BiocManager::install("pathview")
}
library(pathview)

if (!requireNamespace("KEGGREST", quietly = TRUE)) {
  BiocManager::install("KEGGREST")
}
library(KEGGREST)

resultaten[1] <- NULL
resultaten[2:5] <- NULL

pathview(
  gene.data = resultaten,
  pathway.id = "hsa05323",  # KEGG ID voor Biofilm formation b