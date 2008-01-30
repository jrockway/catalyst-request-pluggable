package TestApp::Controller::Root;
use strict;
use warnings;
use Data::Dumper;

{
    package Data;
    use Moose::Role;
    
    has 'data' => (
        is  => 'rw',
        isa => 'HashRef',
    );
}

__PACKAGE__->config(namespace => q{});

use base 'Catalyst::Controller';

# your actions replace this one
sub main :Path { $_[1]->res->body('<h1>It works</h1>') }

sub normal :Local {
    my ($self, $c) = @_;
    $c->res->body(
        Dumper(
            [ ref $c->request,
            $c->request->can('data') ? 'can_data' : 'cannot_data', ]
        )
    );
}

sub data :Local {
    my ($self, $c) = @_;
    Data->meta->apply($c->request);
    $c->res->body(
        Dumper(
            [ ref $c->request,
            $c->request->can('data') ? 'can_data' : 'cannot_data' ]
        )
    );
}

1;
