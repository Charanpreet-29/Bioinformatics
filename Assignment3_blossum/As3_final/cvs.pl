use List::Util qw[min max];
$train_file=shift;
open(IN, $train_file);
@train=<IN>;
chomp(@train);

@G=(-16, -14, -12, -10, -8, -6, -4, -2);
@Ge=(-2, -1, -.5, -.1);
%error=();
@values;

  for (my $i=0; $i<scalar(@train); $i++)
  {
      $unaligned=$train[$i];
        $aligned=$unaligned;
        $aligned=~s/.unaligned//g;
      #print "unaligned=$unaligned, aligned=$aligned\n";

 for (my $j=0;$j<scalar(@G);$j++)
   {
       $g = $G[$j]; 
         $data=$unaligned;
    for (my $k=0; $k<scalar(@Ge); $k++)
    {
      
          $e=$Ge[$k];
          system("perl affinegaps.pl $data $g $e > NW_alignment");
           $err=`perl as3_alignment_accuracy.pl $aligned NW_alignment`;
            $error{$g}{$e}+=$err;
            #print "$aligned $g $e $err";
  }
}  
}

foreach my $gapopen (sort keys %error)
{
 	foreach my $gapextension (keys %{$error{$gapopen}})

           {  
               my $m= ($error{$gapopen}{$gapextension})/(scalar(@train));
               push(@values,$m);              
              # print  "$gapopen , $gapextension : $m \n";
             
           }
}

my $var1= min (@values);
#print "@values \n";
#print "minimum is $var1 \n"; 
my $var2= $var1 * (scalar(@train)); 
foreach my $gapopen (sort keys %error)
  {
 	foreach my $gapextension (keys %{$error{$gapopen}})
           {
                if ($var2 == $error{$gapopen}{$gapextension})
                   {
                     $n=$var1*100;
                     $y=sprintf("%.2f",$n);
                      print "$y($gapopen,$gapextension)\n ";
                    }
           }                                                      
  }
