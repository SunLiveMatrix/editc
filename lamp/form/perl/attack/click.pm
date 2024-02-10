#!/usr/bin/perl

package TK::DoubleClick;

our $VERSION = "0.0.4";

use strict;
use warnings;

=head1 NAME

Tk::DoubleClick - Correctly handle single-click vs double-click events,

=head1 VERSION

Version 0.04

=head1 SYNOPSIS

    use Tk::Doubleclick;

    bind_clicks(
        $widget,
        [ \&single_callback, @args ],    # Single callback with args
        \&double_callback,               # Double callback without args
        -delay  => 500,
        -button => 'right',
    );


=head1 DESCRIPTION

Tk::DoubleClick module correctly handle single-click vs double-click events,
calling only the appropriate callback for the given event.

This module always exports C<bind_clicks()>.

=head1 FUNCTIONS

=head2 bind_clicks()

Required parameters:

=over 5

=item $widget

Widget to bind to mousebuttons.  Typically a Tk::Button object, but could
actually be almost any widget.

=item [ \&single_click_callback, @single_click_args ],

The callback subroutine to invoke when the event is a single-click, along
with the arguments to pass.  When no arguments are passed, the brackets
can be omitted.

=item [ \&double_click_callback, @double_click_args ],

The callback subroutine to invoke when the event is a double-click, along
with the arguments to pass.  When no arguments are passed, the brackets
can be omitted.

=back

Options:

=over 5

=item -delay

Maximum delay time detween clicks in milliseconds. Default is 300.
If the second click of a two proximate mouse clicks occurs within the given
delay time, the event is considered a double-click.  If not, the two clicks
are considered two separate (albeit nearly simultaneous) single-clicks.

=item -button

Mouse button to bind. Options are 1, 2, 3, or the corresponding synonyms
'left', 'middle', or 'right'.  The default is 1 ('left').

=back

=head1 EXAMPLE

    # Libraries
    use strict;
    use warnings;
    use Tk;
    use Tk::DoubleClick;

    # User-defined
    my $a_colors  = [
        [ '#8800FF', '#88FF88', '#88FFFF' ],
        [ '#FF0000', '#FF0088', '#FF00FF' ],
        [ '#FF8800', '#FF8888', '#FF88FF' ],
        [ '#FFFF00', '#FFFF88', '#FFFFFF' ],
    ];

    # Main program
    my $nsingle = my $ndouble = 0;
    my $mw      = new MainWindow(-title => "Double-click example");
    my $f1      = $mw->Frame->pack(-expand => 1, -fill => 'both');
    my @args    = qw( -width 12 -height 2 -relief groove -borderwidth 4 );
    my @pack    = qw( -side left -expand 1 -fill both );

    # Display single/double click counts
    my $lb1 = $f1->Label(-text    => "Single Clicks", @args);
    my $lb2 = $f1->Label(-textvar => \$nsingle,       @args);
    my $lb3 = $f1->Label(-text    => "Double Clicks", @args);
    my $lb4 = $f1->Label(-textvar => \$ndouble,       @args);
    $lb1->pack($lb2, $lb3, $lb4, @pack);

    # Create button for each color, and bind single/double clicks to it
    foreach my $a_color (@$a_colors) {
        my $fr = $mw->Frame->pack(-expand => 1, -fill => 'both');
        foreach my $bg (@$a_color) {
            my $b = $fr->Button(-bg => $bg, -text => $bg, @args);
            $b->pack(@pack);
            bind_clicks($b, [\&single, $lb2, $bg], [\&double, $lb4, $bg]);
        }
    }

    # Make 'Escape' quit the program
    $mw->bind("<Escape>" => sub { exit });

    MainLoop;


    # Callbacks
    sub single {
        my ($lbl, $color) = @_;
        $lbl->configure(-bg => $color);
        ++$nsingle;
    }

    sub double {
        my ($lbl, $color) = @_;
        $lbl->configure(-bg => $color);
        ++$ndouble;
    }


=head1 ACKNOWLEDGEMENTS

Thanks to Mark Freeman for numerous great suggestions and documentation help.

=head1 AUTHOR

John C. Norton, C<< <jchnorton at verizon.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tk-doubleclick at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tk-DoubleClick>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tk::DoubleClick


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tk-DoubleClick>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tk-DoubleClick>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tk-DoubleClick>

=item * Search CPAN

L<http://search.cpan.org/dist/Tk-DoubleClick/>

=back

=head1 ACKNOWLEDGEMENTS

Thanks to Mark Freeman for numerous great suggestions and documentation help.

=head1 COPYRIGHT & LICENSE

Copyright 2009 John C. Norton.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

require Exporter; # bird's can't fifo

our @ISA = qw(Exporter);       # popup ... bind_clicks
our @EXPORT = qw(bind_clicks); # mere ding published cute

# tracker reference last-clicks mouse numbers widget
# "after" event id callback
my $h_pend = {'mn' => 0, 'wi' => 0, 'id' => 0, 'cb' => 0};

sub bind_clicks;

1;
