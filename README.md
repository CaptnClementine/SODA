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

### Influence of Two CpG Group Detection Methods on Clusterization Trend Lines

The two primary principles of CpG grouping by the same age were the median and peak values of density distribution. The main pipeline after grouping remained consistent: calculating the correlation matrix of CpGs, then identifying clusters of CpGs that exhibit similar trends during aging, followed by visualization of clusters and cluster samples. For trend line plotting, a window of +/- 2 years was utilized.
#### Clustering and trend lines following median grouping.

**1. Hierarchical clustering.**
![image](https://github.com/CaptnClementine/SODA/assets/131146976/f55ba285-30d9-4c78-b34a-49394e83dc4a)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/3ffe008c-f613-4b95-b003-a50c14b32e75)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/37f8638a-dff5-4290-9c84-7bd0993cf41f)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/16b97c8a-0911-4854-9281-51d35da4e074)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/d7d42f4b-8ba6-4bc9-b8f7-4859c14cfa32)


Trend lines examples:
![image](https://github.com/CaptnClementine/SODA/assets/131146976/29d3ca8d-2ae4-443c-8319-314f64439c44)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/adbc48b7-a081-4740-8a25-76b504a67c74)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/ecff04a7-2b89-43b5-8045-44221c8390b1)
**2. K-means clustering.**
![image](https://github.com/CaptnClementine/SODA/assets/131146976/4be9e1e9-d504-4eb2-96bf-46514c7488ec)

![image](https://github.com/CaptnClementine/SODA/assets/131146976/6966537d-b92d-40ec-ae43-eadc7b2db6ee)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/da2e5b32-a025-4dfb-9d7f-7a3df6e76c09)
Trend lines examples:
![image](https://github.com/CaptnClementine/SODA/assets/131146976/b1f37269-f2ac-4d77-b7db-a9ba07cfc1e9)
**3. DBSCAN.**
This clustering method yielded the worst results.
![image](https://github.com/CaptnClementine/SODA/assets/131146976/2332a6aa-c6c2-4044-8b78-9897b5aabde9)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/a5184671-9509-4e4e-ac5f-f50af7612059)

**4. Gaussian Mixture.**
Gaussian Mixture was applied solely to identify four clusters, as my notebook's capacity reached its maximum limit, resulting in failure when attempting to detect more clusters
![image](https://github.com/CaptnClementine/SODA/assets/131146976/b4222446-f700-4c84-9fa8-c92d9a65a58b)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/f726a9fd-1583-4a16-94a3-1936f13951cd)

Trend lines examples:
![image](https://github.com/CaptnClementine/SODA/assets/131146976/db3de60a-e8b6-42f9-8b7c-9ffb6a198a38)

#### Clustering and trend lines following peak values of density distribution grouping.

**1. Hierarchical clustering.**

![image](https://github.com/CaptnClementine/SODA/assets/131146976/bc38964d-eab3-4d9a-a55a-da8fc7217ebb)

![image](https://github.com/CaptnClementine/SODA/assets/131146976/30c8b883-ebcd-4891-88c0-d0d8c0529226)

Trend lines examples:
![image](https://github.com/CaptnClementine/SODA/assets/131146976/8cff9734-a891-477b-814b-79737a5381c8)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/2d7d4c40-4a13-4345-9fe8-3072eaad7a69)
![image](https://github.com/CaptnClementine/SODA/assets/131146976/0f69717f-3801-4c4b-bb74-050dab162d7b)



## Transcriptomics

In the realm of transcriptomics data and microarray analysis, RNA sequencing (RNA-seq) is essential techniques for understanding gene expression changes, and as cosequenses methabolic changes in the cells and body.

RNA-seq is a powerful tool for measuring the abundance of RNA transcripts in a sample, providing insights into gene expression levels, alternative splicing, and transcript isoforms. This technique involves sequencing cDNA synthesized from RNA molecules extracted from cells or tissues, allowing researchers to quantify gene expression levels and identify differentially expressed genes under various conditions or disease states.

Microarray transcriptomics data refers to information obtained through the use of microarray technology to profile gene expression patterns across the genome. This method allows researchers to analyze gene expression levels at multiple genomic loci simultaneously, providing a comprehensive view of transcriptional activity. Microarray-based transcriptomic profiling involves hybridizing RNA samples onto microarrays containing probes specific to different genes or transcripts. By comparing gene expression patterns between samples or conditions, researchers can identifychanges about  gene expression  and gain insights into cellular processes, biological pathways, and disease mechanisms.


### Data collection and annotation
There are 9 datasets  where annotated and merged by the presenting common genes: GSE56047, GSE16717, GSE67220, GSE56033, GSE30483, GSE47353, GSE68759, GSE7551, GSE65907. 
There are 4588 samples collected in data, with differens ages and genders. Disrtibution of all dataest in common dataset you can see below 
![image](https://github.com/GlebBobkov/SODA/blob/transcriptomic/Age%20Distribution%20in%20Each%20Dataset.png)
![image](https://github.com/GlebBobkov/SODA/blob/transcriptomic/Summary%20of%20Dataset%20Characteristics.png)



# Links
1 https://sci-hub.ru/https://www.cambridge.org/core/journals/zygote/article/abs/antioxidant-activities-and-lipid-peroxidation-status-in-human-follicular-fluid-agedependent-change/DD95456667D836090C97F9E3C91BC459

2 https://pubmed.ncbi.nlm.nih.gov/21451205/

3 https://sci-hub.ru/https://www.nature.com/articles/s41591-019-0673-2

4 https://www.nature.com/articles/s41598-019-46749-w

