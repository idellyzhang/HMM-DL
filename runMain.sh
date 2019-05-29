input=$1
output=`echo $input|sed 's/.txt//'`
echo "Running parse.pl"
perl parse.pl $input  > $input.parse.txt
echo "Running sort.pl"
perl sort.pl $input.parse.txt > $input.sort.txt
echo "Running GA.pl"
perl GA.pl $input.sort.txt > $input.GA.txt
echo "Running dlnSeq.pl"
perl dlnSeq.pl $input.GA.txt > $input.dln.txt
echo "Running maxSedl.pl"
perl maxSeqdl.pl $input.dln.txt > $input.dlmax.txt
echo "Running SeqThreshol.pl"
perl SeqThreshold.pl $input.dlmax.txt > $output.dloutput.txt

rm $input.parse.txt $input.sort.txt $input.GA.txt $input.dln.txt $input.dlmax.txt

