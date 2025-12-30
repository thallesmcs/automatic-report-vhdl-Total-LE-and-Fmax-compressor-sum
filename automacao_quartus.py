import os
import re
import csv  # <--- 1. Adicionei esta biblioteca

# ================= CONFIGURAÇÃO =================
# Ponto de partida da busca ('.' significa a pasta onde o script está)
DIRETORIO_RAIZ = "." 
NOME_CSV = "relatorio_final.csv" # <--- 2. Nome do arquivo de saída
# ================================================

def extrair_dados_quartus(caminho_pasta, nome_design):
    """
    Lê os arquivos .fit.summary e .sta.rpt para extrair os dados reais.
    """
    
    arquivo_fit = os.path.join(caminho_pasta, f"{nome_design}.fit.summary")
    arquivo_sta = os.path.join(caminho_pasta, f"{nome_design}.sta.rpt")

    dados = {
        "design": nome_design,
        "pasta": os.path.relpath(caminho_pasta), # Mostra onde achou
        "les": "N/A",
        "fmax": "N/A",
        "status": "OK"
    }

    # 1. LER LEs REAIS (Fitter)
    if os.path.exists(arquivo_fit):
        try:
            with open(arquivo_fit, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # Tenta pegar Logic Elements
            match = re.search(r"Total logic elements.*?\s(\d+)\s+/", content)
            if match:
                dados["les"] = int(match.group(1))
            else:
                # Tenta pegar ALMs (para Cyclone V ou mais novos)
                match_alm = re.search(r"Logic utilization.*?\s(\d+)\s+/", content)
                if match_alm:
                     dados["les"] = f"{match_alm.group(1)} (ALMs)"
        except Exception as e:
            dados["status"] = f"Erro leitura FIT"
    else:
        dados["status"] = "Sem FIT"

    # 2. LER FMAX REAL (Slow 85C)
    if os.path.exists(arquivo_sta):
        try:
            with open(arquivo_sta, 'r', encoding='utf-8', errors='ignore') as f:
                lines = f.readlines()

            secao_correta = False
            fmax_encontrado = False

            for line in lines:
                # Procura cabeçalho do PIOR CASO (85C)
                if "Slow 1200mV 85C Model Fmax Summary" in line:
                    secao_correta = True
                    continue
                
                # Se mudar de seção, para de ler
                if "Model Fmax Summary" in line and "85C" not in line:
                    secao_correta = False

                if secao_correta:
                    if "MHz" in line and "clk" in line:
                        match_fmax = re.search(r"(\d+\.\d+)", line)
                        if match_fmax:
                            dados["fmax"] = float(match_fmax.group(1))
                            fmax_encontrado = True
                            break
            
            if not fmax_encontrado:
                dados["fmax"] = "Sem Clock/Conv"

        except Exception as e:
            dados["status"] = f"Erro leitura STA"
    else:
         if dados["status"] == "OK": dados["status"] = "Sem STA"

    return dados

def main():
    print(f"--- Iniciando varredura RECURSIVA em: {os.path.abspath(DIRETORIO_RAIZ)} ---\n")
    
    resultados = []
    
    # os.walk percorre todas as pastas e subpastas
    for root, dirs, files in os.walk(DIRETORIO_RAIZ):
        for file in files:
            # Identifica arquivos de relatório do Fitter
            if file.endswith(".fit.summary"):
                # O nome do design é o nome do arquivo sem a extensão
                nome_design = file.replace(".fit.summary", "")
                
                # Chama a função passando a pasta onde o arquivo foi encontrado
                resultado = extrair_dados_quartus(root, nome_design)
                resultados.append(resultado)

    if not resultados:
        print("Nenhum relatório (.fit.summary) encontrado nas subpastas.")
        return

    # --- CONFIGURAÇÃO DE LARGURAS ---
    # Definindo larguras fixas para garantir que Cabeçalho e Linhas batam exatamente
    W_DESIGN = 40
    W_LES = 8
    W_FMAX = 12
    W_PASTA = 60  # Aumentei um pouco para caber caminhos melhores
    W_STATUS = 10 # Tamanho fixo para o status

    # --- IMPRIMIR CABEÇALHO ---
    # O segredo é usar o mesmo número (ex: :<30) no cabeçalho e no loop
    header = (
        f"{'DESIGN':<{W_DESIGN}} | "
        f"{'LEs':<{W_LES}} | "
        f"{'FMAX (85C)':<{W_FMAX}} | "
        f"{'PASTA':<{W_PASTA}} | "
        f"{'STATUS':<{W_STATUS}}"
    )

    print(header)
    print("-" * len(header))

    # --- IMPRIMIR LINHAS ---
    for item in resultados:
        # 1. Tratar Design (Corta se passar da largura)
        design_str = item['design']
        if len(design_str) > W_DESIGN:
            design_str = design_str[:W_DESIGN-2] + '..'
        
        # 2. Tratar Pasta (Corta o INÍCIO se passar da largura, para ver o final da pasta)
        pasta_str = item['pasta']
        if len(pasta_str) > W_PASTA:
            # Pega os ultimos caracteres que cabem, deixando espaço para '...'
            pasta_str = '...' + pasta_str[-(W_PASTA-3):] 

        # 3. Status e Conversões
        les_str = str(item['les'])
        fmax_str = str(item['fmax'])
        status_str = item['status']

        # 4. Print com as MESMAS larguras do cabeçalho
        print(
            f"{design_str:<{W_DESIGN}} | "
            f"{les_str:<{W_LES}} | "
            f"{fmax_str:<{W_FMAX}} | "
            f"{pasta_str:<{W_PASTA}} | "
            f"{status_str:<{W_STATUS}}" # Aqui garante que o OK fique alinhado com STATUS
        )

# --- 3. GERAR ARQUIVO CSV ---
    try:
        with open(NOME_CSV, mode='w', newline='', encoding='utf-8') as csv_file:
            # Definindo as colunas
            colunas = ['DESIGN', 'LEs', 'FMAX (85C)', 'PASTA', 'STATUS']
            writer = csv.writer(csv_file)
            
            # Escreve o cabeçalho
            writer.writerow(colunas)
            
            # Escreve os dados (usando os dados originais, sem cortes '...')
            for item in resultados:
                writer.writerow([
                    item['design'], 
                    item['les'], 
                    item['fmax'], 
                    item['pasta'], 
                    item['status']
                ])
        
        print(f"\n[SUCESSO] Arquivo CSV gerado: {os.path.abspath(NOME_CSV)}")
        
    except Exception as e:
        print(f"\n[ERRO] Não foi possível gerar o CSV: {e}")

if __name__ == "__main__":
    main()