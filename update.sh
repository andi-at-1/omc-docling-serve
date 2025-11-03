#!/bin/bash

# Update docling-serve package

echo "Aktiviere Virtual Environment..."
source venv-docling/bin/activate

echo "Aktualisiere docling-serve[ui]..."
pip install --upgrade docling-serve[ui]

echo ""
echo "Update abgeschlossen!"
echo "Installierte Version:"
pip show docling-serve | grep Version
