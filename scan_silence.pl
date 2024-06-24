#!/usr/bin/perl
use Data::Dumper;
use Getopt::Long;

my $dir;
my $info_cmd = "ffmpeg -hide_banner -i !FILEPATH! -af silencedetect=n=-40dB:d=5 -f null - 2>&1";

GetOptions(
    'd|dir=s'   => \$dir,

) or die "$!";

unless (defined $dir) {
    die;
}
my @files = `find $dir -type f`;

foreach my $f(@files) {
    chomp $f;
    scan_file($f);
    exit();
}

sub scan_file {
    my ($f) = @_;
    (my $cmd = $info_cmd) =~ s/!FILEPATH!/$f/;
    print Dumper $cmd;
    my @INFO = `$cmd`;
    print Dumper @INFO;
    my $H = parse_info(\@INFO);
}

sub parse_info {
    my ($i) = @_;
    my $H;

}
