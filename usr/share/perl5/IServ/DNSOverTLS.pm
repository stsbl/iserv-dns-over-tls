package IServ::DNSOverTLS;

use warnings;
use strict;
use Exporter;
use JSON;
use Net::IP;
use Path::Tiny;

our @ISA = qw(Exporter);
our @EXPORT = qw(GetNameserverState GetCurrentNameservers SetNameserverState);

my $dir_interface = "/run/resolvconf/interface";
my $fn_nameservers = "/var/lib/iserv/dns-over-tls/nameservers.json";

my $json = JSON->new->utf8->canonical([1]);
#$json->boolean_values([0, 1]); # requires libjson-perl >= 4.00, he have 2.90

sub ip_in_net($$)
{
  my ($net, $ip) = @_;

  $net = new Net::IP($net);
  $ip = new Net::IP($ip);

  my $overlaps = $net->overlaps($ip, $net);
  $overlaps ? ($overlaps eq $Net::IP::IP_B_IN_A_OVERLAP) : 0;
}

sub is_loop_ip($)
{
  ip_in_net "127.0.0.0/8", $_[0] || ip_in_net "::1/128", $_[0];
}

sub GetNameserverState()
{
  my $nameservers;

  if (-f $fn_nameservers)
  {
    $nameservers = $json->decode(path($fn_nameservers)->slurp_utf8);
  }

  for (keys %$nameservers)
  {
    $nameservers->{$_}->{activate} = ($nameservers->{$_}->{activate} // undef) eq JSON::true ? 1 : 0;
  }

  $nameservers;
}

sub GetCurrentNameservers()
{
  my @parts = glob "$dir_interface/*";
  my %nameservers;

  for (@parts)
  {
    -f or next;
    $nameservers{$_} = 0 for grep { not is_loop_ip $_ } map
        {
          (my $ns = $_) =~ s/^nameserver\s(.+)$/$1/g; chomp $ns; $ns;
        } grep { /^nameserver\s/ } path($_)->lines_utf8;
  }

  my %state = %{ GetNameserverState() };
  for (keys %nameservers)
  {
    $nameservers{$_} = $state{$_} // { hostname => undef, activate => 0 };
  }

  %nameservers;
}

sub SetNameserverState(%)
{
  my %nameservers = %{ $_[0] };
  $nameservers{$_}{activate} = $nameservers{$_}{activate} ?
     JSON::true : JSON::false for keys %nameservers;

  path($fn_nameservers)->spew_utf8($json->encode(\%nameservers));
}

1;
