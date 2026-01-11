ИНСТРУКЦИЯ ПО ЗАПУСКУ
=====================

РЕКОМЕНДУЕМЫЙ СПОСОБ: MAKEFILE
-------------------------------

cd mlclass-ex2
make help              # показать справку
make ex2               # простая регрессия (графики показываются)
make ex2_reg           # с регуляризацией (графики показываются)
make test_lambda       # тест разных lambda (графики показываются)
make test_degree       # тест разных degree (графики показываются)
make test_without_reg  # без регуляризации (графики показываются)
make all               # запустить все основные тесты
make clean             # удалить временные файлы

ОСНОВНЫЕ СКРИПТЫ (НАПРЯМУЮ):
----------------------------

1. Простая логистическая регрессия (БЕЗ регуляризации):
   octave --persist --eval "ex2"

2. С регуляризацией (lambda = 1):
   octave --persist --eval "ex2_reg"

ВАЖНО: Используйте --persist вместо --no-gui, чтобы графики показывались!

ТЕСТИРОВАНИЕ:
-------------

3. Тест разных lambda (0, 0.01, 0.1, 1, 10, 100):
   make test_lambda
   или
   octave --persist --eval "test_lambda"

4. Тест БЕЗ регуляризации (lambda = 0):
   make test_without_reg
   или
   octave --persist --eval "test_without_reg"

5. Тест разных degree (1, 2, 3, 4, 5, 6):
   make test_degree
   или
   octave --persist --eval "test_degree"

6. Сравнение БЕЗ vs С регуляризацией:
   make test_reg_comparison
   или
   octave --persist --eval "test_reg_comparison"

ИЗМЕНЕНИЕ ПАРАМЕТРОВ ВРУЧНУЮ:
------------------------------

Изменить lambda:
  Откройте ex2_reg.m
  Найдите: lambda = 1;
  Измените на нужное значение
  Затем: make ex2_reg

Изменить degree:
  Откройте mapFeature.m
  Найдите: degree = 6;
  Измените на нужное значение
  Затем: make ex2_reg

ЗАПУСК В ИНТЕРАКТИВНОМ РЕЖИМЕ:
------------------------------

octave
>> cd mlclass-ex2
>> ex2              % простая регрессия
>> ex2_reg          % с регуляризацией
>> test_lambda      % тест lambda
>> test_degree      % тест degree
