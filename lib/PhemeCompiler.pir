# $Id$

=head1 TITLE

PhemeCompiler.pir - A Pheme compiler.

=head2 Description

This is the base file for the Pheme compiler.

This file includes the parsing and grammar rules from
the src/ directory, loads the relevant PGE libraries,
and registers the compiler under the name 'Pheme'.

=head2 Functions

=over 4

=item onload()

Creates the Pheme compiler using a C<PCT::HLLCompiler>
object.

=cut

.HLL 'pheme'

.sub '' :anon :load
    load_bytecode 'PCT.pbc'
    load_bytecode 'TGE.pbc'

    .local pmc parrotns, hllns, exports
    parrotns = get_root_namespace ['parrot']
    hllns = get_hll_namespace
    exports = split ' ', 'PAST PCT PGE TGE'
    parrotns.'export_to'(hllns, exports)
.end

.include 'lib/PhemeObjects.pir'
.include 'lib/PhemeSymbols.pir'
.include 'lib/pheme_grammar_gen.pir'
.include 'lib/ASTGrammar.pir'

.namespace [ 'Pheme';'Compiler' ]

.sub '__onload' :load
    load_bytecode 'PCT.pbc'
    load_bytecode 'PGE/Text.pbc'

    .local pmc p6meta
    p6meta = get_root_global ['parrot'], 'P6metaclass'

    $P0 = p6meta.'new_class'('Match','parent'=>'parrot;PGE::Match')
    $P0 = p6meta.'new_class'('Grammar','parent'=>'Match')
    $P0 = p6meta.'new_class'('Pheme::PGE::Grammar','parent'=>'Grammar')

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()

    $P1.'language'('pheme')
    $P0 = get_hll_namespace ['Pheme';'Grammar']
    $P1.'parsegrammar'($P0)
    $P0 = get_hll_namespace ['Pheme';'AST';'Grammar']
    $P1.'astgrammar'(  $P0)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

