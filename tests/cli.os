#использовать "../src"
#Использовать asserts
Перем V, B, S, ARG, SRC;
Перем юТест;

Функция ПолучитьСписокТестов(Знач Тестирование) Экспорт

	юТест = Тестирование;
	
	ИменаТестов = Новый Массив;
	
	//ИменаТестов.Добавить("ТестДолжен_ПроверитьРаботуКоманды");
	ИменаТестов.Добавить("ТестДолжен_ПроверитьПриложения");
	
	Возврат ИменаТестов;

КонецФункции

Процедура ТестДолжен_ПроверитьРаботуКоманды() Экспорт

	cli = Новый КомандаПриложения("os", "я тут", ЭтотОбъект);
	оп_v = cli.БулевоОпция("v vers", Ложь, "Тест");
	оп_s = cli.БулевоОпция("s ssss", Ложь, "Тест");
	оп_b = cli.БулевоОпция("b bbbb", Ложь, "Тест");
	ARG = cli.СтрокаАргумент("ARG", "", "Тест");
	SRC = cli.СтрокаАргумент("SRC", "", "Тест");
	cli.Спек = "ARG -v[-s | --ssss] -b SRC";
	cli.НачалоЗапуска();
	ВходящиеАргументы = Новый Массив;
	ВходящиеАргументы.Добавить("Это очень крутой аргумент");
	ВходящиеАргументы.Добавить("-v");
	ВходящиеАргументы.Добавить("--ssss");
	ВходящиеАргументы.Добавить("-b");
	ВходящиеАргументы.Добавить("аргумент SRC");
	cli.Запуск(ВходящиеАргументы);

	Сообщить("-v "+ оп_v.Значение);
	Сообщить("-b "+ оп_b.Значение);
	Сообщить("-s "+ оп_s.Значение);
	Сообщить("ARG "+ ARG.Значение);
	Сообщить("SRC "+ SRC.Значение);

КонецПроцедуры

Процедура ОписаниеКоманды(Команда) Экспорт
	
	V = Команда.Опция("v vers-predator", Ложь, "Флаг вывода парметров").Флаговый();
	S = Команда.Опция("s ssss", Ложь, "Тест").Флаговый();
	B = Команда.Опция("b bbbb", Ложь, "Тест").Флаговый();
	ARG = Команда.Аргумент("ARG", "", "Тест");
	SRC = Команда.Аргумент("SRC", "", "Тест");
	Команда.Спек = "-v [-sb] ARG SRC";
	//Команда.Спек = "ARG -v[-s | --ssss] -b SRC";
	
КонецПроцедуры


Процедура ТестДолжен_ПроверитьПриложения() Экспорт

	cli = Новый КонсольноеПриложение("testapp", "Выполняет полезную работу");
	cli.Версия("v version", "1.0");
	КомандаAve = cli.ДобавитьПодкоманду("a ave", "Команда ave", ЭтотОбъект);
	// оп_v = КомандаAve.Опция("v vers", Ложь, "Тест").Флаговый().ВПеременную(V);
	// on_s = КомандаAve.Опция("s ssss", Ложь, "Тест").Флаговый().ВПеременную(S);
	// on_b = КомандаAve.Опция("b bbbb", Ложь, "Тест").Флаговый().ВПеременную(B);
	// ARG = КомандаAve.Аргумент("ARG", "", "Тест").ВПеременную(ARG);
	// SRC = КомандаAve.Аргумент("SRC", "", "Тест").ВПеременную(SRC);
	// // КомандаAve.Спек = "-vsb ARG SRC";

	ВходящиеАргументы = Новый Массив;
	ВходящиеАргументы.Добавить("ave");
	//ВходящиеАргументы.Добавить("-v");
	ВходящиеАргументы.Добавить("--help");
	//ВходящиеАргументы.Добавить("-b");
	ВходящиеАргументы.Добавить("Это очень крутой аргумент");
	ВходящиеАргументы.Добавить("аргумент SRC");
	cli.Запустить(ВходящиеАргументы);


КонецПроцедуры


Процедура ВыполнитьКоманду() Экспорт
	
	Сообщить("-v "+ V.Значение);
	Сообщить("-b "+ B.Значение);
	Сообщить("-s "+ S.Значение);
	Сообщить("ARG "+ ARG.Значение);
	Сообщить("SRC "+ SRC.Значение);
	Сообщить("Полезная работа");

КонецПроцедуры 