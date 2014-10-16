\name{logbin-package}
\alias{logbin-package}
\docType{package}
\title{
Relative Risk Regression Using the Log Binomial Model
}
\description{
Methods for fitting log-link GLMs and GAMs for binomial data. The package uses EM-type
algorithms with more stable convergence properties than standard methods.
}
\details{
\tabular{ll}{
Package: \tab logbin\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-10-16\cr
License: \tab GPL (>= 2)\cr
}
This package provides methods to fit generalized linear models (GLMs) and generalized additive
models (GAMs) with log-link functions to binomial data.
It has two primary functions: \code{\link{logbin}} and \code{\link{logbin.smooth}}, 
together with various supporting functions.

It is useful in two main situations. The first is when a standard GLM routine, such as
\code{\link{glm}}, fails to converge with such a model. The second is when a flexible
semi-parametric component is desired in these models. One of the main purposes of this
package is to provide parametric and semi-parametric adjustment of relative risks.

The computational method is a combinatorial EM algorithm (Marschner, 2014), 
which accommodates the parameter constraints and is more stable than iteratively
reweighted least squares. A collection of restricted parameter spaces is defined
which covers the full parameter space, and the EM algorithm is applied within each
restricted parameter space in order to find a collection of restricted maxima of
the log-likelihood function, from which can be obtained the global maximum over the
full parameter space.

The methodology implemented in this package is presented in Marschner and Gillett (2012) 
and Donoghoe and Marschner (2014).
}
\author{
Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}

Maintainer: Mark Donoghoe \email{Mark.Donoghoe@mq.edu.au}
}
\references{
Donoghoe, M.W. and I.C. Marschner (2014): "Smooth semi-parametric adjustment of rate 
differences, risk differences and relative risks," \emph{Proceedings of the 29th 
International Workshop on Statistical Modelling}, 1, 105--110.

Marschner, I.C. and A.C. Gillett (2012): "Relative risk regression: reliable
and flexible methods for log-binomial models," \emph{Biostatistics}, 13, 179--192.

Marschner, I.C. (2014): "Combinatorial EM algorithms,"
\emph{Statistics and Computing}, 24, 921--940.
}
\keyword{ package }
\keyword{ regression }
\seealso{
\code{\link{glm}}
}
\examples{
## For examples, see example(logbin) and example(logbin.smooth)
}
