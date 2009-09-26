#!/usr/bin/perl -w

use strict;
use warnings;

use Mojo::Server::Daemon;

my $daemon = Mojo::Server::Daemon->new(
    port => 8010,
    handler_cb => sub {
            my ($self, $tx) = @_;
            $tx->res->headers->content_type('text/plain');
            $tx->res->body($tx->req->param('a') + $tx->req->param('b'));
        },
    );

$daemon->run;
