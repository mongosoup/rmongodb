% Generated by roxygen2 (4.0.2): do not edit by hand
\name{mongo.aggregation}
\alias{mongo.aggregation}
\title{Aggregation pipeline}
\usage{
mongo.aggregation(mongo, ns, pipeline, explain = NULL, allowDiskUse = NULL,
  cursor = NULL, ...)
}
\arguments{
\item{mongo}{(\link{mongo}) A mongo connection object.}

\item{ns}{(string) The namespace of the collection in which to find distinct
keys.}

\item{pipeline}{(\link{list} of \link{mongo.bson} objects) representing aggregation query pipeline.
Alternately, \code{pipeline} may be a \link{list} of \link{list} which will be converted to a mongo.bson list object by
\code{\link{mongo.bson.from.list}()}.

Alternately, \code{pipeline} may be a \link{list} of valid JSON \link{character} strings which will be converted to a
mongo.bson object by \code{\link{mongo.bson.from.JSON}()}.}

\item{explain}{(\link{logical}) Optional, MongoDB 2.6+. Specifies to return the information on the processing of the pipeline. References above.}

\item{allowDiskUse}{(\link{logical}) Optional, MongoDB 2.6+. Enables writing to temporary files. When set to true, aggregation stages can write data to the _tmp subdirectory in the dbPath directory.}

\item{cursor}{(\link{mongo.bson}) Optional, MongoDB 2.6+. Specify a document that contains options that control the creation of the cursor object.}

\item{...}{Arguments to be passed to methods, such as \link{mongo.bson.to.list}, \link{fromJSON}
Unfortunately, current underlying mongo-c-driver can return BSON from aggreagation camand. Cursors are not supported.

Alternately, \code{cursor} may be a list which will be converted to a
mongo.bson object by \code{\link{mongo.bson.from.list}()}.

Alternately, \code{cursor} may be a valid JSON character string which will be converted to mongo.bson object by \code{\link{mongo.bson.from.JSON}()}.}
}
\value{
NULL if the command failed.  \code{\link{mongo.get.err}()} may be
MONGO_COMMAND_FAILED.

\link{mongo.bson} The result of aggregation.
}
\description{
Aggregation pipeline
}
\details{
See
\url{http://docs.mongodb.org/manual/reference/command/aggregate/}
\url{http://docs.mongodb.org/manual/core/aggregation-pipeline/}.
}
\examples{
# using the zips example data set
mongo <- mongo.create()
# insert some example data
data(zips)
colnames(zips)[5] <- "orig_id"
ziplist <- list()
ziplist <- apply( zips, 1, function(x) c( ziplist, x ) )
res <- lapply( ziplist, function(x) mongo.bson.from.list(x) )
if (mongo.is.connected(mongo)) {
    mongo.insert.batch(mongo, "test.zips", res )
    pipe_1 <- mongo.bson.from.JSON('{"$group":{"_id":"$state", "totalPop":{"$sum":"$pop"}}}')
    cmd_list <- list(pipe_1)
    res <- mongo.aggregation(mongo, "test.zips", cmd_list)
}
mongo.destroy(mongo)
}
\seealso{
\code{\link{mongo.command}},\cr
\code{\link{mongo.simple.command}},\cr \code{\link{mongo.find}},\cr
\link{mongo}.
}

