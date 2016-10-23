



#' Cryptonator.currencies
#'
#' Returns all the valid currency pairs
#'
#' @return data.frame
#' \itemize{
#'  \item code currency code
#'  \item name description of currency
#'  \item statuses primary or secondary (or both)
#' }
#' @examples
#' \dontrun{
#' Cryptonator.currencies()
#' }
#' @export
Cryptonator.currencies <- function() {
  json <- getURL("https://api.cryptonator.com/api/currencies")
  res <- jsonlite::fromJSON(json)
  res$rows
}

#' Cryptonator.simple
#'
#' Returns actual volume-weighted price, total 24h volume and the price change
#' from Cryptonator.
#'
#' @param ticker a vector of tickers. Tickers are hyphen-separated
#'   currency pairs (e.g. btc-usd, xmr-btc).  Note that if you provide more than
#'   one ticker, a separate request will be made for each ticker.
#' @return data.frame with
#' \itemize{
#'  \item ticker
#'  \item base base currency code
#'  \item target counter currency code
#'  \item price volume-weighted price
#'  \item volume total trade volume for the last 24 hours (Volume is displayed
#'  only for the cryptocurrencies that are actually traded on online exchanges.)
#'  \item change past hour price change
#'  \item timestamp POSIXct timestamp in local timezone
#' }
#' @author gsee
#' @examples
#' \dontrun{
#' Cryptonator.simple("btc-usd")
#' Cryptonator.simple(c("btc-usd", "xmr-btc", "xmr-usd"))
#' }
#' @export
Cryptonator.simple <- function(ticker="btc-usd") {
  ticker <- sub("/", "-", ticker)
  if (length(ticker) > 1) {
    L <- lapply(ticker, Cryptonator.simple)
    return(do.call(rbind, L))
  }

  base.url <- "https://api.cryptonator.com/api/ticker/"
  uri <- paste0(base.url, ticker)
  json <- getURL(uri)
  res <- jsonlite::fromJSON(json)

  if (!res$success) return(res$error)

  timestamp <- as.POSIXct(res$timestamp, origin=as.Date("1970-01-01"))
  as.data.frame(c(ticker=ticker, res$ticker, list(timestamp=timestamp)))
}


#' Cryptonator.complete
#'
#' Returns actual volume-weighted price, total 24h volume, rate change as well
#' as prices and volumes across all connected exchanges.
#'
#' @param ticker a single ticker (e.g. "btc-usd").  See
#'   \code{\link{Cryptonator.currencies}} for a list of valid tickers
#' @return a list with 2 components
#' \itemize{
#'   \item summary same information returned by \code{\link{Cryptonator.simple}}
#'   \item detail a data.frame with price and volume by exchange.
#' }
#' @author gsee
#' @examples
#' \dontrun{
#' Cryptonator.complete("btc-usd")
#' Cryptonator.complete("xmr-btc")
#' }
#' @export
Cryptonator.complete <- function(ticker="btc-usd") {
  ticker <- sub("/", "-", ticker)
  base.url <- "https://api.cryptonator.com/api/full/"
  uri <- paste0(base.url, ticker)
  json <- getURL(uri)
  res <- jsonlite::fromJSON(json)

  if (!res$success) return(res$error)

  timestamp <- as.POSIXct(res$timestamp, origin=as.Date("1970-01-01"))

  smry <- as.data.frame(c(ticker=ticker, head(res$ticker, -1), list(timestamp=timestamp)))
  dat <- res$ticker$markets
  list(summary=smry, detail=dat[order(dat$volume, decreasing=TRUE),])
}


#' getQuote.cryptonator
#' 
#' a "method" for \code{quantmod::getQuote}
#' 
#' This is simply a wrapper around \code{\link{Cryptonator.simple}} or 
#'  \code{\link{Cryptonator.complete}} to allow calling \code{quantmod::getQuote}
#'  with \code{src="cryptonator"}
#' 
#' @param Symbols a ticker or vector of tickers (only supported for 
#'  what="simple"). Tickers are hyphen-separated currency pairs (e.g. "btc-usd")
#' @param what either "simple" or "complete" depending on whether you want to 
#'  get back a summary or details for all exchanges.
#' @return see \code{\link{Cryptonator.simple}} or \code{\link{Cryptonator.complete}}
#' @author gsee
#' @examples 
#' \dontrun{
#' library(quantmod)
#' getQuote("XMR-BTC", src="cryptonator")
#' }
#' @export
getQuote.cryptonator <- function(Symbols, what=c("simple", "complete")) {
  what <- tolower(what)
  what <- match.arg(what)
  if (length(Symbols) > 1L & what=="complete") {
    stop('must use what="simple" when supplying more than one ticker.')
  }
  do.call(paste("Cryptonator", what, sep="."), list(ticker=Symbols))
}
