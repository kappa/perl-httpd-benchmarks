#!/usr/bin/perl -w

use strict;
use warnings;

use CGI::Simple;

my $q = CGI::Simple->new;
print $q->header(-type => 'text/plain'),
    $q->param('a') + $q->param('b');
