use inc::Module::Install;

name 'Catalyst-Request-Pluggable';
all_from 'lib/Catalyst/Request/Pluggable.pm';

build_requires 'Catalyst::Runtime';
build_requires 'Test::WWW::Mechanize::Catalyst';
build_requires 'Test::More';
build_requires 'ok';

WriteAll();
