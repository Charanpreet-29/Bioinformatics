#file calling
$input=shift;
print("filename is $input \n");

$v=`wc -l $input`;
print "$v";
$v=~ s\$input\\g ;
print "$v \n";

open(IN,$input);
@data=<IN>;
chomp(@data);

$m=5; $mm=-4; $g=-20; $score=0;

for(my $i=0;$i<$v;$i++)
{
$seq[$i+1]=$data[$i];
}

#printing
for(my $i=0;$i<$v;$i++)
{
print "$seq[$i+1]\n";
}
$n=length($seq[1]);
print "length is $n \n";

for(my $i=1 ; $i<$v ;$i++)
{
 for (my $j=$i+1;$j<=$v;$j++)
 {
     
      $score=0;
    for(my $k=0;$k<length($seq[1]);$k++)
	{
  
 if (substr($seq[$i], $k, 1) eq '-' || substr($seq[$j], $k, 1)eq '-')
  {
    $score+=$g;
  }
  elsif (substr($seq[$i], $k, 1) eq '-' && substr($seq[$j], $k, 1)eq '-')
  {
    $score+=$g;
  } 
  elsif (substr($seq[$i],$k, 1) eq substr($seq[$j], $k, 1))
  {
    $score+=$m;	
  }
  else
  {
    $score+=$mm;
  } 
  
 }
print " $i $seq[$i] $j $seq[$j] $score \n";
}
}
