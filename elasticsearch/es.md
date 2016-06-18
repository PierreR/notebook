% Elastic Search
% Pierre Radermecker

* ES only keeps one version of a document


Automatic index creation by generating a "mapping"

All documents live in an index.  An index is roughtly the same as a database which mean it is just a namespace. A type is like a table, a collection of similar thing. A document is like a row and a field is similar to a column.

Everything is stored in an inversed index.

a namespace
* index
* index type

By default each index is divided in 5 pieces called Shards. A document will live on a single shard + by default on replica for each shard.