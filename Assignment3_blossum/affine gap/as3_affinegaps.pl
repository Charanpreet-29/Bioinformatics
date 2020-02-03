#Affine_gap.pl

$filename=shift;
#print "filename is $filename\n";
open(IN, $filename);
@data=<IN>;
chomp(@data);

#$m=5;
 #$mm=-4;
 $g=shift; $e=shift;
$seq1=$data[1]; $seq2=$data[3];


open(IN,'BLOSUM_62.txt');
@bloss=<IN>;
chomp(@bloss);
@s1=();
#print"$bloss[0]";

@s1=split(/\s+/,$bloss[0]);
#print "@s1 \n";

#print("$s1[23] \n");

%hashie=();

for(my $i=1;$i<24;$i++)
{
 @s=split(/\s+/,$bloss[$i]);
   for(my $j=1;$j<24;$j++)
     {
       $hashie{$s[0]}{$s1[$j]}=$s[$j];
     }
}

#Initialization
@V=();
@M=();
@E=();
@F=();
@T=();

$T[0][0]=0;
$V[0][0]=0;
$M[0][0]=0;
$E[0][0]=-inf;
$F[0][0]=-inf;

for(my $i=1;$i<length($seq1)+1;$i++)
{
  $M[$i][0]=-inf;
  $E[$i][0]=-inf;
  $V[$i][0]=$F[$i][0]=$g+($i-1)*$e;
  $T[$i][0]='U';
}
for(my $j=1;$j<length($seq2)+1;$j++)
{
  $M[0][$j]=-inf;
  $F[0][$j]=-inf;
  $V[0][$j]=$E[0][$j]=$g+($j-1)*$e;
  $T[0][$j]='L';
}

#Recurrence
for (my $i=1; $i<=length($seq1)+1; $i++)
{
  for (my $j=1; $j<=length($seq2)+1; $j++)
   {
     if (substr($seq1, $i-1, 1) eq substr($seq2, $j-1, 1))
     {
        $ma=substr($seq1, $i-1, 1);
        $na=substr($seq2, $j-1, 1);
        $M[$i][$j]=$V[$i-1][$j-1]+ $hashie{$ma}{$na};
     }
     else
     {
         $ma=substr($seq1, $i-1, 1);
        $na=substr($seq2, $j-1, 1);
        $M[$i][$j]=$V[$i-1][$j-1]+ $hashie{$ma}{$na};
     }
	    $D=$M[$i][$j];
     if (($M[$i-1][$j]+$g)>=($F[$i-1][$j]+$e))
     { 
        $F[$i][$j]=$M[$i-1][$j]+$g;
     }
     else 
     {
        $F[$i][$j]=$F[$i-1][$j]+$e;
     }
     if (($M[$i][$j-1]+$g)>=($E[$i][$j-1]+$e))
     {
        $E[$i][$j]=$M[$i][$j-1]+$g;
     }
     else
     {
        $E[$i][$j]=$E[$i][$j-1]+$e;
     }
        $U=$F[$i][$j];
        $L=$E[$i][$j];   
    if (($F[$i][$j] >= $E[$i][$j]) && ($F[$i][$j] >= $M[$i][$j]))
	 {
         $V[$i][$j]=$F[$i][$j];
         $T[$i][$j]='U';
      }
	elsif(($E[$i][$j] >= $M[$i][$j]) && ($E[$i][$j] >= $F[$i][$j]))
      {
         $V[$i][$j]=$E[$i][$j];
         $T[$i][$j]='L';
      }
	elsif(($M[$i][$j] >= $E[$i][$j]) && ($M[$i][$j] >= $F[$i][$j]))
      {
        $V[$i][$j]=$M[$i][$j];
        $T[$i][$j]='D';
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
   if ($T[$i][$j] eq 'U')
   {

      $ch1=substr($seq1,$i-1,1);
      $ch2="-";
      $i=$i-1;
 
       }
   elsif ($T[$i][$j] eq 'L')
   { 
       $ch1="-";
      $ch2=substr($seq2,$j-1,1);
      $j=$j-1;
 
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
