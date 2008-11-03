ActiveRecord::Lint
================

A library to support the automatic checking for the doing of stupid things 
with ActiveRecord.

AR::Lint is not big, nor is it clever, nor is it that well written.
It makes recommendations based upon what I have found to be good practice, with
only anecdotal evidence to support it.

This is *not* a substitute for a DB admin, nor is it a substitute for knoledge.

Your mileage may vary, remember to check your tire pressure.

Usage
-----

You can check a typical rails application by executing:
> $ arlint path/to/rails/app

Support for automated tests and making it work with rake is something I could do to get around to.

Copyright (c) 2008 Tom Lea, released under the MIT Licence
