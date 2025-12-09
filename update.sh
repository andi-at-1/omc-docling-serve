#!/bin/bash

# apt-get install tesseract-ocr tesseract-ocr-deu

# Update docling-serve package

echo "Aktiviere Virtual Environment..."
source venv-docling/bin/activate

echo "Aktualisiere docling-serve[ui]..."
pip install --upgrade docling-serve[ui]
pip install --upgrade easyocr
pip install --upgrade rapidocr
pip install --upgrade onnxruntime-gpu
pip install --upgrade tesserocr  # schneller, empfohlen
pip install --upgrade pytesseract  # langsamer, einfacher

echo ""
echo "Update abgeschlossen!"
echo "Installierte Versionen:"
pip show docling-serve | grep Version
pip show easyocr | grep Version
pip show rapidocr | grep Version
pip show onnxruntime-gpu | grep Version
