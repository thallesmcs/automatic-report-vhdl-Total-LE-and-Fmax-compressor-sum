import os
import subprocess
import re
import csv
import time

# --- CONFIGURAÇÕES ---

# Caminho para o executável do Quartus. 
# Se estiver no PATH do Windows, deixe apenas 'quartus_sh'.
# Se não, coloque o caminho completo. Ex: r'C:\intelFPGA\18.1\quartus\bin64\quartus_sh.exe'
QUARTUS_CMD = 'quartus_sh' 

# Nome do arquivo de saída
OUTPUT_CSV = 'resultado_final_96_arqs.csv'

def compile_project(project_path, project_name):
    """
    Roda a compilação completa (Map, Fit, ASM, STA).
    Retorna True se rodou sem erro de processo, False se falhou.
    """
    print(f"Compilando {project_name} ... (isso pode demorar)")
    try:
        # O comando --flow compile roda todo o fluxo padrão
        cmd = [QUARTUS_CMD, '--flow', 'compile', project_name]
        
        # Executa o comando escondendo a saída gigante do terminal (capture_output=True)
        # Se quiser ver o log passando, remova o capture_output
        result = subprocess.run(cmd, cwd=project_path, capture_output=True, text=True)
        
        if result.returncode == 0:
            print(f"-> {project_name}: Compilação SUCESSO.")
            return True
        else:
            print(f"-> {project_name}: ERRO na compilação.")
            # Salva o log de erro para debug se precisar
            with open(os.path.join(project_path, 'erro_compilacao.log'), 'w') as f:
                f.write(result.stderr + "\n" + result.stdout)
            return False
    except Exception as e:
        print(f"-> Erro ao tentar executar o Quartus: {e}")
        return False

def extract_data(project_path):
    """
    Busca LE (do Fitter/Fit) e Fmax (Slow 85C) nos arquivos gerados.
    """
    le_count = "N/A"
    fmax_slow_85c = "N/A"
    
    # Define a pasta de output
    search_dir = os.path.join(project_path, 'output_files')
    if not os.path.exists(search_dir):
        search_dir = project_path

    files = os.listdir(search_dir) if os.path.exists(search_dir) else []

    # 1. Extrair Logic Elements DO FITTER (.fit.summary) - É O MAIS PRECISO
    # Se não achar o fit, tenta o map como fallback
    found_le = False
    
    # Primeiro tenta achar o .fit.summary
    for f in files:
        if f.endswith('.fit.summary'):
            try:
                with open(os.path.join(search_dir, f), 'r', encoding='utf-8', errors='ignore') as file:
                    content = file.read()
                    # Padrão: "Total logic elements : 1,234 / 22,320 ( < 1 % )"
                    match = re.search(r"Total logic elements\s+:\s+([\d,]+)", content)
                    if match:
                        le_count = match.group(1).replace(',', '')
                        found_le = True
                        break
            except: pass
            
    # Se NÃO achou no fit, tenta no map (só por segurança)
    if not found_le:
        for f in files:
            if f.endswith('.map.summary'):
                try:
                    with open(os.path.join(search_dir, f), 'r', encoding='utf-8', errors='ignore') as file:
                        content = file.read()
                        match = re.search(r"Total logic elements\s+:\s+([\d,]+)", content)
                        if match:
                            le_count = match.group(1).replace(',', '') + " (Map)" # Marca pra saber que veio do Map
                            break
                except: pass

    # 2. Extrair Fmax Específico (Slow 1200mV 85C Model) no .sta.rpt (MANTIDO IGUAL)
    for f in files:
        if f.endswith('.sta.rpt'):
            try:
                with open(os.path.join(search_dir, f), 'r', encoding='utf-8', errors='ignore') as file:
                    content = file.read()
                    pattern = r"Slow 1200mV 85C Model Fmax Summary.*?Fmax\s+;.*?;\s+([\d\.]+)\s+MHz"
                    match = re.search(pattern, content, flags=re.DOTALL)
                    if match:
                        fmax_slow_85c = match.group(1)
                        break
            except: pass
            
    return le_count, fmax_slow_85c

def main():
    root_dir = '.' # Pasta atual
    results = []
    
    # Encontra todos os arquivos .qpf (Projetos Quartus)
    projects_to_process = []
    for dirpath, dirnames, filenames in os.walk(root_dir):
        for f in filenames:
            if f.endswith('.qpf'):
                projects_to_process.append((dirpath, f))

    total = len(projects_to_process)
    print(f"Encontrados {total} projetos. Iniciando processamento...\n")

    count = 0
    for folder, qpf_file in projects_to_process:
        count += 1
        project_name = qpf_file.replace('.qpf', '')
        print(f"[{count}/{total}] Processando: {project_name}")
        
        # 1. Compilar
        success = compile_project(folder, project_name)
        
        # 2. Extrair (mesmo se falhar, tenta extrair, as vezes já existia compilação antiga)
        le, fmax = extract_data(folder)
        
        status = "OK" if success else "Falha Compilação"
        results.append([project_name, le, fmax, status])
        print(f"   -> Dados: LE={le}, Fmax(85C)={fmax} MHz\n")

    # Salva CSV Final
    with open(OUTPUT_CSV, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['Arquitetura', 'Total Logic Elements', 'Fmax (Slow 1200mV 85C)', 'Status Compilacao'])
        writer.writerows(results)

    print(f"Concluído! Verifique o arquivo: {OUTPUT_CSV}")

if __name__ == "__main__":
    main()