#!/usr/bin/perl -w

use strict;
use warnings;
use HTTP::Engine;

my $engine = HTTP::Engine->new(
    interface => {
        module => 'ServerSimple',
        args   => {
            port =>  8010,
        },
        request_handler => sub {
            my $req = shift;
            my $vars = $req->query_parameters;
            my $res = HTTP::Engine::Response->new(
                body => $vars->{a} + $vars->{b},
                );
            $res->headers->header('Content-Type' => 'text/plain');
            return $res;
        },
    },
);

$engine->run;

