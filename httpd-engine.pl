#!/usr/bin/perl -w

use strict;
use warnings;
use HTTP::Engine;

my $engine = HTTP::Engine->new(
    interface => {
        module => 'ServerSimple',
        args   => {
            host => 'localhost',
            port =>  8010,
        },
        request_handler => \&handle_request,
    },
    );

$engine->run;

sub handle_request {
    my $req = shift;
    my $vars = $req->query_parameters;
    return HTTP::Engine::Response->new(
        body => $vars->{a} + $vars->{b},
        );
}
