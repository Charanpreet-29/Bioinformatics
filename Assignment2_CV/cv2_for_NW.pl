$train_file=shift;
open(IN, $train_file);
@train=<IN>;
chomp(@train);

@G=(-16, -14, -12, -10, -8, -6, -4, -2);
%error=();

for (my $i=0; $i<scalar(@train); $i++)
{
  $unaligned=$train[$i];
  $aligned=$unaligned;
  $aligned=~s/.unaligned//g;
 print "unaligned=$unaligned, aligned=$aligned\n";

  for (my $j=0; $j<scalar(@G); $j++)
  {
     #Let Data=unaligned data
     $data=$unaligned;
	 $g=$G[$j];

#Call NW(g).pl on data
  system("perl NW.pl $data $g > NW_alignment");
#Get error
     $err=`perl alignment_accuracy1.pl $aligned NW_alignment`;
     $error{$g}+=$err;
     print "$aligned $g $err\n";
  }
}  

#Print error for different gaps
@keys=keys(%error);
for (my $i=0; $i<scalar(@keys); $i++)
{
$error{$keys[$i]}=$error{$keys[$i]}/scalar(@train);
print "$keys[$i] $error{$keys[$i]}\n";
}
