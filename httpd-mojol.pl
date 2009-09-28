#!/usr/bin/perl -w

use Mojolicious::Lite;

app->log->level('error');
app->mode('production');

get '/sum' => sub {
    my $self = shift;
    my $req = $self->req;
    $self->render(text => $req->param('a') + $req->param('b'));
};

shagadelic;
