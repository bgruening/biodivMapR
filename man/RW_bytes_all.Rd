% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Lib_MapAlphaDiversity.R
\name{RW_bytes_all}
\alias{RW_bytes_all}
\title{identifies bytes where to read and write for each piece of image and all files}
\usage{
RW_bytes_all(SeqRead_SS, SeqWrite_SSD, SeqWrite_Sunlit, SeqRead_Mask = FALSE)
}
\arguments{
\item{SeqRead_SS}{list. coordinates corresponding to spectral species file}

\item{SeqWrite_SSD}{list. coordinates corresponding to spectral species distribution file}

\item{SeqWrite_Sunlit}{list. coordinates corresponding to sunlit proportion}

\item{SeqRead_Mask}{list. coordinates corresponding to optional mask file}
}
\value{
ReadWrite list of bytes coordinates for each read and write
}
\description{
identifies bytes where to read and write for each piece of image and all files
}
