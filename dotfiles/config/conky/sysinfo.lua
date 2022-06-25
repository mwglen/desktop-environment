conky.config = {
   -- Window Properties
   own_window             = true,
   own_window_type        = 'desktop',
   own_window_class       = 'Conky',
   own_window_title       = 'Sysinfo Conky',
   own_window_hints       =
      'undecorated,below,above,sticky,skip_taskbar,skip_pager',
   own_window_colour      = '0A0409',
   own_window_argb_value  = 255,
   own_window_argb_visual = true,
   own_window_transparent = false,

   -- XFT
   use_xft  = true,
   font     = 'RobotoMono Nerd Font:size=9',
   xftalpha = 0.1,

   -- Size & Alignment
   maximum_width   = 315,
   minimum_width   = 315,
   minimum_height  = 935,
   alignment       = 'top_left',
   gap_x           = 35,
   gap_y           = 35,
   update_interval = 1.0,

   -- Shades & Borders
   draw_graph_borders    = false,
   draw_shades           = true,
   default_shade_color   = '0A0409',
    
   -- Misc
   override_utf8_locale = true,
   cpu_avg_samples      = 2,
   net_avg_samples      = 1,
   double_buffer    = true,
   
    -- Colors
    color0     = '0A0409', -- Black: Same as Background
    color1     = '9B2E33', -- Primary Color
    color2     = 'C9473A', -- Secondary Color: Horizontal Rules
    color3     = '99374F', -- Ternary Color
    color4     = 'B14856', -- Bar/Graph Colors
    color5     = 'B5BD68', -- Positive Color
    color6     = 'C19267', -- Warning Color
    color7     = '6B6B6B'  -- Critical Color
}

--- WALM color0 0A0409
--- WALM color1 9B2E33
--- WALM color2 C9473A
--- WALM color3 99374F
--- WALM color4 B14856

adp = 'BAT0'

function conky_format(format, number)
   return string.format(format, conky_parse(number))
end

function reset_font()
   return '${font ' .. conky.config.font .. '}${color1}'
end

function h1(name)
   return '${font RobotoMono Nerd Font:bold:size=10}${color2}\n' ..
      name .. ' ${color2}${hr 2}' .. reset_font() .. '\n'
end

clock_module = [[
${font RobotoMono Nerd Font:size=12}${color1}\
${time %A %d %B}
${font RobotoMono Nerd Font:size=70}${color1}\
${time %H:%M}\
]] .. reset_font() .. '\n\n' .. [[
${texeci 500 curl 'wttr.in/Raleigh?format=%C+%t+(%f)+%m'}
${texeci 500 curl 'wttr.in/Raleigh?format=Sunrise+%S+Sunset+%s'}
]]

system_info_module =
   h1('SYSTEM INFO') .. [[
$nodename 
Operating System:$alignr${execi 999999 lsb_release -ds |  tr -d \"}
Kernel:$alignr$sysname $kernel
Architecture:$alignr $machine
Uptime: $alignr${uptime}
Temp: ${alignr}${acpitemp}C
]]

drives_module =
   h1('STORAGE') .. [[
${color4}${fs_bar 10 /}${color1}
${fs_used /} / ${fs_size /} ${alignr} ${fs_used_perc}%
]]

battery_module =
   h1('BATTERY') .. adp .. [[
${alignr}${execi 60 acpi | grep -Eo '\w+,' | grep -Eo '\w+'}
${color4}${battery_bar 10}
]] .. reset_font() .. [[
${battery_percent}% ${alignr}Time Remaining: ${execi 60 acpi | grep -Eo '(:?[0-9]+){3}'}
]]

cpu_module =
   h1('CPU') .. [[
${execi 999999 cat /proc/cpuinfo | grep -m 1 'model name' | cut -d' ' -f3-}
${color4}${cpubar 10,}${color1}
${freq_g cpu0}Ghz${alignr}${cpu}%
]]

memory_module =
   h1('MEMORY') .. [[
${color4}${membar 10,}${color1}
$mem / $memmax $alignr $memperc%
]]

swap_module =
   h1('SWAP') .. [[
${color4}${swapbar 10,}${color1}
${swap} / ${swapmax}${alignr}${swapperc}%
]]

function proc(num)
   mod_font = '${font RobotoMono Nerd Font:size=8}'
   proc_name = '${color1}${top name ' .. num .. '}'
   proc_cpu  = '${color2}${goto 105}${top cpu ' .. num .. '}%'
   proc_mem  = '${color1}${goto 160}${top_mem name ' .. num .. '}'
   proc_memp = '${color2}${alignr}${top_mem mem_res ' .. num .. '}\n'
   return mod_font .. proc_name .. proc_cpu .. proc_mem .. proc_memp
end
processes_module =
   h1('PROCESSES') ..
   'CPU${goto 160}RAM\n' ..
   proc(1) ..
   proc(2) ..
   proc(3) ..
   proc(4) ..
   proc(5) ..
   proc(6) ..
   proc(7) ..
   proc(8) ..
   proc(9)

conky.text =
   clock_module       ..
   system_info_module ..
   battery_module     ..
   cpu_module         ..
   drives_module      ..
   memory_module      ..
   swap_module        ..
   processes_module
