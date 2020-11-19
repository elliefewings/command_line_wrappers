# Wrappers to run PROGENy and Dorothea on the command line

## PROGENy: Pathway RespOnsive GENes for activity inference

See further information : <https://saezlab.github.io/progeny/index.html>

Aberrant cell signaling is known to cause cancer and many other diseases, 
as well as a focus of treatment. A common approach is to infer its activity
on the level of pathways using gene expression. However, mapping gene expression
to pathway components disregards the effect of post-translational modifications, 
and downstream signatures represent very specific experimental conditions. Here we 
present PROGENy, a method that overcomes both limitations by leveraging a large 
compendium of publicly available perturbation experiments to yield a common core of 
Pathway RespOnsive GENes. Unlike existing methods, PROGENy can:

(i) recover the effect of known driver mutations

(ii) provide or improve strong markers for drug indications

(iii) distinguish between oncogenic and tumor suppressor pathways for patient survival.

Collectively, these results show that PROGENy more accurately infers pathway activity from gene expression than other methods.

## Usage
```
Usage: ./progeny [options]


Options:
        -e EXPR, --expr=EXPR
                A gene expression object with HGNC/MGI symbols in rows and samples in columns.
              In order to run PROGENy in single-cell RNAseq data, it also accepts Seurat and SingleCellExperiment object,
              taking the normalized counts for the computation. [required]

        -s SCALE, --scale=SCALE
                A logical value indicating whether to scale the scores of each pathway to have a mean of zero and a
              standard deviation of one. It does not apply if we use permutations [default=FALSE]

        -o ORGANISM, --organism=ORGANISM
                The model organism - 'Human' or 'Mouse' [default=Mouse]

        -t TOP, --top=TOP
                The top n genes for generating the model matrix according to significance (p-value) [default=500]

        -p PERM, --perm=PERM
                An interger detailing the number of permutations.
              When Permutations larger than 1, we compute progeny pathway scores and assesses their significance using a
              gene sampling-based permutation strategy, for a series of experimental samples/contrasts [default=1]

        -v VERBOSE, --verbose=VERBOSE
                A logical value indicating whether to display a message about the number of genes used per pathway
              to compute progeny scores (i.e. number of genes present in the progeny model and in the expression dataset) [default=FALSE]

        -z Z_SCORES, --z_scores=Z_SCORES
                Only applies if the number of permutations is greater than 1. A logical value. TRUE: the z-scores will
              be returned for the pathway activity estimations. FALSE: the function returns a normalized z-score value between -1 and 1 [default=FALSE]

        -g GET_NULLDIST, --get_nulldist=GET_NULLDIST
                Only applies if the number of permutations is greater than 1. A logical value. TRUE: the null distributions generated
              to assess the signifance of the pathways scores is also returned [default=FALSE]

        -h, --help
                Show this help message and exit
```

## DoRothEA : A gene set resource containing signed transcription factor (TF) interactions for usage with Viper

See further information : <https://saezlab.github.io/dorothea/index.html>

DoRothEA is a gene set resource containing signed transcription factor (TF) - target
interactions first described in Garcia-Alonso et al., 2019. The collection of a TF 
and its transcriptional targets is defined as regulon. DoRothEA regulons were curated
and collected from different types of evidence such as literature curated resources, 
ChIP-seq peaks, TF binding site motifs and interactions inferred directly from gene 
expression.

## Usage
```
Usage: ./dorothea [options]


Options:
        -e EXPR, --expr=EXPR
                An object containing a gene expression matrix with genes (HGNC/MGI symbols) in rows and samples in columns [required]

        -o ORGANISM, --organism=ORGANISM
                The model organism - 'Human' or 'Mouse' [default=Mouse]

        -t TIDY, --tidy=TIDY
                Logical, whether computed tf activities scores should be returned in a tidy format [default=FALSE]

        -p PLEIOTROPY, --pleiotropy=PLEIOTROPY
                Logical, whether correction for pleiotropic regulation should be performed [default=FALSE]

        -n NES, --nes=NES
                Logical, whether the enrichment score reported should be normalized [default=FALSE]

        -m METHOD, --method=METHOD
                Character string indicating the method for computing the single samples signature, either scale, rank, mad, ttest or none [default=none]

        -i MINSIZE, --minsize=MINSIZE
                Integer indicating the minimum number of targets allowed per regulon [default=1]

        -a ADAPTIVE.SIZE, --adaptive.size=ADAPTIVE.SIZE
                Logical, whether the weighting scores should be taken into account for computing the regulon size [default=FALSE]

        -f ESET.FILTER, --eset.filter=ESET.FILTER
                Logical, whether the dataset should be limited only to the genes represented in the interactome
              #' @param mvws Number or vector indicating either the exponent score for the metaViper weights, or the
              #' inflection point and trend for the sigmoid function describing the weights in metaViper [default=FALSE]

        -c CORES, --cores=CORES
                Integer indicating the number of cores to use (only 1 in Windows-based systems) [default=1]

        -v VERBOSE, --verbose=VERBOSE
               Logical, whether progression messages should be printed in the terminal [default=FALSE]

        -h, --help
                Show this help message and exit
```
