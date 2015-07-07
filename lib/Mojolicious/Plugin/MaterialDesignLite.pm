package Mojolicious::Plugin::MaterialDesignLite;

=encoding utf8

=head1 NAME

Mojolicious::Plugin::MaterialDesignLite - Mojolicious Plugin

=head1 SYNOPSIS

    # Mojolicious
    $self->plugin('MaterialDesignLite');

    # Mojolicious::Lite
    plugin 'MaterialDesignLite';

=head1 DESCRIPTION

L<< Mojolicious::Plugin::MaterialDesignLite >> is a L<< Mojolicious >> plugin.

=cut

use Mojo::Base 'Mojolicious::Plugin';
use Mojo::ByteStream;

our $VERSION = '0.1';

=head1 METHODS

L<Mojolicious::Plugin::MaterialDesignLite> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

    $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=cut

sub register 
{
    my ($self, $app) = @_;
    
    $app->helper(mdl_badge  => sub { mdl_badge(@_) });
    $app->helper(mdl_button => sub { mdl_button(@_) });
}

=head2 mdl_badge

    %= mdl_badge label => 'States', data => 50;
    %= mdl_badge icon => 'email', data => 42;

Generates HTML code for MDL badge

=cut

sub mdl_badge
{
    my %attr = @_ % 2 ? (value => shift, @_) : @_;
    
    my $str = ($attr{icon}
        ? '<div class="icon material-icons mdl-badge" data-badge="' 
            . $attr{data} . '">' . $attr{icon}
        : '<div class="mdl-badge" data-badge="'
            . $attr{data} . '">' . $attr{label}
            )
        . '</div>';
        
    #<div class="icon material-icons mdl-badge" data-badge="1">account_box</div>
    #<div class="mdl-badge" data-badge="4">Inbox</div>
    say "badge: $str";
    
    return (Mojo::ByteStream->new($str));
}

=head2 mdl_button

    %= mdl_button label => 'Button Label';
    %= mdl_button icon => 'add', type => 'fab';

Generates HTML code for MDL button

=cut

sub mdl_button
{
    my %attr = @_ % 2 ? (value => shift, @_) : @_;
    
    my $type = $attr{type} || 'raised';
    my $inner = ($attr{icon} ? mdl_icon($attr{icon}) : $attr{label});
    my $str = '<button class="mdl-button mdl-js-button mdl-button--' 
        . ${type} .'">' . $inner . '</button>';
    say "button: $str";
    
    return (Mojo::ByteStream->new($str));
}

=head2 mdl_icon

=cut

sub mdl_icon
{
    my $icon = shift;
    
    my $str = '<i class="material-icons">' . $icon . '</i>';
    
    return (Mojo::ByteStream->new($str));
}

=head2 comment
<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--colored">
  <i class="material-icons">add</i>
</button>
<!-- Colored FAB button with ripple -->
<button class="mdl-button mdl-js-button mdl-button--fab mdl-js-ripple-effect mdl-button--colored">
  <i class="material-icons">add</i>
</button>
=cut

1;

=head1 SEE ALSO

L<< Mojolicious >>, L<< Mojolicious::Guides >>, L<< http://mojolicio.us >>.

=cut