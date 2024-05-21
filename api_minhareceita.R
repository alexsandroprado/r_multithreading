# Função para verificar e instalar pacotes
install_and_load <- function(packages) {
  installed_packages <- rownames(installed.packages())
  
  for (pkg in packages) {
    if (!pkg %in% installed_packages) {
      install.packages(pkg, dependencies = TRUE)
    }
    library(pkg, character.only = TRUE)
  }
}

# Lista de pacotes
packages <- c("parallel", "tibble", "purrr", "pbapply", "dplyr", "jsonlite")

# Chamar a função
install_and_load(packages)

consultar_cnpj <- function(cnpjs) {
  # Configurar o número de núcleos
  num_cores <- detectCores() - 1
  
  # Função para obter todos os dados
  obter_dados <- function(cnpj) {
    url <- paste0("https://minhareceita.org/", cnpj)
    tryCatch({
      json_data <- fromJSON(url)
      
      # Dados gerais
      dados_gerais <- tibble(
        uf = pluck(json_data, "uf", .default = NA),
        cep = pluck(json_data, "cep", .default = NA),
        cnpj = pluck(json_data, "cnpj", .default = NA),
        pais = pluck(json_data, "pais", .default = NA),
        email = pluck(json_data, "email", .default = NA),
        porte = pluck(json_data, "porte", .default = NA),
        bairro = pluck(json_data, "bairro", .default = NA),
        numero = pluck(json_data, "numero", .default = NA),
        ddd_fax = pluck(json_data, "ddd_fax", .default = NA),
        municipio = pluck(json_data, "municipio", .default = NA),
        logradouro = pluck(json_data, "logradouro", .default = NA),
        cnae_fiscal = pluck(json_data, "cnae_fiscal", .default = NA),
        codigo_pais = pluck(json_data, "codigo_pais", .default = NA),
        complemento = pluck(json_data, "complemento", .default = NA),
        codigo_porte = pluck(json_data, "codigo_porte", .default = NA),
        razao_social = pluck(json_data, "razao_social", .default = NA),
        nome_fantasia = pluck(json_data, "nome_fantasia", .default = NA),
        capital_social = pluck(json_data, "capital_social", .default = NA),
        ddd_telefone_1 = pluck(json_data, "ddd_telefone_1", .default = NA),
        ddd_telefone_2 = pluck(json_data, "ddd_telefone_2", .default = NA),
        opcao_pelo_mei = pluck(json_data, "opcao_pelo_mei", .default = NA),
        descricao_porte = pluck(json_data, "descricao_porte", .default = NA),
        codigo_municipio = pluck(json_data, "codigo_municipio", .default = NA),
        natureza_juridica = pluck(json_data, "natureza_juridica", .default = NA),
        situacao_especial = pluck(json_data, "situacao_especial", .default = NA),
        opcao_pelo_simples = pluck(json_data, "opcao_pelo_simples", .default = NA),
        situacao_cadastral = pluck(json_data, "situacao_cadastral", .default = NA),
        data_opcao_pelo_mei = pluck(json_data, "data_opcao_pelo_mei", .default = NA),
        data_exclusao_do_mei = pluck(json_data, "data_exclusao_do_mei", .default = NA),
        cnae_fiscal_descricao = pluck(json_data, "cnae_fiscal_descricao", .default = NA),
        codigo_municipio_ibge = pluck(json_data, "codigo_municipio_ibge", .default = NA),
        data_inicio_atividade = pluck(json_data, "data_inicio_atividade", .default = NA),
        data_situacao_especial = pluck(json_data, "data_situacao_especial", .default = NA),
        data_opcao_pelo_simples = pluck(json_data, "data_opcao_pelo_simples", .default = NA),
        data_situacao_cadastral = pluck(json_data, "data_situacao_cadastral", .default = NA),
        nome_cidade_no_exterior = pluck(json_data, "nome_cidade_no_exterior", .default = NA),
        codigo_natureza_juridica = pluck(json_data, "codigo_natureza_juridica", .default = NA),
        data_exclusao_do_simples = pluck(json_data, "data_exclusao_do_simples", .default = NA),
        motivo_situacao_cadastral = pluck(json_data, "motivo_situacao_cadastral", .default = NA),
        ente_federativo_responsavel = pluck(json_data, "ente_federativo_responsavel", .default = NA),
        identificador_matriz_filial = pluck(json_data, "identificador_matriz_filial", .default = NA),
        qualificacao_do_responsavel = pluck(json_data, "qualificacao_do_responsavel", .default = NA),
        descricao_situacao_cadastral = pluck(json_data, "descricao_situacao_cadastral", .default = NA),
        descricao_tipo_de_logradouro = pluck(json_data, "descricao_tipo_de_logradouro", .default = NA),
        descricao_motivo_situacao_cadastral = pluck(json_data, "descricao_motivo_situacao_cadastral", .default = NA),
        descricao_identificador_matriz_filial = pluck(json_data, "descricao_identificador_matriz_filial", .default = NA)
      )
      
      # CNAEs secundários
      cnaes_secundarios <- json_data$cnaes_secundarios %||% list(codigo = NA, descricao = NA)
      dados_cnaes_sec <- tibble(
        cnpj = json_data$cnpj,
        cnaes_sec_codigo = cnaes_secundarios[[1]] %||% NA,
        cnaes_sec_descricao = cnaes_secundarios[[2]] %||% NA
      )
      
      # Dados societários
      qsa <- json_data$qsa %||% list()
      dados_societarios <- tibble(
        cnpj = json_data$cnpj,
        razao_social = pluck(json_data, "razao_social", .default = NA),
        qsa_pais = pluck(qsa, 1, .default = NA),
        qsa_nome_socio = pluck(qsa, 2, .default = NA),
        qsa_faixa_etaria = pluck(qsa, 4, .default = NA),
        qsa_codigo_faixa_etaria = pluck(qsa, 7, .default = NA),
        qsa_data_entrada_sociedade = pluck(qsa, 8, .default = NA),
        qsa_identificador_de_socio = pluck(qsa, 9, .default = NA),
        qsa_codigo_qualificacao_socio = pluck(qsa, 12, .default = NA),
        qsa_codigo_qualificacao_representante_legal = pluck(qsa, 13, .default = NA),
        qsa_qualificacao_representante_legal = pluck(qsa, 14, .default = NA),
        qsa_qualificacao_socio = pluck(qsa, 6, .default = NA)
      )
      
      # Unificar os data frames
      df_final <- dados_gerais %>%
        select(-razao_social) %>%
        inner_join(dados_societarios, by = 'cnpj', relationship = "many-to-many") %>%
        inner_join(dados_cnaes_sec, by = 'cnpj', relationship = "many-to-many")
      
      df_final
    }, error = function(e) {
      tibble()
    })
  }
  
  # Executando todas as consultas em paralelo com barra de progresso única
  resultados <- pblapply(cnpjs, obter_dados, cl = num_cores)
  
  df_resultado <- bind_rows(resultados)
  
  # Agregação e união dos data frames conforme solicitado
  temp <- df_resultado %>%
    group_by(cnpj) %>%
    summarise(
      cnaes_sec_descricao = paste(unique(cnaes_sec_descricao), collapse = ", "),
      cnaes_sec_codigo = paste(unique(cnaes_sec_codigo), collapse = ", "),
      qsa_nome_socio = paste(unique(qsa_nome_socio), collapse = ", "),
      qsa_qualificacao_socio = list(qsa_qualificacao_socio),
      qsa_pais = paste(unique(qsa_pais), collapse = ", "),
      qsa_faixa_etaria = list(qsa_faixa_etaria),
      qsa_codigo_faixa_etaria = list(qsa_codigo_faixa_etaria),
      qsa_data_entrada_sociedade = list(qsa_data_entrada_sociedade),
      qsa_identificador_de_socio = list(qsa_identificador_de_socio),
      qsa_codigo_qualificacao_representante_legal = paste(unique(qsa_codigo_qualificacao_representante_legal),collapse = ", "),
      qsa_qualificacao_representante_legal = paste(unique(qsa_qualificacao_representante_legal), collapse = ", "))
  
  temp2 <- df_resultado %>% 
    select(
      -cnaes_sec_descricao,
      -cnaes_sec_codigo,
      -qsa_nome_socio,
      -qsa_qualificacao_socio,
      -qsa_codigo_qualificacao_socio,
      -qsa_pais,
      -qsa_faixa_etaria,
      -qsa_codigo_faixa_etaria,
      -qsa_data_entrada_sociedade,
      -qsa_identificador_de_socio,
      -qsa_codigo_qualificacao_representante_legal,
      -qsa_qualificacao_representante_legal
    ) %>% 
    distinct(cnpj, .keep_all = TRUE) 
  
  df <- temp %>% left_join(temp2, by = "cnpj")
  
  rm(temp,temp2)
  gc()
  
  # Reorganizando as colunas
  df <- df %>% select(cnpj, razao_social, nome_fantasia, logradouro, numero, bairro, municipio, uf, cep, 
                      data_inicio_atividade, natureza_juridica, porte, capital_social, everything())
  
  return(df)
}

