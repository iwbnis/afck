include build/colors.mak

# ----------- # Цель по умолчанию # ----------- #
.PHONY: all show-rules
all: help

# ---------- # Полезные переменные # ---------- #

# Перевод строки
define NL


endef
# Запятая
COMMA=,
# Пустышка
EMPTY=
# Пробел
SPACE=$(EMPTY) $(EMPTY)
# Вывод текста в аргументе $1 на терминал
SAY = echo -e '$(subst $(NL),\n,$(subst ','\'',$1))'
# Создать подкаталог со всеми промежуточными подкаталогами
MKDIR = mkdir -p "$(1:/=)"
# Удаление файла $1 без вопрсов
RM = rm -f "$1"
# Рекурсивное удаление каталога $1 без вопросов
RMDIR = rm -rf "$1"
# Копировать файл $1 в $2
CP = cp -dP --preserve=all "$1" "$2"
# Переминовать/переместить файл $1 в $2
MV = mv -f "$1" "$2"
# Создание символической ссылки
LN_S = ln -fs "$1" "$2"
# Рекурсивное копирование каталога $1 в $2
RCP = cp -a "$1" "$2"
# Обновить штамп времени последней модификации на файле
TOUCH = touch "$1"
# Записать текст $2 в файл $1
FWRITE = $(call SAY,$2) > "$1"
# Дописать текст $2 к файлу $1
FAP = $(call SAY,$2) >> "$1"
# Скопировать файл $1 в $2 если они отличаются
UCOPY = cmp -s "$1" "$2" || cp -a "$1" "$2"
# Переместить файл $1 в $2 если они отличаются, иначе удалить $1
UMOVE = cmp -s "$1" "$2" && rm -f "$1" || mv -f "$1" "$2"
# Перевод ASCII строки $1 в нижний регистр
LOWCASE = $(shell echo '$1' | tr A-Z a-z)
# Правило для вычисления суммы двух чисел
ADD = $(shell expr '$1' + '$2')
# Линия разделителя -- $- :-)
-=------------------------------------------------------------------------

# ---------- # Каталоги и утилиты # ---------- #

# Базовый каталог для генерируемых файлов
OUT = out/$(TARGET)/
# Каталог с файлами для целевой платформы
TARGET.DIR = build/$(TARGET)/
# Функция для добавления описания $2 цели $1
HELPL = $(NL)$(C.BOLD) $(strip $1)$(C.RST) - $(strip $2)

ifndef HOST.OS
# Автоматическое определение операционной системы, в которой ведётся сборка
ifneq ($(COMSPEC)$(ComSpec),)
HOST.OS = windows
else
HOST.OS = $(call LOWCASE,$(shell uname -s))
endif
endif
# Каталог с утилитами для текущей ОС
TOOLS.DIR = tools/$(HOST.OS)/

# Системно-зависимые утилиты
include build/rules-$(HOST.OS).mak

# Наложить патч $1 относительно каталога $2 с дополнительными опциями $3
define APPLY.PATCH
	@$(call SAY,$(C.WHITE)Applying patch file $(C.LBLUE)$1$(C.RST))
	patch $(if $2,-d "$2") $3 <$(if $1,"$1")

endef

# Проверить условие $1, вывести ошибку $2 если условие непустое
ASSERT = $(if $(strip $1),,$(error $(C.ERR)$2))

# Общие правила
include build/common.mak

# Правила для целевой платформы
ifeq ($(wildcard $(TARGET.DIR)rules.mak),)
$(error $(C.ERR)Файл с правилами для целевой платформы $(TARGET.DIR)rules.mak не существует!)
endif
include $(TARGET.DIR)rules.mak
