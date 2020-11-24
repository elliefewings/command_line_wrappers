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
# Runs DoRothEA resource on Viper

# ============================================================

# Install if required
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

if (!require("dorothea", character.only = TRUE, quietly = TRUE)){
  BiocManager::install("dorothea")
}

# Load libraries
libs <- c("optparse", "viper", "dplyr", "magrittr")

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
              help="An object containing a gene expression matrix with genes (HGNC/MGI symbols) in rows and samples in columns [required]"),
  
  make_option(c("--organism", "-o"), action="store", default="Mouse", type='character',
              help="The model organism - 'Human' or 'Mouse' [default=Mouse]"),
  
  make_option(c("--tidy", "-t"), action="store", default=FALSE, type='logical',
              help="Logical, whether computed tf activities scores should be returned in a tidy format [default=FALSE]"),
  
  make_option(c("--pleiotropy", "-p"), action="store", default=FALSE, type='logical',
              help="Logical, whether correction for pleiotropic regulation should be performed [default=FALSE]"),
 
  make_option(c("--nes", "-n"), action="store", default=FALSE, type='logical',
              help="Logical, whether the enrichment score reported should be normalized [default=FALSE]"),
  
  make_option(c("--method", "-m"), action="store", default="none", type='character',
              help="Character string indicating the method for computing the single samples signature, either scale, rank, mad, ttest or none [default=none]"),
  
  make_option(c("--minsize", "-i"), action="store", default=1, type='numeric',
              help="Integer indicating the minimum number of targets allowed per regulon [default=1]"),
  
  make_option(c("--adaptive.size", "-a"), action="store", default=FALSE, type='logical',
              help="Logical, whether the weighting scores should be taken into account for computing the regulon size [default=FALSE]"),
  
  make_option(c("--eset.filter", "-f"), action="store", default=FALSE, type='logical',
              help="Logical, whether the dataset should be limited only to the genes represented in the interactome 
              #' @param mvws Number or vector indicating either the exponent score for the metaViper weights, or the 
              #' inflection point and trend for the sigmoid function describing the weights in metaViper [default=FALSE]"),
  
  make_option(c("--cores", "-c"), action="store", default=1, type='numeric',
              help="Integer indicating the number of cores to use (only 1 in Windows-based systems) [default=1]"),

  make_option(c("--verbose", "-v"), action="store", default=FALSE, type='logical',
              help="Logical, whether progression messages should be printed in the terminal [default=FALSE]")
)

opt <- parse_args(OptionParser(option_list=option_list))

## Check for input and output options
if (is.null(opt$expr)) {
  message("ERROR: Expression matrix missing, please specify with --expr, -e flags.")
  stop(parse_args(OptionParser(option_list=option_list), args = c("--help")))
}

# Load input
input <- read.table(opt$expr, row.names=1, header=TRUE)

## Run dorothea

#Set organism
org <- ifelse(opt$organism == "Human", "dorothea_hs", "dorothea_mm") 

dorothea_regulon_human <- get(data(list=org, package = "dorothea"))

## We obtain the regulons based on interactions with confidence level A, B and C
regulon <- dorothea_regulon_human %>%
  dplyr::filter(confidence %in% c("A","B","C"))

## We compute Viper Scores 
out <- run_viper(input, regulon,
                  options = list(pleiotropy = opt$pleiotropy,
                                 nes = opt$nes,
                                 method = opt$method,
                                 minsize = opt$minsize,
                                 adaptive.size = opt$adaptive.size,
                                 eset.filter = opt$eset.filter,
                                 cores = opt$cores,
                                 verbose = opt$verbose))
print(out)
