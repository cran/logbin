\name{logbin}
\alias{logbin}
\title{
Log Binomial Regression
}
\concept{Binomial regression}
\concept{CEM algorithm}
\description{
\code{logbin} fits relative risk (log-link) binomial
regression models using a stable combinatorial EM algorithm.
}
\usage{
logbin(formula, mono = NULL, data, subset, na.action, start = NULL,
        offset, control = list(...), model = TRUE, warn = TRUE, ...)
}
\arguments{
  \item{formula}{
	an object of class "\code{\link{formula}}"
  (or one that can be coerced into that class): a symbolic
  description of the model to be fitted. The details of
  model specification are given under 'Details'.  Note that
  the model must contain an intercept, and 2nd-order terms
  (such as interactions) or above are currently not supported
  - see "Note".
}
  \item{mono}{
	a vector indicating which terms in
  \code{formula} should be restricted to have a
  monotonically non-decreasing relationship with the
  outcome. May be specified as names or indices of the
  terms.
}
  \item{data}{
	an optional data frame, list or environment
  (or object coercible by \code{\link{as.data.frame}} to a
  data frame) containing the variables in the model. If not
  found in \code{data}, the variables are taken from
  \code{environment(formula)}, typically the environment
  from which \code{logbin} is called.
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
  \item{start}{
	starting values for the parameters in the
  linear predictor.
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
	a logical value indicating whether \emph{model frame} 
	should be included as a component of the returned value.
}
  \item{warn}{
	a logical indicating if warnings should be
  provided for non-convergence or boundary values.
}
  \item{\dots}{
	arguments to be used to form the default
  \code{control} argument if it is not supplied directly.
}
}
\details{
\code{logbin} fits a generalized linear model (GLM) with a
binomial error distribution and log-link
function. Predictors are assumed to be continuous, unless
they are of class \code{\link{factor}}, or are character or
logical (in which case they are converted to
\code{factor}s). Specifying a predictor as monotonic using
the \code{mono} argument means that for continuous terms,
the associated coefficient will be restricted to be
non-negative, and for categorical terms, the coefficients
will be non-decreasing in the order of the factor
\code{levels}. This allows semi-parametric monotonic regression
functions, in the form of unsmoothed step-functions. For 
smooth regression functions see \code{\link{logbin.smooth}}.

As well as allowing monotonicity constraints, the function 
is useful when a standard GLM routine, such as
\code{glm}, fails to converge with a log-link
binomial model. If \code{glm} does achieve successful convergence,
and \code{logbin} converges to an interior point, then the two
results will be identical. However, as illustrated in one of 
the examples below, \code{glm} may still experience convergence 
problems even when \code{logbin} converges to an interior point. 
Note that if \code{logbin} converges to a boundary point, then it 
may differ slightly from \code{glm} even if \code{glm} successfully 
converges, because of differences in the definition of the parameter 
space. \code{logbin} produces valid fitted values for covariate 
values within the Cartesian product of the observed range of covariate 
values, whereas \code{glm} produces valid fitted values just 
for the observed covariate combinations (assuming it successfully 
converges). This issue is only relevant when \code{logbin} 
converges to a boundary point.

The computational method is a combinatorial EM algorithm
(Marschner (2014)) which accommodates the parameter
contraints in the model and is more stable than iteratively
reweighted least squares. A collection of restricted
parameter spaces is defined which covers the full parameter
space, and the EM algorithm is applied within each
restricted parameter space in order to find a collection of
restricted maxima of the log-likelihood function, from
which can be obtained the global maximum over the full
parameter space. See Marschner and Gillett (2012) for further
details.
}
\value{
\code{logbin} returns an object of class \code{"logbin"},
which inherits from classes \code{"glm"} and \code{"lm"}.
The function \code{\link{summary.logbin}} can be used 
to obtain or print a summary of the results.

The generic accessor functions \code{\link{coefficients}},
\code{fitted.values} and \code{residuals} can be used to
extract various useful features of the value returned by
\code{logbin}. Note that \code{effects} will not work.

An object of class \code{"logbin"} is a list containing the
same components as an object of class \code{"glm"} (see the
"Value" section of \code{\link{glm}}), but without
\code{contrasts}, \code{qr}, \code{R} or \code{effects}
components. It also includes: 
\item{loglik}{the maximized log-likelihood.}
\item{aic.c}{a small-sample corrected
version of Akaike's \emph{An Information Criterion}
(Hurvich, Simonoff and Tsai (1998)). This is used by
\code{\link{logbin.smooth}} to choose the optimal number of
knots for smooth terms.} 
\item{xminmax}{the minimum and maximum observed values
for each of the continuous covariates, to help define
the covariate space of the model.}

As well as:
\item{np.coefficients}{estimated coefficients associated
with the non-positive parameterization corresponding to the
MLE.} 
\item{nn.x}{non-negative model matrix associated with
\code{np.coefficients}.}  
}
\references{
Hurvich, C.M., J.S. Simonoff and C.-L. Tsai (1998): "Smoothing parameter 
selection in non-parametric regression using an improved Akaike 
information criterion,"
\emph{Journal of the Royal Statistical Society: Series B}, 60, 271--293.

Marschner, I.C. and A.C. Gillett (2012): "Relative risk regression: reliable
and flexible methods for log-binomial models," \emph{Biostatistics}, 13, 179--192.

Marschner, I.C. (2014): "Combinatorial EM algorithms,"
\emph{Statistics and Computing}, 24, 921--940.
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\note{
Due to the way the covariate space is defined in the CEM algorithm,
specifying interactions in the formula is not currently supported 
by \code{logbin}. 2-way interactions between factors can be
included by calculating a new factor term that has levels
corresponding to all possible combinations of the factor
levels. See the Example.
}
\examples{
require(glm2)
data(heart)
\donttest{
#======================================================
#  Model with periodic non-convergence when glm is used
#======================================================

start.p <- sum(heart$Deaths) / sum(heart$Patients)

fit.glm <- glm(cbind(Deaths, Patients-Deaths) ~ factor(AgeGroup) + factor(Severity)
  + factor(Delay) + factor(Region), family = binomial(log), 
  start = c(log(start.p), -rep(1e-4, 8)), data = heart, trace = TRUE, maxit = 100)

fit.logbin <- logbin(formula(fit.glm), data = heart, trace = 1)
## (Note that convergence may be sped up by specifying mono = c(1,2))

summary(fit.logbin)
}

#=============================
#  Model with interaction term
#=============================

heart$AgeSev <- 10 * heart$AgeGroup + heart$Severity

fit.logbin.int <- logbin(cbind(Deaths, Patients-Deaths) ~ factor(AgeSev)
  + factor(Delay) + factor(Region), data = heart, trace = 1, maxit = 100000)
  
summary(fit.logbin.int)
vcov(fit.logbin.int)
confint(fit.logbin.int)
summary(predict(fit.logbin.int, type = "response"))
\donttest{
anova(fit.logbin, fit.logbin.int, test = "Chisq")
}
}
\keyword{ models }
\keyword{ regression }
