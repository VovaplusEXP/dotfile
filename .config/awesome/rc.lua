-- ═══════════════════════════════════════════════════════════════════════════
--  AwesomeWM конфигурация в стиле Kali Linux Xfce
--  Автор: VovaplusEXP
--  Лицензия: MIT
-- ═══════════════════════════════════════════════════════════════════════════

-- ══════════════════════════════════════════════════════════════
-- A) ИМПОРТ НЕОБХОДИМЫХ БИБЛИОТЕК
-- ══════════════════════════════════════════════════════════════

-- Если LuaRocks установлен, используем его для загрузки модулей
pcall(require, "luarocks.loader")

-- Стандартные библиотеки awesome
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Включаем горячие клавиши для Vim и других приложений
require("awful.hotkeys_popup.keys")

-- ══════════════════════════════════════════════════════════════
-- B) ОБРАБОТКА ОШИБОК
-- ══════════════════════════════════════════════════════════════

-- Обработка ошибок при запуске (например, синтаксические ошибки в конфиге)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Ошибка при запуске AwesomeWM!",
        text = awesome.startup_errors
    })
end

-- Обработка runtime ошибок (ошибки во время работы)
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Предотвращаем бесконечный цикл уведомлений об ошибках
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Произошла ошибка!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-- ══════════════════════════════════════════════════════════════
-- C) ПЕРЕМЕННЫЕ
-- ══════════════════════════════════════════════════════════════

-- Терминал (xfce4-terminal с фолбэком на alacritty)
terminal = "xfce4-terminal"
-- Проверяем доступность терминала
awful.spawn.easy_async_with_shell("which xfce4-terminal", function(stdout)
    if stdout == "" then
        terminal = "alacritty"
    end
end)

-- Редактор (mousepad или переменная окружения EDITOR)
editor = os.getenv("EDITOR") or "mousepad"
editor_cmd = terminal .. " -e " .. editor

-- Модификатор (Mod4 = Super/Windows клавиша)
modkey = "Mod4"

-- Браузер
browser = "firefox"

-- Файловый менеджер
filemanager = "thunar"

-- ══════════════════════════════════════════════════════════════
-- D) ИНИЦИАЛИЗАЦИЯ ТЕМЫ
-- ══════════════════════════════════════════════════════════════

local gfs = require("gears.filesystem")
local theme_path = gfs.get_configuration_dir() .. "theme.lua"
beautiful.init(theme_path)

-- ══════════════════════════════════════════════════════════════
-- E) LAYOUTS (РАСКЛАДКИ ОКОН)
-- ══════════════════════════════════════════════════════════════

awful.layout.layouts = {
    awful.layout.suit.tile,           -- основной тайлинг (мастер слева)
    awful.layout.suit.tile.left,      -- мастер справа
    awful.layout.suit.tile.bottom,    -- мастер сверху
    awful.layout.suit.tile.top,       -- мастер снизу
    awful.layout.suit.fair,           -- равномерное распределение
    awful.layout.suit.max,            -- максимизация (одно окно на весь экран)
    awful.layout.suit.floating,       -- плавающие окна
    awful.layout.suit.spiral.dwindle, -- спиральная раскладка
}

-- ══════════════════════════════════════════════════════════════
-- F) ВИДЖЕТЫ ДЛЯ WIBAR
-- ══════════════════════════════════════════════════════════════

-- Виджет часов с форматом: день недели, дата, время
local mytextclock = wibox.widget.textclock("%a %d %b, %H:%M")

-- Создаём виджет календаря при клике на часы
local month_calendar = awful.widget.calendar_popup.month()
month_calendar:attach(mytextclock, "tr")

-- ══════════════════════════════════════════════════════════════
-- G) TAGS (РАБОЧИЕ СТОЛЫ)
-- ══════════════════════════════════════════════════════════════

-- Создаём 9 рабочих столов на каждом мониторе
awful.screen.connect_for_each_screen(function(s)
    -- Каждый экран получает теги с именами 1-9
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)

-- ══════════════════════════════════════════════════════════════
-- H) МЕНЮ
-- ══════════════════════════════════════════════════════════════

