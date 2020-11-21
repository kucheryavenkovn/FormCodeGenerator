#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ИнициализироватьПредварительныеНастройки();

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	Если Объект.ЗапущенаКакВнешняя Тогда
		Если Найти(Врег(СтрокаСоединенияИнформационнойБазы()), "SRVR=") Тогда
			//Положить обработку в хранилище и подключить
			УИД = ЭтаФорма.УникальныйИдентификатор;
			ДвоичныеДанные = Новый ДвоичныеДанные(Объект.ИмяПодключеннойОбработки);
			Объект.АдресДанныхФайлаВоВременномХранилище = ПоместитьВоВременноеХранилище(ДвоичныеДанные, УИД);
			ПодключитьОбработкуНаСервере();
		КонецЕсли;
	КонецЕсли;
	
	ОбновитьЗаголовокГиперссылок();
	
	Если ПустаяСтрока(Объект.ТекстШаблонаОкружения) Тогда
		
		Объект.ТекстШаблонаОкружения = НСтр("ru = '&НаСервере
										 |Процедура ПодготовитьФорму(Команда)
										 |
										 |	Если РедакторФорм.ФормаПодготовлена(ЭтаФорма) Тогда
										 |		Возврат;
										 |	КонецЕсли;
										 |
										 |%1
										 |
										 |КонецПроцедуры
										 |'");			
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОчиститьВсе(Команда)
	
	ФормаАнализируемая = Неопределено;
	ФормаЭталонная = Неопределено;
	
	ОчиститьДанныеНаФорме(Истина);
	ОчиститьДанныеНаФорме(Ложь);
		
	ОбновитьЗаголовокГиперссылок();
	
КонецПроцедуры

&НаКлиенте
Процедура ПеречитатьФорму(Команда)

	Если ЗначениеЗаполнено(ФормаАнализируемая) Тогда
		ИнициализироватьПредварительныеНастройки();
		ПодготовитьДанныеИзФормы(ФормаАнализируемая, Ложь);
		ИнициализироватьПредварительныеНастройки();
		ПодготовитьДанныеИзФормы(ФормаЭталонная, Истина);	
		СравнитьФормыУстановитьФлажкиНаСервере();	
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СравнитьФормыУстановитьФлажки(Команда)
	СравнитьФормыУстановитьФлажкиНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьЭталоннуюФормуДляАнализа(Команда)
	
	Параметр = Новый Структура("Эталонная", Истина);
	ОповещениеВыбора = Новый ОписаниеОповещения("ВыборФормыАнализируемойЗавершение", ЭтотОбъект, Параметр);

	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ФормаИмяОбъекта", ФормаИмяОбъекта);
	ПараметрыОткрытия.Вставить("ФормаТипОбъекта", ФормаТипОбъекта);
	ПараметрыОткрытия.Вставить("ФормаИмяФормы", ФормаИмяФормы);
	ПараметрыОткрытия.Вставить("ТекущаяСтрока", ФормаЭталонная);
	
	Если Не ЗначениеЗаполнено(ФормаЭталонная) 
		И ЗначениеЗаполнено(ФормаАнализируемая) Тогда
		ПараметрыОткрытия.Вставить("ТекущаяСтрока", ФормаАнализируемая);		
	КонецЕсли; 

	Если Объект.ЗапущенаКакВнешняя Тогда
		ИмяОбработки = "ВнешняяОбработка.FormGenerator.Форма.ФормаВыбораФормы";
	Иначе
		ИмяОбработки = СтрШаблон("Обработка.%1.Форма.ФормаВыбораФормы", Объект.ИмяПодключеннойОбработки);
	КонецЕсли;
	
	ОткрытьФорму(ИмяОбработки, ПараметрыОткрытия, , , , , ОповещениеВыбора, РежимОткрытияОкнаФормы.Независимый);
		
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьФормуДляАнализа(Команда)
	
	Параметр = Новый Структура("Эталонная", Ложь);
	ОповещениеВыбора = Новый ОписаниеОповещения("ВыборФормыАнализируемойЗавершение", ЭтотОбъект, Параметр);

	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ФормаИмяОбъекта", ФормаИмяОбъекта);
	ПараметрыОткрытия.Вставить("ФормаТипОбъекта", ФормаТипОбъекта);
	ПараметрыОткрытия.Вставить("ФормаИмяФормы", ФормаИмяФормы);
	ПараметрыОткрытия.Вставить("ТекущаяСтрока", ФормаАнализируемая);
	
	Если Не ЗначениеЗаполнено(ФормаАнализируемая) 
		И ЗначениеЗаполнено(ФормаЭталонная) Тогда
		ПараметрыОткрытия.Вставить("ТекущаяСтрока", ФормаЭталонная);		
	КонецЕсли;

	Если Объект.ЗапущенаКакВнешняя Тогда
		ИмяОбработки = "ВнешняяОбработка.FormGenerator.Форма.ФормаВыбораФормы";
	Иначе
		ИмяОбработки = СтрШаблон("Обработка.%1.Форма.ФормаВыбораФормы", Объект.ИмяПодключеннойОбработки);
	КонецЕсли;
	
	ОткрытьФорму(ИмяОбработки, ПараметрыОткрытия, , , , , ОповещениеВыбора, РежимОткрытияОкнаФормы.Независимый);
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФормаАнализируемаяНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	ОповещениеВыбора = Новый ОписаниеОповещения("ВыборФормыАнализируемойЗавершение", ЭтотОбъект);

	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ФормаИмяОбъекта", ФормаИмяОбъекта);
	ПараметрыОткрытия.Вставить("ФормаТипОбъекта", ФормаТипОбъекта);
	ПараметрыОткрытия.Вставить("ФормаИмяФормы", ФормаИмяФормы);
	ПараметрыОткрытия.Вставить("ТекущаяСтрока", ФормаАнализируемая);

	ОткрытьФорму("ВнешняяОбработка.FormGenerator.Форма.ФормаВыбораФормы", ПараметрыОткрытия, Элемент, , , ,
		ОповещениеВыбора);
КонецПроцедуры

&НаКлиенте
Процедура ВыборФормыАнализируемойЗавершение(Результат, Параметры) Экспорт
	
	Если ЗначениеЗаполнено(Результат) Тогда
		
		ОчиститьДанныеНаФорме(Параметры.Эталонная);
		
		Если Параметры.Эталонная = Истина Тогда

			ФормаЭталонная = Результат.ПолныйПутьКФорме;
		Иначе			
						
			ФормаАнализируемая = Результат.ПолныйПутьКФорме;
			ФормаТипОбъекта = Результат.ТипОбъекта;
			ФормаИмяОбъекта = Результат.ИмяОбъекта;
			ФормаИмяФормы = Результат.ИмяФормы;
		КонецЕсли;	
		
		ПодготовитьДанныеИзФормы(Результат.ПолныйПутьКФорме, Параметры.Эталонная);
	КонецЕсли;
		
	ОбновитьЗаголовокГиперссылок();
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоРеквизитов

&НаКлиенте
Процедура ОбъектДеревоРеквизитовВыбранПриИзменении(Элемент)

	ОбновитьТекстДобавленияЭлементов();
	ОбновитьТекстДобавленияРеквизитов();
	ОбновитьОбщийТекстПрограмногоДобаления();

КонецПроцедуры

&НаКлиенте
Процедура ДополнитьИдентификаторыНайденнымиВнутри(ИдентификаторыВыбранных, ТекущийЭлемент)

	Для Каждого Строка Из ТекущийЭлемент.ПолучитьЭлементы() Цикл

		Если Строка.Выбран Тогда
			ИдентификаторыВыбранных.Добавить(Строка.ПолучитьИдентификатор());
		КонецЕсли;

		ДополнитьИдентификаторыНайденнымиВнутри(ИдентификаторыВыбранных, Строка);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоЭлементов

&НаКлиенте
Процедура ОбъектДеревоЭлементовВыбранПриИзменении(Элемент)

	ОбновитьТекстДобавленияЭлементов();
	ОбновитьТекстДобавленияРеквизитов();
	ОбновитьОбщийТекстПрограмногоДобаления();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаКоманд

&НаКлиенте
Процедура ОбъектТаблицаКомандВыбранПриИзменении(Элемент)

	Объект.ТекстДобавленияКоманд = "";
							  						   
	КонтекстСформирован = Ложь;
	ВПредыдущемЭлементеБылиУстановленыСвойства = Ложь;
	
	Для Каждого Строка Из Объект.ТаблицаКоманд Цикл
		Если Строка.Выбран Тогда
			
			ТекстТекущейСтроки = "";
			
			Если Не КонтекстСформирован Или ВПредыдущемЭлементеБылиУстановленыСвойства Тогда
				
				КонтекстСформирован = Истина;
				ДобавитьТекст(ТекстТекущейСтроки, Строка.ТекстСозданиеКонтекста);
				
			КонецЕсли;
			
			Если Не ПустаяСтрока(Строка.ТекстЗаполненияСвойств) Тогда
				
				ВПредыдущемЭлементеБылиУстановленыСвойства = Истина;
				ДобавитьТекст(ТекстТекущейСтроки, Строка.ТекстЗаполненияСвойств);
				
			Иначе
				ВПредыдущемЭлементеБылиУстановленыСвойства = Ложь;				
			КонецЕсли;
			
			ДобавитьТекст(ТекстТекущейСтроки, Строка.ТекстСоздания);
			
			ДобавитьТекст(Объект.ТекстДобавленияКоманд, ТекстТекущейСтроки);
		КонецЕсли;	
	КонецЦикла; 
						   
	ОбновитьОбщийТекстПрограмногоДобаления();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИнициализироватьПредварительныеНастройки()

	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");

	ПустоеДеревоРеквизитов = ОбработкаОбъект.ДеревоРеквизитов.Скопировать();
	ПустоеДеревоЭлементов = ОбработкаОбъект.ДеревоЭлементов.Скопировать();
	ПустаяТаблицаКоманд = ОбработкаОбъект.ТаблицаКоманд.ВыгрузитьКолонки();
	ПустоеДеревоРеквизитов.Строки.Очистить();
	ПустоеДеревоЭлементов.Строки.Очистить();

	СоответствиеТекстовыхПредставлений = ОбработкаОбъект.НовоеСоответствиеТекстовыхПредставлений();
	СоответствиеПредставленийТипов = ОбработкаОбъект.НовоеСоответствиеПредставленийТипов();

	ПараметрыРедакторФорм = Новый Структура;
	ПараметрыРедакторФорм.Вставить("СоответствиеТекстовыхПредставлений", СоответствиеТекстовыхПредставлений);
	ПараметрыРедакторФорм.Вставить("СоответствиеПредставленийТипов", СоответствиеПредставленийТипов);
	ПараметрыРедакторФорм.Вставить("ДеревоРеквизитов", ПустоеДеревоРеквизитов);	
	ПараметрыРедакторФорм.Вставить("ДеревоЭлементов", ПустоеДеревоЭлементов);
	ПараметрыРедакторФорм.Вставить("ТаблицаКоманд", ПустаяТаблицаКоманд);

	Объект.АдресВоВременномХранилище = ПоместитьВоВременноеХранилище(ПараметрыРедакторФорм,	ЭтаФорма.УникальныйИдентификатор);
	Объект.ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	Если Не Метаданные.Обработки.Содержит(ОбработкаОбъект.Метаданные()) Тогда
		Объект.ИмяПодключеннойОбработки = ОбработкаОбъект.ИспользуемоеИмяФайла;
		Объект.ЗапущенаКакВнешняя = Истина;
	Иначе
		Для Каждого Обработка Из Метаданные.Обработки Цикл
			Если Обработка = ОбработкаОбъект.Метаданные() Тогда
				 Объект.ИмяПодключеннойОбработки = Обработка.Имя;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьДанныеНаФорме(Эталонная)
	
	ИнициализироватьПредварительныеНастройки();
	
	Если Эталонная = Истина Тогда
		
		Объект.ДеревоРеквизитовЭталон.ПолучитьЭлементы().Очистить();
		Объект.ДеревоЭлементовЭталон.ПолучитьЭлементы().Очистить();
		Объект.ТаблицаКомандЭталон.Очистить();
	Иначе
		
		Объект.ДеревоРеквизитов.ПолучитьЭлементы().Очистить();
		Объект.ДеревоЭлементов.ПолучитьЭлементы().Очистить();
		Объект.ДеревоФорм.ПолучитьЭлементы().Очистить();
		Объект.ТаблицаКоманд.Очистить();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПодготовитьДанныеИзФормы(ПолныйПутьКФорме, Эталонная)

	ПараметрыПолученияДанных = Новый Структура;
	ПараметрыПолученияДанных.Вставить("АдресВоВременномХранилище", Объект.АдресВоВременномХранилище);
	ПараметрыПолученияДанных.Вставить("ИмяПодключеннойОбработки", Объект.ИмяПодключеннойОбработки);
	ПараметрыПолученияДанных.Вставить("ИмяВременногоФайла", Объект.ИмяВременногоФайла);
	ПараметрыПолученияДанных.Вставить("ЗапущенаКакВнешняя", Объект.ЗапущенаКакВнешняя);
	
	ПараметрыФормы = Новый Структура("РедакторФорм", ПараметрыПолученияДанных);

	Объект.ПолныйПутьКФорме = ПолныйПутьКФорме;
	ПолучитьФорму(ПолныйПутьКФорме, ПараметрыФормы);

	ЗаполнитьДанныеПоХранилищу(Эталонная);

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДанныеПоХранилищу(Эталонная) Экспорт

	ФайлСДанными = Новый Файл(Объект.ИмяВременногоФайла);

	Если ФайлСДанными.Существует() Тогда
		
		ПараметрыРедакторФорм = ЗначениеИзФайла(Объект.ИмяВременногоФайла);
		УдалитьФайлы(Объект.ИмяВременногоФайла);
		
		Если Эталонная = Истина Тогда
			
			ЗначениеВРеквизитФормы(ПараметрыРедакторФорм.ДеревоРеквизитов, "Объект.ДеревоРеквизитовЭталон");
			ЗначениеВРеквизитФормы(ПараметрыРедакторФорм.ДеревоЭлементов, "Объект.ДеревоЭлементовЭталон");
			Объект.ТаблицаКомандЭталон.Загрузить(ПараметрыРедакторФорм.ТаблицаКоманд);
				
		Иначе
			
			ЗначениеВРеквизитФормы(ПараметрыРедакторФорм.ДеревоРеквизитов, "Объект.ДеревоРеквизитов");
			ЗначениеВРеквизитФормы(ПараметрыРедакторФорм.ДеревоЭлементов, "Объект.ДеревоЭлементов");
			Объект.ТаблицаКоманд.Загрузить(ПараметрыРедакторФорм.ТаблицаКоманд);
		
		КонецЕсли;

	Иначе
		Сообщить("Заполнение не выполнено!
				 |Необходимо разместить в процедуре ""ПриСозданииНаСервере()""
				 |модуля формы """ + Объект.ПолныйПутьКФорме + """ следующий код:
															|
															|
														    |	ИмяПодключеннойОбработки = ЭтаФорма.Параметры.РедакторФорм.ИмяПодключеннойОбработки;
															|	Если ЭтаФорма.Параметры.РедакторФорм.ЗапущенаКакВнешняя Тогда
															|		ВнешниеОбработки.Создать(ИмяПодключеннойОбработки, Ложь).ПодготовитьДанныеАнализируемойФормы(ЭтаФорма);
															|	Иначе
															|		Обработки[ИмяПодключеннойОбработки].Создать().ПодготовитьДанныеАнализируемойФормы(ЭтаФорма);
															|	КонецЕсли;
															|КонецЕсли;"); 
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗаголовокГиперссылок()
	
	Если ПустаяСтрока(ФормаАнализируемая) Тогда
		Элементы.ВыбратьФормуДляАнализа.Заголовок = НСтр("ru = 'Выбрать форму для анализа'");
	Иначе
		Шаблон = НСтр("ru = 'Форма: %1'"); 
		Элементы.ВыбратьФормуДляАнализа.Заголовок = СтрШаблон(Шаблон, ФормаАнализируемая);
	КонецЕсли;

	Если ПустаяСтрока(ФормаЭталонная) Тогда
		Элементы.ВыбратьЭталоннуюФормуДляАнализа.Заголовок = НСтр("ru = 'Эталонная форма'");
	Иначе
		Шаблон = НСтр("ru = 'Эталонная : %1'"); 
		Элементы.ВыбратьЭталоннуюФормуДляАнализа.Заголовок = СтрШаблон(Шаблон, ФормаЭталонная);
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура ПодключитьОбработкуНаСервере()
	Объект.ИмяПодключеннойОбработки = ВнешниеОбработки.Подключить(Объект.АдресДанныхФайлаВоВременномХранилище, , Ложь);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДобавитьТекст(ИсходныйТекст, НовыйТекст, ДобавлятьПустые = Ложь)
	
	Если ПустаяСтрока(НовыйТекст) И ДобавлятьПустые = Ложь Тогда
		Возврат;
	КонецЕсли;
	
	ИсходныйТекст = ИсходныйТекст + ?(ПустаяСтрока(ИсходныйТекст),"", Символы.ПС) + НовыйТекст;
	
КонецПроцедуры

#Область РасчетТекстаДобавления

&НаКлиенте
Процедура ОбновитьТекстДобавленияЭлементов()
	Перем ЭлементРеквизита;
	Перем ИдентификаторыВыбранныхЭлементов;
	Перем Идентификатор;
	ИдентификаторыВыбранныхЭлементов = Новый Массив;
	ДополнитьИдентификаторыНайденнымиВнутри(ИдентификаторыВыбранныхЭлементов, Объект.ДеревоЭлементов);

	Объект.ТекстДобавленияЭлементов = "";
	Объект.ТекстОбслуживающихМетодов = "" + Символы.ПС;
							   
	Если ИдентификаторыВыбранныхЭлементов.Количество() > 0 Тогда

		Для Каждого Идентификатор Из ИдентификаторыВыбранныхЭлементов Цикл
			ЭлементРеквизита = Объект.ДеревоЭлементов.НайтиПоИдентификатору(Идентификатор);
				
			Объект.ТекстДобавленияЭлементов = ?(ПустаяСтрока(Объект.ТекстДобавленияЭлементов), "", Объект.ТекстДобавленияЭлементов + Символы.ПС)
											+  ?(ПустаяСтрока(ЭлементРеквизита.ТекстНачало), "", ЭлементРеквизита.ТекстНачало + Символы.ПС)
											+  ?(ПустаяСтрока(ЭлементРеквизита.ТекстУстановкиСвойств), "", ЭлементРеквизита.ТекстУстановкиСвойств + Символы.ПС)
											+ ЭлементРеквизита.ТекстСоздания
											+  ?(ПустаяСтрока(ЭлементРеквизита.ТекстПослеСоздания), "", ЭлементРеквизита.ТекстПослеСоздания) ;

			Объект.ТекстДобавленияЭлементов = Объект.ТекстДобавленияЭлементов + Символы.ПС;
			
			ДобавитьТекст(Объект.ТекстОбслуживающихМетодов, ЭлементРеквизита.ТекстОбслуживающихПроцедур);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьТекстДобавленияРеквизитов()

	ИдентификаторыВыбранныхРеквизитов = Новый Массив;
	ДополнитьИдентификаторыНайденнымиВнутри(ИдентификаторыВыбранныхРеквизитов, Объект.ДеревоРеквизитов);

	Объект.ТекстДобавленияРеквизитов = "";
	ТекстИнициализироватьМассив = "НовыеРеквизитыФормы = Новый Массив;" + Символы.ПС + Символы.ПС;
	ТекстИзменитьРеквизитыФормы = "ЭтаФорма.ИзменитьРеквизиты(НовыеРеквизитыФормы);";
	ТекстДобавитьВМассив = "НовыеРеквизитыФормы.Добавить(НовыйРеквизит);";
	ШаблонРеквизитыПрограммно = "%1
								|%2";
	ТекстРеквизитыПрограммно = ШаблонРеквизитыПрограммно;

	Если ИдентификаторыВыбранныхРеквизитов.Количество() > 0 Тогда
		Для Каждого Идентификатор Из ИдентификаторыВыбранныхРеквизитов Цикл
			ЭлементРеквизита = Объект.ДеревоРеквизитов.НайтиПоИдентификатору(Идентификатор);

			ШаблонРеквизита = ШаблонРеквизитыПрограммно + Символы.ПС;
			ТекстДобавления = СтрШаблон(ШаблонРеквизита, ЭлементРеквизита.ТекстСоздания, ТекстДобавитьВМассив);
			ТекстРеквизитыПрограммно = СтрШаблон(ТекстРеквизитыПрограммно, ТекстДобавления, ШаблонРеквизитыПрограммно);
		КонецЦикла;

		Объект.ТекстДобавленияРеквизитов = ТекстИнициализироватьМассив + СтрШаблон(ТекстРеквизитыПрограммно,
			ТекстИзменитьРеквизитыФормы, "");

	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОбщийТекстПрограмногоДобаления()
	
	ТекстГенерированияИсходный = Объект.ТекстДобавленияРеквизитов + Объект.ТекстДобавленияКоманд + Объект.ТекстДобавленияЭлементов;
	ТекстГенерирования = "";
	Для Индекс = 1 По СтрЧислоСтрок(ТекстГенерированияИсходный) Цикл
	   Строка = СтрПолучитьСтроку(ТекстГенерированияИсходный, Индекс);
	   ДобавитьТекст(ТекстГенерирования, "	" + Строка, Истина);
	КонецЦикла;
	
	ВложенныйТекст = СтрШаблон(Объект.ТекстШаблонаОкружения, ТекстГенерирования);
	
	Объект.ТекстПрограммногоДобавления = ВложенныйТекст + Объект.ТекстОбслуживающихМетодов;
	
КонецПроцедуры

#КонецОбласти

#Область СравнениеСЭталоном

&НаСервере
Процедура СравнитьФормыУстановитьФлажкиНаСервере()
	
	ТаблицаРеквизитыЭталон = НоваяТаблицаИмен();	
	ЗаполнитьТаблицуИменПоДереву(ТаблицаРеквизитыЭталон, Объект.ДеревоРеквизитовЭталон);	
	ОтметитьЭлементыПоЭталоннымДанным(Объект.ДеревоРеквизитов, ТаблицаРеквизитыЭталон);

	ТаблицаЭлементыЭталон = НоваяТаблицаИмен();
	ЗаполнитьТаблицуИменПоДереву(ТаблицаЭлементыЭталон, Объект.ДеревоЭлементовЭталон);	
	ОтметитьЭлементыПоЭталоннымДанным(Объект.ДеревоЭлементов, ТаблицаЭлементыЭталон);	
  
КонецПроцедуры

&НаСервере
Процедура ОтметитьЭлементыПоЭталоннымДанным(ДеревоРеквизитов, ТаблицаРеквизитыЭталон)
	//Если в эталоне нет - ставим галку
	Для Каждого СтрокаДерева Из ДеревоРеквизитов.ПолучитьЭлементы() Цикл		
		ПроверитьНаличиеЭлементаПоЭталону(ТаблицаРеквизитыЭталон, СтрокаДерева)		
	КонецЦикла;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ПроверитьНаличиеЭлементаПоЭталону(ТаблицаИмен, ЭлементДерева)
	
	Отбор = Новый Структура("Имя", ЭлементДерева.Имя);
	НайденыеСтроки = ТаблицаИмен.НайтиСтроки(Отбор);
	Если НайденыеСтроки.Количество() = 0 Тогда
		ЭлементДерева.Выбран = Истина;
	КонецЕсли;
	
	Для Каждого СтрокаДерева Из ЭлементДерева.ПолучитьЭлементы() Цикл
		
		ПроверитьНаличиеЭлементаПоЭталону(ТаблицаИмен, СтрокаДерева);
		
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуИменПоДереву(ТаблицаЭлементы, ДеревоРеквизитов)
	
	Для Каждого СтрокаДерева Из ДеревоРеквизитов.ПолучитьЭлементы() Цикл
		
		Строка = ТаблицаЭлементы.Добавить();
		Строка.Имя = СтрокаДерева.Имя;
		Строка.ИмяРодителя = "";
		
		ДополнитьТаблицуДаннымиЭлементов(ТаблицаЭлементы, СтрокаДерева)
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция НоваяТаблицаИмен()
	ТаблицаЭлементы = Новый ТаблицаЗначений();
	ТаблицаЭлементы.Колонки.Добавить("Имя");
	ТаблицаЭлементы.Колонки.Добавить("ИмяРодителя");
	Возврат ТаблицаЭлементы
КонецФункции

&НаСервере
Процедура ДополнитьТаблицуДаннымиЭлементов(Таблица, ЭлементДерева, ИмяРодителя = "")
	
	Для Каждого СтрокаДерева Из ЭлементДерева.ПолучитьЭлементы() Цикл
		
		СтрокаТаблицы = Таблица.Добавить();
		СтрокаТаблицы.Имя = СтрокаДерева.Имя;
		СтрокаТаблицы.ИмяРодителя = ИмяРодителя;
		
		ДополнитьТаблицуДаннымиЭлементов(Таблица, СтрокаДерева, СтрокаДерева.Имя);
		
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#КонецОбласти
