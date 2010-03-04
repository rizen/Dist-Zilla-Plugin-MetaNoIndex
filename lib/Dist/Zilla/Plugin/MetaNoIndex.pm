package Dist::Zilla::Plugin::MetaNoIndex;

use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::MetaProvider';

sub mvp_multivalue_args { qw(folder directory file namespace package) }

sub mvp_aliases {
    return {
        dir         => 'directories',
        directory   => 'directories',
        folder      => 'directories',
        file        => 'files',
        'package'   => 'packages',
        module      => 'packages',
        class       => 'packages',
        namespace   => 'namespaces',
    };
}

has directories => (
    is          => 'rw',
    isa         => 'ArrayRef',
    predicate   => 'has_directories',
);

has files => (
    is          => 'ro',
    isa         => 'ArrayRef',
    predicate   => 'has_files',
);

has packages => (
    is          => 'ro',
    isa         => 'ArrayRef',
    predicate   => 'has_packages',
);

has namespaces => (
    is          => 'ro',
    isa         => 'ArrayRef',
    predicate   => 'has_namespaces',
);

sub metadata {
    my $self = shift;
    my %no = ();
    if ($self->has_directories) {
        $no{directory} = $self->directories;
    }
    if ($self->has_files) {
        $no{file} = $self->files;
    }
    if ($self->has_packages) {
        $no{package} = $self->packages;
    }
    if ($self->has_namespaces) {
        $no{namespace} = $self->namespaces;
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

The following directives are available.

=over

=item directory

Exclude folders and everything in them. Example: C<author.t>. Aliases: C<folder>, C<dir>.

=item file

Exclude a specific file. Example: C<lib/Foo.pm>.

=item package

Exclude by package name. Example: C<My::Package>. Aliases: C<class>, C<module>.

=item namespace

Exclude everything under a specific namespace. Example: C<My::Package>. 

B<NOTE:> This will not exclude the package C<My::Package>, only everything under it like C<My::Package::Foo>.

=back

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

