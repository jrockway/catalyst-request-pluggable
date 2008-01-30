package TestApp;
use strict;
use warnings;

use Catalyst;
use Catalyst::Request::Pluggable;

__PACKAGE__->request_class('Catalyst::Request::Pluggable');
__PACKAGE__->setup;

1;
