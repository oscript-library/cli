#Использовать logos
#Использовать fluent

перем Лог;

Перем НомераСостояний;
Перем ПоследнийНомар; 

Функция ЗаполнитьЗначения(КонтейнерыЗначений) Экспорт

	Для каждого Контейнер Из КонтейнерыЗначений Цикл

		Лог.Отладка("Заполняю значения %1", Контейнер.Ключ);

		Если Контейнер.Ключ.ЭтоМассив() Тогда
			Контейнер.Ключ.Очистить();
		КонецЕсли;

		Для каждого значениеКонтейнера Из Контейнер.Значение Цикл
			Лог.Отладка("Установил значения %1 в контейнер %2",значениеКонтейнера, Контейнер.Ключ);
			Контейнер.Ключ.УстановитьЗначение(значениеКонтейнера)

		КонецЦикла;

		Контейнер.Ключ.УстановленаИзПеременнойОкружения = Ложь;

		Если Не Контейнер.Ключ.УстановленаПользователем Тогда
			Контейнер.Ключ.УстановленаПользователем = Истина;
		КонецЕсли;

	КонецЦикла;

КонецФункции

Процедура УпроститьСоединения(НачальноеСостояние, Состояние, ПосетилиСостояние) Экспорт

	//Возврат; // пока не работает
	Лог.Отладка("Я УпроститьСоединения");
		
	Если ПосетилиСостояние[Состояние] = Истина Тогда
		Лог.Отладка("Я уже тут был");
		Возврат;
	КонецЕсли;

	ПосетилиСостояние.Вставить(Состояние, Истина);
	
	Для каждого Соединение Из Состояние.МассивСоединений Цикл
		
		УпроститьСоединения(НачальноеСостояние, Соединение.СледующееСостояние, ПосетилиСостояние);

	КонецЦикла;


	Пока Состояние.УпроститьСвоиСоединения() Цикл
		
	КонецЦикла;

КонецПроцедуры

Функция НомерСостояни(Состояние) Экспорт
	
	Номер = НомераСостояний[Состояние];
	
	Если Номер = Неопределено Тогда
		ПоследнийНомар = ПоследнийНомар +1;
		Номер = ПоследнийНомар;

		НомераСостояний.Вставить(Состояние, Номер);

	КонецЕсли;

	Возврат Номер;
	
КонецФункции


Функция ИмяСостояния(Состояние) Экспорт

	Номер = НомерСостояни(Состояние);

	Если Состояние.Завершено Тогда
		
		Возврат СтрШаблон("(S%1)",Номер);

	КонецЕсли;
	
	Возврат СтрШаблон("S%1",Номер);
	
КонецФункции

Функция СгенеритьСтрокуПути(НачальноеСостояние) Экспорт

	ПосетилиСостояние = Новый Соответствие;

	МассивСтрок = СостояниеВСтрокуПути(НачальноеСостояние, НомераСостояний, ПосетилиСостояние);

	Возврат СтрСоединить(МассивСтрок, Символы.ПС);
	
КонецФункции

Функция СостояниеВСтрокуПути(Состояние, НомераСостояний, ПосетилиСостояние)

	Лог.Отладка("Я УпроститьСоединения");
	МассивСтрок = Новый Массив;
	Если ПосетилиСостояние[Состояние] = Истина Тогда
		Лог.Отладка("Я уже тут был");
		Возврат МассивСтрок;
	КонецЕсли;

	ПосетилиСостояние.Вставить(Состояние, Истина);
	
	Для каждого Соединение Из Состояние.МассивСоединений Цикл
		
		МассивСтрок.Добавить(СтрШаблон("%1 %2 %3", ИмяСостояния(Состояние), Соединение.Парсер.ВСтроку(), ИмяСостояния(Соединение.СледующееСостояние)));
		СоединитьМассивы(МассивСтрок, СостояниеВСтрокуПути(Соединение.СледующееСостояние, НомераСостояний, ПосетилиСостояние));
	КонецЦикла;

	Возврат МассивСтрок

КонецФункции

Процедура СоединитьМассивы(ИсходныйМассив, ПрисоединяемыйМассив)
	
	Для каждого Переменная Из ПрисоединяемыйМассив Цикл
		ИсходныйМассив.Добавить(Переменная);
	КонецЦикла;

КонецПроцедуры


Процедура СортировкаСоединений(Состояние, ПосетилиСостояние) Экспорт
	
	Если ПосетилиСостояние[Состояние] = Истина Тогда
		Возврат;
	КонецЕсли;

	ПосетилиСостояние.Вставить(Состояние, Истина);
	
	СортироватьМассив(Состояние.МассивСоединений);

	Для каждого Соединение Из Состояние.МассивСоединений Цикл
		СортировкаСоединений(Соединение.СледующееСостояние, ПосетилиСостояние);
	КонецЦикла;


КонецПроцедуры

Процедура СортироватьМассив(МассивСоединений)

	ПроцессорКоллекций = ПроцессорыКоллекций.ИзКоллекции(МассивСоединений);
	МассивСоединений = ПроцессорКоллекций
		.Сортировать("Результат = Элемент1.Парсер.Приоритет() > Элемент2.Парсер.Приоритет()")
		.ВМассив();

КонецПроцедуры

Функция НовоеСостояние() Экспорт
	Возврат Новый Совпадение();
КонецФункции

НомераСостояний = Новый Соответствие;
ПоследнийНомар = 0;
Лог = Логирование.ПолучитьЛог("oscript.lib.v8runner");
//Лог.УстановитьУровень(УровниЛога.Отладка);