#file calling
$input=shift;
print("filename is $input \n");
open(IN,$input);
@data=<IN>;
chomp(@data);

#giving values for match,mismatch,shift and gap
$m=5; $mm=-4; $g=-20; $e=-.1;
$seq1=$data[1];
$seq2=$data[3];

#giving length size
$m=length($seq1);
$n=length($seq2);

#initializing the array
@V=();
@M=();
@E=();
@F=();
@T=();

#initialization
$V[0][0] = 0;
$M[0][0] = 0;
$E[0][0] = -inf;
$F[0][0] = -inf;
$T[0][0]=0;

#initialization V,M,T,E,F
for(my $i=1;$i<$m+1;$i++)
{
 $V[$i][0] = $g+($i-1)*$e;
 $M[$i][0] = -inf;
 $E[$i][0] = -inf;
 $T[$i][0]='U';
 $F[$i][0] = $g+($i-1)*$e;
}
 for(my $j=1;$j<$n+1;$j++)
  {
   $V[0][$j] = $g+($j-1)*$e;
   $M[0][$j] = -inf;
   $E[0][$j] = $g+($j-1)*$e;
   $F[0][$j]= -inf;
   $T[0][$j]='L';
  }


#printing v
print("\n");
print("for matrice V \n");
for (my $i=0;$i<length($seq1)+1;$i++)
{
 for(my $j=0; $j<length($seq2)+1;$j++)
  {
     print($V[$i][$j]." ");
  }
 print("\n");
}


print("for matrice M,D \n");
#for matrice M (xi aligned to yj)
#recurrence M
for (my $i=1;$i<$m+1;$i++)
{
    for (my $j=1;$j<$n+1;$j++)
   {
        if(substr($seq1,$i-1,1) eq substr($seq2,$j-1,1))
         {
                $M[$i][$j]=$V[$i-1][$j-1]+$m;
         }
        else
         {
                $M[$i][$j]=$V[$i-1][$j-1]+$mm;
         }
           $D=$M[$i][$j];
   }
}

#priniting M
for(my $i=0;$i<length($seq1)+1;$i++)
{
 for(my $j=0; $j<length($seq2)+1;$j++)
  {
     print($M[$i][$j]." ");
  }
 print("\n");
}

print("\n");

#for matrice F  Xi aligned to gap
#recurence F
for (my $i=1;$i<$m+1;$i++)
{
    for (my $j=1;$j<$n+1;$j++)
   {
       if(($M[$i-1][$j]+$g) >= ($F[$i-1][$j]+$e))
        {
          $F[$i][$j]=$M[$i-1][$j] +$g;
        }
       else
        {
           $F[$i][$j]=$F[$i-1][$j]+$e;
        }
                $U=$F[$i][$j];
   }
}
 print ("\n ");

print("for matrice F,U \n");
for(my $i=0;$i<length($seq1)+1;$i++)
{
 for(my $j=0; $j<length($seq2)+1;$j++)
  {
   print($F[$i][$j]." ");
  }
 print("\n");
}



#for matrice E  Xi aligned to gap

for (my $i=1;$i<$m+1;$i++)
{
    for (my $j=1;$j<$n+1;$j++)
   {
       if(($M[$i][$j-1]+$g) >= ($E[$i][$j-1]+$e))
        {
          $E[$i][$j]=$M[$i][$j-1]+$g;
        }
       else
        {
          $E[$i][$j]=$E[$i][$j-1]+$e;
        }
        $L=$E[$i][$j];
   }
}

print ("\n ");

print("for matrice E,L \n");
for(my $i=0;$i<length($seq1)+1;$i++)
{
 for(my $j=0;$j<length($seq2)+1;$j++)
  {
   print($E[$i][$j]." ");
  }
 print("\n");
}

#assigning value U,L,D
for (my $i=1;$i<length($seq1)+1;$i++)
{
 for(my $j=1;$j<length($seq2)+1;$j++)
  {
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
    else
      {
        $V[$i][$j]=$M[$i][$j];
         $T[$i][$j]='D';

      }
  }
}

 print ("\n ");
print("for matrice final matrice V \n");
for(my $i=0;$i<length($seq1)+1;$i++)
{
 for(my $j=0;$j<length($seq2)+1;$j++)
  {
   print($V[$i][$j]." ");
  }
 print("\n");
}

 print ("\n ");
print("Traceback \n");
for(my $i=0;$i<length($seq1)+1;$i++)
{
 for(my $j=0; $j<length($seq2)+1;$j++)
  {
   print($T[$i][$j]." ");
  }
 print("\n");
}

$i=length($seq1);
$j=length($seq2);
$aligned_seq1="";
$aligned_seq2="";
print"\$i=$i,\$j=$j";

print("\n");

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
print("\n");
print "new seq1=$aligned_seq1 \n";
print "new seq2=$aligned_seq2 \n";
print("\n");

