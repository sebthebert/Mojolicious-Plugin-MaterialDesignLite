#!/usr/bin/env perl

use Mojolicious::Lite;

plugin 'MaterialDesignLite';

get '/' => sub {
	my $self = shift;
	$self->render('demo');
};

app->start;

__DATA__

@@ demo.html.ep
% layout 'default';
% title 'Mojolicious::Plugin::MaterialDesignLite demo';

<h1>Material Design Lite demo</h1>


<h2>Badges</h2>

<h3>Badge with label</h3>
%= mdl_badge label => 'States', data => 50;

<h3>Badge with icon</h3>
%= mdl_badge icon => 'email', data => 42;


<h2>Buttons</h2>

<h3>Button with label</h3>
%= mdl_button label => 'Button Label';

<h3>Button with icon</h3>
%= mdl_button icon => 'add', type => 'fab';

<h2>Sliders</h2>

%= mdl_slider id => 'percentage', value => 80;

%= mdl_slider id => 'digit', min => 0, max => 9, step => 1, value => 3;


<h2>Switches</h2>

%= mdl_switch id => 'wifi', label => 'Wifi', checked => 1;

%= mdl_switch id => 'airplane_mode', label => 'Airplane Mode', checked => 0;


<h2>textfields</h2>
%= mdl_textfield label => 'Type a number', pattern => '[0-9]*', id => 'demo1', error => 'Not a number !';
%= mdl_textfield label => 'With floating label', id => 'demo2', label_type => 'floating';

<!--div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable
 mdl-textfield--floating-label">
  <label class="mdl-button mdl-js-button mdl-button--icon" for="search-expandable2">
    <i class="material-icons">search</i>
  </label>
  <div class="mdl-textfield__expandable-holder">
    <input class="mdl-textfield__input" type="text" id="search-expandable2" />
    <label class="mdl-textfield__label" for="search-expandable2">
      Enter search text below
    </label>
  </div>
</div>-->


@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
    <head>
    <title><%= title %></title>
    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.0/material.indigo-pink.min.css">
    <script src="https://storage.googleapis.com/code.getmdl.io/1.0.0/material.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    </head>
    <body>
    <%= content %>
    </body>
</html>