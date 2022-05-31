import json, pathlib, os

#get what to replace
with open('/home/mwglen/.config/conky/sysinfo-raw.lua') as conf:
    f = conf.read()
lines = f.split('\n')
confs = [l for l in lines if "WALM" in l]

pairs = []
for l in confs:
    p = l.split(' ')
    pairs.append((p[2],p[3]))

print(pairs)

#getting colors from wal
h = pathlib.Path.home()
usr = str(h).split('/')[-1]
cols_path = os.path.join(h, '.cache/wal/colors.json')
fp_colors = open(cols_path)
wal_cols = json.load(fp_colors)

col_map = {**wal_cols['special'], **wal_cols['colors']}

#start replacing
for p in pairs:
    #getting the key from the pairs
    key = p[0]
    new_val = col_map[key].replace('#',"").upper()
    #replacing it inefficiently
    f = f.replace(p[1],new_val)

with open('/home/mwglen/.config/conky/sysinfo.lua', 'w') as conf:
    conf.write(f)
