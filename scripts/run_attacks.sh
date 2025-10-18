#!/bin/bash
# Exemplo simples — execute APENAS em seu ambiente de teste (VM).
TARGET="192.168.56.101"
OUTDIR="$(pwd)/outputs"
WORDDIR="$(pwd)/wordlists"
mkdir -p "$OUTDIR"
echo "Escaneando o alvo: $TARGET"
nmap -sS -sV -p 21,22,80,139,445 $TARGET -oN "$OUTDIR/nmap_quick.txt"
echo "Pronto. Verifique outputs/nmap_quick.txt"
