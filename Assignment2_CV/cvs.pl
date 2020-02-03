$train_file=shift;
open(IN, $train_file);
@train=<IN>;
chomp(@train);

@G=(-16, -14, -12, -10, -8, -6, -4, -2);
@Ge=(-2,-1, -.5, -.1);
%error=();

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
          system("perl affinegap.pl $data $g $e > NW_alignment");
           $err=`perl alignment_accuracy.pl $aligned NW_alignment`;
            $error{$g}{$e}+=$err;
         print "$aligned $g $e $err \n";
  }
}  
}

foreach my $gapopen (sort keys %error)
{
 	foreach my $gapextension (keys %{$error{$gapopen}})

           {   my $m= ($error{$gapopen}{$gapextension})/(scalar(@train));             
               print  "$gapopen , $ gapextension : $m \n";
             
}
}

