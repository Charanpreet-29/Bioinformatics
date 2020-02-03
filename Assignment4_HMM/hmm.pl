#HMM.pl


$filename=shift;
#print "filename is $filename\n";
open(IN, $filename);
@data=<IN>;
chomp(@data);

$seq1=$data[1]; $seq2=$data[3];
$delta=shift; $eta=shift;
$V[0][0]=0;
$T[0][0]=0;

#Transition probabilities
$BX=$delta; $BY=$delta; $BM=1-2*$delta;
$MX=$delta; $MY=$delta; $MM=1-2*$delta;
$XX=$eta; $XY=0; $XM=1-$eta;
$YY=$eta; $YX=0; $YM=1-$eta;

#Emission probabilities
$pgap=1; $pm=0.6; $pmm=1-$pm;

#Initialization
#Initialize B
$B[0][0]=1; $B[0][1]=0; $B[1][0]=0;
for (my $i=1; $i<=length($seq1); $i++)
{
  for (my $j=1; $j<=length($seq2); $j++)
  {
  $B[$i][$j]=0;
  }
}

#Initialize M

$M[0][0]=0;
for (my $i=1; $i<=length($seq1); $i++)
{
  $M[0][$i]=0; 
}
for (my $i=1; $i<=length($seq2); $i++)
{
  $M[$i][0]=0;
}

#Initialize X
$X[0][0]=0;
$X[1][0]=$pgap*$BX*$B[0][0];
for (my $i=1; $i<length($seq1); $i++)
{
  $X[0][$i]=0; 
}
for (my $i=2; $i<length($seq2); $i++)
{
  $X[$i][0]=$pgap*$XX*$X[$i-1][0];
}

#Initialize Y
$Y[0][0]=0;
$Y[0][1]=$pgap*$BY*$B[0][0];
for (my $i=2; $i<length($seq1); $i++)
{
 $Y[0][$i]=$pgap*$YY*$Y[0][$i-1]; 
}
for (my $i=1; $i<length($seq2); $i++)
{
  $Y[$i][0]=0;
}

#Initialize T
for (my $i=1; $i<=length($seq1); $i++)
{
 $T[$i][0]='U';
}
for (my $i=1; $i<=length($seq2); $i++)
{
  $T[0][$i]="L";
}

