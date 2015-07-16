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
    
    $app->helper(mdl_badge      => sub { mdl_badge(@_)     });
    $app->helper(mdl_button     => sub { mdl_button(@_)    });
    $app->helper(mdl_slider     => sub { mdl_slider(@_)    });
    $app->helper(mdl_switch     => sub { mdl_switch(@_)    });
    $app->helper(mdl_textfield  => sub { mdl_textfield(@_) });
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

=head2 mdl_slider

    %= mdl_slider id => 'percentage', value => 80;
    %= mdl_slider id => 'digit', min => 0, max => 9, step => 1, value => 3;

=cut

sub mdl_slider
{
    my %attr = @_ % 2 ? (value => shift, @_) : @_;
    
    my $id      = $attr{id} || 'slider';
    my $min     = $attr{min} || 0;
    my $max     = $attr{max} || 100;
    my $step    = $attr{step} || 5;
    my $value   = $attr{value} || 0;

    my $str = '<input class="mdl-slider mdl-js-slider" type="range"' 
        . ' id="' . $id . '" min="' . $min . '" max="' . $max . '"'
        . ' value="' . $value . '" step="' . $step . '" />';

    return (Mojo::ByteStream->new($str));
}

=head2 mdl_switch

=cut

sub mdl_switch
{
    my %attr = @_ % 2 ? (value => shift, @_) : @_;
    
    my $id      = $attr{id} || 'switch';
    my $checked = ($attr{checked} ? 'checked ' : '');
    my $label   = $attr{label} || '';

    my $str = '<label class="mdl-switch mdl-js-switch mdl-js-ripple-effect"' 
        . ' for="' . $id . '"><input type="checkbox" id="' . $id .'"'
        . ' class="mdl-switch__input" ' . $checked . '/>'
        . '<span class="mdl-switch__label">' . $label . '</span></label>';

    return (Mojo::ByteStream->new($str));
}

=head2 mdl_textfield

=cut

sub mdl_textfield
{
    my %attr = @_ % 2 ? (value => shift, @_) : @_;
    my $id = $attr{id};
    my $pattern = ($attr{pattern} ? ' pattern="' . $attr{pattern} . '"' : '');
    my $label_type = ($attr{label_type} eq 'floating' 
        ?  ' mdl-textfield--floating-label' : '');

    my $str = '<div class="mdl-textfield mdl-js-textfield' . $label_type . '">'
        . '<input class="mdl-textfield__input" type="text" id="' . $id . '"'
        . $pattern . ' />'
        . '<label class="mdl-textfield__label" for="' . $id . '">' 
        . $attr{label} . '</label>'
        . '<span class="mdl-textfield__error">' . $attr{error} . '</span>'
        . '</div>';
    
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