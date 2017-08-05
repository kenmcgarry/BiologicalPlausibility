# Biological Plausibility
Bioinformatics algorithms need the ability to assess the relevance and biological plausibility of their discoveries.

The past 20 years as seen the rapid development and application of numerous computational methods for analyzing bioinformatic data generated from genomic, proteomic and metabolic studies. This has taken place against the backdrop of ever increasing volumes of data with increasing complexity and sophistication. What perhaps has been lacking in the majority of methods is the ability to assess and relevance and biological plausibility of the machine learning discoveries. The term `biological plausibility` relates to a set of criteria defined by Bradford-Hill to assess the association between some biological entity and a disease or some risk factor, the `Bradford-Hill criteria` has seen much use over the years for epidemiological studies. The explanation for the link should be plausible and explicable according to the known facts of biology of the disease in question. 

![Alt Text](![system](https://user-images.githubusercontent.com/11558110/28996853-90e80f06-79ff-11e7-9837-e18648b93844.jpg)
)

We use three datasets of microarray expression data to demonstrate our methods. The Arapadosis Thaliana (a plant) experiments by Smith concern the  measurement of 800 genes from 22 samples during diurnal cycle extracted from the leaves and examines the synthesis and functions of enzymes of starch metabolism [Smith2004]. We also use two breast cancer data sets by West and Hedenfalk [West2001,Hedenfalk2001]. The Hedenfalk data examines the different groups of genes (3,226 genes ) expressed by breast cancers with BRCA1 mutations and breast cancers with BRCA2 mutations from 16 samples. The West data explores the hypothesis that breast tumors can be discriminated on the basis of estrogen receptor status and also on the categorized lymph node status, using Affymetrix arrays with 3,883 genes from 49 samples.

In this work we present  a new method called Biologically Plausible Clustering (BPC) for computing a global relevance measure for clustering genes and determining their biological meaning.

In our work we incorporate information theoretic approaches for the assessment and biological validity of modules discovered by the clustering process. The use of ontologies (within reason) play a major role in this assessment process. The intention, is not only to provide the best solution but to provide an explanation of why one answer should be preferred over the others. This is the approach favored by clinicians and biomedical scientists to understand the impact and significance of any bioinformatic discovery. 

## References

> Zuo, Y., Cui, Y., Li, R. and Ressom, H. [2017], Incorporating prior biological knowledge
for network-based diferential gene expression analysis using diferentially weighted graphical
LASSO, BMC Bioinformatics 18(99).

> Bradford-Hill, A. [1965], The environment and disease: association or causation?,
Proceedings of the Royal Society of Medicine. 58(5).

> Heritage, J., McDonald, S. and McGarry, K. [2017], Integrating association rules mined
from health-care data with ontological information for automated knowledge generation,
in The 17th UK Workshop on Computational Intelligence, UKCI-2017, University of
Cardiff, UK.

> McGarry, K. [2013], Discovery of functional protein groups by clustering community links and integration of ontological knowledge, Expert Systems with Applications,40(13), 5101-5112.

> Swaen, G. and Amelsvoort, L. [2009], Applying the bradford hill criteria in the 21st century:
How data integration has changed causal inference in molecular epidemiology, Journal of
Clinical Epidemiology 62(3), 270-277.

> Stegmayer, G., Milone, D., Kamenetzky, L., Lopez, M. and Carrari, F. [2012], A biologically
inspired validity measure for comparison of clustering methods over metabolic data sets,
IEEE/ACM transactions on computational biology and bioinformatics 9(3), 706-716.

> Schriml, L., Arze, C., Nadendla, S., Chang, Y.-W., Mazaitis, M., Felix, V., Feng, G. and
Kibbe, W. [2012], Disease ontology: a backbone for disease semantic integration', Nucleic
Acids Research 40, D940-D946.

> West, M., Blanchette, C., Dressman, H., Huang, E., Ishida, S., Spang, R., Zuzan, H., Olson, J., Marks,
J. and Nevins, J. [2001], Predicting the clinical status of human breast cancer by using gene expression
profiles, 98(20), 1146211467

> Hedenfalk, I., Duggan, D., Chen, Y., Radmacher, M., Bittner, M., Simon, R., Meltzer, P., Gusterson,
B., Esteller, M., Raeld, M., Yakhini, Z., Ben-Dor, A., Dougherty, E., Kononen, J., Bubendorf, L.,
Fehrle, W., Pittaluga, S., Gruvberger, S., Loman, N., Johannsson, O., Olsson, H., Wilfond, B., Sauter,
G., Kallioniemi, O.-P., Borg, k. and Trent, J. [2001], Gene-expression proles in hereditary breast
cancer, New England Journal of Medicine 344(8), 539-548.

> Smith, S., Fulton, D., Chia, T., Thorneycroft, D., Chapple, A., Dunstan, H., Hylton, C., Zeeman, S.
and Smith, A. [2009], Diurnal changes in the transcriptom encoding enzymes of starch metabolism
provide evidence for both transcriptional and posttranscriptional regulation of starch metabolism in
arabidopsis leaves., Plant Physiol. 136, 2687-2699.

## Project last updated August 4th 2017
