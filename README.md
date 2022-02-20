# Ruby-task
Вся логика программы реализована в файле test_main.rb. При желании ввода значений с клавиатуры в целях ручного тестирования программы, необходимо запустить файл test_interface.rb. При желании запустить встроенные тесты, реализованные с помощью модуля Minitest, необходимо запустить файл test_test.rb.

# Условие:
Есть модель лицензия License
у нее есть поле оплачено до: paid_till
и опциональные поля max_version и min_version
Есть сервис который возвращает версию последнего релиза Флюссоника: FlussonicLastVersion.get, в формате гг.мм, например сейчас это 22.02, после релиза в случайный день марта будет 22.03 и тд
Работает как черный ящик
FlussonicLastVersion.get
=> 22.02

У лицензии есть список доступных версий, он формируется по следующим правилам:
1) берутся пять последних релизов Флюссоника (отсчет идет от текущего значения FlussonicLastVersion.get), сейчас (в феврале 2022) это 21.10 21.11 21.12 22.01 22.02
2) доступная версия не может быть больше той что указана в max_version
3) доступная версия не может быть больше той что была в в дату paid_till
3) доступная версия не может быть меньше той что указана в min_version
4) если после примененных выше правил получился пустой массив, то берется максимально доступная версия без учета пяти последних релизов.

Пример:
paid_till: 04.07.2021
max_version: nil
min_version: nil
FlussonicLastVersion.get -> 21.10

В таком случае список доступных версий для лицензии будет: [21.06, 21.07]

Ещё пример:
paid_till: 04.07.2020
max_version: 20.02
min_version: 19.01
FlussonicLastVersion.get -> 20.10

В таком случае список доступных версий для лицензии будет: [20.02]

Задание: нужно написать метод или сервис, который будет возвращать список доступных версий для лицензии.
