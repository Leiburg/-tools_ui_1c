
&НаКлиенте
Процедура ВыполнитьАлгоритм(Команда)
	МассивАлгоритмов = Элементы.Список.ВыделенныеСтроки;
	
	Для Каждого Алгоритм Из МассивАлгоритмов Цикл
		Ошибка = Ложь;
		СообщениеОбОшибке = "";
        СтруктураПередачи = Новый структура;
		
		Если АлгоритмВыполняетсяНаКлиенте(Алгоритм) Тогда
			ВыполнитьАлгоритмНаКлиенте(Алгоритм, СтруктураПередачи);
		Иначе
			УИ_АлгоритмыВызовСервера.ВыполнитьАлгоритм(Алгоритм);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция АлгоритмВыполняетсяНаКлиенте(Алгоритм)

	Возврат Алгоритм.НаКлиенте;

КонецФункции
 
&НаКлиенте
Процедура ВыполнитьАлгоритмНаКлиенте(Алгоритм, СтруктураПередачи)
	Если Не ЗначениеЗаполнено(СокрЛП(Алгоритм.ТекстАлгоритма)) Тогда
		Возврат;
	КонецЕсли;

	КонтекстВыполнения = УИ_АлгоритмыВызовСервера.ПолучитьПараметры(Алгоритм);

	РезультатВыполнения = УИ_РедакторКодаКлиентСервер.ВыполнитьАлгоритм(Алгоритм.ТекстАлгоритма, КонтекстВыполнения);

КонецПроцедуры


