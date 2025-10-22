# AwesomeWM конфигурация в стиле Kali Linux Xfce

## 📋 Описание

Эта конфигурация воспроизводит окружение Kali Linux Xfce на базе AwesomeWM с расширенными возможностями тайлинга. Конфигурация объединяет мощь динамического оконного менеджера Awesome с удобством и знакомым интерфейсом Xfce компонентов.

## ✨ Особенности

- ✅ **xfdesktop** для управления рабочим столом с иконками
- ✅ **Тёмная тема Kali-Dark** для всех GTK приложений
- ✅ **Иконки Flat-Remix-Blue-Dark** в синей цветовой гамме Kali
- ✅ **Полная интеграция с Xfce компонентами** (thunar, xfce4-terminal, xfce4-settings)
- ✅ **Тайлинг и динамическое управление окнами** - 8 различных раскладок
- ✅ **Информативная панель** с системным треем, часами и индикаторами
- ✅ **Тёмно-голубая цветовая схема** характерная для Kali Linux
- ✅ **Оптимизированные горячие клавиши** для быстрой работы

## 📦 Необходимые пакеты

**Важно:** Все инструкции адаптированы для **Arch Linux**. Команды используют `pacman` и `yay` (AUR helper).

### Основные:

```bash
sudo pacman -S awesome xorg-server xorg-xinit
```

### Xfce компоненты:

```bash
sudo pacman -S xfdesktop thunar xfce4-settings xfce4-power-manager \
               xfce4-notifyd xfce4-terminal xfce4-screenshooter
```

### Темы и иконки:

```bash
# Kali-Dark тема (из AUR)
yay -S kali-themes

# Flat-Remix иконки
sudo pacman -S flat-remix

# Или из AUR для полной версии:
yay -S flat-remix-git
```

### Дополнительные утилиты:

```bash
sudo pacman -S picom rofi network-manager-applet polkit-gnome firefox
```

### Шрифты:

```bash
sudo pacman -S noto-fonts noto-fonts-emoji ttf-dejavu
```

## 🚀 Установка

Есть два способа установки: через **yadm** (рекомендуется) или через **git** с симлинками.

### Вариант 1: Установка через yadm (рекомендуется)

**yadm** (Yet Another Dotfiles Manager) - специализированный менеджер для dotfiles, который работает как обёртка над git.

#### 1. Установить yadm:

```bash
# На Arch Linux
sudo pacman -S yadm
```

#### 2. Клонировать репозиторий с помощью yadm:

```bash
# Инициализация и клонирование dotfiles
yadm clone https://github.com/VovaplusEXP/dotfile.git

# Если у вас уже есть файлы в домашней директории, используйте:
yadm clone https://github.com/VovaplusEXP/dotfile.git --bootstrap
```

#### 3. Сделать autostart.sh исполняемым:

```bash
chmod +x ~/.config/awesome/autostart.sh
```

#### 4. Создать .xinitrc для запуска Awesome:

```bash
cat > ~/.xinitrc << 'EOF'
#!/bin/sh
# Запуск AwesomeWM
exec awesome
EOF

chmod +x ~/.xinitrc
```

#### 5. Проверить конфигурацию:

```bash
awesome -k
```

#### 6. Запустить AwesomeWM:

```bash
startx
```

**Преимущества yadm:**
- Файлы размещаются напрямую в `$HOME` без симлинков
- Простое управление версиями dotfiles
- Поддержка альтернативных файлов для разных систем
- Встроенное шифрование для чувствительных данных

**Управление через yadm:**
```bash
# Статус файлов
yadm status

# Добавить изменения
yadm add .config/awesome/rc.lua

# Коммит
yadm commit -m "Update awesome config"

# Отправка изменений
yadm push
```

---

### Вариант 2: Установка через git (с симлинками)

#### 1. Клонировать репозиторий:

```bash
git clone https://github.com/VovaplusEXP/dotfile.git ~/.dotfiles
cd ~/.dotfiles
```

#### 2. Создать симлинки:

