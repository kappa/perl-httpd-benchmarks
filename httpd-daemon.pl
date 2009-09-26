#!/usr/bin/perl -w

use strict;
use warnings;
use HTTP::Daemon;
use HTTP::Response;
use HTTP::Status;
use URI;
use CGI::Simple;

my $d = HTTP::Daemon->new( LocalPort => 8010, Listen => 100 ) || die;
print "Please contact me at: <URL:", $d->url, ">\n";
while (my $c = $d->accept) {
    while (my $r = $c->get_request) {
        my $u = URI->new($r->uri);
        my $q = CGI::Simple->new($u->query);
        my $resp = HTTP::Response->new(RC_OK);
        $resp->push_header('Content-type', 'text/plain');
        $resp->content($q->param('a') + $q->param('b'));
        $c->send_response($resp);
    }
    $c->close;
}

exit 0;
