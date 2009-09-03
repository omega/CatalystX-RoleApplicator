use strict;
use warnings;
use Test::More tests => 4;

{
  package TestApp;

  use base 'Catalyst';
  use Catalyst;
  use CatalystX::RoleApplicator;
  __PACKAGE__->apply_request_class_roles(qw/TestRole2/);
  __PACKAGE__->config(
      'CatalystX::RoleApplicator' => {
          request => 'TestRole',
          response => [qw/TestRole TestRole2/],
      },
  );
  __PACKAGE__->setup;
}

{
  package TestRole;
  use Moose::Role;
}
{
  package TestRole2;
  use Moose::Role;
}

ok(Class::MOP::class_of(TestApp->request_class)->does_role('TestRole'), 
"request does TestRole");
ok(Class::MOP::class_of(TestApp->request_class)->does_role('TestRole2'), 
"request does TestRole2");
ok(Class::MOP::class_of(TestApp->response_class)->does_role('TestRole'), 
"response does TestRole");
ok(Class::MOP::class_of(TestApp->response_class)->does_role('TestRole2'), 
"response does TestRole2");
