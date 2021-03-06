% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ci.R
\name{CI}
\alias{CI}
\alias{CI.default}
\alias{CI.tvirf}
\title{Confidence Intervals for Model Parameters of Objects in tvReg}
\usage{
CI(object, ...)

\method{CI}{default}(object, level = 0, runs = 0, tboot = NULL, ...)

\method{CI}{tvirf}(object, level = 0, runs = 0, tboot = NULL, ...)
}
\arguments{
\item{object}{Object of class \code{tvsure}, class \code{tvvar} or class \code{tvirf}.}

\item{...}{Other parameters passed to specific methods.}

\item{level}{Numeric, the confidence level required (between 0 and 1).}

\item{runs}{(optional) Number of bootstrap replications.}

\item{tboot}{Type of wild bootstrap, choices 'wild'(default), 'wild2'. Option 'wild' uses the
distribution suggested by Mammen (1993) in the wild resampling, while 'wild2' uses the standard
normal.}
}
\value{
an object of class \code{tvsure} with BOOT, Lower and Upper different from NULL.
}
\description{
CI is used to estimate the bootstrap confidence intervals for objects with class
attribute \code{tvlm}, \code{tvar}, \code{tvirf}, \code{tvsure}.
}
\examples{

##Calculation of confidence intervals for a tvLM model
tau <- seq(1:1000)/1000
beta <- data.frame(beta1 = sin(2*pi*tau), beta2= 2*tau)
X1 <- rnorm(1000)
X2 <- rchisq(1000, df = 4)
error <- rt(1000, df = 10)
y <- apply(cbind(X1, X2)*beta, 1, sum) + error
data <- data.frame(y = y, X1 = X1, X2 = X2)
model.tvlm <-  tvLM(y~0+X1+X2, data = data)
tvci <- CI(model.tvlm, level = 0.95, runs = 30)
##Once the first confidence interval is calculated, the same resamples are used for other
##confidence intervals, which makes the process faster for consecutives calls of function CI.
tvci2 <- CI (tvci, level = 0.80)
plot(tvci)

##Calculation of confidence intervals for a tvSURE model
data( "Kmenta", package="systemfit" )
eqDemand <- consump ~ price + income
eqSupply <- consump ~ price + farmPrice + trend
system <- list( demand = eqDemand, supply = eqSupply )
tvfgls1.fit <- tvSURE(system, data = Kmenta, method="tvFGLS")

##Calculate 95\% confidence interval of our object using a resampling of size 100
tvfgls95.fit <- CI (tvfgls1.fit, level = 0.95, runs = 50)

}
\references{
Chen, X. B., Gao, J., Li, D., and Silvapulle, P (2017) Nonparametric estimation and 
forecasting for time-varying coefficient realized volatility models,
\emph{Journal of Business \& Economic Statistics}, online, 1-13.

Mammen, E (1993) Bootstrap and wild bootstrap for high dimensional linear models,
\emph{ Annals of Statistics}, 21, 255-285.
}
\seealso{
\code{\link{tvLM}}, \code{\link{tvAR}}, \code{\link{tvVAR}},
\code{\link{tvSURE}}
}
