class DESeq2():
    def __init__(self, counts, meta, design):
        self.raw_counts = robjects.conversion.py2rpy(counts.round().astype(int))
        self.meta_chr = robjects.conversion.py2rpy(meta)
        self.meta = to_factors(robjects.conversion.py2rpy(meta))
        self.design = design
        
    def create_deseq_object(self):
        self.dds = deseq.DESeqDataSetFromMatrix(countData=self.raw_counts, colData=self.meta, design=self.design)
        
    def normalization(self):
        self.dds = deseq.estimateSizeFactors_DESeqDataSet(self.dds)
        norm_counts = to_dataframe(deseq.counts_DESeqDataSet(self.dds, normalized=True))
        norm_counts = robjects.conversion.rpy2py(norm_counts)
        norm_counts.index = robjects.conversion.rpy2py(self.raw_counts).index
        norm_counts.columns = robjects.conversion.rpy2py(self.raw_counts).columns
        return norm_counts
    
    def transformation(self, method = "vst"):
        if method == "vst":
            mat = deseq.varianceStabilizingTransformation(self.dds, blind = True)
        elif method == "rlog":
            mat = deseq.rlog(self.dds, blind = True)
            
        mat = to_dataframe(sumexp.assay(mat))
        mat = robjects.conversion.rpy2py(mat)
        mat.index = robjects.conversion.rpy2py(self.raw_counts).index
        mat.columns = robjects.conversion.rpy2py(self.raw_counts).columns   
        return mat
    
    def LRT_testing(self):
        try:
            dds_lrt = deseq.DESeq(self.dds, test="LRT", reduced = Formula("~1"))
            res_LRT = to_dataframe(deseq.results(dds_lrt))
            res_LRT = robjects.conversion.rpy2py(res_LRT)
        except rpy2.rinterface_lib.embedded.RRuntimeError:
            sys.exit()
        return res_LRT
    
    def clustering(self, cluster_mat):
        cluster_mat = robjects.conversion.py2rpy(cluster_mat)
        dp = degreport.degPatterns(cluster_mat, metadata = self.meta_chr, time = "AgeBins")
        cluster_content = robjects.conversion.rpy2py(get_clusters(dp))
        cluster_data = robjects.conversion.rpy2py(get_cluster_data(dp))
        return cluster_content, cluster_data


def compute_peak_values(cpg_site):
    peak_values = []
    for age in df['age'].unique():
        subset = df[df['age'] == age][cpg_site]
        density, bins = np.histogram(subset, bins=30, density=True)
        peaks, _ = find_peaks(density, height=0)
        if len(peaks) > 0:
            peak_values.append(bins[peaks[0]])
        else:
            peak_values.append(np.nan)
    return peak_values