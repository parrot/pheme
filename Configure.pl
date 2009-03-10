#! perl
# $Id: Configure.pl 36833 2009-02-17 20:09:26Z allison $
# Copyright (C) 2009, Parrot Foundation.

use strict;
use warnings;

chdir '../..';
`$^X -Ilib tools/dev/reconfigure.pl --step=gen::languages --languages=pheme`;
