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
%= mdl_badge label => 'States', data => 50;
%= mdl_badge icon => 'email', data => 42;

<h2>Buttons</h2>
%= mdl_button label => 'Button Label';
%= mdl_button icon => 'add', type => 'fab';


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