import seaborn as sns
import pandas as pd
import numpy as np
import umap
import matplotlib.pyplot as plt

from sklearn.manifold import TSNE
from scipy.cluster.hierarchy import cut_tree


def plot_umap_and_tsne(labels: np.ndarray, x: np.ndarray) -> None:
    """
    Plot UMAP and t-SNE visualizations of the given data.

    Parameters:
        labels (np.ndarray): Labels for the data points.
        x (np.ndarray): Data for visualization.

    Returns:
        None
    """
    umap_embedding = umap.UMAP(n_neighbors=15, min_dist=0.1, metric='euclidean').fit_transform(x)
    tsne_embedding = TSNE(n_components=2, perplexity=30, metric='euclidean').fit_transform(x)
    plt.figure(figsize=(12, 6))

    plt.subplot(1, 2, 1)
    plt.scatter(umap_embedding[:, 0], umap_embedding[:, 1], c=labels, cmap='viridis', s=10)
    plt.title('UMAP Visualization')

    plt.subplot(1, 2, 2)
    plt.scatter(tsne_embedding[:, 0], tsne_embedding[:, 1], c=labels, cmap='viridis', s=10)
    plt.title('t-SNE Visualization')

    plt.show()


def plot_pca(labels: np.ndarray, components_df: pd.DataFrame) -> None:
    """
    Plot PCA visualization of the given data.

    Parameters:
        labels (np.ndarray): Labels for the data points.
        components_df (pd.DataFrame): DataFrame containing PCA components.

    Returns:
        None
    """
    plt.figure(figsize=(10, 6))
    sns.scatterplot(data=components_df, x='x', y='y', hue=labels, palette='viridis')


def cut_clustermap_tree(clustering_results, n_clusters=2, by_cols=True, name='Clusters') -> pd.Series:
    """
    Cut clustermap into the desired number of clusters.

    Parameters:
        clustering_results: Clustering results obtained from seaborn.clustermap.
        n_clusters (int): Number of clusters to cut the tree into.
        by_cols (bool): If True, cut the clustering tree by columns, else by rows.
        name (str): Name for the resulting series.

    Returns:
        pd.Series: Series containing cluster assignments.
    """
    if by_cols:
        link = clustering_results.dendrogram_col.linkage
        index = clustering_results.data.columns
    else:
        link = clustering_results.dendrogram_row.linkage
        index = clustering_results.data.index

    return pd.Series(cut_tree(link, n_clusters=n_clusters)[:, 0], index=index, name=name) + 1
    

def calculate_clusters_statistics(df: pd.DataFrame, labels: np.ndarray) -> pd.DataFrame:
    """
    Calculate cluster statistics.

    Parameters:
        df (pd.DataFrame): Dataframe containing the data.
        labels (np.ndarray): Cluster labels.

    Returns:
        pd.DataFrame: DataFrame containing the cluster statistics.
    """
    df = df.T
    df['clusters'] = labels
    stats = pd.DataFrame()
    stats['mean'] = df.groupby(['cluster_kmeans']).mean().T.mean()
    stats['std'] = df.groupby(['cluster_kmeans']).std().T.mean()
    return stats
