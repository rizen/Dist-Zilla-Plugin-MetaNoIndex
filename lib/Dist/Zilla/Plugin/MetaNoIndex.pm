package Dist::Zilla::Plugin::MetaNoIndex;

use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::MetaProvider';

sub mvp_multivalue_args { qw(folder) }

has folder => (
    is          => 'ro',
    isa         => 'ArrayRef',
    required    => 1,
);

sub metadata {
    my $self = shift;
    return { no_index => { directory => $self->folder } };
}


=head1 NAME

Dist::Zilla::Plugin::MetaNoIndex - Stop CPAN from indexing stuff

=head1 SYNOPSIS

In your F<dist.ini>:

 [MetaNoIndex]
 folder = author.t
 folder = examples

=head1 DESCRIPTION

This plugin allows you to prevent PAUSE/CPAN from indexing files you don't want indexed. This is useful if you build test classes or example classes that are used for those purposes only, and are not part of the distribution. It does this by adding a C<no_index> block to your F<META.yml> file in your distribution.

=head1 AUTHOR

JT Smith <jt_at_plainblack_com>

=head1 LEGAL

Dist::Zilla::Plugin::MetaNoIndex is Copyright 2010 Plain Black Corporation (L<http://www.plainblack.com/>) and is licensed under the same terms as Perl itself.

=cut







__PACKAGE__->meta->make_immutable;
no Moose;
1;

