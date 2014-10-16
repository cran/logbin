\name{logbin.smooth.allref}
\alias{logbin.smooth.allref}
\title{
Parameterization for CEM Algorithm with Smooth Terms
}
\description{
A workhorse function for \code{\link{logbin.smooth}},
\code{logbin.smooth.allref} takes the formula and data
for a log-link binomial GLM with smooth terms and produces a
list of all parameterizations needed for the CEM algorithm
associated with the semi-parametric part of the model.
}
\usage{
logbin.smooth.allref(object, data = environment(object), mono, 
  logbin.smooth.spec, num.knots)
}
\arguments{
  \item{object}{
	a \code{\link{terms}} object for the "\code{fake.formula}"
		associated with an \code{\link{logbin.smooth}} model
		(see \code{\link{interpret.logbin.smooth}}).
}
  \item{data}{
	a data frame created with \code{\link{get_all_vars}} for
	the \code{fake.formula}.
}
  \item{mono}{
	a vector indicating which terms in
  \code{fake.formula} should be restricted to have a
  monotonically non-decreasing relationship with the
  outcome. May be specified as names or indices of the
  terms.
}
  \item{logbin.smooth.spec}{
	details of the smooth terms in the formula; this must 
	be in the format returned
	by \code{\link{interpret.logbin.smooth}}.
}
  \item{num.knots}{
	a vector containing the number of interior knots to be used for
	each smooth term in the model (\code{NA} for \code{\link{Iso}} terms).
}
}
\details{
Semi-parametric models in \code{\link{logbin.smooth}} use an extended CEM algorithm 
by partioning the parameter space associated with the smooth terms into a
collection of restricted parameter spaces, each corresponding to a
restricted fully parametric model that can be fit using \code{\link{logbin}}.
This is a workhorse function that creates the list of possible parameterizations of
each smooth term.

Isotonic terms and monotonic B-spline terms have only one parameterization: where
the maximum fitted value occurs at the maximum of the covariate range.

Unrestricted B-spline terms have \code{k + 3} parameterizations each
(where \code{k} is the number of internal knots), corresponding to the possible 
locations of the maximum of the smooth curve along the range of the covariate.

\code{\link{logbin.smooth}} considers all possible combinations of the number of 
knots for each smooth term, and all possible combinations of the associated
parameterizations, and \code{\link{logbin.smooth.design}} creates the appropriate
formula and design matrix to be used in the call to \code{\link{logbin}}.
}
\value{
A list with components:
\item{allref}{a named list, with one component for each smooth term in
the model. Each component is itself a list, whose components
are each of the parameterizations for that term.}
\item{terms}{the \code{\link{terms}} component of \code{object}.}
\item{data}{the object passed into the \code{data} argument.}
\item{monotonic}{a named logical vector indicating which
components of \code{terms} are restricted to be
monotonically non-decreasing.}
}
\references{
Donoghoe, M.W. and I.C. Marschner (2014): "Smooth semi-parametric adjustment of rate 
differences, risk differences and relative risks," \emph{Proceedings of the 29th 
International Workshop on Statistical Modelling}, 1, 105--110.
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\seealso{
\code{\link{logbin.smooth}}
}
\keyword{ misc }
