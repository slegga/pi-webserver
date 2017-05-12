package API::PiData::Pi;
use Mojo::Base "Mojolicious::Controller";
use autodie;
sub set_ip {

  # Do not continue on invalid input and render a default 400
  # error document.
  my $c = shift->openapi->valid_input or return;

  # IP check goes here
  my $spec = $c->openapi->spec;
#  unless ($spec->{'x-opening-hour'} == (localtime)[2]) {
#    return $c->render(openapi => [], status => 498);
#  }

  # $c->openapi->valid_input copies valid data to validation object,
  # and the normal Mojolicious api works as well.
  my $body = $c->validation->output->{body};
  my $pi_ip   = $body->{ip};

	open my $fh,'>',$ENV{HOME}.'/etc/pi-ip.txt';
	print $fh $pi_ip;
	close $fh;
  # $output will be validated by the OpenAPI spec before rendered
  $c->render(openapi => 'ok');
}

1;