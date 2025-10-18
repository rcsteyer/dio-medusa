# dio-medusa
# Desafio DIO — Ataques de Força Bruta com Medusa (Kali + Metasploitable)

> **Aviso legal e ético:** todos os testes descritos neste repositório foram e devem ser executados **apenas** em ambientes controlados e autorizados (máquinas virtuais pessoais, laboratórios). Executar ataques contra sistemas de terceiros sem permissão é ilegal.

## Resumo
Projeto prático para demonstrar entendimento sobre ataques de força bruta em serviços diversos (FTP, SMB e formulário Web) usando **Kali Linux** e **Medusa**, com apoio de ferramentas auxiliares (Nmap, enum4linux, Hydra, smbclient). O objetivo é simular cenários de ataque em VMs vulneráveis (por exemplo, Metasploitable2 e DVWA), documentar comandos, resultados e propor medidas de mitigação.

## Topologia de laboratório
- Rede: **Host‑only** (VirtualBox host‑only `vboxnet0`)
- Kali Linux: `192.168.56.10` (exemplo)
- Metasploitable2 / DVWA: `192.168.56.101` (exemplo)
> Ajuste os endereços IP conforme seu ambiente.

## Ferramentas utilizadas
- Kali Linux
- Medusa
- Nmap
- Enum4linux
- Hydra (para ataques em formulários web)
- smbclient
- nbtscan
- tcpdump / Wireshark (opcional)

## Estrutura do repositório
