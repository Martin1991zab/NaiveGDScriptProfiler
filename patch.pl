#! /usr/bin/env perl

use strict;
use warnings;

my $file = $ARGV[0] or die("$0 <filename>");

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
  elsif( $line =~ /^( +)/) {
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
    return length($1);
  }
  return 0;
}

# print("ident type: $indent_type\n");
# print("ident width: $indent_count\n");

my $line_cnt = scalar(@lines);

my $lastIc = 0;

for (my $i = 0; $i < $line_cnt; $i++) {
  my $line = $lines[$i];
  if (length($line) eq 0) {
    print("\n");
    next;
  }
  my $ic = get_indent_count($line);
  my $i = $indent_type x $indent_count x $ic;
  print("$line\n");
  if ($ic gt 0) {
    # TODO handle control structure
    print("$i");
    if ($ic eq $lastIc) {
      print("insert on same level");
    } elsif ($ic gt $lastIc) {
      print("insert on deeper level");
    } elsif ($ic lt $lastIc) {
      print("insert on higher level")
    } else {
      print("insert nothing");
    }
    print(" || $lastIc -> $ic\n");
  }
  $lastIc = $ic;
}
