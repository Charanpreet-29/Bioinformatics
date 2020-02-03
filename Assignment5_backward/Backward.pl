open(IN,shift);
@data=<IN>;
close(IN);
chomp(@data);
$seq1=$data[1];
$seq2=$data[3];

#$delta=shift; $eta=shift;
$delta=0.2;
$eta=0.4;
$pm=0.6;
$pmm=1-$pm;
$pgap=1;
$tau=0;

#BM=1/3 ; BX=1/3 ; BY=1/3
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

#Inititalization
$B[0][0]=1;
$B[0][1]=0;
$B[1][0]=0;
$M[0][0]=0;
$M[0][1]=0;
$M[1][0]=0;
$X[1][0]=$pgap*$BX*$B[0][0];
$Y[0][1]=$pgap*$BY*$B[0][0];
$X[0][0]=0;
$X[0][1]=0;
$Y[0][0]=0;
$Y[1][0]=0;
$T[0][1]='L';
$T[1][0]='U';

for(my $i=2;$i<=length($seq2);$i++)
    {
	 $M[$i][0]=0;
	 $X[$i][0]=$pgap*$XX*$X[$i-1][0];
	 $Y[$i][0]=0;
	 $T[$i][0]='U';
	 }

for(my $i=2;$i<=length($seq1);$i++)
    {
	 $M[0][$i]=0;
	 $Y[0][$i]=$pgap*$YY*$Y[0][$i-1];
	 $X[0][$i]=0;
	 $T[0][$i]='L';
	 }
	 
	#recurrence
print"\n FORWARD VALUES : \n";

