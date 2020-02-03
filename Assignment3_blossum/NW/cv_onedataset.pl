
$train_file=shift; #unaligned
open(IN,$train_file);
@train=<IN>;
chomp(@train);


@G= (-8);
@error = ();
for(my $i=0;$i<scalar(@train);$i++)
{

$unaligned=$train[$i];
$aligned=$unaligned;
 $aligned=~s/.unaligned//g;
#print"unaligned =$unaligned , aligned = $aligned \n";

for(my $j=0;$j<scalar(@G);$j++)
 {
 $data =$unaligned;
 $g=$G[$j];
 system("perl NW.pl $data $g > NW_alignment");
 $err =`perl alignment_accuracy.pl  $aligned  NW_alignment`;
 $error{$g} += $err;
 print"$aligned $g  $err \n";
}
}

 @keys=keys(%error);
for(my $i=0; $i<scalar(@keys);$i++)
{
 $error{$keys[$i]}=$error{$keys[$i]}/scalar(@train);
 print" $keys[$i] $error{$keys[$i]} \n ";
}
