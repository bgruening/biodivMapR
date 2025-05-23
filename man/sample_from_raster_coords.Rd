% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample_from_raster_coords.R
\name{sample_from_raster_coords}
\alias{sample_from_raster_coords}
\title{sample set of pixels defined by row and col from raster data}
\usage{
sample_from_raster_coords(input_rast, xy, input_mask = NULL)
}
\arguments{
\item{input_rast}{SpatRaster. raster to extract data from}

\item{xy}{data.frame coordinates.}

\item{input_mask}{SpatRaster. mask corresponding to raster to extract data from}
}
\value{
rast_sample dataframe. pixel/plot info extracted from input_rast
}
\description{
sample set of pixels defined by row and col from raster data
}
