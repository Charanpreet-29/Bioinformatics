$len=50;

srand;

$aff=0.9;$afl=0.1;
$all=0.9;$alf=0.1;

@ef=(1/6, 1/6, 1/6, 1/6, 1/6, 1/6);
@el=(0.5/5, 0.5/5, 0.5/5, 0.5/5, 0.5/5, 0.5);
#@el=(0.1, 0.1, 0.1, 0.1, 0.1, 0.5);

$x=rand;
if($x < 0.5){ $state='F';}
else{$state='L';}

$out = ""; $genseq="";
for(my $i=0; $i<$len;$i++){
 $genseq.=$state;
 $out .= &generate($state);
 my $x=rand; 
 if($state eq 'F'){
  if($x < $aff) { $state='F';}
  else { $state='L';}
 }
 else{
  if($x < $all) { $state='L';}
  else { $state='F';}
 }
}
print "$out\n";
print "$genseq\n";

sub generate{
 my $die=$_[0];
 my $x = rand; my $cumul=0;
 my $i=0; my $out=-1;
 if($die eq 'F'){
  for($i=0; $i < scalar(@ef); $i++){
   $cumul+=$ef[$i];
   if($x < $cumul) { $out = $i+1; last; }
  }
  return $out;
 }
 else{
  for($i=0; $i < scalar(@el); $i++){
   $cumul+=$el[$i];
   if($x < $cumul) { $out = $i+1; last; }
  }
  return $out;
 }
} 