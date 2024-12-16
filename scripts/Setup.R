#Eugene-van-Berd: система контроля версий пакетов для проекта

if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Восстанавливаем все необходимые пакеты и зависимости, согласно renv.lock
renv::restore() 
