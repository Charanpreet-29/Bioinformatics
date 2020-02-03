#file calling
$input=shift;
print("filename is $input \n");
open(IN,$input);
@data=<IN>;
chomp(@data);

#giving values for match,mismatch and gap
$m=5;$mm=-4;$g=-20;
$seq1=$data[1] ; $seq2=$data[3];

print "\$seq1= $seq1 , \$seq2=$seq2 \n";
print("\n");
#initializing the array
@V=();
@T=();

$V[0][0]=0;

#initializing the first row
for(my $i=1; $i<length($seq1)+1;$i++)
 {
  $V[$i][0]=0;
}

#initializing the first column
for(my $i=1; $i<length($seq2)+1;$i++)
 {
  $V[0][$i]=0;
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
     $D=$V[$i-1][$j-1]+$m;
    }
   else
    {
     $D=$V[$i-1][$j-1]+$mm;
     }
   if($D>=$L && $D>=$U && $D>0)
     {
      $V[$i][$j]=$D;
      $T[$i][$j]='D';
     }
   elsif($U>=$L && $U>=$D && $U>0)
     {
      $V[$i][$j]=$U;
      $T[$i][$j]='U';
     }
   elsif($L>=$U && $L>=$D && $L>0)
     {
      $V[$i][$j]=$L;
      $T[$i][$j]='L';
     }
   else
     {
      $V[$i][$j]=0;
      $T[$i][$j]=0;
     }
   }
}


# printing the NW table in highest priority number form
for(my $i=0;$i<length($seq1)+1;$i++)
{
 for(my $j=0; $j<length($seq2)+1;$j++)
  {
   print($V[$i][$j]." ");
  }
 print("\n");
}

print("\n");


#printing the Nw table in the L,U,D form
for(my $i=0; $i<length($seq1)+1;$i++)
 {
  for(my $j=0; $j<length($seq2)+1;$j++)
   {
     print($T[$i][$j]." ");
   }
  print("\n");
 }

print("\n");

#printing max value in matrix

$max=0;
for(my $i=1;$i<length($seq1)+1;$i++)
{
 for(my $j=1;$j<length($seq2)+1;$j++)
  {
    if($V[$i][$j]>$max)
     {
       $max = $V[$i][$j];
        $it=$i;
        $jt=$j;
      }
 }
}

#traceback

 $i=$it;
 $j=$jt;

$aligned_seq1="";
$aligned_seq2="";

while($V[$i][$j]!= 0)
  { 
     #print " $V[$i][$j] \n ";
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
 elsif($T[$i][$j] eq 'D')
  {
    $str1=substr($seq1,$i-1,1);
    $str2=substr($seq2,$j-1,1);
    $i=$i-1;
    $j=$j-1;
  }
    $aligned_seq1=$str1.$aligned_seq1;
    $aligned_seq2=$str2.$aligned_seq2;
   }

print("\n LOCAL SEQUENCE IS \n");
print "new seq1=$aligned_seq1 \n";
print "new seq2=$aligned_seq2 \n";
print("\n");
