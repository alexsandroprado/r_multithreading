cat("## ATIVANDO MULTIPROCESSAMENTO NO AMBIENTE R ##\n\n")

cat("Para desativar o multicore, digite:  'stopCluster(cl)'\n")

cat("Para testar o desempenho do computador, digite:  'benchmark()'\n")

# Pacotes necessarios ----
if (!require('doParallel')) install.packages('doParallel', dependencies = TRUE); library('doParallel')
if (!require("SuppDists")) install.packages("SuppDists")
if (!require("benchmarkme")) install.packages("benchmarkme")

# Funcões
benchmark <- function(x) {
  source("http://r.research.att.com/benchmarks/R-benchmark-25.R")}

benchmarkplot <- function(x) {
  library(benchmarkme)
  res = benchmark_std(runs = 3)
  upload_results(res)
  plot(res)
}


  
  # Ativando multithreading no R----
  library(doParallel)
  cl <- makeCluster(detectCores()-1)
  registerDoParallel(cl)
  showConnections() #Checar se o multicore esta ON
  for (node in cl) try(print(node)) #Checar se o multicore esta ON
  #stopCluster(cl) ##Desativar multiprocessamento
  
  # Ativando multithreading na instalação de pacotes do R
  options(Ncpus = detectCores())
  getOption("Ncpus", 1L)
  
  cat("\n")
  
  
  cat("| @contabilidados | @ufersa3 | @gecomt_ufersa\n ")
  
  cat("https://github.com/alexsandroprado\n“In God we trust; all others must bring data” - Deming\n ")
