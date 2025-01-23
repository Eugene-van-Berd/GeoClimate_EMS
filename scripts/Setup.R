#Eugene-van-Berd: система контроля версий пакетов для проекта

if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Текущее состояние всех пакетов, используемых в проекте
renv::snapshot()

# Восстанавливаем все необходимые пакеты и зависимости, согласно renv.lock
renv::restore() 
