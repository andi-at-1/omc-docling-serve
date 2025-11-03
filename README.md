Installation:
python -m venv venv-docling
pip install "docling-serve[ui]"

Erststart, modelle laden:

/root/omc-docling-serve/venv-docling/bin/docling-tools models download --all -o models

Danach mit run.sh ausführen