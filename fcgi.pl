#!/usr/bin/env perl -w

# nginx.conf:
# location /fcgisum {
#     fastcgi_pass unix:/tmp/sum_fcgi.socket;
# 
#     fastcgi_param  PATH_INFO   $fastcgi_script_name;
#     fastcgi_param  QUERY_STRING  $query_string;
#     fastcgi_param  REQUEST_METHOD  $request_method;
#     fastcgi_param  CONTENT_TYPE  $content_type;
#     fastcgi_param  CONTENT_LENGTH  $content_length;
# }

use strict;
use warnings;

use FCGI;
use CGI::Simple;

my $sock_fn = '/tmp/sum_fcgi.socket';

my $socket  = FCGI::OpenSocket($sock_fn, 100);
eval { chmod 0777, $sock_fn };
my $request = FCGI::Request(\*STDIN, \*STDOUT, \*STDERR, \%ENV, $socket, FCGI::FAIL_ACCEPT_ON_INTR());

while ($request->Accept() >= 0) {
    my $q = CGI::Simple->new;
    print $q->header(-type => 'text/plain'),
        ($q->param('a') + $q->param('b'));
}

FCGI::CloseSocket($socket);
