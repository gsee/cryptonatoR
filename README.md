# cryptonatoR
cryptonatoR is an R API to market data provided by 
<a href="https://www.cryptonator.com">Cryptonator.com</a>:  
"Cryptonator provides unique volume of cryptocurrency exchange rates data, 
which is delivered in easy-to-integrate JSON format via simple HTTPS requests. 
Prices are updated every 30 seconds, covering 300+ cryptocurrencies across 58 
exchanges."  

See <a href="https://www.cryptonator.com/api">cryptonator.com/api</a> for more.

Installation:
````
devtools::install_github("gsee/cryptonatoR")
````

Example usage:  
````
Cryptonator.currencies()
Cryptonator.simple("btc-usd")
Cryptonator.complete("btc-usd")

#includes a getQuote "method"
library(quantmod)
getQuote("XMR-BTC", src="cryptonator")
getQuote("XMR-BTC", src="cryptonator", what="complete")
````
  
<a href="http://www.wtfpl.net/"><img
       src="http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png"
       width="80" height="15" alt="WTFPL" /></a>
       

*Cryptonator<sup>TM</sup> is a brand name that is owned by Global Technical
Enterprise Ltd.  This software is in no way affiliated, endorsed, or
approved by Cryptonator<sup>TM</sup>, Global Technical Enterprise Ltd, or any 
of its affiliates.*