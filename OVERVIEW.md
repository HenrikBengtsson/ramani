This [R] package provides a shell script and an R API for working with the Ramani et al. (2017) Hi-C data sets, e.g. [GSM2254215](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM2254215).

REFERENCES:

1. Ramani, V., Deng, X., Qiu, R., Gunderson, K. L., Steemers, F. J., Disteche, C. M., … Shendure, J. (2017). Massively multiplex single-cell Hi-C. Nature methods, 14(3), 263–266. doi:10.1038/nmeth.4155, [PMC5330809](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5330809/)



## Splitting whole-genome files into chromosome-pair files

The package also provides a Bash script for splitting a HiC-count data file into chromosome-pair files.  This  [`split.sh`](inst/scripts/split.sh) script is located under `system.file("scripts", package = "ramani")`.

```sh
$ split.sh 
Split HiC Count Data File into Chromosome-Pair Files

Usage:
 ./split.sh [options] path/to/*.summary.txt.gz

Options:
 --help       Display this help
 --version    Display the version
 --dryrun     Don't run anything
 --intraonly  Only process intra-chromosome pairs

Examples:
 ./split.sh --intraonly hicData/GSE35156_GSM862720_J1_mESC_HindIII_ori_HiC.nodup.hic.summary.txt.gz

This outputs *.tsv.gz files:

  1. GSE35156_GSM862720_J1_mESC_HindIII_ori_HiC.nodup.hic.summary_chr1_vs_chr1.tsv.gz
  2. GSE35156_GSM862720_J1_mESC_HindIII_ori_HiC.nodup.hic.summary_chr2_vs_chr2.tsv.gz
...
 25. GSE35156_GSM862720_J1_mESC_HindIII_ori_HiC.nodup.hic.summary_chrM_vs_chrM.tsv.gz

to folder hicData/GSE35156_GSM862720/ with names 

Details:
The produced files are names '<name>,<chr_i>_vs_<chr_j>.tsv.gz' where <name>
is the name of input '*.summary.txt.gz' file without the extension. The
files are written to folder 'hicData/<gse_id>_<gsm_id>/' where <gse_id> and
<gsm_id> are inferred from the <name>. This folder is automatically created,
if missing.

Version: 0.1.2
Copyright: Henrik Bengtsson (2017-2019)
License: GPL (>= 3.0)
Source: https://github.com/HenrikBengtsson/ramani
```


## Parsing HiC files in R

See `help("import_assignments", package = "ramani")` for an example.



[R]: https://www.r-project.org/
[remotes]: https://cran.r-project.org/package=remotes