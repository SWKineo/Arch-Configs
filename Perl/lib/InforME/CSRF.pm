package InforME::CSRF;

use 5.008008;
use strict;
use warnings;
use Moose;
use CGI;
use Digest::SHA qw(sha512_hex);

our $VERSION = '0.02';

has 'token'        => (isa => 'Str', is => 'rw');
has 'randomString' => (isa => 'Str', is => 'rw', default => 'omg csrf is kinda bad n stuff');
has 'session'      => (isa => 'CGI::Session', is => 'rw');
has 'q'            => (isa => 'CGI', is => 'rw');
has 'tokenName'    => (isa => 'Str', is => 'rw', default => 'informepagetoken');

sub BUILD {
    my $self = shift;

    $self->q(new CGI);

    # Check to make sure a session object was passed
    if (!$self->session) {
	die("Invalid session was passed to constructor");
    }
}

sub genNewToken {
    my ($self) = @_;
    my $time   = localtime(time);
    
    $self->token(sha512_hex(localtime(time) . $self->randomString . 
			    localtime(time)));

    $self->session->param($self->tokenName => $self->token);

    return $self->token;
}

sub checkToken {
    my ($self) = @_;

    # First check to make sure a token was even passed, and that
    # we have a token in the session
    if (!$self->session->param($self->tokenName) || !$self->q->param($self->tokenName)) {
	die("CSRF Initial Token check failed.");
    }

    # Check to see if the tokens match
    if ($self->session->param($self->tokenName) ne $self->q->param($self->tokenName)) {
	die("CSRF Check Validation Error! From IP: " . $ENV{REMOTE_ADDR});
    }
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

InforME::CSRF - Perl extension for dealing with CSRF

=head1 SYNOPSIS

  use InforME::CSRF;

  # $session is a CGI::Session object
  my $csrf = InforME::CSRF->new(session => $session);

  # If information was POST'd or GET'd to the page, ie:
  if ($q->param()) {
    # Now we can check the token, the module takes care of
    # Dieing automagicly

    $csrf->checkToken();
  }

  # If this is just a normal page load (no info submited from a form)

  # Generate a new token
  $csrf->genNewToken();

  ...
  ...

  # Now send this to your templating system (I generally use HTML::Template)
  # The 'token' property of the $csrf object contains the token and the
  # 'tokenName' contains the name of the token to use in a hidden form field
  $template->param('token' => $csrf->token);
  $template->param('tokenName' => $csrf->tokenName);


  Make sure that you have the token in the form that is submitting the
  data. The default name for the form element is 'informepagetoken'. This
  can be set or retreived through the 'tokenName' method/property:

  $csrf->tokenName('myNewTokenName');

  If you use HTML::Template, then your hidden form field with the csrf token would
  look kinda like this:

  <input type="hidden" name="<TMPL_VAR NAME=TOKENNAME>" value="<TMPL_VAR NAME=TOKEN>" />


=head1 DESCRIPTION

Simple (very) module for dealing with CSRF attacks

=head2 EXPORT

None

=head1 SEE ALSO


=head1 AUTHOR

Joe Grace, E<lt>joe@informe.orgE<gt>

=cut
