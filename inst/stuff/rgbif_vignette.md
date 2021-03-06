<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{Tutorial for the new GBIF API}
-->

rgbif vignette - Seach and retrieve data from the Global Biodiverity Information Facilty (GBIF)
======

## About the package

`rgbif` is an R package to search and retrieve data from the Global Biodiverity Information Facilty (GBIF). `rgbif` wraps R code around the [GBIF API][gbifapi] to allow you to talk to GBIF from R. 

********************

## Install rgbif and dependencies


```r
install.packages("devtools")
library(devtools)
install_github("rgbif", "ropensci", ref = "newapi")
```


## Load rgbif and dependencies


```r
library(rgbif)
library(XML)
library(RCurl)
library(plyr)
library(ggplot2)
library(maps)
```


********************

## Get number of occurrences for a set of search parameters

### Search by type of record, all observational in this case


```r
occ_count(basisOfRecord = "OBSERVATION")
```

```
[1] 286071783
```


### Records for **Puma concolor** with lat/long data (georeferened) only


```r
occ_count(nubKey = 2435099, georeferenced = TRUE)
```

```
[1] 2541
```


### All georeferenced records in GBIF


```r
occ_count(georeferenced = TRUE)
```

```
[1] 3.55e+08
```


### Records from Denmark


```r
occ_count(country = "DENMARK")
```

```
[1] 8628822
```


### Records from France


```r
occ_count(hostCountry = "FRANCE")
```

```
[1] 17272175
```


### Number of records in a particular dataset


```r
occ_count(datasetKey = "9e7ea106-0bf8-4087-bb61-dfe4f29e0f17")
```

```
[1] 4591
```


### All records from 2012


```r
occ_count(year = 2012)
```

```
[1] 31483292
```


### Records for a particular dataset, and only for preserved specimens


```r
occ_count(datasetKey = "8626bd3a-f762-11e1-a439-00145eb45e9a", basisOfRecord = "PRESERVED_SPECIMEN")
```

```
[1] 550849
```


********************

## Get possible values to be used in taxonomic rank arguments in functions


```r
taxrank()
```

```
[1] "kingdom"       "phylum"        "class"         "order"        
[5] "family"        "genus"         "species"       "infraspecific"
```


********************

## Search for taxon information

### Search for a genus 


```r
head(name_lookup(query = "Cnaemidophorus", rank = "genus", return = "data"))
```

```
        key  nubKey parentKey        parent  kingdom     phylum   clazz
1 116755723 1858636 110614854 Pterophoridae Animalia Arthropoda Insecta
2   1858636 1858636      8863 Pterophoridae Animalia Arthropoda Insecta
3 125802004 1858636 125793784 Pterophoridae     <NA>       <NA> Insecta
4 124531302 1858636        NA          <NA>     <NA>       <NA>    <NA>
5 126862804 1858636 126783981 Pterophoridae Animalia Arthropoda Insecta
6 115123697 1858636        NA          <NA>     <NA>       <NA>    <NA>
        order        family          genus kingdomKey phylumKey  classKey
1 Lepidoptera Pterophoridae Cnaemidophorus  116630539 116762374 116686069
2 Lepidoptera Pterophoridae Cnaemidophorus          1        54       216
3 Lepidoptera Pterophoridae Cnaemidophorus         NA        NA 125831175
4        <NA>          <NA> Cnaemidophorus         NA        NA        NA
5 Lepidoptera Pterophoridae Cnaemidophorus  126774927 126774928 126775138
6        <NA>          <NA> Cnaemidophorus         NA        NA        NA
   orderKey familyKey  genusKey  canonicalName       authorship   nameType
1 116843281 110614854 116755723 Cnaemidophorus Wallengren, 1862 WELLFORMED
2       797      8863   1858636 Cnaemidophorus Wallengren, 1862 WELLFORMED
3 125810165 125793784 125802004 Cnaemidophorus Wallengren, 1862 WELLFORMED
4        NA        NA 124531302 Cnaemidophorus                  WELLFORMED
5 126775421 126783981 126862804 Cnaemidophorus                  WELLFORMED
6        NA        NA 115123697 Cnaemidophorus                  WELLFORMED
   rank numOccurrences
1 GENUS              0
2 GENUS              0
3 GENUS              0
4 GENUS              0
5 GENUS              0
6 GENUS              0
```


### Search for the class mammalia


```r
head(name_lookup(query = "mammalia")$data)
```

