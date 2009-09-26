#!/usr/bin/perl -w

use strict;
use warnings;

use AnyEvent::HTTPD;

my $httpd = AnyEvent::HTTPD->new (port => 8010);

$httpd->reg_cb (
    '/sum' => sub {
        my ($httpd, $req) = @_;
        $req->respond ({ content => ['text/html',
            $req->parm('a') + $req->parm('b')
            ]});
    },
);

$httpd->run; # making a AnyEvent condition variable would also work
