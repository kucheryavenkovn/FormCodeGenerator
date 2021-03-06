[![Release](https://img.shields.io/github/tag/huxuxuya/FormCodeGenerator.svg?label=Last%20release&a)](https://github.com/huxuxuya/FormCodeGenerator/releases)

# Обработка генерации кода для программной доработки форм

При доработке типовых конфигураций, для уменьшения издержек на сопровождение конфигурации при ее обновлении, доработка форм должна производиться с максимальным приоритетом программной доработки.

Данная обработка создана для увеличения скорости программного добавления реквизитов формы.

Определение элементов, для которых необходимо сгенерировать код , реализуется через сравнение эталонной формы и формы, в которую реквизиты добавлены интерактивно.

# Зависимости:
Код, генерируемый обработкой использует [модуль программной доработки форм](https://github.com/huxuxuya/1cFormEditor).

## Установка модуля программной доработки форм:
Скачать последнюю [поставку модулья из релизов](https://github.com/huxuxuya/1cFormEditor/releases).

В дорабатываемой конфигурации:
1. Выбрать "Сравнить объединить с конфигурацией из файла".
2. Согласиться поставить конфигурацию на поддержку.
3. В сравнении/объединении выбрать только общий модуль "Редактор форм".
4. Выполнить объединение.
	

# Roadmap:

| Метод   |      Статус      |  Дата |
|----------|:-------------:|------:|
| НовоеПолеФормы |  Never | - |
| НовоеПолеРеквизитаФормы |  Yep | - |
| НоваяГруппаФормы |  Yep | - |
| НоваяГруппаКолонкиЛевоПраво |  Never | - |
| НоваяГруппаОбычная |  Yep | - |
| НоваяТаблицаФормы |  - | - |
| НовоеПолеТабличнойЧастиформы |  - | - |
| НоваяКнопкаФормы |  Never | - |
| НоваяКомандаИГиперссылкаФормы |  - | - |
| НоваяКомандаИКнопкаКоманднойПанели |  - | - |
| НоваяКомандаИКнопкаФормы |  In prgrs | - |
| НоваяКомандаФормы |  - | - |
| НовыйРеквизитОбъектаФормы |  Yep | - |
| НовоеПолеФормыРеквизитОбъекта |  - | - |
| НовоеПолеШапкиФормыРеквизитОбъекта |  Yep | - |
| НовоеМногострочноеПолеРеквизитОбъекта |  Yep | - |
| НовоеПолеФлажокФормыРеквизитОбъекта |  Yep | - |
| НоваяГруппаКнопок |  - | - |
| НоваяДекорацияНадпись |  Yep | - |



