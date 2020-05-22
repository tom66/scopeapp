import ZynqScope.ZynqScope as zs

zsobj = zs.ZynqScope(2048, 12)

print("")
print("*** Supported Timebases ***")
tb_list = zsobj.get_supported_timebases()
print(tb_list)

for idx, item in enumerate(tb_list):
    print("")
    print("*** Change timebase to %d ***" % idx)
    zsobj.set_next_timebase(idx)
    print("")