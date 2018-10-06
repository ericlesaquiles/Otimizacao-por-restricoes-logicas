#!/bin/bash

#
# Has to:
#   Copy Capi.tex to CapiC.tex;
#
#   Remove (comment out):
#     \documentclass{article}
#     \input{../header.tex}
#     \begin{document}
#     \end{document}
#

for ((i = 0; i < 17; i++))
do
  cp "../Cap${i}/[LOG]Cap${i}.tex" "../Cap${i}/[LOG]Cap${i}C.tex"
  sed -i 's/\\documentclass{article}/%\\documentclass{article}/' "../Cap${i}/[LOG]Cap${i}C.tex"
  sed -i 's/\\input{/%\\input{/'                                 "../Cap${i}/[LOG]Cap${i}C.tex"
  sed -i 's/\\begin{document}/%\\begin{document}/'               "../Cap${i}/[LOG]Cap${i}C.tex"
  sed -i 's/\\end{document}/%\\end{document}/'                   "../Cap${i}/[LOG]Cap${i}C.tex"
done

cp "../Intro/Intro.tex" "../Intro/IntroC.tex"
sed -i 's/\\documentclass{article}/%\\documentclass{article}/' "../Intro/IntroC.tex"
sed -i 's/\\input{/%\\input{/'                                 "../Intro/IntroC.tex"
sed -i 's/\\begin{document}/%\\begin{document}/'               "../Intro/IntroC.tex"
sed -i 's/\\end{document}/%\\end{document}/'                   "../Intro/IntroC.tex"

echo "Ignore os erros/warnings."

pdflatex -shell-escape "Complete.tex"


for ((i = 0; i < 17; i++))
do
    rm "../Cap${i}/[LOG]Cap${i}C.tex"
done

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
