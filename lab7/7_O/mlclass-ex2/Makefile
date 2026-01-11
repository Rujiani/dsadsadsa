# Makefile для запуска скриптов логистической регрессии
# Использование: make <цель>
# Например: make ex2, make test_lambda, make all

# Переменные
OCTAVE = octave
OCTAVE_FLAGS = --persist

# Цвета для вывода (опционально)
GREEN = \033[0;32m
YELLOW = \033[1;33m
NC = \033[0m # No Color

.PHONY: all help ex2 ex2_reg test_lambda test_degree test_without_reg test_reg_comparison clean

# Цель по умолчанию - показать справку
help:
	@echo "$(GREEN)Доступные команды:$(NC)"
	@echo ""
	@echo "  $(YELLOW)make ex2$(NC)              - Запустить простую логистическую регрессию (без регуляризации)"
	@echo "  $(YELLOW)make ex2_reg$(NC)          - Запустить с регуляризацией (lambda = 1)"
	@echo "  $(YELLOW)make test_lambda$(NC)      - Тест разных значений lambda (0, 0.01, 0.1, 1, 10, 100)"
	@echo "  $(YELLOW)make test_degree$(NC)       - Тест разных степеней полинома (1, 2, 3, 4, 5, 6)"
	@echo "  $(YELLOW)make test_without_reg$(NC) - Тест БЕЗ регуляризации (lambda = 0)"
	@echo "  $(YELLOW)make test_reg_comparison$(NC) - Сравнение: БЕЗ vs С регуляризацией"
	@echo "  $(YELLOW)make all$(NC)               - Запустить все основные тесты"
	@echo "  $(YELLOW)make clean$(NC)             - Удалить временные файлы"
	@echo ""

# Простая логистическая регрессия
ex2:
	@echo "$(GREEN)Запуск простой логистической регрессии...$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "ex2"

# С регуляризацией
ex2_reg:
	@echo "$(GREEN)Запуск логистической регрессии с регуляризацией...$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "ex2_reg"

# Тест разных lambda
test_lambda:
	@echo "$(GREEN)Тестирование разных значений lambda...$(NC)"
	@echo "$(YELLOW)Будут показаны графики для lambda = 0, 0.01, 0.1, 1, 10, 100$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "test_lambda"

# Тест разных degree
test_degree:
	@echo "$(GREEN)Тестирование разных степеней полинома...$(NC)"
	@echo "$(YELLOW)Будут показаны графики для degree = 1, 2, 3, 4, 5, 6$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "test_degree"

# Тест без регуляризации
test_without_reg:
	@echo "$(GREEN)Тестирование БЕЗ регуляризации (lambda = 0)...$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "test_without_reg"

# Сравнение с и без регуляризации
test_reg_comparison:
	@echo "$(GREEN)Сравнение: БЕЗ регуляризации vs С регуляризацией...$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "test_reg_comparison"

# Запустить все основные тесты
all:
	@echo "$(GREEN)Запуск всех основных тестов...$(NC)"
	@echo ""
	@echo "$(YELLOW)1. Простая регрессия (ex2)...$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "ex2" || true
	@echo ""
	@echo "$(YELLOW)2. С регуляризацией (ex2_reg)...$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "ex2_reg" || true
	@echo ""
	@echo "$(YELLOW)3. Без регуляризации (test_without_reg)...$(NC)"
	@$(OCTAVE) $(OCTAVE_FLAGS) --eval "test_without_reg" || true

# Очистка временных файлов
clean:
	@echo "$(GREEN)Очистка временных файлов...$(NC)"
	@rm -f octave-workspace octave-core *.asv
	@echo "$(GREEN)Готово!$(NC)"

