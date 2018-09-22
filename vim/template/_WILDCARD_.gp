:silent %s/#FILENAME#/\=RPath('%:t:r')/g
#!/bin/gnuplot
set term post landscape size 29cm,21cm color enhanced
set output "#FILENAME#.ps"
set title "#TITLE#";
set xlabel "#XLABEL#";
set ylabel "#YLABEL#";
plot "#DATAFILE#"
