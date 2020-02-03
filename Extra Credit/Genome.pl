open(IN, shift);
@dogF = <IN>;
chomp(@dogF);
$dogFull = join '',@dogF;

open(IN, shift);
@ratF = <IN>;
chomp(@ratF);
$ratFull = join '',@ratF;

%d;
%r;

$seed = shift;
$ls = length($seed);
$ldog = length($dogFull)-12;
$lrat = length($ratFull)-12;
#print "$ldog\n";
#print "$lrat\n";

###Dog hash
$count = 0;
for(my $i = 12; $i < (length($dogFull) - $ls + 1); $i++){
  $key = "";
  $sub = substr($dogFull, $i, $ls);
 # if($i%10000==0){print "dog $i\n";}
  for(my $j = 0; $j < $ls; $j++){
    $ch = substr($sub, $j, 1);
    $s = substr($seed, $j, 1);
      if($s eq '1' && $ch eq uc $ch){
        $key = $key . $ch;}
  }
  if ($key eq '' || exists $d{$key}){}
  else{$d{$key} = $i;#print "$key\n";
#      print "$key   $i\n";
    $count++;
#    print "Dog key count: $count\n";
}
}

###Rat Hash
$count2 = 0;
for(my $i = 12; $i < (length($ratFull) - $ls + 1); $i++){
  $key2 = "";
  $sub2 = substr($ratFull, $i, $ls);
  for(my $j = 0; $j < $ls; $j++){
    $ch2 = substr($sub2, $j, 1);
    $s2 = substr($seed, $j, 1);
      if($s2 eq '1' && $ch2 eq uc $ch2){
        $key2 = $key2 . $ch2;
	}
  }
  if ($key2 eq '' || exists $r{$key2}){}
  else{$r{$key2} = $i;#print "$key2\n";
    # print "$key   $i\n";
    $count2++;
#    print "Rat key count: $count2\n";
}
}


###hit check
$hit = 0;

#open(my $line, $line2, '>', 'dog-rat.maf');
print "##maf version = 1\n\na score = 0.00000\n";
foreach $k (keys %r){
  if (exists $d{$k}){
    $strdog = substr($dogFull, $d{$k}, $ls);
    $lk = length($k);
    $line = "s simDog.chrA $d{$k} $lk + $ldog $k \n";
    print "$line";
    $hit++;
  }
}
print "\na score = 0.00000\n";
foreach $k (keys %r){
  if (exists $d{$k}){
    $strrat = substr($ratFull, $r{$k}, $ls);
    $lk = length($k);
    $line2 = "s simRat.chrQ $r{$k} $lk + $lrat $k \n";
    print "$line2";
  }
}
#print "hit count: $hit\n";