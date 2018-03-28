#!/bin/bash

for ((i = 0; i < 13; i++))
do
  #Prepend and append \begin{listing} to inputeminted
  sed -i '/inputminted/i \
    \\begin\{listing\}' "Cap${i}/[LOG]Cap${i}C.tex"
  sed -i '/inputminted/a \
    \\end\{listing\}' "Cap${i}/[LOG]Cap${i}C.tex"

  sed -i '/inputminted/i \
    \\begin\{listing\}' "Cap${i}/[LOG]Cap${i}.tex"
  sed -i '/inputminted/a \
    \\end\{listing\}' "Cap${i}/[LOG]Cap${i}.tex"

done
