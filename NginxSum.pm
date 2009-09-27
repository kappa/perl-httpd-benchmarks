package Sum;
use CGI::PSGI;
use Dancer;
use Data::Dumper;

use Dancer::Config 'setting';
setting apphandler  => 'PSGI';

get '/sum' => sub {
    params->{a} + params->{b}
};

# two handlers, with Dancer and without
# both still require CGI::PSGI from github
# nginx config:
#
# http {
#     perl_modules /home/kappa/work/nginx-psgi-patchs;
# 	#perl_modules /home/kappa/work/nginx-0.7.62/objs/src/http/modules/perl/blib/lib/;
# 	perl_require  NginxSum.pm;
#     server {
#         listen       8011;
#         server_name  localhost;
# 
# 		location /sum {
# 			psgi Sum::handler_dancer;
#                   # or Sum::handler_raw;
# 		}
#     }
# }

sub handler_dancer {
    Dancer->dance(CGI::PSGI->new(shift));
}

sub handler_rawpsgi {
    my $q = CGI::PSGI->new(shift);

    my $body = $q->param('a') + $q->param('b');

    [
        200,
        ['Content-Type'     => 'text/plain',
         'Content-Length'   => bytes::length($body)],
        [$body],
    ];
}

sub handler_raw2 {
    my $env = shift;
    my ($aa, $bb) = ($env->{QUERY_STRING} =~ /a=(\d+)&b=(\d+)/);
    my $body = $aa + $bb;

    [
        200,
        ['Content-Type'     => 'text/plain',
         'Content-Length'   => bytes::length($body)],
        [$body],
    ];
}

sub handler_raw {
    my $env = shift;
    my $body = $env->{a} + $env->{b};

    [
        200,
        ['Content-Type'     => 'text/plain',
         'Content-Length'   => bytes::length($body)],
        [$body],
    ];
}

1;
