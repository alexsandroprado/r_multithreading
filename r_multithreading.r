cat("## ATIVANDO MULTIPROCESSAMENTO NO AMBIENTE R ##\n\n")

# Pacotes necessarios ----
if (!require('doParallel')) install.packages('doParallel', dependencies = TRUE); library('doParallel')

# Ativando multithending no R----
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

