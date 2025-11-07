# Transcriptomics-Jaar-2
 
Welkom bij mijn Github-pagina Dewi ;)

Marike Meijberg
LBM2A - J2P4 - Transcriptomics


# Transcriptomics 

> `I will not have you in my class if you continue to be a babbling, bumbling band of baboons who can't even SORT their data!`

## 📁 Inhoud/structuur

- `Introductie` – Korte introductie en achtergrond informatie.  
- `Methode` - Methode gebruikt voor analyses. 
- `Scripts` – Scripts voor extra uitleg over de gebruikte analyses en methodes. 
- `Resultaten` - Volcanoplot, go-analyse en KEGG analyse.
- `Bronnen` - Gebruikte bronnen.
- `README.md` - Het document om de tekst hier te genereren.


---

## 🧠 Introductie

Reuma

## 🧬 Methoden
Voor deze transcriptomics-analyse werd gebruikgemaakt van RNA-sequencingdata van acht personen: vier met reumatoïde artritis (RA) en vier zonder RA. De [ruwe sequencingbestanden](Ruwe%20data/)
 (FASTQ) werden uitgepakt en ingelezen in R. Vervolgens werd het [humane referentiegenoom](Referentie%20genoom) geïndexeerd met het pakket Rsubread, waarna de reads van de samples werden uitgelijnd met de functie align(). De gegenereerde [BAM-bestanden](BAM%20files) zijn gebruikt voor analyse.
Met featureCounts werd er een countmatrix gemaakt, waarbij een aangepaste GTF-annotatie werd gebruikt om alleen op exons te tellen. Vervolgens is er een [volledige count-matrix](Count%20matrix) gebruikt voor verder onderzoek.
De verschillen in genexpressie tussen RA en controle werden bepaald met het pakket DESeq2. De resultaten werden geëxporteerd naar een CSV-bestand en gevisualiseerd met behulp van EnhancedVolcano.
Vervolgens werd met een R-pakket (goseq) onderzocht welke biologische processen verhoogt voorkwamen in genen die anders tot expressie kwamen bij RA. Deze processen (Go-termen) kunnen betrokken zijn bij de ziekte en werden gevisualiseerd met behulp van ggplots2. Daarna is er een KEGG-analyse om dieper in te gaan op de biochemische pathways, die zijn gevisualiseerd met behulp van pathview. Het onderzoek is vastgelegd volgend de principes van data stewardship, met duidelijke mappen structuur en reproduceerbaarheid. 

📄 **[Klik hier voor het volledige script](script.R)**  

[![Klik hier voor het volledige script](https://img.shields.io/badge/script-pink?style=flat&logo=R&logoColor=white)](script.R)


## 📊 Resultaten

### 🌋 Volcanoplot van genexpressie (EnhancedVolcano)
In figuur 1 is een volcanoplot zichtbaar van 29.407 genen zichtbaar. Er is zichtbaar dat er veel genen zijn rond de log2-fold = 0, die niet significant verschillen. De groene stippen zijn de genen die significant verschillen van expressie. 

<img src="Resultaten/Volcanoplot.png" width ="250" height ="350">
Figuur 1: Volcanoplot toont de log2-fold change (x-as) tegen de -log10 p-waarde (y-as) voor alle gemeten genen (totaal: 29.407)

**[Afbeelding vergroten 🔍](Resultaten/Volcanoplot.png)**


### 📊 GO-analyse
In figuur 2 is duidelijk zichtbaar de gen expressie in processen zoals bijvoorbeeld, het immuun-respons significant veranderd zijn. 

<img src="Resultaten/Go-analyse.pdf" width ="500" height ="350">
Figuur 2: Barplot Go-analyse, toont aan bij welke processen meeste verandering in gen expressie is waargenomen. 

**[Afbeelding vergroten 🔍](Resultaten/Go-anlyse.pdf)**


### 🧬 Pathway-analyse KEGG Rheumatoïde Artritis
In figuur 3 zijn ovallende bevindingen waargenomen, waaronder de genen **IL6, IL1β en MMP13** die verhoogd tot expressie komen. Deze genen zijn betrokken bij ontsteking, kraakbeenschade en gewrichtsvernietiging. Ook zijn er genen zoals, **TGFβ**, (betrokken bij immuunonderdrukking en weefselherstel) en **IL23** (stimuleert ontstekingsbevorderende T-cellen), die juist onderdukt worden.

<img src="Resultaten/hsa05323 pathview results.png" width ="500" height ="350">
Figuur 3: KEGG pathview afbeelding, geeft duidelijk verhoogd (Rood) en verlaagde (Groen) activiteit van ontstekingsgenen weer.

**[Afbeelding vergroten 🔍](Resultaten/hsa05323%20pathview%20results.png)**


## ⚡Conclusie
De resultaten tonen aan dat er een verandering in genexpressie is bij patiënten RA. Dit is bevestigd in de volcanoplot, die aangaf dat er een veel significant verschillende genen zijn bij RA patiënten. In de Go-analyse is aangetoond dat veel genen die significant verschillen betrokken zijn bij het immuunrespons. Dit is verder bevestigd door de KEGG pathways waar genen **IL6, IL1β en MMP13** verhoogd tot expressie kwamen. Deze genen zijn betrokken bij ontsteking, kraakbeenschade en gewrichtsvernietiging. Ook waren er genen zoals, **TGFβ**, (betrokken bij immuunonderdrukking en weefselherstel) en **IL23** (stimuleert ontstekingsbevorderende T-cellen), die juist onderdukt werden. Dit gaf aan dat er bij mensen met RA een verstoring plaats vond in ontstekingregulatie.

In dit onderzoek is dus aangetoond dat transcriptomics een handige tool is in het begrijpen van de ziekte RA. Daarom word aanbevolen meer onderzoek te doen met grotere groepen en bijvoorbeeld verschillende statia RA, om hopelijk meer mogelijke biomarkers te ontdekken.
