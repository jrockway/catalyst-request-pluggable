package TestApp::Controller::Foo;
use strict;
use warnings;
require TestApp::Controller::Root; # for that Data role

use base 'Catalyst::Controller';

sub begin :Private {
    my ($self, $c, $no_role) = @_;
    unless($no_role){
        Data->meta->apply($c->request);
        $c->request->data({ this => 'worked' });
    }
}

sub whatever :Local {
    my ($self, $c) = @_;
    $c->res->body(join ' => ', %{$c->request->data});
}

1;
