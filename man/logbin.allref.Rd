\name{logbin.allref}
\alias{logbin.allref}
\title{
Parameterization for CEM Algorithm
}
\description{
A workhorse function for \code{\link{logbin}},
\code{logbin.allref} takes the formula and data for a
log-link binomial GLM and produces a list of all
parameterizations needed for the associated CEM algorithm.
}
\usage{
logbin.allref(object, data = environment(object), mono, start = NULL)
}
\arguments{
  \item{object}{
	a model \code{\link{formula}} or a
  \code{\link{terms}} object for the addreg model.
}
  \item{data}{
	a data frame created with
  \code{\link{model.frame}}. If another sort of object,
  \code{model.frame} is called first.
}
  \item{mono}{
	a vector indicating which terms should be
  restricted to have a monotonically non-decreasing
  relationship with the outcome.
}
  \item{start}{
	starting values for the parameters in the linear predictor.
}
}
\details{
In the CEM algorithms employed by \code{\link{logbin}}, the
parameter space is partitioned into a collection of
restricted parameter spaces (see Marschner (2014)).
\code{logbin.allref} finds the list of possible
parameterizations of each term in the model.

If a term \code{x} has a \code{TRUE} value for
\code{\link{is.factor}(x)}, \code{\link{is.character}(x)}
or \code{\link{is.logical}(x)}, it is considered to be a
categorical covariate. This has a
parameterization for each level of the factor.

Otherwise the covariate is considered to be continuous, in
which case it has two possible parameterizations, relating
to the minimum and maximum observed values.

If a covariate is restricted to be monotonic via the
\code{mono} argument, it has only one parameterization.

\code{\link{logbin}} considers all possible combinations of
the parameterizations of each covariate, and for each calls
\code{\link{logbin.design}} to create the appropriate
non-negative design matrix to be used in the EM algorithm.
}
\value{
A list with components: 
\item{allref}{a named list, with
one component for each term in the model. Each component is
itself a list, whose components are each of the
parameterizations for that term. 

If \code{start} was specified, the first component for each
term will correspond to the parameterization specified
by \code{start}.} 
\item{terms}{the \code{\link{terms}} component of \code{object}.}
\item{data}{the object passed into the \code{data}
argument, or the result of calling \code{\link{model.frame}} with \code{data}.}
\item{monotonic}{a named logical vector indicating which
components of \code{terms} are restricted to be
monotonically non-decreasing.}
\item{start.new}{a reparameterized version of \code{start}, corresponding
to the first parameterization in \code{allref}. \code{NULL} if \code{start}
was not supplied.}
}
\references{
Marschner, I.C. and A.C. Gillett (2012): "Relative risk regression: reliable
and flexible methods for log-binomial models," \emph{Biostatistics}, 13, 179--192.

Marschner, I.C. (2014): "Combinatorial EM algorithms,"
\emph{Statistics and Computing}, 24, 921--940.
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\seealso{
\code{\link{logbin}}
}
\keyword{ misc }