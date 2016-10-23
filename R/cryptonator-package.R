#' cryptonatoR package: An \R interface to the Cryptonator(tm) REST API
#'
#' \emph{Cryptonator(tm) is a brand name that is owned by Global Technical
#' Enterprise Ltd.  This software is in no way affiliated, endorsed, or
#' approved by Cryptonator(tm), Global Technical Enterprise Ltd, or any of its
#' affiliates.}
#'
#' The \pkg{cryptonatoR} package provides functions to access the free rate
#' quotes provided by Cryptonator(tm).
#'
#' @name cryptonatoR
#' @aliases cryptonatoR cryptonatoR-package
#' @docType package
#' @author Garrett See \email{gsee000@@gmail.com}
#' @references
#' \url{https://www.cryptonator.com}
#'
#' \url{https://www.cryptonator.com/api}
#' @keywords package programming IO
#' @examples
#' \dontrun{
#' head(Cryptonator.currencies())
#' Cryptonator.simple("btc-usd")
#' Cryptonator.complete("btc-usd")
#' }
NULL

#' @importFrom utils head
#' @importFrom jsonlite fromJSON
#' @importFrom RCurl getURL
NULL
