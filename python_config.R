instala_python <- function() {
  # Instalando interface R para Python
  if (!require(reticulate)) {
    install.packages("reticulate")
  }
  
  # Instalando e configurando ambiente Python
  reticulate::install_python("3.10.11")
  reticulate::virtualenv_create("my-python", python_version = "3.10.11")
  reticulate::py_discover_config()
  reticulate::virtualenv_list()
  reticulate::conda_list(conda = "auto")
  
  # Instalando pacotes Python
  reticulate::py_install("pandas", envname = "my-python", ignore_installed = FALSE)
  reticulate::py_install("numpy", envname = "my-python", ignore_installed = FALSE)
  reticulate::py_install("matplotlib", envname = "my-python", ignore_installed = FALSE)
  reticulate::py_install("scikit-learn", envname = "my-python", ignore_installed = FALSE)
  reticulate::py_install("matplotlib", envname = "my-python", ignore_installed = FALSE) # Nota: 'matplotlib' está repetido
  reticulate::py_install("statsmodels", envname = "my-python", ignore_installed = FALSE)
  reticulate::py_install("rpy2", envname = "my-python", ignore_installed = FALSE)
  
  # Ative o ambiente antes de iniciar de rodar o código Python
  reticulate::use_virtualenv("my-python", required = TRUE)
  
  # Testando ambiente
  reticulate::py_run_file("python_test.py")
}



