# SODA (SennesOmics Data Analysis)

This repository is the outcome of a project conducted at the [Bioinformatics Institute](https://bioinf.me/), aimed at comprehensively characterizing the molecular changes associated with aging around the age of 37 through multiomics analysis. The utilized omics data include Epigenomics and RNA-sequencing.

Why choose 37 instead of 42, you might ask? There is a lot of diverse data showing the importance of processes in this particular age interval (about 37 years), in particular, changes in glucose metabolism, an increase in markers of oxidative stress (MDA) in the blood plasma from 37 years, as well as in the interval 20-25 years for men and women [1-4]. But perhaps 42 is the correct answer 😊, who knows?

<img width="700" alt="image" src="https://github.com/CaptnClementine/SODA/assets/131146976/a3328486-5bbd-4c11-a3f5-9fc349780db8">


## Workflow structure

The workflow comprises the following steps:

1. **Data Collection:** Find and download epigenomic and transcriptomic data from aging cohorts, including DNA methylation profiles.
2. **Batch Correction:** Detect and correct for batch effects in the data to ensure accurate analysis.
3. **Sample Sex Identification:** Determine the sex of the samples.
4. **Main Pipeline Creation:** Develop main scripts for individual cohorts and meta-cohorts.
     - CpG selection (retain only differing CpGs).
     - Detection of CpG groups using various statistical calculations and clustering methods.
     - Selection of the optimal statistical calculation and clustering method.
     - Detection and plotting of trend lines for each CpG/RNAseq.
     - Validation of identified groups on PBMC cohort.
5. **Execution of Main Script:** Run the main script for all methylation and microarray metacohorts, and additionally, analyses were performed separately for males and females.
6. **Merge Findings:** Combine results for comprehensive omics analysis.
7. **Functional Gene Detection:** Conduct enrichment analysis to elucidate functional pathways associated with identified trends.

The entire process utilizes Jupyter notebooks, and the outputs are visually represented in the schematic image provided below:

<img width="1310" alt="image" src="https://github.com/CaptnClementine/SODA/assets/131146976/99e33be0-94b3-4189-8a38-4be1a95ba4c8">

# More about omics

## Epigenomics
DNA methylation is an epigenetic mechanism that involves the addition of a methyl group to DNA molecules, typically at cytosine bases within CpG dinucleotides. This modification plays a crucial role in gene regulation, development, and various cellular processes. In the context of aging, epigenomics explores how these modifications change over time and contribute to age-related processes and diseases. 

![image](https://github.com/CaptnClementine/SODA/assets/131146976/722029fc-651c-45d3-bd65-bc80e5c63d03)

Microarray methylation data refers to information obtained through the use of microarray technology to profile DNA methylation patterns across the genome. This method allows researchers to analyze DNA methylation levels at multiple genomic loci simultaneously, providing a comprehensive view of epigenetic modifications. Microarray-based DNA methylation profiling involves enriching unmethylated and methylated DNA fractions, which are then interrogated on microarrays containing probes specific to these regions.

### Data Collection, Batch Effect Correction, and CpG Selection

More than 6000 samples were found for further analysis. For the initial step, approximately 2000 samples of PBMC were collected.

<img src="https://github.com/CaptnClementine/SODA/assets/131146976/6ca1f703-4ec1-43ba-84e9-08b2fd31c6b9" style="width:50%;">

After detecting batch effects using PCA, the COMBAT method is commonly employed to correct for these effects. COMBAT (Empirical Bayes framework) works by adjusting the data to remove unwanted variation introduced by batch effects while preserving true biological signals. It achieves this by borrowing information across genes to estimate and adjust for batch effects, enhancing the accuracy of downstream analyses by harmonizing data from different batches.
![image](https://github.com/CaptnClementine/SODA/assets/131146976/3511627d-bb14-4e3f-b870-f6c0c091ca60)


The dataset GSE42861 was chosen for CpG selection due to its broad age range and ample sample size, enabling the exploration of age-related CpG methylation patterns with statistical robustness.
The selection of CpGs based on the dataset GSE42861 involved the following steps:

1. **Define Age Bins:**
Age bins were defined to categorize individuals into different age groups. The specified age bins used were: [18, 27, 30, 35, 40, 45, 60].
  
2. **Calculate Mean by Age Range:**
The dataset was then grouped by age range, and the mean values for each CpG site across different age groups were calculated.

3. **Calculate Difference in Mean Expression:**
The difference between the maximum and minimum mean expression values for each CpG site across different age ranges was calculated to assess variability in CpG expression across age groups.

4. **Count CpGs with Significant Differences:**
Finally, the number of CpGs exhibiting a significant difference in mean expression across age ranges, defined as greater than 0.05, was determined.

Based on the described process, a total of 16122 CpGs were identified for different age groups within the dataset GSE42861.




## Transcriptomics

In the realm of transcriptomics data and microarray analysis, RNA sequencing (RNA-seq) is essential techniques for understanding gene expression changes, and as cosequenses methabolic changes in the cells and body.

RNA-seq is a powerful tool for measuring the abundance of RNA transcripts in a sample, providing insights into gene expression levels, alternative splicing, and transcript isoforms. This technique involves sequencing cDNA synthesized from RNA molecules extracted from cells or tissues, allowing researchers to quantify gene expression levels and identify differentially expressed genes under various conditions or disease states.

Microarray transcriptomics data refers to information obtained through the use of microarray technology to profile gene expression patterns across the genome. This method allows researchers to analyze gene expression levels at multiple genomic loci simultaneously, providing a comprehensive view of transcriptional activity. Microarray-based transcriptomic profiling involves hybridizing RNA samples onto microarrays containing probes specific to different genes or transcripts. By comparing gene expression patterns between samples or conditions, researchers can identifychanges about  gene expression  and gain insights into cellular processes, biological pathways, and disease mechanisms.


### Data collection and annotation
There are 9 datasets  where annotated and merged by the presenting common genes: GSE56047, GSE16717, GSE67220, GSE56033, GSE30483, GSE47353, GSE68759, GSE7551, GSE65907. 
There are 4588 samples collected in data, with differens ages and genders. Disrtibution of all dataest in common dataset you can see below 
![image](https://github.com/GlebBobkov/SODA/blob/transcriptomic/Age%20Distribution%20in%20Each%20Dataset.png)
![image](https://github.com/GlebBobkov/SODA/blob/transcriptomic/Summary%20of%20Dataset%20Characteristics.png)

# Contacts

<p align="center">
  <img src="https://github.com/CaptnClementine/gene_code_tools/assets/131146976/83e7d702-ba84-4e60-8ce9-d7ec3e5b7149" alt="image">
</p>


If you have any questions, suggestions, or encounter about the pipeline or methylation data, feel free to reach out to [CaptnClementine](https://github.com/CaptnClementine) 💛. You can also contact me directly on Telegram via [this link](https://t.me/Capnclementine).

# Links
1 https://sci-hub.ru/https://www.cambridge.org/core/journals/zygote/article/abs/antioxidant-activities-and-lipid-peroxidation-status-in-human-follicular-fluid-agedependent-change/DD95456667D836090C97F9E3C91BC459

2 https://pubmed.ncbi.nlm.nih.gov/21451205/

3 https://sci-hub.ru/https://www.nature.com/articles/s41591-019-0673-2

4 https://www.nature.com/articles/s41598-019-46749-w

