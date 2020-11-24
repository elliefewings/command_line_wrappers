#!/usr/bin/env Rscript
# coding: utf-8
# Copyright (C) 2020 Eleanor Fewings
#
# Contact: eleanor.fewings@bioquant.uni-heidelberg.de
#
# ====================
# GNU-GLPv3:
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# A full copy of the GNU General Public License can be found on
# http://www.gnu.org/licenses/.
#
# ============================================================
# DESCRIPTION:
# Runs PROGENy: Pathway RespOnsive GENes for activity inference

# ============================================================

# Install if required
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

if (!require("progeny", character.only = TRUE, quietly = TRUE)){
  BiocManager::install("progeny")
}

# Load libraries
libs <- c("optparse", "progeny")

for (i in libs) {
  if (! suppressPackageStartupMessages(suppressWarnings(require(i, character.only = TRUE, quietly = TRUE)))) { 
    install.packages(i, repos = "https://ftp.fau.de/cran/")
    if (! suppressPackageStartupMessages(suppressWarnings(require(i, character.only = TRUE, quietly = TRUE)))) {
      stop(paste("Unable to install package: ", i, ". Please install manually and restart.", sep=""))
    }
  }
}

## Get options
option_list <- list(
  make_option(c("--expr", "-e"), action="store", default=NULL, type='character',
              help="A gene expression object with HGNC/MGI symbols in rows and samples in columns. 
              In order to run PROGENy in single-cell RNAseq data, it also accepts Seurat and SingleCellExperiment object, 
              taking the normalized counts for the computation. [required]"),
  make_option(c("--scale", "-s"), action="store", default=FALSE, type='logical',
              help="A logical value indicating whether to scale the scores of each pathway to have a mean of zero and a 
              standard deviation of one. It does not apply if we use permutations [default=FALSE]"),
  make_option(c("--organism", "-o"), action="store", default="Mouse", type='character',
              help="The model organism - 'Human' or 'Mouse' [default=Mouse]"),
  make_option(c("--top", "-t"), action="store", default=500, type='numeric',
              help="The top n genes for generating the model matrix according to significance (p-value) [default=500]"),
  make_option(c("--perm", "-p"), action="store", default=1, type='numeric',
              help="An interger detailing the number of permutations. 
              When Permutations larger than 1, we compute progeny pathway scores and assesses their significance using a 
              gene sampling-based permutation strategy, for a series of experimental samples/contrasts [default=1]"),
  make_option(c("--verbose", "-v"), action="store", default=FALSE, type='logical',
              help="A logical value indicating whether to display a message about the number of genes used per pathway
              to compute progeny scores (i.e. number of genes present in the progeny model and in the expression dataset) [default=FALSE]"),
  make_option(c("--z_scores", "-z"), action="store", default=FALSE, type='logical',
              help="Only applies if the number of permutations is greater than 1. A logical value. TRUE: the z-scores will
              be returned for the pathway activity estimations. FALSE: the function returns a normalized z-score value between -1 and 1 [default=FALSE]"),
  make_option(c("--get_nulldist", "-g"), action="store", default=FALSE, type='logical',
              help="Only applies if the number of permutations is greater than 1. A logical value. TRUE: the null distributions generated 
              to assess the signifance of the pathways scores is also returned [default=FALSE]")
)

opt <- parse_args(OptionParser(option_list=option_list))

## Check for input and output options
if (is.null(opt$expr)) {
  message("ERROR: Expression matrix missing, please specify with --expr, -e flags.")
  stop(parse_args(OptionParser(option_list=option_list), args = c("--help")))
}

# Load input
input <- read.table(opt$expr, row.names=1, header=TRUE)

#Run progeny
out <- progeny(input, 
                scale=opt$scale, 
                organism=opt$organism, 
                top=opt$top, 
                perm=opt$perm,
                verbose=opt$verbose,
                z_scores=opt$z_scores,
                get_nulldist=opt$get_nulldist)

print(out)

