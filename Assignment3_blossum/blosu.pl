$blos_file=shift;
open(IN, $blos_file);
@bloss=<IN>;
chomp(@bloss);
@s1=();
#print"$bloss[0]";

@s1=split(/\s+/,$bloss[0]);
print "@s1 \n";

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

@outer=keys(%hashie);

for(my $i=1;$i<24;$i++)
{ 
    print("\n");
   for(my $j=1;$j<24;$j++)
   {     
      $val=$hashie{$outer[$i]}{$s1[$j]};
      #$val = $hashie{'A'}{'R'};
      print " $outer[$i] $val ";
   }
}

