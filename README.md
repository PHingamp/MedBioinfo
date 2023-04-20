# MedBioinfo 2023 Applied Bioinformatics
## repo for re-analysis

### Data source

Data is from Daniel Castañeda-Mogollón et al. Dec 2021 https://www.sciencedirect.com/science/article/pii/S1386653221002924

Samples (either Nasopharyngeal or Throat swabs) are from 125 patients, either COVID+ or COVID- by RT-PCR, were subjected to Illumina sequencing (one RNA and one DNA sequencing run for each patient).

Aknowledgment: kudos to the authors for providing all the required data to reproduce the analysis, both as online supplementary material to the published paper, as raw sequence data submissions to 
open international archives, and as as prompt replies to email queries. 

### Aim of the re-analysis

Use k-mer based binning of the raw reads to identify potential human pathogens in the samples (including SARS-CoV-2).

To investigate, amongst others: 
 - correlation between COVID+/- PCR status and SARS sequence presence in metatranscriptomes
 - correlation between SARS2 infection and presence of known viral/bacterial co-pathogens
 - effectiveness of SARS2 detection with regards swab type (Nasopharyngeal or Throat)

Each course participant is in charge of a subset of the 250 total samples sequenced. Results will then be compiled to allow overall analysis of the full dataset.

### Structure of the shared repository

 - ```data``` contains the original data from Castañeda-Mogollón (**read only**, ie file contents not to be modified!)
 - ```docs``` contains documentation (eg papers, manuals etc.)
 - ```scripts``` will contain any scripts used in the analysis workflow (eg  Jupyter notebooks, SLURM bash scripts)
 - ```analyses``` will contain results of the analyses, such as transformed datasets, output files, and figures
 
Because of their large size, the original raw FASTQ sequence files will be excluded from git tracking via the .gitignore file. 
This is reproducible-friendly because these FASTQ raw files will be considered strictly read only, and therefore can be re-instanciated 
simply by executing the download commands that will be documented in the scripts & notebooks.
 
### Initial data
 - the NCBI raw sample metadata annotation file (downloaded from [NCBI SRA](https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJEB47870)) is in ```data/SraRunTable.csv```
 - the EBI ENA sample metadata annotation file (downloaded from [EBI ENA](https://www.ebi.ac.uk/ena/browser/view/PRJEB47870?show=reads)) is in ```data/filereport_read_run_PRJEB47870.tsv```
 - RT-PCR Ct (cycle threshold) values (obtained by contacting the authors by email) are in ```data/ct_values_covid19_metagenomics.xlsx```
 - IDseq (see ref below) processing metadata for 5'/forward reads (obtained by contacting the authors by email) are in ```data/sample_overviews 5.csv```
 - IDseq (see ref below) processing metadata for 3'/reverse reads (obtained by contacting the authors by email) are in ```data/sample_overviews 3.csv```
 - a copy of the Castañeda-Mogollón et al. paper is in ```docs/Castaneda-Mogollon_et_al_J_Clinical_Vir_Dec_2021.pdf```
 - a copy of the supplementary figures are in ```Castaneda-Mogollon_et_al_J_Clinical_Vir_Dec_2021_supp_figs.pdf```
 - a copy of the supplementary material & methods are in ```Castaneda-Mogollon_et_al_J_Clinical_Vir_Dec_2021_supp_mat_and_meth.pdf```
 
### Organisation of the collaborative analysis
- the raw sequencing files archived at the NCBI SRA https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=PRJEB47870 will be downloaded in ```data/```
- data needed to collaborate will be stored in the SQLite database in ```analyses/sample_collab.db```
  - table ```SraRunTable``` is a direct DB import of ```data/SraRunTable.csv```
  - table ```sample_overviews``` is a direct DB import of concatenated files ```data/sample_overviews 5.csv``` plus ```data/sample_overviews 3.csv```
  - table ```ct_values``` is a direct DB import of ```data/ct_values_covid19_metagenomics.xlsx```
  - table ```users``` will hold the list of course participants (field ```username``` is your **IFB account login**)
  - samples to users dispatch to be made in table ```sample2user```

### References
 - publication in Journal of Clinical Virology, Volume 145, December 2021: https://www.sciencedirect.com/science/article/pii/S1386653221002924
 - referenced papers on the "spiked primer enrichment" technique (nothing to do with the SC2 Spike protein...): 
   - https://www.nature.com/articles/s41564-019-0637-9
   - preprint applied to SC2: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7217139/
   - with a corresponding "open reproducible protocol": https://www.protocols.io/view/sars-cov-2-enrichment-sequencing-by-spiked-primer-261geowedl47/v4
 - paper describing the "IDSeq" (now morphed into https://czid.org/) metagenomic analysis protocol (used in the 2021 J. of Clinical Virol): https://academic.oup.com/gigascience/article/9/10/giaa111/5918865?login=true
