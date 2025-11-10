Installation:
python -m venv venv-docling
pip install "docling-serve[ui]"
pip install easyocr

Erststart, modelle laden, müssen wir nciht mehr machen!

export DOCLING_SERVE_ARTIFACTS_PATH=/root/models/docling 
/root/omc-docling-serve/venv-docling/bin/docling-tools models download --all -o models

Danach mit run.sh ausführen