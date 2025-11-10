#!/bin/bash

# Update docling-serve package

echo "Aktiviere Virtual Environment..."
source venv-docling/bin/activate

echo "Aktualisiere docling-serve[ui]..."
pip install --upgrade docling-serve[ui]

echo ""
echo "Aktualisiere easyocr..."
pip install --upgrade easyocr

echo ""
echo "Update abgeschlossen!"
echo "Installierte Versionen:"
pip show docling-serve | grep Version
pip show easyocr | grep Version
