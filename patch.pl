#! /usr/bin/env perl

use strict;
use warnings;

my $file = $ARGV[0] or die("$0 <filename>");

my $dev_no_linenumber = $ENV{'DEV_NO_LINENUMER'} or 0;

open(my $fh, "<:encoding(utf8)", $file);
chomp(my @lines = <$fh>);
close($fh);

my $indent_type = "\t";
my $indent_count = -1;

foreach my $line (@lines) {
  if( $line =~ /^(\t+)/) {
    $indent_type = "\t";
    $indent_count = length($1);
    last;
  }
  if( $line =~ /^( +)/) {
    $indent_type = " ";
    $indent_count = length($1);
    last;
  }
}

sub get_indent_count {
  my $line = $_[0];
  if( $line =~ /^(\t+)/) {
    return length($1);
  }
  elsif( $line =~ /^( +)/) {
    return length($1) / $indent_count;
  }
  return 0;
}

my $line_cnt = scalar(@lines);

my $lastIc = 0;

for (my $i = 0; $i < $line_cnt; $i++) {
  my $line = $lines[$i];
  if (length($line) eq 0) {
    print("\n");
    next;
  }
  if ($line =~ /^\s+#/ or $line =~ /^\s*match .+:/ or $line =~ /^\s+return/) {
    print("$line\n");
    next;
  }
  my $ic = get_indent_count($line);
  if ($line =~ /^\s*.+:/ and not $line =~ /".*:.*"/ and not $line =~ /:(\s*[a-zA-Z0-9]*)=/ and not $line =~ /var.*:/) {
    $ic++;
  }
  # pre line when block has ended and new begin even on empty lines
  print("$line\n");
  if ($ic eq 0) {
    next
  }
  my $ins = 0;
  if ($ic eq $lastIc or $ic gt $lastIc or $ic lt $lastIc) {
    $ins = 1;
  } else {
    $ins = 0;
  }
  if ($ins eq 1) {
    my $t = $i + 1;
    if ($dev_no_linenumber) {
      $t = -1;
    }
    my $indent = $indent_type x $indent_count x $ic;
    chomp($line);
    print($indent . "NaiveGBScriptProfiler.note('$file', $t, OS.get_ticks_msec(), '$indent$line')\n");
  }
  $lastIc = $ic;
}
