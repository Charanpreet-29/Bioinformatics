$filename=shift;
print("Filename is $filename\n");

open(IN, $filename);
@data=<IN>;
chomp(@data);

for(my $i=0; $i<scalar(@data); $i++)
{
  print "$data[$i] \n";
}

$seq1=$data[1];
$seq2=$data[3];

$m=5; $mm= -4; $g=-20; $ge=-1;

$score=0;
$count=0;
for(my $i=0; $i<length($seq1);$i++)
{  
  if(substr($seq1,$i,1) eq substr($seq2,$i,1))
  {
   $score+=$m;
   $count = 0;
  }
  elsif(substr($seq1,$i,1) eq '-' || substr($seq2,$i,1) eq '-' )
      { 
            if($count == 0) 
             {
                $score+=$g;
              }
           else
             {
                 $score+=$ge;
              }
      if(substr($seq1,$i+1,1) eq '-' || substr($seq2,$i+1,1) eq '-')
             {
                  $count++;
             }
      }
  else
             {
               $score+=$mm;
               $count=0;
             }
 }

print( "the score is $score \n");

