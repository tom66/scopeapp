import ZynqScope.ZynqScope as zs

# Test base zsobj
zsobj = zs.ZynqScope(2048, 12)
zsobj.connect()

print("")
print("*** Supported Timebases ***")
tb_list = zsobj.get_supported_timebases()
print(tb_list)

for idx, item in enumerate(tb_list):
    print("")
    print("*** Change timebase to %d with zero pre-time and auto memory depth ***" % idx)
    zsobj.set_next_timebase(idx)
    zsobj.setup_for_timebase(0)
    print("")

    