```bash
# Awesome конфигурация
ln -sf ~/.dotfiles/.config/awesome ~/.config/

# GTK настройки
ln -sf ~/.dotfiles/.config/gtk-3.0 ~/.config/
ln -sf ~/.dotfiles/.gtkrc-2.0 ~/
```

#### 3. Сделать autostart.sh исполняемым:

```bash
chmod +x ~/.config/awesome/autostart.sh
```

#### 4. Создать .xinitrc для запуска Awesome:

```bash
cat > ~/.xinitrc << 'EOF'
#!/bin/sh
# Запуск AwesomeWM
exec awesome
EOF

chmod +x ~/.xinitrc
```

#### 5. Проверить конфигурацию на ошибки:

```bash
awesome -k
```

Если команда завершается без вывода, конфигурация корректна.

#### 6. Запустить AwesomeWM:

```bash
startx
```

Или если используете display manager (GDM, LightDM, SDDM), выберите "Awesome" в меню сессий.

---

### Примечания по установке

- **Рекомендуется использовать yadm** для более чистого управления dotfiles
- Все инструкции адаптированы для **Arch Linux**
- Убедитесь что все необходимые пакеты установлены (см. раздел "Необходимые пакеты")
- После установки перезагрузите конфигурацию: `Mod4 + Ctrl + R`

## ⌨️ Горячие клавиши

### Основные приложения:

| Клавиши | Действие |
|---------|----------|
| `Mod4 + Enter` | Открыть терминал (xfce4-terminal) |
| `Mod4 + W` | Открыть браузер (Firefox) |
| `Mod4 + E` | Открыть файловый менеджер (Thunar) |
| `Mod4 + R` | Запустить поиск приложений (rofi/xfce4-appfinder) |
| `Mod4 + Shift + S` | Сделать скриншот (xfce4-screenshooter) |
| `Mod4 + L` | Заблокировать экран (xflock4) |
| `Mod4 + P` | Показать menubar |

### Управление окнами:

| Клавиши | Действие |
|---------|----------|
| `Mod4 + J` | Переключиться на следующее окно |
| `Mod4 + K` | Переключиться на предыдущее окно |
| `Mod4 + Shift + J` | Переместить окно вниз по стеку |
| `Mod4 + Shift + K` | Переместить окно вверх по стеку |
| `Mod4 + H` | Уменьшить ширину мастер-области |
| `Mod4 + L` | Увеличить ширину мастер-области |
| `Mod4 + F` | Полноэкранный режим (fullscreen) |
| `Mod4 + M` | Максимизировать окно |
| `Mod4 + N` | Минимизировать окно |
| `Mod4 + Ctrl + N` | Восстановить минимизированное окно |
| `Mod4 + Shift + C` | Закрыть окно |
| `Mod4 + T` | Поверх всех окон (always on top) |
| `Mod4 + Ctrl + Space` | Переключить в плавающий режим |
| `Mod4 + Ctrl + Return` | Переместить в мастер-область |
| `Mod4 + O` | Переместить окно на другой монитор |

### Управление раскладками:

| Клавиши | Действие |
|---------|----------|
| `Mod4 + Space` | Следующая раскладка |
| `Mod4 + Shift + Space` | Предыдущая раскладка |

**Доступные раскладки:**
1. Tile (тайлинг, мастер слева)
2. Tile Left (мастер справа)
3. Tile Bottom (мастер сверху)
4. Tile Top (мастер снизу)
5. Fair (равномерное распределение)
6. Max (максимизация)
7. Floating (плавающие окна)
8. Spiral Dwindle (спираль)

### Рабочие столы (теги):

| Клавиши | Действие |
|---------|----------|
| `Mod4 + 1-9` | Переключиться на рабочий стол 1-9 |
| `Mod4 + Shift + 1-9` | Переместить окно на рабочий стол 1-9 |
| `Mod4 + Ctrl + 1-9` | Показать рабочий стол 1-9 дополнительно |
| `Mod4 + Ctrl + Shift + 1-9` | Показать окно на рабочем столе 1-9 |

### AwesomeWM система:

