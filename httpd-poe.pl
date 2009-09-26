#!/usr/local/bin/perl -w

use strict;
use warnings;
use POE::Component::Server::HTTP;
use POE;
use URI;
use CGI::Simple;

POE::Component::Server::HTTP->new(
    ContentHandler => { '/sum' => sub {
            my ($req, $resp) = @_;
            my $u = URI->new($req->uri);
            my $q = CGI::Simple->new($u->query);
            $resp->code(RC_OK);
            $resp->push_header('Content-type', 'text/plain');
            $resp->content($q->param('a') + $q->param('b'));
            return RC_OK;
        },
    },
    Port => 8010
);
$poe_kernel->run;

exit 0;
