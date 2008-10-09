MissingIndexes
================

A rather trivial tool to check foreign key indexes on database tables.

MissingIndexes::Basic
-----------------------

Scans through the database schema for columns that imply being foreign keys, 
but are not indexed.

MissingIndexes::References
----------------------------

Loads all AR::Base subclasses and scans for belongs_to associations.


Example
=======

    $ rake db:missing_indexes:show
    list_items:
     list_id

    $ rake db:missing_indexes:show_fix
    add_index :list_items, :list_id

TODO
====

* Make MissingIndexes::References deal with HABTM associations better.
* Runtime profiling of find_by_* type calls.
* Possibly check read/write balance to make intelligent indexing 
  recommendations... but that aint never gonna happen!

Copyright (c) 2008 Tom Lea, released under the MIT Licence