| Клавиши | Действие |
|---------|----------|
| `Mod4 + S` | Показать все горячие клавиши |
| `Mod4 + Ctrl + R` | Перезагрузить конфигурацию |
| `Mod4 + Shift + Q` | Выйти из Awesome |

### Мышь:

| Действие | Результат |
|----------|-----------|
| `Правый клик на рабочем столе` | Открыть главное меню |
| `Mod4 + Левая кнопка на окне` | Перемещение окна |
| `Mod4 + Правая кнопка на окне` | Изменение размера окна |
| `Левый клик на окне в tasklist` | Свернуть/развернуть окно |
| `Правый клик на окне в tasklist` | Показать список всех окон |

**Примечание:** `Mod4` - это клавиша Super (обычно Windows или Command)

## 🎨 Кастомизация

### Изменить обои:

**Способ 1: Через xfdesktop (рекомендуется)**
```
Правый клик на рабочем столе → Desktop Settings → Background
```

**Способ 2: В theme.lua**
```lua
theme.wallpaper = "/путь/к/вашим/обоям.jpg"
```

**Способ 3: Через feh (если не используете xfdesktop)**
```bash
# Отключите xfdesktop в autostart.sh и добавьте:
feh --bg-scale ~/.config/awesome/wallpaper.jpg
```

### Изменить терминал:

В файле `rc.lua` найдите:
```lua
terminal = "xfce4-terminal"
```

Замените на:
```lua
terminal = "alacritty"    -- или "kitty", "urxvt", "st"
```

### Изменить браузер или файловый менеджер:

В файле `rc.lua`:
```lua
browser = "chromium"           -- вместо firefox
filemanager = "pcmanfm"        -- вместо thunar
```

### Изменить модификатор клавиш:

По умолчанию используется `Mod4` (Super/Windows). Для изменения на `Alt`:
```lua
modkey = "Mod1"  -- Mod1 = Alt, Mod4 = Super
```

### Добавить автозапуск приложений:

Отредактируйте `~/.config/awesome/autostart.sh`:
```bash
# Добавьте в конец файла:
run discord
run telegram-desktop
```

### Изменить цветовую схему:

Отредактируйте `~/.config/awesome/theme.lua`:
```lua
theme.bg_focus      = "#ff0000"  -- Красный акцент вместо синего
theme.border_focus  = "#ff0000"  -- Красная граница
```

### Изменить размер отступов между окнами:

В `theme.lua`:
```lua
theme.useless_gap   = dpi(8)   -- Увеличить до 8 пикселей
```

### Отключить titlebars (заголовки окон):

В `rc.lua` найдите:
```lua
properties = { titlebars_enabled = true }
```

Замените на:
```lua
properties = { titlebars_enabled = false }
```

## 🔧 Решение проблем

### xfdesktop не показывает иконки на рабочем столе

```bash
# Перезапустить xfdesktop
killall xfdesktop
xfdesktop --disable-wm-check &
```

### GTK темы не применяются

```bash
# Перезапустить xfsettingsd
killall xfsettingsd
xfsettingsd --replace &

# Проверить переменные окружения
echo $GTK_THEME
echo $GTK2_RC_FILES
```

### Awesome не запускается или выдаёт ошибки

```bash
# Проверить синтаксис конфигурации
awesome -k

# Если есть ошибки, они будут показаны
# Посмотреть подробные логи
cat ~/.xsession-errors
```

### Нет звука в уведомлениях

```bash
# Установить звуковые темы
sudo pacman -S sound-theme-freedesktop

# Проверить что xfce4-notifyd запущен
ps aux | grep xfce4-notifyd
```

### Горячие клавиши не работают

```bash
# Проверить что конфигурация загружена
awesome -k

# Перезагрузить awesome
Mod4 + Ctrl + R
```

### Picom вызывает проблемы с производительностью

```bash
# Отключить picom
killall picom

# Или отредактировать autostart.sh и закомментировать:
# run picom -b
```

### Шрифты выглядят размыто

```bash
# Установить дополнительные шрифты
sudo pacman -S ttf-liberation ttf-dejavu noto-fonts

# Перезапустить awesome
Mod4 + Ctrl + R
```