#Recurrence
for (my $i=1; $i<=length($seq1); $i++)
{
  for (my $j=1; $j<=length($seq2); $j++)
   {
     if (($MX*$M[$i-1][$j])>=($XX*$X[$i-1][$j]) && ($MX*$M[$i-1][$j])>=($BX*$B[$i-1][$j]))
	 {
	    $X[$i][$j]=$MX*$M[$i-1][$j];
	 }
	 elsif (($XX*$X[$i-1][$j])>=($MX*$M[$i-1][$j]) && ($XX*$X[$i-1][$j])>=($BX*$B[$i-1][$j]))
	 {
	    $X[$i][$j]=$XX*$X[$i-1][$j];
	 }
	 elsif (($BX*$B[$i-1][$j])>=($MX*$M[$i-1][$j]) && ($BX*$B[$i-1][$j])>=($XX*$X[$i-1][$j]))
	 {
	     $X[$i][$j]=$BX*$B[$i-1][$j];
	 }
	 if (($MY*$M[$i][$j-1])>=($YY*$Y[$i][$j-1]) && ($MY*$M[$i][$j-1])>=($BY*$B[$i][$j-1]))
	 {
	    $Y[$i][$j]=$MY*$M[$i][$j-1];
	 }
	 elsif (($YY*$Y[$i][$j-1])>=($MY*$M[$i][$j-1]) && ($YY*$Y[$i][$j-1])>=($BY*$B[$i][$j-1]))
	 {
	    $Y[$i][$j]=$YY*$Y[$i][$j-1];
	 }
	 elsif (($BY*$B[$i][$j-1])>=($MY*$M[$i][$j-1]) && ($BY*$B[$i][$j-1])>=($YY*$Y[$i][$j-1]))
	 {
	    $Y[$i][$j]=$BY*$B[$i][$j-1];
	 }
     if (($MM*$M[$i-1][$j-1])>=($XM*$X[$i-1][$j-1]) && ($MM*$M[$i-1][$j-1])>=($YM*$Y[$i-1][$j-1]) && ($MM*$M[$i-1][$j-1])>=($BM*$B[$i-1][$j-1]))
	 {
	    $M[$i][$j]=$MM*$M[$i-1][$j-1];
	 }  
	 elsif (($XM*$X[$i-1][$j-1])>=($MM*$M[$i-1][$j-1]) && ($XM*$X[$i-1][$j-1])>=($YM*$Y[$i-1][$j-1]) && ($XM*$X[$i-1][$j-1])>=($BM*$B[$i-1][$j-1]))
	 {
	    $M[$i][$j]=$XM*$X[$i-1][$j-1];
	 } 
	 elsif (($YM*$Y[$i-1][$j-1])>=($MM*$M[$i-1][$j-1]) && ($YM*$Y[$i-1][$j-1])>=($XM*$X[$i-1][$j-1]) && ($YM*$Y[$i-1][$j-1])>=($BM*$B[$i-1][$j-1]))
	 {
	    $M[$i][$j]=$YM*$Y[$i-1][$j-1];
	 }
	 elsif (($BM*$B[$i-1][$j-1])>=($MM*$M[$i-1][$j-1]) && ($BM*$B[$i-1][$j-1])>=($XM*$X[$i-1][$j-1]) && ($BM*$B[$i-1][$j-1])>=($YM*$Y[$i-1][$j-1]))
	 {
	    $M[$i][$j]=$BM*$B[$i-1][$j-1];
	 }
	 if (substr($seq1, $i-1, 1) eq substr($seq2, $j-1, 1))
	 {
	     $M[$i][$j]=$M[$i][$j]*$pm;
	 }
	 else
	 {
	     $M[$i][$j]=$M[$i][$j]*$pmm;
	 }
         $X[$i][$j]=$X[$i][$j]*$pgap;
         $Y[$i][$j]=$Y[$i][$j]*$pgap;
     if (($M[$i][$j] >= $X[$i][$j]) && ($M[$i][$j] >= $Y[$i][$j]))
	 {
         $V[$i][$j]=$M[$i][$j];
         $T[$i][$j]='D';
      } 
	  elsif (($X[$i][$j] >= $M[$i][$j]) && ($X[$i][$j] >= $Y[$i][$j]))
      {
         $V[$i][$j]=$X[$i][$j];
         $T[$i][$j]='U';
      }     
    elsif (($Y[$i][$j] >= $M[$i][$j]) && ($Y[$i][$j] >= $X[$i][$j]))
      {
        $V[$i][$j]=$Y[$i][$j];
        $T[$i][$j]='L';
      }
   }
 }
 
#Traceback
$aligned_seq1=" ";
$aligned_seq2=" ";
$i=length($seq1);
$j=length($seq2);   

while($i!=0 || $j!=0)
{
   if ($T[$i][$j] eq 'L')
   {
      $ch1="-";
      $ch2=substr($seq2,$j-1,1);
      $j=$j-1;
   }
   elsif ($T[$i][$j] eq 'U')
   {
      $ch1=substr($seq1,$i-1,1);
      $ch2="-";
      $i=$i-1;
   }
   elsif ($T[$i][$j] eq 'D')
   {
      $ch1=substr($seq1,$i-1,1);
      $ch2=substr($seq2,$j-1,1);
      $i=$i-1; $j=$j-1;
   }  
       $aligned_seq1=$ch1.$aligned_seq1;
       $aligned_seq2=$ch2.$aligned_seq2;
}
print "$data[0]\n";
print "$aligned_seq1\n";
print "$data[2]\n";
print "$aligned_seq2\n";
print"\n";