-- Создаём главное меню приложения
myawesomemenu = {
    { "Горячие клавиши", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Документация", terminal .. " -e man awesome" },
    { "Редактор конфига", editor_cmd .. " " .. awesome.conffile },
    { "Перезагрузить", awesome.restart },
    { "Выйти", function() awesome.quit() end },
}

mymainmenu = awful.menu({
    items = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        { "Терминал", terminal },
        { "Браузер", browser },
        { "Файлы", filemanager },
        { "Поиск приложений", "xfce4-appfinder" },
    }
})

-- Лаунчер меню
mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Настройка Menubar
menubar.utils.terminal = terminal

-- ══════════════════════════════════════════════════════════════
-- I) WIBAR (ПАНЕЛЬ)
-- ══════════════════════════════════════════════════════════════

-- Создаём wibar для каждого экрана
awful.screen.connect_for_each_screen(function(s)
    -- Создаём виджет promptbox для ввода команд
    s.mypromptbox = awful.widget.prompt()
    
    -- Создаём виджет layoutbox для переключения раскладок
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function() awful.layout.inc(1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end),
        awful.button({ }, 4, function() awful.layout.inc(1) end),
        awful.button({ }, 5, function() awful.layout.inc(-1) end)
    ))
    
    -- Создаём виджет taglist (список рабочих столов)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = gears.table.join(
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end)
            -- Колёсико мыши НЕ переключает теги (по требованию пользователя)
        )
    }

    -- Создаём виджет tasklist (список окон)
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = gears.table.join(
            awful.button({ }, 1, function(c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal("request::activate", "tasklist", {raise = true})
                end
            end),
            awful.button({ }, 3, function()
                awful.menu.client_list({ theme = { width = 250 } })
            end),
            awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
        )
    }

    -- Создаём wibar (верхняя панель)
    s.mywibox = awful.wibar({ 
        position = "top", 
        screen = s,
        height = beautiful.wibar_height or 28
    })

    -- Добавляем виджеты на панель
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Левая часть
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Центр (список окон)
        { -- Правая часть
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)

-- ══════════════════════════════════════════════════════════════
-- J) ГОРЯЧИЕ КЛАВИШИ
-- ══════════════════════════════════════════════════════════════

globalkeys = gears.table.join(
    -- ═══ AWESOME ═══
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
              {description="показать горячие клавиши", group="awesome"}),
    
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "перезагрузить awesome", group = "awesome"}),
    
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
              {description = "выйти из awesome", group = "awesome"}),

    -- ═══ ЗАПУСК ПРИЛОЖЕНИЙ ═══
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
              {description = "открыть терминал", group = "приложения"}),
    
    awful.key({ modkey }, "w", function() awful.spawn(browser) end,
              {description = "открыть браузер", group = "приложения"}),
    
    awful.key({ modkey }, "e", function() awful.spawn(filemanager) end,
              {description = "открыть файловый менеджер", group = "приложения"}),
    
    awful.key({ modkey }, "r", function() 
        awful.spawn("rofi -show drun -theme ~/.config/rofi/launcher.rasi || xfce4-appfinder") 
    end,
              {description = "запустить rofi/appfinder", group = "приложения"}),
    
    awful.key({ modkey, "Shift" }, "s", function() awful.spawn("xfce4-screenshooter") end,
              {description = "сделать скриншот", group = "приложения"}),
    
    awful.key({ modkey }, "l", function() awful.spawn("xflock4") end,
              {description = "заблокировать экран", group = "приложения"}),

    -- ═══ НАВИГАЦИЯ МЕЖДУ ОКНАМИ ═══
    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end,
              {description = "фокус на следующее окно", group = "навигация"}),
    
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end,
              {description = "фокус на предыдущее окно", group = "навигация"}),
    
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
              {description = "поменять местами со следующим окном", group = "навигация"}),
    
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
              {description = "поменять местами с предыдущим окном", group = "навигация"}),

    -- ═══ ИЗМЕНЕНИЕ РАЗМЕРА МАСТЕР-ОБЛАСТИ ═══
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
              {description = "уменьшить ширину мастер-области", group = "layout"}),
    
    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
              {description = "увеличить ширину мастер-области", group = "layout"}),

    -- ═══ УПРАВЛЕНИЕ РАСКЛАДКАМИ ═══
    awful.key({ modkey }, "space", function() awful.layout.inc(1) end,
              {description = "следующая раскладка", group = "layout"}),
    
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
              {description = "предыдущая раскладка", group = "layout"}),

    -- ═══ ВОССТАНОВЛЕНИЕ МИНИМИЗИРОВАННЫХ ОКОН ═══
    awful.key({ modkey, "Control" }, "n",
              function()
                  local c = awful.client.restore()
                  if c then
                    c:emit_signal("request::activate", "key.unminimize", {raise = true})
                  end
              end,
              {description = "восстановить минимизированное окно", group = "клиент"}),

    -- ═══ MENUBAR ═══
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "показать menubar", group = "launcher"})
)

