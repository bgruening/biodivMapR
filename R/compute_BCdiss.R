#' compute bray curtis dissimilarity matrix corresponding to a list of kernels
#' (rows) defined by their spectral species (columns)
#' SSDList is a list containing spectral species distribution for two sets of kernels
#' pcelim is the threshold for minimum contributin of a spctral species to be kept
#
#' @param SSDList list. list of 2 groups to compute BC dissimilarity from
#' @param pcelim numeric. minimum proportion required for a species to be included
#
#' @return MatBC matrix of bray curtis dissimilarity matrix
#' @importFrom dissUtils diss
#' @export

compute_BCdiss <- function(SSDList, pcelim=0.02) {
  # compute the proportion of each spectral species
  # Here, the proportion is computed with regards to the total number of sunlit pixels
  # One may want to determine if the results are similar when the proportion is computed
  # with regards to the total number of pixels (se*se)
  # however it would increase dissimilarity between kernels with different number of sunlit pixels
  # SSD <- lapply(SSDList,FUN = normalize_SSD, pcelim = pcelim)
  # matrix of bray curtis dissimilarity (size = nb kernels x nb kernels)
  MatBC <- dissUtils::diss(SSDList[[1]], SSDList[[2]], method = 'braycurtis')
  # EDIT 06-Feb-2019: added this to fix problem when empty kernels occur, leading to NA BC value
  # BCNA <- which(is.na(MatBC) == TRUE)
  # if (length(BCNA) > 0) MatBC[BCNA] <- 1
  return(MatBC)
}
