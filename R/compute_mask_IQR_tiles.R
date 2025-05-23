#' get samples for alpha and beta diversity mapping
#'
#' @param feature_dir character.
#' @param feature_list character.
#' @param mask_dir character.
#' @param plots list.
#' @param weightIRQ numeric.
#' @param filetype character.
#' @param nbCPU numeric.
#' @param nbPixstats numeric.
#'
#' @return mask_path_list
#' @importFrom progressr progressor handlers with_progress
#' @importFrom future.apply future_lapply
#' @importFrom future plan
#' @importFrom parallel makeCluster stopCluster
#' @export
#'
compute_mask_IQR_tiles <- function(feature_dir, feature_list, mask_dir, plots,
                                   weightIRQ = 4, filetype = 'GTiff', nbCPU = 1,
                                   nbPixstats = 5e6){

  process_mask <- TRUE
  # first check missing masks
  mask_path <- file.path(mask_dir, paste0('mask_', names(plots), '_IQR.tiff'))
  tile_exists <- names(plots)[which(file.exists(mask_path))]
  mask_missing <- paste0('_', names(plots)[which(!file.exists(mask_path))], '_')
  if (length(mask_missing)==0){
    process_mask <- FALSE
    tile_exists <- names(plots)[which(file.exists(mask_path))]
  } else {
    # check if features also exist
    features_files <- lapply(X = feature_list, FUN = list.files, path = feature_dir)
    names(features_files) <- feature_list
    feat_exists <- list()
    # which features exist
    for (feat in feature_list)
      feat_exists[[feat]] <- unlist(lapply(X = mask_missing, FUN = grep, x = features_files[[feat]]))
    if (length(unlist(feat_exists))==0)
      process_mask <- FALSE
  }

  if (process_mask){
    # list files
    listfiles <- list.files(feature_dir, full.names = T)
    ##############################################################################
    # get number of pixels per tile
    # if (nbCPU==1){
      handlers("cli")
      suppressWarnings(with_progress({
        p <- progressr::progressor(steps = length(plots),
                                   message = 'get valid pixels from tiles')
        nbPixValid <- lapply(X = names(plots), FUN = get_valid_pixels,
                             listfiles = listfiles, p = p)}))
    # } else {
    #   message('get valid pixels from tiles')
    #   cl <- parallel::makeCluster(nbCPU)
    #   plan("cluster", workers = cl)
    #   nbPixValid <- future.apply::future_lapply(X = names(plots),
    #                                             FUN = get_valid_pixels,
    #                                             listfiles = listfiles,
    #                                             future.seed = TRUE)
    #   parallel::stopCluster(cl)
    #   plan(sequential)
    # }
    # get total number of pixels
    totalPixels <- sum(unlist(nbPixValid))
    ##############################################################################
    # get statistics on nbPixstats
    if (totalPixels<nbPixstats)
      nbPixstats <- totalPixels
    ratioStats <- nbPixstats/totalPixels
    pix2sel <- lapply(X = nbPixValid,
                      FUN = function(x, ratio){as.numeric(round(x*ratio))},
                      ratio = ratioStats)
    if (nbCPU==1){
      handlers("cli")
      suppressWarnings(with_progress({
        p <- progressr::progressor(steps = length(plots),
                                   message = 'compute stats')
        selpix <- mapply(FUN = get_samples_from_tiles,
                         plotID = names(plots), pix2sel = pix2sel,
                         MoreArgs = list(listfiles = listfiles,
                                         feat_list = feature_list,
                                         as.df = T,
                                         p = p),
                         SIMPLIFY = F)}))
    } else {
      message('compute stats')
      cl <- parallel::makeCluster(nbCPU)
      plan("cluster", workers = cl)
      selpix <- future.apply::future_mapply(FUN = get_samples_from_tiles,
                                            plotID = names(plots), pix2sel = pix2sel,
                                            MoreArgs = list(listfiles = listfiles,
                                                            feat_list = feature_list,
                                                            as.df = T),
                                            future.seed = T, SIMPLIFY = F)
      parallel::stopCluster(cl)
      plan(sequential)
    }
    # compute IQR
    selpixAll <- do.call(what = 'rbind', selpix)
    iqr_si <- lapply(X = selpixAll, FUN = biodivMapR::IQR_outliers, weightIRQ = weightIRQ)

    ##############################################################################
    # produce mask for each tile
    # if (nbCPU==1){
      handlers("cli")
      suppressWarnings(with_progress({

        p <- progressr::progressor(steps = length(plots),
                                   message = 'update mask')
        mask_path <- lapply(X = names(plots),
                            FUN = update_mask_from_tiles,
                            listfiles = listfiles,
                            iqr_si = iqr_si,
                            mask_dir = mask_dir,
                            p = p)}))
    # } else {
    #   message('update mask')
    #   cl <- parallel::makeCluster(nbCPU)
    #   plan("cluster", workers = cl)
    #   mask_path <- future.apply::future_lapply(X = names(plots),
    #                                            FUN = update_mask_from_tiles,
    #                                            listfiles = listfiles,
    #                                            iqr_si = iqr_si,
    #                                            mask_dir = mask_dir,
    #                                            future.seed = TRUE)
    #   parallel::stopCluster(cl)
    #   plan(sequential)
    # }
    notnullMask <- which(!unlist(lapply(X = mask_path, FUN = is.null)))
    tile_exists <- names(plots)[notnullMask]
    mask_path <- mask_path[notnullMask]
  }
  mask_path_list <- list('mask_path' = mask_path,
                         'tile_exists' = tile_exists)
  return(mask_path_list)
}