```
        key nubKey parentKey        parent   phylum         clazz
1 125798198    359 125828859      Chordata Chordata      Mammalia
2 116665331    359 116842680      Chordata Chordata      Mammalia
3       359    359        44      Chordata Chordata      Mammalia
4 125826646    359 125828859      Chordata Chordata      Mammalia
5 125775548    359 125775547 Macroscelidea Chordata Macroscelidea
6 102402290    359 102545028      Chordata Chordata      Mammalia
  phylumKey  classKey canonicalName     authorship   nameType  rank
1 125828859 125798198      Mammalia                WELLFORMED CLASS
2 116842680 116665331      Mammalia Linnaeus, 1758 WELLFORMED CLASS
3        44       359      Mammalia Linnaeus, 1758 WELLFORMED CLASS
4 125828859 125826646      Mammalia Linnaeus, 1758 WELLFORMED CLASS
5 116842680 125775547      Mammalia                WELLFORMED ORDER
6 102545028 102402290      Mammalia                WELLFORMED CLASS
  numOccurrences  kingdom kingdomKey    order  orderKey
1              0     <NA>         NA     <NA>        NA
2              0 Animalia  116630539     <NA>        NA
3              0 Animalia          1     <NA>        NA
4              0     <NA>         NA     <NA>        NA
5              0 Animalia  116630539 Mammalia 125775548
6              0 Animalia  101719444     <NA>        NA
```


### Look up the species Helianthus annuus


```r
head(name_lookup("Helianthus annuus", rank = "species")$data)
```

```
        key  nubKey parentKey     parent       kingdom     order
1 116845199 3119195 116853573 Helianthus       Plantae Asterales
2   3119195 3119195   3119134 Helianthus       Plantae Asterales
3 125790787 3119195 125809269 Helianthus          <NA> Asterales
4 106239436 3119195 106239325 Helianthus Viridiplantae Asterales
5 121635316 3119195 124573711 Helianthus          <NA>      <NA>
6 111449704 3119195 111449703 Helianthus       Plantae      <NA>
      family      genus kingdomKey  orderKey familyKey  genusKey
1 Asteraceae Helianthus  116668764 110610447 116856030 116853573
2 Asteraceae Helianthus          6       414      3065   3119134
3 Asteraceae Helianthus         NA 125833882 125799038 125809269
4 Asteraceae Helianthus  106147210 106237428 106237535 106239325
5       <NA> Helianthus         NA        NA        NA 124573711
6 Compositae Helianthus  111449174        NA 111442813 111449703
      canonicalName authorship   nameType    rank numOccurrences
1 Helianthus annuus         L. WELLFORMED SPECIES              0
2 Helianthus annuus         L. WELLFORMED SPECIES              0
3 Helianthus annuus         L. WELLFORMED SPECIES              0
4 Helianthus annuus            WELLFORMED SPECIES              0
5 Helianthus annuus            WELLFORMED SPECIES              0
6 Helianthus annuus         L. WELLFORMED SPECIES              0
         phylum         clazz phylumKey  classKey
1          <NA>          <NA>        NA        NA
2 Magnoliophyta Magnoliopsida        49       220
3          <NA>          <NA>        NA        NA
4  Streptophyta          <NA> 106171079        NA
5          <NA>          <NA>        NA        NA
6 Spermatophyta Dicotyledones 111449175 111449177
```


********************

## Get data for a single occurrence. Note that data is returned as a list, with slots for metadata and data, or as a hierarchy, or just data.

### Just data 


```r
occ_get(key = 773433533, return = "data")
```

```
                  name       key longitude latitude
1 Helianthus annuus L. 773433533      -117    32.85
```


### Just taxonomic hierarchy


```r
occ_get(key = 773433533, return = "hier")
```

```
                  name     key    rank
1              Plantae       6 kingdom
2        Magnoliophyta      49  phylum
3        Magnoliopsida     220   clazz
4            Asterales     414   order
5           Asteraceae    3065  family
6           Helianthus 3119134   genus
7 Helianthus annuus L. 3119195 species
```


### All data, or leave return parameter blank


```r
occ_get(key = 773433533, return = "all")
```

```
$hierarch
                  name     key    rank
1              Plantae       6 kingdom
2        Magnoliophyta      49  phylum
3        Magnoliopsida     220   clazz
4            Asterales     414   order
5           Asteraceae    3065  family
6           Helianthus 3119134   genus
7 Helianthus annuus L. 3119195 species

$data
                  name       key longitude latitude
1 Helianthus annuus L. 773433533      -117    32.85
```


### Get many occurrences. `occ_get` is vectorized


```r
occ_get(key = c(773433533, 101010, 240713150, 855998194, 49819470), return = "data")
```

```
                                   name       key longitude latitude
1                  Helianthus annuus L. 773433533   -117.00    32.85
2  Platydoras costatus (Linnaeus, 1758)    101010    -70.07    -4.35
3                              Pelosina 240713150    163.58   -77.57
4       Sciurus vulgaris Linnaeus, 1758 855998194     12.04    58.41
5 Phlogophora meticulosa Linnaeus, 1758  49819470     13.28    55.72
```


********************

## Maps

### Static map using the ggplot2 package

Make a map of **Puma concolor** occurrences


```r
key <- name_backbone(name = "Puma concolor", kingdom = "plants")$speciesKey
dat <- occ_search(taxonKey = key, return = "data", limit = 300, minimal = FALSE)
gbifmap(input = dat)
```

![plot of chunk gbifmap1](figure/gbifmap1.png) 


[gbifapi]: http://data.gbif.org/tutorial/services
