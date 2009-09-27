#!/usr/bin/env perl

use strict;
use warnings;

# location /fcgimojo {
#     fastcgi_pass unix:/tmp/mojo_fcgi.socket;
# 
#     fastcgi_param  MOJO_APP  Bench;
#     fastcgi_param  PATH_INFO   $fastcgi_script_name; 
#     fastcgi_param  QUERY_STRING  $query_string;
#     fastcgi_param  REQUEST_METHOD  $request_method;
#     fastcgi_param  CONTENT_TYPE  $content_type;
#     fastcgi_param  CONTENT_LENGTH  $content_length;
# }

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
