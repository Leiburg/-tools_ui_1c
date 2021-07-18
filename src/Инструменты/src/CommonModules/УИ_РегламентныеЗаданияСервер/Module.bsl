// Вызывает исключение, если у пользователя нет права администрирования.
Процедура ВызватьИсключениеЕслиНетПраваАдминистрирования()

	ПроверятьПраваАдминистрированияСистемы = Истина;
	Если УИ_ОбщегоНазначения.РазделениеВключено() И УИ_ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		ПроверятьПраваАдминистрированияСистемы = Ложь;
	КонецЕсли;

	Если Не УИ_Пользователи.ЭтоПолноправныйПользователь( , ПроверятьПраваАдминистрированияСистемы) Тогда
		ВызватьИсключение НСтр("ru = 'Нарушение прав доступа.'");
	КонецЕсли;

КонецПроцедуры

// Возвращает РегламентноеЗадание из информационной базы.
// Не предназначена для использования в модели сервиса.
//
// Параметры:
//  Идентификатор - ОбъектМетаданных - объект метаданных регламентного задания для поиска
//                  предопределенного регламентного задания.
//                - УникальныйИдентификатор - идентификатор регламентного задания.
//                - Строка - строка уникального идентификатора регламентного задания.
//                - РегламентноеЗадание - регламентное задание из которого нужно получить
//                  уникальный идентификатор для получения свежей копии регламентного задания.
// 
// Возвращаемое значение:
//  РегламентноеЗадание - прочитано из базы данных.
//
Функция ПолучитьРегламентноеЗадание(Знач Идентификатор) Экспорт

	ВызватьИсключениеЕслиНетПраваАдминистрирования();

	Если ТипЗнч(Идентификатор) = Тип("РегламентноеЗадание") Тогда
		Идентификатор = Идентификатор.УникальныйИдентификатор;
	КонецЕсли;

	Если ТипЗнч(Идентификатор) = Тип("Строка") Тогда
		Идентификатор = Новый УникальныйИдентификатор(Идентификатор);
	КонецЕсли;

	Если ТипЗнч(Идентификатор) = Тип("ОбъектМетаданных") Тогда
		РегламентноеЗадание = РегламентныеЗадания.НайтиПредопределенное(Идентификатор);
	Иначе
		РегламентноеЗадание = РегламентныеЗадания.НайтиПоУникальномуИдентификатору(Идентификатор);
	КонецЕсли;

	Если РегламентноеЗадание = Неопределено Тогда
		ВызватьИсключение (НСтр("ru = 'Регламентное задание не найдено.
								|Возможно, оно удалено другим пользователем.'"));
	КонецЕсли;

	Возврат РегламентноеЗадание;

КонецФункции

// Добавляет новое задание в очередь или как регламентное.
// 
// Параметры: 
//  Параметры - Структура - Параметры добавляемого задания, возможные ключи:
//   Использование
//   Метаданные - обязательно для указания.
//   Параметры
//   Ключ
//   ИнтервалПовтораПриАварийномЗавершении.
//   Расписание
//   КоличествоПовторовПриАварийномЗавершении.
//
// Возвращаемое значение: 
//  РегламентноеЗадание, СправочникСсылка.ОчередьЗаданий, СправочникСсылка.ОчередьЗаданийОбластейДанных - Идентификатор
//  добавленного задания.
// 
Функция ДобавитьЗадание(Параметры) Экспорт

	ВызватьИсключениеЕслиНетПраваАдминистрирования();

	ПараметрыЗадания = УИ_ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(Параметры);

	//Если УИ_ОбщегоНазначения.РазделениеВключено() Тогда

	//	Если УИ_ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса.ОчередьЗаданий") Тогда
	//		МодульРаботаВМоделиСервиса = УИ_ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");

	//		Если УИ_ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
	//			ОбластьДанных = МодульРаботаВМоделиСервиса.ЗначениеРазделителяСеанса();
	//			ПараметрыЗадания.Вставить("ОбластьДанных", ОбластьДанных);
	//		КонецЕсли;

	//		МетаданныеЗадания = ПараметрыЗадания.Метаданные;
	//		ИмяМетода = МетаданныеЗадания.ИмяМетода;
	//		ПараметрыЗадания.Вставить("ИмяМетода", ИмяМетода);

	//		ПараметрыЗадания.Удалить("Метаданные");
	//		ПараметрыЗадания.Удалить("Наименование");

	//		МодульОчередьЗаданий = УИ_ОбщегоНазначения.ОбщийМодуль("ОчередьЗаданий");
	//		Задание = МодульОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);
	//		СписокЗаданий = МодульОчередьЗаданий.ПолучитьЗадания(Новый Структура("Идентификатор", Задание));
	//		Для Каждого Задание Из СписокЗаданий Цикл
	//			Возврат Задание;
	//		КонецЦикла;

	//	КонецЕсли;

	//Иначе

		МетаданныеЗадания = ПараметрыЗадания.Метаданные;
		Задание = РегламентныеЗадания.СоздатьРегламентноеЗадание(МетаданныеЗадания);

		Если ПараметрыЗадания.Свойство("Наименование") Тогда
			Задание.Наименование = ПараметрыЗадания.Наименование;
		Иначе
			Задание.Наименование = МетаданныеЗадания.Наименование;
		КонецЕсли;

		Если ПараметрыЗадания.Свойство("Использование") Тогда
			Задание.Использование = ПараметрыЗадания.Использование;
		Иначе
			Задание.Использование = МетаданныеЗадания.Использование;
		КонецЕсли;

		Если ПараметрыЗадания.Свойство("Ключ") Тогда
			Задание.Ключ = ПараметрыЗадания.Ключ;
		Иначе
			Задание.Ключ = МетаданныеЗадания.Ключ;
		КонецЕсли;

		Если ПараметрыЗадания.Свойство("ИмяПользователя") Тогда
			Задание.ИмяПользователя = ПараметрыЗадания.ИмяПользователя;
		КонецЕсли;

		Если ПараметрыЗадания.Свойство("ИнтервалПовтораПриАварийномЗавершении") Тогда
			Задание.ИнтервалПовтораПриАварийномЗавершении = ПараметрыЗадания.ИнтервалПовтораПриАварийномЗавершении;
		Иначе
			Задание.ИнтервалПовтораПриАварийномЗавершении = МетаданныеЗадания.ИнтервалПовтораПриАварийномЗавершении;
		КонецЕсли;

		Если ПараметрыЗадания.Свойство("КоличествоПовторовПриАварийномЗавершении") Тогда
			Задание.КоличествоПовторовПриАварийномЗавершении = ПараметрыЗадания.КоличествоПовторовПриАварийномЗавершении;
		Иначе
			Задание.КоличествоПовторовПриАварийномЗавершении = МетаданныеЗадания.КоличествоПовторовПриАварийномЗавершении;
		КонецЕсли;

		Если ПараметрыЗадания.Свойство("Параметры") Тогда
			Задание.Параметры = ПараметрыЗадания.Параметры;
		КонецЕсли;

		Если ПараметрыЗадания.Свойство("Расписание") Тогда
			Задание.Расписание = ПараметрыЗадания.Расписание;
		КонецЕсли;

		Задание.Записать();

	//КонецЕсли;

	Возврат Задание;

КонецФункции
// Возвращает расписание регламентного задания.
// Перед вызовом требуется иметь право Администрирования или УстановитьПривилегированныйРежим.
// Не предназначена для использования в модели сервиса.
//
// Параметры:
//  Идентификатор - ОбъектМетаданных - объект метаданных регламентного задания для поиска
//                  предопределенного регламентного задания.
//                - УникальныйИдентификатор - идентификатор регламентного задания.
//                - Строка - строка уникального идентификатора регламентного задания.
//                - РегламентноеЗадание - регламентное задание.
//
//  ВСтруктуре    - Булево - если Истина, тогда расписание будет преобразовано
//                  в структуру, которую можно передать на клиент.
// 
// Возвращаемое значение:
//  РасписаниеРегламентногоЗадания, Структура - структура содержит те же свойства, что и расписание.
// 
Функция РасписаниеРегламентногоЗадания(Знач Идентификатор, Знач ВСтруктуре = Ложь) Экспорт

	ВызватьИсключениеЕслиНетПраваАдминистрирования();

	Задание = ПолучитьРегламентноеЗадание(Идентификатор);

	Если ВСтруктуре Тогда
		Возврат УИ_ОбщегоНазначенияКлиентСервер.РасписаниеВСтруктуру(Задание.Расписание);
	КонецЕсли;

	Возврат Задание.Расписание;

КонецФункции

// Устанавливает расписание регламентного задания.
// Перед вызовом требуется иметь право Администрирования или УстановитьПривилегированныйРежим.
// Не предназначена для использования в модели сервиса.
//
// Параметры:
//  Идентификатор - ОбъектМетаданных - объект метаданных регламентного задания для поиска
//                  предопределенного регламентного задания.
//                - УникальныйИдентификатор - идентификатор регламентного задания.
//                - Строка - строка уникального идентификатора регламентного задания.
//                - РегламентноеЗадание - регламентное задание.
//
//  Расписание    - РасписаниеРегламентногоЗадания - расписание.
//                - Структура - значение возвращаемое функцией РасписаниеВСтруктуру
//                  общего модуля ОбщегоНазначенияКлиентСервер.
// 
Процедура УстановитьРасписаниеРегламентногоЗадания(Знач Идентификатор, Знач Расписание) Экспорт

	ВызватьИсключениеЕслиНетПраваАдминистрирования();

	Задание = ПолучитьРегламентноеЗадание(Идентификатор);

	Если ТипЗнч(Расписание) = Тип("РасписаниеРегламентногоЗадания") Тогда
		Задание.Расписание = Расписание;
	Иначе
		Задание.Расписание = УИ_ОбщегоНазначенияКлиентСервер.СтруктураВРасписание(Расписание);
	КонецЕсли;

	Задание.Записать();

КонецПроцедуры

Функция ПолучитьОбъектРегламентногоЗадания(УникальныйНомерЗадания) Экспорт

	Попытка

		Если Не ПустаяСтрока(УникальныйНомерЗадания) Тогда
			УникальныйИдентификаторЗадания = Новый УникальныйИдентификатор(УникальныйНомерЗадания);
			ТекущееРегламентноеЗадание = РегламентныеЗадания.НайтиПоУникальномуИдентификатору(
				УникальныйИдентификаторЗадания);
		Иначе
			ТекущееРегламентноеЗадание = Неопределено;
		КонецЕсли;

	Исключение
		ТекущееРегламентноеЗадание = Неопределено;
	КонецПопытки;

	Возврат ТекущееРегламентноеЗадание;

КонецФункции

Функция ПолучитьОбъектФоновогоЗадания(УникальныйНомерЗадания) Экспорт

	Попытка

		Если Не ПустаяСтрока(УникальныйНомерЗадания) Тогда
			УникальныйИдентификаторЗадания = Новый УникальныйИдентификатор(УникальныйНомерЗадания);
			ТекущееФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(УникальныйИдентификаторЗадания);
		Иначе
			ТекущееФоновоеЗадание = Неопределено;
		КонецЕсли;

	Исключение
		ТекущееФоновоеЗадание = Неопределено;
	КонецПопытки;

	Возврат ТекущееФоновоеЗадание;

КонецФункции