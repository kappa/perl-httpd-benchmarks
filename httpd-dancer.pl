#!/usr/bin/perl
use Dancer;

set access_log => 0;
set port => 8010;

get '/sum' => sub {
    params->{a} + params->{b}
};

dance;
