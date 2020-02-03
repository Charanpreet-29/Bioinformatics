#system("perl as3_cv.pl training.txt ");#>  PUT");

@v=();
$v[0][0]=print("\t\t ");
$v[0][1]= print("Non Affine \t\t\t");
$v[0][2]= print(" Affine \t\n");
$v[1][0]= print("Match/mismatch \t");
$var1=`perl cv2_for_NW.pl training.txt`;
$v[1][1]= print "$var1 \t ";
$var2=`perl cvs.pl training.txt`;
$v[1][2]= print "$var2 \n";
$v[2][0]=print("BLOSUM62 \t ");
$var3=`perl as3_cv_NW.pl training.txt`;
$V[2][1] = print "$var3 \t ";
$var4=`perl as3_cv.pl training.txt`;
$V[2][2] = print "$var4 \n";

