package Dist::Zilla::Plugin::MetaNoIndex;

use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::MetaProvider';

sub mvp_multivalue_args { qw(folder directory file namespace package) }

# just here for backward compatibility
has folder => (
    is          => 'ro',
    isa         => 'ArrayRef',
    trigger     => sub {
        my ($self, $new, $old) = @_;
        $self->directory($new);
    },
);

has directory => (
    is          => 'rw',
    isa         => 'ArrayRef',
    predicate   => 'has_directory',
);

has file => (
    is          => 'ro',
    isa         => 'ArrayRef',
    predicate   => 'has_file',
);

has package => (
    is          => 'ro',
    isa         => 'ArrayRef',
    predicate   => 'has_package',
);

has namespace => (
    is          => 'ro',
    isa         => 'ArrayRef',
    predicate   => 'has_namespace',
);

sub metadata {
    my $self = shift;
    my %no = ();
    if ($self->has_directory) {
        $no{directory} = $self->directory;
    }
    if ($self->has_file) {
        $no{file} = $self->file;
    }
    if ($self->has_package) {
        $no{package} = $self->package;
    }
    if ($self->has_file) {
        $no{namespace} = $self->namespace;
    }
    return { no_index => \%no };
}


=head1 NAME

Dist::Zilla::Plugin::MetaNoIndex - Stop CPAN from indexing stuff

=head1 SYNOPSIS

In your F<dist.ini>:

 [MetaNoIndex]
 directory = author.t
 directory = examples
 file = lib/Foo.pm
 package = My::Module
 namespace = My::Module

=head1 DESCRIPTION

This plugin allows you to prevent PAUSE/CPAN from indexing files you don't want indexed. This is useful if you build test classes or example classes that are used for those purposes only, and are not part of the distribution. It does this by adding a C<no_index> block to your F<META.yml> file in your distribution.

=head1 SUPPORT

=over

=item Repository

L<http://github.com/rizen/Dist-Zilla-Plugin-MetaNoIndex>

=item Bug Reports

L<http://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-Plugin-MetaNoIndex>

=back

=head1 SEE ALSO

L<Dist::Zilla>

=head1 AUTHOR

JT Smith <jt_at_plainblack_com>

=head1 LEGAL

Dist::Zilla::Plugin::MetaNoIndex is Copyright 2010 Plain Black Corporation (L<http://www.plainblack.com/>) and is licensed under the same terms as Perl itself.

=cut







__PACKAGE__->meta->make_immutable;
no Moose;
1;

