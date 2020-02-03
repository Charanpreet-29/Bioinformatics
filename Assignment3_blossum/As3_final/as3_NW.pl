#file calling
$input=shift;
#print("filename is $input \n");
open(IN,$input);
@data=<IN>;
chomp(@data);

#giving values for match,mismatch and gap
#$m=5;
#$mm=-4;
$g=shift;
$seq1=$data[1] ;
$seq2=$data[3];

#$blos_file=shift;
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


#print "\$seq1= $seq1 , \$seq2=$seq2 \n";
#print("\n");
#initializing the array
@V=();
@T=();

$V[0][0]=0;

#initializing the first row
for(my $i=1; $i<length($seq1)+1;$i++)
 {
  $V[$i][0]=$g*$i;
  $T[$i][0]='U';
}

#initializing the first column
for(my $i=1; $i<length($seq2)+1;$i++)
 {
  $V[0][$i]=$g*$i;
  $T[0][$i]='L';
}

#recurrence
for(my $i=1;$i<length($seq1)+1;$i++)
{
 for(my $j=1;$j<length($seq2)+1;$j++) 
  {
    $U=$V[$i-1][$j]+$g;
    $L=$V[$i][$j-1]+$g;
   if(substr($seq1,$i-1,1) eq substr($seq2,$j-1,1))
    {
      $n=substr($seq1,$i-1,1);
      $m=substr($seq2,$j-1,1);
     $D=$V[$i-1][$j-1]+$hashie{$n}{$m};
    }
   else
    {
      $n=substr($seq1,$i-1,1);
      $m=substr($seq2,$j-1,1);
     $D=$V[$i-1][$j-1]+$hashie{$n}{$m};
     }
   if($D>=$L && $D>=$U)
     {
      $V[$i][$j]=$D;
      $T[$i][$j]='D';
     }
   elsif($U>=$L && $U>=$D)
     {
      $V[$i][$j]=$U;
      $T[$i][$j]='U';
     }
   else
     {
      $V[$i][$j]=$L;
      $T[$i][$j]='L';
     }
   }      
}

# printing the NW table in highest priority number form



#traceback
$i=length($seq1);
$j=length($seq2);
$aligned_seq1="";
$aligned_seq2="";

while($i!=0 || $j!=0)
{
 if($T[$i][$j] eq 'L')
  {
    $str1='-';
    $str2=substr($seq2,$j-1,1);
    $j=$j-1;
  }
 elsif($T[$i][$j] eq 'U')
  {
    $str1=substr($seq1,$i-1,1);
    $str2='-';
    $i=$i-1;

  }
 else
  {
    $str1=substr($seq1,$i-1,1);
    $str2=substr($seq2,$j-1,1);
    $i=$i-1;
   $j=$j-1;
 }
    $aligned_seq1=$str1.$aligned_seq1;
    $aligned_seq2=$str2.$aligned_seq2;

  }

print "$data[0]\n";
print "$aligned_seq1 \n";
print "$data[2]\n";
print "$aligned_seq2";
#print("\n");
