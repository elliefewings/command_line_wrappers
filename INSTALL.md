# Wrappers to run PROGENy and Dorothea on the command line

## PROGENy: Pathway RespOnsive GENes for activity inference
Install required R packages
```
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
```

## DoRothEA : A gene set resource containing signed transcription factor (TF) interactions for usage with Viper
Install required R packages
```
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
```