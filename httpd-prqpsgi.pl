use Plack::Request;

my $handler = sub {
    my $req = Plack::Request->new(shift);
    return [ 200, [ "Content-Type" => "text/plain" ],
        [ $req->param('a') + $req->param('b') ] ];
};
