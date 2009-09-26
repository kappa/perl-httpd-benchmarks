#!/usr/bin/perl
use Dancer;

get '/sum' => sub {
    params->{a} + params->{b}
};

dance;
