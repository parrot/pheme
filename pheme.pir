# $Id$

=head1 TITLE

pheme.pir - A Pheme compiler.

=head2 Description

This is the entry point for the Pheme compiler.

=head2 Functions

=over 4

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args> to the Pheme compiler.

=cut

.sub 'main' :anon :main
    .param pmc args

    load_language 'pheme'

    $P0 = compreg 'pheme'

    .include 'except_severity.pasm'
    .local pmc eh
    eh = new 'ExceptionHandler'
    eh.'handle_types'(.EXCEPT_EXIT)
    set_addr eh, exit_handler
    push_eh eh
      $P1 = $P0.'command_line'(args)
    pop_eh
    goto done

  exit_handler:
    .get_results($P0)

  done:
    end
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

