#!/usr/bin/perl
use Toadfarm -init;
use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

my $datestring = localtime();
print "------------------------------\n";
print "Started: $datestring\n";

logging {
        combined => 1,
        file     => "/var/log/toadfarm/pi-webserver.log",
        level    => "info",
};
mount "MyApp";

plugin "Toadfarm::Plugin::AccessLog";
start ['http://*:8888'], workers => 1;
