package ModPerl2Sum;

use strict;
use warnings;

use Apache2::RequestRec ();
use Apache2::RequestIO ();
use Apache2::Request ();
use Apache2::Const -compile => qw(OK);

sub handler {
    my $r = shift;
    my $q = Apache2::Request->new($r);
    $r->content_type('text/plain');
    $r->print($q->param('a') + $q->param('b'));
    return Apache2::Const::OK;
}

1;
