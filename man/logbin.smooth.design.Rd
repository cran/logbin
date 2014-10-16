\name{logbin.smooth.design}
\alias{logbin.smooth.design}
\title{
Construct Design Matrix for logbin.smooth Model
}
\description{
\code{logbin.smooth.design} constructs the design matrix and associated formula
for an \code{\link{logbin.smooth}} model, given a particular parameterization,
to be passed into \code{\link{logbin}} for fitting.

This is a workhorse function -- it would not normally be called directly.
}
\usage{
logbin.smooth.design(interpret, allref, design.knots, design.param)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{interpret}{
	the object returned by running \code{\link{interpret.logbin.smooth}}
	for the desired model, containing details of the smooth components.
}
  \item{allref}{
	the object returned by running \code{\link{logbin.smooth.allref}}
	for the desired model.
}
  \item{design.knots}{
	a vector containing the number of internal knots for each smooth
	term (\code{NA} for \code{Iso} terms).
}
  \item{design.param}{
	a vector of indices for a particular parameterization in 
	\code{allref$allref}. Each element corresponds to a smooth
	term in the model, and the value indicates which item in
	the associated list is the reference level for this
	parameterization.
}
}
\details{
For a particular combination of reference levels, \code{logbin.smooth.design}
constructs the associated design matrix and formula. Specifically, for \code{Iso} smooth
components, it creates the matrix of indicator covariates for increments between
levels. For \code{B} smooth components, it creates the basis functions using 
\code{\link[splines]{splineDesign}} and removing the column associated with
the reference level (see Donoghoe and Marschner (2014)).

The \code{formula} component is altered to include the terms in the design matrix,
and \code{allref$monotonic} is altered such that all of the smooth coefficients
are restricted to be non-negative, as required.
}
\value{
A list with components:
\item{formula}{an updated version of \code{interpret$full.formula}, with the
smooth terms removed and replaced by the names of their associated
basis components.}
\item{data}{an updated version of \code{interpret$data}, with columns
for the basis functions of the smooth terms added.}
\item{monotonic}{an updated version of \code{allref$monotonic}, such that
the coefficients associated with the smooth terms for this parameterization
are constrained to be non-negative.}
\item{knots}{a list, with one component for each smooth term, containing
the knot vector for that term (\code{NA} for \code{Iso} terms).}
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
\code{\link{logbin.smooth}}, \code{\link{interpret.logbin.smooth}},
\code{\link{logbin.smooth.allref}}, \code{\link{logbin.design}}
}
\keyword{ models }
\keyword{ smooth }