for(my $i=1;$i<=length($seq2);$i++)
{
 for(my $j=1;$j<=length($seq1);$j++)
     {
	 $ch1=substr($seq1,$j-1,1);
	 $ch2=substr($seq2,$i-1,1);
	 if($ch1 eq $ch2)
	   {
	      $p=$pm;
	   }
	 else
	   {
	      $p=$pmm;
	   }
      $x=$MM*$M[$i-1][$j-1];
      $y=$XM*$X[$i-1][$j-1];
      $z=$YM*$Y[$i-1][$j-1];
      $w=$BM*$B[$i-1][$j-1];
      #print "x=$x  y=$y  z=$z	w=$w \n";
      $M[$i][$j]=$p*$x+$p*$y+$p*$z+$p*$w;

      $x=$MX*$M[$i-1][$j];
      $y=$XX*$X[$i-1][$j];
      $w=$BX*$B[$i-1][$j];
      $X[$i][$j]=$pgap*$x+$pgap*$y+$pgap*$w;

      $x=$MY*$M[$i][$j-1];
      $y=$YY*$Y[$i][$j-1];
      $w=$BY*$B[$i][$j-1];
      $Y[$i][$j]=$pgap*$x+$pgap*$y+$pgap*$w;
	  
	  $f[$i][$j]=$M[$i][$j]+$X[$i][$j]+$Y[$i][$j];
      	  
      print "i=$i  j=$j M[$i][$j]=$M[$i][$j] X[$i][$j]=$X[$i][$j] Y[$i][$j]=$Y[$i][$j] \n";   
	 }	
}

	 #print("BACKWARD \n");
	 
	 #INITIALIZATIOM
	@b;
	$tau=0;
	@B=();
        @X=();
	@Y=();
	@M=();

	$x=length($seq2);
	$y=length($seq1);


	$BX=$delta;
	$BY=$delta;
	$BM=1-2*$delta-$tau;
	$XM=$delta;
	$YM=$delta;
	$MM=1-2*$delta-$tau;
	$XX=$eta;
	$XY=0;
	$MX=1-$eta-$tau;	
	$YY=$eta;
	$YX=0;
	$MY=1-$eta-$tau;

	$B[$x][$y]=1;
	$B[$x][$y-1]=0;
	$B[$x-1][$y]=0;

	$M[$x][$y]=0;
	$M[$x][$y-1]=0;
	$M[$x-1][$y]=0;

	$X[$x][$y]=0;
	$X[$x][$y-1]=0;
	$X[$x-1][$y]=$pgap*$BX*$B[$x][$y];

	$Y[$x][$y]=0;
	$Y[$x-1][$y]=0;
	$Y[$x][$y-1]=$pgap*$BY*$B[$x][$y];
	$T[$x][$y-1]='L';
	$T[$x-1][$y]='U';


	for($i=length($seq2)-2;$i>=0;$i--)
	  {
		$M[$i][$y]=0;
		$Y[$i][$y]=0;
		$T[$i][$y]='U';
		$X[$i][$y]=$pgap*$XX*$X[$i+1][$y];
	  }
	for($i=length($seq1)-2;$i>=0;$i--)
	  {
		$M[$x][$i]=0;
		$X[$x][$i]=0;
		$Y[$x][$i]=$pgap*$YY*$Y[$x][$i+1];
		$T[$x][$i]='L';
 	  }
    
 
        print "\n\n Backward Values \n";
	for($i=length($seq2)-1; $i>=0; $i--)
	  {
		for ( $j=length($seq1)-1; $j>=0; $j--)
		    {
 			$ch1 = substr($seq1,$j,1);
			$ch2 = substr($seq2,$i,1);
			    $p=0;
        		$dm=0;
        		$dy=0;
        		$dx=0;
        		$db=0;
			    $um=0;
        		$ux=0;
        		$ub=0;
			    $lm=0;
			    $ly=0;
			    $lb=0;
			if ($ch1 eq $ch2)
			  {
				$p=$pm;
			  }
			else
			  {	
		 		$p=$pmm;
			  }	
		$dm=$MM*$M[$i+1][$j+1];
		$dx=$MX*$X[$i+1][$j+1];
		$dy=$YM*$Y[$i+1][$j+1];
		$db=$BM*$B[$i+1][$j+1];

		$M[$i][$j]=$p*$dm+$p*$dx+$p*$dy+$p*$db;


		$um=$XM*$M[$i+1][$j];
		$ux=$XX*$X[$i+1][$j]; 
		$ub=$XB*$B[$i+1][$j];
		$X[$i][$j]=$pgap*$um+$pgap*$ux+$pgap*$ub;


		$lm=$MY*$M[$i][$j+1];
		$ly=$YY*$Y[$i][$j+1]; 
		$lb=$YB*$B[$i][$j+1];
		$Y[$i][$j]=$pgap*$lm+$pgap*$ly+$pgap*$lb;

		$b[$i][$j]=$M[$i][$j]+$X[$i][$j]+$Y[$i][$j];
                	
                print "i=$i  j=$j M[$i][$j]=$M[$i][$j] X[$i][$j]=$X[$i][$j] Y[$i][$j]=$Y[$i][$j] \n";
             }
        }
	 
	 #traceback
     for(my $i=1;$i<=length($seq2);$i++)
     {
      for(my $j=1;$j<=length($seq1);$j++)
       {
	     $p[$i][$j]=$f[$i][$j]*$b[$i-1][$j-1]/$f[length($seq2)][length($seq1)];
		 
		}
	  }
	 
     print "\n Forward Matrix is \n";
	 for(my $i=1;$i<=length($seq2);$i++)
     {
      for(my $j=1;$j<=length($seq1);$j++)
       {
         print "  $f[$i][$j] ";
        }
	   print "\n";
	  }
	 print"\n";

      print "\n Backward Matrix is  \n";
	 for(my $i=0;$i<length($seq2);$i++)
     {
      for(my $j=0;$j<=length($seq1);$j++)
       {
         print "  $b[$i][$j] ";
        }
	   print "\n";
	  }
	 print"\n";

     print "\n Matrix p is \n";
	 for(my $i=0;$i<=length($seq2);$i++)
     {
      for(my $j=0;$j<=length($seq1);$j++)
       {
         print " $p[$i][$j] ";
        }
	   print "\n";
	  }
	 print"\n";









