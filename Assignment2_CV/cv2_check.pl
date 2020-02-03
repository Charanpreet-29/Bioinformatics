$train_file=shift;
open(IN, $train_file);
@train=<IN>;
chomp(@train);

@G=(-16);
@Ge=(-2,-1);
%error=();
$E =0;


=pod
  for (my $i=0; $i<scalar(@G); $i++)
  {
        $g = $G[$i]; 
    

 for (my $j=0;$j<scalar(@Ge);$j++)
   {
       $ge=$Ge[$j];

    for (my $k=0; $k<scalar(@train); $k++)
    {
      
          $unaligned=$train[$k];
        $aligned=$unaligned;
        $aligned=~s/.unaligned//g;
       print "unaligned=$unaligned, aligned=$aligned\n";  
               $data=$unaligned;   
          system("perl ag1.pl $data $g $ge > NW_alignment");
           $err=`perl alignment_accuracy1.pl $aligned NW_alignment`;
	  #$E +=$err;
            $error{$g}{$e}+=$err;
         print "$aligned $g $e $err \n";
  }
}  
}
=cut


  for (my $i=0; $i<scalar(@train); $i++)
  {
      $unaligned=$train[$i];
        $aligned=$unaligned;
        $aligned=~s/.unaligned//g;
       print "unaligned=$unaligned, aligned=$aligned\n";

 for (my $j=0;$j<scalar(@G);$j++)
   {
       $g = $G[$j]; 
         $data=$unaligned;
    for (my $k=0; $k<scalar(@Ge); $k++)
    {
      
          $e=$Ge[$k];
          system("perl ag1.pl $data $g $e > NW_alignment");
           $err=`perl alignment_accuracy1.pl $aligned NW_alignment`;
	  #$E +=$err;
            $error{$g}{$e}+=$err;
         print "$aligned $g $e $err \n";
  }
}  
}
#$m=$E/100;

#print "\nError: $m\n";

foreach my $gapopen (sort keys %error)
{
 	foreach my $gapextension (keys %{$error{$gapopen}})

           {   my $m= ($error{$gapopen}{$gapextension})/(scalar(@train));             
               print  "$gapopen , $ gapextension : $m \n";
             
}
}

=pod
#Print error for different gaps
for (my $i=0; $i<scalar(@G); $i++)
{
for (my $j=0; $j<scalar(@Ge);$j++ )
{
$error{$G}{$Ge}=($error {$G}{$Ge})/scalar(@train);
print " $G  $Ge  $error{$G}{$Ge}\n";
}
}
=cut
