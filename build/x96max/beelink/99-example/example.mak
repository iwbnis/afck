#--------------------------
# Пример файла модификации
#--------------------------

# Перед загрузкой этого файла система сборки устанавливает
# следующие переменные:
#
# MOD - название мода (берётся из имени каталога с модом)
# DIR - полный путь к каталогу мода (например, $(DIR)data.bin
#       будет ссылаться на файл data.bin из каталога мода).
# IMG.OUT - путь к рабочим образам, с которыми работаем

# Переменная DISABLED, если имеет значение отличное от пустого,
# отключает выполнение мода
DISABLED = YES

# В переменной HELP задаётся описание мода для 'make help-mod'
HELP = пример мода

# Многострочное описание мода, этот текст попадёт в автоматически
# формируемый файл README.md. Используйте директивы форматирования
# Markdown, если требуется более сложное оформление текста:
# https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
# Проверить форматирование можно здесь: https://dillinger.io
define DESC
Модификация, которая модифицирует модифицируемые файлы \
только для того, чтобы наиболее полно описать \
модификационные директивы в системе сборки AFCK!

* Список!
* **Вторая** строка списка!

```
u211:/# echo "Hello, world!"
Hello, world!
```
endef

# Функция IMG.UNPACK.EXT4 декларирует, что данный мод нуждается
# в распаковке образа в формате ext4. Распакованный образ
# будет лежать в каталоге $(IMG.OUT)[название].
# Название - это имя раздела - system, vendor и т.п.
#$(call IMG.UNPACK.EXT4,system)

# В переменной DEPS задаётся список зависимостей для этого мода.
# Там уже могут быть накоплены зависимости, поэтому используется
# оператор добавления += а не присваивания.
# Если любая из зависимостей изменится, мод будет пересобран.
#DEPS += $(wildcard $(DIR)*/*)

# Если мод должен установить системный APK, проще всего
# воспользоваться функцией MOD.SYSAPK:
#$(call MOD.SYSAPK,vendor.example.apk,Пример системной программы)
# Или если пакет необходимо установить в пользовательский раздел
# (/data), чтобы пользователь мог обновлять/удалять его:
#$(call MOD.USERAPK,example.apk,Пример пользовательской программы)

# В переменной INSTALL задаётся список команд, которые каким-то
# образом модифицируют образ прошивки (обычно распакованный).
define INSTALL
	echo Hello, world!
endef
