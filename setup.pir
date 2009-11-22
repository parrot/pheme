#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.
# $Id$

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    $P0 = new 'Hash'
    $P0['name'] = 'Pheme'
    $P0['abstract'] = 'Yet Another Scheme'
    $P0['description'] = 'Pheme is a Parrot-based implementation of Scheme.'
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'Parrot Foundation'
    $P0['generated_by'] = 'Francois Perrad <francois.perrad@gadz.org>'
    $P0['checkout_uri'] = 'https://svn.parrot.org/languages/pheme/trunk'
    $P0['browser_uri'] = 'https://trac.parrot.org/languages/browser/pheme'
    $P0['project_uri'] = 'https://trac.parrot.org/parrot/wiki/Languages'

    # build
    $P1 = new 'Hash'
    $P1['lib/pheme_grammar_gen.pir'] = 'lib/pheme.g'
    $P0['pir_pge'] = $P1

    $P2 = new 'Hash'
    $P2['lib/ASTGrammar.pir'] = 'lib/pge2past.tg'
    $P0['pir_tge'] = $P2

    $P3 = new 'Hash'
    $P4 = split "\n", <<'SOURCES'
pheme.pir
lib/pheme_grammar_gen.pir
lib/ASTGrammar.pir
lib/PhemeObjects.pir
lib/PhemeSymbols.pir
SOURCES
    $P3['pheme.pbc'] = $P4
    $P0['pbc_pir'] = $P3

    $P5 = new 'Hash'
    $P5['parrot-pheme'] = 'pheme.pbc'
    $P0['installable_pbc'] = $P5

    # test
    $S0 = get_parrot()
    $S0 .= ' pheme.pbc'
    $P0['prove_exec'] = $S0
    $P0['prove_files'] = 't/*.t t/phemer/*.t'

    .tailcall setup(args :flat, $P0 :flat :named)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
