 #cv2.pl

$train_file=shift;
open(IN, $train_file);
@train=<IN>;
chomp(@train);

@Delta =(.1,.15, .2, .25, .3, .35, .4, .45, .5);
@Eta =(.2, .25, .3, .35, .4, .45, .5, .55, .6);
%error=();

for (my $i=0; $i<scalar(@train); $i++)
{
       $unaligned=$train[$i];
       $aligned=$unaligned;
       $aligned=~s/.unaligned//g;
       $data=$unaligned;
 print " ($i) unaligned=$unaligned, aligned=$aligned\n";

 for (my $j=0; $j<scalar(@Delta); $j++)
  {
    for(my $k=0; $k<scalar(@Eta); $k++)
    {
	   #Let Data=unaligned data
	   $delta=$Delta[$j];
       $eta=$Eta[$k]; 
  
#Call NW(g).pl on data
  system("perl hmm.pl $data $delta $eta > HMM_alignment");
#Get error
     $err=`perl alignment_accuracy.pl $aligned HMM_alignment`;
     $error{$delta}{$eta}+=$err;
     print "$aligned $delta $eta $err\n";
  }
} 
} 

@err1;
$i=0;
#Print error for different gaps
foreach my $delta (sort keys %error)
{
foreach my $eta (keys %{$error{$delta}})
          {   
             
              $err1[$i] = ($error{$delta}{$eta});#(scalar(@train));             
              print  "$delta $eta $err1[$i] \n";
}
}

print"\n **delta-eta pairs sorted by their cross-validation error** \n ";
for my $keypair (
        sort { $error{$b->[0]}{$b->[1]} <=> $error{$a->[0]}{$a->[1]} }
        map { my $intKey=$_; map [$intKey, $_], keys %{$error{$intKey}} } keys %error
) {
    printf( " %5s,%5s => %s\n", $keypair->[0], $keypair->[1], $error{$keypair->[0]}{$keypair->[1]} );
}


