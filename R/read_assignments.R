#' Read Assignments Files
#'
#' An 'assignments' file ...
#'
#' @param file Pathname to a \file{*_assignments.txt(.gz)} file.
#'
#' @param columns (optional) Name of columns to be read.
#'
#' @param ... Additional arguments passed to [readr::read_tsv()].
#'
#' @return A data.frame with four columns:
#'  \item{`readname`}{...}
#'  \item{`left_inner_barcode`}{...}
#'  \item{`right_inner_barcode`}{...}
#'  \item{`outer_barcode`}{...}
#'
#' @details
#' The description here are adopted from [GSE84920_README.txt](ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE84nnn/GSE84920/suppl/GSE84920\%5FREADME\%2Etxt).
#' It is sparse on what 'assignments' files are, but it says:
#' "TXT \[ed. we think they meant ASSIGNMENTS\] files represent the barcode
#' associations for each sequenced read where two barcodes were identifiable.
#' The format is `READNAME\tLEFT_INNER_BARCODE\tRIGHT_INNER_BARCODE\tOUTER_BARCODE`,
#' where `LEFT_INNER_BARCODE` and `RIGHT_INNER_BARCODE` should match for
#' valid reads.  We include all reads here, but note that for all analyses
#' presented in the associated paper, all reads where these barcodes do not
#' match were discarded."
#'
#' @section Validation:
#' The `read_assignments()` function does some basic validation on the
#' values read.
#'
#' @examples
#' path <- system.file("extdata", package = "GSE84920.parser")
#' file <- file.path(path, "GSM2254215_ML1.rows=1-1000_assignments.txt.gz")
#' data <- read_assignments(file)
#' print(data)
#' # # A tibble: 1,000 x 4
#' #    readname                   left_inner_barcode right_inner_barc… outer_barcode
#' #    <chr>                      <chr>              <chr>             <chr>        
#' #  1 D00584:136:HMTLJBCXX:1:11… CTCTCACG           CTCTCACG          TCAGATGC     
#' #  2 D00584:136:HMTLJBCXX:1:11… GCACCATG           GCACCATG          GTGTAGCA     
#' #  3 D00584:136:HMTLJBCXX:1:11… AGGTGCGA           AGGTGCGA          GTATCTAT     
#' #  4 D00584:136:HMTLJBCXX:1:11… GCCTTAGG           GCCTTAGG          CAGCATAT     
#' #  5 D00584:136:HMTLJBCXX:1:11… CACCTGTG           CACCTGTG          TACTAAGC     
#' #  6 D00584:136:HMTLJBCXX:1:11… CCGCTACG           CCGCTACG          CAGCATAT     
#' #  7 D00584:136:HMTLJBCXX:1:11… GCCTCGAA           GCCTCGAA          GTATCTAT     
#' #  8 D00584:136:HMTLJBCXX:1:11… CTGGTCAC           CTGGTCAC          TTGACCAT     
#' #  9 D00584:136:HMTLJBCXX:1:11… CTGCGTAG           CTGCGTAG          TATCTTGT     
#' # 10 D00584:136:HMTLJBCXX:1:11… CACGACCT           CACGACCT          GATGATCC     
#' # # … with 990 more rows
#' 
#' @importFrom readr read_tsv cols col_character col_skip
#' @export
read_assignments <- function(file, columns = NULL, ...) {
  col_types <- cols(
    readname = col_character(),
    left_inner_barcode = col_character(),
    right_inner_barcode = col_character(),
    outer_barcode = col_character(),
    .default = col_skip()
  )
  all_col_names <- names(col_types$cols)

  if (!is.null(columns)) {
    stopifnot(all(columns %in% names(col_types$cols)))
    col_types$cols <- col_types$cols[columns]
  }

  data <- read_tsv(file, col_names = all_col_names, col_types = col_types, ...)
  
  ## Validation
  col_names <- colnames(data)
  with(data, stopifnot(
    !"left_inner_barcode" %in% col_names || all(nchar(left_inner_barcode) == 8L),
    !"right_inner_barcode" %in% col_names || all(nchar(right_inner_barcode) == 8L),
    !"outer_barcode" %in% col_names || all(nchar(outer_barcode) == 8L)
  ))

  data
}
