\name{logbin.smooth}
\alias{logbin.smooth}
\title{
Smooth Log Binomial Regression
}
\description{
\code{logbin.smooth} fits log-link binomial
regression models using a stable CEM algorithm. It provides additional
flexibility over \code{\link{logbin}} by allowing for smooth 
semi-parametric terms.
}
\usage{
logbin.smooth(formula, mono = NULL, data, subset, na.action, offset, 
  control = list(...), model = TRUE, model.logbin = FALSE, ...)
}
\arguments{
  \item{formula}{
	an object of class "\code{\link{formula}}"
  (or one that can be coerced into that class): a symbolic
  description of the model to be fitted. The details of
  model specification are given under 'Details'.  Note that
  the model must contain an intercept, and 2nd-order terms
  (such as interactions) or above are not accepted (see \code{\link{logbin}}).
  
	Semi-parametric terms are included by using the \code{\link{B}}
	or \code{\link{Iso}} functions.
}
  \item{mono}{
	a vector indicating which terms in
  \code{formula} should be restricted to have a
  monotonically non-decreasing relationship with the
  outcome. May be specified as names or indices of the
  terms.
  
	Note that \code{Iso()} terms are always monotonic.
}
  \item{data}{
	an optional data frame, list or environment
  (or object coercible by \code{\link{as.data.frame}} to a
  data frame) containing the variables in the model. If not
  found in \code{data}, the variables are taken from
  \code{environment(formula)}, typically the environment
  from which \code{logbin.smooth} is called.
}
  \item{subset}{
	an optional vector specifying a subset of
  observations to be used in the fitting process.
}
  \item{na.action}{
  a function which indicates what should happen with the data
  contain \code{NA}s. The default is set be the \code{na.action}
  setting of \code{\link{options}}, and is \code{\link{na.fail}}
  if that is unset. The 'factory-fresh' default is \code{\link{na.omit}}.
  Another possible value is \code{NULL}, no action. Value
  \code{\link{na.exclude}} can be useful.
}
  \item{offset}{
	this can be used to specify an \emph{a
  priori} known component to be included in the linear
  predictor during fitting. This should be NULL or a
  \emph{non-positive} numeric vector of length equal to the number of cases.
  One or more \code{\link{offset}} terms can be included in
  the formula instead or as well, and if more than one is
  specified their sum is used. See
  \code{\link{model.offset}}.
}
  \item{control}{
	a list of parameters for controlling the
  fitting process, passed to
  \code{\link{logbin.control}}.
}
  \item{model}{
	a logical value indicating whether the \emph{model frame} 
	should be included as a component of the returned value.
}
  \item{model.logbin}{
	a logical value indicating whether the fitted \code{logbin}
	object should be included as a component of the returned value.
}
  \item{\dots}{
	arguments to be used to form the default
  \code{control} argument if it is not supplied directly.
}
}
\details{
\code{logbin.smooth} performs the same fitting process as \code{\link{logbin}},
providing a stable maximum likelihood estimation procedure for log-link
binomial GLMs, with the added flexibility of allowing semi-parametric
\code{B} and \code{Iso} terms (note that \code{logbin.smooth} will stop with an 
error if no semi-parametric terms are specified in the right-hand side of the \code{formula}; 
\code{\link{logbin}} should be used instead).

The method partitions the parameter space associated with the semi-parametric part of the
model into a sequence of constrained parameter spaces, and defines a fully parametric 
\code{logbin} model for each. The model with the highest log-likelihood is the MLE for 
the semi-parametric model (see Donoghoe and Marschner (2014)).
}
\value{
An object of class \code{"logbin.smooth"}, which contains the same objects as class
\code{"logbin"} (the same as \code{"\link{glm}"} objects, without \code{contrasts},
\code{qr}, \code{R} or \code{effects} components), as well as:
\item{model.logbin}{if \code{model.logbin} is \code{TRUE}; the \code{logbin} object
for the fully parametric model corresponding to the fitted model.}
\item{xminmax.smooth}{the minimum and maximum observed values for
each of the smooth terms in the model, to help define the 
covariate space.}
\item{full.formula}{the component from \code{\link{interpret.logbin.smooth}(formula)}
that contains the \code{formula} term with any additional arguments to the \code{B}
function removed.}
\item{knots}{a named list containing the knot vectors for each of the smooth
terms in the model.}
}
\references{
Donoghoe, M.W. and I.C. Marschner (2014): "Smooth semi-parametric adjustment of rate 
differences, risk differences and relative risks," \emph{Proceedings of the 29th 
International Workshop on Statistical Modelling}, 1, 105--110.

Marschner, I.C. (2014): "Combinatorial EM algorithms,"
\emph{Statistics and Computing}, 24, 921--940.
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\seealso{
\code{\link{logbin}}
}
\examples{
## Simple example
x <- c(0.3, 0.2, 0.0, 0.1, 0.2, 0.1, 0.7, 0.2, 1.0, 0.9)
y <- c(5, 4, 6, 4, 7, 3, 6, 5, 9, 8)
m1 <- logbin.smooth(cbind(y, 10-y) ~ B(x, knot.range = 0:2), mono = 1, trace = 1)
m2 <- logbin.smooth(cbind(y, 10-y) ~ Iso(x))
\donttest{
plot(m1)
plot(m2)
}
summary(predict(m1, type = "response"))
summary(predict(m2, type = "response"))
}
\keyword{ regression }
\keyword{ smooth }
