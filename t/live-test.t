#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 12;

# setup library path
use FindBin qw($Bin);
use lib "$Bin/lib";

# make sure testapp works
use ok 'TestApp';

# a live test against TestApp, the test application
use Test::WWW::Mechanize::Catalyst 'TestApp';
my $mech = Test::WWW::Mechanize::Catalyst->new;
$mech->get_ok('http://localhost/', 'get main page');
$mech->content_like(qr/it works/i, 'see if it has our text');

$mech->get_ok('http://localhost/normal', 'get normal');
is_deeply deser_content(), [qw/Catalyst::Request::Pluggable cannot_data/];

$mech->get_ok('http://localhost/data', 'get data');
is_deeply deser_content(), [qw/Class::MOP::Class::__ANON__::SERIAL::2 can_data/];

$mech->get_ok('http://localhost/normal', 'get normal again');
is_deeply deser_content(), [qw/Catalyst::Request::Pluggable cannot_data/];

$mech->get_ok('http://localhost/foo/whatever', 'get foo/whatever');
$mech->content_like(qr/this => worked/, 'this worked');

$mech->get('http://localhost/foo/whatever/1', 'get foo/whatever with no_role');
is $mech->status, '500', 'no role application == error';

sub deser_content {
    my $content = $mech->content;
    return eval "my $content";
}