### Не хватает иконок в меню

```bash
# Установить больше пакетов иконок
sudo pacman -S papirus-icon-theme breeze-icons
```

### Высокое использование CPU

```bash
# Проверить процессы
htop

# Возможно, проблема с picom - попробуйте другой композитор:
# В autostart.sh замените picom на:
run compton -b
```

## 📁 Структура файлов

```
~/.config/awesome/
├── rc.lua              # Главный конфигурационный файл
├── theme.lua           # Тема Kali-Dark
├── autostart.sh        # Скрипт автозапуска
└── README.md           # Эта документация

~/.config/gtk-3.0/
└── settings.ini        # Настройки GTK 3

~/.gtkrc-2.0            # Настройки GTK 2
```

## 🔄 Обновление конфигурации

### Если используете yadm:

```bash
# Получить обновления
yadm pull

# Перезагрузить awesome
Mod4 + Ctrl + R
```

### Если используете git с симлинками:

```bash
# Перейти в директорию с dotfiles
cd ~/.dotfiles

# Получить обновления
git pull

# Перезагрузить awesome
Mod4 + Ctrl + R
```

## 📚 Полезные ресурсы

### Документация:
- [Awesome WM официальная документация](https://awesomewm.org/doc/)
- [Awesome WM API документация](https://awesomewm.org/apidoc/)
- [Arch Wiki: Awesome](https://wiki.archlinux.org/title/Awesome)

### Темы и виджеты:
- [Awesome WM Copycats](https://github.com/lcpz/awesome-copycats)
- [Awesome WM Widgets](https://github.com/streetturtle/awesome-wm-widgets)

### Kali Linux:
- [Kali Linux темы](https://www.kali.org/docs/general-use/kali-themes/)
- [Kali Linux документация](https://www.kali.org/docs/)

### Xfce:
- [Xfce документация](https://docs.xfce.org/)
- [Arch Wiki: Xfce](https://wiki.archlinux.org/title/Xfce)

## 💡 Советы по использованию

### Для новичков:

1. **Начните с изучения горячих клавиш** - нажмите `Mod4 + S` для справки
2. **Поэкспериментируйте с раскладками** - `Mod4 + Space` для переключения
3. **Используйте несколько рабочих столов** - организуйте окна по задачам
4. **Изучите tiling режим** - это основная мощь Awesome

### Для продвинутых пользователей:

1. **Создайте свои виджеты** в `rc.lua` используя API wibox
2. **Настройте rules** для автоматического размещения приложений
3. **Добавьте кастомные сигналы** для автоматизации
4. **Интегрируйте скрипты** через `awful.spawn`

### Оптимизация производительности:

- Отключите picom если не нужна прозрачность
- Используйте `awful.spawn.once` вместо `run` в autostart.sh для уникальных процессов
- Оптимизируйте частоту обновления виджетов

## 🤝 Вклад в развитие

Pull requests приветствуются! Если у вас есть улучшения или исправления:

1. Форкните репозиторий
2. Создайте feature branch (`git checkout -b feature/amazing-feature`)
3. Закоммитьте изменения (`git commit -m 'Add some amazing feature'`)
4. Запушьте в branch (`git push origin feature/amazing-feature`)
5. Откройте Pull Request

### Что можно улучшить:

- [ ] Дополнительные виджеты (батарея, температура, сеть)
- [ ] Настраиваемые цветовые схемы
- [ ] Дополнительные раскладки окон
- [ ] Интеграция с другими DE компонентами
- [ ] Улучшенная документация
- [ ] Скрипты для автоматической установки

## 📄 Лицензия

MIT License

Copyright (c) 2024 VovaplusEXP

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 👤 Автор

**VovaplusEXP**

- GitHub: [@VovaplusEXP](https://github.com/VovaplusEXP)

## 🌟 Благодарности

- Команде Awesome WM за потрясающий оконный менеджер
- Команде Xfce за стабильные и надёжные компоненты
- Разработчикам Kali Linux за отличную тёмную тему
- Сообществу Arch Linux за подробную документацию

---

**Приятного использования AwesomeWM! 🚀**
