## Deprecated: _TP53_ mutation status in Medulloblastoma SHH subtype samples

**Module Author:** Candace Savonen ([@cansavvy](https://www.github.com/cansavvy))

The goal of this analysis was to further classify SHH subtype medulloblastoma samples into SHH, _TP53_-mutated and SHH, _TP53_-wildtype per [#247](https://github.com/AlexsLemonade/OpenPBTA-analysis/issues/247).

**The notebook described below looked at any somatic _TP53_ mutations.
According to the Medulloblastoma WHO 2016 book chapter linked on the issue, _TP53_ mutations are often found in exons 4 through 8 and are germline mutations about half the time.
We do not have information regarding the presence or absence of _TP53_ germline mutations for this cohort.
The mutation status table in `results` should not be used for subtyping.**

We use `molecular_subtype` information from the harmonized clinical file (`pbta-histologies.tsv`) to restrict our analysis to samples classified as `SHH`.
The medulloblastoma subtype classifier uses RNA-seq data, so we must identify WGS biospecimens that map to the same `sample_id`, if available.
We then look at the presence or absence of mutations in _TP53_ in the consensus mutation file (`pbta-snv-consensus-mutation.maf.tsv.gz`).

### Running the analysis

This analysis consists of a single R Notebook, that can be run with the following from the top directory of the project:

```
Rscript -e "rmarkdown::render('analyses/molecular-subtyping-SHH-tp53/SHH-tp53-molecular-subtyping-data-prep.Rmd', clean = TRUE)"
```

### Output

The output is a table _TP53_ mutation status on a per `sample_id` basis available as `results/tp53-shh-samples-status.tsv`.
