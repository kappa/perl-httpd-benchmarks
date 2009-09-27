use CGI::PSGI;

my $handler = sub {
    my $q = CGI::PSGI->new(shift);
    return [ 200, [ "Content-Type" => "text/plain" ],
        [ $q->param('a') + $q->param('b') ] ];
};
