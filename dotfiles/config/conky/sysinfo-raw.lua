conky.config = {
   -- Window Properties
   own_window             = true,
   own_window_type        = 'desktop',
   own_window_class       = 'Conky',
   own_window_title       = 'Sysinfo Conky',
   own_window_hints       =
      'undecorated,below,above,sticky,skip_taskbar,skip_pager',
   own_window_colour      = '000000',
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
   minimum_height  = 930,
   alignment       = 'top_left',
   gap_x           = 35,
   gap_y           = 35,
   update_interval = 1.0,

   -- Shades & Borders
   draw_graph_borders    = false,
   draw_shades           = true,
   default_shade_color   = '000000',
    
   -- Misc
   override_utf8_locale = true,
   cpu_avg_samples      = 2,
   net_avg_samples      = 1,

   total_run_times  = 0,
   double_buffer    = true,
   no_buffers       = true,
   use_spacer       = 'left',
   text_buffer_size = 256,
   
    -- Colors
    color0     = '000000', -- Black: Same as Background
    color1     = 'B294BB', -- Primary Color
    color2     = 'B4C3CA', -- Secondary Color: Horizontal Rules
    color3     = '81A2BE', -- Ternary Color
    color4     = '3DAEE9', -- Bar/Graph Colors
    color5     = 'B5BD68', -- Positive Color
    color6     = 'C19267', -- Warning Color
    color7     = '6B6B6B'  -- Critical Color
}

--- WALM color1 B294BB
--- WALM color2 B4C3CA
--- WALM color3 81A2BE
--- WALM color4 3DAEE9

adp = 'BAT0'

function reset_font()
   return '${font ' .. conky.config.font .. '}${color1}'
end

function h1(name)
   return '${font RobotoMono Nerd Font:bold:size=10}${color2}\n' ..
      name .. '${color2}${hr 2}' .. reset_font() .. '\n'
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
#Load: ${color}${alignr}${loadavg}
]]

drives_module =
   h1('DRIVES') .. [[
/ $alignr ${fs_used /} / ${fs_size /} 
${color4}${fs_bar 10 /}
${color1}READ ${diskio_read /dev/nvme0n1p3} $alignr ${color1} WRITE ${diskio_write /dev/nvme0n1p3}
]]

battery_module =
   h1('BATTERY') .. adp .. [[
${alignr}${font Noto Sans UI:size=6}${font}${execi 60 acpi | grep -Eo '\w+,' | grep -Eo '\w+'}
${color green}${voffset 2}${if_match ${battery_percent}<=20}${color7}${battery_bar 10}${else}${if_match ${battery_percent}<=50}${color6}${battery_bar 10}${else}${if_match ${battery_percent}<=90}${color5}${battery_bar 10}${else}${if_match ${battery_percent}>90}${color4}${battery_bar 10}${endif}${endif}${endif}${endif}
]] .. reset_font() .. [[
${battery_percent}% ${alignr}Time Remaining: ${execi 60 acpi | grep -Eo '(:?[0-9]+){3}'}
]]
   -- h2(adp, [[${execi 60 acpi | grep -Eo '\w+,' | grep -Eo '\w+'}]])

cpu_module =
   h1('CPU') .. [[
${execi 999999 cat /proc/cpuinfo | grep -m 1 'model name' | cut -d' ' -f3-}
${color green}${if_match ${cpu}<=50}${color4}${cpubar 10,} ${else}${if_match ${cpu}<=70}${color5}${cpubar 10,} ${else}${if_match ${cpu}<=90}${color6}${cpubar 10,} ${else}${if_match ${cpu}>90}${color7}${cpubar 10,}${endif}${endif}${endif}${endif}$color1
${freq_g cpu0}Ghz${alignr}${cpu}%
]]

memory_module =
   h1('MEMORY') .. [[
#${execi 999999 dmidecode --type 17 | grep -m 1 "Type:" | cut -d' ' -f2-} $alignc $mem / $memmax $alignr $memperc%
DDR4 $alignc $mem / $memmax $alignr $memperc%
${color green}${if_match ${memperc}<=50}${color4}${membar 10,} ${else}${if_match ${memperc}<=70}${color5}${membar 10,} ${else}${if_match ${memperc}<=90}${color6}${membar 10,} ${else}${if_match ${memperc}>90}${color7}${membar 10,}${endif}${endif}${endif}${endif}${color}
]]

swap_module =
   h1('SWAP') .. [[
$swap / $swapmax $alignr $swapperc%
${color green}${if_match ${swapperc}<=50}${color4}${swapbar 10,} ${else}${if_match ${swapperc}<=70}${color5}${swapbar 10,} ${else}${if_match ${swapperc}<=90}${color6}${swapbar 10,} ${else}${if_match ${swapperc}>90}${color7}${swapbar 10,}${endif}${endif}${endif}${endif}${color}
]]

function proc(num)
   proc_name = '$font$color1${top name ' .. num .. '}'
   proc_cpu  = '$color2${goto 110}${top cpu ' .. num .. '}%'
   proc_mem  = '$color1${goto 165}${top_mem name ' .. num .. '}'
   proc_memp = '$color2${goto 270}${top_mem mem_res ' .. num .. '}\n'
   return proc_name .. proc_cpu .. proc_mem .. proc_memp
end
processes_module =
   h1('PROCESSES') ..
   '${font}CPU${goto 165}RAM\n' ..
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
   drives_module      ..
   cpu_module         ..
   memory_module      ..
   swap_module        ..
   processes_module
