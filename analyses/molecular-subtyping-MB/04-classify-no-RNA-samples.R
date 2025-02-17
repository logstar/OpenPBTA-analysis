# Author: Komal S. Rathi
# Function: Script to add "To be classified" for WGS-only samples

suppressPackageStartupMessages({
  library(tidyverse)
  library(readr)
})

# root directory
root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))

# set results directory
output_dir <- file.path(root_dir, "analyses", "molecular-subtyping-MB", "results") 
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

# read medulloblastoma samples from histology
mb_samples <- file.path(root_dir, "data", "histologies.tsv") %>%
  read_tsv() %>%
  filter(cancer_group == "Medulloblastoma",
         sample_type == "Tumor")

# samples where no RNA-Seq data is available
sample_ids_with_rna <- mb_samples %>% 
  filter(experimental_strategy == "RNA-Seq")
samples_ids_no_rna <- mb_samples %>%
  filter(!sample_id %in% sample_ids_with_rna$sample_id)

# format data
samples_ids_no_rna <- samples_ids_no_rna %>%
  dplyr::mutate(Kids_First_Biospecimen_ID_DNA = Kids_First_Biospecimen_ID,
                Kids_First_Biospecimen_ID_RNA = NA,
                molecular_subtype = "MB, To be classified") %>%
  dplyr::select(Kids_First_Participant_ID, sample_id, Kids_First_Biospecimen_ID_DNA, Kids_First_Biospecimen_ID_RNA, molecular_subtype)

# read RNA-based results, append samples with no RNA and write out
result_file <- file.path(root_dir, "analyses", "molecular-subtyping-MB", "results", "MB_molecular_subtype.tsv")
read_tsv(result_file) %>%
  rbind(samples_ids_no_rna) %>%
  write_tsv(result_file)
