open(IN,shift);
 @data=<IN>;
chomp(@data);
$seq1=$data[1];
$seq2=$data[3]; #$delta=shift; $eta=shift;
$delta=0.2;
$eta=0.4;
$pm=0.6;
$pmm=1-$pm;
$pgap=1;
$tau=0; #BM=1/3 ; BX=1/3 ; BY=1/3;
$BM=1-2*$delta-$tau;
$BX=$delta;
$BY=$delta;
$MX=$delta;
$MY=$delta;
$MM=1-2*$delta-$tau;
$XX=$eta;
$XM=1-$eta-$tau;
$XY=0;
$YY=$eta;
$YM=1-$eta-$tau;
$YX=0;

@list=();
for(my $i=0;$i<length($seq1);$i++)
  {
    $ch1=substr($seq1,$i,1);
    $ch2=substr($seq2,$i,1);
    if ($ch1 ne "-" && $ch2 ne "-" && $ch1=~/[A-Z]/ && $ch2 =~/[A-Z]/)
       {
          if($ch1 eq $ch2)
           {
             $list[$i]='M';
             $p=$pm;
            }
          else
           {
             $list[$i]='M';
             $p=$pmm;
           }
         }
      elsif($ch1 = "-" && $ch2 ne "-" && $ch2 =~/[A-Z]/)
         {
 $list[$i]='X';
         }
      else
         {
          $list[$i]='Y';
         }

    }

print "$seq1 \n$seq2 \n@list \n";


$prob=$BM;
for(my $i=0;$i<length($seq1)-1;$i++)
  {

    if($list[$i] eq "M" && $list[$i+1] eq "X")
     {
         $ch1=substr($seq1,$i,1);
         $ch2=substr($seq2,$i,1);
         if(ch1 eq ch2)
         {
 $prob=$prob*$MX*$pm ;
          }
          else
          {
       $prob=$prob*$MX*$pmm ;
          }
       #print " $list[$i] $list[$i+1] MX : $MX \n" ;
     }
    elsif($list[$i] eq "M" && $list[$i+1] eq "M")
     {
       $ch1=substr($seq1,$i,1);
         $ch2=substr($seq2,$i,1);
         if(ch1 eq ch2)
         {
       $prob=$prob*$MM*$pm ;
          }
          else
          {
       $prob=$prob*$MM*$pmm ;
          }
       #$prob=$prob*$MM;
       #print " MM : $MM \n";
  }
    elsif($list[$i] eq "M" && $list[$i+1] eq "Y")
     {
      $ch1=substr($seq1,$i,1);
         $ch2=substr($seq2,$i,1);
         if(ch1 eq ch2)
         {
       $prob=$prob*$MY*$pm ;
          }
          else
          {
       $prob=$prob*$MY*$pmm ;
          }
       $prob=$prob*$MY;
       #print " MY : $MY\n";
     }
   elsif($list[$i] eq "X" && $list[$i+1] eq "X")
     {
       $prob=$prob*$XX;
       #print " XX : $XX \n";
     }
  elsif($list[$i] eq "Y" && $list[$i+1] eq "Y")
 {
       $prob=$prob*$YY;
       #print " YY : $YY \n";
     }
  elsif($list[$i] eq "X" &&$list[$i+1] eq "M")
     {
       $prob=$prob*$XM;
       #print " XM : $XM";
     }
  elsif($list[$i] eq "Y" && $list[$i+1] eq "M")
     {
       $prob=$prob*$YM;
       #print " YM : $YM \n";
      }
   }
 print "\n prob = $prob \n";
