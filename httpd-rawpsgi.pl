my $handler = sub {
    my $env = shift;
    my ($aa, $bb) = ($env->{QUERY_STRING} =~ /a=(\d+)&b=(\d+)/);
    return [ 200, [ "Content-Type" => "text/plain" ], [ $aa + $bb ] ];
};
