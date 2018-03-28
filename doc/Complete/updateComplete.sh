#!/bin/bash

for ((i = 0; i < 13; i++))
do
  cp "../Cap${i}/[LOG]Cap${i}.tex" "../Cap${i}/[LOG]Cap${i}C.tex"

  #Prepend and append \begin{listing} to inputeminted
  sed -i 's/inputminted/i \
    \\begin\{listing\}/g' "../Cap${i}/[LOG]Cap${i}C.tex"
  sed -i '/inputminted/a \
    \\end\{listing\}' "../Cap${i}/[LOG]Cap${i}C.tex"

  sed -i 's/inputminted/i \
    \\begin\{listing\}/g' "../Cap${i}/[LOG]Cap${i}.tex"
  sed -i '/inputminted/a \
    \\end\{listing\}' "../Cap${i}/[LOG]Cap${i}.tex"
done


pdflatex -shell-escape "Complete.tex"




  # Remove \documentclass{article}
  #sed -i 's|\\documentclass\{article\}||g'

  # Remove \input{header}
  #sed -i 's|\\input\{\.\.\\header*\}||g'

  # Remove \end{document}
  #sed -i 's|\\end\{document\}||g'

  # Remove \begin{document}
  #sed -i 's|\\begin\{document\}||g'

  # Prepend and append \begin{listing} to inputeminted
  #sed -i 's/inputminted/i \
    #\\begin\{listing\}/g'
  #sed -i '/inputminted/a \
    #\\end\{listing\}' '[LOG]Cap0C.tex'
