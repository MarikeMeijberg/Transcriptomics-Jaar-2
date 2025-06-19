# Transcriptomics-Jaar-2
 
setwd("C:/Users/meijb/OneDrive/Documenten/Marike R/Casus Transcriptomics/")

<p align="center">
  <img src="assets/Logo_SpellMetrics.png" alt="Wizarding Spell Metrics Logo" width="600"/>
</p>


# 🧙‍♂️ Wizarding Spell Metrics

Welkom in **Wizarding Spell Metrics**, waar de data nep is, maar de structuur *verrassend oké* is. Deze repo is gemaakt om te laten zie hoe je een bio-informatica project structureert in GitHub met behulp van een onzin dataset. files mogen gedownload en hergebruikt worden (zoals [deze README.md file](README.md)). Vraag ook gerust AI voor tips!

Perfect voor:
- Wegwijs worden in GitHub
- Het leren structureren van data

> `I will not have you in my class if you continue to be a babbling, bumbling band of baboons who can't even SORT their data!`

## 📁 Inhoud/structuur

- `data/raw/` – fictionele datasets voor de analyse van spreuk effectiviteit, gevaar en welke spreuken het beste samengaan met verschillende types staf.  
- `data/processed` - verwerkte datasets gegenereerd met scripts 
- `scripts/` – scripts om prachtige onzin te genereren
- `resultaten/` - grafieken en tabellen
- `bronnen/` - gebruikte bronnen 
- `README.md` - het document om de tekst hier te genereren
- `assets/` - overige documenten voor de opmaak van deze pagina
- `data_stewardship/` - Voor de competentie beheren ga je aantonen dat je projectgegevens kunt beheren met behulp van GitHub. In deze folder kan je hulpvragen terugvinden om je op gang te helpen met de uitleg van data stewardship. 

---

## Introductie

Deze GitHub pagina staat in het teken van magische spreuken en hun eigenschappen (Harry Potter⚡). Met behulp van historische registergegevens kan de **kracht**, **nauwkeurigheid** en het **risiconiveau** geanalyseerd worden. Voor een goede tovenaar is het van belang dat de gebruikte spreuken effectief en veilig zijn om te gebruiken. Daarnaast is het van belang voor elke tovenaar om rekening te houden met de compatibiliteit van het type toverstok dat gebruikt wordt om de geschiktheid van spreukgebruik af te stemmen.  

Heb je Harry Potter nooit gelezen? Moet je echt doen, [klik maar hier](bronnen/harry-potter.pdf).

## Methoden
Voor deze transcriptomics-analyse werd gebruikgemaakt van RNA-sequencingdata van acht personen: vier met reumatoïde artritis (RA) en vier zonder RA. De ruwe sequencingbestanden (FASTQ) werden uitgepakt en ingelezen in R. Vervolgens werd het humane referentiegenoom geïndexeerd met het pakket Rsubread, waarna de reads van de samples werden uitgelijnd met de functie align(). De gegenereerde BAM-bestanden zijn gebruikt voor analyse.
Met featureCounts werd er een countmatrix gemaakt, waarbij een aangepaste GTF-annotatie werd gebruikt om alleen op exons te tellen. Vervolgens is er een volledige count-matrix gebruikt voor verder onderzoek.
De verschillen in genexpressie tussen RA en controle werden bepaald met het pakket DESeq2. De resultaten werden geëxporteerd naar een CSV-bestand en gevisualiseerd met behulp van EnhancedVolcano.
Vervolgens werd met een R-pakket (goseq) onderzocht welke biologische processen verhoogt voorkwamen in genen die anders tot expressie kwamen bij RA. Deze processen (Go-termen) kunnen betrokken zijn bij de ziekte en werden gevisualiseerd met behulp van ggplots2. Daarna is er een KEGG-analyse om dieper in te gaan op de biochemische pathways, die zijn gevisualiseerd met behulp van pathview. Het onderzoek is vastgelegd volgend de principes van data stewardship, met duidelijke mappen structuur en reproduceerbaarheid. 

📄 **[Klik hier voor het volledige script](script.R)**  


<a href="script.R" style="color:pink;">Klik hier voor het volledige script</a>


## 📊 Resultaten

Om inzicht te krijgen in eigenschappen van de te gebruiken spreuken is er een overzicht gemaakt, te vinden in [deze tabel](resultaten/top_10_spells.csv). Onvergeeflijke vloeken zijn niet meegenomen in dit overzicht. 

Om een afweging te maken welke spreuken het meest effectief zijn, is er onderzocht of er een verband te vinden is tussen kracht en accuraatheid. In [het resultaat hiervan](resultaten/spell_power_vs_accuracy.png) is te zien dat er een negatieve daling lijkt te zijn in kracht als de accuraatheid toeneemt. Een uitschieter is de onvergeeflijke vloek *Avada Kedavra*, met zowel hoge kracht als accuraatheid. 

## Conclusie

Spreuken met meer accuraatheid lijken minder krachtig te zijn. Een uitzondering op deze trend is de onvergeeflijke vloek *Avada Kedavra*, welke beter niet gebruikt kan worden. 