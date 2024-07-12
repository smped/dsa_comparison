Comparison of DSA Approaches
================
Dr Stevie Pederson  
Black Ochre Data Labs  
Telethon Kids Institute  
Adelaide, Australia

13 July, 2024

This repository holds a comparison of methods for Differential Signal
Analysis (DSA) of ChIP-Seq data, as a baseline comparison between those
offered by the Bioconductor packages `extraChIPs` and `DiffBind`
(Ross-Innes et al. 2012). All individual analyses are simple pair-wise
comparisons, with the differing results contrasted.

Peaks for all analyses have been identified using `macs2 callpeak`
(Zhang et al. 2008), with final peak sets being the union of
treatment-specific consensus peaks. Treatment-specific consensus peaks
were considered to be those detected in merged samples, and which
overlapped peaks detected in at least 2 of the 3 individual samples
within each group. Sliding window methods will use these peaks as a
guide for setting thresholds when retaining or discarding windows, as is
implemented in `extraChIPs`

Analysis using limma-trend (Law et al. 2014) will use logCPM values
whilst all other methods use count-based models. Smooth quantile
normalisation (Hicks et al. 2018) will only be applied to sliding
windows.

Sample-specific library sizes will always be taken as the total number
of alignments within a bam file, not just those within defined peaks.
Given the broad similarity between RLE and TMM (Robinson and Oshlack
2010) normalisation, only RLE normalisation will be used. This is the
default for DiffBind and ensured consistency with a recent benchmarking
analysis (Eder and Grebien 2022).

`quantro` (Hicks and Irizarry 2015) will be used to assess equality of
distributions between groups, using logCPM data produced with only
library size normalisation. Any comparisons not passing either component
of this test will be marked for analyses where the requirement for equal
distributions is not met, i.e. RLE normalisation (Anders and Huber
2010). Quantro tests will be performed separately for fixed and sliding
window datasets.

Each ChIP target will return two sets of ranges

1.  Those used for fixed-width window analysis, and
2.  Those retained and merged during sliding window approaches

These sets of windows will be compared to ensure differences are clearly
understood.

Complete DSA will be performed twice.

1.  Using a point-based null hypothesis, i.e. H<sub>0</sub>: μ = 0
2.  Using a range-based null hypothesis, i.e. H<sub>0</sub>: -λ \< μ \<
    λ, setting λ = log<sub>2</sub>1.2 as the default value for `treat`
    (McCarthy and Smyth 2009)

A summary of the methods under investigation is

| Package    | Window Type | Normalisation Method | Model Fitting | Abbreviation |
|:-----------|:------------|:---------------------|:--------------|:-------------|
| extraChIPs | fixed       | Library Size         | glmQLFit      | ec-fx-ls-ql  |
| extraChIPs | fixed       | Library Size         | limma-trend   | ec-fx-ls-lt  |
| extraChIPs | fixed       | RLE                  | glmQLFit      | ec-fx-rle-ql |
| extraChIPs | fixed       | RLE (Within Groups)  | glmQLFit      | ec-fx-rlg-ql |
| extraChIPs | fixed       | RLE                  | limma-trend   | ec-fx-rle-lt |
| extraChIPs | fixed       | RLE                  | WaldTest      | ec-fx-rle-wt |
| DiffBind   | fixed       | Library Size         | WaldTest      | db-fx-ls-ql  |
| DiffBind   | fixed       | RLE                  | WaldTest      | db-fx-rle-ql |
| extraChIPs | sliding     | Library Size         | glmQLFit      | ec-sl-ls-ql  |
| extraChIPs | sliding     | Library Size         | limma-trend   | ec-sl-ls-lt  |
| extraChIPs | sliding     | RLE                  | glmQLFit      | ec-sl-rle-ql |
| extraChIPs | sliding     | RLE                  | limma-trend   | ec-sl-rle-lt |
| extraChIPs | sliding     | Smooth-Quantile      | limma-trend   | ec-sl-sq-lt  |

*Summary of all methods used in this comparison*

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-Anders2010-sd" class="csl-entry">

Anders, Simon, and Wolfgang Huber. 2010. “Differential Expression
Analysis for Sequence Count Data.” *Genome Biol.* 11 (10): R106.

</div>

<div id="ref-Eder2022-db" class="csl-entry">

Eder, Thomas, and Florian Grebien. 2022. “Comprehensive Assessment of
Differential <span class="nocase">ChIP-seq</span> Tools Guides Optimal
Algorithm Selection.” *Genome Biol.* 23 (1): 119.

</div>

<div id="ref-Hicks2015-ee" class="csl-entry">

Hicks, Stephanie C, and Rafael A Irizarry. 2015. “Quantro: A Data-Driven
Approach to Guide the Choice of an Appropriate Normalization Method.”
*Genome Biol.* 16 (1): 117.

</div>

<div id="ref-Hicks2018-uw" class="csl-entry">

Hicks, Stephanie C, Kwame Okrah, Joseph N Paulson, John Quackenbush,
Rafael A Irizarry, and Héctor Corrada Bravo. 2018. “Smooth Quantile
Normalization.” *Biostatistics* 19 (2): 185–98.

</div>

<div id="ref-Law2014-xq" class="csl-entry">

Law, Charity W, Yunshun Chen, Wei Shi, and Gordon K Smyth. 2014. “Voom:
Precision Weights Unlock Linear Model Analysis Tools for
<span class="nocase">RNA-seq</span> Read Counts.” *Genome Biol.* 15 (2):
R29.

</div>

<div id="ref-McCarthy2009-qf" class="csl-entry">

McCarthy, Davis J, and Gordon K Smyth. 2009. “Testing Significance
Relative to a Fold-Change Threshold Is a TREAT.” *Bioinformatics* 25
(6): 765–71.

</div>

<div id="ref-Robinson2010-qp" class="csl-entry">

Robinson, Mark D, and Alicia Oshlack. 2010. “A Scaling Normalization
Method for Differential Expression Analysis of
<span class="nocase">RNA-seq</span> Data.” *Genome Biol.* 11 (3): R25.

</div>

<div id="ref-Ross-Innes2012-zy" class="csl-entry">

Ross-Innes, Caryn S, Rory Stark, Andrew E Teschendorff, Kelly A Holmes,
H Raza Ali, Mark J Dunning, Gordon D Brown, et al. 2012. “Differential
Oestrogen Receptor Binding Is Associated with Clinical Outcome in Breast
Cancer.” *Nature* 481 (7381): 389–93.

</div>

<div id="ref-Zhang2008-ms" class="csl-entry">

Zhang, Yong, Tao Liu, Clifford A Meyer, Jérôme Eeckhoute, David S
Johnson, Bradley E Bernstein, Chad Nusbaum, et al. 2008. “Model-Based
Analysis of ChIP-Seq (MACS).” *Genome Biol.* 9 (9): R137.

</div>

</div>
