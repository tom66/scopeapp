	.arch armv6
	.eabi_attribute 28, 1	@ Tag_ABI_VFP_args
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 2	@ Tag_ABI_enum_size
	.eabi_attribute 30, 2	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"armwave.c"
@ GNU C17 (Raspbian 8.3.0-6+rpi1) version 8.3.0 (arm-linux-gnueabihf)
@	compiled by GNU C version 8.3.0, GMP version 6.1.2, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.20-GMP

@ GGC heuristics: --param ggc-min-expand=81 --param ggc-min-heapsize=95638
@ options passed:  -I /usr/local/include/python3.8 -imultilib .
@ -imultiarch arm-linux-gnueabihf armwave.c -mfloat-abi=hard -mfpu=vfp
@ -mtls-dialect=gnu -marm -march=armv6+fp -auxbase-strip armwave.s -g -O3
@ -fverbose-asm -fwrapv
@ options enabled:  -faggressive-loop-optimizations -falign-jumps
@ -falign-labels -falign-loops -fauto-inc-dec -fbranch-count-reg
@ -fcaller-saves -fchkp-check-incomplete-type -fchkp-check-read
@ -fchkp-check-write -fchkp-instrument-calls -fchkp-narrow-bounds
@ -fchkp-optimize -fchkp-store-bounds -fchkp-use-static-bounds
@ -fchkp-use-static-const-bounds -fchkp-use-wrappers -fcode-hoisting
@ -fcombine-stack-adjustments -fcommon -fcompare-elim -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop
@ -fdelete-null-pointer-checks -fdevirtualize -fdevirtualize-speculatively
@ -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-types
@ -fexpensive-optimizations -fforward-propagate -ffp-int-builtin-inexact
@ -ffunction-cse -fgcse -fgcse-after-reload -fgcse-lm -fgnu-runtime
@ -fgnu-unique -fguess-branch-probability -fhoist-adjacent-loads -fident
@ -fif-conversion -fif-conversion2 -findirect-inlining -finline
@ -finline-atomics -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-cp-clone -fipa-icf
@ -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
@ -fipa-ra -fipa-reference -fipa-sra -fipa-vrp -fira-hoist-pressure
@ -fira-share-save-slots -fira-share-spill-slots
@ -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
@ -fleading-underscore -flifetime-dse -floop-interchange
@ -floop-unroll-and-jam -flra-remat -flto-odr-type-merging -fmath-errno
@ -fmerge-constants -fmerge-debug-strings -fmove-loop-invariants
@ -fomit-frame-pointer -foptimize-sibling-calls -foptimize-strlen
@ -fpartial-inlining -fpeel-loops -fpeephole -fpeephole2 -fplt
@ -fpredictive-commoning -fprefetch-loop-arrays -freg-struct-return
@ -freorder-blocks -freorder-functions -frerun-cse-after-loop
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-pressure -fsched-rank-heuristic -fsched-spec
@ -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-insns
@ -fschedule-insns2 -fsection-anchors -fsemantic-interposition
@ -fshow-column -fshrink-wrap -fshrink-wrap-separate -fsigned-zeros
@ -fsplit-ivs-in-unroller -fsplit-loops -fsplit-paths -fsplit-wide-types
@ -fssa-backprop -fssa-phiopt -fstdarg-opt -fstore-merging
@ -fstrict-aliasing -fstrict-volatile-bitfields -fsync-libcalls
@ -fthread-jumps -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
@ -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
@ -ftree-copy-prop -ftree-cselim -ftree-dce -ftree-dominator-opts
@ -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-distribute-patterns
@ -ftree-loop-distribution -ftree-loop-if-convert -ftree-loop-im
@ -ftree-loop-ivcanon -ftree-loop-optimize -ftree-loop-vectorize
@ -ftree-parallelize-loops= -ftree-partial-pre -ftree-phiprop -ftree-pre
@ -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink
@ -ftree-slp-vectorize -ftree-slsr -ftree-sra -ftree-switch-conversion
@ -ftree-tail-merge -ftree-ter -ftree-vrp -funit-at-a-time -funswitch-loops
@ -fvar-tracking -fvar-tracking-assignments -fverbose-asm -fwrapv
@ -fzero-initialized-in-bss -marm -mbe32 -mglibc -mlittle-endian
@ -mpic-data-is-text-relative -msched-prolog -munaligned-access
@ -mvectorize-with-neon-quad

	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_setup_render.constprop.0, %function
armwave_setup_render.constprop.0:
.LVL0:
.LFB74:
	.file 1 "armwave.c"
	.loc 1 98 6 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 100 5 view .LVU1
	.loc 1 101 5 view .LVU2
	.loc 1 103 5 view .LVU3
	.loc 1 106 5 view .LVU4
@ armwave.c:98: void armwave_setup_render(uint8_t *wave_buffer, uint32_t start_point, uint32_t end_point, uint32_t waves, uint32_t wave_stride, uint32_t target_width, uint32_t target_height, uint32_t render_flags)
	.loc 1 98 6 is_stmt 0 view .LVU5
	push	{r4, r5, r6, lr}	@
	.cfi_def_cfa_offset 16
	.cfi_offset 4, -16
	.cfi_offset 5, -12
	.cfi_offset 6, -8
	.cfi_offset 14, -4
@ armwave.c:109:     assert(target_height == 256 || target_height == 512 || target_height == 1024 || target_height == 2048);
	.loc 1 109 5 view .LVU6
	sub	r2, r1, #256	@ tmp143, target_height,
@ armwave.c:106:     g_armwave_state.wave_buffer = wave_buffer;
	.loc 1 106 33 view .LVU7
	ldr	r4, .L21+8	@ tmp213,
	ldr	r3, .L21+12	@ tmp142,
@ armwave.c:109:     assert(target_height == 256 || target_height == 512 || target_height == 1024 || target_height == 2048);
	.loc 1 109 5 view .LVU8
	bics	r2, r2, #256	@ tmp215, tmp143,
@ armwave.c:98: void armwave_setup_render(uint8_t *wave_buffer, uint32_t start_point, uint32_t end_point, uint32_t waves, uint32_t wave_stride, uint32_t target_width, uint32_t target_height, uint32_t render_flags)
	.loc 1 98 6 view .LVU9
	vpush.64	{d8}	@
	.cfi_def_cfa_offset 24
	.cfi_offset 80, -24
	.cfi_offset 81, -20
@ armwave.c:98: void armwave_setup_render(uint8_t *wave_buffer, uint32_t start_point, uint32_t end_point, uint32_t waves, uint32_t wave_stride, uint32_t target_width, uint32_t target_height, uint32_t render_flags)
	.loc 1 98 6 view .LVU10
	mov	r5, r0	@ target_width, target_width
@ armwave.c:106:     g_armwave_state.wave_buffer = wave_buffer;
	.loc 1 106 33 view .LVU11
	str	r3, [r4, #20]	@ tmp142, g_armwave_state.wave_buffer
	.loc 1 109 5 is_stmt 1 view .LVU12
	beq	.L2		@,
	sub	r3, r1, #1024	@ tmp145, target_height,
	bics	r3, r3, #1024	@ tmp216, tmp145,
	bne	.L17		@,
	.loc 1 114 12 view .LVU13
	.loc 1 117 12 view .LVU14
@ armwave.c:117:     } else if(target_height == 1024) {
	.loc 1 117 14 is_stmt 0 view .LVU15
	cmp	r1, #1024	@ target_height,
	beq	.L18		@,
	.loc 1 120 12 is_stmt 1 view .LVU16
@ armwave.c:120:     } else if(target_height == 2048) {
	.loc 1 120 14 is_stmt 0 view .LVU17
	cmp	r1, #2048	@ target_height,
	.loc 1 121 9 is_stmt 1 view .LVU18
@ armwave.c:121:         g_armwave_state.row_shift = 11;
	.loc 1 121 35 is_stmt 0 view .LVU19
	moveq	r2, #11	@ tmp165,
	ldreq	r3, .L21+16	@ tmp163,
	strdeq	r2, [r4, #68]	@, tmp213,
	.loc 1 122 9 is_stmt 1 view .LVU20
.L5:
	.loc 1 126 5 view .LVU21
@ armwave.c:130:     g_armwave_state.size = target_height * target_width;
	.loc 1 130 42 is_stmt 0 view .LVU22
	mul	r2, r5, r1	@ tmp174, target_width, target_height
@ armwave.c:132:     g_armwave_state.ch_buff_size = g_armwave_state.bitdepth_height * target_width;
	.loc 1 132 68 view .LVU23
	lsl	r3, r5, #8	@ _11, target_width,
@ armwave.c:127:     g_armwave_state.vscale = target_height / 256;
	.loc 1 127 44 view .LVU24
	lsr	r0, r1, #8	@ tmp168, target_height,
.LVL1:
@ armwave.c:126:     g_armwave_state.xstride = target_height;
	.loc 1 126 29 view .LVU25
	str	r1, [r4, #24]	@ target_height, g_armwave_state.xstride
	.loc 1 127 5 is_stmt 1 view .LVU26
@ armwave.c:134:     g_armwave_state.target_height = target_height;
	.loc 1 134 35 is_stmt 0 view .LVU27
	str	r1, [r4, #64]	@ target_height, g_armwave_state.target_height
@ armwave.c:130:     g_armwave_state.size = target_height * target_width;
	.loc 1 130 26 view .LVU28
	str	r2, [r4, #56]	@ tmp174, g_armwave_state.size
@ armwave.c:136:     printf("ch_buff_size=%d\n", g_armwave_state.ch_buff_size);
	.loc 1 136 5 view .LVU29
	mov	r1, r3	@, _11
.LVL2:
@ armwave.c:128:     g_armwave_state.wave_stride = wave_stride;
	.loc 1 128 33 view .LVU30
	mov	r2, #2048	@ tmp170,
@ armwave.c:127:     g_armwave_state.vscale = target_height / 256;
	.loc 1 127 28 view .LVU31
	str	r0, [r4, #28]	@ tmp168, g_armwave_state.vscale
	.loc 1 128 5 is_stmt 1 view .LVU32
@ armwave.c:129:     g_armwave_state.waves = waves;
	.loc 1 129 27 is_stmt 0 view .LVU33
	mov	r6, #64	@ tmp172,
@ armwave.c:132:     g_armwave_state.ch_buff_size = g_armwave_state.bitdepth_height * target_width;
	.loc 1 132 34 view .LVU34
	str	r3, [r4, #52]	@ _11, g_armwave_state.ch_buff_size
@ armwave.c:136:     printf("ch_buff_size=%d\n", g_armwave_state.ch_buff_size);
	.loc 1 136 5 view .LVU35
	ldr	r0, .L21+20	@,
@ armwave.c:131:     g_armwave_state.bitdepth_height = 256;  // Always 256 possible levels in 8-bit mode
	.loc 1 131 37 view .LVU36
	mov	r3, #256	@ tmp176,
@ armwave.c:133:     g_armwave_state.target_width = target_width;
	.loc 1 133 34 view .LVU37
	str	r5, [r4, #60]	@ target_width, g_armwave_state.target_width
@ armwave.c:128:     g_armwave_state.wave_stride = wave_stride;
	.loc 1 128 33 view .LVU38
	str	r2, [r4, #32]	@ tmp170, g_armwave_state.wave_stride
	.loc 1 129 5 is_stmt 1 view .LVU39
@ armwave.c:129:     g_armwave_state.waves = waves;
	.loc 1 129 27 is_stmt 0 view .LVU40
	str	r6, [r4, #36]	@ tmp172, g_armwave_state.waves
	.loc 1 130 5 is_stmt 1 view .LVU41
	.loc 1 131 5 view .LVU42
@ armwave.c:131:     g_armwave_state.bitdepth_height = 256;  // Always 256 possible levels in 8-bit mode
	.loc 1 131 37 is_stmt 0 view .LVU43
	str	r3, [r4, #40]	@ tmp176, g_armwave_state.bitdepth_height
	.loc 1 132 5 is_stmt 1 view .LVU44
	.loc 1 133 5 view .LVU45
	.loc 1 134 5 view .LVU46
	.loc 1 136 5 view .LVU47
	bl	printf		@
.LVL3:
	.loc 1 141 5 view .LVU48
@ armwave.c:143:     if(g_armwave_state.ch1_buffer != NULL)
	.loc 1 143 23 is_stmt 0 view .LVU49
	ldr	r0, [r4, #4]	@ _12, g_armwave_state.ch1_buffer
@ armwave.c:141:     g_armwave_state.slice_height = 64;  
	.loc 1 141 34 view .LVU50
	str	r6, [r4, #44]	@ tmp172, g_armwave_state.slice_height
	.loc 1 143 5 is_stmt 1 view .LVU51
@ armwave.c:143:     if(g_armwave_state.ch1_buffer != NULL)
	.loc 1 143 7 is_stmt 0 view .LVU52
	cmp	r0, #0	@ _12,
	beq	.L7		@,
	.loc 1 144 9 is_stmt 1 view .LVU53
	bl	free		@
.LVL4:
.L7:
	.loc 1 146 5 view .LVU54
@ armwave.c:146:     g_armwave_state.ch1_buffer = calloc(g_armwave_state.ch_buff_size, 1);
	.loc 1 146 34 is_stmt 0 view .LVU55
	mov	r1, #1	@,
	ldr	r0, [r4, #52]	@, g_armwave_state.ch_buff_size
	bl	calloc		@
.LVL5:
@ armwave.c:148:     assert(g_armwave_state.ch1_buffer != NULL);
	.loc 1 148 5 view .LVU56
	cmp	r0, #0	@ tmp186,
@ armwave.c:146:     g_armwave_state.ch1_buffer = calloc(g_armwave_state.ch_buff_size, 1);
	.loc 1 146 32 view .LVU57
	str	r0, [r4, #4]	@ tmp186, g_armwave_state.ch1_buffer
	.loc 1 148 5 is_stmt 1 view .LVU58
	beq	.L19		@,
	.loc 1 151 5 view .LVU59
.LVL6:
	.loc 1 152 5 view .LVU60
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 34 is_stmt 0 view .LVU61
	vmov	s15, r5	@ int	@ target_width, target_width
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 22 view .LVU62
	vldr.32	s13, .L21	@ tmp192,
@ armwave.c:154:     g_armwave_state.xcoord_to_xpixel = malloc(length * sizeof(uint16_t));
	.loc 1 154 40 view .LVU63
	mov	r0, #4096	@,
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 34 view .LVU64
	vcvt.f32.u32	s14, s15	@ tmp191, target_width
@ armwave.c:153:     g_armwave_state.slice_record_height = points_per_pixel * g_armwave_state.slice_height;
	.loc 1 153 60 view .LVU65
	vldr.32	s15, [r4, #44]	@ int	@ tmp218, g_armwave_state.slice_height
	vcvt.f32.u32	s15, s15	@ tmp195, tmp218
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 22 view .LVU66
	vdiv.f32	s16, s13, s14	@ points_per_pixel, tmp192, tmp191
.LVL7:
	.loc 1 153 5 is_stmt 1 view .LVU67
@ armwave.c:153:     g_armwave_state.slice_record_height = points_per_pixel * g_armwave_state.slice_height;
	.loc 1 153 60 is_stmt 0 view .LVU68
	vmul.f32	s15, s15, s16	@ tmp197, tmp195, points_per_pixel
@ armwave.c:153:     g_armwave_state.slice_record_height = points_per_pixel * g_armwave_state.slice_height;
	.loc 1 153 41 view .LVU69
	vcvt.u32.f32	s15, s15	@ tmp198, tmp197
	vstr.32	s15, [r4, #48]	@ int	@ tmp198, g_armwave_state.slice_record_height
	.loc 1 154 5 is_stmt 1 view .LVU70
@ armwave.c:154:     g_armwave_state.xcoord_to_xpixel = malloc(length * sizeof(uint16_t));
	.loc 1 154 40 is_stmt 0 view .LVU71
	bl	malloc		@
.LVL8:
@ armwave.c:156:     assert(g_armwave_state.xcoord_to_xpixel != NULL);
	.loc 1 156 5 view .LVU72
	cmp	r0, #0	@ tmp199,
@ armwave.c:154:     g_armwave_state.xcoord_to_xpixel = malloc(length * sizeof(uint16_t));
	.loc 1 154 38 view .LVU73
	str	r0, [r4, #104]	@ tmp199, g_armwave_state.xcoord_to_xpixel
	.loc 1 156 5 is_stmt 1 view .LVU74
	beq	.L20		@,
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 54 is_stmt 0 view .LVU75
	vldr.32	s15, .L21+4	@ tmp204,
	sub	r0, r0, #2	@ ivtmp.30, tmp199,
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 12 view .LVU76
	mov	r3, #0	@ xx,
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 54 view .LVU77
	vdiv.f32	s14, s15, s16	@ _25, tmp204, points_per_pixel
.L10:
.LVL9:
	.loc 1 159 9 is_stmt 1 view .LVU78
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 74 is_stmt 0 view .LVU79
	vmov	s15, r3	@ int	@ xx, xx
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 32 view .LVU80
	add	r3, r3, #1	@ xx, xx,
.LVL10:
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 5 view .LVU81
	cmp	r3, #2048	@ xx,
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 74 view .LVU82
	vcvt.f32.s32	s15, s15	@ tmp205, xx
	vmul.f32	s15, s15, s14	@ tmp206, tmp205, _25
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 46 view .LVU83
	vcvt.u32.f32	s15, s15	@ tmp207, tmp206
	vmov	r2, s15	@ int	@ tmp207, tmp207
	strh	r2, [r0, #2]!	@ movhi	@ tmp207, MEM[base: _6, offset: 0B]
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 5 view .LVU84
	bne	.L10		@,
	.loc 1 164 5 is_stmt 1 view .LVU85
@ armwave.c:164:     g_armwave_state.out_pixbuf = malloc(sizeof(uint32_t) * g_armwave_state.size);
	.loc 1 164 34 is_stmt 0 view .LVU86
	ldr	r0, [r4, #56]	@ g_armwave_state.size, g_armwave_state.size
	lsl	r0, r0, #2	@, g_armwave_state.size,
	bl	malloc		@
.LVL11:
@ armwave.c:165: }
	.loc 1 165 1 view .LVU87
	vldm	sp!, {d8}	@
	.cfi_remember_state
	.cfi_restore 80
	.cfi_restore 81
	.cfi_def_cfa_offset 16
.LVL12:
@ armwave.c:164:     g_armwave_state.out_pixbuf = malloc(sizeof(uint32_t) * g_armwave_state.size);
	.loc 1 164 32 view .LVU88
	str	r0, [r4, #76]	@, g_armwave_state.out_pixbuf
@ armwave.c:165: }
	.loc 1 165 1 view .LVU89
	pop	{r4, r5, r6, pc}	@
.LVL13:
.L2:
	.cfi_restore_state
	.loc 1 111 5 is_stmt 1 view .LVU90
@ armwave.c:111:     if(target_height == 256) {
	.loc 1 111 7 is_stmt 0 view .LVU91
	cmp	r1, #256	@ target_height,
	.loc 1 112 9 is_stmt 1 view .LVU92
@ armwave.c:113:         g_armwave_state.row_mask = 0x0ff;
	.loc 1 113 34 is_stmt 0 view .LVU93
	moveq	r2, #8	@ tmp151,
@ armwave.c:115:         g_armwave_state.row_shift = 9;
	.loc 1 115 35 view .LVU94
	ldrne	r3, .L21+24	@ tmp155,
@ armwave.c:113:         g_armwave_state.row_mask = 0x0ff;
	.loc 1 113 34 view .LVU95
	moveq	r3, #255	@ tmp153,
	.loc 1 114 12 is_stmt 1 view .LVU96
	.loc 1 115 9 view .LVU97
@ armwave.c:115:         g_armwave_state.row_shift = 9;
	.loc 1 115 35 is_stmt 0 view .LVU98
	movne	r2, #9	@ tmp157,
	strd	r2, [r4, #68]	@, tmp213,
	.loc 1 116 9 is_stmt 1 view .LVU99
	b	.L5		@
.L18:
	.loc 1 118 9 view .LVU100
@ armwave.c:118:         g_armwave_state.row_shift = 10;
	.loc 1 118 35 is_stmt 0 view .LVU101
	ldr	r3, .L21+28	@ tmp159,
	mov	r2, #10	@ tmp161,
	strd	r2, [r4, #68]	@, tmp213,
	.loc 1 119 9 is_stmt 1 view .LVU102
	b	.L5		@
.L17:
	.loc 1 109 5 view .LVU103
	ldr	r3, .L21+32	@,
	mov	r2, #109	@,
	ldr	r1, .L21+36	@,
.LVL14:
	.loc 1 109 5 is_stmt 0 view .LVU104
	ldr	r0, .L21+40	@,
.LVL15:
	.loc 1 109 5 view .LVU105
	bl	__assert_fail		@
.LVL16:
.L19:
	.loc 1 148 5 is_stmt 1 view .LVU106
	ldr	r3, .L21+32	@,
	mov	r2, #148	@,
	ldr	r1, .L21+36	@,
	ldr	r0, .L21+44	@,
	bl	__assert_fail		@
.LVL17:
.L20:
	.loc 1 156 5 view .LVU107
	ldr	r3, .L21+32	@,
	mov	r2, #156	@,
	ldr	r1, .L21+36	@,
	ldr	r0, .L21+48	@,
	bl	__assert_fail		@
.LVL18:
.L22:
	.align	2
.L21:
	.word	1157627904
	.word	1065353216
	.word	g_armwave_state
	.word	test_wave_buffer
	.word	2047
	.word	.LC2
	.word	511
	.word	1023
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC3
	.word	.LC4
	.cfi_endproc
.LFE74:
	.size	armwave_setup_render.constprop.0, .-armwave_setup_render.constprop.0
	.align	2
	.global	test_create_gamma
	.syntax unified
	.arm
	.fpu vfp
	.type	test_create_gamma, %function
test_create_gamma:
.LFB57:
	.loc 1 46 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 47 5 view .LVU109
	.loc 1 48 5 view .LVU110
.LVL19:
	.loc 1 50 5 view .LVU111
@ armwave.c:46: {
	.loc 1 46 1 is_stmt 0 view .LVU112
	push	{r4, r5, r6, lr}	@
	.cfi_def_cfa_offset 16
	.cfi_offset 4, -16
	.cfi_offset 5, -12
	.cfi_offset 6, -8
	.cfi_offset 14, -4
	vpush.64	{d8, d9, d10}	@
	.cfi_def_cfa_offset 40
	.cfi_offset 80, -40
	.cfi_offset 81, -36
	.cfi_offset 82, -32
	.cfi_offset 83, -28
	.cfi_offset 84, -24
	.cfi_offset 85, -20
	ldr	r4, .L27+20	@ ivtmp.39,
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 32 view .LVU113
	vldr.32	s20, .L27+16	@ tmp128,
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 26 view .LVU114
	vldr.64	d9, .L27	@ tmp135,
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 49 view .LVU115
	vldr.64	d8, .L27+8	@ tmp131,
	add	r5, r4, #1	@ _25, ivtmp.39,
	add	r6, r4, #256	@ _26, ivtmp.39,
	rsb	r5, r5, #1	@ tmp134, _25,
.LVL20:
.L24:
	.loc 1 51 9 is_stmt 1 discriminator 3 view .LVU116
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 32 is_stmt 0 discriminator 3 view .LVU117
	add	r3, r5, r4	@ tmp125, tmp134, ivtmp.39
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 26 discriminator 3 view .LVU118
	vmov.f64	d1, d9	@, tmp135
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 32 discriminator 3 view .LVU119
	vmov	s15, r3	@ int	@ tmp125, tmp125
	vcvt.f32.s32	s15, s15	@ tmp126, tmp125
	vdiv.f32	s0, s15, s20	@ tmp127, tmp126, tmp128
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 26 discriminator 3 view .LVU120
	vcvt.f64.f32	d0, s0	@, tmp127
	bl	pow		@
.LVL21:
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 49 discriminator 3 view .LVU121
	vmul.f64	d0, d0, d8	@ tmp130,, tmp131
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 24 discriminator 3 view .LVU122
	vcvt.u32.f64	s15, d0	@ tmp132, tmp130
	vmov	r3, s15	@ int	@ tmp132, tmp132
	strb	r3, [r4, #1]!	@ tmp132, MEM[base: _24, offset: 0B]
.LVL22:
@ armwave.c:50:     for(i = 0; i < 256; i++) {
	.loc 1 50 5 discriminator 3 view .LVU123
	cmp	r4, r6	@ ivtmp.39, _26
	bne	.L24		@,
@ armwave.c:53: }
	.loc 1 53 1 view .LVU124
	vldm	sp!, {d8-d10}	@,
	.cfi_restore 84
	.cfi_restore 85
	.cfi_restore 82
	.cfi_restore 83
	.cfi_restore 80
	.cfi_restore 81
	.cfi_def_cfa_offset 16
	pop	{r4, r5, r6, pc}	@
.LVL23:
.L28:
	.loc 1 53 1 view .LVU125
	.align	3
.L27:
	.word	-1073741824
	.word	1072483532
	.word	0
	.word	1081073664
	.word	1132396544
	.word	gamma_table-1
	.cfi_endproc
.LFE57:
	.size	test_create_gamma, .-test_create_gamma
	.align	2
	.global	render_nonaa_to_buffer_1ch_slice
	.syntax unified
	.arm
	.fpu vfp
	.type	render_nonaa_to_buffer_1ch_slice, %function
render_nonaa_to_buffer_1ch_slice:
.LVL24:
.LFB58:
	.loc 1 64 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 65 5 view .LVU127
	.loc 1 66 5 view .LVU128
	.loc 1 67 5 view .LVU129
	.loc 1 68 5 view .LVU130
	.loc 1 69 5 view .LVU131
	.loc 1 71 5 view .LVU132
@ armwave.c:64: {
	.loc 1 64 1 is_stmt 0 view .LVU133
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	.cfi_def_cfa_offset 36
	.cfi_offset 4, -36
	.cfi_offset 5, -32
	.cfi_offset 6, -28
	.cfi_offset 7, -24
	.cfi_offset 8, -20
	.cfi_offset 9, -16
	.cfi_offset 10, -12
	.cfi_offset 11, -8
	.cfi_offset 14, -4
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 40 view .LVU134
	ldr	r4, .L41	@ tmp242,
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 view .LVU135
	ldr	r2, [r4, #36]	@ g_armwave_state.waves, g_armwave_state.waves
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 63 view .LVU136
	ldr	r5, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 view .LVU137
	cmp	r2, #0	@ g_armwave_state.waves,
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 40 view .LVU138
	ldr	r3, [r4, #4]	@ _1, g_armwave_state.ch1_buffer
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 63 view .LVU139
	mul	r5, r5, r0	@ _3, g_armwave_state.bitdepth_height, slice_y
.LVL25:
	.loc 1 74 5 is_stmt 1 view .LVU140
	.loc 1 74 5 is_stmt 0 view .LVU141
	popeq	{r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
	cmp	r1, #0	@ height,
	popeq	{r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
	sub	r8, r0, #4	@ tmp243, slice_y,
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 11 view .LVU142
	mov	r7, #0	@ w,
.LVL26:
.L33:
	.loc 1 75 9 is_stmt 1 view .LVU143
	.loc 1 79 9 view .LVU144
@ armwave.c:75:         wave_base = g_armwave_state.wave_buffer + slice_y + (w * g_armwave_state.wave_stride);
	.loc 1 75 64 is_stmt 0 view .LVU145
	ldr	r0, [r4, #32]	@ g_armwave_state.wave_stride, g_armwave_state.wave_stride
	ldr	r6, [r4, #20]	@ g_armwave_state.wave_buffer, g_armwave_state.wave_buffer
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 16 view .LVU146
	mov	r2, #0	@ yy,
	mla	r0, r0, r7, r8	@ tmp193, g_armwave_state.wave_stride, w, tmp243
	add	r6, r6, r0	@ ivtmp.45, g_armwave_state.wave_buffer, tmp193
.LVL27:
.L32:
	.loc 1 80 13 is_stmt 1 view .LVU147
@ armwave.c:80:             word = *(uint32_t*)(wave_base + yy);
	.loc 1 80 18 is_stmt 0 view .LVU148
	ldr	r0, [r6, #4]!	@ word, MEM[base: _168, offset: 0B]
.LVL28:
	.loc 1 82 13 is_stmt 1 view .LVU149
	.loc 1 84 17 view .LVU150
	.loc 1 85 17 view .LVU151
	.loc 1 86 17 view .LVU152
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU153
	ldr	r9, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
	add	ip, r2, #1	@ tmp206, yy,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU154
	uxtab	lr, r5, r0	@ tmp199, _3, word
	mla	r9, r9, r2, lr	@ tmp200, g_armwave_state.bitdepth_height, yy, tmp199
@ armwave.c:87:                 word >>= 8;
	.loc 1 87 22 view .LVU155
	lsr	fp, r0, #8	@ word, word,
	lsr	r10, r0, #16	@ word, word,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU156
	ldrb	lr, [r3, r9]	@ zero_extendqisi2	@ *_55, *_55
	uxtab	fp, r5, fp	@ tmp211, _3, word
	add	lr, lr, #1	@ tmp203, *_55,
	strb	lr, [r3, r9]	@ tmp203, *_55
.LVL29:
	.loc 1 87 17 is_stmt 1 view .LVU157
	.loc 1 84 17 view .LVU158
	.loc 1 85 17 view .LVU159
	.loc 1 86 17 view .LVU160
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU161
	ldr	lr, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU162
	uxtab	r10, r5, r10	@ tmp223, _3, word
	mla	lr, lr, ip, fp	@ tmp212, g_armwave_state.bitdepth_height, tmp206, tmp211
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 view .LVU163
	add	ip, r2, #2	@ tmp218, yy,
	add	r9, r2, #3	@ tmp230, yy,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU164
	ldrb	fp, [r3, lr]	@ zero_extendqisi2	@ *_75, *_75
	add	r0, r5, r0, lsr #24	@ tmp234, _3, word,
.LVL30:
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 37 view .LVU165
	add	r2, r2, #4	@ yy, yy,
.LVL31:
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU166
	add	fp, fp, #1	@ tmp215, *_75,
	strb	fp, [r3, lr]	@ tmp215, *_75
.LVL32:
	.loc 1 87 17 is_stmt 1 view .LVU167
	.loc 1 84 17 view .LVU168
	.loc 1 85 17 view .LVU169
	.loc 1 86 17 view .LVU170
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU171
	ldr	lr, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 view .LVU172
	cmp	r1, r2	@ height, yy
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU173
	mla	ip, lr, ip, r10	@ tmp224, g_armwave_state.bitdepth_height, tmp218, tmp223
	ldrb	lr, [r3, ip]	@ zero_extendqisi2	@ *_95, *_95
	add	lr, lr, #1	@ tmp227, *_95,
	strb	lr, [r3, ip]	@ tmp227, *_95
	.loc 1 87 17 is_stmt 1 view .LVU174
.LVL33:
	.loc 1 84 17 view .LVU175
	.loc 1 85 17 view .LVU176
	.loc 1 86 17 view .LVU177
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU178
	ldr	ip, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU179
	mla	r0, ip, r9, r0	@ tmp235, g_armwave_state.bitdepth_height, tmp230, tmp234
	ldrb	ip, [r3, r0]	@ zero_extendqisi2	@ *_115, *_115
	add	ip, ip, #1	@ tmp238, *_115,
	strb	ip, [r3, r0]	@ tmp238, *_115
	.loc 1 87 17 is_stmt 1 view .LVU180
.LVL34:
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 is_stmt 0 view .LVU181
	bhi	.L32		@,
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 view .LVU182
	ldr	r2, [r4, #36]	@ g_armwave_state.waves, g_armwave_state.waves
.LVL35:
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 44 view .LVU183
	add	r7, r7, #1	@ w, w,
.LVL36:
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 view .LVU184
	cmp	r7, r2	@ w, g_armwave_state.waves
	bcc	.L33		@,
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
.L42:
	.align	2
.L41:
	.word	g_armwave_state
	.cfi_endproc
.LFE58:
	.size	render_nonaa_to_buffer_1ch_slice, .-render_nonaa_to_buffer_1ch_slice
	.align	2
	.global	armwave_init
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_init, %function
armwave_init:
.LFB59:
	.loc 1 94 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 95 5 view .LVU186
@ armwave.c:95:     g_armwave_state.flags = 0;
	.loc 1 95 27 is_stmt 0 view .LVU187
	ldr	r3, .L44	@ tmp110,
	mov	r2, #0	@ tmp111,
	str	r2, [r3]	@ tmp111, g_armwave_state.flags
@ armwave.c:96: }
	.loc 1 96 1 view .LVU188
	bx	lr	@
.L45:
	.align	2
.L44:
	.word	g_armwave_state
	.cfi_endproc
.LFE59:
	.size	armwave_init, .-armwave_init
	.align	2
	.global	armwave_setup_render
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_setup_render, %function
armwave_setup_render:
.LVL37:
.LFB60:
	.loc 1 99 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 16, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 100 5 view .LVU190
	.loc 1 101 5 view .LVU191
	.loc 1 103 5 view .LVU192
@ armwave.c:99: {
	.loc 1 99 1 is_stmt 0 view .LVU193
	push	{r4, r5, r6, r7, r8, lr}	@
	.cfi_def_cfa_offset 24
	.cfi_offset 4, -24
	.cfi_offset 5, -20
	.cfi_offset 6, -16
	.cfi_offset 7, -12
	.cfi_offset 8, -8
	.cfi_offset 14, -4
@ armwave.c:103:     assert(start_point < end_point);
	.loc 1 103 5 view .LVU194
	cmp	r1, r2	@ start_point, end_point
@ armwave.c:99: {
	.loc 1 99 1 view .LVU195
	vpush.64	{d8}	@
	.cfi_def_cfa_offset 32
	.cfi_offset 80, -32
	.cfi_offset 81, -28
@ armwave.c:99: {
	.loc 1 99 1 view .LVU196
	mov	r7, r1	@ start_point, start_point
	mov	r5, r2	@ end_point, end_point
	ldr	r1, [sp, #32]	@ wave_stride, wave_stride
.LVL38:
	.loc 1 99 1 view .LVU197
	ldr	r6, [sp, #36]	@ target_width, target_width
	ldr	r2, [sp, #40]	@ target_height, target_height
.LVL39:
@ armwave.c:103:     assert(start_point < end_point);
	.loc 1 103 5 view .LVU198
	bcs	.L62		@,
	.loc 1 106 5 is_stmt 1 view .LVU199
@ armwave.c:106:     g_armwave_state.wave_buffer = wave_buffer;
	.loc 1 106 33 is_stmt 0 view .LVU200
	ldr	r4, .L67+4	@ tmp223,
@ armwave.c:109:     assert(target_height == 256 || target_height == 512 || target_height == 1024 || target_height == 2048);
	.loc 1 109 5 view .LVU201
	sub	ip, r2, #256	@ tmp154, target_height,
	bics	ip, ip, #256	@ tmp225, tmp154,
@ armwave.c:106:     g_armwave_state.wave_buffer = wave_buffer;
	.loc 1 106 33 view .LVU202
	str	r0, [r4, #20]	@ wave_buffer, g_armwave_state.wave_buffer
	.loc 1 109 5 is_stmt 1 view .LVU203
	beq	.L48		@,
@ armwave.c:109:     assert(target_height == 256 || target_height == 512 || target_height == 1024 || target_height == 2048);
	.loc 1 109 5 is_stmt 0 discriminator 1 view .LVU204
	sub	r0, r2, #1024	@ tmp156, target_height,
.LVL40:
	.loc 1 109 5 discriminator 1 view .LVU205
	bics	r0, r0, #1024	@ tmp226, tmp156,
	bne	.L63		@,
	.loc 1 111 5 is_stmt 1 view .LVU206
	.loc 1 117 12 view .LVU207
@ armwave.c:117:     } else if(target_height == 1024) {
	.loc 1 117 14 is_stmt 0 view .LVU208
	cmp	r2, #1024	@ target_height,
	beq	.L64		@,
	.loc 1 120 12 is_stmt 1 view .LVU209
@ armwave.c:120:     } else if(target_height == 2048) {
	.loc 1 120 14 is_stmt 0 view .LVU210
	cmp	r2, #2048	@ target_height,
	.loc 1 121 9 is_stmt 1 view .LVU211
@ armwave.c:121:         g_armwave_state.row_shift = 11;
	.loc 1 121 35 is_stmt 0 view .LVU212
	moveq	r0, #11	@ tmp174,
@ armwave.c:122:         g_armwave_state.row_mask = 0x7ff;
	.loc 1 122 34 view .LVU213
	ldreq	ip, .L67+8	@ tmp176,
@ armwave.c:121:         g_armwave_state.row_shift = 11;
	.loc 1 121 35 view .LVU214
	streq	r0, [r4, #68]	@ tmp174, g_armwave_state.row_shift
	.loc 1 122 9 is_stmt 1 view .LVU215
@ armwave.c:122:         g_armwave_state.row_mask = 0x7ff;
	.loc 1 122 34 is_stmt 0 view .LVU216
	streq	ip, [r4, #72]	@ tmp176, g_armwave_state.row_mask
.L51:
	.loc 1 126 5 is_stmt 1 view .LVU217
@ armwave.c:130:     g_armwave_state.size = target_height * target_width;
	.loc 1 130 42 is_stmt 0 view .LVU218
	mul	lr, r6, r2	@ tmp183, target_width, target_height
@ armwave.c:132:     g_armwave_state.ch_buff_size = g_armwave_state.bitdepth_height * target_width;
	.loc 1 132 68 view .LVU219
	lsl	ip, r6, #8	@ _9, target_width,
@ armwave.c:127:     g_armwave_state.vscale = target_height / 256;
	.loc 1 127 44 view .LVU220
	lsr	r0, r2, #8	@ tmp179, target_height,
@ armwave.c:128:     g_armwave_state.wave_stride = wave_stride;
	.loc 1 128 33 view .LVU221
	str	r1, [r4, #32]	@ wave_stride, g_armwave_state.wave_stride
@ armwave.c:129:     g_armwave_state.waves = waves;
	.loc 1 129 27 view .LVU222
	str	r3, [r4, #36]	@ waves, g_armwave_state.waves
@ armwave.c:127:     g_armwave_state.vscale = target_height / 256;
	.loc 1 127 28 view .LVU223
	str	r0, [r4, #28]	@ tmp179, g_armwave_state.vscale
@ armwave.c:131:     g_armwave_state.bitdepth_height = 256;  // Always 256 possible levels in 8-bit mode
	.loc 1 131 37 view .LVU224
	mov	r3, #256	@ tmp185,
.LVL41:
@ armwave.c:136:     printf("ch_buff_size=%d\n", g_armwave_state.ch_buff_size);
	.loc 1 136 5 view .LVU225
	mov	r1, ip	@, _9
	ldr	r0, .L67+12	@,
@ armwave.c:131:     g_armwave_state.bitdepth_height = 256;  // Always 256 possible levels in 8-bit mode
	.loc 1 131 37 view .LVU226
	str	r3, [r4, #40]	@ tmp185, g_armwave_state.bitdepth_height
@ armwave.c:126:     g_armwave_state.xstride = target_height;
	.loc 1 126 29 view .LVU227
	str	r2, [r4, #24]	@ target_height, g_armwave_state.xstride
	.loc 1 127 5 is_stmt 1 view .LVU228
	.loc 1 128 5 view .LVU229
	.loc 1 129 5 view .LVU230
	.loc 1 130 5 view .LVU231
	.loc 1 131 5 view .LVU232
	.loc 1 132 5 view .LVU233
	.loc 1 133 5 view .LVU234
	.loc 1 134 5 view .LVU235
	.loc 1 136 5 view .LVU236
@ armwave.c:133:     g_armwave_state.target_width = target_width;
	.loc 1 133 34 is_stmt 0 view .LVU237
	str	r6, [r4, #60]	@ target_width, g_armwave_state.target_width
@ armwave.c:134:     g_armwave_state.target_height = target_height;
	.loc 1 134 35 view .LVU238
	str	r2, [r4, #64]	@ target_height, g_armwave_state.target_height
@ armwave.c:130:     g_armwave_state.size = target_height * target_width;
	.loc 1 130 26 view .LVU239
	str	lr, [r4, #56]	@ tmp183, g_armwave_state.size
@ armwave.c:132:     g_armwave_state.ch_buff_size = g_armwave_state.bitdepth_height * target_width;
	.loc 1 132 34 view .LVU240
	str	ip, [r4, #52]	@ _9, g_armwave_state.ch_buff_size
@ armwave.c:136:     printf("ch_buff_size=%d\n", g_armwave_state.ch_buff_size);
	.loc 1 136 5 view .LVU241
	bl	printf		@
.LVL42:
	.loc 1 141 5 is_stmt 1 view .LVU242
@ armwave.c:143:     if(g_armwave_state.ch1_buffer != NULL)
	.loc 1 143 23 is_stmt 0 view .LVU243
	ldr	r0, [r4, #4]	@ _10, g_armwave_state.ch1_buffer
@ armwave.c:141:     g_armwave_state.slice_height = 64;  
	.loc 1 141 34 view .LVU244
	mov	r3, #64	@ tmp191,
@ armwave.c:143:     if(g_armwave_state.ch1_buffer != NULL)
	.loc 1 143 7 view .LVU245
	cmp	r0, #0	@ _10,
@ armwave.c:141:     g_armwave_state.slice_height = 64;  
	.loc 1 141 34 view .LVU246
	str	r3, [r4, #44]	@ tmp191, g_armwave_state.slice_height
	.loc 1 143 5 is_stmt 1 view .LVU247
@ armwave.c:143:     if(g_armwave_state.ch1_buffer != NULL)
	.loc 1 143 7 is_stmt 0 view .LVU248
	beq	.L53		@,
	.loc 1 144 9 is_stmt 1 view .LVU249
	bl	free		@
.LVL43:
.L53:
	.loc 1 146 5 view .LVU250
@ armwave.c:146:     g_armwave_state.ch1_buffer = calloc(g_armwave_state.ch_buff_size, 1);
	.loc 1 146 34 is_stmt 0 view .LVU251
	mov	r1, #1	@,
	ldr	r0, [r4, #52]	@, g_armwave_state.ch_buff_size
	bl	calloc		@
.LVL44:
@ armwave.c:148:     assert(g_armwave_state.ch1_buffer != NULL);
	.loc 1 148 5 view .LVU252
	cmp	r0, #0	@ tmp195,
@ armwave.c:146:     g_armwave_state.ch1_buffer = calloc(g_armwave_state.ch_buff_size, 1);
	.loc 1 146 32 view .LVU253
	str	r0, [r4, #4]	@ tmp195, g_armwave_state.ch1_buffer
	.loc 1 148 5 is_stmt 1 view .LVU254
	beq	.L65		@,
	.loc 1 151 5 view .LVU255
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 34 is_stmt 0 view .LVU256
	vmov	s15, r6	@ int	@ target_width, target_width
@ armwave.c:151:     length = end_point - start_point;
	.loc 1 151 12 view .LVU257
	sub	r5, r5, r7	@ length, end_point, start_point
.LVL45:
	.loc 1 152 5 is_stmt 1 view .LVU258
@ armwave.c:154:     g_armwave_state.xcoord_to_xpixel = malloc(length * sizeof(uint16_t));
	.loc 1 154 40 is_stmt 0 view .LVU259
	lsl	r0, r5, #1	@, length,
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 34 view .LVU260
	vcvt.f32.u32	s14, s15	@ tmp201, target_width
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 31 view .LVU261
	vmov	s15, r5	@ int	@ length, length
	vcvt.f32.u32	s13, s15	@ tmp200, length
@ armwave.c:153:     g_armwave_state.slice_record_height = points_per_pixel * g_armwave_state.slice_height;
	.loc 1 153 60 view .LVU262
	vldr.32	s15, [r4, #44]	@ int	@ tmp229, g_armwave_state.slice_height
	vcvt.f32.u32	s15, s15	@ tmp204, tmp229
@ armwave.c:152:     points_per_pixel = length / ((float)(target_width));
	.loc 1 152 22 view .LVU263
	vdiv.f32	s16, s13, s14	@ points_per_pixel, tmp200, tmp201
.LVL46:
	.loc 1 153 5 is_stmt 1 view .LVU264
@ armwave.c:153:     g_armwave_state.slice_record_height = points_per_pixel * g_armwave_state.slice_height;
	.loc 1 153 60 is_stmt 0 view .LVU265
	vmul.f32	s15, s15, s16	@ tmp206, tmp204, points_per_pixel
@ armwave.c:153:     g_armwave_state.slice_record_height = points_per_pixel * g_armwave_state.slice_height;
	.loc 1 153 41 view .LVU266
	vcvt.u32.f32	s15, s15	@ tmp207, tmp206
	vstr.32	s15, [r4, #48]	@ int	@ tmp207, g_armwave_state.slice_record_height
	.loc 1 154 5 is_stmt 1 view .LVU267
@ armwave.c:154:     g_armwave_state.xcoord_to_xpixel = malloc(length * sizeof(uint16_t));
	.loc 1 154 40 is_stmt 0 view .LVU268
	bl	malloc		@
.LVL47:
@ armwave.c:156:     assert(g_armwave_state.xcoord_to_xpixel != NULL);
	.loc 1 156 5 view .LVU269
	cmp	r0, #0	@ tmp209,
@ armwave.c:154:     g_armwave_state.xcoord_to_xpixel = malloc(length * sizeof(uint16_t));
	.loc 1 154 38 view .LVU270
	str	r0, [r4, #104]	@ tmp209, g_armwave_state.xcoord_to_xpixel
	.loc 1 156 5 is_stmt 1 view .LVU271
	beq	.L66		@,
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 54 is_stmt 0 view .LVU272
	vldr.32	s15, .L67	@ tmp214,
	sub	r0, r0, #2	@ ivtmp.55, tmp209,
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 12 view .LVU273
	mov	r3, #0	@ xx,
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 54 view .LVU274
	vdiv.f32	s14, s15, s16	@ _21, tmp214, points_per_pixel
.L56:
.LVL48:
	.loc 1 159 9 is_stmt 1 discriminator 3 view .LVU275
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 74 is_stmt 0 discriminator 3 view .LVU276
	vmov	s15, r3	@ int	@ xx, xx
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 32 discriminator 3 view .LVU277
	add	r3, r3, #1	@ xx, xx,
.LVL49:
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 5 discriminator 3 view .LVU278
	cmp	r5, r3	@ length, xx
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 74 discriminator 3 view .LVU279
	vcvt.f32.s32	s15, s15	@ tmp215, xx
	vmul.f32	s15, s15, s14	@ tmp216, tmp215, _21
@ armwave.c:159:         g_armwave_state.xcoord_to_xpixel[xx] = (1.0f / points_per_pixel) * xx;
	.loc 1 159 46 discriminator 3 view .LVU280
	vcvt.u32.f32	s15, s15	@ tmp217, tmp216
	vmov	r2, s15	@ int	@ tmp217, tmp217
	strh	r2, [r0, #2]!	@ movhi	@ tmp217, MEM[base: _78, offset: 0B]
@ armwave.c:158:     for(xx = 0; xx < length; xx++) {
	.loc 1 158 5 discriminator 3 view .LVU281
	bne	.L56		@,
	.loc 1 164 5 is_stmt 1 view .LVU282
@ armwave.c:164:     g_armwave_state.out_pixbuf = malloc(sizeof(uint32_t) * g_armwave_state.size);
	.loc 1 164 34 is_stmt 0 view .LVU283
	ldr	r0, [r4, #56]	@ g_armwave_state.size, g_armwave_state.size
	lsl	r0, r0, #2	@, g_armwave_state.size,
	bl	malloc		@
.LVL50:
@ armwave.c:165: }
	.loc 1 165 1 view .LVU284
	vldm	sp!, {d8}	@
	.cfi_remember_state
	.cfi_restore 80
	.cfi_restore 81
	.cfi_def_cfa_offset 24
.LVL51:
@ armwave.c:164:     g_armwave_state.out_pixbuf = malloc(sizeof(uint32_t) * g_armwave_state.size);
	.loc 1 164 32 view .LVU285
	str	r0, [r4, #76]	@, g_armwave_state.out_pixbuf
@ armwave.c:165: }
	.loc 1 165 1 view .LVU286
	pop	{r4, r5, r6, r7, r8, pc}	@
.LVL52:
.L48:
	.cfi_restore_state
	.loc 1 111 5 is_stmt 1 view .LVU287
@ armwave.c:111:     if(target_height == 256) {
	.loc 1 111 7 is_stmt 0 view .LVU288
	cmp	r2, #256	@ target_height,
	.loc 1 112 9 is_stmt 1 view .LVU289
@ armwave.c:112:         g_armwave_state.row_shift = 8;
	.loc 1 112 35 is_stmt 0 view .LVU290
	moveq	ip, #8	@ tmp162,
@ armwave.c:116:         g_armwave_state.row_mask = 0x1ff;
	.loc 1 116 34 view .LVU291
	ldrne	ip, .L67+16	@ tmp168,
@ armwave.c:113:         g_armwave_state.row_mask = 0x0ff;
	.loc 1 113 34 view .LVU292
	moveq	r0, #255	@ tmp164,
.LVL53:
@ armwave.c:115:         g_armwave_state.row_shift = 9;
	.loc 1 115 35 view .LVU293
	movne	r0, #9	@ tmp166,
@ armwave.c:112:         g_armwave_state.row_shift = 8;
	.loc 1 112 35 view .LVU294
	streq	ip, [r4, #68]	@ tmp162, g_armwave_state.row_shift
	.loc 1 113 9 is_stmt 1 view .LVU295
@ armwave.c:113:         g_armwave_state.row_mask = 0x0ff;
	.loc 1 113 34 is_stmt 0 view .LVU296
	streq	r0, [r4, #72]	@ tmp164, g_armwave_state.row_mask
	.loc 1 114 12 is_stmt 1 view .LVU297
	.loc 1 115 9 view .LVU298
@ armwave.c:116:         g_armwave_state.row_mask = 0x1ff;
	.loc 1 116 34 is_stmt 0 view .LVU299
	strne	ip, [r4, #72]	@ tmp168, g_armwave_state.row_mask
@ armwave.c:115:         g_armwave_state.row_shift = 9;
	.loc 1 115 35 view .LVU300
	strne	r0, [r4, #68]	@ tmp166, g_armwave_state.row_shift
	.loc 1 116 9 is_stmt 1 view .LVU301
	b	.L51		@
.L64:
	.loc 1 118 9 view .LVU302
@ armwave.c:119:         g_armwave_state.row_mask = 0x3ff;
	.loc 1 119 34 is_stmt 0 view .LVU303
	ldr	ip, .L67+20	@ tmp172,
@ armwave.c:118:         g_armwave_state.row_shift = 10;
	.loc 1 118 35 view .LVU304
	mov	r0, #10	@ tmp170,
@ armwave.c:119:         g_armwave_state.row_mask = 0x3ff;
	.loc 1 119 34 view .LVU305
	str	ip, [r4, #72]	@ tmp172, g_armwave_state.row_mask
@ armwave.c:118:         g_armwave_state.row_shift = 10;
	.loc 1 118 35 view .LVU306
	str	r0, [r4, #68]	@ tmp170, g_armwave_state.row_shift
	.loc 1 119 9 is_stmt 1 view .LVU307
	b	.L51		@
.L63:
	.loc 1 109 5 discriminator 2 view .LVU308
	ldr	r3, .L67+24	@,
.LVL54:
	.loc 1 109 5 is_stmt 0 discriminator 2 view .LVU309
	mov	r2, #109	@,
	ldr	r1, .L67+28	@,
	ldr	r0, .L67+32	@,
	bl	__assert_fail		@
.LVL55:
.L65:
	.loc 1 148 5 is_stmt 1 discriminator 1 view .LVU310
	ldr	r3, .L67+24	@,
	mov	r2, #148	@,
	ldr	r1, .L67+28	@,
	ldr	r0, .L67+36	@,
	bl	__assert_fail		@
.LVL56:
.L66:
	.loc 1 156 5 discriminator 1 view .LVU311
	ldr	r3, .L67+24	@,
	mov	r2, #156	@,
	ldr	r1, .L67+28	@,
	ldr	r0, .L67+40	@,
	bl	__assert_fail		@
.LVL57:
.L62:
	.loc 1 103 5 discriminator 1 view .LVU312
	ldr	r3, .L67+24	@,
.LVL58:
	.loc 1 103 5 is_stmt 0 discriminator 1 view .LVU313
	mov	r2, #103	@,
	ldr	r1, .L67+28	@,
	ldr	r0, .L67+44	@,
.LVL59:
	.loc 1 103 5 discriminator 1 view .LVU314
	bl	__assert_fail		@
.LVL60:
.L68:
	.align	2
.L67:
	.word	1065353216
	.word	g_armwave_state
	.word	2047
	.word	.LC2
	.word	511
	.word	1023
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.cfi_endproc
.LFE60:
	.size	armwave_setup_render, .-armwave_setup_render
	.align	2
	.global	armwave_clear_buffer
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_clear_buffer, %function
armwave_clear_buffer:
.LVL61:
.LFB61:
	.loc 1 168 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 170 5 view .LVU316
	ldr	r3, .L70	@ tmp113,
	mov	r1, #0	@,
	ldr	r2, [r3, #56]	@, g_armwave_state.size
	ldr	r0, [r3, #4]	@, g_armwave_state.ch1_buffer
.LVL62:
	.loc 1 170 5 is_stmt 0 view .LVU317
	b	memset		@
.LVL63:
.L71:
	.align	2
.L70:
	.word	g_armwave_state
	.cfi_endproc
.LFE61:
	.size	armwave_clear_buffer, .-armwave_clear_buffer
	.align	2
	.global	armwave_set_channel_colour
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_set_channel_colour, %function
armwave_set_channel_colour:
.LVL64:
.LFB62:
	.loc 1 177 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 179 5 view .LVU319
	cmp	r0, #1	@ ch,
	.loc 1 181 13 view .LVU320
@ armwave.c:181:             g_armwave_state.ch1_color.r = r;
	.loc 1 181 41 is_stmt 0 view .LVU321
	ldreq	r0, .L74	@ tmp117,
.LVL65:
	.loc 1 181 41 view .LVU322
	strheq	r1, [r0, #80]	@ movhi	@ r, g_armwave_state.ch1_color.r
	.loc 1 182 13 is_stmt 1 view .LVU323
@ armwave.c:182:             g_armwave_state.ch1_color.g = g;
	.loc 1 182 41 is_stmt 0 view .LVU324
	strheq	r2, [r0, #82]	@ movhi	@ g, g_armwave_state.ch1_color.g
	.loc 1 183 13 is_stmt 1 view .LVU325
@ armwave.c:183:             g_armwave_state.ch1_color.b = b;
	.loc 1 183 41 is_stmt 0 view .LVU326
	strheq	r3, [r0, #84]	@ movhi	@ b, g_armwave_state.ch1_color.b
	.loc 1 184 13 is_stmt 1 view .LVU327
@ armwave.c:186: }
	.loc 1 186 1 is_stmt 0 view .LVU328
	bx	lr	@
.L75:
	.align	2
.L74:
	.word	g_armwave_state
	.cfi_endproc
.LFE62:
	.size	armwave_set_channel_colour, .-armwave_set_channel_colour
	.align	2
	.global	armwave_fill_pixbuf_256
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_fill_pixbuf_256, %function
armwave_fill_pixbuf_256:
.LVL66:
.LFB63:
	.loc 1 192 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 193 5 view .LVU330
	.loc 1 194 5 view .LVU331
	.loc 1 195 5 view .LVU332
	.loc 1 196 5 view .LVU333
@ armwave.c:192: {
	.loc 1 192 1 is_stmt 0 view .LVU334
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	.cfi_def_cfa_offset 36
	.cfi_offset 4, -36
	.cfi_offset 5, -32
	.cfi_offset 6, -28
	.cfi_offset 7, -24
	.cfi_offset 8, -20
	.cfi_offset 9, -16
	.cfi_offset 10, -12
	.cfi_offset 11, -8
	.cfi_offset 14, -4
@ armwave.c:200:     assert(out_buffer != NULL);
	.loc 1 200 5 view .LVU335
	cmp	r0, #0	@ out_buffer
@ armwave.c:196:     uint32_t *base_32ptr = (uint32_t*)g_armwave_state.ch1_buffer;
	.loc 1 196 15 view .LVU336
	ldr	r5, .L103	@ tmp361,
@ armwave.c:192: {
	.loc 1 192 1 view .LVU337
	sub	sp, sp, #12	@,,
	.cfi_def_cfa_offset 48
@ armwave.c:196:     uint32_t *base_32ptr = (uint32_t*)g_armwave_state.ch1_buffer;
	.loc 1 196 15 view .LVU338
	ldr	r1, [r5, #4]	@ base_32ptr, g_armwave_state.ch1_buffer
.LVL67:
	.loc 1 197 5 is_stmt 1 view .LVU339
	.loc 1 198 5 view .LVU340
	.loc 1 200 5 view .LVU341
	beq	.L101		@,
	.loc 1 204 5 view .LVU342
@ armwave.c:204:     npix = g_armwave_state.target_width * 256;
	.loc 1 204 41 is_stmt 0 view .LVU343
	ldr	ip, [r5, #60]	@ g_armwave_state.target_width, g_armwave_state.target_width
	lsl	ip, ip, #8	@ npix, g_armwave_state.target_width,
.LVL68:
	.loc 1 206 5 is_stmt 1 view .LVU344
	.loc 1 206 5 is_stmt 0 view .LVU345
	cmp	ip, #0	@ npix,
	ble	.L76		@,
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 52 view .LVU346
	ldrsh	r10, [r5, #80]	@ _70, g_armwave_state.ch1_color.r
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 52 view .LVU347
	ldrsh	r9, [r5, #82]	@ _76, g_armwave_state.ch1_color.g
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 52 view .LVU348
	ldrsh	fp, [r5, #84]	@ _80, g_armwave_state.ch1_color.b
@ armwave.c:206:     for(n = 0; n < npix; n += 4) {
	.loc 1 206 11 view .LVU349
	mov	r3, #0	@ n,
	str	r0, [sp]	@ out_buffer, %sfp
.LVL69:
.L85:
	.loc 1 210 9 is_stmt 1 view .LVU350
@ armwave.c:210:         wave_word = *base_32ptr++;
	.loc 1 210 19 is_stmt 0 view .LVU351
	ldr	r2, [r1], #4	@ wave_word, MEM[base: base_32ptr_46, offset: 4294967292B]
.LVL70:
	.loc 1 212 9 is_stmt 1 view .LVU352
@ armwave.c:212:         if(COND_UNLIKELY(wave_word != 0)) {
	.loc 1 212 11 is_stmt 0 view .LVU353
	cmp	r2, #0	@ wave_word,
	bne	.L102		@,
.LVL71:
.L80:
@ armwave.c:206:     for(n = 0; n < npix; n += 4) {
	.loc 1 206 28 discriminator 2 view .LVU354
	add	r3, r3, #4	@ n, n,
.LVL72:
@ armwave.c:206:     for(n = 0; n < npix; n += 4) {
	.loc 1 206 5 discriminator 2 view .LVU355
	cmp	ip, r3	@ npix, n
	bgt	.L85		@,
.LVL73:
.L76:
@ armwave.c:239: }
	.loc 1 239 1 view .LVU356
	add	sp, sp, #12	@,,
	.cfi_remember_state
	.cfi_def_cfa_offset 36
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
.LVL74:
.L102:
	.cfi_restore_state
	.loc 1 214 17 is_stmt 1 view .LVU357
	.loc 1 215 17 view .LVU358
@ armwave.c:217:                 if(value != 0) {
	.loc 1 217 19 is_stmt 0 view .LVU359
	ands	r6, r2, #255	@ _72, wave_word,
@ armwave.c:215:                 wave_word >>= 8;
	.loc 1 215 27 view .LVU360
	lsr	lr, r2, #8	@ wave_word, wave_word,
.LVL75:
	.loc 1 217 17 is_stmt 1 view .LVU361
@ armwave.c:217:                 if(value != 0) {
	.loc 1 217 19 is_stmt 0 view .LVU362
	beq	.L81		@,
	.loc 1 218 21 is_stmt 1 view .LVU363
.LVL76:
	.loc 1 219 21 view .LVU364
	.loc 1 220 21 view .LVU365
	.loc 1 222 21 view .LVU366
	.loc 1 223 21 view .LVU367
	.loc 1 224 21 view .LVU368
	.loc 1 227 21 view .LVU369
	.loc 1 230 21 view .LVU370
	.loc 1 231 21 view .LVU371
	.loc 1 232 21 view .LVU372
	.loc 1 233 21 view .LVU373
	.loc 1 234 21 view .LVU374
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 55 is_stmt 0 view .LVU375
	mul	r4, fp, r6	@ tmp277, _80, _72
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 55 view .LVU376
	mul	r8, r9, r6	@ tmp281, _76, _72
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 24 view .LVU377
	asr	r4, r4, #8	@ bb, tmp277,
.LVL77:
@ armwave.c:224:                     b = MIN(bb, 255);
	.loc 1 224 25 view .LVU378
	cmp	r4, #255	@ bb,
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 24 view .LVU379
	asr	r8, r8, #8	@ gg, tmp281,
.LVL78:
@ armwave.c:224:                     b = MIN(bb, 255);
	.loc 1 224 25 view .LVU380
	movge	r4, #255	@ bb,
.LVL79:
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 55 view .LVU381
	mul	r6, r6, r10	@ tmp287, _72, _70
.LVL80:
@ armwave.c:223:                     g = MIN(gg, 255);
	.loc 1 223 25 view .LVU382
	cmp	r8, #255	@ gg,
	movge	r8, #255	@ gg,
.LVL81:
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 24 view .LVU383
	asr	r6, r6, #8	@ rr, tmp287,
.LVL82:
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU384
	lsl	r8, r8, #8	@ tmp282, gg,
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 39 view .LVU385
	ldr	r0, [r5, #60]	@ tmp373, g_armwave_state.target_width
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU386
	lsl	r4, r4, #16	@ tmp278, bb,
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU387
	cmp	r6, #255	@ rr,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU388
	uxth	r8, r8	@ tmp283, tmp282
@ armwave.c:231:                     xx = nsub & 0xff;
	.loc 1 231 24 view .LVU389
	uxtb	r7, r3	@ xx, n
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU390
	and	r4, r4, #16711680	@ tmp279, tmp278,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 51 view .LVU391
	orr	r4, r4, r8	@ tmp285, tmp279, tmp283
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU392
	movge	r6, #255	@ rr,
.LVL83:
@ armwave.c:232:                     yy = nsub >> 8;
	.loc 1 232 31 view .LVU393
	asr	r8, r3, #8	@ yy, n,
.LVL84:
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 39 view .LVU394
	mla	r7, r0, r7, r8	@ tmp275, tmp373, xx, yy
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU395
	uxtb	r6, r6	@ rr, rr
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU396
	ldr	r0, [sp]	@ out_buffer, %sfp
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU397
	orr	r6, r4, r6	@ tmp289, tmp285, rr
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 26 view .LVU398
	orr	r6, r6, #-16777216	@ word, tmp289,
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU399
	str	r6, [r0, r7, lsl #2]	@ word, *_106
.LVL85:
.L81:
	.loc 1 214 17 is_stmt 1 view .LVU400
	.loc 1 215 17 view .LVU401
@ armwave.c:217:                 if(value != 0) {
	.loc 1 217 19 is_stmt 0 view .LVU402
	ands	lr, lr, #255	@ _118, wave_word,
.LVL86:
@ armwave.c:215:                 wave_word >>= 8;
	.loc 1 215 27 view .LVU403
	lsr	r8, r2, #16	@ wave_word, wave_word,
.LVL87:
	.loc 1 217 17 is_stmt 1 view .LVU404
@ armwave.c:217:                 if(value != 0) {
	.loc 1 217 19 is_stmt 0 view .LVU405
	beq	.L82		@,
	.loc 1 218 21 is_stmt 1 view .LVU406
.LVL88:
	.loc 1 219 21 view .LVU407
	.loc 1 220 21 view .LVU408
	.loc 1 222 21 view .LVU409
	.loc 1 223 21 view .LVU410
	.loc 1 224 21 view .LVU411
	.loc 1 227 21 view .LVU412
	.loc 1 230 21 view .LVU413
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 55 is_stmt 0 view .LVU414
	mul	r4, lr, fp	@ tmp300, _118, _80
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 55 view .LVU415
	mul	r7, lr, r9	@ tmp304, _118, _76
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 24 view .LVU416
	asr	r4, r4, #8	@ bb, tmp300,
.LVL89:
@ armwave.c:224:                     b = MIN(bb, 255);
	.loc 1 224 25 view .LVU417
	cmp	r4, #255	@ bb,
	movge	r4, #255	@ bb,
.LVL90:
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 55 view .LVU418
	mul	lr, lr, r10	@ tmp310, _118, _70
.LVL91:
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 24 view .LVU419
	asr	r7, r7, #8	@ gg, tmp304,
.LVL92:
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU420
	lsl	r4, r4, #16	@ tmp301, bb,
@ armwave.c:223:                     g = MIN(gg, 255);
	.loc 1 223 25 view .LVU421
	cmp	r7, #255	@ gg,
	add	r6, r3, #1	@ _158, n,
	.loc 1 231 21 is_stmt 1 view .LVU422
	.loc 1 232 21 view .LVU423
	.loc 1 233 21 view .LVU424
	.loc 1 234 21 view .LVU425
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 is_stmt 0 view .LVU426
	and	r4, r4, #16711680	@ tmp302, tmp301,
@ armwave.c:223:                     g = MIN(gg, 255);
	.loc 1 223 25 view .LVU427
	movge	r7, #255	@ gg,
.LVL93:
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU428
	str	r4, [sp, #4]	@ tmp302, %sfp
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 39 view .LVU429
	ldr	r4, [r5, #60]	@ tmp376, g_armwave_state.target_width
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 24 view .LVU430
	asr	lr, lr, #8	@ rr, tmp310,
.LVL94:
@ armwave.c:231:                     xx = nsub & 0xff;
	.loc 1 231 24 view .LVU431
	uxtb	r0, r6	@ xx, _158
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU432
	cmp	lr, #255	@ rr,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU433
	lsl	r7, r7, #8	@ tmp305, gg,
@ armwave.c:232:                     yy = nsub >> 8;
	.loc 1 232 31 view .LVU434
	asr	r6, r6, #8	@ yy, _158,
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 39 view .LVU435
	mla	r6, r4, r0, r6	@ tmp298, tmp376, xx, yy
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU436
	movge	lr, #255	@ rr,
.LVL95:
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 51 view .LVU437
	ldr	r0, [sp, #4]	@ tmp302, %sfp
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU438
	uxth	r7, r7	@ tmp306, tmp305
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 51 view .LVU439
	orr	r4, r0, r7	@ tmp308, tmp302, tmp306
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU440
	uxtb	lr, lr	@ rr, rr
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU441
	ldr	r0, [sp]	@ out_buffer, %sfp
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU442
	orr	lr, r4, lr	@ tmp312, tmp308, rr
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 26 view .LVU443
	orr	lr, lr, #-16777216	@ word, tmp312,
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU444
	str	lr, [r0, r6, lsl #2]	@ word, *_152
.LVL96:
.L82:
	.loc 1 214 17 is_stmt 1 view .LVU445
	.loc 1 215 17 view .LVU446
@ armwave.c:217:                 if(value != 0) {
	.loc 1 217 19 is_stmt 0 view .LVU447
	ands	lr, r8, #255	@ _164, wave_word,
@ armwave.c:215:                 wave_word >>= 8;
	.loc 1 215 27 view .LVU448
	lsr	r2, r2, #24	@ wave_word, wave_word,
.LVL97:
	.loc 1 217 17 is_stmt 1 view .LVU449
@ armwave.c:217:                 if(value != 0) {
	.loc 1 217 19 is_stmt 0 view .LVU450
	beq	.L83		@,
	.loc 1 218 21 is_stmt 1 view .LVU451
.LVL98:
	.loc 1 219 21 view .LVU452
	.loc 1 220 21 view .LVU453
	.loc 1 222 21 view .LVU454
	.loc 1 223 21 view .LVU455
	.loc 1 224 21 view .LVU456
	.loc 1 227 21 view .LVU457
	.loc 1 230 21 view .LVU458
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 55 is_stmt 0 view .LVU459
	mul	r4, lr, fp	@ tmp323, _164, _80
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 55 view .LVU460
	mul	r6, lr, r9	@ tmp327, _164, _76
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 24 view .LVU461
	asr	r4, r4, #8	@ bb, tmp323,
.LVL99:
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 55 view .LVU462
	mul	lr, lr, r10	@ tmp333, _164, _70
.LVL100:
@ armwave.c:224:                     b = MIN(bb, 255);
	.loc 1 224 25 view .LVU463
	cmp	r4, #255	@ bb,
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 24 view .LVU464
	asr	r6, r6, #8	@ gg, tmp327,
.LVL101:
@ armwave.c:224:                     b = MIN(bb, 255);
	.loc 1 224 25 view .LVU465
	movge	r4, #255	@ bb,
.LVL102:
@ armwave.c:223:                     g = MIN(gg, 255);
	.loc 1 223 25 view .LVU466
	cmp	r6, #255	@ gg,
	movge	r6, #255	@ gg,
.LVL103:
	.loc 1 223 25 view .LVU467
	add	r7, r3, #2	@ _66, n,
	.loc 1 231 21 is_stmt 1 view .LVU468
	.loc 1 232 21 view .LVU469
	.loc 1 233 21 view .LVU470
	.loc 1 234 21 view .LVU471
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 24 is_stmt 0 view .LVU472
	asr	lr, lr, #8	@ rr, tmp333,
.LVL104:
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 39 view .LVU473
	ldr	r0, [r5, #60]	@ tmp377, g_armwave_state.target_width
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU474
	cmp	lr, #255	@ rr,
@ armwave.c:231:                     xx = nsub & 0xff;
	.loc 1 231 24 view .LVU475
	uxtb	r8, r7	@ xx, _66
.LVL105:
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU476
	lsl	r6, r6, #8	@ tmp328, gg,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU477
	lsl	r4, r4, #16	@ tmp324, bb,
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU478
	movge	lr, #255	@ rr,
.LVL106:
@ armwave.c:232:                     yy = nsub >> 8;
	.loc 1 232 31 view .LVU479
	asr	r7, r7, #8	@ yy, _66,
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 39 view .LVU480
	mla	r7, r0, r8, r7	@ tmp321, tmp377, xx, yy
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU481
	and	r4, r4, #16711680	@ tmp325, tmp324,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU482
	uxth	r6, r6	@ tmp329, tmp328
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 51 view .LVU483
	orr	r6, r4, r6	@ tmp331, tmp325, tmp329
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU484
	uxtb	lr, lr	@ rr, rr
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU485
	ldr	r0, [sp]	@ out_buffer, %sfp
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU486
	orr	lr, r6, lr	@ tmp335, tmp331, rr
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 26 view .LVU487
	orr	lr, lr, #-16777216	@ word, tmp335,
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU488
	str	lr, [r0, r7, lsl #2]	@ word, *_198
.L83:
.LVL107:
	.loc 1 214 17 is_stmt 1 view .LVU489
	.loc 1 215 17 view .LVU490
	.loc 1 217 17 view .LVU491
@ armwave.c:217:                 if(value != 0) {
	.loc 1 217 19 is_stmt 0 view .LVU492
	cmp	r2, #0	@ wave_word,
	beq	.L80		@,
	.loc 1 218 21 is_stmt 1 view .LVU493
.LVL108:
	.loc 1 219 21 view .LVU494
	.loc 1 220 21 view .LVU495
	.loc 1 222 21 view .LVU496
	.loc 1 223 21 view .LVU497
	.loc 1 224 21 view .LVU498
	.loc 1 227 21 view .LVU499
	.loc 1 230 21 view .LVU500
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 55 is_stmt 0 view .LVU501
	mul	lr, r2, fp	@ tmp344, wave_word, _80
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 55 view .LVU502
	mul	r4, r2, r9	@ tmp348, wave_word, _76
@ armwave.c:220:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 220 24 view .LVU503
	asr	lr, lr, #8	@ bb, tmp344,
.LVL109:
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 55 view .LVU504
	mul	r2, r2, r10	@ tmp354, wave_word, _70
.LVL110:
@ armwave.c:224:                     b = MIN(bb, 255);
	.loc 1 224 25 view .LVU505
	cmp	lr, #255	@ bb,
@ armwave.c:219:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 219 24 view .LVU506
	asr	r4, r4, #8	@ gg, tmp348,
.LVL111:
@ armwave.c:224:                     b = MIN(bb, 255);
	.loc 1 224 25 view .LVU507
	movge	lr, #255	@ bb,
.LVL112:
@ armwave.c:223:                     g = MIN(gg, 255);
	.loc 1 223 25 view .LVU508
	cmp	r4, #255	@ gg,
	movge	r4, #255	@ gg,
.LVL113:
	.loc 1 223 25 view .LVU509
	add	r6, r3, #3	@ _59, n,
	.loc 1 231 21 is_stmt 1 view .LVU510
	.loc 1 232 21 view .LVU511
	.loc 1 233 21 view .LVU512
	.loc 1 234 21 view .LVU513
@ armwave.c:218:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 218 24 is_stmt 0 view .LVU514
	asr	r2, r2, #8	@ rr, tmp354,
.LVL114:
@ armwave.c:233:                     offset = yy + (xx * g_armwave_state.target_width);
	.loc 1 233 39 view .LVU515
	ldr	r7, [r5, #60]	@ g_armwave_state.target_width, g_armwave_state.target_width
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU516
	cmp	r2, #255	@ rr,
@ armwave.c:231:                     xx = nsub & 0xff;
	.loc 1 231 24 view .LVU517
	uxtb	r8, r6	@ xx, _59
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU518
	lsl	r4, r4, #8	@ tmp349, gg,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU519
	lsl	lr, lr, #16	@ tmp345, bb,
@ armwave.c:222:                     r = MIN(rr, 255);
	.loc 1 222 25 view .LVU520
	movge	r2, #255	@ rr,
.LVL115:
@ armwave.c:232:                     yy = nsub >> 8;
	.loc 1 232 31 view .LVU521
	asr	r6, r6, #8	@ yy, _59,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 44 view .LVU522
	and	lr, lr, #16711680	@ tmp346, tmp345,
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 56 view .LVU523
	uxth	r4, r4	@ tmp350, tmp349
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 39 view .LVU524
	mla	r6, r7, r8, r6	@ tmp342, g_armwave_state.target_width, xx, yy
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 51 view .LVU525
	orr	lr, lr, r4	@ tmp352, tmp346, tmp350
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU526
	uxtb	r2, r2	@ rr, rr
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU527
	ldr	r0, [sp]	@ out_buffer, %sfp
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 62 view .LVU528
	orr	r2, lr, r2	@ tmp356, tmp352, rr
@ armwave.c:227:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 227 26 view .LVU529
	orr	r2, r2, #-16777216	@ word, tmp356,
@ armwave.c:234:                     *(out_buffer_base + offset) = word;
	.loc 1 234 49 view .LVU530
	str	r2, [r0, r6, lsl #2]	@ word, *_244
	b	.L80		@
.LVL116:
.L101:
	.loc 1 200 5 is_stmt 1 discriminator 1 view .LVU531
	ldr	r3, .L103+4	@,
	mov	r2, #200	@,
	ldr	r1, .L103+8	@,
.LVL117:
	.loc 1 200 5 is_stmt 0 discriminator 1 view .LVU532
	ldr	r0, .L103+12	@,
.LVL118:
	.loc 1 200 5 discriminator 1 view .LVU533
	bl	__assert_fail		@
.LVL119:
.L104:
	.loc 1 200 5 discriminator 1 view .LVU534
	.align	2
.L103:
	.word	g_armwave_state
	.word	.LANCHOR0+24
	.word	.LC0
	.word	.LC6
	.cfi_endproc
.LFE63:
	.size	armwave_fill_pixbuf_256, .-armwave_fill_pixbuf_256
	.align	2
	.global	armwave_fill_pixbuf_scaled
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_fill_pixbuf_scaled, %function
armwave_fill_pixbuf_scaled:
.LVL120:
.LFB64:
	.loc 1 246 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 247 5 view .LVU536
	.loc 1 248 5 view .LVU537
	.loc 1 249 5 view .LVU538
	.loc 1 250 5 view .LVU539
@ armwave.c:246: {
	.loc 1 246 1 is_stmt 0 view .LVU540
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	.cfi_def_cfa_offset 36
	.cfi_offset 4, -36
	.cfi_offset 5, -32
	.cfi_offset 6, -28
	.cfi_offset 7, -24
	.cfi_offset 8, -20
	.cfi_offset 9, -16
	.cfi_offset 10, -12
	.cfi_offset 11, -8
	.cfi_offset 14, -4
@ armwave.c:254:     assert(out_buffer != NULL);
	.loc 1 254 5 view .LVU541
	cmp	r0, #0	@ out_buffer
@ armwave.c:250:     uint32_t *base_32ptr = (uint32_t*)g_armwave_state.ch1_buffer;
	.loc 1 250 15 view .LVU542
	ldr	r5, .L130	@ tmp202,
@ armwave.c:246: {
	.loc 1 246 1 view .LVU543
	sub	sp, sp, #12	@,,
	.cfi_def_cfa_offset 48
@ armwave.c:250:     uint32_t *base_32ptr = (uint32_t*)g_armwave_state.ch1_buffer;
	.loc 1 250 15 view .LVU544
	ldr	r6, [r5, #4]	@ base_32ptr, g_armwave_state.ch1_buffer
.LVL121:
	.loc 1 251 5 is_stmt 1 view .LVU545
	.loc 1 252 5 view .LVU546
	.loc 1 254 5 view .LVU547
	beq	.L127		@,
	.loc 1 256 5 view .LVU548
@ armwave.c:256:     npix = g_armwave_state.target_width * 256; 
	.loc 1 256 41 is_stmt 0 view .LVU549
	ldr	r8, [r5, #60]	@ g_armwave_state.target_width, g_armwave_state.target_width
	lsl	r8, r8, #8	@ npix, g_armwave_state.target_width,
.LVL122:
	.loc 1 257 5 is_stmt 1 view .LVU550
	.loc 1 259 5 view .LVU551
	.loc 1 259 5 is_stmt 0 view .LVU552
	cmp	r8, #0	@ npix,
	ble	.L105		@,
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 52 view .LVU553
	ldrsh	r3, [r5, #82]	@ _11, g_armwave_state.ch1_color.g
@ armwave.c:271:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 271 52 view .LVU554
	ldrsh	fp, [r5, #80]	@ _7, g_armwave_state.ch1_color.r
@ armwave.c:259:     for(n = 0; n < npix; n += 4) {
	.loc 1 259 11 view .LVU555
	mov	lr, #0	@ n,
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 52 view .LVU556
	str	r3, [sp]	@ _11, %sfp
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 52 view .LVU557
	ldrsh	r3, [r5, #84]	@ _14, g_armwave_state.ch1_color.b
	str	r3, [sp, #4]	@ _14, %sfp
.LVL123:
.L112:
	.loc 1 263 9 is_stmt 1 view .LVU558
@ armwave.c:263:         wave_word = *base_32ptr++;
	.loc 1 263 19 is_stmt 0 view .LVU559
	ldr	ip, [r6], #4	@ wave_word, MEM[base: base_32ptr_53, offset: 4294967292B]
.LVL124:
	.loc 1 265 9 is_stmt 1 view .LVU560
@ armwave.c:265:         if(COND_UNLIKELY(wave_word != 0)) {
	.loc 1 265 11 is_stmt 0 view .LVU561
	cmp	ip, #0	@ wave_word,
	bne	.L128		@,
.L108:
@ armwave.c:259:     for(n = 0; n < npix; n += 4) {
	.loc 1 259 28 view .LVU562
	add	lr, lr, #4	@ n, n,
.LVL125:
@ armwave.c:259:     for(n = 0; n < npix; n += 4) {
	.loc 1 259 5 view .LVU563
	cmp	r8, lr	@ npix, n
	bgt	.L112		@,
.LVL126:
.L105:
@ armwave.c:295: }
	.loc 1 295 1 view .LVU564
	add	sp, sp, #12	@,,
	.cfi_remember_state
	.cfi_def_cfa_offset 36
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
.LVL127:
.L128:
	.cfi_restore_state
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 view .LVU565
	ands	r3, ip, #255	@ _8, wave_word,
@ armwave.c:266:             for(w = 0; w < 4; w++) {
	.loc 1 266 19 view .LVU566
	mov	r9, #0	@ w,
.LVL128:
	.loc 1 267 17 is_stmt 1 view .LVU567
	.loc 1 268 17 view .LVU568
@ armwave.c:268:                 wave_word >>= 8;
	.loc 1 268 27 is_stmt 0 view .LVU569
	lsr	ip, ip, #8	@ wave_word, wave_word,
.LVL129:
	.loc 1 270 17 is_stmt 1 view .LVU570
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 is_stmt 0 view .LVU571
	bne	.L129		@,
.L109:
@ armwave.c:266:             for(w = 0; w < 4; w++) {
	.loc 1 266 32 view .LVU572
	add	r9, r9, #1	@ w, w,
.LVL130:
@ armwave.c:266:             for(w = 0; w < 4; w++) {
	.loc 1 266 13 view .LVU573
	cmp	r9, #4	@ w,
	beq	.L108		@,
	.loc 1 267 17 is_stmt 1 view .LVU574
.LVL131:
	.loc 1 268 17 view .LVU575
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 is_stmt 0 view .LVU576
	ands	r3, ip, #255	@ _8, wave_word,
@ armwave.c:268:                 wave_word >>= 8;
	.loc 1 268 27 view .LVU577
	lsr	ip, ip, #8	@ wave_word, wave_word,
.LVL132:
	.loc 1 270 17 is_stmt 1 view .LVU578
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 is_stmt 0 view .LVU579
	beq	.L109		@,
.L129:
	.loc 1 271 21 is_stmt 1 view .LVU580
.LVL133:
	.loc 1 272 21 view .LVU581
	.loc 1 273 21 view .LVU582
	.loc 1 275 21 view .LVU583
	.loc 1 276 21 view .LVU584
	.loc 1 277 21 view .LVU585
	.loc 1 280 21 view .LVU586
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 55 is_stmt 0 view .LVU587
	ldr	r2, [sp, #4]	@ _14, %sfp
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 55 view .LVU588
	ldr	r1, [sp]	@ _11, %sfp
	add	r7, lr, r9	@ _113, n, w
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 55 view .LVU589
	mul	r2, r2, r3	@ tmp179, _14, _8
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 55 view .LVU590
	mul	r1, r1, r3	@ tmp183, _11, _8
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 24 view .LVU591
	asr	r2, r2, #8	@ bb, tmp179,
.LVL134:
@ armwave.c:271:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 271 55 view .LVU592
	mul	r3, r3, fp	@ tmp189, _8, _7
.LVL135:
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 24 view .LVU593
	asr	r1, r1, #8	@ gg, tmp183,
.LVL136:
@ armwave.c:277:                     b = MIN(bb, 255);
	.loc 1 277 25 view .LVU594
	cmp	r2, #255	@ bb,
	movge	r2, #255	@ bb,
.LVL137:
@ armwave.c:276:                     g = MIN(gg, 255);
	.loc 1 276 25 view .LVU595
	cmp	r1, #255	@ gg,
	movge	r1, #255	@ gg,
.LVL138:
@ armwave.c:271:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 271 24 view .LVU596
	asr	r3, r3, #8	@ rr, tmp189,
.LVL139:
@ armwave.c:275:                     r = MIN(rr, 255);
	.loc 1 275 25 view .LVU597
	cmp	r3, #255	@ rr,
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 56 view .LVU598
	lsl	r1, r1, #8	@ tmp184, gg,
@ armwave.c:275:                     r = MIN(rr, 255);
	.loc 1 275 25 view .LVU599
	movge	r3, #255	@ rr,
.LVL140:
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 44 view .LVU600
	lsl	r4, r2, #16	@ tmp180, bb,
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 56 view .LVU601
	uxth	r1, r1	@ tmp185, tmp184
@ armwave.c:284:                     yy = (nsub & 0xff) * g_armwave_state.vscale;
	.loc 1 284 57 view .LVU602
	ldr	r10, [r5, #28]	@ _28, g_armwave_state.vscale
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 44 view .LVU603
	and	r4, r4, #16711680	@ tmp181, tmp180,
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 51 view .LVU604
	orr	r4, r4, r1	@ tmp187, tmp181, tmp185
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 62 view .LVU605
	uxtb	r3, r3	@ rr, rr
@ armwave.c:284:                     yy = (nsub & 0xff) * g_armwave_state.vscale;
	.loc 1 284 32 view .LVU606
	uxtb	r1, r7	@ _113, _113
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 62 view .LVU607
	orr	r4, r4, r3	@ tmp191, tmp187, rr
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 21 view .LVU608
	cmp	r10, #0	@ _28,
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 26 view .LVU609
	orr	r4, r4, #-16777216	@ word, tmp191,
.LVL141:
	.loc 1 283 21 is_stmt 1 view .LVU610
	.loc 1 284 21 view .LVU611
@ armwave.c:285:                     xx = (nsub >> 8);
	.loc 1 285 32 is_stmt 0 view .LVU612
	asr	r7, r7, #8	@ xx, _113,
.LVL142:
@ armwave.c:284:                     yy = (nsub & 0xff) * g_armwave_state.vscale;
	.loc 1 284 24 view .LVU613
	mul	r10, r10, r1	@ yy, _28, _113
.LVL143:
	.loc 1 285 21 is_stmt 1 view .LVU614
	.loc 1 287 21 view .LVU615
	.loc 1 287 21 is_stmt 0 view .LVU616
	beq	.L109		@,
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 29 view .LVU617
	mov	r3, #0	@ row,
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 38 view .LVU618
	mov	r2, r3	@ _35, row
.LVL144:
.L110:
	.loc 1 288 25 is_stmt 1 discriminator 3 view .LVU619
	.loc 1 289 25 discriminator 3 view .LVU620
@ armwave.c:288:                         offset = (xx + ((yy + row) * g_armwave_state.target_width)); 
	.loc 1 288 52 is_stmt 0 discriminator 3 view .LVU621
	ldr	r1, [r5, #60]	@ g_armwave_state.target_width, g_armwave_state.target_width
@ armwave.c:288:                         offset = (xx + ((yy + row) * g_armwave_state.target_width)); 
	.loc 1 288 45 discriminator 3 view .LVU622
	add	r2, r2, r10	@ tmp194, _35, yy
.LVL145:
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 67 discriminator 3 view .LVU623
	add	r3, r3, #1	@ tmp199, row,
.LVL146:
@ armwave.c:289:                         *(out_buffer_base + offset) = word;
	.loc 1 289 43 discriminator 3 view .LVU624
	mla	r1, r1, r2, r7	@ tmp198, g_armwave_state.target_width, tmp194, xx
.LVL147:
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 67 discriminator 3 view .LVU625
	uxtb	r3, r3	@ row, tmp199
.LVL148:
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 38 discriminator 3 view .LVU626
	mov	r2, r3	@ _35, row
@ armwave.c:289:                         *(out_buffer_base + offset) = word;
	.loc 1 289 53 discriminator 3 view .LVU627
	str	r4, [r0, r1, lsl #2]	@ word, *_34
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 21 discriminator 3 view .LVU628
	ldr	r1, [r5, #28]	@ g_armwave_state.vscale, g_armwave_state.vscale
.LVL149:
	.loc 1 287 21 discriminator 3 view .LVU629
	cmp	r3, r1	@ row, g_armwave_state.vscale
	bcc	.L110		@,
	.loc 1 287 21 discriminator 3 view .LVU630
	b	.L109		@
.LVL150:
.L127:
	.loc 1 254 5 is_stmt 1 discriminator 1 view .LVU631
	ldr	r3, .L130+4	@,
	mov	r2, #254	@,
	ldr	r1, .L130+8	@,
	ldr	r0, .L130+12	@,
.LVL151:
	.loc 1 254 5 is_stmt 0 discriminator 1 view .LVU632
	bl	__assert_fail		@
.LVL152:
.L131:
	.align	2
.L130:
	.word	g_armwave_state
	.word	.LANCHOR0+48
	.word	.LC0
	.word	.LC6
	.cfi_endproc
.LFE64:
	.size	armwave_fill_pixbuf_scaled, .-armwave_fill_pixbuf_scaled
	.align	2
	.global	armwave_dump_ppm_debug
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_dump_ppm_debug, %function
armwave_dump_ppm_debug:
.LVL153:
.LFB65:
	.loc 1 298 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 299 5 view .LVU634
@ armwave.c:298: {
	.loc 1 298 1 is_stmt 0 view .LVU635
	mov	r3, r1	@ fn, fn
	push	{r4, r5, r6, r7, r8, r9, lr}	@
	.cfi_def_cfa_offset 28
	.cfi_offset 4, -28
	.cfi_offset 5, -24
	.cfi_offset 6, -20
	.cfi_offset 7, -16
	.cfi_offset 8, -12
	.cfi_offset 9, -8
	.cfi_offset 14, -4
	mov	r8, r0	@ buffer, buffer
	sub	sp, sp, #12	@,,
	.cfi_def_cfa_offset 40
@ armwave.c:299:     FILE *fp = fopen(fn, "wb");
	.loc 1 299 16 view .LVU636
	ldr	r1, .L144	@,
.LVL154:
	.loc 1 299 16 view .LVU637
	mov	r0, r3	@, fn
.LVL155:
	.loc 1 299 16 view .LVU638
	bl	fopen64		@
.LVL156:
@ armwave.c:306:     fprintf(fp, "%d %d\n", g_armwave_state.target_height, g_armwave_state.target_width);
	.loc 1 306 5 view .LVU639
	ldr	r6, .L144+4	@ tmp154,
@ armwave.c:305:     fputs("P3\n", fp);
	.loc 1 305 5 view .LVU640
	mov	r2, #3	@,
	mov	r1, #1	@,
@ armwave.c:299:     FILE *fp = fopen(fn, "wb");
	.loc 1 299 16 view .LVU641
	mov	r7, r0	@ fp,
.LVL157:
	.loc 1 300 5 is_stmt 1 view .LVU642
	.loc 1 301 5 view .LVU643
	.loc 1 305 5 view .LVU644
	mov	r3, r0	@, fp
	ldr	r0, .L144+8	@,
.LVL158:
	.loc 1 305 5 is_stmt 0 view .LVU645
	bl	fwrite		@
.LVL159:
	.loc 1 306 5 is_stmt 1 view .LVU646
	ldr	r3, [r6, #60]	@, g_armwave_state.target_width
	ldr	r2, [r6, #64]	@, g_armwave_state.target_height
	ldr	r1, .L144+12	@,
	mov	r0, r7	@, fp
	bl	fprintf		@
.LVL160:
	.loc 1 307 5 view .LVU647
	mov	r2, #4	@,
	mov	r3, r7	@, fp
	mov	r1, #1	@,
	ldr	r0, .L144+16	@,
	bl	fwrite		@
.LVL161:
	.loc 1 309 5 view .LVU648
@ armwave.c:309:     for(yy = 0; yy < g_armwave_state.target_height; yy++) {
	.loc 1 309 37 is_stmt 0 view .LVU649
	ldr	r2, [r6, #64]	@ prephitmp_57, g_armwave_state.target_height
@ armwave.c:309:     for(yy = 0; yy < g_armwave_state.target_height; yy++) {
	.loc 1 309 5 view .LVU650
	cmp	r2, #0	@ prephitmp_57,
	beq	.L133		@,
	ldr	r3, [r6, #60]	@ _12, g_armwave_state.target_width
@ armwave.c:314:             fprintf(fp, "%3d %3d %3d\n", data & 0xff, (data >> 8) & 0xff, (data >> 16) & 0xff);
	.loc 1 314 13 view .LVU651
	ldr	r9, .L144+20	@ tmp156,
@ armwave.c:309:     for(yy = 0; yy < g_armwave_state.target_height; yy++) {
	.loc 1 309 12 view .LVU652
	mov	r5, #0	@ yy,
.LVL162:
.L134:
@ armwave.c:310:         for(xx = 0; xx < g_armwave_state.target_width; xx++) {
	.loc 1 310 9 view .LVU653
	cmp	r3, #0	@ _12,
@ armwave.c:310:         for(xx = 0; xx < g_armwave_state.target_width; xx++) {
	.loc 1 310 16 view .LVU654
	movne	r4, #0	@ xx,
@ armwave.c:310:         for(xx = 0; xx < g_armwave_state.target_width; xx++) {
	.loc 1 310 9 view .LVU655
	beq	.L143		@,
.LVL163:
.L135:
	.loc 1 311 13 is_stmt 1 discriminator 3 view .LVU656
@ armwave.c:311:             data = *(buffer + (xx + (yy * g_armwave_state.target_width)));
	.loc 1 311 29 is_stmt 0 discriminator 3 view .LVU657
	mla	r3, r5, r3, r4	@ tmp145, yy, _12, xx
@ armwave.c:314:             fprintf(fp, "%3d %3d %3d\n", data & 0xff, (data >> 8) & 0xff, (data >> 16) & 0xff);
	.loc 1 314 13 discriminator 3 view .LVU658
	mov	r1, r9	@, tmp156
	mov	r0, r7	@, fp
@ armwave.c:311:             data = *(buffer + (xx + (yy * g_armwave_state.target_width)));
	.loc 1 311 18 discriminator 3 view .LVU659
	ldr	r2, [r8, r3, lsl #2]	@ data, *_6
.LVL164:
	.loc 1 314 13 is_stmt 1 discriminator 3 view .LVU660
@ armwave.c:310:         for(xx = 0; xx < g_armwave_state.target_width; xx++) {
	.loc 1 310 58 is_stmt 0 discriminator 3 view .LVU661
	add	r4, r4, #1	@ xx, xx,
.LVL165:
@ armwave.c:314:             fprintf(fp, "%3d %3d %3d\n", data & 0xff, (data >> 8) & 0xff, (data >> 16) & 0xff);
	.loc 1 314 81 discriminator 3 view .LVU662
	lsr	ip, r2, #16	@ tmp150, data,
@ armwave.c:314:             fprintf(fp, "%3d %3d %3d\n", data & 0xff, (data >> 8) & 0xff, (data >> 16) & 0xff);
	.loc 1 314 61 discriminator 3 view .LVU663
	lsr	r3, r2, #8	@ tmp146, data,
@ armwave.c:314:             fprintf(fp, "%3d %3d %3d\n", data & 0xff, (data >> 8) & 0xff, (data >> 16) & 0xff);
	.loc 1 314 13 discriminator 3 view .LVU664
	uxtb	ip, ip	@ tmp151, tmp150
	uxtb	r3, r3	@, tmp146
	str	ip, [sp]	@ tmp151,
	uxtb	r2, r2	@, data
.LVL166:
	.loc 1 314 13 discriminator 3 view .LVU665
	bl	fprintf		@
.LVL167:
@ armwave.c:310:         for(xx = 0; xx < g_armwave_state.target_width; xx++) {
	.loc 1 310 41 discriminator 3 view .LVU666
	ldr	r3, [r6, #60]	@ _12, g_armwave_state.target_width
@ armwave.c:310:         for(xx = 0; xx < g_armwave_state.target_width; xx++) {
	.loc 1 310 9 discriminator 3 view .LVU667
	cmp	r3, r4	@ _12, xx
	bhi	.L135		@,
	ldr	r2, [r6, #64]	@ prephitmp_57, g_armwave_state.target_height
.LVL168:
.L136:
@ armwave.c:309:     for(yy = 0; yy < g_armwave_state.target_height; yy++) {
	.loc 1 309 55 discriminator 2 view .LVU668
	add	r5, r5, #1	@ yy, yy,
.LVL169:
@ armwave.c:309:     for(yy = 0; yy < g_armwave_state.target_height; yy++) {
	.loc 1 309 5 discriminator 2 view .LVU669
	cmp	r5, r2	@ yy, prephitmp_57
	bcc	.L134		@,
.LVL170:
.L133:
	.loc 1 318 5 is_stmt 1 view .LVU670
	mov	r0, r7	@, fp
@ armwave.c:319: }
	.loc 1 319 1 is_stmt 0 view .LVU671
	add	sp, sp, #12	@,,
	.cfi_remember_state
	.cfi_def_cfa_offset 28
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, lr}	@
	.cfi_restore 14
	.cfi_restore 9
	.cfi_restore 8
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 5
	.cfi_restore 4
	.cfi_def_cfa_offset 0
.LVL171:
@ armwave.c:318:     fclose(fp);
	.loc 1 318 5 view .LVU672
	b	fclose		@
.LVL172:
.L143:
	.cfi_restore_state
@ armwave.c:309:     for(yy = 0; yy < g_armwave_state.target_height; yy++) {
	.loc 1 309 55 view .LVU673
	add	r5, r5, #1	@ yy, yy,
.LVL173:
@ armwave.c:309:     for(yy = 0; yy < g_armwave_state.target_height; yy++) {
	.loc 1 309 5 view .LVU674
	cmp	r2, r5	@ prephitmp_57, yy
	bhi	.L136		@,
	b	.L133		@
.L145:
	.align	2
.L144:
	.word	.LC7
	.word	g_armwave_state
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.cfi_endproc
.LFE65:
	.size	armwave_dump_ppm_debug, .-armwave_dump_ppm_debug
	.align	2
	.global	armwave_test_init
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_test_init, %function
armwave_test_init:
.LVL174:
.LFB66:
	.loc 1 322 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 323 5 view .LVU676
.LBB10:
.LBI10:
	.loc 1 45 6 view .LVU677
	.loc 1 45 6 is_stmt 0 view .LVU678
.LBE10:
@ armwave.c:322: {
	.loc 1 322 1 view .LVU679
	push	{r4, r5, r6, r7, r8, lr}	@
	.cfi_def_cfa_offset 24
	.cfi_offset 4, -24
	.cfi_offset 5, -20
	.cfi_offset 6, -16
	.cfi_offset 7, -12
	.cfi_offset 8, -8
	.cfi_offset 14, -4
	vpush.64	{d8, d9, d10}	@
	.cfi_def_cfa_offset 48
	.cfi_offset 80, -48
	.cfi_offset 81, -44
	.cfi_offset 82, -40
	.cfi_offset 83, -36
	.cfi_offset 84, -32
	.cfi_offset 85, -28
	ldr	r4, .L150+20	@ ivtmp.95,
.LBB13:
.LBB11:
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 32 view .LVU680
	vldr.32	s20, .L150+16	@ tmp132,
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 26 view .LVU681
	vldr.64	d9, .L150	@ tmp146,
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 49 view .LVU682
	vldr.64	d8, .L150+8	@ tmp135,
	add	r3, r4, #1	@ _34, ivtmp.95,
.LBE11:
.LBE13:
@ armwave.c:322: {
	.loc 1 322 1 view .LVU683
	mov	r6, r0	@ render_width, render_width
	mov	r7, r1	@ render_height, render_height
	add	r8, r4, #256	@ _35, ivtmp.95,
	rsb	r5, r3, #1	@ tmp145, _34,
.LVL175:
.L147:
.LBB14:
.LBB12:
	.loc 1 51 9 is_stmt 1 view .LVU684
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 32 is_stmt 0 view .LVU685
	add	r3, r5, r4	@ tmp129, tmp145, ivtmp.95
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 26 view .LVU686
	vmov.f64	d1, d9	@, tmp146
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 32 view .LVU687
	vmov	s15, r3	@ int	@ tmp129, tmp129
	vcvt.f32.s32	s15, s15	@ tmp130, tmp129
	vdiv.f32	s0, s15, s20	@ tmp131, tmp130, tmp132
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 26 view .LVU688
	vcvt.f64.f32	d0, s0	@, tmp131
	bl	pow		@
.LVL176:
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 49 view .LVU689
	vmul.f64	d0, d0, d8	@ tmp134,, tmp135
@ armwave.c:51:         gamma_table[i] = pow(i / 255.0f, gamma) * 255.0f;
	.loc 1 51 24 view .LVU690
	vcvt.u32.f64	s15, d0	@ tmp136, tmp134
	vmov	r3, s15	@ int	@ tmp136, tmp136
	strb	r3, [r4, #1]!	@ tmp136, MEM[base: _33, offset: 0B]
.LVL177:
@ armwave.c:50:     for(i = 0; i < 256; i++) {
	.loc 1 50 5 view .LVU691
	cmp	r4, r8	@ ivtmp.95, _35
	bne	.L147		@,
.LVL178:
	.loc 1 50 5 view .LVU692
.LBE12:
.LBE14:
	.loc 1 326 5 is_stmt 1 view .LVU693
.LBB15:
.LBI15:
	.loc 1 176 6 view .LVU694
.LBB16:
	.loc 1 179 5 view .LVU695
	.loc 1 181 13 view .LVU696
	.loc 1 182 13 view .LVU697
@ armwave.c:181:             g_armwave_state.ch1_color.r = r;
	.loc 1 181 41 is_stmt 0 view .LVU698
	ldr	r3, .L150+24	@ tmp138,
	ldr	ip, .L150+28	@ tmp139,
.LBE16:
.LBE15:
@ armwave.c:328:     armwave_setup_render(&test_wave_buffer, 0, TEST_WAVE_SIZE, TEST_NWAVES, TEST_WAVE_SIZE, render_width, render_height, 0x00000000);
	.loc 1 328 5 view .LVU699
	mov	r1, r7	@, render_height
	mov	r0, r6	@, render_width
.LBB18:
.LBB17:
@ armwave.c:183:             g_armwave_state.ch1_color.b = b;
	.loc 1 183 41 view .LVU700
	mov	r2, #250	@ tmp142,
@ armwave.c:181:             g_armwave_state.ch1_color.r = r;
	.loc 1 181 41 view .LVU701
	str	ip, [r3, #80]	@ tmp139, MEM[(short int *)&g_armwave_state + 80B]
	.loc 1 183 13 is_stmt 1 view .LVU702
@ armwave.c:183:             g_armwave_state.ch1_color.b = b;
	.loc 1 183 41 is_stmt 0 view .LVU703
	strh	r2, [r3, #84]	@ movhi	@ tmp142, g_armwave_state.ch1_color.b
	.loc 1 184 13 is_stmt 1 view .LVU704
.LVL179:
	.loc 1 184 13 is_stmt 0 view .LVU705
.LBE17:
.LBE18:
	.loc 1 328 5 is_stmt 1 view .LVU706
	bl	armwave_setup_render.constprop.0		@
.LVL180:
	.loc 1 330 5 view .LVU707
@ armwave.c:331: }
	.loc 1 331 1 is_stmt 0 view .LVU708
	vldm	sp!, {d8-d10}	@,
	.cfi_restore 84
	.cfi_restore 85
	.cfi_restore 82
	.cfi_restore 83
	.cfi_restore 80
	.cfi_restore 81
	.cfi_def_cfa_offset 24
@ armwave.c:330:     printf("armwave version: %s\n", ARMWAVE_VER);
	.loc 1 330 5 view .LVU709
	ldr	r1, .L150+32	@,
	ldr	r0, .L150+36	@,
@ armwave.c:331: }
	.loc 1 331 1 view .LVU710
	pop	{r4, r5, r6, r7, r8, lr}	@
	.cfi_restore 14
	.cfi_restore 8
	.cfi_restore 7
	.cfi_restore 6
	.cfi_restore 5
	.cfi_restore 4
	.cfi_def_cfa_offset 0
.LVL181:
@ armwave.c:330:     printf("armwave version: %s\n", ARMWAVE_VER);
	.loc 1 330 5 view .LVU711
	b	printf		@
.LVL182:
.L151:
	.align	3
.L150:
	.word	-1073741824
	.word	1072483532
	.word	0
	.word	1081073664
	.word	1132396544
	.word	gamma_table-1
	.word	g_armwave_state
	.word	116656630
	.word	.LC12
	.word	.LC13
	.cfi_endproc
.LFE66:
	.size	armwave_test_init, .-armwave_test_init
	.global	__aeabi_uidiv
	.align	2
	.global	armwave_test_generate
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_test_generate, %function
armwave_test_generate:
.LFB67:
	.loc 1 334 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 335 5 view .LVU713
	.loc 1 337 5 view .LVU714
@ armwave.c:334: {
	.loc 1 334 1 is_stmt 0 view .LVU715
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	.cfi_offset 4, -36
	.cfi_offset 5, -32
	.cfi_offset 6, -28
	.cfi_offset 7, -24
	.cfi_offset 8, -20
	.cfi_offset 9, -16
	.cfi_offset 10, -12
	.cfi_offset 11, -8
	.cfi_offset 14, -4
@ armwave.c:337:     memset(g_armwave_state.ch1_buffer, 0, g_armwave_state.ch_buff_size);
	.loc 1 337 5 view .LVU716
	mov	r1, #0	@,
	ldr	r4, .L170	@ tmp255,
	ldr	r2, [r4, #52]	@, g_armwave_state.ch_buff_size
	ldr	r0, [r4, #4]	@, g_armwave_state.ch1_buffer
	bl	memset		@
.LVL183:
	.loc 1 339 5 is_stmt 1 view .LVU717
@ armwave.c:339:     for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 339 45 is_stmt 0 view .LVU718
	ldr	r9, [r4, #44]	@ _92, g_armwave_state.slice_height
@ armwave.c:339:     for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 339 5 view .LVU719
	cmp	r9, #2048	@ _92,
	pophi	{r3, r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
	ldr	r8, [r4, #36]	@ prephitmp_177, g_armwave_state.waves
@ armwave.c:339:     for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 339 12 view .LVU720
	mov	r5, #0	@ yy,
.LVL184:
.L158:
	.loc 1 340 9 is_stmt 1 discriminator 3 view .LVU721
	mul	r6, r9, r5	@ _3, _92, yy
.LBB21:
.LBB22:
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 63 is_stmt 0 discriminator 3 view .LVU722
	ldr	r0, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 discriminator 3 view .LVU723
	cmp	r8, #0	@ prephitmp_177,
.LBE22:
.LBE21:
@ armwave.c:340:         render_nonaa_to_buffer_1ch_slice(yy * g_armwave_state.slice_height, g_armwave_state.slice_record_height);
	.loc 1 340 9 discriminator 3 view .LVU724
	ldr	r7, [r4, #48]	@ _4, g_armwave_state.slice_record_height
.LVL185:
.LBB24:
.LBI21:
	.loc 1 63 6 is_stmt 1 discriminator 3 view .LVU725
.LBB23:
	.loc 1 65 5 discriminator 3 view .LVU726
	.loc 1 66 5 discriminator 3 view .LVU727
	.loc 1 67 5 discriminator 3 view .LVU728
	.loc 1 68 5 discriminator 3 view .LVU729
	.loc 1 69 5 discriminator 3 view .LVU730
	.loc 1 71 5 discriminator 3 view .LVU731
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 63 is_stmt 0 discriminator 3 view .LVU732
	mul	r0, r0, r6	@ _15, g_armwave_state.bitdepth_height, _3
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 40 discriminator 3 view .LVU733
	ldr	r3, [r4, #4]	@ _13, g_armwave_state.ch1_buffer
.LVL186:
	.loc 1 74 5 is_stmt 1 discriminator 3 view .LVU734
	.loc 1 74 5 is_stmt 0 discriminator 3 view .LVU735
	beq	.L154		@,
	sub	r6, r6, #4	@ _76, _3,
.LVL187:
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 11 view .LVU736
	mov	lr, #0	@ w,
.LVL188:
.L157:
	.loc 1 75 9 is_stmt 1 view .LVU737
@ armwave.c:75:         wave_base = g_armwave_state.wave_buffer + slice_y + (w * g_armwave_state.wave_stride);
	.loc 1 75 64 is_stmt 0 view .LVU738
	ldr	r2, [r4, #32]	@ g_armwave_state.wave_stride, g_armwave_state.wave_stride
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 view .LVU739
	cmp	r7, #0	@ _4,
@ armwave.c:75:         wave_base = g_armwave_state.wave_buffer + slice_y + (w * g_armwave_state.wave_stride);
	.loc 1 75 36 view .LVU740
	ldr	ip, [r4, #20]	@ _16, g_armwave_state.wave_buffer
@ armwave.c:75:         wave_base = g_armwave_state.wave_buffer + slice_y + (w * g_armwave_state.wave_stride);
	.loc 1 75 64 view .LVU741
	mul	r2, r2, lr	@ _19, g_armwave_state.wave_stride, w
.LVL189:
	.loc 1 79 9 is_stmt 1 view .LVU742
	.loc 1 79 9 is_stmt 0 view .LVU743
	beq	.L155		@,
	add	r2, r2, r6	@ tmp203, _19, _76
.LVL190:
	.loc 1 79 9 view .LVU744
	add	ip, ip, r2	@ ivtmp.101, _16, tmp203
.LVL191:
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 16 view .LVU745
	mov	r2, #0	@ yy,
.LVL192:
.L156:
	.loc 1 80 13 is_stmt 1 view .LVU746
@ armwave.c:80:             word = *(uint32_t*)(wave_base + yy);
	.loc 1 80 18 is_stmt 0 view .LVU747
	ldr	r1, [ip, #4]!	@ word, MEM[base: _189, offset: 0B]
.LVL193:
	.loc 1 82 13 is_stmt 1 view .LVU748
	.loc 1 84 17 view .LVU749
	.loc 1 85 17 view .LVU750
	.loc 1 86 17 view .LVU751
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU752
	ldr	r9, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
	add	fp, r2, #1	@ tmp215, yy,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU753
	uxtab	r8, r0, r1	@ tmp208, _15, word
	mla	r9, r9, r2, r8	@ tmp209, g_armwave_state.bitdepth_height, yy, tmp208
@ armwave.c:87:                 word >>= 8;
	.loc 1 87 22 view .LVU754
	lsr	r10, r1, #8	@ word, word,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU755
	ldrb	r8, [r3, r9]	@ zero_extendqisi2	@ *_63, *_63
	uxtab	r10, r0, r10	@ tmp220, _15, word
	add	r8, r8, #1	@ tmp212, *_63,
	strb	r8, [r3, r9]	@ tmp212, *_63
.LVL194:
	.loc 1 87 17 is_stmt 1 view .LVU756
	.loc 1 84 17 view .LVU757
	.loc 1 85 17 view .LVU758
	.loc 1 86 17 view .LVU759
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU760
	ldr	r8, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:87:                 word >>= 8;
	.loc 1 87 22 view .LVU761
	lsr	r9, r1, #16	@ word, word,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU762
	add	r1, r0, r1, lsr #24	@ tmp243, _15, word,
.LVL195:
	.loc 1 86 47 view .LVU763
	mla	r8, r8, fp, r10	@ tmp221, g_armwave_state.bitdepth_height, tmp215, tmp220
	uxtab	r10, r0, r9	@ tmp228, _15, word
	ldrb	fp, [r3, r8]	@ zero_extendqisi2	@ *_83, *_83
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 view .LVU764
	add	r9, r2, #2	@ tmp230, yy,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU765
	add	fp, fp, #1	@ tmp224, *_83,
	strb	fp, [r3, r8]	@ tmp224, *_83
.LVL196:
	.loc 1 87 17 is_stmt 1 view .LVU766
	.loc 1 84 17 view .LVU767
	.loc 1 85 17 view .LVU768
	.loc 1 86 17 view .LVU769
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU770
	ldr	fp, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
	add	r8, r2, #3	@ tmp239, yy,
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 37 view .LVU771
	add	r2, r2, #4	@ yy, yy,
.LVL197:
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU772
	mla	r9, fp, r9, r10	@ tmp233, g_armwave_state.bitdepth_height, tmp230, tmp228
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 view .LVU773
	cmp	r7, r2	@ _4, yy
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU774
	ldrb	r10, [r3, r9]	@ zero_extendqisi2	@ *_103, *_103
	add	r10, r10, #1	@ tmp236, *_103,
	strb	r10, [r3, r9]	@ tmp236, *_103
.LVL198:
	.loc 1 87 17 is_stmt 1 view .LVU775
	.loc 1 84 17 view .LVU776
	.loc 1 85 17 view .LVU777
	.loc 1 86 17 view .LVU778
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU779
	ldr	r9, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU780
	mla	r1, r9, r8, r1	@ tmp244, g_armwave_state.bitdepth_height, tmp239, tmp243
	ldrb	r8, [r3, r1]	@ zero_extendqisi2	@ *_123, *_123
	add	r8, r8, #1	@ tmp247, *_123,
	strb	r8, [r3, r1]	@ tmp247, *_123
	.loc 1 87 17 is_stmt 1 view .LVU781
.LVL199:
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 is_stmt 0 view .LVU782
	bhi	.L156		@,
	ldr	r8, [r4, #36]	@ prephitmp_177, g_armwave_state.waves
.LVL200:
.L155:
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 44 view .LVU783
	add	lr, lr, #1	@ w, w,
.LVL201:
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 view .LVU784
	cmp	lr, r8	@ w, prephitmp_177
	bcc	.L157		@,
	ldr	r9, [r4, #44]	@ _92, g_armwave_state.slice_height
.LVL202:
.L154:
	.loc 1 74 5 view .LVU785
.LBE23:
.LBE24:
@ armwave.c:339:     for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 339 28 discriminator 3 view .LVU786
	mov	r1, r9	@, _92
	mov	r0, #2048	@,
.LVL203:
	.loc 1 339 28 discriminator 3 view .LVU787
	bl	__aeabi_uidiv		@
.LVL204:
@ armwave.c:339:     for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 339 63 discriminator 3 view .LVU788
	add	r5, r5, #1	@ yy, yy,
.LVL205:
@ armwave.c:339:     for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 339 5 discriminator 3 view .LVU789
	cmp	r0, r5	@, yy
	bhi	.L158		@,
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
.L171:
	.align	2
.L170:
	.word	g_armwave_state
	.cfi_endproc
.LFE67:
	.size	armwave_test_generate, .-armwave_test_generate
	.align	2
	.global	armwave_test_fill_gdkbuf
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_test_fill_gdkbuf, %function
armwave_test_fill_gdkbuf:
.LVL206:
.LFB68:
	.loc 1 345 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 350 5 view .LVU791
@ armwave.c:350:     void *out_pixbuf = ((uint32_t ***)buf)[2][10];
	.loc 1 350 11 is_stmt 0 view .LVU792
	ldr	r3, [r0, #8]	@ MEM[(uint32_t * * *)buf_2(D) + 8B], MEM[(uint32_t * * *)buf_2(D) + 8B]
@ armwave.c:345: {
	.loc 1 345 1 view .LVU793
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	.cfi_def_cfa_offset 36
	.cfi_offset 4, -36
	.cfi_offset 5, -32
	.cfi_offset 6, -28
	.cfi_offset 7, -24
	.cfi_offset 8, -20
	.cfi_offset 9, -16
	.cfi_offset 10, -12
	.cfi_offset 11, -8
	.cfi_offset 14, -4
	sub	sp, sp, #12	@,,
	.cfi_def_cfa_offset 48
.LBB27:
.LBB28:
@ armwave.c:250:     uint32_t *base_32ptr = (uint32_t*)g_armwave_state.ch1_buffer;
	.loc 1 250 15 view .LVU794
	ldr	r2, .L196	@ tmp206,
.LBE28:
.LBE27:
@ armwave.c:350:     void *out_pixbuf = ((uint32_t ***)buf)[2][10];
	.loc 1 350 11 view .LVU795
	ldr	r8, [r3, #40]	@ out_pixbuf, MEM[(uint32_t * *)_1 + 40B]
.LVL207:
	.loc 1 353 3 is_stmt 1 view .LVU796
.LBB31:
.LBI27:
	.loc 1 245 6 view .LVU797
.LBB29:
	.loc 1 247 5 view .LVU798
	.loc 1 248 5 view .LVU799
	.loc 1 249 5 view .LVU800
	.loc 1 250 5 view .LVU801
@ armwave.c:254:     assert(out_buffer != NULL);
	.loc 1 254 5 is_stmt 0 view .LVU802
	cmp	r8, #0	@ out_pixbuf,
@ armwave.c:250:     uint32_t *base_32ptr = (uint32_t*)g_armwave_state.ch1_buffer;
	.loc 1 250 15 view .LVU803
	ldr	r9, [r2, #4]	@ base_32ptr, g_armwave_state.ch1_buffer
.LVL208:
	.loc 1 251 5 is_stmt 1 view .LVU804
	.loc 1 252 5 view .LVU805
	.loc 1 254 5 view .LVU806
	beq	.L194		@,
	.loc 1 256 5 view .LVU807
@ armwave.c:256:     npix = g_armwave_state.target_width * 256; 
	.loc 1 256 41 is_stmt 0 view .LVU808
	ldr	r5, [r2, #60]	@ g_armwave_state.target_width, g_armwave_state.target_width
	lsl	r5, r5, #8	@ npix, g_armwave_state.target_width,
.LVL209:
	.loc 1 257 5 is_stmt 1 view .LVU809
	.loc 1 259 5 view .LVU810
	.loc 1 259 5 is_stmt 0 view .LVU811
	cmp	r5, #0	@ npix,
	ble	.L172		@,
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 52 view .LVU812
	ldrsh	r3, [r2, #82]	@ _26, g_armwave_state.ch1_color.g
@ armwave.c:271:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 271 52 view .LVU813
	ldrsh	fp, [r2, #80]	@ _20, g_armwave_state.ch1_color.r
@ armwave.c:259:     for(n = 0; n < npix; n += 4) {
	.loc 1 259 11 view .LVU814
	mov	r1, #0	@ n,
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 52 view .LVU815
	str	r3, [sp]	@ _26, %sfp
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 52 view .LVU816
	ldrsh	r3, [r2, #84]	@ _30, g_armwave_state.ch1_color.b
	str	r3, [sp, #4]	@ _30, %sfp
.LVL210:
.L179:
	.loc 1 263 9 is_stmt 1 view .LVU817
@ armwave.c:263:         wave_word = *base_32ptr++;
	.loc 1 263 19 is_stmt 0 view .LVU818
	ldr	r0, [r9], #4	@ wave_word, MEM[base: base_32ptr_11, offset: 4294967292B]
.LVL211:
	.loc 1 265 9 is_stmt 1 view .LVU819
@ armwave.c:265:         if(COND_UNLIKELY(wave_word != 0)) {
	.loc 1 265 11 is_stmt 0 view .LVU820
	cmp	r0, #0	@ wave_word,
	bne	.L191		@,
	add	r1, r1, #4	@ n, n,
.L175:
.LVL212:
@ armwave.c:259:     for(n = 0; n < npix; n += 4) {
	.loc 1 259 5 view .LVU821
	cmp	r5, r1	@ npix, n
	bgt	.L179		@,
.LVL213:
.L172:
	.loc 1 259 5 view .LVU822
.LBE29:
.LBE31:
@ armwave.c:354: }
	.loc 1 354 1 view .LVU823
	add	sp, sp, #12	@,,
	.cfi_remember_state
	.cfi_def_cfa_offset 36
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
.LVL214:
.L191:
	.cfi_restore_state
.LBB32:
.LBB30:
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 view .LVU824
	ands	lr, r0, #255	@ _22, wave_word,
@ armwave.c:265:         if(COND_UNLIKELY(wave_word != 0)) {
	.loc 1 265 11 view .LVU825
	mov	r6, r1	@ ivtmp.118, n
.LVL215:
	.loc 1 267 17 is_stmt 1 view .LVU826
	.loc 1 268 17 view .LVU827
@ armwave.c:268:                 wave_word >>= 8;
	.loc 1 268 27 is_stmt 0 view .LVU828
	lsr	r0, r0, #8	@ wave_word, wave_word,
.LVL216:
	.loc 1 270 17 is_stmt 1 view .LVU829
	add	r1, r1, #4	@ n, ivtmp.118,
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 is_stmt 0 view .LVU830
	bne	.L195		@,
.L176:
	.loc 1 270 19 view .LVU831
	add	r6, r6, #1	@ ivtmp.118, ivtmp.118,
@ armwave.c:266:             for(w = 0; w < 4; w++) {
	.loc 1 266 13 view .LVU832
	cmp	r1, r6	@ n, ivtmp.118
	beq	.L175		@,
	.loc 1 267 17 is_stmt 1 view .LVU833
.LVL217:
	.loc 1 268 17 view .LVU834
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 is_stmt 0 view .LVU835
	ands	lr, r0, #255	@ _22, wave_word,
@ armwave.c:268:                 wave_word >>= 8;
	.loc 1 268 27 view .LVU836
	lsr	r0, r0, #8	@ wave_word, wave_word,
.LVL218:
	.loc 1 270 17 is_stmt 1 view .LVU837
@ armwave.c:270:                 if(value != 0) {
	.loc 1 270 19 is_stmt 0 view .LVU838
	beq	.L176		@,
.L195:
	.loc 1 271 21 is_stmt 1 view .LVU839
.LVL219:
	.loc 1 272 21 view .LVU840
	.loc 1 273 21 view .LVU841
	.loc 1 275 21 view .LVU842
	.loc 1 276 21 view .LVU843
	.loc 1 277 21 view .LVU844
	.loc 1 280 21 view .LVU845
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 55 is_stmt 0 view .LVU846
	ldr	r3, [sp, #4]	@ _30, %sfp
@ armwave.c:284:                     yy = (nsub & 0xff) * g_armwave_state.vscale;
	.loc 1 284 57 view .LVU847
	ldr	r10, [r2, #28]	@ _52, g_armwave_state.vscale
@ armwave.c:284:                     yy = (nsub & 0xff) * g_armwave_state.vscale;
	.loc 1 284 32 view .LVU848
	uxtb	r7, r6	@ ivtmp.118, ivtmp.118
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 55 view .LVU849
	mul	ip, r3, lr	@ tmp181, _30, _22
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 55 view .LVU850
	ldr	r3, [sp]	@ _26, %sfp
@ armwave.c:284:                     yy = (nsub & 0xff) * g_armwave_state.vscale;
	.loc 1 284 24 view .LVU851
	mul	r7, r10, r7	@ yy, _52, ivtmp.118
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 55 view .LVU852
	mul	r4, r3, lr	@ tmp185, _26, _22
@ armwave.c:273:                     bb = (g_armwave_state.ch1_color.b * value) >> 8;
	.loc 1 273 24 view .LVU853
	asr	ip, ip, #8	@ bb, tmp181,
.LVL220:
@ armwave.c:271:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 271 55 view .LVU854
	mul	lr, lr, fp	@ tmp191, _22, _20
.LVL221:
@ armwave.c:272:                     gg = (g_armwave_state.ch1_color.g * value) >> 8;
	.loc 1 272 24 view .LVU855
	asr	r4, r4, #8	@ gg, tmp185,
.LVL222:
@ armwave.c:277:                     b = MIN(bb, 255);
	.loc 1 277 25 view .LVU856
	cmp	ip, #255	@ bb,
	movge	ip, #255	@ bb,
.LVL223:
@ armwave.c:276:                     g = MIN(gg, 255);
	.loc 1 276 25 view .LVU857
	cmp	r4, #255	@ gg,
	movge	r4, #255	@ gg,
.LVL224:
@ armwave.c:271:                     rr = (g_armwave_state.ch1_color.r * value) >> 8;
	.loc 1 271 24 view .LVU858
	asr	lr, lr, #8	@ rr, tmp191,
.LVL225:
@ armwave.c:275:                     r = MIN(rr, 255);
	.loc 1 275 25 view .LVU859
	cmp	lr, #255	@ rr,
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 56 view .LVU860
	lsl	r4, r4, #8	@ tmp186, gg,
@ armwave.c:275:                     r = MIN(rr, 255);
	.loc 1 275 25 view .LVU861
	movge	lr, #255	@ rr,
.LVL226:
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 44 view .LVU862
	lsl	r3, ip, #16	@ tmp182, bb,
	and	r3, r3, #16711680	@ tmp183, tmp182,
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 56 view .LVU863
	uxth	r4, r4	@ tmp187, tmp186
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 51 view .LVU864
	orr	r3, r3, r4	@ tmp189, tmp183, tmp187
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 62 view .LVU865
	uxtb	lr, lr	@ rr, rr
	orr	r3, r3, lr	@ tmp193, tmp189, rr
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 21 view .LVU866
	cmp	r10, #0	@ _52,
@ armwave.c:280:                     word = 0xff000000 | (b << 16) | (g << 8) | r;
	.loc 1 280 26 view .LVU867
	orr	r3, r3, #-16777216	@ word, tmp193,
.LVL227:
	.loc 1 283 21 is_stmt 1 view .LVU868
	.loc 1 284 21 view .LVU869
	.loc 1 285 21 view .LVU870
@ armwave.c:285:                     xx = (nsub >> 8);
	.loc 1 285 32 is_stmt 0 view .LVU871
	asr	r10, r6, #8	@ xx, ivtmp.118,
.LVL228:
	.loc 1 287 21 is_stmt 1 view .LVU872
	.loc 1 287 21 is_stmt 0 view .LVU873
	beq	.L176		@,
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 29 view .LVU874
	mov	ip, #0	@ row,
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 38 view .LVU875
	mov	lr, ip	@ _56, row
.LVL229:
.L177:
	.loc 1 288 25 is_stmt 1 view .LVU876
	.loc 1 289 25 view .LVU877
@ armwave.c:288:                         offset = (xx + ((yy + row) * g_armwave_state.target_width)); 
	.loc 1 288 52 is_stmt 0 view .LVU878
	ldr	r4, [r2, #60]	@ g_armwave_state.target_width, g_armwave_state.target_width
@ armwave.c:288:                         offset = (xx + ((yy + row) * g_armwave_state.target_width)); 
	.loc 1 288 45 view .LVU879
	add	lr, r7, lr	@ tmp196, yy, _56
.LVL230:
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 67 view .LVU880
	add	ip, ip, #1	@ tmp201, row,
.LVL231:
@ armwave.c:289:                         *(out_buffer_base + offset) = word;
	.loc 1 289 43 view .LVU881
	mla	r4, r4, lr, r10	@ tmp200, g_armwave_state.target_width, tmp196, xx
.LVL232:
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 67 view .LVU882
	uxtb	ip, ip	@ row, tmp201
.LVL233:
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 38 view .LVU883
	mov	lr, ip	@ _56, row
@ armwave.c:289:                         *(out_buffer_base + offset) = word;
	.loc 1 289 53 view .LVU884
	str	r3, [r8, r4, lsl #2]	@ word, *_62
@ armwave.c:287:                     for(row = 0; row < g_armwave_state.vscale; row++) {
	.loc 1 287 21 view .LVU885
	ldr	r4, [r2, #28]	@ g_armwave_state.vscale, g_armwave_state.vscale
.LVL234:
	.loc 1 287 21 view .LVU886
	cmp	ip, r4	@ row, g_armwave_state.vscale
	bcc	.L177		@,
	.loc 1 287 21 view .LVU887
	b	.L176		@
.LVL235:
.L194:
	.loc 1 254 5 is_stmt 1 view .LVU888
	ldr	r3, .L196+4	@,
	mov	r2, #254	@,
	ldr	r1, .L196+8	@,
	ldr	r0, .L196+12	@,
.LVL236:
	.loc 1 254 5 is_stmt 0 view .LVU889
	bl	__assert_fail		@
.LVL237:
.L197:
	.align	2
.L196:
	.word	g_armwave_state
	.word	.LANCHOR0+48
	.word	.LC0
	.word	.LC6
.LBE30:
.LBE32:
	.cfi_endproc
.LFE68:
	.size	armwave_test_fill_gdkbuf, .-armwave_test_fill_gdkbuf
	.align	2
	.global	armwave_test_dump_buffer_to_ppm
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_test_dump_buffer_to_ppm, %function
armwave_test_dump_buffer_to_ppm:
.LVL238:
.LFB69:
	.loc 1 357 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 358 5 view .LVU891
	ldr	r3, .L199	@ tmp112,
	mov	r1, r0	@, fn
	ldr	r0, [r3, #76]	@, g_armwave_state.out_pixbuf
.LVL239:
	.loc 1 358 5 is_stmt 0 view .LVU892
	b	armwave_dump_ppm_debug		@
.LVL240:
.L200:
	.loc 1 358 5 view .LVU893
	.align	2
.L199:
	.word	g_armwave_state
	.cfi_endproc
.LFE69:
	.size	armwave_test_dump_buffer_to_ppm, .-armwave_test_dump_buffer_to_ppm
	.align	2
	.global	armwave_test_create_am_sine
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_test_create_am_sine, %function
armwave_test_create_am_sine:
.LVL241:
.LFB70:
	.loc 1 368 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 369 5 view .LVU895
	.loc 1 370 5 view .LVU896
	.loc 1 372 5 view .LVU897
@ armwave.c:368: {
	.loc 1 368 1 is_stmt 0 view .LVU898
	push	{r4, r5, r6, r7, r8, r9, r10, lr}	@
	.cfi_def_cfa_offset 32
	.cfi_offset 4, -32
	.cfi_offset 5, -28
	.cfi_offset 6, -24
	.cfi_offset 7, -20
	.cfi_offset 8, -16
	.cfi_offset 9, -12
	.cfi_offset 10, -8
	.cfi_offset 14, -4
	vpush.64	{d8, d9, d10, d11, d12, d13, d14}	@
	.cfi_def_cfa_offset 88
	.cfi_offset 80, -88
	.cfi_offset 81, -84
	.cfi_offset 82, -80
	.cfi_offset 83, -76
	.cfi_offset 84, -72
	.cfi_offset 85, -68
	.cfi_offset 86, -64
	.cfi_offset 87, -60
	.cfi_offset 88, -56
	.cfi_offset 89, -52
	.cfi_offset 90, -48
	.cfi_offset 91, -44
	.cfi_offset 92, -40
	.cfi_offset 93, -36
	ldr	r8, .L220+36	@ _76,
	vmov.f32	s27, s0	@ mod, mod
	add	r6, r8, #2032	@ ivtmp.139, _76,
	vmov.f32	s24, s1	@ noise_fraction, noise_fraction
@ armwave.c:373:         mod_val = 0.5f + (((float)w / TEST_NWAVES) * mod);
	.loc 1 373 37 view .LVU899
	vldr.32	s26, .L220	@ tmp158,
@ armwave.c:373:         mod_val = 0.5f + (((float)w / TEST_NWAVES) * mod);
	.loc 1 373 17 view .LVU900
	vldr.32	s25, .L220+4	@ tmp160,
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 29 view .LVU901
	vldr.32	s23, .L220+8	@ tmp168,
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 33 view .LVU902
	vldr.32	s22, .L220+12	@ tmp170,
@ armwave.c:386:             xnoise = (rand() & 0xffff) / 6553500.0f;
	.loc 1 386 20 view .LVU903
	vldr.32	s21, .L220+16	@ tmp175,
@ armwave.c:385:             noise += 1.0f;
	.loc 1 385 19 view .LVU904
	vldr.32	s20, .L220+20	@ tmp181,
	add	r10, r6, #131072	@ _82,,
@ armwave.c:368: {
	.loc 1 368 1 view .LVU905
	sub	sp, sp, #8	@,,
	.cfi_def_cfa_offset 96
	add	r10, r10, #15	@ _82, _82,
	add	r6, r6, #15	@ ivtmp.139, ivtmp.139,
	rsb	r8, r8, #0	@ ivtmp.142, _76
@ armwave.c:372:     for(w = 0; w < TEST_NWAVES; w++) {
	.loc 1 372 11 view .LVU906
	mov	r9, #0	@ w,
.LVL242:
.L207:
	.loc 1 373 9 is_stmt 1 view .LVU907
@ armwave.c:373:         mod_val = 0.5f + (((float)w / TEST_NWAVES) * mod);
	.loc 1 373 28 is_stmt 0 view .LVU908
	vmov	s15, r9	@ int	@ w, w
@ armwave.c:373:         mod_val = 0.5f + (((float)w / TEST_NWAVES) * mod);
	.loc 1 373 17 view .LVU909
	vmov.f32	s16, s25	@ mod_val, tmp160
@ armwave.c:390:             test_wave_buffer[x + (w * TEST_WAVE_SIZE)] = MIN(MAX(128 + (v * 127), 0), 255);
	.loc 1 390 58 view .LVU910
	vldr.32	s19, .L220+24	@ tmp186,
	vldr.32	s18, .L220+28	@ tmp187,
@ armwave.c:373:         mod_val = 0.5f + (((float)w / TEST_NWAVES) * mod);
	.loc 1 373 28 view .LVU911
	vcvt.f32.s32	s15, s15	@ tmp156, w
	sub	r5, r6, #2048	@ ivtmp.132, ivtmp.139,
	add	r7, r8, #1	@ tmp193, ivtmp.142,
@ armwave.c:373:         mod_val = 0.5f + (((float)w / TEST_NWAVES) * mod);
	.loc 1 373 37 view .LVU912
	vmul.f32	s15, s15, s26	@ tmp157, tmp156, tmp158
@ armwave.c:373:         mod_val = 0.5f + (((float)w / TEST_NWAVES) * mod);
	.loc 1 373 17 view .LVU913
	vmla.f32	s16, s15, s27	@ mod_val, tmp157, mod
.LVL243:
	.loc 1 376 9 is_stmt 1 view .LVU914
	.loc 1 376 9 is_stmt 0 view .LVU915
	vcvt.f64.f32	d8, s16	@ tmp194, mod_val
.LVL244:
.L206:
@ armwave.c:377:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 377 24 view .LVU916
	bl	rand		@
.LVL245:
	add	r4, r7, r5	@ _72, tmp193, ivtmp.132
.LVL246:
	.loc 1 377 13 is_stmt 1 view .LVU917
@ armwave.c:377:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 377 31 is_stmt 0 view .LVU918
	uxth	r0, r0	@ tmp162,
@ armwave.c:377:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 377 41 view .LVU919
	vmov	s15, r0	@ int	@ tmp162, tmp162
	vcvt.f32.s32	s15, s15	@ tmp164, tmp162
@ armwave.c:377:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 377 20 view .LVU920
	vmul.f32	s15, s15, s24	@ noise, tmp164, noise_fraction
.LVL247:
	.loc 1 378 13 is_stmt 1 view .LVU921
@ armwave.c:378:             noise *= noise;
	.loc 1 378 19 is_stmt 0 view .LVU922
	vmul.f32	s15, s15, s15	@ noise, noise, noise
.LVL248:
	.loc 1 379 13 is_stmt 1 view .LVU923
@ armwave.c:379:             noise *= noise;
	.loc 1 379 19 is_stmt 0 view .LVU924
	vmul.f32	s15, s15, s15	@ noise, noise, noise
.LVL249:
	.loc 1 380 13 is_stmt 1 view .LVU925
@ armwave.c:380:             noise *= noise;
	.loc 1 380 19 is_stmt 0 view .LVU926
	vmul.f32	s28, s15, s15	@ noise, noise, noise
.LVL250:
	.loc 1 382 13 is_stmt 1 view .LVU927
@ armwave.c:382:             if((rand() & 0xffff) > 0x7fff)
	.loc 1 382 17 is_stmt 0 view .LVU928
	bl	rand		@
.LVL251:
	.loc 1 383 17 is_stmt 1 view .LVU929
@ armwave.c:382:             if((rand() & 0xffff) > 0x7fff)
	.loc 1 382 15 is_stmt 0 view .LVU930
	tst	r0, #32768	@,
@ armwave.c:383:                 noise = -noise;
	.loc 1 383 23 view .LVU931
	vnegne.f32	s28, s28	@ noise, noise
.LVL252:
	.loc 1 385 13 is_stmt 1 view .LVU932
	.loc 1 386 13 view .LVU933
@ armwave.c:386:             xnoise = (rand() & 0xffff) / 6553500.0f;
	.loc 1 386 23 is_stmt 0 view .LVU934
	bl	rand		@
.LVL253:
	.loc 1 388 13 is_stmt 1 view .LVU935
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 29 is_stmt 0 view .LVU936
	vmov	s15, r4	@ int	@ _72, _72
	vcvt.f32.s32	s15, s15	@ tmp166, _72
	vmul.f32	s15, s15, s23	@ tmp167, tmp166, tmp168
@ armwave.c:386:             xnoise = (rand() & 0xffff) / 6553500.0f;
	.loc 1 386 30 view .LVU937
	uxth	r0, r0	@ tmp171,
.LVL254:
@ armwave.c:386:             xnoise = (rand() & 0xffff) / 6553500.0f;
	.loc 1 386 40 view .LVU938
	vmov	s14, r0	@ int	@ tmp171, tmp171
	vcvt.f32.s32	s14, s14	@ tmp173, tmp171
@ armwave.c:386:             xnoise = (rand() & 0xffff) / 6553500.0f;
	.loc 1 386 20 view .LVU939
	vdiv.f32	s0, s14, s21	@ xnoise, tmp173, tmp175
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 60 view .LVU940
	vmla.f32	s0, s15, s22	@ tmp176, tmp167, tmp170
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 18 view .LVU941
	vcvt.f64.f32	d0, s0	@, tmp176
	bl	sin		@
.LVL255:
	.loc 1 390 13 is_stmt 1 view .LVU942
@ armwave.c:385:             noise += 1.0f;
	.loc 1 385 19 is_stmt 0 view .LVU943
	vadd.f32	s15, s28, s20	@ noise, noise, tmp181
@ armwave.c:390:             test_wave_buffer[x + (w * TEST_WAVE_SIZE)] = MIN(MAX(128 + (v * 127), 0), 255);
	.loc 1 390 56 view .LVU944
	vldr.32	s13, .L220+32	@ tmp189,
	mov	r3, #0	@ iftmp.18_29,
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 81 view .LVU945
	vcvt.f64.f32	d7, s15	@ tmp182, noise
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 70 view .LVU946
	vmul.f64	d0, d8, d0	@ tmp179, tmp194,
.LVL256:
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 81 view .LVU947
	vmul.f64	d7, d0, d7	@ tmp183, tmp179, tmp182
@ armwave.c:388:             v = (sin((6.28f * x * (1.0f / TEST_WAVE_SIZE)) + xnoise) * mod_val) * noise;
	.loc 1 388 15 view .LVU948
	vcvt.f32.f64	s14, d7	@ v, tmp183
@ armwave.c:390:             test_wave_buffer[x + (w * TEST_WAVE_SIZE)] = MIN(MAX(128 + (v * 127), 0), 255);
	.loc 1 390 58 view .LVU949
	vmov.f32	s15, s18	@ _23, tmp187
	vmla.f32	s15, s14, s19	@ _23, v, tmp186
	vcmpe.f32	s15, #0	@ _23
	vmrs	APSR_nzcv, FPSCR
	ble	.L203		@,
@ armwave.c:390:             test_wave_buffer[x + (w * TEST_WAVE_SIZE)] = MIN(MAX(128 + (v * 127), 0), 255);
	.loc 1 390 56 discriminator 1 view .LVU950
	vcmpe.f32	s15, s13	@ _23, tmp189
	mov	r3, #255	@ iftmp.18_29,
	vmrs	APSR_nzcv, FPSCR
	vcvtmi.u32.f32	s15, s15	@ tmp191, _23
	vstrmi.32	s15, [sp, #4]	@ int	@ tmp191, %sfp
	ldrbmi	r3, [sp, #4]	@ zero_extendqisi2	@ iftmp.18_29, %sfp
.L203:
@ armwave.c:390:             test_wave_buffer[x + (w * TEST_WAVE_SIZE)] = MIN(MAX(128 + (v * 127), 0), 255);
	.loc 1 390 56 discriminator 12 view .LVU951
	strb	r3, [r5, #1]!	@ iftmp.18_29, MEM[base: _61, offset: 0B]
.LVL257:
@ armwave.c:376:         for(x = 0; x < TEST_WAVE_SIZE; x++) {
	.loc 1 376 9 discriminator 12 view .LVU952
	cmp	r5, r6	@ ivtmp.132, ivtmp.139
	bne	.L206		@,
	add	r6, r5, #2048	@ ivtmp.139, ivtmp.132,
.LVL258:
@ armwave.c:372:     for(w = 0; w < TEST_NWAVES; w++) {
	.loc 1 372 5 discriminator 2 view .LVU953
	cmp	r6, r10	@ ivtmp.139, _82
@ armwave.c:372:     for(w = 0; w < TEST_NWAVES; w++) {
	.loc 1 372 34 discriminator 2 view .LVU954
	add	r9, r9, #1	@ w, w,
.LVL259:
	.loc 1 372 34 discriminator 2 view .LVU955
	sub	r8, r8, #2048	@ ivtmp.142, ivtmp.142,
@ armwave.c:372:     for(w = 0; w < TEST_NWAVES; w++) {
	.loc 1 372 5 discriminator 2 view .LVU956
	bne	.L207		@,
@ armwave.c:393: }
	.loc 1 393 1 view .LVU957
	add	sp, sp, #8	@,,
	.cfi_def_cfa_offset 88
	@ sp needed	@
	vldm	sp!, {d8-d14}	@,
	.cfi_restore 92
	.cfi_restore 93
	.cfi_restore 90
	.cfi_restore 91
	.cfi_restore 88
	.cfi_restore 89
	.cfi_restore 86
	.cfi_restore 87
	.cfi_restore 84
	.cfi_restore 85
	.cfi_restore 82
	.cfi_restore 83
	.cfi_restore 80
	.cfi_restore 81
	.cfi_def_cfa_offset 32
.LVL260:
	.loc 1 393 1 view .LVU958
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}	@
.LVL261:
.L221:
	.loc 1 393 1 view .LVU959
	.align	2
.L220:
	.word	1015021568
	.word	1056964608
	.word	1086911939
	.word	973078528
	.word	1254620984
	.word	1065353216
	.word	1123942400
	.word	1124073472
	.word	1132396544
	.word	test_wave_buffer
	.cfi_endproc
.LFE70:
	.size	armwave_test_create_am_sine, .-armwave_test_create_am_sine
	.align	2
	.global	armwave_test_create_square
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_test_create_square, %function
armwave_test_create_square:
.LVL262:
.LFB71:
	.loc 1 401 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 402 5 view .LVU961
	.loc 1 403 5 view .LVU962
	.loc 1 404 5 view .LVU963
	.loc 1 405 5 view .LVU964
	.loc 1 407 5 view .LVU965
@ armwave.c:401: {
	.loc 1 401 1 is_stmt 0 view .LVU966
	push	{r4, r5, r6, r7, r8, r9, lr}	@
	.cfi_def_cfa_offset 28
	.cfi_offset 4, -28
	.cfi_offset 5, -24
	.cfi_offset 6, -20
	.cfi_offset 7, -16
	.cfi_offset 8, -12
	.cfi_offset 9, -8
	.cfi_offset 14, -4
	vpush.64	{d8, d9, d10, d11, d12}	@
	.cfi_def_cfa_offset 68
	.cfi_offset 80, -68
	.cfi_offset 81, -64
	.cfi_offset 82, -60
	.cfi_offset 83, -56
	.cfi_offset 84, -52
	.cfi_offset 85, -48
	.cfi_offset 86, -44
	.cfi_offset 87, -40
	.cfi_offset 88, -36
	.cfi_offset 89, -32
@ armwave.c:404:     float level = 0.8f, new_level = 0.8f;
	.loc 1 404 11 view .LVU967
	vldr.32	s17, .L245	@ level,
	ldr	r8, .L245+36	@ _62,
@ armwave.c:401: {
	.loc 1 401 1 view .LVU968
	vmov.f32	s20, s0	@ noise_fraction, noise_fraction
	add	r6, r8, #2032	@ ivtmp.157, _62,
@ armwave.c:422:                 new_level = 0.8f;
	.loc 1 422 27 view .LVU969
	vmov.f32	s23, s17	@ new_level, level
@ armwave.c:419:             if(x > (TEST_WAVE_SIZE * 0.75f)) {
	.loc 1 419 15 view .LVU970
	vldr.32	s19, .L245+4	@ tmp144,
@ armwave.c:424:                 new_level = 0.2f;
	.loc 1 424 27 view .LVU971
	vldr.32	s21, .L245+8	@ new_level,
@ armwave.c:421:             } else if(x > (TEST_WAVE_SIZE * 0.5f)) {
	.loc 1 421 22 view .LVU972
	vldr.32	s22, .L245+12	@ tmp161,
	add	r6, r6, #15	@ ivtmp.157, ivtmp.157,
@ armwave.c:401: {
	.loc 1 401 1 view .LVU973
	sub	sp, sp, #12	@,,
	.cfi_def_cfa_offset 80
	rsb	r8, r8, #0	@ ivtmp.160, _62
	add	r9, r6, #131072	@ _68,,
.LVL263:
.L223:
@ armwave.c:423:             } else if(x > (TEST_WAVE_SIZE * 0.25f)) {
	.loc 1 423 22 view .LVU974
	vldr.32	s24, .L245+16	@ tmp163,
@ armwave.c:429:             level = ((level * 3) + new_level) * 0.25f;
	.loc 1 429 29 view .LVU975
	vldr.32	s18, .L245+20	@ tmp148,
	sub	r5, r6, #2048	@ ivtmp.150, ivtmp.157,
	add	r7, r8, #1	@ tmp157, ivtmp.160,
.LVL264:
.L229:
@ armwave.c:409:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 409 24 view .LVU976
	bl	rand		@
.LVL265:
	add	r4, r7, r5	@ _58, tmp157, ivtmp.150
.LVL266:
	.loc 1 409 13 is_stmt 1 view .LVU977
@ armwave.c:409:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 409 31 is_stmt 0 view .LVU978
	uxth	r0, r0	@ tmp140,
@ armwave.c:409:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 409 41 view .LVU979
	vmov	s15, r0	@ int	@ tmp140, tmp140
	vcvt.f32.s32	s15, s15	@ tmp142, tmp140
@ armwave.c:409:             noise  = ((rand() & 0xffff) * noise_fraction);
	.loc 1 409 20 view .LVU980
	vmul.f32	s15, s15, s20	@ noise, tmp142, noise_fraction
.LVL267:
	.loc 1 410 13 is_stmt 1 view .LVU981
@ armwave.c:410:             noise *= noise;
	.loc 1 410 19 is_stmt 0 view .LVU982
	vmul.f32	s15, s15, s15	@ noise, noise, noise
.LVL268:
	.loc 1 411 13 is_stmt 1 view .LVU983
@ armwave.c:411:             noise *= noise;
	.loc 1 411 19 is_stmt 0 view .LVU984
	vmul.f32	s15, s15, s15	@ noise, noise, noise
.LVL269:
	.loc 1 412 13 is_stmt 1 view .LVU985
@ armwave.c:412:             noise *= noise;
	.loc 1 412 19 is_stmt 0 view .LVU986
	vmul.f32	s16, s15, s15	@ noise, noise, noise
.LVL270:
	.loc 1 414 13 is_stmt 1 view .LVU987
@ armwave.c:414:             if((rand() & 0xff) > 0x7f)
	.loc 1 414 17 is_stmt 0 view .LVU988
	bl	rand		@
.LVL271:
@ armwave.c:419:             if(x > (TEST_WAVE_SIZE * 0.75f)) {
	.loc 1 419 18 view .LVU989
	vmov	s15, r4	@ int	@ _58, _58
	vcvt.f32.s32	s15, s15	@ _6, _58
@ armwave.c:419:             if(x > (TEST_WAVE_SIZE * 0.75f)) {
	.loc 1 419 15 view .LVU990
	vcmpe.f32	s15, s19	@ _6, tmp144
@ armwave.c:414:             if((rand() & 0xff) > 0x7f)
	.loc 1 414 15 view .LVU991
	tst	r0, #128	@,
	.loc 1 415 17 is_stmt 1 view .LVU992
@ armwave.c:415:                 noise = -noise;
	.loc 1 415 23 is_stmt 0 view .LVU993
	vnegne.f32	s16, s16	@ noise, noise
.LVL272:
	.loc 1 419 13 is_stmt 1 view .LVU994
@ armwave.c:419:             if(x > (TEST_WAVE_SIZE * 0.75f)) {
	.loc 1 419 15 is_stmt 0 view .LVU995
	vmrs	APSR_nzcv, FPSCR
@ armwave.c:424:                 new_level = 0.2f;
	.loc 1 424 27 view .LVU996
	vmovgt.f32	s15, s21	@ new_level, new_level
@ armwave.c:419:             if(x > (TEST_WAVE_SIZE * 0.75f)) {
	.loc 1 419 15 view .LVU997
	bgt	.L225		@,
	.loc 1 421 20 is_stmt 1 view .LVU998
@ armwave.c:421:             } else if(x > (TEST_WAVE_SIZE * 0.5f)) {
	.loc 1 421 22 is_stmt 0 view .LVU999
	vcmpe.f32	s15, s22	@ _6, tmp161
	vmrs	APSR_nzcv, FPSCR
@ armwave.c:422:                 new_level = 0.8f;
	.loc 1 422 27 view .LVU1000
	vmovgt.f32	s15, s23	@ new_level, new_level
@ armwave.c:421:             } else if(x > (TEST_WAVE_SIZE * 0.5f)) {
	.loc 1 421 22 view .LVU1001
	bgt	.L225		@,
	.loc 1 423 20 is_stmt 1 view .LVU1002
@ armwave.c:422:                 new_level = 0.8f;
	.loc 1 422 27 is_stmt 0 view .LVU1003
	vcmpe.f32	s15, s24	@ _6, tmp163
	vmrs	APSR_nzcv, FPSCR
	vmovle.f32	s15, s23	@, new_level, new_level
	vmovgt.f32	s15, s21	@, new_level, new_level
.L225:
.LVL273:
	.loc 1 429 13 is_stmt 1 view .LVU1004
@ armwave.c:429:             level = ((level * 3) + new_level) * 0.25f;
	.loc 1 429 34 is_stmt 0 view .LVU1005
	vmla.f32	s15, s17, s18	@ _9, level, tmp148
.LVL274:
@ armwave.c:429:             level = ((level * 3) + new_level) * 0.25f;
	.loc 1 429 19 view .LVU1006
	vldr.32	s17, .L245+24	@ tmp149,
.LVL275:
	.loc 1 429 19 view .LVU1007
	vmul.f32	s17, s15, s17	@ level, _9, tmp149
.LVL276:
	.loc 1 431 13 is_stmt 1 view .LVU1008
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 27 is_stmt 0 view .LVU1009
	vadd.f32	s15, s16, s17	@ _10, noise, level
	vcmpe.f32	s15, #0	@ _10
	vmrs	APSR_nzcv, FPSCR
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 17 view .LVU1010
	movle	r3, #0	@ iftmp.21_20,
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 27 view .LVU1011
	ble	.L226		@,
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 17 discriminator 1 view .LVU1012
	vldr.32	s14, .L245+28	@ tmp151,
	vcmpe.f32	s15, s14	@ _10, tmp151
	vmrs	APSR_nzcv, FPSCR
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 60 discriminator 1 view .LVU1013
	vldrmi.32	s14, .L245+32	@ tmp153,
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 17 discriminator 1 view .LVU1014
	movpl	r3, #255	@ iftmp.21_20,
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 60 discriminator 1 view .LVU1015
	vmulmi.f32	s15, s15, s14	@ tmp152, _10, tmp153
@ armwave.c:431:             v = (uint8_t)(CLAMP(level + noise, 0.0f, 1.0f) * 255);
	.loc 1 431 17 discriminator 1 view .LVU1016
	vcvtmi.u32.f32	s15, s15	@ tmp155, tmp152
	vstrmi.32	s15, [sp, #4]	@ int	@ tmp155, %sfp
	ldrbmi	r3, [sp, #4]	@ zero_extendqisi2	@ iftmp.21_20, %sfp
.L226:
.LVL277:
	.loc 1 432 13 is_stmt 1 discriminator 12 view .LVU1017
@ armwave.c:432:             test_wave_buffer[x + (w * TEST_WAVE_SIZE)] = v;
	.loc 1 432 56 is_stmt 0 discriminator 12 view .LVU1018
	strb	r3, [r5, #1]!	@ iftmp.21_20, MEM[base: _43, offset: 0B]
.LVL278:
@ armwave.c:408:         for(x = 0; x < TEST_WAVE_SIZE; x++) {
	.loc 1 408 9 discriminator 12 view .LVU1019
	cmp	r5, r6	@ ivtmp.150, ivtmp.157
	bne	.L229		@,
	.loc 1 408 9 discriminator 12 view .LVU1020
	add	r6, r5, #2048	@ ivtmp.157, ivtmp.150,
.LVL279:
@ armwave.c:407:     for(w = 0; w < TEST_NWAVES; w++) {
	.loc 1 407 5 discriminator 2 view .LVU1021
	cmp	r6, r9	@ ivtmp.157, _68
	sub	r8, r8, #2048	@ ivtmp.160, ivtmp.160,
	bne	.L223		@,
@ armwave.c:435: }
	.loc 1 435 1 view .LVU1022
	add	sp, sp, #12	@,,
	.cfi_def_cfa_offset 68
	@ sp needed	@
	vldm	sp!, {d8-d12}	@,
	.cfi_restore 88
	.cfi_restore 89
	.cfi_restore 86
	.cfi_restore 87
	.cfi_restore 84
	.cfi_restore 85
	.cfi_restore 82
	.cfi_restore 83
	.cfi_restore 80
	.cfi_restore 81
	.cfi_def_cfa_offset 28
.LVL280:
	.loc 1 435 1 view .LVU1023
	pop	{r4, r5, r6, r7, r8, r9, pc}	@
.L246:
	.loc 1 435 1 view .LVU1024
	.align	2
.L245:
	.word	1061997773
	.word	1153433600
	.word	1045220557
	.word	1149239296
	.word	1140850688
	.word	1077936128
	.word	1048576000
	.word	1065353216
	.word	1132396544
	.word	test_wave_buffer
	.cfi_endproc
.LFE71:
	.size	armwave_test_create_square, .-armwave_test_create_square
	.align	2
	.global	armwave_cleanup
	.syntax unified
	.arm
	.fpu vfp
	.type	armwave_cleanup, %function
armwave_cleanup:
.LFB72:
	.loc 1 438 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 439 5 view .LVU1026
@ armwave.c:438: {
	.loc 1 438 1 is_stmt 0 view .LVU1027
	push	{r4, lr}	@
	.cfi_def_cfa_offset 8
	.cfi_offset 4, -8
	.cfi_offset 14, -4
@ armwave.c:439:     free(g_armwave_state.out_pixbuf);
	.loc 1 439 25 view .LVU1028
	ldr	r4, .L249	@ tmp113,
@ armwave.c:439:     free(g_armwave_state.out_pixbuf);
	.loc 1 439 5 view .LVU1029
	ldr	r0, [r4, #76]	@, g_armwave_state.out_pixbuf
	bl	free		@
.LVL281:
	.loc 1 440 5 is_stmt 1 view .LVU1030
	ldr	r0, [r4, #4]	@, g_armwave_state.ch1_buffer
	bl	free		@
.LVL282:
	.loc 1 441 5 view .LVU1031
	ldr	r0, [r4, #104]	@, g_armwave_state.xcoord_to_xpixel
	bl	free		@
.LVL283:
	.loc 1 443 5 view .LVU1032
@ armwave.c:443:     g_armwave_state.out_pixbuf = NULL;
	.loc 1 443 32 is_stmt 0 view .LVU1033
	mov	r3, #0	@ tmp120,
	str	r3, [r4, #76]	@ tmp120, g_armwave_state.out_pixbuf
	.loc 1 444 5 is_stmt 1 view .LVU1034
@ armwave.c:444:     g_armwave_state.ch1_buffer = NULL;
	.loc 1 444 32 is_stmt 0 view .LVU1035
	str	r3, [r4, #4]	@ tmp120, g_armwave_state.ch1_buffer
	.loc 1 445 5 is_stmt 1 view .LVU1036
@ armwave.c:445:     g_armwave_state.xcoord_to_xpixel = NULL;
	.loc 1 445 38 is_stmt 0 view .LVU1037
	str	r3, [r4, #104]	@ tmp120, g_armwave_state.xcoord_to_xpixel
@ armwave.c:446: }
	.loc 1 446 1 view .LVU1038
	pop	{r4, pc}	@
.L250:
	.align	2
.L249:
	.word	g_armwave_state
	.cfi_endproc
.LFE72:
	.size	armwave_cleanup, .-armwave_cleanup
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
.LVL284:
.LFB73:
	.loc 1 449 1 is_stmt 1 view -0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	.loc 1 450 5 view .LVU1040
	.loc 1 451 5 view .LVU1041
	.loc 1 454 5 view .LVU1042
.LBB37:
.LBI37:
	.loc 1 93 6 view .LVU1043
.LBB38:
	.loc 1 95 5 view .LVU1044
.LBE38:
.LBE37:
@ armwave.c:449: {
	.loc 1 449 1 is_stmt 0 view .LVU1045
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}	@
	.cfi_def_cfa_offset 36
	.cfi_offset 4, -36
	.cfi_offset 5, -32
	.cfi_offset 6, -28
	.cfi_offset 7, -24
	.cfi_offset 8, -20
	.cfi_offset 9, -16
	.cfi_offset 10, -12
	.cfi_offset 11, -8
	.cfi_offset 14, -4
.LBB41:
.LBB39:
@ armwave.c:95:     g_armwave_state.flags = 0;
	.loc 1 95 27 view .LVU1046
	mov	r3, #0	@ tmp190,
	ldr	r4, .L271+8	@ tmp255,
.LBE39:
.LBE41:
@ armwave.c:449: {
	.loc 1 449 1 view .LVU1047
	sub	sp, sp, #12	@,,
	.cfi_def_cfa_offset 48
@ armwave.c:457:     armwave_test_create_am_sine(0.5f, 1e-6f);
	.loc 1 457 5 view .LVU1048
	vldr.32	s1, .L271	@,
	vldr.32	s0, .L271+4	@,
.LBB42:
.LBB40:
@ armwave.c:95:     g_armwave_state.flags = 0;
	.loc 1 95 27 view .LVU1049
	str	r3, [r4]	@ tmp190, g_armwave_state.flags
.LBE40:
.LBE42:
	.loc 1 457 5 is_stmt 1 view .LVU1050
	bl	armwave_test_create_am_sine		@
.LVL285:
	.loc 1 460 5 view .LVU1051
	bl	test_create_gamma		@
.LVL286:
	.loc 1 463 5 view .LVU1052
	mov	r1, #256	@,
	mov	r0, #2048	@,
	bl	armwave_setup_render.constprop.0		@
.LVL287:
	.loc 1 467 5 view .LVU1053
	.loc 1 467 5 is_stmt 0 view .LVU1054
	ldr	r6, [r4, #44]	@ _119, g_armwave_state.slice_height
@ armwave.c:463:     armwave_setup_render(&test_wave_buffer, 0, TEST_WAVE_SIZE, TEST_NWAVES, TEST_WAVE_SIZE, 2048, 256, 0x00000000);
	.loc 1 463 5 view .LVU1055
	ldr	r3, .L271+12	@ ivtmp_197,
	str	r3, [sp, #4]	@ ivtmp_197, %sfp
.LVL288:
.L252:
@ armwave.c:468:         for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 468 9 view .LVU1056
	cmp	r6, #2048	@ _119,
@ armwave.c:468:         for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 468 16 view .LVU1057
	movls	r5, #0	@ yy,
	ldrls	r10, [r4, #36]	@ prephitmp_184, g_armwave_state.waves
@ armwave.c:468:         for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 468 9 view .LVU1058
	bhi	.L260		@,
.LVL289:
.L257:
	.loc 1 470 13 is_stmt 1 discriminator 3 view .LVU1059
	mul	r2, r6, r5	@ _1, _119, yy
.LBB43:
.LBB44:
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 63 is_stmt 0 discriminator 3 view .LVU1060
	ldr	r0, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 discriminator 3 view .LVU1061
	cmp	r10, #0	@ prephitmp_184,
.LBE44:
.LBE43:
@ armwave.c:470:             render_nonaa_to_buffer_1ch_slice(yy * g_armwave_state.slice_height, g_armwave_state.slice_record_height);
	.loc 1 470 13 discriminator 3 view .LVU1062
	ldr	r7, [r4, #48]	@ _2, g_armwave_state.slice_record_height
.LVL290:
.LBB46:
.LBI43:
	.loc 1 63 6 is_stmt 1 discriminator 3 view .LVU1063
.LBB45:
	.loc 1 65 5 discriminator 3 view .LVU1064
	.loc 1 66 5 discriminator 3 view .LVU1065
	.loc 1 67 5 discriminator 3 view .LVU1066
	.loc 1 68 5 discriminator 3 view .LVU1067
	.loc 1 69 5 discriminator 3 view .LVU1068
	.loc 1 71 5 discriminator 3 view .LVU1069
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 63 is_stmt 0 discriminator 3 view .LVU1070
	mul	r0, r0, r2	@ _19, g_armwave_state.bitdepth_height, _1
@ armwave.c:71:     write_buffer_base = g_armwave_state.ch1_buffer + (slice_y * g_armwave_state.bitdepth_height);
	.loc 1 71 40 discriminator 3 view .LVU1071
	ldr	r3, [r4, #4]	@ _17, g_armwave_state.ch1_buffer
.LVL291:
	.loc 1 74 5 is_stmt 1 discriminator 3 view .LVU1072
	.loc 1 74 5 is_stmt 0 discriminator 3 view .LVU1073
	beq	.L253		@,
	sub	r6, r2, #4	@ _80, _1,
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 11 view .LVU1074
	mov	lr, #0	@ w,
.LVL292:
.L256:
	.loc 1 75 9 is_stmt 1 view .LVU1075
@ armwave.c:75:         wave_base = g_armwave_state.wave_buffer + slice_y + (w * g_armwave_state.wave_stride);
	.loc 1 75 64 is_stmt 0 view .LVU1076
	ldr	r2, [r4, #32]	@ g_armwave_state.wave_stride, g_armwave_state.wave_stride
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 view .LVU1077
	cmp	r7, #0	@ _2,
@ armwave.c:75:         wave_base = g_armwave_state.wave_buffer + slice_y + (w * g_armwave_state.wave_stride);
	.loc 1 75 36 view .LVU1078
	ldr	ip, [r4, #20]	@ _20, g_armwave_state.wave_buffer
@ armwave.c:75:         wave_base = g_armwave_state.wave_buffer + slice_y + (w * g_armwave_state.wave_stride);
	.loc 1 75 64 view .LVU1079
	mul	r2, r2, lr	@ _23, g_armwave_state.wave_stride, w
.LVL293:
	.loc 1 79 9 is_stmt 1 view .LVU1080
	.loc 1 79 9 is_stmt 0 view .LVU1081
	beq	.L254		@,
	add	r2, r2, r6	@ tmp202, _23, _80
.LVL294:
	.loc 1 79 9 view .LVU1082
	add	ip, ip, r2	@ ivtmp.166, _20, tmp202
.LVL295:
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 16 view .LVU1083
	mov	r2, #0	@ yy,
.LVL296:
.L255:
	.loc 1 80 13 is_stmt 1 view .LVU1084
@ armwave.c:80:             word = *(uint32_t*)(wave_base + yy);
	.loc 1 80 18 is_stmt 0 view .LVU1085
	ldr	r1, [ip, #4]!	@ word, MEM[base: _183, offset: 0B]
.LVL297:
	.loc 1 82 13 is_stmt 1 view .LVU1086
	.loc 1 84 17 view .LVU1087
	.loc 1 85 17 view .LVU1088
	.loc 1 86 17 view .LVU1089
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU1090
	ldr	r9, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
	add	fp, r2, #1	@ tmp214, yy,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU1091
	uxtab	r8, r0, r1	@ tmp207, _19, word
	mla	r9, r9, r2, r8	@ tmp208, g_armwave_state.bitdepth_height, yy, tmp207
@ armwave.c:87:                 word >>= 8;
	.loc 1 87 22 view .LVU1092
	lsr	r10, r1, #8	@ word, word,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU1093
	ldrb	r8, [r3, r9]	@ zero_extendqisi2	@ *_67, *_67
	uxtab	r10, r0, r10	@ tmp219, _19, word
	add	r8, r8, #1	@ tmp211, *_67,
	strb	r8, [r3, r9]	@ tmp211, *_67
.LVL298:
	.loc 1 87 17 is_stmt 1 view .LVU1094
	.loc 1 84 17 view .LVU1095
	.loc 1 85 17 view .LVU1096
	.loc 1 86 17 view .LVU1097
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU1098
	ldr	r8, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:87:                 word >>= 8;
	.loc 1 87 22 view .LVU1099
	lsr	r9, r1, #16	@ word, word,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU1100
	add	r1, r0, r1, lsr #24	@ tmp242, _19, word,
.LVL299:
	.loc 1 86 47 view .LVU1101
	mla	r8, r8, fp, r10	@ tmp220, g_armwave_state.bitdepth_height, tmp214, tmp219
	uxtab	r10, r0, r9	@ tmp227, _19, word
	ldrb	fp, [r3, r8]	@ zero_extendqisi2	@ *_87, *_87
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 view .LVU1102
	add	r9, r2, #2	@ tmp229, yy,
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU1103
	add	fp, fp, #1	@ tmp223, *_87,
	strb	fp, [r3, r8]	@ tmp223, *_87
.LVL300:
	.loc 1 87 17 is_stmt 1 view .LVU1104
	.loc 1 84 17 view .LVU1105
	.loc 1 85 17 view .LVU1106
	.loc 1 86 17 view .LVU1107
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU1108
	ldr	fp, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
	add	r8, r2, #3	@ tmp238, yy,
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 37 view .LVU1109
	add	r2, r2, #4	@ yy, yy,
.LVL301:
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU1110
	mla	r9, fp, r9, r10	@ tmp232, g_armwave_state.bitdepth_height, tmp229, tmp227
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 view .LVU1111
	cmp	r7, r2	@ _2, yy
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU1112
	ldrb	r10, [r3, r9]	@ zero_extendqisi2	@ *_107, *_107
	add	r10, r10, #1	@ tmp235, *_107,
	strb	r10, [r3, r9]	@ tmp235, *_107
.LVL302:
	.loc 1 87 17 is_stmt 1 view .LVU1113
	.loc 1 84 17 view .LVU1114
	.loc 1 85 17 view .LVU1115
	.loc 1 86 17 view .LVU1116
@ armwave.c:85:                 write_buffer = write_buffer_base + ((yy + ys) * g_armwave_state.bitdepth_height);
	.loc 1 85 63 is_stmt 0 view .LVU1117
	ldr	r9, [r4, #40]	@ g_armwave_state.bitdepth_height, g_armwave_state.bitdepth_height
@ armwave.c:86:                 *(write_buffer + scale_value) += 1;
	.loc 1 86 47 view .LVU1118
	mla	r1, r9, r8, r1	@ tmp243, g_armwave_state.bitdepth_height, tmp238, tmp242
	ldrb	r8, [r3, r1]	@ zero_extendqisi2	@ *_127, *_127
	add	r8, r8, #1	@ tmp246, *_127,
	strb	r8, [r3, r1]	@ tmp246, *_127
	.loc 1 87 17 is_stmt 1 view .LVU1119
.LVL303:
@ armwave.c:79:         for(yy = 0; yy < height; yy += 4) {
	.loc 1 79 9 is_stmt 0 view .LVU1120
	bhi	.L255		@,
	ldr	r10, [r4, #36]	@ prephitmp_184, g_armwave_state.waves
.LVL304:
.L254:
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 44 view .LVU1121
	add	lr, lr, #1	@ w, w,
.LVL305:
@ armwave.c:74:     for(w = 0; w < g_armwave_state.waves; w++) {
	.loc 1 74 5 view .LVU1122
	cmp	lr, r10	@ w, prephitmp_184
	bcc	.L256		@,
	ldr	r6, [r4, #44]	@ _119, g_armwave_state.slice_height
.LVL306:
.L253:
	.loc 1 74 5 view .LVU1123
.LBE45:
.LBE46:
@ armwave.c:468:         for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 468 32 discriminator 3 view .LVU1124
	mov	r1, r6	@, _119
	mov	r0, #2048	@,
.LVL307:
	.loc 1 468 32 discriminator 3 view .LVU1125
	bl	__aeabi_uidiv		@
.LVL308:
@ armwave.c:468:         for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 468 67 discriminator 3 view .LVU1126
	add	r5, r5, #1	@ yy, yy,
.LVL309:
@ armwave.c:468:         for(yy = 0; yy < (2048 / g_armwave_state.slice_height); yy++) {
	.loc 1 468 9 discriminator 3 view .LVU1127
	cmp	r0, r5	@, yy
	bhi	.L257		@,
.LVL310:
.L260:
@ armwave.c:467:     for(n = 0; n < 5000; n++) {
	.loc 1 467 5 discriminator 2 view .LVU1128
	ldr	r3, [sp, #4]	@ ivtmp_197, %sfp
	subs	r3, r3, #1	@ ivtmp_197, ivtmp_197,
	str	r3, [sp, #4]	@ ivtmp_197, %sfp
	bne	.L252		@,
	mov	r0, r3	@, ivtmp_197
	.loc 1 483 5 is_stmt 1 view .LVU1129
@ armwave.c:484: }
	.loc 1 484 1 is_stmt 0 view .LVU1130
	add	sp, sp, #12	@,,
	.cfi_def_cfa_offset 36
	@ sp needed	@
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}	@
.L272:
	.align	2
.L271:
	.word	897988541
	.word	1056964608
	.word	g_armwave_state
	.word	5000
	.cfi_endproc
.LFE73:
	.size	main, .-main
	.comm	gamma_table,256,4
	.comm	test_wave_buffer,131072,4
	.comm	g_armwave_state,108,4
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	__PRETTY_FUNCTION__.16995, %object
	.size	__PRETTY_FUNCTION__.16995, 21
__PRETTY_FUNCTION__.16995:
	.ascii	"armwave_setup_render\000"
	.space	3
	.type	__PRETTY_FUNCTION__.17031, %object
	.size	__PRETTY_FUNCTION__.17031, 24
__PRETTY_FUNCTION__.17031:
	.ascii	"armwave_fill_pixbuf_256\000"
	.type	__PRETTY_FUNCTION__.17062, %object
	.size	__PRETTY_FUNCTION__.17062, 27
__PRETTY_FUNCTION__.17062:
	.ascii	"armwave_fill_pixbuf_scaled\000"
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"armwave.c\000"
	.space	2
.LC1:
	.ascii	"target_height == 256 || target_height == 512 || tar"
	.ascii	"get_height == 1024 || target_height == 2048\000"
	.space	1
.LC2:
	.ascii	"ch_buff_size=%d\012\000"
	.space	3
.LC3:
	.ascii	"g_armwave_state.ch1_buffer != NULL\000"
	.space	1
.LC4:
	.ascii	"g_armwave_state.xcoord_to_xpixel != NULL\000"
	.space	3
.LC5:
	.ascii	"start_point < end_point\000"
.LC6:
	.ascii	"out_buffer != NULL\000"
	.space	1
.LC7:
	.ascii	"wb\000"
	.space	1
.LC8:
	.ascii	"P3\012\000"
.LC9:
	.ascii	"%d %d\012\000"
	.space	1
.LC10:
	.ascii	"255\012\000"
	.space	3
.LC11:
	.ascii	"%3d %3d %3d\012\000"
	.space	3
.LC12:
	.ascii	"v0.0.1\000"
	.space	1
.LC13:
	.ascii	"armwave version: %s\012\000"
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/arm-linux-gnueabihf/8/include/stddef.h"
	.file 3 "/usr/include/arm-linux-gnueabihf/bits/types.h"
	.file 4 "/usr/include/arm-linux-gnueabihf/bits/types/struct_FILE.h"
	.file 5 "/usr/include/arm-linux-gnueabihf/bits/types/FILE.h"
	.file 6 "/usr/include/stdio.h"
	.file 7 "/usr/include/arm-linux-gnueabihf/bits/sys_errlist.h"
	.file 8 "/usr/include/errno.h"
	.file 9 "/usr/include/arm-linux-gnueabihf/bits/stdint-intn.h"
	.file 10 "/usr/include/unistd.h"
	.file 11 "/usr/include/arm-linux-gnueabihf/bits/getopt_core.h"
	.file 12 "/usr/include/arm-linux-gnueabihf/bits/stdint-uintn.h"
	.file 13 "/usr/local/include/python3.8/pyport.h"
	.file 14 "/usr/include/math.h"
	.file 15 "/usr/include/arm-linux-gnueabihf/sys/time.h"
	.file 16 "/usr/include/time.h"
	.file 17 "/usr/local/include/python3.8/pymem.h"
	.file 18 "/usr/local/include/python3.8/object.h"
	.file 19 "/usr/local/include/python3.8/cpython/object.h"
	.file 20 "/usr/local/include/python3.8/methodobject.h"
	.file 21 "/usr/local/include/python3.8/descrobject.h"
	.file 22 "/usr/local/include/python3.8/pyhash.h"
	.file 23 "/usr/local/include/python3.8/pydebug.h"
	.file 24 "/usr/local/include/python3.8/bytearrayobject.h"
	.file 25 "/usr/local/include/python3.8/bytesobject.h"
	.file 26 "/usr/local/include/python3.8/unicodeobject.h"
	.file 27 "/usr/local/include/python3.8/cpython/unicodeobject.h"
	.file 28 "/usr/local/include/python3.8/longintrepr.h"
	.file 29 "/usr/local/include/python3.8/longobject.h"
	.file 30 "/usr/local/include/python3.8/boolobject.h"
	.file 31 "/usr/local/include/python3.8/floatobject.h"
	.file 32 "/usr/local/include/python3.8/complexobject.h"
	.file 33 "/usr/local/include/python3.8/rangeobject.h"
	.file 34 "/usr/local/include/python3.8/memoryobject.h"
	.file 35 "/usr/local/include/python3.8/tupleobject.h"
	.file 36 "/usr/local/include/python3.8/listobject.h"
	.file 37 "/usr/local/include/python3.8/dictobject.h"
	.file 38 "/usr/local/include/python3.8/odictobject.h"
	.file 39 "/usr/local/include/python3.8/enumobject.h"
	.file 40 "/usr/local/include/python3.8/setobject.h"
	.file 41 "/usr/local/include/python3.8/moduleobject.h"
	.file 42 "/usr/local/include/python3.8/funcobject.h"
	.file 43 "/usr/local/include/python3.8/classobject.h"
	.file 44 "/usr/local/include/python3.8/fileobject.h"
	.file 45 "/usr/local/include/python3.8/cpython/fileobject.h"
	.file 46 "/usr/local/include/python3.8/pycapsule.h"
	.file 47 "/usr/local/include/python3.8/traceback.h"
	.file 48 "/usr/local/include/python3.8/sliceobject.h"
	.file 49 "/usr/local/include/python3.8/cellobject.h"
	.file 50 "/usr/local/include/python3.8/iterobject.h"
	.file 51 "/usr/local/include/python3.8/pystate.h"
	.file 52 "/usr/local/include/python3.8/cpython/pystate.h"
	.file 53 "/usr/local/include/python3.8/genobject.h"
	.file 54 "/usr/local/include/python3.8/weakrefobject.h"
	.file 55 "/usr/local/include/python3.8/structseq.h"
	.file 56 "/usr/local/include/python3.8/namespaceobject.h"
	.file 57 "/usr/local/include/python3.8/picklebufobject.h"
	.file 58 "/usr/local/include/python3.8/codecs.h"
	.file 59 "/usr/local/include/python3.8/pyerrors.h"
	.file 60 "/usr/local/include/python3.8/context.h"
	.file 61 "/usr/local/include/python3.8/modsupport.h"
	.file 62 "/usr/local/include/python3.8/code.h"
	.file 63 "/usr/local/include/python3.8/pythonrun.h"
	.file 64 "/usr/local/include/python3.8/ceval.h"
	.file 65 "/usr/local/include/python3.8/import.h"
	.file 66 "/usr/local/include/python3.8/bltinmodule.h"
	.file 67 "/usr/local/include/python3.8/pyctype.h"
	.file 68 "armwave.h"
	.file 69 "/usr/include/stdlib.h"
	.file 70 "/usr/include/assert.h"
	.file 71 "/usr/include/arm-linux-gnueabihf/bits/mathcalls.h"
	.file 72 "<built-in>"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x34d6
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF618
	.byte	0xc
	.4byte	.LASF619
	.4byte	.LASF620
	.4byte	.Ldebug_ranges0+0xa8
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF0
	.uleb128 0x2
	.byte	0x8
	.byte	0x4
	.4byte	.LASF1
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0x4
	.4byte	.LASF7
	.byte	0x2
	.byte	0xd8
	.byte	0x17
	.4byte	0x3a
	.uleb128 0x5
	.4byte	0x3a
	.uleb128 0x6
	.byte	0x4
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x5
	.4byte	0x54
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF6
	.uleb128 0x4
	.4byte	.LASF8
	.byte	0x3
	.byte	0x25
	.byte	0x17
	.4byte	0x54
	.uleb128 0x4
	.4byte	.LASF9
	.byte	0x3
	.byte	0x26
	.byte	0x1a
	.4byte	0x8d
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF10
	.uleb128 0x4
	.4byte	.LASF11
	.byte	0x3
	.byte	0x27
	.byte	0x1c
	.4byte	0x60
	.uleb128 0x4
	.4byte	.LASF12
	.byte	0x3
	.byte	0x29
	.byte	0x16
	.4byte	0x3a
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF13
	.uleb128 0x4
	.4byte	.LASF14
	.byte	0x3
	.byte	0x2f
	.byte	0x2e
	.4byte	0xbf
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF15
	.uleb128 0x4
	.4byte	.LASF16
	.byte	0x3
	.byte	0x41
	.byte	0x25
	.4byte	0xac
	.uleb128 0x4
	.4byte	.LASF17
	.byte	0x3
	.byte	0x96
	.byte	0x19
	.4byte	0xde
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF18
	.uleb128 0x4
	.4byte	.LASF19
	.byte	0x3
	.byte	0x97
	.byte	0x1b
	.4byte	0xc6
	.uleb128 0x4
	.4byte	.LASF20
	.byte	0x3
	.byte	0xbf
	.byte	0x1b
	.4byte	0x33
	.uleb128 0x7
	.byte	0x4
	.4byte	0x103
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF21
	.uleb128 0x5
	.4byte	0x103
	.uleb128 0x8
	.4byte	.LASF79
	.byte	0x98
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.4byte	0x296
	.uleb128 0x9
	.4byte	.LASF22
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.4byte	0x33
	.byte	0
	.uleb128 0x9
	.4byte	.LASF23
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.4byte	0xfd
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF24
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.4byte	0xfd
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF25
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.4byte	0xfd
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF26
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.4byte	0xfd
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF27
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.4byte	0xfd
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF28
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.4byte	0xfd
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF29
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.4byte	0xfd
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF30
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.4byte	0xfd
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF31
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.4byte	0xfd
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF32
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.4byte	0xfd
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF33
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.4byte	0xfd
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF34
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.4byte	0x2af
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF35
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.4byte	0x2b5
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF36
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.4byte	0x33
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF37
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.4byte	0x33
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF38
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.4byte	0xd2
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF39
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.4byte	0x60
	.byte	0x44
	.uleb128 0x9
	.4byte	.LASF40
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.4byte	0x6e
	.byte	0x46
	.uleb128 0x9
	.4byte	.LASF41
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.4byte	0x2bb
	.byte	0x47
	.uleb128 0x9
	.4byte	.LASF42
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.4byte	0x2cb
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF43
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.4byte	0xe5
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF44
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.4byte	0x2d6
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF45
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.4byte	0x2e1
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF46
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.4byte	0x2b5
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF47
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.4byte	0x52
	.byte	0x64
	.uleb128 0x9
	.4byte	.LASF48
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.4byte	0x41
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF49
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.4byte	0x33
	.byte	0x6c
	.uleb128 0x9
	.4byte	.LASF50
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.4byte	0x2e7
	.byte	0x70
	.byte	0
	.uleb128 0x4
	.4byte	.LASF51
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.4byte	0x10f
	.uleb128 0xa
	.4byte	.LASF621
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xb
	.4byte	.LASF52
	.uleb128 0x7
	.byte	0x4
	.4byte	0x2aa
	.uleb128 0x7
	.byte	0x4
	.4byte	0x10f
	.uleb128 0xc
	.4byte	0x103
	.4byte	0x2cb
	.uleb128 0xd
	.4byte	0x3a
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x2a2
	.uleb128 0xb
	.4byte	.LASF53
	.uleb128 0x7
	.byte	0x4
	.4byte	0x2d1
	.uleb128 0xb
	.4byte	.LASF54
	.uleb128 0x7
	.byte	0x4
	.4byte	0x2dc
	.uleb128 0xc
	.4byte	0x103
	.4byte	0x2f7
	.uleb128 0xd
	.4byte	0x3a
	.byte	0x27
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x10a
	.uleb128 0x5
	.4byte	0x2f7
	.uleb128 0x4
	.4byte	.LASF55
	.byte	0x6
	.byte	0x4d
	.byte	0x13
	.4byte	0xf1
	.uleb128 0xe
	.4byte	.LASF56
	.byte	0x6
	.byte	0x89
	.byte	0xe
	.4byte	0x31a
	.uleb128 0x7
	.byte	0x4
	.4byte	0x296
	.uleb128 0xe
	.4byte	.LASF57
	.byte	0x6
	.byte	0x8a
	.byte	0xe
	.4byte	0x31a
	.uleb128 0xe
	.4byte	.LASF58
	.byte	0x6
	.byte	0x8b
	.byte	0xe
	.4byte	0x31a
	.uleb128 0xe
	.4byte	.LASF59
	.byte	0x7
	.byte	0x1a
	.byte	0xc
	.4byte	0x33
	.uleb128 0xc
	.4byte	0x2fd
	.4byte	0x34f
	.uleb128 0xf
	.byte	0
	.uleb128 0x5
	.4byte	0x344
	.uleb128 0xe
	.4byte	.LASF60
	.byte	0x7
	.byte	0x1b
	.byte	0x1a
	.4byte	0x34f
	.uleb128 0xe
	.4byte	.LASF61
	.byte	0x7
	.byte	0x1e
	.byte	0xc
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF62
	.byte	0x7
	.byte	0x1f
	.byte	0x1a
	.4byte	0x34f
	.uleb128 0xe
	.4byte	.LASF63
	.byte	0x8
	.byte	0x2d
	.byte	0xe
	.4byte	0xfd
	.uleb128 0xe
	.4byte	.LASF64
	.byte	0x8
	.byte	0x2e
	.byte	0xe
	.4byte	0xfd
	.uleb128 0x4
	.4byte	.LASF65
	.byte	0x9
	.byte	0x19
	.byte	0x13
	.4byte	0x81
	.uleb128 0x10
	.4byte	.LASF66
	.byte	0xa
	.2byte	0x21f
	.byte	0xf
	.4byte	0x3a9
	.uleb128 0x7
	.byte	0x4
	.4byte	0xfd
	.uleb128 0x10
	.4byte	.LASF67
	.byte	0xa
	.2byte	0x221
	.byte	0xf
	.4byte	0x3a9
	.uleb128 0xe
	.4byte	.LASF68
	.byte	0xb
	.byte	0x24
	.byte	0xe
	.4byte	0xfd
	.uleb128 0xe
	.4byte	.LASF69
	.byte	0xb
	.byte	0x32
	.byte	0xc
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF70
	.byte	0xb
	.byte	0x37
	.byte	0xc
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF71
	.byte	0xb
	.byte	0x3b
	.byte	0xc
	.4byte	0x33
	.uleb128 0x4
	.4byte	.LASF72
	.byte	0xc
	.byte	0x18
	.byte	0x13
	.4byte	0x75
	.uleb128 0x4
	.4byte	.LASF73
	.byte	0xc
	.byte	0x19
	.byte	0x14
	.4byte	0x94
	.uleb128 0x4
	.4byte	.LASF74
	.byte	0xc
	.byte	0x1a
	.byte	0x14
	.4byte	0xa0
	.uleb128 0x4
	.4byte	.LASF75
	.byte	0xc
	.byte	0x1b
	.byte	0x14
	.4byte	0xb3
	.uleb128 0x4
	.4byte	.LASF76
	.byte	0xd
	.byte	0x69
	.byte	0x19
	.4byte	0x302
	.uleb128 0x4
	.4byte	.LASF77
	.byte	0xd
	.byte	0x72
	.byte	0x14
	.4byte	0x41c
	.uleb128 0x10
	.4byte	.LASF78
	.byte	0xe
	.2byte	0x305
	.byte	0xc
	.4byte	0x33
	.uleb128 0x8
	.4byte	.LASF80
	.byte	0x8
	.byte	0xf
	.byte	0x34
	.byte	0x8
	.4byte	0x469
	.uleb128 0x9
	.4byte	.LASF81
	.byte	0xf
	.byte	0x36
	.byte	0x9
	.4byte	0x33
	.byte	0
	.uleb128 0x9
	.4byte	.LASF82
	.byte	0xf
	.byte	0x37
	.byte	0x9
	.4byte	0x33
	.byte	0x4
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x441
	.uleb128 0x11
	.4byte	0x469
	.uleb128 0xc
	.4byte	0xfd
	.4byte	0x484
	.uleb128 0xd
	.4byte	0x3a
	.byte	0x1
	.byte	0
	.uleb128 0xe
	.4byte	.LASF83
	.byte	0x10
	.byte	0x9f
	.byte	0xe
	.4byte	0x474
	.uleb128 0xe
	.4byte	.LASF84
	.byte	0x10
	.byte	0xa0
	.byte	0xc
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF85
	.byte	0x10
	.byte	0xa1
	.byte	0x11
	.4byte	0xde
	.uleb128 0xe
	.4byte	.LASF86
	.byte	0x10
	.byte	0xa6
	.byte	0xe
	.4byte	0x474
	.uleb128 0xe
	.4byte	.LASF87
	.byte	0x10
	.byte	0xae
	.byte	0xc
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF80
	.byte	0x10
	.byte	0xaf
	.byte	0x11
	.4byte	0xde
	.uleb128 0x10
	.4byte	.LASF88
	.byte	0x10
	.2byte	0x118
	.byte	0xc
	.4byte	0x33
	.uleb128 0x12
	.byte	0x7
	.byte	0x4
	.4byte	0x3a
	.byte	0x11
	.byte	0x70
	.byte	0xa
	.4byte	0x4fa
	.uleb128 0x13
	.4byte	.LASF89
	.byte	0
	.uleb128 0x13
	.4byte	.LASF90
	.byte	0x1
	.uleb128 0x13
	.4byte	.LASF91
	.byte	0x2
	.byte	0
	.uleb128 0x8
	.4byte	.LASF92
	.byte	0x10
	.byte	0x11
	.byte	0x6d
	.byte	0x8
	.4byte	0x53c
	.uleb128 0x9
	.4byte	.LASF93
	.byte	0x11
	.byte	0x74
	.byte	0x7
	.4byte	0x4d9
	.byte	0
	.uleb128 0x9
	.4byte	.LASF94
	.byte	0x11
	.byte	0x78
	.byte	0x9
	.4byte	0x33
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF95
	.byte	0x11
	.byte	0x7c
	.byte	0x9
	.4byte	0x33
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF96
	.byte	0x11
	.byte	0x80
	.byte	0x9
	.4byte	0x33
	.byte	0xc
	.byte	0
	.uleb128 0xe
	.4byte	.LASF97
	.byte	0x11
	.byte	0x83
	.byte	0x2a
	.4byte	0x4fa
	.uleb128 0x8
	.4byte	.LASF98
	.byte	0x8
	.byte	0x12
	.byte	0x68
	.byte	0x10
	.4byte	0x570
	.uleb128 0x9
	.4byte	.LASF99
	.byte	0x12
	.byte	0x6a
	.byte	0x10
	.4byte	0x41c
	.byte	0
	.uleb128 0x9
	.4byte	.LASF100
	.byte	0x12
	.byte	0x6b
	.byte	0x19
	.4byte	0x80b
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.4byte	.LASF101
	.byte	0xd0
	.byte	0x13
	.byte	0xb1
	.byte	0x10
	.4byte	0x80b
	.uleb128 0x9
	.4byte	.LASF102
	.byte	0x13
	.byte	0xb2
	.byte	0x5
	.4byte	0x841
	.byte	0
	.uleb128 0x9
	.4byte	.LASF103
	.byte	0x13
	.byte	0xb3
	.byte	0x11
	.4byte	0x2f7
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF104
	.byte	0x13
	.byte	0xb4
	.byte	0x10
	.4byte	0x41c
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF105
	.byte	0x13
	.byte	0xb4
	.byte	0x1e
	.4byte	0x41c
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF106
	.byte	0x13
	.byte	0xb8
	.byte	0x10
	.4byte	0xa1c
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF107
	.byte	0x13
	.byte	0xb9
	.byte	0x10
	.4byte	0x41c
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF108
	.byte	0x13
	.byte	0xba
	.byte	0x11
	.4byte	0xa39
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF109
	.byte	0x13
	.byte	0xbb
	.byte	0x11
	.4byte	0xa6b
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF110
	.byte	0x13
	.byte	0xbc
	.byte	0x15
	.4byte	0x1029
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF111
	.byte	0x13
	.byte	0xbe
	.byte	0xe
	.4byte	0xaa2
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF112
	.byte	0x13
	.byte	0xc2
	.byte	0x16
	.4byte	0x102f
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF113
	.byte	0x13
	.byte	0xc3
	.byte	0x18
	.4byte	0x1035
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF114
	.byte	0x13
	.byte	0xc4
	.byte	0x17
	.4byte	0x103b
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF115
	.byte	0x13
	.byte	0xc8
	.byte	0xe
	.4byte	0xaae
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF116
	.byte	0x13
	.byte	0xc9
	.byte	0x11
	.4byte	0x89f
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF117
	.byte	0x13
	.byte	0xca
	.byte	0xe
	.4byte	0xaa2
	.byte	0x44
	.uleb128 0x9
	.4byte	.LASF118
	.byte	0x13
	.byte	0xcb
	.byte	0x12
	.4byte	0xa5f
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF119
	.byte	0x13
	.byte	0xcc
	.byte	0x12
	.4byte	0xa96
	.byte	0x4c
	.uleb128 0x9
	.4byte	.LASF120
	.byte	0x13
	.byte	0xcf
	.byte	0x14
	.4byte	0x1041
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF121
	.byte	0x13
	.byte	0xd2
	.byte	0x13
	.4byte	0x67
	.byte	0x54
	.uleb128 0x9
	.4byte	.LASF122
	.byte	0x13
	.byte	0xd4
	.byte	0x11
	.4byte	0x2f7
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF123
	.byte	0x13
	.byte	0xd8
	.byte	0x12
	.4byte	0x9d4
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF124
	.byte	0x13
	.byte	0xdb
	.byte	0xd
	.4byte	0x8ca
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF125
	.byte	0x13
	.byte	0xdf
	.byte	0x11
	.4byte	0xacf
	.byte	0x64
	.uleb128 0x9
	.4byte	.LASF126
	.byte	0x13
	.byte	0xe2
	.byte	0x10
	.4byte	0x41c
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF127
	.byte	0x13
	.byte	0xe5
	.byte	0x11
	.4byte	0xafa
	.byte	0x6c
	.uleb128 0x9
	.4byte	.LASF128
	.byte	0x13
	.byte	0xe6
	.byte	0x12
	.4byte	0xb06
	.byte	0x70
	.uleb128 0x9
	.4byte	.LASF129
	.byte	0x13
	.byte	0xe9
	.byte	0x19
	.4byte	0x1089
	.byte	0x74
	.uleb128 0x9
	.4byte	.LASF130
	.byte	0x13
	.byte	0xea
	.byte	0x19
	.4byte	0x1094
	.byte	0x78
	.uleb128 0x9
	.4byte	.LASF131
	.byte	0x13
	.byte	0xeb
	.byte	0x19
	.4byte	0x10e9
	.byte	0x7c
	.uleb128 0x9
	.4byte	.LASF132
	.byte	0x13
	.byte	0xec
	.byte	0x19
	.4byte	0x80b
	.byte	0x80
	.uleb128 0x9
	.4byte	.LASF133
	.byte	0x13
	.byte	0xed
	.byte	0xf
	.4byte	0x86e
	.byte	0x84
	.uleb128 0x9
	.4byte	.LASF134
	.byte	0x13
	.byte	0xee
	.byte	0x12
	.4byte	0xb12
	.byte	0x88
	.uleb128 0x9
	.4byte	.LASF135
	.byte	0x13
	.byte	0xef
	.byte	0x12
	.4byte	0xb1e
	.byte	0x8c
	.uleb128 0x9
	.4byte	.LASF136
	.byte	0x13
	.byte	0xf0
	.byte	0x10
	.4byte	0x41c
	.byte	0x90
	.uleb128 0x9
	.4byte	.LASF137
	.byte	0x13
	.byte	0xf1
	.byte	0xe
	.4byte	0xb2a
	.byte	0x94
	.uleb128 0x9
	.4byte	.LASF138
	.byte	0x13
	.byte	0xf2
	.byte	0xf
	.4byte	0xb61
	.byte	0x98
	.uleb128 0x9
	.4byte	.LASF139
	.byte	0x13
	.byte	0xf3
	.byte	0xd
	.4byte	0xb36
	.byte	0x9c
	.uleb128 0x9
	.4byte	.LASF140
	.byte	0x13
	.byte	0xf4
	.byte	0xe
	.4byte	0x9ff
	.byte	0xa0
	.uleb128 0x9
	.4byte	.LASF141
	.byte	0x13
	.byte	0xf5
	.byte	0xd
	.4byte	0x8ca
	.byte	0xa4
	.uleb128 0x9
	.4byte	.LASF142
	.byte	0x13
	.byte	0xf6
	.byte	0xf
	.4byte	0x86e
	.byte	0xa8
	.uleb128 0x9
	.4byte	.LASF143
	.byte	0x13
	.byte	0xf7
	.byte	0xf
	.4byte	0x86e
	.byte	0xac
	.uleb128 0x9
	.4byte	.LASF144
	.byte	0x13
	.byte	0xf8
	.byte	0xf
	.4byte	0x86e
	.byte	0xb0
	.uleb128 0x9
	.4byte	.LASF145
	.byte	0x13
	.byte	0xf9
	.byte	0xf
	.4byte	0x86e
	.byte	0xb4
	.uleb128 0x9
	.4byte	.LASF146
	.byte	0x13
	.byte	0xfa
	.byte	0xf
	.4byte	0x86e
	.byte	0xb8
	.uleb128 0x9
	.4byte	.LASF147
	.byte	0x13
	.byte	0xfb
	.byte	0x10
	.4byte	0xa1c
	.byte	0xbc
	.uleb128 0x9
	.4byte	.LASF148
	.byte	0x13
	.byte	0xfe
	.byte	0x12
	.4byte	0x3a
	.byte	0xc0
	.uleb128 0x14
	.4byte	.LASF149
	.byte	0x13
	.2byte	0x100
	.byte	0x10
	.4byte	0xa1c
	.byte	0xc4
	.uleb128 0x14
	.4byte	.LASF150
	.byte	0x13
	.2byte	0x101
	.byte	0x14
	.4byte	0xcc7
	.byte	0xc8
	.uleb128 0x14
	.4byte	.LASF151
	.byte	0x13
	.2byte	0x104
	.byte	0x1e
	.4byte	0x1108
	.byte	0xcc
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x570
	.uleb128 0x4
	.4byte	.LASF152
	.byte	0x12
	.byte	0x6c
	.byte	0x3
	.4byte	0x548
	.uleb128 0x15
	.byte	0xc
	.byte	0x12
	.byte	0x71
	.byte	0x9
	.4byte	0x841
	.uleb128 0x9
	.4byte	.LASF102
	.byte	0x12
	.byte	0x72
	.byte	0xe
	.4byte	0x811
	.byte	0
	.uleb128 0x9
	.4byte	.LASF153
	.byte	0x12
	.byte	0x73
	.byte	0x10
	.4byte	0x41c
	.byte	0x8
	.byte	0
	.uleb128 0x4
	.4byte	.LASF154
	.byte	0x12
	.byte	0x74
	.byte	0x3
	.4byte	0x81d
	.uleb128 0x4
	.4byte	.LASF155
	.byte	0x12
	.byte	0x8c
	.byte	0x16
	.4byte	0x859
	.uleb128 0x7
	.byte	0x4
	.4byte	0x85f
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x811
	.uleb128 0x5
	.4byte	0x86e
	.uleb128 0x4
	.4byte	.LASF156
	.byte	0x12
	.byte	0x8d
	.byte	0x16
	.4byte	0x885
	.uleb128 0x7
	.byte	0x4
	.4byte	0x88b
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0x89f
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF157
	.byte	0x12
	.byte	0x8e
	.byte	0x16
	.4byte	0x8ab
	.uleb128 0x7
	.byte	0x4
	.4byte	0x8b1
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0x8ca
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF158
	.byte	0x12
	.byte	0x8f
	.byte	0xf
	.4byte	0x8d6
	.uleb128 0x7
	.byte	0x4
	.4byte	0x8dc
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x8eb
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF159
	.byte	0x12
	.byte	0x90
	.byte	0x16
	.4byte	0x8f7
	.uleb128 0x7
	.byte	0x4
	.4byte	0x8fd
	.uleb128 0x16
	.4byte	0x41c
	.4byte	0x90c
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF160
	.byte	0x12
	.byte	0x91
	.byte	0x15
	.4byte	0x918
	.uleb128 0x7
	.byte	0x4
	.4byte	0x91e
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0x932
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x41c
	.byte	0
	.uleb128 0x4
	.4byte	.LASF161
	.byte	0x12
	.byte	0x93
	.byte	0xe
	.4byte	0x93e
	.uleb128 0x7
	.byte	0x4
	.4byte	0x944
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x95d
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x41c
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF162
	.byte	0x12
	.byte	0x95
	.byte	0xe
	.4byte	0x969
	.uleb128 0x7
	.byte	0x4
	.4byte	0x96f
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x988
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF163
	.byte	0x12
	.byte	0x97
	.byte	0xf
	.4byte	0x994
	.uleb128 0x7
	.byte	0x4
	.4byte	0x99a
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x9ae
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF164
	.byte	0x12
	.byte	0x98
	.byte	0xf
	.4byte	0x9ba
	.uleb128 0x7
	.byte	0x4
	.4byte	0x9c0
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x9d4
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x52
	.byte	0
	.uleb128 0x4
	.4byte	.LASF165
	.byte	0x12
	.byte	0x99
	.byte	0xf
	.4byte	0x9e0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x9e6
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x9ff
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x9ae
	.uleb128 0x17
	.4byte	0x52
	.byte	0
	.uleb128 0x4
	.4byte	.LASF166
	.byte	0x12
	.byte	0x9c
	.byte	0x10
	.4byte	0xa0b
	.uleb128 0x7
	.byte	0x4
	.4byte	0xa11
	.uleb128 0x18
	.4byte	0xa1c
	.uleb128 0x17
	.4byte	0x52
	.byte	0
	.uleb128 0x4
	.4byte	.LASF167
	.byte	0x12
	.byte	0x9d
	.byte	0x10
	.4byte	0xa28
	.uleb128 0x7
	.byte	0x4
	.4byte	0xa2e
	.uleb128 0x18
	.4byte	0xa39
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF168
	.byte	0x12
	.byte	0x9e
	.byte	0x15
	.4byte	0xa45
	.uleb128 0x7
	.byte	0x4
	.4byte	0xa4b
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0xa5f
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0xfd
	.byte	0
	.uleb128 0x4
	.4byte	.LASF169
	.byte	0x12
	.byte	0x9f
	.byte	0x15
	.4byte	0x885
	.uleb128 0x4
	.4byte	.LASF170
	.byte	0x12
	.byte	0xa0
	.byte	0xf
	.4byte	0xa77
	.uleb128 0x7
	.byte	0x4
	.4byte	0xa7d
	.uleb128 0x16
	.4byte	0x33
	.4byte	0xa96
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0xfd
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF171
	.byte	0x12
	.byte	0xa1
	.byte	0xf
	.4byte	0x969
	.uleb128 0x4
	.4byte	.LASF172
	.byte	0x12
	.byte	0xa2
	.byte	0x15
	.4byte	0x859
	.uleb128 0x4
	.4byte	.LASF173
	.byte	0x12
	.byte	0xa3
	.byte	0x15
	.4byte	0xaba
	.uleb128 0x7
	.byte	0x4
	.4byte	0xac0
	.uleb128 0x16
	.4byte	0x428
	.4byte	0xacf
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF174
	.byte	0x12
	.byte	0xa4
	.byte	0x15
	.4byte	0xadb
	.uleb128 0x7
	.byte	0x4
	.4byte	0xae1
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0xafa
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x33
	.byte	0
	.uleb128 0x4
	.4byte	.LASF175
	.byte	0x12
	.byte	0xa5
	.byte	0x15
	.4byte	0x859
	.uleb128 0x4
	.4byte	.LASF176
	.byte	0x12
	.byte	0xa6
	.byte	0x15
	.4byte	0x859
	.uleb128 0x4
	.4byte	.LASF177
	.byte	0x12
	.byte	0xa7
	.byte	0x15
	.4byte	0x8ab
	.uleb128 0x4
	.4byte	.LASF178
	.byte	0x12
	.byte	0xa8
	.byte	0xf
	.4byte	0x969
	.uleb128 0x4
	.4byte	.LASF179
	.byte	0x12
	.byte	0xa9
	.byte	0xf
	.4byte	0x969
	.uleb128 0x4
	.4byte	.LASF180
	.byte	0x12
	.byte	0xaa
	.byte	0x15
	.4byte	0xb42
	.uleb128 0x7
	.byte	0x4
	.4byte	0xb48
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0xb61
	.uleb128 0x17
	.4byte	0x80b
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x4
	.4byte	.LASF181
	.byte	0x12
	.byte	0xab
	.byte	0x15
	.4byte	0xb6d
	.uleb128 0x7
	.byte	0x4
	.4byte	0xb73
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0xb87
	.uleb128 0x17
	.4byte	0x80b
	.uleb128 0x17
	.4byte	0x41c
	.byte	0
	.uleb128 0xe
	.4byte	.LASF182
	.byte	0x12
	.byte	0xce
	.byte	0x20
	.4byte	0x570
	.uleb128 0xe
	.4byte	.LASF183
	.byte	0x12
	.byte	0xcf
	.byte	0x20
	.4byte	0x570
	.uleb128 0xe
	.4byte	.LASF184
	.byte	0x12
	.byte	0xd0
	.byte	0x20
	.4byte	0x570
	.uleb128 0x10
	.4byte	.LASF185
	.byte	0x12
	.2byte	0x230
	.byte	0x16
	.4byte	0x811
	.uleb128 0x10
	.4byte	.LASF186
	.byte	0x12
	.2byte	0x23a
	.byte	0x16
	.4byte	0x811
	.uleb128 0x8
	.4byte	.LASF187
	.byte	0x2c
	.byte	0x13
	.byte	0x28
	.byte	0x10
	.4byte	0xc62
	.uleb128 0x19
	.ascii	"buf\000"
	.byte	0x13
	.byte	0x29
	.byte	0xb
	.4byte	0x52
	.byte	0
	.uleb128 0x19
	.ascii	"obj\000"
	.byte	0x13
	.byte	0x2a
	.byte	0xf
	.4byte	0x86e
	.byte	0x4
	.uleb128 0x19
	.ascii	"len\000"
	.byte	0x13
	.byte	0x2b
	.byte	0x10
	.4byte	0x41c
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF188
	.byte	0x13
	.byte	0x2c
	.byte	0x10
	.4byte	0x41c
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF189
	.byte	0x13
	.byte	0x2e
	.byte	0x9
	.4byte	0x33
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF190
	.byte	0x13
	.byte	0x2f
	.byte	0x9
	.4byte	0x33
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF191
	.byte	0x13
	.byte	0x30
	.byte	0xb
	.4byte	0xfd
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF192
	.byte	0x13
	.byte	0x31
	.byte	0x11
	.4byte	0xc62
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF193
	.byte	0x13
	.byte	0x32
	.byte	0x11
	.4byte	0xc62
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF194
	.byte	0x13
	.byte	0x33
	.byte	0x11
	.4byte	0xc62
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF195
	.byte	0x13
	.byte	0x34
	.byte	0xb
	.4byte	0x52
	.byte	0x28
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x41c
	.uleb128 0x4
	.4byte	.LASF196
	.byte	0x13
	.byte	0x35
	.byte	0x3
	.4byte	0xbc5
	.uleb128 0x4
	.4byte	.LASF197
	.byte	0x13
	.byte	0x37
	.byte	0xf
	.4byte	0xc80
	.uleb128 0x7
	.byte	0x4
	.4byte	0xc86
	.uleb128 0x16
	.4byte	0x33
	.4byte	0xc9f
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0xc9f
	.uleb128 0x17
	.4byte	0x33
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0xc68
	.uleb128 0x4
	.4byte	.LASF198
	.byte	0x13
	.byte	0x38
	.byte	0x10
	.4byte	0xcb1
	.uleb128 0x7
	.byte	0x4
	.4byte	0xcb7
	.uleb128 0x18
	.4byte	0xcc7
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0xc9f
	.byte	0
	.uleb128 0x4
	.4byte	.LASF199
	.byte	0x13
	.byte	0x3a
	.byte	0x15
	.4byte	0xcd3
	.uleb128 0x7
	.byte	0x4
	.4byte	0xcd9
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0xcf7
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0xcf7
	.uleb128 0x17
	.4byte	0x41
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x874
	.uleb128 0x15
	.byte	0x90
	.byte	0x13
	.byte	0x5f
	.byte	0x9
	.4byte	0xedb
	.uleb128 0x9
	.4byte	.LASF200
	.byte	0x13
	.byte	0x64
	.byte	0x10
	.4byte	0x879
	.byte	0
	.uleb128 0x9
	.4byte	.LASF201
	.byte	0x13
	.byte	0x65
	.byte	0x10
	.4byte	0x879
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF202
	.byte	0x13
	.byte	0x66
	.byte	0x10
	.4byte	0x879
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF203
	.byte	0x13
	.byte	0x67
	.byte	0x10
	.4byte	0x879
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF204
	.byte	0x13
	.byte	0x68
	.byte	0x10
	.4byte	0x879
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF205
	.byte	0x13
	.byte	0x69
	.byte	0x11
	.4byte	0x89f
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF206
	.byte	0x13
	.byte	0x6a
	.byte	0xf
	.4byte	0x84d
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF207
	.byte	0x13
	.byte	0x6b
	.byte	0xf
	.4byte	0x84d
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF208
	.byte	0x13
	.byte	0x6c
	.byte	0xf
	.4byte	0x84d
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF209
	.byte	0x13
	.byte	0x6d
	.byte	0xd
	.4byte	0x8ca
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF210
	.byte	0x13
	.byte	0x6e
	.byte	0xf
	.4byte	0x84d
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF211
	.byte	0x13
	.byte	0x6f
	.byte	0x10
	.4byte	0x879
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF212
	.byte	0x13
	.byte	0x70
	.byte	0x10
	.4byte	0x879
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF213
	.byte	0x13
	.byte	0x71
	.byte	0x10
	.4byte	0x879
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF214
	.byte	0x13
	.byte	0x72
	.byte	0x10
	.4byte	0x879
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF215
	.byte	0x13
	.byte	0x73
	.byte	0x10
	.4byte	0x879
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF216
	.byte	0x13
	.byte	0x74
	.byte	0xf
	.4byte	0x84d
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF217
	.byte	0x13
	.byte	0x75
	.byte	0xb
	.4byte	0x52
	.byte	0x44
	.uleb128 0x9
	.4byte	.LASF218
	.byte	0x13
	.byte	0x76
	.byte	0xf
	.4byte	0x84d
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF219
	.byte	0x13
	.byte	0x78
	.byte	0x10
	.4byte	0x879
	.byte	0x4c
	.uleb128 0x9
	.4byte	.LASF220
	.byte	0x13
	.byte	0x79
	.byte	0x10
	.4byte	0x879
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF221
	.byte	0x13
	.byte	0x7a
	.byte	0x10
	.4byte	0x879
	.byte	0x54
	.uleb128 0x9
	.4byte	.LASF222
	.byte	0x13
	.byte	0x7b
	.byte	0x10
	.4byte	0x879
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF223
	.byte	0x13
	.byte	0x7c
	.byte	0x11
	.4byte	0x89f
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF224
	.byte	0x13
	.byte	0x7d
	.byte	0x10
	.4byte	0x879
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF225
	.byte	0x13
	.byte	0x7e
	.byte	0x10
	.4byte	0x879
	.byte	0x64
	.uleb128 0x9
	.4byte	.LASF226
	.byte	0x13
	.byte	0x7f
	.byte	0x10
	.4byte	0x879
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF227
	.byte	0x13
	.byte	0x80
	.byte	0x10
	.4byte	0x879
	.byte	0x6c
	.uleb128 0x9
	.4byte	.LASF228
	.byte	0x13
	.byte	0x81
	.byte	0x10
	.4byte	0x879
	.byte	0x70
	.uleb128 0x9
	.4byte	.LASF229
	.byte	0x13
	.byte	0x83
	.byte	0x10
	.4byte	0x879
	.byte	0x74
	.uleb128 0x9
	.4byte	.LASF230
	.byte	0x13
	.byte	0x84
	.byte	0x10
	.4byte	0x879
	.byte	0x78
	.uleb128 0x9
	.4byte	.LASF231
	.byte	0x13
	.byte	0x85
	.byte	0x10
	.4byte	0x879
	.byte	0x7c
	.uleb128 0x9
	.4byte	.LASF232
	.byte	0x13
	.byte	0x86
	.byte	0x10
	.4byte	0x879
	.byte	0x80
	.uleb128 0x9
	.4byte	.LASF233
	.byte	0x13
	.byte	0x88
	.byte	0xf
	.4byte	0x84d
	.byte	0x84
	.uleb128 0x9
	.4byte	.LASF234
	.byte	0x13
	.byte	0x8a
	.byte	0x10
	.4byte	0x879
	.byte	0x88
	.uleb128 0x9
	.4byte	.LASF235
	.byte	0x13
	.byte	0x8b
	.byte	0x10
	.4byte	0x879
	.byte	0x8c
	.byte	0
	.uleb128 0x4
	.4byte	.LASF236
	.byte	0x13
	.byte	0x8c
	.byte	0x3
	.4byte	0xcfd
	.uleb128 0x15
	.byte	0x28
	.byte	0x13
	.byte	0x8e
	.byte	0x9
	.4byte	0xf73
	.uleb128 0x9
	.4byte	.LASF237
	.byte	0x13
	.byte	0x8f
	.byte	0xd
	.4byte	0x8eb
	.byte	0
	.uleb128 0x9
	.4byte	.LASF238
	.byte	0x13
	.byte	0x90
	.byte	0x10
	.4byte	0x879
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF239
	.byte	0x13
	.byte	0x91
	.byte	0x12
	.4byte	0x90c
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF240
	.byte	0x13
	.byte	0x92
	.byte	0x12
	.4byte	0x90c
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF241
	.byte	0x13
	.byte	0x93
	.byte	0xb
	.4byte	0x52
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF242
	.byte	0x13
	.byte	0x94
	.byte	0x15
	.4byte	0x932
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF243
	.byte	0x13
	.byte	0x95
	.byte	0xb
	.4byte	0x52
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF244
	.byte	0x13
	.byte	0x96
	.byte	0x10
	.4byte	0x988
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF245
	.byte	0x13
	.byte	0x98
	.byte	0x10
	.4byte	0x879
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF246
	.byte	0x13
	.byte	0x99
	.byte	0x12
	.4byte	0x90c
	.byte	0x24
	.byte	0
	.uleb128 0x4
	.4byte	.LASF247
	.byte	0x13
	.byte	0x9a
	.byte	0x3
	.4byte	0xee7
	.uleb128 0x15
	.byte	0xc
	.byte	0x13
	.byte	0x9c
	.byte	0x9
	.4byte	0xfb0
	.uleb128 0x9
	.4byte	.LASF248
	.byte	0x13
	.byte	0x9d
	.byte	0xd
	.4byte	0x8eb
	.byte	0
	.uleb128 0x9
	.4byte	.LASF249
	.byte	0x13
	.byte	0x9e
	.byte	0x10
	.4byte	0x879
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF250
	.byte	0x13
	.byte	0x9f
	.byte	0x13
	.4byte	0x95d
	.byte	0x8
	.byte	0
	.uleb128 0x4
	.4byte	.LASF251
	.byte	0x13
	.byte	0xa0
	.byte	0x3
	.4byte	0xf7f
	.uleb128 0x15
	.byte	0xc
	.byte	0x13
	.byte	0xa2
	.byte	0x9
	.4byte	0xfed
	.uleb128 0x9
	.4byte	.LASF252
	.byte	0x13
	.byte	0xa3
	.byte	0xf
	.4byte	0x84d
	.byte	0
	.uleb128 0x9
	.4byte	.LASF253
	.byte	0x13
	.byte	0xa4
	.byte	0xf
	.4byte	0x84d
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF254
	.byte	0x13
	.byte	0xa5
	.byte	0xf
	.4byte	0x84d
	.byte	0x8
	.byte	0
	.uleb128 0x4
	.4byte	.LASF255
	.byte	0x13
	.byte	0xa6
	.byte	0x3
	.4byte	0xfbc
	.uleb128 0x15
	.byte	0x8
	.byte	0x13
	.byte	0xa8
	.byte	0x9
	.4byte	0x101d
	.uleb128 0x9
	.4byte	.LASF256
	.byte	0x13
	.byte	0xa9
	.byte	0x14
	.4byte	0xc74
	.byte	0
	.uleb128 0x9
	.4byte	.LASF257
	.byte	0x13
	.byte	0xaa
	.byte	0x18
	.4byte	0xca5
	.byte	0x4
	.byte	0
	.uleb128 0x4
	.4byte	.LASF258
	.byte	0x13
	.byte	0xab
	.byte	0x3
	.4byte	0xff9
	.uleb128 0x7
	.byte	0x4
	.4byte	0xfed
	.uleb128 0x7
	.byte	0x4
	.4byte	0xedb
	.uleb128 0x7
	.byte	0x4
	.4byte	0xf73
	.uleb128 0x7
	.byte	0x4
	.4byte	0xfb0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x101d
	.uleb128 0x8
	.4byte	.LASF259
	.byte	0x10
	.byte	0x14
	.byte	0x33
	.byte	0x8
	.4byte	0x1089
	.uleb128 0x9
	.4byte	.LASF260
	.byte	0x14
	.byte	0x34
	.byte	0x12
	.4byte	0x2f7
	.byte	0
	.uleb128 0x9
	.4byte	.LASF261
	.byte	0x14
	.byte	0x35
	.byte	0x11
	.4byte	0x15d4
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF262
	.byte	0x14
	.byte	0x36
	.byte	0x11
	.4byte	0x33
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF263
	.byte	0x14
	.byte	0x38
	.byte	0x12
	.4byte	0x2f7
	.byte	0xc
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1047
	.uleb128 0xb
	.4byte	.LASF264
	.uleb128 0x7
	.byte	0x4
	.4byte	0x108f
	.uleb128 0x8
	.4byte	.LASF265
	.byte	0x14
	.byte	0x15
	.byte	0xb
	.byte	0x10
	.4byte	0x10e9
	.uleb128 0x9
	.4byte	.LASF266
	.byte	0x15
	.byte	0xc
	.byte	0x11
	.4byte	0x2f7
	.byte	0
	.uleb128 0x19
	.ascii	"get\000"
	.byte	0x15
	.byte	0xd
	.byte	0xc
	.4byte	0x19df
	.byte	0x4
	.uleb128 0x19
	.ascii	"set\000"
	.byte	0x15
	.byte	0xe
	.byte	0xc
	.4byte	0x19eb
	.byte	0x8
	.uleb128 0x19
	.ascii	"doc\000"
	.byte	0x15
	.byte	0xf
	.byte	0x11
	.4byte	0x2f7
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF267
	.byte	0x15
	.byte	0x10
	.byte	0xb
	.4byte	0x52
	.byte	0x10
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x109a
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x1108
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x31a
	.uleb128 0x17
	.4byte	0x33
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x10ef
	.uleb128 0x1a
	.4byte	.LASF268
	.byte	0x13
	.2byte	0x10e
	.byte	0x3
	.4byte	0x570
	.uleb128 0x10
	.4byte	.LASF269
	.byte	0x13
	.2byte	0x182
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x10
	.4byte	.LASF270
	.byte	0x13
	.2byte	0x183
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xc
	.4byte	0x33
	.4byte	0x1140
	.uleb128 0xf
	.byte	0
	.uleb128 0x10
	.4byte	.LASF271
	.byte	0x13
	.2byte	0x188
	.byte	0x11
	.4byte	0x1135
	.uleb128 0x15
	.byte	0x8
	.byte	0x16
	.byte	0x3a
	.byte	0x5
	.4byte	0x1171
	.uleb128 0x9
	.4byte	.LASF272
	.byte	0x16
	.byte	0x3b
	.byte	0x13
	.4byte	0x428
	.byte	0
	.uleb128 0x9
	.4byte	.LASF273
	.byte	0x16
	.byte	0x3c
	.byte	0x13
	.4byte	0x428
	.byte	0x4
	.byte	0
	.uleb128 0x15
	.byte	0x10
	.byte	0x16
	.byte	0x3f
	.byte	0x5
	.4byte	0x1193
	.uleb128 0x19
	.ascii	"k0\000"
	.byte	0x16
	.byte	0x40
	.byte	0x12
	.4byte	0x410
	.byte	0
	.uleb128 0x19
	.ascii	"k1\000"
	.byte	0x16
	.byte	0x41
	.byte	0x12
	.4byte	0x410
	.byte	0x8
	.byte	0
	.uleb128 0x15
	.byte	0x14
	.byte	0x16
	.byte	0x44
	.byte	0x5
	.4byte	0x11b7
	.uleb128 0x9
	.4byte	.LASF274
	.byte	0x16
	.byte	0x45
	.byte	0x17
	.4byte	0x11b7
	.byte	0
	.uleb128 0x9
	.4byte	.LASF273
	.byte	0x16
	.byte	0x46
	.byte	0x13
	.4byte	0x428
	.byte	0x10
	.byte	0
	.uleb128 0xc
	.4byte	0x54
	.4byte	0x11c7
	.uleb128 0xd
	.4byte	0x3a
	.byte	0xf
	.byte	0
	.uleb128 0x15
	.byte	0x14
	.byte	0x16
	.byte	0x48
	.byte	0x5
	.4byte	0x11eb
	.uleb128 0x9
	.4byte	.LASF274
	.byte	0x16
	.byte	0x49
	.byte	0x17
	.4byte	0x11b7
	.byte	0
	.uleb128 0x9
	.4byte	.LASF275
	.byte	0x16
	.byte	0x4a
	.byte	0x13
	.4byte	0x428
	.byte	0x10
	.byte	0
	.uleb128 0x1b
	.byte	0x18
	.byte	0x16
	.byte	0x36
	.byte	0x9
	.4byte	0x1230
	.uleb128 0x1c
	.ascii	"uc\000"
	.byte	0x16
	.byte	0x38
	.byte	0x13
	.4byte	0x1230
	.uleb128 0x1c
	.ascii	"fnv\000"
	.byte	0x16
	.byte	0x3d
	.byte	0x7
	.4byte	0x114d
	.uleb128 0x1d
	.4byte	.LASF276
	.byte	0x16
	.byte	0x42
	.byte	0x7
	.4byte	0x1171
	.uleb128 0x1d
	.4byte	.LASF277
	.byte	0x16
	.byte	0x47
	.byte	0x7
	.4byte	0x1193
	.uleb128 0x1d
	.4byte	.LASF278
	.byte	0x16
	.byte	0x4b
	.byte	0x7
	.4byte	0x11c7
	.byte	0
	.uleb128 0xc
	.4byte	0x54
	.4byte	0x1240
	.uleb128 0xd
	.4byte	0x3a
	.byte	0x17
	.byte	0
	.uleb128 0x4
	.4byte	.LASF279
	.byte	0x16
	.byte	0x4c
	.byte	0x3
	.4byte	0x11eb
	.uleb128 0xe
	.4byte	.LASF280
	.byte	0x16
	.byte	0x4d
	.byte	0x1e
	.4byte	0x1240
	.uleb128 0xe
	.4byte	.LASF281
	.byte	0x17
	.byte	0xa
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF282
	.byte	0x17
	.byte	0xb
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF283
	.byte	0x17
	.byte	0xc
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF284
	.byte	0x17
	.byte	0xd
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF285
	.byte	0x17
	.byte	0xe
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF286
	.byte	0x17
	.byte	0xf
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF287
	.byte	0x17
	.byte	0x10
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF288
	.byte	0x17
	.byte	0x11
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF289
	.byte	0x17
	.byte	0x12
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF290
	.byte	0x17
	.byte	0x13
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF291
	.byte	0x17
	.byte	0x14
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF292
	.byte	0x17
	.byte	0x15
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF293
	.byte	0x17
	.byte	0x16
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF294
	.byte	0x17
	.byte	0x17
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF295
	.byte	0x17
	.byte	0x18
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF296
	.byte	0x18
	.byte	0x22
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF297
	.byte	0x18
	.byte	0x23
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xc
	.4byte	0x103
	.4byte	0x132f
	.uleb128 0xf
	.byte	0
	.uleb128 0xe
	.4byte	.LASF298
	.byte	0x18
	.byte	0x38
	.byte	0x12
	.4byte	0x1324
	.uleb128 0xe
	.4byte	.LASF299
	.byte	0x19
	.byte	0x2c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF300
	.byte	0x19
	.byte	0x2d
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF301
	.byte	0x1a
	.byte	0x6f
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF302
	.byte	0x1a
	.byte	0x70
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xc
	.4byte	0x5b
	.4byte	0x1376
	.uleb128 0xf
	.byte	0
	.uleb128 0x5
	.4byte	0x136b
	.uleb128 0x10
	.4byte	.LASF303
	.byte	0x1b
	.2byte	0x430
	.byte	0x21
	.4byte	0x1376
	.uleb128 0x8
	.4byte	.LASF304
	.byte	0x10
	.byte	0x1c
	.byte	0x55
	.byte	0x8
	.4byte	0x13b0
	.uleb128 0x9
	.4byte	.LASF102
	.byte	0x1c
	.byte	0x56
	.byte	0x5
	.4byte	0x841
	.byte	0
	.uleb128 0x9
	.4byte	.LASF305
	.byte	0x1c
	.byte	0x57
	.byte	0xb
	.4byte	0x13fc
	.byte	0xc
	.byte	0
	.uleb128 0xe
	.4byte	.LASF306
	.byte	0x1d
	.byte	0xc
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xc
	.4byte	0x54
	.4byte	0x13cc
	.uleb128 0xd
	.4byte	0x3a
	.byte	0xff
	.byte	0
	.uleb128 0xe
	.4byte	.LASF307
	.byte	0x1d
	.byte	0x4f
	.byte	0x1b
	.4byte	0x13bc
	.uleb128 0xe
	.4byte	.LASF308
	.byte	0x1d
	.byte	0xe8
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF309
	.byte	0x1d
	.byte	0xe9
	.byte	0x18
	.4byte	0x86e
	.uleb128 0x4
	.4byte	.LASF310
	.byte	0x1c
	.byte	0x35
	.byte	0x18
	.4byte	0x60
	.uleb128 0xc
	.4byte	0x13f0
	.4byte	0x140c
	.uleb128 0xd
	.4byte	0x3a
	.byte	0
	.byte	0
	.uleb128 0xe
	.4byte	.LASF311
	.byte	0x1e
	.byte	0xa
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF312
	.byte	0x1e
	.byte	0x12
	.byte	0x20
	.4byte	0x1388
	.uleb128 0xe
	.4byte	.LASF313
	.byte	0x1e
	.byte	0x12
	.byte	0x31
	.4byte	0x1388
	.uleb128 0xe
	.4byte	.LASF314
	.byte	0x1f
	.byte	0x15
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF315
	.byte	0x20
	.byte	0x27
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF316
	.byte	0x21
	.byte	0x12
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF317
	.byte	0x21
	.byte	0x13
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF318
	.byte	0x21
	.byte	0x14
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF319
	.byte	0x22
	.byte	0xa
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF320
	.byte	0x22
	.byte	0xc
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF321
	.byte	0x23
	.byte	0x17
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF322
	.byte	0x23
	.byte	0x18
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF323
	.byte	0x24
	.byte	0x2b
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF324
	.byte	0x24
	.byte	0x2c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF325
	.byte	0x24
	.byte	0x2d
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF326
	.byte	0x24
	.byte	0x2e
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF327
	.byte	0x25
	.byte	0xf
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF328
	.byte	0x25
	.byte	0x3f
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF329
	.byte	0x25
	.byte	0x40
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF330
	.byte	0x25
	.byte	0x41
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF331
	.byte	0x25
	.byte	0x4c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF332
	.byte	0x25
	.byte	0x4d
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF333
	.byte	0x25
	.byte	0x4e
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF334
	.byte	0x25
	.byte	0x50
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF335
	.byte	0x25
	.byte	0x51
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF336
	.byte	0x25
	.byte	0x52
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF337
	.byte	0x26
	.byte	0xf
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF338
	.byte	0x26
	.byte	0x10
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF339
	.byte	0x26
	.byte	0x11
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF340
	.byte	0x26
	.byte	0x12
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF341
	.byte	0x26
	.byte	0x13
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF342
	.byte	0x27
	.byte	0xa
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF343
	.byte	0x27
	.byte	0xb
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF344
	.byte	0x28
	.byte	0x45
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF345
	.byte	0x28
	.byte	0x4d
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF346
	.byte	0x28
	.byte	0x4e
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF347
	.byte	0x28
	.byte	0x4f
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF348
	.byte	0x14
	.byte	0xe
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x4
	.4byte	.LASF349
	.byte	0x14
	.byte	0x12
	.byte	0x15
	.4byte	0x885
	.uleb128 0xe
	.4byte	.LASF350
	.byte	0x29
	.byte	0xa
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF351
	.byte	0x29
	.byte	0x29
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x1e
	.4byte	0x86e
	.uleb128 0x7
	.byte	0x4
	.4byte	0x15f8
	.uleb128 0xe
	.4byte	.LASF352
	.byte	0x2a
	.byte	0x2c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF353
	.byte	0x2a
	.byte	0x5e
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF354
	.byte	0x2a
	.byte	0x5f
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF355
	.byte	0x2b
	.byte	0x14
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF356
	.byte	0x2b
	.byte	0x2b
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF357
	.byte	0x2c
	.byte	0x16
	.byte	0x1a
	.4byte	0x2f7
	.uleb128 0xe
	.4byte	.LASF358
	.byte	0x2c
	.byte	0x17
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF359
	.byte	0x2d
	.byte	0xc
	.byte	0x1a
	.4byte	0x2f7
	.uleb128 0xe
	.4byte	.LASF360
	.byte	0x2d
	.byte	0x10
	.byte	0x11
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF361
	.byte	0x2d
	.byte	0x16
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1681
	.uleb128 0x16
	.4byte	0x86e
	.4byte	0x1695
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x52
	.byte	0
	.uleb128 0xe
	.4byte	.LASF362
	.byte	0x2e
	.byte	0x15
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF363
	.byte	0x2f
	.byte	0xf
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xb
	.4byte	.LASF364
	.uleb128 0x7
	.byte	0x4
	.4byte	0x16ad
	.uleb128 0xe
	.4byte	.LASF365
	.byte	0x30
	.byte	0x9
	.byte	0x16
	.4byte	0x811
	.uleb128 0xe
	.4byte	.LASF366
	.byte	0x30
	.byte	0x1c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF367
	.byte	0x30
	.byte	0x1d
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF368
	.byte	0x31
	.byte	0xe
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF369
	.byte	0x32
	.byte	0x8
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF370
	.byte	0x32
	.byte	0x9
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF371
	.byte	0x32
	.byte	0xa
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x4
	.4byte	.LASF372
	.byte	0x33
	.byte	0x17
	.byte	0x14
	.4byte	0x1718
	.uleb128 0x1f
	.ascii	"_ts\000"
	.byte	0x98
	.byte	0x34
	.byte	0x33
	.byte	0x8
	.4byte	0x18d2
	.uleb128 0x9
	.4byte	.LASF373
	.byte	0x34
	.byte	0x36
	.byte	0x11
	.4byte	0x1967
	.byte	0
	.uleb128 0x9
	.4byte	.LASF374
	.byte	0x34
	.byte	0x37
	.byte	0x11
	.4byte	0x1967
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF375
	.byte	0x34
	.byte	0x38
	.byte	0x19
	.4byte	0x196d
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF376
	.byte	0x34
	.byte	0x3b
	.byte	0x14
	.4byte	0x16b2
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF377
	.byte	0x34
	.byte	0x3c
	.byte	0x9
	.4byte	0x33
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF378
	.byte	0x34
	.byte	0x3d
	.byte	0xa
	.4byte	0x103
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF379
	.byte	0x34
	.byte	0x3f
	.byte	0xa
	.4byte	0x103
	.byte	0x15
	.uleb128 0x9
	.4byte	.LASF380
	.byte	0x34
	.byte	0x41
	.byte	0x9
	.4byte	0x33
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF94
	.byte	0x34
	.byte	0x46
	.byte	0x9
	.4byte	0x33
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF381
	.byte	0x34
	.byte	0x47
	.byte	0x9
	.4byte	0x33
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF382
	.byte	0x34
	.byte	0x49
	.byte	0x12
	.4byte	0x18e3
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF383
	.byte	0x34
	.byte	0x4a
	.byte	0x12
	.4byte	0x18e3
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF384
	.byte	0x34
	.byte	0x4b
	.byte	0xf
	.4byte	0x86e
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF385
	.byte	0x34
	.byte	0x4c
	.byte	0xf
	.4byte	0x86e
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF386
	.byte	0x34
	.byte	0x4f
	.byte	0xf
	.4byte	0x86e
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF387
	.byte	0x34
	.byte	0x50
	.byte	0xf
	.4byte	0x86e
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF388
	.byte	0x34
	.byte	0x51
	.byte	0xf
	.4byte	0x86e
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF389
	.byte	0x34
	.byte	0x56
	.byte	0x16
	.4byte	0x195b
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF390
	.byte	0x34
	.byte	0x5a
	.byte	0x17
	.4byte	0x1973
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF391
	.byte	0x34
	.byte	0x5c
	.byte	0xf
	.4byte	0x86e
	.byte	0x54
	.uleb128 0x9
	.4byte	.LASF392
	.byte	0x34
	.byte	0x5e
	.byte	0x9
	.4byte	0x33
	.byte	0x58
	.uleb128 0x9
	.4byte	.LASF393
	.byte	0x34
	.byte	0x60
	.byte	0xf
	.4byte	0x86e
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF394
	.byte	0x34
	.byte	0x61
	.byte	0x13
	.4byte	0x67
	.byte	0x60
	.uleb128 0x9
	.4byte	.LASF395
	.byte	0x34
	.byte	0x63
	.byte	0x9
	.4byte	0x33
	.byte	0x64
	.uleb128 0x9
	.4byte	.LASF396
	.byte	0x34
	.byte	0x64
	.byte	0xf
	.4byte	0x86e
	.byte	0x68
	.uleb128 0x9
	.4byte	.LASF397
	.byte	0x34
	.byte	0x7d
	.byte	0xc
	.4byte	0xa0b
	.byte	0x6c
	.uleb128 0x9
	.4byte	.LASF398
	.byte	0x34
	.byte	0x7e
	.byte	0xb
	.4byte	0x52
	.byte	0x70
	.uleb128 0x9
	.4byte	.LASF399
	.byte	0x34
	.byte	0x80
	.byte	0x9
	.4byte	0x33
	.byte	0x74
	.uleb128 0x9
	.4byte	.LASF400
	.byte	0x34
	.byte	0x82
	.byte	0xf
	.4byte	0x86e
	.byte	0x78
	.uleb128 0x9
	.4byte	.LASF401
	.byte	0x34
	.byte	0x83
	.byte	0xf
	.4byte	0x86e
	.byte	0x7c
	.uleb128 0x9
	.4byte	.LASF402
	.byte	0x34
	.byte	0x85
	.byte	0xf
	.4byte	0x86e
	.byte	0x80
	.uleb128 0x9
	.4byte	.LASF403
	.byte	0x34
	.byte	0x86
	.byte	0xe
	.4byte	0x410
	.byte	0x88
	.uleb128 0x19
	.ascii	"id\000"
	.byte	0x34
	.byte	0x89
	.byte	0xe
	.4byte	0x410
	.byte	0x90
	.byte	0
	.uleb128 0x4
	.4byte	.LASF404
	.byte	0x33
	.byte	0x19
	.byte	0x14
	.4byte	0x18de
	.uleb128 0x20
	.ascii	"_is\000"
	.uleb128 0x4
	.4byte	.LASF405
	.byte	0x34
	.byte	0x13
	.byte	0xf
	.4byte	0x18ef
	.uleb128 0x7
	.byte	0x4
	.4byte	0x18f5
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x1913
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x16b2
	.uleb128 0x17
	.4byte	0x33
	.uleb128 0x17
	.4byte	0x86e
	.byte	0
	.uleb128 0x8
	.4byte	.LASF406
	.byte	0x10
	.byte	0x34
	.byte	0x24
	.byte	0x10
	.4byte	0x1955
	.uleb128 0x9
	.4byte	.LASF407
	.byte	0x34
	.byte	0x2b
	.byte	0xf
	.4byte	0x86e
	.byte	0
	.uleb128 0x9
	.4byte	.LASF408
	.byte	0x34
	.byte	0x2b
	.byte	0x1a
	.4byte	0x86e
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF409
	.byte	0x34
	.byte	0x2b
	.byte	0x26
	.4byte	0x86e
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF410
	.byte	0x34
	.byte	0x2d
	.byte	0x1c
	.4byte	0x1955
	.byte	0xc
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1913
	.uleb128 0x4
	.4byte	.LASF411
	.byte	0x34
	.byte	0x2f
	.byte	0x3
	.4byte	0x1913
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1718
	.uleb128 0x7
	.byte	0x4
	.4byte	0x18d2
	.uleb128 0x7
	.byte	0x4
	.4byte	0x195b
	.uleb128 0x7
	.byte	0x4
	.4byte	0x170c
	.uleb128 0xe
	.4byte	.LASF412
	.byte	0x35
	.byte	0x26
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF413
	.byte	0x35
	.byte	0x3b
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF414
	.byte	0x35
	.byte	0x3c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF415
	.byte	0x35
	.byte	0x3e
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF416
	.byte	0x35
	.byte	0x57
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF417
	.byte	0x35
	.byte	0x58
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF418
	.byte	0x35
	.byte	0x59
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF419
	.byte	0x35
	.byte	0x5a
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x4
	.4byte	.LASF420
	.byte	0x15
	.byte	0x8
	.byte	0x15
	.4byte	0x167b
	.uleb128 0x4
	.4byte	.LASF421
	.byte	0x15
	.byte	0x9
	.byte	0xf
	.4byte	0x19f7
	.uleb128 0x7
	.byte	0x4
	.4byte	0x19fd
	.uleb128 0x16
	.4byte	0x33
	.4byte	0x1a16
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x86e
	.uleb128 0x17
	.4byte	0x52
	.byte	0
	.uleb128 0xe
	.4byte	.LASF422
	.byte	0x15
	.byte	0x4c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF423
	.byte	0x15
	.byte	0x4d
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF424
	.byte	0x15
	.byte	0x4e
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF425
	.byte	0x15
	.byte	0x4f
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF426
	.byte	0x15
	.byte	0x50
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF427
	.byte	0x15
	.byte	0x51
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF428
	.byte	0x15
	.byte	0x53
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF429
	.byte	0x15
	.byte	0x67
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF430
	.byte	0x36
	.byte	0x2b
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF431
	.byte	0x36
	.byte	0x2c
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF432
	.byte	0x36
	.byte	0x2d
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF433
	.byte	0x37
	.byte	0x16
	.byte	0xe
	.4byte	0xfd
	.uleb128 0xe
	.4byte	.LASF434
	.byte	0x38
	.byte	0xb
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF435
	.byte	0x39
	.byte	0xd
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF436
	.byte	0x3a
	.byte	0xea
	.byte	0x1a
	.4byte	0x2f7
	.uleb128 0xe
	.4byte	.LASF437
	.byte	0x3b
	.byte	0x42
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF438
	.byte	0x3b
	.byte	0x43
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF439
	.byte	0x3b
	.byte	0x45
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF440
	.byte	0x3b
	.byte	0x47
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF441
	.byte	0x3b
	.byte	0x48
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF442
	.byte	0x3b
	.byte	0x49
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF443
	.byte	0x3b
	.byte	0x4a
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF444
	.byte	0x3b
	.byte	0x4c
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF445
	.byte	0x3b
	.byte	0x4d
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF446
	.byte	0x3b
	.byte	0x4e
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF447
	.byte	0x3b
	.byte	0x4f
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF448
	.byte	0x3b
	.byte	0x50
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF449
	.byte	0x3b
	.byte	0x51
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF450
	.byte	0x3b
	.byte	0x52
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF451
	.byte	0x3b
	.byte	0x54
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF452
	.byte	0x3b
	.byte	0x56
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF453
	.byte	0x3b
	.byte	0x57
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF454
	.byte	0x3b
	.byte	0x58
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF455
	.byte	0x3b
	.byte	0x59
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF456
	.byte	0x3b
	.byte	0x5a
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF457
	.byte	0x3b
	.byte	0x5b
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF458
	.byte	0x3b
	.byte	0x5c
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF459
	.byte	0x3b
	.byte	0x5e
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF460
	.byte	0x3b
	.byte	0x60
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF461
	.byte	0x3b
	.byte	0x61
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF462
	.byte	0x3b
	.byte	0x62
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF463
	.byte	0x3b
	.byte	0x63
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF464
	.byte	0x3b
	.byte	0x64
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF465
	.byte	0x3b
	.byte	0x65
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF466
	.byte	0x3b
	.byte	0x66
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF467
	.byte	0x3b
	.byte	0x67
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF468
	.byte	0x3b
	.byte	0x68
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF469
	.byte	0x3b
	.byte	0x69
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF470
	.byte	0x3b
	.byte	0x6a
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF471
	.byte	0x3b
	.byte	0x6b
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF472
	.byte	0x3b
	.byte	0x6c
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF473
	.byte	0x3b
	.byte	0x6d
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF474
	.byte	0x3b
	.byte	0x6e
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF475
	.byte	0x3b
	.byte	0x71
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF476
	.byte	0x3b
	.byte	0x72
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF477
	.byte	0x3b
	.byte	0x73
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF478
	.byte	0x3b
	.byte	0x74
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF479
	.byte	0x3b
	.byte	0x75
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF480
	.byte	0x3b
	.byte	0x76
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF481
	.byte	0x3b
	.byte	0x77
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF482
	.byte	0x3b
	.byte	0x78
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF483
	.byte	0x3b
	.byte	0x79
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF484
	.byte	0x3b
	.byte	0x7a
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF485
	.byte	0x3b
	.byte	0x7b
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF486
	.byte	0x3b
	.byte	0x7c
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF487
	.byte	0x3b
	.byte	0x7d
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF488
	.byte	0x3b
	.byte	0x7e
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF489
	.byte	0x3b
	.byte	0x7f
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF490
	.byte	0x3b
	.byte	0x84
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF491
	.byte	0x3b
	.byte	0x85
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF492
	.byte	0x3b
	.byte	0x8b
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF493
	.byte	0x3b
	.byte	0x8c
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF494
	.byte	0x3b
	.byte	0x8d
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF495
	.byte	0x3b
	.byte	0x8e
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF496
	.byte	0x3b
	.byte	0x8f
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF497
	.byte	0x3b
	.byte	0x90
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF498
	.byte	0x3b
	.byte	0x91
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF499
	.byte	0x3b
	.byte	0x92
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF500
	.byte	0x3b
	.byte	0x93
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF501
	.byte	0x3b
	.byte	0x94
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF502
	.byte	0x3b
	.byte	0x95
	.byte	0x18
	.4byte	0x86e
	.uleb128 0xe
	.4byte	.LASF503
	.byte	0x3c
	.byte	0xa
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF504
	.byte	0x3c
	.byte	0xd
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF505
	.byte	0x3c
	.byte	0x10
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF506
	.byte	0x3d
	.byte	0xf2
	.byte	0x1a
	.4byte	0x2f7
	.uleb128 0xe
	.4byte	.LASF507
	.byte	0x3e
	.byte	0x74
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x1e
	.4byte	0x33
	.uleb128 0xe
	.4byte	.LASF508
	.byte	0x3f
	.byte	0xba
	.byte	0x13
	.4byte	0x1e2f
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1e1e
	.uleb128 0x16
	.4byte	0xfd
	.4byte	0x1e4e
	.uleb128 0x17
	.4byte	0x31a
	.uleb128 0x17
	.4byte	0x31a
	.uleb128 0x17
	.4byte	0x2f7
	.byte	0
	.uleb128 0xe
	.4byte	.LASF509
	.byte	0x3f
	.byte	0xbb
	.byte	0x15
	.4byte	0x1e5a
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1e35
	.uleb128 0xe
	.4byte	.LASF510
	.byte	0x3f
	.byte	0xbd
	.byte	0x1c
	.4byte	0x1979
	.uleb128 0xe
	.4byte	.LASF511
	.byte	0x40
	.byte	0x65
	.byte	0x11
	.4byte	0x33
	.uleb128 0x8
	.4byte	.LASF512
	.byte	0x8
	.byte	0x41
	.byte	0x76
	.byte	0x8
	.4byte	0x1ea0
	.uleb128 0x9
	.4byte	.LASF266
	.byte	0x41
	.byte	0x77
	.byte	0x11
	.4byte	0x2f7
	.byte	0
	.uleb128 0x9
	.4byte	.LASF513
	.byte	0x41
	.byte	0x78
	.byte	0x11
	.4byte	0x15fd
	.byte	0x4
	.byte	0
	.uleb128 0xe
	.4byte	.LASF514
	.byte	0x41
	.byte	0x7a
	.byte	0x1f
	.4byte	0x1eac
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1e78
	.uleb128 0xe
	.4byte	.LASF515
	.byte	0x41
	.byte	0x7e
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0x8
	.4byte	.LASF516
	.byte	0xc
	.byte	0x41
	.byte	0x86
	.byte	0x8
	.4byte	0x1ef3
	.uleb128 0x9
	.4byte	.LASF266
	.byte	0x41
	.byte	0x87
	.byte	0x11
	.4byte	0x2f7
	.byte	0
	.uleb128 0x9
	.4byte	.LASF517
	.byte	0x41
	.byte	0x88
	.byte	0x1a
	.4byte	0x1ef8
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF518
	.byte	0x41
	.byte	0x89
	.byte	0x9
	.4byte	0x33
	.byte	0x8
	.byte	0
	.uleb128 0x5
	.4byte	0x1ebe
	.uleb128 0x7
	.byte	0x4
	.4byte	0x5b
	.uleb128 0xe
	.4byte	.LASF519
	.byte	0x41
	.byte	0x8f
	.byte	0x24
	.4byte	0x1f0a
	.uleb128 0x7
	.byte	0x4
	.4byte	0x1ef3
	.uleb128 0xe
	.4byte	.LASF520
	.byte	0x42
	.byte	0x7
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF521
	.byte	0x42
	.byte	0x8
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xe
	.4byte	.LASF522
	.byte	0x42
	.byte	0x9
	.byte	0x1a
	.4byte	0x110e
	.uleb128 0xc
	.4byte	0x4d
	.4byte	0x1f44
	.uleb128 0xd
	.4byte	0x3a
	.byte	0xff
	.byte	0
	.uleb128 0x5
	.4byte	0x1f34
	.uleb128 0xe
	.4byte	.LASF523
	.byte	0x43
	.byte	0xd
	.byte	0x20
	.4byte	0x1f44
	.uleb128 0xc
	.4byte	0x5b
	.4byte	0x1f65
	.uleb128 0xd
	.4byte	0x3a
	.byte	0xff
	.byte	0
	.uleb128 0x5
	.4byte	0x1f55
	.uleb128 0xe
	.4byte	.LASF524
	.byte	0x43
	.byte	0x1a
	.byte	0x21
	.4byte	0x1f65
	.uleb128 0xe
	.4byte	.LASF525
	.byte	0x43
	.byte	0x1b
	.byte	0x21
	.4byte	0x1f65
	.uleb128 0x8
	.4byte	.LASF526
	.byte	0x6
	.byte	0x44
	.byte	0x14
	.byte	0x8
	.4byte	0x1fb1
	.uleb128 0x19
	.ascii	"r\000"
	.byte	0x44
	.byte	0x15
	.byte	0xb
	.4byte	0x390
	.byte	0
	.uleb128 0x19
	.ascii	"g\000"
	.byte	0x44
	.byte	0x15
	.byte	0xe
	.4byte	0x390
	.byte	0x2
	.uleb128 0x19
	.ascii	"b\000"
	.byte	0x44
	.byte	0x15
	.byte	0x11
	.4byte	0x390
	.byte	0x4
	.byte	0
	.uleb128 0x8
	.4byte	.LASF527
	.byte	0x6c
	.byte	0x44
	.byte	0x18
	.byte	0x8
	.4byte	0x2104
	.uleb128 0x9
	.4byte	.LASF528
	.byte	0x44
	.byte	0x19
	.byte	0xc
	.4byte	0x404
	.byte	0
	.uleb128 0x9
	.4byte	.LASF529
	.byte	0x44
	.byte	0x1b
	.byte	0xc
	.4byte	0x2104
	.byte	0x4
	.uleb128 0x9
	.4byte	.LASF530
	.byte	0x44
	.byte	0x1c
	.byte	0xc
	.4byte	0x2104
	.byte	0x8
	.uleb128 0x9
	.4byte	.LASF531
	.byte	0x44
	.byte	0x1d
	.byte	0xc
	.4byte	0x2104
	.byte	0xc
	.uleb128 0x9
	.4byte	.LASF532
	.byte	0x44
	.byte	0x1e
	.byte	0xc
	.4byte	0x2104
	.byte	0x10
	.uleb128 0x9
	.4byte	.LASF533
	.byte	0x44
	.byte	0x20
	.byte	0xc
	.4byte	0x2104
	.byte	0x14
	.uleb128 0x9
	.4byte	.LASF534
	.byte	0x44
	.byte	0x22
	.byte	0xc
	.4byte	0x404
	.byte	0x18
	.uleb128 0x9
	.4byte	.LASF535
	.byte	0x44
	.byte	0x23
	.byte	0xc
	.4byte	0x404
	.byte	0x1c
	.uleb128 0x9
	.4byte	.LASF536
	.byte	0x44
	.byte	0x24
	.byte	0xc
	.4byte	0x404
	.byte	0x20
	.uleb128 0x9
	.4byte	.LASF537
	.byte	0x44
	.byte	0x25
	.byte	0xc
	.4byte	0x404
	.byte	0x24
	.uleb128 0x9
	.4byte	.LASF538
	.byte	0x44
	.byte	0x26
	.byte	0xc
	.4byte	0x404
	.byte	0x28
	.uleb128 0x9
	.4byte	.LASF539
	.byte	0x44
	.byte	0x27
	.byte	0xc
	.4byte	0x404
	.byte	0x2c
	.uleb128 0x9
	.4byte	.LASF540
	.byte	0x44
	.byte	0x28
	.byte	0xc
	.4byte	0x404
	.byte	0x30
	.uleb128 0x9
	.4byte	.LASF541
	.byte	0x44
	.byte	0x29
	.byte	0xc
	.4byte	0x404
	.byte	0x34
	.uleb128 0x9
	.4byte	.LASF518
	.byte	0x44
	.byte	0x2a
	.byte	0xc
	.4byte	0x404
	.byte	0x38
	.uleb128 0x9
	.4byte	.LASF542
	.byte	0x44
	.byte	0x2c
	.byte	0xc
	.4byte	0x404
	.byte	0x3c
	.uleb128 0x9
	.4byte	.LASF543
	.byte	0x44
	.byte	0x2d
	.byte	0xc
	.4byte	0x404
	.byte	0x40
	.uleb128 0x9
	.4byte	.LASF544
	.byte	0x44
	.byte	0x2f
	.byte	0xc
	.4byte	0x404
	.byte	0x44
	.uleb128 0x9
	.4byte	.LASF545
	.byte	0x44
	.byte	0x30
	.byte	0xc
	.4byte	0x404
	.byte	0x48
	.uleb128 0x9
	.4byte	.LASF546
	.byte	0x44
	.byte	0x32
	.byte	0xd
	.4byte	0x210a
	.byte	0x4c
	.uleb128 0x9
	.4byte	.LASF547
	.byte	0x44
	.byte	0x34
	.byte	0x1e
	.4byte	0x1f82
	.byte	0x50
	.uleb128 0x9
	.4byte	.LASF548
	.byte	0x44
	.byte	0x35
	.byte	0x1e
	.4byte	0x1f82
	.byte	0x56
	.uleb128 0x9
	.4byte	.LASF549
	.byte	0x44
	.byte	0x36
	.byte	0x1e
	.4byte	0x1f82
	.byte	0x5c
	.uleb128 0x9
	.4byte	.LASF550
	.byte	0x44
	.byte	0x37
	.byte	0x1e
	.4byte	0x1f82
	.byte	0x62
	.uleb128 0x9
	.4byte	.LASF551
	.byte	0x44
	.byte	0x3c
	.byte	0xd
	.4byte	0x2110
	.byte	0x68
	.byte	0
	.uleb128 0x7
	.byte	0x4
	.4byte	0x3ec
	.uleb128 0x7
	.byte	0x4
	.4byte	0x404
	.uleb128 0x7
	.byte	0x4
	.4byte	0x3f8
	.uleb128 0x21
	.4byte	.LASF552
	.byte	0x1
	.byte	0x25
	.byte	0x18
	.4byte	0x1fb1
	.uleb128 0x5
	.byte	0x3
	.4byte	g_armwave_state
	.uleb128 0xc
	.4byte	0x3ec
	.4byte	0x213b
	.uleb128 0x22
	.4byte	0x3a
	.4byte	0x1ffff
	.byte	0
	.uleb128 0x21
	.4byte	.LASF553
	.byte	0x1
	.byte	0x27
	.byte	0x9
	.4byte	0x2128
	.uleb128 0x5
	.byte	0x3
	.4byte	test_wave_buffer
	.uleb128 0xc
	.4byte	0x3ec
	.4byte	0x215d
	.uleb128 0xd
	.4byte	0x3a
	.byte	0xff
	.byte	0
	.uleb128 0x21
	.4byte	.LASF554
	.byte	0x1
	.byte	0x28
	.byte	0x9
	.4byte	0x214d
	.uleb128 0x5
	.byte	0x3
	.4byte	gamma_table
	.uleb128 0x23
	.4byte	.LASF622
	.byte	0x1
	.2byte	0x1c0
	.byte	0x5
	.4byte	0x33
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x22f2
	.uleb128 0x24
	.4byte	.LASF555
	.byte	0x1
	.2byte	0x1c0
	.byte	0xe
	.4byte	0x33
	.4byte	.LLST124
	.4byte	.LVUS124
	.uleb128 0x24
	.4byte	.LASF556
	.byte	0x1
	.2byte	0x1c0
	.byte	0x1a
	.4byte	0x3a9
	.4byte	.LLST125
	.4byte	.LVUS125
	.uleb128 0x25
	.4byte	.LASF557
	.byte	0x1
	.2byte	0x1c2
	.byte	0xf
	.4byte	0x210a
	.uleb128 0x26
	.ascii	"xx\000"
	.byte	0x1
	.2byte	0x1c3
	.byte	0xe
	.4byte	0x404
	.uleb128 0x27
	.ascii	"yy\000"
	.byte	0x1
	.2byte	0x1c3
	.byte	0x12
	.4byte	0x404
	.4byte	.LLST126
	.4byte	.LVUS126
	.uleb128 0x27
	.ascii	"n\000"
	.byte	0x1
	.2byte	0x1c3
	.byte	0x16
	.4byte	0x404
	.4byte	.LLST127
	.4byte	.LVUS127
	.uleb128 0x28
	.4byte	0x2df5
	.4byte	.LBI37
	.byte	.LVU1043
	.4byte	.Ldebug_ranges0+0x70
	.byte	0x1
	.2byte	0x1c6
	.byte	0x5
	.uleb128 0x29
	.4byte	0x2dfe
	.4byte	.LBI43
	.byte	.LVU1063
	.4byte	.Ldebug_ranges0+0x90
	.byte	0x1
	.2byte	0x1d6
	.byte	0xd
	.4byte	0x22aa
	.uleb128 0x2a
	.4byte	0x2e17
	.4byte	.LLST128
	.4byte	.LVUS128
	.uleb128 0x2a
	.4byte	0x2e0b
	.4byte	.LLST129
	.4byte	.LVUS129
	.uleb128 0x2b
	.4byte	.Ldebug_ranges0+0x90
	.uleb128 0x2c
	.4byte	0x2e23
	.4byte	.LLST130
	.4byte	.LVUS130
	.uleb128 0x2c
	.4byte	0x2e2e
	.4byte	.LLST131
	.4byte	.LVUS131
	.uleb128 0x2c
	.4byte	0x2e39
	.4byte	.LLST132
	.4byte	.LVUS132
	.uleb128 0x2c
	.4byte	0x2e43
	.4byte	.LLST133
	.4byte	.LVUS133
	.uleb128 0x2d
	.4byte	0x2e4f
	.uleb128 0x2c
	.4byte	0x2e5b
	.4byte	.LLST134
	.4byte	.LVUS134
	.uleb128 0x2c
	.4byte	0x2e67
	.4byte	.LLST135
	.4byte	.LVUS135
	.uleb128 0x2c
	.4byte	0x2e73
	.4byte	.LLST136
	.4byte	.LVUS136
	.uleb128 0x2c
	.4byte	0x2e7f
	.4byte	.LLST137
	.4byte	.LVUS137
	.byte	0
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL285
	.4byte	0x23e9
	.4byte	0x22d0
	.uleb128 0x2f
	.uleb128 0x2
	.byte	0x90
	.uleb128 0x40
	.uleb128 0x7
	.byte	0xf4
	.uleb128 0x25
	.byte	0x4
	.4byte	0x3f000000
	.uleb128 0x2f
	.uleb128 0x2
	.byte	0x90
	.uleb128 0x41
	.uleb128 0x7
	.byte	0xf4
	.uleb128 0x25
	.byte	0x4
	.4byte	0x358637bd
	.byte	0
	.uleb128 0x30
	.4byte	.LVL286
	.4byte	0x2e8c
	.uleb128 0x31
	.4byte	.LVL287
	.4byte	0x2eb0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0xa
	.2byte	0x800
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x100
	.byte	0
	.byte	0
	.uleb128 0x32
	.4byte	.LASF558
	.byte	0x1
	.2byte	0x1b5
	.byte	0x6
	.4byte	.LFB72
	.4byte	.LFE72-.LFB72
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2325
	.uleb128 0x30
	.4byte	.LVL281
	.4byte	0x3438
	.uleb128 0x30
	.4byte	.LVL282
	.4byte	0x3438
	.uleb128 0x30
	.4byte	.LVL283
	.4byte	0x3438
	.byte	0
	.uleb128 0x32
	.4byte	.LASF559
	.byte	0x1
	.2byte	0x190
	.byte	0x6
	.4byte	.LFB71
	.4byte	.LFE71-.LFB71
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x23e9
	.uleb128 0x24
	.4byte	.LASF560
	.byte	0x1
	.2byte	0x190
	.byte	0x27
	.4byte	0x25
	.4byte	.LLST117
	.4byte	.LVUS117
	.uleb128 0x27
	.ascii	"v\000"
	.byte	0x1
	.2byte	0x192
	.byte	0xd
	.4byte	0x3ec
	.4byte	.LLST118
	.4byte	.LVUS118
	.uleb128 0x33
	.4byte	.LASF561
	.byte	0x1
	.2byte	0x193
	.byte	0xb
	.4byte	0x25
	.4byte	.LLST119
	.4byte	.LVUS119
	.uleb128 0x25
	.4byte	.LASF562
	.byte	0x1
	.2byte	0x193
	.byte	0x12
	.4byte	0x25
	.uleb128 0x33
	.4byte	.LASF563
	.byte	0x1
	.2byte	0x194
	.byte	0xb
	.4byte	0x25
	.4byte	.LLST120
	.4byte	.LVUS120
	.uleb128 0x33
	.4byte	.LASF564
	.byte	0x1
	.2byte	0x194
	.byte	0x19
	.4byte	0x25
	.4byte	.LLST121
	.4byte	.LVUS121
	.uleb128 0x27
	.ascii	"w\000"
	.byte	0x1
	.2byte	0x195
	.byte	0x9
	.4byte	0x33
	.4byte	.LLST122
	.4byte	.LVUS122
	.uleb128 0x27
	.ascii	"x\000"
	.byte	0x1
	.2byte	0x195
	.byte	0xc
	.4byte	0x33
	.4byte	.LLST123
	.4byte	.LVUS123
	.uleb128 0x30
	.4byte	.LVL265
	.4byte	0x3445
	.uleb128 0x30
	.4byte	.LVL271
	.4byte	0x3445
	.byte	0
	.uleb128 0x32
	.4byte	.LASF565
	.byte	0x1
	.2byte	0x16f
	.byte	0x6
	.4byte	.LFB70
	.4byte	.LFE70-.LFB70
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x24c7
	.uleb128 0x34
	.ascii	"mod\000"
	.byte	0x1
	.2byte	0x16f
	.byte	0x28
	.4byte	0x25
	.4byte	.LLST109
	.4byte	.LVUS109
	.uleb128 0x24
	.4byte	.LASF560
	.byte	0x1
	.2byte	0x16f
	.byte	0x33
	.4byte	0x25
	.4byte	.LLST110
	.4byte	.LVUS110
	.uleb128 0x27
	.ascii	"v\000"
	.byte	0x1
	.2byte	0x171
	.byte	0xb
	.4byte	0x25
	.4byte	.LLST111
	.4byte	.LVUS111
	.uleb128 0x33
	.4byte	.LASF561
	.byte	0x1
	.2byte	0x171
	.byte	0xe
	.4byte	0x25
	.4byte	.LLST112
	.4byte	.LVUS112
	.uleb128 0x33
	.4byte	.LASF562
	.byte	0x1
	.2byte	0x171
	.byte	0x15
	.4byte	0x25
	.4byte	.LLST113
	.4byte	.LVUS113
	.uleb128 0x33
	.4byte	.LASF566
	.byte	0x1
	.2byte	0x171
	.byte	0x1d
	.4byte	0x25
	.4byte	.LLST114
	.4byte	.LVUS114
	.uleb128 0x27
	.ascii	"w\000"
	.byte	0x1
	.2byte	0x172
	.byte	0x9
	.4byte	0x33
	.4byte	.LLST115
	.4byte	.LVUS115
	.uleb128 0x27
	.ascii	"x\000"
	.byte	0x1
	.2byte	0x172
	.byte	0xc
	.4byte	0x33
	.4byte	.LLST116
	.4byte	.LVUS116
	.uleb128 0x30
	.4byte	.LVL245
	.4byte	0x3445
	.uleb128 0x30
	.4byte	.LVL251
	.4byte	0x3445
	.uleb128 0x30
	.4byte	.LVL253
	.4byte	0x3445
	.uleb128 0x30
	.4byte	.LVL255
	.4byte	0x3452
	.byte	0
	.uleb128 0x32
	.4byte	.LASF567
	.byte	0x1
	.2byte	0x164
	.byte	0x6
	.4byte	.LFB69
	.4byte	.LFE69-.LFB69
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2504
	.uleb128 0x34
	.ascii	"fn\000"
	.byte	0x1
	.2byte	0x164
	.byte	0x2c
	.4byte	0xfd
	.4byte	.LLST108
	.4byte	.LVUS108
	.uleb128 0x35
	.4byte	.LVL240
	.4byte	0x289b
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0
	.byte	0
	.uleb128 0x32
	.4byte	.LASF568
	.byte	0x1
	.2byte	0x158
	.byte	0x6
	.4byte	.LFB68
	.4byte	.LFE68-.LFB68
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2698
	.uleb128 0x34
	.ascii	"buf\000"
	.byte	0x1
	.2byte	0x158
	.byte	0x29
	.4byte	0x86e
	.4byte	.LLST86
	.4byte	.LVUS86
	.uleb128 0x33
	.4byte	.LASF546
	.byte	0x1
	.2byte	0x15e
	.byte	0xb
	.4byte	0x52
	.4byte	.LLST87
	.4byte	.LVUS87
	.uleb128 0x36
	.4byte	0x29d9
	.4byte	.LBI27
	.byte	.LVU797
	.4byte	.Ldebug_ranges0+0x50
	.byte	0x1
	.2byte	0x161
	.byte	0x3
	.uleb128 0x2a
	.4byte	0x29e6
	.4byte	.LLST88
	.4byte	.LVUS88
	.uleb128 0x2b
	.4byte	.Ldebug_ranges0+0x50
	.uleb128 0x2c
	.4byte	0x29f2
	.4byte	.LLST89
	.4byte	.LVUS89
	.uleb128 0x2c
	.4byte	0x29fd
	.4byte	.LLST90
	.4byte	.LVUS90
	.uleb128 0x2d
	.4byte	0x2a08
	.uleb128 0x2c
	.4byte	0x2a14
	.4byte	.LLST91
	.4byte	.LVUS91
	.uleb128 0x2c
	.4byte	0x2a20
	.4byte	.LLST92
	.4byte	.LVUS92
	.uleb128 0x2c
	.4byte	0x2a2c
	.4byte	.LLST93
	.4byte	.LVUS93
	.uleb128 0x2c
	.4byte	0x2a37
	.4byte	.LLST94
	.4byte	.LVUS94
	.uleb128 0x2c
	.4byte	0x2a42
	.4byte	.LLST95
	.4byte	.LVUS95
	.uleb128 0x2c
	.4byte	0x2a4d
	.4byte	.LLST96
	.4byte	.LVUS96
	.uleb128 0x2c
	.4byte	0x2a57
	.4byte	.LLST97
	.4byte	.LVUS97
	.uleb128 0x2c
	.4byte	0x2a63
	.4byte	.LLST98
	.4byte	.LVUS98
	.uleb128 0x2d
	.4byte	0x2a6f
	.uleb128 0x2c
	.4byte	0x2a79
	.4byte	.LLST99
	.4byte	.LVUS99
	.uleb128 0x2c
	.4byte	0x2a85
	.4byte	.LLST100
	.4byte	.LVUS100
	.uleb128 0x2c
	.4byte	0x2a8f
	.4byte	.LLST101
	.4byte	.LVUS101
	.uleb128 0x2c
	.4byte	0x2a99
	.4byte	.LLST102
	.4byte	.LVUS102
	.uleb128 0x2c
	.4byte	0x2aa3
	.4byte	.LLST103
	.4byte	.LVUS103
	.uleb128 0x2c
	.4byte	0x2aaf
	.4byte	.LLST104
	.4byte	.LVUS104
	.uleb128 0x2c
	.4byte	0x2abb
	.4byte	.LLST105
	.4byte	.LVUS105
	.uleb128 0x2c
	.4byte	0x2ac7
	.4byte	.LLST106
	.4byte	.LVUS106
	.uleb128 0x2c
	.4byte	0x2ad3
	.4byte	.LLST107
	.4byte	.LVUS107
	.uleb128 0x31
	.4byte	.LVL237
	.4byte	0x345e
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC6
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0xfe
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0+48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x37
	.4byte	.LASF569
	.byte	0x1
	.2byte	0x14d
	.byte	0x6
	.4byte	.LFB67
	.4byte	.LFE67-.LFB67
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2777
	.uleb128 0x27
	.ascii	"yy\000"
	.byte	0x1
	.2byte	0x14f
	.byte	0xe
	.4byte	0x404
	.4byte	.LLST75
	.4byte	.LVUS75
	.uleb128 0x29
	.4byte	0x2dfe
	.4byte	.LBI21
	.byte	.LVU725
	.4byte	.Ldebug_ranges0+0x38
	.byte	0x1
	.2byte	0x154
	.byte	0x9
	.4byte	0x2767
	.uleb128 0x2a
	.4byte	0x2e17
	.4byte	.LLST76
	.4byte	.LVUS76
	.uleb128 0x2a
	.4byte	0x2e0b
	.4byte	.LLST77
	.4byte	.LVUS77
	.uleb128 0x2b
	.4byte	.Ldebug_ranges0+0x38
	.uleb128 0x2c
	.4byte	0x2e23
	.4byte	.LLST78
	.4byte	.LVUS78
	.uleb128 0x2c
	.4byte	0x2e2e
	.4byte	.LLST79
	.4byte	.LVUS79
	.uleb128 0x2c
	.4byte	0x2e39
	.4byte	.LLST80
	.4byte	.LVUS80
	.uleb128 0x2c
	.4byte	0x2e43
	.4byte	.LLST81
	.4byte	.LVUS81
	.uleb128 0x2d
	.4byte	0x2e4f
	.uleb128 0x2c
	.4byte	0x2e5b
	.4byte	.LLST82
	.4byte	.LVUS82
	.uleb128 0x2c
	.4byte	0x2e67
	.4byte	.LLST83
	.4byte	.LVUS83
	.uleb128 0x2c
	.4byte	0x2e73
	.4byte	.LLST84
	.4byte	.LVUS84
	.uleb128 0x2c
	.4byte	0x2e7f
	.4byte	.LLST85
	.4byte	.LVUS85
	.byte	0
	.byte	0
	.uleb128 0x31
	.4byte	.LVL183
	.4byte	0x346a
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.byte	0
	.uleb128 0x32
	.4byte	.LASF570
	.byte	0x1
	.2byte	0x141
	.byte	0x6
	.4byte	.LFB66
	.4byte	.LFE66-.LFB66
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x289b
	.uleb128 0x24
	.4byte	.LASF571
	.byte	0x1
	.2byte	0x141
	.byte	0x1c
	.4byte	0x33
	.4byte	.LLST68
	.4byte	.LVUS68
	.uleb128 0x24
	.4byte	.LASF572
	.byte	0x1
	.2byte	0x141
	.byte	0x2e
	.4byte	0x33
	.4byte	.LLST69
	.4byte	.LVUS69
	.uleb128 0x29
	.4byte	0x2e8c
	.4byte	.LBI10
	.byte	.LVU677
	.4byte	.Ldebug_ranges0+0
	.byte	0x1
	.2byte	0x143
	.byte	0x5
	.4byte	0x2819
	.uleb128 0x2b
	.4byte	.Ldebug_ranges0+0x8
	.uleb128 0x2c
	.4byte	0x2e99
	.4byte	.LLST70
	.4byte	.LVUS70
	.uleb128 0x2d
	.4byte	0x2ea3
	.uleb128 0x31
	.4byte	.LVL176
	.4byte	0x3475
	.uleb128 0x2f
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x40
	.byte	0x93
	.uleb128 0x4
	.byte	0x90
	.uleb128 0x41
	.byte	0x93
	.uleb128 0x4
	.uleb128 0xf
	.byte	0x75
	.sleb128 0
	.byte	0x74
	.sleb128 0
	.byte	0x22
	.byte	0xf7
	.uleb128 0x33
	.byte	0xf7
	.uleb128 0x25
	.byte	0xf5
	.uleb128 0x54
	.uleb128 0x25
	.byte	0x1b
	.byte	0xf7
	.uleb128 0x2c
	.uleb128 0x2f
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x42
	.byte	0x93
	.uleb128 0x4
	.byte	0x90
	.uleb128 0x43
	.byte	0x93
	.uleb128 0x4
	.uleb128 0x3
	.byte	0xf5
	.uleb128 0x52
	.uleb128 0x2c
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x29
	.4byte	0x2ccf
	.4byte	.LBI15
	.byte	.LVU694
	.4byte	.Ldebug_ranges0+0x20
	.byte	0x1
	.2byte	0x146
	.byte	0x5
	.4byte	0x2864
	.uleb128 0x2a
	.4byte	0x2cfb
	.4byte	.LLST71
	.4byte	.LVUS71
	.uleb128 0x2a
	.4byte	0x2cf1
	.4byte	.LLST72
	.4byte	.LVUS72
	.uleb128 0x2a
	.4byte	0x2ce7
	.4byte	.LLST73
	.4byte	.LVUS73
	.uleb128 0x2a
	.4byte	0x2cdc
	.4byte	.LLST74
	.4byte	.LVUS74
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL180
	.4byte	0x2eb0
	.4byte	0x287e
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.byte	0
	.uleb128 0x35
	.4byte	.LVL182
	.4byte	0x3481
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC13
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC12
	.byte	0
	.byte	0
	.uleb128 0x32
	.4byte	.LASF573
	.byte	0x1
	.2byte	0x129
	.byte	0x6
	.4byte	.LFB65
	.4byte	.LFE65-.LFB65
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x29d9
	.uleb128 0x24
	.4byte	.LASF574
	.byte	0x1
	.2byte	0x129
	.byte	0x27
	.4byte	0x210a
	.4byte	.LLST62
	.4byte	.LVUS62
	.uleb128 0x34
	.ascii	"fn\000"
	.byte	0x1
	.2byte	0x129
	.byte	0x35
	.4byte	0xfd
	.4byte	.LLST63
	.4byte	.LVUS63
	.uleb128 0x27
	.ascii	"fp\000"
	.byte	0x1
	.2byte	0x12b
	.byte	0xb
	.4byte	0x31a
	.4byte	.LLST64
	.4byte	.LVUS64
	.uleb128 0x33
	.4byte	.LASF575
	.byte	0x1
	.2byte	0x12c
	.byte	0xe
	.4byte	0x404
	.4byte	.LLST65
	.4byte	.LVUS65
	.uleb128 0x27
	.ascii	"xx\000"
	.byte	0x1
	.2byte	0x12d
	.byte	0x9
	.4byte	0x33
	.4byte	.LLST66
	.4byte	.LVUS66
	.uleb128 0x27
	.ascii	"yy\000"
	.byte	0x1
	.2byte	0x12d
	.byte	0xd
	.4byte	0x33
	.4byte	.LLST67
	.4byte	.LVUS67
	.uleb128 0x2e
	.4byte	.LVL156
	.4byte	0x348e
	.4byte	0x294a
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC7
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL159
	.4byte	0x349b
	.4byte	0x2971
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC8
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x33
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL160
	.4byte	0x34a6
	.4byte	0x298e
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC9
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL161
	.4byte	0x349b
	.4byte	0x29b5
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC10
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x1
	.byte	0x34
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL167
	.4byte	0x34a6
	.4byte	0x29cf
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.byte	0
	.uleb128 0x38
	.4byte	.LVL172
	.4byte	0x34b3
	.byte	0
	.uleb128 0x39
	.4byte	.LASF587
	.byte	0x1
	.byte	0xf5
	.byte	0x6
	.byte	0x1
	.4byte	0x2aef
	.uleb128 0x3a
	.4byte	.LASF557
	.byte	0x1
	.byte	0xf5
	.byte	0x2b
	.4byte	0x210a
	.uleb128 0x3b
	.ascii	"xx\000"
	.byte	0x1
	.byte	0xf7
	.byte	0xe
	.4byte	0x404
	.uleb128 0x3b
	.ascii	"yy\000"
	.byte	0x1
	.byte	0xf7
	.byte	0x12
	.4byte	0x404
	.uleb128 0x3c
	.4byte	.LASF576
	.byte	0x1
	.byte	0xf7
	.byte	0x16
	.4byte	0x404
	.uleb128 0x3c
	.4byte	.LASF577
	.byte	0x1
	.byte	0xf7
	.byte	0x1c
	.4byte	0x404
	.uleb128 0x3c
	.4byte	.LASF578
	.byte	0x1
	.byte	0xf7
	.byte	0x22
	.4byte	0x404
	.uleb128 0x3b
	.ascii	"rr\000"
	.byte	0x1
	.byte	0xf8
	.byte	0x9
	.4byte	0x33
	.uleb128 0x3b
	.ascii	"gg\000"
	.byte	0x1
	.byte	0xf8
	.byte	0xd
	.4byte	0x33
	.uleb128 0x3b
	.ascii	"bb\000"
	.byte	0x1
	.byte	0xf8
	.byte	0x11
	.4byte	0x33
	.uleb128 0x3b
	.ascii	"n\000"
	.byte	0x1
	.byte	0xf8
	.byte	0x15
	.4byte	0x33
	.uleb128 0x3c
	.4byte	.LASF579
	.byte	0x1
	.byte	0xf8
	.byte	0x18
	.4byte	0x33
	.uleb128 0x3c
	.4byte	.LASF580
	.byte	0x1
	.byte	0xf8
	.byte	0x1e
	.4byte	0x33
	.uleb128 0x3b
	.ascii	"w\000"
	.byte	0x1
	.byte	0xf8
	.byte	0x24
	.4byte	0x33
	.uleb128 0x3c
	.4byte	.LASF535
	.byte	0x1
	.byte	0xf8
	.byte	0x27
	.4byte	0x33
	.uleb128 0x3b
	.ascii	"r\000"
	.byte	0x1
	.byte	0xf9
	.byte	0xd
	.4byte	0x3ec
	.uleb128 0x3b
	.ascii	"g\000"
	.byte	0x1
	.byte	0xf9
	.byte	0x10
	.4byte	0x3ec
	.uleb128 0x3b
	.ascii	"b\000"
	.byte	0x1
	.byte	0xf9
	.byte	0x13
	.4byte	0x3ec
	.uleb128 0x3c
	.4byte	.LASF581
	.byte	0x1
	.byte	0xf9
	.byte	0x16
	.4byte	0x3ec
	.uleb128 0x3b
	.ascii	"row\000"
	.byte	0x1
	.byte	0xf9
	.byte	0x1d
	.4byte	0x3ec
	.uleb128 0x3c
	.4byte	.LASF582
	.byte	0x1
	.byte	0xfa
	.byte	0xf
	.4byte	0x210a
	.uleb128 0x3c
	.4byte	.LASF583
	.byte	0x1
	.byte	0xfb
	.byte	0xf
	.4byte	0x210a
	.uleb128 0x3c
	.4byte	.LASF584
	.byte	0x1
	.byte	0xfc
	.byte	0xe
	.4byte	0x404
	.uleb128 0x3d
	.4byte	.LASF586
	.4byte	0x2aff
	.uleb128 0x5
	.byte	0x3
	.4byte	__PRETTY_FUNCTION__.17062
	.byte	0
	.uleb128 0xc
	.4byte	0x10a
	.4byte	0x2aff
	.uleb128 0xd
	.4byte	0x3a
	.byte	0x1a
	.byte	0
	.uleb128 0x5
	.4byte	0x2aef
	.uleb128 0x3e
	.4byte	.LASF585
	.byte	0x1
	.byte	0xbf
	.byte	0x6
	.4byte	.LFB63
	.4byte	.LFE63-.LFB63
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2cba
	.uleb128 0x3f
	.4byte	.LASF557
	.byte	0x1
	.byte	0xbf
	.byte	0x28
	.4byte	0x210a
	.4byte	.LLST24
	.4byte	.LVUS24
	.uleb128 0x40
	.ascii	"xx\000"
	.byte	0x1
	.byte	0xc1
	.byte	0xe
	.4byte	0x404
	.4byte	.LLST25
	.4byte	.LVUS25
	.uleb128 0x40
	.ascii	"yy\000"
	.byte	0x1
	.byte	0xc1
	.byte	0x12
	.4byte	0x404
	.4byte	.LLST26
	.4byte	.LVUS26
	.uleb128 0x41
	.4byte	.LASF577
	.byte	0x1
	.byte	0xc1
	.byte	0x16
	.4byte	0x404
	.4byte	.LLST27
	.4byte	.LVUS27
	.uleb128 0x41
	.4byte	.LASF578
	.byte	0x1
	.byte	0xc1
	.byte	0x1c
	.4byte	0x404
	.4byte	.LLST28
	.4byte	.LVUS28
	.uleb128 0x40
	.ascii	"rr\000"
	.byte	0x1
	.byte	0xc2
	.byte	0x9
	.4byte	0x33
	.4byte	.LLST29
	.4byte	.LVUS29
	.uleb128 0x40
	.ascii	"gg\000"
	.byte	0x1
	.byte	0xc2
	.byte	0xd
	.4byte	0x33
	.4byte	.LLST30
	.4byte	.LVUS30
	.uleb128 0x40
	.ascii	"bb\000"
	.byte	0x1
	.byte	0xc2
	.byte	0x11
	.4byte	0x33
	.4byte	.LLST31
	.4byte	.LVUS31
	.uleb128 0x40
	.ascii	"n\000"
	.byte	0x1
	.byte	0xc2
	.byte	0x15
	.4byte	0x33
	.4byte	.LLST32
	.4byte	.LVUS32
	.uleb128 0x41
	.4byte	.LASF579
	.byte	0x1
	.byte	0xc2
	.byte	0x18
	.4byte	0x33
	.4byte	.LLST33
	.4byte	.LVUS33
	.uleb128 0x41
	.4byte	.LASF580
	.byte	0x1
	.byte	0xc2
	.byte	0x1e
	.4byte	0x33
	.4byte	.LLST34
	.4byte	.LVUS34
	.uleb128 0x40
	.ascii	"i\000"
	.byte	0x1
	.byte	0xc2
	.byte	0x24
	.4byte	0x33
	.4byte	.LLST35
	.4byte	.LVUS35
	.uleb128 0x40
	.ascii	"r\000"
	.byte	0x1
	.byte	0xc3
	.byte	0xd
	.4byte	0x3ec
	.4byte	.LLST36
	.4byte	.LVUS36
	.uleb128 0x40
	.ascii	"g\000"
	.byte	0x1
	.byte	0xc3
	.byte	0x10
	.4byte	0x3ec
	.4byte	.LLST37
	.4byte	.LVUS37
	.uleb128 0x40
	.ascii	"b\000"
	.byte	0x1
	.byte	0xc3
	.byte	0x13
	.4byte	0x3ec
	.4byte	.LLST38
	.4byte	.LVUS38
	.uleb128 0x41
	.4byte	.LASF581
	.byte	0x1
	.byte	0xc3
	.byte	0x16
	.4byte	0x3ec
	.4byte	.LLST39
	.4byte	.LVUS39
	.uleb128 0x41
	.4byte	.LASF582
	.byte	0x1
	.byte	0xc4
	.byte	0xf
	.4byte	0x210a
	.4byte	.LLST40
	.4byte	.LVUS40
	.uleb128 0x3c
	.4byte	.LASF583
	.byte	0x1
	.byte	0xc5
	.byte	0xf
	.4byte	0x210a
	.uleb128 0x41
	.4byte	.LASF584
	.byte	0x1
	.byte	0xc6
	.byte	0xe
	.4byte	0x404
	.4byte	.LLST41
	.4byte	.LVUS41
	.uleb128 0x3d
	.4byte	.LASF586
	.4byte	0x2cca
	.uleb128 0x5
	.byte	0x3
	.4byte	__PRETTY_FUNCTION__.17031
	.uleb128 0x31
	.4byte	.LVL119
	.4byte	0x345e
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC6
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0xc8
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0+24
	.byte	0
	.byte	0
	.uleb128 0xc
	.4byte	0x10a
	.4byte	0x2cca
	.uleb128 0xd
	.4byte	0x3a
	.byte	0x17
	.byte	0
	.uleb128 0x5
	.4byte	0x2cba
	.uleb128 0x39
	.4byte	.LASF588
	.byte	0x1
	.byte	0xb0
	.byte	0x6
	.byte	0x1
	.4byte	0x2d06
	.uleb128 0x42
	.ascii	"ch\000"
	.byte	0x1
	.byte	0xb0
	.byte	0x25
	.4byte	0x33
	.uleb128 0x42
	.ascii	"r\000"
	.byte	0x1
	.byte	0xb0
	.byte	0x2d
	.4byte	0x33
	.uleb128 0x42
	.ascii	"g\000"
	.byte	0x1
	.byte	0xb0
	.byte	0x34
	.4byte	0x33
	.uleb128 0x42
	.ascii	"b\000"
	.byte	0x1
	.byte	0xb0
	.byte	0x3b
	.4byte	0x33
	.byte	0
	.uleb128 0x3e
	.4byte	.LASF589
	.byte	0x1
	.byte	0xa7
	.byte	0x6
	.4byte	.LFB61
	.4byte	.LFE61-.LFB61
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x2d40
	.uleb128 0x3f
	.4byte	.LASF528
	.byte	0x1
	.byte	0xa7
	.byte	0x24
	.4byte	0x404
	.4byte	.LLST22
	.4byte	.LVUS22
	.uleb128 0x35
	.4byte	.LVL63
	.4byte	0x346a
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.byte	0
	.uleb128 0x39
	.4byte	.LASF590
	.byte	0x1
	.byte	0x62
	.byte	0x6
	.byte	0x1
	.4byte	0x2de0
	.uleb128 0x3a
	.4byte	.LASF533
	.byte	0x1
	.byte	0x62
	.byte	0x24
	.4byte	0x2104
	.uleb128 0x3a
	.4byte	.LASF591
	.byte	0x1
	.byte	0x62
	.byte	0x3a
	.4byte	0x404
	.uleb128 0x3a
	.4byte	.LASF592
	.byte	0x1
	.byte	0x62
	.byte	0x50
	.4byte	0x404
	.uleb128 0x3a
	.4byte	.LASF537
	.byte	0x1
	.byte	0x62
	.byte	0x64
	.4byte	0x404
	.uleb128 0x3a
	.4byte	.LASF536
	.byte	0x1
	.byte	0x62
	.byte	0x74
	.4byte	0x404
	.uleb128 0x3a
	.4byte	.LASF542
	.byte	0x1
	.byte	0x62
	.byte	0x8a
	.4byte	0x404
	.uleb128 0x3a
	.4byte	.LASF543
	.byte	0x1
	.byte	0x62
	.byte	0xa1
	.4byte	0x404
	.uleb128 0x3a
	.4byte	.LASF593
	.byte	0x1
	.byte	0x62
	.byte	0xb9
	.4byte	0x404
	.uleb128 0x3c
	.4byte	.LASF594
	.byte	0x1
	.byte	0x64
	.byte	0xe
	.4byte	0x404
	.uleb128 0x3b
	.ascii	"xx\000"
	.byte	0x1
	.byte	0x64
	.byte	0x16
	.4byte	0x404
	.uleb128 0x3c
	.4byte	.LASF595
	.byte	0x1
	.byte	0x65
	.byte	0xb
	.4byte	0x25
	.uleb128 0x3d
	.4byte	.LASF586
	.4byte	0x2df0
	.uleb128 0x5
	.byte	0x3
	.4byte	__PRETTY_FUNCTION__.16995
	.byte	0
	.uleb128 0xc
	.4byte	0x10a
	.4byte	0x2df0
	.uleb128 0xd
	.4byte	0x3a
	.byte	0x14
	.byte	0
	.uleb128 0x5
	.4byte	0x2de0
	.uleb128 0x43
	.4byte	.LASF623
	.byte	0x1
	.byte	0x5d
	.byte	0x6
	.byte	0x1
	.uleb128 0x39
	.4byte	.LASF596
	.byte	0x1
	.byte	0x3f
	.byte	0x6
	.byte	0x1
	.4byte	0x2e8c
	.uleb128 0x3a
	.4byte	.LASF597
	.byte	0x1
	.byte	0x3f
	.byte	0x30
	.4byte	0x404
	.uleb128 0x3a
	.4byte	.LASF598
	.byte	0x1
	.byte	0x3f
	.byte	0x42
	.4byte	0x404
	.uleb128 0x3b
	.ascii	"yy\000"
	.byte	0x1
	.byte	0x41
	.byte	0x9
	.4byte	0x33
	.uleb128 0x3b
	.ascii	"ys\000"
	.byte	0x1
	.byte	0x41
	.byte	0xd
	.4byte	0x33
	.uleb128 0x3b
	.ascii	"w\000"
	.byte	0x1
	.byte	0x41
	.byte	0x11
	.4byte	0x33
	.uleb128 0x3c
	.4byte	.LASF599
	.byte	0x1
	.byte	0x41
	.byte	0x14
	.4byte	0x33
	.uleb128 0x3c
	.4byte	.LASF581
	.byte	0x1
	.byte	0x42
	.byte	0xe
	.4byte	0x404
	.uleb128 0x3c
	.4byte	.LASF577
	.byte	0x1
	.byte	0x42
	.byte	0x15
	.4byte	0x404
	.uleb128 0x3c
	.4byte	.LASF600
	.byte	0x1
	.byte	0x43
	.byte	0xe
	.4byte	0x2104
	.uleb128 0x3c
	.4byte	.LASF601
	.byte	0x1
	.byte	0x44
	.byte	0xe
	.4byte	0x2104
	.uleb128 0x3c
	.4byte	.LASF602
	.byte	0x1
	.byte	0x45
	.byte	0xe
	.4byte	0x2104
	.byte	0
	.uleb128 0x44
	.4byte	.LASF624
	.byte	0x1
	.byte	0x2d
	.byte	0x6
	.byte	0x1
	.4byte	0x2eb0
	.uleb128 0x3b
	.ascii	"i\000"
	.byte	0x1
	.byte	0x2f
	.byte	0x9
	.4byte	0x33
	.uleb128 0x3c
	.4byte	.LASF603
	.byte	0x1
	.byte	0x30
	.byte	0xb
	.4byte	0x25
	.byte	0
	.uleb128 0x45
	.4byte	0x2d40
	.4byte	.LFB74
	.4byte	.LFE74-.LFB74
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x3013
	.uleb128 0x2a
	.4byte	0x2d89
	.4byte	.LLST0
	.4byte	.LVUS0
	.uleb128 0x2a
	.4byte	0x2d95
	.4byte	.LLST1
	.4byte	.LVUS1
	.uleb128 0x2c
	.4byte	0x2dad
	.4byte	.LLST2
	.4byte	.LVUS2
	.uleb128 0x2c
	.4byte	0x2db9
	.4byte	.LLST3
	.4byte	.LVUS3
	.uleb128 0x2c
	.4byte	0x2dc4
	.4byte	.LLST4
	.4byte	.LVUS4
	.uleb128 0x46
	.4byte	0x2da1
	.byte	0
	.uleb128 0x47
	.4byte	0x2d7d
	.2byte	0x800
	.uleb128 0x46
	.4byte	0x2d71
	.byte	0x40
	.uleb128 0x47
	.4byte	0x2d65
	.2byte	0x800
	.uleb128 0x46
	.4byte	0x2d59
	.byte	0
	.uleb128 0x48
	.4byte	0x2d4d
	.uleb128 0x6
	.byte	0x3
	.4byte	test_wave_buffer
	.byte	0x9f
	.uleb128 0x2e
	.4byte	.LVL3
	.4byte	0x3481
	.4byte	0x2f4f
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC2
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x75
	.sleb128 0
	.byte	0x38
	.byte	0x24
	.byte	0
	.uleb128 0x30
	.4byte	.LVL4
	.4byte	0x3438
	.uleb128 0x2e
	.4byte	.LVL5
	.4byte	0x34bf
	.4byte	0x2f6b
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL8
	.4byte	0x34cc
	.4byte	0x2f80
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x3
	.byte	0xa
	.2byte	0x1000
	.byte	0
	.uleb128 0x30
	.4byte	.LVL11
	.4byte	0x34cc
	.uleb128 0x2e
	.4byte	.LVL16
	.4byte	0x345e
	.4byte	0x2fb8
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x6d
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL17
	.4byte	0x345e
	.4byte	0x2fe7
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC3
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x94
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.byte	0
	.uleb128 0x31
	.4byte	.LVL18
	.4byte	0x345e
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC4
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x9c
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.byte	0
	.byte	0
	.uleb128 0x45
	.4byte	0x2e8c
	.4byte	.LFB57
	.4byte	.LFE57-.LFB57
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x3070
	.uleb128 0x2c
	.4byte	0x2e99
	.4byte	.LLST5
	.4byte	.LVUS5
	.uleb128 0x49
	.4byte	0x2ea3
	.byte	0x4
	.4byte	0x3f666666
	.uleb128 0x31
	.4byte	.LVL21
	.4byte	0x3475
	.uleb128 0x2f
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x40
	.byte	0x93
	.uleb128 0x4
	.byte	0x90
	.uleb128 0x41
	.byte	0x93
	.uleb128 0x4
	.uleb128 0xf
	.byte	0x75
	.sleb128 0
	.byte	0x74
	.sleb128 0
	.byte	0x22
	.byte	0xf7
	.uleb128 0x33
	.byte	0xf7
	.uleb128 0x25
	.byte	0xf5
	.uleb128 0x54
	.uleb128 0x25
	.byte	0x1b
	.byte	0xf7
	.uleb128 0x2c
	.uleb128 0x2f
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x42
	.byte	0x93
	.uleb128 0x4
	.byte	0x90
	.uleb128 0x43
	.byte	0x93
	.uleb128 0x4
	.uleb128 0x3
	.byte	0xf5
	.uleb128 0x52
	.uleb128 0x2c
	.byte	0
	.byte	0
	.uleb128 0x45
	.4byte	0x2dfe
	.4byte	.LFB58
	.4byte	.LFE58-.LFB58
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x3105
	.uleb128 0x2a
	.4byte	0x2e0b
	.4byte	.LLST6
	.4byte	.LVUS6
	.uleb128 0x48
	.4byte	0x2e17
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2c
	.4byte	0x2e23
	.4byte	.LLST7
	.4byte	.LVUS7
	.uleb128 0x2c
	.4byte	0x2e2e
	.4byte	.LLST8
	.4byte	.LVUS8
	.uleb128 0x2c
	.4byte	0x2e39
	.4byte	.LLST9
	.4byte	.LVUS9
	.uleb128 0x2c
	.4byte	0x2e43
	.4byte	.LLST10
	.4byte	.LVUS10
	.uleb128 0x2d
	.4byte	0x2e4f
	.uleb128 0x2c
	.4byte	0x2e5b
	.4byte	.LLST11
	.4byte	.LVUS11
	.uleb128 0x2c
	.4byte	0x2e67
	.4byte	.LLST12
	.4byte	.LVUS12
	.uleb128 0x2c
	.4byte	0x2e73
	.4byte	.LLST13
	.4byte	.LVUS13
	.uleb128 0x2c
	.4byte	0x2e7f
	.4byte	.LLST14
	.4byte	.LVUS14
	.byte	0
	.uleb128 0x4a
	.4byte	0x2df5
	.4byte	.LFB59
	.4byte	.LFE59-.LFB59
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x45
	.4byte	0x2d40
	.4byte	.LFB60
	.4byte	.LFE60-.LFB60
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x32b5
	.uleb128 0x2a
	.4byte	0x2d4d
	.4byte	.LLST15
	.4byte	.LVUS15
	.uleb128 0x2a
	.4byte	0x2d59
	.4byte	.LLST16
	.4byte	.LVUS16
	.uleb128 0x2a
	.4byte	0x2d65
	.4byte	.LLST17
	.4byte	.LVUS17
	.uleb128 0x2a
	.4byte	0x2d71
	.4byte	.LLST18
	.4byte	.LVUS18
	.uleb128 0x48
	.4byte	0x2d7d
	.uleb128 0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0x48
	.4byte	0x2d89
	.uleb128 0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0x48
	.4byte	0x2d95
	.uleb128 0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0x48
	.4byte	0x2da1
	.uleb128 0x2
	.byte	0x91
	.sleb128 12
	.uleb128 0x2c
	.4byte	0x2dad
	.4byte	.LLST19
	.4byte	.LVUS19
	.uleb128 0x2c
	.4byte	0x2db9
	.4byte	.LLST20
	.4byte	.LVUS20
	.uleb128 0x2c
	.4byte	0x2dc4
	.4byte	.LLST21
	.4byte	.LVUS21
	.uleb128 0x2e
	.4byte	.LVL42
	.4byte	0x3481
	.4byte	0x31c1
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC2
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x4
	.byte	0x76
	.sleb128 0
	.byte	0x38
	.byte	0x24
	.byte	0
	.uleb128 0x30
	.4byte	.LVL43
	.4byte	0x3438
	.uleb128 0x2e
	.4byte	.LVL44
	.4byte	0x34bf
	.4byte	0x31dd
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL47
	.4byte	0x34cc
	.4byte	0x31f3
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x4
	.byte	0x75
	.sleb128 0
	.byte	0x31
	.byte	0x24
	.byte	0
	.uleb128 0x30
	.4byte	.LVL50
	.4byte	0x34cc
	.uleb128 0x2e
	.4byte	.LVL55
	.4byte	0x345e
	.4byte	0x322b
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC1
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x6d
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL56
	.4byte	0x345e
	.4byte	0x325a
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC3
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x94
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.byte	0
	.uleb128 0x2e
	.4byte	.LVL57
	.4byte	0x345e
	.4byte	0x3289
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC4
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x9c
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.byte	0
	.uleb128 0x31
	.4byte	.LVL60
	.4byte	0x345e
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC5
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0x67
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0
	.byte	0
	.byte	0
	.uleb128 0x45
	.4byte	0x2ccf
	.4byte	.LFB62
	.4byte	.LFE62-.LFB62
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x32eb
	.uleb128 0x2a
	.4byte	0x2cdc
	.4byte	.LLST23
	.4byte	.LVUS23
	.uleb128 0x48
	.4byte	0x2ce7
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x48
	.4byte	0x2cf1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x48
	.4byte	0x2cfb
	.uleb128 0x1
	.byte	0x53
	.byte	0
	.uleb128 0x45
	.4byte	0x29d9
	.4byte	.LFB64
	.4byte	.LFE64-.LFB64
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x3438
	.uleb128 0x2a
	.4byte	0x29e6
	.4byte	.LLST42
	.4byte	.LVUS42
	.uleb128 0x2c
	.4byte	0x29f2
	.4byte	.LLST43
	.4byte	.LVUS43
	.uleb128 0x2c
	.4byte	0x29fd
	.4byte	.LLST44
	.4byte	.LVUS44
	.uleb128 0x2d
	.4byte	0x2a08
	.uleb128 0x2c
	.4byte	0x2a14
	.4byte	.LLST45
	.4byte	.LVUS45
	.uleb128 0x2c
	.4byte	0x2a20
	.4byte	.LLST46
	.4byte	.LVUS46
	.uleb128 0x2c
	.4byte	0x2a2c
	.4byte	.LLST47
	.4byte	.LVUS47
	.uleb128 0x2c
	.4byte	0x2a37
	.4byte	.LLST48
	.4byte	.LVUS48
	.uleb128 0x2c
	.4byte	0x2a42
	.4byte	.LLST49
	.4byte	.LVUS49
	.uleb128 0x2c
	.4byte	0x2a4d
	.4byte	.LLST50
	.4byte	.LVUS50
	.uleb128 0x2c
	.4byte	0x2a57
	.4byte	.LLST51
	.4byte	.LVUS51
	.uleb128 0x2c
	.4byte	0x2a63
	.4byte	.LLST52
	.4byte	.LVUS52
	.uleb128 0x2c
	.4byte	0x2a6f
	.4byte	.LLST53
	.4byte	.LVUS53
	.uleb128 0x2c
	.4byte	0x2a79
	.4byte	.LLST54
	.4byte	.LVUS54
	.uleb128 0x2c
	.4byte	0x2a85
	.4byte	.LLST55
	.4byte	.LVUS55
	.uleb128 0x2c
	.4byte	0x2a8f
	.4byte	.LLST56
	.4byte	.LVUS56
	.uleb128 0x2c
	.4byte	0x2a99
	.4byte	.LLST57
	.4byte	.LVUS57
	.uleb128 0x2c
	.4byte	0x2aa3
	.4byte	.LLST58
	.4byte	.LVUS58
	.uleb128 0x2c
	.4byte	0x2aaf
	.4byte	.LLST59
	.4byte	.LVUS59
	.uleb128 0x2c
	.4byte	0x2abb
	.4byte	.LLST60
	.4byte	.LVUS60
	.uleb128 0x2d
	.4byte	0x2ac7
	.uleb128 0x2c
	.4byte	0x2ad3
	.4byte	.LLST61
	.4byte	.LVUS61
	.uleb128 0x31
	.4byte	.LVL152
	.4byte	0x345e
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC6
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0x3
	.4byte	.LC0
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x8
	.byte	0xfe
	.uleb128 0x2f
	.uleb128 0x1
	.byte	0x53
	.uleb128 0x5
	.byte	0x3
	.4byte	.LANCHOR0+48
	.byte	0
	.byte	0
	.uleb128 0x4b
	.4byte	.LASF604
	.4byte	.LASF604
	.byte	0x45
	.2byte	0x233
	.byte	0xd
	.uleb128 0x4b
	.4byte	.LASF605
	.4byte	.LASF605
	.byte	0x45
	.2byte	0x1c5
	.byte	0xc
	.uleb128 0x4c
	.ascii	"sin\000"
	.ascii	"sin\000"
	.byte	0x47
	.byte	0x40
	.byte	0x1
	.uleb128 0x4d
	.4byte	.LASF606
	.4byte	.LASF606
	.byte	0x46
	.byte	0x45
	.byte	0xd
	.uleb128 0x4e
	.4byte	.LASF610
	.4byte	.LASF612
	.byte	0x48
	.byte	0
	.uleb128 0x4c
	.ascii	"pow\000"
	.ascii	"pow\000"
	.byte	0x47
	.byte	0x8c
	.byte	0x1
	.uleb128 0x4b
	.4byte	.LASF607
	.4byte	.LASF607
	.byte	0x6
	.2byte	0x14c
	.byte	0xc
	.uleb128 0x4b
	.4byte	.LASF608
	.4byte	.LASF609
	.byte	0x6
	.2byte	0x101
	.byte	0xe
	.uleb128 0x4e
	.4byte	.LASF611
	.4byte	.LASF613
	.byte	0x48
	.byte	0
	.uleb128 0x4b
	.4byte	.LASF614
	.4byte	.LASF614
	.byte	0x6
	.2byte	0x146
	.byte	0xc
	.uleb128 0x4d
	.4byte	.LASF615
	.4byte	.LASF615
	.byte	0x6
	.byte	0xd5
	.byte	0xc
	.uleb128 0x4b
	.4byte	.LASF616
	.4byte	.LASF616
	.byte	0x45
	.2byte	0x21d
	.byte	0xe
	.uleb128 0x4b
	.4byte	.LASF617
	.4byte	.LASF617
	.byte	0x45
	.2byte	0x21b
	.byte	0xe
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x1d
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x34
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x36
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0x5
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x37
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x38
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x39
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3f
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x40
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x41
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x42
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x43
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x44
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x45
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x46
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x47
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x48
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x49
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x4a
	.uleb128 0x2e
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x4b
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4c
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4d
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x4e
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LVUS124:
	.uleb128 0
	.uleb128 .LVU1051
	.uleb128 .LVU1051
	.uleb128 0
.LLST124:
	.4byte	.LVL284
	.4byte	.LVL285-1
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL285-1
	.4byte	.LFE73
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS125:
	.uleb128 0
	.uleb128 .LVU1051
	.uleb128 .LVU1051
	.uleb128 0
.LLST125:
	.4byte	.LVL284
	.4byte	.LVL285-1
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL285-1
	.4byte	.LFE73
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS126:
	.uleb128 .LVU1056
	.uleb128 .LVU1059
	.uleb128 .LVU1059
	.uleb128 .LVU1128
.LLST126:
	.4byte	.LVL288
	.4byte	.LVL289
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL289
	.4byte	.LVL310
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LVUS127:
	.uleb128 .LVU1054
	.uleb128 .LVU1056
.LLST127:
	.4byte	.LVL287
	.4byte	.LVL288
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS128:
	.uleb128 .LVU1063
	.uleb128 .LVU1123
.LLST128:
	.4byte	.LVL290
	.4byte	.LVL306
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LVUS129:
	.uleb128 .LVU1063
	.uleb128 .LVU1075
	.uleb128 .LVU1075
	.uleb128 .LVU1123
.LLST129:
	.4byte	.LVL290
	.4byte	.LVL292
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL292
	.4byte	.LVL306
	.2byte	0x3
	.byte	0x76
	.sleb128 4
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS130:
	.uleb128 .LVU1081
	.uleb128 .LVU1084
	.uleb128 .LVU1084
	.uleb128 .LVU1110
	.uleb128 .LVU1110
	.uleb128 .LVU1120
	.uleb128 .LVU1120
	.uleb128 .LVU1121
.LLST130:
	.4byte	.LVL293
	.4byte	.LVL296
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL296
	.4byte	.LVL301
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL301
	.4byte	.LVL303
	.2byte	0x3
	.byte	0x72
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL303
	.4byte	.LVL304
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LVUS131:
	.uleb128 .LVU1087
	.uleb128 .LVU1095
	.uleb128 .LVU1095
	.uleb128 .LVU1105
	.uleb128 .LVU1105
	.uleb128 .LVU1114
	.uleb128 .LVU1114
	.uleb128 .LVU1120
	.uleb128 .LVU1120
	.uleb128 .LVU1121
.LLST131:
	.4byte	.LVL297
	.4byte	.LVL298
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL298
	.4byte	.LVL300
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.4byte	.LVL300
	.4byte	.LVL302
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.4byte	.LVL302
	.4byte	.LVL303
	.2byte	0x2
	.byte	0x33
	.byte	0x9f
	.4byte	.LVL303
	.4byte	.LVL304
	.2byte	0x2
	.byte	0x34
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS132:
	.uleb128 .LVU1073
	.uleb128 .LVU1075
	.uleb128 .LVU1075
	.uleb128 .LVU1123
.LLST132:
	.4byte	.LVL291
	.4byte	.LVL292
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL292
	.4byte	.LVL306
	.2byte	0x1
	.byte	0x5e
	.4byte	0
	.4byte	0
.LVUS133:
	.uleb128 .LVU1088
	.uleb128 .LVU1096
	.uleb128 .LVU1096
	.uleb128 .LVU1101
.LLST133:
	.4byte	.LVL297
	.4byte	.LVL298
	.2byte	0x6
	.byte	0x71
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	.LVL298
	.4byte	.LVL299
	.2byte	0x8
	.byte	0x71
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS134:
	.uleb128 .LVU1086
	.uleb128 .LVU1095
	.uleb128 .LVU1095
	.uleb128 .LVU1101
	.uleb128 .LVU1120
	.uleb128 .LVU1121
.LLST134:
	.4byte	.LVL297
	.4byte	.LVL298
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL298
	.4byte	.LVL299
	.2byte	0x5
	.byte	0x71
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x9f
	.4byte	.LVL303
	.4byte	.LVL304
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS135:
	.uleb128 .LVU1080
	.uleb128 .LVU1082
	.uleb128 .LVU1082
	.uleb128 .LVU1083
	.uleb128 .LVU1083
	.uleb128 .LVU1084
.LLST135:
	.4byte	.LVL293
	.4byte	.LVL294
	.2byte	0xb
	.byte	0x7c
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x76
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x4
	.byte	0x9f
	.4byte	.LVL294
	.4byte	.LVL295
	.2byte	0x12
	.byte	0x3
	.4byte	g_armwave_state+32
	.byte	0x6
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x7c
	.sleb128 0
	.byte	0x22
	.byte	0x76
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x4
	.byte	0x9f
	.4byte	.LVL295
	.4byte	.LVL296
	.2byte	0x16
	.byte	0x3
	.4byte	g_armwave_state+32
	.byte	0x6
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x3
	.4byte	g_armwave_state+20
	.byte	0x6
	.byte	0x22
	.byte	0x76
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x4
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS136:
	.uleb128 .LVU1072
	.uleb128 .LVU1125
.LLST136:
	.4byte	.LVL291
	.4byte	.LVL307
	.2byte	0x6
	.byte	0x73
	.sleb128 0
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS137:
	.uleb128 .LVU1089
	.uleb128 .LVU1094
	.uleb128 .LVU1097
	.uleb128 .LVU1104
	.uleb128 .LVU1107
	.uleb128 .LVU1110
	.uleb128 .LVU1110
	.uleb128 .LVU1113
	.uleb128 .LVU1113
	.uleb128 .LVU1116
.LLST137:
	.4byte	.LVL297
	.4byte	.LVL298
	.2byte	0x10
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL298
	.4byte	.LVL300
	.2byte	0x10
	.byte	0x72
	.sleb128 1
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL300
	.4byte	.LVL301
	.2byte	0x10
	.byte	0x72
	.sleb128 2
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL301
	.4byte	.LVL302
	.2byte	0x10
	.byte	0x72
	.sleb128 -2
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL302
	.4byte	.LVL302
	.2byte	0xc
	.byte	0x72
	.sleb128 -2
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS117:
	.uleb128 0
	.uleb128 .LVU974
	.uleb128 .LVU974
	.uleb128 .LVU1023
	.uleb128 .LVU1023
	.uleb128 0
.LLST117:
	.4byte	.LVL262
	.4byte	.LVL263
	.2byte	0x2
	.byte	0x90
	.uleb128 0x40
	.4byte	.LVL263
	.4byte	.LVL280
	.2byte	0x2
	.byte	0x90
	.uleb128 0x54
	.4byte	.LVL280
	.4byte	.LFE71
	.2byte	0x6
	.byte	0xf3
	.uleb128 0x3
	.byte	0xf5
	.uleb128 0x40
	.uleb128 0x25
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS118:
	.uleb128 .LVU1017
	.uleb128 0
.LLST118:
	.4byte	.LVL277
	.4byte	.LFE71
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS119:
	.uleb128 .LVU981
	.uleb128 .LVU987
	.uleb128 .LVU987
	.uleb128 .LVU1023
.LLST119:
	.4byte	.LVL267
	.4byte	.LVL270
	.2byte	0x2
	.byte	0x90
	.uleb128 0x4f
	.4byte	.LVL270
	.4byte	.LVL280
	.2byte	0x2
	.byte	0x90
	.uleb128 0x50
	.4byte	0
	.4byte	0
.LVUS120:
	.uleb128 .LVU964
	.uleb128 .LVU974
	.uleb128 .LVU974
	.uleb128 .LVU1007
	.uleb128 .LVU1008
	.uleb128 0
.LLST120:
	.4byte	.LVL262
	.4byte	.LVL263
	.2byte	0x6
	.byte	0x9e
	.uleb128 0x4
	.4byte	0x3f4ccccd
	.4byte	.LVL263
	.4byte	.LVL275
	.2byte	0x2
	.byte	0x90
	.uleb128 0x51
	.4byte	.LVL276
	.4byte	.LFE71
	.2byte	0x2
	.byte	0x90
	.uleb128 0x51
	.4byte	0
	.4byte	0
.LVUS121:
	.uleb128 .LVU964
	.uleb128 .LVU974
	.uleb128 .LVU1004
	.uleb128 .LVU1006
.LLST121:
	.4byte	.LVL262
	.4byte	.LVL263
	.2byte	0x6
	.byte	0x9e
	.uleb128 0x4
	.4byte	0x3f4ccccd
	.4byte	.LVL273
	.4byte	.LVL274
	.2byte	0x2
	.byte	0x90
	.uleb128 0x4f
	.4byte	0
	.4byte	0
.LVUS122:
	.uleb128 .LVU966
	.uleb128 .LVU974
.LLST122:
	.4byte	.LVL262
	.4byte	.LVL263
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS123:
	.uleb128 .LVU974
	.uleb128 .LVU976
	.uleb128 .LVU977
	.uleb128 .LVU1019
	.uleb128 .LVU1019
	.uleb128 .LVU1021
.LLST123:
	.4byte	.LVL263
	.4byte	.LVL264
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL266
	.4byte	.LVL278
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL278
	.4byte	.LVL279
	.2byte	0x9
	.byte	0x75
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1c
	.byte	0x23
	.uleb128 0x800
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS109:
	.uleb128 0
	.uleb128 .LVU907
	.uleb128 .LVU907
	.uleb128 0
.LLST109:
	.4byte	.LVL241
	.4byte	.LVL242
	.2byte	0x2
	.byte	0x90
	.uleb128 0x40
	.4byte	.LVL242
	.4byte	.LFE70
	.2byte	0x2
	.byte	0x90
	.uleb128 0x5b
	.4byte	0
	.4byte	0
.LVUS110:
	.uleb128 0
	.uleb128 .LVU907
	.uleb128 .LVU907
	.uleb128 .LVU958
	.uleb128 .LVU958
	.uleb128 0
.LLST110:
	.4byte	.LVL241
	.4byte	.LVL242
	.2byte	0x2
	.byte	0x90
	.uleb128 0x41
	.4byte	.LVL242
	.4byte	.LVL260
	.2byte	0x2
	.byte	0x90
	.uleb128 0x58
	.4byte	.LVL260
	.4byte	.LFE70
	.2byte	0x6
	.byte	0xf3
	.uleb128 0x3
	.byte	0xf5
	.uleb128 0x41
	.uleb128 0x25
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS111:
	.uleb128 .LVU942
	.uleb128 .LVU947
.LLST111:
	.4byte	.LVL255
	.4byte	.LVL256
	.2byte	0x29
	.byte	0x79
	.sleb128 0
	.byte	0xf7
	.uleb128 0x33
	.byte	0xf7
	.uleb128 0x25
	.byte	0xf5
	.uleb128 0x5a
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x5b
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x59
	.uleb128 0x25
	.byte	0x22
	.byte	0xf7
	.uleb128 0x2c
	.byte	0xf5
	.uleb128 0x40
	.uleb128 0x2c
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x5c
	.uleb128 0x25
	.byte	0xf4
	.uleb128 0x25
	.byte	0x4
	.4byte	0x3f800000
	.byte	0x22
	.byte	0xf7
	.uleb128 0x2c
	.byte	0x1e
	.byte	0xf7
	.uleb128 0x25
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS112:
	.uleb128 .LVU921
	.uleb128 .LVU927
	.uleb128 .LVU927
	.uleb128 .LVU933
	.uleb128 .LVU933
	.uleb128 .LVU958
.LLST112:
	.4byte	.LVL247
	.4byte	.LVL250
	.2byte	0x2
	.byte	0x90
	.uleb128 0x4f
	.4byte	.LVL250
	.4byte	.LVL252
	.2byte	0x2
	.byte	0x90
	.uleb128 0x5c
	.4byte	.LVL252
	.4byte	.LVL260
	.2byte	0xc
	.byte	0xf5
	.uleb128 0x5c
	.uleb128 0x25
	.byte	0xf4
	.uleb128 0x25
	.byte	0x4
	.4byte	0x3f800000
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS113:
	.uleb128 .LVU935
	.uleb128 .LVU938
.LLST113:
	.4byte	.LVL253
	.4byte	.LVL254
	.2byte	0x13
	.byte	0x70
	.sleb128 0
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0xf7
	.uleb128 0x33
	.byte	0xf7
	.uleb128 0x25
	.byte	0xf4
	.uleb128 0x25
	.byte	0x4
	.4byte	0x4ac7ff38
	.byte	0x1b
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS114:
	.uleb128 .LVU914
	.uleb128 .LVU916
	.uleb128 .LVU916
	.uleb128 .LVU955
	.uleb128 .LVU955
	.uleb128 .LVU958
	.uleb128 .LVU958
	.uleb128 .LVU959
.LLST114:
	.4byte	.LVL243
	.4byte	.LVL244
	.2byte	0xc
	.byte	0xf5
	.uleb128 0x4f
	.uleb128 0x25
	.byte	0xf5
	.uleb128 0x5b
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x59
	.uleb128 0x25
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL244
	.4byte	.LVL259
	.2byte	0x13
	.byte	0x79
	.sleb128 0
	.byte	0xf7
	.uleb128 0x33
	.byte	0xf7
	.uleb128 0x25
	.byte	0xf5
	.uleb128 0x5a
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x5b
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x59
	.uleb128 0x25
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL259
	.4byte	.LVL260
	.2byte	0x13
	.byte	0x79
	.sleb128 -1
	.byte	0xf7
	.uleb128 0x33
	.byte	0xf7
	.uleb128 0x25
	.byte	0xf5
	.uleb128 0x5a
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x5b
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x59
	.uleb128 0x25
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL260
	.4byte	.LVL261
	.2byte	0x17
	.byte	0x79
	.sleb128 -1
	.byte	0xf7
	.uleb128 0x33
	.byte	0xf7
	.uleb128 0x25
	.byte	0xf4
	.uleb128 0x25
	.byte	0x4
	.4byte	0x3c800000
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x5b
	.uleb128 0x25
	.byte	0x1e
	.byte	0xf5
	.uleb128 0x59
	.uleb128 0x25
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS115:
	.uleb128 .LVU898
	.uleb128 .LVU907
	.uleb128 .LVU907
	.uleb128 .LVU959
.LLST115:
	.4byte	.LVL241
	.4byte	.LVL242
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL242
	.4byte	.LVL261
	.2byte	0x1
	.byte	0x59
	.4byte	0
	.4byte	0
.LVUS116:
	.uleb128 .LVU915
	.uleb128 .LVU916
	.uleb128 .LVU917
	.uleb128 .LVU952
	.uleb128 .LVU952
	.uleb128 .LVU953
.LLST116:
	.4byte	.LVL243
	.4byte	.LVL244
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL246
	.4byte	.LVL257
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL257
	.4byte	.LVL258
	.2byte	0x9
	.byte	0x75
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1c
	.byte	0x23
	.uleb128 0x800
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS108:
	.uleb128 0
	.uleb128 .LVU892
	.uleb128 .LVU892
	.uleb128 .LVU893
	.uleb128 .LVU893
	.uleb128 0
.LLST108:
	.4byte	.LVL238
	.4byte	.LVL239
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL239
	.4byte	.LVL240-1
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL240-1
	.4byte	.LFE69
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS86:
	.uleb128 0
	.uleb128 .LVU817
	.uleb128 .LVU817
	.uleb128 .LVU888
	.uleb128 .LVU888
	.uleb128 .LVU889
	.uleb128 .LVU889
	.uleb128 0
.LLST86:
	.4byte	.LVL206
	.4byte	.LVL210
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL210
	.4byte	.LVL235
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	.LVL235
	.4byte	.LVL236
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL236
	.4byte	.LFE68
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS87:
	.uleb128 .LVU796
	.uleb128 0
.LLST87:
	.4byte	.LVL207
	.4byte	.LFE68
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LVUS88:
	.uleb128 .LVU797
	.uleb128 0
.LLST88:
	.4byte	.LVL207
	.4byte	.LFE68
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LVUS89:
	.uleb128 .LVU872
	.uleb128 .LVU888
.LLST89:
	.4byte	.LVL228
	.4byte	.LVL235
	.2byte	0x1
	.byte	0x5a
	.4byte	0
	.4byte	0
.LVUS90:
	.uleb128 .LVU870
	.uleb128 .LVU888
.LLST90:
	.4byte	.LVL227
	.4byte	.LVL235
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LVUS91:
	.uleb128 .LVU868
	.uleb128 .LVU888
.LLST91:
	.4byte	.LVL227
	.4byte	.LVL235
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS92:
	.uleb128 .LVU819
	.uleb128 .LVU822
	.uleb128 .LVU824
	.uleb128 .LVU888
.LLST92:
	.4byte	.LVL211
	.4byte	.LVL213
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL214
	.4byte	.LVL235
	.2byte	0x1
	.byte	0x50
	.4byte	0
	.4byte	0
.LVUS93:
	.uleb128 .LVU840
	.uleb128 .LVU855
	.uleb128 .LVU859
	.uleb128 .LVU862
.LLST93:
	.4byte	.LVL219
	.4byte	.LVL221
	.2byte	0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL225
	.4byte	.LVL226
	.2byte	0x1
	.byte	0x5e
	.4byte	0
	.4byte	0
.LVUS94:
	.uleb128 .LVU841
	.uleb128 .LVU855
	.uleb128 .LVU856
	.uleb128 .LVU858
.LLST94:
	.4byte	.LVL219
	.4byte	.LVL221
	.2byte	0x9
	.byte	0x7e
	.sleb128 0
	.byte	0x7d
	.sleb128 0
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL222
	.4byte	.LVL224
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
.LVUS95:
	.uleb128 .LVU842
	.uleb128 .LVU854
	.uleb128 .LVU854
	.uleb128 .LVU857
.LLST95:
	.4byte	.LVL219
	.4byte	.LVL220
	.2byte	0x9
	.byte	0x7e
	.sleb128 0
	.byte	0x91
	.sleb128 -52
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL220
	.4byte	.LVL223
	.2byte	0x1
	.byte	0x5c
	.4byte	0
	.4byte	0
.LVUS96:
	.uleb128 .LVU811
	.uleb128 .LVU817
	.uleb128 .LVU821
	.uleb128 .LVU822
.LLST96:
	.4byte	.LVL209
	.4byte	.LVL210
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL212
	.4byte	.LVL213
	.2byte	0x1
	.byte	0x51
	.4byte	0
	.4byte	0
.LVUS97:
	.uleb128 .LVU869
	.uleb128 .LVU888
.LLST97:
	.4byte	.LVL227
	.4byte	.LVL235
	.2byte	0x1
	.byte	0x56
	.4byte	0
	.4byte	0
.LVUS98:
	.uleb128 .LVU809
	.uleb128 .LVU888
.LLST98:
	.4byte	.LVL209
	.4byte	.LVL235
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LVUS99:
	.uleb128 .LVU810
	.uleb128 .LVU817
.LLST99:
	.4byte	.LVL209
	.4byte	.LVL210
	.2byte	0x9
	.byte	0x3
	.4byte	g_armwave_state+64
	.byte	0x6
	.byte	0x38
	.byte	0x25
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS100:
	.uleb128 .LVU843
	.uleb128 .LVU855
.LLST100:
	.4byte	.LVL219
	.4byte	.LVL221
	.2byte	0x13
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS101:
	.uleb128 .LVU844
	.uleb128 .LVU855
.LLST101:
	.4byte	.LVL219
	.4byte	.LVL221
	.2byte	0x14
	.byte	0x7e
	.sleb128 0
	.byte	0x7d
	.sleb128 0
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS102:
	.uleb128 .LVU845
	.uleb128 .LVU855
.LLST102:
	.4byte	.LVL219
	.4byte	.LVL221
	.2byte	0x14
	.byte	0x7e
	.sleb128 0
	.byte	0x91
	.sleb128 -52
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS103:
	.uleb128 .LVU827
	.uleb128 .LVU829
	.uleb128 .LVU834
	.uleb128 .LVU837
.LLST103:
	.4byte	.LVL215
	.4byte	.LVL216
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL217
	.4byte	.LVL218
	.2byte	0x1
	.byte	0x50
	.4byte	0
	.4byte	0
.LVUS104:
	.uleb128 .LVU873
	.uleb128 .LVU876
	.uleb128 .LVU876
	.uleb128 .LVU881
	.uleb128 .LVU883
	.uleb128 .LVU888
.LLST104:
	.4byte	.LVL228
	.4byte	.LVL229
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL229
	.4byte	.LVL231
	.2byte	0x1
	.byte	0x5c
	.4byte	.LVL233
	.4byte	.LVL235
	.2byte	0x1
	.byte	0x5c
	.4byte	0
	.4byte	0
.LVUS105:
	.uleb128 .LVU804
	.uleb128 .LVU819
	.uleb128 .LVU819
	.uleb128 .LVU821
	.uleb128 .LVU821
	.uleb128 .LVU824
	.uleb128 .LVU824
	.uleb128 .LVU888
	.uleb128 .LVU888
	.uleb128 0
.LLST105:
	.4byte	.LVL208
	.4byte	.LVL211
	.2byte	0x1
	.byte	0x59
	.4byte	.LVL211
	.4byte	.LVL212
	.2byte	0x3
	.byte	0x79
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL212
	.4byte	.LVL214
	.2byte	0x1
	.byte	0x59
	.4byte	.LVL214
	.4byte	.LVL235
	.2byte	0x3
	.byte	0x79
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL235
	.4byte	.LFE68
	.2byte	0x1
	.byte	0x59
	.4byte	0
	.4byte	0
.LVUS106:
	.uleb128 .LVU805
	.uleb128 0
.LLST106:
	.4byte	.LVL208
	.4byte	.LFE68
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LVUS107:
	.uleb128 .LVU877
	.uleb128 .LVU880
	.uleb128 .LVU882
	.uleb128 .LVU886
.LLST107:
	.4byte	.LVL229
	.4byte	.LVL230
	.2byte	0x10
	.byte	0x77
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x22
	.byte	0x3
	.4byte	g_armwave_state+60
	.byte	0x6
	.byte	0x1e
	.byte	0x7a
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL232
	.4byte	.LVL234
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
.LVUS75:
	.uleb128 .LVU718
	.uleb128 .LVU721
	.uleb128 .LVU721
	.uleb128 0
.LLST75:
	.4byte	.LVL183
	.4byte	.LVL184
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL184
	.4byte	.LFE67
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LVUS76:
	.uleb128 .LVU725
	.uleb128 .LVU785
.LLST76:
	.4byte	.LVL185
	.4byte	.LVL202
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LVUS77:
	.uleb128 .LVU725
	.uleb128 .LVU736
	.uleb128 .LVU736
	.uleb128 .LVU785
.LLST77:
	.4byte	.LVL185
	.4byte	.LVL187
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL187
	.4byte	.LVL202
	.2byte	0x3
	.byte	0x76
	.sleb128 4
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS78:
	.uleb128 .LVU743
	.uleb128 .LVU746
	.uleb128 .LVU746
	.uleb128 .LVU772
	.uleb128 .LVU772
	.uleb128 .LVU782
	.uleb128 .LVU782
	.uleb128 .LVU783
.LLST78:
	.4byte	.LVL189
	.4byte	.LVL192
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL192
	.4byte	.LVL197
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL197
	.4byte	.LVL199
	.2byte	0x3
	.byte	0x72
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL199
	.4byte	.LVL200
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LVUS79:
	.uleb128 .LVU749
	.uleb128 .LVU757
	.uleb128 .LVU757
	.uleb128 .LVU767
	.uleb128 .LVU767
	.uleb128 .LVU776
	.uleb128 .LVU776
	.uleb128 .LVU782
	.uleb128 .LVU782
	.uleb128 .LVU783
.LLST79:
	.4byte	.LVL193
	.4byte	.LVL194
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL194
	.4byte	.LVL196
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.4byte	.LVL196
	.4byte	.LVL198
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.4byte	.LVL198
	.4byte	.LVL199
	.2byte	0x2
	.byte	0x33
	.byte	0x9f
	.4byte	.LVL199
	.4byte	.LVL200
	.2byte	0x2
	.byte	0x34
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS80:
	.uleb128 .LVU735
	.uleb128 .LVU737
	.uleb128 .LVU737
	.uleb128 .LVU785
.LLST80:
	.4byte	.LVL186
	.4byte	.LVL188
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL188
	.4byte	.LVL202
	.2byte	0x1
	.byte	0x5e
	.4byte	0
	.4byte	0
.LVUS81:
	.uleb128 .LVU750
	.uleb128 .LVU758
	.uleb128 .LVU758
	.uleb128 .LVU763
.LLST81:
	.4byte	.LVL193
	.4byte	.LVL194
	.2byte	0x6
	.byte	0x71
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	.LVL194
	.4byte	.LVL195
	.2byte	0x8
	.byte	0x71
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS82:
	.uleb128 .LVU748
	.uleb128 .LVU757
	.uleb128 .LVU757
	.uleb128 .LVU763
	.uleb128 .LVU782
	.uleb128 .LVU783
.LLST82:
	.4byte	.LVL193
	.4byte	.LVL194
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL194
	.4byte	.LVL195
	.2byte	0x5
	.byte	0x71
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x9f
	.4byte	.LVL199
	.4byte	.LVL200
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS83:
	.uleb128 .LVU742
	.uleb128 .LVU744
	.uleb128 .LVU744
	.uleb128 .LVU745
	.uleb128 .LVU745
	.uleb128 .LVU746
.LLST83:
	.4byte	.LVL189
	.4byte	.LVL190
	.2byte	0xb
	.byte	0x7c
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x22
	.byte	0x76
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x4
	.byte	0x9f
	.4byte	.LVL190
	.4byte	.LVL191
	.2byte	0x12
	.byte	0x3
	.4byte	g_armwave_state+32
	.byte	0x6
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x7c
	.sleb128 0
	.byte	0x22
	.byte	0x76
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x4
	.byte	0x9f
	.4byte	.LVL191
	.4byte	.LVL192
	.2byte	0x16
	.byte	0x3
	.4byte	g_armwave_state+32
	.byte	0x6
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x3
	.4byte	g_armwave_state+20
	.byte	0x6
	.byte	0x22
	.byte	0x76
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x4
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS84:
	.uleb128 .LVU734
	.uleb128 .LVU787
.LLST84:
	.4byte	.LVL186
	.4byte	.LVL203
	.2byte	0x6
	.byte	0x73
	.sleb128 0
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS85:
	.uleb128 .LVU751
	.uleb128 .LVU756
	.uleb128 .LVU759
	.uleb128 .LVU766
	.uleb128 .LVU769
	.uleb128 .LVU772
	.uleb128 .LVU772
	.uleb128 .LVU775
	.uleb128 .LVU775
	.uleb128 .LVU778
.LLST85:
	.4byte	.LVL193
	.4byte	.LVL194
	.2byte	0x10
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL194
	.4byte	.LVL196
	.2byte	0x10
	.byte	0x72
	.sleb128 1
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL196
	.4byte	.LVL197
	.2byte	0x10
	.byte	0x72
	.sleb128 2
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL197
	.4byte	.LVL198
	.2byte	0x10
	.byte	0x72
	.sleb128 -2
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL198
	.4byte	.LVL198
	.2byte	0xc
	.byte	0x72
	.sleb128 -2
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x70
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS68:
	.uleb128 0
	.uleb128 .LVU684
	.uleb128 .LVU684
	.uleb128 .LVU711
	.uleb128 .LVU711
	.uleb128 0
.LLST68:
	.4byte	.LVL174
	.4byte	.LVL175
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL175
	.4byte	.LVL181
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL181
	.4byte	.LFE66
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS69:
	.uleb128 0
	.uleb128 .LVU684
	.uleb128 .LVU684
	.uleb128 .LVU711
	.uleb128 .LVU711
	.uleb128 0
.LLST69:
	.4byte	.LVL174
	.4byte	.LVL175
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL175
	.4byte	.LVL181
	.2byte	0x1
	.byte	0x57
	.4byte	.LVL181
	.4byte	.LFE66
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS70:
	.uleb128 .LVU678
	.uleb128 .LVU684
	.uleb128 .LVU684
	.uleb128 .LVU692
.LLST70:
	.4byte	.LVL174
	.4byte	.LVL175
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL175
	.4byte	.LVL178
	.2byte	0x9
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.4byte	gamma_table-1
	.byte	0x1c
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS71:
	.uleb128 .LVU694
	.uleb128 .LVU705
.LLST71:
	.4byte	.LVL178
	.4byte	.LVL179
	.2byte	0x3
	.byte	0x8
	.byte	0xfa
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS72:
	.uleb128 .LVU694
	.uleb128 .LVU705
.LLST72:
	.4byte	.LVL178
	.4byte	.LVL179
	.2byte	0x4
	.byte	0xa
	.2byte	0x6f4
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS73:
	.uleb128 .LVU694
	.uleb128 .LVU705
.LLST73:
	.4byte	.LVL178
	.4byte	.LVL179
	.2byte	0x4
	.byte	0xa
	.2byte	0x9f6
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS74:
	.uleb128 .LVU694
	.uleb128 .LVU705
.LLST74:
	.4byte	.LVL178
	.4byte	.LVL179
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS62:
	.uleb128 0
	.uleb128 .LVU638
	.uleb128 .LVU638
	.uleb128 .LVU672
	.uleb128 .LVU672
	.uleb128 .LVU673
	.uleb128 .LVU673
	.uleb128 0
.LLST62:
	.4byte	.LVL153
	.4byte	.LVL155
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL155
	.4byte	.LVL171
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL171
	.4byte	.LVL172
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	.LVL172
	.4byte	.LFE65
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LVUS63:
	.uleb128 0
	.uleb128 .LVU637
	.uleb128 .LVU637
	.uleb128 .LVU639
	.uleb128 .LVU639
	.uleb128 0
.LLST63:
	.4byte	.LVL153
	.4byte	.LVL154
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL154
	.4byte	.LVL156-1
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL156-1
	.4byte	.LFE65
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS64:
	.uleb128 .LVU642
	.uleb128 .LVU645
	.uleb128 .LVU645
	.uleb128 .LVU646
	.uleb128 .LVU646
	.uleb128 .LVU672
	.uleb128 .LVU672
	.uleb128 .LVU673
	.uleb128 .LVU673
	.uleb128 0
.LLST64:
	.4byte	.LVL157
	.4byte	.LVL158
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL158
	.4byte	.LVL159-1
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL159-1
	.4byte	.LVL171
	.2byte	0x1
	.byte	0x57
	.4byte	.LVL171
	.4byte	.LVL172-1
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL172
	.4byte	.LFE65
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LVUS65:
	.uleb128 .LVU660
	.uleb128 .LVU665
.LLST65:
	.4byte	.LVL164
	.4byte	.LVL166
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LVUS66:
	.uleb128 .LVU653
	.uleb128 .LVU656
	.uleb128 .LVU656
	.uleb128 .LVU662
	.uleb128 .LVU662
	.uleb128 .LVU666
	.uleb128 .LVU666
	.uleb128 .LVU668
	.uleb128 .LVU673
	.uleb128 0
.LLST66:
	.4byte	.LVL162
	.4byte	.LVL163
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL163
	.4byte	.LVL165
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL165
	.4byte	.LVL167
	.2byte	0x3
	.byte	0x74
	.sleb128 -1
	.byte	0x9f
	.4byte	.LVL167
	.4byte	.LVL168
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL172
	.4byte	.LFE65
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS67:
	.uleb128 .LVU649
	.uleb128 .LVU653
	.uleb128 .LVU653
	.uleb128 .LVU670
	.uleb128 .LVU673
	.uleb128 0
.LLST67:
	.4byte	.LVL161
	.4byte	.LVL162
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL162
	.4byte	.LVL170
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL172
	.4byte	.LFE65
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LVUS24:
	.uleb128 0
	.uleb128 .LVU350
	.uleb128 .LVU350
	.uleb128 .LVU356
	.uleb128 .LVU356
	.uleb128 .LVU357
	.uleb128 .LVU357
	.uleb128 .LVU531
	.uleb128 .LVU531
	.uleb128 .LVU533
	.uleb128 .LVU533
	.uleb128 0
.LLST24:
	.4byte	.LVL66
	.4byte	.LVL69
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL69
	.4byte	.LVL73
	.2byte	0x2
	.byte	0x7d
	.sleb128 0
	.4byte	.LVL73
	.4byte	.LVL74
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	.LVL74
	.4byte	.LVL116
	.2byte	0x2
	.byte	0x7d
	.sleb128 0
	.4byte	.LVL116
	.4byte	.LVL118
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL118
	.4byte	.LFE63
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS25:
	.uleb128 .LVU372
	.uleb128 .LVU400
.LLST25:
	.4byte	.LVL76
	.4byte	.LVL85
	.2byte	0x6
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS26:
	.uleb128 .LVU373
	.uleb128 .LVU394
	.uleb128 .LVU394
	.uleb128 .LVU400
.LLST26:
	.4byte	.LVL76
	.4byte	.LVL84
	.2byte	0x5
	.byte	0x73
	.sleb128 0
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL84
	.4byte	.LVL85
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LVUS27:
	.uleb128 .LVU370
	.uleb128 .LVU378
	.uleb128 .LVU378
	.uleb128 .LVU380
	.uleb128 .LVU380
	.uleb128 .LVU381
	.uleb128 .LVU381
	.uleb128 .LVU382
	.uleb128 .LVU382
	.uleb128 .LVU383
	.uleb128 .LVU383
	.uleb128 .LVU384
	.uleb128 .LVU384
	.uleb128 .LVU393
	.uleb128 .LVU393
	.uleb128 .LVU400
	.uleb128 .LVU413
	.uleb128 .LVU417
	.uleb128 .LVU417
	.uleb128 .LVU418
	.uleb128 .LVU418
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU420
	.uleb128 .LVU420
	.uleb128 .LVU428
	.uleb128 .LVU428
	.uleb128 .LVU431
	.uleb128 .LVU431
	.uleb128 .LVU437
	.uleb128 .LVU437
	.uleb128 .LVU445
	.uleb128 .LVU458
	.uleb128 .LVU462
	.uleb128 .LVU462
	.uleb128 .LVU463
	.uleb128 .LVU463
	.uleb128 .LVU465
	.uleb128 .LVU465
	.uleb128 .LVU466
	.uleb128 .LVU466
	.uleb128 .LVU467
	.uleb128 .LVU467
	.uleb128 .LVU473
	.uleb128 .LVU473
	.uleb128 .LVU476
	.uleb128 .LVU500
	.uleb128 .LVU504
	.uleb128 .LVU504
	.uleb128 .LVU505
.LLST27:
	.4byte	.LVL76
	.4byte	.LVL77
	.2byte	0x4e
	.byte	0x76
	.sleb128 0
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x76
	.sleb128 0
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL77
	.4byte	.LVL78
	.2byte	0x49
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x76
	.sleb128 0
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL78
	.4byte	.LVL79
	.2byte	0x44
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x78
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL79
	.4byte	.LVL80
	.2byte	0x49
	.byte	0x76
	.sleb128 0
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x78
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL80
	.4byte	.LVL81
	.2byte	0x4f
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x78
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL81
	.4byte	.LVL82
	.2byte	0x57
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL82
	.4byte	.LVL83
	.2byte	0x4f
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x76
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL83
	.4byte	.LVL85
	.2byte	0x57
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL88
	.4byte	.LVL89
	.2byte	0x4e
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL89
	.4byte	.LVL90
	.2byte	0x49
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL90
	.4byte	.LVL91
	.2byte	0x4e
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL91
	.4byte	.LVL92
	.2byte	0x5d
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL92
	.4byte	.LVL93
	.2byte	0x53
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x77
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL93
	.4byte	.LVL94
	.2byte	0x5d
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL94
	.4byte	.LVL95
	.2byte	0x53
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7e
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL95
	.4byte	.LVL96
	.2byte	0x5d
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL98
	.4byte	.LVL99
	.2byte	0x4e
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL99
	.4byte	.LVL100
	.2byte	0x49
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL100
	.4byte	.LVL101
	.2byte	0x4f
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL101
	.4byte	.LVL102
	.2byte	0x47
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x76
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL102
	.4byte	.LVL103
	.2byte	0x4f
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x76
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL103
	.4byte	.LVL104
	.2byte	0x57
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL104
	.4byte	.LVL105
	.2byte	0x4f
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7e
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL108
	.4byte	.LVL109
	.2byte	0x4e
	.byte	0x7b
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	.LVL109
	.4byte	.LVL110
	.2byte	0x49
	.byte	0x7e
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x40
	.byte	0x24
	.byte	0x8
	.byte	0xff
	.byte	0x40
	.byte	0x24
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x38
	.byte	0x24
	.byte	0xa
	.2byte	0xffff
	.byte	0x1a
	.byte	0x21
	.byte	0x7a
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x21
	.byte	0x40
	.byte	0x44
	.byte	0x24
	.byte	0x1f
	.byte	0x21
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS28:
	.uleb128 .LVU352
	.uleb128 .LVU354
	.uleb128 .LVU357
	.uleb128 .LVU361
	.uleb128 .LVU361
	.uleb128 .LVU403
	.uleb128 .LVU403
	.uleb128 .LVU404
	.uleb128 .LVU404
	.uleb128 .LVU449
	.uleb128 .LVU449
	.uleb128 .LVU491
	.uleb128 .LVU491
	.uleb128 .LVU531
.LLST28:
	.4byte	.LVL70
	.4byte	.LVL71
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL74
	.4byte	.LVL75
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL75
	.4byte	.LVL86
	.2byte	0x1
	.byte	0x5e
	.4byte	.LVL86
	.4byte	.LVL87
	.2byte	0x5
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x9f
	.4byte	.LVL87
	.4byte	.LVL97
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL97
	.4byte	.LVL107
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL107
	.4byte	.LVL116
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS29:
	.uleb128 .LVU364
	.uleb128 .LVU382
	.uleb128 .LVU382
	.uleb128 .LVU384
	.uleb128 .LVU384
	.uleb128 .LVU393
	.uleb128 .LVU393
	.uleb128 .LVU400
	.uleb128 .LVU407
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU431
	.uleb128 .LVU431
	.uleb128 .LVU437
	.uleb128 .LVU437
	.uleb128 .LVU445
	.uleb128 .LVU452
	.uleb128 .LVU463
	.uleb128 .LVU463
	.uleb128 .LVU473
	.uleb128 .LVU473
	.uleb128 .LVU479
	.uleb128 .LVU494
	.uleb128 .LVU505
	.uleb128 .LVU515
	.uleb128 .LVU521
.LLST29:
	.4byte	.LVL76
	.4byte	.LVL80
	.2byte	0x8
	.byte	0x7a
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL80
	.4byte	.LVL82
	.2byte	0xb
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL82
	.4byte	.LVL83
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL83
	.4byte	.LVL85
	.2byte	0xb
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL88
	.4byte	.LVL91
	.2byte	0x8
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL91
	.4byte	.LVL94
	.2byte	0xd
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL94
	.4byte	.LVL95
	.2byte	0x1
	.byte	0x5e
	.4byte	.LVL95
	.4byte	.LVL96
	.2byte	0xd
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL98
	.4byte	.LVL100
	.2byte	0x8
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL100
	.4byte	.LVL104
	.2byte	0xb
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL104
	.4byte	.LVL106
	.2byte	0x1
	.byte	0x5e
	.4byte	.LVL108
	.4byte	.LVL110
	.2byte	0x8
	.byte	0x7a
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL114
	.4byte	.LVL115
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LVUS30:
	.uleb128 .LVU365
	.uleb128 .LVU380
	.uleb128 .LVU380
	.uleb128 .LVU383
	.uleb128 .LVU383
	.uleb128 .LVU400
	.uleb128 .LVU408
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU420
	.uleb128 .LVU420
	.uleb128 .LVU428
	.uleb128 .LVU428
	.uleb128 .LVU445
	.uleb128 .LVU453
	.uleb128 .LVU463
	.uleb128 .LVU463
	.uleb128 .LVU465
	.uleb128 .LVU465
	.uleb128 .LVU467
	.uleb128 .LVU467
	.uleb128 .LVU476
	.uleb128 .LVU495
	.uleb128 .LVU505
	.uleb128 .LVU507
	.uleb128 .LVU509
.LLST30:
	.4byte	.LVL76
	.4byte	.LVL78
	.2byte	0x8
	.byte	0x76
	.sleb128 0
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL78
	.4byte	.LVL81
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL81
	.4byte	.LVL85
	.2byte	0xb
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL88
	.4byte	.LVL91
	.2byte	0x8
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL91
	.4byte	.LVL92
	.2byte	0xd
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL92
	.4byte	.LVL93
	.2byte	0x1
	.byte	0x57
	.4byte	.LVL93
	.4byte	.LVL96
	.2byte	0xd
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL98
	.4byte	.LVL100
	.2byte	0x8
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL100
	.4byte	.LVL101
	.2byte	0xb
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL101
	.4byte	.LVL103
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL103
	.4byte	.LVL105
	.2byte	0xb
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL108
	.4byte	.LVL110
	.2byte	0x8
	.byte	0x79
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL111
	.4byte	.LVL113
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
.LVUS31:
	.uleb128 .LVU366
	.uleb128 .LVU378
	.uleb128 .LVU378
	.uleb128 .LVU381
	.uleb128 .LVU381
	.uleb128 .LVU382
	.uleb128 .LVU382
	.uleb128 .LVU400
	.uleb128 .LVU409
	.uleb128 .LVU417
	.uleb128 .LVU417
	.uleb128 .LVU418
	.uleb128 .LVU418
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU445
	.uleb128 .LVU454
	.uleb128 .LVU462
	.uleb128 .LVU462
	.uleb128 .LVU466
	.uleb128 .LVU466
	.uleb128 .LVU476
	.uleb128 .LVU496
	.uleb128 .LVU504
	.uleb128 .LVU504
	.uleb128 .LVU508
.LLST31:
	.4byte	.LVL76
	.4byte	.LVL77
	.2byte	0x8
	.byte	0x76
	.sleb128 0
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL77
	.4byte	.LVL79
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL79
	.4byte	.LVL80
	.2byte	0x8
	.byte	0x76
	.sleb128 0
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL80
	.4byte	.LVL85
	.2byte	0xb
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL88
	.4byte	.LVL89
	.2byte	0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL89
	.4byte	.LVL90
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL90
	.4byte	.LVL91
	.2byte	0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL91
	.4byte	.LVL96
	.2byte	0xd
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL98
	.4byte	.LVL99
	.2byte	0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL99
	.4byte	.LVL102
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL102
	.4byte	.LVL105
	.2byte	0xb
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL108
	.4byte	.LVL109
	.2byte	0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL109
	.4byte	.LVL112
	.2byte	0x1
	.byte	0x5e
	.4byte	0
	.4byte	0
.LVUS32:
	.uleb128 .LVU345
	.uleb128 .LVU350
	.uleb128 .LVU350
	.uleb128 .LVU356
	.uleb128 .LVU357
	.uleb128 .LVU531
.LLST32:
	.4byte	.LVL68
	.4byte	.LVL69
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL69
	.4byte	.LVL73
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL74
	.4byte	.LVL116
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS33:
	.uleb128 .LVU371
	.uleb128 .LVU400
.LLST33:
	.4byte	.LVL76
	.4byte	.LVL85
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS34:
	.uleb128 .LVU344
	.uleb128 .LVU531
.LLST34:
	.4byte	.LVL68
	.4byte	.LVL116
	.2byte	0x1
	.byte	0x5c
	.4byte	0
	.4byte	0
.LVUS35:
	.uleb128 .LVU357
	.uleb128 .LVU400
	.uleb128 .LVU400
	.uleb128 .LVU445
	.uleb128 .LVU445
	.uleb128 .LVU489
	.uleb128 .LVU489
	.uleb128 .LVU531
.LLST35:
	.4byte	.LVL74
	.4byte	.LVL85
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL85
	.4byte	.LVL96
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.4byte	.LVL96
	.4byte	.LVL107
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.4byte	.LVL107
	.4byte	.LVL116
	.2byte	0x2
	.byte	0x33
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS36:
	.uleb128 .LVU367
	.uleb128 .LVU382
	.uleb128 .LVU382
	.uleb128 .LVU400
	.uleb128 .LVU410
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU445
	.uleb128 .LVU455
	.uleb128 .LVU463
	.uleb128 .LVU463
	.uleb128 .LVU476
	.uleb128 .LVU497
	.uleb128 .LVU505
.LLST36:
	.4byte	.LVL76
	.4byte	.LVL80
	.2byte	0x13
	.byte	0x7a
	.sleb128 0
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL80
	.4byte	.LVL85
	.2byte	0x16
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL88
	.4byte	.LVL91
	.2byte	0x13
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL91
	.4byte	.LVL96
	.2byte	0x18
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL98
	.4byte	.LVL100
	.2byte	0x13
	.byte	0x7a
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL100
	.4byte	.LVL105
	.2byte	0x16
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7a
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL108
	.4byte	.LVL110
	.2byte	0x13
	.byte	0x7a
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS37:
	.uleb128 .LVU368
	.uleb128 .LVU380
	.uleb128 .LVU380
	.uleb128 .LVU383
	.uleb128 .LVU383
	.uleb128 .LVU400
	.uleb128 .LVU411
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU420
	.uleb128 .LVU420
	.uleb128 .LVU428
	.uleb128 .LVU428
	.uleb128 .LVU445
	.uleb128 .LVU456
	.uleb128 .LVU463
	.uleb128 .LVU463
	.uleb128 .LVU465
	.uleb128 .LVU465
	.uleb128 .LVU467
	.uleb128 .LVU467
	.uleb128 .LVU476
	.uleb128 .LVU498
	.uleb128 .LVU505
	.uleb128 .LVU507
	.uleb128 .LVU509
.LLST37:
	.4byte	.LVL76
	.4byte	.LVL78
	.2byte	0x13
	.byte	0x76
	.sleb128 0
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL78
	.4byte	.LVL81
	.2byte	0xe
	.byte	0x78
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL81
	.4byte	.LVL85
	.2byte	0x16
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL88
	.4byte	.LVL91
	.2byte	0x13
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL91
	.4byte	.LVL92
	.2byte	0x18
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL92
	.4byte	.LVL93
	.2byte	0xe
	.byte	0x77
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL93
	.4byte	.LVL96
	.2byte	0x18
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL98
	.4byte	.LVL100
	.2byte	0x13
	.byte	0x79
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL100
	.4byte	.LVL101
	.2byte	0x16
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL101
	.4byte	.LVL103
	.2byte	0xe
	.byte	0x76
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL103
	.4byte	.LVL105
	.2byte	0x16
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x79
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL108
	.4byte	.LVL110
	.2byte	0x13
	.byte	0x79
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL111
	.4byte	.LVL113
	.2byte	0xe
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS38:
	.uleb128 .LVU369
	.uleb128 .LVU378
	.uleb128 .LVU378
	.uleb128 .LVU381
	.uleb128 .LVU381
	.uleb128 .LVU382
	.uleb128 .LVU382
	.uleb128 .LVU400
	.uleb128 .LVU412
	.uleb128 .LVU417
	.uleb128 .LVU417
	.uleb128 .LVU418
	.uleb128 .LVU418
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU445
	.uleb128 .LVU457
	.uleb128 .LVU462
	.uleb128 .LVU462
	.uleb128 .LVU466
	.uleb128 .LVU466
	.uleb128 .LVU476
	.uleb128 .LVU499
	.uleb128 .LVU504
	.uleb128 .LVU504
	.uleb128 .LVU508
.LLST38:
	.4byte	.LVL76
	.4byte	.LVL77
	.2byte	0x13
	.byte	0x76
	.sleb128 0
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL77
	.4byte	.LVL79
	.2byte	0xe
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL79
	.4byte	.LVL80
	.2byte	0x13
	.byte	0x76
	.sleb128 0
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL80
	.4byte	.LVL85
	.2byte	0x16
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL88
	.4byte	.LVL89
	.2byte	0x13
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL89
	.4byte	.LVL90
	.2byte	0xe
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL90
	.4byte	.LVL91
	.2byte	0x13
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL91
	.4byte	.LVL96
	.2byte	0x18
	.byte	0x72
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL98
	.4byte	.LVL99
	.2byte	0x13
	.byte	0x7b
	.sleb128 0
	.byte	0x7e
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL99
	.4byte	.LVL102
	.2byte	0xe
	.byte	0x74
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL102
	.4byte	.LVL105
	.2byte	0x16
	.byte	0x78
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x7b
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL108
	.4byte	.LVL109
	.2byte	0x13
	.byte	0x7b
	.sleb128 0
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	.LVL109
	.4byte	.LVL112
	.2byte	0xe
	.byte	0x7e
	.sleb128 0
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS39:
	.uleb128 .LVU358
	.uleb128 .LVU401
	.uleb128 .LVU401
	.uleb128 .LVU403
	.uleb128 .LVU446
	.uleb128 .LVU476
	.uleb128 .LVU490
	.uleb128 .LVU505
.LLST39:
	.4byte	.LVL74
	.4byte	.LVL85
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL85
	.4byte	.LVL86
	.2byte	0x1
	.byte	0x5e
	.4byte	.LVL96
	.4byte	.LVL105
	.2byte	0x1
	.byte	0x58
	.4byte	.LVL107
	.4byte	.LVL110
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LVUS40:
	.uleb128 .LVU339
	.uleb128 .LVU352
	.uleb128 .LVU352
	.uleb128 .LVU355
	.uleb128 .LVU355
	.uleb128 .LVU357
	.uleb128 .LVU357
	.uleb128 .LVU531
	.uleb128 .LVU531
	.uleb128 .LVU532
	.uleb128 .LVU532
	.uleb128 .LVU534
.LLST40:
	.4byte	.LVL67
	.4byte	.LVL70
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL70
	.4byte	.LVL72
	.2byte	0x3
	.byte	0x71
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL72
	.4byte	.LVL74
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL74
	.4byte	.LVL116
	.2byte	0x3
	.byte	0x71
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL116
	.4byte	.LVL117
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL117
	.4byte	.LVL119-1
	.2byte	0x5
	.byte	0x3
	.4byte	g_armwave_state+4
	.4byte	0
	.4byte	0
.LVUS41:
	.uleb128 .LVU374
	.uleb128 .LVU400
.LLST41:
	.4byte	.LVL76
	.4byte	.LVL85
	.2byte	0x12
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x3
	.4byte	g_armwave_state+60
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x38
	.byte	0x26
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS22:
	.uleb128 0
	.uleb128 .LVU317
	.uleb128 .LVU317
	.uleb128 0
.LLST22:
	.4byte	.LVL61
	.4byte	.LVL62
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL62
	.4byte	.LFE61
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU25
	.uleb128 .LVU25
	.uleb128 .LVU90
	.uleb128 .LVU90
	.uleb128 .LVU105
	.uleb128 .LVU105
	.uleb128 0
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL1
	.4byte	.LVL13
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL13
	.4byte	.LVL15
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL15
	.4byte	.LFE74
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LVUS1:
	.uleb128 0
	.uleb128 .LVU30
	.uleb128 .LVU30
	.uleb128 .LVU48
	.uleb128 .LVU48
	.uleb128 .LVU90
	.uleb128 .LVU90
	.uleb128 .LVU104
	.uleb128 .LVU104
	.uleb128 0
.LLST1:
	.4byte	.LVL0
	.4byte	.LVL2
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL2
	.4byte	.LVL3-1
	.2byte	0x5
	.byte	0x3
	.4byte	g_armwave_state+24
	.4byte	.LVL3-1
	.4byte	.LVL13
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	.LVL13
	.4byte	.LVL14
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL14
	.4byte	.LFE74
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS2:
	.uleb128 .LVU60
	.uleb128 .LVU90
	.uleb128 .LVU107
	.uleb128 0
.LLST2:
	.4byte	.LVL6
	.4byte	.LVL13
	.2byte	0x4
	.byte	0xa
	.2byte	0x800
	.byte	0x9f
	.4byte	.LVL17
	.4byte	.LFE74
	.2byte	0x4
	.byte	0xa
	.2byte	0x800
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS3:
	.uleb128 .LVU78
	.uleb128 .LVU87
.LLST3:
	.4byte	.LVL9
	.4byte	.LVL11-1
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS4:
	.uleb128 .LVU67
	.uleb128 .LVU88
	.uleb128 .LVU88
	.uleb128 .LVU90
	.uleb128 .LVU107
	.uleb128 0
.LLST4:
	.4byte	.LVL7
	.4byte	.LVL12
	.2byte	0x2
	.byte	0x90
	.uleb128 0x50
	.4byte	.LVL12
	.4byte	.LVL13
	.2byte	0xf
	.byte	0xf4
	.uleb128 0x25
	.byte	0x4
	.4byte	0x45000000
	.byte	0x75
	.sleb128 0
	.byte	0xf7
	.uleb128 0x3a
	.byte	0xf7
	.uleb128 0x25
	.byte	0x1b
	.byte	0x9f
	.4byte	.LVL17
	.4byte	.LFE74
	.2byte	0x2
	.byte	0x90
	.uleb128 0x50
	.4byte	0
	.4byte	0
.LVUS5:
	.uleb128 .LVU112
	.uleb128 .LVU116
	.uleb128 .LVU116
	.uleb128 .LVU125
.LLST5:
	.4byte	.LVL19
	.4byte	.LVL20
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL20
	.4byte	.LVL23
	.2byte	0x9
	.byte	0x74
	.sleb128 0
	.byte	0x3
	.4byte	gamma_table-1
	.byte	0x1c
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS6:
	.uleb128 0
	.uleb128 .LVU143
	.uleb128 .LVU143
	.uleb128 0
.LLST6:
	.4byte	.LVL24
	.4byte	.LVL26
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL26
	.4byte	.LFE58
	.2byte	0x3
	.byte	0x78
	.sleb128 4
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS7:
	.uleb128 .LVU145
	.uleb128 .LVU147
	.uleb128 .LVU147
	.uleb128 .LVU166
	.uleb128 .LVU166
	.uleb128 .LVU181
	.uleb128 .LVU181
	.uleb128 .LVU183
	.uleb128 .LVU183
	.uleb128 0
.LLST7:
	.4byte	.LVL26
	.4byte	.LVL27
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL27
	.4byte	.LVL31
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL31
	.4byte	.LVL34
	.2byte	0x3
	.byte	0x72
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL34
	.4byte	.LVL35
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL35
	.4byte	.LFE58
	.2byte	0x3
	.byte	0x79
	.sleb128 1
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS8:
	.uleb128 .LVU150
	.uleb128 .LVU158
	.uleb128 .LVU158
	.uleb128 .LVU168
	.uleb128 .LVU168
	.uleb128 .LVU175
	.uleb128 .LVU175
	.uleb128 .LVU181
	.uleb128 .LVU181
	.uleb128 0
.LLST8:
	.4byte	.LVL28
	.4byte	.LVL29
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL29
	.4byte	.LVL32
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.4byte	.LVL32
	.4byte	.LVL33
	.2byte	0x2
	.byte	0x32
	.byte	0x9f
	.4byte	.LVL33
	.4byte	.LVL34
	.2byte	0x2
	.byte	0x33
	.byte	0x9f
	.4byte	.LVL34
	.4byte	.LFE58
	.2byte	0x2
	.byte	0x34
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS9:
	.uleb128 .LVU141
	.uleb128 .LVU143
	.uleb128 .LVU143
	.uleb128 0
.LLST9:
	.4byte	.LVL25
	.4byte	.LVL26
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL26
	.4byte	.LFE58
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LVUS10:
	.uleb128 .LVU151
	.uleb128 .LVU159
	.uleb128 .LVU159
	.uleb128 .LVU165
.LLST10:
	.4byte	.LVL28
	.4byte	.LVL29
	.2byte	0x6
	.byte	0x70
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	.LVL29
	.4byte	.LVL30
	.2byte	0x8
	.byte	0x70
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS11:
	.uleb128 .LVU149
	.uleb128 .LVU158
	.uleb128 .LVU158
	.uleb128 .LVU165
	.uleb128 .LVU181
	.uleb128 0
.LLST11:
	.4byte	.LVL28
	.4byte	.LVL29
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL29
	.4byte	.LVL30
	.2byte	0x5
	.byte	0x70
	.sleb128 0
	.byte	0x38
	.byte	0x25
	.byte	0x9f
	.4byte	.LVL34
	.4byte	.LFE58
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS12:
	.uleb128 .LVU144
	.uleb128 .LVU147
.LLST12:
	.4byte	.LVL26
	.4byte	.LVL27
	.2byte	0x16
	.byte	0x3
	.4byte	g_armwave_state+32
	.byte	0x6
	.byte	0x77
	.sleb128 0
	.byte	0x1e
	.byte	0x3
	.4byte	g_armwave_state+20
	.byte	0x6
	.byte	0x22
	.byte	0x78
	.sleb128 0
	.byte	0x22
	.byte	0x23
	.uleb128 0x4
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS13:
	.uleb128 .LVU140
	.uleb128 0
.LLST13:
	.4byte	.LVL25
	.4byte	.LFE58
	.2byte	0x6
	.byte	0x73
	.sleb128 0
	.byte	0x75
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS14:
	.uleb128 .LVU152
	.uleb128 .LVU157
	.uleb128 .LVU160
	.uleb128 .LVU166
	.uleb128 .LVU166
	.uleb128 .LVU167
.LLST14:
	.4byte	.LVL28
	.4byte	.LVL29
	.2byte	0x10
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x72
	.sleb128 0
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x75
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL29
	.4byte	.LVL31
	.2byte	0x10
	.byte	0x72
	.sleb128 1
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x75
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL31
	.4byte	.LVL32
	.2byte	0x10
	.byte	0x72
	.sleb128 -3
	.byte	0x3
	.4byte	g_armwave_state+40
	.byte	0x6
	.byte	0x1e
	.byte	0x73
	.sleb128 0
	.byte	0x22
	.byte	0x75
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS15:
	.uleb128 0
	.uleb128 .LVU205
	.uleb128 .LVU205
	.uleb128 .LVU242
	.uleb128 .LVU242
	.uleb128 .LVU287
	.uleb128 .LVU287
	.uleb128 .LVU293
	.uleb128 .LVU293
	.uleb128 .LVU310
	.uleb128 .LVU310
	.uleb128 .LVU312
	.uleb128 .LVU312
	.uleb128 .LVU314
	.uleb128 .LVU314
	.uleb128 0
.LLST15:
	.4byte	.LVL37
	.4byte	.LVL40
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL40
	.4byte	.LVL42-1
	.2byte	0x5
	.byte	0x3
	.4byte	g_armwave_state+20
	.4byte	.LVL42-1
	.4byte	.LVL52
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	.LVL52
	.4byte	.LVL53
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL53
	.4byte	.LVL55-1
	.2byte	0x5
	.byte	0x3
	.4byte	g_armwave_state+20
	.4byte	.LVL55-1
	.4byte	.LVL57
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	.LVL57
	.4byte	.LVL59
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL59
	.4byte	.LFE60
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS16:
	.uleb128 0
	.uleb128 .LVU197
	.uleb128 .LVU197
	.uleb128 0
.LLST16:
	.4byte	.LVL37
	.4byte	.LVL38
	.2byte	0x1
	.byte	0x51
	.4byte	.LVL38
	.4byte	.LFE60
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LVUS17:
	.uleb128 0
	.uleb128 .LVU198
	.uleb128 .LVU198
	.uleb128 .LVU258
	.uleb128 .LVU258
	.uleb128 .LVU287
	.uleb128 .LVU287
	.uleb128 .LVU311
	.uleb128 .LVU311
	.uleb128 .LVU312
	.uleb128 .LVU312
	.uleb128 0
.LLST17:
	.4byte	.LVL37
	.4byte	.LVL39
	.2byte	0x1
	.byte	0x52
	.4byte	.LVL39
	.4byte	.LVL45
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL45
	.4byte	.LVL52
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.4byte	.LVL52
	.4byte	.LVL56
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL56
	.4byte	.LVL57
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.4byte	.LVL57
	.4byte	.LFE60
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LVUS18:
	.uleb128 0
	.uleb128 .LVU225
	.uleb128 .LVU225
	.uleb128 .LVU242
	.uleb128 .LVU242
	.uleb128 .LVU287
	.uleb128 .LVU287
	.uleb128 .LVU309
	.uleb128 .LVU309
	.uleb128 .LVU312
	.uleb128 .LVU312
	.uleb128 .LVU313
	.uleb128 .LVU313
	.uleb128 0
.LLST18:
	.4byte	.LVL37
	.4byte	.LVL41
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL41
	.4byte	.LVL42-1
	.2byte	0x5
	.byte	0x3
	.4byte	g_armwave_state+36
	.4byte	.LVL42-1
	.4byte	.LVL52
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x53
	.byte	0x9f
	.4byte	.LVL52
	.4byte	.LVL54
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL54
	.4byte	.LVL57
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x53
	.byte	0x9f
	.4byte	.LVL57
	.4byte	.LVL58
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL58
	.4byte	.LFE60
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x53
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS19:
	.uleb128 .LVU258
	.uleb128 .LVU287
	.uleb128 .LVU311
	.uleb128 .LVU312
.LLST19:
	.4byte	.LVL45
	.4byte	.LVL52
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL56
	.4byte	.LVL57
	.2byte	0x1
	.byte	0x55
	.4byte	0
	.4byte	0
.LVUS20:
	.uleb128 .LVU275
	.uleb128 .LVU284
.LLST20:
	.4byte	.LVL48
	.4byte	.LVL50-1
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS21:
	.uleb128 .LVU264
	.uleb128 .LVU285
	.uleb128 .LVU285
	.uleb128 .LVU287
	.uleb128 .LVU311
	.uleb128 .LVU312
.LLST21:
	.4byte	.LVL46
	.4byte	.LVL51
	.2byte	0x2
	.byte	0x90
	.uleb128 0x50
	.4byte	.LVL51
	.4byte	.LVL52
	.2byte	0xe
	.byte	0x75
	.sleb128 0
	.byte	0xf7
	.uleb128 0x3a
	.byte	0xf7
	.uleb128 0x25
	.byte	0x76
	.sleb128 0
	.byte	0xf7
	.uleb128 0x3a
	.byte	0xf7
	.uleb128 0x25
	.byte	0x1b
	.byte	0x9f
	.4byte	.LVL56
	.4byte	.LVL57
	.2byte	0x2
	.byte	0x90
	.uleb128 0x50
	.4byte	0
	.4byte	0
.LVUS23:
	.uleb128 0
	.uleb128 .LVU322
	.uleb128 .LVU322
	.uleb128 0
.LLST23:
	.4byte	.LVL64
	.4byte	.LVL65
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL65
	.4byte	.LFE62
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS42:
	.uleb128 0
	.uleb128 .LVU632
	.uleb128 .LVU632
	.uleb128 0
.LLST42:
	.4byte	.LVL120
	.4byte	.LVL151
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL151
	.4byte	.LFE64
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS43:
	.uleb128 .LVU615
	.uleb128 .LVU631
.LLST43:
	.4byte	.LVL143
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x57
	.4byte	0
	.4byte	0
.LVUS44:
	.uleb128 .LVU614
	.uleb128 .LVU631
.LLST44:
	.4byte	.LVL143
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x5a
	.4byte	0
	.4byte	0
.LVUS45:
	.uleb128 .LVU610
	.uleb128 .LVU631
.LLST45:
	.4byte	.LVL141
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
.LVUS46:
	.uleb128 .LVU560
	.uleb128 .LVU564
	.uleb128 .LVU565
	.uleb128 .LVU631
.LLST46:
	.4byte	.LVL124
	.4byte	.LVL126
	.2byte	0x1
	.byte	0x5c
	.4byte	.LVL127
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x5c
	.4byte	0
	.4byte	0
.LVUS47:
	.uleb128 .LVU581
	.uleb128 .LVU593
	.uleb128 .LVU597
	.uleb128 .LVU600
.LLST47:
	.4byte	.LVL133
	.4byte	.LVL135
	.2byte	0x8
	.byte	0x7b
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL139
	.4byte	.LVL140
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS48:
	.uleb128 .LVU582
	.uleb128 .LVU593
	.uleb128 .LVU594
	.uleb128 .LVU596
.LLST48:
	.4byte	.LVL133
	.4byte	.LVL135
	.2byte	0x9
	.byte	0x73
	.sleb128 0
	.byte	0x7d
	.sleb128 0
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL136
	.4byte	.LVL138
	.2byte	0x1
	.byte	0x51
	.4byte	0
	.4byte	0
.LVUS49:
	.uleb128 .LVU583
	.uleb128 .LVU592
	.uleb128 .LVU592
	.uleb128 .LVU595
.LLST49:
	.4byte	.LVL133
	.4byte	.LVL134
	.2byte	0x9
	.byte	0x73
	.sleb128 0
	.byte	0x91
	.sleb128 -52
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x9f
	.4byte	.LVL134
	.4byte	.LVL137
	.2byte	0x1
	.byte	0x52
	.4byte	0
	.4byte	0
.LVUS50:
	.uleb128 .LVU552
	.uleb128 .LVU558
	.uleb128 .LVU558
	.uleb128 .LVU564
	.uleb128 .LVU565
	.uleb128 .LVU631
.LLST50:
	.4byte	.LVL122
	.4byte	.LVL123
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL123
	.4byte	.LVL126
	.2byte	0x1
	.byte	0x5e
	.4byte	.LVL127
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x5e
	.4byte	0
	.4byte	0
.LVUS51:
	.uleb128 .LVU611
	.uleb128 .LVU613
	.uleb128 .LVU613
	.uleb128 .LVU631
.LLST51:
	.4byte	.LVL141
	.4byte	.LVL142
	.2byte	0x1
	.byte	0x57
	.4byte	.LVL142
	.4byte	.LVL150
	.2byte	0x6
	.byte	0x7e
	.sleb128 0
	.byte	0x79
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS52:
	.uleb128 .LVU550
	.uleb128 .LVU631
.LLST52:
	.4byte	.LVL122
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LVUS53:
	.uleb128 .LVU567
	.uleb128 .LVU631
.LLST53:
	.4byte	.LVL128
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x59
	.4byte	0
	.4byte	0
.LVUS54:
	.uleb128 .LVU551
	.uleb128 .LVU558
.LLST54:
	.4byte	.LVL122
	.4byte	.LVL123
	.2byte	0x9
	.byte	0x3
	.4byte	g_armwave_state+64
	.byte	0x6
	.byte	0x38
	.byte	0x25
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS55:
	.uleb128 .LVU584
	.uleb128 .LVU593
.LLST55:
	.4byte	.LVL133
	.4byte	.LVL135
	.2byte	0x13
	.byte	0x7b
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS56:
	.uleb128 .LVU585
	.uleb128 .LVU593
.LLST56:
	.4byte	.LVL133
	.4byte	.LVL135
	.2byte	0x14
	.byte	0x73
	.sleb128 0
	.byte	0x7d
	.sleb128 0
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS57:
	.uleb128 .LVU586
	.uleb128 .LVU593
.LLST57:
	.4byte	.LVL133
	.4byte	.LVL135
	.2byte	0x14
	.byte	0x73
	.sleb128 0
	.byte	0x91
	.sleb128 -52
	.byte	0x6
	.byte	0x1e
	.byte	0x38
	.byte	0x26
	.byte	0x12
	.byte	0x8
	.byte	0xff
	.byte	0x16
	.byte	0x14
	.byte	0x2d
	.byte	0x28
	.2byte	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x9f
	.4byte	0
	.4byte	0
.LVUS58:
	.uleb128 .LVU568
	.uleb128 .LVU570
	.uleb128 .LVU575
	.uleb128 .LVU578
.LLST58:
	.4byte	.LVL128
	.4byte	.LVL129
	.2byte	0x1
	.byte	0x5c
	.4byte	.LVL131
	.4byte	.LVL132
	.2byte	0x1
	.byte	0x5c
	.4byte	0
	.4byte	0
.LVUS59:
	.uleb128 .LVU616
	.uleb128 .LVU619
	.uleb128 .LVU619
	.uleb128 .LVU624
	.uleb128 .LVU626
	.uleb128 .LVU631
.LLST59:
	.4byte	.LVL143
	.4byte	.LVL144
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL144
	.4byte	.LVL146
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL148
	.4byte	.LVL150
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LVUS60:
	.uleb128 .LVU545
	.uleb128 .LVU560
	.uleb128 .LVU560
	.uleb128 .LVU563
	.uleb128 .LVU563
	.uleb128 .LVU565
	.uleb128 .LVU565
	.uleb128 .LVU631
	.uleb128 .LVU631
	.uleb128 0
.LLST60:
	.4byte	.LVL121
	.4byte	.LVL124
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL124
	.4byte	.LVL125
	.2byte	0x3
	.byte	0x76
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL125
	.4byte	.LVL127
	.2byte	0x1
	.byte	0x56
	.4byte	.LVL127
	.4byte	.LVL150
	.2byte	0x3
	.byte	0x76
	.sleb128 -4
	.byte	0x9f
	.4byte	.LVL150
	.4byte	.LFE64
	.2byte	0x1
	.byte	0x56
	.4byte	0
	.4byte	0
.LVUS61:
	.uleb128 .LVU620
	.uleb128 .LVU623
	.uleb128 .LVU625
	.uleb128 .LVU629
.LLST61:
	.4byte	.LVL144
	.4byte	.LVL145
	.2byte	0x10
	.byte	0x72
	.sleb128 0
	.byte	0x7a
	.sleb128 0
	.byte	0x22
	.byte	0x3
	.4byte	g_armwave_state+60
	.byte	0x6
	.byte	0x1e
	.byte	0x77
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL147
	.4byte	.LVL149
	.2byte	0x1
	.byte	0x51
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB73
	.4byte	.LFE73-.LFB73
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LBB10
	.4byte	.LBE10
	.4byte	.LBB13
	.4byte	.LBE13
	.4byte	.LBB14
	.4byte	.LBE14
	.4byte	0
	.4byte	0
	.4byte	.LBB15
	.4byte	.LBE15
	.4byte	.LBB18
	.4byte	.LBE18
	.4byte	0
	.4byte	0
	.4byte	.LBB21
	.4byte	.LBE21
	.4byte	.LBB24
	.4byte	.LBE24
	.4byte	0
	.4byte	0
	.4byte	.LBB27
	.4byte	.LBE27
	.4byte	.LBB31
	.4byte	.LBE31
	.4byte	.LBB32
	.4byte	.LBE32
	.4byte	0
	.4byte	0
	.4byte	.LBB37
	.4byte	.LBE37
	.4byte	.LBB41
	.4byte	.LBE41
	.4byte	.LBB42
	.4byte	.LBE42
	.4byte	0
	.4byte	0
	.4byte	.LBB43
	.4byte	.LBE43
	.4byte	.LBB46
	.4byte	.LBE46
	.4byte	0
	.4byte	0
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.LFB73
	.4byte	.LFE73
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF275:
	.ascii	"hashsalt\000"
.LASF412:
	.ascii	"PyGen_Type\000"
.LASF405:
	.ascii	"Py_tracefunc\000"
.LASF62:
	.ascii	"_sys_errlist\000"
.LASF50:
	.ascii	"_unused2\000"
.LASF36:
	.ascii	"_fileno\000"
.LASF159:
	.ascii	"lenfunc\000"
.LASF451:
	.ascii	"PyExc_ModuleNotFoundError\000"
.LASF591:
	.ascii	"start_point\000"
.LASF453:
	.ascii	"PyExc_KeyError\000"
.LASF108:
	.ascii	"tp_getattr\000"
.LASF467:
	.ascii	"PyExc_TypeError\000"
.LASF240:
	.ascii	"sq_item\000"
.LASF200:
	.ascii	"nb_add\000"
.LASF423:
	.ascii	"PyGetSetDescr_Type\000"
.LASF8:
	.ascii	"__uint8_t\000"
.LASF483:
	.ascii	"PyExc_FileNotFoundError\000"
.LASF99:
	.ascii	"ob_refcnt\000"
.LASF321:
	.ascii	"PyTuple_Type\000"
.LASF242:
	.ascii	"sq_ass_item\000"
.LASF183:
	.ascii	"PyBaseObject_Type\000"
.LASF444:
	.ascii	"PyExc_AssertionError\000"
.LASF94:
	.ascii	"tracing\000"
.LASF246:
	.ascii	"sq_inplace_repeat\000"
.LASF110:
	.ascii	"tp_as_async\000"
.LASF418:
	.ascii	"_PyAsyncGenWrappedValue_Type\000"
.LASF234:
	.ascii	"nb_matrix_multiply\000"
.LASF211:
	.ascii	"nb_lshift\000"
.LASF245:
	.ascii	"sq_inplace_concat\000"
.LASF141:
	.ascii	"tp_is_gc\000"
.LASF41:
	.ascii	"_shortbuf\000"
.LASF205:
	.ascii	"nb_power\000"
.LASF611:
	.ascii	"fwrite\000"
.LASF254:
	.ascii	"am_anext\000"
.LASF583:
	.ascii	"out_buffer_base\000"
.LASF368:
	.ascii	"PyCell_Type\000"
.LASF462:
	.ascii	"PyExc_IndentationError\000"
.LASF239:
	.ascii	"sq_repeat\000"
.LASF66:
	.ascii	"__environ\000"
.LASF387:
	.ascii	"curexc_value\000"
.LASF364:
	.ascii	"_frame\000"
.LASF105:
	.ascii	"tp_itemsize\000"
.LASF276:
	.ascii	"siphash\000"
.LASF496:
	.ascii	"PyExc_SyntaxWarning\000"
.LASF238:
	.ascii	"sq_concat\000"
.LASF73:
	.ascii	"uint16_t\000"
.LASF447:
	.ascii	"PyExc_EOFError\000"
.LASF515:
	.ascii	"PyNullImporter_Type\000"
.LASF179:
	.ascii	"initproc\000"
.LASF509:
	.ascii	"PyOS_ReadlineFunctionPointer\000"
.LASF22:
	.ascii	"_flags\000"
.LASF540:
	.ascii	"slice_record_height\000"
.LASF508:
	.ascii	"PyOS_InputHook\000"
.LASF374:
	.ascii	"next\000"
.LASF491:
	.ascii	"PyExc_IOError\000"
.LASF265:
	.ascii	"PyGetSetDef\000"
.LASF616:
	.ascii	"calloc\000"
.LASF142:
	.ascii	"tp_bases\000"
.LASF17:
	.ascii	"__off_t\000"
.LASF463:
	.ascii	"PyExc_TabError\000"
.LASF425:
	.ascii	"PyMethodDescr_Type\000"
.LASF553:
	.ascii	"test_wave_buffer\000"
.LASF286:
	.ascii	"Py_OptimizeFlag\000"
.LASF598:
	.ascii	"height\000"
.LASF42:
	.ascii	"_lock\000"
.LASF314:
	.ascii	"PyFloat_Type\000"
.LASF318:
	.ascii	"PyLongRangeIter_Type\000"
.LASF171:
	.ascii	"setattrofunc\000"
.LASF106:
	.ascii	"tp_dealloc\000"
.LASF539:
	.ascii	"slice_height\000"
.LASF408:
	.ascii	"exc_value\000"
.LASF585:
	.ascii	"armwave_fill_pixbuf_256\000"
.LASF89:
	.ascii	"TRACEMALLOC_NOT_INITIALIZED\000"
.LASF298:
	.ascii	"_PyByteArray_empty_string\000"
.LASF101:
	.ascii	"_typeobject\000"
.LASF229:
	.ascii	"nb_floor_divide\000"
.LASF571:
	.ascii	"render_width\000"
.LASF224:
	.ascii	"nb_inplace_lshift\000"
.LASF575:
	.ascii	"data\000"
.LASF480:
	.ascii	"PyExc_ConnectionRefusedError\000"
.LASF576:
	.ascii	"ysub\000"
.LASF479:
	.ascii	"PyExc_ConnectionAbortedError\000"
.LASF449:
	.ascii	"PyExc_OSError\000"
.LASF562:
	.ascii	"xnoise\000"
.LASF292:
	.ascii	"Py_NoUserSiteDirectory\000"
.LASF478:
	.ascii	"PyExc_ConnectionError\000"
.LASF476:
	.ascii	"PyExc_BrokenPipeError\000"
.LASF492:
	.ascii	"PyExc_Warning\000"
.LASF233:
	.ascii	"nb_index\000"
.LASF125:
	.ascii	"tp_richcompare\000"
.LASF511:
	.ascii	"_Py_CheckRecursionLimit\000"
.LASF472:
	.ascii	"PyExc_UnicodeTranslateError\000"
.LASF549:
	.ascii	"ch3_color\000"
.LASF440:
	.ascii	"PyExc_StopIteration\000"
.LASF477:
	.ascii	"PyExc_ChildProcessError\000"
.LASF612:
	.ascii	"__builtin_memset\000"
.LASF28:
	.ascii	"_IO_write_end\000"
.LASF372:
	.ascii	"PyThreadState\000"
.LASF203:
	.ascii	"nb_remainder\000"
.LASF615:
	.ascii	"fclose\000"
.LASF164:
	.ascii	"visitproc\000"
.LASF355:
	.ascii	"PyMethod_Type\000"
.LASF557:
	.ascii	"out_buffer\000"
.LASF313:
	.ascii	"_Py_TrueStruct\000"
.LASF221:
	.ascii	"nb_inplace_multiply\000"
.LASF512:
	.ascii	"_inittab\000"
.LASF604:
	.ascii	"free\000"
.LASF282:
	.ascii	"Py_VerboseFlag\000"
.LASF516:
	.ascii	"_frozen\000"
.LASF241:
	.ascii	"was_sq_slice\000"
.LASF83:
	.ascii	"__tzname\000"
.LASF264:
	.ascii	"PyMemberDef\000"
.LASF514:
	.ascii	"PyImport_Inittab\000"
.LASF375:
	.ascii	"interp\000"
.LASF542:
	.ascii	"target_width\000"
.LASF100:
	.ascii	"ob_type\000"
.LASF495:
	.ascii	"PyExc_PendingDeprecationWarning\000"
.LASF140:
	.ascii	"tp_free\000"
.LASF497:
	.ascii	"PyExc_RuntimeWarning\000"
.LASF320:
	.ascii	"PyMemoryView_Type\000"
.LASF154:
	.ascii	"PyVarObject\000"
.LASF319:
	.ascii	"_PyManagedBuffer_Type\000"
.LASF90:
	.ascii	"TRACEMALLOC_INITIALIZED\000"
.LASF384:
	.ascii	"c_profileobj\000"
.LASF541:
	.ascii	"ch_buff_size\000"
.LASF213:
	.ascii	"nb_and\000"
.LASF475:
	.ascii	"PyExc_BlockingIOError\000"
.LASF68:
	.ascii	"optarg\000"
.LASF406:
	.ascii	"_err_stackitem\000"
.LASF488:
	.ascii	"PyExc_ProcessLookupError\000"
.LASF116:
	.ascii	"tp_call\000"
.LASF393:
	.ascii	"async_exc\000"
.LASF572:
	.ascii	"render_height\000"
.LASF527:
	.ascii	"armwave_state_t\000"
.LASF269:
	.ascii	"_PyNone_Type\000"
.LASF392:
	.ascii	"gilstate_counter\000"
.LASF60:
	.ascii	"sys_errlist\000"
.LASF554:
	.ascii	"gamma_table\000"
.LASF117:
	.ascii	"tp_str\000"
.LASF544:
	.ascii	"row_shift\000"
.LASF566:
	.ascii	"mod_val\000"
.LASF243:
	.ascii	"was_sq_ass_slice\000"
.LASF458:
	.ascii	"PyExc_RuntimeError\000"
.LASF87:
	.ascii	"daylight\000"
.LASF9:
	.ascii	"__int16_t\000"
.LASF11:
	.ascii	"__uint16_t\000"
.LASF157:
	.ascii	"ternaryfunc\000"
.LASF442:
	.ascii	"PyExc_ArithmeticError\000"
.LASF102:
	.ascii	"ob_base\000"
.LASF268:
	.ascii	"PyTypeObject\000"
.LASF363:
	.ascii	"PyTraceBack_Type\000"
.LASF435:
	.ascii	"PyPickleBuffer_Type\000"
.LASF446:
	.ascii	"PyExc_BufferError\000"
.LASF285:
	.ascii	"Py_InspectFlag\000"
.LASF415:
	.ascii	"_PyAIterWrapper_Type\000"
.LASF244:
	.ascii	"sq_contains\000"
.LASF274:
	.ascii	"padding\000"
.LASF592:
	.ascii	"end_point\000"
.LASF35:
	.ascii	"_chain\000"
.LASF109:
	.ascii	"tp_setattr\000"
.LASF507:
	.ascii	"PyCode_Type\000"
.LASF617:
	.ascii	"malloc\000"
.LASF174:
	.ascii	"richcmpfunc\000"
.LASF3:
	.ascii	"unsigned char\000"
.LASF351:
	.ascii	"PyModuleDef_Type\000"
.LASF277:
	.ascii	"djbx33a\000"
.LASF429:
	.ascii	"PyProperty_Type\000"
.LASF250:
	.ascii	"mp_ass_subscript\000"
.LASF485:
	.ascii	"PyExc_IsADirectoryError\000"
.LASF595:
	.ascii	"points_per_pixel\000"
.LASF335:
	.ascii	"PyDictRevIterItem_Type\000"
.LASF93:
	.ascii	"initialized\000"
.LASF621:
	.ascii	"_IO_lock_t\000"
.LASF468:
	.ascii	"PyExc_UnboundLocalError\000"
.LASF0:
	.ascii	"float\000"
.LASF136:
	.ascii	"tp_dictoffset\000"
.LASF603:
	.ascii	"gamma\000"
.LASF441:
	.ascii	"PyExc_GeneratorExit\000"
.LASF236:
	.ascii	"PyNumberMethods\000"
.LASF259:
	.ascii	"PyMethodDef\000"
.LASF149:
	.ascii	"tp_finalize\000"
.LASF422:
	.ascii	"PyClassMethodDescr_Type\000"
.LASF346:
	.ascii	"PyFrozenSet_Type\000"
.LASF249:
	.ascii	"mp_subscript\000"
.LASF124:
	.ascii	"tp_clear\000"
.LASF283:
	.ascii	"Py_QuietFlag\000"
.LASF428:
	.ascii	"_PyMethodWrapper_Type\000"
.LASF331:
	.ascii	"PyDictIterKey_Type\000"
.LASF526:
	.ascii	"armwave_color_mix_t\000"
.LASF75:
	.ascii	"uint64_t\000"
.LASF466:
	.ascii	"PyExc_SystemExit\000"
.LASF357:
	.ascii	"Py_FileSystemDefaultEncoding\000"
.LASF381:
	.ascii	"use_tracing\000"
.LASF323:
	.ascii	"PyList_Type\000"
.LASF391:
	.ascii	"dict\000"
.LASF209:
	.ascii	"nb_bool\000"
.LASF344:
	.ascii	"_PySet_Dummy\000"
.LASF362:
	.ascii	"PyCapsule_Type\000"
.LASF293:
	.ascii	"Py_UnbufferedStdioFlag\000"
.LASF137:
	.ascii	"tp_init\000"
.LASF162:
	.ascii	"objobjargproc\000"
.LASF153:
	.ascii	"ob_size\000"
.LASF133:
	.ascii	"tp_dict\000"
.LASF482:
	.ascii	"PyExc_FileExistsError\000"
.LASF27:
	.ascii	"_IO_write_ptr\000"
.LASF114:
	.ascii	"tp_as_mapping\000"
.LASF620:
	.ascii	"/home/pi/git/armwave\000"
.LASF588:
	.ascii	"armwave_set_channel_colour\000"
.LASF581:
	.ascii	"value\000"
.LASF366:
	.ascii	"PySlice_Type\000"
.LASF460:
	.ascii	"PyExc_NotImplementedError\000"
.LASF156:
	.ascii	"binaryfunc\000"
.LASF424:
	.ascii	"PyMemberDescr_Type\000"
.LASF534:
	.ascii	"xstride\000"
.LASF518:
	.ascii	"size\000"
.LASF51:
	.ascii	"FILE\000"
.LASF256:
	.ascii	"bf_getbuffer\000"
.LASF199:
	.ascii	"vectorcallfunc\000"
.LASF551:
	.ascii	"xcoord_to_xpixel\000"
.LASF175:
	.ascii	"getiterfunc\000"
.LASF414:
	.ascii	"_PyCoroWrapper_Type\000"
.LASF524:
	.ascii	"_Py_ctype_tolower\000"
.LASF160:
	.ascii	"ssizeargfunc\000"
.LASF606:
	.ascii	"__assert_fail\000"
.LASF578:
	.ascii	"wave_word\000"
.LASF550:
	.ascii	"ch4_color\000"
.LASF389:
	.ascii	"exc_state\000"
.LASF7:
	.ascii	"size_t\000"
.LASF91:
	.ascii	"TRACEMALLOC_FINALIZED\000"
.LASF88:
	.ascii	"getdate_err\000"
.LASF72:
	.ascii	"uint8_t\000"
.LASF178:
	.ascii	"descrsetfunc\000"
.LASF559:
	.ascii	"armwave_test_create_square\000"
.LASF564:
	.ascii	"new_level\000"
.LASF426:
	.ascii	"PyWrapperDescr_Type\000"
.LASF177:
	.ascii	"descrgetfunc\000"
.LASF590:
	.ascii	"armwave_setup_render\000"
.LASF279:
	.ascii	"_Py_HashSecret_t\000"
.LASF407:
	.ascii	"exc_type\000"
.LASF219:
	.ascii	"nb_inplace_add\000"
.LASF217:
	.ascii	"nb_reserved\000"
.LASF579:
	.ascii	"nsub\000"
.LASF397:
	.ascii	"on_delete\000"
.LASF31:
	.ascii	"_IO_save_base\000"
.LASF499:
	.ascii	"PyExc_ImportWarning\000"
.LASF301:
	.ascii	"PyUnicode_Type\000"
.LASF67:
	.ascii	"environ\000"
.LASF172:
	.ascii	"reprfunc\000"
.LASF326:
	.ascii	"PySortWrapper_Type\000"
.LASF533:
	.ascii	"wave_buffer\000"
.LASF388:
	.ascii	"curexc_traceback\000"
.LASF281:
	.ascii	"Py_DebugFlag\000"
.LASF567:
	.ascii	"armwave_test_dump_buffer_to_ppm\000"
.LASF517:
	.ascii	"code\000"
.LASF45:
	.ascii	"_wide_data\000"
.LASF529:
	.ascii	"ch1_buffer\000"
.LASF520:
	.ascii	"PyFilter_Type\000"
.LASF433:
	.ascii	"PyStructSequence_UnnamedField\000"
.LASF170:
	.ascii	"setattrfunc\000"
.LASF456:
	.ascii	"PyExc_NameError\000"
.LASF97:
	.ascii	"_Py_tracemalloc_config\000"
.LASF378:
	.ascii	"overflowed\000"
.LASF573:
	.ascii	"armwave_dump_ppm_debug\000"
.LASF78:
	.ascii	"signgam\000"
.LASF327:
	.ascii	"PyDict_Type\000"
.LASF530:
	.ascii	"ch2_buffer\000"
.LASF77:
	.ascii	"Py_hash_t\000"
.LASF14:
	.ascii	"__uint64_t\000"
.LASF623:
	.ascii	"armwave_init\000"
.LASF152:
	.ascii	"PyObject\000"
.LASF214:
	.ascii	"nb_xor\000"
.LASF502:
	.ascii	"PyExc_ResourceWarning\000"
.LASF206:
	.ascii	"nb_negative\000"
.LASF608:
	.ascii	"fopen64\000"
.LASF361:
	.ascii	"PyStdPrinter_Type\000"
.LASF92:
	.ascii	"_PyTraceMalloc_Config\000"
.LASF519:
	.ascii	"PyImport_FrozenModules\000"
.LASF614:
	.ascii	"fprintf\000"
.LASF531:
	.ascii	"ch3_buffer\000"
.LASF417:
	.ascii	"_PyAsyncGenASend_Type\000"
.LASF20:
	.ascii	"__ssize_t\000"
.LASF537:
	.ascii	"waves\000"
.LASF333:
	.ascii	"PyDictIterItem_Type\000"
.LASF340:
	.ascii	"PyODictItems_Type\000"
.LASF337:
	.ascii	"PyODict_Type\000"
.LASF338:
	.ascii	"PyODictIter_Type\000"
.LASF379:
	.ascii	"recursion_critical\000"
.LASF85:
	.ascii	"__timezone\000"
.LASF427:
	.ascii	"PyDictProxy_Type\000"
.LASF370:
	.ascii	"PyCallIter_Type\000"
.LASF409:
	.ascii	"exc_traceback\000"
.LASF258:
	.ascii	"PyBufferProcs\000"
.LASF558:
	.ascii	"armwave_cleanup\000"
.LASF371:
	.ascii	"PyCmpWrapper_Type\000"
.LASF262:
	.ascii	"ml_flags\000"
.LASF139:
	.ascii	"tp_new\000"
.LASF353:
	.ascii	"PyClassMethod_Type\000"
.LASF232:
	.ascii	"nb_inplace_true_divide\000"
.LASF411:
	.ascii	"_PyErr_StackItem\000"
.LASF167:
	.ascii	"destructor\000"
.LASF349:
	.ascii	"PyCFunction\000"
.LASF610:
	.ascii	"memset\000"
.LASF563:
	.ascii	"level\000"
.LASF58:
	.ascii	"stderr\000"
.LASF345:
	.ascii	"PySet_Type\000"
.LASF266:
	.ascii	"name\000"
.LASF303:
	.ascii	"_Py_ascii_whitespace\000"
.LASF64:
	.ascii	"program_invocation_short_name\000"
.LASF493:
	.ascii	"PyExc_UserWarning\000"
.LASF33:
	.ascii	"_IO_save_end\000"
.LASF504:
	.ascii	"PyContextVar_Type\000"
.LASF147:
	.ascii	"tp_del\000"
.LASF316:
	.ascii	"PyRange_Type\000"
.LASF356:
	.ascii	"PyInstanceMethod_Type\000"
.LASF367:
	.ascii	"PyEllipsis_Type\000"
.LASF96:
	.ascii	"use_domain\000"
.LASF57:
	.ascii	"stdout\000"
.LASF103:
	.ascii	"tp_name\000"
.LASF71:
	.ascii	"optopt\000"
.LASF267:
	.ascii	"closure\000"
.LASF513:
	.ascii	"initfunc\000"
.LASF536:
	.ascii	"wave_stride\000"
.LASF287:
	.ascii	"Py_NoSiteFlag\000"
.LASF586:
	.ascii	"__PRETTY_FUNCTION__\000"
.LASF382:
	.ascii	"c_profilefunc\000"
.LASF113:
	.ascii	"tp_as_sequence\000"
.LASF120:
	.ascii	"tp_as_buffer\000"
.LASF188:
	.ascii	"itemsize\000"
.LASF582:
	.ascii	"base_32ptr\000"
.LASF226:
	.ascii	"nb_inplace_and\000"
.LASF310:
	.ascii	"digit\000"
.LASF65:
	.ascii	"int16_t\000"
.LASF4:
	.ascii	"short unsigned int\000"
.LASF6:
	.ascii	"signed char\000"
.LASF400:
	.ascii	"async_gen_firstiter\000"
.LASF350:
	.ascii	"PyModule_Type\000"
.LASF570:
	.ascii	"armwave_test_init\000"
.LASF342:
	.ascii	"PyEnum_Type\000"
.LASF138:
	.ascii	"tp_alloc\000"
.LASF194:
	.ascii	"suboffsets\000"
.LASF489:
	.ascii	"PyExc_TimeoutError\000"
.LASF568:
	.ascii	"armwave_test_fill_gdkbuf\000"
.LASF395:
	.ascii	"trash_delete_nesting\000"
.LASF19:
	.ascii	"__off64_t\000"
.LASF25:
	.ascii	"_IO_read_base\000"
.LASF522:
	.ascii	"PyZip_Type\000"
.LASF43:
	.ascii	"_offset\000"
.LASF322:
	.ascii	"PyTupleIter_Type\000"
.LASF30:
	.ascii	"_IO_buf_end\000"
.LASF118:
	.ascii	"tp_getattro\000"
.LASF181:
	.ascii	"allocfunc\000"
.LASF270:
	.ascii	"_PyNotImplemented_Type\000"
.LASF385:
	.ascii	"c_traceobj\000"
.LASF70:
	.ascii	"opterr\000"
.LASF95:
	.ascii	"max_nframe\000"
.LASF49:
	.ascii	"_mode\000"
.LASF343:
	.ascii	"PyReversed_Type\000"
.LASF129:
	.ascii	"tp_methods\000"
.LASF26:
	.ascii	"_IO_write_base\000"
.LASF143:
	.ascii	"tp_mro\000"
.LASF455:
	.ascii	"PyExc_MemoryError\000"
.LASF82:
	.ascii	"tz_dsttime\000"
.LASF437:
	.ascii	"PyExc_BaseException\000"
.LASF271:
	.ascii	"_Py_SwappedOp\000"
.LASF431:
	.ascii	"_PyWeakref_ProxyType\000"
.LASF618:
	.ascii	"GNU C17 8.3.0 -mfloat-abi=hard -mfpu=vfp -mtls-dial"
	.ascii	"ect=gnu -marm -march=armv6+fp -g -O3 -fwrapv\000"
.LASF503:
	.ascii	"PyContext_Type\000"
.LASF505:
	.ascii	"PyContextToken_Type\000"
.LASF448:
	.ascii	"PyExc_FloatingPointError\000"
.LASF324:
	.ascii	"PyListIter_Type\000"
.LASF535:
	.ascii	"vscale\000"
.LASF18:
	.ascii	"long int\000"
.LASF215:
	.ascii	"nb_or\000"
.LASF619:
	.ascii	"armwave.c\000"
.LASF191:
	.ascii	"format\000"
.LASF155:
	.ascii	"unaryfunc\000"
.LASF52:
	.ascii	"_IO_marker\000"
.LASF296:
	.ascii	"PyByteArray_Type\000"
.LASF523:
	.ascii	"_Py_ctype_table\000"
.LASF218:
	.ascii	"nb_float\000"
.LASF465:
	.ascii	"PyExc_SystemError\000"
.LASF329:
	.ascii	"PyDictValues_Type\000"
.LASF473:
	.ascii	"PyExc_ValueError\000"
.LASF506:
	.ascii	"_Py_PackageContext\000"
.LASF165:
	.ascii	"traverseproc\000"
.LASF402:
	.ascii	"context\000"
.LASF107:
	.ascii	"tp_vectorcall_offset\000"
.LASF158:
	.ascii	"inquiry\000"
.LASF74:
	.ascii	"uint32_t\000"
.LASF210:
	.ascii	"nb_invert\000"
.LASF263:
	.ascii	"ml_doc\000"
.LASF53:
	.ascii	"_IO_codecvt\000"
.LASF260:
	.ascii	"ml_name\000"
.LASF543:
	.ascii	"target_height\000"
.LASF452:
	.ascii	"PyExc_IndexError\000"
.LASF369:
	.ascii	"PySeqIter_Type\000"
.LASF328:
	.ascii	"PyDictKeys_Type\000"
.LASF438:
	.ascii	"PyExc_Exception\000"
.LASF112:
	.ascii	"tp_as_number\000"
.LASF354:
	.ascii	"PyStaticMethod_Type\000"
.LASF288:
	.ascii	"Py_BytesWarningFlag\000"
.LASF255:
	.ascii	"PyAsyncMethods\000"
.LASF126:
	.ascii	"tp_weaklistoffset\000"
.LASF5:
	.ascii	"long unsigned int\000"
.LASF261:
	.ascii	"ml_meth\000"
.LASF189:
	.ascii	"readonly\000"
.LASF122:
	.ascii	"tp_doc\000"
.LASF403:
	.ascii	"context_ver\000"
.LASF169:
	.ascii	"getattrofunc\000"
.LASF325:
	.ascii	"PyListRevIter_Type\000"
.LASF21:
	.ascii	"char\000"
.LASF247:
	.ascii	"PySequenceMethods\000"
.LASF56:
	.ascii	"stdin\000"
.LASF398:
	.ascii	"on_delete_data\000"
.LASF146:
	.ascii	"tp_weaklist\000"
.LASF613:
	.ascii	"__builtin_fwrite\000"
.LASF29:
	.ascii	"_IO_buf_base\000"
.LASF187:
	.ascii	"bufferinfo\000"
.LASF180:
	.ascii	"newfunc\000"
.LASF521:
	.ascii	"PyMap_Type\000"
.LASF173:
	.ascii	"hashfunc\000"
.LASF168:
	.ascii	"getattrfunc\000"
.LASF24:
	.ascii	"_IO_read_end\000"
.LASF464:
	.ascii	"PyExc_ReferenceError\000"
.LASF79:
	.ascii	"_IO_FILE\000"
.LASF560:
	.ascii	"noise_fraction\000"
.LASF54:
	.ascii	"_IO_wide_data\000"
.LASF547:
	.ascii	"ch1_color\000"
.LASF486:
	.ascii	"PyExc_NotADirectoryError\000"
.LASF494:
	.ascii	"PyExc_DeprecationWarning\000"
.LASF86:
	.ascii	"tzname\000"
.LASF577:
	.ascii	"word\000"
.LASF599:
	.ascii	"scale_value\000"
.LASF386:
	.ascii	"curexc_type\000"
.LASF574:
	.ascii	"buffer\000"
.LASF192:
	.ascii	"shape\000"
.LASF115:
	.ascii	"tp_hash\000"
.LASF297:
	.ascii	"PyByteArrayIter_Type\000"
.LASF273:
	.ascii	"suffix\000"
.LASF593:
	.ascii	"render_flags\000"
.LASF500:
	.ascii	"PyExc_UnicodeWarning\000"
.LASF190:
	.ascii	"ndim\000"
.LASF161:
	.ascii	"ssizeobjargproc\000"
.LASF565:
	.ascii	"armwave_test_create_am_sine\000"
.LASF150:
	.ascii	"tp_vectorcall\000"
.LASF459:
	.ascii	"PyExc_RecursionError\000"
.LASF148:
	.ascii	"tp_version_tag\000"
.LASF383:
	.ascii	"c_tracefunc\000"
.LASF48:
	.ascii	"__pad5\000"
.LASF197:
	.ascii	"getbufferproc\000"
.LASF308:
	.ascii	"_PyLong_Zero\000"
.LASF295:
	.ascii	"Py_IsolatedFlag\000"
.LASF34:
	.ascii	"_markers\000"
.LASF421:
	.ascii	"setter\000"
.LASF410:
	.ascii	"previous_item\000"
.LASF596:
	.ascii	"render_nonaa_to_buffer_1ch_slice\000"
.LASF252:
	.ascii	"am_await\000"
.LASF490:
	.ascii	"PyExc_EnvironmentError\000"
.LASF432:
	.ascii	"_PyWeakref_CallableProxyType\000"
.LASF44:
	.ascii	"_codecvt\000"
.LASF130:
	.ascii	"tp_members\000"
.LASF123:
	.ascii	"tp_traverse\000"
.LASF248:
	.ascii	"mp_length\000"
.LASF1:
	.ascii	"double\000"
.LASF253:
	.ascii	"am_aiter\000"
.LASF555:
	.ascii	"argc\000"
.LASF227:
	.ascii	"nb_inplace_xor\000"
.LASF55:
	.ascii	"ssize_t\000"
.LASF624:
	.ascii	"test_create_gamma\000"
.LASF307:
	.ascii	"_PyLong_DigitValue\000"
.LASF145:
	.ascii	"tp_subclasses\000"
.LASF223:
	.ascii	"nb_inplace_power\000"
.LASF280:
	.ascii	"_Py_HashSecret\000"
.LASF119:
	.ascii	"tp_setattro\000"
.LASF311:
	.ascii	"PyBool_Type\000"
.LASF166:
	.ascii	"freefunc\000"
.LASF12:
	.ascii	"__uint32_t\000"
.LASF607:
	.ascii	"printf\000"
.LASF202:
	.ascii	"nb_multiply\000"
.LASF605:
	.ascii	"rand\000"
.LASF84:
	.ascii	"__daylight\000"
.LASF230:
	.ascii	"nb_true_divide\000"
.LASF131:
	.ascii	"tp_getset\000"
.LASF306:
	.ascii	"PyLong_Type\000"
.LASF589:
	.ascii	"armwave_clear_buffer\000"
.LASF128:
	.ascii	"tp_iternext\000"
.LASF501:
	.ascii	"PyExc_BytesWarning\000"
.LASF347:
	.ascii	"PySetIter_Type\000"
.LASF434:
	.ascii	"_PyNamespace_Type\000"
.LASF237:
	.ascii	"sq_length\000"
.LASF419:
	.ascii	"_PyAsyncGenAThrow_Type\000"
.LASF134:
	.ascii	"tp_descr_get\000"
.LASF289:
	.ascii	"Py_FrozenFlag\000"
.LASF127:
	.ascii	"tp_iter\000"
.LASF231:
	.ascii	"nb_inplace_floor_divide\000"
.LASF63:
	.ascii	"program_invocation_name\000"
.LASF587:
	.ascii	"armwave_fill_pixbuf_scaled\000"
.LASF299:
	.ascii	"PyBytes_Type\000"
.LASF193:
	.ascii	"strides\000"
.LASF413:
	.ascii	"PyCoro_Type\000"
.LASF278:
	.ascii	"expat\000"
.LASF336:
	.ascii	"PyDictRevIterValue_Type\000"
.LASF304:
	.ascii	"_longobject\000"
.LASF330:
	.ascii	"PyDictItems_Type\000"
.LASF309:
	.ascii	"_PyLong_One\000"
.LASF132:
	.ascii	"tp_base\000"
.LASF212:
	.ascii	"nb_rshift\000"
.LASF47:
	.ascii	"_freeres_buf\000"
.LASF450:
	.ascii	"PyExc_ImportError\000"
.LASF390:
	.ascii	"exc_info\000"
.LASF436:
	.ascii	"Py_hexdigits\000"
.LASF257:
	.ascii	"bf_releasebuffer\000"
.LASF469:
	.ascii	"PyExc_UnicodeError\000"
.LASF401:
	.ascii	"async_gen_finalizer\000"
.LASF151:
	.ascii	"tp_print\000"
.LASF15:
	.ascii	"long long unsigned int\000"
.LASF377:
	.ascii	"recursion_depth\000"
.LASF584:
	.ascii	"offset\000"
.LASF594:
	.ascii	"length\000"
.LASF39:
	.ascii	"_cur_column\000"
.LASF198:
	.ascii	"releasebufferproc\000"
.LASF332:
	.ascii	"PyDictIterValue_Type\000"
.LASF222:
	.ascii	"nb_inplace_remainder\000"
.LASF394:
	.ascii	"thread_id\000"
.LASF98:
	.ascii	"_object\000"
.LASF294:
	.ascii	"Py_HashRandomizationFlag\000"
.LASF609:
	.ascii	"fopen\000"
.LASF208:
	.ascii	"nb_absolute\000"
.LASF545:
	.ascii	"row_mask\000"
.LASF454:
	.ascii	"PyExc_KeyboardInterrupt\000"
.LASF32:
	.ascii	"_IO_backup_base\000"
.LASF23:
	.ascii	"_IO_read_ptr\000"
.LASF399:
	.ascii	"coroutine_origin_tracking_depth\000"
.LASF195:
	.ascii	"internal\000"
.LASF396:
	.ascii	"trash_delete_later\000"
.LASF46:
	.ascii	"_freeres_list\000"
.LASF359:
	.ascii	"Py_FileSystemDefaultEncodeErrors\000"
.LASF291:
	.ascii	"Py_DontWriteBytecodeFlag\000"
.LASF228:
	.ascii	"nb_inplace_or\000"
.LASF61:
	.ascii	"_sys_nerr\000"
.LASF600:
	.ascii	"wave_base\000"
.LASF80:
	.ascii	"timezone\000"
.LASF111:
	.ascii	"tp_repr\000"
.LASF445:
	.ascii	"PyExc_AttributeError\000"
.LASF144:
	.ascii	"tp_cache\000"
.LASF569:
	.ascii	"armwave_test_generate\000"
.LASF443:
	.ascii	"PyExc_LookupError\000"
.LASF76:
	.ascii	"Py_ssize_t\000"
.LASF300:
	.ascii	"PyBytesIter_Type\000"
.LASF360:
	.ascii	"Py_UTF8Mode\000"
.LASF580:
	.ascii	"npix\000"
.LASF38:
	.ascii	"_old_offset\000"
.LASF457:
	.ascii	"PyExc_OverflowError\000"
.LASF225:
	.ascii	"nb_inplace_rshift\000"
.LASF358:
	.ascii	"Py_HasFileSystemDefaultEncoding\000"
.LASF341:
	.ascii	"PyODictValues_Type\000"
.LASF302:
	.ascii	"PyUnicodeIter_Type\000"
.LASF315:
	.ascii	"PyComplex_Type\000"
.LASF186:
	.ascii	"_Py_NotImplementedStruct\000"
.LASF69:
	.ascii	"optind\000"
.LASF207:
	.ascii	"nb_positive\000"
.LASF352:
	.ascii	"PyFunction_Type\000"
.LASF538:
	.ascii	"bitdepth_height\000"
.LASF13:
	.ascii	"long long int\000"
.LASF471:
	.ascii	"PyExc_UnicodeDecodeError\000"
.LASF185:
	.ascii	"_Py_NoneStruct\000"
.LASF380:
	.ascii	"stackcheck_counter\000"
.LASF37:
	.ascii	"_flags2\000"
.LASF601:
	.ascii	"write_buffer_base\000"
.LASF532:
	.ascii	"ch4_buffer\000"
.LASF251:
	.ascii	"PyMappingMethods\000"
.LASF430:
	.ascii	"_PyWeakref_RefType\000"
.LASF272:
	.ascii	"prefix\000"
.LASF597:
	.ascii	"slice_y\000"
.LASF461:
	.ascii	"PyExc_SyntaxError\000"
.LASF561:
	.ascii	"noise\000"
.LASF510:
	.ascii	"_PyOS_ReadlineTState\000"
.LASF184:
	.ascii	"PySuper_Type\000"
.LASF348:
	.ascii	"PyCFunction_Type\000"
.LASF121:
	.ascii	"tp_flags\000"
.LASF548:
	.ascii	"ch2_color\000"
.LASF474:
	.ascii	"PyExc_ZeroDivisionError\000"
.LASF284:
	.ascii	"Py_InteractiveFlag\000"
.LASF59:
	.ascii	"sys_nerr\000"
.LASF305:
	.ascii	"ob_digit\000"
.LASF339:
	.ascii	"PyODictKeys_Type\000"
.LASF201:
	.ascii	"nb_subtract\000"
.LASF182:
	.ascii	"PyType_Type\000"
.LASF546:
	.ascii	"out_pixbuf\000"
.LASF481:
	.ascii	"PyExc_ConnectionResetError\000"
.LASF334:
	.ascii	"PyDictRevIterKey_Type\000"
.LASF484:
	.ascii	"PyExc_InterruptedError\000"
.LASF365:
	.ascii	"_Py_EllipsisObject\000"
.LASF439:
	.ascii	"PyExc_StopAsyncIteration\000"
.LASF622:
	.ascii	"main\000"
.LASF317:
	.ascii	"PyRangeIter_Type\000"
.LASF602:
	.ascii	"write_buffer\000"
.LASF176:
	.ascii	"iternextfunc\000"
.LASF487:
	.ascii	"PyExc_PermissionError\000"
.LASF2:
	.ascii	"unsigned int\000"
.LASF420:
	.ascii	"getter\000"
.LASF470:
	.ascii	"PyExc_UnicodeEncodeError\000"
.LASF216:
	.ascii	"nb_int\000"
.LASF525:
	.ascii	"_Py_ctype_toupper\000"
.LASF135:
	.ascii	"tp_descr_set\000"
.LASF196:
	.ascii	"Py_buffer\000"
.LASF290:
	.ascii	"Py_IgnoreEnvironmentFlag\000"
.LASF10:
	.ascii	"short int\000"
.LASF498:
	.ascii	"PyExc_FutureWarning\000"
.LASF373:
	.ascii	"prev\000"
.LASF40:
	.ascii	"_vtable_offset\000"
.LASF376:
	.ascii	"frame\000"
.LASF235:
	.ascii	"nb_inplace_matrix_multiply\000"
.LASF104:
	.ascii	"tp_basicsize\000"
.LASF220:
	.ascii	"nb_inplace_subtract\000"
.LASF312:
	.ascii	"_Py_FalseStruct\000"
.LASF556:
	.ascii	"argv\000"
.LASF552:
	.ascii	"g_armwave_state\000"
.LASF204:
	.ascii	"nb_divmod\000"
.LASF528:
	.ascii	"flags\000"
.LASF81:
	.ascii	"tz_minuteswest\000"
.LASF163:
	.ascii	"objobjproc\000"
.LASF16:
	.ascii	"__quad_t\000"
.LASF416:
	.ascii	"PyAsyncGen_Type\000"
.LASF404:
	.ascii	"PyInterpreterState\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
