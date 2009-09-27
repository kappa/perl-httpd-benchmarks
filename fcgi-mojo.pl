#!/usr/bin/env perl

use strict;
use warnings;

# Application
$ENV{MOJO_APP} ||= 'Bench';

use Mojo::Server::FCGI::Prefork;
my $fcgi = Mojo::Server::FCGI::Prefork->new(
    path => '/tmp/mojo_fcgi.socket',
    max_servers => 1,
    start_servers   => 1,
    min_spare_servers => 0,
    max_spare_servers => 1,
    );

$fcgi->run;

package Bench;

use strict;
use warnings;

use base 'Mojo';

sub handler {
    my ($self, $tx) = @_;
	for($tx->res) {
	    $_->headers->content_type('text/plain');
	    $_->body($tx->req->param('a') + $tx->req->param('b'));
	}
}

1;