-- Горячие клавиши для клиентских окон
clientkeys = gears.table.join(
    awful.key({ modkey }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "переключить полноэкранный режим", group = "клиент"}),

    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end,
              {description = "закрыть окно", group = "клиент"}),

    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
              {description = "переключить плавающий режим", group = "клиент"}),

    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
              {description = "переместить в мастер-область", group = "клиент"}),

    awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
              {description = "переместить на другой экран", group = "клиент"}),

    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
              {description = "переключить поверх всех окон", group = "клиент"}),

    awful.key({ modkey }, "n",
        function(c)
            c.minimized = true
        end,
        {description = "минимизировать окно", group = "клиент"}),

    awful.key({ modkey }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(раз)максимизировать окно", group = "клиент"})
)

-- Привязка горячих клавиш для переключения между рабочими столами (тегами)
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- Переключиться на рабочий стол i
        awful.key({ modkey }, "#" .. i + 9,
                  function()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "переключиться на рабочий стол " .. i, group = "тег"}),
        
        -- Переместить окно на рабочий стол i
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "переместить окно на рабочий стол " .. i, group = "тег"}),
        
        -- Показать рабочий стол i дополнительно
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "показать/скрыть рабочий стол " .. i, group = "тег"}),
        
        -- Показать окно на рабочем столе i дополнительно
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "показать окно на рабочем столе " .. i, group = "тег"})
    )
end

-- ══════════════════════════════════════════════════════════════
-- K) MOUSE BINDINGS (ПРИВЯЗКИ МЫШИ)
-- ══════════════════════════════════════════════════════════════

-- Привязки мыши для клиентских окон
clientbuttons = gears.table.join(
    awful.button({ }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Привязки мыши для рабочего стола
root.buttons(gears.table.join(
    awful.button({ }, 3, function() mymainmenu:toggle() end)
    -- Колёсико мыши НЕ переключает теги (по требованию пользователя)
))

-- Устанавливаем глобальные горячие клавиши
root.keys(globalkeys)

-- ══════════════════════════════════════════════════════════════
-- L) ПРАВИЛА ДЛЯ ОКОН
-- ══════════════════════════════════════════════════════════════

awful.rules.rules = {
    -- Правило для всех окон
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Плавающие окна
    {
        rule_any = {
            instance = {
                "DTA",
                "copyq",
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",
                "Sxiv",
                "Tor Browser",
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "Xfce4-appfinder",
            },
            name = {
                "Event Tester",
            },
            role = {
                "AlarmWindow",
                "ConfigManager",
                "pop-up",
            }
        },
        properties = { floating = true }
    },

    -- Добавляем titlebars к обычным окнам и диалогам
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = true }
    },

    -- Правила для конкретных приложений
    {
        rule = { class = "Firefox" },
        properties = { screen = 1, tag = "1" }
    },
    {
        rule = { class = "Thunar", type = "dialog" },
        properties = { floating = true }
    },
}

-- ══════════════════════════════════════════════════════════════
-- M) SIGNALS (СИГНАЛЫ)
-- ══════════════════════════════════════════════════════════════

-- Сигнал при появлении нового клиента
client.connect_signal("manage", function(c)
    -- Устанавливаем новые окна как slave (не в мастер-области)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Предотвращаем появление окон вне экрана
        awful.placement.no_offscreen(c)
    end
end)

-- Добавляем titlebar для клиентских окон
client.connect_signal("request::titlebars", function(c)
    -- Кнопки для titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        { -- Левая часть
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Центр
            { -- Заголовок
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Правая часть
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Фокус следует за мышью
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- Изменение цвета границы при фокусе
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- ══════════════════════════════════════════════════════════════
-- N) AUTOSTART (АВТОЗАПУСК)
-- ══════════════════════════════════════════════════════════════

-- Запускаем скрипт автозапуска
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
