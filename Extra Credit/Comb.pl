open(IN, shift);
@data = <IN>;
chomp(@data);

for(my $i=0; $i<scalar(@data);$i++){
	$seed = $data[$i];
	print "current seed: $seed\n";
	system("perl Genome.pl dogA.fa.txt ratQ.fa.txt $seed >| $i.maf");
	system("./mafComparator --maf1 $i.maf --maf2 dogA-ratQ-truth-mafFilter.maf --out $i.xml");
	system("python comparatorSummarizer.py --xml $i.xml");
}