-- ═══════════════════════════════════════════════════════════════════════════
--  AwesomeWM тема в стиле Kali-Dark
--  Основана на палитре Kali Linux с тёмно-синими акцентами
--  Автор: VovaplusEXP
--  Лицензия: MIT
-- ═══════════════════════════════════════════════════════════════════════════

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

-- ══════════════════════════════════════════════════════════════
-- A) ЦВЕТА (Kali Linux палитра)
-- ══════════════════════════════════════════════════════════════

-- Основные цвета фона
theme.bg_normal     = "#2b2b2b"  -- Тёмно-серый фон панели
theme.bg_focus      = "#367bf0"  -- Ярко-синий Kali (фокус)
theme.bg_urgent     = "#f0544c"  -- Красный для urgent окон
theme.bg_minimize   = "#1c1c1c"  -- Очень тёмный фон для минимизированных
theme.bg_systray    = theme.bg_normal

-- Цвета текста
theme.fg_normal     = "#e8e8e8"  -- Светло-серый текст
theme.fg_focus      = "#ffffff"  -- Белый текст для фокуса
theme.fg_urgent     = "#ffffff"  -- Белый текст на красном фоне
theme.fg_minimize   = "#888888"  -- Серый для минимизированных

-- ══════════════════════════════════════════════════════════════
-- B) ГРАНИЦЫ ОКОН
-- ══════════════════════════════════════════════════════════════

theme.useless_gap   = dpi(4)     -- Отступ между окнами (4 пикселя)
theme.border_width  = dpi(2)     -- Толщина границы окна (2 пикселя)
theme.border_normal = "#1c1c1c"  -- Тёмная граница для обычных окон
theme.border_focus  = "#367bf0"  -- Синяя граница для окна в фокусе
theme.border_marked = "#f0544c"  -- Красная граница для помеченных окон

-- ══════════════════════════════════════════════════════════════
-- C) ШРИФТЫ
-- ══════════════════════════════════════════════════════════════

theme.font          = "Noto Sans 10"
theme.taglist_font  = "Noto Sans Bold 10"

-- ══════════════════════════════════════════════════════════════
-- D) ИКОНКИ
-- ══════════════════════════════════════════════════════════════

theme.icon_theme = "Flat-Remix-Blue-Dark"

-- ══════════════════════════════════════════════════════════════
-- E) WIBAR (ПАНЕЛЬ)
-- ══════════════════════════════════════════════════════════════

theme.wibar_height = dpi(28)
theme.wibar_bg = theme.bg_normal
theme.wibar_fg = theme.fg_normal

-- Цвета для taglist (список рабочих столов)
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_fg_focus = theme.fg_focus
theme.taglist_bg_occupied = "#3a3a3a"
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_empty = "#666666"
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_fg_urgent = theme.fg_urgent

-- Цвета для tasklist (список окон)
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_fg_normal = theme.fg_normal
theme.tasklist_bg_minimize = theme.bg_minimize
theme.tasklist_fg_minimize = theme.fg_minimize
theme.tasklist_bg_urgent = theme.bg_urgent
theme.tasklist_fg_urgent = theme.fg_urgent

-- ══════════════════════════════════════════════════════════════
-- F) TITLEBAR (ЗАГОЛОВОК ОКНА)
-- ══════════════════════════════════════════════════════════════

theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus  = theme.fg_focus
theme.titlebar_fg_normal = theme.fg_normal

-- Генерируем иконки для titlebar
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- ══════════════════════════════════════════════════════════════
-- G) NOTIFICATION (УВЕДОМЛЕНИЯ)
-- ══════════════════════════════════════════════════════════════

theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_color = theme.border_focus
theme.notification_border_width = dpi(2)
theme.notification_icon_size = dpi(64)
theme.notification_opacity = 0.9
theme.notification_max_width = dpi(400)
theme.notification_max_height = dpi(200)

-- ══════════════════════════════════════════════════════════════
-- H) MENU (МЕНЮ)
-- ══════════════════════════════════════════════════════════════

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(24)
theme.menu_width  = dpi(200)
theme.menu_bg_normal = theme.bg_normal
theme.menu_bg_focus = theme.bg_focus
theme.menu_fg_normal = theme.fg_normal
theme.menu_fg_focus = theme.fg_focus
theme.menu_border_color = theme.border_focus
theme.menu_border_width = dpi(1)

-- ══════════════════════════════════════════════════════════════
-- I) WALLPAPER (ОБОИ) - опционально
-- ══════════════════════════════════════════════════════════════

-- Раскомментируйте если хотите установить обои через awesome
-- theme.wallpaper = gfs.get_configuration_dir() .. "wallpaper.jpg"

-- Или используйте цвет фона вместо обоев
theme.bg_normal = "#1a1a1a"

-- ══════════════════════════════════════════════════════════════
-- ДОПОЛНИТЕЛЬНЫЕ НАСТРОЙКИ
-- ══════════════════════════════════════════════════════════════

-- Иконка awesome для меню
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Иконки для layoutbox (индикатора раскладки)
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Генерация taglist квадратов
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_focus
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Настройка hotkeys (всплывающая подсказка горячих клавиш)
theme.hotkeys_bg = theme.bg_normal
theme.hotkeys_fg = theme.fg_normal
theme.hotkeys_border_width = theme.border_width
theme.hotkeys_border_color = theme.border_focus
theme.hotkeys_modifiers_fg = "#367bf0"
theme.hotkeys_label_bg = "#1c1c1c"
theme.hotkeys_label_fg = theme.fg_normal
theme.hotkeys_font = theme.font
theme.hotkeys_description_font = theme.font
theme.hotkeys_group_margin = dpi(20)

return theme