# Exemplo de uso da função

#elapsed=00s 
cnpj <- c("33000167104900")

#elapsed=04s  
cnpj <- c("08350241000172", "24529265000140", "33000167104900", "75315333000109", "09305994000129", "28195667000106", "60746948000112")

#elapsed=02m 39s (326 cnpjs)
cnpj <- c(
  "42771949000135", "07526557000100", "12528708000107", "37663076000107", "10338320000100", "07628528000159", 
  "21240146000184", "62002886000160", "20247322000147", "05878397000132", "61079117000105", "60537263000166", 
  "61189288000189", "12648266000124", "00776574000156", "09288252000132", "61156931000178", "00242184000104", 
  "16590234000176", "06057223000171", "04032433000180", "00359742000108", "28594234000123", "16811931000100", 
  "61351532000168", "45987245000192", "61374161000130", "95426862000197", "01107327000120", "60851615000153", 
  "67620377000114", "33041260065290", "04752991000110", "58430828000160", "56992423000190", "09042817000105", 
  "50564053000103", "03847461000192", "01838723000127", "17193806000146", "19796586000170", "42150391000170", 
  "36542025000164", "61022042000118", "61088894000108", "64904295000103", "14110585000107", "82508433000117", 
  "19526748000150", "61409892000173", "02846056000197", "45242914000105", "00070698000111", "17245234000100", 
  "15139629000194", "08467115000100", "33938119000169", "61856571000117", "92012467000170", "01027058000191", 
  "83878892000155", "17155730000164", "06981180000116", "08902291000115", "00272185000193", "07047251000170", 
  "02800026000140", "02429144000193", "76483817000120", "75315333000109", "15115504000124", "50746577000115", 
  "62984091000102", "17281106000103", "33042730000104", "08324196000181", "06981381000113", "82640558000104", 
  "22677520000176", "21255567000189", "08797760000183", "10760260000119", "73178600000118", "61486650000183", 
  "08170849000115", "02193750000152", "16614075000100", "12108897000150", "84683408000103", "18174270000184", 
  "03303999000136", "97837181000147", "82643537000134", "04149454000180", "08873873000110", "02474103000119", 
  "02328280000197", "00001180000126", "09347516000181", "02302101000142", "07689002000189", "11669021000110", 
  "04423567000121", "00864214000106", "16922038000151", "03467321000199", "42331462000131", "04895728000180", 
  "03220438000173", "26659061000159", "61082004000150", "61092037000181", "56643018000166", "61190096000192", 
  "43470988000165", "08312229000173", "15141799000103", "22266175000188", "07820907000146", "02255187000108", 
  "60840055000131", "88610126000129", "04821041000108", "86550951000150", "02998301000181", "01545826000107", 
  "33611500000119", "09229201000130", "24990777000109", "92690783000109", "06164253000187", "08560444000193", 
  "18483666000103", "89850341000160", "08764621000153", "08402943000152", "30540991000166", "05197443000138", 
  "49263189000102", "14785152000151", "12648327000153", "87762563000103", "92749225000163", "33200049000147", 
  "02932074000191", "38456921000136", "08159965000133", "51218147000193", "60543816000193", "76627504000106", 
  "09611768000176", "82901000000127", "02635522000195", "02916265000160", "33035536000100", "08294224000165", 
  "87456562000122", "52548435000179", "91983056000169", "89637490000145", "13270520000166", "40337136000106", 
  "26462693000128", "60476884000187", "03378521000175", "01104937000170", "96418264021802", "02357251000153", 
  "09041168000110", "42278291000124", "08078847000109", "92754738000162", "89463822000112", "92660570000126", 
  "05917486000140", "02351877000152", "16676520000159", "31553627000101", "07206816000115", "12049631000184", 
  "17314329000120", "12181987000177", "61065298000102", "47960950000121", "27093558000115", "59717553000102", 
  "17161241000115", "88610191000154", "90076886000140", "21314559000166", "03853896000140", "08343492000120", 
  "60730348000166", "08795211000170", "07882930000165", "86375425000109", "07816890000153", "84683671000194", 
  "61156113000175", "60651809000105", "01083200000118", "08613550000198", "10139870000108", "14127813000151", 
  "60884319000159", "29950060000157", "71673990000177", "32785497000197", "51128999000190", "97191902000194", 
  "58119199000151", "20258278000170", "76535764000143", "12104241000402", "09114805000130", "11421994000136", 
  "09112685000132", "92693019000189", "47508411000156", "02950811000189", "02365069000144", "01938783000111", 
  "33000167000101", "18328118000109", "45453214000151", "06626253000151", "51928174000150", "24230275000180", 
  "60398369000126", "60398369000479", "92665611000177", "88611835000129", "33130691000105", "81243735000148", 
  "59789545000171", "10629105000168", "18593815000197", "83475913000191", "08574411000100", "88613658000110", 
  "35791391000194", "01851771000155", "61585865000151", "02387241000160", "33453598000123", "92791243000103", 
  "89086144000116", "91333666000117", "67010660000124", "06047087000139", "03342704000130", "61584140000149", 
  "16670085000155", "56720428000163", "33412081000196", "12091809000155", "61065751000180", "85778074000106", 
  "13522948000159", "76484013000145", "13217485000111", "43776517000180", "29780061000109", "04986320000113", 
  "01599101000193", "07718269000157", "02860694000162", "84693183000168", "07415333000120", "89096457000155", 
  "60500139000126", "07594978000178", "51466860000156", "14807945000124", "10807374000177", "10285590000108", 
  "33386210000119", "42500384000151", "02762121000104", "16404287000155", "08801621000186", "07859971000130", 
  "92781335000102", "33111246000190", "08065557000112", "09295063000197", "30213493000109", "82636986000155", 
  "00336701000104", "71476527000135", "05799312000120", "59418806000147", "02351144000118", "02421421000111", 
  "33467572000134", "53113791000122", "03014553000191", "26345998000150", "08811643000127", "02998611000104", 
  "94813102000170", "84683374000149", "82982075000180", "90441460000148", "33256439000139", "33958695000178", 
  "60894730000105", "33592510000154", "23373000000132", "34274233000102", "45365558000109", "33839910000111", 
  "67571414000141", "02558157000162", "33113309000147", "00924429000175", "49669856000143", "50926955000142", 
  "12420164000157", "84429695000111", "14776142000150", "59105999000186", "33228024000151", "02217319000107", 
  "08807432000110", "13574594000196"
)

df_resultado <- consultar_cnpj(cnpj)
print(df_resultado)
