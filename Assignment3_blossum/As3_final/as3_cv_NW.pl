use List::Util qw[min max];

$train_file=shift; #unaligned
open(IN,$train_file);
@train=<IN>;
chomp(@train);


@G= (-16, -14, -12, -10, -8, -6, -4, -2);
@error = ();
@values=();
for(my $i=0;$i<scalar(@train);$i++)
{

$unaligned=$train[$i];
$aligned=$unaligned;
 $aligned=~s/.unaligned//g;
print"unaligned =$unaligned , aligned = $aligned \n";

for(my $j=0;$j<scalar(@G);$j++)
 {
 $data =$unaligned;
 $g=$G[$j];
 system("perl as3_NW.pl $data $g > NW_alignment");
 $err =`perl as3_alignment_accuracy.pl  $aligned  NW_alignment`;
 $error{$g} += $err;
 print"$aligned $g  $err";
}
}

 @keys=keys(%error);
for(my $i=0; $i<scalar(@keys);$i++)
{
 $m = $error{$keys[$i]}/scalar(@train);
 $error{$keys[$i]}=$m;
 push(@values,$m);
 #print" $keys[$i] $error{$keys[$i]} \n ";
}
  
my $var1= min(@values);

for(my $i=0; $i<scalar(@keys);$i++)
{ 
   if ($var1 == $error{$keys[$i]})
                {
                  $n=$var1*100;
                  $y=sprintf("%.2f",$n);
                  print " $y {$keys[$i]}";
                 }
}



