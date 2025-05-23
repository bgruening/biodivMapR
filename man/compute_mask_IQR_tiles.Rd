% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_mask_IQR_tiles.R
\name{compute_mask_IQR_tiles}
\alias{compute_mask_IQR_tiles}
\title{get samples for alpha and beta diversity mapping}
\usage{
compute_mask_IQR_tiles(
  feature_dir,
  feature_list,
  mask_dir,
  plots,
  weightIRQ = 4,
  filetype = "GTiff",
  nbCPU = 1,
  nbPixstats = 5e+06
)
}
\arguments{
\item{feature_dir}{character.}

\item{feature_list}{character.}

\item{mask_dir}{character.}

\item{plots}{list.}

\item{weightIRQ}{numeric.}

\item{filetype}{character.}

\item{nbCPU}{numeric.}

\item{nbPixstats}{numeric.}
}
\value{
mask_path_list
}
\description{
get samples for alpha and beta diversity mapping
}
