# $Id: Simpler.pm,v 1.0 2002/04/01 00:00:00 grantm Exp $

package XML::Simpler;

use strict;
use warnings;

require Exporter;
use File::Slurp;

use vars qw(@ISA @EXPORT $VERSION);
@ISA = qw(Exporter);
@EXPORT = qw( XMLin XMLout );
$VERSION = '1.00';

sub XMLin  { read_file ( $_[0]       ) }
sub XMLout { write_file( $_[1], $_[0]) }

1;
__END__

=head1 NAME

XML::Simpler - Simpler API for handling XML

=head1 SYNOPSIS

  use XML::Simpler;
  
  my $ref = XMLin($filename);

  XMLout($ref, $filename);

=head1 BACKGROUND

In the years since XML::Simple was released, many people have taken the time to
email me suggestions for how the module could be improved. 

It rapidly became apparent to me that what these people wanted could not be
achieved through small changes to XML::Simple (even though most correspondents
expressed opinions to the contrary).

The recurring complaints were:

=over 4

=item *

XML::Simple does not always preserve element order

=item *

When XML is written out, elements can get translated into attributes

=item *

The original encoding is not maintained when the file is read

=item *

The data structures returned by XMLin() are too complex

=item *

There are too many options

=item *

There is too much documentation

=back

Clearly a whole new approach was required and so XML::Simpler was born...


=head1 DESCRIPTION

XML::Simpler offers the following improvements over XML::Simple:

=over 4

=item *

Element order is always preserved

=item *

Elements are never translated into attributes

=item *

Indentation and whitespace is preserved

=item *

Absolutely no encoding translations are performed (unless the 'utf8' option is
enabled - see below)

=back

In addition to these changes, the data structures returned by XMLin() have been
vastly simplified.  All hashrefs and arrayrefs have been eliminated, and
instead the contents of the XML file are represented using a single scalar
value which perfectly preserves the fidelity of the original document.  In fact
the format of this data structure is so intuitive that new users will be able
to work with it immediately without reading the documentation.

The new data structure offers a number of exciting possibilities:

=over 4

=item *

The need for documents to comply with the strict (and often inconvenient)
syntax rules defined in the W3C XML Recommendation has been relaxed.  

=item *

It is no longer necessary to use an encoding declaration when pasting in
accented characters, symbols and 'smart quotes' from MS Word (in fact you
can mix multiple encodings in the same file).

=item *

It is also possible to embed HTML (including unbalanced or unclosed tags) in
your files without having to resort to CDATA sections.

=back

Furthermore, the new data structure and relaxed rules mean that XML::Simpler is
not restricted to XML data.  In fact the new module works equally well with INI
files, CSV files and all of the 'dot file' formats commonly used on Unix
systems.

In the absence of hash keys and array indexes, users will need to adopt
different techniques for extracting individual data values.  The most popular
approach will likely be regular expressions but this is Perl and there is
always more than one way to do it, so split() and substr() are likely to be popular alternatives.


=head1 METHODS

XML::Simple's object oriented API has been discarded in favour of the simpler
procedural interface.  These two routines are exported by default:

=head2 XMLin(filename, option)

For compatibility with XML::Simple, this method is named XMLin() but as
described above it should work with most file formats.  It takes a filename and
returns the contents of the file represented as a single scalar value (no
nested hashrefs etc).

=head2 XMLout(ref, filename)

This method can be used to write data out to an XML (or other) format file.
It takes a scalar value in the format returned by XMLin() and a filename.
The contents of the scalar is written to the named file.

=head1 OPTIONS

Perhaps surprisingly, all this added flexibility comes with a vastly simplified
API.  In fact the new API supports only one option: 'utf8'.  This option is
disabled by default but if it is enabled, XMLin() will auto-detect the encoding
and convert the data to UTF-8.

This option will not be fully implemented until Perl version 5.8 (or perhaps
6.0).  In the current release, enabling this option will cause your data to be
replaced with a pseudo-random character string of approximately the same
length.  As many of my correspondents have pointed out, UTF-8 encoded data is
virtually indistinguishable from random characters anyway so the current
implementation should tide us over for some time.

=head1 DEPENDENCIES

XML::Simpler does not require XML::Parser or a SAX parser.  It does require
File::Slurp.

The 'utf8' option requires that your system implements /dev/random, however on
Win32 platforms the system registry has been found to offer equivalent
functionality.

=head1 RELEASE HISTORY

Version 1.00 of XML::Simpler was released on April 1st, 2002

=head1 COPYRIGHT 

Copyright 2002 Grant McLean E<lt>grantm@cpan.orgE<gt>

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. 

=cut

