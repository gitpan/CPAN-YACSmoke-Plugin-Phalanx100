=head1 NAME

  CPAN::YACSmoke::Plugin::Phalanx100 - Test Phalanx 100 list in CPAN::YACSmoke

=head1 SYNOPSIS

  use CPAN::YACSmoke;
  my $config = {
      list_from        => 'Phalanx100', 
  };
  my $foo = CPAN::YACSmoke->new(config => $config);
  my @list = $foo->download_list();

=head1 DESCRIPTION

This module provides the backend ability to test modules from the
Phalanx 100 list.

This module should be used together with L<CPAN::YACSmoke>.

=cut

package CPAN::YACSmoke::Plugin::Phalanx100;

use 5.006001;
use strict;
use warnings;

our $VERSION = '0.02';

use CPANPLUS::Backend;

use CPAN::YACSmoke 0.03;
use Module::Phalanx100 0.03;

# use YAML 'Dump';

=head1 CONSTRUCTOR

=over 4

=item new()

Creates the plugin object.

=back

=cut
    
sub new {
  my $class = shift || __PACKAGE__;
  my $hash  = shift;

  my $self = {
  };
  foreach my $field (qw( smoke force )) {
    $self->{$field} = $hash->{$field}   if(exists $hash->{$field});
  }

  bless $self, $class;
}

=head1 METHODS

=over 4

=item download_list()

Return the list of distributions recorded in the latest RECENT file.

=cut

sub download_list {
  my $self  = shift;

  my @list = Module::Phalanx100->modules();

  my $cpan = $self->{smoke}->{cpan};

  my %testlist = ( );
  foreach my $modname (@list) {
    my $mod = $cpan->parse_module( module => $modname );
    if ($mod) {
      my $pkgname = $mod->path .'/'. $mod->package;
      $pkgname =~ s/^authors\/id//i;
#      print STDERR Dump($mod), "\n";
      $testlist{$pkgname}++,
	unless ($mod->package_is_perl_core);
    } else {
      # TODO: warning message
    }
  }

  return (sort keys %testlist);
}


1;
__END__

=pod

=back

=head1 CAVEATS

This is a proto-type release. Use with caution and supervision.

=head1 AUTHOR

Robert Rothenberg <rrwo at cpan.org>

=head2 Suggestions and Bug Reporting

Please submit suggestions and report bugs to the CPAN Bug Tracker at
L<http://rt.cpan.org>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Robert Rothenberg.  All Rights Reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.

=head1 SEE ALSO

  Module::Phalanx100

=cut
