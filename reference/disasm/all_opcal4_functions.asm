
vendor/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

0005ffb0 <check_boundary>:
   60000: ee71 3be0    	vsub.f64	d19, d17, d16
   60004: ee42 3b81    	vmla.f64	d19, d18, d1
   60008: eef4 3b40    	vcmp.f64	d19, d0
   6000c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60010: d80a         	bhi	0x60028 <check_boundary+0x78> @ imm = #0x14
   60012: ee70 0ba1    	vadd.f64	d16, d16, d17
   60016: ee42 0b81    	vmla.f64	d16, d18, d1
   6001a: eef4 0b40    	vcmp.f64	d16, d0
   6001e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60022: bfa4         	itt	ge
   60024: 2001         	movge	r0, #0x1
   60026: 4770         	bxge	lr
   60028: 2000         	movs	r0, #0x0
   6002a: 4770         	bx	lr
   6002c: f2 b9 02 00  	.word	0x0002b9f2

00060030 <solve_linear>:
   60030: b084         	sub	sp, #0x10
   60032: b5f0         	push	{r4, r5, r6, r7, lr}
   60034: af03         	add	r7, sp, #0xc
   60036: e92d 0fe0    	push.w	{r5, r6, r7, r8, r9, r10, r11}
   6003a: f897 c0f8    	ldrb.w	r12, [r7, #0xf8]
   6003e: f107 0408    	add.w	r4, r7, #0x8
   60042: c40f         	stm	r4!, {r0, r1, r2, r3}
   60044: fa4f f08c    	sxtb.w	r0, r12
   60048: 2801         	cmp	r0, #0x1
   6004a: bfa2         	ittt	ge
   6004c: f107 0b08    	addge.w	r11, r7, #0x8
   60050: f99b 00f1    	ldrsbge.w	r0, [r11, #0xf1]
   60054: 2801         	cmpge	r0, #0x1
   60056: db07         	blt	0x60068 <solve_linear+0x38> @ imm = #0xe
   60058: f1bc 0f05    	cmp.w	r12, #0x5
   6005c: bf9c         	itt	ls
   6005e: fa5f f880    	uxtbls.w	r8, r0
   60062: f1b8 0f06    	cmpls.w	r8, #0x6
   60066: d905         	bls	0x60074 <solve_linear+0x44> @ imm = #0xa
   60068: e8bd 0f0e    	pop.w	{r1, r2, r3, r8, r9, r10, r11}
   6006c: e8bd 40f0    	pop.w	{r4, r5, r6, r7, lr}
   60070: b004         	add	sp, #0x10
   60072: 4770         	bx	lr
   60074: f1ac 0001    	sub.w	r0, r12, #0x1
   60078: ea4f 05c8    	lsl.w	r5, r8, #0x3
   6007c: f10b 0e30    	add.w	lr, r11, #0x30
   60080: 9001         	str	r0, [sp, #0x4]
   60082: f04f 0900    	mov.w	r9, #0x0
   60086: 4659         	mov	r1, r11
   60088: 9801         	ldr	r0, [sp, #0x4]
   6008a: 4581         	cmp	r9, r0
   6008c: d06c         	beq	0x60168 <solve_linear+0x138> @ imm = #0xd8
   6008e: eb09 0049    	add.w	r0, r9, r9, lsl #1
   60092: f109 0201    	add.w	r2, r9, #0x1
   60096: 4676         	mov	r6, lr
   60098: 9202         	str	r2, [sp, #0x8]
   6009a: eb0b 1000    	add.w	r0, r11, r0, lsl #4
   6009e: eb00 03c9    	add.w	r3, r0, r9, lsl #3
   600a2: 4562         	cmp	r2, r12
   600a4: d235         	bhs	0x60112 <solve_linear+0xe2> @ imm = #0x6a
   600a6: eb02 0042    	add.w	r0, r2, r2, lsl #1
   600aa: eb0b 1000    	add.w	r0, r11, r0, lsl #4
   600ae: eb00 00c9    	add.w	r0, r0, r9, lsl #3
   600b2: edd0 0b00    	vldr	d16, [r0]
   600b6: eef5 0b40    	vcmp.f64	d16, #0
   600ba: eef1 1b60    	vneg.f64	d17, d16
   600be: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   600c2: bf48         	it	mi
   600c4: eef0 0b61    	vmovmi.f64	d16, d17
   600c8: edd3 1b00    	vldr	d17, [r3]
   600cc: eef5 1b40    	vcmp.f64	d17, #0
   600d0: eef1 2b61    	vneg.f64	d18, d17
   600d4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   600d8: bf48         	it	mi
   600da: eef0 1b62    	vmovmi.f64	d17, d18
   600de: eef4 1b60    	vcmp.f64	d17, d16
   600e2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   600e6: d510         	bpl	0x6010a <solve_linear+0xda> @ imm = #0x20
   600e8: 4608         	mov	r0, r1
   600ea: 4674         	mov	r4, lr
   600ec: 46c2         	mov	r10, r8
   600ee: f1ba 0f00    	cmp.w	r10, #0x0
   600f2: d00a         	beq	0x6010a <solve_linear+0xda> @ imm = #0x14
   600f4: edd0 0b00    	vldr	d16, [r0]
   600f8: f1aa 0a01    	sub.w	r10, r10, #0x1
   600fc: edd4 1b00    	vldr	d17, [r4]
   60100: ece0 1b02    	vstmia	r0!, {d17}
   60104: ece4 0b02    	vstmia	r4!, {d16}
   60108: e7f1         	b	0x600ee <solve_linear+0xbe> @ imm = #-0x1e
   6010a: f10e 0e30    	add.w	lr, lr, #0x30
   6010e: 3201         	adds	r2, #0x1
   60110: e7c7         	b	0x600a2 <solve_linear+0x72> @ imm = #-0x72
   60112: 9c02         	ldr	r4, [sp, #0x8]
   60114: 46b6         	mov	lr, r6
   60116: 4632         	mov	r2, r6
   60118: 4564         	cmp	r4, r12
   6011a: d21f         	bhs	0x6015c <solve_linear+0x12c> @ imm = #0x3e
   6011c: eb04 0044    	add.w	r0, r4, r4, lsl #1
   60120: edd3 1b00    	vldr	d17, [r3]
   60124: eb0b 1000    	add.w	r0, r11, r0, lsl #4
   60128: eb00 00c9    	add.w	r0, r0, r9, lsl #3
   6012c: edd0 0b00    	vldr	d16, [r0]
   60130: 2000         	movs	r0, #0x0
   60132: eef1 0b60    	vneg.f64	d16, d16
   60136: eec0 0ba1    	vdiv.f64	d16, d16, d17
   6013a: 4285         	cmp	r5, r0
   6013c: d00b         	beq	0x60156 <solve_linear+0x126> @ imm = #0x16
   6013e: 180e         	adds	r6, r1, r0
   60140: edd6 1b00    	vldr	d17, [r6]
   60144: 1816         	adds	r6, r2, r0
   60146: 3008         	adds	r0, #0x8
   60148: edd6 2b00    	vldr	d18, [r6]
   6014c: ee40 2ba1    	vmla.f64	d18, d16, d17
   60150: edc6 2b00    	vstr	d18, [r6]
   60154: e7f1         	b	0x6013a <solve_linear+0x10a> @ imm = #-0x1e
   60156: 3230         	adds	r2, #0x30
   60158: 3401         	adds	r4, #0x1
   6015a: e7dd         	b	0x60118 <solve_linear+0xe8> @ imm = #-0x46
   6015c: f8dd 9008    	ldr.w	r9, [sp, #0x8]
   60160: 3130         	adds	r1, #0x30
   60162: f10e 0e30    	add.w	lr, lr, #0x30
   60166: e78f         	b	0x60088 <solve_linear+0x58> @ imm = #-0xe2
   60168: ebcc 00cc    	rsb	r0, r12, r12, lsl #3
   6016c: f8d7 9100    	ldr.w	r9, [r7, #0x100]
   60170: 9901         	ldr	r1, [sp, #0x4]
   60172: f1a8 0401    	sub.w	r4, r8, #0x1
   60176: eb0b 00c0    	add.w	r0, r11, r0, lsl #3
   6017a: eb09 0ecc    	add.w	lr, r9, r12, lsl #3
   6017e: f1a0 0a30    	sub.w	r10, r0, #0x30
   60182: 2900         	cmp	r1, #0x0
   60184: f53f af70    	bmi.w	0x60068 <solve_linear+0x38> @ imm = #-0x120
   60188: eb01 0041    	add.w	r0, r1, r1, lsl #1
   6018c: eb09 02c1    	add.w	r2, r9, r1, lsl #3
   60190: 4676         	mov	r6, lr
   60192: 4653         	mov	r3, r10
   60194: eb0b 1500    	add.w	r5, r11, r0, lsl #4
   60198: eb05 00c4    	add.w	r0, r5, r4, lsl #3
   6019c: edd0 0b00    	vldr	d16, [r0]
   601a0: 4660         	mov	r0, r12
   601a2: 42a0         	cmp	r0, r4
   601a4: edc2 0b00    	vstr	d16, [r2]
   601a8: da07         	bge	0x601ba <solve_linear+0x18a> @ imm = #0xe
   601aa: ecf6 1b02    	vldmia	r6!, {d17}
   601ae: 3001         	adds	r0, #0x1
   601b0: ecf3 2b02    	vldmia	r3!, {d18}
   601b4: ee42 0be1    	vmls.f64	d16, d18, d17
   601b8: e7f3         	b	0x601a2 <solve_linear+0x172> @ imm = #-0x1a
   601ba: eb05 00c1    	add.w	r0, r5, r1, lsl #3
   601be: f1ae 0e08    	sub.w	lr, lr, #0x8
   601c2: f1ac 0c01    	sub.w	r12, r12, #0x1
   601c6: f1aa 0a38    	sub.w	r10, r10, #0x38
   601ca: edd0 1b00    	vldr	d17, [r0]
   601ce: 3901         	subs	r1, #0x1
   601d0: eec0 0ba1    	vdiv.f64	d16, d16, d17
   601d4: edc2 0b00    	vstr	d16, [r2]
   601d8: e7d3         	b	0x60182 <solve_linear+0x152> @ imm = #-0x5a
   601da: d4d4         	bmi	0x60186 <solve_linear+0x156> @ imm = #-0x58
   601dc: d4d4         	bmi	0x60188 <solve_linear+0x158> @ imm = #-0x58
   601de: d4d4         	bmi	0x6018a <solve_linear+0x15a> @ imm = #-0x58

000601e0 <apply_simple_smooth>:
   601e0: b5f0         	push	{r4, r5, r6, r7, lr}
   601e2: af03         	add	r7, sp, #0xc
   601e4: f84d 8d04    	str	r8, [sp, #-4]!
   601e8: ed2d 8b02    	vpush	{d8}
   601ec: b0b8         	sub	sp, #0xe0
   601ee: 4605         	mov	r5, r0
   601f0: 4845         	ldr	r0, [pc, #0x114]        @ 0x60308 <apply_simple_smooth+0x128>
   601f2: 4688         	mov	r8, r1
   601f4: 4614         	mov	r4, r2
   601f6: 4478         	add	r0, pc
   601f8: 2238         	movs	r2, #0x38
   601fa: 6800         	ldr	r0, [r0]
   601fc: 6800         	ldr	r0, [r0]
   601fe: 9037         	str	r0, [sp, #0xdc]
   60200: a828         	add	r0, sp, #0xa0
   60202: 4942         	ldr	r1, [pc, #0x108]        @ 0x6030c <apply_simple_smooth+0x12c>
   60204: 4479         	add	r1, pc
   60206: f00e ef04    	blx	0x6f010 <sincos+0x6f010> @ imm = #0xee08
   6020a: 4841         	ldr	r0, [pc, #0x104]        @ 0x60310 <apply_simple_smooth+0x130>
   6020c: 4478         	add	r0, pc
   6020e: f890 1210    	ldrb.w	r1, [r0, #0x210]
   60212: 42a9         	cmp	r1, r5
   60214: d90d         	bls	0x60232 <apply_simple_smooth+0x52> @ imm = #0x1a
   60216: eb08 00c1    	add.w	r0, r8, r1, lsl #3
   6021a: 2100         	movs	r1, #0x0
   6021c: 3838         	subs	r0, #0x38
   6021e: 2938         	cmp	r1, #0x38
   60220: d05e         	beq	0x602e0 <apply_simple_smooth+0x100> @ imm = #0xbc
   60222: 1843         	adds	r3, r0, r1
   60224: 1862         	adds	r2, r4, r1
   60226: 3108         	adds	r1, #0x8
   60228: edd3 0b00    	vldr	d16, [r3]
   6022c: edc2 0b00    	vstr	d16, [r2]
   60230: e7f5         	b	0x6021e <apply_simple_smooth+0x3e> @ imm = #-0x16
   60232: 4640         	mov	r0, r8
   60234: f7fe ffc4    	bl	0x5f1c0 <math_std>      @ imm = #-0x1078
   60238: eddf 0b31    	vldr	d16, [pc, #196]         @ 0x60300 <apply_simple_smooth+0x120>
   6023c: eeb4 0b60    	vcmp.f64	d0, d16
   60240: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60244: d50c         	bpl	0x60260 <apply_simple_smooth+0x80> @ imm = #0x18
   60246: f108 0018    	add.w	r0, r8, #0x18
   6024a: 2100         	movs	r1, #0x0
   6024c: 2938         	cmp	r1, #0x38
   6024e: d047         	beq	0x602e0 <apply_simple_smooth+0x100> @ imm = #0x8e
   60250: 1843         	adds	r3, r0, r1
   60252: 1862         	adds	r2, r4, r1
   60254: 3108         	adds	r1, #0x8
   60256: edd3 0b00    	vldr	d16, [r3]
   6025a: edc2 0b00    	vstr	d16, [r2]
   6025e: e7f5         	b	0x6024c <apply_simple_smooth+0x6c> @ imm = #-0x16
   60260: ad14         	add	r5, sp, #0x50
   60262: 2150         	movs	r1, #0x50
   60264: eeb0 8b40    	vmov.f64	d8, d0
   60268: 4628         	mov	r0, r5
   6026a: f00e eeca    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xed94
   6026e: 466e         	mov	r6, sp
   60270: 2150         	movs	r1, #0x50
   60272: 4630         	mov	r0, r6
   60274: f00e eec4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xed88
   60278: eeb0 0b48    	vmov.f64	d0, d8
   6027c: a928         	add	r1, sp, #0xa0
   6027e: 4640         	mov	r0, r8
   60280: 4632         	mov	r2, r6
   60282: f7ff faf3    	bl	0x5f86c <smooth_sg>     @ imm = #-0xa1a
   60286: 2000         	movs	r0, #0x0
   60288: 2850         	cmp	r0, #0x50
   6028a: d007         	beq	0x6029c <apply_simple_smooth+0xbc> @ imm = #0xe
   6028c: 1832         	adds	r2, r6, r0
   6028e: 1829         	adds	r1, r5, r0
   60290: 3008         	adds	r0, #0x8
   60292: edd2 0b00    	vldr	d16, [r2]
   60296: edc1 0b00    	vstr	d16, [r1]
   6029a: e7f5         	b	0x60288 <apply_simple_smooth+0xa8> @ imm = #-0x16
   6029c: eef6 0b00    	vmov.f64	d16, #5.000000e-01
   602a0: f105 0008    	add.w	r0, r5, #0x8
   602a4: 2100         	movs	r1, #0x0
   602a6: 2940         	cmp	r1, #0x40
   602a8: d00d         	beq	0x602c6 <apply_simple_smooth+0xe6> @ imm = #0x1a
   602aa: 1873         	adds	r3, r6, r1
   602ac: 1842         	adds	r2, r0, r1
   602ae: 3108         	adds	r1, #0x8
   602b0: edd3 1b00    	vldr	d17, [r3]
   602b4: edd3 2b04    	vldr	d18, [r3, #16]
   602b8: ee71 1ba2    	vadd.f64	d17, d17, d18
   602bc: ee61 1ba0    	vmul.f64	d17, d17, d16
   602c0: edc2 1b00    	vstr	d17, [r2]
   602c4: e7ef         	b	0x602a6 <apply_simple_smooth+0xc6> @ imm = #-0x22
   602c6: f105 0018    	add.w	r0, r5, #0x18
   602ca: 2100         	movs	r1, #0x0
   602cc: 2938         	cmp	r1, #0x38
   602ce: d007         	beq	0x602e0 <apply_simple_smooth+0x100> @ imm = #0xe
   602d0: 1843         	adds	r3, r0, r1
   602d2: 1862         	adds	r2, r4, r1
   602d4: 3108         	adds	r1, #0x8
   602d6: edd3 0b00    	vldr	d16, [r3]
   602da: edc2 0b00    	vstr	d16, [r2]
   602de: e7f5         	b	0x602cc <apply_simple_smooth+0xec> @ imm = #-0x16
   602e0: 9837         	ldr	r0, [sp, #0xdc]
   602e2: 490c         	ldr	r1, [pc, #0x30]         @ 0x60314 <apply_simple_smooth+0x134>
   602e4: 4479         	add	r1, pc
   602e6: 6809         	ldr	r1, [r1]
   602e8: 6809         	ldr	r1, [r1]
   602ea: 4281         	cmp	r1, r0
   602ec: bf01         	itttt	eq
   602ee: b038         	addeq	sp, #0xe0
   602f0: ecbd 8b02    	vpopeq	{d8}
   602f4: f85d 8b04    	ldreq	r8, [sp], #4
   602f8: bdf0         	popeq	{r4, r5, r6, r7, pc}
   602fa: f00e ee9a    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xed34
   602fe: bf00         	nop
   60300: f1 68 e3 88  	.word	0x88e368f1
   60304: b5 f8 e4 3e  	.word	0x3ee4f8b5
   60308: da 2f 01 00  	.word	0x00012fda
   6030c: 00 90 fc ff  	.word	0xfffc9000
   60310: 98 b7 02 00  	.word	0x0002b798
   60314: ec 2e 01 00  	.word	0x00012eec

00060318 <smooth1q_err16>:
   60318: b5f0         	push	{r4, r5, r6, r7, lr}
   6031a: af03         	add	r7, sp, #0xc
   6031c: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   60320: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   60324: f5ad 6d9d    	sub.w	sp, sp, #0x4e8
   60328: 9201         	str	r2, [sp, #0x4]
   6032a: 4682         	mov	r10, r0
   6032c: 487c         	ldr	r0, [pc, #0x1f0]        @ 0x60520 <smooth1q_err16+0x208>
   6032e: 468b         	mov	r11, r1
   60330: f44f 71c8    	mov.w	r1, #0x190
   60334: 4478         	add	r0, pc
   60336: 6800         	ldr	r0, [r0]
   60338: 6800         	ldr	r0, [r0]
   6033a: f847 0c68    	str	r0, [r7, #-104]
   6033e: aed4         	add	r6, sp, #0x350
   60340: 4630         	mov	r0, r6
   60342: f00e ee5e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xecbc
   60346: ee00 ba10    	vmov	s0, r11
   6034a: ed9f 9b6d    	vldr	d9, [pc, #436]          @ 0x60500 <smooth1q_err16+0x1e8>
   6034e: eeb0 ab00    	vmov.f64	d10, #2.000000e+00
   60352: ea4f 044b    	lsl.w	r4, r11, #0x1
   60356: 2500         	movs	r5, #0x0
   60358: eeb8 8b40    	vcvt.f64.u32	d8, s0
   6035c: 42ac         	cmp	r4, r5
   6035e: d015         	beq	0x6038c <smooth1q_err16+0x74> @ imm = #0x2a
   60360: ee00 5a10    	vmov	s0, r5
   60364: eef8 0bc0    	vcvt.f64.s32	d16, s0
   60368: ee60 0b89    	vmul.f64	d16, d16, d9
   6036c: eec0 0b88    	vdiv.f64	d16, d16, d8
   60370: ec51 0b30    	vmov	r0, r1, d16
   60374: f00e eeac    	blx	0x6f0d0 <sincos+0x6f0d0> @ imm = #0xed58
   60378: ec41 0b30    	vmov	d16, r0, r1
   6037c: 3502         	adds	r5, #0x2
   6037e: ee70 0ba0    	vadd.f64	d16, d16, d16
   60382: ee7a 0b60    	vsub.f64	d16, d10, d16
   60386: ece6 0b02    	vstmia	r6!, {d16}
   6038a: e7e7         	b	0x6035c <smooth1q_err16+0x44> @ imm = #-0x32
   6038c: a80c         	add	r0, sp, #0x30
   6038e: f44f 7148    	mov.w	r1, #0x320
   60392: f00e ee36    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xec6c
   60396: eeb7 bb00    	vmov.f64	d11, #1.000000e+00
   6039a: ac0a         	add	r4, sp, #0x28
   6039c: ae08         	add	r6, sp, #0x20
   6039e: f04f 0800    	mov.w	r8, #0x0
   603a2: ef80 9010    	vmov.i32	d9, #0x0
   603a6: ed9f cb5a    	vldr	d12, [pc, #360]         @ 0x60510 <smooth1q_err16+0x1f8>
   603aa: efc0 1010    	vmov.i32	d17, #0x0
   603ae: 45d8         	cmp	r8, r11
   603b0: d054         	beq	0x6045c <smooth1q_err16+0x144> @ imm = #0xa8
   603b2: eddf 0b55    	vldr	d16, [pc, #340]         @ 0x60508 <smooth1q_err16+0x1f0>
   603b6: ef80 e010    	vmov.i32	d14, #0x0
   603ba: ef80 d010    	vmov.i32	d13, #0x0
   603be: 4655         	mov	r5, r10
   603c0: ee21 aba0    	vmul.f64	d10, d17, d16
   603c4: 46d9         	mov	r9, r11
   603c6: ef80 f010    	vmov.i32	d15, #0x0
   603ca: edcd 1b02    	vstr	d17, [sp, #8]
   603ce: f1b9 0f00    	cmp.w	r9, #0x0
   603d2: d020         	beq	0x60416 <smooth1q_err16+0xfe> @ imm = #0x40
   603d4: ee6a 0b0d    	vmul.f64	d16, d10, d13
   603d8: 4622         	mov	r2, r4
   603da: 4633         	mov	r3, r6
   603dc: eec0 0b88    	vdiv.f64	d16, d16, d8
   603e0: ec51 0b30    	vmov	r0, r1, d16
   603e4: f00e ee64    	blx	0x6f0b0 <sincos+0x6f0b0> @ imm = #0xecc8
   603e8: eddd 0b08    	vldr	d16, [sp, #32]
   603ec: f1a9 0901    	sub.w	r9, r9, #0x1
   603f0: ecf5 2b02    	vldmia	r5!, {d18}
   603f4: ee60 1b89    	vmul.f64	d17, d16, d9
   603f8: eddd 3b0a    	vldr	d19, [sp, #40]
   603fc: ee3d db0b    	vadd.f64	d13, d13, d11
   60400: ee42 1ba3    	vmla.f64	d17, d18, d19
   60404: ee3e eb21    	vadd.f64	d14, d14, d17
   60408: ee63 1b8c    	vmul.f64	d17, d19, d12
   6040c: ee42 1ba0    	vmla.f64	d17, d18, d16
   60410: ee3f fb21    	vadd.f64	d15, d15, d17
   60414: e7db         	b	0x603ce <smooth1q_err16+0xb6> @ imm = #-0x4a
   60416: a8d4         	add	r0, sp, #0x350
   60418: eef0 2b4b    	vmov.f64	d18, d11
   6041c: eb00 00c8    	add.w	r0, r0, r8, lsl #3
   60420: edd0 0b00    	vldr	d16, [r0]
   60424: a80c         	add	r0, sp, #0x30
   60426: eb00 1008    	add.w	r0, r0, r8, lsl #4
   6042a: f108 0801    	add.w	r8, r8, #0x1
   6042e: ee60 1b88    	vmul.f64	d17, d16, d8
   60432: ee41 2ba0    	vmla.f64	d18, d17, d16
   60436: eecb 0b22    	vdiv.f64	d16, d11, d18
   6043a: ee6f 1b09    	vmul.f64	d17, d15, d9
   6043e: ee6e 2b0c    	vmul.f64	d18, d14, d12
   60442: ee40 1b8e    	vmla.f64	d17, d16, d14
   60446: ee40 2b8f    	vmla.f64	d18, d16, d15
   6044a: edc0 1b02    	vstr	d17, [r0, #8]
   6044e: eddd 1b02    	vldr	d17, [sp, #8]
   60452: edc0 2b00    	vstr	d18, [r0]
   60456: ee71 1b8b    	vadd.f64	d17, d17, d11
   6045a: e7a8         	b	0x603ae <smooth1q_err16+0x96> @ imm = #-0xb0
   6045c: ed9f 9b2e    	vldr	d9, [pc, #184]          @ 0x60518 <smooth1q_err16+0x200>
   60460: f10d 0a18    	add.w	r10, sp, #0x18
   60464: f10d 0910    	add.w	r9, sp, #0x10
   60468: a80c         	add	r0, sp, #0x30
   6046a: 2500         	movs	r5, #0x0
   6046c: 3008         	adds	r0, #0x8
   6046e: 9002         	str	r0, [sp, #0x8]
   60470: 455d         	cmp	r5, r11
   60472: d032         	beq	0x604da <smooth1q_err16+0x1c2> @ imm = #0x64
   60474: ef80 a010    	vmov.i32	d10, #0x0
   60478: 2400         	movs	r4, #0x0
   6047a: 9e02         	ldr	r6, [sp, #0x8]
   6047c: 46d8         	mov	r8, r11
   6047e: f1bb 0f00    	cmp.w	r11, #0x0
   60482: d022         	beq	0x604ca <smooth1q_err16+0x1b2> @ imm = #0x44
   60484: ee00 4a10    	vmov	s0, r4
   60488: 4652         	mov	r2, r10
   6048a: 464b         	mov	r3, r9
   6048c: eef8 0bc0    	vcvt.f64.s32	d16, s0
   60490: ee60 0b89    	vmul.f64	d16, d16, d9
   60494: eec0 0b88    	vdiv.f64	d16, d16, d8
   60498: ec51 0b30    	vmov	r0, r1, d16
   6049c: f00e ee08    	blx	0x6f0b0 <sincos+0x6f0b0> @ imm = #0xec10
   604a0: ed56 0b02    	vldr	d16, [r6, #-8]
   604a4: 442c         	add	r4, r5
   604a6: eddd 2b04    	vldr	d18, [sp, #16]
   604aa: f1ab 0b01    	sub.w	r11, r11, #0x1
   604ae: edd6 1b00    	vldr	d17, [r6]
   604b2: 3610         	adds	r6, #0x10
   604b4: ee60 0ba2    	vmul.f64	d16, d16, d18
   604b8: eddd 2b06    	vldr	d18, [sp, #24]
   604bc: ee42 0be1    	vmls.f64	d16, d18, d17
   604c0: eec0 0b88    	vdiv.f64	d16, d16, d8
   604c4: ee3a ab20    	vadd.f64	d10, d10, d16
   604c8: e7d9         	b	0x6047e <smooth1q_err16+0x166> @ imm = #-0x4e
   604ca: 9801         	ldr	r0, [sp, #0x4]
   604cc: 46c3         	mov	r11, r8
   604ce: eb00 00c5    	add.w	r0, r0, r5, lsl #3
   604d2: 3501         	adds	r5, #0x1
   604d4: ed80 ab00    	vstr	d10, [r0]
   604d8: e7ca         	b	0x60470 <smooth1q_err16+0x158> @ imm = #-0x6c
   604da: f857 0c68    	ldr	r0, [r7, #-104]
   604de: 4911         	ldr	r1, [pc, #0x44]         @ 0x60524 <smooth1q_err16+0x20c>
   604e0: 4479         	add	r1, pc
   604e2: 6809         	ldr	r1, [r1]
   604e4: 6809         	ldr	r1, [r1]
   604e6: 4281         	cmp	r1, r0
   604e8: bf01         	itttt	eq
   604ea: f50d 6d9d    	addeq.w	sp, sp, #0x4e8
   604ee: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   604f2: b001         	addeq	sp, #0x4
   604f4: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   604f8: bf08         	it	eq
   604fa: bdf0         	popeq	{r4, r5, r6, r7, pc}
   604fc: f00e ed98    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xeb30
   60500: 18 2d 44 54  	.word	0x54442d18
   60504: fb 21 09 40  	.word	0x400921fb
   60508: 18 2d 44 54  	.word	0x54442d18
   6050c: fb 21 19 c0  	.word	0xc01921fb
   60510: 00 00 00 00  	.word	0x00000000
   60514: 00 00 00 80  	.word	0x80000000
   60518: 18 2d 44 54  	.word	0x54442d18
   6051c: fb 21 19 40  	.word	0x401921fb
   60520: 9c 2e 01 00  	.word	0x00012e9c
   60524: f0 2c 01 00  	.word	0x00012cf0

00060528 <f_cgm_trend>:
   60528: b5f0         	push	{r4, r5, r6, r7, lr}
   6052a: af03         	add	r7, sp, #0xc
   6052c: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   60530: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   60534: f5ad 5d49    	sub.w	sp, sp, #0x3240
   60538: b08e         	sub	sp, #0x38
   6053a: 4682         	mov	r10, r0
   6053c: f8df 0768    	ldr.w	r0, [pc, #0x768]        @ 0x60ca8 <f_cgm_trend+0x780>
   60540: f50d 59b9    	add.w	r9, sp, #0x1720
   60544: f641 3108    	movw	r1, #0x1b08
   60548: 4478         	add	r0, pc
   6054a: 461e         	mov	r6, r3
   6054c: 4615         	mov	r5, r2
   6054e: 6800         	ldr	r0, [r0]
   60550: 6800         	ldr	r0, [r0]
   60552: f847 0c6c    	str	r0, [r7, #-108]
   60556: 6bf8         	ldr	r0, [r7, #0x3c]
   60558: f847 0c74    	str	r0, [r7, #-116]
   6055c: 6bb8         	ldr	r0, [r7, #0x38]
   6055e: f847 0c78    	str	r0, [r7, #-120]
   60562: 6b78         	ldr	r0, [r7, #0x34]
   60564: f847 0c7c    	str	r0, [r7, #-124]
   60568: 6b38         	ldr	r0, [r7, #0x30]
   6056a: f847 0c80    	str	r0, [r7, #-128]
   6056e: 6af8         	ldr	r0, [r7, #0x2c]
   60570: f847 0c84    	str	r0, [r7, #-132]
   60574: 6ab8         	ldr	r0, [r7, #0x28]
   60576: f847 0c88    	str	r0, [r7, #-136]
   6057a: 6a78         	ldr	r0, [r7, #0x24]
   6057c: f847 0c8c    	str	r0, [r7, #-140]
   60580: 6a38         	ldr	r0, [r7, #0x20]
   60582: f847 0c90    	str	r0, [r7, #-144]
   60586: 69f8         	ldr	r0, [r7, #0x1c]
   60588: f847 0c94    	str	r0, [r7, #-148]
   6058c: 69b8         	ldr	r0, [r7, #0x18]
   6058e: f847 0c98    	str	r0, [r7, #-152]
   60592: 6978         	ldr	r0, [r7, #0x14]
   60594: f847 0c9c    	str	r0, [r7, #-156]
   60598: 6938         	ldr	r0, [r7, #0x10]
   6059a: f847 0ca0    	str	r0, [r7, #-160]
   6059e: 68f8         	ldr	r0, [r7, #0xc]
   605a0: f847 0ca4    	str	r0, [r7, #-164]
   605a4: 68b8         	ldr	r0, [r7, #0x8]
   605a6: f847 0ca8    	str	r0, [r7, #-168]
   605aa: f8ba b641    	ldrh.w	r11, [r10, #0x641]
   605ae: 48dd         	ldr	r0, [pc, #0x374]        @ 0x60924 <f_cgm_trend+0x3fc>
   605b0: e947 232c    	strd	r2, r3, [r7, #-176]
   605b4: 4478         	add	r0, pc
   605b6: 8804         	ldrh	r4, [r0]
   605b8: 4648         	mov	r0, r9
   605ba: f00e ed22    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xea44
   605be: edd7 0b02    	vldr	d16, [r7, #8]
   605c2: ec46 5b1a    	vmov	d10, r5, r6
   605c6: 4ad8         	ldr	r2, [pc, #0x360]        @ 0x60928 <f_cgm_trend+0x400>
   605c8: f20a 6643    	addw	r6, r10, #0x643
   605cc: eebd 0be0    	vcvt.s32.f64	s0, d16
   605d0: e9d7 5c10    	ldrd	r5, r12, [r7, #64]
   605d4: 2100         	movs	r1, #0x0
   605d6: ee10 0a10    	vmov	r0, s0
   605da: ed97 8b0c    	vldr	d8, [r7, #48]
   605de: 1a20         	subs	r0, r4, r0
   605e0: ed97 9b0a    	vldr	d9, [r7, #40]
   605e4: edd7 0b04    	vldr	d16, [r7, #16]
   605e8: b152         	cbz	r2, 0x60600 <f_cgm_trend+0xd8> @ imm = #0x14
   605ea: 18b3         	adds	r3, r6, r2
   605ec: f8b3 36c2    	ldrh.w	r3, [r3, #0x6c2]
   605f0: b123         	cbz	r3, 0x605fc <f_cgm_trend+0xd4> @ imm = #0x8
   605f2: 4298         	cmp	r0, r3
   605f4: dc02         	bgt	0x605fc <f_cgm_trend+0xd4> @ imm = #0x4
   605f6: 42a3         	cmp	r3, r4
   605f8: bf98         	it	ls
   605fa: 3101         	addls	r1, #0x1
   605fc: 3202         	adds	r2, #0x2
   605fe: e7f3         	b	0x605e8 <f_cgm_trend+0xc0> @ imm = #-0x1a
   60600: fa1f f881    	uxth.w	r8, r1
   60604: ee00 8a10    	vmov	s0, r8
   60608: eef8 1b40    	vcvt.f64.u32	d17, s0
   6060c: eef4 0b61    	vcmp.f64	d16, d17
   60610: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60614: d911         	bls	0x6063a <f_cgm_trend+0x112> @ imm = #0x22
   60616: f1bb 0f02    	cmp.w	r11, #0x2
   6061a: d348         	blo	0x606ae <f_cgm_trend+0x186> @ imm = #0x90
   6061c: edd5 0b02    	vldr	d16, [r5, #8]
   60620: f1bc 0f02    	cmp.w	r12, #0x2
   60624: edc5 0b00    	vstr	d16, [r5]
   60628: f040 81b7    	bne.w	0x6099a <f_cgm_trend+0x472> @ imm = #0x36e
   6062c: 48bf         	ldr	r0, [pc, #0x2fc]        @ 0x6092c <f_cgm_trend+0x404>
   6062e: 4450         	add	r0, r10
   60630: f960 070f    	vld1.8	{d16}, [r0]
   60634: edc5 0b16    	vstr	d16, [r5, #88]
   60638: e1b5         	b	0x609a6 <f_cgm_trend+0x47e> @ imm = #0x36a
   6063a: f240 3061    	movw	r0, #0x361
   6063e: eba0 0308    	sub.w	r3, r0, r8
   60642: f24c 41cc    	movw	r1, #0xc4cc
   60646: ed9f bbba    	vldr	d11, [pc, #744]         @ 0x60930 <f_cgm_trend+0x408>
   6064a: eb0a 00c3    	add.w	r0, r10, r3, lsl #3
   6064e: 46de         	mov	lr, r11
   60650: 4408         	add	r0, r1
   60652: f04f 0b00    	mov.w	r11, #0x0
   60656: 4645         	mov	r5, r8
   60658: 4641         	mov	r1, r8
   6065a: b1a9         	cbz	r1, 0x60688 <f_cgm_trend+0x160> @ imm = #0x2a
   6065c: f960 070f    	vld1.8	{d16}, [r0]
   60660: eef0 1be0    	vabs.f64	d17, d16
   60664: eef4 1b4b    	vcmp.f64	d17, d11
   60668: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6066c: d009         	beq	0x60682 <f_cgm_trend+0x15a> @ imm = #0x12
   6066e: d608         	bvs	0x60682 <f_cgm_trend+0x15a> @ imm = #0x10
   60670: e7ff         	b	0x60672 <f_cgm_trend+0x14a> @ imm = #-0x2
   60672: fa1f f28b    	uxth.w	r2, r11
   60676: f10b 0b01    	add.w	r11, r11, #0x1
   6067a: eb09 02c2    	add.w	r2, r9, r2, lsl #3
   6067e: edc2 0b00    	vstr	d16, [r2]
   60682: 3008         	adds	r0, #0x8
   60684: 3901         	subs	r1, #0x1
   60686: e7e8         	b	0x6065a <f_cgm_trend+0x132> @ imm = #-0x30
   60688: f1bc 0f00    	cmp.w	r12, #0x0
   6068c: e9cd 6e01    	strd	r6, lr, [sp, #4]
   60690: 9403         	str	r4, [sp, #0xc]
   60692: d02a         	beq	0x606ea <f_cgm_trend+0x1c2> @ imm = #0x54
   60694: f1bc 0f01    	cmp.w	r12, #0x1
   60698: f040 8123    	bne.w	0x608e2 <f_cgm_trend+0x3ba> @ imm = #0x246
   6069c: f50d 50b9    	add.w	r0, sp, #0x1720
   606a0: fa1f f18b    	uxth.w	r1, r11
   606a4: 2214         	movs	r2, #0x14
   606a6: 461e         	mov	r6, r3
   606a8: f000 fb4e    	bl	0x60d48 <f_trimmed_mean> @ imm = #0x69c
   606ac: e025         	b	0x606fa <f_cgm_trend+0x1d2> @ imm = #0x4a
   606ae: 48a2         	ldr	r0, [pc, #0x288]        @ 0x60938 <f_cgm_trend+0x410>
   606b0: 2100         	movs	r1, #0x0
   606b2: f1bc 0f02    	cmp.w	r12, #0x2
   606b6: f44f 54d8    	mov.w	r4, #0x1b00
   606ba: e9c5 1000    	strd	r1, r0, [r5]
   606be: bf1a         	itte	ne
   606c0: e9c5 1022    	strdne	r1, r0, [r5, #136]
   606c4: f105 0198    	addne.w	r1, r5, #0x98
   606c8: f105 0158    	addeq.w	r1, r5, #0x58
   606cc: 6a2b         	ldr	r3, [r5, #0x20]
   606ce: 2200         	movs	r2, #0x0
   606d0: 600a         	str	r2, [r1]
   606d2: 511a         	str	r2, [r3, r4]
   606d4: 6048         	str	r0, [r1, #0x4]
   606d6: f503 51d8    	add.w	r1, r3, #0x1b00
   606da: 6048         	str	r0, [r1, #0x4]
   606dc: e9c5 2012    	strd	r2, r0, [r5, #72]
   606e0: e9c5 200e    	strd	r2, r0, [r5, #56]
   606e4: e9c5 200a    	strd	r2, r0, [r5, #40]
   606e8: e2bc         	b	0x60c64 <f_cgm_trend+0x73c> @ imm = #0x578
   606ea: f50d 50b9    	add.w	r0, sp, #0x1720
   606ee: fa1f f18b    	uxth.w	r1, r11
   606f2: 220a         	movs	r2, #0xa
   606f4: 461e         	mov	r6, r3
   606f6: f000 fadf    	bl	0x60cb8 <calcPercentile> @ imm = #0x5be
   606fa: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   606fe: 4633         	mov	r3, r6
   60700: 6bfa         	ldr	r2, [r7, #0x3c]
   60702: f04f 0900    	mov.w	r9, #0x0
   60706: f8dc 0010    	ldr.w	r0, [r12, #0x10]
   6070a: ed8c 0b00    	vstr	d0, [r12]
   6070e: f500 51d8    	add.w	r1, r0, #0x1b00
   60712: eb00 00c6    	add.w	r0, r0, r6, lsl #3
   60716: ed81 0b00    	vstr	d0, [r1]
   6071a: b17d         	cbz	r5, 0x6073c <f_cgm_trend+0x214> @ imm = #0x1e
   6071c: ecf0 0b02    	vldmia	r0!, {d16}
   60720: f109 0101    	add.w	r1, r9, #0x1
   60724: eef0 0be0    	vabs.f64	d16, d16
   60728: eef4 0b4b    	vcmp.f64	d16, d11
   6072c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60730: bf48         	it	mi
   60732: 4689         	movmi	r9, r1
   60734: bfc8         	it	gt
   60736: 4689         	movgt	r9, r1
   60738: 3d01         	subs	r5, #0x1
   6073a: e7ee         	b	0x6071a <f_cgm_trend+0x1f2> @ imm = #-0x24
   6073c: f641 3008    	movw	r0, #0x1b08
   60740: 2401         	movs	r4, #0x1
   60742: eba0 00c8    	sub.w	r0, r0, r8, lsl #3
   60746: 9006         	str	r0, [sp, #0x18]
   60748: 6c78         	ldr	r0, [r7, #0x44]
   6074a: ef80 c050    	vmov.i32	q6, #0x0
   6074e: f1a7 06b0    	sub.w	r6, r7, #0xb0
   60752: ed9f eb7b    	vldr	d14, [pc, #492]         @ 0x60940 <f_cgm_trend+0x418>
   60756: 2800         	cmp	r0, #0x0
   60758: eb0a 0043    	add.w	r0, r10, r3, lsl #1
   6075c: f200 6043    	addw	r0, r0, #0x643
   60760: bf08         	it	eq
   60762: 2402         	moveq	r4, #0x2
   60764: 9009         	str	r0, [sp, #0x24]
   60766: f60a 5005    	addw	r0, r10, #0xd05
   6076a: 9008         	str	r0, [sp, #0x20]
   6076c: f2a3 3061    	subw	r0, r3, #0x361
   60770: f04f 0a00    	mov.w	r10, #0x0
   60774: 9004         	str	r0, [sp, #0x10]
   60776: b290         	uxth	r0, r2
   60778: 9007         	str	r0, [sp, #0x1c]
   6077a: 9405         	str	r4, [sp, #0x14]
   6077c: 45a2         	cmp	r10, r4
   6077e: f000 8147    	beq.w	0x60a10 <f_cgm_trend+0x4e8> @ imm = #0x28e
   60782: a80a         	add	r0, sp, #0x28
   60784: f44f 6116    	mov.w	r1, #0x960
   60788: f00e ec3a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xe874
   6078c: f50d 605c    	add.w	r0, sp, #0xdc0
   60790: f44f 6116    	mov.w	r1, #0x960
   60794: f00e ec34    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xe868
   60798: eb06 004a    	add.w	r0, r6, r10, lsl #1
   6079c: 8f05         	ldrh	r5, [r0, #0x38]
   6079e: fa1f f089    	uxth.w	r0, r9
   607a2: 4285         	cmp	r5, r0
   607a4: d23f         	bhs	0x60826 <f_cgm_trend+0x2fe> @ imm = #0x7e
   607a6: 9c06         	ldr	r4, [sp, #0x18]
   607a8: 2600         	movs	r6, #0x0
   607aa: f8dd 8010    	ldr.w	r8, [sp, #0x10]
   607ae: f04f 0b00    	mov.w	r11, #0x0
   607b2: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   607b6: f1b8 0f00    	cmp.w	r8, #0x0
   607ba: d03f         	beq	0x6083c <f_cgm_trend+0x314> @ imm = #0x7e
   607bc: f8dc 0010    	ldr.w	r0, [r12, #0x10]
   607c0: 4420         	add	r0, r4
   607c2: ed90 fb00    	vldr	d15, [r0]
   607c6: eef0 0bcf    	vabs.f64	d16, d15
   607ca: eef4 0b4b    	vcmp.f64	d16, d11
   607ce: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   607d2: d024         	beq	0x6081e <f_cgm_trend+0x2f6> @ imm = #0x48
   607d4: d623         	bvs	0x6081e <f_cgm_trend+0x2f6> @ imm = #0x46
   607d6: e7ff         	b	0x607d8 <f_cgm_trend+0x2b0> @ imm = #-0x2
   607d8: fa1f f08b    	uxth.w	r0, r11
   607dc: 4629         	mov	r1, r5
   607de: f00e ead2    	blx	0x6ed84 <__aeabi_uidivmod> @ imm = #0xe5a4
   607e2: b9c1         	cbnz	r1, 0x60816 <f_cgm_trend+0x2ee> @ imm = #0x30
   607e4: 4858         	ldr	r0, [pc, #0x160]        @ 0x60948 <f_cgm_trend+0x420>
   607e6: f50d 615c    	add.w	r1, sp, #0xdc0
   607ea: ea00 00c6    	and.w	r0, r0, r6, lsl #3
   607ee: 3601         	adds	r6, #0x1
   607f0: 4401         	add	r1, r0
   607f2: ed81 fb00    	vstr	d15, [r1]
   607f6: a90a         	add	r1, sp, #0x28
   607f8: 4408         	add	r0, r1
   607fa: 9908         	ldr	r1, [sp, #0x20]
   607fc: 9a09         	ldr	r2, [sp, #0x24]
   607fe: f831 1018    	ldrh.w	r1, [r1, r8, lsl #1]
   60802: 8812         	ldrh	r2, [r2]
   60804: 1a89         	subs	r1, r1, r2
   60806: ee00 1a10    	vmov	s0, r1
   6080a: eef8 0bc0    	vcvt.f64.s32	d16, s0
   6080e: eec0 0b8e    	vdiv.f64	d16, d16, d14
   60812: edc0 0b00    	vstr	d16, [r0]
   60816: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6081a: f10b 0b01    	add.w	r11, r11, #0x1
   6081e: 3408         	adds	r4, #0x8
   60820: f108 0801    	add.w	r8, r8, #0x1
   60824: e7c7         	b	0x607b6 <f_cgm_trend+0x28e> @ imm = #-0x72
   60826: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6082a: 2100         	movs	r1, #0x0
   6082c: 4a42         	ldr	r2, [pc, #0x108]        @ 0x60938 <f_cgm_trend+0x410>
   6082e: eb0c 00ca    	add.w	r0, r12, r10, lsl #3
   60832: e9c0 1222    	strd	r1, r2, [r0, #136]
   60836: e9c0 1226    	strd	r1, r2, [r0, #152]
   6083a: e04f         	b	0x608dc <f_cgm_trend+0x3b4> @ imm = #0x9e
   6083c: f50d 605b    	add.w	r0, sp, #0xdb0
   60840: b2b5         	uxth	r5, r6
   60842: f900 cacf    	vst1.64	{d12, d13}, [r0]
   60846: 9807         	ldr	r0, [sp, #0x1c]
   60848: 4285         	cmp	r5, r0
   6084a: d208         	bhs	0x6085e <f_cgm_trend+0x336> @ imm = #0x10
   6084c: 4a3a         	ldr	r2, [pc, #0xe8]         @ 0x60938 <f_cgm_trend+0x410>
   6084e: eb0c 00ca    	add.w	r0, r12, r10, lsl #3
   60852: 2100         	movs	r1, #0x0
   60854: e9c0 1222    	strd	r1, r2, [r0, #136]
   60858: e9c0 1226    	strd	r1, r2, [r0, #152]
   6085c: e03b         	b	0x608d6 <f_cgm_trend+0x3ae> @ imm = #0x76
   6085e: f1ba 0f01    	cmp.w	r10, #0x1
   60862: d119         	bne	0x60898 <f_cgm_trend+0x370> @ imm = #0x32
   60864: ae0a         	add	r6, sp, #0x28
   60866: f50d 685c    	add.w	r8, sp, #0xdc0
   6086a: f50d 645b    	add.w	r4, sp, #0xdb0
   6086e: 462a         	mov	r2, r5
   60870: 4630         	mov	r0, r6
   60872: 4641         	mov	r1, r8
   60874: 4623         	mov	r3, r4
   60876: f000 fab7    	bl	0x60de8 <fit_simple_regression> @ imm = #0x56e
   6087a: 4620         	mov	r0, r4
   6087c: 4631         	mov	r1, r6
   6087e: 4642         	mov	r2, r8
   60880: 462b         	mov	r3, r5
   60882: f000 fb31    	bl	0x60ee8 <f_rsq>         @ imm = #0x662
   60886: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6088a: edd4 0b00    	vldr	d16, [r4]
   6088e: ed8c 0b28    	vstr	d0, [r12, #160]
   60892: edcc 0b24    	vstr	d16, [r12, #144]
   60896: e01e         	b	0x608d6 <f_cgm_trend+0x3ae> @ imm = #0x3c
   60898: 9e07         	ldr	r6, [sp, #0x1c]
   6089a: a90a         	add	r1, sp, #0x28
   6089c: f50d 645b    	add.w	r4, sp, #0xdb0
   608a0: 1ba8         	subs	r0, r5, r6
   608a2: 4632         	mov	r2, r6
   608a4: 4623         	mov	r3, r4
   608a6: eb01 05c0    	add.w	r5, r1, r0, lsl #3
   608aa: f50d 615c    	add.w	r1, sp, #0xdc0
   608ae: eb01 08c0    	add.w	r8, r1, r0, lsl #3
   608b2: 4628         	mov	r0, r5
   608b4: 4641         	mov	r1, r8
   608b6: f000 fa97    	bl	0x60de8 <fit_simple_regression> @ imm = #0x52e
   608ba: 4620         	mov	r0, r4
   608bc: 4629         	mov	r1, r5
   608be: 4642         	mov	r2, r8
   608c0: 4633         	mov	r3, r6
   608c2: f000 fb11    	bl	0x60ee8 <f_rsq>         @ imm = #0x622
   608c6: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   608ca: edd4 0b00    	vldr	d16, [r4]
   608ce: ed8c 0b26    	vstr	d0, [r12, #152]
   608d2: edcc 0b22    	vstr	d16, [r12, #136]
   608d6: 9c05         	ldr	r4, [sp, #0x14]
   608d8: f1a7 06b0    	sub.w	r6, r7, #0xb0
   608dc: f10a 0a01    	add.w	r10, r10, #0x1
   608e0: e74c         	b	0x6077c <f_cgm_trend+0x254> @ imm = #-0x168
   608e2: ac0a         	add	r4, sp, #0x28
   608e4: f640 5184    	movw	r1, #0xd84
   608e8: 4620         	mov	r0, r4
   608ea: f00e eb8a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xe714
   608ee: eeb2 bb04    	vmov.f64	d11, #1.000000e+01
   608f2: fa1f f58b    	uxth.w	r5, r11
   608f6: f50d 58b9    	add.w	r8, sp, #0x1720
   608fa: 46a1         	mov	r9, r4
   608fc: 462e         	mov	r6, r5
   608fe: b32e         	cbz	r6, 0x6094c <f_cgm_trend+0x424> @ imm = #0x4a
   60900: ecf8 0b02    	vldmia	r8!, {d16}
   60904: ee80 0b8b    	vdiv.f64	d0, d16, d11
   60908: f7fe fcfe    	bl	0x5f308 <math_round>    @ imm = #-0x1604
   6090c: eebd 0bc0    	vcvt.s32.f64	s0, d0
   60910: 3e01         	subs	r6, #0x1
   60912: ee10 0a10    	vmov	r0, s0
   60916: eb00 0080    	add.w	r0, r0, r0, lsl #2
   6091a: 0040         	lsls	r0, r0, #0x1
   6091c: f849 0b04    	str	r0, [r9], #4
   60920: e7ed         	b	0x608fe <f_cgm_trend+0x3d6> @ imm = #-0x26
   60922: bf00         	nop
   60924: 48 ab 02 00  	.word	0x0002ab48
   60928: 3e f9 ff ff  	.word	0xfffff93e
   6092c: a4 4f 01 00  	.word	0x00014fa4
   60930: 00 00 00 00  	.word	0x00000000
   60934: 00 00 f0 7f  	.word	0x7ff00000
   60938: 00 00 f8 7f  	.word	0x7ff80000
   6093c: 00 bf 00 bf  	.word	0xbf00bf00
   60940: 00 00 00 00  	.word	0x00000000
   60944: 00 00 72 40  	.word	0x40720000
   60948: f8 ff 07 00  	.word	0x0007fff8
   6094c: ea5f 400b    	lsls.w	r0, r11, #0x10
   60950: d054         	beq	0x609fc <f_cgm_trend+0x4d4> @ imm = #0xa8
   60952: f8dd c028    	ldr.w	r12, [sp, #0x28]
   60956: f04f 0e00    	mov.w	lr, #0x0
   6095a: f04f 0800    	mov.w	r8, #0x0
   6095e: 45a8         	cmp	r8, r5
   60960: d035         	beq	0x609ce <f_cgm_trend+0x4a6> @ imm = #0x6a
   60962: 4643         	mov	r3, r8
   60964: f108 0801    	add.w	r8, r8, #0x1
   60968: 2601         	movs	r6, #0x1
   6096a: 4642         	mov	r2, r8
   6096c: 42aa         	cmp	r2, r5
   6096e: d208         	bhs	0x60982 <f_cgm_trend+0x45a> @ imm = #0x10
   60970: f854 0022    	ldr.w	r0, [r4, r2, lsl #2]
   60974: f854 1023    	ldr.w	r1, [r4, r3, lsl #2]
   60978: 4281         	cmp	r1, r0
   6097a: bf08         	it	eq
   6097c: 3601         	addeq	r6, #0x1
   6097e: 3201         	adds	r2, #0x1
   60980: e7f4         	b	0x6096c <f_cgm_trend+0x444> @ imm = #-0x18
   60982: 4576         	cmp	r6, lr
   60984: dbeb         	blt	0x6095e <f_cgm_trend+0x436> @ imm = #-0x2a
   60986: f854 2023    	ldr.w	r2, [r4, r3, lsl #2]
   6098a: d103         	bne	0x60994 <f_cgm_trend+0x46c> @ imm = #0x6
   6098c: 4594         	cmp	r12, r2
   6098e: bfc8         	it	gt
   60990: 4694         	movgt	r12, r2
   60992: e7e4         	b	0x6095e <f_cgm_trend+0x436> @ imm = #-0x38
   60994: 46b6         	mov	lr, r6
   60996: 4694         	mov	r12, r2
   60998: e7e1         	b	0x6095e <f_cgm_trend+0x436> @ imm = #-0x3e
   6099a: 48c2         	ldr	r0, [pc, #0x308]        @ 0x60ca4 <f_cgm_trend+0x77c>
   6099c: 2100         	movs	r1, #0x0
   6099e: e9c5 1022    	strd	r1, r0, [r5, #136]
   609a2: e9c5 1026    	strd	r1, r0, [r5, #152]
   609a6: 6a28         	ldr	r0, [r5, #0x20]
   609a8: edd5 0b0c    	vldr	d16, [r5, #48]
   609ac: f500 50d8    	add.w	r0, r0, #0x1b00
   609b0: edc0 0b00    	vstr	d16, [r0]
   609b4: edd5 0b0c    	vldr	d16, [r5, #48]
   609b8: edd5 1b10    	vldr	d17, [r5, #64]
   609bc: edd5 2b14    	vldr	d18, [r5, #80]
   609c0: edc5 0b0a    	vstr	d16, [r5, #40]
   609c4: edc5 1b0e    	vstr	d17, [r5, #56]
   609c8: edc5 2b12    	vstr	d18, [r5, #72]
   609cc: e14a         	b	0x60c64 <f_cgm_trend+0x73c> @ imm = #0x294
   609ce: ee00 ca10    	vmov	s0, r12
   609d2: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   609d6: eef8 0bc0    	vcvt.f64.s32	d16, s0
   609da: ee00 ea10    	vmov	s0, lr
   609de: edcc 0b00    	vstr	d16, [r12]
   609e2: eef8 0bc0    	vcvt.f64.s32	d16, s0
   609e6: ee00 5a10    	vmov	s0, r5
   609ea: eef8 1b40    	vcvt.f64.u32	d17, s0
   609ee: eec0 0ba1    	vdiv.f64	d16, d16, d17
   609f2: eddf 1ba7    	vldr	d17, [pc, #668]         @ 0x60c90 <f_cgm_trend+0x768>
   609f6: ee60 0ba1    	vmul.f64	d16, d16, d17
   609fa: e007         	b	0x60a0c <f_cgm_trend+0x4e4> @ imm = #0xe
   609fc: 48a9         	ldr	r0, [pc, #0x2a4]        @ 0x60ca4 <f_cgm_trend+0x77c>
   609fe: 2100         	movs	r1, #0x0
   60a00: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   60a04: eddf 0ba4    	vldr	d16, [pc, #656]         @ 0x60c98 <f_cgm_trend+0x770>
   60a08: e9cc 1000    	strd	r1, r0, [r12]
   60a0c: edcc 0b16    	vstr	d16, [r12, #88]
   60a10: 48a6         	ldr	r0, [pc, #0x298]        @ 0x60cac <f_cgm_trend+0x784>
   60a12: 9903         	ldr	r1, [sp, #0xc]
   60a14: 4478         	add	r0, pc
   60a16: f8dd 8008    	ldr.w	r8, [sp, #0x8]
   60a1a: 4da1         	ldr	r5, [pc, #0x284]        @ 0x60ca0 <f_cgm_trend+0x778>
   60a1c: f8b0 0418    	ldrh.w	r0, [r0, #0x418]
   60a20: 4281         	cmp	r1, r0
   60a22: f240 80ae    	bls.w	0x60b82 <f_cgm_trend+0x65a> @ imm = #0x15c
   60a26: eef7 1b00    	vmov.f64	d17, #1.000000e+00
   60a2a: eddc 0b06    	vldr	d16, [r12, #24]
   60a2e: ee70 0ba1    	vadd.f64	d16, d16, d17
   60a32: edcc 0b06    	vstr	d16, [r12, #24]
   60a36: eddc 0b00    	vldr	d16, [r12]
   60a3a: eddc 1b0c    	vldr	d17, [r12, #48]
   60a3e: edcd 0b0a    	vstr	d16, [sp, #40]
   60a42: edcd 1b0c    	vstr	d17, [sp, #48]
   60a46: a80a         	add	r0, sp, #0x28
   60a48: f000 fac6    	bl	0x60fd8 <math_max>      @ imm = #0x58c
   60a4c: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   60a50: f8dc 2020    	ldr.w	r2, [r12, #0x20]
   60a54: f502 50d8    	add.w	r0, r2, #0x1b00
   60a58: ed80 0b00    	vstr	d0, [r0]
   60a5c: eddc 0b06    	vldr	d16, [r12, #24]
   60a60: eef4 0b4a    	vcmp.f64	d16, d10
   60a64: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60a68: da15         	bge	0x60a96 <f_cgm_trend+0x56e> @ imm = #0x2a
   60a6a: eebd 1bc9    	vcvt.s32.f64	s2, d9
   60a6e: 9903         	ldr	r1, [sp, #0xc]
   60a70: 462b         	mov	r3, r5
   60a72: 9d01         	ldr	r5, [sp, #0x4]
   60a74: 9e03         	ldr	r6, [sp, #0xc]
   60a76: ee11 0a10    	vmov	r0, s2
   60a7a: 1a09         	subs	r1, r1, r0
   60a7c: 2000         	movs	r0, #0x0
   60a7e: b30b         	cbz	r3, 0x60ac4 <f_cgm_trend+0x59c> @ imm = #0x42
   60a80: 18ec         	adds	r4, r5, r3
   60a82: f8b4 46c2    	ldrh.w	r4, [r4, #0x6c2]
   60a86: b124         	cbz	r4, 0x60a92 <f_cgm_trend+0x56a> @ imm = #0x8
   60a88: 42a1         	cmp	r1, r4
   60a8a: dc02         	bgt	0x60a92 <f_cgm_trend+0x56a> @ imm = #0x4
   60a8c: 42b4         	cmp	r4, r6
   60a8e: bf98         	it	ls
   60a90: 3001         	addls	r0, #0x1
   60a92: 3302         	adds	r3, #0x2
   60a94: e7f3         	b	0x60a7e <f_cgm_trend+0x556> @ imm = #-0x1a
   60a96: eef4 0b4a    	vcmp.f64	d16, d10
   60a9a: 2001         	movs	r0, #0x1
   60a9c: f88c 00a8    	strb.w	r0, [r12, #0xa8]
   60aa0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60aa4: dc58         	bgt	0x60b58 <f_cgm_trend+0x630> @ imm = #0xb0
   60aa6: eebc 0bca    	vcvt.u32.f64	s0, d10
   60aaa: f240 3061    	movw	r0, #0x361
   60aae: ee10 1a10    	vmov	r1, s0
   60ab2: 1a40         	subs	r0, r0, r1
   60ab4: eb02 00c0    	add.w	r0, r2, r0, lsl #3
   60ab8: 2214         	movs	r2, #0x14
   60aba: f000 f945    	bl	0x60d48 <f_trimmed_mean> @ imm = #0x28a
   60abe: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   60ac2: e04e         	b	0x60b62 <f_cgm_trend+0x63a> @ imm = #0x9c
   60ac4: 6c79         	ldr	r1, [r7, #0x44]
   60ac6: b109         	cbz	r1, 0x60acc <f_cgm_trend+0x5a4> @ imm = #0x2
   60ac8: 2902         	cmp	r1, #0x2
   60aca: d113         	bne	0x60af4 <f_cgm_trend+0x5cc> @ imm = #0x26
   60acc: b281         	uxth	r1, r0
   60ace: f240 3361    	movw	r3, #0x361
   60ad2: 1a5b         	subs	r3, r3, r1
   60ad4: 4d72         	ldr	r5, [pc, #0x1c8]        @ 0x60ca0 <f_cgm_trend+0x778>
   60ad6: 460c         	mov	r4, r1
   60ad8: eb02 03c3    	add.w	r3, r2, r3, lsl #3
   60adc: 2200         	movs	r2, #0x0
   60ade: b35c         	cbz	r4, 0x60b38 <f_cgm_trend+0x610> @ imm = #0x56
   60ae0: ecf3 0b02    	vldmia	r3!, {d16}
   60ae4: eef4 0b40    	vcmp.f64	d16, d0
   60ae8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60aec: bf08         	it	eq
   60aee: 3201         	addeq	r2, #0x1
   60af0: 3c01         	subs	r4, #0x1
   60af2: e7f4         	b	0x60ade <f_cgm_trend+0x5b6> @ imm = #-0x18
   60af4: b281         	uxth	r1, r0
   60af6: f240 3361    	movw	r3, #0x361
   60afa: 1a5b         	subs	r3, r3, r1
   60afc: eef9 0b04    	vmov.f64	d16, #-5.000000e+00
   60b00: 4d67         	ldr	r5, [pc, #0x19c]        @ 0x60ca0 <f_cgm_trend+0x778>
   60b02: 460c         	mov	r4, r1
   60b04: eb02 03c3    	add.w	r3, r2, r3, lsl #3
   60b08: 2200         	movs	r2, #0x0
   60b0a: eef1 1b04    	vmov.f64	d17, #5.000000e+00
   60b0e: b19c         	cbz	r4, 0x60b38 <f_cgm_trend+0x610> @ imm = #0x26
   60b10: edd3 2b00    	vldr	d18, [r3]
   60b14: ee72 3ba0    	vadd.f64	d19, d18, d16
   60b18: eeb4 0b63    	vcmp.f64	d0, d19
   60b1c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60b20: db07         	blt	0x60b32 <f_cgm_trend+0x60a> @ imm = #0xe
   60b22: ee72 2ba1    	vadd.f64	d18, d18, d17
   60b26: eeb4 0b62    	vcmp.f64	d0, d18
   60b2a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60b2e: bf98         	it	ls
   60b30: 3201         	addls	r2, #0x1
   60b32: 3308         	adds	r3, #0x8
   60b34: 3c01         	subs	r4, #0x1
   60b36: e7ea         	b	0x60b0e <f_cgm_trend+0x5e6> @ imm = #-0x2c
   60b38: b292         	uxth	r2, r2
   60b3a: 428a         	cmp	r2, r1
   60b3c: d109         	bne	0x60b52 <f_cgm_trend+0x62a> @ imm = #0x12
   60b3e: b280         	uxth	r0, r0
   60b40: ee01 0a10    	vmov	s2, r0
   60b44: eef8 0b41    	vcvt.f64.u32	d16, s2
   60b48: eeb4 8b60    	vcmp.f64	d8, d16
   60b4c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60b50: d907         	bls	0x60b62 <f_cgm_trend+0x63a> @ imm = #0xe
   60b52: f1b8 0f02    	cmp.w	r8, #0x2
   60b56: d302         	blo	0x60b5e <f_cgm_trend+0x636> @ imm = #0x4
   60b58: ed9c 0b0c    	vldr	d0, [r12, #48]
   60b5c: e001         	b	0x60b62 <f_cgm_trend+0x63a> @ imm = #0x2
   60b5e: ed9f 0b4e    	vldr	d0, [pc, #312]          @ 0x60c98 <f_cgm_trend+0x770>
   60b62: eddc 0b00    	vldr	d16, [r12]
   60b66: eddf 1b4a    	vldr	d17, [pc, #296]         @ 0x60c90 <f_cgm_trend+0x768>
   60b6a: ee70 0bc0    	vsub.f64	d16, d16, d0
   60b6e: edcc 0b0e    	vstr	d16, [r12, #56]
   60b72: eec0 0b80    	vdiv.f64	d16, d16, d0
   60b76: ee60 0ba1    	vmul.f64	d16, d16, d17
   60b7a: ed8c 0b0a    	vstr	d0, [r12, #40]
   60b7e: edcc 0b12    	vstr	d16, [r12, #72]
   60b82: 6c78         	ldr	r0, [r7, #0x44]
   60b84: 2801         	cmp	r0, #0x1
   60b86: d16d         	bne	0x60c64 <f_cgm_trend+0x73c> @ imm = #0xda
   60b88: eddc 0b00    	vldr	d16, [r12]
   60b8c: eddc 1b1a    	vldr	d17, [r12, #104]
   60b90: edcd 0b0a    	vstr	d16, [sp, #40]
   60b94: edcd 1b0c    	vstr	d17, [sp, #48]
   60b98: a80a         	add	r0, sp, #0x28
   60b9a: f000 fa1d    	bl	0x60fd8 <math_max>      @ imm = #0x43a
   60b9e: eebd 1bc9    	vcvt.s32.f64	s2, d9
   60ba2: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   60ba6: 9e03         	ldr	r6, [sp, #0xc]
   60ba8: 462b         	mov	r3, r5
   60baa: 9d01         	ldr	r5, [sp, #0x4]
   60bac: f8dc 1070    	ldr.w	r1, [r12, #0x70]
   60bb0: f501 50d8    	add.w	r0, r1, #0x1b00
   60bb4: ed80 0b00    	vstr	d0, [r0]
   60bb8: ee11 0a10    	vmov	r0, s2
   60bbc: 1a32         	subs	r2, r6, r0
   60bbe: 2000         	movs	r0, #0x0
   60bc0: b163         	cbz	r3, 0x60bdc <f_cgm_trend+0x6b4> @ imm = #0x18
   60bc2: 461c         	mov	r4, r3
   60bc4: 442b         	add	r3, r5
   60bc6: f8b3 36c2    	ldrh.w	r3, [r3, #0x6c2]
   60bca: b123         	cbz	r3, 0x60bd6 <f_cgm_trend+0x6ae> @ imm = #0x8
   60bcc: 429a         	cmp	r2, r3
   60bce: dc02         	bgt	0x60bd6 <f_cgm_trend+0x6ae> @ imm = #0x4
   60bd0: 42b3         	cmp	r3, r6
   60bd2: bf98         	it	ls
   60bd4: 3001         	addls	r0, #0x1
   60bd6: 4623         	mov	r3, r4
   60bd8: 1ca3         	adds	r3, r4, #0x2
   60bda: e7f1         	b	0x60bc0 <f_cgm_trend+0x698> @ imm = #-0x1e
   60bdc: b280         	uxth	r0, r0
   60bde: f240 3261    	movw	r2, #0x361
   60be2: 1a12         	subs	r2, r2, r0
   60be4: eef9 0b04    	vmov.f64	d16, #-5.000000e+00
   60be8: 4603         	mov	r3, r0
   60bea: eb01 02c2    	add.w	r2, r1, r2, lsl #3
   60bee: 2100         	movs	r1, #0x0
   60bf0: eef1 1b04    	vmov.f64	d17, #5.000000e+00
   60bf4: b19b         	cbz	r3, 0x60c1e <f_cgm_trend+0x6f6> @ imm = #0x26
   60bf6: edd2 2b00    	vldr	d18, [r2]
   60bfa: ee72 3ba0    	vadd.f64	d19, d18, d16
   60bfe: eeb4 0b63    	vcmp.f64	d0, d19
   60c02: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60c06: db07         	blt	0x60c18 <f_cgm_trend+0x6f0> @ imm = #0xe
   60c08: ee72 2ba1    	vadd.f64	d18, d18, d17
   60c0c: eeb4 0b62    	vcmp.f64	d0, d18
   60c10: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60c14: bf98         	it	ls
   60c16: 3101         	addls	r1, #0x1
   60c18: 3208         	adds	r2, #0x8
   60c1a: 3b01         	subs	r3, #0x1
   60c1c: e7ea         	b	0x60bf4 <f_cgm_trend+0x6cc> @ imm = #-0x2c
   60c1e: ee01 0a10    	vmov	s2, r0
   60c22: eef8 0b41    	vcvt.f64.u32	d16, s2
   60c26: eeb4 8b60    	vcmp.f64	d8, d16
   60c2a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60c2e: d802         	bhi	0x60c36 <f_cgm_trend+0x70e> @ imm = #0x4
   60c30: b289         	uxth	r1, r1
   60c32: 4281         	cmp	r1, r0
   60c34: d006         	beq	0x60c44 <f_cgm_trend+0x71c> @ imm = #0xc
   60c36: f1b8 0f02    	cmp.w	r8, #0x2
   60c3a: bf2c         	ite	hs
   60c3c: ed9c 0b1a    	vldrhs	d0, [r12, #104]
   60c40: ed9f 0b15    	vldrlo	d0, [pc, #84]           @ 0x60c98 <f_cgm_trend+0x770>
   60c44: eddc 0b00    	vldr	d16, [r12]
   60c48: eddf 2b11    	vldr	d18, [pc, #68]          @ 0x60c90 <f_cgm_trend+0x768>
   60c4c: ee70 0bc0    	vsub.f64	d16, d16, d0
   60c50: eec0 1b80    	vdiv.f64	d17, d16, d0
   60c54: ee61 1ba2    	vmul.f64	d17, d17, d18
   60c58: ed8c 0b18    	vstr	d0, [r12, #96]
   60c5c: edcc 0b1e    	vstr	d16, [r12, #120]
   60c60: edcc 1b20    	vstr	d17, [r12, #128]
   60c64: f857 0c6c    	ldr	r0, [r7, #-108]
   60c68: 4911         	ldr	r1, [pc, #0x44]         @ 0x60cb0 <f_cgm_trend+0x788>
   60c6a: 4479         	add	r1, pc
   60c6c: 6809         	ldr	r1, [r1]
   60c6e: 6809         	ldr	r1, [r1]
   60c70: 4281         	cmp	r1, r0
   60c72: bf01         	itttt	eq
   60c74: f50d 5d49    	addeq.w	sp, sp, #0x3240
   60c78: b00e         	addeq	sp, #0x38
   60c7a: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   60c7e: b001         	addeq	sp, #0x4
   60c80: bf04         	itt	eq
   60c82: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   60c86: bdf0         	popeq	{r4, r5, r6, r7, pc}
   60c88: f00e e9d2    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xe3a4
   60c8c: bf00         	nop
   60c8e: bf00         	nop
   60c90: 00 00 00 00  	.word	0x00000000
   60c94: 00 00 59 40  	.word	0x40590000
   60c98: 00 00 00 00  	.word	0x00000000
   60c9c: 00 00 f8 7f  	.word	0x7ff80000
   60ca0: 3e f9 ff ff  	.word	0xfffff93e
   60ca4: 00 00 f8 7f  	.word	0x7ff80000
   60ca8: 88 2c 01 00  	.word	0x00012c88
   60cac: 90 af 02 00  	.word	0x0002af90
   60cb0: 66 25 01 00  	.word	0x00012566
   60cb4: d4 d4 d4 d4  	.word	0xd4d4d4d4

00060cb8 <calcPercentile>:
   60cb8: b5d0         	push	{r4, r6, r7, lr}
   60cba: af02         	add	r7, sp, #0x8
   60cbc: ee00 2a10    	vmov	s0, r2
   60cc0: 4b1f         	ldr	r3, [pc, #0x7c]         @ 0x60d40 <calcPercentile+0x88>
   60cc2: eddf 1b1b    	vldr	d17, [pc, #108]         @ 0x60d30 <calcPercentile+0x78>
   60cc6: 2200         	movs	r2, #0x0
   60cc8: eef8 0b40    	vcvt.f64.u32	d16, s0
   60ccc: 447b         	add	r3, pc
   60cce: b199         	cbz	r1, 0x60cf8 <calcPercentile+0x40> @ imm = #0x26
   60cd0: edd0 2b00    	vldr	d18, [r0]
   60cd4: eef0 3be2    	vabs.f64	d19, d18
   60cd8: eef4 3b61    	vcmp.f64	d19, d17
   60cdc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60ce0: d007         	beq	0x60cf2 <calcPercentile+0x3a> @ imm = #0xe
   60ce2: d606         	bvs	0x60cf2 <calcPercentile+0x3a> @ imm = #0xc
   60ce4: e7ff         	b	0x60ce6 <calcPercentile+0x2e> @ imm = #-0x2
   60ce6: b294         	uxth	r4, r2
   60ce8: 3201         	adds	r2, #0x1
   60cea: eb03 04c4    	add.w	r4, r3, r4, lsl #3
   60cee: edc4 2b00    	vstr	d18, [r4]
   60cf2: 3008         	adds	r0, #0x8
   60cf4: 3901         	subs	r1, #0x1
   60cf6: e7ea         	b	0x60cce <calcPercentile+0x16> @ imm = #-0x2c
   60cf8: eddf 1b0f    	vldr	d17, [pc, #60]          @ 0x60d38 <calcPercentile+0x80>
   60cfc: b291         	uxth	r1, r2
   60cfe: eef6 2b00    	vmov.f64	d18, #5.000000e-01
   60d02: 4810         	ldr	r0, [pc, #0x40]         @ 0x60d44 <calcPercentile+0x8c>
   60d04: 4478         	add	r0, pc
   60d06: ee60 0ba1    	vmul.f64	d16, d16, d17
   60d0a: ee00 1a10    	vmov	s0, r1
   60d0e: eef8 1b40    	vcvt.f64.u32	d17, s0
   60d12: ee40 2ba1    	vmla.f64	d18, d16, d17
   60d16: eebc 0be2    	vcvt.u32.f64	s0, d18
   60d1a: ee10 2a10    	vmov	r2, s0
   60d1e: 2a00         	cmp	r2, #0x0
   60d20: e8bd 40d0    	pop.w	{r4, r6, r7, lr}
   60d24: bf18         	it	ne
   60d26: f7fe bc53    	bne.w	0x5f5d0 <quick_select>  @ imm = #-0x175a
   60d2a: f000 b979    	b.w	0x61020 <math_min>      @ imm = #0x2f2
   60d2e: bf00         	nop
   60d30: 00 00 00 00  	.word	0x00000000
   60d34: 00 00 f0 7f  	.word	0x7ff00000
   60d38: 7b 14 ae 47  	.word	0x47ae147b
   60d3c: e1 7a 84 3f  	.word	0x3f847ae1
   60d40: 48 ec 02 00  	.word	0x0002ec48
   60d44: 10 ec 02 00  	.word	0x0002ec10

00060d48 <f_trimmed_mean>:
   60d48: b5f0         	push	{r4, r5, r6, r7, lr}
   60d4a: af03         	add	r7, sp, #0xc
   60d4c: f84d bd04    	str	r11, [sp, #-4]!
   60d50: ed2d 8b08    	vpush	{d8, d9, d10, d11}
   60d54: 4616         	mov	r6, r2
   60d56: 460c         	mov	r4, r1
   60d58: 4605         	mov	r5, r0
   60d5a: f7ff ffad    	bl	0x60cb8 <calcPercentile> @ imm = #-0xa6
   60d5e: f1c6 0064    	rsb.w	r0, r6, #0x64
   60d62: 4621         	mov	r1, r4
   60d64: b2c2         	uxtb	r2, r0
   60d66: 4628         	mov	r0, r5
   60d68: eeb0 8b40    	vmov.f64	d8, d0
   60d6c: f7ff ffa4    	bl	0x60cb8 <calcPercentile> @ imm = #-0xb8
   60d70: eeb4 8b40    	vcmp.f64	d8, d0
   60d74: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60d78: d109         	bne	0x60d8e <f_trimmed_mean+0x46> @ imm = #0x12
   60d7a: 4628         	mov	r0, r5
   60d7c: 4621         	mov	r1, r4
   60d7e: ecbd 8b08    	vpop	{d8, d9, d10, d11}
   60d82: f85d bb04    	ldr	r11, [sp], #4
   60d86: e8bd 40f0    	pop.w	{r4, r5, r6, r7, lr}
   60d8a: f7fe ba61    	b.w	0x5f250 <math_mean>     @ imm = #-0x1b3e
   60d8e: eeb0 9b40    	vmov.f64	d9, d0
   60d92: 2600         	movs	r6, #0x0
   60d94: ef80 b010    	vmov.i32	d11, #0x0
   60d98: b1cc         	cbz	r4, 0x60dce <f_trimmed_mean+0x86> @ imm = #0x32
   60d9a: ed95 ab00    	vldr	d10, [r5]
   60d9e: 200a         	movs	r0, #0xa
   60da0: eeb0 1b48    	vmov.f64	d1, d8
   60da4: 2103         	movs	r1, #0x3
   60da6: ef2a 011a    	vorr	d0, d10, d10
   60daa: f7fe fb15    	bl	0x5f3d8 <fun_comp_decimals> @ imm = #-0x19d6
   60dae: b158         	cbz	r0, 0x60dc8 <f_trimmed_mean+0x80> @ imm = #0x16
   60db0: eeb0 1b49    	vmov.f64	d1, d9
   60db4: 200a         	movs	r0, #0xa
   60db6: 2104         	movs	r1, #0x4
   60db8: ef2a 011a    	vorr	d0, d10, d10
   60dbc: f7fe fb0c    	bl	0x5f3d8 <fun_comp_decimals> @ imm = #-0x19e8
   60dc0: b110         	cbz	r0, 0x60dc8 <f_trimmed_mean+0x80> @ imm = #0x4
   60dc2: ee3b bb0a    	vadd.f64	d11, d11, d10
   60dc6: 3601         	adds	r6, #0x1
   60dc8: 3508         	adds	r5, #0x8
   60dca: 3c01         	subs	r4, #0x1
   60dcc: e7e4         	b	0x60d98 <f_trimmed_mean+0x50> @ imm = #-0x38
   60dce: b2b0         	uxth	r0, r6
   60dd0: ee00 0a10    	vmov	s0, r0
   60dd4: eef8 0b40    	vcvt.f64.u32	d16, s0
   60dd8: ee8b 0b20    	vdiv.f64	d0, d11, d16
   60ddc: ecbd 8b08    	vpop	{d8, d9, d10, d11}
   60de0: f85d bb04    	ldr	r11, [sp], #4
   60de4: bdf0         	pop	{r4, r5, r6, r7, pc}
   60de6: d4d4         	bmi	0x60d92 <f_trimmed_mean+0x4a> @ imm = #-0x58

00060de8 <fit_simple_regression>:
   60de8: b5f0         	push	{r4, r5, r6, r7, lr}
   60dea: af03         	add	r7, sp, #0xc
   60dec: e92d 0700    	push.w	{r8, r9, r10}
   60df0: f5ad 5d96    	sub.w	sp, sp, #0x12c0
   60df4: b082         	sub	sp, #0x8
   60df6: 4604         	mov	r4, r0
   60df8: 4839         	ldr	r0, [pc, #0xe4]         @ 0x60ee0 <fit_simple_regression+0xf8>
   60dfa: f50d 6916    	add.w	r9, sp, #0x960
   60dfe: 460e         	mov	r6, r1
   60e00: 4478         	add	r0, pc
   60e02: f44f 6116    	mov.w	r1, #0x960
   60e06: 4698         	mov	r8, r3
   60e08: 4615         	mov	r5, r2
   60e0a: 6800         	ldr	r0, [r0]
   60e0c: 6800         	ldr	r0, [r0]
   60e0e: f847 0c20    	str	r0, [r7, #-32]
   60e12: 4648         	mov	r0, r9
   60e14: f00e e8f4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xe1e8
   60e18: 46ea         	mov	r10, sp
   60e1a: f44f 6116    	mov.w	r1, #0x960
   60e1e: 4650         	mov	r0, r10
   60e20: f00e e8ee    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xe1dc
   60e24: efc0 0010    	vmov.i32	d16, #0x0
   60e28: 2000         	movs	r0, #0x0
   60e2a: efc0 1010    	vmov.i32	d17, #0x0
   60e2e: b305         	cbz	r5, 0x60e72 <fit_simple_regression+0x8a> @ imm = #0x40
   60e30: edd6 2b00    	vldr	d18, [r6]
   60e34: eef4 2b62    	vcmp.f64	d18, d18
   60e38: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60e3c: bf7f         	itttt	vc
   60e3e: edd4 3b00    	vldrvc	d19, [r4]
   60e42: eef4 3b63    	vcmpvc.f64	d19, d19
   60e46: eef1 fa10    	vmrsvc	APSR_nzcv, fpscr
   60e4a: b2c1         	uxtbvc	r1, r0
   60e4c: bf7f         	itttt	vc
   60e4e: eb0a 02c1    	addvc.w	r2, r10, r1, lsl #3
   60e52: edc2 2b00    	vstrvc	d18, [r2]
   60e56: eb09 01c1    	addvc.w	r1, r9, r1, lsl #3
   60e5a: edc1 3b00    	vstrvc	d19, [r1]
   60e5e: bf7e         	ittt	vc
   60e60: ee70 0ba2    	vaddvc.f64	d16, d16, d18
   60e64: ee71 1ba3    	vaddvc.f64	d17, d17, d19
   60e68: 3001         	addvc	r0, #0x1
   60e6a: 3408         	adds	r4, #0x8
   60e6c: 3608         	adds	r6, #0x8
   60e6e: 3d01         	subs	r5, #0x1
   60e70: e7dd         	b	0x60e2e <fit_simple_regression+0x46> @ imm = #-0x46
   60e72: b2c0         	uxtb	r0, r0
   60e74: f50d 6116    	add.w	r1, sp, #0x960
   60e78: 466a         	mov	r2, sp
   60e7a: efc0 3010    	vmov.i32	d19, #0x0
   60e7e: ee00 0a10    	vmov	s0, r0
   60e82: eef8 2b40    	vcvt.f64.u32	d18, s0
   60e86: eec0 0ba2    	vdiv.f64	d16, d16, d18
   60e8a: eec1 1ba2    	vdiv.f64	d17, d17, d18
   60e8e: efc0 2010    	vmov.i32	d18, #0x0
   60e92: b168         	cbz	r0, 0x60eb0 <fit_simple_regression+0xc8> @ imm = #0x1a
   60e94: ecf2 4b02    	vldmia	r2!, {d20}
   60e98: 3801         	subs	r0, #0x1
   60e9a: ecf1 5b02    	vldmia	r1!, {d21}
   60e9e: ee74 4be0    	vsub.f64	d20, d20, d16
   60ea2: ee75 5be1    	vsub.f64	d21, d21, d17
   60ea6: ee45 2ba4    	vmla.f64	d18, d21, d20
   60eaa: ee45 3ba5    	vmla.f64	d19, d21, d21
   60eae: e7f0         	b	0x60e92 <fit_simple_regression+0xaa> @ imm = #-0x20
   60eb0: eec2 2ba3    	vdiv.f64	d18, d18, d19
   60eb4: ee42 0be1    	vmls.f64	d16, d18, d17
   60eb8: edc8 2b00    	vstr	d18, [r8]
   60ebc: edc8 0b02    	vstr	d16, [r8, #8]
   60ec0: f857 0c20    	ldr	r0, [r7, #-32]
   60ec4: 4907         	ldr	r1, [pc, #0x1c]         @ 0x60ee4 <fit_simple_regression+0xfc>
   60ec6: 4479         	add	r1, pc
   60ec8: 6809         	ldr	r1, [r1]
   60eca: 6809         	ldr	r1, [r1]
   60ecc: 4281         	cmp	r1, r0
   60ece: bf01         	itttt	eq
   60ed0: f50d 5d96    	addeq.w	sp, sp, #0x12c0
   60ed4: b002         	addeq	sp, #0x8
   60ed6: e8bd 0700    	popeq.w	{r8, r9, r10}
   60eda: bdf0         	popeq	{r4, r5, r6, r7, pc}
   60edc: f00e e8a8    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xe150
   60ee0: d0 23 01 00  	.word	0x000123d0
   60ee4: 0a 23 01 00  	.word	0x0001230a

00060ee8 <f_rsq>:
   60ee8: b5f0         	push	{r4, r5, r6, r7, lr}
   60eea: af03         	add	r7, sp, #0xc
   60eec: e92d 0b00    	push.w	{r8, r9, r11}
   60ef0: f6ad 1d68    	subw	sp, sp, #0x968
   60ef4: 4605         	mov	r5, r0
   60ef6: 4836         	ldr	r0, [pc, #0xd8]         @ 0x60fd0 <f_rsq+0xe8>
   60ef8: 466c         	mov	r4, sp
   60efa: 460e         	mov	r6, r1
   60efc: 4478         	add	r0, pc
   60efe: f44f 6116    	mov.w	r1, #0x960
   60f02: 4699         	mov	r9, r3
   60f04: 4690         	mov	r8, r2
   60f06: 6800         	ldr	r0, [r0]
   60f08: 6800         	ldr	r0, [r0]
   60f0a: f847 0c1c    	str	r0, [r7, #-28]
   60f0e: 4620         	mov	r0, r4
   60f10: f00e e876    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xe0ec
   60f14: 4648         	mov	r0, r9
   60f16: b148         	cbz	r0, 0x60f2c <f_rsq+0x44> @ imm = #0x12
   60f18: ecf6 0b02    	vldmia	r6!, {d16}
   60f1c: 3801         	subs	r0, #0x1
   60f1e: ecd5 1b04    	vldmia	r5, {d17, d18}
   60f22: ee41 2ba0    	vmla.f64	d18, d17, d16
   60f26: ece4 2b02    	vstmia	r4!, {d18}
   60f2a: e7f4         	b	0x60f16 <f_rsq+0x2e>    @ imm = #-0x18
   60f2c: 4640         	mov	r0, r8
   60f2e: 4649         	mov	r1, r9
   60f30: f7fe f98e    	bl	0x5f250 <math_mean>     @ imm = #-0x1ce4
   60f34: efc0 0010    	vmov.i32	d16, #0x0
   60f38: 4668         	mov	r0, sp
   60f3a: efc0 1010    	vmov.i32	d17, #0x0
   60f3e: f1b9 0f00    	cmp.w	r9, #0x0
   60f42: d00e         	beq	0x60f62 <f_rsq+0x7a>    @ imm = #0x1c
   60f44: ecf8 2b02    	vldmia	r8!, {d18}
   60f48: f1a9 0901    	sub.w	r9, r9, #0x1
   60f4c: ee72 2bc0    	vsub.f64	d18, d18, d0
   60f50: ee42 1ba2    	vmla.f64	d17, d18, d18
   60f54: ecf0 2b02    	vldmia	r0!, {d18}
   60f58: ee72 2bc0    	vsub.f64	d18, d18, d0
   60f5c: ee42 0ba2    	vmla.f64	d16, d18, d18
   60f60: e7ed         	b	0x60f3e <f_rsq+0x56>    @ imm = #-0x26
   60f62: eddf 2b17    	vldr	d18, [pc, #92]          @ 0x60fc0 <f_rsq+0xd8>
   60f66: eef4 1b62    	vcmp.f64	d17, d18
   60f6a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60f6e: d502         	bpl	0x60f76 <f_rsq+0x8e>    @ imm = #0x4
   60f70: ed9f 0b11    	vldr	d0, [pc, #68]           @ 0x60fb8 <f_rsq+0xd0>
   60f74: e011         	b	0x60f9a <f_rsq+0xb2>    @ imm = #0x22
   60f76: ee80 0ba1    	vdiv.f64	d0, d16, d17
   60f7a: eddf 1b13    	vldr	d17, [pc, #76]          @ 0x60fc8 <f_rsq+0xe0>
   60f7e: eef0 0bc0    	vabs.f64	d16, d0
   60f82: eef4 0b61    	vcmp.f64	d16, d17
   60f86: eddf 2b0c    	vldr	d18, [pc, #48]          @ 0x60fb8 <f_rsq+0xd0>
   60f8a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60f8e: bf08         	it	eq
   60f90: eeb0 0b62    	vmoveq.f64	d0, d18
   60f94: bf68         	it	vs
   60f96: eeb0 0b62    	vmovvs.f64	d0, d18
   60f9a: f857 0c1c    	ldr	r0, [r7, #-28]
   60f9e: 490d         	ldr	r1, [pc, #0x34]         @ 0x60fd4 <f_rsq+0xec>
   60fa0: 4479         	add	r1, pc
   60fa2: 6809         	ldr	r1, [r1]
   60fa4: 6809         	ldr	r1, [r1]
   60fa6: 4281         	cmp	r1, r0
   60fa8: bf02         	ittt	eq
   60faa: f60d 1d68    	addweq	sp, sp, #0x968
   60fae: e8bd 0b00    	popeq.w	{r8, r9, r11}
   60fb2: bdf0         	popeq	{r4, r5, r6, r7, pc}
   60fb4: f00e e83c    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xe078
   60fb8: 00 00 00 00  	.word	0x00000000
   60fbc: 00 00 f8 7f  	.word	0x7ff80000
   60fc0: 3a 8c 30 e2  	.word	0xe2308c3a
   60fc4: 8e 79 45 3e  	.word	0x3e45798e
   60fc8: 00 00 00 00  	.word	0x00000000
   60fcc: 00 00 f0 7f  	.word	0x7ff00000
   60fd0: d4 22 01 00  	.word	0x000122d4
   60fd4: 30 22 01 00  	.word	0x00012230

00060fd8 <math_max>:
   60fd8: ef80 0010    	vmov.i32	d0, #0x0
   60fdc: 2100         	movs	r1, #0x0
   60fde: 2200         	movs	r2, #0x0
   60fe0: 2910         	cmp	r1, #0x10
   60fe2: d012         	beq	0x6100a <math_max+0x32> @ imm = #0x24
   60fe4: 1843         	adds	r3, r0, r1
   60fe6: edd3 0b00    	vldr	d16, [r3]
   60fea: eef4 0b60    	vcmp.f64	d16, d16
   60fee: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60ff2: d608         	bvs	0x61006 <math_max+0x2e> @ imm = #0x10
   60ff4: b122         	cbz	r2, 0x61000 <math_max+0x28> @ imm = #0x8
   60ff6: eef4 0b40    	vcmp.f64	d16, d0
   60ffa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   60ffe: dd02         	ble	0x61006 <math_max+0x2e> @ imm = #0x4
   61000: eeb0 0b60    	vmov.f64	d0, d16
   61004: 2201         	movs	r2, #0x1
   61006: 3108         	adds	r1, #0x8
   61008: e7ea         	b	0x60fe0 <math_max+0x8>  @ imm = #-0x2c
   6100a: eddf 0b03    	vldr	d16, [pc, #12]          @ 0x61018 <math_max+0x40>
   6100e: 2a00         	cmp	r2, #0x0
   61010: bf08         	it	eq
   61012: eeb0 0b60    	vmoveq.f64	d0, d16
   61016: 4770         	bx	lr
   61018: 00 00 00 00  	.word	0x00000000
   6101c: 00 00 f8 7f  	.word	0x7ff80000

00061020 <math_min>:
   61020: b1e9         	cbz	r1, 0x6105e <math_min+0x3e> @ imm = #0x3a
   61022: ef80 0010    	vmov.i32	d0, #0x0
   61026: 2200         	movs	r2, #0x0
   61028: b191         	cbz	r1, 0x61050 <math_min+0x30> @ imm = #0x24
   6102a: edd0 0b00    	vldr	d16, [r0]
   6102e: eef4 0b60    	vcmp.f64	d16, d16
   61032: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   61036: d608         	bvs	0x6104a <math_min+0x2a> @ imm = #0x10
   61038: b122         	cbz	r2, 0x61044 <math_min+0x24> @ imm = #0x8
   6103a: eef4 0b40    	vcmp.f64	d16, d0
   6103e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   61042: d502         	bpl	0x6104a <math_min+0x2a> @ imm = #0x4
   61044: eeb0 0b60    	vmov.f64	d0, d16
   61048: 2201         	movs	r2, #0x1
   6104a: 3008         	adds	r0, #0x8
   6104c: 3901         	subs	r1, #0x1
   6104e: e7eb         	b	0x61028 <math_min+0x8>  @ imm = #-0x2a
   61050: eddf 0b05    	vldr	d16, [pc, #20]          @ 0x61068 <math_min+0x48>
   61054: 2a00         	cmp	r2, #0x0
   61056: bf08         	it	eq
   61058: eeb0 0b60    	vmoveq.f64	d0, d16
   6105c: 4770         	bx	lr
   6105e: ed9f 0b02    	vldr	d0, [pc, #8]            @ 0x61068 <math_min+0x48>
   61062: 4770         	bx	lr
   61064: bf00         	nop
   61066: bf00         	nop
   61068: 00 00 00 00  	.word	0x00000000
   6106c: 00 00 f8 7f  	.word	0x7ff80000

00061070 <f_check_cgm_trend>:
   61070: b5f0         	push	{r4, r5, r6, r7, lr}
   61072: af03         	add	r7, sp, #0xc
   61074: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   61078: ed2d 4b16    	vpush	{d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14}
   6107c: 4683         	mov	r11, r0
   6107e: 48f7         	ldr	r0, [pc, #0x3dc]        @ 0x6145c <f_check_cgm_trend+0x3ec>
   61080: 4cf7         	ldr	r4, [pc, #0x3dc]        @ 0x61460 <f_check_cgm_trend+0x3f0>
   61082: f201 6343    	addw	r3, r1, #0x643
   61086: 4478         	add	r0, pc
   61088: f107 0e08    	add.w	lr, r7, #0x8
   6108c: f04f 0a00    	mov.w	r10, #0x0
   61090: 8800         	ldrh	r0, [r0]
   61092: eba0 0c02    	sub.w	r12, r0, r2
   61096: b1a4         	cbz	r4, 0x610c2 <f_check_cgm_trend+0x52> @ imm = #0x28
   61098: 191d         	adds	r5, r3, r4
   6109a: 2600         	movs	r6, #0x0
   6109c: f8b5 26c2    	ldrh.w	r2, [r5, #0x6c2]
   610a0: 4594         	cmp	r12, r2
   610a2: bfb8         	it	lt
   610a4: 2601         	movlt	r6, #0x1
   610a6: 4615         	mov	r5, r2
   610a8: 2a00         	cmp	r2, #0x0
   610aa: bf18         	it	ne
   610ac: 2501         	movne	r5, #0x1
   610ae: 4035         	ands	r5, r6
   610b0: 4282         	cmp	r2, r0
   610b2: f04f 0200    	mov.w	r2, #0x0
   610b6: bf98         	it	ls
   610b8: 2201         	movls	r2, #0x1
   610ba: 3402         	adds	r4, #0x2
   610bc: 402a         	ands	r2, r5
   610be: 4492         	add	r10, r2
   610c0: e7e9         	b	0x61096 <f_check_cgm_trend+0x26> @ imm = #-0x2e
   610c2: f1bb 0f64    	cmp.w	r11, #0x64
   610c6: d12a         	bne	0x6111e <f_check_cgm_trend+0xae> @ imm = #0x54
   610c8: fa1f f48a    	uxth.w	r4, r10
   610cc: f1c4 0024    	rsb.w	r0, r4, #0x24
   610d0: ecbe 8b04    	vldmia	lr!, {d8, d9}
   610d4: f04f 0800    	mov.w	r8, #0x0
   610d8: eb01 00c0    	add.w	r0, r1, r0, lsl #3
   610dc: 2500         	movs	r5, #0x0
   610de: 49e1         	ldr	r1, [pc, #0x384]        @ 0x61464 <f_check_cgm_trend+0x3f4>
   610e0: 1846         	adds	r6, r0, r1
   610e2: 2c00         	cmp	r4, #0x0
   610e4: d06f         	beq	0x611c6 <f_check_cgm_trend+0x156> @ imm = #0xde
   610e6: f5a6 7090    	sub.w	r0, r6, #0x120
   610ea: eeb0 1b48    	vmov.f64	d1, d8
   610ee: 2104         	movs	r1, #0x4
   610f0: f920 070f    	vld1.8	{d0}, [r0]
   610f4: 200a         	movs	r0, #0xa
   610f6: f7fe f96f    	bl	0x5f3d8 <fun_comp_decimals> @ imm = #-0x1d22
   610fa: ef29 1119    	vorr	d1, d9, d9
   610fe: 2800         	cmp	r0, #0x0
   61100: bf18         	it	ne
   61102: f108 0801    	addne.w	r8, r8, #0x1
   61106: f926 070f    	vld1.8	{d0}, [r6]
   6110a: 200a         	movs	r0, #0xa
   6110c: 2104         	movs	r1, #0x4
   6110e: f7fe f963    	bl	0x5f3d8 <fun_comp_decimals> @ imm = #-0x1d3a
   61112: 2800         	cmp	r0, #0x0
   61114: bf18         	it	ne
   61116: 3501         	addne	r5, #0x1
   61118: 3608         	adds	r6, #0x8
   6111a: 3c01         	subs	r4, #0x1
   6111c: e7e1         	b	0x610e2 <f_check_cgm_trend+0x72> @ imm = #-0x3e
   6111e: fa1f f98a    	uxth.w	r9, r10
   61122: f1c9 0024    	rsb.w	r0, r9, #0x24
   61126: f1bb 0f02    	cmp.w	r11, #0x2
   6112a: f8cd 9008    	str.w	r9, [sp, #0x8]
   6112e: d95c         	bls	0x611ea <f_check_cgm_trend+0x17a> @ imm = #0xb8
   61130: eb01 01c0    	add.w	r1, r1, r0, lsl #3
   61134: 48f2         	ldr	r0, [pc, #0x3c8]        @ 0x61500 <f_check_cgm_trend+0x490>
   61136: 9106         	str	r1, [sp, #0x18]
   61138: ef80 c010    	vmov.i32	d12, #0x0
   6113c: 180c         	adds	r4, r1, r0
   6113e: 48f1         	ldr	r0, [pc, #0x3c4]        @ 0x61504 <f_check_cgm_trend+0x494>
   61140: ef80 d811    	vmov.i16	d13, #0x1
   61144: eb01 0800    	add.w	r8, r1, r0
   61148: f10e 0010    	add.w	r0, lr, #0x10
   6114c: ecb0 8b08    	vldmia	r0!, {d8, d9, d10, d11}
   61150: 4eef         	ldr	r6, [pc, #0x3bc]        @ 0x61510 <f_check_cgm_trend+0x4a0>
   61152: 447e         	add	r6, pc
   61154: f1b9 0f00    	cmp.w	r9, #0x0
   61158: f000 8089    	beq.w	0x6126e <f_check_cgm_trend+0x1fe> @ imm = #0x112
   6115c: eeb0 1b48    	vmov.f64	d1, d8
   61160: 200a         	movs	r0, #0xa
   61162: 2104         	movs	r1, #0x4
   61164: f924 070f    	vld1.8	{d0}, [r4]
   61168: 47b0         	blx	r6
   6116a: 4605         	mov	r5, r0
   6116c: f504 7090    	add.w	r0, r4, #0x120
   61170: ef2a 111a    	vorr	d1, d10, d10
   61174: 2104         	movs	r1, #0x4
   61176: f920 070f    	vld1.8	{d0}, [r0]
   6117a: 200a         	movs	r0, #0xa
   6117c: 47b0         	blx	r6
   6117e: ee0e 5b30    	vmov.16	d14[0], r5
   61182: ef29 1119    	vorr	d1, d9, d9
   61186: 2104         	movs	r1, #0x4
   61188: f928 070f    	vld1.8	{d0}, [r8]
   6118c: ee0e 0b70    	vmov.16	d14[1], r0
   61190: 200a         	movs	r0, #0xa
   61192: 47b0         	blx	r6
   61194: ee2e 0b30    	vmov.16	d14[2], r0
   61198: f508 7090    	add.w	r0, r8, #0x120
   6119c: ef2b 111b    	vorr	d1, d11, d11
   611a0: 2104         	movs	r1, #0x4
   611a2: f920 070f    	vld1.8	{d0}, [r0]
   611a6: 200a         	movs	r0, #0xa
   611a8: 47b0         	blx	r6
   611aa: ee2e 0b70    	vmov.16	d14[3], r0
   611ae: 3408         	adds	r4, #0x8
   611b0: f108 0808    	add.w	r8, r8, #0x8
   611b4: f1a9 0901    	sub.w	r9, r9, #0x1
   611b8: fff5 010e    	vceq.i16	d16, d14, #0
   611bc: ef5d 0130    	vbic	d16, d13, d16
   611c0: ef1c c820    	vadd.i16	d12, d12, d16
   611c4: e7c6         	b	0x61154 <f_check_cgm_trend+0xe4> @ imm = #-0x74
   611c6: b2e8         	uxtb	r0, r5
   611c8: fa5f f188    	uxtb.w	r1, r8
   611cc: ea80 000a    	eor.w	r0, r0, r10
   611d0: ea81 010a    	eor.w	r1, r1, r10
   611d4: 4308         	orrs	r0, r1
   611d6: b280         	uxth	r0, r0
   611d8: fab0 f080    	clz	r0, r0
   611dc: 0940         	lsrs	r0, r0, #0x5
   611de: ecbd 4b16    	vpop	{d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14}
   611e2: b001         	add	sp, #0x4
   611e4: e8bd 0f00    	pop.w	{r8, r9, r10, r11}
   611e8: bdf0         	pop	{r4, r5, r6, r7, pc}
   611ea: eb01 01c0    	add.w	r1, r1, r0, lsl #3
   611ee: 48c1         	ldr	r0, [pc, #0x304]        @ 0x614f4 <f_check_cgm_trend+0x484>
   611f0: f8cd a004    	str.w	r10, [sp, #0x4]
   611f4: 464e         	mov	r6, r9
   611f6: 9106         	str	r1, [sp, #0x18]
   611f8: 180c         	adds	r4, r1, r0
   611fa: 48bf         	ldr	r0, [pc, #0x2fc]        @ 0x614f8 <f_check_cgm_trend+0x488>
   611fc: f04f 0b00    	mov.w	r11, #0x0
   61200: ec9e 8b04    	vldmia	lr, {d8, d9}
   61204: f04f 0a00    	mov.w	r10, #0x0
   61208: eb01 0900    	add.w	r9, r1, r0
   6120c: f04f 0800    	mov.w	r8, #0x0
   61210: ed9e ab1a    	vldr	d10, [lr, #104]
   61214: 4dbd         	ldr	r5, [pc, #0x2f4]        @ 0x6150c <f_check_cgm_trend+0x49c>
   61216: 447d         	add	r5, pc
   61218: 2e00         	cmp	r6, #0x0
   6121a: f000 80bb    	beq.w	0x61394 <f_check_cgm_trend+0x324> @ imm = #0x176
   6121e: f5a4 7090    	sub.w	r0, r4, #0x120
   61222: eeb0 1b48    	vmov.f64	d1, d8
   61226: 2104         	movs	r1, #0x4
   61228: f920 070f    	vld1.8	{d0}, [r0]
   6122c: 200a         	movs	r0, #0xa
   6122e: 47a8         	blx	r5
   61230: ef29 1119    	vorr	d1, d9, d9
   61234: 2800         	cmp	r0, #0x0
   61236: bf18         	it	ne
   61238: f10b 0b01    	addne.w	r11, r11, #0x1
   6123c: f924 070f    	vld1.8	{d0}, [r4]
   61240: 200a         	movs	r0, #0xa
   61242: 2104         	movs	r1, #0x4
   61244: 47a8         	blx	r5
   61246: ef2a 111a    	vorr	d1, d10, d10
   6124a: 2800         	cmp	r0, #0x0
   6124c: bf18         	it	ne
   6124e: f10a 0a01    	addne.w	r10, r10, #0x1
   61252: f929 070f    	vld1.8	{d0}, [r9]
   61256: 200a         	movs	r0, #0xa
   61258: 2101         	movs	r1, #0x1
   6125a: 47a8         	blx	r5
   6125c: 2800         	cmp	r0, #0x0
   6125e: bf18         	it	ne
   61260: f108 0801    	addne.w	r8, r8, #0x1
   61264: 3408         	adds	r4, #0x8
   61266: f109 0908    	add.w	r9, r9, #0x8
   6126a: 3e01         	subs	r6, #0x1
   6126c: e7d4         	b	0x61218 <f_check_cgm_trend+0x1a8> @ imm = #-0x58
   6126e: ff87 cb3f    	vbic.i16	d12, #0xff00
   61272: ee80 abb0    	vdup.16	d16, r10
   61276: f1bb 0f05    	cmp.w	r11, #0x5
   6127a: ff50 089c    	vceq.i16	d16, d16, d12
   6127e: ee90 0bf0    	vmov.u16	r0, d16[1]
   61282: ee90 1bb0    	vmov.u16	r1, d16[0]
   61286: f000 0001    	and	r0, r0, #0x1
   6128a: f001 0101    	and	r1, r1, #0x1
   6128e: ea41 0040    	orr.w	r0, r1, r0, lsl #1
   61292: eeb0 1bb0    	vmov.u16	r1, d16[2]
   61296: f001 0101    	and	r1, r1, #0x1
   6129a: ea40 0081    	orr.w	r0, r0, r1, lsl #2
   6129e: eeb0 1bf0    	vmov.u16	r1, d16[3]
   612a2: ea40 00c1    	orr.w	r0, r0, r1, lsl #3
   612a6: f000 000f    	and	r0, r0, #0xf
   612aa: f0c0 80dd    	blo.w	0x61468 <f_check_cgm_trend+0x3f8> @ imm = #0x1ba
   612ae: 9000         	str	r0, [sp]
   612b0: f04f 0b00    	mov.w	r11, #0x0
   612b4: 4894         	ldr	r0, [pc, #0x250]        @ 0x61508 <f_check_cgm_trend+0x498>
   612b6: 9906         	ldr	r1, [sp, #0x18]
   612b8: f8dd 9008    	ldr.w	r9, [sp, #0x8]
   612bc: 180d         	adds	r5, r1, r0
   612be: f24f 3004    	movw	r0, #0xf304
   612c2: eb01 0800    	add.w	r8, r1, r0
   612c6: f107 0008    	add.w	r0, r7, #0x8
   612ca: f100 0150    	add.w	r1, r0, #0x50
   612ce: ed90 bb0e    	vldr	d11, [r0, #56]
   612d2: ed90 cb10    	vldr	d12, [r0, #64]
   612d6: 2000         	movs	r0, #0x0
   612d8: 9006         	str	r0, [sp, #0x18]
   612da: 2000         	movs	r0, #0x0
   612dc: ecb1 8b06    	vldmia	r1!, {d8, d9, d10}
   612e0: 9004         	str	r0, [sp, #0x10]
   612e2: 2000         	movs	r0, #0x0
   612e4: 9003         	str	r0, [sp, #0xc]
   612e6: 2000         	movs	r0, #0x0
   612e8: 9005         	str	r0, [sp, #0x14]
   612ea: f1b9 0f00    	cmp.w	r9, #0x0
   612ee: f000 80bd    	beq.w	0x6146c <f_check_cgm_trend+0x3fc> @ imm = #0x17a
   612f2: f5a5 7010    	sub.w	r0, r5, #0x240
   612f6: ef2b 111b    	vorr	d1, d11, d11
   612fa: 2102         	movs	r1, #0x2
   612fc: f920 d70f    	vld1.8	{d13}, [r0]
   61300: 200a         	movs	r0, #0xa
   61302: ef2d 011d    	vorr	d0, d13, d13
   61306: 47b0         	blx	r6
   61308: 2800         	cmp	r0, #0x0
   6130a: 9806         	ldr	r0, [sp, #0x18]
   6130c: bf18         	it	ne
   6130e: 3001         	addne	r0, #0x1
   61310: f925 e70f    	vld1.8	{d14}, [r5]
   61314: ef2e 011e    	vorr	d0, d14, d14
   61318: 2101         	movs	r1, #0x1
   6131a: eeb0 1b48    	vmov.f64	d1, d8
   6131e: 9006         	str	r0, [sp, #0x18]
   61320: 200a         	movs	r0, #0xa
   61322: 47b0         	blx	r6
   61324: eeb5 db40    	vcmp.f64	d13, #0
   61328: 2800         	cmp	r0, #0x0
   6132a: 9804         	ldr	r0, [sp, #0x10]
   6132c: bf18         	it	ne
   6132e: 3001         	addne	r0, #0x1
   61330: 9004         	str	r0, [sp, #0x10]
   61332: eef1 0b4d    	vneg.f64	d16, d13
   61336: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6133a: bf48         	it	mi
   6133c: eeb0 db60    	vmovmi.f64	d13, d16
   61340: ef2d 011d    	vorr	d0, d13, d13
   61344: 200a         	movs	r0, #0xa
   61346: ef2c 111c    	vorr	d1, d12, d12
   6134a: 2102         	movs	r1, #0x2
   6134c: 47b0         	blx	r6
   6134e: ef2e 011e    	vorr	d0, d14, d14
   61352: 4604         	mov	r4, r0
   61354: ef29 1119    	vorr	d1, d9, d9
   61358: 200a         	movs	r0, #0xa
   6135a: 2101         	movs	r1, #0x1
   6135c: 47b0         	blx	r6
   6135e: 2800         	cmp	r0, #0x0
   61360: 9803         	ldr	r0, [sp, #0xc]
   61362: ef2a 111a    	vorr	d1, d10, d10
   61366: bf18         	it	ne
   61368: 3001         	addne	r0, #0x1
   6136a: f928 070f    	vld1.8	{d0}, [r8]
   6136e: 2101         	movs	r1, #0x1
   61370: 9003         	str	r0, [sp, #0xc]
   61372: 200a         	movs	r0, #0xa
   61374: 47b0         	blx	r6
   61376: 2800         	cmp	r0, #0x0
   61378: 9805         	ldr	r0, [sp, #0x14]
   6137a: bf18         	it	ne
   6137c: 3001         	addne	r0, #0x1
   6137e: 2c00         	cmp	r4, #0x0
   61380: 9005         	str	r0, [sp, #0x14]
   61382: bf18         	it	ne
   61384: f10b 0b01    	addne.w	r11, r11, #0x1
   61388: 3508         	adds	r5, #0x8
   6138a: f108 0808    	add.w	r8, r8, #0x8
   6138e: f1a9 0901    	sub.w	r9, r9, #0x1
   61392: e7aa         	b	0x612ea <f_check_cgm_trend+0x27a> @ imm = #-0xac
   61394: 9a01         	ldr	r2, [sp, #0x4]
   61396: fa5f f08a    	uxtb.w	r0, r10
   6139a: fa5f f18b    	uxtb.w	r1, r11
   6139e: f8dd a008    	ldr.w	r10, [sp, #0x8]
   613a2: 4050         	eors	r0, r2
   613a4: 4051         	eors	r1, r2
   613a6: 4308         	orrs	r0, r1
   613a8: fa5f f188    	uxtb.w	r1, r8
   613ac: b280         	uxth	r0, r0
   613ae: fab0 f080    	clz	r0, r0
   613b2: 0940         	lsrs	r0, r0, #0x5
   613b4: 458a         	cmp	r10, r1
   613b6: f47f af12    	bne.w	0x611de <f_check_cgm_trend+0x16e> @ imm = #-0x1dc
   613ba: 9005         	str	r0, [sp, #0x14]
   613bc: f04f 0b00    	mov.w	r11, #0x0
   613c0: 484e         	ldr	r0, [pc, #0x138]        @ 0x614fc <f_check_cgm_trend+0x48c>
   613c2: f04f 0800    	mov.w	r8, #0x0
   613c6: 9906         	ldr	r1, [sp, #0x18]
   613c8: f04f 0900    	mov.w	r9, #0x0
   613cc: 180c         	adds	r4, r1, r0
   613ce: 484c         	ldr	r0, [pc, #0x130]        @ 0x61500 <f_check_cgm_trend+0x490>
   613d0: 180e         	adds	r6, r1, r0
   613d2: f107 0008    	add.w	r0, r7, #0x8
   613d6: ed90 8b04    	vldr	d8, [r0, #16]
   613da: ed90 9b0a    	vldr	d9, [r0, #40]
   613de: ed90 ab1c    	vldr	d10, [r0, #112]
   613e2: ed90 bb1e    	vldr	d11, [r0, #120]
   613e6: 2000         	movs	r0, #0x0
   613e8: 9006         	str	r0, [sp, #0x18]
   613ea: f1ba 0f00    	cmp.w	r10, #0x0
   613ee: d042         	beq	0x61476 <f_check_cgm_trend+0x406> @ imm = #0x84
   613f0: ef2a 111a    	vorr	d1, d10, d10
   613f4: f924 070f    	vld1.8	{d0}, [r4]
   613f8: 200a         	movs	r0, #0xa
   613fa: 2104         	movs	r1, #0x4
   613fc: 47a8         	blx	r5
   613fe: 2800         	cmp	r0, #0x0
   61400: 9806         	ldr	r0, [sp, #0x18]
   61402: bf18         	it	ne
   61404: 3001         	addne	r0, #0x1
   61406: 9006         	str	r0, [sp, #0x18]
   61408: f504 7090    	add.w	r0, r4, #0x120
   6140c: ef2b 111b    	vorr	d1, d11, d11
   61410: 2104         	movs	r1, #0x4
   61412: f920 070f    	vld1.8	{d0}, [r0]
   61416: 200a         	movs	r0, #0xa
   61418: 47a8         	blx	r5
   6141a: ef28 1118    	vorr	d1, d8, d8
   6141e: 2800         	cmp	r0, #0x0
   61420: bf18         	it	ne
   61422: f10b 0b01    	addne.w	r11, r11, #0x1
   61426: f926 070f    	vld1.8	{d0}, [r6]
   6142a: 200a         	movs	r0, #0xa
   6142c: 2104         	movs	r1, #0x4
   6142e: 47a8         	blx	r5
   61430: 2800         	cmp	r0, #0x0
   61432: f506 7090    	add.w	r0, r6, #0x120
   61436: ef29 1119    	vorr	d1, d9, d9
   6143a: bf18         	it	ne
   6143c: f108 0801    	addne.w	r8, r8, #0x1
   61440: f920 070f    	vld1.8	{d0}, [r0]
   61444: 200a         	movs	r0, #0xa
   61446: 2104         	movs	r1, #0x4
   61448: 47a8         	blx	r5
   6144a: 2800         	cmp	r0, #0x0
   6144c: bf18         	it	ne
   6144e: f109 0901    	addne.w	r9, r9, #0x1
   61452: 3408         	adds	r4, #0x8
   61454: 3608         	adds	r6, #0x8
   61456: f1aa 0a01    	sub.w	r10, r10, #0x1
   6145a: e7c6         	b	0x613ea <f_check_cgm_trend+0x37a> @ imm = #-0x74
   6145c: 76 a0 02 00  	.word	0x0002a076
   61460: 3e f9 ff ff  	.word	0xfffff93e
   61464: 95 8b 01 00  	.word	0x00018b95
   61468: 380f         	subs	r0, #0xf
   6146a: e6b5         	b	0x611d8 <f_check_cgm_trend+0x168> @ imm = #-0x296
   6146c: 9800         	ldr	r0, [sp]
   6146e: 280f         	cmp	r0, #0xf
   61470: d01c         	beq	0x614ac <f_check_cgm_trend+0x43c> @ imm = #0x38
   61472: 2000         	movs	r0, #0x0
   61474: e6b3         	b	0x611de <f_check_cgm_trend+0x16e> @ imm = #-0x29a
   61476: 9b01         	ldr	r3, [sp, #0x4]
   61478: fa5f f089    	uxtb.w	r0, r9
   6147c: fa5f f188    	uxtb.w	r1, r8
   61480: 9a06         	ldr	r2, [sp, #0x18]
   61482: 4058         	eors	r0, r3
   61484: 4059         	eors	r1, r3
   61486: 4308         	orrs	r0, r1
   61488: fa5f f18b    	uxtb.w	r1, r11
   6148c: b2d2         	uxtb	r2, r2
   6148e: 4059         	eors	r1, r3
   61490: 405a         	eors	r2, r3
   61492: b280         	uxth	r0, r0
   61494: 4311         	orrs	r1, r2
   61496: fab0 f080    	clz	r0, r0
   6149a: b289         	uxth	r1, r1
   6149c: 0940         	lsrs	r0, r0, #0x5
   6149e: fab1 f181    	clz	r1, r1
   614a2: 0949         	lsrs	r1, r1, #0x5
   614a4: 4301         	orrs	r1, r0
   614a6: 9805         	ldr	r0, [sp, #0x14]
   614a8: 4008         	ands	r0, r1
   614aa: e698         	b	0x611de <f_check_cgm_trend+0x16e> @ imm = #-0x2d0
   614ac: 9906         	ldr	r1, [sp, #0x18]
   614ae: 9b02         	ldr	r3, [sp, #0x8]
   614b0: 9805         	ldr	r0, [sp, #0x14]
   614b2: b2c9         	uxtb	r1, r1
   614b4: 428b         	cmp	r3, r1
   614b6: b2c0         	uxtb	r0, r0
   614b8: bf02         	ittt	eq
   614ba: 9904         	ldreq	r1, [sp, #0x10]
   614bc: b2c9         	uxtbeq	r1, r1
   614be: 428b         	cmpeq	r3, r1
   614c0: d013         	beq	0x614ea <f_check_cgm_trend+0x47a> @ imm = #0x26
   614c2: 9903         	ldr	r1, [sp, #0xc]
   614c4: fa5f f28b    	uxtb.w	r2, r11
   614c8: ea82 020a    	eor.w	r2, r2, r10
   614cc: 1a18         	subs	r0, r3, r0
   614ce: b2c9         	uxtb	r1, r1
   614d0: fab0 f080    	clz	r0, r0
   614d4: ea81 010a    	eor.w	r1, r1, r10
   614d8: 0940         	lsrs	r0, r0, #0x5
   614da: 4311         	orrs	r1, r2
   614dc: b289         	uxth	r1, r1
   614de: fab1 f181    	clz	r1, r1
   614e2: 0949         	lsrs	r1, r1, #0x5
   614e4: 4201         	tst	r1, r0
   614e6: d0c4         	beq	0x61472 <f_check_cgm_trend+0x402> @ imm = #-0x78
   614e8: e001         	b	0x614ee <f_check_cgm_trend+0x47e> @ imm = #0x2
   614ea: 4283         	cmp	r3, r0
   614ec: d1c1         	bne	0x61472 <f_check_cgm_trend+0x402> @ imm = #-0x7e
   614ee: 2001         	movs	r0, #0x1
   614f0: e675         	b	0x611de <f_check_cgm_trend+0x16e> @ imm = #-0x316
   614f2: bf00         	nop
   614f4: 95 8b 01 00  	.word	0x00018b95
   614f8: 94 4e 01 00  	.word	0x00014e94
   614fc: b4 4f 01 00  	.word	0x00014fb4
   61500: 1c 31 01 00  	.word	0x0001311c
   61504: 75 8a 01 00  	.word	0x00018a75
   61508: fc 2f 01 00  	.word	0x00012ffc
   6150c: bf e1 ff ff  	.word	0xffffe1bf
   61510: 83 e2 ff ff  	.word	0xffffe283
   61514: d4 d4 d4 d4  	.word	0xd4d4d4d4

00061518 <cal_threshold>:
   61518: b5f0         	push	{r4, r5, r6, r7, lr}
   6151a: af03         	add	r7, sp, #0xc
   6151c: f84d bd04    	str	r11, [sp, #-4]!
   61520: eeb5 1b40    	vcmp.f64	d1, #0
   61524: 68bd         	ldr	r5, [r7, #0x8]
   61526: eef1 0b41    	vneg.f64	d16, d1
   6152a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6152e: bf48         	it	mi
   61530: eeb0 1b60    	vmovmi.f64	d1, d16
   61534: 4e34         	ldr	r6, [pc, #0xd0]         @ 0x61608 <cal_threshold+0xf0>
   61536: f893 e000    	ldrb.w	lr, [r3]
   6153a: 447e         	add	r6, pc
   6153c: edd2 0b00    	vldr	d16, [r2]
   61540: f8b6 447a    	ldrh.w	r4, [r6, #0x47a]
   61544: 42ac         	cmp	r4, r5
   61546: d915         	bls	0x61574 <cal_threshold+0x5c> @ imm = #0x2a
   61548: b325         	cbz	r5, 0x61594 <cal_threshold+0x7c> @ imm = #0x48
   6154a: eeb4 2b42    	vcmp.f64	d2, d2
   6154e: f105 0c01    	add.w	r12, r5, #0x1
   61552: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   61556: eddf 1b2a    	vldr	d17, [pc, #168]         @ 0x61600 <cal_threshold+0xe8>
   6155a: bf68         	it	vs
   6155c: eeb0 2b61    	vmovvs.f64	d2, d17
   61560: ee32 0b00    	vadd.f64	d0, d2, d0
   61564: eeb4 3b43    	vcmp.f64	d3, d3
   61568: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6156c: d645         	bvs	0x615fa <cal_threshold+0xe2> @ imm = #0x8a
   6156e: ee71 0b03    	vadd.f64	d16, d1, d3
   61572: e037         	b	0x615e4 <cal_threshold+0xcc> @ imm = #0x6e
   61574: f8b0 c000    	ldrh.w	r12, [r0]
   61578: d109         	bne	0x6158e <cal_threshold+0x76> @ imm = #0x12
   6157a: 68fc         	ldr	r4, [r7, #0xc]
   6157c: 2c01         	cmp	r4, #0x1
   6157e: d117         	bne	0x615b0 <cal_threshold+0x98> @ imm = #0x2e
   61580: f04f 0e01    	mov.w	lr, #0x1
   61584: eeb0 0b42    	vmov.f64	d0, d2
   61588: eef0 0b43    	vmov.f64	d16, d3
   6158c: e02a         	b	0x615e4 <cal_threshold+0xcc> @ imm = #0x54
   6158e: ed91 0b00    	vldr	d0, [r1]
   61592: e027         	b	0x615e4 <cal_threshold+0xcc> @ imm = #0x4e
   61594: f506 6490    	add.w	r4, r6, #0x480
   61598: f04f 0c01    	mov.w	r12, #0x1
   6159c: edd4 1b00    	vldr	d17, [r4]
   615a0: eeb4 1b61    	vcmp.f64	d1, d17
   615a4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   615a8: dd1c         	ble	0x615e4 <cal_threshold+0xcc> @ imm = #0x38
   615aa: eef0 0b41    	vmov.f64	d16, d1
   615ae: e019         	b	0x615e4 <cal_threshold+0xcc> @ imm = #0x32
   615b0: ee00 5a10    	vmov	s0, r5
   615b4: f896 547d    	ldrb.w	r5, [r6, #0x47d]
   615b8: f896 447c    	ldrb.w	r4, [r6, #0x47c]
   615bc: f04f 0e01    	mov.w	lr, #0x1
   615c0: eef8 1b40    	vcvt.f64.u32	d17, s0
   615c4: eec3 0b21    	vdiv.f64	d16, d3, d17
   615c8: eec2 1b21    	vdiv.f64	d17, d2, d17
   615cc: ee00 5a10    	vmov	s0, r5
   615d0: eef8 2b40    	vcvt.f64.u32	d18, s0
   615d4: ee00 4a10    	vmov	s0, r4
   615d8: ee60 0ba2    	vmul.f64	d16, d16, d18
   615dc: eef8 2b40    	vcvt.f64.u32	d18, s0
   615e0: ee21 0ba2    	vmul.f64	d0, d17, d18
   615e4: ed81 0b00    	vstr	d0, [r1]
   615e8: f8a0 c000    	strh.w	r12, [r0]
   615ec: edc2 0b00    	vstr	d16, [r2]
   615f0: f883 e000    	strb.w	lr, [r3]
   615f4: f85d bb04    	ldr	r11, [sp], #4
   615f8: bdf0         	pop	{r4, r5, r6, r7, pc}
   615fa: f506 6490    	add.w	r4, r6, #0x480
   615fe: e7cd         	b	0x6159c <cal_threshold+0x84> @ imm = #-0x66
   61600: 00 00 00 00  	.word	0x00000000
   61604: 00 00 00 80  	.word	0x80000000
   61608: 6a a4 02 00  	.word	0x0002a46a

0006160c <err1_TD_var_update>:
   6160c: b5f0         	push	{r4, r5, r6, r7, lr}
   6160e: af03         	add	r7, sp, #0xc
   61610: f84d 8d04    	str	r8, [sp, #-4]!
   61614: f8d7 c010    	ldr.w	r12, [r7, #0x10]
   61618: f04f 0800    	mov.w	r8, #0x0
   6161c: e9d7 4e02    	ldrd	r4, lr, [r7, #8]
   61620: 2600         	movs	r6, #0x0
   61622: 2e5a         	cmp	r6, #0x5a
   61624: d00f         	beq	0x61646 <err1_TD_var_update+0x3a> @ imm = #0x1e
   61626: f85e 5026    	ldr.w	r5, [lr, r6, lsl #2]
   6162a: edd4 0b00    	vldr	d16, [r4]
   6162e: f842 5026    	str.w	r5, [r2, r6, lsl #2]
   61632: ece1 0b02    	vstmia	r1!, {d16}
   61636: f820 8016    	strh.w	r8, [r0, r6, lsl #1]
   6163a: f84e 8026    	str.w	r8, [lr, r6, lsl #2]
   6163e: 3601         	adds	r6, #0x1
   61640: e8e4 8802    	strd	r8, r8, [r4], #8
   61644: e7ed         	b	0x61622 <err1_TD_var_update+0x16> @ imm = #-0x26
   61646: f8bc 0000    	ldrh.w	r0, [r12]
   6164a: 8018         	strh	r0, [r3]
   6164c: 2000         	movs	r0, #0x0
   6164e: f8ac 0000    	strh.w	r0, [r12]
   61652: f85d 8b04    	ldr	r8, [sp], #4
   61656: bdf0         	pop	{r4, r5, r6, r7, pc}

00061658 <err1_TD_trio_update>:
   61658: b5f0         	push	{r4, r5, r6, r7, lr}
   6165a: af03         	add	r7, sp, #0xc
   6165c: e92d 0f00    	push.w	{r8, r9, r10, r11}
   61660: f8d7 8010    	ldr.w	r8, [r7, #0x10]
   61664: f04f 0a00    	mov.w	r10, #0x0
   61668: e9d7 be02    	ldrd	r11, lr, [r7, #8]
   6166c: f04f 0900    	mov.w	r9, #0x0
   61670: f1b9 0f5a    	cmp.w	r9, #0x5a
   61674: d01c         	beq	0x616b0 <err1_TD_trio_update+0x58> @ imm = #0x38
   61676: 2400         	movs	r4, #0x0
   61678: 4606         	mov	r6, r0
   6167a: 461d         	mov	r5, r3
   6167c: 2c03         	cmp	r4, #0x3
   6167e: d00d         	beq	0x6169c <err1_TD_trio_update+0x44> @ imm = #0x1a
   61680: f85b c024    	ldr.w	r12, [r11, r4, lsl #2]
   61684: edd5 0b00    	vldr	d16, [r5]
   61688: f841 c024    	str.w	r12, [r1, r4, lsl #2]
   6168c: f84b a024    	str.w	r10, [r11, r4, lsl #2]
   61690: 3401         	adds	r4, #0x1
   61692: ece6 0b02    	vstmia	r6!, {d16}
   61696: e8e5 aa02    	strd	r10, r10, [r5], #8
   6169a: e7ef         	b	0x6167c <err1_TD_trio_update+0x24> @ imm = #-0x22
   6169c: f808 a009    	strb.w	r10, [r8, r9]
   616a0: 3018         	adds	r0, #0x18
   616a2: 3318         	adds	r3, #0x18
   616a4: 310c         	adds	r1, #0xc
   616a6: f10b 0b0c    	add.w	r11, r11, #0xc
   616aa: f109 0901    	add.w	r9, r9, #0x1
   616ae: e7df         	b	0x61670 <err1_TD_trio_update+0x18> @ imm = #-0x42
   616b0: 6979         	ldr	r1, [r7, #0x14]
   616b2: f89e 0000    	ldrb.w	r0, [lr]
   616b6: 7010         	strb	r0, [r2]
   616b8: 2000         	movs	r0, #0x0
   616ba: f88e 0000    	strb.w	r0, [lr]
   616be: 7008         	strb	r0, [r1]
   616c0: e8bd 0f00    	pop.w	{r8, r9, r10, r11}
   616c4: bdf0         	pop	{r4, r5, r6, r7, pc}
   616c6: d4d4         	bmi	0x61672 <err1_TD_trio_update+0x1a> @ imm = #-0x58

000616c8 <get_version_air1_opcal4>:
   616c8: 4906         	ldr	r1, [pc, #0x18]         @ 0x616e4 <get_version_air1_opcal4+0x1c>
   616ca: 4479         	add	r1, pc
   616cc: edd1 0b00    	vldr	d16, [r1]
   616d0: 3107         	adds	r1, #0x7
   616d2: f940 070f    	vst1.8	{d16}, [r0]
   616d6: 3007         	adds	r0, #0x7
   616d8: f961 070f    	vld1.8	{d16}, [r1]
   616dc: f940 070f    	vst1.8	{d16}, [r0]
   616e0: 4770         	bx	lr
   616e2: bf00         	nop
   616e4: ba 7a fc ff  	.word	0xfffc7aba

000616e8 <air1_opcal4_algorithm>:
   616e8: b5f0         	push	{r4, r5, r6, r7, lr}
   616ea: af03         	add	r7, sp, #0xc
   616ec: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   616f0: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   616f4: f5ad 5d8a    	sub.w	sp, sp, #0x1140
   616f8: b084         	sub	sp, #0x10
   616fa: 915f         	str	r1, [sp, #0x17c]
   616fc: 4682         	mov	r10, r0
   616fe: 9246         	str	r2, [sp, #0x118]
   61700: f240 3111    	movw	r1, #0x311
   61704: f8df 0bb8    	ldr.w	r0, [pc, #0xbb8]        @ 0x622c0 <air1_opcal4_algorithm+0xbd8>
   61708: 461e         	mov	r6, r3
   6170a: 4478         	add	r0, pc
   6170c: 6800         	ldr	r0, [r0]
   6170e: 6800         	ldr	r0, [r0]
   61710: f847 0c6c    	str	r0, [r7, #-108]
   61714: 4817         	ldr	r0, [pc, #0x5c]         @ 0x61774 <air1_opcal4_algorithm+0x8c>
   61716: 4d18         	ldr	r5, [pc, #0x60]         @ 0x61778 <air1_opcal4_algorithm+0x90>
   61718: 4478         	add	r0, pc
   6171a: 9054         	str	r0, [sp, #0x150]
   6171c: 447d         	add	r5, pc
   6171e: 47a8         	blx	r5
   61720: 4816         	ldr	r0, [pc, #0x58]         @ 0x6177c <air1_opcal4_algorithm+0x94>
   61722: 219b         	movs	r1, #0x9b
   61724: 4478         	add	r0, pc
   61726: 4683         	mov	r11, r0
   61728: 47a8         	blx	r5
   6172a: 4c15         	ldr	r4, [pc, #0x54]         @ 0x61780 <air1_opcal4_algorithm+0x98>
   6172c: f240 612b    	movw	r1, #0x62b
   61730: 9545         	str	r5, [sp, #0x114]
   61732: 447c         	add	r4, pc
   61734: 4620         	mov	r0, r4
   61736: 47a8         	blx	r5
   61738: 8930         	ldrh	r0, [r6, #0x8]
   6173a: 1c41         	adds	r1, r0, #0x1
   6173c: 8131         	strh	r1, [r6, #0x8]
   6173e: 2800         	cmp	r0, #0x0
   61740: f040 8086    	bne.w	0x61850 <air1_opcal4_algorithm+0x168> @ imm = #0x10c
   61744: f8da 01b6    	ldr.w	r0, [r10, #0x1b6]
   61748: efc0 1010    	vmov.i32	d17, #0x0
   6174c: ee00 0a10    	vmov	s0, r0
   61750: eeb4 0a40    	vcmp.f32	s0, s0
   61754: eef7 0ac0    	vcvt.f64.f32	d16, s0
   61758: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6175c: bf68         	it	vs
   6175e: eef0 0b61    	vmovvs.f64	d16, d17
   61762: eddf 1b09    	vldr	d17, [pc, #36]          @ 0x61788 <air1_opcal4_algorithm+0xa0>
   61766: eef4 0b61    	vcmp.f64	d16, d17
   6176a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6176e: d567         	bpl	0x61840 <air1_opcal4_algorithm+0x158> @ imm = #0xce
   61770: 2002         	movs	r0, #0x2
   61772: e06c         	b	0x6184e <air1_opcal4_algorithm+0x166> @ imm = #0xd8
   61774: 04 fd 02 00  	.word	0x0002fd04
   61778: 55 4f 00 00  	.word	0x00004f55
   6177c: 0a 00 03 00  	.word	0x0003000a
   61780: 98 00 03 00  	.word	0x00030098
   61784: 00 bf 00 bf  	.word	0xbf00bf00
   61788: 33 33 33 33  	.word	0x33333333
   6178c: 33 33 b3 3f  	.word	0x3fb33333
   61790: c4 ff ff ff  	.word	0xffffffc4
   61794: ff ff ff ff  	.word	0xffffffff
   61798: 84 03 00 00  	.word	0x00000384
   6179c: 00 00 00 00  	.word	0x00000000
   617a0: 33 33 33 33  	.word	0x33333333
   617a4: 33 33 f3 3f  	.word	0x3ff33333
   617a8: 9a 99 99 99  	.word	0x9999999a
   617ac: 99 99 c9 3f  	.word	0x3fc99999
   617b0: 9a 99 99 99  	.word	0x9999999a
   617b4: 99 99 f9 3f  	.word	0x3ff99999
   617b8: cd cc cc cc  	.word	0xcccccccd
   617bc: cc cc ec 3f  	.word	0x3feccccc
   617c0: 00 00 00 00  	.word	0x00000000
   617c4: 00 00 49 c0  	.word	0xc0490000
   617c8: 00 00 00 00  	.word	0x00000000
   617cc: 00 00 54 c0  	.word	0xc0540000
   617d0: 00 00 00 00  	.word	0x00000000
   617d4: 00 c0 72 40  	.word	0x4072c000
   617d8: 00 00 00 00  	.word	0x00000000
   617dc: 00 c0 62 40  	.word	0x4062c000
   617e0: 00 00 00 00  	.word	0x00000000
   617e4: 00 00 44 c0  	.word	0xc0440000
   617e8: 00 00 00 00  	.word	0x00000000
   617ec: 00 00 49 40  	.word	0x40490000
   617f0: 00 00 00 00  	.word	0x00000000
   617f4: 00 80 a6 40  	.word	0x40a68000
   617f8: 00 00 00 00  	.word	0x00000000
   617fc: 00 20 ac 40  	.word	0x40ac2000
   61800: 00 00 00 00  	.word	0x00000000
   61804: 00 00 8b 40  	.word	0x408b0000
   61808: 00 00 00 00  	.word	0x00000000
   6180c: 00 00 7b 40  	.word	0x407b0000
   61810: 9a 99 99 99  	.word	0x9999999a
   61814: 99 99 a9 3f  	.word	0x3fa99999
   61818: cd cc cc cc  	.word	0xcccccccd
   6181c: cc cc dc 3f  	.word	0x3fdccccc
   61820: 2b 00 28 00  	.word	0x0028002b
   61824: 25 00 22 00  	.word	0x00220025
   61828: 02 00 06 00  	.word	0x00060002
   6182c: 04 00 08 00  	.word	0x00080004
   61830: 05 00 03 00  	.word	0x00030005
   61834: 40 02 05 00  	.word	0x00050240
   61838: 60 03 18 00  	.word	0x00180360
   6183c: 0b 00 17 00  	.word	0x0017000b
   61840: eef4 0b61    	vcmp.f64	d16, d17
   61844: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   61848: bfd4         	ite	le
   6184a: 2000         	movle	r0, #0x0
   6184c: 2001         	movgt	r0, #0x1
   6184e: 70b0         	strb	r0, [r6, #0x2]
   61850: f50a 70d9    	add.w	r0, r10, #0x1b2
   61854: 904e         	str	r0, [sp, #0x138]
   61856: 945e         	str	r4, [sp, #0x178]
   61858: 2300         	movs	r3, #0x0
   6185a: 4cfb         	ldr	r4, [pc, #0x3ec]        @ 0x61c48 <air1_opcal4_algorithm+0x560>
   6185c: efc0 0050    	vmov.i32	q8, #0x0
   61860: 48fa         	ldr	r0, [pc, #0x3e8]        @ 0x61c4c <air1_opcal4_algorithm+0x564>
   61862: eeb7 fb00    	vmov.f64	d15, #1.000000e+00
   61866: 447c         	add	r4, pc
   61868: 4af9         	ldr	r2, [pc, #0x3e4]        @ 0x61c50 <air1_opcal4_algorithm+0x568>
   6186a: 4dfa         	ldr	r5, [pc, #0x3e8]        @ 0x61c54 <air1_opcal4_algorithm+0x56c>
   6186c: e9c4 3002    	strd	r3, r0, [r4, #8]
   61870: 48f9         	ldr	r0, [pc, #0x3e4]        @ 0x61c58 <air1_opcal4_algorithm+0x570>
   61872: 4694         	mov	r12, r2
   61874: 49f9         	ldr	r1, [pc, #0x3e4]        @ 0x61c5c <air1_opcal4_algorithm+0x574>
   61876: eeb7 eb08    	vmov.f64	d14, #1.500000e+00
   6187a: e9c4 3200    	strd	r3, r2, [r4]
   6187e: e9c4 300a    	strd	r3, r0, [r4, #40]
   61882: 48f7         	ldr	r0, [pc, #0x3dc]        @ 0x61c60 <air1_opcal4_algorithm+0x578>
   61884: 4af7         	ldr	r2, [pc, #0x3dc]        @ 0x61c64 <air1_opcal4_algorithm+0x57c>
   61886: eef0 3b4e    	vmov.f64	d19, d14
   6188a: e9c4 250c    	strd	r2, r5, [r4, #48]
   6188e: f04f 3566    	mov.w	r5, #0x66666666
   61892: e9c4 5012    	strd	r5, r0, [r4, #72]
   61896: e9c4 3104    	strd	r3, r1, [r4, #16]
   6189a: 49f3         	ldr	r1, [pc, #0x3cc]        @ 0x61c68 <air1_opcal4_algorithm+0x580>
   6189c: 48f3         	ldr	r0, [pc, #0x3cc]        @ 0x61c6c <air1_opcal4_algorithm+0x584>
   6189e: 4df4         	ldr	r5, [pc, #0x3d0]        @ 0x61c70 <air1_opcal4_algorithm+0x588>
   618a0: e9c4 210e    	strd	r2, r1, [r4, #56]
   618a4: 4681         	mov	r9, r0
   618a6: 49f3         	ldr	r1, [pc, #0x3cc]        @ 0x61c74 <air1_opcal4_algorithm+0x58c>
   618a8: 48f3         	ldr	r0, [pc, #0x3cc]        @ 0x61c78 <air1_opcal4_algorithm+0x590>
   618aa: 46ae         	mov	lr, r5
   618ac: 4af3         	ldr	r2, [pc, #0x3cc]        @ 0x61c7c <air1_opcal4_algorithm+0x594>
   618ae: e9c4 2114    	strd	r2, r1, [r4, #80]
   618b2: e9c4 c31d    	strd	r12, r3, [r4, #116]
   618b6: 4684         	mov	r12, r0
   618b8: 49f1         	ldr	r1, [pc, #0x3c4]        @ 0x61c80 <air1_opcal4_algorithm+0x598>
   618ba: 48f2         	ldr	r0, [pc, #0x3c8]        @ 0x61c84 <air1_opcal4_algorithm+0x59c>
   618bc: 4af2         	ldr	r2, [pc, #0x3c8]        @ 0x61c88 <air1_opcal4_algorithm+0x5a0>
   618be: 4df3         	ldr	r5, [pc, #0x3cc]        @ 0x61c8c <air1_opcal4_algorithm+0x5a4>
   618c0: e9c4 502c    	strd	r5, r0, [r4, #176]
   618c4: e9c4 3122    	strd	r3, r1, [r4, #136]
   618c8: 4690         	mov	r8, r2
   618ca: 49f1         	ldr	r1, [pc, #0x3c4]        @ 0x61c90 <air1_opcal4_algorithm+0x5a8>
   618cc: 48f1         	ldr	r0, [pc, #0x3c4]        @ 0x61c94 <air1_opcal4_algorithm+0x5ac>
   618ce: f8c4 9098    	str.w	r9, [r4, #0x98]
   618d2: 46b1         	mov	r9, r6
   618d4: f104 069c    	add.w	r6, r4, #0x9c
   618d8: 4aef         	ldr	r2, [pc, #0x3bc]        @ 0x61c98 <air1_opcal4_algorithm+0x5b0>
   618da: e886 5106    	stm.w	r6, {r1, r2, r8, r12, lr}
   618de: 49ef         	ldr	r1, [pc, #0x3bc]        @ 0x61c9c <air1_opcal4_algorithm+0x5b4>
   618e0: e9c4 102e    	strd	r1, r0, [r4, #184]
   618e4: 48ee         	ldr	r0, [pc, #0x3b8]        @ 0x61ca0 <air1_opcal4_algorithm+0x5b8>
   618e6: 49ef         	ldr	r1, [pc, #0x3bc]        @ 0x61ca4 <air1_opcal4_algorithm+0x5bc>
   618e8: 4aef         	ldr	r2, [pc, #0x3bc]        @ 0x61ca8 <air1_opcal4_algorithm+0x5c0>
   618ea: e9c4 1036    	strd	r1, r0, [r4, #216]
   618ee: e9c4 1038    	strd	r1, r0, [r4, #224]
   618f2: 49ee         	ldr	r1, [pc, #0x3b8]        @ 0x61cac <air1_opcal4_algorithm+0x5c4>
   618f4: 48ee         	ldr	r0, [pc, #0x3b8]        @ 0x61cb0 <air1_opcal4_algorithm+0x5c8>
   618f6: 4def         	ldr	r5, [pc, #0x3bc]        @ 0x61cb4 <air1_opcal4_algorithm+0x5cc>
   618f8: e9c4 313e    	strd	r3, r1, [r4, #248]
   618fc: f04f 3166    	mov.w	r1, #0x66666666
   61900: e9c4 1040    	strd	r1, r0, [r4, #256]
   61904: 200a         	movs	r0, #0xa
   61906: f8a4 00d0    	strh.w	r0, [r4, #0xd0]
   6190a: 2001         	movs	r0, #0x1
   6190c: f884 0092    	strb.w	r0, [r4, #0x92]
   61910: 2118         	movs	r1, #0x18
   61912: f884 0080    	strb.w	r0, [r4, #0x80]
   61916: f884 0040    	strb.w	r0, [r4, #0x40]
   6191a: 201e         	movs	r0, #0x1e
   6191c: f884 0020    	strb.w	r0, [r4, #0x20]
   61920: 48e5         	ldr	r0, [pc, #0x394]        @ 0x61cb8 <air1_opcal4_algorithm+0x5d0>
   61922: 61e0         	str	r0, [r4, #0x1c]
   61924: 2002         	movs	r0, #0x2
   61926: 76a0         	strb	r0, [r4, #0x1a]
   61928: f44f 7080    	mov.w	r0, #0x100
   6192c: 8320         	strh	r0, [r4, #0x18]
   6192e: f104 0060    	add.w	r0, r4, #0x60
   61932: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   61936: 6003         	str	r3, [r0]
   61938: f504 7084    	add.w	r0, r4, #0x108
   6193c: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   61940: f8a4 1090    	strh.w	r1, [r4, #0x90]
   61944: f44f 6110    	mov.w	r1, #0x900
   61948: 6003         	str	r3, [r0]
   6194a: 48dc         	ldr	r0, [pc, #0x370]        @ 0x61cbc <air1_opcal4_algorithm+0x5d4>
   6194c: f8a4 1086    	strh.w	r1, [r4, #0x86]
   61950: 49db         	ldr	r1, [pc, #0x36c]        @ 0x61cc0 <air1_opcal4_algorithm+0x5d8>
   61952: f8c4 1082    	str.w	r1, [r4, #0x82]
   61956: 49c5         	ldr	r1, [pc, #0x314]        @ 0x61c6c <air1_opcal4_algorithm+0x584>
   61958: e9c4 1048    	strd	r1, r0, [r4, #288]
   6195c: f504 7094    	add.w	r0, r4, #0x128
   61960: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   61964: 6003         	str	r3, [r0]
   61966: 48ba         	ldr	r0, [pc, #0x2e8]        @ 0x61c50 <air1_opcal4_algorithm+0x568>
   61968: e9c4 5230    	strd	r5, r2, [r4, #192]
   6196c: 4ad5         	ldr	r2, [pc, #0x354]        @ 0x61cc4 <air1_opcal4_algorithm+0x5dc>
   6196e: f8cd a134    	str.w	r10, [sp, #0x134]
   61972: 4684         	mov	r12, r0
   61974: 4682         	mov	r10, r0
   61976: e9c4 037b    	strd	r0, r3, [r4, #492]
   6197a: f8c4 01f4    	str.w	r0, [r4, #0x1f4]
   6197e: 48d2         	ldr	r0, [pc, #0x348]        @ 0x61cc8 <air1_opcal4_algorithm+0x5e0>
   61980: 4dd2         	ldr	r5, [pc, #0x348]        @ 0x61ccc <air1_opcal4_algorithm+0x5e4>
   61982: e9c4 523a    	strd	r5, r2, [r4, #232]
   61986: 4ad2         	ldr	r2, [pc, #0x348]        @ 0x61cd0 <air1_opcal4_algorithm+0x5e8>
   61988: e9c4 2073    	strd	r2, r0, [r4, #460]
   6198c: 48d1         	ldr	r0, [pc, #0x344]        @ 0x61cd4 <air1_opcal4_algorithm+0x5ec>
   6198e: 49d2         	ldr	r1, [pc, #0x348]        @ 0x61cd8 <air1_opcal4_algorithm+0x5f0>
   61990: f8c4 11d4    	str.w	r1, [r4, #0x1d4]
   61994: 4686         	mov	lr, r0
   61996: 48d1         	ldr	r0, [pc, #0x344]        @ 0x61cdc <air1_opcal4_algorithm+0x5f4>
   61998: 49d1         	ldr	r1, [pc, #0x344]        @ 0x61ce0 <air1_opcal4_algorithm+0x5f8>
   6199a: 4ad2         	ldr	r2, [pc, #0x348]        @ 0x61ce4 <air1_opcal4_algorithm+0x5fc>
   6199c: 4682         	mov	r10, r0
   6199e: e9c4 1067    	strd	r1, r0, [r4, #412]
   619a2: f504 70d2    	add.w	r0, r4, #0x1a4
   619a6: 4dd0         	ldr	r5, [pc, #0x340]        @ 0x61ce8 <air1_opcal4_algorithm+0x600>
   619a8: e8a0 4024    	stm.w	r0!, {r2, r5, lr}
   619ac: 48cf         	ldr	r0, [pc, #0x33c]        @ 0x61cec <air1_opcal4_algorithm+0x604>
   619ae: 4ed0         	ldr	r6, [pc, #0x340]        @ 0x61cf0 <air1_opcal4_algorithm+0x608>
   619b0: e9c4 3c6c    	strd	r3, r12, [r4, #432]
   619b4: 4680         	mov	r8, r0
   619b6: 48cf         	ldr	r0, [pc, #0x33c]        @ 0x61cf4 <air1_opcal4_algorithm+0x60c>
   619b8: e9c4 3632    	strd	r3, r6, [r4, #200]
   619bc: 4ece         	ldr	r6, [pc, #0x338]        @ 0x61cf8 <air1_opcal4_algorithm+0x610>
   619be: 4684         	mov	r12, r0
   619c0: 48ce         	ldr	r0, [pc, #0x338]        @ 0x61cfc <air1_opcal4_algorithm+0x614>
   619c2: f8c4 0184    	str.w	r0, [r4, #0x184]
   619c6: e9c4 363c    	strd	r3, r6, [r4, #240]
   619ca: 4686         	mov	lr, r0
   619cc: 48cc         	ldr	r0, [pc, #0x330]        @ 0x61d00 <air1_opcal4_algorithm+0x618>
   619ce: 4ecd         	ldr	r6, [pc, #0x334]        @ 0x61d04 <air1_opcal4_algorithm+0x61c>
   619d0: 4dcd         	ldr	r5, [pc, #0x334]        @ 0x61d08 <air1_opcal4_algorithm+0x620>
   619d2: e9c4 8c62    	strd	r8, r12, [r4, #392]
   619d6: 4684         	mov	r12, r0
   619d8: e9c4 a264    	strd	r10, r2, [r4, #400]
   619dc: 4acb         	ldr	r2, [pc, #0x32c]        @ 0x61d0c <air1_opcal4_algorithm+0x624>
   619de: 48cc         	ldr	r0, [pc, #0x330]        @ 0x61d10 <air1_opcal4_algorithm+0x628>
   619e0: e9c4 2657    	strd	r2, r6, [r4, #348]
   619e4: f504 72b2    	add.w	r2, r4, #0x164
   619e8: e9c4 155f    	strd	r1, r5, [r4, #380]
   619ec: 49c9         	ldr	r1, [pc, #0x324]        @ 0x61d14 <air1_opcal4_algorithm+0x62c>
   619ee: e882 1003    	stm.w	r2, {r0, r1, r12}
   619f2: 48c9         	ldr	r0, [pc, #0x324]        @ 0x61d18 <air1_opcal4_algorithm+0x630>
   619f4: f8c4 0150    	str.w	r0, [r4, #0x150]
   619f8: 48c8         	ldr	r0, [pc, #0x320]        @ 0x61d1c <air1_opcal4_algorithm+0x634>
   619fa: f8c4 0154    	str.w	r0, [r4, #0x154]
   619fe: f04f 4080    	mov.w	r0, #0x40000000
   61a02: f8c4 014c    	str.w	r0, [r4, #0x14c]
   61a06: 4897         	ldr	r0, [pc, #0x25c]        @ 0x61c64 <air1_opcal4_algorithm+0x57c>
   61a08: f8c4 0140    	str.w	r0, [r4, #0x140]
   61a0c: 49c4         	ldr	r1, [pc, #0x310]        @ 0x61d20 <air1_opcal4_algorithm+0x638>
   61a0e: 4684         	mov	r12, r0
   61a10: 4890         	ldr	r0, [pc, #0x240]        @ 0x61c54 <air1_opcal4_algorithm+0x56c>
   61a12: f8c4 0144    	str.w	r0, [r4, #0x144]
   61a16: f504 70ec    	add.w	r0, r4, #0x1d8
   61a1a: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   61a1e: 6003         	str	r3, [r0]
   61a20: f504 70dc    	add.w	r0, r4, #0x1b8
   61a24: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   61a28: 6001         	str	r1, [r0]
   61a2a: f504 70fc    	add.w	r0, r4, #0x1f8
   61a2e: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   61a32: 4987         	ldr	r1, [pc, #0x21c]        @ 0x61c50 <air1_opcal4_algorithm+0x568>
   61a34: f8c4 120c    	str.w	r1, [r4, #0x20c]
   61a38: 498c         	ldr	r1, [pc, #0x230]        @ 0x61c6c <air1_opcal4_algorithm+0x584>
   61a3a: 6003         	str	r3, [r0]
   61a3c: 48b9         	ldr	r0, [pc, #0x2e4]        @ 0x61d24 <air1_opcal4_algorithm+0x63c>
   61a3e: 4aba         	ldr	r2, [pc, #0x2e8]        @ 0x61d28 <air1_opcal4_algorithm+0x640>
   61a40: 468a         	mov	r10, r1
   61a42: f8c4 6198    	str.w	r6, [r4, #0x198]
   61a46: f8c4 6178    	str.w	r6, [r4, #0x178]
   61a4a: 4e91         	ldr	r6, [pc, #0x244]        @ 0x61c90 <air1_opcal4_algorithm+0x5a8>
   61a4c: e9c4 1088    	strd	r1, r0, [r4, #544]
   61a50: f8c4 1228    	str.w	r1, [r4, #0x228]
   61a54: 49b5         	ldr	r1, [pc, #0x2d4]        @ 0x61d2c <air1_opcal4_algorithm+0x644>
   61a56: 48b6         	ldr	r0, [pc, #0x2d8]        @ 0x61d30 <air1_opcal4_algorithm+0x648>
   61a58: f8c4 5158    	str.w	r5, [r4, #0x158]
   61a5c: e9c4 5e5c    	strd	r5, lr, [r4, #368]
   61a60: 4db4         	ldr	r5, [pc, #0x2d0]        @ 0x61d34 <air1_opcal4_algorithm+0x64c>
   61a62: e9c4 a690    	strd	r10, r6, [r4, #576]
   61a66: 4692         	mov	r10, r2
   61a68: e9c4 2193    	strd	r2, r1, [r4, #588]
   61a6c: f8c4 0254    	str.w	r0, [r4, #0x254]
   61a70: 48b1         	ldr	r0, [pc, #0x2c4]        @ 0x61d38 <air1_opcal4_algorithm+0x650>
   61a72: e9c4 c286    	strd	r12, r2, [r4, #536]
   61a76: f8c4 2234    	str.w	r2, [r4, #0x234]
   61a7a: 4ab0         	ldr	r2, [pc, #0x2c0]        @ 0x61d3c <air1_opcal4_algorithm+0x654>
   61a7c: 4686         	mov	lr, r0
   61a7e: e9c4 6c8b    	strd	r6, r12, [r4, #556]
   61a82: 4eaf         	ldr	r6, [pc, #0x2bc]        @ 0x61d40 <air1_opcal4_algorithm+0x658>
   61a84: e9c4 c58e    	strd	r12, r5, [r4, #568]
   61a88: 4dae         	ldr	r5, [pc, #0x2b8]        @ 0x61d44 <air1_opcal4_algorithm+0x65c>
   61a8a: e9c4 5298    	strd	r5, r2, [r4, #608]
   61a8e: 48ae         	ldr	r0, [pc, #0x2b8]        @ 0x61d48 <air1_opcal4_algorithm+0x660>
   61a90: 4a99         	ldr	r2, [pc, #0x264]        @ 0x61cf8 <air1_opcal4_algorithm+0x610>
   61a92: e9c4 069a    	strd	r0, r6, [r4, #616]
   61a96: f240 600a    	movw	r0, #0x60a
   61a9a: 49ac         	ldr	r1, [pc, #0x2b0]        @ 0x61d4c <air1_opcal4_algorithm+0x664>
   61a9c: e9c4 1e96    	strd	r1, lr, [r4, #600]
   61aa0: 4696         	mov	lr, r2
   61aa2: f8a4 0210    	strh.w	r0, [r4, #0x210]
   61aa6: 67e3         	str	r3, [r4, #0x7c]
   61aa8: f884 3058    	strb.w	r3, [r4, #0x58]
   61aac: f8c4 311c    	str.w	r3, [r4, #0x11c]
   61ab0: f8c4 313c    	str.w	r3, [r4, #0x13c]
   61ab4: f8c4 3148    	str.w	r3, [r4, #0x148]
   61ab8: f8c4 c248    	str.w	r12, [r4, #0x248]
   61abc: f899 1002    	ldrb.w	r1, [r9, #0x2]
   61ac0: e9c4 23a7    	strd	r2, r3, [r4, #668]
   61ac4: 4a68         	ldr	r2, [pc, #0x1a0]        @ 0x61c68 <air1_opcal4_algorithm+0x580>
   61ac6: 4da2         	ldr	r5, [pc, #0x288]        @ 0x61d50 <air1_opcal4_algorithm+0x668>
   61ac8: 4ea2         	ldr	r6, [pc, #0x288]        @ 0x61d54 <air1_opcal4_algorithm+0x66c>
   61aca: e9c4 c2b2    	strd	r12, r2, [r4, #712]
   61ace: 4aa2         	ldr	r2, [pc, #0x288]        @ 0x61d58 <air1_opcal4_algorithm+0x670>
   61ad0: f8c4 6314    	str.w	r6, [r4, #0x314]
   61ad4: f8c4 32a4    	str.w	r3, [r4, #0x2a4]
   61ad8: 4690         	mov	r8, r2
   61ada: e9c4 32ba    	strd	r3, r2, [r4, #744]
   61ade: 4a9f         	ldr	r2, [pc, #0x27c]        @ 0x61d5c <air1_opcal4_algorithm+0x674>
   61ae0: e9c4 25c2    	strd	r2, r5, [r4, #776]
   61ae4: 2554         	movs	r5, #0x54
   61ae6: f8a4 5318    	strh.w	r5, [r4, #0x318]
   61aea: 2560         	movs	r5, #0x60
   61aec: f8a4 5306    	strh.w	r5, [r4, #0x306]
   61af0: 4d9b         	ldr	r5, [pc, #0x26c]        @ 0x61d60 <air1_opcal4_algorithm+0x678>
   61af2: f8c4 5302    	str.w	r5, [r4, #0x302]
   61af6: f44f 7558    	mov.w	r5, #0x360
   61afa: f8a4 5300    	strh.w	r5, [r4, #0x300]
   61afe: 2532         	movs	r5, #0x32
   61b00: f884 5270    	strb.w	r5, [r4, #0x270]
   61b04: f2af 3578    	adr.w	r5, #-888
   61b08: f965 0acf    	vld1.64	{d16, d17}, [r5]
   61b0c: f504 7522    	add.w	r5, r4, #0x288
   61b10: f945 0acd    	vst1.64	{d16, d17}, [r5]!
   61b14: f8c4 2310    	str.w	r2, [r4, #0x310]
   61b18: 2202         	movs	r2, #0x2
   61b1a: eef0 1b4f    	vmov.f64	d17, d15
   61b1e: 602b         	str	r3, [r5]
   61b20: f884 22b0    	strb.w	r2, [r4, #0x2b0]
   61b24: 2901         	cmp	r1, #0x1
   61b26: f44f 63b4    	mov.w	r3, #0x5a0
   61b2a: 4849         	ldr	r0, [pc, #0x124]        @ 0x61c50 <air1_opcal4_algorithm+0x568>
   61b2c: 4d8d         	ldr	r5, [pc, #0x234]        @ 0x61d64 <air1_opcal4_algorithm+0x67c>
   61b2e: ed5f 0be4    	vldr	d16, [pc, #-912]        @ 0x617a0 <air1_opcal4_algorithm+0xb8>
   61b32: bf08         	it	eq
   61b34: eef0 1b60    	vmoveq.f64	d17, d16
   61b38: edc4 1bbe    	vstr	d17, [r4, #760]
   61b3c: eef5 1b00    	vmov.f64	d17, #2.500000e-01
   61b40: 4e89         	ldr	r6, [pc, #0x224]        @ 0x61d68 <air1_opcal4_algorithm+0x680>
   61b42: ed5f 0be7    	vldr	d16, [pc, #-924]        @ 0x617a8 <air1_opcal4_algorithm+0xc0>
   61b46: eef0 2b61    	vmov.f64	d18, d17
   61b4a: bf08         	it	eq
   61b4c: eef0 2b60    	vmoveq.f64	d18, d16
   61b50: 2901         	cmp	r1, #0x1
   61b52: ed5f 0be9    	vldr	d16, [pc, #-932]        @ 0x617b0 <air1_opcal4_algorithm+0xc8>
   61b56: bf08         	it	eq
   61b58: eef0 3b60    	vmoveq.f64	d19, d16
   61b5c: edc4 2bb8    	vstr	d18, [r4, #736]
   61b60: edc4 3bb6    	vstr	d19, [r4, #728]
   61b64: bf08         	it	eq
   61b66: f44f 7358    	moveq.w	r3, #0x360
   61b6a: f8a4 32d2    	strh.w	r3, [r4, #0x2d2]
   61b6e: f44f 7334    	mov.w	r3, #0x2d0
   61b72: 2901         	cmp	r1, #0x1
   61b74: bf08         	it	eq
   61b76: f44f 736a    	moveq.w	r3, #0x3a8
   61b7a: ed5f 2bf1    	vldr	d18, [pc, #-964]        @ 0x617b8 <air1_opcal4_algorithm+0xd0>
   61b7e: f8a4 32d0    	strh.w	r3, [r4, #0x2d0]
   61b82: bf08         	it	eq
   61b84: eef0 2b4f    	vmoveq.f64	d18, d15
   61b88: f2af 33cc    	adr.w	r3, #-972
   61b8c: edc4 2baa    	vstr	d18, [r4, #680]
   61b90: 2901         	cmp	r1, #0x1
   61b92: bf08         	it	eq
   61b94: 3308         	addeq	r3, #0x8
   61b96: edd3 2b00    	vldr	d18, [r3]
   61b9a: f2af 33cc    	adr.w	r3, #-972
   61b9e: 2901         	cmp	r1, #0x1
   61ba0: edc4 2bbc    	vstr	d18, [r4, #752]
   61ba4: bf08         	it	eq
   61ba6: 3308         	addeq	r3, #0x8
   61ba8: edd3 2b00    	vldr	d18, [r3]
   61bac: f2af 33d0    	adr.w	r3, #-976
   61bb0: 2901         	cmp	r1, #0x1
   61bb2: bf08         	it	eq
   61bb4: 3308         	addeq	r3, #0x8
   61bb6: edd3 3b00    	vldr	d19, [r3]
   61bba: f2af 33cc    	adr.w	r3, #-972
   61bbe: edc4 2bb0    	vstr	d18, [r4, #704]
   61bc2: 2901         	cmp	r1, #0x1
   61bc4: edc4 3bae    	vstr	d19, [r4, #696]
   61bc8: bf08         	it	eq
   61bca: 3308         	addeq	r3, #0x8
   61bcc: edd3 2b00    	vldr	d18, [r3]
   61bd0: 2901         	cmp	r1, #0x1
   61bd2: f2af 33d4    	adr.w	r3, #-980
   61bd6: 4965         	ldr	r1, [pc, #0x194]        @ 0x61d6c <air1_opcal4_algorithm+0x684>
   61bd8: bf08         	it	eq
   61bda: 3308         	addeq	r3, #0x8
   61bdc: edd3 3b00    	vldr	d19, [r3]
   61be0: f8cd 9158    	str.w	r9, [sp, #0x158]
   61be4: 46c1         	mov	r9, r8
   61be6: e9c4 c1c8    	strd	r12, r1, [r4, #800]
   61bea: f04f 4980    	mov.w	r9, #0x40000000
   61bee: f8a4 2330    	strh.w	r2, [r4, #0x330]
   61bf2: edc4 3b9e    	vstr	d19, [r4, #632]
   61bf6: edc4 2ba0    	vstr	d18, [r4, #640]
   61bfa: bf12         	itee	ne
   61bfc: ed5f 2bfc    	vldrne	d18, [pc, #-1008]       @ 0x61810 <air1_opcal4_algorithm+0x128>
   61c00: ed5f 1bfb    	vldreq	d17, [pc, #-1004]       @ 0x61818 <air1_opcal4_algorithm+0x130>
   61c04: eef5 2b00    	vmoveq.f64	d18, #2.500000e-01
   61c08: e9c4 cad2    	strd	r12, r10, [r4, #840]
   61c0c: 46a2         	mov	r10, r4
   61c0e: 2300         	movs	r3, #0x0
   61c10: f8c4 0354    	str.w	r0, [r4, #0x354]
   61c14: e9ca 03e9    	strd	r0, r3, [r10, #932]
   61c18: 4855         	ldr	r0, [pc, #0x154]        @ 0x61d70 <air1_opcal4_algorithm+0x688>
   61c1a: e9ca 03f3    	strd	r0, r3, [r10, #972]
   61c1e: 4855         	ldr	r0, [pc, #0x154]        @ 0x61d74 <air1_opcal4_algorithm+0x68c>
   61c20: e9ca 03fb    	strd	r0, r3, [r10, #1004]
   61c24: 4854         	ldr	r0, [pc, #0x150]        @ 0x61d78 <air1_opcal4_algorithm+0x690>
   61c26: f8ca 0404    	str.w	r0, [r10, #0x404]
   61c2a: 4854         	ldr	r0, [pc, #0x150]        @ 0x61d7c <air1_opcal4_algorithm+0x694>
   61c2c: f8ca 0414    	str.w	r0, [r10, #0x414]
   61c30: 4853         	ldr	r0, [pc, #0x14c]        @ 0x61d80 <air1_opcal4_algorithm+0x698>
   61c32: f8ca 043c    	str.w	r0, [r10, #0x43c]
   61c36: 4853         	ldr	r0, [pc, #0x14c]        @ 0x61d84 <air1_opcal4_algorithm+0x69c>
   61c38: f8ca 0474    	str.w	r0, [r10, #0x474]
   61c3c: 4852         	ldr	r0, [pc, #0x148]        @ 0x61d88 <air1_opcal4_algorithm+0x6a0>
   61c3e: f8ca 0484    	str.w	r0, [r10, #0x484]
   61c42: 4846         	ldr	r0, [pc, #0x118]        @ 0x61d5c <air1_opcal4_algorithm+0x674>
   61c44: f000 b8a2    	b.w	0x61d8c <air1_opcal4_algorithm+0x6a4> @ imm = #0x144
   61c48: 3e 0e 03 00  	.word	0x00030e3e
   61c4c: 00 40 7f 40  	.word	0x407f4000
   61c50: 00 00 f0 3f  	.word	0x3ff00000
   61c54: 99 99 b9 3f  	.word	0x3fb99999
   61c58: 00 00 e0 3f  	.word	0x3fe00000
   61c5c: 00 00 44 40  	.word	0x40440000
   61c60: 66 66 e6 3f  	.word	0x3fe66666
   61c64: 9a 99 99 99  	.word	0x9999999a
   61c68: 99 99 c9 3f  	.word	0x3fc99999
   61c6c: cd cc cc cc  	.word	0xcccccccd
   61c70: a2 be 39 3e  	.word	0x3e39bea2
   61c74: 9f 1a cf 3f  	.word	0x3fcf1a9f
   61c78: 10 f6 cd c0  	.word	0xc0cdf610
   61c7c: b4 c8 76 be  	.word	0xbe76c8b4
   61c80: 00 08 91 40  	.word	0x40910800
   61c84: 36 c1 0b 3f  	.word	0x3f0bc136
   61c88: 24 a8 96 bd  	.word	0xbd96a824
   61c8c: 4d e0 8b a0  	.word	0xa08be04d
   61c90: cc cc ec 3f  	.word	0x3feccccc
   61c94: f2 44 ed 3f  	.word	0x3fed44f2
   61c98: 69 dc 5b 22  	.word	0x225bdc69
   61c9c: 3d 1b a8 42  	.word	0x42a81b3d
   61ca0: da 18 67 3f  	.word	0x3f6718da
   61ca4: dd 9b 4a ea  	.word	0xea4a9bdd
   61ca8: 80 26 c2 bf  	.word	0xbfc22680
   61cac: 00 00 14 40  	.word	0x40140000
   61cb0: 66 66 f2 bf  	.word	0xbff26666
   61cb4: 83 51 49 9d  	.word	0x9d495183
   61cb8: 08 07 2c 01  	.word	0x012c0708
   61cbc: cc cc 2c 40  	.word	0x402ccccc
   61cc0: 60 03 e0 07  	.word	0x07e00360
   61cc4: ce d1 ef 3f  	.word	0x3fefd1ce
   61cc8: ec d3 20 07  	.word	0x0720d3ec
   61ccc: c8 6a 2b 4a  	.word	0x4a2b6ac8
   61cd0: b2 68 e3 3f  	.word	0x3fe368b2
   61cd4: 9a 08 f6 3f  	.word	0x3ff6089a
   61cd8: 9a 2e d9 3f  	.word	0x3fd92e9a
   61cdc: 92 cb 7f 48  	.word	0x487fcb92
   61ce0: 06 5f d0 3f  	.word	0x3fd05f06
   61ce4: bf 7d f9 3f  	.word	0x3ff97dbf
   61ce8: 46 25 75 02  	.word	0x02752546
   61cec: 32 55 30 2a  	.word	0x2a305532
   61cf0: 00 00 69 40  	.word	0x40690000
   61cf4: a9 f3 33 40  	.word	0x4033f3a9
   61cf8: 00 00 24 40  	.word	0x40240000
   61cfc: 0e 2d 0c 40  	.word	0x400c2d0e
   61d00: ce 88 f5 3f  	.word	0x3ff588ce
   61d04: 74 46 94 f6  	.word	0xf6944674
   61d08: 93 18 04 56  	.word	0x56041893
   61d0c: 0e 2d fc 3f  	.word	0x3ffc2d0e
   61d10: 06 5f c0 3f  	.word	0x3fc05f06
   61d14: 7f fb 3a 70  	.word	0x703afb7f
   61d18: 0e 4f af 94  	.word	0x94af4f0e
   61d1c: 65 88 e5 3f  	.word	0x3fe58865
   61d20: 0a 96 6f fc  	.word	0xfc6f960a
   61d24: cc cc f4 3f  	.word	0x3ff4cccc
   61d28: 99 99 e9 3f  	.word	0x3fe99999
   61d2c: 09 1b 9e 5e  	.word	0x5e9e1b09
   61d30: 29 cb a0 3f  	.word	0x3fa0cb29
   61d34: 99 99 f1 3f  	.word	0x3ff19999
   61d38: 3f 35 be bf  	.word	0xbfbe353f
   61d3c: 58 39 ec 3f  	.word	0x3fec3958
   61d40: dd 24 f2 3f  	.word	0x3ff224dd
   61d44: d3 4d 62 10  	.word	0x10624dd3
   61d48: be 9f 1a 2f  	.word	0x2f1a9fbe
   61d4c: 68 91 ed 7c  	.word	0x7ced9168
   61d50: e1 7a 84 3f  	.word	0x3f847ae1
   61d54: e1 7a 84 bf  	.word	0xbf847ae1
   61d58: 00 80 61 40  	.word	0x40618000
   61d5c: 7b 14 ae 47  	.word	0x47ae147b
   61d60: ff 00 01 02  	.word	0x020100ff
   61d64: 8c ae a4 33  	.word	0x33a4ae8c
   61d68: 54 2c e8 3f  	.word	0x3fe82c54
   61d6c: 99 99 89 3f  	.word	0x3f899999
   61d70: 00 00 28 40  	.word	0x40280000
   61d74: 00 00 39 40  	.word	0x40390000
   61d78: 00 80 51 40  	.word	0x40518000
   61d7c: 00 00 54 40  	.word	0x40540000
   61d80: 99 99 a9 3f  	.word	0x3fa99999
   61d84: 4d 62 50 3f  	.word	0x3f50624d
   61d88: af 03 d2 3c  	.word	0x3cd203af
   61d8c: f8ca 0488    	str.w	r0, [r10, #0x488]
   61d90: 48fb         	ldr	r0, [pc, #0x3ec]        @ 0x62180 <air1_opcal4_algorithm+0xa98>
   61d92: f8ca 04b8    	str.w	r0, [r10, #0x4b8]
   61d96: 48fb         	ldr	r0, [pc, #0x3ec]        @ 0x62184 <air1_opcal4_algorithm+0xa9c>
   61d98: f8ca 047a    	str.w	r0, [r10, #0x47a]
   61d9c: 200c         	movs	r0, #0xc
   61d9e: f88a 0478    	strb.w	r0, [r10, #0x478]
   61da2: 48f9         	ldr	r0, [pc, #0x3e4]        @ 0x62188 <air1_opcal4_algorithm+0xaa0>
   61da4: f8ca 041c    	str.w	r0, [r10, #0x41c]
   61da8: 48f8         	ldr	r0, [pc, #0x3e0]        @ 0x6218c <air1_opcal4_algorithm+0xaa4>
   61daa: f8ca 0418    	str.w	r0, [r10, #0x418]
   61dae: f44f 7090    	mov.w	r0, #0x120
   61db2: f8aa 03d8    	strh.w	r0, [r10, #0x3d8]
   61db6: 2001         	movs	r0, #0x1
   61db8: 49f5         	ldr	r1, [pc, #0x3d4]        @ 0x62190 <air1_opcal4_algorithm+0xaa8>
   61dba: f88a 038c    	strb.w	r0, [r10, #0x38c]
   61dbe: 48f5         	ldr	r0, [pc, #0x3d4]        @ 0x62194 <air1_opcal4_algorithm+0xaac>
   61dc0: f8ca 0388    	str.w	r0, [r10, #0x388]
   61dc4: f44f 70d8    	mov.w	r0, #0x1b0
   61dc8: edca 2bce    	vstr	d18, [r10, #824]
   61dcc: efc0 2050    	vmov.i32	q9, #0x0
   61dd0: f8aa 0378    	strh.w	r0, [r10, #0x378]
   61dd4: 48f0         	ldr	r0, [pc, #0x3c0]        @ 0x62198 <air1_opcal4_algorithm+0xab0>
   61dd6: e9ca 51d8    	strd	r5, r1, [r10, #864]
   61dda: 49f0         	ldr	r1, [pc, #0x3c0]        @ 0x6219c <air1_opcal4_algorithm+0xab4>
   61ddc: f8ca 0358    	str.w	r0, [r10, #0x358]
   61de0: f50a 7064    	add.w	r0, r10, #0x390
   61de4: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   61de8: 6003         	str	r3, [r0]
   61dea: f2af 50cc    	adr.w	r0, #-1484
   61dee: e9ca 31e0    	strd	r3, r1, [r10, #896]
   61df2: e9ca 13fd    	strd	r1, r3, [r10, #1012]
   61df6: f8ca 140c    	str.w	r1, [r10, #0x40c]
   61dfa: 49e9         	ldr	r1, [pc, #0x3a4]        @ 0x621a0 <air1_opcal4_algorithm+0xab8>
   61dfc: f960 2acf    	vld1.64	{d18, d19}, [r0]
   61e00: f50a 608a    	add.w	r0, r10, #0x450
   61e04: f8ca 142c    	str.w	r1, [r10, #0x42c]
   61e08: f8ca 144c    	str.w	r1, [r10, #0x44c]
   61e0c: 49e5         	ldr	r1, [pc, #0x394]        @ 0x621a4 <air1_opcal4_algorithm+0xabc>
   61e0e: f8ca 146c    	str.w	r1, [r10, #0x46c]
   61e12: 49e5         	ldr	r1, [pc, #0x394]        @ 0x621a8 <air1_opcal4_algorithm+0xac0>
   61e14: f8c4 3350    	str.w	r3, [r4, #0x350]
   61e18: 4ae4         	ldr	r2, [pc, #0x390]        @ 0x621ac <air1_opcal4_algorithm+0xac4>
   61e1a: 4ce5         	ldr	r4, [pc, #0x394]        @ 0x621b0 <air1_opcal4_algorithm+0xac8>
   61e1c: f8ca 1494    	str.w	r1, [r10, #0x494]
   61e20: 49e4         	ldr	r1, [pc, #0x390]        @ 0x621b4 <air1_opcal4_algorithm+0xacc>
   61e22: f940 2a4d    	vst1.16	{d18, d19}, [r0]!
   61e26: e9ca 26da    	strd	r2, r6, [r10, #872]
   61e2a: 4ae3         	ldr	r2, [pc, #0x38c]        @ 0x621b8 <air1_opcal4_algorithm+0xad0>
   61e2c: f8ca 14a0    	str.w	r1, [r10, #0x4a0]
   61e30: 2106         	movs	r1, #0x6
   61e32: 8001         	strh	r1, [r0]
   61e34: 48e1         	ldr	r0, [pc, #0x384]        @ 0x621bc <air1_opcal4_algorithm+0xad4>
   61e36: e9ca 34dc    	strd	r3, r4, [r10, #880]
   61e3a: 4ce1         	ldr	r4, [pc, #0x384]        @ 0x621c0 <air1_opcal4_algorithm+0xad8>
   61e3c: f8ca 04dc    	str.w	r0, [r10, #0x4dc]
   61e40: 48e0         	ldr	r0, [pc, #0x380]        @ 0x621c4 <air1_opcal4_algorithm+0xadc>
   61e42: e9ca 42ef    	strd	r4, r2, [r10, #956]
   61e46: 4ce0         	ldr	r4, [pc, #0x380]        @ 0x621c8 <air1_opcal4_algorithm+0xae0>
   61e48: f8ca 04e4    	str.w	r0, [r10, #0x4e4]
   61e4c: 48df         	ldr	r0, [pc, #0x37c]        @ 0x621cc <air1_opcal4_algorithm+0xae4>
   61e4e: f8ca 0514    	str.w	r0, [r10, #0x514]
   61e52: 48df         	ldr	r0, [pc, #0x37c]        @ 0x621d0 <air1_opcal4_algorithm+0xae8>
   61e54: f8ca 051c    	str.w	r0, [r10, #0x51c]
   61e58: 48de         	ldr	r0, [pc, #0x378]        @ 0x621d4 <air1_opcal4_algorithm+0xaec>
   61e5a: e9ca 83f9    	strd	r8, r3, [r10, #996]
   61e5e: 46f0         	mov	r8, lr
   61e60: f8ca e3fc    	str.w	lr, [r10, #0x3fc]
   61e64: 46a6         	mov	lr, r4
   61e66: f8ca 054c    	str.w	r0, [r10, #0x54c]
   61e6a: f50a 60b4    	add.w	r0, r10, #0x5a0
   61e6e: f8ca 4444    	str.w	r4, [r10, #0x444]
   61e72: f8ca 449c    	str.w	r4, [r10, #0x49c]
   61e76: 4cd8         	ldr	r4, [pc, #0x360]        @ 0x621d8 <air1_opcal4_algorithm+0xaf0>
   61e78: f8ca 44ac    	str.w	r4, [r10, #0x4ac]
   61e7c: 4cc8         	ldr	r4, [pc, #0x320]        @ 0x621a0 <air1_opcal4_algorithm+0xab8>
   61e7e: e880 1018    	stm.w	r0, {r3, r4, r12}
   61e82: 48d6         	ldr	r0, [pc, #0x358]        @ 0x621dc <air1_opcal4_algorithm+0xaf4>
   61e84: f8ca 05b4    	str.w	r0, [r10, #0x5b4]
   61e88: f04f 3066    	mov.w	r0, #0x66666666
   61e8c: f8ca 05b0    	str.w	r0, [r10, #0x5b0]
   61e90: 48d3         	ldr	r0, [pc, #0x34c]        @ 0x621e0 <air1_opcal4_algorithm+0xaf8>
   61e92: f8ca 0580    	str.w	r0, [r10, #0x580]
   61e96: 48d3         	ldr	r0, [pc, #0x34c]        @ 0x621e4 <air1_opcal4_algorithm+0xafc>
   61e98: 4ed3         	ldr	r6, [pc, #0x34c]        @ 0x621e8 <air1_opcal4_algorithm+0xb00>
   61e9a: f8ca 0504    	str.w	r0, [r10, #0x504]
   61e9e: 48d3         	ldr	r0, [pc, #0x34c]        @ 0x621ec <air1_opcal4_algorithm+0xb04>
   61ea0: e9ca 63ed    	strd	r6, r3, [r10, #948]
   61ea4: 4ed2         	ldr	r6, [pc, #0x348]        @ 0x621f0 <air1_opcal4_algorithm+0xb08>
   61ea6: 49d3         	ldr	r1, [pc, #0x34c]        @ 0x621f4 <air1_opcal4_algorithm+0xb0c>
   61ea8: f8ca 0500    	str.w	r0, [r10, #0x500]
   61eac: f640 2002    	movw	r0, #0xa02
   61eb0: f8ca 648c    	str.w	r6, [r10, #0x48c]
   61eb4: 2605         	movs	r6, #0x5
   61eb6: f8aa 04f0    	strh.w	r0, [r10, #0x4f0]
   61eba: 48cf         	ldr	r0, [pc, #0x33c]        @ 0x621f8 <air1_opcal4_algorithm+0xb10>
   61ebc: f8aa 64c0    	strh.w	r6, [r10, #0x4c0]
   61ec0: 4ece         	ldr	r6, [pc, #0x338]        @ 0x621fc <air1_opcal4_algorithm+0xb14>
   61ec2: f8ca 04d4    	str.w	r0, [r10, #0x4d4]
   61ec6: 48ce         	ldr	r0, [pc, #0x338]        @ 0x62200 <air1_opcal4_algorithm+0xb18>
   61ec8: f8ca 64bc    	str.w	r6, [r10, #0x4bc]
   61ecc: 460e         	mov	r6, r1
   61ece: f8ca 152c    	str.w	r1, [r10, #0x52c]
   61ed2: 49cc         	ldr	r1, [pc, #0x330]        @ 0x62204 <air1_opcal4_algorithm+0xb1c>
   61ed4: f8ca 04d0    	str.w	r0, [r10, #0x4d0]
   61ed8: 48cb         	ldr	r0, [pc, #0x32c]        @ 0x62208 <air1_opcal4_algorithm+0xb20>
   61eda: f8ca 0420    	str.w	r0, [r10, #0x420]
   61ede: f2af 60b0    	adr.w	r0, #-1712
   61ee2: f960 2acf    	vld1.64	{d18, d19}, [r0]
   61ee6: f50a 60ad    	add.w	r0, r10, #0x568
   61eea: f8ca 84ec    	str.w	r8, [r10, #0x4ec]
   61eee: f8ca 850c    	str.w	r8, [r10, #0x50c]
   61ef2: 4688         	mov	r8, r1
   61ef4: f8ca 153c    	str.w	r1, [r10, #0x53c]
   61ef8: f50a 61a8    	add.w	r1, r10, #0x540
   61efc: e881 1208    	stm.w	r1, {r3, r9, r12}
   61f00: 49c2         	ldr	r1, [pc, #0x308]        @ 0x6220c <air1_opcal4_algorithm+0xb24>
   61f02: f940 2a4d    	vst1.16	{d18, d19}, [r0]!
   61f06: f8ca 157c    	str.w	r1, [r10, #0x57c]
   61f0a: 49c1         	ldr	r1, [pc, #0x304]        @ 0x62210 <air1_opcal4_algorithm+0xb28>
   61f0c: 6001         	str	r1, [r0]
   61f0e: 48c1         	ldr	r0, [pc, #0x304]        @ 0x62214 <air1_opcal4_algorithm+0xb2c>
   61f10: f8ca 05c4    	str.w	r0, [r10, #0x5c4]
   61f14: f04f 3033    	mov.w	r0, #0x33333333
   61f18: f8ca 05c0    	str.w	r0, [r10, #0x5c0]
   61f1c: 48be         	ldr	r0, [pc, #0x2f8]        @ 0x62218 <air1_opcal4_algorithm+0xb30>
   61f1e: f8ca 05cc    	str.w	r0, [r10, #0x5cc]
   61f22: 48be         	ldr	r0, [pc, #0x2f8]        @ 0x6221c <air1_opcal4_algorithm+0xb34>
   61f24: f8ca 05fc    	str.w	r0, [r10, #0x5fc]
   61f28: 48bd         	ldr	r0, [pc, #0x2f4]        @ 0x62220 <air1_opcal4_algorithm+0xb38>
   61f2a: f8ca 062c    	str.w	r0, [r10, #0x62c]
   61f2e: f8ca 063c    	str.w	r0, [r10, #0x63c]
   61f32: f8ca 068c    	str.w	r0, [r10, #0x68c]
   61f36: f8ca 0694    	str.w	r0, [r10, #0x694]
   61f3a: f8ca 069c    	str.w	r0, [r10, #0x69c]
   61f3e: f8ca 06a4    	str.w	r0, [r10, #0x6a4]
   61f42: f8ca 06ac    	str.w	r0, [r10, #0x6ac]
   61f46: f8ca 06dc    	str.w	r0, [r10, #0x6dc]
   61f4a: 4896         	ldr	r0, [pc, #0x258]        @ 0x621a4 <air1_opcal4_algorithm+0xabc>
   61f4c: f8ca 06e4    	str.w	r0, [r10, #0x6e4]
   61f50: 489b         	ldr	r0, [pc, #0x26c]        @ 0x621c0 <air1_opcal4_algorithm+0xad8>
   61f52: f8ca 06f4    	str.w	r0, [r10, #0x6f4]
   61f56: 48b3         	ldr	r0, [pc, #0x2cc]        @ 0x62224 <air1_opcal4_algorithm+0xb3c>
   61f58: f8ca 06fc    	str.w	r0, [r10, #0x6fc]
   61f5c: 48b2         	ldr	r0, [pc, #0x2c8]        @ 0x62228 <air1_opcal4_algorithm+0xb40>
   61f5e: 4db3         	ldr	r5, [pc, #0x2cc]        @ 0x6222c <air1_opcal4_algorithm+0xb44>
   61f60: 49b3         	ldr	r1, [pc, #0x2cc]        @ 0x62230 <air1_opcal4_algorithm+0xb48>
   61f62: e9ca 53f1    	strd	r5, r3, [r10, #964]
   61f66: 4db3         	ldr	r5, [pc, #0x2cc]        @ 0x62234 <air1_opcal4_algorithm+0xb4c>
   61f68: f8ca 5480    	str.w	r5, [r10, #0x480]
   61f6c: 4db2         	ldr	r5, [pc, #0x2c8]        @ 0x62238 <air1_opcal4_algorithm+0xb50>
   61f6e: f8ca 9434    	str.w	r9, [r10, #0x434]
   61f72: f8ca 94cc    	str.w	r9, [r10, #0x4cc]
   61f76: f8ca 94fc    	str.w	r9, [r10, #0x4fc]
   61f7a: f8ca 9524    	str.w	r9, [r10, #0x524]
   61f7e: f8ca 9534    	str.w	r9, [r10, #0x534]
   61f82: f8ca 1594    	str.w	r1, [r10, #0x594]
   61f86: f8ca 161c    	str.w	r1, [r10, #0x61c]
   61f8a: 49ac         	ldr	r1, [pc, #0x2b0]        @ 0x6223c <air1_opcal4_algorithm+0xb54>
   61f8c: f8ca 96bc    	str.w	r9, [r10, #0x6bc]
   61f90: f8ca 96c4    	str.w	r9, [r10, #0x6c4]
   61f94: f8ca 96cc    	str.w	r9, [r10, #0x6cc]
   61f98: f8ca 96ec    	str.w	r9, [r10, #0x6ec]
   61f9c: 4681         	mov	r9, r0
   61f9e: f8ca 071c    	str.w	r0, [r10, #0x71c]
   61fa2: 48a7         	ldr	r0, [pc, #0x29c]        @ 0x62240 <air1_opcal4_algorithm+0xb58>
   61fa4: f8ca 54a8    	str.w	r5, [r10, #0x4a8]
   61fa8: 4da6         	ldr	r5, [pc, #0x298]        @ 0x62244 <air1_opcal4_algorithm+0xb5c>
   61faa: f8ca 074c    	str.w	r0, [r10, #0x74c]
   61fae: 48a6         	ldr	r0, [pc, #0x298]        @ 0x62248 <air1_opcal4_algorithm+0xb60>
   61fb0: f8ca 5554    	str.w	r5, [r10, #0x554]
   61fb4: 4da5         	ldr	r5, [pc, #0x294]        @ 0x6224c <air1_opcal4_algorithm+0xb64>
   61fb6: f8ca 0748    	str.w	r0, [r10, #0x748]
   61fba: 48a5         	ldr	r0, [pc, #0x294]        @ 0x62250 <air1_opcal4_algorithm+0xb68>
   61fbc: f8ca 076c    	str.w	r0, [r10, #0x76c]
   61fc0: 48a4         	ldr	r0, [pc, #0x290]        @ 0x62254 <air1_opcal4_algorithm+0xb6c>
   61fc2: f8ca 555c    	str.w	r5, [r10, #0x55c]
   61fc6: f8ca 55ec    	str.w	r5, [r10, #0x5ec]
   61fca: 460d         	mov	r5, r1
   61fcc: f8ca 1634    	str.w	r1, [r10, #0x634]
   61fd0: f8ca 1644    	str.w	r1, [r10, #0x644]
   61fd4: 49a0         	ldr	r1, [pc, #0x280]        @ 0x62258 <air1_opcal4_algorithm+0xb70>
   61fd6: f8ca 165c    	str.w	r1, [r10, #0x65c]
   61fda: 499e         	ldr	r1, [pc, #0x278]        @ 0x62254 <air1_opcal4_algorithm+0xb6c>
   61fdc: f8ca 0774    	str.w	r0, [r10, #0x774]
   61fe0: f8ca 077c    	str.w	r0, [r10, #0x77c]
   61fe4: 489d         	ldr	r0, [pc, #0x274]        @ 0x6225c <air1_opcal4_algorithm+0xb74>
   61fe6: f8ca 45bc    	str.w	r4, [r10, #0x5bc]
   61fea: 4c9d         	ldr	r4, [pc, #0x274]        @ 0x62260 <air1_opcal4_algorithm+0xb78>
   61fec: f8ca 0780    	str.w	r0, [r10, #0x780]
   61ff0: 489c         	ldr	r0, [pc, #0x270]        @ 0x62264 <air1_opcal4_algorithm+0xb7c>
   61ff2: f8ca 1664    	str.w	r1, [r10, #0x664]
   61ff6: f8ca 166c    	str.w	r1, [r10, #0x66c]
   61ffa: 4998         	ldr	r1, [pc, #0x260]        @ 0x6225c <air1_opcal4_algorithm+0xb74>
   61ffc: f8ca 464c    	str.w	r4, [r10, #0x64c]
   62000: f8ca 1670    	str.w	r1, [r10, #0x670]
   62004: 4c97         	ldr	r4, [pc, #0x25c]        @ 0x62264 <air1_opcal4_algorithm+0xb7c>
   62006: 4998         	ldr	r1, [pc, #0x260]        @ 0x62268 <air1_opcal4_algorithm+0xb80>
   62008: f8ca 0784    	str.w	r0, [r10, #0x784]
   6200c: f50a 60f3    	add.w	r0, r10, #0x798
   62010: f8ca 4674    	str.w	r4, [r10, #0x674]
   62014: 4c95         	ldr	r4, [pc, #0x254]        @ 0x6226c <air1_opcal4_algorithm+0xb84>
   62016: e880 1018    	stm.w	r0, {r3, r4, r12}
   6201a: 4889         	ldr	r0, [pc, #0x224]        @ 0x62240 <air1_opcal4_algorithm+0xb58>
   6201c: f8ca e59c    	str.w	lr, [r10, #0x59c]
   62020: 46c6         	mov	lr, r8
   62022: f8ca 867c    	str.w	r8, [r10, #0x67c]
   62026: 4688         	mov	r8, r1
   62028: f8ca 87ac    	str.w	r8, [r10, #0x7ac]
   6202c: 4680         	mov	r8, r0
   6202e: f8ca 07cc    	str.w	r0, [r10, #0x7cc]
   62032: f50a 60fb    	add.w	r0, r10, #0x7d8
   62036: e880 1018    	stm.w	r0, {r3, r4, r12}
   6203a: 488d         	ldr	r0, [pc, #0x234]        @ 0x62270 <air1_opcal4_algorithm+0xb88>
   6203c: f8ca 080c    	str.w	r0, [r10, #0x80c]
   62040: f8ca 0814    	str.w	r0, [r10, #0x814]
   62044: 200c         	movs	r0, #0xc
   62046: f8aa 0754    	strh.w	r0, [r10, #0x754]
   6204a: 488a         	ldr	r0, [pc, #0x228]        @ 0x62274 <air1_opcal4_algorithm+0xb8c>
   6204c: f8ca 0750    	str.w	r0, [r10, #0x750]
   62050: 4889         	ldr	r0, [pc, #0x224]        @ 0x62278 <air1_opcal4_algorithm+0xb90>
   62052: f8ca 0700    	str.w	r0, [r10, #0x700]
   62056: 2018         	movs	r0, #0x18
   62058: f8aa 0626    	strh.w	r0, [r10, #0x626]
   6205c: 4887         	ldr	r0, [pc, #0x21c]        @ 0x6227c <air1_opcal4_algorithm+0xb94>
   6205e: f8ca 0622    	str.w	r0, [r10, #0x622]
   62062: 2003         	movs	r0, #0x3
   62064: f88a 0620    	strb.w	r0, [r10, #0x620]
   62068: f44f 70c0    	mov.w	r0, #0x180
   6206c: f8aa 060c    	strh.w	r0, [r10, #0x60c]
   62070: 4883         	ldr	r0, [pc, #0x20c]        @ 0x62280 <air1_opcal4_algorithm+0xb98>
   62072: f8ca 0608    	str.w	r0, [r10, #0x608]
   62076: 2001         	movs	r0, #0x1
   62078: f8aa 05f0    	strh.w	r0, [r10, #0x5f0]
   6207c: 2006         	movs	r0, #0x6
   6207e: f8aa 05e0    	strh.w	r0, [r10, #0x5e0]
   62082: 2002         	movs	r0, #0x2
   62084: f88a 05d0    	strb.w	r0, [r10, #0x5d0]
   62088: 487e         	ldr	r0, [pc, #0x1f8]        @ 0x62284 <air1_opcal4_algorithm+0xb9c>
   6208a: f8ca 0824    	str.w	r0, [r10, #0x824]
   6208e: 487e         	ldr	r0, [pc, #0x1f8]        @ 0x62288 <air1_opcal4_algorithm+0xba0>
   62090: f8ca 0844    	str.w	r0, [r10, #0x844]
   62094: 484d         	ldr	r0, [pc, #0x134]        @ 0x621cc <air1_opcal4_algorithm+0xae4>
   62096: f8ca 084c    	str.w	r0, [r10, #0x84c]
   6209a: 486a         	ldr	r0, [pc, #0x1a8]        @ 0x62244 <air1_opcal4_algorithm+0xb5c>
   6209c: f8ca 0854    	str.w	r0, [r10, #0x854]
   620a0: f8ca 085c    	str.w	r0, [r10, #0x85c]
   620a4: f8ca 0864    	str.w	r0, [r10, #0x864]
   620a8: 4861         	ldr	r0, [pc, #0x184]        @ 0x62230 <air1_opcal4_algorithm+0xb48>
   620aa: f8ca 086c    	str.w	r0, [r10, #0x86c]
   620ae: 4863         	ldr	r0, [pc, #0x18c]        @ 0x6223c <air1_opcal4_algorithm+0xb54>
   620b0: f8ca 0884    	str.w	r0, [r10, #0x884]
   620b4: f8ca 088c    	str.w	r0, [r10, #0x88c]
   620b8: f8ca 0894    	str.w	r0, [r10, #0x894]
   620bc: f8ca 089c    	str.w	r0, [r10, #0x89c]
   620c0: 4867         	ldr	r0, [pc, #0x19c]        @ 0x62260 <air1_opcal4_algorithm+0xb78>
   620c2: f8ca 08a4    	str.w	r0, [r10, #0x8a4]
   620c6: 4871         	ldr	r0, [pc, #0x1c4]        @ 0x6228c <air1_opcal4_algorithm+0xba4>
   620c8: f8ca 08ac    	str.w	r0, [r10, #0x8ac]
   620cc: 4862         	ldr	r0, [pc, #0x188]        @ 0x62258 <air1_opcal4_algorithm+0xb70>
   620ce: f8ca 1684    	str.w	r1, [r10, #0x684]
   620d2: 495c         	ldr	r1, [pc, #0x170]        @ 0x62244 <air1_opcal4_algorithm+0xb5c>
   620d4: f8ca 08b4    	str.w	r0, [r10, #0x8b4]
   620d8: 4862         	ldr	r0, [pc, #0x188]        @ 0x62264 <air1_opcal4_algorithm+0xb7c>
   620da: f8ca 16b4    	str.w	r1, [r10, #0x6b4]
   620de: f50a 61e2    	add.w	r1, r10, #0x710
   620e2: f8ca 08cc    	str.w	r0, [r10, #0x8cc]
   620e6: 4847         	ldr	r0, [pc, #0x11c]        @ 0x62204 <air1_opcal4_algorithm+0xb1c>
   620e8: e881 1018    	stm.w	r1, {r3, r4, r12}
   620ec: 4968         	ldr	r1, [pc, #0x1a0]        @ 0x62290 <air1_opcal4_algorithm+0xba8>
   620ee: f8ca 08d4    	str.w	r0, [r10, #0x8d4]
   620f2: 485d         	ldr	r0, [pc, #0x174]        @ 0x62268 <air1_opcal4_algorithm+0xb80>
   620f4: f8ca 08dc    	str.w	r0, [r10, #0x8dc]
   620f8: 4866         	ldr	r0, [pc, #0x198]        @ 0x62294 <air1_opcal4_algorithm+0xbac>
   620fa: e9ca 32eb    	strd	r3, r2, [r10, #940]
   620fe: 4a66         	ldr	r2, [pc, #0x198]        @ 0x62298 <air1_opcal4_algorithm+0xbb0>
   62100: f8ca 08e4    	str.w	r0, [r10, #0x8e4]
   62104: f8ca 08ec    	str.w	r0, [r10, #0x8ec]
   62108: 2001         	movs	r0, #0x1
   6210a: f8ca 23d4    	str.w	r2, [r10, #0x3d4]
   6210e: 4a63         	ldr	r2, [pc, #0x18c]        @ 0x6229c <air1_opcal4_algorithm+0xbb4>
   62110: f8ca e78c    	str.w	lr, [r10, #0x78c]
   62114: 468e         	mov	lr, r1
   62116: f88a 0908    	strb.w	r0, [r10, #0x908]
   6211a: 4861         	ldr	r0, [pc, #0x184]        @ 0x622a0 <air1_opcal4_algorithm+0xbb8>
   6211c: f8ca 1744    	str.w	r1, [r10, #0x744]
   62120: f8ca 17c4    	str.w	r1, [r10, #0x7c4]
   62124: f8ca 17ec    	str.w	r1, [r10, #0x7ec]
   62128: 494c         	ldr	r1, [pc, #0x130]        @ 0x6225c <air1_opcal4_algorithm+0xb74>
   6212a: f8ca 0904    	str.w	r0, [r10, #0x904]
   6212e: 4852         	ldr	r0, [pc, #0x148]        @ 0x62278 <air1_opcal4_algorithm+0xb90>
   62130: f8ca 2470    	str.w	r2, [r10, #0x470]
   62134: f8ca 2490    	str.w	r2, [r10, #0x490]
   62138: 4a5a         	ldr	r2, [pc, #0x168]        @ 0x622a4 <air1_opcal4_algorithm+0xbbc>
   6213a: f8ca 1840    	str.w	r1, [r10, #0x840]
   6213e: f8ca 18c8    	str.w	r1, [r10, #0x8c8]
   62142: 4959         	ldr	r1, [pc, #0x164]        @ 0x622a8 <air1_opcal4_algorithm+0xbc0>
   62144: f8ca 24a4    	str.w	r2, [r10, #0x4a4]
   62148: 4a58         	ldr	r2, [pc, #0x160]        @ 0x622ac <air1_opcal4_algorithm+0xbc4>
   6214a: f8ca 0818    	str.w	r0, [r10, #0x818]
   6214e: 4858         	ldr	r0, [pc, #0x160]        @ 0x622b0 <air1_opcal4_algorithm+0xbc8>
   62150: f8ca 18f4    	str.w	r1, [r10, #0x8f4]
   62154: f8ca 18fc    	str.w	r1, [r10, #0x8fc]
   62158: 4956         	ldr	r1, [pc, #0x158]        @ 0x622b4 <air1_opcal4_algorithm+0xbcc>
   6215a: f8ca 56d4    	str.w	r5, [r10, #0x6d4]
   6215e: 4d56         	ldr	r5, [pc, #0x158]        @ 0x622b8 <air1_opcal4_algorithm+0xbd0>
   62160: f8ca 1900    	str.w	r1, [r10, #0x900]
   62164: 4955         	ldr	r1, [pc, #0x154]        @ 0x622bc <air1_opcal4_algorithm+0xbd4>
   62166: f8ca 091c    	str.w	r0, [r10, #0x91c]
   6216a: 4822         	ldr	r0, [pc, #0x88]         @ 0x621f4 <air1_opcal4_algorithm+0xb0c>
   6216c: f8ca 24b4    	str.w	r2, [r10, #0x4b4]
   62170: f8ca 25ac    	str.w	r2, [r10, #0x5ac]
   62174: f8ca 258c    	str.w	r2, [r10, #0x58c]
   62178: f8ca 2614    	str.w	r2, [r10, #0x614]
   6217c: f000 b8a2    	b.w	0x622c4 <air1_opcal4_algorithm+0xbdc> @ imm = #0x144
   62180: 65 03 24 00  	.word	0x00240365
   62184: 20 01 0a 0a  	.word	0x0a0a0120
   62188: 2f 00 0b 00  	.word	0x000b002f
   6218c: 60 03 17 00  	.word	0x00170360
   62190: dd 5e 3c 3f  	.word	0x3f3c5edd
   62194: 20 01 90 00  	.word	0x00900120
   62198: 02 00 01 02  	.word	0x02010002
   6219c: 00 80 66 40  	.word	0x40668000
   621a0: 00 00 e0 3f  	.word	0x3fe00000
   621a4: 00 00 08 40  	.word	0x40080000
   621a8: 4d 62 60 3f  	.word	0x3f60624d
   621ac: 56 b1 a0 39  	.word	0x39a0b156
   621b0: 00 00 3e 40  	.word	0x403e0000
   621b4: ae 47 e1 7a  	.word	0x7ae147ae
   621b8: c3 f5 28 5c  	.word	0x5c28f5c3
   621bc: 00 00 89 40  	.word	0x40890000
   621c0: 00 00 34 40  	.word	0x40340000
   621c4: 00 e0 95 40  	.word	0x4095e000
   621c8: 99 99 b9 3f  	.word	0x3fb99999
   621cc: 00 00 4e 40  	.word	0x404e0000
   621d0: 00 00 2c 40  	.word	0x402c0000
   621d4: 99 99 f9 3f  	.word	0x3ff99999
   621d8: 1e 05 34 40  	.word	0x4034051e
   621dc: 66 66 e6 3f  	.word	0x3fe66666
   621e0: 24 00 20 01  	.word	0x01200024
   621e4: 0c 00 3f 02  	.word	0x023f000c
   621e8: 8f c2 c5 3f  	.word	0x3fc5c28f
   621ec: 01 00 05 00  	.word	0x00050001
   621f0: e1 7a 94 3f  	.word	0x3f947ae1
   621f4: 00 00 22 40  	.word	0x40220000
   621f8: 0b 00 05 00  	.word	0x0005000b
   621fc: 03 00 04 00  	.word	0x00040003
   62200: 21 01 14 00  	.word	0x00140121
   62204: 00 00 14 40  	.word	0x40140000
   62208: 03 00 0b 00  	.word	0x000b0003
   6220c: 18 00 0b 00  	.word	0x000b0018
   62210: 0c 00 20 01  	.word	0x0120000c
   62214: 33 33 d3 3f  	.word	0x3fd33333
   62218: 00 00 f0 bf  	.word	0xbff00000
   6221c: 00 00 f8 3f  	.word	0x3ff80000
   62220: 00 00 3e c0  	.word	0xc03e0000
   62224: 00 80 51 40  	.word	0x40518000
   62228: 99 99 85 40  	.word	0x40859999
   6222c: 8f c2 f1 3f  	.word	0x3ff1c28f
   62230: 00 00 f0 3f  	.word	0x3ff00000
   62234: 16 56 e7 9e  	.word	0x9ee75616
   62238: 85 eb 51 b8  	.word	0xb851eb85
   6223c: 00 00 34 c0  	.word	0xc0340000
   62240: 33 33 33 40  	.word	0x40333333
   62244: 00 00 49 40  	.word	0x40490000
   62248: 34 33 33 33  	.word	0x33333334
   6224c: 99 99 f1 3f  	.word	0x3ff19999
   62250: 00 00 18 40  	.word	0x40180000
   62254: 99 99 e9 3f  	.word	0x3fe99999
   62258: 00 00 10 40  	.word	0x40100000
   6225c: cd cc cc cc  	.word	0xcccccccd
   62260: 00 00 f8 7f  	.word	0x7ff80000
   62264: cc cc ec 3f  	.word	0x3feccccc
   62268: 00 00 24 40  	.word	0x40240000
   6226c: 00 00 8b 40  	.word	0x408b0000
   62270: 00 80 51 c0  	.word	0xc0518000
   62274: 03 00 0c 00  	.word	0x000c0003
   62278: 0c 00 18 00  	.word	0x0018000c
   6227c: 05 00 1e 00  	.word	0x001e0005
   62280: 05 00 40 02  	.word	0x02400005
   62284: 00 00 14 c0  	.word	0xc0140000
   62288: cc cc 6c 40  	.word	0x406ccccc
   6228c: 00 00 1c c0  	.word	0xc01c0000
   62290: 00 00 38 40  	.word	0x40380000
   62294: 00 00 39 c0  	.word	0xc0390000
   62298: 00 c0 72 40  	.word	0x4072c000
   6229c: fc a9 f1 d2  	.word	0xd2f1a9fc
   622a0: 58 02 04 02  	.word	0x02040258
   622a4: 14 ae ef 3f  	.word	0x3fefae14
   622a8: 00 80 41 c0  	.word	0xc0418000
   622ac: 99 99 c9 3f  	.word	0x3fc99999
   622b0: 00 00 5e 40  	.word	0x405e0000
   622b4: 17 00 3c 00  	.word	0x003c0017
   622b8: 00 00 44 c0  	.word	0xc0440000
   622bc: 00 00 54 40  	.word	0x40540000
   622c0: c6 1a 01 00  	.word	0x00011ac6
   622c4: 4af3         	ldr	r2, [pc, #0x3cc]        @ 0x62694 <air1_opcal4_algorithm+0xfac>
   622c6: f8ca 6604    	str.w	r6, [r10, #0x604]
   622ca: f8ca 2654    	str.w	r2, [r10, #0x654]
   622ce: 4af2         	ldr	r2, [pc, #0x3c8]        @ 0x62698 <air1_opcal4_algorithm+0xfb0>
   622d0: 4ef2         	ldr	r6, [pc, #0x3c8]        @ 0x6269c <air1_opcal4_algorithm+0xfb4>
   622d2: f8ca e874    	str.w	lr, [r10, #0x874]
   622d6: f8ca 1914    	str.w	r1, [r10, #0x914]
   622da: 49f1         	ldr	r1, [pc, #0x3c4]        @ 0x626a0 <air1_opcal4_algorithm+0xfb8>
   622dc: f8ca 092c    	str.w	r0, [r10, #0x92c]
   622e0: 48f0         	ldr	r0, [pc, #0x3c0]        @ 0x626a4 <air1_opcal4_algorithm+0xfbc>
   622e2: f8ca 572c    	str.w	r5, [r10, #0x72c]
   622e6: f8ca 573c    	str.w	r5, [r10, #0x73c]
   622ea: 4def         	ldr	r5, [pc, #0x3bc]        @ 0x626a8 <air1_opcal4_algorithm+0xfc0>
   622ec: f8dd e158    	ldr.w	lr, [sp, #0x158]
   622f0: f8ca 575c    	str.w	r5, [r10, #0x75c]
   622f4: 4ded         	ldr	r5, [pc, #0x3b4]        @ 0x626ac <air1_opcal4_algorithm+0xfc4>
   622f6: f8ca 6764    	str.w	r6, [r10, #0x764]
   622fa: 4eed         	ldr	r6, [pc, #0x3b4]        @ 0x626b0 <air1_opcal4_algorithm+0xfc8>
   622fc: f8ca 0934    	str.w	r0, [r10, #0x934]
   62300: 200c         	movs	r0, #0xc
   62302: f8ca 2724    	str.w	r2, [r10, #0x724]
   62306: f8ca 2734    	str.w	r2, [r10, #0x734]
   6230a: f8ca 27b4    	str.w	r2, [r10, #0x7b4]
   6230e: f8ca 27bc    	str.w	r2, [r10, #0x7bc]
   62312: f8ca 27fc    	str.w	r2, [r10, #0x7fc]
   62316: f8ca 2804    	str.w	r2, [r10, #0x804]
   6231a: 4ae6         	ldr	r2, [pc, #0x398]        @ 0x626b4 <air1_opcal4_algorithm+0xfcc>
   6231c: f8ca 194c    	str.w	r1, [r10, #0x94c]
   62320: f8ca 1954    	str.w	r1, [r10, #0x954]
   62324: 49e4         	ldr	r1, [pc, #0x390]        @ 0x626b8 <air1_opcal4_algorithm+0xfd0>
   62326: f8ca 33e0    	str.w	r3, [r10, #0x3e0]
   6232a: f8ca 3400    	str.w	r3, [r10, #0x400]
   6232e: f8ca 3408    	str.w	r3, [r10, #0x408]
   62332: f8ca 3410    	str.w	r3, [r10, #0x410]
   62336: f8ca 3428    	str.w	r3, [r10, #0x428]
   6233a: f8ca 3430    	str.w	r3, [r10, #0x430]
   6233e: f8ca c438    	str.w	r12, [r10, #0x438]
   62342: f8ca c440    	str.w	r12, [r10, #0x440]
   62346: f8ca 3448    	str.w	r3, [r10, #0x448]
   6234a: f8ca 3468    	str.w	r3, [r10, #0x468]
   6234e: f8ca c498    	str.w	r12, [r10, #0x498]
   62352: f8ca c4b0    	str.w	r12, [r10, #0x4b0]
   62356: edca 1bd0    	vstr	d17, [r10, #832]
   6235a: f8ca 34c8    	str.w	r3, [r10, #0x4c8]
   6235e: f8ca 34d8    	str.w	r3, [r10, #0x4d8]
   62362: f8ca 34e0    	str.w	r3, [r10, #0x4e0]
   62366: f8ca 34e8    	str.w	r3, [r10, #0x4e8]
   6236a: f8ca 34f8    	str.w	r3, [r10, #0x4f8]
   6236e: f8ca 3508    	str.w	r3, [r10, #0x508]
   62372: f8ca 3510    	str.w	r3, [r10, #0x510]
   62376: f8ca 3518    	str.w	r3, [r10, #0x518]
   6237a: f8ca 3520    	str.w	r3, [r10, #0x520]
   6237e: f8ca 3528    	str.w	r3, [r10, #0x528]
   62382: f8ca 3530    	str.w	r3, [r10, #0x530]
   62386: f8ca 3538    	str.w	r3, [r10, #0x538]
   6238a: f8ca 3550    	str.w	r3, [r10, #0x550]
   6238e: f8ca c558    	str.w	r12, [r10, #0x558]
   62392: f8ca 3560    	str.w	r3, [r10, #0x560]
   62396: f8ca 3564    	str.w	r3, [r10, #0x564]
   6239a: f8ca c598    	str.w	r12, [r10, #0x598]
   6239e: f8ca c588    	str.w	r12, [r10, #0x588]
   623a2: f8ca 3590    	str.w	r3, [r10, #0x590]
   623a6: f8ca 35b8    	str.w	r3, [r10, #0x5b8]
   623aa: f8ca 35c8    	str.w	r3, [r10, #0x5c8]
   623ae: f8ca 35d8    	str.w	r3, [r10, #0x5d8]
   623b2: f8ca 35dc    	str.w	r3, [r10, #0x5dc]
   623b6: f8ca c5e8    	str.w	r12, [r10, #0x5e8]
   623ba: f8ca 35f8    	str.w	r3, [r10, #0x5f8]
   623be: f8ca 3600    	str.w	r3, [r10, #0x600]
   623c2: f8ca c610    	str.w	r12, [r10, #0x610]
   623c6: f8ca 3618    	str.w	r3, [r10, #0x618]
   623ca: f8ca 3628    	str.w	r3, [r10, #0x628]
   623ce: f8ca 3630    	str.w	r3, [r10, #0x630]
   623d2: f8ca 3638    	str.w	r3, [r10, #0x638]
   623d6: f8ca 3640    	str.w	r3, [r10, #0x640]
   623da: f8ca 3648    	str.w	r3, [r10, #0x648]
   623de: f8ca 3650    	str.w	r3, [r10, #0x650]
   623e2: f8ca 3658    	str.w	r3, [r10, #0x658]
   623e6: f8ca c660    	str.w	r12, [r10, #0x660]
   623ea: f8ca c668    	str.w	r12, [r10, #0x668]
   623ee: f8ca 3678    	str.w	r3, [r10, #0x678]
   623f2: f8ca 3680    	str.w	r3, [r10, #0x680]
   623f6: f8ca 3688    	str.w	r3, [r10, #0x688]
   623fa: f8ca 3690    	str.w	r3, [r10, #0x690]
   623fe: f8ca 3698    	str.w	r3, [r10, #0x698]
   62402: f8ca 36a0    	str.w	r3, [r10, #0x6a0]
   62406: f8ca 36a8    	str.w	r3, [r10, #0x6a8]
   6240a: f8ca 36b0    	str.w	r3, [r10, #0x6b0]
   6240e: f8ca 36b8    	str.w	r3, [r10, #0x6b8]
   62412: f8ca 36c0    	str.w	r3, [r10, #0x6c0]
   62416: f8ca 36c8    	str.w	r3, [r10, #0x6c8]
   6241a: f8ca 36d0    	str.w	r3, [r10, #0x6d0]
   6241e: f8ca 36d8    	str.w	r3, [r10, #0x6d8]
   62422: f8ca 36e0    	str.w	r3, [r10, #0x6e0]
   62426: f8ca 36e8    	str.w	r3, [r10, #0x6e8]
   6242a: f8ca 36f0    	str.w	r3, [r10, #0x6f0]
   6242e: f8ca 36f8    	str.w	r3, [r10, #0x6f8]
   62432: f8ca 3708    	str.w	r3, [r10, #0x708]
   62436: f8ca 470c    	str.w	r4, [r10, #0x70c]
   6243a: f8ca 3720    	str.w	r3, [r10, #0x720]
   6243e: f8ca 3728    	str.w	r3, [r10, #0x728]
   62442: f8ca 3730    	str.w	r3, [r10, #0x730]
   62446: f8ca 3738    	str.w	r3, [r10, #0x738]
   6244a: f8ca 3740    	str.w	r3, [r10, #0x740]
   6244e: f8ca 3758    	str.w	r3, [r10, #0x758]
   62452: f8ca 3760    	str.w	r3, [r10, #0x760]
   62456: f8ca 3768    	str.w	r3, [r10, #0x768]
   6245a: f8ca c770    	str.w	r12, [r10, #0x770]
   6245e: f8ca c778    	str.w	r12, [r10, #0x778]
   62462: f8ca 3788    	str.w	r3, [r10, #0x788]
   62466: f8ca 3790    	str.w	r3, [r10, #0x790]
   6246a: f8ca 4794    	str.w	r4, [r10, #0x794]
   6246e: f8ca 97a4    	str.w	r9, [r10, #0x7a4]
   62472: f8ca 37a8    	str.w	r3, [r10, #0x7a8]
   62476: f8ca 37b0    	str.w	r3, [r10, #0x7b0]
   6247a: f8ca 37b8    	str.w	r3, [r10, #0x7b8]
   6247e: f8ca 37c0    	str.w	r3, [r10, #0x7c0]
   62482: f8ca 67c8    	str.w	r6, [r10, #0x7c8]
   62486: f8ca 37d0    	str.w	r3, [r10, #0x7d0]
   6248a: f8ca 47d4    	str.w	r4, [r10, #0x7d4]
   6248e: f8ca 97e4    	str.w	r9, [r10, #0x7e4]
   62492: f8ca 37f8    	str.w	r3, [r10, #0x7f8]
   62496: f8ca 3800    	str.w	r3, [r10, #0x800]
   6249a: f8ca 3808    	str.w	r3, [r10, #0x808]
   6249e: f8ca 3810    	str.w	r3, [r10, #0x810]
   624a2: f8ca 37e8    	str.w	r3, [r10, #0x7e8]
   624a6: f8ca 87f4    	str.w	r8, [r10, #0x7f4]
   624aa: f8ca 67f0    	str.w	r6, [r10, #0x7f0]
   624ae: f8ca 6878    	str.w	r6, [r10, #0x878]
   624b2: f8ca 3820    	str.w	r3, [r10, #0x820]
   624b6: f8ca c828    	str.w	r12, [r10, #0x828]
   624ba: f8ca 582c    	str.w	r5, [r10, #0x82c]
   624be: f8ca 3830    	str.w	r3, [r10, #0x830]
   624c2: f8ca 4834    	str.w	r4, [r10, #0x834]
   624c6: f8ca 3838    	str.w	r3, [r10, #0x838]
   624ca: f8ca 283c    	str.w	r2, [r10, #0x83c]
   624ce: f8ca 3848    	str.w	r3, [r10, #0x848]
   624d2: f8ca 3850    	str.w	r3, [r10, #0x850]
   624d6: f8ca 3858    	str.w	r3, [r10, #0x858]
   624da: f8ca 3860    	str.w	r3, [r10, #0x860]
   624de: f8ca 3868    	str.w	r3, [r10, #0x868]
   624e2: f8ca 3870    	str.w	r3, [r10, #0x870]
   624e6: f8ca 887c    	str.w	r8, [r10, #0x87c]
   624ea: f8ca 3880    	str.w	r3, [r10, #0x880]
   624ee: f8ca 3888    	str.w	r3, [r10, #0x888]
   624f2: f8ca 3890    	str.w	r3, [r10, #0x890]
   624f6: f8ca 3898    	str.w	r3, [r10, #0x898]
   624fa: f8ca 38a0    	str.w	r3, [r10, #0x8a0]
   624fe: f8ca 38a8    	str.w	r3, [r10, #0x8a8]
   62502: f8ca 38b0    	str.w	r3, [r10, #0x8b0]
   62506: f8ca c8b8    	str.w	r12, [r10, #0x8b8]
   6250a: f8ca 58bc    	str.w	r5, [r10, #0x8bc]
   6250e: f8ca c8c0    	str.w	r12, [r10, #0x8c0]
   62512: f8ca 58c4    	str.w	r5, [r10, #0x8c4]
   62516: f8ca 38d0    	str.w	r3, [r10, #0x8d0]
   6251a: f8ca 38d8    	str.w	r3, [r10, #0x8d8]
   6251e: f8ca 38e0    	str.w	r3, [r10, #0x8e0]
   62522: f8ca 38e8    	str.w	r3, [r10, #0x8e8]
   62526: f8ca 38f0    	str.w	r3, [r10, #0x8f0]
   6252a: f8ca 38f8    	str.w	r3, [r10, #0x8f8]
   6252e: f8ca 3910    	str.w	r3, [r10, #0x910]
   62532: f8ca 3918    	str.w	r3, [r10, #0x918]
   62536: f8ca c920    	str.w	r12, [r10, #0x920]
   6253a: f8ca 5924    	str.w	r5, [r10, #0x924]
   6253e: f8ca 3928    	str.w	r3, [r10, #0x928]
   62542: f8ca 3940    	str.w	r3, [r10, #0x940]
   62546: f8ca 3944    	str.w	r3, [r10, #0x944]
   6254a: f8ca 3948    	str.w	r3, [r10, #0x948]
   6254e: f8ca 3950    	str.w	r3, [r10, #0x950]
   62552: f8ca 3930    	str.w	r3, [r10, #0x930]
   62556: f8ca 1938    	str.w	r1, [r10, #0x938]
   6255a: f8aa 090a    	strh.w	r0, [r10, #0x90a]
   6255e: f8cd a170    	str.w	r10, [sp, #0x170]
   62562: f8be 9008    	ldrh.w	r9, [lr, #0x8]
   62566: 9e5f         	ldr	r6, [sp, #0x17c]
   62568: f8dd a134    	ldr.w	r10, [sp, #0x134]
   6256c: f1b9 0f01    	cmp.w	r9, #0x1
   62570: d81e         	bhi	0x625b0 <air1_opcal4_algorithm+0xec8> @ imm = #0x3c
   62572: 995c         	ldr	r1, [sp, #0x170]
   62574: 8830         	ldrh	r0, [r6]
   62576: f8d6 2002    	ldr.w	r2, [r6, #0x2]
   6257a: 8bc9         	ldrh	r1, [r1, #0x1e]
   6257c: 4d4f         	ldr	r5, [pc, #0x13c]        @ 0x626bc <air1_opcal4_algorithm+0xfd4>
   6257e: fba1 0100    	umull	r0, r1, r1, r0
   62582: 1a10         	subs	r0, r2, r0
   62584: f8da 21ba    	ldr.w	r2, [r10, #0x1ba]
   62588: eb63 0101    	sbc.w	r1, r3, r1
   6258c: ebb0 0c02    	subs.w	r12, r0, r2
   62590: f161 0400    	sbc	r4, r1, #0x0
   62594: ebb5 050c    	subs.w	r5, r5, r12
   62598: eb73 0504    	sbcs.w	r5, r3, r4
   6259c: 4615         	mov	r5, r2
   6259e: bfb8         	it	lt
   625a0: 4605         	movlt	r5, r0
   625a2: 4240         	rsbs	r0, r0, #0
   625a4: eb73 0001    	sbcs.w	r0, r3, r1
   625a8: bfa8         	it	ge
   625aa: 4615         	movge	r5, r2
   625ac: f8ce 5004    	str.w	r5, [lr, #0x4]
   625b0: 984e         	ldr	r0, [sp, #0x138]
   625b2: eddf 2b43    	vldr	d18, [pc, #268]         @ 0x626c0 <air1_opcal4_algorithm+0xfd8>
   625b6: e9d7 c802    	ldrd	r12, r8, [r7, #8]
   625ba: 6840         	ldr	r0, [r0, #0x4]
   625bc: ee00 0a10    	vmov	s0, r0
   625c0: eef7 1ac0    	vcvt.f64.f32	d17, s0
   625c4: eef4 1b62    	vcmp.f64	d17, d18
   625c8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   625cc: d42f         	bmi	0x6262e <air1_opcal4_algorithm+0xf46> @ imm = #0x5e
   625ce: eddf 2b3e    	vldr	d18, [pc, #248]         @ 0x626c8 <air1_opcal4_algorithm+0xfe0>
   625d2: eef4 1b62    	vcmp.f64	d17, d18
   625d6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   625da: dc28         	bgt	0x6262e <air1_opcal4_algorithm+0xf46> @ imm = #0x50
   625dc: 984e         	ldr	r0, [sp, #0x138]
   625de: eddf 2b3c    	vldr	d18, [pc, #240]         @ 0x626d0 <air1_opcal4_algorithm+0xfe8>
   625e2: 6800         	ldr	r0, [r0]
   625e4: ee00 0a10    	vmov	s0, r0
   625e8: eef7 1ac0    	vcvt.f64.f32	d17, s0
   625ec: eef4 1b62    	vcmp.f64	d17, d18
   625f0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   625f4: d41b         	bmi	0x6262e <air1_opcal4_algorithm+0xf46> @ imm = #0x36
   625f6: eef4 1b60    	vcmp.f64	d17, d16
   625fa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   625fe: dc16         	bgt	0x6262e <air1_opcal4_algorithm+0xf46> @ imm = #0x2c
   62600: f10a 0005    	add.w	r0, r10, #0x5
   62604: eeb0 1a04    	vmov.f32	s2, #2.500000e+00
   62608: 9033         	str	r0, [sp, #0xcc]
   6260a: 6800         	ldr	r0, [r0]
   6260c: ee00 0a10    	vmov	s0, r0
   62610: eeb4 0a41    	vcmp.f32	s0, s2
   62614: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62618: d409         	bmi	0x6262e <air1_opcal4_algorithm+0xf46> @ imm = #0x12
   6261a: eef7 0ac0    	vcvt.f64.f32	d16, s0
   6261e: eddf 1b2e    	vldr	d17, [pc, #184]         @ 0x626d8 <air1_opcal4_algorithm+0xff0>
   62622: eef4 0b61    	vcmp.f64	d16, d17
   62626: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6262a: f340 8088    	ble.w	0x6273e <air1_opcal4_algorithm+0x1056> @ imm = #0x110
   6262e: 9a54         	ldr	r2, [sp, #0x150]
   62630: 2000         	movs	r0, #0x0
   62632: 2101         	movs	r1, #0x1
   62634: f88b 009a    	strb.w	r0, [r11, #0x9a]
   62638: f88b 0054    	strb.w	r0, [r11, #0x54]
   6263c: 1db5         	adds	r5, r6, #0x6
   6263e: f882 1310    	strb.w	r1, [r2, #0x310]
   62642: 465c         	mov	r4, r11
   62644: f8d6 1002    	ldr.w	r1, [r6, #0x2]
   62648: f8cb 1004    	str.w	r1, [r11, #0x4]
   6264c: 8832         	ldrh	r2, [r6]
   6264e: f8be 3058    	ldrh.w	r3, [lr, #0x58]
   62652: f8ab 2000    	strh.w	r2, [r11]
   62656: 4413         	add	r3, r2
   62658: f8ab 3002    	strh.w	r3, [r11, #0x2]
   6265c: 281e         	cmp	r0, #0x1e
   6265e: d007         	beq	0x62670 <air1_opcal4_algorithm+0xf88> @ imm = #0xe
   62660: 465c         	mov	r4, r11
   62662: f835 6010    	ldrh.w	r6, [r5, r0, lsl #1]
   62666: eb0b 0440    	add.w	r4, r11, r0, lsl #1
   6266a: 3001         	adds	r0, #0x1
   6266c: 8126         	strh	r6, [r4, #0x8]
   6266e: e7f5         	b	0x6265c <air1_opcal4_algorithm+0xf74> @ imm = #-0x16
   62670: 9c5e         	ldr	r4, [sp, #0x178]
   62672: 2000         	movs	r0, #0x0
   62674: 7220         	strb	r0, [r4, #0x8]
   62676: 6061         	str	r1, [r4, #0x4]
   62678: 8063         	strh	r3, [r4, #0x2]
   6267a: 8022         	strh	r2, [r4]
   6267c: 281e         	cmp	r0, #0x1e
   6267e: d037         	beq	0x626f0 <air1_opcal4_algorithm+0x1008> @ imm = #0x6e
   62680: 465a         	mov	r2, r11
   62682: eb04 0140    	add.w	r1, r4, r0, lsl #1
   62686: eb0b 0240    	add.w	r2, r11, r0, lsl #1
   6268a: 3001         	adds	r0, #0x1
   6268c: 8912         	ldrh	r2, [r2, #0x8]
   6268e: 824a         	strh	r2, [r1, #0x12]
   62690: e7f4         	b	0x6267c <air1_opcal4_algorithm+0xf94> @ imm = #-0x18
   62692: bf00         	nop
   62694: 00 00 1c c0  	.word	0xc01c0000
   62698: 00 00 49 c0  	.word	0xc0490000
   6269c: 00 00 24 c0  	.word	0xc0240000
   626a0: 00 00 08 40  	.word	0x40080000
   626a4: 00 00 04 c0  	.word	0xc0040000
   626a8: 00 00 2e c0  	.word	0xc02e0000
   626ac: 99 99 e9 3f  	.word	0x3fe99999
   626b0: 34 33 33 33  	.word	0x33333334
   626b4: 00 00 72 40  	.word	0x40720000
   626b8: 03 00 24 00  	.word	0x00240003
   626bc: 00 bb 17 00  	.word	0x0017bb00
   626c0: 83 c0 ca a1  	.word	0xa1cac083
   626c4: 45 b6 a3 3f  	.word	0x3fa3b645
   626c8: 98 4c 15 8c  	.word	0x8c154c98
   626cc: 4a ea bc 3f  	.word	0x3fbcea4a
   626d0: 66 66 66 66  	.word	0x66666666
   626d4: 66 66 f6 3f  	.word	0x3ff66666
   626d8: 33 33 33 33  	.word	0x33333333
   626dc: 33 33 20 40  	.word	0x40203333
   626e0: 00 00 00 00  	.word	0x00000000
   626e4: 00 00 4e 40  	.word	0x404e0000
   626e8: 00 00 00 00  	.word	0x00000000
   626ec: 00 c0 82 40  	.word	0x4082c000
   626f0: 2040         	movs	r0, #0x40
   626f2: f8ab 0097    	strh.w	r0, [r11, #0x97]
   626f6: 49e0         	ldr	r1, [pc, #0x380]        @ 0x62a78 <air1_opcal4_algorithm+0x1390>
   626f8: 4660         	mov	r0, r12
   626fa: 229b         	movs	r2, #0x9b
   626fc: 4479         	add	r1, pc
   626fe: f009 ff7e    	bl	0x6c5fe <copy_mem>      @ imm = #0x9efc
   62702: 49de         	ldr	r1, [pc, #0x378]        @ 0x62a7c <air1_opcal4_algorithm+0x1394>
   62704: 4640         	mov	r0, r8
   62706: f240 622b    	movw	r2, #0x62b
   6270a: 4479         	add	r1, pc
   6270c: f009 ff77    	bl	0x6c5fe <copy_mem>      @ imm = #0x9eee
   62710: 9854         	ldr	r0, [sp, #0x150]
   62712: f890 0310    	ldrb.w	r0, [r0, #0x310]
   62716: f857 1c6c    	ldr	r1, [r7, #-108]
   6271a: 4ad9         	ldr	r2, [pc, #0x364]        @ 0x62a80 <air1_opcal4_algorithm+0x1398>
   6271c: 447a         	add	r2, pc
   6271e: 6812         	ldr	r2, [r2]
   62720: 6812         	ldr	r2, [r2]
   62722: 428a         	cmp	r2, r1
   62724: bf01         	itttt	eq
   62726: f50d 5d8a    	addeq.w	sp, sp, #0x1140
   6272a: b004         	addeq	sp, #0x10
   6272c: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   62730: b001         	addeq	sp, #0x4
   62732: bf04         	itt	eq
   62734: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   62738: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6273a: f00c ec7a    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xc8f4
   6273e: 49d1         	ldr	r1, [pc, #0x344]        @ 0x62a84 <air1_opcal4_algorithm+0x139c>
   62740: 48d1         	ldr	r0, [pc, #0x344]        @ 0x62a88 <air1_opcal4_algorithm+0x13a0>
   62742: 4479         	add	r1, pc
   62744: 9141         	str	r1, [sp, #0x104]
   62746: eb0e 0400    	add.w	r4, lr, r0
   6274a: 2000         	movs	r0, #0x0
   6274c: f1b9 0f02    	cmp.w	r9, #0x2
   62750: 7008         	strb	r0, [r1]
   62752: f0c0 8088    	blo.w	0x62866 <air1_opcal4_algorithm+0x117e> @ imm = #0x110
   62756: f8b4 0130    	ldrh.w	r0, [r4, #0x130]
   6275a: 8831         	ldrh	r1, [r6]
   6275c: 1a08         	subs	r0, r1, r0
   6275e: 2801         	cmp	r0, #0x1
   62760: d15f         	bne	0x62822 <air1_opcal4_algorithm+0x113a> @ imm = #0xbe
   62762: f8d6 0002    	ldr.w	r0, [r6, #0x2]
   62766: eef3 2b07    	vmov.f64	d18, #2.300000e+01
   6276a: ed94 0a4b    	vldr	s0, [r4, #300]
   6276e: eef8 0b40    	vcvt.f64.u32	d16, s0
   62772: ee00 0a10    	vmov	s0, r0
   62776: eef8 1b40    	vcvt.f64.u32	d17, s0
   6277a: ee71 0be0    	vsub.f64	d16, d17, d16
   6277e: ed5f 1b28    	vldr	d17, [pc, #-160]        @ 0x626e0 <air1_opcal4_algorithm+0xff8>
   62782: eec0 0ba1    	vdiv.f64	d16, d16, d17
   62786: eef4 0b62    	vcmp.f64	d16, d18
   6278a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6278e: db12         	blt	0x627b6 <air1_opcal4_algorithm+0x10ce> @ imm = #0x24
   62790: f8d4 0134    	ldr.w	r0, [r4, #0x134]
   62794: f8c4 0132    	str.w	r0, [r4, #0x132]
   62798: f894 0140    	ldrb.w	r0, [r4, #0x140]
   6279c: f8b4 1138    	ldrh.w	r1, [r4, #0x138]
   627a0: 3001         	adds	r0, #0x1
   627a2: f8a4 1136    	strh.w	r1, [r4, #0x136]
   627a6: b2c1         	uxtb	r1, r0
   627a8: f8a4 9138    	strh.w	r9, [r4, #0x138]
   627ac: 2904         	cmp	r1, #0x4
   627ae: bf28         	it	hs
   627b0: 2004         	movhs	r0, #0x4
   627b2: f884 0140    	strb.w	r0, [r4, #0x140]
   627b6: eef4 0b61    	vcmp.f64	d16, d17
   627ba: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   627be: db0e         	blt	0x627de <air1_opcal4_algorithm+0x10f6> @ imm = #0x1c
   627c0: f8b4 013c    	ldrh.w	r0, [r4, #0x13c]
   627c4: f8a4 013a    	strh.w	r0, [r4, #0x13a]
   627c8: f894 0141    	ldrb.w	r0, [r4, #0x141]
   627cc: f8a4 913c    	strh.w	r9, [r4, #0x13c]
   627d0: 3001         	adds	r0, #0x1
   627d2: b2c1         	uxtb	r1, r0
   627d4: 2902         	cmp	r1, #0x2
   627d6: bf28         	it	hs
   627d8: 2002         	movhs	r0, #0x2
   627da: f884 0141    	strb.w	r0, [r4, #0x141]
   627de: ed5f 1b3e    	vldr	d17, [pc, #-248]        @ 0x626e8 <air1_opcal4_algorithm+0x1000>
   627e2: eef4 0b61    	vcmp.f64	d16, d17
   627e6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   627ea: db08         	blt	0x627fe <air1_opcal4_algorithm+0x1116> @ imm = #0x10
   627ec: f894 0142    	ldrb.w	r0, [r4, #0x142]
   627f0: f8a4 913e    	strh.w	r9, [r4, #0x13e]
   627f4: 38ff         	subs	r0, #0xff
   627f6: bf18         	it	ne
   627f8: 2001         	movne	r0, #0x1
   627fa: f884 0142    	strb.w	r0, [r4, #0x142]
   627fe: 9a5c         	ldr	r2, [sp, #0x170]
   62800: f894 1140    	ldrb.w	r1, [r4, #0x140]
   62804: f892 0906    	ldrb.w	r0, [r2, #0x906]
   62808: 4281         	cmp	r1, r0
   6280a: d108         	bne	0x6281e <air1_opcal4_algorithm+0x1136> @ imm = #0x10
   6280c: f9b2 0418    	ldrsh.w	r0, [r2, #0x418]
   62810: f9b4 1132    	ldrsh.w	r1, [r4, #0x132]
   62814: f9b4 2138    	ldrsh.w	r2, [r4, #0x138]
   62818: 1a51         	subs	r1, r2, r1
   6281a: 4281         	cmp	r1, r0
   6281c: dd03         	ble	0x62826 <air1_opcal4_algorithm+0x113e> @ imm = #0x6
   6281e: 2000         	movs	r0, #0x0
   62820: e004         	b	0x6282c <air1_opcal4_algorithm+0x1144> @ imm = #0x8
   62822: 2000         	movs	r0, #0x0
   62824: e01f         	b	0x62866 <air1_opcal4_algorithm+0x117e> @ imm = #0x3e
   62826: 9941         	ldr	r1, [sp, #0x104]
   62828: 2001         	movs	r0, #0x1
   6282a: 7008         	strb	r0, [r1]
   6282c: 9b5c         	ldr	r3, [sp, #0x170]
   6282e: f894 2141    	ldrb.w	r2, [r4, #0x141]
   62832: f893 1907    	ldrb.w	r1, [r3, #0x907]
   62836: 428a         	cmp	r2, r1
   62838: d10b         	bne	0x62852 <air1_opcal4_algorithm+0x116a> @ imm = #0x16
   6283a: f9b3 1418    	ldrsh.w	r1, [r3, #0x418]
   6283e: f9b4 213a    	ldrsh.w	r2, [r4, #0x13a]
   62842: f9b4 313c    	ldrsh.w	r3, [r4, #0x13c]
   62846: 1a9a         	subs	r2, r3, r2
   62848: 428a         	cmp	r2, r1
   6284a: bfde         	ittt	le
   6284c: 2001         	movle	r0, #0x1
   6284e: 9941         	ldrle	r1, [sp, #0x104]
   62850: 7008         	strble	r0, [r1]
   62852: 995c         	ldr	r1, [sp, #0x170]
   62854: f894 2142    	ldrb.w	r2, [r4, #0x142]
   62858: f891 1908    	ldrb.w	r1, [r1, #0x908]
   6285c: 428a         	cmp	r2, r1
   6285e: bf02         	ittt	eq
   62860: 2001         	moveq	r0, #0x1
   62862: 9941         	ldreq	r1, [sp, #0x104]
   62864: 7008         	strbeq	r0, [r1]
   62866: 4989         	ldr	r1, [pc, #0x224]        @ 0x62a8c <air1_opcal4_algorithm+0x13a4>
   62868: 4676         	mov	r6, lr
   6286a: 9432         	str	r4, [sp, #0xc8]
   6286c: f894 4143    	ldrb.w	r4, [r4, #0x143]
   62870: 468c         	mov	r12, r1
   62872: 4987         	ldr	r1, [pc, #0x21c]        @ 0x62a90 <air1_opcal4_algorithm+0x13a8>
   62874: 2c01         	cmp	r4, #0x1
   62876: bf02         	ittt	eq
   62878: 2001         	moveq	r0, #0x1
   6287a: 9c41         	ldreq	r4, [sp, #0x104]
   6287c: 7020         	strbeq	r0, [r4]
   6287e: 4a85         	ldr	r2, [pc, #0x214]        @ 0x62a94 <air1_opcal4_algorithm+0x13ac>
   62880: 4634         	mov	r4, r6
   62882: 468e         	mov	lr, r1
   62884: 4984         	ldr	r1, [pc, #0x210]        @ 0x62a98 <air1_opcal4_algorithm+0x13b0>
   62886: 4b85         	ldr	r3, [pc, #0x214]        @ 0x62a9c <air1_opcal4_algorithm+0x13b4>
   62888: 4d85         	ldr	r5, [pc, #0x214]        @ 0x62aa0 <air1_opcal4_algorithm+0x13b8>
   6288a: 4688         	mov	r8, r1
   6288c: 4985         	ldr	r1, [pc, #0x214]        @ 0x62aa4 <air1_opcal4_algorithm+0x13bc>
   6288e: 468a         	mov	r10, r1
   62890: f642 2160    	movw	r1, #0x2a60
   62894: 4431         	add	r1, r6
   62896: 9153         	str	r1, [sp, #0x14c]
   62898: f244 2110    	movw	r1, #0x4210
   6289c: 4431         	add	r1, r6
   6289e: 914f         	str	r1, [sp, #0x13c]
   628a0: f644 31f8    	movw	r1, #0x4bf8
   628a4: 4431         	add	r1, r6
   628a6: 9130         	str	r1, [sp, #0xc0]
   628a8: f645 0158    	movw	r1, #0x5858
   628ac: 4431         	add	r1, r6
   628ae: 912f         	str	r1, [sp, #0xbc]
   628b0: f649 1170    	movw	r1, #0x9970
   628b4: 4431         	add	r1, r6
   628b6: 912e         	str	r1, [sp, #0xb8]
   628b8: f24c 61c0    	movw	r1, #0xc6c0
   628bc: 4431         	add	r1, r6
   628be: 912d         	str	r1, [sp, #0xb4]
   628c0: f24e 41c0    	movw	r1, #0xe4c0
   628c4: 4431         	add	r1, r6
   628c6: 912c         	str	r1, [sp, #0xb0]
   628c8: f24f 71f0    	movw	r1, #0xf7f0
   628cc: 4431         	add	r1, r6
   628ce: 912b         	str	r1, [sp, #0xac]
   628d0: 18b1         	adds	r1, r6, r2
   628d2: 912a         	str	r1, [sp, #0xa8]
   628d4: 18f1         	adds	r1, r6, r3
   628d6: 9129         	str	r1, [sp, #0xa4]
   628d8: 1971         	adds	r1, r6, r5
   628da: 9128         	str	r1, [sp, #0xa0]
   628dc: eb06 010c    	add.w	r1, r6, r12
   628e0: 9127         	str	r1, [sp, #0x9c]
   628e2: eb06 010e    	add.w	r1, r6, lr
   628e6: 9126         	str	r1, [sp, #0x98]
   628e8: eb06 0108    	add.w	r1, r6, r8
   628ec: 9125         	str	r1, [sp, #0x94]
   628ee: eb06 010a    	add.w	r1, r6, r10
   628f2: 9124         	str	r1, [sp, #0x90]
   628f4: 9932         	ldr	r1, [sp, #0xc8]
   628f6: 9a5f         	ldr	r2, [sp, #0x17c]
   628f8: f8b6 31c4    	ldrh.w	r3, [r6, #0x1c4]
   628fc: f881 0143    	strb.w	r0, [r1, #0x143]
   62900: f8d2 0002    	ldr.w	r0, [r2, #0x2]
   62904: f8c1 012c    	str.w	r0, [r1, #0x12c]
   62908: f8b2 a000    	ldrh.w	r10, [r2]
   6290c: f8a1 a130    	strh.w	r10, [r1, #0x130]
   62910: b94b         	cbnz	r3, 0x62926 <air1_opcal4_algorithm+0x123e> @ imm = #0x12
   62912: 995c         	ldr	r1, [sp, #0x170]
   62914: 6862         	ldr	r2, [r4, #0x4]
   62916: 8b89         	ldrh	r1, [r1, #0x1c]
   62918: 4411         	add	r1, r2
   6291a: 3978         	subs	r1, #0x78
   6291c: 4281         	cmp	r1, r0
   6291e: bf9c         	itt	ls
   62920: f8a4 a1c4    	strhls.w	r10, [r4, #0x1c4]
   62924: 4653         	movls	r3, r10
   62926: f50d 6567    	add.w	r5, sp, #0xe70
   6292a: 21f0         	movs	r1, #0xf0
   6292c: 935b         	str	r3, [sp, #0x16c]
   6292e: 4628         	mov	r0, r5
   62930: f00c eb66    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc6cc
   62934: f50d 603a    	add.w	r0, sp, #0xba0
   62938: 21f0         	movs	r1, #0xf0
   6293a: f00c eb62    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc6c4
   6293e: f50d 680d    	add.w	r8, sp, #0x8d0
   62942: 21f0         	movs	r1, #0xf0
   62944: 4640         	mov	r0, r8
   62946: f00c eb5c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc6b8
   6294a: f50d 66c0    	add.w	r6, sp, #0x600
   6294e: 21f0         	movs	r1, #0xf0
   62950: 4630         	mov	r0, r6
   62952: f00c eb56    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc6ac
   62956: 985f         	ldr	r0, [sp, #0x17c]
   62958: f8a4 a000    	strh.w	r10, [r4]
   6295c: 1d84         	adds	r4, r0, #0x6
   6295e: 2000         	movs	r0, #0x0
   62960: 4621         	mov	r1, r4
   62962: 28f0         	cmp	r0, #0xf0
   62964: d016         	beq	0x62994 <air1_opcal4_algorithm+0x12ac> @ imm = #0x2c
   62966: f831 3b02    	ldrh	r3, [r1], #2
   6296a: 182a         	adds	r2, r5, r0
   6296c: ee00 3a10    	vmov	s0, r3
   62970: eef8 0b40    	vcvt.f64.u32	d16, s0
   62974: edc2 0b00    	vstr	d16, [r2]
   62978: f50d 623a    	add.w	r2, sp, #0xba0
   6297c: 4402         	add	r2, r0
   6297e: edc2 0b00    	vstr	d16, [r2]
   62982: eb08 0200    	add.w	r2, r8, r0
   62986: edc2 0b00    	vstr	d16, [r2]
   6298a: 1832         	adds	r2, r6, r0
   6298c: 3008         	adds	r0, #0x8
   6298e: edc2 0b00    	vstr	d16, [r2]
   62992: e7e6         	b	0x62962 <air1_opcal4_algorithm+0x127a> @ imm = #-0x34
   62994: 201e         	movs	r0, #0x1e
   62996: 211e         	movs	r1, #0x1e
   62998: f88d 0238    	strb.w	r0, [sp, #0x238]
   6299c: f88d 0328    	strb.w	r0, [sp, #0x328]
   629a0: f88d 0490    	strb.w	r0, [sp, #0x490]
   629a4: 4628         	mov	r0, r5
   629a6: 945d         	str	r4, [sp, #0x174]
   629a8: f009 fe32    	bl	0x6c610 <math_std>      @ imm = #0x9c64
   629ac: f50d 6667    	add.w	r6, sp, #0xe70
   629b0: eeb0 9b40    	vmov.f64	d9, d0
   629b4: f106 0008    	add.w	r0, r6, #0x8
   629b8: f8dd a158    	ldr.w	r10, [sp, #0x158]
   629bc: 2101         	movs	r1, #0x1
   629be: 2500         	movs	r5, #0x0
   629c0: 4602         	mov	r2, r0
   629c2: 291e         	cmp	r1, #0x1e
   629c4: d00e         	beq	0x629e4 <air1_opcal4_algorithm+0x12fc> @ imm = #0x1c
   629c6: b2eb         	uxtb	r3, r5
   629c8: ecf2 1b02    	vldmia	r2!, {d17}
   629cc: eb06 03c3    	add.w	r3, r6, r3, lsl #3
   629d0: edd3 0b00    	vldr	d16, [r3]
   629d4: eef4 1b60    	vcmp.f64	d17, d16
   629d8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   629dc: bfc8         	it	gt
   629de: 460d         	movgt	r5, r1
   629e0: 3101         	adds	r1, #0x1
   629e2: e7ee         	b	0x629c2 <air1_opcal4_algorithm+0x12da> @ imm = #-0x24
   629e4: ef80 a010    	vmov.i32	d10, #0x0
   629e8: fa5f f885    	uxtb.w	r8, r5
   629ec: ef80 b010    	vmov.i32	d11, #0x0
   629f0: f1b8 0f01    	cmp.w	r8, #0x1
   629f4: f200 8080    	bhi.w	0x62af8 <air1_opcal4_algorithm+0x1410> @ imm = #0x100
   629f8: f50d 643a    	add.w	r4, sp, #0xba0
   629fc: 2201         	movs	r2, #0x1
   629fe: 2100         	movs	r1, #0x0
   62a00: 2a1e         	cmp	r2, #0x1e
   62a02: d00e         	beq	0x62a22 <air1_opcal4_algorithm+0x133a> @ imm = #0x1c
   62a04: b2cb         	uxtb	r3, r1
   62a06: ecf0 1b02    	vldmia	r0!, {d17}
   62a0a: eb06 03c3    	add.w	r3, r6, r3, lsl #3
   62a0e: edd3 0b00    	vldr	d16, [r3]
   62a12: eef4 1b60    	vcmp.f64	d17, d16
   62a16: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62a1a: bf48         	it	mi
   62a1c: 4611         	movmi	r1, r2
   62a1e: 3201         	adds	r2, #0x1
   62a20: e7ee         	b	0x62a00 <air1_opcal4_algorithm+0x1318> @ imm = #-0x24
   62a22: f50d 660d    	add.w	r6, sp, #0x8d0
   62a26: b2ca         	uxtb	r2, r1
   62a28: a98e         	add	r1, sp, #0x238
   62a2a: 4630         	mov	r0, r6
   62a2c: f009 fe1c    	bl	0x6c668 <delete_element> @ imm = #0x9c38
   62a30: f89d 1238    	ldrb.w	r1, [sp, #0x238]
   62a34: 4630         	mov	r0, r6
   62a36: f009 fdeb    	bl	0x6c610 <math_std>      @ imm = #0x9bd6
   62a3a: ef20 a110    	vorr	d10, d0, d0
   62a3e: 0628         	lsls	r0, r5, #0x18
   62a40: d032         	beq	0x62aa8 <air1_opcal4_algorithm+0x13c0> @ imm = #0x64
   62a42: eb04 00c8    	add.w	r0, r4, r8, lsl #3
   62a46: edd0 0b02    	vldr	d16, [r0, #8]
   62a4a: f1a8 0001    	sub.w	r0, r8, #0x1
   62a4e: eb04 01c0    	add.w	r1, r4, r0, lsl #3
   62a52: edd1 1b00    	vldr	d17, [r1]
   62a56: eef4 0b61    	vcmp.f64	d16, d17
   62a5a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62a5e: dd2f         	ble	0x62ac0 <air1_opcal4_algorithm+0x13d8> @ imm = #0x5e
   62a60: f50d 653a    	add.w	r5, sp, #0xba0
   62a64: acca         	add	r4, sp, #0x328
   62a66: 4642         	mov	r2, r8
   62a68: 4628         	mov	r0, r5
   62a6a: 4621         	mov	r1, r4
   62a6c: f009 fdfc    	bl	0x6c668 <delete_element> @ imm = #0x9bf8
   62a70: 4628         	mov	r0, r5
   62a72: 4621         	mov	r1, r4
   62a74: 4642         	mov	r2, r8
   62a76: e02f         	b	0x62ad8 <air1_opcal4_algorithm+0x13f0> @ imm = #0x5e
   62a78: 32 f0 02 00  	.word	0x0002f032
   62a7c: c0 f0 02 00  	.word	0x0002f0c0
   62a80: b4 0a 01 00  	.word	0x00010ab4
   62a84: ba 08 03 00  	.word	0x000308ba
   62a88: f8 c8 01 00  	.word	0x0001c8f8
   62a8c: 58 53 01 00  	.word	0x00015358
   62a90: f0 71 01 00  	.word	0x000171f0
   62a94: 20 14 01 00  	.word	0x00011420
   62a98: 48 8e 01 00  	.word	0x00018e48
   62a9c: a8 32 01 00  	.word	0x000132a8
   62aa0: 28 37 01 00  	.word	0x00013728
   62aa4: b8 ac 01 00  	.word	0x0001acb8
   62aa8: f50d 653a    	add.w	r5, sp, #0xba0
   62aac: acca         	add	r4, sp, #0x328
   62aae: 2200         	movs	r2, #0x0
   62ab0: 4628         	mov	r0, r5
   62ab2: 4621         	mov	r1, r4
   62ab4: f009 fdd8    	bl	0x6c668 <delete_element> @ imm = #0x9bb0
   62ab8: 4628         	mov	r0, r5
   62aba: 4621         	mov	r1, r4
   62abc: 2200         	movs	r2, #0x0
   62abe: e00b         	b	0x62ad8 <air1_opcal4_algorithm+0x13f0> @ imm = #0x16
   62ac0: b284         	uxth	r4, r0
   62ac2: f50d 653a    	add.w	r5, sp, #0xba0
   62ac6: aeca         	add	r6, sp, #0x328
   62ac8: 4628         	mov	r0, r5
   62aca: 4622         	mov	r2, r4
   62acc: 4631         	mov	r1, r6
   62ace: f009 fdcb    	bl	0x6c668 <delete_element> @ imm = #0x9b96
   62ad2: 4628         	mov	r0, r5
   62ad4: 4631         	mov	r1, r6
   62ad6: 4622         	mov	r2, r4
   62ad8: f009 fdc6    	bl	0x6c668 <delete_element> @ imm = #0x9b8c
   62adc: f89d 1328    	ldrb.w	r1, [sp, #0x328]
   62ae0: f50d 603a    	add.w	r0, sp, #0xba0
   62ae4: f009 fd94    	bl	0x6c610 <math_std>      @ imm = #0x9b28
   62ae8: f8dd a158    	ldr.w	r10, [sp, #0x158]
   62aec: ef20 b110    	vorr	d11, d0, d0
   62af0: f50d 6667    	add.w	r6, sp, #0xe70
   62af4: f8ba 9008    	ldrh.w	r9, [r10, #0x8]
   62af8: 985b         	ldr	r0, [sp, #0x16c]
   62afa: 2800         	cmp	r0, #0x0
   62afc: d07a         	beq	0x62bf4 <air1_opcal4_algorithm+0x150c> @ imm = #0xf4
   62afe: 4581         	cmp	r9, r0
   62b00: d978         	bls	0x62bf4 <air1_opcal4_algorithm+0x150c> @ imm = #0xf0
   62b02: f1b8 0f01    	cmp.w	r8, #0x1
   62b06: d875         	bhi	0x62bf4 <air1_opcal4_algorithm+0x150c> @ imm = #0xea
   62b08: eb06 00c8    	add.w	r0, r6, r8, lsl #3
   62b0c: f50d 69c0    	add.w	r9, sp, #0x600
   62b10: f50d 6192    	add.w	r1, sp, #0x490
   62b14: 4642         	mov	r2, r8
   62b16: ed90 8b00    	vldr	d8, [r0]
   62b1a: 4648         	mov	r0, r9
   62b1c: f009 fda4    	bl	0x6c668 <delete_element> @ imm = #0x9b48
   62b20: f89d 1490    	ldrb.w	r1, [sp, #0x490]
   62b24: 4648         	mov	r0, r9
   62b26: f009 fdbb    	bl	0x6c6a0 <math_mean>     @ imm = #0x9b76
   62b2a: ee78 0b40    	vsub.f64	d16, d8, d0
   62b2e: eef5 0b40    	vcmp.f64	d16, #0
   62b32: eef1 1b60    	vneg.f64	d17, d16
   62b36: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62b3a: bf48         	it	mi
   62b3c: eef0 0b61    	vmovmi.f64	d16, d17
   62b40: eec0 0b80    	vdiv.f64	d16, d16, d0
   62b44: 985c         	ldr	r0, [sp, #0x170]
   62b46: edd0 1b0e    	vldr	d17, [r0, #56]
   62b4a: eef4 0b61    	vcmp.f64	d16, d17
   62b4e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62b52: dd4f         	ble	0x62bf4 <air1_opcal4_algorithm+0x150c> @ imm = #0x9e
   62b54: ee79 0b4b    	vsub.f64	d16, d9, d11
   62b58: eef5 0b40    	vcmp.f64	d16, #0
   62b5c: eef1 1b60    	vneg.f64	d17, d16
   62b60: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62b64: bf48         	it	mi
   62b66: eef0 0b61    	vmovmi.f64	d16, d17
   62b6a: eec0 0b8b    	vdiv.f64	d16, d16, d11
   62b6e: 985c         	ldr	r0, [sp, #0x170]
   62b70: edd0 1b0a    	vldr	d17, [r0, #40]
   62b74: eef4 0b61    	vcmp.f64	d16, d17
   62b78: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62b7c: dd3a         	ble	0x62bf4 <air1_opcal4_algorithm+0x150c> @ imm = #0x74
   62b7e: ee79 0b4a    	vsub.f64	d16, d9, d10
   62b82: eef5 0b40    	vcmp.f64	d16, #0
   62b86: eef1 1b60    	vneg.f64	d17, d16
   62b8a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62b8e: bf48         	it	mi
   62b90: eef0 0b61    	vmovmi.f64	d16, d17
   62b94: eec0 0b8a    	vdiv.f64	d16, d16, d10
   62b98: 985c         	ldr	r0, [sp, #0x170]
   62b9a: edd0 1b0c    	vldr	d17, [r0, #48]
   62b9e: eef4 0b61    	vcmp.f64	d16, d17
   62ba2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62ba6: d525         	bpl	0x62bf4 <air1_opcal4_algorithm+0x150c> @ imm = #0x4a
   62ba8: 9954         	ldr	r1, [sp, #0x150]
   62baa: 2001         	movs	r0, #0x1
   62bac: 9e5f         	ldr	r6, [sp, #0x17c]
   62bae: 2200         	movs	r2, #0x0
   62bb0: f88b 2054    	strb.w	r2, [r11, #0x54]
   62bb4: 465c         	mov	r4, r11
   62bb6: f881 0310    	strb.w	r0, [r1, #0x310]
   62bba: 2002         	movs	r0, #0x2
   62bbc: f88b 009a    	strb.w	r0, [r11, #0x9a]
   62bc0: f8d6 e002    	ldr.w	lr, [r6, #0x2]
   62bc4: f8cb e004    	str.w	lr, [r11, #0x4]
   62bc8: 8831         	ldrh	r1, [r6]
   62bca: f8ba 3058    	ldrh.w	r3, [r10, #0x58]
   62bce: e9d7 c802    	ldrd	r12, r8, [r7, #8]
   62bd2: 985d         	ldr	r0, [sp, #0x174]
   62bd4: 440b         	add	r3, r1
   62bd6: f8ab 1000    	strh.w	r1, [r11]
   62bda: f8ab 3002    	strh.w	r3, [r11, #0x2]
   62bde: 2a1e         	cmp	r2, #0x1e
   62be0: f003 851e    	beq.w	0x66620 <air1_opcal4_algorithm+0x4f38> @ imm = #0x3a3c
   62be4: 465d         	mov	r5, r11
   62be6: f830 4012    	ldrh.w	r4, [r0, r2, lsl #1]
   62bea: eb0b 0542    	add.w	r5, r11, r2, lsl #1
   62bee: 3201         	adds	r2, #0x1
   62bf0: 812c         	strh	r4, [r5, #0x8]
   62bf2: e7f4         	b	0x62bde <air1_opcal4_algorithm+0x14f6> @ imm = #-0x18
   62bf4: 985f         	ldr	r0, [sp, #0x17c]
   62bf6: 2178         	movs	r1, #0x78
   62bf8: f8ba 4010    	ldrh.w	r4, [r10, #0x10]
   62bfc: f100 0842    	add.w	r8, r0, #0x42
   62c00: f8da 500c    	ldr.w	r5, [r10, #0xc]
   62c04: 8806         	ldrh	r6, [r0]
   62c06: f8d0 b002    	ldr.w	r11, [r0, #0x2]
   62c0a: f50d 6092    	add.w	r0, sp, #0x490
   62c0e: f928 970f    	vld1.8	{d9}, [r8]
   62c12: ed9a 8b14    	vldr	d8, [r10, #80]
   62c16: f00c e9f4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc3e8
   62c1a: f50d 6983    	add.w	r9, sp, #0x418
   62c1e: 2178         	movs	r1, #0x78
   62c20: 4648         	mov	r0, r9
   62c22: f00c e9ee    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc3dc
   62c26: f50d 600d    	add.w	r0, sp, #0x8d0
   62c2a: 21f0         	movs	r1, #0xf0
   62c2c: f00c e9e8    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc3d0
   62c30: f50d 60c0    	add.w	r0, sp, #0x600
   62c34: 21f0         	movs	r1, #0xf0
   62c36: f00c e9e4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc3c8
   62c3a: a8ca         	add	r0, sp, #0x328
   62c3c: 21f0         	movs	r1, #0xf0
   62c3e: f00c e9e0    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc3c0
   62c42: a88e         	add	r0, sp, #0x238
   62c44: 21f0         	movs	r1, #0xf0
   62c46: f00c e9dc    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc3b8
   62c4a: ef80 a050    	vmov.i32	q5, #0x0
   62c4e: a86a         	add	r0, sp, #0x1a8
   62c50: f44f 7134    	mov.w	r1, #0x2d0
   62c54: f900 aacd    	vst1.64	{d10, d11}, [r0]!
   62c58: f900 aacd    	vst1.64	{d10, d11}, [r0]!
   62c5c: f900 aacf    	vst1.64	{d10, d11}, [r0]
   62c60: f50d 6067    	add.w	r0, sp, #0xe70
   62c64: f00c e9cc    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc398
   62c68: f50d 603a    	add.w	r0, sp, #0xba0
   62c6c: f44f 7134    	mov.w	r1, #0x2d0
   62c70: f00c e9c6    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xc38c
   62c74: 2000         	movs	r0, #0x0
   62c76: e9cd 0060    	strd	r0, r0, [sp, #384]
   62c7a: a962         	add	r1, sp, #0x188
   62c7c: ebbb 0205    	subs.w	r2, r11, r5
   62c80: f160 0300    	sbc	r3, r0, #0x0
   62c84: 985c         	ldr	r0, [sp, #0x170]
   62c86: f901 aacd    	vst1.64	{d10, d11}, [r1]!
   62c8a: f890 0040    	ldrb.w	r0, [r0, #0x40]
   62c8e: f901 aacf    	vst1.64	{d10, d11}, [r1]
   62c92: 2801         	cmp	r0, #0x1
   62c94: d141         	bne	0x62d1a <air1_opcal4_algorithm+0x1632> @ imm = #0x82
   62c96: 2c00         	cmp	r4, #0x0
   62c98: d03f         	beq	0x62d1a <air1_opcal4_algorithm+0x1632> @ imm = #0x7e
   62c9a: 1b30         	subs	r0, r6, r4
   62c9c: 2801         	cmp	r0, #0x1
   62c9e: d13c         	bne	0x62d1a <air1_opcal4_algorithm+0x1632> @ imm = #0x78
   62ca0: f5b2 70f0    	subs.w	r0, r2, #0x1e0
   62ca4: f173 0000    	sbcs	r0, r3, #0x0
   62ca8: db37         	blt	0x62d1a <air1_opcal4_algorithm+0x1632> @ imm = #0x6e
   62caa: 2000         	movs	r0, #0x0
   62cac: f240 5163    	movw	r1, #0x563
   62cb0: 1a89         	subs	r1, r1, r2
   62cb2: 4198         	sbcs	r0, r3
   62cb4: db31         	blt	0x62d1a <air1_opcal4_algorithm+0x1632> @ imm = #0x62
   62cb6: ee39 cb48    	vsub.f64	d12, d9, d8
   62cba: 48e9         	ldr	r0, [pc, #0x3a4]        @ 0x63060 <air1_opcal4_algorithm+0x1978>
   62cbc: 46ac         	mov	r12, r5
   62cbe: 9d5d         	ldr	r5, [sp, #0x174]
   62cc0: e9cd 825a    	strd	r8, r2, [sp, #360]
   62cc4: f10a 0112    	add.w	r1, r10, #0x12
   62cc8: 300a         	adds	r0, #0xa
   62cca: f50d 62c0    	add.w	r2, sp, #0x600
   62cce: f50d 640d    	add.w	r4, sp, #0x8d0
   62cd2: f50d 6867    	add.w	r8, sp, #0xe70
   62cd6: f50d 7ad4    	add.w	r10, sp, #0x1a8
   62cda: f50d 6e92    	add.w	lr, sp, #0x490
   62cde: 9355         	str	r3, [sp, #0x154]
   62ce0: 2300         	movs	r3, #0x0
   62ce2: 9658         	str	r6, [sp, #0x160]
   62ce4: 2b3c         	cmp	r3, #0x3c
   62ce6: d045         	beq	0x62d74 <air1_opcal4_algorithm+0x168c> @ imm = #0x8a
   62ce8: eb0c 0600    	add.w	r6, r12, r0
   62cec: f849 6013    	str.w	r6, [r9, r3, lsl #1]
   62cf0: eb0b 0600    	add.w	r6, r11, r0
   62cf4: f84e 6013    	str.w	r6, [lr, r3, lsl #1]
   62cf8: 300a         	adds	r0, #0xa
   62cfa: 5aee         	ldrh	r6, [r5, r3]
   62cfc: ee00 6a10    	vmov	s0, r6
   62d00: 5ace         	ldrh	r6, [r1, r3]
   62d02: 3302         	adds	r3, #0x2
   62d04: eef8 0b40    	vcvt.f64.u32	d16, s0
   62d08: ee00 6a10    	vmov	s0, r6
   62d0c: ece4 0b02    	vstmia	r4!, {d16}
   62d10: eef8 0b40    	vcvt.f64.u32	d16, s0
   62d14: ece2 0b02    	vstmia	r2!, {d16}
   62d18: e7e4         	b	0x62ce4 <air1_opcal4_algorithm+0x15fc> @ imm = #-0x38
   62d1a: 9954         	ldr	r1, [sp, #0x150]
   62d1c: 2001         	movs	r0, #0x1
   62d1e: 9d53         	ldr	r5, [sp, #0x14c]
   62d20: f50d 693a    	add.w	r9, sp, #0xba0
   62d24: f8dd c17c    	ldr.w	r12, [sp, #0x17c]
   62d28: f881 0310    	strb.w	r0, [r1, #0x310]
   62d2c: f501 703c    	add.w	r0, r1, #0x2f0
   62d30: 810e         	strh	r6, [r1, #0x8]
   62d32: f900 974f    	vst1.16	{d9}, [r0]
   62d36: f8ba 0058    	ldrh.w	r0, [r10, #0x58]
   62d3a: f8c1 b010    	str.w	r11, [r1, #0x10]
   62d3e: f50d 6b0d    	add.w	r11, sp, #0x8d0
   62d42: 4430         	add	r0, r6
   62d44: 8008         	strh	r0, [r1]
   62d46: 48c6         	ldr	r0, [pc, #0x318]        @ 0x63060 <air1_opcal4_algorithm+0x1978>
   62d48: 2188         	movs	r1, #0x88
   62d4a: 9e5d         	ldr	r6, [sp, #0x174]
   62d4c: 300a         	adds	r0, #0xa
   62d4e: 4632         	mov	r2, r6
   62d50: f5b1 7fbc    	cmp.w	r1, #0x178
   62d54: f000 8396    	beq.w	0x63484 <air1_opcal4_algorithm+0x1d9c> @ imm = #0x72c
   62d58: f8dc 3002    	ldr.w	r3, [r12, #0x2]
   62d5c: 9c54         	ldr	r4, [sp, #0x150]
   62d5e: 4403         	add	r3, r0
   62d60: 300a         	adds	r0, #0xa
   62d62: f844 3011    	str.w	r3, [r4, r1, lsl #1]
   62d66: 1863         	adds	r3, r4, r1
   62d68: 3108         	adds	r1, #0x8
   62d6a: f832 4b02    	ldrh	r4, [r2], #2
   62d6e: f823 4c68    	strh	r4, [r3, #-104]
   62d72: e7ed         	b	0x62d50 <air1_opcal4_algorithm+0x1668> @ imm = #-0x26
   62d74: f8cd c164    	str.w	r12, [sp, #0x164]
   62d78: adca         	add	r5, sp, #0x328
   62d7a: f50d 600d    	add.w	r0, sp, #0x8d0
   62d7e: 4629         	mov	r1, r5
   62d80: f009 fcba    	bl	0x6c6f8 <eliminate_peak> @ imm = #0x9974
   62d84: ae8e         	add	r6, sp, #0x238
   62d86: f50d 60c0    	add.w	r0, sp, #0x600
   62d8a: 4631         	mov	r1, r6
   62d8c: f009 fcb4    	bl	0x6c6f8 <eliminate_peak> @ imm = #0x9968
   62d90: f50d 6080    	add.w	r0, sp, #0x400
   62d94: 210a         	movs	r1, #0xa
   62d96: ed90 0a0a    	vldr	s0, [r0, #40]
   62d9a: f50d 6080    	add.w	r0, sp, #0x400
   62d9e: eef8 0b40    	vcvt.f64.u32	d16, s0
   62da2: ed90 1a14    	vldr	s2, [r0, #80]
   62da6: f50d 6080    	add.w	r0, sp, #0x400
   62daa: edcd 0b82    	vstr	d16, [sp, #520]
   62dae: eef8 0b41    	vcvt.f64.u32	d16, s2
   62db2: ed90 2a1e    	vldr	s4, [r0, #120]
   62db6: f50d 6080    	add.w	r0, sp, #0x400
   62dba: edcd 0b84    	vstr	d16, [sp, #528]
   62dbe: eef8 0b42    	vcvt.f64.u32	d16, s4
   62dc2: ed90 0a28    	vldr	s0, [r0, #160]
   62dc6: f50d 6080    	add.w	r0, sp, #0x400
   62dca: edcd 0b86    	vstr	d16, [sp, #536]
   62dce: eef8 0b40    	vcvt.f64.u32	d16, s0
   62dd2: ed90 1a32    	vldr	s2, [r0, #200]
   62dd6: f50d 6080    	add.w	r0, sp, #0x400
   62dda: edcd 0b88    	vstr	d16, [sp, #544]
   62dde: eef8 0b41    	vcvt.f64.u32	d16, s2
   62de2: ed90 2a3c    	vldr	s4, [r0, #240]
   62de6: 4630         	mov	r0, r6
   62de8: edcd 0b8a    	vstr	d16, [sp, #552]
   62dec: eef8 0b42    	vcvt.f64.u32	d16, s4
   62df0: edcd 0b8c    	vstr	d16, [sp, #560]
   62df4: 4c9b         	ldr	r4, [pc, #0x26c]        @ 0x63064 <air1_opcal4_algorithm+0x197c>
   62df6: 447c         	add	r4, pc
   62df8: 47a0         	blx	r4
   62dfa: f106 0050    	add.w	r0, r6, #0x50
   62dfe: 210a         	movs	r1, #0xa
   62e00: eeb0 ab40    	vmov.f64	d10, d0
   62e04: ed8d 0b76    	vstr	d0, [sp, #472]
   62e08: 47a0         	blx	r4
   62e0a: f106 00a0    	add.w	r0, r6, #0xa0
   62e0e: 210a         	movs	r1, #0xa
   62e10: eeb0 bb40    	vmov.f64	d11, d0
   62e14: ed8d 0b78    	vstr	d0, [sp, #480]
   62e18: 47a0         	blx	r4
   62e1a: 4628         	mov	r0, r5
   62e1c: 210a         	movs	r1, #0xa
   62e1e: eeb0 9b40    	vmov.f64	d9, d0
   62e22: ed8d 0b7a    	vstr	d0, [sp, #488]
   62e26: 47a0         	blx	r4
   62e28: f105 0050    	add.w	r0, r5, #0x50
   62e2c: 210a         	movs	r1, #0xa
   62e2e: ed8d 0b7c    	vstr	d0, [sp, #496]
   62e32: 47a0         	blx	r4
   62e34: f105 00a0    	add.w	r0, r5, #0xa0
   62e38: 210a         	movs	r1, #0xa
   62e3a: ed8d 0b7e    	vstr	d0, [sp, #504]
   62e3e: 47a0         	blx	r4
   62e40: f8dd 6418    	ldr.w	r6, [sp, #0x418]
   62e44: 2000         	movs	r0, #0x0
   62e46: ed8d 0b80    	vstr	d0, [sp, #512]
   62e4a: a982         	add	r1, sp, #0x208
   62e4c: ee00 6a10    	vmov	s0, r6
   62e50: eeb8 db40    	vcvt.f64.u32	d13, s0
   62e54: 2830         	cmp	r0, #0x30
   62e56: d00a         	beq	0x62e6e <air1_opcal4_algorithm+0x1786> @ imm = #0x14
   62e58: 180b         	adds	r3, r1, r0
   62e5a: eb0a 0200    	add.w	r2, r10, r0
   62e5e: 3008         	adds	r0, #0x8
   62e60: edd3 0b00    	vldr	d16, [r3]
   62e64: ee70 0bcd    	vsub.f64	d16, d16, d13
   62e68: edc2 0b00    	vstr	d16, [r2]
   62e6c: e7f2         	b	0x62e54 <air1_opcal4_algorithm+0x176c> @ imm = #-0x1c
   62e6e: 985b         	ldr	r0, [sp, #0x16c]
   62e70: 2105         	movs	r1, #0x5
   62e72: eddf 1b7d    	vldr	d17, [pc, #500]         @ 0x63068 <air1_opcal4_algorithm+0x1980>
   62e76: ee00 0a10    	vmov	s0, r0
   62e7a: eef8 0b40    	vcvt.f64.u32	d16, s0
   62e7e: eec0 0ba1    	vdiv.f64	d16, d16, d17
   62e82: eef9 1b0c    	vmov.f64	d17, #-7.000000e+00
   62e86: ee70 0ba1    	vadd.f64	d16, d16, d17
   62e8a: eebc ebe0    	vcvt.u32.f64	s28, d16
   62e8e: ee1e 4a10    	vmov	r4, s28
   62e92: b2e0         	uxtb	r0, r4
   62e94: f00b ee10    	blx	0x6eab8 <__udivsi3>     @ imm = #0xbc20
   62e98: eb00 0180    	add.w	r1, r0, r0, lsl #2
   62e9c: eddf 1b74    	vldr	d17, [pc, #464]         @ 0x63070 <air1_opcal4_algorithm+0x1988>
   62ea0: 1a61         	subs	r1, r4, r1
   62ea2: eddd 0b6e    	vldr	d16, [sp, #440]
   62ea6: eddd 2b70    	vldr	d18, [sp, #448]
   62eaa: 0609         	lsls	r1, r1, #0x18
   62eac: eddf 4b72    	vldr	d20, [pc, #456]         @ 0x63078 <air1_opcal4_algorithm+0x1990>
   62eb0: d00d         	beq	0x62ece <air1_opcal4_algorithm+0x17e6> @ imm = #0x1a
   62eb2: eef8 3b4e    	vcvt.f64.u32	d19, s28
   62eb6: eef1 5b04    	vmov.f64	d21, #5.000000e+00
   62eba: eec3 3ba5    	vdiv.f64	d19, d19, d21
   62ebe: eef7 5b00    	vmov.f64	d21, #1.000000e+00
   62ec2: ee73 3ba5    	vadd.f64	d19, d19, d21
   62ec6: eebc 0be3    	vcvt.u32.f64	s0, d19
   62eca: ee10 0a10    	vmov	r0, s0
   62ece: ee72 3ba1    	vadd.f64	d19, d18, d17
   62ed2: b2c4         	uxtb	r4, r0
   62ed4: 2c01         	cmp	r4, #0x1
   62ed6: ee70 1ba4    	vadd.f64	d17, d16, d20
   62eda: d01b         	beq	0x62f14 <air1_opcal4_algorithm+0x182c> @ imm = #0x36
   62edc: eddf 2b68    	vldr	d18, [pc, #416]         @ 0x63080 <air1_opcal4_algorithm+0x1998>
   62ee0: 2c02         	cmp	r4, #0x2
   62ee2: d13a         	bne	0x62f5a <air1_opcal4_algorithm+0x1872> @ imm = #0x74
   62ee4: ee73 2ba2    	vadd.f64	d18, d19, d18
   62ee8: f108 03f0    	add.w	r3, r8, #0xf0
   62eec: 2100         	movs	r1, #0x0
   62eee: efc0 3010    	vmov.i32	d19, #0x0
   62ef2: eef2 4b04    	vmov.f64	d20, #1.000000e+01
   62ef6: eef7 5b00    	vmov.f64	d21, #1.000000e+00
   62efa: 29f0         	cmp	r1, #0xf0
   62efc: d045         	beq	0x62f8a <air1_opcal4_algorithm+0x18a2> @ imm = #0x8a
   62efe: eef0 6b62    	vmov.f64	d22, d18
   62f02: 185a         	adds	r2, r3, r1
   62f04: 3108         	adds	r1, #0x8
   62f06: ee43 6ba4    	vmla.f64	d22, d19, d20
   62f0a: ee73 3ba5    	vadd.f64	d19, d19, d21
   62f0e: edc2 6b00    	vstr	d22, [r2]
   62f12: e7f2         	b	0x62efa <air1_opcal4_algorithm+0x1812> @ imm = #-0x1c
   62f14: eddf 2b5c    	vldr	d18, [pc, #368]         @ 0x63088 <air1_opcal4_algorithm+0x19a0>
   62f18: f50d 6267    	add.w	r2, sp, #0xe70
   62f1c: ee73 2ba2    	vadd.f64	d18, d19, d18
   62f20: eef4 1b62    	vcmp.f64	d17, d18
   62f24: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62f28: bfc8         	it	gt
   62f2a: eef0 2b61    	vmovgt.f64	d18, d17
   62f2e: ee73 1be2    	vsub.f64	d17, d19, d18
   62f32: 2101         	movs	r1, #0x1
   62f34: eef3 3b0e    	vmov.f64	d19, #3.000000e+01
   62f38: eec1 1ba3    	vdiv.f64	d17, d17, d19
   62f3c: 291f         	cmp	r1, #0x1f
   62f3e: f000 80b3    	beq.w	0x630a8 <air1_opcal4_algorithm+0x19c0> @ imm = #0x166
   62f42: ee00 1a10    	vmov	s0, r1
   62f46: 3101         	adds	r1, #0x1
   62f48: eef0 4b62    	vmov.f64	d20, d18
   62f4c: eef8 3bc0    	vcvt.f64.s32	d19, s0
   62f50: ee41 4ba3    	vmla.f64	d20, d17, d19
   62f54: ece2 4b02    	vstmia	r2!, {d20}
   62f58: e7f0         	b	0x62f3c <air1_opcal4_algorithm+0x1854> @ imm = #-0x20
   62f5a: ee73 4ba2    	vadd.f64	d20, d19, d18
   62f5e: f508 73f0    	add.w	r3, r8, #0x1e0
   62f62: 2100         	movs	r1, #0x0
   62f64: eef2 2b04    	vmov.f64	d18, #1.000000e+01
   62f68: eef7 3b00    	vmov.f64	d19, #1.000000e+00
   62f6c: efc0 5010    	vmov.i32	d21, #0x0
   62f70: 29f0         	cmp	r1, #0xf0
   62f72: d034         	beq	0x62fde <air1_opcal4_algorithm+0x18f6> @ imm = #0x68
   62f74: eef0 6b64    	vmov.f64	d22, d20
   62f78: 185a         	adds	r2, r3, r1
   62f7a: 3108         	adds	r1, #0x8
   62f7c: ee45 6ba2    	vmla.f64	d22, d21, d18
   62f80: edc2 6b00    	vstr	d22, [r2]
   62f84: ee75 5ba3    	vadd.f64	d21, d21, d19
   62f88: e7f2         	b	0x62f70 <air1_opcal4_algorithm+0x1888> @ imm = #-0x1c
   62f8a: f50d 6140    	add.w	r1, sp, #0xc00
   62f8e: eefa 2b04    	vmov.f64	d18, #-1.000000e+01
   62f92: f50d 6267    	add.w	r2, sp, #0xe70
   62f96: edd1 3bd8    	vldr	d19, [r1, #864]
   62f9a: ee73 4ba2    	vadd.f64	d20, d19, d18
   62f9e: eddf 2b3a    	vldr	d18, [pc, #232]         @ 0x63088 <air1_opcal4_algorithm+0x19a0>
   62fa2: ee73 2ba2    	vadd.f64	d18, d19, d18
   62fa6: eef4 1b62    	vcmp.f64	d17, d18
   62faa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   62fae: bfc8         	it	gt
   62fb0: eef0 2b61    	vmovgt.f64	d18, d17
   62fb4: ee74 1be2    	vsub.f64	d17, d20, d18
   62fb8: 2101         	movs	r1, #0x1
   62fba: eef3 3b0e    	vmov.f64	d19, #3.000000e+01
   62fbe: eec1 1ba3    	vdiv.f64	d17, d17, d19
   62fc2: 291f         	cmp	r1, #0x1f
   62fc4: d070         	beq	0x630a8 <air1_opcal4_algorithm+0x19c0> @ imm = #0xe0
   62fc6: ee00 1a10    	vmov	s0, r1
   62fca: 3101         	adds	r1, #0x1
   62fcc: eef0 4b62    	vmov.f64	d20, d18
   62fd0: eef8 3bc0    	vcvt.f64.s32	d19, s0
   62fd4: ee41 4ba3    	vmla.f64	d20, d17, d19
   62fd8: ece2 4b02    	vstmia	r2!, {d20}
   62fdc: e7f1         	b	0x62fc2 <air1_opcal4_algorithm+0x18da> @ imm = #-0x1e
   62fde: efc0 5010    	vmov.i32	d21, #0x0
   62fe2: f108 03f0    	add.w	r3, r8, #0xf0
   62fe6: eddf 4b28    	vldr	d20, [pc, #160]         @ 0x63088 <air1_opcal4_algorithm+0x19a0>
   62fea: 2100         	movs	r1, #0x0
   62fec: 29f0         	cmp	r1, #0xf0
   62fee: d00e         	beq	0x6300e <air1_opcal4_algorithm+0x1926> @ imm = #0x1c
   62ff0: f50d 5280    	add.w	r2, sp, #0x1000
   62ff4: edd2 6b14    	vldr	d22, [r2, #80]
   62ff8: 185a         	adds	r2, r3, r1
   62ffa: 3108         	adds	r1, #0x8
   62ffc: ee76 6ba4    	vadd.f64	d22, d22, d20
   63000: ee45 6ba2    	vmla.f64	d22, d21, d18
   63004: edc2 6b00    	vstr	d22, [r2]
   63008: ee75 5ba3    	vadd.f64	d21, d21, d19
   6300c: e7ee         	b	0x62fec <air1_opcal4_algorithm+0x1904> @ imm = #-0x24
   6300e: f50d 6140    	add.w	r1, sp, #0xc00
   63012: eefa 2b04    	vmov.f64	d18, #-1.000000e+01
   63016: f50d 6267    	add.w	r2, sp, #0xe70
   6301a: edd1 3bd8    	vldr	d19, [r1, #864]
   6301e: ee73 5ba2    	vadd.f64	d21, d19, d18
   63022: ee73 2ba4    	vadd.f64	d18, d19, d20
   63026: eef4 1b62    	vcmp.f64	d17, d18
   6302a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6302e: bfc8         	it	gt
   63030: eef0 2b61    	vmovgt.f64	d18, d17
   63034: ee75 1be2    	vsub.f64	d17, d21, d18
   63038: 2101         	movs	r1, #0x1
   6303a: eef3 3b0e    	vmov.f64	d19, #3.000000e+01
   6303e: eec1 1ba3    	vdiv.f64	d17, d17, d19
   63042: 291f         	cmp	r1, #0x1f
   63044: d030         	beq	0x630a8 <air1_opcal4_algorithm+0x19c0> @ imm = #0x60
   63046: ee00 1a10    	vmov	s0, r1
   6304a: 3101         	adds	r1, #0x1
   6304c: eef0 4b62    	vmov.f64	d20, d18
   63050: eef8 3bc0    	vcvt.f64.s32	d19, s0
   63054: ee41 4ba3    	vmla.f64	d20, d17, d19
   63058: ece2 4b02    	vstmia	r2!, {d20}
   6305c: e7f1         	b	0x63042 <air1_opcal4_algorithm+0x195a> @ imm = #-0x1e
   6305e: bf00         	nop
   63060: d4 fe ff ff  	.word	0xfffffed4
   63064: a7 98 00 00  	.word	0x000098a7
   63068: 00 00 00 00  	.word	0x00000000
   6306c: 00 00 4e 40  	.word	0x404e0000
   63070: 00 00 00 00  	.word	0x00000000
   63074: 00 00 49 c0  	.word	0xc0490000
   63078: 00 00 00 00  	.word	0x00000000
   6307c: 00 00 49 40  	.word	0x40490000
   63080: 00 00 00 00  	.word	0x00000000
   63084: 00 20 72 c0  	.word	0xc0722000
   63088: 00 00 00 00  	.word	0x00000000
   6308c: 00 c0 72 c0  	.word	0xc072c000
   63090: 00 00 00 00  	.word	0x00000000
   63094: 00 00 f8 7f  	.word	0x7ff80000
   63098: 00 00 00 00  	.word	0x00000000
   6309c: 00 00 59 40  	.word	0x40590000
   630a0: 17 f4 de 18  	.word	0x18def417
   630a4: 02 00 e0 3f  	.word	0x3fe00002
   630a8: efc0 2050    	vmov.i32	q9, #0x0
   630ac: f50d 6ebb    	add.w	lr, sp, #0x5d8
   630b0: 9057         	str	r0, [sp, #0x15c]
   630b2: 2100         	movs	r1, #0x0
   630b4: 4670         	mov	r0, lr
   630b6: f50d 68b0    	add.w	r8, sp, #0x580
   630ba: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   630be: f50d 6bab    	add.w	r11, sp, #0x558
   630c2: f50d 69a6    	add.w	r9, sp, #0x530
   630c6: f50d 65a1    	add.w	r5, sp, #0x508
   630ca: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   630ce: 6001         	str	r1, [r0]
   630d0: f50d 60b5    	add.w	r0, sp, #0x5a8
   630d4: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   630d8: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   630dc: 6001         	str	r1, [r0]
   630de: 4640         	mov	r0, r8
   630e0: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   630e4: 945e         	str	r4, [sp, #0x178]
   630e6: f10b 0408    	add.w	r4, r11, #0x8
   630ea: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   630ee: 6001         	str	r1, [r0]
   630f0: 4620         	mov	r0, r4
   630f2: f940 2acd    	vst1.64	{d18, d19}, [r0]!
   630f6: f940 2acf    	vst1.64	{d18, d19}, [r0]
   630fa: f109 0008    	add.w	r0, r9, #0x8
   630fe: 4602         	mov	r2, r0
   63100: f8cd 15fc    	str.w	r1, [sp, #0x5fc]
   63104: f942 2acd    	vst1.64	{d18, d19}, [r2]!
   63108: f942 2acf    	vst1.64	{d18, d19}, [r2]
   6310c: 462a         	mov	r2, r5
   6310e: f942 2acd    	vst1.64	{d18, d19}, [r2]!
   63112: f942 2acd    	vst1.64	{d18, d19}, [r2]!
   63116: f8cd 15cc    	str.w	r1, [sp, #0x5cc]
   6311a: f8cd 15a4    	str.w	r1, [sp, #0x5a4]
   6311e: 6011         	str	r1, [r2]
   63120: f8cd 152c    	str.w	r1, [sp, #0x52c]
   63124: 2928         	cmp	r1, #0x28
   63126: d00a         	beq	0x6313e <air1_opcal4_algorithm+0x1a56> @ imm = #0x14
   63128: eb0a 0301    	add.w	r3, r10, r1
   6312c: 186a         	adds	r2, r5, r1
   6312e: 3108         	adds	r1, #0x8
   63130: ecf3 1b04    	vldmia	r3!, {d17, d18}
   63134: ee72 1be1    	vsub.f64	d17, d18, d17
   63138: edc2 1b00    	vstr	d17, [r2]
   6313c: e7f2         	b	0x63124 <air1_opcal4_algorithm+0x1a3c> @ imm = #-0x1c
   6313e: 2100         	movs	r1, #0x0
   63140: eef0 1b08    	vmov.f64	d17, #3.000000e+00
   63144: f8cd 155c    	str.w	r1, [sp, #0x55c]
   63148: f105 0208    	add.w	r2, r5, #0x8
   6314c: f8cd 1558    	str.w	r1, [sp, #0x558]
   63150: f10a 0c10    	add.w	r12, r10, #0x10
   63154: f8cd 1534    	str.w	r1, [sp, #0x534]
   63158: f8cd 1530    	str.w	r1, [sp, #0x530]
   6315c: efc0 2010    	vmov.i32	d18, #0x0
   63160: f8cd 15d4    	str.w	r1, [sp, #0x5d4]
   63164: efc0 3010    	vmov.i32	d19, #0x0
   63168: f8cd 15d0    	str.w	r1, [sp, #0x5d0]
   6316c: ab76         	add	r3, sp, #0x1d8
   6316e: f103 0a10    	add.w	r10, r3, #0x10
   63172: 2920         	cmp	r1, #0x20
   63174: d034         	beq	0x631e0 <air1_opcal4_algorithm+0x1af8> @ imm = #0x68
   63176: eb0c 0301    	add.w	r3, r12, r1
   6317a: edd3 4b00    	vldr	d20, [r3]
   6317e: ed53 5b04    	vldr	d21, [r3, #-16]
   63182: 1853         	adds	r3, r2, r1
   63184: ee74 4ba4    	vadd.f64	d20, d20, d20
   63188: ee74 4be5    	vsub.f64	d20, d20, d21
   6318c: ed53 5b02    	vldr	d21, [r3, #-8]
   63190: edd3 6b00    	vldr	d22, [r3]
   63194: 1863         	adds	r3, r4, r1
   63196: ee45 4be3    	vmls.f64	d20, d21, d19
   6319a: eec6 3ba4    	vdiv.f64	d19, d22, d20
   6319e: edc3 3b00    	vstr	d19, [r3]
   631a2: eb0a 0301    	add.w	r3, r10, r1
   631a6: ed53 8b04    	vldr	d24, [r3, #-16]
   631aa: edd3 7b00    	vldr	d23, [r3]
   631ae: 1843         	adds	r3, r0, r1
   631b0: ee7b 8b68    	vsub.f64	d24, d11, d24
   631b4: 3108         	adds	r1, #0x8
   631b6: ee77 9bcb    	vsub.f64	d25, d23, d11
   631ba: ee68 8ba1    	vmul.f64	d24, d24, d17
   631be: ee69 9ba1    	vmul.f64	d25, d25, d17
   631c2: eec8 8ba5    	vdiv.f64	d24, d24, d21
   631c6: eec9 6ba6    	vdiv.f64	d22, d25, d22
   631ca: ee76 6be8    	vsub.f64	d22, d22, d24
   631ce: ee45 6be2    	vmls.f64	d22, d21, d18
   631d2: eeb0 bb67    	vmov.f64	d11, d23
   631d6: eec6 2ba4    	vdiv.f64	d18, d22, d20
   631da: edc3 2b00    	vstr	d18, [r3]
   631de: e7c8         	b	0x63172 <air1_opcal4_algorithm+0x1a8a> @ imm = #-0x70
   631e0: f50d 60b5    	add.w	r0, sp, #0x5a8
   631e4: a976         	add	r1, sp, #0x1d8
   631e6: 3008         	adds	r0, #0x8
   631e8: 3108         	adds	r1, #0x8
   631ea: 2200         	movs	r2, #0x0
   631ec: 2a28         	cmp	r2, #0x28
   631ee: d034         	beq	0x6325a <air1_opcal4_algorithm+0x1b72> @ imm = #0x68
   631f0: eb0b 0402    	add.w	r4, r11, r2
   631f4: 1883         	adds	r3, r0, r2
   631f6: edd4 3b00    	vldr	d19, [r4]
   631fa: eb09 0402    	add.w	r4, r9, r2
   631fe: edd3 2b00    	vldr	d18, [r3]
   63202: edd4 4b00    	vldr	d20, [r4]
   63206: ee43 4be2    	vmls.f64	d20, d19, d18
   6320a: ed43 4b02    	vstr	d20, [r3, #-8]
   6320e: 18ab         	adds	r3, r5, r2
   63210: ee72 3be4    	vsub.f64	d19, d18, d20
   63214: edd3 5b00    	vldr	d21, [r3]
   63218: eb08 0302    	add.w	r3, r8, r2
   6321c: ee65 6ba1    	vmul.f64	d22, d21, d17
   63220: eec3 3ba6    	vdiv.f64	d19, d19, d22
   63224: edc3 3b00    	vstr	d19, [r3]
   63228: 188b         	adds	r3, r1, r2
   6322a: ee74 3ba4    	vadd.f64	d19, d20, d20
   6322e: ee73 2ba2    	vadd.f64	d18, d19, d18
   63232: ee62 2ba5    	vmul.f64	d18, d18, d21
   63236: edd3 3b00    	vldr	d19, [r3]
   6323a: eb0e 0302    	add.w	r3, lr, r2
   6323e: eec2 2ba1    	vdiv.f64	d18, d18, d17
   63242: 3208         	adds	r2, #0x8
   63244: ee73 4bca    	vsub.f64	d20, d19, d10
   63248: eec4 4ba5    	vdiv.f64	d20, d20, d21
   6324c: ee74 2be2    	vsub.f64	d18, d20, d18
   63250: edc3 2b00    	vstr	d18, [r3]
   63254: eeb0 ab63    	vmov.f64	d10, d19
   63258: e7c8         	b	0x631ec <air1_opcal4_algorithm+0x1b04> @ imm = #-0x70
   6325a: 9d5e         	ldr	r5, [sp, #0x178]
   6325c: f50d 62b2    	add.w	r2, sp, #0x590
   63260: f50d 6467    	add.w	r4, sp, #0xe70
   63264: f8dd a158    	ldr.w	r10, [sp, #0x158]
   63268: f50d 613a    	add.w	r1, sp, #0xba0
   6326c: edd2 1b00    	vldr	d17, [r2]
   63270: ebc5 1005    	rsb	r0, r5, r5, lsl #4
   63274: edd2 2b0a    	vldr	d18, [r2, #40]
   63278: edd2 3b16    	vldr	d19, [r2, #88]
   6327c: f50d 693a    	add.w	r9, sp, #0xba0
   63280: 0040         	lsls	r0, r0, #0x1
   63282: 4622         	mov	r2, r4
   63284: b1a8         	cbz	r0, 0x632b2 <air1_opcal4_algorithm+0x1bca> @ imm = #0x2a
   63286: ecf2 4b02    	vldmia	r2!, {d20}
   6328a: 3801         	subs	r0, #0x1
   6328c: eef0 5b49    	vmov.f64	d21, d9
   63290: ee74 4be0    	vsub.f64	d20, d20, d16
   63294: ee43 5ba4    	vmla.f64	d21, d19, d20
   63298: ee62 6ba4    	vmul.f64	d22, d18, d20
   6329c: ee46 5ba4    	vmla.f64	d21, d22, d20
   632a0: ee61 6ba4    	vmul.f64	d22, d17, d20
   632a4: ee64 6ba6    	vmul.f64	d22, d20, d22
   632a8: ee46 5ba4    	vmla.f64	d21, d22, d20
   632ac: ece1 5b02    	vstmia	r1!, {d21}
   632b0: e7e8         	b	0x63284 <air1_opcal4_algorithm+0x1b9c> @ imm = #-0x30
   632b2: f8ba 0058    	ldrh.w	r0, [r10, #0x58]
   632b6: f105 0801    	add.w	r8, r5, #0x1
   632ba: 9958         	ldr	r1, [sp, #0x160]
   632bc: aa60         	add	r2, sp, #0x180
   632be: 4408         	add	r0, r1
   632c0: 2100         	movs	r1, #0x0
   632c2: 4588         	cmp	r8, r1
   632c4: d004         	beq	0x632d0 <air1_opcal4_algorithm+0x1be8> @ imm = #0x8
   632c6: 1843         	adds	r3, r0, r1
   632c8: f822 3011    	strh.w	r3, [r2, r1, lsl #1]
   632cc: 3101         	adds	r1, #0x1
   632ce: e7f8         	b	0x632c2 <air1_opcal4_algorithm+0x1bda> @ imm = #-0x10
   632d0: 985b         	ldr	r0, [sp, #0x16c]
   632d2: 9955         	ldr	r1, [sp, #0x154]
   632d4: f00b ed18    	blx	0x6ed08 <__floatdidf>   @ imm = #0xba30
   632d8: ec41 0b30    	vmov	d16, r0, r1
   632dc: 9859         	ldr	r0, [sp, #0x164]
   632de: f104 0be8    	add.w	r11, r4, #0xe8
   632e2: 462c         	mov	r4, r5
   632e4: ee8c 9b20    	vdiv.f64	d9, d12, d16
   632e8: ad62         	add	r5, sp, #0x188
   632ea: ee00 0a10    	vmov	s0, r0
   632ee: ed1f bb98    	vldr	d11, [pc, #-608]        @ 0x63090 <air1_opcal4_algorithm+0x19a8>
   632f2: ed1f cb97    	vldr	d12, [pc, #-604]        @ 0x63098 <air1_opcal4_algorithm+0x19b0>
   632f6: eeb8 ab40    	vcvt.f64.u32	d10, s0
   632fa: ed1f eb97    	vldr	d14, [pc, #-604]        @ 0x630a0 <air1_opcal4_algorithm+0x19b8>
   632fe: b314         	cbz	r4, 0x63346 <air1_opcal4_algorithm+0x1c5e> @ imm = #0x44
   63300: ed9b 0b00    	vldr	d0, [r11]
   63304: f009 fa28    	bl	0x6c758 <math_round>    @ imm = #0x9450
   63308: ee70 0b0d    	vadd.f64	d16, d0, d13
   6330c: ee70 1bca    	vsub.f64	d17, d16, d10
   63310: eef0 0b48    	vmov.f64	d16, d8
   63314: ee49 0b21    	vmla.f64	d16, d9, d17
   63318: ef6b 111b    	vorr	d17, d11, d11
   6331c: eef4 0b60    	vcmp.f64	d16, d16
   63320: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63324: d609         	bvs	0x6333a <air1_opcal4_algorithm+0x1c52> @ imm = #0x12
   63326: ef6e 111e    	vorr	d17, d14, d14
   6332a: ee40 1b8c    	vmla.f64	d17, d16, d12
   6332e: eebd 0be1    	vcvt.s32.f64	s0, d17
   63332: eef8 0bc0    	vcvt.f64.s32	d16, s0
   63336: eec0 1b8c    	vdiv.f64	d17, d16, d12
   6333a: ece5 1b02    	vstmia	r5!, {d17}
   6333e: 3c01         	subs	r4, #0x1
   63340: f10b 0bf0    	add.w	r11, r11, #0xf0
   63344: e7db         	b	0x632fe <air1_opcal4_algorithm+0x1c16> @ imm = #-0x4a
   63346: f8dd b15c    	ldr.w	r11, [sp, #0x15c]
   6334a: eeb7 eb08    	vmov.f64	d14, #1.500000e+00
   6334e: 9954         	ldr	r1, [sp, #0x150]
   63350: f10b 0001    	add.w	r0, r11, #0x1
   63354: f881 0310    	strb.w	r0, [r1, #0x310]
   63358: f101 0008    	add.w	r0, r1, #0x8
   6335c: a960         	add	r1, sp, #0x180
   6335e: 9b5f         	ldr	r3, [sp, #0x17c]
   63360: f1b8 0f00    	cmp.w	r8, #0x0
   63364: d009         	beq	0x6337a <air1_opcal4_algorithm+0x1c92> @ imm = #0x12
   63366: f831 2b02    	ldrh	r2, [r1], #2
   6336a: f1a8 0801    	sub.w	r8, r8, #0x1
   6336e: f820 2c08    	strh	r2, [r0, #-8]
   63372: 881a         	ldrh	r2, [r3]
   63374: f820 2b02    	strh	r2, [r0], #2
   63378: e7f2         	b	0x63360 <air1_opcal4_algorithm+0x1c78> @ imm = #-0x1c
   6337a: 9854         	ldr	r0, [sp, #0x150]
   6337c: eef6 0b00    	vmov.f64	d16, #5.000000e-01
   63380: f50d 6c67    	add.w	r12, sp, #0xe70
   63384: f8dd 8168    	ldr.w	r8, [sp, #0x168]
   63388: f500 7188    	add.w	r1, r0, #0x110
   6338c: f100 0220    	add.w	r2, r0, #0x20
   63390: f50d 643a    	add.w	r4, sp, #0xba0
   63394: f04f 0e00    	mov.w	lr, #0x0
   63398: 4665         	mov	r5, r12
   6339a: 985e         	ldr	r0, [sp, #0x178]
   6339c: 4586         	cmp	lr, r0
   6339e: d021         	beq	0x633e4 <air1_opcal4_algorithm+0x1cfc> @ imm = #0x42
   633a0: 2000         	movs	r0, #0x0
   633a2: 28f0         	cmp	r0, #0xf0
   633a4: d017         	beq	0x633d6 <air1_opcal4_algorithm+0x1cee> @ imm = #0x2e
   633a6: 1823         	adds	r3, r4, r0
   633a8: edd3 1b00    	vldr	d17, [r3]
   633ac: ee71 1ba0    	vadd.f64	d17, d17, d16
   633b0: eebc 0be1    	vcvt.u32.f64	s0, d17
   633b4: ee10 3a10    	vmov	r3, s0
   633b8: 5213         	strh	r3, [r2, r0]
   633ba: 182b         	adds	r3, r5, r0
   633bc: edd3 1b00    	vldr	d17, [r3]
   633c0: ee71 1ba0    	vadd.f64	d17, d17, d16
   633c4: eebc 0be1    	vcvt.u32.f64	s0, d17
   633c8: ee10 3a10    	vmov	r3, s0
   633cc: 4433         	add	r3, r6
   633ce: f841 3010    	str.w	r3, [r1, r0, lsl #1]
   633d2: 3008         	adds	r0, #0x8
   633d4: e7e5         	b	0x633a2 <air1_opcal4_algorithm+0x1cba> @ imm = #-0x36
   633d6: 34f0         	adds	r4, #0xf0
   633d8: 35f0         	adds	r5, #0xf0
   633da: 3202         	adds	r2, #0x2
   633dc: 3104         	adds	r1, #0x4
   633de: f10e 0e01    	add.w	lr, lr, #0x1
   633e2: e7da         	b	0x6339a <air1_opcal4_algorithm+0x1cb2> @ imm = #-0x4c
   633e4: 9d5e         	ldr	r5, [sp, #0x178]
   633e6: 9954         	ldr	r1, [sp, #0x150]
   633e8: 9c5d         	ldr	r4, [sp, #0x174]
   633ea: eb01 0045    	add.w	r0, r1, r5, lsl #1
   633ee: eb01 0e85    	add.w	lr, r1, r5, lsl #2
   633f2: f100 0220    	add.w	r2, r0, #0x20
   633f6: f50e 7388    	add.w	r3, lr, #0x110
   633fa: 49e5         	ldr	r1, [pc, #0x394]        @ 0x63790 <air1_opcal4_algorithm+0x20a8>
   633fc: b161         	cbz	r1, 0x63418 <air1_opcal4_algorithm+0x1d30> @ imm = #0x18
   633fe: f834 0b02    	ldrh	r0, [r4], #2
   63402: f822 0b08    	strh	r0, [r2], #8
   63406: 985f         	ldr	r0, [sp, #0x17c]
   63408: f8d0 0002    	ldr.w	r0, [r0, #0x2]
   6340c: 4408         	add	r0, r1
   6340e: 310a         	adds	r1, #0xa
   63410: 300a         	adds	r0, #0xa
   63412: f843 0b10    	str	r0, [r3], #16
   63416: e7f1         	b	0x633fc <air1_opcal4_algorithm+0x1d14> @ imm = #-0x1e
   63418: 9854         	ldr	r0, [sp, #0x150]
   6341a: ac62         	add	r4, sp, #0x188
   6341c: f500 723c    	add.w	r2, r0, #0x2f0
   63420: f100 0310    	add.w	r3, r0, #0x10
   63424: f10c 00e8    	add.w	r0, r12, #0xe8
   63428: b195         	cbz	r5, 0x63450 <air1_opcal4_algorithm+0x1d68> @ imm = #0x24
   6342a: ecf4 1b02    	vldmia	r4!, {d17}
   6342e: 3d01         	subs	r5, #0x1
   63430: f942 174f    	vst1.16	{d17}, [r2]
   63434: 3208         	adds	r2, #0x8
   63436: edd0 1b00    	vldr	d17, [r0]
   6343a: 30f0         	adds	r0, #0xf0
   6343c: ee71 1ba0    	vadd.f64	d17, d17, d16
   63440: eebc 0be1    	vcvt.u32.f64	s0, d17
   63444: ee10 1a10    	vmov	r1, s0
   63448: 4431         	add	r1, r6
   6344a: f843 1b04    	str	r1, [r3], #4
   6344e: e7eb         	b	0x63428 <air1_opcal4_algorithm+0x1d40> @ imm = #-0x2a
   63450: f8dd c17c    	ldr.w	r12, [sp, #0x17c]
   63454: 995e         	ldr	r1, [sp, #0x178]
   63456: 9e5d         	ldr	r6, [sp, #0x174]
   63458: f8dc 0002    	ldr.w	r0, [r12, #0x2]
   6345c: f8ce 0010    	str.w	r0, [lr, #0x10]
   63460: 9854         	ldr	r0, [sp, #0x150]
   63462: f968 070f    	vld1.8	{d16}, [r8]
   63466: eb00 00c1    	add.w	r0, r0, r1, lsl #3
   6346a: f500 703c    	add.w	r0, r0, #0x2f0
   6346e: 9d53         	ldr	r5, [sp, #0x14c]
   63470: f940 074f    	vst1.16	{d16}, [r0]
   63474: f8ba 0058    	ldrh.w	r0, [r10, #0x58]
   63478: fa50 f08b    	uxtab	r0, r0, r11
   6347c: f50d 6b0d    	add.w	r11, sp, #0x8d0
   63480: f8aa 0058    	strh.w	r0, [r10, #0x58]
   63484: 2000         	movs	r0, #0x0
   63486: 281e         	cmp	r0, #0x1e
   63488: d006         	beq	0x63498 <air1_opcal4_algorithm+0x1db0> @ imm = #0xc
   6348a: f836 1010    	ldrh.w	r1, [r6, r0, lsl #1]
   6348e: eb0a 0240    	add.w	r2, r10, r0, lsl #1
   63492: 3001         	adds	r0, #0x1
   63494: 8251         	strh	r1, [r2, #0x12]
   63496: e7f6         	b	0x63486 <air1_opcal4_algorithm+0x1d9e> @ imm = #-0x14
   63498: f8bc 0000    	ldrh.w	r0, [r12]
   6349c: f50d 6e67    	add.w	lr, sp, #0xe70
   634a0: f8aa 0010    	strh.w	r0, [r10, #0x10]
   634a4: eeb2 ab04    	vmov.f64	d10, #1.000000e+01
   634a8: f8dc 0002    	ldr.w	r0, [r12, #0x2]
   634ac: 2200         	movs	r2, #0x0
   634ae: f8ca 000c    	str.w	r0, [r10, #0xc]
   634b2: f244 20ec    	movw	r0, #0x42ec
   634b6: 4450         	add	r0, r10
   634b8: 900e         	str	r0, [sp, #0x38]
   634ba: f244 2090    	movw	r0, #0x4290
   634be: f968 070f    	vld1.8	{d16}, [r8]
   634c2: 4450         	add	r0, r10
   634c4: ef80 8050    	vmov.i32	q4, #0x0
   634c8: 9023         	str	r0, [sp, #0x8c]
   634ca: f244 2088    	movw	r0, #0x4288
   634ce: 4450         	add	r0, r10
   634d0: 9022         	str	r0, [sp, #0x88]
   634d2: f642 4078    	movw	r0, #0x2c78
   634d6: 9946         	ldr	r1, [sp, #0x118]
   634d8: 4450         	add	r0, r10
   634da: 9021         	str	r0, [sp, #0x84]
   634dc: f642 40b0    	movw	r0, #0x2cb0
   634e0: ed9f dbad    	vldr	d13, [pc, #692]         @ 0x63798 <air1_opcal4_algorithm+0x20b0>
   634e4: 4450         	add	r0, r10
   634e6: 9020         	str	r0, [sp, #0x80]
   634e8: f642 5020    	movw	r0, #0x2d20
   634ec: f50a 6476    	add.w	r4, r10, #0xf60
   634f0: 4450         	add	r0, r10
   634f2: 901f         	str	r0, [sp, #0x7c]
   634f4: f642 5028    	movw	r0, #0x2d28
   634f8: edca 0b14    	vstr	d16, [r10, #80]
   634fc: 4450         	add	r0, r10
   634fe: 901e         	str	r0, [sp, #0x78]
   63500: f642 50f8    	movw	r0, #0x2df8
   63504: 9411         	str	r4, [sp, #0x44]
   63506: 4450         	add	r0, r10
   63508: 900d         	str	r0, [sp, #0x34]
   6350a: f244 2008    	movw	r0, #0x4208
   6350e: 4450         	add	r0, r10
   63510: 9007         	str	r0, [sp, #0x1c]
   63512: f642 30d8    	movw	r0, #0x2bd8
   63516: 4450         	add	r0, r10
   63518: 9010         	str	r0, [sp, #0x40]
   6351a: f642 4038    	movw	r0, #0x2c38
   6351e: 4450         	add	r0, r10
   63520: 9009         	str	r0, [sp, #0x24]
   63522: f642 4014    	movw	r0, #0x2c14
   63526: 4450         	add	r0, r10
   63528: 900b         	str	r0, [sp, #0x2c]
   6352a: f642 4039    	movw	r0, #0x2c39
   6352e: 4450         	add	r0, r10
   63530: 901d         	str	r0, [sp, #0x74]
   63532: f642 4010    	movw	r0, #0x2c10
   63536: 4450         	add	r0, r10
   63538: 901c         	str	r0, [sp, #0x70]
   6353a: f642 3078    	movw	r0, #0x2b78
   6353e: 4450         	add	r0, r10
   63540: 9031         	str	r0, [sp, #0xc4]
   63542: f642 3090    	movw	r0, #0x2b90
   63546: 4450         	add	r0, r10
   63548: 901b         	str	r0, [sp, #0x6c]
   6354a: f642 30a8    	movw	r0, #0x2ba8
   6354e: 4450         	add	r0, r10
   63550: 901a         	str	r0, [sp, #0x68]
   63552: f642 3018    	movw	r0, #0x2b18
   63556: 4450         	add	r0, r10
   63558: 9019         	str	r0, [sp, #0x64]
   6355a: f642 3020    	movw	r0, #0x2b20
   6355e: eb0a 0800    	add.w	r8, r10, r0
   63562: f246 00c8    	movw	r0, #0x60c8
   63566: f8cd 8060    	str.w	r8, [sp, #0x60]
   6356a: 4450         	add	r0, r10
   6356c: 9017         	str	r0, [sp, #0x5c]
   6356e: f245 20e0    	movw	r0, #0x52e0
   63572: 4450         	add	r0, r10
   63574: 9016         	str	r0, [sp, #0x58]
   63576: f642 6010    	movw	r0, #0x2e10
   6357a: 4450         	add	r0, r10
   6357c: 9006         	str	r0, [sp, #0x18]
   6357e: f642 5070    	movw	r0, #0x2d70
   63582: 4450         	add	r0, r10
   63584: 9040         	str	r0, [sp, #0x100]
   63586: f642 40e8    	movw	r0, #0x2ce8
   6358a: 4450         	add	r0, r10
   6358c: 903f         	str	r0, [sp, #0xfc]
   6358e: f642 20a8    	movw	r0, #0x2aa8
   63592: 4450         	add	r0, r10
   63594: 9005         	str	r0, [sp, #0x14]
   63596: 9854         	ldr	r0, [sp, #0x150]
   63598: f500 7388    	add.w	r3, r0, #0x110
   6359c: f100 0c20    	add.w	r12, r0, #0x20
   635a0: f50a 5031    	add.w	r0, r10, #0x2c40
   635a4: 9015         	str	r0, [sp, #0x54]
   635a6: f201 20bd    	addw	r0, r1, #0x2bd
   635aa: 9050         	str	r0, [sp, #0x140]
   635ac: f101 0064    	add.w	r0, r1, #0x64
   635b0: 9014         	str	r0, [sp, #0x50]
   635b2: f60a 40fe    	addw	r0, r10, #0xcfe
   635b6: 900f         	str	r0, [sp, #0x3c]
   635b8: f10e 0018    	add.w	r0, lr, #0x18
   635bc: 900c         	str	r0, [sp, #0x30]
   635be: f50a 502f    	add.w	r0, r10, #0x2bc0
   635c2: 9013         	str	r0, [sp, #0x4c]
   635c4: f60a 7068    	addw	r0, r10, #0xf68
   635c8: 9012         	str	r0, [sp, #0x48]
   635ca: f60a 7048    	addw	r0, r10, #0xf48
   635ce: 9002         	str	r0, [sp, #0x8]
   635d0: f60a 6058    	addw	r0, r10, #0xe58
   635d4: 9035         	str	r0, [sp, #0xd4]
   635d6: f60a 5068    	addw	r0, r10, #0xd68
   635da: f50d 613a    	add.w	r1, sp, #0xba0
   635de: 9034         	str	r0, [sp, #0xd0]
   635e0: f501 70f0    	add.w	r0, r1, #0x1e0
   635e4: 9051         	str	r0, [sp, #0x144]
   635e6: f50e 70f0    	add.w	r0, lr, #0x1e0
   635ea: 9001         	str	r0, [sp, #0x4]
   635ec: f60a 5038    	addw	r0, r10, #0xd38
   635f0: 905b         	str	r0, [sp, #0x16c]
   635f2: f50a 6056    	add.w	r0, r10, #0xd60
   635f6: 9055         	str	r0, [sp, #0x154]
   635f8: f101 0028    	add.w	r0, r1, #0x28
   635fc: 905a         	str	r0, [sp, #0x168]
   635fe: f10e 0028    	add.w	r0, lr, #0x28
   63602: 900a         	str	r0, [sp, #0x28]
   63604: f101 06f0    	add.w	r6, r1, #0xf0
   63608: 984f         	ldr	r0, [sp, #0x13c]
   6360a: 964c         	str	r6, [sp, #0x130]
   6360c: f100 0108    	add.w	r1, r0, #0x8
   63610: 9108         	str	r1, [sp, #0x20]
   63612: f10e 0110    	add.w	r1, lr, #0x10
   63616: 9159         	str	r1, [sp, #0x164]
   63618: f10e 0108    	add.w	r1, lr, #0x8
   6361c: 9158         	str	r1, [sp, #0x160]
   6361e: f105 0128    	add.w	r1, r5, #0x28
   63622: 9104         	str	r1, [sp, #0x10]
   63624: f505 719c    	add.w	r1, r5, #0x138
   63628: 30b0         	adds	r0, #0xb0
   6362a: 9100         	str	r1, [sp]
   6362c: 9003         	str	r0, [sp, #0xc]
   6362e: 9854         	ldr	r0, [sp, #0x150]
   63630: f890 0310    	ldrb.w	r0, [r0, #0x310]
   63634: 4282         	cmp	r2, r0
   63636: f4bf a86b    	bhs.w	0x62710 <air1_opcal4_algorithm+0x1028> @ imm = #-0xf2a
   6363a: 4c59         	ldr	r4, [pc, #0x164]        @ 0x637a0 <air1_opcal4_algorithm+0x20b8>
   6363c: f640 01a8    	movw	r1, #0x8a8
   63640: 9d45         	ldr	r5, [sp, #0x114]
   63642: 4616         	mov	r6, r2
   63644: 447c         	add	r4, pc
   63646: 9344         	str	r3, [sp, #0x110]
   63648: f8cd c12c    	str.w	r12, [sp, #0x12c]
   6364c: 4620         	mov	r0, r4
   6364e: 47a8         	blx	r5
   63650: 4854         	ldr	r0, [pc, #0x150]        @ 0x637a4 <air1_opcal4_algorithm+0x20bc>
   63652: 219b         	movs	r1, #0x9b
   63654: 4478         	add	r0, pc
   63656: 905d         	str	r0, [sp, #0x174]
   63658: 47a8         	blx	r5
   6365a: 4853         	ldr	r0, [pc, #0x14c]        @ 0x637a8 <air1_opcal4_algorithm+0x20c0>
   6365c: f240 612b    	movw	r1, #0x62b
   63660: 4478         	add	r0, pc
   63662: 905e         	str	r0, [sp, #0x178]
   63664: 47a8         	blx	r5
   63666: 9954         	ldr	r1, [sp, #0x150]
   63668: 9b4b         	ldr	r3, [sp, #0x12c]
   6366a: eb01 0246    	add.w	r2, r1, r6, lsl #1
   6366e: 9d44         	ldr	r5, [sp, #0x110]
   63670: f831 0016    	ldrh.w	r0, [r1, r6, lsl #1]
   63674: 9643         	str	r6, [sp, #0x10c]
   63676: 8020         	strh	r0, [r4]
   63678: f832 0f08    	ldrh	r0, [r2, #8]!
   6367c: 923e         	str	r2, [sp, #0xf8]
   6367e: eb01 0286    	add.w	r2, r1, r6, lsl #2
   63682: 8060         	strh	r0, [r4, #0x2]
   63684: f852 0f10    	ldr	r0, [r2, #16]!
   63688: 6060         	str	r0, [r4, #0x4]
   6368a: eb01 00c6    	add.w	r0, r1, r6, lsl #3
   6368e: f500 703c    	add.w	r0, r0, #0x2f0
   63692: e9dd 6c3f    	ldrd	r6, r12, [sp, #252]
   63696: 923d         	str	r2, [sp, #0xf4]
   63698: f960 074f    	vld1.16	{d16}, [r0]
   6369c: 2000         	movs	r0, #0x0
   6369e: 945f         	str	r4, [sp, #0x17c]
   636a0: edc4 0b12    	vstr	d16, [r4, #72]
   636a4: 283c         	cmp	r0, #0x3c
   636a6: d00b         	beq	0x636c0 <air1_opcal4_algorithm+0x1fd8> @ imm = #0x16
   636a8: 9c5f         	ldr	r4, [sp, #0x17c]
   636aa: f833 2020    	ldrh.w	r2, [r3, r0, lsl #2]
   636ae: 1821         	adds	r1, r4, r0
   636b0: 810a         	strh	r2, [r1, #0x8]
   636b2: eb04 0140    	add.w	r1, r4, r0, lsl #1
   636b6: f855 2030    	ldr.w	r2, [r5, r0, lsl #3]
   636ba: 3002         	adds	r0, #0x2
   636bc: 650a         	str	r2, [r1, #0x50]
   636be: e7f1         	b	0x636a4 <air1_opcal4_algorithm+0x1fbc> @ imm = #-0x1e
   636c0: 483a         	ldr	r0, [pc, #0xe8]         @ 0x637ac <air1_opcal4_algorithm+0x20c4>
   636c2: 2400         	movs	r4, #0x0
   636c4: f8ba 1648    	ldrh.w	r1, [r10, #0x648]
   636c8: f5a0 70a4    	sub.w	r0, r0, #0x148
   636cc: eddf 4b38    	vldr	d20, [pc, #224]         @ 0x637b0 <air1_opcal4_algorithm+0x20c8>
   636d0: f101 0801    	add.w	r8, r1, #0x1
   636d4: eddf 5b38    	vldr	d21, [pc, #224]         @ 0x637b8 <air1_opcal4_algorithm+0x20d0>
   636d8: f8aa 8648    	strh.w	r8, [r10, #0x648]
   636dc: b138         	cbz	r0, 0x636ee <air1_opcal4_algorithm+0x2006> @ imm = #0xe
   636de: eb0a 0200    	add.w	r2, r10, r0
   636e2: 3002         	adds	r0, #0x2
   636e4: f8b2 3d0c    	ldrh.w	r3, [r2, #0xd0c]
   636e8: f8a2 3d0a    	strh.w	r3, [r2, #0xd0a]
   636ec: e7f6         	b	0x636dc <air1_opcal4_algorithm+0x1ff4> @ imm = #-0x14
   636ee: 985f         	ldr	r0, [sp, #0x17c]
   636f0: 8800         	ldrh	r0, [r0]
   636f2: f8aa 0d0a    	strh.w	r0, [r10, #0xd0a]
   636f6: 2000         	movs	r0, #0x0
   636f8: 283c         	cmp	r0, #0x3c
   636fa: d006         	beq	0x6370a <air1_opcal4_algorithm+0x2022> @ imm = #0xc
   636fc: eb0a 0280    	add.w	r2, r10, r0, lsl #2
   63700: 3001         	adds	r0, #0x1
   63702: f8d2 30d4    	ldr.w	r3, [r2, #0xd4]
   63706: 65d3         	str	r3, [r2, #0x5c]
   63708: e7f6         	b	0x636f8 <air1_opcal4_algorithm+0x2010> @ imm = #-0x14
   6370a: 2000         	movs	r0, #0x0
   6370c: 2878         	cmp	r0, #0x78
   6370e: d007         	beq	0x63720 <air1_opcal4_algorithm+0x2038> @ imm = #0xe
   63710: f855 2020    	ldr.w	r2, [r5, r0, lsl #2]
   63714: eb0a 0300    	add.w	r3, r10, r0
   63718: 3004         	adds	r0, #0x4
   6371a: f8c3 214c    	str.w	r2, [r3, #0x14c]
   6371e: e7f5         	b	0x6370c <air1_opcal4_algorithm+0x2024> @ imm = #-0x16
   63720: 4822         	ldr	r0, [pc, #0x88]         @ 0x637ac <air1_opcal4_algorithm+0x20c4>
   63722: 30fc         	adds	r0, #0xfc
   63724: b138         	cbz	r0, 0x63736 <air1_opcal4_algorithm+0x204e> @ imm = #0xe
   63726: eb0a 0200    	add.w	r2, r10, r0
   6372a: 3004         	adds	r0, #0x4
   6372c: f8d2 3648    	ldr.w	r3, [r2, #0x648]
   63730: f8c2 3644    	str.w	r3, [r2, #0x644]
   63734: e7f6         	b	0x63724 <air1_opcal4_algorithm+0x203c> @ imm = #-0x14
   63736: 9d5f         	ldr	r5, [sp, #0x17c]
   63738: 2900         	cmp	r1, #0x0
   6373a: 6868         	ldr	r0, [r5, #0x4]
   6373c: f8ca 0644    	str.w	r0, [r10, #0x644]
   63740: f040 8087    	bne.w	0x63852 <air1_opcal4_algorithm+0x216a> @ imm = #0x10e
   63744: 994f         	ldr	r1, [sp, #0x13c]
   63746: 22ff         	movs	r2, #0xff
   63748: 764a         	strb	r2, [r1, #0x19]
   6374a: 2201         	movs	r2, #0x1
   6374c: 9953         	ldr	r1, [sp, #0x14c]
   6374e: f881 20ad    	strb.w	r2, [r1, #0xad]
   63752: 2107         	movs	r1, #0x7
   63754: 4632         	mov	r2, r6
   63756: b131         	cbz	r1, 0x63766 <air1_opcal4_algorithm+0x207e> @ imm = #0xc
   63758: 4b19         	ldr	r3, [pc, #0x64]         @ 0x637c0 <air1_opcal4_algorithm+0x20d8>
   6375a: 3901         	subs	r1, #0x1
   6375c: e942 430e    	strd	r4, r3, [r2, #-56]
   63760: e8e2 4402    	strd	r4, r4, [r2], #8
   63764: e7f7         	b	0x63756 <air1_opcal4_algorithm+0x206e> @ imm = #-0x12
   63766: 210a         	movs	r1, #0xa
   63768: 4662         	mov	r2, r12
   6376a: b131         	cbz	r1, 0x6377a <air1_opcal4_algorithm+0x2092> @ imm = #0xc
   6376c: 4b14         	ldr	r3, [pc, #0x50]         @ 0x637c0 <air1_opcal4_algorithm+0x20d8>
   6376e: 3901         	subs	r1, #0x1
   63770: e942 4314    	strd	r4, r3, [r2, #-80]
   63774: e8e2 4402    	strd	r4, r4, [r2], #8
   63778: e7f7         	b	0x6376a <air1_opcal4_algorithm+0x2082> @ imm = #-0x12
   6377a: 9a06         	ldr	r2, [sp, #0x18]
   6377c: 2132         	movs	r1, #0x32
   6377e: b309         	cbz	r1, 0x637c4 <air1_opcal4_algorithm+0x20dc> @ imm = #0x42
   63780: 4b0f         	ldr	r3, [pc, #0x3c]         @ 0x637c0 <air1_opcal4_algorithm+0x20d8>
   63782: 3901         	subs	r1, #0x1
   63784: e942 430a    	strd	r4, r3, [r2, #-40]
   63788: e8e2 431a    	strd	r4, r3, [r2], #104
   6378c: e7f7         	b	0x6377e <air1_opcal4_algorithm+0x2096> @ imm = #-0x12
   6378e: bf00         	nop
   63790: d4 fe ff ff  	.word	0xfffffed4
   63794: 00 bf 00 bf  	.word	0xbf00bf00
   63798: 9a 99 99 99  	.word	0x9999999a
   6379c: 99 99 4c 40  	.word	0x404c9999
   637a0: b8 e7 02 00  	.word	0x0002e7b8
   637a4: da e0 02 00  	.word	0x0002e0da
   637a8: 6a e1 02 00  	.word	0x0002e16a
   637ac: 88 fa ff ff  	.word	0xfffffa88
   637b0: 00 00 00 00  	.word	0x00000000
   637b4: 00 40 8f 40  	.word	0x408f4000
   637b8: 00 00 00 00  	.word	0x00000000
   637bc: 00 fe af 40  	.word	0x40affe00
   637c0: 00 00 f0 3f  	.word	0x3ff00000
   637c4: 995c         	ldr	r1, [sp, #0x170]
   637c6: 2506         	movs	r5, #0x6
   637c8: 9a53         	ldr	r2, [sp, #0x14c]
   637ca: 9b4f         	ldr	r3, [sp, #0x13c]
   637cc: edd1 0bd2    	vldr	d16, [r1, #840]
   637d0: edd1 1bd4    	vldr	d17, [r1, #848]
   637d4: 2101         	movs	r1, #0x1
   637d6: f882 1110    	strb.w	r1, [r2, #0x110]
   637da: 49e9         	ldr	r1, [pc, #0x3a4]        @ 0x63b80 <air1_opcal4_algorithm+0x2498>
   637dc: e9c2 1405    	strd	r1, r4, [r2, #20]
   637e0: e9c2 1407    	strd	r1, r4, [r2, #28]
   637e4: 6251         	str	r1, [r2, #0x24]
   637e6: e9c2 414e    	strd	r4, r1, [r2, #312]
   637ea: e9c2 4150    	strd	r4, r1, [r2, #320]
   637ee: e9c2 4152    	strd	r4, r1, [r2, #328]
   637f2: e9c2 4146    	strd	r4, r1, [r2, #280]
   637f6: e9c2 4148    	strd	r4, r1, [r2, #288]
   637fa: e9c2 414a    	strd	r4, r1, [r2, #296]
   637fe: e9c2 414c    	strd	r4, r1, [r2, #304]
   63802: 9903         	ldr	r1, [sp, #0xc]
   63804: f883 40d2    	strb.w	r4, [r3, #0xd2]
   63808: f8a3 40d0    	strh.w	r4, [r3, #0xd0]
   6380c: 6114         	str	r4, [r2, #0x10]
   6380e: f8a2 4040    	strh.w	r4, [r2, #0x40]
   63812: 8194         	strh	r4, [r2, #0xc]
   63814: 6094         	str	r4, [r2, #0x8]
   63816: 240f         	movs	r4, #0xf
   63818: f901 8ac4    	vst1.64	{d8, d9}, [r1], r4
   6381c: edc3 1b08    	vstr	d17, [r3, #32]
   63820: ee7f 1b61    	vsub.f64	d17, d15, d17
   63824: 7395         	strb	r5, [r2, #0xe]
   63826: 9d5f         	ldr	r5, [sp, #0x17c]
   63828: f901 8a0f    	vst1.8	{d8, d9}, [r1]
   6382c: 2164         	movs	r1, #0x64
   6382e: f882 1042    	strb.w	r1, [r2, #0x42]
   63832: 9904         	ldr	r1, [sp, #0x10]
   63834: edc3 1b0a    	vstr	d17, [r3, #40]
   63838: edc3 0b0c    	vstr	d16, [r3, #48]
   6383c: f901 8acf    	vst1.64	{d8, d9}, [r1]
   63840: 9905         	ldr	r1, [sp, #0x14]
   63842: f901 8acd    	vst1.64	{d8, d9}, [r1]!
   63846: f901 8acf    	vst1.64	{d8, d9}, [r1]
   6384a: f5a0 7191    	sub.w	r1, r0, #0x122
   6384e: f8c3 10d8    	str.w	r1, [r3, #0xd8]
   63852: 995c         	ldr	r1, [sp, #0x170]
   63854: 462e         	mov	r6, r5
   63856: f8da 2004    	ldr.w	r2, [r10, #0x4]
   6385a: 8b89         	ldrh	r1, [r1, #0x1c]
   6385c: 4411         	add	r1, r2
   6385e: f1a1 0278    	sub.w	r2, r1, #0x78
   63862: 2100         	movs	r1, #0x0
   63864: 4282         	cmp	r2, r0
   63866: f04f 0000    	mov.w	r0, #0x0
   6386a: bf98         	it	ls
   6386c: 2001         	movls	r0, #0x1
   6386e: 9b4e         	ldr	r3, [sp, #0x138]
   63870: f885 00c8    	strb.w	r0, [r5, #0xc8]
   63874: f105 00d0    	add.w	r0, r5, #0xd0
   63878: 9c55         	ldr	r4, [sp, #0x154]
   6387a: f50d 65c0    	add.w	r5, sp, #0x600
   6387e: 681a         	ldr	r2, [r3]
   63880: 685b         	ldr	r3, [r3, #0x4]
   63882: ee00 2a10    	vmov	s0, r2
   63886: eef7 0ac0    	vcvt.f64.f32	d16, s0
   6388a: ee00 3a10    	vmov	s0, r3
   6388e: eef7 1ac0    	vcvt.f64.f32	d17, s0
   63892: eef1 1b61    	vneg.f64	d17, d17
   63896: 291e         	cmp	r1, #0x1e
   63898: d016         	beq	0x638c8 <air1_opcal4_algorithm+0x21e0> @ imm = #0x2c
   6389a: eb06 0241    	add.w	r2, r6, r1, lsl #1
   6389e: eef0 3b61    	vmov.f64	d19, d17
   638a2: 3101         	adds	r1, #0x1
   638a4: 8912         	ldrh	r2, [r2, #0x8]
   638a6: ee00 2a10    	vmov	s0, r2
   638aa: eef8 2b40    	vcvt.f64.u32	d18, s0
   638ae: eec2 2b8a    	vdiv.f64	d18, d18, d10
   638b2: eec2 2ba5    	vdiv.f64	d18, d18, d21
   638b6: ee42 3ba0    	vmla.f64	d19, d18, d16
   638ba: eec3 2b8a    	vdiv.f64	d18, d19, d10
   638be: ee62 2ba4    	vmul.f64	d18, d18, d20
   638c2: ece0 2b02    	vstmia	r0!, {d18}
   638c6: e7e6         	b	0x63896 <air1_opcal4_algorithm+0x21ae> @ imm = #-0x34
   638c8: f50d 6067    	add.w	r0, sp, #0xe70
   638cc: f44f 718c    	mov.w	r1, #0x118
   638d0: f00b eb96    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xb72c
   638d4: f50d 603a    	add.w	r0, sp, #0xba0
   638d8: f44f 718c    	mov.w	r1, #0x118
   638dc: f00b eb90    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xb720
   638e0: 4658         	mov	r0, r11
   638e2: 2200         	movs	r2, #0x0
   638e4: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   638e8: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   638ec: f900 8acf    	vst1.64	{d8, d9}, [r0]
   638f0: 4628         	mov	r0, r5
   638f2: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   638f6: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   638fa: f8ad 223c    	strh.w	r2, [sp, #0x23c]
   638fe: 928e         	str	r2, [sp, #0x238]
   63900: f900 8acf    	vst1.64	{d8, d9}, [r0]
   63904: a8ca         	add	r0, sp, #0x328
   63906: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   6390a: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   6390e: f900 8acf    	vst1.64	{d8, d9}, [r0]
   63912: fa1f f088    	uxth.w	r0, r8
   63916: 2801         	cmp	r0, #0x1
   63918: 904a         	str	r0, [sp, #0x128]
   6391a: d91d         	bls	0x63958 <air1_opcal4_algorithm+0x2270> @ imm = #0x3a
   6391c: ae8e         	add	r6, sp, #0x238
   6391e: f8dd e130    	ldr.w	lr, [sp, #0x130]
   63922: 9d0a         	ldr	r5, [sp, #0x28]
   63924: f50d 6c3a    	add.w	r12, sp, #0xba0
   63928: f06f 0027    	mvn	r0, #0x27
   6392c: b320         	cbz	r0, 0x63978 <air1_opcal4_algorithm+0x2290> @ imm = #0x48
   6392e: eb0a 0200    	add.w	r2, r10, r0
   63932: f50d 6167    	add.w	r1, sp, #0xe70
   63936: f602 5338    	addw	r3, r2, #0xd38
   6393a: 4401         	add	r1, r0
   6393c: f502 6256    	add.w	r2, r2, #0xd60
   63940: edd3 0b00    	vldr	d16, [r3]
   63944: edc1 0b0a    	vstr	d16, [r1, #40]
   63948: eb0c 0100    	add.w	r1, r12, r0
   6394c: edd2 0b00    	vldr	d16, [r2]
   63950: 3008         	adds	r0, #0x8
   63952: edc1 0b0a    	vstr	d16, [r1, #40]
   63956: e7e9         	b	0x6392c <air1_opcal4_algorithm+0x2244> @ imm = #-0x2e
   63958: 2000         	movs	r0, #0x0
   6395a: f50d 6c3a    	add.w	r12, sp, #0xba0
   6395e: e9dd 8534    	ldrd	r8, r5, [sp, #208]
   63962: eeb1 eb08    	vmov.f64	d14, #6.000000e+00
   63966: 28f0         	cmp	r0, #0xf0
   63968: d016         	beq	0x63998 <air1_opcal4_algorithm+0x22b0> @ imm = #0x2c
   6396a: 1831         	adds	r1, r6, r0
   6396c: 3008         	adds	r0, #0x8
   6396e: edd1 0b34    	vldr	d16, [r1, #208]
   63972: edc1 0b70    	vstr	d16, [r1, #448]
   63976: e7f6         	b	0x63966 <air1_opcal4_algorithm+0x227e> @ imm = #-0x14
   63978: 2000         	movs	r0, #0x0
   6397a: 28f0         	cmp	r0, #0xf0
   6397c: d012         	beq	0x639a4 <air1_opcal4_algorithm+0x22bc> @ imm = #0x24
   6397e: 9a5f         	ldr	r2, [sp, #0x17c]
   63980: 1829         	adds	r1, r5, r0
   63982: 4402         	add	r2, r0
   63984: edd2 0b34    	vldr	d16, [r2, #208]
   63988: edc1 0b00    	vstr	d16, [r1]
   6398c: 995a         	ldr	r1, [sp, #0x168]
   6398e: 4401         	add	r1, r0
   63990: 3008         	adds	r0, #0x8
   63992: edc1 0b00    	vstr	d16, [r1]
   63996: e7f0         	b	0x6397a <air1_opcal4_algorithm+0x2292> @ imm = #-0x20
   63998: 2000         	movs	r0, #0x0
   6399a: 2806         	cmp	r0, #0x6
   6399c: d00b         	beq	0x639b6 <air1_opcal4_algorithm+0x22ce> @ imm = #0x16
   6399e: 5422         	strb	r2, [r4, r0]
   639a0: 3001         	adds	r0, #0x1
   639a2: e7fa         	b	0x6399a <air1_opcal4_algorithm+0x22b2> @ imm = #-0xc
   639a4: f50d 65c0    	add.w	r5, sp, #0x600
   639a8: 2000         	movs	r0, #0x0
   639aa: 2806         	cmp	r0, #0x6
   639ac: d010         	beq	0x639d0 <air1_opcal4_algorithm+0x22e8> @ imm = #0x20
   639ae: 5c21         	ldrb	r1, [r4, r0]
   639b0: 5431         	strb	r1, [r6, r0]
   639b2: 3001         	adds	r0, #0x1
   639b4: e7f9         	b	0x639aa <air1_opcal4_algorithm+0x22c2> @ imm = #-0xe
   639b6: 2000         	movs	r0, #0x0
   639b8: 2828         	cmp	r0, #0x28
   639ba: f000 8154    	beq.w	0x63c66 <air1_opcal4_algorithm+0x257e> @ imm = #0x2a8
   639be: 995b         	ldr	r1, [sp, #0x16c]
   639c0: 1832         	adds	r2, r6, r0
   639c2: 4401         	add	r1, r0
   639c4: edd2 0b66    	vldr	d16, [r2, #408]
   639c8: 3008         	adds	r0, #0x8
   639ca: edc1 0b00    	vstr	d16, [r1]
   639ce: e7f3         	b	0x639b8 <air1_opcal4_algorithm+0x22d0> @ imm = #-0x1a
   639d0: 985f         	ldr	r0, [sp, #0x17c]
   639d2: f50d 6a67    	add.w	r10, sp, #0xe70
   639d6: f50d 683a    	add.w	r8, sp, #0xba0
   639da: 2100         	movs	r1, #0x0
   639dc: f04f 0900    	mov.w	r9, #0x0
   639e0: 8800         	ldrh	r0, [r0]
   639e2: 3801         	subs	r0, #0x1
   639e4: 9052         	str	r0, [sp, #0x148]
   639e6: f1b9 0f1e    	cmp.w	r9, #0x1e
   639ea: f000 8112    	beq.w	0x63c12 <air1_opcal4_algorithm+0x252a> @ imm = #0x224
   639ee: 9856         	ldr	r0, [sp, #0x158]
   639f0: eb00 0089    	add.w	r0, r0, r9, lsl #2
   639f4: ed90 0a4e    	vldr	s0, [r0, #312]
   639f8: ed90 1a53    	vldr	s2, [r0, #332]
   639fc: eef8 0b40    	vcvt.f64.u32	d16, s0
   63a00: eef8 1b41    	vcvt.f64.u32	d17, s2
   63a04: ee71 0be0    	vsub.f64	d16, d17, d16
   63a08: eef4 0b4d    	vcmp.f64	d16, d13
   63a0c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63a10: bf48         	it	mi
   63a12: 2101         	movmi	r1, #0x1
   63a14: b2c8         	uxtb	r0, r1
   63a16: 9157         	str	r1, [sp, #0x15c]
   63a18: 2801         	cmp	r0, #0x1
   63a1a: d129         	bne	0x63a70 <air1_opcal4_algorithm+0x2388> @ imm = #0x52
   63a1c: 2100         	movs	r1, #0x0
   63a1e: 2930         	cmp	r1, #0x30
   63a20: d009         	beq	0x63a36 <air1_opcal4_algorithm+0x234e> @ imm = #0x12
   63a22: eb0a 0301    	add.w	r3, r10, r1
   63a26: eb0b 0201    	add.w	r2, r11, r1
   63a2a: 3108         	adds	r1, #0x8
   63a2c: edd3 0b00    	vldr	d16, [r3]
   63a30: edc2 0b00    	vstr	d16, [r2]
   63a34: e7f3         	b	0x63a1e <air1_opcal4_algorithm+0x2336> @ imm = #-0x1a
   63a36: 2100         	movs	r1, #0x0
   63a38: 2200         	movs	r2, #0x0
   63a3a: 2a06         	cmp	r2, #0x6
   63a3c: d007         	beq	0x63a4e <air1_opcal4_algorithm+0x2366> @ imm = #0xe
   63a3e: 56b3         	ldrsb	r3, [r6, r2]
   63a40: 3201         	adds	r2, #0x1
   63a42: eb03 14e3    	add.w	r4, r3, r3, asr #7
   63a46: ea84 13e3    	eor.w	r3, r4, r3, asr #7
   63a4a: 4419         	add	r1, r3
   63a4c: e7f5         	b	0x63a3a <air1_opcal4_algorithm+0x2352> @ imm = #-0x16
   63a4e: 9c55         	ldr	r4, [sp, #0x154]
   63a50: b2c9         	uxtb	r1, r1
   63a52: 2904         	cmp	r1, #0x4
   63a54: d30c         	blo	0x63a70 <air1_opcal4_algorithm+0x2388> @ imm = #0x18
   63a56: 2100         	movs	r1, #0x0
   63a58: 2928         	cmp	r1, #0x28
   63a5a: d009         	beq	0x63a70 <air1_opcal4_algorithm+0x2388> @ imm = #0x12
   63a5c: eb08 0301    	add.w	r3, r8, r1
   63a60: eb0b 0201    	add.w	r2, r11, r1
   63a64: 3108         	adds	r1, #0x8
   63a66: edd3 0b00    	vldr	d16, [r3]
   63a6a: edc2 0b00    	vstr	d16, [r2]
   63a6e: e7f3         	b	0x63a58 <air1_opcal4_algorithm+0x2370> @ imm = #-0x1a
   63a70: 2100         	movs	r1, #0x0
   63a72: 2905         	cmp	r1, #0x5
   63a74: d004         	beq	0x63a80 <air1_opcal4_algorithm+0x2398> @ imm = #0x8
   63a76: 1872         	adds	r2, r6, r1
   63a78: 7852         	ldrb	r2, [r2, #0x1]
   63a7a: 5472         	strb	r2, [r6, r1]
   63a7c: 3101         	adds	r1, #0x1
   63a7e: e7f8         	b	0x63a72 <air1_opcal4_algorithm+0x238a> @ imm = #-0x10
   63a80: 2801         	cmp	r0, #0x1
   63a82: d135         	bne	0x63af0 <air1_opcal4_algorithm+0x2408> @ imm = #0x6a
   63a84: 9856         	ldr	r0, [sp, #0x158]
   63a86: 9952         	ldr	r1, [sp, #0x148]
   63a88: f8b0 0d08    	ldrh.w	r0, [r0, #0xd08]
   63a8c: 4281         	cmp	r1, r0
   63a8e: d12f         	bne	0x63af0 <air1_opcal4_algorithm+0x2408> @ imm = #0x5e
   63a90: 4658         	mov	r0, r11
   63a92: 2106         	movs	r1, #0x6
   63a94: f008 ff5c    	bl	0x6c950 <math_median>   @ imm = #0x8eb8
   63a98: eeb0 bb40    	vmov.f64	d11, d0
   63a9c: 2400         	movs	r4, #0x0
   63a9e: 2c30         	cmp	r4, #0x30
   63aa0: d028         	beq	0x63af4 <air1_opcal4_algorithm+0x240c> @ imm = #0x50
   63aa2: eb0b 0004    	add.w	r0, r11, r4
   63aa6: ed90 cb00    	vldr	d12, [r0]
   63aaa: ee7c 0b4b    	vsub.f64	d16, d12, d11
   63aae: eef5 0b40    	vcmp.f64	d16, #0
   63ab2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63ab6: eef1 1b60    	vneg.f64	d17, d16
   63aba: bf48         	it	mi
   63abc: eef0 0b61    	vmovmi.f64	d16, d17
   63ac0: 1928         	adds	r0, r5, r4
   63ac2: 2106         	movs	r1, #0x6
   63ac4: edc0 0b00    	vstr	d16, [r0]
   63ac8: 4658         	mov	r0, r11
   63aca: f008 fde9    	bl	0x6c6a0 <math_mean>     @ imm = #0x8bd2
   63ace: ee7c 0b40    	vsub.f64	d16, d12, d0
   63ad2: eef5 0b40    	vcmp.f64	d16, #0
   63ad6: eef1 1b60    	vneg.f64	d17, d16
   63ada: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63ade: bf48         	it	mi
   63ae0: eef0 0b61    	vmovmi.f64	d16, d17
   63ae4: a8ca         	add	r0, sp, #0x328
   63ae6: 4420         	add	r0, r4
   63ae8: 3408         	adds	r4, #0x8
   63aea: edc0 0b00    	vstr	d16, [r0]
   63aee: e7d6         	b	0x63a9e <air1_opcal4_algorithm+0x23b6> @ imm = #-0x54
   63af0: 2000         	movs	r0, #0x0
   63af2: e07a         	b	0x63bea <air1_opcal4_algorithm+0x2502> @ imm = #0xf4
   63af4: 4628         	mov	r0, r5
   63af6: 2106         	movs	r1, #0x6
   63af8: f008 ff2a    	bl	0x6c950 <math_median>   @ imm = #0x8e54
   63afc: a8ca         	add	r0, sp, #0x328
   63afe: 2106         	movs	r1, #0x6
   63b00: eeb0 db40    	vmov.f64	d13, d0
   63b04: f008 fdcc    	bl	0x6c6a0 <math_mean>     @ imm = #0x8b98
   63b08: eddf 0b1f    	vldr	d16, [pc, #124]         @ 0x63b88 <air1_opcal4_algorithm+0x24a0>
   63b0c: eeb4 db60    	vcmp.f64	d13, d16
   63b10: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63b14: d511         	bpl	0x63b3a <air1_opcal4_algorithm+0x2452> @ imm = #0x22
   63b16: ed9f 1b1e    	vldr	d1, [pc, #120]          @ 0x63b90 <air1_opcal4_algorithm+0x24a8>
   63b1a: 200a         	movs	r0, #0xa
   63b1c: 2101         	movs	r1, #0x1
   63b1e: eeb0 cb40    	vmov.f64	d12, d0
   63b22: f008 fe81    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x8d02
   63b26: eddf 0b1c    	vldr	d16, [pc, #112]         @ 0x63b98 <air1_opcal4_algorithm+0x24b0>
   63b2a: 2800         	cmp	r0, #0x0
   63b2c: 9c55         	ldr	r4, [sp, #0x154]
   63b2e: ee2c cb20    	vmul.f64	d12, d12, d16
   63b32: d064         	beq	0x63bfe <air1_opcal4_algorithm+0x2516> @ imm = #0xc8
   63b34: f50d 60b2    	add.w	r0, sp, #0x590
   63b38: e006         	b	0x63b48 <air1_opcal4_algorithm+0x2460> @ imm = #0xc
   63b3a: eddf 0b19    	vldr	d16, [pc, #100]         @ 0x63ba0 <air1_opcal4_algorithm+0x24b8>
   63b3e: f50d 60b2    	add.w	r0, sp, #0x590
   63b42: 9c55         	ldr	r4, [sp, #0x154]
   63b44: ee2d cb20    	vmul.f64	d12, d13, d16
   63b48: edd0 0bda    	vldr	d16, [r0, #872]
   63b4c: ee70 0bcb    	vsub.f64	d16, d16, d11
   63b50: ee80 bb8c    	vdiv.f64	d11, d16, d12
   63b54: eeb0 0b4b    	vmov.f64	d0, d11
   63b58: 200a         	movs	r0, #0xa
   63b5a: 2101         	movs	r1, #0x1
   63b5c: eeb0 1b4e    	vmov.f64	d1, d14
   63b60: ed9f db11    	vldr	d13, [pc, #68]          @ 0x63ba8 <air1_opcal4_algorithm+0x24c0>
   63b64: f008 fe60    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x8cc0
   63b68: b330         	cbz	r0, 0x63bb8 <air1_opcal4_algorithm+0x24d0> @ imm = #0x4c
   63b6a: f50d 6c3a    	add.w	r12, sp, #0xba0
   63b6e: eb0c 00c9    	add.w	r0, r12, r9, lsl #3
   63b72: edd0 0b08    	vldr	d16, [r0, #32]
   63b76: 2001         	movs	r0, #0x1
   63b78: ee7c 0b20    	vadd.f64	d16, d12, d16
   63b7c: e02e         	b	0x63bdc <air1_opcal4_algorithm+0x24f4> @ imm = #0x5c
   63b7e: bf00         	nop
   63b80: 00 00 f8 7f  	.word	0x7ff80000
   63b84: 00 bf 00 bf  	.word	0xbf00bf00
   63b88: 9b 2b a1 86  	.word	0x86a12b9b
   63b8c: 9b 84 06 3d  	.word	0x3d06849b
   63b90: fc a9 f1 d2  	.word	0xd2f1a9fc
   63b94: 4d 62 50 3f  	.word	0x3f50624d
   63b98: 32 e7 19 fb  	.word	0xfb19e732
   63b9c: 92 0d f4 3f  	.word	0x3ff40d92
   63ba0: 2d b2 9d ef  	.word	0xef9db22d
   63ba4: a7 c6 f7 3f  	.word	0x3ff7c6a7
   63ba8: 9a 99 99 99  	.word	0x9999999a
   63bac: 99 99 4c 40  	.word	0x404c9999
   63bb0: 9a 99 99 99  	.word	0x9999999a
   63bb4: 99 09 8c 40  	.word	0x408c0999
   63bb8: eeb0 0b4b    	vmov.f64	d0, d11
   63bbc: 200a         	movs	r0, #0xa
   63bbe: 2102         	movs	r1, #0x2
   63bc0: eebf 1b08    	vmov.f64	d1, #-1.500000e+00
   63bc4: f008 fe30    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x8c60
   63bc8: b1e0         	cbz	r0, 0x63c04 <air1_opcal4_algorithm+0x251c> @ imm = #0x38
   63bca: f50d 6c3a    	add.w	r12, sp, #0xba0
   63bce: eb0c 00c9    	add.w	r0, r12, r9, lsl #3
   63bd2: edd0 0b08    	vldr	d16, [r0, #32]
   63bd6: 20ff         	movs	r0, #0xff
   63bd8: ee70 0bcc    	vsub.f64	d16, d16, d12
   63bdc: ae8e         	add	r6, sp, #0x238
   63bde: f8dd e130    	ldr.w	lr, [sp, #0x130]
   63be2: eb0c 01c9    	add.w	r1, r12, r9, lsl #3
   63be6: edc1 0b0a    	vstr	d16, [r1, #40]
   63bea: f88d 023d    	strb.w	r0, [sp, #0x23d]
   63bee: f108 0808    	add.w	r8, r8, #0x8
   63bf2: f10a 0a08    	add.w	r10, r10, #0x8
   63bf6: f109 0901    	add.w	r9, r9, #0x1
   63bfa: 9957         	ldr	r1, [sp, #0x15c]
   63bfc: e6f3         	b	0x639e6 <air1_opcal4_algorithm+0x22fe> @ imm = #-0x21a
   63bfe: ef80 b010    	vmov.i32	d11, #0x0
   63c02: e7a7         	b	0x63b54 <air1_opcal4_algorithm+0x246c> @ imm = #-0xb2
   63c04: ae8e         	add	r6, sp, #0x238
   63c06: 2000         	movs	r0, #0x0
   63c08: f50d 6c3a    	add.w	r12, sp, #0xba0
   63c0c: f8dd e130    	ldr.w	lr, [sp, #0x130]
   63c10: e7eb         	b	0x63bea <air1_opcal4_algorithm+0x2502> @ imm = #-0x2a
   63c12: 2000         	movs	r0, #0x0
   63c14: f8dd a158    	ldr.w	r10, [sp, #0x158]
   63c18: f50d 693a    	add.w	r9, sp, #0xba0
   63c1c: e9dd 8534    	ldrd	r8, r5, [sp, #208]
   63c20: eeb1 eb08    	vmov.f64	d14, #6.000000e+00
   63c24: 28f0         	cmp	r0, #0xf0
   63c26: d009         	beq	0x63c3c <air1_opcal4_algorithm+0x2554> @ imm = #0x12
   63c28: 9a5a         	ldr	r2, [sp, #0x168]
   63c2a: 995f         	ldr	r1, [sp, #0x17c]
   63c2c: 4402         	add	r2, r0
   63c2e: 4401         	add	r1, r0
   63c30: 3008         	adds	r0, #0x8
   63c32: edd2 0b00    	vldr	d16, [r2]
   63c36: edc1 0b70    	vstr	d16, [r1, #448]
   63c3a: e7f3         	b	0x63c24 <air1_opcal4_algorithm+0x253c> @ imm = #-0x1a
   63c3c: 2000         	movs	r0, #0x0
   63c3e: 2806         	cmp	r0, #0x6
   63c40: d003         	beq	0x63c4a <air1_opcal4_algorithm+0x2562> @ imm = #0x6
   63c42: 5c31         	ldrb	r1, [r6, r0]
   63c44: 5421         	strb	r1, [r4, r0]
   63c46: 3001         	adds	r0, #0x1
   63c48: e7f9         	b	0x63c3e <air1_opcal4_algorithm+0x2556> @ imm = #-0xe
   63c4a: 9e5f         	ldr	r6, [sp, #0x17c]
   63c4c: 2000         	movs	r0, #0x0
   63c4e: 2828         	cmp	r0, #0x28
   63c50: d009         	beq	0x63c66 <air1_opcal4_algorithm+0x257e> @ imm = #0x12
   63c52: 995b         	ldr	r1, [sp, #0x16c]
   63c54: eb0e 0200    	add.w	r2, lr, r0
   63c58: 4401         	add	r1, r0
   63c5a: edd2 0b00    	vldr	d16, [r2]
   63c5e: 3008         	adds	r0, #0x8
   63c60: edc1 0b00    	vstr	d16, [r1]
   63c64: e7f3         	b	0x63c4e <air1_opcal4_algorithm+0x2566> @ imm = #-0x1a
   63c66: 2000         	movs	r0, #0x0
   63c68: 2828         	cmp	r0, #0x28
   63c6a: d00a         	beq	0x63c82 <air1_opcal4_algorithm+0x259a> @ imm = #0x14
   63c6c: 1831         	adds	r1, r6, r0
   63c6e: edd1 0b66    	vldr	d16, [r1, #408]
   63c72: eb0a 0100    	add.w	r1, r10, r0
   63c76: f501 6151    	add.w	r1, r1, #0xd10
   63c7a: 3008         	adds	r0, #0x8
   63c7c: edc1 0b00    	vstr	d16, [r1]
   63c80: e7f2         	b	0x63c68 <air1_opcal4_algorithm+0x2580> @ imm = #-0x1c
   63c82: f50d 6067    	add.w	r0, sp, #0xe70
   63c86: f44f 7134    	mov.w	r1, #0x2d0
   63c8a: 4664         	mov	r4, r12
   63c8c: f00b e9b8    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xb370
   63c90: 4620         	mov	r0, r4
   63c92: f44f 7134    	mov.w	r1, #0x2d0
   63c96: f00b e9b4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xb368
   63c9a: 4658         	mov	r0, r11
   63c9c: f44f 7134    	mov.w	r1, #0x2d0
   63ca0: f00b e9ae    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xb35c
   63ca4: f50d 60c0    	add.w	r0, sp, #0x600
   63ca8: f44f 7134    	mov.w	r1, #0x2d0
   63cac: f00b e9a8    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xb350
   63cb0: 984a         	ldr	r0, [sp, #0x128]
   63cb2: 2802         	cmp	r0, #0x2
   63cb4: d910         	bls	0x63cd8 <air1_opcal4_algorithm+0x25f0> @ imm = #0x20
   63cb6: ed9a 0a17    	vldr	s0, [r10, #92]
   63cba: ed9a 1a70    	vldr	s2, [r10, #448]
   63cbe: eef8 0b40    	vcvt.f64.u32	d16, s0
   63cc2: eef8 1b41    	vcvt.f64.u32	d17, s2
   63cc6: ee71 0be0    	vsub.f64	d16, d17, d16
   63cca: ed5f 1b47    	vldr	d17, [pc, #-284]        @ 0x63bb0 <air1_opcal4_algorithm+0x24c8>
   63cce: eef4 0b61    	vcmp.f64	d16, d17
   63cd2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63cd6: d40c         	bmi	0x63cf2 <air1_opcal4_algorithm+0x260a> @ imm = #0x18
   63cd8: f50d 6b67    	add.w	r11, sp, #0xe70
   63cdc: 2000         	movs	r0, #0x0
   63cde: 28f0         	cmp	r0, #0xf0
   63ce0: f000 80fd    	beq.w	0x63ede <air1_opcal4_algorithm+0x27f6> @ imm = #0x1fa
   63ce4: 1831         	adds	r1, r6, r0
   63ce6: 3008         	adds	r0, #0x8
   63ce8: edd1 0b70    	vldr	d16, [r1, #448]
   63cec: edc1 0bac    	vstr	d16, [r1, #688]
   63cf0: e7f5         	b	0x63cde <air1_opcal4_algorithm+0x25f6> @ imm = #-0x16
   63cf2: f50d 65c0    	add.w	r5, sp, #0x600
   63cf6: 2000         	movs	r0, #0x0
   63cf8: 2400         	movs	r4, #0x0
   63cfa: f5b0 7ff0    	cmp.w	r0, #0x1e0
   63cfe: d00a         	beq	0x63d16 <air1_opcal4_algorithm+0x262e> @ imm = #0x14
   63d00: eb08 0200    	add.w	r2, r8, r0
   63d04: f50d 6167    	add.w	r1, sp, #0xe70
   63d08: 4401         	add	r1, r0
   63d0a: 3008         	adds	r0, #0x8
   63d0c: edd2 0b00    	vldr	d16, [r2]
   63d10: edc1 0b00    	vstr	d16, [r1]
   63d14: e7f1         	b	0x63cfa <air1_opcal4_algorithm+0x2612> @ imm = #-0x1e
   63d16: 9b01         	ldr	r3, [sp, #0x4]
   63d18: 2000         	movs	r0, #0x0
   63d1a: 28f0         	cmp	r0, #0xf0
   63d1c: d007         	beq	0x63d2e <air1_opcal4_algorithm+0x2646> @ imm = #0xe
   63d1e: 1832         	adds	r2, r6, r0
   63d20: 1819         	adds	r1, r3, r0
   63d22: 3008         	adds	r0, #0x8
   63d24: edd2 0b70    	vldr	d16, [r2, #448]
   63d28: edc1 0b00    	vstr	d16, [r1]
   63d2c: e7f5         	b	0x63d1a <air1_opcal4_algorithm+0x2632> @ imm = #-0x16
   63d2e: 2000         	movs	r0, #0x0
   63d30: f5b0 7f34    	cmp.w	r0, #0x2d0
   63d34: d007         	beq	0x63d46 <air1_opcal4_algorithm+0x265e> @ imm = #0xe
   63d36: eb0b 0100    	add.w	r1, r11, r0
   63d3a: 4acf         	ldr	r2, [pc, #0x33c]        @ 0x64078 <air1_opcal4_algorithm+0x2990>
   63d3c: f84b 4000    	str.w	r4, [r11, r0]
   63d40: 3008         	adds	r0, #0x8
   63d42: 604a         	str	r2, [r1, #0x4]
   63d44: e7f4         	b	0x63d30 <air1_opcal4_algorithm+0x2648> @ imm = #-0x18
   63d46: f04f 0900    	mov.w	r9, #0x0
   63d4a: f04f 0800    	mov.w	r8, #0x0
   63d4e: f1b8 0f03    	cmp.w	r8, #0x3
   63d52: f000 80b2    	beq.w	0x63eba <air1_opcal4_algorithm+0x27d2> @ imm = #0x164
   63d56: 48c9         	ldr	r0, [pc, #0x324]        @ 0x6407c <air1_opcal4_algorithm+0x2994>
   63d58: 2200         	movs	r2, #0x0
   63d5a: 4478         	add	r0, pc
   63d5c: f8d0 e000    	ldr.w	lr, [r0]
   63d60: f647 70f0    	movw	r0, #0x7ff0
   63d64: eb0e 0c00    	add.w	r12, lr, r0
   63d68: 2a5a         	cmp	r2, #0x5a
   63d6a: d075         	beq	0x63e58 <air1_opcal4_algorithm+0x2770> @ imm = #0xea
   63d6c: efc0 0010    	vmov.i32	d16, #0x0
   63d70: f50d 6467    	add.w	r4, sp, #0xe70
   63d74: efc0 1010    	vmov.i32	d17, #0x0
   63d78: f50d 660d    	add.w	r6, sp, #0x8d0
   63d7c: efc0 3010    	vmov.i32	d19, #0x0
   63d80: f50d 6b67    	add.w	r11, sp, #0xe70
   63d84: efc0 4010    	vmov.i32	d20, #0x0
   63d88: 2301         	movs	r3, #0x1
   63d8a: efc0 2010    	vmov.i32	d18, #0x0
   63d8e: 4665         	mov	r5, r12
   63d90: 4670         	mov	r0, lr
   63d92: 2b5b         	cmp	r3, #0x5b
   63d94: d023         	beq	0x63dde <air1_opcal4_algorithm+0x26f6> @ imm = #0x46
   63d96: 4629         	mov	r1, r5
   63d98: 2a2d         	cmp	r2, #0x2d
   63d9a: bf38         	it	lo
   63d9c: 4601         	movlo	r1, r0
   63d9e: ecf6 6b02    	vldmia	r6!, {d22}
   63da2: ee00 3a10    	vmov	s0, r3
   63da6: f5a5 75b4    	sub.w	r5, r5, #0x168
   63daa: edd1 5b00    	vldr	d21, [r1]
   63dae: f500 70b4    	add.w	r0, r0, #0x168
   63db2: ecf4 8b02    	vldmia	r4!, {d24}
   63db6: 3301         	adds	r3, #0x1
   63db8: ee66 5ba5    	vmul.f64	d21, d22, d21
   63dbc: eef8 6bc0    	vcvt.f64.s32	d22, s0
   63dc0: ee65 7ba6    	vmul.f64	d23, d21, d22
   63dc4: ee65 8ba8    	vmul.f64	d24, d21, d24
   63dc8: ee47 2ba6    	vmla.f64	d18, d23, d22
   63dcc: ee48 1ba6    	vmla.f64	d17, d24, d22
   63dd0: ee73 3ba5    	vadd.f64	d19, d19, d21
   63dd4: ee77 4ba4    	vadd.f64	d20, d23, d20
   63dd8: ee78 0ba0    	vadd.f64	d16, d24, d16
   63ddc: e7d9         	b	0x63d92 <air1_opcal4_algorithm+0x26aa> @ imm = #-0x4e
   63dde: ee62 5ba3    	vmul.f64	d21, d18, d19
   63de2: 1c50         	adds	r0, r2, #0x1
   63de4: f50d 613a    	add.w	r1, sp, #0xba0
   63de8: f50d 65c0    	add.w	r5, sp, #0x600
   63dec: eb01 01c2    	add.w	r1, r1, r2, lsl #3
   63df0: f1ac 0c08    	sub.w	r12, r12, #0x8
   63df4: f10e 0e08    	add.w	lr, lr, #0x8
   63df8: ee44 5be4    	vmls.f64	d21, d20, d20
   63dfc: eef1 4b64    	vneg.f64	d20, d20
   63e00: eec3 3ba5    	vdiv.f64	d19, d19, d21
   63e04: eec4 4ba5    	vdiv.f64	d20, d20, d21
   63e08: eec2 2ba5    	vdiv.f64	d18, d18, d21
   63e0c: ee61 3ba3    	vmul.f64	d19, d17, d19
   63e10: ee61 1ba4    	vmul.f64	d17, d17, d20
   63e14: ee44 3ba0    	vmla.f64	d19, d20, d16
   63e18: ee42 1ba0    	vmla.f64	d17, d18, d16
   63e1c: ee00 0a10    	vmov	s0, r0
   63e20: eef8 0bc0    	vcvt.f64.s32	d16, s0
   63e24: ee43 1ba0    	vmla.f64	d17, d19, d16
   63e28: edc1 1b00    	vstr	d17, [r1]
   63e2c: eb0b 01c2    	add.w	r1, r11, r2, lsl #3
   63e30: edd1 0b00    	vldr	d16, [r1]
   63e34: eb05 01c2    	add.w	r1, r5, r2, lsl #3
   63e38: 4602         	mov	r2, r0
   63e3a: ee70 0be1    	vsub.f64	d16, d16, d17
   63e3e: eef5 0b40    	vcmp.f64	d16, #0
   63e42: eef1 1b60    	vneg.f64	d17, d16
   63e46: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63e4a: bf48         	it	mi
   63e4c: eef0 0b61    	vmovmi.f64	d16, d17
   63e50: edc1 0b00    	vstr	d16, [r1]
   63e54: 9e5f         	ldr	r6, [sp, #0x17c]
   63e56: e787         	b	0x63d68 <air1_opcal4_algorithm+0x2680> @ imm = #-0xf2
   63e58: 4628         	mov	r0, r5
   63e5a: 215a         	movs	r1, #0x5a
   63e5c: f008 fca0    	bl	0x6c7a0 <quick_median>  @ imm = #0x8940
   63e60: ee60 0b0e    	vmul.f64	d16, d0, d14
   63e64: f50d 630d    	add.w	r3, sp, #0x8d0
   63e68: 2000         	movs	r0, #0x0
   63e6a: f5b0 7f34    	cmp.w	r0, #0x2d0
   63e6e: d01d         	beq	0x63eac <air1_opcal4_algorithm+0x27c4> @ imm = #0x3a
   63e70: 182a         	adds	r2, r5, r0
   63e72: eef0 2b4f    	vmov.f64	d18, d15
   63e76: 1819         	adds	r1, r3, r0
   63e78: edd2 1b00    	vldr	d17, [r2]
   63e7c: eec1 1ba0    	vdiv.f64	d17, d17, d16
   63e80: eef4 1b4f    	vcmp.f64	d17, d15
   63e84: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63e88: bfc8         	it	gt
   63e8a: eef0 1b4f    	vmovgt.f64	d17, d15
   63e8e: ee41 2be1    	vmls.f64	d18, d17, d17
   63e92: ee62 1ba2    	vmul.f64	d17, d18, d18
   63e96: eef4 1b61    	vcmp.f64	d17, d17
   63e9a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63e9e: edc1 1b00    	vstr	d17, [r1]
   63ea2: bf68         	it	vs
   63ea4: f04f 0901    	movvs.w	r9, #0x1
   63ea8: 3008         	adds	r0, #0x8
   63eaa: e7de         	b	0x63e6a <air1_opcal4_algorithm+0x2782> @ imm = #-0x44
   63eac: f108 0801    	add.w	r8, r8, #0x1
   63eb0: fa5f f089    	uxtb.w	r0, r9
   63eb4: 2801         	cmp	r0, #0x1
   63eb6: f47f af4a    	bne.w	0x63d4e <air1_opcal4_algorithm+0x2666> @ imm = #-0x16c
   63eba: e9dd 8534    	ldrd	r8, r5, [sp, #208]
   63ebe: f50d 693a    	add.w	r9, sp, #0xba0
   63ec2: f50d 6b67    	add.w	r11, sp, #0xe70
   63ec6: 2000         	movs	r0, #0x0
   63ec8: 28f0         	cmp	r0, #0xf0
   63eca: d008         	beq	0x63ede <air1_opcal4_algorithm+0x27f6> @ imm = #0x10
   63ecc: 9a51         	ldr	r2, [sp, #0x144]
   63ece: 1831         	adds	r1, r6, r0
   63ed0: 4402         	add	r2, r0
   63ed2: 3008         	adds	r0, #0x8
   63ed4: edd2 0b00    	vldr	d16, [r2]
   63ed8: edc1 0bac    	vstr	d16, [r1, #688]
   63edc: e7f4         	b	0x63ec8 <air1_opcal4_algorithm+0x27e0> @ imm = #-0x18
   63ede: 201e         	movs	r0, #0x1e
   63ee0: 4641         	mov	r1, r8
   63ee2: b128         	cbz	r0, 0x63ef0 <air1_opcal4_algorithm+0x2808> @ imm = #0xa
   63ee4: edd1 0b3c    	vldr	d16, [r1, #240]
   63ee8: 3801         	subs	r0, #0x1
   63eea: ece1 0b02    	vstmia	r1!, {d16}
   63eee: e7f8         	b	0x63ee2 <air1_opcal4_algorithm+0x27fa> @ imm = #-0x10
   63ef0: 2000         	movs	r0, #0x0
   63ef2: 28f0         	cmp	r0, #0xf0
   63ef4: d007         	beq	0x63f06 <air1_opcal4_algorithm+0x281e> @ imm = #0xe
   63ef6: 1832         	adds	r2, r6, r0
   63ef8: 1829         	adds	r1, r5, r0
   63efa: 3008         	adds	r0, #0x8
   63efc: edd2 0b70    	vldr	d16, [r2, #448]
   63f00: edc1 0b00    	vstr	d16, [r1]
   63f04: e7f5         	b	0x63ef2 <air1_opcal4_algorithm+0x280a> @ imm = #-0x16
   63f06: 4658         	mov	r0, r11
   63f08: f506 752c    	add.w	r5, r6, #0x2b0
   63f0c: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   63f10: f506 7468    	add.w	r4, r6, #0x3a0
   63f14: f04f 0800    	mov.w	r8, #0x0
   63f18: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   63f1c: f900 8acf    	vst1.64	{d8, d9}, [r0]
   63f20: f1b8 0f1d    	cmp.w	r8, #0x1d
   63f24: d83e         	bhi	0x63fa4 <air1_opcal4_algorithm+0x28bc> @ imm = #0x7c
   63f26: 2000         	movs	r0, #0x0
   63f28: 2830         	cmp	r0, #0x30
   63f2a: d008         	beq	0x63f3e <air1_opcal4_algorithm+0x2856> @ imm = #0x10
   63f2c: 182a         	adds	r2, r5, r0
   63f2e: eb0b 0100    	add.w	r1, r11, r0
   63f32: 3008         	adds	r0, #0x8
   63f34: edd2 0b00    	vldr	d16, [r2]
   63f38: edc1 0b00    	vstr	d16, [r1]
   63f3c: e7f4         	b	0x63f28 <air1_opcal4_algorithm+0x2840> @ imm = #-0x18
   63f3e: 4e50         	ldr	r6, [pc, #0x140]        @ 0x64080 <air1_opcal4_algorithm+0x2998>
   63f40: 4658         	mov	r0, r11
   63f42: 2103         	movs	r1, #0x3
   63f44: 447e         	add	r6, pc
   63f46: 47b0         	blx	r6
   63f48: 4658         	mov	r0, r11
   63f4a: 2104         	movs	r1, #0x4
   63f4c: ed89 0b00    	vstr	d0, [r9]
   63f50: 47b0         	blx	r6
   63f52: 4658         	mov	r0, r11
   63f54: 2105         	movs	r1, #0x5
   63f56: ed89 0b02    	vstr	d0, [r9, #8]
   63f5a: 47b0         	blx	r6
   63f5c: 4658         	mov	r0, r11
   63f5e: 2106         	movs	r1, #0x6
   63f60: ed89 0b04    	vstr	d0, [r9, #16]
   63f64: 47b0         	blx	r6
   63f66: 9858         	ldr	r0, [sp, #0x160]
   63f68: 2105         	movs	r1, #0x5
   63f6a: ed89 0b06    	vstr	d0, [r9, #24]
   63f6e: 47b0         	blx	r6
   63f70: 9859         	ldr	r0, [sp, #0x164]
   63f72: 2104         	movs	r1, #0x4
   63f74: ed89 0b08    	vstr	d0, [r9, #32]
   63f78: 47b0         	blx	r6
   63f7a: 9e5f         	ldr	r6, [sp, #0x17c]
   63f7c: f50d 633a    	add.w	r3, sp, #0xba0
   63f80: 2000         	movs	r0, #0x0
   63f82: ed89 0b0a    	vstr	d0, [r9, #40]
   63f86: 2830         	cmp	r0, #0x30
   63f88: d007         	beq	0x63f9a <air1_opcal4_algorithm+0x28b2> @ imm = #0xe
   63f8a: 181a         	adds	r2, r3, r0
   63f8c: 1821         	adds	r1, r4, r0
   63f8e: 3008         	adds	r0, #0x8
   63f90: edd2 0b00    	vldr	d16, [r2]
   63f94: edc1 0b00    	vstr	d16, [r1]
   63f98: e7f5         	b	0x63f86 <air1_opcal4_algorithm+0x289e> @ imm = #-0x16
   63f9a: 3430         	adds	r4, #0x30
   63f9c: 3530         	adds	r5, #0x30
   63f9e: f108 0806    	add.w	r8, r8, #0x6
   63fa2: e7bd         	b	0x63f20 <air1_opcal4_algorithm+0x2838> @ imm = #-0x86
   63fa4: 4658         	mov	r0, r11
   63fa6: f44f 7184    	mov.w	r1, #0x108
   63faa: f00b e82a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xb054
   63fae: f8ba 9648    	ldrh.w	r9, [r10, #0x648]
   63fb2: f1b9 0f01    	cmp.w	r9, #0x1
   63fb6: d910         	bls	0x63fda <air1_opcal4_algorithm+0x28f2> @ imm = #0x20
   63fb8: ed9a 0a50    	vldr	s0, [r10, #320]
   63fbc: ed9a 1a70    	vldr	s2, [r10, #448]
   63fc0: eef8 0b40    	vcvt.f64.u32	d16, s0
   63fc4: eef8 1b41    	vcvt.f64.u32	d17, s2
   63fc8: ee71 0be0    	vsub.f64	d16, d17, d16
   63fcc: eddf 1b2e    	vldr	d17, [pc, #184]         @ 0x64088 <air1_opcal4_algorithm+0x29a0>
   63fd0: eef4 0b61    	vcmp.f64	d16, d17
   63fd4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   63fd8: d40f         	bmi	0x63ffa <air1_opcal4_algorithm+0x2912> @ imm = #0x1e
   63fda: f8dd 814c    	ldr.w	r8, [sp, #0x14c]
   63fde: 2000         	movs	r0, #0x0
   63fe0: 9c16         	ldr	r4, [sp, #0x58]
   63fe2: 28f0         	cmp	r0, #0xf0
   63fe4: f000 80ae    	beq.w	0x64144 <air1_opcal4_algorithm+0x2a5c> @ imm = #0x15c
   63fe8: 1831         	adds	r1, r6, r0
   63fea: 3008         	adds	r0, #0x8
   63fec: f501 6292    	add.w	r2, r1, #0x490
   63ff0: edd1 0be8    	vldr	d16, [r1, #928]
   63ff4: edc2 0b00    	vstr	d16, [r2]
   63ff8: e7f3         	b	0x63fe2 <air1_opcal4_algorithm+0x28fa> @ imm = #-0x1a
   63ffa: eef1 3b0c    	vmov.f64	d19, #7.000000e+00
   63ffe: f8dd 814c    	ldr.w	r8, [sp, #0x14c]
   64002: 9c16         	ldr	r4, [sp, #0x58]
   64004: 2000         	movs	r0, #0x0
   64006: 9b0c         	ldr	r3, [sp, #0x30]
   64008: 9d02         	ldr	r5, [sp, #0x8]
   6400a: 2818         	cmp	r0, #0x18
   6400c: d008         	beq	0x64020 <air1_opcal4_algorithm+0x2938> @ imm = #0x10
   6400e: 182a         	adds	r2, r5, r0
   64010: eb0b 0100    	add.w	r1, r11, r0
   64014: 3008         	adds	r0, #0x8
   64016: edd2 0b00    	vldr	d16, [r2]
   6401a: edc1 0b00    	vstr	d16, [r1]
   6401e: e7f4         	b	0x6400a <air1_opcal4_algorithm+0x2922> @ imm = #-0x18
   64020: 2000         	movs	r0, #0x0
   64022: 28f0         	cmp	r0, #0xf0
   64024: d007         	beq	0x64036 <air1_opcal4_algorithm+0x294e> @ imm = #0xe
   64026: 1832         	adds	r2, r6, r0
   64028: 1819         	adds	r1, r3, r0
   6402a: 3008         	adds	r0, #0x8
   6402c: edd2 0be8    	vldr	d16, [r2, #928]
   64030: edc1 0b00    	vstr	d16, [r1]
   64034: e7f5         	b	0x64022 <air1_opcal4_algorithm+0x293a> @ imm = #-0x16
   64036: f50d 6167    	add.w	r1, sp, #0xe70
   6403a: 2003         	movs	r0, #0x3
   6403c: 281e         	cmp	r0, #0x1e
   6403e: d029         	beq	0x64094 <air1_opcal4_algorithm+0x29ac> @ imm = #0x52
   64040: efc0 0010    	vmov.i32	d16, #0x0
   64044: 2200         	movs	r2, #0x0
   64046: 2a38         	cmp	r2, #0x38
   64048: d00b         	beq	0x64062 <air1_opcal4_algorithm+0x297a> @ imm = #0x16
   6404a: 188b         	adds	r3, r1, r2
   6404c: edd3 1b00    	vldr	d17, [r3]
   64050: 4b0f         	ldr	r3, [pc, #0x3c]         @ 0x64090 <air1_opcal4_algorithm+0x29a8>
   64052: 447b         	add	r3, pc
   64054: 4413         	add	r3, r2
   64056: 3208         	adds	r2, #0x8
   64058: edd3 2b00    	vldr	d18, [r3]
   6405c: ee42 0ba1    	vmla.f64	d16, d18, d17
   64060: e7f1         	b	0x64046 <air1_opcal4_algorithm+0x295e> @ imm = #-0x1e
   64062: eec0 0ba3    	vdiv.f64	d16, d16, d19
   64066: eb06 02c0    	add.w	r2, r6, r0, lsl #3
   6406a: f502 628f    	add.w	r2, r2, #0x478
   6406e: 3108         	adds	r1, #0x8
   64070: 3001         	adds	r0, #0x1
   64072: edc2 0b00    	vstr	d16, [r2]
   64076: e7e1         	b	0x6403c <air1_opcal4_algorithm+0x2954> @ imm = #-0x3e
   64078: 00 00 f0 3f  	.word	0x3ff00000
   6407c: 9e f4 00 00  	.word	0x0000f49e
   64080: 09 8a 00 00  	.word	0x00008a09
   64084: 00 bf 00 bf  	.word	0xbf00bf00
   64088: 33 33 33 33  	.word	0x33333333
   6408c: 33 73 74 40  	.word	0x40747333
   64090: 7a d0 fc ff  	.word	0xfffcd07a
   64094: f50d 6040    	add.w	r0, sp, #0xc00
   64098: eefd 9b00    	vmov.f64	d25, #-2.500000e-01
   6409c: edd0 0bd2    	vldr	d16, [r0, #840]
   640a0: f50d 6040    	add.w	r0, sp, #0xc00
   640a4: eef7 ab0c    	vmov.f64	d26, #1.750000e+00
   640a8: edd0 1bd4    	vldr	d17, [r0, #848]
   640ac: f50d 6040    	add.w	r0, sp, #0xc00
   640b0: edd0 2bd6    	vldr	d18, [r0, #856]
   640b4: f50d 6040    	add.w	r0, sp, #0xc00
   640b8: edd0 3bd8    	vldr	d19, [r0, #864]
   640bc: f50d 6040    	add.w	r0, sp, #0xc00
   640c0: ef63 41b3    	vorr	d20, d19, d19
   640c4: edd0 5bda    	vldr	d21, [r0, #872]
   640c8: f50d 6040    	add.w	r0, sp, #0xc00
   640cc: ee42 4ba9    	vmla.f64	d20, d18, d25
   640d0: ee65 6baa    	vmul.f64	d22, d21, d26
   640d4: edd0 7bdc    	vldr	d23, [r0, #880]
   640d8: f506 60af    	add.w	r0, r6, #0x578
   640dc: ee76 4ba4    	vadd.f64	d20, d22, d20
   640e0: ee77 8ba7    	vadd.f64	d24, d23, d23
   640e4: ee78 4ba4    	vadd.f64	d20, d24, d20
   640e8: eef1 8b02    	vmov.f64	d24, #4.500000e+00
   640ec: eec4 4ba8    	vdiv.f64	d20, d20, d24
   640f0: edc0 4b00    	vstr	d20, [r0]
   640f4: f506 60ae    	add.w	r0, r6, #0x570
   640f8: eef0 4b62    	vmov.f64	d20, d18
   640fc: ee41 4ba9    	vmla.f64	d20, d17, d25
   64100: ee40 1ba9    	vmla.f64	d17, d16, d25
   64104: ee43 4baa    	vmla.f64	d20, d19, d26
   64108: ee42 1baa    	vmla.f64	d17, d18, d26
   6410c: ee75 5ba5    	vadd.f64	d21, d21, d21
   64110: ee73 0ba3    	vadd.f64	d16, d19, d19
   64114: ee75 4ba4    	vadd.f64	d20, d21, d20
   64118: ee70 0ba1    	vadd.f64	d16, d16, d17
   6411c: ee47 4baa    	vmla.f64	d20, d23, d26
   64120: ee76 0ba0    	vadd.f64	d16, d22, d16
   64124: ee77 0ba0    	vadd.f64	d16, d23, d16
   64128: eef1 5b09    	vmov.f64	d21, #6.250000e+00
   6412c: eef1 1b0d    	vmov.f64	d17, #7.250000e+00
   64130: eec4 4ba5    	vdiv.f64	d20, d20, d21
   64134: eec0 0ba1    	vdiv.f64	d16, d16, d17
   64138: edc0 4b00    	vstr	d20, [r0]
   6413c: f506 60ad    	add.w	r0, r6, #0x568
   64140: edc0 0b00    	vstr	d16, [r0]
   64144: f640 7048    	movw	r0, #0xf48
   64148: f5b0 6f76    	cmp.w	r0, #0xf60
   6414c: d00a         	beq	0x64164 <air1_opcal4_algorithm+0x2a7c> @ imm = #0x14
   6414e: 1832         	adds	r2, r6, r0
   64150: eb0a 0100    	add.w	r1, r10, r0
   64154: f5a2 622d    	sub.w	r2, r2, #0xad0
   64158: 3008         	adds	r0, #0x8
   6415a: edd2 0b00    	vldr	d16, [r2]
   6415e: edc1 0b00    	vstr	d16, [r1]
   64162: e7f1         	b	0x64148 <air1_opcal4_algorithm+0x2a60> @ imm = #-0x1e
   64164: 48e7         	ldr	r0, [pc, #0x39c]        @ 0x64504 <air1_opcal4_algorithm+0x2e1c>
   64166: b160         	cbz	r0, 0x64182 <air1_opcal4_algorithm+0x2a9a> @ imm = #0x18
   64168: eb0a 0200    	add.w	r2, r10, r0
   6416c: 1821         	adds	r1, r4, r0
   6416e: f502 42b1    	add.w	r2, r2, #0x5880
   64172: f501 61af    	add.w	r1, r1, #0x578
   64176: 3008         	adds	r0, #0x8
   64178: edd2 0b00    	vldr	d16, [r2]
   6417c: edc1 0b00    	vstr	d16, [r1]
   64180: e7f1         	b	0x64166 <air1_opcal4_algorithm+0x2a7e> @ imm = #-0x1e
   64182: f506 6097    	add.w	r0, r6, #0x4b8
   64186: 992f         	ldr	r1, [sp, #0xbc]
   64188: f506 6492    	add.w	r4, r6, #0x490
   6418c: 2500         	movs	r5, #0x0
   6418e: edd0 0b00    	vldr	d16, [r0]
   64192: f506 609d    	add.w	r0, r6, #0x4e8
   64196: edc1 0b00    	vstr	d16, [r1]
   6419a: edd0 0b00    	vldr	d16, [r0]
   6419e: f506 60a3    	add.w	r0, r6, #0x518
   641a2: edc1 0b02    	vstr	d16, [r1, #8]
   641a6: edd0 0b00    	vldr	d16, [r0]
   641aa: f506 60a9    	add.w	r0, r6, #0x548
   641ae: edc1 0b04    	vstr	d16, [r1, #16]
   641b2: edd0 0b00    	vldr	d16, [r0]
   641b6: f506 60af    	add.w	r0, r6, #0x578
   641ba: edc1 0b06    	vstr	d16, [r1, #24]
   641be: edd0 0b00    	vldr	d16, [r0]
   641c2: 4658         	mov	r0, r11
   641c4: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   641c8: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   641cc: edc1 0b08    	vstr	d16, [r1, #32]
   641d0: f900 8acf    	vst1.64	{d8, d9}, [r0]
   641d4: 2d05         	cmp	r5, #0x5
   641d6: d018         	beq	0x6420a <air1_opcal4_algorithm+0x2b22> @ imm = #0x30
   641d8: 2000         	movs	r0, #0x0
   641da: 2830         	cmp	r0, #0x30
   641dc: d008         	beq	0x641f0 <air1_opcal4_algorithm+0x2b08> @ imm = #0x10
   641de: 1822         	adds	r2, r4, r0
   641e0: eb0b 0100    	add.w	r1, r11, r0
   641e4: 3008         	adds	r0, #0x8
   641e6: edd2 0b00    	vldr	d16, [r2]
   641ea: edc1 0b00    	vstr	d16, [r1]
   641ee: e7f4         	b	0x641da <air1_opcal4_algorithm+0x2af2> @ imm = #-0x18
   641f0: 4658         	mov	r0, r11
   641f2: 2106         	movs	r1, #0x6
   641f4: f008 fd38    	bl	0x6cc68 <cal_average_without_min_max> @ imm = #0x8a70
   641f8: eb06 00c5    	add.w	r0, r6, r5, lsl #3
   641fc: 3430         	adds	r4, #0x30
   641fe: f500 60b0    	add.w	r0, r0, #0x580
   64202: 3501         	adds	r5, #0x1
   64204: ed80 0b00    	vstr	d0, [r0]
   64208: e7e4         	b	0x641d4 <air1_opcal4_algorithm+0x2aec> @ imm = #-0x38
   6420a: f8cd 915c    	str.w	r9, [sp, #0x15c]
   6420e: 2000         	movs	r0, #0x0
   64210: f645 3178    	movw	r1, #0x5b78
   64214: f8dd 9070    	ldr.w	r9, [sp, #0x70]
   64218: 9c17         	ldr	r4, [sp, #0x5c]
   6421a: f645 0594    	movw	r5, #0x5894
   6421e: f5b0 7f2f    	cmp.w	r0, #0x2bc
   64222: d00e         	beq	0x64242 <air1_opcal4_algorithm+0x2b5a> @ imm = #0x1c
   64224: eb0a 0200    	add.w	r2, r10, r0
   64228: f44f 46b1    	mov.w	r6, #0x5880
   6422c: 3004         	adds	r0, #0x4
   6422e: 5953         	ldr	r3, [r2, r5]
   64230: 5193         	str	r3, [r2, r6]
   64232: eb0a 0201    	add.w	r2, r10, r1
   64236: 3108         	adds	r1, #0x8
   64238: edd2 0b00    	vldr	d16, [r2]
   6423c: ed42 0b0a    	vstr	d16, [r2, #-40]
   64240: e7ed         	b	0x6421e <air1_opcal4_algorithm+0x2b36> @ imm = #-0x26
   64242: 9d5f         	ldr	r5, [sp, #0x17c]
   64244: 2000         	movs	r0, #0x0
   64246: f645 313c    	movw	r1, #0x5b3c
   6424a: 2828         	cmp	r0, #0x28
   6424c: d010         	beq	0x64270 <air1_opcal4_algorithm+0x2b88> @ imm = #0x20
   6424e: eb00 0240    	add.w	r2, r0, r0, lsl #1
   64252: 182b         	adds	r3, r5, r0
   64254: 442a         	add	r2, r5
   64256: f503 63b0    	add.w	r3, r3, #0x580
   6425a: 6e52         	ldr	r2, [r2, #0x64]
   6425c: f84a 2001    	str.w	r2, [r10, r1]
   64260: 1822         	adds	r2, r4, r0
   64262: 3104         	adds	r1, #0x4
   64264: edd3 0b00    	vldr	d16, [r3]
   64268: 3008         	adds	r0, #0x8
   6426a: edc2 0b00    	vstr	d16, [r2]
   6426e: e7ec         	b	0x6424a <air1_opcal4_algorithm+0x2b62> @ imm = #-0x28
   64270: 4659         	mov	r1, r11
   64272: 2000         	movs	r0, #0x0
   64274: f901 8acd    	vst1.64	{d8, d9}, [r1]!
   64278: f901 8acd    	vst1.64	{d8, d9}, [r1]!
   6427c: 6008         	str	r0, [r1]
   6427e: f8cd 0e94    	str.w	r0, [sp, #0xe94]
   64282: 2828         	cmp	r0, #0x28
   64284: d00a         	beq	0x6429c <air1_opcal4_algorithm+0x2bb4> @ imm = #0x14
   64286: 182a         	adds	r2, r5, r0
   64288: eb0b 0100    	add.w	r1, r11, r0
   6428c: f502 62b0    	add.w	r2, r2, #0x580
   64290: 3008         	adds	r0, #0x8
   64292: edd2 0b00    	vldr	d16, [r2]
   64296: edc1 0b00    	vstr	d16, [r1]
   6429a: e7f2         	b	0x64282 <air1_opcal4_algorithm+0x2b9a> @ imm = #-0x1c
   6429c: 4658         	mov	r0, r11
   6429e: 2105         	movs	r1, #0x5
   642a0: f008 fce2    	bl	0x6cc68 <cal_average_without_min_max> @ imm = #0x89c4
   642a4: f505 60b5    	add.w	r0, r5, #0x5a8
   642a8: f8dd e0c4    	ldr.w	lr, [sp, #0xc4]
   642ac: f8dd c06c    	ldr.w	r12, [sp, #0x6c]
   642b0: e9dd 5418    	ldrd	r5, r4, [sp, #96]
   642b4: e9dd 6311    	ldrd	r6, r3, [sp, #68]
   642b8: 9042         	str	r0, [sp, #0x108]
   642ba: ed80 0b00    	vstr	d0, [r0]
   642be: 2000         	movs	r0, #0x0
   642c0: f5b0 5fd8    	cmp.w	r0, #0x1b00
   642c4: d007         	beq	0x642d6 <air1_opcal4_algorithm+0x2bee> @ imm = #0xe
   642c6: 181a         	adds	r2, r3, r0
   642c8: 1831         	adds	r1, r6, r0
   642ca: 3008         	adds	r0, #0x8
   642cc: edd2 0b00    	vldr	d16, [r2]
   642d0: edc1 0b00    	vstr	d16, [r1]
   642d4: e7f4         	b	0x642c0 <air1_opcal4_algorithm+0x2bd8> @ imm = #-0x18
   642d6: 9842         	ldr	r0, [sp, #0x108]
   642d8: edd0 0b00    	vldr	d16, [r0]
   642dc: f89a 0002    	ldrb.w	r0, [r10, #0x2]
   642e0: edc8 0b00    	vstr	d16, [r8]
   642e4: 2801         	cmp	r0, #0x1
   642e6: d005         	beq	0x642f4 <air1_opcal4_algorithm+0x2c0c> @ imm = #0xa
   642e8: 9e5f         	ldr	r6, [sp, #0x17c]
   642ea: 2802         	cmp	r0, #0x2
   642ec: d10e         	bne	0x6430c <air1_opcal4_algorithm+0x2c24> @ imm = #0x1c
   642ee: 985c         	ldr	r0, [sp, #0x170]
   642f0: 3050         	adds	r0, #0x50
   642f2: e002         	b	0x642fa <air1_opcal4_algorithm+0x2c12> @ imm = #0x4
   642f4: 985c         	ldr	r0, [sp, #0x170]
   642f6: 9e5f         	ldr	r6, [sp, #0x17c]
   642f8: 3048         	adds	r0, #0x48
   642fa: edd0 1b00    	vldr	d17, [r0]
   642fe: f506 60b6    	add.w	r0, r6, #0x5b0
   64302: ee70 0be1    	vsub.f64	d16, d16, d17
   64306: edc0 0b00    	vstr	d16, [r0]
   6430a: e003         	b	0x64314 <air1_opcal4_algorithm+0x2c2c> @ imm = #0x6
   6430c: f506 60b6    	add.w	r0, r6, #0x5b0
   64310: edd0 0b00    	vldr	d16, [r0]
   64314: 995c         	ldr	r1, [sp, #0x170]
   64316: f891 0058    	ldrb.w	r0, [r1, #0x58]
   6431a: 2801         	cmp	r0, #0x1
   6431c: d111         	bne	0x64342 <air1_opcal4_algorithm+0x2c5a> @ imm = #0x22
   6431e: f101 0060    	add.w	r0, r1, #0x60
   64322: ecf0 1b08    	vldmia	r0!, {d17, d18, d19, d20}
   64326: ee60 2ba2    	vmul.f64	d18, d16, d18
   6432a: ee60 1ba1    	vmul.f64	d17, d16, d17
   6432e: ee60 1ba1    	vmul.f64	d17, d16, d17
   64332: ee60 2ba2    	vmul.f64	d18, d16, d18
   64336: ee41 2ba0    	vmla.f64	d18, d17, d16
   6433a: ee43 2ba0    	vmla.f64	d18, d19, d16
   6433e: ee74 0ba2    	vadd.f64	d16, d20, d18
   64342: 4608         	mov	r0, r1
   64344: f506 61b7    	add.w	r1, r6, #0x5b8
   64348: 913c         	str	r1, [sp, #0xf0]
   6434a: edc1 0b00    	vstr	d16, [r1]
   6434e: 9957         	ldr	r1, [sp, #0x15c]
   64350: 2901         	cmp	r1, #0x1
   64352: d954         	bls	0x643fe <air1_opcal4_algorithm+0x2d16> @ imm = #0xa8
   64354: 4602         	mov	r2, r0
   64356: f8b0 1084    	ldrh.w	r1, [r0, #0x84]
   6435a: 8830         	ldrh	r0, [r6]
   6435c: f8b2 2082    	ldrh.w	r2, [r2, #0x82]
   64360: 4290         	cmp	r0, r2
   64362: d902         	bls	0x6436a <air1_opcal4_algorithm+0x2c82> @ imm = #0x4
   64364: 4288         	cmp	r0, r1
   64366: f240 8085    	bls.w	0x64474 <air1_opcal4_algorithm+0x2d8c> @ imm = #0x10a
   6436a: 4288         	cmp	r0, r1
   6436c: bf84         	itt	hi
   6436e: f8b8 100c    	ldrhhi.w	r1, [r8, #0xc]
   64372: f5b1 7f90    	cmphi.w	r1, #0x120
   64376: d943         	bls	0x64400 <air1_opcal4_algorithm+0x2d18> @ imm = #0x86
   64378: ee00 1a10    	vmov	s0, r1
   6437c: f8b8 1008    	ldrh.w	r1, [r8, #0x8]
   64380: eeff 4b00    	vmov.f64	d20, #-1.000000e+00
   64384: eef8 2b40    	vcvt.f64.u32	d18, s0
   64388: ee00 1a10    	vmov	s0, r1
   6438c: f8b8 100a    	ldrh.w	r1, [r8, #0xa]
   64390: edd8 5b0c    	vldr	d21, [r8, #48]
   64394: eef8 1b40    	vcvt.f64.u32	d17, s0
   64398: ee00 1a10    	vmov	s0, r1
   6439c: eddf 6b5a    	vldr	d22, [pc, #360]         @ 0x64508 <air1_opcal4_algorithm+0x2e20>
   643a0: eec1 1ba2    	vdiv.f64	d17, d17, d18
   643a4: eef8 3b40    	vcvt.f64.u32	d19, s0
   643a8: eec3 3ba2    	vdiv.f64	d19, d19, d18
   643ac: ee72 2ba4    	vadd.f64	d18, d18, d20
   643b0: eec5 2ba2    	vdiv.f64	d18, d21, d18
   643b4: eef1 2be2    	vsqrt.f64	d18, d18
   643b8: edd8 4b0a    	vldr	d20, [r8, #40]
   643bc: ee61 1ba6    	vmul.f64	d17, d17, d22
   643c0: eec2 2ba4    	vdiv.f64	d18, d18, d20
   643c4: ee62 2ba6    	vmul.f64	d18, d18, d22
   643c8: ee63 3ba6    	vmul.f64	d19, d19, d22
   643cc: eddf 4b50    	vldr	d20, [pc, #320]         @ 0x64510 <air1_opcal4_algorithm+0x2e28>
   643d0: edc8 1b04    	vstr	d17, [r8, #16]
   643d4: eef4 2b64    	vcmp.f64	d18, d20
   643d8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   643dc: edc8 3b06    	vstr	d19, [r8, #24]
   643e0: edc8 2b08    	vstr	d18, [r8, #32]
   643e4: dc07         	bgt	0x643f6 <air1_opcal4_algorithm+0x2d0e> @ imm = #0xe
   643e6: eef1 4b04    	vmov.f64	d20, #5.000000e+00
   643ea: eef4 3b64    	vcmp.f64	d19, d20
   643ee: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   643f2: f341 8375    	ble.w	0x65ae0 <air1_opcal4_algorithm+0x43f8> @ imm = #0x16ea
   643f6: 2106         	movs	r1, #0x6
   643f8: f888 100e    	strb.w	r1, [r8, #0xe]
   643fc: e000         	b	0x64400 <air1_opcal4_algorithm+0x2d18> @ imm = #0x0
   643fe: 8830         	ldrh	r0, [r6]
   64400: 9a5c         	ldr	r2, [sp, #0x170]
   64402: f892 1080    	ldrb.w	r1, [r2, #0x80]
   64406: 2901         	cmp	r1, #0x1
   64408: d12b         	bne	0x64462 <air1_opcal4_algorithm+0x2d7a> @ imm = #0x56
   6440a: f8b2 1090    	ldrh.w	r1, [r2, #0x90]
   6440e: 2805         	cmp	r0, #0x5
   64410: edd2 1b22    	vldr	d17, [r2, #136]
   64414: d31a         	blo	0x6444c <air1_opcal4_algorithm+0x2d64> @ imm = #0x34
   64416: 4288         	cmp	r0, r1
   64418: d818         	bhi	0x6444c <air1_opcal4_algorithm+0x2d64> @ imm = #0x30
   6441a: eef6 2b00    	vmov.f64	d18, #5.000000e-01
   6441e: eef4 0b62    	vcmp.f64	d16, d18
   64422: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64426: db11         	blt	0x6444c <air1_opcal4_algorithm+0x2d64> @ imm = #0x22
   64428: eddf 2b3b    	vldr	d18, [pc, #236]         @ 0x64518 <air1_opcal4_algorithm+0x2e30>
   6442c: eef4 0b62    	vcmp.f64	d16, d18
   64430: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64434: d80a         	bhi	0x6444c <air1_opcal4_algorithm+0x2d64> @ imm = #0x14
   64436: edd8 2b1c    	vldr	d18, [r8, #112]
   6443a: f8b8 2078    	ldrh.w	r2, [r8, #0x78]
   6443e: ee70 2ba2    	vadd.f64	d18, d16, d18
   64442: 3201         	adds	r2, #0x1
   64444: f8a8 2078    	strh.w	r2, [r8, #0x78]
   64448: edc8 2b1c    	vstr	d18, [r8, #112]
   6444c: f898 20a8    	ldrb.w	r2, [r8, #0xa8]
   64450: 4288         	cmp	r0, r1
   64452: d209         	bhs	0x64468 <air1_opcal4_algorithm+0x2d80> @ imm = #0x12
   64454: 2a00         	cmp	r2, #0x0
   64456: d052         	beq	0x644fe <air1_opcal4_algorithm+0x2e16> @ imm = #0xa4
   64458: edd8 2b24    	vldr	d18, [r8, #144]
   6445c: edd8 3b26    	vldr	d19, [r8, #152]
   64460: e0a0         	b	0x645a4 <air1_opcal4_algorithm+0x2ebc> @ imm = #0x140
   64462: ef60 21b0    	vorr	d18, d16, d16
   64466: e153         	b	0x64710 <air1_opcal4_algorithm+0x3028> @ imm = #0x2a6
   64468: 2a00         	cmp	r2, #0x0
   6446a: f000 8085    	beq.w	0x64578 <air1_opcal4_algorithm+0x2e90> @ imm = #0x10a
   6446e: edd8 2b26    	vldr	d18, [r8, #152]
   64472: e091         	b	0x64598 <air1_opcal4_algorithm+0x2eb0> @ imm = #0x122
   64474: edd8 1b0e    	vldr	d17, [r8, #56]
   64478: eddf 2b29    	vldr	d18, [pc, #164]         @ 0x64520 <air1_opcal4_algorithm+0x2e38>
   6447c: eef4 1b62    	vcmp.f64	d17, d18
   64480: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64484: dbbc         	blt	0x64400 <air1_opcal4_algorithm+0x2d18> @ imm = #-0x88
   64486: eddf 2b28    	vldr	d18, [pc, #160]         @ 0x64528 <air1_opcal4_algorithm+0x2e40>
   6448a: eef4 1b62    	vcmp.f64	d17, d18
   6448e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64492: d8b5         	bhi	0x64400 <air1_opcal4_algorithm+0x2d18> @ imm = #-0x96
   64494: eddf 2b26    	vldr	d18, [pc, #152]         @ 0x64530 <air1_opcal4_algorithm+0x2e48>
   64498: f8b8 100c    	ldrh.w	r1, [r8, #0xc]
   6449c: eef4 1b62    	vcmp.f64	d17, d18
   644a0: 3101         	adds	r1, #0x1
   644a2: f8a8 100c    	strh.w	r1, [r8, #0xc]
   644a6: b289         	uxth	r1, r1
   644a8: eddf 2b23    	vldr	d18, [pc, #140]         @ 0x64538 <air1_opcal4_algorithm+0x2e50>
   644ac: ee00 1a10    	vmov	s0, r1
   644b0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   644b4: bfc2         	ittt	gt
   644b6: f8b8 2008    	ldrhgt.w	r2, [r8, #0x8]
   644ba: 3201         	addgt	r2, #0x1
   644bc: f8a8 2008    	strhgt.w	r2, [r8, #0x8]
   644c0: eef4 1b62    	vcmp.f64	d17, d18
   644c4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   644c8: bf42         	ittt	mi
   644ca: f8b8 200a    	ldrhmi.w	r2, [r8, #0xa]
   644ce: 3201         	addmi	r2, #0x1
   644d0: f8a8 200a    	strhmi.w	r2, [r8, #0xa]
   644d4: edd8 2b0a    	vldr	d18, [r8, #40]
   644d8: eef8 5b40    	vcvt.f64.u32	d21, s0
   644dc: ee71 4be2    	vsub.f64	d20, d17, d18
   644e0: eec4 5ba5    	vdiv.f64	d21, d20, d21
   644e4: ee72 2ba5    	vadd.f64	d18, d18, d21
   644e8: ee71 1be2    	vsub.f64	d17, d17, d18
   644ec: edd8 3b0c    	vldr	d19, [r8, #48]
   644f0: ee44 3ba1    	vmla.f64	d19, d20, d17
   644f4: edc8 2b0a    	vstr	d18, [r8, #40]
   644f8: edc8 3b0c    	vstr	d19, [r8, #48]
   644fc: e780         	b	0x64400 <air1_opcal4_algorithm+0x2d18> @ imm = #-0x100
   644fe: efc0 1010    	vmov.i32	d17, #0x0
   64502: e067         	b	0x645d4 <air1_opcal4_algorithm+0x2eec> @ imm = #0xce
   64504: 88 fa ff ff  	.word	0xfffffa88
   64508: 00 00 00 00  	.word	0x00000000
   6450c: 00 00 59 40  	.word	0x40590000
   64510: 00 00 00 00  	.word	0x00000000
   64514: 00 00 42 40  	.word	0x40420000
   64518: 00 00 00 00  	.word	0x00000000
   6451c: 00 00 49 40  	.word	0x40490000
   64520: 00 00 00 00  	.word	0x00000000
   64524: 00 00 44 40  	.word	0x40440000
   64528: 00 00 00 00  	.word	0x00000000
   6452c: 00 c0 82 40  	.word	0x4082c000
   64530: 00 00 00 00  	.word	0x00000000
   64534: 00 80 66 40  	.word	0x40668000
   64538: 00 00 00 00  	.word	0x00000000
   6453c: 00 80 51 40  	.word	0x40518000
   64540: 00 00 00 00  	.word	0x00000000
   64544: 80 84 2e 41  	.word	0x412e8480
   64548: 66 66 66 66  	.word	0x66666666
   6454c: 66 66 ee 3f  	.word	0x3fee6666
   64550: 33 33 33 33  	.word	0x33333333
   64554: 33 33 eb 3f  	.word	0x3feb3333
   64558: 9a 99 99 99  	.word	0x9999999a
   6455c: 99 99 e9 3f  	.word	0x3fe99999
   64560: 00 00 00 00  	.word	0x00000000
   64564: 00 00 00 80  	.word	0x80000000
   64568: 00 00 00 00  	.word	0x00000000
   6456c: 00 80 46 40  	.word	0x40468000
   64570: 00 00 00 00  	.word	0x00000000
   64574: 00 00 f8 7f  	.word	0x7ff80000
   64578: 2101         	movs	r1, #0x1
   6457a: ef60 21b0    	vorr	d18, d16, d16
   6457e: f888 10a8    	strb.w	r1, [r8, #0xa8]
   64582: f8b8 1078    	ldrh.w	r1, [r8, #0x78]
   64586: b139         	cbz	r1, 0x64598 <air1_opcal4_algorithm+0x2eb0> @ imm = #0xe
   64588: ee00 1a10    	vmov	s0, r1
   6458c: edd8 2b1c    	vldr	d18, [r8, #112]
   64590: eef8 3b40    	vcvt.f64.u32	d19, s0
   64594: eec2 2ba3    	vdiv.f64	d18, d18, d19
   64598: ef60 31b0    	vorr	d19, d16, d16
   6459c: edc8 2b24    	vstr	d18, [r8, #144]
   645a0: edc8 0b26    	vstr	d16, [r8, #152]
   645a4: ed5f 4b1a    	vldr	d20, [pc, #-104]        @ 0x64540 <air1_opcal4_algorithm+0x2e58>
   645a8: eeff 6b00    	vmov.f64	d22, #-1.000000e+00
   645ac: eec1 1ba4    	vdiv.f64	d17, d17, d20
   645b0: ee71 4ba6    	vadd.f64	d20, d17, d22
   645b4: ee7f 5b61    	vsub.f64	d21, d15, d17
   645b8: ee71 1ba1    	vadd.f64	d17, d17, d17
   645bc: ee71 6ba6    	vadd.f64	d22, d17, d22
   645c0: ee64 1ba2    	vmul.f64	d17, d20, d18
   645c4: ee45 1ba3    	vmla.f64	d17, d21, d19
   645c8: edd8 2b28    	vldr	d18, [r8, #160]
   645cc: ee46 1be2    	vmls.f64	d17, d22, d18
   645d0: edc8 1b28    	vstr	d17, [r8, #160]
   645d4: 995c         	ldr	r1, [sp, #0x170]
   645d6: f8b8 20aa    	ldrh.w	r2, [r8, #0xaa]
   645da: f8b1 1082    	ldrh.w	r1, [r1, #0x82]
   645de: 4288         	cmp	r0, r1
   645e0: d903         	bls	0x645ea <air1_opcal4_algorithm+0x2f02> @ imm = #0x6
   645e2: b91a         	cbnz	r2, 0x645ec <air1_opcal4_algorithm+0x2f04> @ imm = #0x6
   645e4: 9a57         	ldr	r2, [sp, #0x15c]
   645e6: f8a8 20aa    	strh.w	r2, [r8, #0xaa]
   645ea: b1f2         	cbz	r2, 0x6462a <air1_opcal4_algorithm+0x2f42> @ imm = #0x3c
   645ec: 995c         	ldr	r1, [sp, #0x170]
   645ee: f8b1 1084    	ldrh.w	r1, [r1, #0x84]
   645f2: 4288         	cmp	r0, r1
   645f4: d81d         	bhi	0x64632 <air1_opcal4_algorithm+0x2f4a> @ imm = #0x3a
   645f6: eef6 2b00    	vmov.f64	d18, #5.000000e-01
   645fa: eef4 0b62    	vcmp.f64	d16, d18
   645fe: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64602: db16         	blt	0x64632 <air1_opcal4_algorithm+0x2f4a> @ imm = #0x2c
   64604: ed5f 2b3c    	vldr	d18, [pc, #-240]        @ 0x64518 <air1_opcal4_algorithm+0x2e30>
   64608: eef4 0b62    	vcmp.f64	d16, d18
   6460c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64610: d80f         	bhi	0x64632 <air1_opcal4_algorithm+0x2f4a> @ imm = #0x1e
   64612: edd8 2b20    	vldr	d18, [r8, #128]
   64616: f8b8 3088    	ldrh.w	r3, [r8, #0x88]
   6461a: ee70 2ba2    	vadd.f64	d18, d16, d18
   6461e: 3301         	adds	r3, #0x1
   64620: f8a8 3088    	strh.w	r3, [r8, #0x88]
   64624: edc8 2b20    	vstr	d18, [r8, #128]
   64628: e003         	b	0x64632 <air1_opcal4_algorithm+0x2f4a> @ imm = #0x6
   6462a: 995c         	ldr	r1, [sp, #0x170]
   6462c: 2200         	movs	r2, #0x0
   6462e: f8b1 1084    	ldrh.w	r1, [r1, #0x84]
   64632: 4288         	cmp	r0, r1
   64634: d912         	bls	0x6465c <air1_opcal4_algorithm+0x2f74> @ imm = #0x24
   64636: f898 30ac    	ldrb.w	r3, [r8, #0xac]
   6463a: b97b         	cbnz	r3, 0x6465c <air1_opcal4_algorithm+0x2f74> @ imm = #0x1e
   6463c: 9b57         	ldr	r3, [sp, #0x15c]
   6463e: 429a         	cmp	r2, r3
   64640: d006         	beq	0x64650 <air1_opcal4_algorithm+0x2f68> @ imm = #0xc
   64642: 9a57         	ldr	r2, [sp, #0x15c]
   64644: f5b2 7f90    	cmp.w	r2, #0x120
   64648: d302         	blo	0x64650 <air1_opcal4_algorithm+0x2f68> @ imm = #0x4
   6464a: f8b8 2088    	ldrh.w	r2, [r8, #0x88]
   6464e: b912         	cbnz	r2, 0x64656 <air1_opcal4_algorithm+0x2f6e> @ imm = #0x4
   64650: 2200         	movs	r2, #0x0
   64652: f888 20ad    	strb.w	r2, [r8, #0xad]
   64656: 2201         	movs	r2, #0x1
   64658: f888 20ac    	strb.w	r2, [r8, #0xac]
   6465c: f898 200e    	ldrb.w	r2, [r8, #0xe]
   64660: 3a01         	subs	r2, #0x1
   64662: 2a05         	cmp	r2, #0x5
   64664: d811         	bhi	0x6468a <air1_opcal4_algorithm+0x2fa2> @ imm = #0x22
   64666: f8b8 3088    	ldrh.w	r3, [r8, #0x88]
   6466a: edd8 2b20    	vldr	d18, [r8, #128]
   6466e: ee00 3a10    	vmov	s0, r3
   64672: eef8 3b40    	vcvt.f64.u32	d19, s0
   64676: eec2 2ba3    	vdiv.f64	d18, d18, d19
   6467a: e8df f002    	tbb	[pc, r2]
   6467e: 03 09 0c 0f  	.word	0x0f0c0903
   64682: 12 17        	.short	0x1712
   64684: ee71 1ba2    	vadd.f64	d17, d17, d18
   64688: e012         	b	0x646b0 <air1_opcal4_algorithm+0x2fc8> @ imm = #0x24
   6468a: efc0 1010    	vmov.i32	d17, #0x0
   6468e: e00f         	b	0x646b0 <air1_opcal4_algorithm+0x2fc8> @ imm = #0x1e
   64690: ed5f 3b53    	vldr	d19, [pc, #-332]        @ 0x64548 <air1_opcal4_algorithm+0x2e60>
   64694: e007         	b	0x646a6 <air1_opcal4_algorithm+0x2fbe> @ imm = #0xe
   64696: ed5f 3b52    	vldr	d19, [pc, #-328]        @ 0x64550 <air1_opcal4_algorithm+0x2e68>
   6469a: e004         	b	0x646a6 <air1_opcal4_algorithm+0x2fbe> @ imm = #0x8
   6469c: ed5f 3b52    	vldr	d19, [pc, #-328]        @ 0x64558 <air1_opcal4_algorithm+0x2e70>
   646a0: e001         	b	0x646a6 <air1_opcal4_algorithm+0x2fbe> @ imm = #0x2
   646a2: eef6 3b08    	vmov.f64	d19, #7.500000e-01
   646a6: ee42 1ba3    	vmla.f64	d17, d18, d19
   646aa: e001         	b	0x646b0 <air1_opcal4_algorithm+0x2fc8> @ imm = #0x2
   646ac: eef0 1b60    	vmov.f64	d17, d16
   646b0: eef0 2b60    	vmov.f64	d18, d16
   646b4: f898 20ad    	ldrb.w	r2, [r8, #0xad]
   646b8: b31a         	cbz	r2, 0x64702 <air1_opcal4_algorithm+0x301a> @ imm = #0x46
   646ba: 9a5c         	ldr	r2, [sp, #0x170]
   646bc: eef0 2b60    	vmov.f64	d18, d16
   646c0: f8b2 2086    	ldrh.w	r2, [r2, #0x86]
   646c4: 4290         	cmp	r0, r2
   646c6: bf88         	it	hi
   646c8: eef0 2b61    	vmovhi.f64	d18, d17
   646cc: d819         	bhi	0x64702 <air1_opcal4_algorithm+0x301a> @ imm = #0x32
   646ce: 4288         	cmp	r0, r1
   646d0: d917         	bls	0x64702 <air1_opcal4_algorithm+0x301a> @ imm = #0x2e
   646d2: ee00 1a10    	vmov	s0, r1
   646d6: eef8 2b40    	vcvt.f64.u32	d18, s0
   646da: ee00 2a10    	vmov	s0, r2
   646de: eef8 3b40    	vcvt.f64.u32	d19, s0
   646e2: ee00 0a10    	vmov	s0, r0
   646e6: ee73 3be2    	vsub.f64	d19, d19, d18
   646ea: eef8 4b40    	vcvt.f64.u32	d20, s0
   646ee: ee74 2be2    	vsub.f64	d18, d20, d18
   646f2: eec2 2ba3    	vdiv.f64	d18, d18, d19
   646f6: ee7f 3b62    	vsub.f64	d19, d15, d18
   646fa: ee61 2ba2    	vmul.f64	d18, d17, d18
   646fe: ee43 2ba0    	vmla.f64	d18, d19, d16
   64702: eef4 2b60    	vcmp.f64	d18, d16
   64706: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6470a: bf48         	it	mi
   6470c: eef0 2b60    	vmovmi.f64	d18, d16
   64710: ee00 0a10    	vmov	s0, r0
   64714: f506 61b9    	add.w	r1, r6, #0x5c8
   64718: 9a5c         	ldr	r2, [sp, #0x170]
   6471a: eef8 0b40    	vcvt.f64.u32	d16, s0
   6471e: 9147         	str	r1, [sp, #0x11c]
   64720: edc1 2b00    	vstr	d18, [r1]
   64724: f506 61b8    	add.w	r1, r6, #0x5c0
   64728: 913b         	str	r1, [sp, #0xec]
   6472a: edc1 2b00    	vstr	d18, [r1]
   6472e: f892 1092    	ldrb.w	r1, [r2, #0x92]
   64732: 2901         	cmp	r1, #0x1
   64734: d12c         	bne	0x64790 <air1_opcal4_algorithm+0x30a8> @ imm = #0x58
   64736: f102 01a8    	add.w	r1, r2, #0xa8
   6473a: edd2 1b28    	vldr	d17, [r2, #160]
   6473e: ecf1 3b06    	vldmia	r1!, {d19, d20, d21}
   64742: ee61 1ba0    	vmul.f64	d17, d17, d16
   64746: ee63 3ba0    	vmul.f64	d19, d19, d16
   6474a: ee61 1ba0    	vmul.f64	d17, d17, d16
   6474e: ee63 3ba0    	vmul.f64	d19, d19, d16
   64752: ee41 3ba0    	vmla.f64	d19, d17, d16
   64756: ee44 3ba0    	vmla.f64	d19, d20, d16
   6475a: ee75 1ba3    	vadd.f64	d17, d21, d19
   6475e: eef4 1b4f    	vcmp.f64	d17, d15
   64762: eef0 3b4f    	vmov.f64	d19, d15
   64766: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6476a: dc0c         	bgt	0x64786 <air1_opcal4_algorithm+0x309e> @ imm = #0x18
   6476c: eef0 3b4f    	vmov.f64	d19, d15
   64770: f240 7124    	movw	r1, #0x724
   64774: 4288         	cmp	r0, r1
   64776: d806         	bhi	0x64786 <air1_opcal4_algorithm+0x309e> @ imm = #0xc
   64778: 995c         	ldr	r1, [sp, #0x170]
   6477a: edd1 4b26    	vldr	d20, [r1, #152]
   6477e: ee7f 3b64    	vsub.f64	d19, d15, d20
   64782: ee41 3ba4    	vmla.f64	d19, d17, d20
   64786: eec2 2ba3    	vdiv.f64	d18, d18, d19
   6478a: 9947         	ldr	r1, [sp, #0x11c]
   6478c: edc1 2b00    	vstr	d18, [r1]
   64790: 9957         	ldr	r1, [sp, #0x15c]
   64792: eeff 3b00    	vmov.f64	d19, #-1.000000e+00
   64796: f5b0 7f58    	cmp.w	r0, #0x360
   6479a: ee00 1a10    	vmov	s0, r1
   6479e: edd8 4b2c    	vldr	d20, [r8, #176]
   647a2: f506 61ba    	add.w	r1, r6, #0x5d0
   647a6: 913a         	str	r1, [sp, #0xe8]
   647a8: eef8 1b40    	vcvt.f64.u32	d17, s0
   647ac: ee71 3ba3    	vadd.f64	d19, d17, d19
   647b0: ee44 2ba3    	vmla.f64	d18, d20, d19
   647b4: eec2 1ba1    	vdiv.f64	d17, d18, d17
   647b8: edc1 1b00    	vstr	d17, [r1]
   647bc: 994f         	ldr	r1, [sp, #0x13c]
   647be: edc8 1b2c    	vstr	d17, [r8, #176]
   647c2: edd1 2b2c    	vldr	d18, [r1, #176]
   647c6: edc1 1b2e    	vstr	d17, [r1, #184]
   647ca: edc1 1b2c    	vstr	d17, [r1, #176]
   647ce: ee71 1be2    	vsub.f64	d17, d17, d18
   647d2: edc1 1b30    	vstr	d17, [r1, #192]
   647d6: d905         	bls	0x647e4 <air1_opcal4_algorithm+0x30fc> @ imm = #0xa
   647d8: 2201         	movs	r2, #0x1
   647da: ed5f 5b9f    	vldr	d21, [pc, #-636]        @ 0x64560 <air1_opcal4_algorithm+0x2e78>
   647de: f881 20ce    	strb.w	r2, [r1, #0xce]
   647e2: e02e         	b	0x64842 <air1_opcal4_algorithm+0x315a> @ imm = #0x5c
   647e4: f891 10ce    	ldrb.w	r1, [r1, #0xce]
   647e8: ed5f 5ba3    	vldr	d21, [pc, #-652]        @ 0x64560 <air1_opcal4_algorithm+0x2e78>
   647ec: bb49         	cbnz	r1, 0x64842 <air1_opcal4_algorithm+0x315a> @ imm = #0x52
   647ee: 995c         	ldr	r1, [sp, #0x170]
   647f0: f8b1 1300    	ldrh.w	r1, [r1, #0x300]
   647f4: 4288         	cmp	r0, r1
   647f6: d824         	bhi	0x64842 <air1_opcal4_algorithm+0x315a> @ imm = #0x48
   647f8: 9a5c         	ldr	r2, [sp, #0x170]
   647fa: edd2 2bc2    	vldr	d18, [r2, #776]
   647fe: eef4 1b62    	vcmp.f64	d17, d18
   64802: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64806: da18         	bge	0x6483a <air1_opcal4_algorithm+0x3152> @ imm = #0x30
   64808: edd2 2bc4    	vldr	d18, [r2, #784]
   6480c: eef4 1b62    	vcmp.f64	d17, d18
   64810: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64814: d911         	bls	0x6483a <air1_opcal4_algorithm+0x3152> @ imm = #0x22
   64816: 9b4f         	ldr	r3, [sp, #0x13c]
   64818: f8b3 10cc    	ldrh.w	r1, [r3, #0xcc]
   6481c: 3101         	adds	r1, #0x1
   6481e: f8a3 10cc    	strh.w	r1, [r3, #0xcc]
   64822: f8b2 2318    	ldrh.w	r2, [r2, #0x318]
   64826: b289         	uxth	r1, r1
   64828: 4291         	cmp	r1, r2
   6482a: bf81         	itttt	hi
   6482c: 994f         	ldrhi	r1, [sp, #0x13c]
   6482e: 2200         	movhi	r2, #0x0
   64830: f8a1 20cc    	strhhi.w	r2, [r1, #0xcc]
   64834: f8a1 00d0    	strhhi.w	r0, [r1, #0xd0]
   64838: e003         	b	0x64842 <air1_opcal4_algorithm+0x315a> @ imm = #0x6
   6483a: 994f         	ldr	r1, [sp, #0x13c]
   6483c: 2200         	movs	r2, #0x0
   6483e: f8a1 20cc    	strh.w	r2, [r1, #0xcc]
   64842: edd6 2b12    	vldr	d18, [r6, #72]
   64846: eef0 1b4a    	vmov.f64	d17, d10
   6484a: eef4 2b4a    	vcmp.f64	d18, d10
   6484e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64852: d40a         	bmi	0x6486a <air1_opcal4_algorithm+0x3182> @ imm = #0x14
   64854: ed5f 1bbc    	vldr	d17, [pc, #-752]        @ 0x64568 <air1_opcal4_algorithm+0x2e80>
   64858: eef4 2b61    	vcmp.f64	d18, d17
   6485c: eef0 1b62    	vmov.f64	d17, d18
   64860: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64864: bfc8         	it	gt
   64866: ed5f 1bc0    	vldrgt	d17, [pc, #-768]        @ 0x64568 <air1_opcal4_algorithm+0x2e80>
   6486a: 9957         	ldr	r1, [sp, #0x15c]
   6486c: 2901         	cmp	r1, #0x1
   6486e: d10b         	bne	0x64888 <air1_opcal4_algorithm+0x31a0> @ imm = #0x16
   64870: 2100         	movs	r1, #0x0
   64872: edc8 1b2e    	vstr	d17, [r8, #184]
   64876: 2918         	cmp	r1, #0x18
   64878: d038         	beq	0x648ec <air1_opcal4_algorithm+0x3204> @ imm = #0x70
   6487a: 2200         	movs	r2, #0x0
   6487c: 4bcf         	ldr	r3, [pc, #0x33c]        @ 0x64bbc <air1_opcal4_algorithm+0x34d4>
   6487e: 506a         	str	r2, [r5, r1]
   64880: 186a         	adds	r2, r5, r1
   64882: 3108         	adds	r1, #0x8
   64884: 6053         	str	r3, [r2, #0x4]
   64886: e7f6         	b	0x64876 <air1_opcal4_algorithm+0x318e> @ imm = #-0x14
   64888: f8ba 1d08    	ldrh.w	r1, [r10, #0xd08]
   6488c: 1a41         	subs	r1, r0, r1
   6488e: 2903         	cmp	r1, #0x3
   64890: d00c         	beq	0x648ac <air1_opcal4_algorithm+0x31c4> @ imm = #0x18
   64892: 2902         	cmp	r1, #0x2
   64894: d013         	beq	0x648be <air1_opcal4_algorithm+0x31d6> @ imm = #0x26
   64896: 2901         	cmp	r1, #0x1
   64898: d11a         	bne	0x648d0 <air1_opcal4_algorithm+0x31e8> @ imm = #0x34
   6489a: f108 01b8    	add.w	r1, r8, #0xb8
   6489e: ecf1 2b06    	vldmia	r1!, {d18, d19, d20}
   648a2: edc8 3b32    	vstr	d19, [r8, #200]
   648a6: edc8 4b34    	vstr	d20, [r8, #208]
   648aa: e01b         	b	0x648e4 <air1_opcal4_algorithm+0x31fc> @ imm = #0x36
   648ac: 49c3         	ldr	r1, [pc, #0x30c]        @ 0x64bbc <air1_opcal4_algorithm+0x34d4>
   648ae: 2200         	movs	r2, #0x0
   648b0: edd8 2b2e    	vldr	d18, [r8, #184]
   648b4: e9c8 2132    	strd	r2, r1, [r8, #200]
   648b8: edc8 2b34    	vstr	d18, [r8, #208]
   648bc: e010         	b	0x648e0 <air1_opcal4_algorithm+0x31f8> @ imm = #0x20
   648be: edd8 2b2e    	vldr	d18, [r8, #184]
   648c2: edd8 3b30    	vldr	d19, [r8, #192]
   648c6: edc8 2b32    	vstr	d18, [r8, #200]
   648ca: edc8 3b34    	vstr	d19, [r8, #208]
   648ce: e007         	b	0x648e0 <air1_opcal4_algorithm+0x31f8> @ imm = #0xe
   648d0: 2200         	movs	r2, #0x0
   648d2: 49ba         	ldr	r1, [pc, #0x2e8]        @ 0x64bbc <air1_opcal4_algorithm+0x34d4>
   648d4: f8c8 20c8    	str.w	r2, [r8, #0xc8]
   648d8: e9c8 1233    	strd	r1, r2, [r8, #204]
   648dc: f8c8 10d4    	str.w	r1, [r8, #0xd4]
   648e0: ed5f 2bdd    	vldr	d18, [pc, #-884]        @ 0x64570 <air1_opcal4_algorithm+0x2e88>
   648e4: edc8 1b2e    	vstr	d17, [r8, #184]
   648e8: edc8 2b30    	vstr	d18, [r8, #192]
   648ec: efc0 1010    	vmov.i32	d17, #0x0
   648f0: 9d13         	ldr	r5, [sp, #0x4c]
   648f2: 2100         	movs	r1, #0x0
   648f4: 2200         	movs	r2, #0x0
   648f6: 2920         	cmp	r1, #0x20
   648f8: d011         	beq	0x6491e <air1_opcal4_algorithm+0x3236> @ imm = #0x22
   648fa: 1863         	adds	r3, r4, r1
   648fc: ef65 31b5    	vorr	d19, d21, d21
   64900: edd3 2b00    	vldr	d18, [r3]
   64904: eef4 2b62    	vcmp.f64	d18, d18
   64908: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6490c: bf78         	it	vc
   6490e: 3201         	addvc	r2, #0x1
   64910: bf78         	it	vc
   64912: eef0 3b62    	vmovvc.f64	d19, d18
   64916: ee71 1ba3    	vadd.f64	d17, d17, d19
   6491a: 3108         	adds	r1, #0x8
   6491c: e7eb         	b	0x648f6 <air1_opcal4_algorithm+0x320e> @ imm = #-0x2a
   6491e: b2d1         	uxtb	r1, r2
   64920: eef5 1b40    	vcmp.f64	d17, #0
   64924: f506 64bb    	add.w	r4, r6, #0x5d8
   64928: f506 62bc    	add.w	r2, r6, #0x5e0
   6492c: ee00 1a10    	vmov	s0, r1
   64930: 995c         	ldr	r1, [sp, #0x170]
   64932: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64936: eef8 2b40    	vcvt.f64.u32	d18, s0
   6493a: eec1 4ba2    	vdiv.f64	d20, d17, d18
   6493e: edd1 5b94    	vldr	d21, [r1, #592]
   64942: edd1 2b96    	vldr	d18, [r1, #600]
   64946: edd1 3b98    	vldr	d19, [r1, #608]
   6494a: ee45 2ba4    	vmla.f64	d18, d21, d20
   6494e: edc4 4b00    	vstr	d20, [r4]
   64952: bf08         	it	eq
   64954: eef0 2b4f    	vmoveq.f64	d18, d15
   64958: eef4 2b63    	vcmp.f64	d18, d19
   6495c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64960: edc2 2b00    	vstr	d18, [r2]
   64964: d407         	bmi	0x64976 <air1_opcal4_algorithm+0x328e> @ imm = #0xe
   64966: 995c         	ldr	r1, [sp, #0x170]
   64968: edd1 3b9a    	vldr	d19, [r1, #616]
   6496c: eef4 2b63    	vcmp.f64	d18, d19
   64970: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64974: dd03         	ble	0x6497e <air1_opcal4_algorithm+0x3296> @ imm = #0x6
   64976: eef0 2b63    	vmov.f64	d18, d19
   6497a: edc2 3b00    	vstr	d19, [r2]
   6497e: 9933         	ldr	r1, [sp, #0xcc]
   64980: eddf 3b8f    	vldr	d19, [pc, #572]         @ 0x64bc0 <air1_opcal4_algorithm+0x34d8>
   64984: 9238         	str	r2, [sp, #0xe0]
   64986: 6809         	ldr	r1, [r1]
   64988: 9a47         	ldr	r2, [sp, #0x11c]
   6498a: ee00 1a10    	vmov	s0, r1
   6498e: 995c         	ldr	r1, [sp, #0x170]
   64990: eef7 1ac0    	vcvt.f64.f32	d17, s0
   64994: eec1 1ba3    	vdiv.f64	d17, d17, d19
   64998: edd1 3b00    	vldr	d19, [r1]
   6499c: ee63 1ba1    	vmul.f64	d17, d19, d17
   649a0: ee62 1ba1    	vmul.f64	d17, d18, d17
   649a4: edd2 2b00    	vldr	d18, [r2]
   649a8: f506 62bd    	add.w	r2, r6, #0x5e8
   649ac: 9237         	str	r2, [sp, #0xdc]
   649ae: ee82 bba1    	vdiv.f64	d11, d18, d17
   649b2: ed82 bb00    	vstr	d11, [r2]
   649b6: 9a57         	ldr	r2, [sp, #0x15c]
   649b8: f5b2 7f58    	cmp.w	r2, #0x360
   649bc: d90c         	bls	0x649d8 <air1_opcal4_algorithm+0x32f0> @ imm = #0x18
   649be: edd8 1b38    	vldr	d17, [r8, #224]
   649c2: edd8 2b3c    	vldr	d18, [r8, #240]
   649c6: edd8 3b40    	vldr	d19, [r8, #256]
   649ca: edc8 1b36    	vstr	d17, [r8, #216]
   649ce: edc8 2b3a    	vstr	d18, [r8, #232]
   649d2: edc8 3b3e    	vstr	d19, [r8, #248]
   649d6: e04f         	b	0x64a78 <air1_opcal4_algorithm+0x3390> @ imm = #0x9e
   649d8: f8b1 10d0    	ldrh.w	r1, [r1, #0xd0]
   649dc: 428a         	cmp	r2, r1
   649de: d108         	bne	0x649f2 <air1_opcal4_algorithm+0x330a> @ imm = #0x10
   649e0: 9a5c         	ldr	r2, [sp, #0x170]
   649e2: edd2 1b32    	vldr	d17, [r2, #200]
   649e6: edc8 1b40    	vstr	d17, [r8, #256]
   649ea: edc8 1b3c    	vstr	d17, [r8, #240]
   649ee: edc8 1b38    	vstr	d17, [r8, #224]
   649f2: 9b57         	ldr	r3, [sp, #0x15c]
   649f4: 4299         	cmp	r1, r3
   649f6: d23f         	bhs	0x64a78 <air1_opcal4_algorithm+0x3390> @ imm = #0x7e
   649f8: 9a5c         	ldr	r2, [sp, #0x170]
   649fa: 1a59         	subs	r1, r3, r1
   649fc: ed88 bb38    	vstr	d11, [r8, #224]
   64a00: edd8 1b36    	vldr	d17, [r8, #216]
   64a04: ee00 1a10    	vmov	s0, r1
   64a08: edd2 6b38    	vldr	d22, [r2, #224]
   64a0c: f506 61be    	add.w	r1, r6, #0x5f0
   64a10: edd2 5b36    	vldr	d21, [r2, #216]
   64a14: ee66 1ba1    	vmul.f64	d17, d22, d17
   64a18: ee45 1b8b    	vmla.f64	d17, d21, d11
   64a1c: edd8 2b3a    	vldr	d18, [r8, #232]
   64a20: edd2 7b3a    	vldr	d23, [r2, #232]
   64a24: edd8 4b42    	vldr	d20, [r8, #264]
   64a28: ee47 1ba2    	vmla.f64	d17, d23, d18
   64a2c: edc8 1b3c    	vstr	d17, [r8, #240]
   64a30: ee71 1ba4    	vadd.f64	d17, d17, d20
   64a34: eef8 2bc0    	vcvt.f64.s32	d18, s0
   64a38: eec1 2ba2    	vdiv.f64	d18, d17, d18
   64a3c: edd8 3b3e    	vldr	d19, [r8, #248]
   64a40: edc8 1b42    	vstr	d17, [r8, #264]
   64a44: ee72 1be3    	vsub.f64	d17, d18, d19
   64a48: edc8 2b40    	vstr	d18, [r8, #256]
   64a4c: edd2 2b30    	vldr	d18, [r2, #192]
   64a50: ed81 bb00    	vstr	d11, [r1]
   64a54: f506 61bf    	add.w	r1, r6, #0x5f8
   64a58: eef4 1b62    	vcmp.f64	d17, d18
   64a5c: edc1 1b00    	vstr	d17, [r1]
   64a60: f506 61c0    	add.w	r1, r6, #0x600
   64a64: efc0 1010    	vmov.i32	d17, #0x0
   64a68: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64a6c: bf48         	it	mi
   64a6e: eef0 1b4f    	vmovmi.f64	d17, d15
   64a72: edc1 1b00    	vstr	d17, [r1]
   64a76: e007         	b	0x64a88 <air1_opcal4_algorithm+0x33a0> @ imm = #0xe
   64a78: f506 61be    	add.w	r1, r6, #0x5f0
   64a7c: 2200         	movs	r2, #0x0
   64a7e: f901 8acd    	vst1.64	{d8, d9}, [r1]!
   64a82: f8c6 2604    	str.w	r2, [r6, #0x604]
   64a86: 600a         	str	r2, [r1]
   64a88: 9a5c         	ldr	r2, [sp, #0x170]
   64a8a: f8b2 1378    	ldrh.w	r1, [r2, #0x378]
   64a8e: 4288         	cmp	r0, r1
   64a90: d82d         	bhi	0x64aee <air1_opcal4_algorithm+0x3406> @ imm = #0x5a
   64a92: edd2 1be0    	vldr	d17, [r2, #896]
   64a96: eef4 1b4b    	vcmp.f64	d17, d11
   64a9a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64a9e: db26         	blt	0x64aee <air1_opcal4_algorithm+0x3406> @ imm = #0x4c
   64aa0: f502 7158    	add.w	r1, r2, #0x360
   64aa4: ee6b 4b0b    	vmul.f64	d20, d11, d11
   64aa8: ecf1 1b06    	vldmia	r1!, {d17, d18, d19}
   64aac: ee6b 2b22    	vmul.f64	d18, d11, d18
   64ab0: f8b2 1388    	ldrh.w	r1, [r2, #0x388]
   64ab4: 4288         	cmp	r0, r1
   64ab6: ee41 2ba4    	vmla.f64	d18, d17, d20
   64aba: ee73 1ba2    	vadd.f64	d17, d19, d18
   64abe: d914         	bls	0x64aea <air1_opcal4_algorithm+0x3402> @ imm = #0x28
   64ac0: ee00 1a10    	vmov	s0, r1
   64ac4: f8b2 138a    	ldrh.w	r1, [r2, #0x38a]
   64ac8: eef8 2b40    	vcvt.f64.u32	d18, s0
   64acc: ee00 1a10    	vmov	s0, r1
   64ad0: ee70 0be2    	vsub.f64	d16, d16, d18
   64ad4: eef8 2b40    	vcvt.f64.u32	d18, s0
   64ad8: eec0 0ba2    	vdiv.f64	d16, d16, d18
   64adc: ee2b bb20    	vmul.f64	d11, d11, d16
   64ae0: ee7f 2b60    	vsub.f64	d18, d15, d16
   64ae4: ee02 bba1    	vmla.f64	d11, d18, d17
   64ae8: e001         	b	0x64aee <air1_opcal4_algorithm+0x3406> @ imm = #0x2
   64aea: eeb0 bb61    	vmov.f64	d11, d17
   64aee: f506 61c1    	add.w	r1, r6, #0x608
   64af2: 9a1a         	ldr	r2, [sp, #0x68]
   64af4: 9136         	str	r1, [sp, #0xd8]
   64af6: ed81 bb00    	vstr	d11, [r1]
   64afa: 2102         	movs	r1, #0x2
   64afc: f1b1 3fff    	cmp.w	r1, #0xffffffff
   64b00: dd06         	ble	0x64b10 <air1_opcal4_algorithm+0x3428> @ imm = #0xc
   64b02: ed52 0b02    	vldr	d16, [r2, #-8]
   64b06: 3901         	subs	r1, #0x1
   64b08: edc2 0b00    	vstr	d16, [r2]
   64b0c: 3a08         	subs	r2, #0x8
   64b0e: e7f5         	b	0x64afc <air1_opcal4_algorithm+0x3414> @ imm = #-0x16
   64b10: 492a         	ldr	r1, [pc, #0xa8]         @ 0x64bbc <air1_opcal4_algorithm+0x34d4>
   64b12: 2200         	movs	r2, #0x0
   64b14: 9439         	str	r4, [sp, #0xe4]
   64b16: e9c8 214c    	strd	r2, r1, [r8, #304]
   64b1a: 9957         	ldr	r1, [sp, #0x15c]
   64b1c: 2901         	cmp	r1, #0x1
   64b1e: bf18         	it	ne
   64b20: 2809         	cmpne	r0, #0x9
   64b22: d822         	bhi	0x64b6a <air1_opcal4_algorithm+0x3482> @ imm = #0x44
   64b24: 2001         	movs	r0, #0x1
   64b26: f888 0110    	strb.w	r0, [r8, #0x110]
   64b2a: 2100         	movs	r1, #0x0
   64b2c: ed88 bb46    	vstr	d11, [r8, #280]
   64b30: 2802         	cmp	r0, #0x2
   64b32: e9c8 114a    	strd	r1, r1, [r8, #296]
   64b36: ed88 bb48    	vstr	d11, [r8, #288]
   64b3a: d805         	bhi	0x64b48 <air1_opcal4_algorithm+0x3460> @ imm = #0xa
   64b3c: 2000         	movs	r0, #0x0
   64b3e: efc0 0010    	vmov.i32	d16, #0x0
   64b42: f888 0110    	strb.w	r0, [r8, #0x110]
   64b46: e054         	b	0x64bf2 <air1_opcal4_algorithm+0x350a> @ imm = #0xa8
   64b48: efc0 0010    	vmov.i32	d16, #0x0
   64b4c: 2803         	cmp	r0, #0x3
   64b4e: d14f         	bne	0x64bf0 <air1_opcal4_algorithm+0x3508> @ imm = #0x9e
   64b50: edd8 1b54    	vldr	d17, [r8, #336]
   64b54: 2000         	movs	r0, #0x0
   64b56: eef4 1b4e    	vcmp.f64	d17, d14
   64b5a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64b5e: bf04         	itt	eq
   64b60: e9c8 0054    	strdeq	r0, r0, [r8, #336]
   64b64: f888 0110    	strbeq.w	r0, [r8, #0x110]
   64b68: e043         	b	0x64bf2 <air1_opcal4_algorithm+0x350a> @ imm = #0x86
   64b6a: ed96 0a01    	vldr	s0, [r6, #4]
   64b6e: f50a 61c8    	add.w	r1, r10, #0x640
   64b72: f8ba 2d08    	ldrh.w	r2, [r10, #0xd08]
   64b76: eef8 0b40    	vcvt.f64.u32	d16, s0
   64b7a: ed91 0a00    	vldr	s0, [r1]
   64b7e: f8ba 11c6    	ldrh.w	r1, [r10, #0x1c6]
   64b82: eef8 1b40    	vcvt.f64.u32	d17, s0
   64b86: 4291         	cmp	r1, r2
   64b88: ee70 0be1    	vsub.f64	d16, d16, d17
   64b8c: d908         	bls	0x64ba0 <air1_opcal4_algorithm+0x34b8> @ imm = #0x10
   64b8e: 4281         	cmp	r1, r0
   64b90: d206         	bhs	0x64ba0 <air1_opcal4_algorithm+0x34b8> @ imm = #0xc
   64b92: eddf 1b0d    	vldr	d17, [pc, #52]          @ 0x64bc8 <air1_opcal4_algorithm+0x34e0>
   64b96: eef4 0b61    	vcmp.f64	d16, d17
   64b9a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64b9e: dc07         	bgt	0x64bb0 <air1_opcal4_algorithm+0x34c8> @ imm = #0xe
   64ba0: eddf 1b0b    	vldr	d17, [pc, #44]          @ 0x64bd0 <air1_opcal4_algorithm+0x34e8>
   64ba4: eef4 0b61    	vcmp.f64	d16, d17
   64ba8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64bac: f340 837d    	ble.w	0x652aa <air1_opcal4_algorithm+0x3bc2> @ imm = #0x6fa
   64bb0: 2000         	movs	r0, #0x0
   64bb2: e9c8 0054    	strd	r0, r0, [r8, #336]
   64bb6: 2002         	movs	r0, #0x2
   64bb8: e7b5         	b	0x64b26 <air1_opcal4_algorithm+0x343e> @ imm = #-0x96
   64bba: bf00         	nop
   64bbc: 00 00 f8 7f  	.word	0x7ff80000
   64bc0: 00 00 00 00  	.word	0x00000000
   64bc4: 00 00 59 40  	.word	0x40590000
   64bc8: 00 00 00 00  	.word	0x00000000
   64bcc: 00 e0 90 40  	.word	0x4090e000
   64bd0: 00 00 00 00  	.word	0x00000000
   64bd4: 00 70 97 40  	.word	0x40977000
   64bd8: 00 00 00 00  	.word	0x00000000
   64bdc: 00 c0 82 40  	.word	0x4082c000
   64be0: 00 00 00 00  	.word	0x00000000
   64be4: 00 40 8f 40  	.word	0x408f4000
   64be8: f1 68 e3 88  	.word	0x88e368f1
   64bec: b5 f8 e4 3e  	.word	0x3ee4f8b5
   64bf0: 2000         	movs	r0, #0x0
   64bf2: ef6b 111b    	vorr	d17, d11, d11
   64bf6: ef6b 211b    	vorr	d18, d11, d11
   64bfa: 9a5c         	ldr	r2, [sp, #0x170]
   64bfc: 1c41         	adds	r1, r0, #0x1
   64bfe: f8a8 1112    	strh.w	r1, [r8, #0x112]
   64c02: f502 73d8    	add.w	r3, r2, #0x1b0
   64c06: ed1f cb0c    	vldr	d12, [pc, #-48]         @ 0x64bd8 <air1_opcal4_algorithm+0x34f0>
   64c0a: ecf3 3b10    	vldmia	r3!, {d19, d20, d21, d22, d23, d24, d25, d26}
   64c0e: f50d 6340    	add.w	r3, sp, #0xc00
   64c12: ee61 7ba7    	vmul.f64	d23, d17, d23
   64c16: ee46 7ba2    	vmla.f64	d23, d22, d18
   64c1a: ee61 6baa    	vmul.f64	d22, d17, d26
   64c1e: ee49 6ba2    	vmla.f64	d22, d25, d18
   64c22: ee48 7ba0    	vmla.f64	d23, d24, d16
   64c26: edd2 8b7c    	vldr	d24, [r2, #496]
   64c2a: edd2 9b56    	vldr	d25, [r2, #344]
   64c2e: ee48 6ba0    	vmla.f64	d22, d24, d16
   64c32: edd2 8b54    	vldr	d24, [r2, #336]
   64c36: ee66 4ba4    	vmul.f64	d20, d22, d20
   64c3a: ee43 4ba7    	vmla.f64	d20, d19, d23
   64c3e: ee45 4ba6    	vmla.f64	d20, d21, d22
   64c42: ee7b 3b64    	vsub.f64	d19, d11, d20
   64c46: edd2 4b80    	vldr	d20, [r2, #512]
   64c4a: ee48 7ba3    	vmla.f64	d23, d24, d19
   64c4e: ee61 1ba4    	vmul.f64	d17, d17, d20
   64c52: edd2 4b7e    	vldr	d20, [r2, #504]
   64c56: ee49 6ba3    	vmla.f64	d22, d25, d19
   64c5a: ee44 1ba2    	vmla.f64	d17, d20, d18
   64c5e: edd2 2b82    	vldr	d18, [r2, #520]
   64c62: edc3 7b9c    	vstr	d23, [r3, #624]
   64c66: f50d 6340    	add.w	r3, sp, #0xc00
   64c6a: ee42 1ba0    	vmla.f64	d17, d18, d16
   64c6e: edd2 0b58    	vldr	d16, [r2, #352]
   64c72: f50d 6240    	add.w	r2, sp, #0xc00
   64c76: edc3 6b9e    	vstr	d22, [r3, #632]
   64c7a: ee40 1ba3    	vmla.f64	d17, d16, d19
   64c7e: edc2 1ba0    	vstr	d17, [r2, #640]
   64c82: 2200         	movs	r2, #0x0
   64c84: 2a18         	cmp	r2, #0x18
   64c86: d009         	beq	0x64c9c <air1_opcal4_algorithm+0x35b4> @ imm = #0x12
   64c88: eb0b 0402    	add.w	r4, r11, r2
   64c8c: eb0e 0302    	add.w	r3, lr, r2
   64c90: 3208         	adds	r2, #0x8
   64c92: edd4 0b00    	vldr	d16, [r4]
   64c96: edc3 0b00    	vstr	d16, [r3]
   64c9a: e7f3         	b	0x64c84 <air1_opcal4_algorithm+0x359c> @ imm = #-0x1a
   64c9c: ef6b 011b    	vorr	d16, d11, d11
   64ca0: b1b0         	cbz	r0, 0x64cd0 <air1_opcal4_algorithm+0x35e8> @ imm = #0x2c
   64ca2: b288         	uxth	r0, r1
   64ca4: 2819         	cmp	r0, #0x19
   64ca6: d811         	bhi	0x64ccc <air1_opcal4_algorithm+0x35e4> @ imm = #0x22
   64ca8: 3801         	subs	r0, #0x1
   64caa: eef3 1b08    	vmov.f64	d17, #2.400000e+01
   64cae: ee00 0a10    	vmov	s0, r0
   64cb2: edd8 2b48    	vldr	d18, [r8, #288]
   64cb6: eef8 0bc0    	vcvt.f64.s32	d16, s0
   64cba: eec0 0ba1    	vdiv.f64	d16, d16, d17
   64cbe: ee7f 1b60    	vsub.f64	d17, d15, d16
   64cc2: ee60 0ba2    	vmul.f64	d16, d16, d18
   64cc6: ee41 0b8b    	vmla.f64	d16, d17, d11
   64cca: e001         	b	0x64cd0 <air1_opcal4_algorithm+0x35e8> @ imm = #0x2
   64ccc: edd8 0b48    	vldr	d16, [r8, #288]
   64cd0: f506 60c2    	add.w	r0, r6, #0x610
   64cd4: ed88 bb56    	vstr	d11, [r8, #344]
   64cd8: 9052         	str	r0, [sp, #0x148]
   64cda: 2150         	movs	r1, #0x50
   64cdc: edc0 0b00    	vstr	d16, [r0]
   64ce0: 4658         	mov	r0, r11
   64ce2: f00a e98e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xa31c
   64ce6: 985c         	ldr	r0, [sp, #0x170]
   64ce8: 2100         	movs	r1, #0x0
   64cea: 462a         	mov	r2, r5
   64cec: f04f 0c00    	mov.w	r12, #0x0
   64cf0: f890 0210    	ldrb.w	r0, [r0, #0x210]
   64cf4: 3801         	subs	r0, #0x1
   64cf6: 4281         	cmp	r1, r0
   64cf8: da0a         	bge	0x64d10 <air1_opcal4_algorithm+0x3628> @ imm = #0x14
   64cfa: eb05 0381    	add.w	r3, r5, r1, lsl #2
   64cfe: 6d5b         	ldr	r3, [r3, #0x54]
   64d00: f849 3021    	str.w	r3, [r9, r1, lsl #2]
   64d04: 3101         	adds	r1, #0x1
   64d06: edd2 0b02    	vldr	d16, [r2, #8]
   64d0a: ece2 0b02    	vstmia	r2!, {d16}
   64d0e: e7f2         	b	0x64cf6 <air1_opcal4_algorithm+0x360e> @ imm = #-0x1c
   64d10: eb0a 0180    	add.w	r1, r10, r0, lsl #2
   64d14: 6872         	ldr	r2, [r6, #0x4]
   64d16: f642 4310    	movw	r3, #0x2c10
   64d1a: eb0a 00c0    	add.w	r0, r10, r0, lsl #3
   64d1e: 50ca         	str	r2, [r1, r3]
   64d20: f500 502f    	add.w	r0, r0, #0x2bc0
   64d24: 9952         	ldr	r1, [sp, #0x148]
   64d26: f8dd e15c    	ldr.w	lr, [sp, #0x15c]
   64d2a: edd1 0b00    	vldr	d16, [r1]
   64d2e: 991d         	ldr	r1, [sp, #0x74]
   64d30: edc0 0b00    	vstr	d16, [r0]
   64d34: 2000         	movs	r0, #0x0
   64d36: 9a5c         	ldr	r2, [sp, #0x170]
   64d38: f892 2211    	ldrb.w	r2, [r2, #0x211]
   64d3c: 3a01         	subs	r2, #0x1
   64d3e: 4290         	cmp	r0, r2
   64d40: da05         	bge	0x64d4e <air1_opcal4_algorithm+0x3666> @ imm = #0xa
   64d42: f811 2b01    	ldrb	r2, [r1], #1
   64d46: 3001         	adds	r0, #0x1
   64d48: f801 2c02    	strb	r2, [r1, #-2]
   64d4c: e7f3         	b	0x64d36 <air1_opcal4_algorithm+0x364e> @ imm = #-0x1a
   64d4e: eb0a 0002    	add.w	r0, r10, r2
   64d52: 9b5c         	ldr	r3, [sp, #0x170]
   64d54: f642 4138    	movw	r1, #0x2c38
   64d58: f800 c001    	strb.w	r12, [r0, r1]
   64d5c: f893 4210    	ldrb.w	r4, [r3, #0x210]
   64d60: 45a6         	cmp	lr, r4
   64d62: d21b         	bhs	0x64d9c <air1_opcal4_algorithm+0x36b4> @ imm = #0x36
   64d64: f893 3211    	ldrb.w	r3, [r3, #0x211]
   64d68: f506 60cb    	add.w	r0, r6, #0x658
   64d6c: e9dd 450f    	ldrd	r4, r5, [sp, #60]
   64d70: f506 61c5    	add.w	r1, r6, #0x628
   64d74: f506 62c3    	add.w	r2, r6, #0x618
   64d78: ed5f 3b67    	vldr	d19, [pc, #-412]        @ 0x64be0 <air1_opcal4_algorithm+0x34f8>
   64d7c: 2b00         	cmp	r3, #0x0
   64d7e: f000 80a3    	beq.w	0x64ec8 <air1_opcal4_algorithm+0x37e0> @ imm = #0x146
   64d82: ecf5 0b02    	vldmia	r5!, {d16}
   64d86: 3b01         	subs	r3, #0x1
   64d88: ece1 0b02    	vstmia	r1!, {d16}
   64d8c: f834 6b02    	ldrh	r6, [r4], #2
   64d90: f822 6b02    	strh	r6, [r2], #2
   64d94: 9e5f         	ldr	r6, [sp, #0x17c]
   64d96: f800 cb01    	strb	r12, [r0], #1
   64d9a: e7ef         	b	0x64d7c <air1_opcal4_algorithm+0x3694> @ imm = #-0x22
   64d9c: f50d 693a    	add.w	r9, sp, #0xba0
   64da0: 2150         	movs	r1, #0x50
   64da2: 4648         	mov	r0, r9
   64da4: f00a e92c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xa258
   64da8: f50d 603a    	add.w	r0, sp, #0xba0
   64dac: 4622         	mov	r2, r4
   64dae: 4629         	mov	r1, r5
   64db0: b12a         	cbz	r2, 0x64dbe <air1_opcal4_algorithm+0x36d6> @ imm = #0xa
   64db2: ecf1 0b02    	vldmia	r1!, {d16}
   64db6: 3a01         	subs	r2, #0x1
   64db8: ece9 0b02    	vstmia	r9!, {d16}
   64dbc: e7f8         	b	0x64db0 <air1_opcal4_algorithm+0x36c8> @ imm = #-0x10
   64dbe: 4621         	mov	r1, r4
   64dc0: f007 fc26    	bl	0x6c610 <math_std>      @ imm = #0x784c
   64dc4: e9dd 250b    	ldrd	r2, r5, [sp, #44]
   64dc8: 1e60         	subs	r0, r4, #0x1
   64dca: ed5f 3b7b    	vldr	d19, [pc, #-492]        @ 0x64be0 <air1_opcal4_algorithm+0x34f8>
   64dce: 2100         	movs	r1, #0x0
   64dd0: 2600         	movs	r6, #0x0
   64dd2: 4281         	cmp	r1, r0
   64dd4: da0c         	bge	0x64df0 <air1_opcal4_algorithm+0x3708> @ imm = #0x18
   64dd6: f852 3c04    	ldr	r3, [r2, #-4]
   64dda: ca10         	ldm	r2!, {r4}
   64ddc: 1ae3         	subs	r3, r4, r3
   64dde: f166 0400    	sbc	r4, r6, #0x0
   64de2: 3101         	adds	r1, #0x1
   64de4: f5b3 7316    	subs.w	r3, r3, #0x258
   64de8: f174 0300    	sbcs	r3, r4, #0x0
   64dec: dbf1         	blt	0x64dd2 <air1_opcal4_algorithm+0x36ea> @ imm = #-0x1e
   64dee: e02b         	b	0x64e48 <air1_opcal4_algorithm+0x3760> @ imm = #0x56
   64df0: ed5f 0b83    	vldr	d16, [pc, #-524]        @ 0x64be8 <air1_opcal4_algorithm+0x3500>
   64df4: eeb4 0b60    	vcmp.f64	d0, d16
   64df8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64dfc: d424         	bmi	0x64e48 <air1_opcal4_algorithm+0x3760> @ imm = #0x48
   64dfe: 9c5c         	ldr	r4, [sp, #0x170]
   64e00: f50d 603a    	add.w	r0, sp, #0xba0
   64e04: 465a         	mov	r2, r11
   64e06: f504 7106    	add.w	r1, r4, #0x218
   64e0a: f007 ff57    	bl	0x6ccbc <smooth_sg>     @ imm = #0x7eae
   64e0e: 9e5f         	ldr	r6, [sp, #0x17c]
   64e10: f894 0211    	ldrb.w	r0, [r4, #0x211]
   64e14: 462c         	mov	r4, r5
   64e16: f8dd e024    	ldr.w	lr, [sp, #0x24]
   64e1a: f506 61cb    	add.w	r1, r6, #0x658
   64e1e: f8dd 903c    	ldr.w	r9, [sp, #0x3c]
   64e22: f506 62c5    	add.w	r2, r6, #0x628
   64e26: ed5f 3b92    	vldr	d19, [pc, #-584]        @ 0x64be0 <air1_opcal4_algorithm+0x34f8>
   64e2a: 4603         	mov	r3, r0
   64e2c: 4675         	mov	r5, lr
   64e2e: b343         	cbz	r3, 0x64e82 <air1_opcal4_algorithm+0x379a> @ imm = #0x50
   64e30: ecf4 0b02    	vldmia	r4!, {d16}
   64e34: 3b01         	subs	r3, #0x1
   64e36: ece2 0b02    	vstmia	r2!, {d16}
   64e3a: f815 6b01    	ldrb	r6, [r5], #1
   64e3e: 3601         	adds	r6, #0x1
   64e40: f801 6b01    	strb	r6, [r1], #1
   64e44: 9e5f         	ldr	r6, [sp, #0x17c]
   64e46: e7f2         	b	0x64e2e <air1_opcal4_algorithm+0x3746> @ imm = #-0x1c
   64e48: 985c         	ldr	r0, [sp, #0x170]
   64e4a: 9e5f         	ldr	r6, [sp, #0x17c]
   64e4c: f8dd c040    	ldr.w	r12, [sp, #0x40]
   64e50: f890 0211    	ldrb.w	r0, [r0, #0x211]
   64e54: f506 61cb    	add.w	r1, r6, #0x658
   64e58: f8dd e024    	ldr.w	lr, [sp, #0x24]
   64e5c: f506 62c5    	add.w	r2, r6, #0x628
   64e60: f8dd 903c    	ldr.w	r9, [sp, #0x3c]
   64e64: 4664         	mov	r4, r12
   64e66: 4603         	mov	r3, r0
   64e68: 4675         	mov	r5, lr
   64e6a: b163         	cbz	r3, 0x64e86 <air1_opcal4_algorithm+0x379e> @ imm = #0x18
   64e6c: ecf4 0b02    	vldmia	r4!, {d16}
   64e70: 3b01         	subs	r3, #0x1
   64e72: ece2 0b02    	vstmia	r2!, {d16}
   64e76: f815 6b01    	ldrb	r6, [r5], #1
   64e7a: f801 6b01    	strb	r6, [r1], #1
   64e7e: 9e5f         	ldr	r6, [sp, #0x17c]
   64e80: e7f3         	b	0x64e6a <air1_opcal4_algorithm+0x3782> @ imm = #-0x1a
   64e82: f8dd c040    	ldr.w	r12, [sp, #0x40]
   64e86: 2100         	movs	r1, #0x0
   64e88: 2200         	movs	r2, #0x0
   64e8a: b2c0         	uxtb	r0, r0
   64e8c: 4282         	cmp	r2, r0
   64e8e: d219         	bhs	0x64ec4 <air1_opcal4_algorithm+0x37dc> @ imm = #0x32
   64e90: f839 0012    	ldrh.w	r0, [r9, r2, lsl #1]
   64e94: eb06 0342    	add.w	r3, r6, r2, lsl #1
   64e98: f8a3 0618    	strh.w	r0, [r3, #0x618]
   64e9c: 1873         	adds	r3, r6, r1
   64e9e: f503 63c5    	add.w	r3, r3, #0x628
   64ea2: eb0c 0001    	add.w	r0, r12, r1
   64ea6: 3108         	adds	r1, #0x8
   64ea8: edd3 0b00    	vldr	d16, [r3]
   64eac: edc0 0b00    	vstr	d16, [r0]
   64eb0: 18b0         	adds	r0, r6, r2
   64eb2: f890 0658    	ldrb.w	r0, [r0, #0x658]
   64eb6: f80e 0002    	strb.w	r0, [lr, r2]
   64eba: 3201         	adds	r2, #0x1
   64ebc: 985c         	ldr	r0, [sp, #0x170]
   64ebe: f890 0211    	ldrb.w	r0, [r0, #0x211]
   64ec2: e7e2         	b	0x64e8a <air1_opcal4_algorithm+0x37a2> @ imm = #-0x3c
   64ec4: f04f 0c00    	mov.w	r12, #0x0
   64ec8: 9846         	ldr	r0, [sp, #0x118]
   64eca: 2100         	movs	r1, #0x0
   64ecc: 9157         	str	r1, [sp, #0x15c]
   64ece: 2100         	movs	r1, #0x0
   64ed0: 9149         	str	r1, [sp, #0x124]
   64ed2: 2100         	movs	r1, #0x0
   64ed4: f890 92bc    	ldrb.w	r9, [r0, #0x2bc]
   64ed8: efc0 0010    	vmov.i32	d16, #0x0
   64edc: 9852         	ldr	r0, [sp, #0x148]
   64ede: f50d 650d    	add.w	r5, sp, #0x8d0
   64ee2: 9148         	str	r1, [sp, #0x120]
   64ee4: 2100         	movs	r1, #0x0
   64ee6: 914a         	str	r1, [sp, #0x128]
   64ee8: f04f 0a00    	mov.w	r10, #0x0
   64eec: edd0 1b00    	vldr	d17, [r0]
   64ef0: f04f 0b00    	mov.w	r11, #0x0
   64ef4: 9814         	ldr	r0, [sp, #0x50]
   64ef6: 2200         	movs	r2, #0x0
   64ef8: 9950         	ldr	r1, [sp, #0x140]
   64efa: 4591         	cmp	r9, r2
   64efc: d053         	beq	0x64fa6 <air1_opcal4_algorithm+0x38be> @ imm = #0xa6
   64efe: 5c8c         	ldrb	r4, [r1, r2]
   64f00: 2c00         	cmp	r4, #0x0
   64f02: d14d         	bne	0x64fa0 <air1_opcal4_algorithm+0x38b8> @ imm = #0x9a
   64f04: eb01 0482    	add.w	r4, r1, r2, lsl #2
   64f08: 6875         	ldr	r5, [r6, #0x4]
   64f0a: f854 4cc9    	ldr	r4, [r4, #-201]
   64f0e: 42ac         	cmp	r4, r5
   64f10: d902         	bls	0x64f18 <air1_opcal4_algorithm+0x3830> @ imm = #0x4
   64f12: f50d 650d    	add.w	r5, sp, #0x8d0
   64f16: e043         	b	0x64fa0 <air1_opcal4_algorithm+0x38b8> @ imm = #0x86
   64f18: f960 270f    	vld1.8	{d18}, [r0]
   64f1c: 1b2e         	subs	r6, r5, r4
   64f1e: f16c 0500    	sbc	r5, r12, #0x0
   64f22: eef4 2b4a    	vcmp.f64	d18, d10
   64f26: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64f2a: db06         	blt	0x64f3a <air1_opcal4_algorithm+0x3852> @ imm = #0xc
   64f2c: eef4 2b4c    	vcmp.f64	d18, d12
   64f30: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64f34: bf9c         	itt	ls
   64f36: 2101         	movls	r1, #0x1
   64f38: 9157         	strls	r1, [sp, #0x15c]
   64f3a: 9b5c         	ldr	r3, [sp, #0x170]
   64f3c: f10a 0a01    	add.w	r10, r10, #0x1
   64f40: f503 7e22    	add.w	lr, r3, #0x288
   64f44: f8d3 8294    	ldr.w	r8, [r3, #0x294]
   64f48: e89e 5002    	ldm.w	lr, {r1, r12, lr}
   64f4c: ebb6 030e    	subs.w	r3, r6, lr
   64f50: eb75 0308    	sbcs.w	r3, r5, r8
   64f54: 465b         	mov	r3, r11
   64f56: bfb8         	it	lt
   64f58: 2301         	movlt	r3, #0x1
   64f5a: 1b89         	subs	r1, r1, r6
   64f5c: eb7c 0105    	sbcs.w	r1, r12, r5
   64f60: bfb8         	it	lt
   64f62: 469b         	movlt	r11, r3
   64f64: 9957         	ldr	r1, [sp, #0x15c]
   64f66: b199         	cbz	r1, 0x64f90 <air1_opcal4_algorithm+0x38a8> @ imm = #0x26
   64f68: ea5f 610b    	lsls.w	r1, r11, #0x18
   64f6c: f8dd 814c    	ldr.w	r8, [sp, #0x14c]
   64f70: 9950         	ldr	r1, [sp, #0x140]
   64f72: f50d 650d    	add.w	r5, sp, #0x8d0
   64f76: 9e5f         	ldr	r6, [sp, #0x17c]
   64f78: d007         	beq	0x64f8a <air1_opcal4_algorithm+0x38a2> @ imm = #0xe
   64f7a: ef62 01b2    	vorr	d16, d18, d18
   64f7e: 2302         	movs	r3, #0x2
   64f80: 548b         	strb	r3, [r1, r2]
   64f82: 2301         	movs	r3, #0x1
   64f84: e9cd 2349    	strd	r2, r3, [sp, #292]
   64f88: 9448         	str	r4, [sp, #0x120]
   64f8a: f04f 0c00    	mov.w	r12, #0x0
   64f8e: e007         	b	0x64fa0 <air1_opcal4_algorithm+0x38b8> @ imm = #0xe
   64f90: f8dd 814c    	ldr.w	r8, [sp, #0x14c]
   64f94: f50d 650d    	add.w	r5, sp, #0x8d0
   64f98: 9950         	ldr	r1, [sp, #0x140]
   64f9a: f04f 0c00    	mov.w	r12, #0x0
   64f9e: 9e5f         	ldr	r6, [sp, #0x17c]
   64fa0: 3008         	adds	r0, #0x8
   64fa2: 3201         	adds	r2, #0x1
   64fa4: e7a9         	b	0x64efa <air1_opcal4_algorithm+0x3812> @ imm = #-0xae
   64fa6: fa5f f08a    	uxtb.w	r0, r10
   64faa: f8dd a158    	ldr.w	r10, [sp, #0x158]
   64fae: f8dd b080    	ldr.w	r11, [sp, #0x80]
   64fb2: f50d 663a    	add.w	r6, sp, #0xba0
   64fb6: f50d 6967    	add.w	r9, sp, #0xe70
   64fba: b138         	cbz	r0, 0x64fcc <air1_opcal4_algorithm+0x38e4> @ imm = #0xe
   64fbc: b130         	cbz	r0, 0x64fcc <air1_opcal4_algorithm+0x38e4> @ imm = #0xc
   64fbe: 780a         	ldrb	r2, [r1]
   64fc0: b90a         	cbnz	r2, 0x64fc6 <air1_opcal4_algorithm+0x38de> @ imm = #0x2
   64fc2: 2202         	movs	r2, #0x2
   64fc4: 700a         	strb	r2, [r1]
   64fc6: 3801         	subs	r0, #0x1
   64fc8: 3101         	adds	r1, #0x1
   64fca: e7f7         	b	0x64fbc <air1_opcal4_algorithm+0x38d4> @ imm = #-0x12
   64fcc: f8ba 0648    	ldrh.w	r0, [r10, #0x648]
   64fd0: 2802         	cmp	r0, #0x2
   64fd2: d326         	blo	0x65022 <air1_opcal4_algorithm+0x393a> @ imm = #0x4c
   64fd4: f8ba 0d08    	ldrh.w	r0, [r10, #0xd08]
   64fd8: f8ba 1d0a    	ldrh.w	r1, [r10, #0xd0a]
   64fdc: 1a08         	subs	r0, r1, r0
   64fde: b200         	sxth	r0, r0
   64fe0: 2804         	cmp	r0, #0x4
   64fe2: dc1e         	bgt	0x65022 <air1_opcal4_algorithm+0x393a> @ imm = #0x3c
   64fe4: eef4 1b4a    	vcmp.f64	d17, d10
   64fe8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64fec: d919         	bls	0x65022 <air1_opcal4_algorithm+0x393a> @ imm = #0x32
   64fee: eef4 1b63    	vcmp.f64	d17, d19
   64ff2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   64ff6: da14         	bge	0x65022 <air1_opcal4_algorithm+0x393a> @ imm = #0x28
   64ff8: 985f         	ldr	r0, [sp, #0x17c]
   64ffa: f890 00c8    	ldrb.w	r0, [r0, #0xc8]
   64ffe: b180         	cbz	r0, 0x65022 <air1_opcal4_algorithm+0x393a> @ imm = #0x20
   65000: 984a         	ldr	r0, [sp, #0x128]
   65002: b170         	cbz	r0, 0x65022 <air1_opcal4_algorithm+0x393a> @ imm = #0x1c
   65004: 9949         	ldr	r1, [sp, #0x124]
   65006: 9846         	ldr	r0, [sp, #0x118]
   65008: fa50 f081    	uxtab	r0, r0, r1
   6500c: 2101         	movs	r1, #0x1
   6500e: f880 12bd    	strb.w	r1, [r0, #0x2bd]
   65012: 985f         	ldr	r0, [sp, #0x17c]
   65014: 9948         	ldr	r1, [sp, #0x120]
   65016: f8c0 1668    	str.w	r1, [r0, #0x668]
   6501a: f500 60cc    	add.w	r0, r0, #0x660
   6501e: edc0 0b00    	vstr	d16, [r0]
   65022: 2000         	movs	r0, #0x0
   65024: 2830         	cmp	r0, #0x30
   65026: d00d         	beq	0x65044 <air1_opcal4_algorithm+0x395c> @ imm = #0x1a
   65028: 9a5f         	ldr	r2, [sp, #0x17c]
   6502a: eb0a 0100    	add.w	r1, r10, r0
   6502e: f501 5131    	add.w	r1, r1, #0x2c40
   65032: 4402         	add	r2, r0
   65034: 3008         	adds	r0, #0x8
   65036: f502 62c5    	add.w	r2, r2, #0x628
   6503a: edd2 0b00    	vldr	d16, [r2]
   6503e: edc1 0b00    	vstr	d16, [r1]
   65042: e7ef         	b	0x65024 <air1_opcal4_algorithm+0x393c> @ imm = #-0x22
   65044: 9852         	ldr	r0, [sp, #0x148]
   65046: ed90 cb00    	vldr	d12, [r0]
   6504a: 985f         	ldr	r0, [sp, #0x17c]
   6504c: ed88 cb84    	vstr	d12, [r8, #528]
   65050: f500 61cc    	add.w	r1, r0, #0x660
   65054: 914a         	str	r1, [sp, #0x128]
   65056: ed91 eb00    	vldr	d14, [r1]
   6505a: eeb5 eb40    	vcmp.f64	d14, #0
   6505e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65062: d10e         	bne	0x65082 <air1_opcal4_algorithm+0x399a> @ imm = #0x1c
   65064: 994f         	ldr	r1, [sp, #0x13c]
   65066: f991 0018    	ldrsb.w	r0, [r1, #0x18]
   6506a: 2801         	cmp	r0, #0x1
   6506c: fa5f f880    	uxtb.w	r8, r0
   65070: f2c0 8110    	blt.w	0x65294 <air1_opcal4_algorithm+0x3bac> @ imm = #0x220
   65074: 985f         	ldr	r0, [sp, #0x17c]
   65076: eeb7 eb08    	vmov.f64	d14, #1.500000e+00
   6507a: 8805         	ldrh	r5, [r0]
   6507c: f8ba 0648    	ldrh.w	r0, [r10, #0x648]
   65080: e0c4         	b	0x6520c <air1_opcal4_algorithm+0x3b24> @ imm = #0x188
   65082: f8d0 4668    	ldr.w	r4, [r0, #0x668]
   65086: ed90 0a01    	vldr	s0, [r0, #4]
   6508a: eddf 1be9    	vldr	d17, [pc, #932]         @ 0x65430 <air1_opcal4_algorithm+0x3d48>
   6508e: eef8 0b40    	vcvt.f64.u32	d16, s0
   65092: 8805         	ldrh	r5, [r0]
   65094: ee00 4a10    	vmov	s0, r4
   65098: eeb8 db40    	vcvt.f64.u32	d13, s0
   6509c: ee70 0bcd    	vsub.f64	d16, d16, d13
   650a0: ee80 0ba1    	vdiv.f64	d0, d16, d17
   650a4: f007 fb58    	bl	0x6c758 <math_round>    @ imm = #0x76b0
   650a8: 985c         	ldr	r0, [sp, #0x170]
   650aa: eef1 2b04    	vmov.f64	d18, #5.000000e+00
   650ae: 9907         	ldr	r1, [sp, #0x1c]
   650b0: edd0 1ba8    	vldr	d17, [r0, #672]
   650b4: 2030         	movs	r0, #0x30
   650b6: eec0 0b22    	vdiv.f64	d16, d0, d18
   650ba: ee81 cba2    	vdiv.f64	d12, d17, d18
   650be: f1b0 3fff    	cmp.w	r0, #0xffffffff
   650c2: dd2e         	ble	0x65122 <air1_opcal4_algorithm+0x3a3a> @ imm = #0x5c
   650c4: f811 2cc8    	ldrb	r2, [r1, #-200]
   650c8: 3801         	subs	r0, #0x1
   650ca: f801 2c60    	strb	r2, [r1, #-96]
   650ce: f851 2cc4    	ldr	r2, [r1, #-196]
   650d2: f841 2c5c    	str	r2, [r1, #-92]
   650d6: f831 2cb0    	ldrh	r2, [r1, #-176]
   650da: ed51 1b30    	vldr	d17, [r1, #-192]
   650de: ed51 2b2e    	vldr	d18, [r1, #-184]
   650e2: f821 2c48    	strh	r2, [r1, #-72]
   650e6: f1a1 02a8    	sub.w	r2, r1, #0xa8
   650ea: ed41 1b16    	vstr	d17, [r1, #-88]
   650ee: ed41 2b14    	vstr	d18, [r1, #-80]
   650f2: ecf2 1b06    	vldmia	r2!, {d17, d18, d19}
   650f6: f1a1 0240    	sub.w	r2, r1, #0x40
   650fa: ece2 1b06    	vstmia	r2!, {d17, d18, d19}
   650fe: f811 2c90    	ldrb	r2, [r1, #-144]
   65102: f801 2c28    	strb	r2, [r1, #-40]
   65106: f1a1 0288    	sub.w	r2, r1, #0x88
   6510a: ecf2 1b08    	vldmia	r2!, {d17, d18, d19, d20}
   6510e: f1a1 0220    	sub.w	r2, r1, #0x20
   65112: ece2 1b08    	vstmia	r2!, {d17, d18, d19, d20}
   65116: 460a         	mov	r2, r1
   65118: f812 3d68    	ldrb	r3, [r2, #-104]!
   6511c: 700b         	strb	r3, [r1]
   6511e: 4611         	mov	r1, r2
   65120: e7cd         	b	0x650be <air1_opcal4_algorithm+0x39d6> @ imm = #-0x66
   65122: ee20 0b8a    	vmul.f64	d0, d16, d10
   65126: f007 fb17    	bl	0x6c758 <math_round>    @ imm = #0x762e
   6512a: eeb0 bb40    	vmov.f64	d11, d0
   6512e: ee2c 0b0a    	vmul.f64	d0, d12, d10
   65132: f007 fb11    	bl	0x6c758 <math_round>    @ imm = #0x7622
   65136: eecb 0b0a    	vdiv.f64	d16, d11, d10
   6513a: 2001         	movs	r0, #0x1
   6513c: f888 0398    	strb.w	r0, [r8, #0x398]
   65140: 2000         	movs	r0, #0x0
   65142: 995c         	ldr	r1, [sp, #0x170]
   65144: f888 03c0    	strb.w	r0, [r8, #0x3c0]
   65148: f8ba 0648    	ldrh.w	r0, [r10, #0x648]
   6514c: f8c8 4364    	str.w	r4, [r8, #0x364]
   65150: f8a8 0378    	strh.w	r0, [r8, #0x378]
   65154: edd8 2ba0    	vldr	d18, [r8, #640]
   65158: ee01 5a10    	vmov	s2, r5
   6515c: edd8 3bae    	vldr	d19, [r8, #696]
   65160: edc8 2be2    	vstr	d18, [r8, #904]
   65164: edc8 2bec    	vstr	d18, [r8, #944]
   65168: eec0 2b0a    	vdiv.f64	d18, d0, d10
   6516c: eef8 1b41    	vcvt.f64.u32	d17, s2
   65170: ee71 0be0    	vsub.f64	d16, d17, d16
   65174: edc8 0bda    	vstr	d16, [r8, #872]
   65178: ee70 0ba2    	vadd.f64	d16, d16, d18
   6517c: ed98 cb84    	vldr	d12, [r8, #528]
   65180: ed88 ebe0    	vstr	d14, [r8, #896]
   65184: edc8 3be4    	vstr	d19, [r8, #912]
   65188: ed88 ebe8    	vstr	d14, [r8, #928]
   6518c: ed88 cbea    	vstr	d12, [r8, #936]
   65190: edc8 3bee    	vstr	d19, [r8, #952]
   65194: edc8 0bdc    	vstr	d16, [r8, #880]
   65198: edd1 2ba0    	vldr	d18, [r1, #640]
   6519c: edd1 0b9e    	vldr	d16, [r1, #632]
   651a0: 2102         	movs	r1, #0x2
   651a2: eef4 2b61    	vcmp.f64	d18, d17
   651a6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   651aa: bfc8         	it	gt
   651ac: 2101         	movgt	r1, #0x1
   651ae: eef4 0b61    	vcmp.f64	d16, d17
   651b2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   651b6: bfc8         	it	gt
   651b8: 2100         	movgt	r1, #0x0
   651ba: edd8 0bf4    	vldr	d16, [r8, #976]
   651be: f888 1360    	strb.w	r1, [r8, #0x360]
   651c2: eef5 0b40    	vcmp.f64	d16, #0
   651c6: eddf 0b9c    	vldr	d16, [pc, #624]         @ 0x65438 <air1_opcal4_algorithm+0x3d50>
   651ca: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   651ce: d009         	beq	0x651e4 <air1_opcal4_algorithm+0x3afc> @ imm = #0x12
   651d0: ed98 0af3    	vldr	s0, [r8, #972]
   651d4: eddf 1b96    	vldr	d17, [pc, #600]         @ 0x65430 <air1_opcal4_algorithm+0x3d48>
   651d8: eef8 0b40    	vcvt.f64.u32	d16, s0
   651dc: ee7d 0b60    	vsub.f64	d16, d13, d16
   651e0: eec0 0ba1    	vdiv.f64	d16, d16, d17
   651e4: 995c         	ldr	r1, [sp, #0x170]
   651e6: eeb7 eb08    	vmov.f64	d14, #1.500000e+00
   651ea: edd1 1ba6    	vldr	d17, [r1, #664]
   651ee: ed9f db94    	vldr	d13, [pc, #592]         @ 0x65440 <air1_opcal4_algorithm+0x3d58>
   651f2: eef4 0b61    	vcmp.f64	d16, d17
   651f6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   651fa: bf9c         	itt	ls
   651fc: 21fe         	movls	r1, #0xfe
   651fe: f888 1400    	strbls.w	r1, [r8, #0x400]
   65202: 994f         	ldr	r1, [sp, #0x13c]
   65204: f04f 0801    	mov.w	r8, #0x1
   65208: f881 8018    	strb.w	r8, [r1, #0x18]
   6520c: 9b0d         	ldr	r3, [sp, #0x34]
   6520e: 2100         	movs	r1, #0x0
   65210: 2232         	movs	r2, #0x32
   65212: b13a         	cbz	r2, 0x65224 <air1_opcal4_algorithm+0x3b3c> @ imm = #0xe
   65214: 781c         	ldrb	r4, [r3]
   65216: 2cfa         	cmp	r4, #0xfa
   65218: bf14         	ite	ne
   6521a: 2c01         	cmpne	r4, #0x1
   6521c: 2101         	moveq	r1, #0x1
   6521e: 3a01         	subs	r2, #0x1
   65220: 3368         	adds	r3, #0x68
   65222: e7f6         	b	0x65212 <air1_opcal4_algorithm+0x3b2a> @ imm = #-0x14
   65224: b181         	cbz	r1, 0x65248 <air1_opcal4_algorithm+0x3b60> @ imm = #0x20
   65226: ee00 5a10    	vmov	s0, r5
   6522a: 9953         	ldr	r1, [sp, #0x14c]
   6522c: eef8 1b40    	vcvt.f64.u32	d17, s0
   65230: edd1 0bdc    	vldr	d16, [r1, #880]
   65234: ee31 bbe0    	vsub.f64	d11, d17, d16
   65238: eeb5 bb40    	vcmp.f64	d11, #0
   6523c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65240: d50a         	bpl	0x65258 <air1_opcal4_algorithm+0x3b70> @ imm = #0x14
   65242: f50d 650d    	add.w	r5, sp, #0x8d0
   65246: e029         	b	0x6529c <air1_opcal4_algorithm+0x3bb4> @ imm = #0x52
   65248: 984f         	ldr	r0, [sp, #0x13c]
   6524a: f04f 0800    	mov.w	r8, #0x0
   6524e: f880 8000    	strb.w	r8, [r0]
   65252: f880 8018    	strb.w	r8, [r0, #0x18]
   65256: e1d6         	b	0x65606 <air1_opcal4_algorithm+0x3f1e> @ imm = #0x3ac
   65258: f8b1 1378    	ldrh.w	r1, [r1, #0x378]
   6525c: 1a40         	subs	r0, r0, r1
   6525e: f1b8 0f02    	cmp.w	r8, #0x2
   65262: d04f         	beq	0x65304 <air1_opcal4_algorithm+0x3c1c> @ imm = #0x9e
   65264: f50d 650d    	add.w	r5, sp, #0x8d0
   65268: f1b8 0f01    	cmp.w	r8, #0x1
   6526c: d160         	bne	0x65330 <air1_opcal4_algorithm+0x3c48> @ imm = #0xc0
   6526e: eeb0 0b4b    	vmov.f64	d0, d11
   65272: f007 fdb9    	bl	0x6cde8 <math_ceil>     @ imm = #0x7b72
   65276: ee70 0b4b    	vsub.f64	d16, d0, d11
   6527a: 9953         	ldr	r1, [sp, #0x14c]
   6527c: 984f         	ldr	r0, [sp, #0x13c]
   6527e: f04f 08ff    	mov.w	r8, #0xff
   65282: f880 8018    	strb.w	r8, [r0, #0x18]
   65286: ee7f 1b60    	vsub.f64	d17, d15, d16
   6528a: ee6c 0b20    	vmul.f64	d16, d12, d16
   6528e: edd1 2b82    	vldr	d18, [r1, #520]
   65292: e079         	b	0x65388 <air1_opcal4_algorithm+0x3ca0> @ imm = #0xf2
   65294: eeb7 eb08    	vmov.f64	d14, #1.500000e+00
   65298: f881 8000    	strb.w	r8, [r1]
   6529c: fa4f f088    	sxtb.w	r0, r8
   652a0: f1b0 3fff    	cmp.w	r0, #0xffffffff
   652a4: f300 81b1    	bgt.w	0x6560a <air1_opcal4_algorithm+0x3f22> @ imm = #0x362
   652a8: e085         	b	0x653b6 <air1_opcal4_algorithm+0x3cce> @ imm = #0x10a
   652aa: eddf 1b61    	vldr	d17, [pc, #388]         @ 0x65430 <air1_opcal4_algorithm+0x3d48>
   652ae: 2000         	movs	r0, #0x0
   652b0: 2100         	movs	r1, #0x0
   652b2: eec0 0ba1    	vdiv.f64	d16, d16, d17
   652b6: edd8 1b56    	vldr	d17, [r8, #344]
   652ba: ee7b 1b61    	vsub.f64	d17, d11, d17
   652be: ee81 cba0    	vdiv.f64	d12, d17, d16
   652c2: ed88 cb4c    	vstr	d12, [r8, #304]
   652c6: 2820         	cmp	r0, #0x20
   652c8: d00b         	beq	0x652e2 <air1_opcal4_algorithm+0x3bfa> @ imm = #0x16
   652ca: eb0c 0200    	add.w	r2, r12, r0
   652ce: edd2 0b00    	vldr	d16, [r2]
   652d2: eef4 0b60    	vcmp.f64	d16, d16
   652d6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   652da: bf68         	it	vs
   652dc: 3101         	addvs	r1, #0x1
   652de: 3008         	adds	r0, #0x8
   652e0: e7f1         	b	0x652c6 <air1_opcal4_algorithm+0x3bde> @ imm = #-0x1e
   652e2: 0608         	lsls	r0, r1, #0x18
   652e4: f000 812e    	beq.w	0x65544 <air1_opcal4_algorithm+0x3e5c> @ imm = #0x25c
   652e8: f898 0110    	ldrb.w	r0, [r8, #0x110]
   652ec: 2800         	cmp	r0, #0x0
   652ee: f47f ac1c    	bne.w	0x64b2a <air1_opcal4_algorithm+0x3442> @ imm = #-0x7c8
   652f2: edd8 2b46    	vldr	d18, [r8, #280]
   652f6: edd8 1b48    	vldr	d17, [r8, #288]
   652fa: edd8 0b4a    	vldr	d16, [r8, #296]
   652fe: f8b8 0112    	ldrh.w	r0, [r8, #0x112]
   65302: e47a         	b	0x64bfa <air1_opcal4_algorithm+0x3512> @ imm = #-0x70c
   65304: f50d 650d    	add.w	r5, sp, #0x8d0
   65308: 2805         	cmp	r0, #0x5
   6530a: dc11         	bgt	0x65330 <air1_opcal4_algorithm+0x3c48> @ imm = #0x22
   6530c: 984f         	ldr	r0, [sp, #0x13c]
   6530e: f04f 0802    	mov.w	r8, #0x2
   65312: edd0 0b02    	vldr	d16, [r0, #8]
   65316: edd0 1b04    	vldr	d17, [r0, #16]
   6531a: eec0 0b8e    	vdiv.f64	d16, d16, d14
   6531e: f880 8000    	strb.w	r8, [r0]
   65322: eec1 1b8e    	vdiv.f64	d17, d17, d14
   65326: edc0 0b02    	vstr	d16, [r0, #8]
   6532a: edc0 1b04    	vstr	d17, [r0, #16]
   6532e: e16c         	b	0x6560a <air1_opcal4_algorithm+0x3f22> @ imm = #0x2d8
   65330: f1b8 0f02    	cmp.w	r8, #0x2
   65334: bf04         	itt	eq
   65336: b280         	uxtheq	r0, r0
   65338: 2806         	cmpeq	r0, #0x6
   6533a: d00e         	beq	0x6535a <air1_opcal4_algorithm+0x3c72> @ imm = #0x1c
   6533c: 9853         	ldr	r0, [sp, #0x14c]
   6533e: 21fd         	movs	r1, #0xfd
   65340: f04f 0800    	mov.w	r8, #0x0
   65344: f880 1398    	strb.w	r1, [r0, #0x398]
   65348: 984f         	ldr	r0, [sp, #0x13c]
   6534a: f880 8018    	strb.w	r8, [r0, #0x18]
   6534e: f880 8000    	strb.w	r8, [r0]
   65352: 9808         	ldr	r0, [sp, #0x20]
   65354: f900 8acf    	vst1.64	{d8, d9}, [r0]
   65358: e157         	b	0x6560a <air1_opcal4_algorithm+0x3f22> @ imm = #0x2ae
   6535a: eeb0 0b4b    	vmov.f64	d0, d11
   6535e: f007 fd43    	bl	0x6cde8 <math_ceil>     @ imm = #0x7a86
   65362: ee70 0b4b    	vsub.f64	d16, d0, d11
   65366: 9908         	ldr	r1, [sp, #0x20]
   65368: 984f         	ldr	r0, [sp, #0x13c]
   6536a: f04f 08fe    	mov.w	r8, #0xfe
   6536e: f880 8018    	strb.w	r8, [r0, #0x18]
   65372: f901 8acf    	vst1.64	{d8, d9}, [r1]
   65376: 9953         	ldr	r1, [sp, #0x14c]
   65378: ee7f 1b60    	vsub.f64	d17, d15, d16
   6537c: edd1 3b7a    	vldr	d19, [r1, #488]
   65380: edd1 2b78    	vldr	d18, [r1, #480]
   65384: ee60 0ba3    	vmul.f64	d16, d16, d19
   65388: ee41 0ba2    	vmla.f64	d16, d17, d18
   6538c: f880 8000    	strb.w	r8, [r0]
   65390: f501 7060    	add.w	r0, r1, #0x380
   65394: ecf0 1b06    	vldmia	r0!, {d17, d18, d19}
   65398: ee42 3ba0    	vmla.f64	d19, d18, d16
   6539c: 985c         	ldr	r0, [sp, #0x170]
   6539e: edc1 1be8    	vstr	d17, [r1, #928]
   653a2: edd0 1baa    	vldr	d17, [r0, #680]
   653a6: ee7f 4b61    	vsub.f64	d20, d15, d17
   653aa: ee63 2ba4    	vmul.f64	d18, d19, d20
   653ae: ee41 2ba0    	vmla.f64	d18, d17, d16
   653b2: edc1 2bea    	vstr	d18, [r1, #936]
   653b6: 2400         	movs	r4, #0x0
   653b8: f50d 613a    	add.w	r1, sp, #0xba0
   653bc: 4650         	mov	r0, r10
   653be: f1b8 0fff    	cmp.w	r8, #0xff
   653c2: f909 8acf    	vst1.64	{d8, d9}, [r9]
   653c6: f901 8acf    	vst1.64	{d8, d9}, [r1]
   653ca: d151         	bne	0x65470 <air1_opcal4_algorithm+0x3d88> @ imm = #0xa2
   653cc: f007 fd34    	bl	0x6ce38 <regress_cal>   @ imm = #0x7a68
   653d0: ed96 eb00    	vldr	d14, [r6]
   653d4: ed96 db02    	vldr	d13, [r6, #8]
   653d8: ef2e 111e    	vorr	d1, d14, d14
   653dc: ef2d 011d    	vorr	d0, d13, d13
   653e0: f007 fffa    	bl	0x6d3d8 <check_boundary> @ imm = #0x7ff4
   653e4: 9c53         	ldr	r4, [sp, #0x14c]
   653e6: 9d4f         	ldr	r5, [sp, #0x13c]
   653e8: b918         	cbnz	r0, 0x653f2 <air1_opcal4_algorithm+0x3d0a> @ imm = #0x6
   653ea: ed94 dbe2    	vldr	d13, [r4, #904]
   653ee: ed94 ebe4    	vldr	d14, [r4, #912]
   653f2: 2002         	movs	r0, #0x2
   653f4: 4649         	mov	r1, r9
   653f6: 7628         	strb	r0, [r5, #0x18]
   653f8: 4650         	mov	r0, r10
   653fa: f007 fd1d    	bl	0x6ce38 <regress_cal>   @ imm = #0x7a3a
   653fe: f50d 6040    	add.w	r0, sp, #0xc00
   65402: ed90 bb9c    	vldr	d11, [r0, #624]
   65406: f50d 6040    	add.w	r0, sp, #0xc00
   6540a: ef2b 111b    	vorr	d1, d11, d11
   6540e: ed90 cb9e    	vldr	d12, [r0, #632]
   65412: ef2c 011c    	vorr	d0, d12, d12
   65416: f007 ffdf    	bl	0x6d3d8 <check_boundary> @ imm = #0x7fbe
   6541a: 2800         	cmp	r0, #0x0
   6541c: d071         	beq	0x65502 <air1_opcal4_algorithm+0x3e1a> @ imm = #0xe2
   6541e: f894 1398    	ldrb.w	r1, [r4, #0x398]
   65422: 3901         	subs	r1, #0x1
   65424: fab1 f181    	clz	r1, r1
   65428: 0949         	lsrs	r1, r1, #0x5
   6542a: e072         	b	0x65512 <air1_opcal4_algorithm+0x3e2a> @ imm = #0xe4
   6542c: bf00         	nop
   6542e: bf00         	nop
   65430: 00 00 00 00  	.word	0x00000000
   65434: 00 00 4e 40  	.word	0x404e0000
   65438: 00 00 00 00  	.word	0x00000000
   6543c: 00 c0 58 40  	.word	0x4058c000
   65440: 9a 99 99 99  	.word	0x9999999a
   65444: 99 99 4c 40  	.word	0x404c9999
   65448: 00 00 00 00  	.word	0x00000000
   6544c: 00 00 59 40  	.word	0x40590000
   65450: 00 00 00 00  	.word	0x00000000
   65454: 00 00 44 40  	.word	0x40440000
   65458: 9a 99 99 99  	.word	0x9999999a
   6545c: 99 99 b9 3f  	.word	0x3fb99999
   65460: 00 00 00 00  	.word	0x00000000
   65464: 00 00 69 40  	.word	0x40690000
   65468: 00 00 00 00  	.word	0x00000000
   6546c: 00 00 59 c0  	.word	0xc0590000
   65470: 4649         	mov	r1, r9
   65472: f007 fce1    	bl	0x6ce38 <regress_cal>   @ imm = #0x79c2
   65476: f50d 6040    	add.w	r0, sp, #0xc00
   6547a: 9d4f         	ldr	r5, [sp, #0x13c]
   6547c: ed90 bb9c    	vldr	d11, [r0, #624]
   65480: f50d 6040    	add.w	r0, sp, #0xc00
   65484: ef2b 111b    	vorr	d1, d11, d11
   65488: 762c         	strb	r4, [r5, #0x18]
   6548a: ed90 cb9e    	vldr	d12, [r0, #632]
   6548e: ef2c 011c    	vorr	d0, d12, d12
   65492: f007 ffa1    	bl	0x6d3d8 <check_boundary> @ imm = #0x7f42
   65496: 9c53         	ldr	r4, [sp, #0x14c]
   65498: b930         	cbnz	r0, 0x654a8 <air1_opcal4_algorithm+0x3dc0> @ imm = #0xc
   6549a: ed94 cbe2    	vldr	d12, [r4, #904]
   6549e: 21fc         	movs	r1, #0xfc
   654a0: ed94 bbe4    	vldr	d11, [r4, #912]
   654a4: f884 1398    	strb.w	r1, [r4, #0x398]
   654a8: f894 1360    	ldrb.w	r1, [r4, #0x360]
   654ac: 2900         	cmp	r1, #0x0
   654ae: d141         	bne	0x65534 <air1_opcal4_algorithm+0x3e4c> @ imm = #0x82
   654b0: f894 1398    	ldrb.w	r1, [r4, #0x398]
   654b4: 2901         	cmp	r1, #0x1
   654b6: d122         	bne	0x654fe <air1_opcal4_algorithm+0x3e16> @ imm = #0x44
   654b8: edd4 1be8    	vldr	d17, [r4, #928]
   654bc: edd4 0bea    	vldr	d16, [r4, #936]
   654c0: ed5f 2b1f    	vldr	d18, [pc, #-124]        @ 0x65448 <air1_opcal4_algorithm+0x3d60>
   654c4: ee70 0be1    	vsub.f64	d16, d16, d17
   654c8: eef4 1b62    	vcmp.f64	d17, d18
   654cc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   654d0: d403         	bmi	0x654da <air1_opcal4_algorithm+0x3df2> @ imm = #0x6
   654d2: eec0 0ba1    	vdiv.f64	d16, d16, d17
   654d6: ee60 0ba2    	vmul.f64	d16, d16, d18
   654da: eefb 1b04    	vmov.f64	d17, #-2.000000e+01
   654de: eef4 0b61    	vcmp.f64	d16, d17
   654e2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   654e6: d407         	bmi	0x654f8 <air1_opcal4_algorithm+0x3e10> @ imm = #0xe
   654e8: ed5f 1b27    	vldr	d17, [pc, #-156]        @ 0x65450 <air1_opcal4_algorithm+0x3d68>
   654ec: eef4 0b61    	vcmp.f64	d16, d17
   654f0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   654f4: f241 806c    	bls.w	0x665d0 <air1_opcal4_algorithm+0x4ee8> @ imm = #0x10d8
   654f8: 21fa         	movs	r1, #0xfa
   654fa: f884 1398    	strb.w	r1, [r4, #0x398]
   654fe: 2102         	movs	r1, #0x2
   65500: e019         	b	0x65536 <air1_opcal4_algorithm+0x3e4e> @ imm = #0x32
   65502: 21fd         	movs	r1, #0xfd
   65504: ed94 cbe2    	vldr	d12, [r4, #904]
   65508: ed94 bbe4    	vldr	d11, [r4, #912]
   6550c: f884 1398    	strb.w	r1, [r4, #0x398]
   65510: 2100         	movs	r1, #0x0
   65512: ee7e 0b4b    	vsub.f64	d16, d14, d11
   65516: 2200         	movs	r2, #0x0
   65518: ee7d 1b4c    	vsub.f64	d17, d13, d12
   6551c: edc5 1b02    	vstr	d17, [r5, #8]
   65520: edc5 0b04    	vstr	d16, [r5, #16]
   65524: b149         	cbz	r1, 0x6553a <air1_opcal4_algorithm+0x3e52> @ imm = #0x12
   65526: eeb7 eb08    	vmov.f64	d14, #1.500000e+00
   6552a: f894 1360    	ldrb.w	r1, [r4, #0x360]
   6552e: ed1f db3c    	vldr	d13, [pc, #-240]        @ 0x65440 <air1_opcal4_algorithm+0x3d58>
   65532: b3c1         	cbz	r1, 0x655a6 <air1_opcal4_algorithm+0x3ebe> @ imm = #0x70
   65534: 21ff         	movs	r1, #0xff
   65536: 7669         	strb	r1, [r5, #0x19]
   65538: e036         	b	0x655a8 <air1_opcal4_algorithm+0x3ec0> @ imm = #0x6c
   6553a: eeb7 eb08    	vmov.f64	d14, #1.500000e+00
   6553e: ed1f db40    	vldr	d13, [pc, #-256]        @ 0x65440 <air1_opcal4_algorithm+0x3d58>
   65542: e031         	b	0x655a8 <air1_opcal4_algorithm+0x3ec0> @ imm = #0x62
   65544: 9800         	ldr	r0, [sp]
   65546: 2103         	movs	r1, #0x3
   65548: f007 f8aa    	bl	0x6c6a0 <math_mean>     @ imm = #0x7154
   6554c: edd8 0b54    	vldr	d16, [r8, #336]
   65550: eef5 0b40    	vcmp.f64	d16, #0
   65554: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65558: f040 82cd    	bne.w	0x65af6 <air1_opcal4_algorithm+0x440e> @ imm = #0x59a
   6555c: eef1 0b04    	vmov.f64	d16, #5.000000e+00
   65560: f8dd e0c4    	ldr.w	lr, [sp, #0xc4]
   65564: eeb4 cb60    	vcmp.f64	d12, d16
   65568: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6556c: dd04         	ble	0x65578 <air1_opcal4_algorithm+0x3e90> @ imm = #0x8
   6556e: eeb4 0b4f    	vcmp.f64	d0, d15
   65572: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65576: d40f         	bmi	0x65598 <air1_opcal4_algorithm+0x3eb0> @ imm = #0x1e
   65578: eef9 0b04    	vmov.f64	d16, #-5.000000e+00
   6557c: eeb4 cb60    	vcmp.f64	d12, d16
   65580: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65584: f57f aeb0    	bpl.w	0x652e8 <air1_opcal4_algorithm+0x3c00> @ imm = #-0x2a0
   65588: eeff 0b00    	vmov.f64	d16, #-1.000000e+00
   6558c: eeb4 0b60    	vcmp.f64	d0, d16
   65590: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65594: f77f aea8    	ble.w	0x652e8 <air1_opcal4_algorithm+0x3c00> @ imm = #-0x2b0
   65598: 48e3         	ldr	r0, [pc, #0x38c]        @ 0x65928 <air1_opcal4_algorithm+0x4240>
   6559a: 2100         	movs	r1, #0x0
   6559c: e9c8 1054    	strd	r1, r0, [r8, #336]
   655a0: 2003         	movs	r0, #0x3
   655a2: f7ff bac0    	b.w	0x64b26 <air1_opcal4_algorithm+0x343e> @ imm = #-0xa80
   655a6: 766a         	strb	r2, [r5, #0x19]
   655a8: eef0 0b04    	vmov.f64	d16, #2.500000e+00
   655ac: eeb4 cb60    	vcmp.f64	d12, d16
   655b0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   655b4: dc14         	bgt	0x655e0 <air1_opcal4_algorithm+0x3ef8> @ imm = #0x28
   655b6: ed5f 0b58    	vldr	d16, [pc, #-352]        @ 0x65458 <air1_opcal4_algorithm+0x3d70>
   655ba: eeb4 cb60    	vcmp.f64	d12, d16
   655be: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   655c2: d40d         	bmi	0x655e0 <air1_opcal4_algorithm+0x3ef8> @ imm = #0x1a
   655c4: ed5f 0b5a    	vldr	d16, [pc, #-360]        @ 0x65460 <air1_opcal4_algorithm+0x3d78>
   655c8: eeb4 bb60    	vcmp.f64	d11, d16
   655cc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   655d0: dc06         	bgt	0x655e0 <air1_opcal4_algorithm+0x3ef8> @ imm = #0xc
   655d2: ed5f 0b5b    	vldr	d16, [pc, #-364]        @ 0x65468 <air1_opcal4_algorithm+0x3d80>
   655d6: eeb4 bb60    	vcmp.f64	d11, d16
   655da: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   655de: d50a         	bpl	0x655f6 <air1_opcal4_algorithm+0x3f0e> @ imm = #0x14
   655e0: 20fb         	movs	r0, #0xfb
   655e2: eeb0 cb4f    	vmov.f64	d12, d15
   655e6: f884 0398    	strb.w	r0, [r4, #0x398]
   655ea: 9808         	ldr	r0, [sp, #0x20]
   655ec: ef80 b010    	vmov.i32	d11, #0x0
   655f0: f900 8acf    	vst1.64	{d8, d9}, [r0]
   655f4: 2000         	movs	r0, #0x0
   655f6: f895 8018    	ldrb.w	r8, [r5, #0x18]
   655fa: f884 03c0    	strb.w	r0, [r4, #0x3c0]
   655fe: ed84 cbec    	vstr	d12, [r4, #944]
   65602: ed84 bbee    	vstr	d11, [r4, #952]
   65606: f50d 650d    	add.w	r5, sp, #0x8d0
   6560a: f8ba 0648    	ldrh.w	r0, [r10, #0x648]
   6560e: 2150         	movs	r1, #0x50
   65610: 9057         	str	r0, [sp, #0x15c]
   65612: 4648         	mov	r0, r9
   65614: f009 ecf4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x99e8
   65618: f50d 603a    	add.w	r0, sp, #0xba0
   6561c: 2150         	movs	r1, #0x50
   6561e: f009 ecf0    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x99e0
   65622: 9853         	ldr	r0, [sp, #0x14c]
   65624: f1b8 0f02    	cmp.w	r8, #0x2
   65628: edd0 0bec    	vldr	d16, [r0, #944]
   6562c: ed90 bbee    	vldr	d11, [r0, #952]
   65630: d108         	bne	0x65644 <air1_opcal4_algorithm+0x3f5c> @ imm = #0x10
   65632: 9c4f         	ldr	r4, [sp, #0x13c]
   65634: edd4 1b02    	vldr	d17, [r4, #8]
   65638: edd4 2b04    	vldr	d18, [r4, #16]
   6563c: ee70 0ba1    	vadd.f64	d16, d16, d17
   65640: ee3b bb22    	vadd.f64	d11, d11, d18
   65644: 9b1f         	ldr	r3, [sp, #0x7c]
   65646: 2009         	movs	r0, #0x9
   65648: 991e         	ldr	r1, [sp, #0x78]
   6564a: f8dd 814c    	ldr.w	r8, [sp, #0x14c]
   6564e: b130         	cbz	r0, 0x6565e <air1_opcal4_algorithm+0x3f76> @ imm = #0xc
   65650: edd1 1b00    	vldr	d17, [r1]
   65654: 3801         	subs	r0, #0x1
   65656: ed41 1b02    	vstr	d17, [r1, #-8]
   6565a: 3108         	adds	r1, #0x8
   6565c: e7f7         	b	0x6564e <air1_opcal4_algorithm+0x3f66> @ imm = #-0x12
   6565e: 2000         	movs	r0, #0x0
   65660: edc8 0bc2    	vstr	d16, [r8, #776]
   65664: 2850         	cmp	r0, #0x50
   65666: d008         	beq	0x6567a <air1_opcal4_algorithm+0x3f92> @ imm = #0x10
   65668: 181a         	adds	r2, r3, r0
   6566a: eb09 0100    	add.w	r1, r9, r0
   6566e: 3008         	adds	r0, #0x8
   65670: edd2 0b00    	vldr	d16, [r2]
   65674: edc1 0b00    	vstr	d16, [r1]
   65678: e7f4         	b	0x65664 <air1_opcal4_algorithm+0x3f7c> @ imm = #-0x18
   6567a: 4628         	mov	r0, r5
   6567c: 2400         	movs	r4, #0x0
   6567e: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   65682: 4649         	mov	r1, r9
   65684: 462a         	mov	r2, r5
   65686: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   6568a: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   6568e: 6004         	str	r4, [r0]
   65690: 9857         	ldr	r0, [sp, #0x15c]
   65692: f8cd 4904    	str.w	r4, [sp, #0x904]
   65696: f007 ffb7    	bl	0x6d608 <apply_simple_smooth> @ imm = #0x7f6e
   6569a: 9e40         	ldr	r6, [sp, #0x100]
   6569c: f50d 613a    	add.w	r1, sp, #0xba0
   656a0: 4658         	mov	r0, r11
   656a2: f04f 0c00    	mov.w	r12, #0x0
   656a6: 2c38         	cmp	r4, #0x38
   656a8: d008         	beq	0x656bc <air1_opcal4_algorithm+0x3fd4> @ imm = #0x10
   656aa: 192a         	adds	r2, r5, r4
   656ac: 3408         	adds	r4, #0x8
   656ae: edd2 0b00    	vldr	d16, [r2]
   656b2: edc0 0b22    	vstr	d16, [r0, #136]
   656b6: ece0 0b02    	vstmia	r0!, {d16}
   656ba: e7f4         	b	0x656a6 <air1_opcal4_algorithm+0x3fbe> @ imm = #-0x18
   656bc: 9d21         	ldr	r5, [sp, #0x84]
   656be: f06f 0047    	mvn	r0, #0x47
   656c2: b150         	cbz	r0, 0x656da <air1_opcal4_algorithm+0x3ff2> @ imm = #0x14
   656c4: eb0a 0200    	add.w	r2, r10, r0
   656c8: 1833         	adds	r3, r6, r0
   656ca: f502 5237    	add.w	r2, r2, #0x2dc0
   656ce: 3008         	adds	r0, #0x8
   656d0: edd2 0b00    	vldr	d16, [r2]
   656d4: edc3 0b12    	vstr	d16, [r3, #72]
   656d8: e7f3         	b	0x656c2 <air1_opcal4_algorithm+0x3fda> @ imm = #-0x1a
   656da: f50d 60c0    	add.w	r0, sp, #0x600
   656de: ed88 bbd6    	vstr	d11, [r8, #856]
   656e2: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   656e6: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   656ea: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   656ee: f8c0 c000    	str.w	r12, [r0]
   656f2: f06f 004f    	mvn	r0, #0x4f
   656f6: f8cd c634    	str.w	r12, [sp, #0x634]
   656fa: b150         	cbz	r0, 0x65712 <air1_opcal4_algorithm+0x402a> @ imm = #0x14
   656fc: eb0a 0200    	add.w	r2, r10, r0
   65700: 180b         	adds	r3, r1, r0
   65702: f502 5237    	add.w	r2, r2, #0x2dc0
   65706: 3008         	adds	r0, #0x8
   65708: edd2 0b00    	vldr	d16, [r2]
   6570c: edc3 0b14    	vstr	d16, [r3, #80]
   65710: e7f3         	b	0x656fa <air1_opcal4_algorithm+0x4012> @ imm = #-0x1a
   65712: 9857         	ldr	r0, [sp, #0x15c]
   65714: f50d 62c0    	add.w	r2, sp, #0x600
   65718: f007 ff76    	bl	0x6d608 <apply_simple_smooth> @ imm = #0x7eec
   6571c: 9b3f         	ldr	r3, [sp, #0xfc]
   6571e: f06f 0037    	mvn	r0, #0x37
   65722: 9e4f         	ldr	r6, [sp, #0x13c]
   65724: b178         	cbz	r0, 0x65746 <air1_opcal4_algorithm+0x405e> @ imm = #0x1e
   65726: f50d 62c0    	add.w	r2, sp, #0x600
   6572a: eb0a 0100    	add.w	r1, r10, r0
   6572e: 4402         	add	r2, r0
   65730: f501 5137    	add.w	r1, r1, #0x2dc0
   65734: edd2 0b0e    	vldr	d16, [r2, #56]
   65738: edc1 0b00    	vstr	d16, [r1]
   6573c: 1819         	adds	r1, r3, r0
   6573e: 3008         	adds	r0, #0x8
   65740: edc1 0b0e    	vstr	d16, [r1, #56]
   65744: e7ee         	b	0x65724 <air1_opcal4_algorithm+0x403c> @ imm = #-0x24
   65746: f50d 643a    	add.w	r4, sp, #0xba0
   6574a: 2000         	movs	r0, #0x0
   6574c: f04f 0c00    	mov.w	r12, #0x0
   65750: 2838         	cmp	r0, #0x38
   65752: d011         	beq	0x65778 <air1_opcal4_algorithm+0x4090> @ imm = #0x22
   65754: eb0a 0200    	add.w	r2, r10, r0
   65758: eb0b 0100    	add.w	r1, r11, r0
   6575c: f502 5231    	add.w	r2, r2, #0x2c40
   65760: 3008         	adds	r0, #0x8
   65762: edd1 0b00    	vldr	d16, [r1]
   65766: edd2 2b00    	vldr	d18, [r2]
   6576a: edd1 1b0e    	vldr	d17, [r1, #56]
   6576e: ee40 1ba2    	vmla.f64	d17, d16, d18
   65772: ed41 1b0e    	vstr	d17, [r1, #-56]
   65776: e7eb         	b	0x65750 <air1_opcal4_algorithm+0x4068> @ imm = #-0x2a
   65778: 464a         	mov	r2, r9
   6577a: 2100         	movs	r1, #0x0
   6577c: f902 8acd    	vst1.64	{d8, d9}, [r2]!
   65780: f902 8acd    	vst1.64	{d8, d9}, [r2]!
   65784: f902 8acd    	vst1.64	{d8, d9}, [r2]!
   65788: 6011         	str	r1, [r2]
   6578a: 4622         	mov	r2, r4
   6578c: f902 8acd    	vst1.64	{d8, d9}, [r2]!
   65790: f902 8acd    	vst1.64	{d8, d9}, [r2]!
   65794: 7e70         	ldrb	r0, [r6, #0x19]
   65796: f8dd b054    	ldr.w	r11, [sp, #0x54]
   6579a: f902 8acd    	vst1.64	{d8, d9}, [r2]!
   6579e: f8cd 1ea4    	str.w	r1, [sp, #0xea4]
   657a2: 6011         	str	r1, [r2]
   657a4: f8cd 1bd4    	str.w	r1, [sp, #0xbd4]
   657a8: 2938         	cmp	r1, #0x38
   657aa: d00f         	beq	0x657cc <air1_opcal4_algorithm+0x40e4> @ imm = #0x1e
   657ac: 186b         	adds	r3, r5, r1
   657ae: eb09 0201    	add.w	r2, r9, r1
   657b2: edd3 0b00    	vldr	d16, [r3]
   657b6: eb0b 0301    	add.w	r3, r11, r1
   657ba: edc2 0b00    	vstr	d16, [r2]
   657be: 1862         	adds	r2, r4, r1
   657c0: edd3 0b00    	vldr	d16, [r3]
   657c4: 3108         	adds	r1, #0x8
   657c6: edc2 0b00    	vstr	d16, [r2]
   657ca: e7ed         	b	0x657a8 <air1_opcal4_algorithm+0x40c0> @ imm = #-0x26
   657cc: 9b5c         	ldr	r3, [sp, #0x170]
   657ce: f893 1303    	ldrb.w	r1, [r3, #0x303]
   657d2: 4288         	cmp	r0, r1
   657d4: d108         	bne	0x657e8 <air1_opcal4_algorithm+0x4100> @ imm = #0x10
   657d6: f886 c0c8    	strb.w	r12, [r6, #0xc8]
   657da: edd3 0bd2    	vldr	d16, [r3, #840]
   657de: edc6 0b08    	vstr	d16, [r6, #32]
   657e2: f893 1304    	ldrb.w	r1, [r3, #0x304]
   657e6: e021         	b	0x6582c <air1_opcal4_algorithm+0x4144> @ imm = #0x42
   657e8: f893 1304    	ldrb.w	r1, [r3, #0x304]
   657ec: 4288         	cmp	r0, r1
   657ee: d107         	bne	0x65800 <air1_opcal4_algorithm+0x4118> @ imm = #0xe
   657f0: 2001         	movs	r0, #0x1
   657f2: f886 00c8    	strb.w	r0, [r6, #0xc8]
   657f6: edd3 0bd0    	vldr	d16, [r3, #832]
   657fa: edc6 0b0c    	vstr	d16, [r6, #48]
   657fe: e01c         	b	0x6583a <air1_opcal4_algorithm+0x4152> @ imm = #0x38
   65800: f893 2305    	ldrb.w	r2, [r3, #0x305]
   65804: 4290         	cmp	r0, r2
   65806: d107         	bne	0x65818 <air1_opcal4_algorithm+0x4130> @ imm = #0xe
   65808: 2201         	movs	r2, #0x1
   6580a: f886 20c8    	strb.w	r2, [r6, #0xc8]
   6580e: edd3 0bce    	vldr	d16, [r3, #824]
   65812: edc6 0b0c    	vstr	d16, [r6, #48]
   65816: e009         	b	0x6582c <air1_opcal4_algorithm+0x4144> @ imm = #0x12
   65818: f893 2302    	ldrb.w	r2, [r3, #0x302]
   6581c: 4290         	cmp	r0, r2
   6581e: bf02         	ittt	eq
   65820: f886 c0c8    	strbeq.w	r12, [r6, #0xc8]
   65824: edd3 0bd4    	vldreq	d16, [r3, #848]
   65828: edc6 0b08    	vstreq	d16, [r6, #32]
   6582c: 4288         	cmp	r0, r1
   6582e: d004         	beq	0x6583a <air1_opcal4_algorithm+0x4152> @ imm = #0x8
   65830: 995c         	ldr	r1, [sp, #0x170]
   65832: f891 1305    	ldrb.w	r1, [r1, #0x305]
   65836: 4288         	cmp	r0, r1
   65838: d109         	bne	0x6584e <air1_opcal4_algorithm+0x4166> @ imm = #0x12
   6583a: f896 00d2    	ldrb.w	r0, [r6, #0xd2]
   6583e: b930         	cbnz	r0, 0x6584e <air1_opcal4_algorithm+0x4166> @ imm = #0xc
   65840: edd6 0b08    	vldr	d16, [r6, #32]
   65844: 2001         	movs	r0, #0x1
   65846: f886 00d2    	strb.w	r0, [r6, #0xd2]
   6584a: edc6 0b0e    	vstr	d16, [r6, #56]
   6584e: ed96 bb08    	vldr	d11, [r6, #32]
   65852: f896 00c8    	ldrb.w	r0, [r6, #0xc8]
   65856: ee7f 0b4b    	vsub.f64	d16, d15, d11
   6585a: 2801         	cmp	r0, #0x1
   6585c: edc6 0b0a    	vstr	d16, [r6, #40]
   65860: d132         	bne	0x658c8 <air1_opcal4_algorithm+0x41e0> @ imm = #0x64
   65862: ed96 cb0c    	vldr	d12, [r6, #48]
   65866: eeb4 bb4c    	vcmp.f64	d11, d12
   6586a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6586e: d02b         	beq	0x658c8 <air1_opcal4_algorithm+0x41e0> @ imm = #0x56
   65870: eeb0 0b4b    	vmov.f64	d0, d11
   65874: 2001         	movs	r0, #0x1
   65876: f886 00c9    	strb.w	r0, [r6, #0xc9]
   6587a: 2002         	movs	r0, #0x2
   6587c: 2105         	movs	r1, #0x5
   6587e: eeb0 1b4c    	vmov.f64	d1, d12
   65882: f006 ffd1    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x6fa2
   65886: 9e4f         	ldr	r6, [sp, #0x13c]
   65888: b998         	cbnz	r0, 0x658b2 <air1_opcal4_algorithm+0x41ca> @ imm = #0x26
   6588a: 985c         	ldr	r0, [sp, #0x170]
   6588c: edd6 0b0e    	vldr	d16, [r6, #56]
   65890: f8b0 0306    	ldrh.w	r0, [r0, #0x306]
   65894: ee70 0bcc    	vsub.f64	d16, d16, d12
   65898: ee00 0a10    	vmov	s0, r0
   6589c: eef8 1b40    	vcvt.f64.u32	d17, s0
   658a0: eec0 0ba1    	vdiv.f64	d16, d16, d17
   658a4: ee3b bb60    	vsub.f64	d11, d11, d16
   658a8: eeb4 bb4c    	vcmp.f64	d11, d12
   658ac: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   658b0: d501         	bpl	0x658b6 <air1_opcal4_algorithm+0x41ce> @ imm = #0x2
   658b2: eeb0 bb4c    	vmov.f64	d11, d12
   658b6: ee7f 0b4b    	vsub.f64	d16, d15, d11
   658ba: f50d 643a    	add.w	r4, sp, #0xba0
   658be: ed86 bb08    	vstr	d11, [r6, #32]
   658c2: edc6 0b0a    	vstr	d16, [r6, #40]
   658c6: e001         	b	0x658cc <air1_opcal4_algorithm+0x41e4> @ imm = #0x2
   658c8: f886 c0c9    	strb.w	r12, [r6, #0xc9]
   658cc: 9d5f         	ldr	r5, [sp, #0x17c]
   658ce: f06f 0037    	mvn	r0, #0x37
   658d2: 9922         	ldr	r1, [sp, #0x88]
   658d4: edc6 0b2a    	vstr	d16, [r6, #168]
   658d8: ed86 bb1c    	vstr	d11, [r6, #112]
   658dc: b1b0         	cbz	r0, 0x6590c <air1_opcal4_algorithm+0x4224> @ imm = #0x2c
   658de: 1822         	adds	r2, r4, r0
   658e0: edd1 1b00    	vldr	d17, [r1]
   658e4: ed51 2b0e    	vldr	d18, [r1, #-56]
   658e8: 3108         	adds	r1, #0x8
   658ea: edd2 0b0e    	vldr	d16, [r2, #56]
   658ee: eb09 0200    	add.w	r2, r9, r0
   658f2: ee61 0ba0    	vmul.f64	d16, d17, d16
   658f6: edd2 1b0e    	vldr	d17, [r2, #56]
   658fa: 182a         	adds	r2, r5, r0
   658fc: f502 62ea    	add.w	r2, r2, #0x750
   65900: 3008         	adds	r0, #0x8
   65902: ee42 0ba1    	vmla.f64	d16, d18, d17
   65906: edc2 0b00    	vstr	d16, [r2]
   6590a: e7e7         	b	0x658dc <air1_opcal4_algorithm+0x41f4> @ imm = #-0x32
   6590c: 9923         	ldr	r1, [sp, #0x8c]
   6590e: 2006         	movs	r0, #0x6
   65910: b160         	cbz	r0, 0x6592c <air1_opcal4_algorithm+0x4244> @ imm = #0x18
   65912: edd1 0b00    	vldr	d16, [r1]
   65916: 3801         	subs	r0, #0x1
   65918: ed51 1b0e    	vldr	d17, [r1, #-56]
   6591c: ed41 0b02    	vstr	d16, [r1, #-8]
   65920: ed41 1b10    	vstr	d17, [r1, #-64]
   65924: 3108         	adds	r1, #0x8
   65926: e7f3         	b	0x65910 <air1_opcal4_algorithm+0x4228> @ imm = #-0x1a
   65928: 00 00 f0 3f  	.word	0x3ff00000
   6592c: 4649         	mov	r1, r9
   6592e: f505 60e9    	add.w	r0, r5, #0x748
   65932: f901 8acd    	vst1.64	{d8, d9}, [r1]!
   65936: f901 8acd    	vst1.64	{d8, d9}, [r1]!
   6593a: edd0 0b00    	vldr	d16, [r0]
   6593e: f901 8acd    	vst1.64	{d8, d9}, [r1]!
   65942: 9057         	str	r0, [sp, #0x15c]
   65944: 2000         	movs	r0, #0x0
   65946: 6008         	str	r0, [r1]
   65948: f8cd 0ea4    	str.w	r0, [sp, #0xea4]
   6594c: 2838         	cmp	r0, #0x38
   6594e: d00a         	beq	0x65966 <air1_opcal4_algorithm+0x427e> @ imm = #0x14
   65950: 182a         	adds	r2, r5, r0
   65952: eb09 0100    	add.w	r1, r9, r0
   65956: f502 62e3    	add.w	r2, r2, #0x718
   6595a: 3008         	adds	r0, #0x8
   6595c: edd2 1b00    	vldr	d17, [r2]
   65960: edc1 1b00    	vstr	d17, [r1]
   65964: e7f2         	b	0x6594c <air1_opcal4_algorithm+0x4264> @ imm = #-0x1c
   65966: 985c         	ldr	r0, [sp, #0x170]
   65968: f890 038c    	ldrb.w	r0, [r0, #0x38c]
   6596c: b108         	cbz	r0, 0x65972 <air1_opcal4_algorithm+0x428a> @ imm = #0x2
   6596e: 7e31         	ldrb	r1, [r6, #0x18]
   65970: b191         	cbz	r1, 0x65998 <air1_opcal4_algorithm+0x42b0> @ imm = #0x24
   65972: 2000         	movs	r0, #0x0
   65974: 2838         	cmp	r0, #0x38
   65976: d00a         	beq	0x6598e <air1_opcal4_algorithm+0x42a6> @ imm = #0x14
   65978: eb09 0200    	add.w	r2, r9, r0
   6597c: 1829         	adds	r1, r5, r0
   6597e: f501 61eb    	add.w	r1, r1, #0x758
   65982: 3008         	adds	r0, #0x8
   65984: edd2 0b00    	vldr	d16, [r2]
   65988: edc1 0b00    	vstr	d16, [r1]
   6598c: e7f2         	b	0x65974 <air1_opcal4_algorithm+0x428c> @ imm = #-0x1c
   6598e: f50d 6040    	add.w	r0, sp, #0xc00
   65992: edd0 1ba8    	vldr	d17, [r0, #672]
   65996: e03b         	b	0x65a10 <air1_opcal4_algorithm+0x4328> @ imm = #0x76
   65998: 2802         	cmp	r0, #0x2
   6599a: d017         	beq	0x659cc <air1_opcal4_algorithm+0x42e4> @ imm = #0x2e
   6599c: efc0 1010    	vmov.i32	d17, #0x0
   659a0: 2801         	cmp	r0, #0x1
   659a2: d123         	bne	0x659ec <air1_opcal4_algorithm+0x4304> @ imm = #0x46
   659a4: 985c         	ldr	r0, [sp, #0x170]
   659a6: f500 7064    	add.w	r0, r0, #0x390
   659aa: ecf0 1b08    	vldmia	r0!, {d17, d18, d19, d20}
   659ae: ee60 2ba2    	vmul.f64	d18, d16, d18
   659b2: ee60 1ba1    	vmul.f64	d17, d16, d17
   659b6: ee60 1ba1    	vmul.f64	d17, d16, d17
   659ba: ee60 2ba2    	vmul.f64	d18, d16, d18
   659be: ee41 2ba0    	vmla.f64	d18, d17, d16
   659c2: ee43 2ba0    	vmla.f64	d18, d19, d16
   659c6: ee74 1ba2    	vadd.f64	d17, d20, d18
   659ca: e00f         	b	0x659ec <air1_opcal4_algorithm+0x4304> @ imm = #0x1e
   659cc: 985c         	ldr	r0, [sp, #0x170]
   659ce: f500 706c    	add.w	r0, r0, #0x3b0
   659d2: ecf0 1b06    	vldmia	r0!, {d17, d18, d19}
   659d6: ee60 1ba1    	vmul.f64	d17, d16, d17
   659da: eef4 1b62    	vcmp.f64	d17, d18
   659de: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   659e2: bfc8         	it	gt
   659e4: eef0 1b62    	vmovgt.f64	d17, d18
   659e8: ee50 1ba3    	vnmls.f64	d17, d16, d19
   659ec: 2000         	movs	r0, #0x0
   659ee: 2830         	cmp	r0, #0x30
   659f0: d00a         	beq	0x65a08 <air1_opcal4_algorithm+0x4320> @ imm = #0x14
   659f2: eb09 0200    	add.w	r2, r9, r0
   659f6: 1829         	adds	r1, r5, r0
   659f8: f501 61eb    	add.w	r1, r1, #0x758
   659fc: 3008         	adds	r0, #0x8
   659fe: edd2 0b00    	vldr	d16, [r2]
   65a02: edc1 0b00    	vstr	d16, [r1]
   65a06: e7f2         	b	0x659ee <air1_opcal4_algorithm+0x4306> @ imm = #-0x1c
   65a08: f505 60f1    	add.w	r0, r5, #0x788
   65a0c: edc0 1b00    	vstr	d17, [r0]
   65a10: f505 60ea    	add.w	r0, r5, #0x750
   65a14: 994d         	ldr	r1, [sp, #0x134]
   65a16: edc0 1b00    	vstr	d17, [r0]
   65a1a: 4650         	mov	r0, r10
   65a1c: f000 fe34    	bl	0x66688 <check_error>   @ imm = #0xc68
   65a20: 2400         	movs	r4, #0x0
   65a22: 48e5         	ldr	r0, [pc, #0x394]        @ 0x65db8 <air1_opcal4_algorithm+0x46d0>
   65a24: f8c5 47a0    	str.w	r4, [r5, #0x7a0]
   65a28: f8c5 07a4    	str.w	r0, [r5, #0x7a4]
   65a2c: f8ba 0648    	ldrh.w	r0, [r10, #0x648]
   65a30: f8d7 e008    	ldr.w	lr, [r7, #0x8]
   65a34: 9e4b         	ldr	r6, [sp, #0x12c]
   65a36: 280c         	cmp	r0, #0xc
   65a38: 9d5d         	ldr	r5, [sp, #0x174]
   65a3a: eddf 0be1    	vldr	d16, [pc, #900]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65a3e: f0c0 80f7    	blo.w	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x1ee
   65a42: eddf 0bdf    	vldr	d16, [pc, #892]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65a46: 2000         	movs	r0, #0x0
   65a48: 2818         	cmp	r0, #0x18
   65a4a: d00e         	beq	0x65a6a <air1_opcal4_algorithm+0x4382> @ imm = #0x1c
   65a4c: eb0a 0100    	add.w	r1, r10, r0
   65a50: f8d1 262c    	ldr.w	r2, [r1, #0x62c]
   65a54: f8d1 1630    	ldr.w	r1, [r1, #0x630]
   65a58: 1a89         	subs	r1, r1, r2
   65a5a: f164 0200    	sbc	r2, r4, #0x0
   65a5e: 3004         	adds	r0, #0x4
   65a60: 39b5         	subs	r1, #0xb5
   65a62: f172 0100    	sbcs	r1, r2, #0x0
   65a66: daef         	bge	0x65a48 <air1_opcal4_algorithm+0x4360> @ imm = #-0x22
   65a68: e0e2         	b	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x1c4
   65a6a: 985f         	ldr	r0, [sp, #0x17c]
   65a6c: f8da 162c    	ldr.w	r1, [r10, #0x62c]
   65a70: 6840         	ldr	r0, [r0, #0x4]
   65a72: 1a42         	subs	r2, r0, r1
   65a74: f5b2 6f96    	cmp.w	r2, #0x4b0
   65a78: f0c0 80da    	blo.w	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x1b4
   65a7c: eddf 0bd0    	vldr	d16, [pc, #832]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65a80: f640 0334    	movw	r3, #0x834
   65a84: 429a         	cmp	r2, r3
   65a86: f200 80d3    	bhi.w	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x1a6
   65a8a: eddf 0bcd    	vldr	d16, [pc, #820]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65a8e: 2200         	movs	r2, #0x0
   65a90: 2a07         	cmp	r2, #0x7
   65a92: d005         	beq	0x65aa0 <air1_opcal4_algorithm+0x43b8> @ imm = #0xa
   65a94: 9b0e         	ldr	r3, [sp, #0x38]
   65a96: 5c9b         	ldrb	r3, [r3, r2]
   65a98: 3201         	adds	r2, #0x1
   65a9a: 2b01         	cmp	r3, #0x1
   65a9c: d1f8         	bne	0x65a90 <air1_opcal4_algorithm+0x43a8> @ imm = #-0x10
   65a9e: e0c7         	b	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x18e
   65aa0: 9a5c         	ldr	r2, [sp, #0x170]
   65aa2: 2300         	movs	r3, #0x0
   65aa4: edd2 0b02    	vldr	d16, [r2, #8]
   65aa8: edd2 1b04    	vldr	d17, [r2, #16]
   65aac: f103 0208    	add.w	r2, r3, #0x8
   65ab0: 2a40         	cmp	r2, #0x40
   65ab2: d03a         	beq	0x65b2a <air1_opcal4_algorithm+0x4442> @ imm = #0x74
   65ab4: 9d5f         	ldr	r5, [sp, #0x17c]
   65ab6: 442b         	add	r3, r5
   65ab8: f503 63eb    	add.w	r3, r3, #0x758
   65abc: edd3 2b00    	vldr	d18, [r3]
   65ac0: eef4 2b61    	vcmp.f64	d18, d17
   65ac4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65ac8: f100 80af    	bmi.w	0x65c2a <air1_opcal4_algorithm+0x4542> @ imm = #0x15e
   65acc: eef4 2b60    	vcmp.f64	d18, d16
   65ad0: 9d5d         	ldr	r5, [sp, #0x174]
   65ad2: 4613         	mov	r3, r2
   65ad4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65ad8: dde8         	ble	0x65aac <air1_opcal4_algorithm+0x43c4> @ imm = #-0x30
   65ada: eddf 0bb9    	vldr	d16, [pc, #740]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65ade: e0a7         	b	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x14e
   65ae0: eddf 3bb9    	vldr	d19, [pc, #740]         @ 0x65dc8 <air1_opcal4_algorithm+0x46e0>
   65ae4: eef4 1b63    	vcmp.f64	d17, d19
   65ae8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65aec: f340 8566    	ble.w	0x665bc <air1_opcal4_algorithm+0x4ed4> @ imm = #0xacc
   65af0: 2105         	movs	r1, #0x5
   65af2: f7fe bc81    	b.w	0x643f8 <air1_opcal4_algorithm+0x2d10> @ imm = #-0x16fe
   65af6: eeb5 cb40    	vcmp.f64	d12, #0
   65afa: eef1 1b4c    	vneg.f64	d17, d12
   65afe: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65b02: bf48         	it	mi
   65b04: eeb0 cb61    	vmovmi.f64	d12, d17
   65b08: eef0 1b08    	vmov.f64	d17, #3.000000e+00
   65b0c: eeb4 cb61    	vcmp.f64	d12, d17
   65b10: ee70 0b8f    	vadd.f64	d16, d16, d15
   65b14: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65b18: bfc8         	it	gt
   65b1a: eef0 0b4f    	vmovgt.f64	d16, d15
   65b1e: f8dd e0c4    	ldr.w	lr, [sp, #0xc4]
   65b22: edc8 0b54    	vstr	d16, [r8, #336]
   65b26: f7ff bbdf    	b.w	0x652e8 <air1_opcal4_algorithm+0x3c00> @ imm = #-0x842
   65b2a: 9a5f         	ldr	r2, [sp, #0x17c]
   65b2c: eddf 0ba4    	vldr	d16, [pc, #656]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65b30: f502 62eb    	add.w	r2, r2, #0x758
   65b34: edd2 3b0c    	vldr	d19, [r2, #48]
   65b38: eef5 3b40    	vcmp.f64	d19, #0
   65b3c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65b40: dd76         	ble	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0xec
   65b42: edd2 4b00    	vldr	d20, [r2]
   65b46: eddf 0b9e    	vldr	d16, [pc, #632]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65b4a: eef5 4b40    	vcmp.f64	d20, #0
   65b4e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65b52: dd6d         	ble	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0xda
   65b54: ee00 1a10    	vmov	s0, r1
   65b58: eddf 6b9b    	vldr	d22, [pc, #620]         @ 0x65dc8 <air1_opcal4_algorithm+0x46e0>
   65b5c: ee73 0be4    	vsub.f64	d16, d19, d20
   65b60: f8da c63c    	ldr.w	r12, [r10, #0x63c]
   65b64: f8da 3640    	ldr.w	r3, [r10, #0x640]
   65b68: eef8 4b40    	vcvt.f64.u32	d20, s0
   65b6c: ee00 0a10    	vmov	s0, r0
   65b70: edd2 2b0a    	vldr	d18, [r2, #40]
   65b74: 985f         	ldr	r0, [sp, #0x17c]
   65b76: eef8 5b40    	vcvt.f64.u32	d21, s0
   65b7a: f500 60f4    	add.w	r0, r0, #0x7a0
   65b7e: ee75 4be4    	vsub.f64	d20, d21, d20
   65b82: eec4 4ba6    	vdiv.f64	d20, d20, d22
   65b86: eec0 0ba4    	vdiv.f64	d16, d16, d20
   65b8a: eef5 2b40    	vcmp.f64	d18, #0
   65b8e: edd2 1b08    	vldr	d17, [r2, #32]
   65b92: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65b96: edc0 0b00    	vstr	d16, [r0]
   65b9a: bfc4         	itt	gt
   65b9c: eef5 1b40    	vcmpgt.f64	d17, #0
   65ba0: eef1 fa10    	vmrsgt	APSR_nzcv, fpscr
   65ba4: dd44         	ble	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x88
   65ba6: ee00 3a10    	vmov	s0, r3
   65baa: eddf 6b87    	vldr	d22, [pc, #540]         @ 0x65dc8 <air1_opcal4_algorithm+0x46e0>
   65bae: ee73 3be2    	vsub.f64	d19, d19, d18
   65bb2: eef8 4b40    	vcvt.f64.u32	d20, s0
   65bb6: ee75 5be4    	vsub.f64	d21, d21, d20
   65bba: eec5 5ba6    	vdiv.f64	d21, d21, d22
   65bbe: eec3 3ba5    	vdiv.f64	d19, d19, d21
   65bc2: eef5 3b40    	vcmp.f64	d19, #0
   65bc6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65bca: d504         	bpl	0x65bd6 <air1_opcal4_algorithm+0x44ee> @ imm = #0x8
   65bcc: eef4 0b4f    	vcmp.f64	d16, d15
   65bd0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65bd4: da0b         	bge	0x65bee <air1_opcal4_algorithm+0x4506> @ imm = #0x16
   65bd6: eef5 3b40    	vcmp.f64	d19, #0
   65bda: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65bde: dd27         	ble	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x4e
   65be0: eeff 5b00    	vmov.f64	d21, #-1.000000e+00
   65be4: eef4 0b65    	vcmp.f64	d16, d21
   65be8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65bec: d820         	bhi	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x40
   65bee: ee00 ca10    	vmov	s0, r12
   65bf2: ee72 0be1    	vsub.f64	d16, d18, d17
   65bf6: eef8 1b40    	vcvt.f64.u32	d17, s0
   65bfa: ee74 1be1    	vsub.f64	d17, d20, d17
   65bfe: eddf 2b72    	vldr	d18, [pc, #456]         @ 0x65dc8 <air1_opcal4_algorithm+0x46e0>
   65c02: eec1 1ba2    	vdiv.f64	d17, d17, d18
   65c06: eec0 0ba1    	vdiv.f64	d16, d16, d17
   65c0a: ee63 0ba0    	vmul.f64	d16, d19, d16
   65c0e: eef5 0b40    	vcmp.f64	d16, #0
   65c12: efc0 0010    	vmov.i32	d16, #0x0
   65c16: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65c1a: bf48         	it	mi
   65c1c: eef0 3b60    	vmovmi.f64	d19, d16
   65c20: ef63 01b3    	vorr	d16, d19, d19
   65c24: edc0 3b00    	vstr	d19, [r0]
   65c28: e002         	b	0x65c30 <air1_opcal4_algorithm+0x4548> @ imm = #0x4
   65c2a: eddf 0b65    	vldr	d16, [pc, #404]         @ 0x65dc0 <air1_opcal4_algorithm+0x46d8>
   65c2e: 9d5d         	ldr	r5, [sp, #0x174]
   65c30: 983e         	ldr	r0, [sp, #0xf8]
   65c32: f8dd c10c    	ldr.w	r12, [sp, #0x10c]
   65c36: 8800         	ldrh	r0, [r0]
   65c38: 8028         	strh	r0, [r5]
   65c3a: 9854         	ldr	r0, [sp, #0x150]
   65c3c: f830 001c    	ldrh.w	r0, [r0, r12, lsl #1]
   65c40: 8068         	strh	r0, [r5, #0x2]
   65c42: 983d         	ldr	r0, [sp, #0xf4]
   65c44: 6800         	ldr	r0, [r0]
   65c46: 6068         	str	r0, [r5, #0x4]
   65c48: 2000         	movs	r0, #0x0
   65c4a: 281e         	cmp	r0, #0x1e
   65c4c: d006         	beq	0x65c5c <air1_opcal4_algorithm+0x4574> @ imm = #0xc
   65c4e: eb05 0140    	add.w	r1, r5, r0, lsl #1
   65c52: f836 2030    	ldrh.w	r2, [r6, r0, lsl #3]
   65c56: 3001         	adds	r0, #0x1
   65c58: 810a         	strh	r2, [r1, #0x8]
   65c5a: e7f6         	b	0x65c4a <air1_opcal4_algorithm+0x4562> @ imm = #-0x14
   65c5c: 9854         	ldr	r0, [sp, #0x150]
   65c5e: f10c 0301    	add.w	r3, r12, #0x1
   65c62: f890 0310    	ldrb.w	r0, [r0, #0x310]
   65c66: 1a19         	subs	r1, r3, r0
   65c68: bf18         	it	ne
   65c6a: 2101         	movne	r1, #0x1
   65c6c: 9a5f         	ldr	r2, [sp, #0x17c]
   65c6e: f885 109a    	strb.w	r1, [r5, #0x9a]
   65c72: f892 17c8    	ldrb.w	r1, [r2, #0x7c8]
   65c76: 2901         	cmp	r1, #0x1
   65c78: bf1c         	itt	ne
   65c7a: f892 1800    	ldrbne.w	r1, [r2, #0x800]
   65c7e: 2901         	cmpne	r1, #0x1
   65c80: f040 8495    	bne.w	0x665ae <air1_opcal4_algorithm+0x4ec6> @ imm = #0x92a
   65c84: 4283         	cmp	r3, r0
   65c86: f04f 0004    	mov.w	r0, #0x4
   65c8a: bf18         	it	ne
   65c8c: 2005         	movne	r0, #0x5
   65c8e: f885 009a    	strb.w	r0, [r5, #0x9a]
   65c92: f105 004c    	add.w	r0, r5, #0x4c
   65c96: 9048         	str	r0, [sp, #0x120]
   65c98: f105 0144    	add.w	r1, r5, #0x44
   65c9c: 913e         	str	r1, [sp, #0xf8]
   65c9e: f940 074f    	vst1.16	{d16}, [r0]
   65ca2: f502 60f1    	add.w	r0, r2, #0x788
   65ca6: edd0 1b00    	vldr	d17, [r0]
   65caa: 4e49         	ldr	r6, [pc, #0x124]        @ 0x65dd0 <air1_opcal4_algorithm+0x46e8>
   65cac: f941 174f    	vst1.16	{d17}, [r1]
   65cb0: f892 17a8    	ldrb.w	r1, [r2, #0x7a8]
   65cb4: f892 27a9    	ldrb.w	r2, [r2, #0x7a9]
   65cb8: 2900         	cmp	r1, #0x0
   65cba: 4608         	mov	r0, r1
   65cbc: bf18         	it	ne
   65cbe: 2001         	movne	r0, #0x1
   65cc0: f8a5 0097    	strh.w	r0, [r5, #0x97]
   65cc4: b12a         	cbz	r2, 0x65cd2 <air1_opcal4_algorithm+0x45ea> @ imm = #0xa
   65cc6: 2002         	movs	r0, #0x2
   65cc8: 2900         	cmp	r1, #0x0
   65cca: bf18         	it	ne
   65ccc: 2003         	movne	r0, #0x3
   65cce: f8a5 0097    	strh.w	r0, [r5, #0x97]
   65cd2: 995f         	ldr	r1, [sp, #0x17c]
   65cd4: f891 17aa    	ldrb.w	r1, [r1, #0x7aa]
   65cd8: b111         	cbz	r1, 0x65ce0 <air1_opcal4_algorithm+0x45f8> @ imm = #0x4
   65cda: 3004         	adds	r0, #0x4
   65cdc: f8a5 0097    	strh.w	r0, [r5, #0x97]
   65ce0: 995f         	ldr	r1, [sp, #0x17c]
   65ce2: f891 17ab    	ldrb.w	r1, [r1, #0x7ab]
   65ce6: b111         	cbz	r1, 0x65cee <air1_opcal4_algorithm+0x4606> @ imm = #0x4
   65ce8: 3008         	adds	r0, #0x8
   65cea: f8a5 0097    	strh.w	r0, [r5, #0x97]
   65cee: 995f         	ldr	r1, [sp, #0x17c]
   65cf0: f891 17ac    	ldrb.w	r1, [r1, #0x7ac]
   65cf4: b111         	cbz	r1, 0x65cfc <air1_opcal4_algorithm+0x4614> @ imm = #0x4
   65cf6: 3010         	adds	r0, #0x10
   65cf8: f8a5 0097    	strh.w	r0, [r5, #0x97]
   65cfc: 9941         	ldr	r1, [sp, #0x104]
   65cfe: 7809         	ldrb	r1, [r1]
   65d00: 2901         	cmp	r1, #0x1
   65d02: bf04         	itt	eq
   65d04: 3020         	addeq	r0, #0x20
   65d06: f8a5 0097    	strheq.w	r0, [r5, #0x97]
   65d0a: 995f         	ldr	r1, [sp, #0x17c]
   65d0c: 9349         	str	r3, [sp, #0x124]
   65d0e: f501 69f6    	add.w	r9, r1, #0x7b0
   65d12: f891 00c8    	ldrb.w	r0, [r1, #0xc8]
   65d16: f885 0054    	strb.w	r0, [r5, #0x54]
   65d1a: 985c         	ldr	r0, [sp, #0x170]
   65d1c: edd9 1b00    	vldr	d17, [r9]
   65d20: f500 6015    	add.w	r0, r0, #0x950
   65d24: edd0 2b00    	vldr	d18, [r0]
   65d28: eef4 2b61    	vcmp.f64	d18, d17
   65d2c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65d30: d41b         	bmi	0x65d6a <air1_opcal4_algorithm+0x4682> @ imm = #0x36
   65d32: eef5 0b40    	vcmp.f64	d16, #0
   65d36: f891 07ad    	ldrb.w	r0, [r1, #0x7ad]
   65d3a: eddf 2b27    	vldr	d18, [pc, #156]         @ 0x65dd8 <air1_opcal4_algorithm+0x46f0>
   65d3e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65d42: eef4 0b62    	vcmp.f64	d16, d18
   65d46: eef1 1b60    	vneg.f64	d17, d16
   65d4a: bf48         	it	mi
   65d4c: eef0 0b61    	vmovmi.f64	d16, d17
   65d50: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65d54: d50b         	bpl	0x65d6e <air1_opcal4_algorithm+0x4686> @ imm = #0x16
   65d56: 995c         	ldr	r1, [sp, #0x170]
   65d58: f601 1148    	addw	r1, r1, #0x948
   65d5c: edd1 1b00    	vldr	d17, [r1]
   65d60: eef4 0b61    	vcmp.f64	d16, d17
   65d64: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   65d68: db01         	blt	0x65d6e <air1_opcal4_algorithm+0x4686> @ imm = #0x2
   65d6a: 2000         	movs	r0, #0x0
   65d6c: e002         	b	0x65d74 <air1_opcal4_algorithm+0x468c> @ imm = #0x4
   65d6e: fab0 f080    	clz	r0, r0
   65d72: 0940         	lsrs	r0, r0, #0x5
   65d74: f885 0099    	strb.w	r0, [r5, #0x99]
   65d78: f44f 60eb    	mov.w	r0, #0x758
   65d7c: f44f 61c3    	mov.w	r1, #0x618
   65d80: f5b0 6ff1    	cmp.w	r0, #0x788
   65d84: d00f         	beq	0x65da6 <air1_opcal4_algorithm+0x46be> @ imm = #0x1e
   65d86: 186a         	adds	r2, r5, r1
   65d88: 9d5f         	ldr	r5, [sp, #0x17c]
   65d8a: 5a6b         	ldrh	r3, [r5, r1]
   65d8c: 3102         	adds	r1, #0x2
   65d8e: 5393         	strh	r3, [r2, r6]
   65d90: 182a         	adds	r2, r5, r0
   65d92: 9d5d         	ldr	r5, [sp, #0x174]
   65d94: edd2 0b00    	vldr	d16, [r2]
   65d98: 182a         	adds	r2, r5, r0
   65d9a: 3008         	adds	r0, #0x8
   65d9c: f2a2 62f1    	subw	r2, r2, #0x6f1
   65da0: f942 070f    	vst1.8	{d16}, [r2]
   65da4: e7ec         	b	0x65d80 <air1_opcal4_algorithm+0x4698> @ imm = #-0x28
   65da6: 9e5f         	ldr	r6, [sp, #0x17c]
   65da8: 2000         	movs	r0, #0x0
   65daa: 2805         	cmp	r0, #0x5
   65dac: d018         	beq	0x65de0 <air1_opcal4_algorithm+0x46f8> @ imm = #0x30
   65dae: 1829         	adds	r1, r5, r0
   65db0: 3001         	adds	r0, #0x1
   65db2: f881 4056    	strb.w	r4, [r1, #0x56]
   65db6: e7f8         	b	0x65daa <air1_opcal4_algorithm+0x46c2> @ imm = #-0x10
   65db8: 00 00 59 40  	.word	0x40590000
   65dbc: 00 bf 00 bf  	.word	0xbf00bf00
   65dc0: 00 00 00 00  	.word	0x00000000
   65dc4: 00 00 59 40  	.word	0x40590000
   65dc8: 00 00 00 00  	.word	0x00000000
   65dcc: 00 00 4e 40  	.word	0x404e0000
   65dd0: 43 fa ff ff  	.word	0xfffffa43
   65dd4: 00 bf 00 bf  	.word	0xbf00bf00
   65dd8: 00 00 00 00  	.word	0x00000000
   65ddc: 00 c0 58 40  	.word	0x4058c000
   65de0: f8b5 005b    	ldrh.w	r0, [r5, #0x5b]
   65de4: b110         	cbz	r0, 0x65dec <air1_opcal4_algorithm+0x4704> @ imm = #0x4
   65de6: 2001         	movs	r0, #0x1
   65de8: f885 0055    	strb.w	r0, [r5, #0x55]
   65dec: 209b         	movs	r0, #0x9b
   65dee: 4629         	mov	r1, r5
   65df0: fb0c e000    	mla	r0, r12, r0, lr
   65df4: 229b         	movs	r2, #0x9b
   65df6: f006 fc02    	bl	0x6c5fe <copy_mem>      @ imm = #0x6804
   65dfa: 9a5e         	ldr	r2, [sp, #0x178]
   65dfc: 6828         	ldr	r0, [r5]
   65dfe: 6869         	ldr	r1, [r5, #0x4]
   65e00: 6010         	str	r0, [r2]
   65e02: f895 009a    	ldrb.w	r0, [r5, #0x9a]
   65e06: 7210         	strb	r0, [r2, #0x8]
   65e08: f895 0054    	ldrb.w	r0, [r5, #0x54]
   65e0c: 7250         	strb	r0, [r2, #0x9]
   65e0e: f102 000a    	add.w	r0, r2, #0xa
   65e12: edd6 0b12    	vldr	d16, [r6, #72]
   65e16: f8dd e0c8    	ldr.w	lr, [sp, #0xc8]
   65e1a: 9d4f         	ldr	r5, [sp, #0x13c]
   65e1c: 6051         	str	r1, [r2, #0x4]
   65e1e: 2100         	movs	r1, #0x0
   65e20: f940 074f    	vst1.16	{d16}, [r0]
   65e24: 2000         	movs	r0, #0x0
   65e26: 291e         	cmp	r1, #0x1e
   65e28: d012         	beq	0x65e50 <air1_opcal4_algorithm+0x4768> @ imm = #0x24
   65e2a: 9a5e         	ldr	r2, [sp, #0x178]
   65e2c: 9c5d         	ldr	r4, [sp, #0x174]
   65e2e: 324e         	adds	r2, #0x4e
   65e30: eb04 0441    	add.w	r4, r4, r1, lsl #1
   65e34: eb02 0341    	add.w	r3, r2, r1, lsl #1
   65e38: 4402         	add	r2, r0
   65e3a: 3101         	adds	r1, #0x1
   65e3c: 8924         	ldrh	r4, [r4, #0x8]
   65e3e: f823 4c3c    	strh	r4, [r3, #-60]
   65e42: 1833         	adds	r3, r6, r0
   65e44: 3008         	adds	r0, #0x8
   65e46: edd3 0b34    	vldr	d16, [r3, #208]
   65e4a: f942 074f    	vst1.16	{d16}, [r2]
   65e4e: e7ea         	b	0x65e26 <air1_opcal4_algorithm+0x473e> @ imm = #-0x2c
   65e50: f8dd c10c    	ldr.w	r12, [sp, #0x10c]
   65e54: 2000         	movs	r0, #0x0
   65e56: 9c5e         	ldr	r4, [sp, #0x178]
   65e58: 2828         	cmp	r0, #0x28
   65e5a: d00b         	beq	0x65e74 <air1_opcal4_algorithm+0x478c> @ imm = #0x16
   65e5c: 1832         	adds	r2, r6, r0
   65e5e: 1821         	adds	r1, r4, r0
   65e60: f502 62b0    	add.w	r2, r2, #0x580
   65e64: f501 719f    	add.w	r1, r1, #0x13e
   65e68: 3008         	adds	r0, #0x8
   65e6a: edd2 0b00    	vldr	d16, [r2]
   65e6e: f941 074f    	vst1.16	{d16}, [r1]
   65e72: e7f1         	b	0x65e58 <air1_opcal4_algorithm+0x4770> @ imm = #-0x1e
   65e74: f108 0010    	add.w	r0, r8, #0x10
   65e78: 9942         	ldr	r1, [sp, #0x108]
   65e7a: ecf0 0b08    	vldmia	r0!, {d16, d17, d18, d19}
   65e7e: f504 70bf    	add.w	r0, r4, #0x17e
   65e82: f940 374f    	vst1.16	{d19}, [r0]
   65e86: f504 70c3    	add.w	r0, r4, #0x186
   65e8a: edd8 3b0c    	vldr	d19, [r8, #48]
   65e8e: f940 374f    	vst1.16	{d19}, [r0]
   65e92: f504 70c7    	add.w	r0, r4, #0x18e
   65e96: f940 074f    	vst1.16	{d16}, [r0]
   65e9a: f504 70cb    	add.w	r0, r4, #0x196
   65e9e: f940 174f    	vst1.16	{d17}, [r0]
   65ea2: f504 70cf    	add.w	r0, r4, #0x19e
   65ea6: f940 274f    	vst1.16	{d18}, [r0]
   65eaa: f898 000e    	ldrb.w	r0, [r8, #0xe]
   65eae: f884 01a6    	strb.w	r0, [r4, #0x1a6]
   65eb2: f504 70b3    	add.w	r0, r4, #0x166
   65eb6: edd1 0b00    	vldr	d16, [r1]
   65eba: f506 61b6    	add.w	r1, r6, #0x5b0
   65ebe: f940 074f    	vst1.16	{d16}, [r0]
   65ec2: f504 70b7    	add.w	r0, r4, #0x16e
   65ec6: edd1 0b00    	vldr	d16, [r1]
   65eca: 993c         	ldr	r1, [sp, #0xf0]
   65ecc: f940 074f    	vst1.16	{d16}, [r0]
   65ed0: f504 70bb    	add.w	r0, r4, #0x176
   65ed4: edd1 0b00    	vldr	d16, [r1]
   65ed8: 9947         	ldr	r1, [sp, #0x11c]
   65eda: f940 074f    	vst1.16	{d16}, [r0]
   65ede: 983b         	ldr	r0, [sp, #0xec]
   65ee0: edd0 0b00    	vldr	d16, [r0]
   65ee4: f204 10a7    	addw	r0, r4, #0x1a7
   65ee8: f940 070f    	vst1.8	{d16}, [r0]
   65eec: f204 10af    	addw	r0, r4, #0x1af
   65ef0: edd1 0b00    	vldr	d16, [r1]
   65ef4: 993a         	ldr	r1, [sp, #0xe8]
   65ef6: f940 070f    	vst1.8	{d16}, [r0]
   65efa: f204 10b7    	addw	r0, r4, #0x1b7
   65efe: edd1 0b00    	vldr	d16, [r1]
   65f02: 9939         	ldr	r1, [sp, #0xe4]
   65f04: f940 070f    	vst1.8	{d16}, [r0]
   65f08: f204 10bf    	addw	r0, r4, #0x1bf
   65f0c: edd5 0b30    	vldr	d16, [r5, #192]
   65f10: f940 070f    	vst1.8	{d16}, [r0]
   65f14: f8b5 00cc    	ldrh.w	r0, [r5, #0xcc]
   65f18: edd1 0b00    	vldr	d16, [r1]
   65f1c: 9938         	ldr	r1, [sp, #0xe0]
   65f1e: f8a4 01c7    	strh.w	r0, [r4, #0x1c7]
   65f22: f204 10c9    	addw	r0, r4, #0x1c9
   65f26: f940 070f    	vst1.8	{d16}, [r0]
   65f2a: f204 10d1    	addw	r0, r4, #0x1d1
   65f2e: edd1 0b00    	vldr	d16, [r1]
   65f32: 9937         	ldr	r1, [sp, #0xdc]
   65f34: f940 070f    	vst1.8	{d16}, [r0]
   65f38: f204 10d9    	addw	r0, r4, #0x1d9
   65f3c: edd1 0b00    	vldr	d16, [r1]
   65f40: 9936         	ldr	r1, [sp, #0xd8]
   65f42: f940 070f    	vst1.8	{d16}, [r0]
   65f46: f204 10e1    	addw	r0, r4, #0x1e1
   65f4a: edd1 0b00    	vldr	d16, [r1]
   65f4e: 9952         	ldr	r1, [sp, #0x148]
   65f50: f940 070f    	vst1.8	{d16}, [r0]
   65f54: f204 10e9    	addw	r0, r4, #0x1e9
   65f58: edd1 0b00    	vldr	d16, [r1]
   65f5c: f44f 61c5    	mov.w	r1, #0x628
   65f60: f940 070f    	vst1.8	{d16}, [r0]
   65f64: f898 0110    	ldrb.w	r0, [r8, #0x110]
   65f68: f884 01f1    	strb.w	r0, [r4, #0x1f1]
   65f6c: 2000         	movs	r0, #0x0
   65f6e: 2806         	cmp	r0, #0x6
   65f70: d019         	beq	0x65fa6 <air1_opcal4_algorithm+0x48be> @ imm = #0x32
   65f72: 9b5d         	ldr	r3, [sp, #0x174]
   65f74: eb04 0240    	add.w	r2, r4, r0, lsl #1
   65f78: eb03 0340    	add.w	r3, r3, r0, lsl #1
   65f7c: f8b3 305b    	ldrh.w	r3, [r3, #0x5b]
   65f80: f8a2 31f2    	strh.w	r3, [r2, #0x1f2]
   65f84: 1872         	adds	r2, r6, r1
   65f86: edd2 0b00    	vldr	d16, [r2]
   65f8a: f204 222e    	addw	r2, r4, #0x22e
   65f8e: 1853         	adds	r3, r2, r1
   65f90: 3108         	adds	r1, #0x8
   65f92: f5a3 63cb    	sub.w	r3, r3, #0x658
   65f96: f943 074f    	vst1.16	{d16}, [r3]
   65f9a: 1833         	adds	r3, r6, r0
   65f9c: f893 3658    	ldrb.w	r3, [r3, #0x658]
   65fa0: 5413         	strb	r3, [r2, r0]
   65fa2: 3001         	adds	r0, #0x1
   65fa4: e7e3         	b	0x65f6e <air1_opcal4_algorithm+0x4886> @ imm = #-0x3a
   65fa6: 7e29         	ldrb	r1, [r5, #0x18]
   65fa8: 7e68         	ldrb	r0, [r5, #0x19]
   65faa: f884 1234    	strb.w	r1, [r4, #0x234]
   65fae: f8d6 1668    	ldr.w	r1, [r6, #0x668]
   65fb2: f884 0235    	strb.w	r0, [r4, #0x235]
   65fb6: f8c4 1236    	str.w	r1, [r4, #0x236]
   65fba: f898 1360    	ldrb.w	r1, [r8, #0x360]
   65fbe: f884 1242    	strb.w	r1, [r4, #0x242]
   65fc2: f8d8 1364    	ldr.w	r1, [r8, #0x364]
   65fc6: f8c4 1243    	str.w	r1, [r4, #0x243]
   65fca: f204 2147    	addw	r1, r4, #0x247
   65fce: edd8 0bda    	vldr	d16, [r8, #872]
   65fd2: edd8 1be0    	vldr	d17, [r8, #896]
   65fd6: edd8 2be8    	vldr	d18, [r8, #928]
   65fda: f941 070f    	vst1.8	{d16}, [r1]
   65fde: f204 214f    	addw	r1, r4, #0x24f
   65fe2: 9a4a         	ldr	r2, [sp, #0x128]
   65fe4: f941 170f    	vst1.8	{d17}, [r1]
   65fe8: f898 1398    	ldrb.w	r1, [r8, #0x398]
   65fec: f884 1257    	strb.w	r1, [r4, #0x257]
   65ff0: f204 213a    	addw	r1, r4, #0x23a
   65ff4: edd2 0b00    	vldr	d16, [r2]
   65ff8: f941 074f    	vst1.16	{d16}, [r1]
   65ffc: f504 7116    	add.w	r1, r4, #0x258
   66000: f941 274f    	vst1.16	{d18}, [r1]
   66004: f504 7118    	add.w	r1, r4, #0x260
   66008: edd8 0bdc    	vldr	d16, [r8, #880]
   6600c: edd8 1be2    	vldr	d17, [r8, #904]
   66010: edd8 2be4    	vldr	d18, [r8, #912]
   66014: edd8 3bea    	vldr	d19, [r8, #936]
   66018: f941 074f    	vst1.16	{d16}, [r1]
   6601c: f8b8 1378    	ldrh.w	r1, [r8, #0x378]
   66020: f8a4 1268    	strh.w	r1, [r4, #0x268]
   66024: f204 216a    	addw	r1, r4, #0x26a
   66028: f941 374f    	vst1.16	{d19}, [r1]
   6602c: f204 2172    	addw	r1, r4, #0x272
   66030: f941 174f    	vst1.16	{d17}, [r1]
   66034: f204 217a    	addw	r1, r4, #0x27a
   66038: f941 274f    	vst1.16	{d18}, [r1]
   6603c: f204 2182    	addw	r1, r4, #0x282
   66040: edd8 0bec    	vldr	d16, [r8, #944]
   66044: f941 074f    	vst1.16	{d16}, [r1]
   66048: f204 218a    	addw	r1, r4, #0x28a
   6604c: edd8 0bee    	vldr	d16, [r8, #952]
   66050: f941 074f    	vst1.16	{d16}, [r1]
   66054: f898 13c0    	ldrb.w	r1, [r8, #0x3c0]
   66058: f884 1292    	strb.w	r1, [r4, #0x292]
   6605c: 2100         	movs	r1, #0x0
   6605e: 2938         	cmp	r1, #0x38
   66060: d01c         	beq	0x6609c <air1_opcal4_algorithm+0x49b4> @ imm = #0x38
   66062: 9b5e         	ldr	r3, [sp, #0x178]
   66064: eb0b 0201    	add.w	r2, r11, r1
   66068: 440b         	add	r3, r1
   6606a: edd2 0b1c    	vldr	d16, [r2, #112]
   6606e: f203 2393    	addw	r3, r3, #0x293
   66072: 3108         	adds	r1, #0x8
   66074: f103 0438    	add.w	r4, r3, #0x38
   66078: f943 070f    	vst1.8	{d16}, [r3]
   6607c: edd2 0b2a    	vldr	d16, [r2, #168]
   66080: f944 070f    	vst1.8	{d16}, [r4]
   66084: f103 0470    	add.w	r4, r3, #0x70
   66088: 33a8         	adds	r3, #0xa8
   6608a: edd2 0b00    	vldr	d16, [r2]
   6608e: f944 070f    	vst1.8	{d16}, [r4]
   66092: edd2 0b0e    	vldr	d16, [r2, #56]
   66096: f943 070f    	vst1.8	{d16}, [r3]
   6609a: e7e0         	b	0x6605e <air1_opcal4_algorithm+0x4976> @ imm = #-0x40
   6609c: 9c5e         	ldr	r4, [sp, #0x178]
   6609e: 9e5f         	ldr	r6, [sp, #0x17c]
   660a0: f884 038b    	strb.w	r0, [r4, #0x38b]
   660a4: f105 0020    	add.w	r0, r5, #0x20
   660a8: ecf0 0b06    	vldmia	r0!, {d16, d17, d18}
   660ac: f204 3073    	addw	r0, r4, #0x373
   660b0: f940 070f    	vst1.8	{d16}, [r0]
   660b4: f204 307b    	addw	r0, r4, #0x37b
   660b8: f940 170f    	vst1.8	{d17}, [r0]
   660bc: f204 3083    	addw	r0, r4, #0x383
   660c0: f940 270f    	vst1.8	{d18}, [r0]
   660c4: f8b5 00d0    	ldrh.w	r0, [r5, #0xd0]
   660c8: f8a4 038c    	strh.w	r0, [r4, #0x38c]
   660cc: 2000         	movs	r0, #0x0
   660ce: 2830         	cmp	r0, #0x30
   660d0: d00b         	beq	0x660ea <air1_opcal4_algorithm+0x4a02> @ imm = #0x16
   660d2: 1832         	adds	r2, r6, r0
   660d4: 1821         	adds	r1, r4, r0
   660d6: f502 62e3    	add.w	r2, r2, #0x718
   660da: f201 318e    	addw	r1, r1, #0x38e
   660de: 3008         	adds	r0, #0x8
   660e0: edd2 0b00    	vldr	d16, [r2]
   660e4: f941 074f    	vst1.16	{d16}, [r1]
   660e8: e7f1         	b	0x660ce <air1_opcal4_algorithm+0x49e6> @ imm = #-0x1e
   660ea: f8d6 07a9    	ldr.w	r0, [r6, #0x7a9]
   660ee: f8c4 03cf    	str.w	r0, [r4, #0x3cf]
   660f2: f896 07a8    	ldrb.w	r0, [r6, #0x7a8]
   660f6: f884 03ce    	strb.w	r0, [r4, #0x3ce]
   660fa: 9841         	ldr	r0, [sp, #0x104]
   660fc: 9957         	ldr	r1, [sp, #0x15c]
   660fe: 9a30         	ldr	r2, [sp, #0xc0]
   66100: 7800         	ldrb	r0, [r0]
   66102: f884 03d3    	strb.w	r0, [r4, #0x3d3]
   66106: 985d         	ldr	r0, [sp, #0x174]
   66108: edd1 0b00    	vldr	d16, [r1]
   6610c: 993e         	ldr	r1, [sp, #0xf8]
   6610e: f890 0099    	ldrb.w	r0, [r0, #0x99]
   66112: f884 03dc    	strb.w	r0, [r4, #0x3dc]
   66116: f204 30be    	addw	r0, r4, #0x3be
   6611a: f896 37f3    	ldrb.w	r3, [r6, #0x7f3]
   6611e: f940 074f    	vst1.16	{d16}, [r0]
   66122: f204 30c6    	addw	r0, r4, #0x3c6
   66126: f961 074f    	vld1.16	{d16}, [r1]
   6612a: 9948         	ldr	r1, [sp, #0x120]
   6612c: f940 074f    	vst1.16	{d16}, [r0]
   66130: f504 7075    	add.w	r0, r4, #0x3d4
   66134: f961 074f    	vld1.16	{d16}, [r1]
   66138: f102 0110    	add.w	r1, r2, #0x10
   6613c: f940 074f    	vst1.16	{d16}, [r0]
   66140: f204 30dd    	addw	r0, r4, #0x3dd
   66144: edd9 0b00    	vldr	d16, [r9]
   66148: f50d 693a    	add.w	r9, sp, #0xba0
   6614c: f940 070f    	vst1.8	{d16}, [r0]
   66150: f204 30e5    	addw	r0, r4, #0x3e5
   66154: ecd2 0b04    	vldmia	r2, {d16, d17}
   66158: f940 070f    	vst1.8	{d16}, [r0]
   6615c: f8b2 0033    	ldrh.w	r0, [r2, #0x33]
   66160: f8a4 041f    	strh.w	r0, [r4, #0x41f]
   66164: f204 30ed    	addw	r0, r4, #0x3ed
   66168: f940 170f    	vst1.8	{d17}, [r0]
   6616c: f204 30f5    	addw	r0, r4, #0x3f5
   66170: ecf1 0b08    	vldmia	r1!, {d16, d17, d18, d19}
   66174: f506 61f8    	add.w	r1, r6, #0x7c0
   66178: f940 070f    	vst1.8	{d16}, [r0]
   6617c: f896 07b8    	ldrb.w	r0, [r6, #0x7b8]
   66180: f884 03fd    	strb.w	r0, [r4, #0x3fd]
   66184: f204 30fe    	addw	r0, r4, #0x3fe
   66188: edd1 0b00    	vldr	d16, [r1]
   6618c: f896 17f1    	ldrb.w	r1, [r6, #0x7f1]
   66190: f940 074f    	vst1.16	{d16}, [r0]
   66194: f204 4006    	addw	r0, r4, #0x406
   66198: f940 174f    	vst1.16	{d17}, [r0]
   6619c: f204 400e    	addw	r0, r4, #0x40e
   661a0: f940 274f    	vst1.16	{d18}, [r0]
   661a4: f204 4016    	addw	r0, r4, #0x416
   661a8: f940 374f    	vst1.16	{d19}, [r0]
   661ac: f892 0032    	ldrb.w	r0, [r2, #0x32]
   661b0: f884 041e    	strb.w	r0, [r4, #0x41e]
   661b4: 8e10         	ldrh	r0, [r2, #0x30]
   661b6: f8a4 0421    	strh.w	r0, [r4, #0x421]
   661ba: f8b6 07c8    	ldrh.w	r0, [r6, #0x7c8]
   661be: f8a4 0423    	strh.w	r0, [r4, #0x423]
   661c2: f896 07f0    	ldrb.w	r0, [r6, #0x7f0]
   661c6: f884 3425    	strb.w	r3, [r4, #0x425]
   661ca: f8b6 37f4    	ldrh.w	r3, [r6, #0x7f4]
   661ce: f8a4 3426    	strh.w	r3, [r4, #0x426]
   661d2: f8d6 37f6    	ldr.w	r3, [r6, #0x7f6]
   661d6: f884 0430    	strb.w	r0, [r4, #0x430]
   661da: f896 07ca    	ldrb.w	r0, [r6, #0x7ca]
   661de: f8c4 3428    	str.w	r3, [r4, #0x428]
   661e2: f8b6 37fa    	ldrh.w	r3, [r6, #0x7fa]
   661e6: f8a4 0432    	strh.w	r0, [r4, #0x432]
   661ea: f896 07cb    	ldrb.w	r0, [r6, #0x7cb]
   661ee: f896 27f2    	ldrb.w	r2, [r6, #0x7f2]
   661f2: f8a4 342c    	strh.w	r3, [r4, #0x42c]
   661f6: f896 37fc    	ldrb.w	r3, [r6, #0x7fc]
   661fa: f884 1431    	strb.w	r1, [r4, #0x431]
   661fe: f06f 010b    	mvn	r1, #0xb
   66202: f884 0434    	strb.w	r0, [r4, #0x434]
   66206: 2000         	movs	r0, #0x0
   66208: f884 342e    	strb.w	r3, [r4, #0x42e]
   6620c: f884 242f    	strb.w	r2, [r4, #0x42f]
   66210: b179         	cbz	r1, 0x66232 <air1_opcal4_algorithm+0x4b4a> @ imm = #0x1e
   66212: 9c5e         	ldr	r4, [sp, #0x178]
   66214: f506 62fb    	add.w	r2, r6, #0x7d8
   66218: 5853         	ldr	r3, [r2, r1]
   6621a: f204 4441    	addw	r4, r4, #0x441
   6621e: 4402         	add	r2, r0
   66220: 5063         	str	r3, [r4, r1]
   66222: 1823         	adds	r3, r4, r0
   66224: edd2 0b00    	vldr	d16, [r2]
   66228: 3104         	adds	r1, #0x4
   6622a: 3008         	adds	r0, #0x8
   6622c: f943 070f    	vst1.8	{d16}, [r3]
   66230: e7ee         	b	0x66210 <air1_opcal4_algorithm+0x4b28> @ imm = #-0x24
   66232: 9c5e         	ldr	r4, [sp, #0x178]
   66234: f606 0118    	addw	r1, r6, #0x818
   66238: f606 0258    	addw	r2, r6, #0x858
   6623c: edd1 0b00    	vldr	d16, [r1]
   66240: f204 4059    	addw	r0, r4, #0x459
   66244: f606 0108    	addw	r1, r6, #0x808
   66248: f940 070f    	vst1.8	{d16}, [r0]
   6624c: f204 4061    	addw	r0, r4, #0x461
   66250: edd1 0b00    	vldr	d16, [r1]
   66254: f506 6101    	add.w	r1, r6, #0x810
   66258: f940 070f    	vst1.8	{d16}, [r0]
   6625c: f204 4069    	addw	r0, r4, #0x469
   66260: edd1 0b00    	vldr	d16, [r1]
   66264: f506 6102    	add.w	r1, r6, #0x820
   66268: f940 070f    	vst1.8	{d16}, [r0]
   6626c: f204 4071    	addw	r0, r4, #0x471
   66270: edd1 0b00    	vldr	d16, [r1]
   66274: f606 0128    	addw	r1, r6, #0x828
   66278: f940 070f    	vst1.8	{d16}, [r0]
   6627c: f204 4079    	addw	r0, r4, #0x479
   66280: edd1 0b00    	vldr	d16, [r1]
   66284: f506 6103    	add.w	r1, r6, #0x830
   66288: f940 070f    	vst1.8	{d16}, [r0]
   6628c: f204 4081    	addw	r0, r4, #0x481
   66290: edd1 0b00    	vldr	d16, [r1]
   66294: f606 0138    	addw	r1, r6, #0x838
   66298: f940 070f    	vst1.8	{d16}, [r0]
   6629c: f204 4089    	addw	r0, r4, #0x489
   662a0: edd1 0b00    	vldr	d16, [r1]
   662a4: f506 6104    	add.w	r1, r6, #0x840
   662a8: f940 070f    	vst1.8	{d16}, [r0]
   662ac: f204 4091    	addw	r0, r4, #0x491
   662b0: edd1 0b00    	vldr	d16, [r1]
   662b4: f606 0148    	addw	r1, r6, #0x848
   662b8: f940 070f    	vst1.8	{d16}, [r0]
   662bc: f204 4099    	addw	r0, r4, #0x499
   662c0: edd1 0b00    	vldr	d16, [r1]
   662c4: f8d6 1850    	ldr.w	r1, [r6, #0x850]
   662c8: f940 070f    	vst1.8	{d16}, [r0]
   662cc: f896 0860    	ldrb.w	r0, [r6, #0x860]
   662d0: f884 04a1    	strb.w	r0, [r4, #0x4a1]
   662d4: f8b6 0861    	ldrh.w	r0, [r6, #0x861]
   662d8: f8a4 04a2    	strh.w	r0, [r4, #0x4a2]
   662dc: f8d6 07fd    	ldr.w	r0, [r6, #0x7fd]
   662e0: f8c4 04a4    	str.w	r0, [r4, #0x4a4]
   662e4: f204 40b4    	addw	r0, r4, #0x4b4
   662e8: edd2 0b00    	vldr	d16, [r2]
   662ec: f506 6207    	add.w	r2, r6, #0x870
   662f0: f940 074f    	vst1.16	{d16}, [r0]
   662f4: f204 40be    	addw	r0, r4, #0x4be
   662f8: edd2 0b00    	vldr	d16, [r2]
   662fc: f506 6208    	add.w	r2, r6, #0x880
   66300: f940 074f    	vst1.16	{d16}, [r0]
   66304: f204 40c6    	addw	r0, r4, #0x4c6
   66308: edd2 0b00    	vldr	d16, [r2]
   6630c: 9a2e         	ldr	r2, [sp, #0xb8]
   6630e: f940 074f    	vst1.16	{d16}, [r0]
   66312: f504 6095    	add.w	r0, r4, #0x4a8
   66316: edd2 0b00    	vldr	d16, [r2]
   6631a: f8c4 14b0    	str.w	r1, [r4, #0x4b0]
   6631e: f940 074f    	vst1.16	{d16}, [r0]
   66322: f8b6 0863    	ldrh.w	r0, [r6, #0x863]
   66326: f8a4 04bc    	strh.w	r0, [r4, #0x4bc]
   6632a: f606 0078    	addw	r0, r6, #0x878
   6632e: edd0 0b00    	vldr	d16, [r0]
   66332: f204 40ce    	addw	r0, r4, #0x4ce
   66336: f940 074f    	vst1.16	{d16}, [r0]
   6633a: f06f 0004    	mvn	r0, #0x4
   6633e: b158         	cbz	r0, 0x66358 <air1_opcal4_algorithm+0x4c70> @ imm = #0x16
   66340: 1832         	adds	r2, r6, r0
   66342: 1821         	adds	r1, r4, r0
   66344: 3001         	adds	r0, #0x1
   66346: f892 386a    	ldrb.w	r3, [r2, #0x86a]
   6634a: f892 288d    	ldrb.w	r2, [r2, #0x88d]
   6634e: f881 24db    	strb.w	r2, [r1, #0x4db]
   66352: f881 34e0    	strb.w	r3, [r1, #0x4e0]
   66356: e7f2         	b	0x6633e <air1_opcal4_algorithm+0x4c56> @ imm = #-0x1c
   66358: f606 0198    	addw	r1, r6, #0x898
   6635c: f8b6 088d    	ldrh.w	r0, [r6, #0x88d]
   66360: f8a4 04e1    	strh.w	r0, [r4, #0x4e1]
   66364: f204 601b    	addw	r0, r4, #0x61b
   66368: edd1 0b00    	vldr	d16, [r1]
   6636c: f506 610a    	add.w	r1, r6, #0x8a0
   66370: 9a2b         	ldr	r2, [sp, #0xac]
   66372: f50d 6b0d    	add.w	r11, sp, #0x8d0
   66376: f940 070f    	vst1.8	{d16}, [r0]
   6637a: f204 6023    	addw	r0, r4, #0x623
   6637e: edd1 0b00    	vldr	d16, [r1]
   66382: 992d         	ldr	r1, [sp, #0xb4]
   66384: f940 070f    	vst1.8	{d16}, [r0]
   66388: f204 40e3    	addw	r0, r4, #0x4e3
   6638c: edd1 0b00    	vldr	d16, [r1]
   66390: f940 070f    	vst1.8	{d16}, [r0]
   66394: f204 40eb    	addw	r0, r4, #0x4eb
   66398: edd1 1b70    	vldr	d17, [r1, #448]
   6639c: edd1 0b6e    	vldr	d16, [r1, #440]
   663a0: edd1 2bae    	vldr	d18, [r1, #696]
   663a4: f940 170f    	vst1.8	{d17}, [r0]
   663a8: f204 40f3    	addw	r0, r4, #0x4f3
   663ac: f940 070f    	vst1.8	{d16}, [r0]
   663b0: f204 40fb    	addw	r0, r4, #0x4fb
   663b4: 992c         	ldr	r1, [sp, #0xb0]
   663b6: f940 270f    	vst1.8	{d18}, [r0]
   663ba: f204 5003    	addw	r0, r4, #0x503
   663be: edd1 0b48    	vldr	d16, [r1, #288]
   663c2: f940 070f    	vst1.8	{d16}, [r0]
   663c6: f204 500b    	addw	r0, r4, #0x50b
   663ca: edd1 0b00    	vldr	d16, [r1]
   663ce: f896 1896    	ldrb.w	r1, [r6, #0x896]
   663d2: f940 070f    	vst1.8	{d16}, [r0]
   663d6: f204 5013    	addw	r0, r4, #0x513
   663da: edd2 0b00    	vldr	d16, [r2]
   663de: f940 070f    	vst1.8	{d16}, [r0]
   663e2: f204 501b    	addw	r0, r4, #0x51b
   663e6: edd2 0b48    	vldr	d16, [r2, #288]
   663ea: f884 161a    	strb.w	r1, [r4, #0x61a]
   663ee: 992a         	ldr	r1, [sp, #0xa8]
   663f0: f940 070f    	vst1.8	{d16}, [r0]
   663f4: f896 086a    	ldrb.w	r0, [r6, #0x86a]
   663f8: f884 04e0    	strb.w	r0, [r4, #0x4e0]
   663fc: f204 5023    	addw	r0, r4, #0x523
   66400: edd1 0b00    	vldr	d16, [r1]
   66404: f940 070f    	vst1.8	{d16}, [r0]
   66408: f204 502b    	addw	r0, r4, #0x52b
   6640c: edd2 0b4a    	vldr	d16, [r2, #296]
   66410: 9a27         	ldr	r2, [sp, #0x9c]
   66412: f940 070f    	vst1.8	{d16}, [r0]
   66416: f204 5033    	addw	r0, r4, #0x533
   6641a: edd1 0b4a    	vldr	d16, [r1, #296]
   6641e: f940 070f    	vst1.8	{d16}, [r0]
   66422: f204 503b    	addw	r0, r4, #0x53b
   66426: edd1 0b92    	vldr	d16, [r1, #584]
   6642a: f940 070f    	vst1.8	{d16}, [r0]
   6642e: f204 5043    	addw	r0, r4, #0x543
   66432: edd1 0b96    	vldr	d16, [r1, #600]
   66436: 9929         	ldr	r1, [sp, #0xa4]
   66438: f940 070f    	vst1.8	{d16}, [r0]
   6643c: f204 504b    	addw	r0, r4, #0x54b
   66440: edd1 0b00    	vldr	d16, [r1]
   66444: f940 070f    	vst1.8	{d16}, [r0]
   66448: f204 5053    	addw	r0, r4, #0x553
   6644c: edd1 0b48    	vldr	d16, [r1, #288]
   66450: f940 070f    	vst1.8	{d16}, [r0]
   66454: f204 505b    	addw	r0, r4, #0x55b
   66458: edd1 0b90    	vldr	d16, [r1, #576]
   6645c: f940 070f    	vst1.8	{d16}, [r0]
   66460: f204 5063    	addw	r0, r4, #0x563
   66464: edd1 0bd8    	vldr	d16, [r1, #864]
   66468: 9928         	ldr	r1, [sp, #0xa0]
   6646a: f940 070f    	vst1.8	{d16}, [r0]
   6646e: f204 506b    	addw	r0, r4, #0x56b
   66472: edd1 0b00    	vldr	d16, [r1]
   66476: f940 070f    	vst1.8	{d16}, [r0]
   6647a: f204 5073    	addw	r0, r4, #0x573
   6647e: edd2 0b00    	vldr	d16, [r2]
   66482: f940 070f    	vst1.8	{d16}, [r0]
   66486: f204 507b    	addw	r0, r4, #0x57b
   6648a: edd1 0b4a    	vldr	d16, [r1, #296]
   6648e: f940 070f    	vst1.8	{d16}, [r0]
   66492: f204 5083    	addw	r0, r4, #0x583
   66496: edd1 0b48    	vldr	d16, [r1, #288]
   6649a: 9926         	ldr	r1, [sp, #0x98]
   6649c: f940 070f    	vst1.8	{d16}, [r0]
   664a0: f204 508b    	addw	r0, r4, #0x58b
   664a4: edd2 0b08    	vldr	d16, [r2, #32]
   664a8: f940 070f    	vst1.8	{d16}, [r0]
   664ac: f204 5093    	addw	r0, r4, #0x593
   664b0: edd2 0b52    	vldr	d16, [r2, #328]
   664b4: f940 070f    	vst1.8	{d16}, [r0]
   664b8: f204 509b    	addw	r0, r4, #0x59b
   664bc: edd2 0b9a    	vldr	d16, [r2, #616]
   664c0: f940 070f    	vst1.8	{d16}, [r0]
   664c4: f204 50a3    	addw	r0, r4, #0x5a3
   664c8: edd1 0b00    	vldr	d16, [r1]
   664cc: f940 070f    	vst1.8	{d16}, [r0]
   664d0: f204 50ab    	addw	r0, r4, #0x5ab
   664d4: edd2 0be4    	vldr	d16, [r2, #912]
   664d8: f940 070f    	vst1.8	{d16}, [r0]
   664dc: f204 50b3    	addw	r0, r4, #0x5b3
   664e0: edd2 0be2    	vldr	d16, [r2, #904]
   664e4: 9a24         	ldr	r2, [sp, #0x90]
   664e6: f940 070f    	vst1.8	{d16}, [r0]
   664ea: f204 50bb    	addw	r0, r4, #0x5bb
   664ee: edd1 0b0a    	vldr	d16, [r1, #40]
   664f2: 9925         	ldr	r1, [sp, #0x94]
   664f4: f940 070f    	vst1.8	{d16}, [r0]
   664f8: f204 50c3    	addw	r0, r4, #0x5c3
   664fc: edd1 0b00    	vldr	d16, [r1]
   66500: f940 070f    	vst1.8	{d16}, [r0]
   66504: f204 50cb    	addw	r0, r4, #0x5cb
   66508: edd1 0b48    	vldr	d16, [r1, #288]
   6650c: f940 070f    	vst1.8	{d16}, [r0]
   66510: f204 50d3    	addw	r0, r4, #0x5d3
   66514: edd1 0b90    	vldr	d16, [r1, #576]
   66518: f940 070f    	vst1.8	{d16}, [r0]
   6651c: f204 50db    	addw	r0, r4, #0x5db
   66520: edd2 0b00    	vldr	d16, [r2]
   66524: f940 070f    	vst1.8	{d16}, [r0]
   66528: f204 50e3    	addw	r0, r4, #0x5e3
   6652c: edd1 0bda    	vldr	d16, [r1, #872]
   66530: f940 070f    	vst1.8	{d16}, [r0]
   66534: f204 50eb    	addw	r0, r4, #0x5eb
   66538: edd1 0bd8    	vldr	d16, [r1, #864]
   6653c: f940 070f    	vst1.8	{d16}, [r0]
   66540: f204 50f3    	addw	r0, r4, #0x5f3
   66544: edd2 0b4e    	vldr	d16, [r2, #312]
   66548: f940 070f    	vst1.8	{d16}, [r0]
   6654c: f204 50fb    	addw	r0, r4, #0x5fb
   66550: edde 0b00    	vldr	d16, [lr]
   66554: f940 070f    	vst1.8	{d16}, [r0]
   66558: f204 6003    	addw	r0, r4, #0x603
   6655c: edd2 0b04    	vldr	d16, [r2, #16]
   66560: f940 070f    	vst1.8	{d16}, [r0]
   66564: f204 600b    	addw	r0, r4, #0x60b
   66568: edde 0b48    	vldr	d16, [lr, #288]
   6656c: f940 070f    	vst1.8	{d16}, [r0]
   66570: 2000         	movs	r0, #0x0
   66572: 2807         	cmp	r0, #0x7
   66574: d007         	beq	0x66586 <air1_opcal4_algorithm+0x4e9e> @ imm = #0xe
   66576: 1832         	adds	r2, r6, r0
   66578: 1821         	adds	r1, r4, r0
   6657a: 3001         	adds	r0, #0x1
   6657c: f892 288f    	ldrb.w	r2, [r2, #0x88f]
   66580: f881 2613    	strb.w	r2, [r1, #0x613]
   66584: e7f5         	b	0x66572 <air1_opcal4_algorithm+0x4e8a> @ imm = #-0x16
   66586: 68f8         	ldr	r0, [r7, #0xc]
   66588: f240 612b    	movw	r1, #0x62b
   6658c: fb0c 0001    	mla	r0, r12, r1, r0
   66590: 4937         	ldr	r1, [pc, #0xdc]         @ 0x66670 <air1_opcal4_algorithm+0x4f88>
   66592: f240 622b    	movw	r2, #0x62b
   66596: 4479         	add	r1, pc
   66598: f006 f831    	bl	0x6c5fe <copy_mem>      @ imm = #0x6062
   6659c: f8dd c12c    	ldr.w	r12, [sp, #0x12c]
   665a0: 9b44         	ldr	r3, [sp, #0x110]
   665a2: f10c 0c02    	add.w	r12, r12, #0x2
   665a6: 9a49         	ldr	r2, [sp, #0x124]
   665a8: 3304         	adds	r3, #0x4
   665aa: f7fd b840    	b.w	0x6362e <air1_opcal4_algorithm+0x1f46> @ imm = #-0x2f80
   665ae: f892 186a    	ldrb.w	r1, [r2, #0x86a]
   665b2: 2901         	cmp	r1, #0x1
   665b4: f43f ab66    	beq.w	0x65c84 <air1_opcal4_algorithm+0x459c> @ imm = #-0x934
   665b8: f7ff bb6b    	b.w	0x65c92 <air1_opcal4_algorithm+0x45aa> @ imm = #-0x92a
   665bc: eef3 3b0e    	vmov.f64	d19, #3.000000e+01
   665c0: eef4 1b63    	vcmp.f64	d17, d19
   665c4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   665c8: dd05         	ble	0x665d6 <air1_opcal4_algorithm+0x4eee> @ imm = #0xa
   665ca: 2104         	movs	r1, #0x4
   665cc: f7fd bf14    	b.w	0x643f8 <air1_opcal4_algorithm+0x2d10> @ imm = #-0x21d8
   665d0: 2101         	movs	r1, #0x1
   665d2: f7fe bfb0    	b.w	0x65536 <air1_opcal4_algorithm+0x3e4e> @ imm = #-0x10a0
   665d6: eef1 3b04    	vmov.f64	d19, #5.000000e+00
   665da: eef4 1b63    	vcmp.f64	d17, d19
   665de: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   665e2: d506         	bpl	0x665f2 <air1_opcal4_algorithm+0x4f0a> @ imm = #0xc
   665e4: eef3 3b04    	vmov.f64	d19, #2.000000e+01
   665e8: eef4 2b63    	vcmp.f64	d18, d19
   665ec: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   665f0: d910         	bls	0x66614 <air1_opcal4_algorithm+0x4f2c> @ imm = #0x20
   665f2: eef2 3b0e    	vmov.f64	d19, #1.500000e+01
   665f6: eef4 1b63    	vcmp.f64	d17, d19
   665fa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   665fe: d506         	bpl	0x6660e <air1_opcal4_algorithm+0x4f26> @ imm = #0xc
   66600: eef3 1b0e    	vmov.f64	d17, #3.000000e+01
   66604: eef4 2b61    	vcmp.f64	d18, d17
   66608: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6660c: d905         	bls	0x6661a <air1_opcal4_algorithm+0x4f32> @ imm = #0xa
   6660e: 2103         	movs	r1, #0x3
   66610: f7fd bef2    	b.w	0x643f8 <air1_opcal4_algorithm+0x2d10> @ imm = #-0x221c
   66614: 2101         	movs	r1, #0x1
   66616: f7fd beef    	b.w	0x643f8 <air1_opcal4_algorithm+0x2d10> @ imm = #-0x2222
   6661a: 2102         	movs	r1, #0x2
   6661c: f7fd beec    	b.w	0x643f8 <air1_opcal4_algorithm+0x2d10> @ imm = #-0x2228
   66620: 9c5e         	ldr	r4, [sp, #0x178]
   66622: 2202         	movs	r2, #0x2
   66624: f8aa 31c6    	strh.w	r3, [r10, #0x1c6]
   66628: f104 000a    	add.w	r0, r4, #0xa
   6662c: 8021         	strh	r1, [r4]
   6662e: f106 0142    	add.w	r1, r6, #0x42
   66632: 7222         	strb	r2, [r4, #0x8]
   66634: f961 070f    	vld1.8	{d16}, [r1]
   66638: f940 074f    	vst1.16	{d16}, [r0]
   6663c: 2000         	movs	r0, #0x0
   6663e: f8c4 e004    	str.w	lr, [r4, #0x4]
   66642: 8063         	strh	r3, [r4, #0x2]
   66644: 281e         	cmp	r0, #0x1e
   66646: d008         	beq	0x6665a <air1_opcal4_algorithm+0x4f72> @ imm = #0x10
   66648: 465a         	mov	r2, r11
   6664a: eb04 0140    	add.w	r1, r4, r0, lsl #1
   6664e: eb0b 0240    	add.w	r2, r11, r0, lsl #1
   66652: 3001         	adds	r0, #0x1
   66654: 8912         	ldrh	r2, [r2, #0x8]
   66656: 824a         	strh	r2, [r1, #0x12]
   66658: e7f4         	b	0x66644 <air1_opcal4_algorithm+0x4f5c> @ imm = #-0x18
   6665a: 9841         	ldr	r0, [sp, #0x104]
   6665c: 7800         	ldrb	r0, [r0]
   6665e: 2800         	cmp	r0, #0x0
   66660: f43c a849    	beq.w	0x626f6 <air1_opcal4_algorithm+0x100e> @ imm = #-0x3f6e
   66664: 2001         	movs	r0, #0x1
   66666: f884 03d3    	strb.w	r0, [r4, #0x3d3]
   6666a: 2020         	movs	r0, #0x20
   6666c: f7fc b841    	b.w	0x626f2 <air1_opcal4_algorithm+0x100a> @ imm = #-0x3f7e
   66670: 34 b2 02 00  	.word	0x0002b234

00066674 <clear_mem>:
   66674: 2200         	movs	r2, #0x0
   66676: b119         	cbz	r1, 0x66680 <clear_mem+0xc> @ imm = #0x6
   66678: f800 2b01    	strb	r2, [r0], #1
   6667c: 3901         	subs	r1, #0x1
   6667e: e7fa         	b	0x66676 <clear_mem+0x2> @ imm = #-0xc
   66680: 4770         	bx	lr
   66682: d4d4         	bmi	0x6662e <air1_opcal4_algorithm+0x4f46> @ imm = #-0x58
   66684: d4d4         	bmi	0x66630 <air1_opcal4_algorithm+0x4f48> @ imm = #-0x58
   66686: d4d4         	bmi	0x66632 <air1_opcal4_algorithm+0x4f4a> @ imm = #-0x58

00066688 <check_error>:
   66688: b5f0         	push	{r4, r5, r6, r7, lr}
   6668a: af03         	add	r7, sp, #0xc
   6668c: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   66690: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   66694: f5ad 4d8c    	sub.w	sp, sp, #0x4600
   66698: b08a         	sub	sp, #0x28
   6669a: 913b         	str	r1, [sp, #0xec]
   6669c: 4601         	mov	r1, r0
   6669e: f8df 0e04    	ldr.w	r0, [pc, #0xe04]        @ 0x674a4 <check_error+0xe1c>
   666a2: 4478         	add	r0, pc
   666a4: 6800         	ldr	r0, [r0]
   666a6: 6800         	ldr	r0, [r0]
   666a8: f847 0c6c    	str	r0, [r7, #-108]
   666ac: f642 2058    	movw	r0, #0x2a58
   666b0: eb01 0a00    	add.w	r10, r1, r0
   666b4: f244 20e4    	movw	r0, #0x42e4
   666b8: 180a         	adds	r2, r1, r0
   666ba: f644 30e8    	movw	r0, #0x4be8
   666be: 4408         	add	r0, r1
   666c0: 9039         	str	r0, [sp, #0xe4]
   666c2: f245 20d8    	movw	r0, #0x52d8
   666c6: 4408         	add	r0, r1
   666c8: 9027         	str	r0, [sp, #0x9c]
   666ca: f246 3058    	movw	r0, #0x6358
   666ce: 4408         	add	r0, r1
   666d0: 9029         	str	r0, [sp, #0xa4]
   666d2: f247 5050    	movw	r0, #0x7550
   666d6: 4408         	add	r0, r1
   666d8: 9024         	str	r0, [sp, #0x90]
   666da: f248 7048    	movw	r0, #0x8748
   666de: 4408         	add	r0, r1
   666e0: 9025         	str	r0, [sp, #0x94]
   666e2: f649 1040    	movw	r0, #0x9940
   666e6: 4408         	add	r0, r1
   666e8: 9035         	str	r0, [sp, #0xd4]
   666ea: f24b 10d0    	movw	r0, #0xb1d0
   666ee: 4408         	add	r0, r1
   666f0: 9026         	str	r0, [sp, #0x98]
   666f2: f64b 4070    	movw	r0, #0xbc70
   666f6: 4408         	add	r0, r1
   666f8: 903c         	str	r0, [sp, #0xf0]
   666fa: f24c 1008    	movw	r0, #0xc108
   666fe: 4408         	add	r0, r1
   66700: 902e         	str	r0, [sp, #0xb8]
   66702: f24c 5030    	movw	r0, #0xc530
   66706: 4408         	add	r0, r1
   66708: 9022         	str	r0, [sp, #0x88]
   6670a: f64c 1078    	movw	r0, #0xc978
   6670e: 4408         	add	r0, r1
   66710: 9021         	str	r0, [sp, #0x84]
   66712: f24e 40c0    	movw	r0, #0xe4c0
   66716: 4408         	add	r0, r1
   66718: 9038         	str	r0, [sp, #0xe0]
   6671a: f24f 70f0    	movw	r0, #0xf7f0
   6671e: 4408         	add	r0, r1
   66720: 902f         	str	r0, [sp, #0xbc]
   66722: 48d3         	ldr	r0, [pc, #0x34c]        @ 0x66a70 <check_error+0x3e8>
   66724: eb01 0b00    	add.w	r11, r1, r0
   66728: 48d2         	ldr	r0, [pc, #0x348]        @ 0x66a74 <check_error+0x3ec>
   6672a: 4408         	add	r0, r1
   6672c: 902b         	str	r0, [sp, #0xac]
   6672e: 48d2         	ldr	r0, [pc, #0x348]        @ 0x66a78 <check_error+0x3f0>
   66730: 4408         	add	r0, r1
   66732: 9031         	str	r0, [sp, #0xc4]
   66734: 48d1         	ldr	r0, [pc, #0x344]        @ 0x66a7c <check_error+0x3f4>
   66736: eb01 0800    	add.w	r8, r1, r0
   6673a: 48d1         	ldr	r0, [pc, #0x344]        @ 0x66a80 <check_error+0x3f8>
   6673c: 4408         	add	r0, r1
   6673e: 9036         	str	r0, [sp, #0xd8]
   66740: 48d0         	ldr	r0, [pc, #0x340]        @ 0x66a84 <check_error+0x3fc>
   66742: 4408         	add	r0, r1
   66744: 9030         	str	r0, [sp, #0xc0]
   66746: 48d0         	ldr	r0, [pc, #0x340]        @ 0x66a88 <check_error+0x400>
   66748: 4408         	add	r0, r1
   6674a: 9033         	str	r0, [sp, #0xcc]
   6674c: 48cf         	ldr	r0, [pc, #0x33c]        @ 0x66a8c <check_error+0x404>
   6674e: 4408         	add	r0, r1
   66750: 9037         	str	r0, [sp, #0xdc]
   66752: 48cf         	ldr	r0, [pc, #0x33c]        @ 0x66a90 <check_error+0x408>
   66754: 4408         	add	r0, r1
   66756: 9034         	str	r0, [sp, #0xd0]
   66758: 4ece         	ldr	r6, [pc, #0x338]        @ 0x66a94 <check_error+0x40c>
   6675a: 447e         	add	r6, pc
   6675c: f896 00c8    	ldrb.w	r0, [r6, #0xc8]
   66760: 2801         	cmp	r0, #0x1
   66762: bf04         	itt	eq
   66764: 8810         	ldrheq	r0, [r2]
   66766: 2800         	cmpeq	r0, #0x0
   66768: f000 8097    	beq.w	0x6689a <check_error+0x212> @ imm = #0x12e
   6676c: f244 20f8    	movw	r0, #0x42f8
   66770: 9228         	str	r2, [sp, #0xa0]
   66772: 180c         	adds	r4, r1, r0
   66774: f506 60ea    	add.w	r0, r6, #0x750
   66778: 902c         	str	r0, [sp, #0xb0]
   6677a: ed90 0b00    	vldr	d0, [r0]
   6677e: 9153         	str	r1, [sp, #0x14c]
   66780: f005 ffea    	bl	0x6c758 <math_round>    @ imm = #0x5fd4
   66784: 9d53         	ldr	r5, [sp, #0x14c]
   66786: 2000         	movs	r0, #0x0
   66788: f640 01f8    	movw	r1, #0x8f8
   6678c: 4288         	cmp	r0, r1
   6678e: d009         	beq	0x667a4 <check_error+0x11c> @ imm = #0x12
   66790: 182b         	adds	r3, r5, r0
   66792: 1822         	adds	r2, r4, r0
   66794: f503 4386    	add.w	r3, r3, #0x4300
   66798: 3008         	adds	r0, #0x8
   6679a: edd3 0b00    	vldr	d16, [r3]
   6679e: edc2 0b00    	vstr	d16, [r2]
   667a2: e7f3         	b	0x6678c <check_error+0x104> @ imm = #-0x1a
   667a4: eebd 0bc0    	vcvt.s32.f64	s0, d0
   667a8: 9839         	ldr	r0, [sp, #0xe4]
   667aa: 49bb         	ldr	r1, [pc, #0x2ec]        @ 0x66a98 <check_error+0x410>
   667ac: f8cd 80c8    	str.w	r8, [sp, #0xc8]
   667b0: eef8 0bc0    	vcvt.f64.s32	d16, s0
   667b4: edc0 0b02    	vstr	d16, [r0, #8]
   667b8: 2000         	movs	r0, #0x0
   667ba: f886 0896    	strb.w	r0, [r6, #0x896]
   667be: f8c6 08a0    	str.w	r0, [r6, #0x8a0]
   667c2: f506 60b5    	add.w	r0, r6, #0x5a8
   667c6: 902a         	str	r0, [sp, #0xa8]
   667c8: edd0 0b00    	vldr	d16, [r0]
   667cc: 982c         	ldr	r0, [sp, #0xb0]
   667ce: f8c6 18a4    	str.w	r1, [r6, #0x8a4]
   667d2: f606 0198    	addw	r1, r6, #0x898
   667d6: 9163         	str	r1, [sp, #0x18c]
   667d8: ed90 0b00    	vldr	d0, [r0]
   667dc: edc1 0b00    	vstr	d16, [r1]
   667e0: f8b5 8648    	ldrh.w	r8, [r5, #0x648]
   667e4: 8834         	ldrh	r4, [r6]
   667e6: f005 ffb7    	bl	0x6c758 <math_round>    @ imm = #0x5f6e
   667ea: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   667ee: f1b8 0f02    	cmp.w	r8, #0x2
   667f2: 4daa         	ldr	r5, [pc, #0x2a8]        @ 0x66a9c <check_error+0x414>
   667f4: 48aa         	ldr	r0, [pc, #0x2a8]        @ 0x66aa0 <check_error+0x418>
   667f6: 9652         	str	r6, [sp, #0x148]
   667f8: 4478         	add	r0, pc
   667fa: 903d         	str	r0, [sp, #0xf4]
   667fc: f0c0 812d    	blo.w	0x66a5a <check_error+0x3d2> @ imm = #0x25a
   66800: 983d         	ldr	r0, [sp, #0xf4]
   66802: f8b0 093a    	ldrh.w	r0, [r0, #0x93a]
   66806: 4580         	cmp	r8, r0
   66808: f240 8127    	bls.w	0x66a5a <check_error+0x3d2> @ imm = #0x24e
   6680c: f89a 104a    	ldrb.w	r1, [r10, #0x4a]
   66810: 2902         	cmp	r1, #0x2
   66812: f200 8122    	bhi.w	0x66a5a <check_error+0x3d2> @ imm = #0x244
   66816: eebd 8bc0    	vcvt.s32.f64	s16, d0
   6681a: 993c         	ldr	r1, [sp, #0xf0]
   6681c: f891 1271    	ldrb.w	r1, [r1, #0x271]
   66820: 2901         	cmp	r1, #0x1
   66822: d13d         	bne	0x668a0 <check_error+0x218> @ imm = #0x7a
   66824: ebae 0000    	sub.w	r0, lr, r0
   66828: f64b 61e2    	movw	r1, #0xbee2
   6682c: 5c40         	ldrb	r0, [r0, r1]
   6682e: 2801         	cmp	r0, #0x1
   66830: f000 8113    	beq.w	0x66a5a <check_error+0x3d2> @ imm = #0x226
   66834: f8be 0d08    	ldrh.w	r0, [lr, #0xd08]
   66838: 1a20         	subs	r0, r4, r0
   6683a: bf48         	it	mi
   6683c: 4240         	rsbmi	r0, r0, #0
   6683e: 993d         	ldr	r1, [sp, #0xf4]
   66840: f8b1 1938    	ldrh.w	r1, [r1, #0x938]
   66844: 4288         	cmp	r0, r1
   66846: f200 8108    	bhi.w	0x66a5a <check_error+0x3d2> @ imm = #0x210
   6684a: eef8 0bc8    	vcvt.f64.s32	d16, s16
   6684e: 983d         	ldr	r0, [sp, #0xf4]
   66850: f500 6011    	add.w	r0, r0, #0x910
   66854: edd0 1b00    	vldr	d17, [r0]
   66858: eef4 1b60    	vcmp.f64	d17, d16
   6685c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66860: d80a         	bhi	0x66878 <check_error+0x1f0> @ imm = #0x14
   66862: 983d         	ldr	r0, [sp, #0xf4]
   66864: f600 1018    	addw	r0, r0, #0x918
   66868: edd0 1b00    	vldr	d17, [r0]
   6686c: eef4 1b60    	vcmp.f64	d17, d16
   66870: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66874: f280 80f1    	bge.w	0x66a5a <check_error+0x3d2> @ imm = #0x1e2
   66878: 983c         	ldr	r0, [sp, #0xf0]
   6687a: edd0 1b9e    	vldr	d17, [r0, #632]
   6687e: 983d         	ldr	r0, [sp, #0xf4]
   66880: f500 6014    	add.w	r0, r0, #0x940
   66884: edd0 2b00    	vldr	d18, [r0]
   66888: ee71 2be2    	vsub.f64	d18, d17, d18
   6688c: eef4 2b60    	vcmp.f64	d18, d16
   66890: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66894: f200 80d4    	bhi.w	0x66a40 <check_error+0x3b8> @ imm = #0x1a8
   66898: e0df         	b	0x66a5a <check_error+0x3d2> @ imm = #0x1be
   6689a: 8830         	ldrh	r0, [r6]
   6689c: 8010         	strh	r0, [r2]
   6689e: e765         	b	0x6676c <check_error+0xe4> @ imm = #-0x136
   668a0: 983d         	ldr	r0, [sp, #0xf4]
   668a2: f20e 634a    	addw	r3, lr, #0x64a
   668a6: 2100         	movs	r1, #0x0
   668a8: f8b0 c90a    	ldrh.w	r12, [r0, #0x90a]
   668ac: eba4 020c    	sub.w	r2, r4, r12
   668b0: b195         	cbz	r5, 0x668d8 <check_error+0x250> @ imm = #0x24
   668b2: 195e         	adds	r6, r3, r5
   668b4: f8b6 66c2    	ldrh.w	r6, [r6, #0x6c2]
   668b8: b15e         	cbz	r6, 0x668d2 <check_error+0x24a> @ imm = #0x16
   668ba: 42b4         	cmp	r4, r6
   668bc: f04f 0000    	mov.w	r0, #0x0
   668c0: bf88         	it	hi
   668c2: 2001         	movhi	r0, #0x1
   668c4: 42b2         	cmp	r2, r6
   668c6: f04f 0600    	mov.w	r6, #0x0
   668ca: bfb8         	it	lt
   668cc: 2601         	movlt	r6, #0x1
   668ce: 4030         	ands	r0, r6
   668d0: 4401         	add	r1, r0
   668d2: 3502         	adds	r5, #0x2
   668d4: 9e52         	ldr	r6, [sp, #0x148]
   668d6: e7eb         	b	0x668b0 <check_error+0x228> @ imm = #-0x2a
   668d8: b28a         	uxth	r2, r1
   668da: f1ac 0001    	sub.w	r0, r12, #0x1
   668de: f5b2 7f90    	cmp.w	r2, #0x120
   668e2: bf28         	it	hs
   668e4: f44f 7190    	movhs.w	r1, #0x120
   668e8: b28c         	uxth	r4, r1
   668ea: 42a0         	cmp	r0, r4
   668ec: f040 80b5    	bne.w	0x66a5a <check_error+0x3d2> @ imm = #0x16a
   668f0: a80c         	add	r0, sp, #0x30
   668f2: f44f 6110    	mov.w	r1, #0x900
   668f6: f500 551f    	add.w	r5, r0, #0x27c0
   668fa: 4628         	mov	r0, r5
   668fc: f008 eb80    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x8700
   66900: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   66904: f644 31f8    	movw	r1, #0x4bf8
   66908: f5c4 7c90    	rsb.w	r12, r4, #0x120
   6690c: 2200         	movs	r2, #0x0
   6690e: ebae 00c4    	sub.w	r0, lr, r4, lsl #3
   66912: 2604         	movs	r6, #0x4
   66914: 4401         	add	r1, r0
   66916: ebae 0084    	sub.w	r0, lr, r4, lsl #2
   6691a: f200 6344    	addw	r3, r0, #0x644
   6691e: 1e60         	subs	r0, r4, #0x1
   66920: eddf 0b61    	vldr	d16, [pc, #388]         @ 0x66aa8 <check_error+0x420>
   66924: 4282         	cmp	r2, r0
   66926: da1e         	bge	0x66966 <check_error+0x2de> @ imm = #0x3c
   66928: f923 0786    	vld1.32	{d0}, [r3], r6
   6692c: eef8 1b40    	vcvt.f64.u32	d17, s0
   66930: eef8 2b60    	vcvt.f64.u32	d18, s1
   66934: ee72 1be1    	vsub.f64	d17, d18, d17
   66938: eec1 1ba0    	vdiv.f64	d17, d17, d16
   6693c: ed51 2b02    	vldr	d18, [r1, #-8]
   66940: ecf1 3b02    	vldmia	r1!, {d19}
   66944: ee73 2be2    	vsub.f64	d18, d19, d18
   66948: eec2 1ba1    	vdiv.f64	d17, d18, d17
   6694c: eef5 1b40    	vcmp.f64	d17, #0
   66950: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66954: eef1 2b61    	vneg.f64	d18, d17
   66958: bf48         	it	mi
   6695a: eef0 1b62    	vmovmi.f64	d17, d18
   6695e: 3201         	adds	r2, #0x1
   66960: ece5 1b02    	vstmia	r5!, {d17}
   66964: e7de         	b	0x66924 <check_error+0x29c> @ imm = #-0x44
   66966: 9e52         	ldr	r6, [sp, #0x148]
   66968: eb0e 01cc    	add.w	r1, lr, r12, lsl #3
   6696c: f244 22f8    	movw	r2, #0x42f8
   66970: 440a         	add	r2, r1
   66972: f50e 61c8    	add.w	r1, lr, #0x640
   66976: ed96 0a01    	vldr	s0, [r6, #4]
   6697a: eef8 1b40    	vcvt.f64.u32	d17, s0
   6697e: ed91 0a00    	vldr	s0, [r1]
   66982: 9939         	ldr	r1, [sp, #0xe4]
   66984: eef8 2b40    	vcvt.f64.u32	d18, s0
   66988: ee71 2be2    	vsub.f64	d18, d17, d18
   6698c: edd1 1b00    	vldr	d17, [r1]
   66990: 993d         	ldr	r1, [sp, #0xf4]
   66992: f601 1118    	addw	r1, r1, #0x918
   66996: edd1 3b00    	vldr	d19, [r1]
   6699a: 2101         	movs	r1, #0x1
   6699c: b194         	cbz	r4, 0x669c4 <check_error+0x33c> @ imm = #0x24
   6699e: ed52 4b02    	vldr	d20, [r2, #-8]
   669a2: eef4 4b63    	vcmp.f64	d20, d19
   669a6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   669aa: dd01         	ble	0x669b0 <check_error+0x328> @ imm = #0x2
   669ac: 2100         	movs	r1, #0x0
   669ae: e006         	b	0x669be <check_error+0x336> @ imm = #0xc
   669b0: edd2 4b00    	vldr	d20, [r2]
   669b4: eef4 4b64    	vcmp.f64	d20, d20
   669b8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   669bc: d6f6         	bvs	0x669ac <check_error+0x324> @ imm = #-0x14
   669be: 3c01         	subs	r4, #0x1
   669c0: 3208         	adds	r2, #0x8
   669c2: e7eb         	b	0x6699c <check_error+0x314> @ imm = #-0x2a
   669c4: eef8 3bc8    	vcvt.f64.s32	d19, s16
   669c8: 9a3d         	ldr	r2, [sp, #0xf4]
   669ca: 2400         	movs	r4, #0x0
   669cc: f502 6212    	add.w	r2, r2, #0x920
   669d0: edd2 4b00    	vldr	d20, [r2]
   669d4: ab0c         	add	r3, sp, #0x30
   669d6: ee73 3be1    	vsub.f64	d19, d19, d17
   669da: 2200         	movs	r2, #0x0
   669dc: f503 531f    	add.w	r3, r3, #0x27c0
   669e0: 4284         	cmp	r4, r0
   669e2: da09         	bge	0x669f8 <check_error+0x370> @ imm = #0x12
   669e4: ecf3 5b02    	vldmia	r3!, {d21}
   669e8: eef4 5b64    	vcmp.f64	d21, d20
   669ec: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   669f0: bf48         	it	mi
   669f2: 3201         	addmi	r2, #0x1
   669f4: 3401         	adds	r4, #0x1
   669f6: e7f3         	b	0x669e0 <check_error+0x358> @ imm = #-0x1a
   669f8: 2901         	cmp	r1, #0x1
   669fa: d12e         	bne	0x66a5a <check_error+0x3d2> @ imm = #0x5c
   669fc: 983d         	ldr	r0, [sp, #0xf4]
   669fe: f600 1028    	addw	r0, r0, #0x928
   66a02: edd0 4b00    	vldr	d20, [r0]
   66a06: b290         	uxth	r0, r2
   66a08: ee00 0a10    	vmov	s0, r0
   66a0c: eef8 5b40    	vcvt.f64.u32	d21, s0
   66a10: eef4 4b65    	vcmp.f64	d20, d21
   66a14: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66a18: d81f         	bhi	0x66a5a <check_error+0x3d2> @ imm = #0x3e
   66a1a: eec2 0ba0    	vdiv.f64	d16, d18, d16
   66a1e: eef5 0b40    	vcmp.f64	d16, #0
   66a22: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66a26: dd18         	ble	0x66a5a <check_error+0x3d2> @ imm = #0x30
   66a28: eec3 0ba0    	vdiv.f64	d16, d19, d16
   66a2c: 983d         	ldr	r0, [sp, #0xf4]
   66a2e: f500 6013    	add.w	r0, r0, #0x930
   66a32: edd0 2b00    	vldr	d18, [r0]
   66a36: eef4 0b62    	vcmp.f64	d16, d18
   66a3a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66a3e: d50c         	bpl	0x66a5a <check_error+0x3d2> @ imm = #0x18
   66a40: 2001         	movs	r0, #0x1
   66a42: f886 0896    	strb.w	r0, [r6, #0x896]
   66a46: f506 600a    	add.w	r0, r6, #0x8a0
   66a4a: edc0 1b00    	vstr	d17, [r0]
   66a4e: 983c         	ldr	r0, [sp, #0xf0]
   66a50: edd0 0ba0    	vldr	d16, [r0, #640]
   66a54: 9863         	ldr	r0, [sp, #0x18c]
   66a56: edc0 0b00    	vstr	d16, [r0]
   66a5a: f64b 60bb    	movw	r0, #0xbebb
   66a5e: 2127         	movs	r1, #0x27
   66a60: 4470         	add	r0, lr
   66a62: b329         	cbz	r1, 0x66ab0 <check_error+0x428> @ imm = #0x4a
   66a64: f810 2b01    	ldrb	r2, [r0], #1
   66a68: 3901         	subs	r1, #0x1
   66a6a: f800 2c02    	strb	r2, [r0, #-2]
   66a6e: e7f8         	b	0x66a62 <check_error+0x3da> @ imm = #-0x10
   66a70: 20 14 01 00  	.word	0x00011420
   66a74: 88 31 01 00  	.word	0x00013188
   66a78: 08 36 01 00  	.word	0x00013608
   66a7c: 58 53 01 00  	.word	0x00015358
   66a80: f0 71 01 00  	.word	0x000171f0
   66a84: 28 8d 01 00  	.word	0x00018d28
   66a88: a0 91 01 00  	.word	0x000191a0
   66a8c: b8 ac 01 00  	.word	0x0001acb8
   66a90: f8 c8 01 00  	.word	0x0001c8f8
   66a94: a2 b6 02 00  	.word	0x0002b6a2
   66a98: 00 00 f8 7f  	.word	0x7ff80000
   66a9c: 3e f9 ff ff  	.word	0xfffff93e
   66aa0: ac be 02 00  	.word	0x0002beac
   66aa4: 00 bf 00 bf  	.word	0xbf00bf00
   66aa8: 00 00 00 00  	.word	0x00000000
   66aac: 00 00 4e 40  	.word	0x404e0000
   66ab0: 993c         	ldr	r1, [sp, #0xf0]
   66ab2: f1b8 0f01    	cmp.w	r8, #0x1
   66ab6: f896 0896    	ldrb.w	r0, [r6, #0x896]
   66aba: f881 0271    	strb.w	r0, [r1, #0x271]
   66abe: f506 600a    	add.w	r0, r6, #0x8a0
   66ac2: edd0 0b00    	vldr	d16, [r0]
   66ac6: 9863         	ldr	r0, [sp, #0x18c]
   66ac8: edc1 0b9e    	vstr	d16, [r1, #632]
   66acc: edd0 0b00    	vldr	d16, [r0]
   66ad0: edc1 0ba0    	vstr	d16, [r1, #640]
   66ad4: f040 814f    	bne.w	0x66d76 <check_error+0x6ee> @ imm = #0x29e
   66ad8: 4de5         	ldr	r5, [pc, #0x394]        @ 0x66e70 <check_error+0x7e8>
   66ada: 2001         	movs	r0, #0x1
   66adc: 992e         	ldr	r1, [sp, #0xb8]
   66ade: 2200         	movs	r2, #0x0
   66ae0: 4be4         	ldr	r3, [pc, #0x390]        @ 0x66e74 <check_error+0x7ec>
   66ae2: 2600         	movs	r6, #0x0
   66ae4: 46a8         	mov	r8, r5
   66ae6: 4de4         	ldr	r5, [pc, #0x390]        @ 0x66e78 <check_error+0x7f0>
   66ae8: f881 0038    	strb.w	r0, [r1, #0x38]
   66aec: f24c 20d8    	movw	r0, #0xc2d8
   66af0: f24c 61c0    	movw	r1, #0xc6c0
   66af4: 4ce1         	ldr	r4, [pc, #0x384]        @ 0x66e7c <check_error+0x7f4>
   66af6: 4470         	add	r0, lr
   66af8: 4471         	add	r1, lr
   66afa: 469c         	mov	r12, r3
   66afc: 2e32         	cmp	r6, #0x32
   66afe: d017         	beq	0x66b30 <check_error+0x4a8> @ imm = #0x2e
   66b00: 4663         	mov	r3, r12
   66b02: f841 200c    	str.w	r2, [r1, r12]
   66b06: 4643         	mov	r3, r8
   66b08: 462b         	mov	r3, r5
   66b0a: f840 2026    	str.w	r2, [r0, r6, lsl #2]
   66b0e: f5a1 63af    	sub.w	r3, r1, #0x578
   66b12: f841 2008    	str.w	r2, [r1, r8]
   66b16: 3601         	adds	r6, #0x1
   66b18: 605c         	str	r4, [r3, #0x4]
   66b1a: f5a1 7348    	sub.w	r3, r1, #0x320
   66b1e: 514a         	str	r2, [r1, r5]
   66b20: 605c         	str	r4, [r3, #0x4]
   66b22: f5a1 73c8    	sub.w	r3, r1, #0x190
   66b26: e9c1 2400    	strd	r2, r4, [r1]
   66b2a: 3108         	adds	r1, #0x8
   66b2c: 605c         	str	r4, [r3, #0x4]
   66b2e: e7e5         	b	0x66afc <check_error+0x474> @ imm = #-0x36
   66b30: 9a22         	ldr	r2, [sp, #0x88]
   66b32: 2000         	movs	r0, #0x0
   66b34: 49d1         	ldr	r1, [pc, #0x344]        @ 0x66e7c <check_error+0x7f4>
   66b36: f64c 1380    	movw	r3, #0xc980
   66b3a: 9d52         	ldr	r5, [sp, #0x148]
   66b3c: 4473         	add	r3, lr
   66b3e: e9c2 10d3    	strd	r1, r0, [r2, #844]
   66b42: 2101         	movs	r1, #0x1
   66b44: f882 1322    	strb.w	r1, [r2, #0x322]
   66b48: 2400         	movs	r4, #0x0
   66b4a: 9921         	ldr	r1, [sp, #0x84]
   66b4c: f8c2 0348    	str.w	r0, [r2, #0x348]
   66b50: f8c2 0354    	str.w	r0, [r2, #0x354]
   66b54: f8a2 0320    	strh.w	r0, [r2, #0x320]
   66b58: f64c 0288    	movw	r2, #0xc888
   66b5c: e9c1 0000    	strd	r0, r0, [r1]
   66b60: f64c 0153    	movw	r1, #0xc853
   66b64: 4ec5         	ldr	r6, [pc, #0x314]        @ 0x66e7c <check_error+0x7f4>
   66b66: 4471         	add	r1, lr
   66b68: 4472         	add	r2, lr
   66b6a: 2c1e         	cmp	r4, #0x1e
   66b6c: d006         	beq	0x66b7c <check_error+0x4f4> @ imm = #0xc
   66b6e: 5508         	strb	r0, [r1, r4]
   66b70: f823 0014    	strh.w	r0, [r3, r4, lsl #1]
   66b74: 3401         	adds	r4, #0x1
   66b76: e8e2 0602    	strd	r0, r6, [r2], #8
   66b7a: e7f6         	b	0x66b6a <check_error+0x4e2> @ imm = #-0x14
   66b7c: 2000         	movs	r0, #0x0
   66b7e: 2100         	movs	r1, #0x0
   66b80: 2907         	cmp	r1, #0x7
   66b82: d004         	beq	0x66b8e <check_error+0x506> @ imm = #0x8
   66b84: 186a         	adds	r2, r5, r1
   66b86: 3101         	adds	r1, #0x1
   66b88: f882 088f    	strb.w	r0, [r2, #0x88f]
   66b8c: e7f8         	b	0x66b80 <check_error+0x4f8> @ imm = #-0x10
   66b8e: f64c 10c0    	movw	r0, #0xc9c0
   66b92: 4dba         	ldr	r5, [pc, #0x2e8]        @ 0x66e7c <check_error+0x7f4>
   66b94: 4470         	add	r0, lr
   66b96: f240 3161    	movw	r1, #0x361
   66b9a: 2200         	movs	r2, #0x0
   66b9c: b119         	cbz	r1, 0x66ba6 <check_error+0x51e> @ imm = #0x6
   66b9e: e8e0 2502    	strd	r2, r5, [r0], #8
   66ba2: 3901         	subs	r1, #0x1
   66ba4: e7fa         	b	0x66b9c <check_error+0x514> @ imm = #-0xc
   66ba6: f24e 40c8    	movw	r0, #0xe4c8
   66baa: 2100         	movs	r1, #0x0
   66bac: 4470         	add	r0, lr
   66bae: 2200         	movs	r2, #0x0
   66bb0: f5b2 7f90    	cmp.w	r2, #0x120
   66bb4: d004         	beq	0x66bc0 <check_error+0x538> @ imm = #0x8
   66bb6: 1883         	adds	r3, r0, r2
   66bb8: 5081         	str	r1, [r0, r2]
   66bba: 3208         	adds	r2, #0x8
   66bbc: 605d         	str	r5, [r3, #0x4]
   66bbe: e7f7         	b	0x66bb0 <check_error+0x528> @ imm = #-0x12
   66bc0: 9938         	ldr	r1, [sp, #0xe0]
   66bc2: 2000         	movs	r0, #0x0
   66bc4: f240 2241    	movw	r2, #0x241
   66bc8: e9c1 004a    	strd	r0, r0, [r1, #296]
   66bcc: f24e 51f0    	movw	r1, #0xe5f0
   66bd0: 4471         	add	r1, lr
   66bd2: b11a         	cbz	r2, 0x66bdc <check_error+0x554> @ imm = #0x6
   66bd4: e8e1 0502    	strd	r0, r5, [r1], #8
   66bd8: 3a01         	subs	r2, #0x1
   66bda: e7fa         	b	0x66bd2 <check_error+0x54a> @ imm = #-0xc
   66bdc: f64f 1020    	movw	r0, #0xf920
   66be0: f240 3161    	movw	r1, #0x361
   66be4: 4470         	add	r0, lr
   66be6: 2200         	movs	r2, #0x0
   66be8: b119         	cbz	r1, 0x66bf2 <check_error+0x56a> @ imm = #0x6
   66bea: e8e0 2502    	strd	r2, r5, [r0], #8
   66bee: 3901         	subs	r1, #0x1
   66bf0: e7fa         	b	0x66be8 <check_error+0x560> @ imm = #-0xc
   66bf2: 982f         	ldr	r0, [sp, #0xbc]
   66bf4: 2100         	movs	r1, #0x0
   66bf6: 2324         	movs	r3, #0x24
   66bf8: e9c0 154a    	strd	r1, r5, [r0, #296]
   66bfc: 48a0         	ldr	r0, [pc, #0x280]        @ 0x66e80 <check_error+0x7f8>
   66bfe: eb0e 0200    	add.w	r2, lr, r0
   66c02: 48a0         	ldr	r0, [pc, #0x280]        @ 0x66e84 <check_error+0x7fc>
   66c04: b143         	cbz	r3, 0x66c18 <check_error+0x590> @ imm = #0x10
   66c06: f5a2 7490    	sub.w	r4, r2, #0x120
   66c0a: 5011         	str	r1, [r2, r0]
   66c0c: e9c2 1500    	strd	r1, r5, [r2]
   66c10: 3b01         	subs	r3, #0x1
   66c12: 6065         	str	r5, [r4, #0x4]
   66c14: 3208         	adds	r2, #0x8
   66c16: e7f5         	b	0x66c04 <check_error+0x57c> @ imm = #-0x16
   66c18: 4c9b         	ldr	r4, [pc, #0x26c]        @ 0x66e88 <check_error+0x800>
   66c1a: 2100         	movs	r1, #0x0
   66c1c: e9cb 1194    	strd	r1, r1, [r11, #592]
   66c20: 46dc         	mov	r12, r11
   66c22: f8cb 1258    	str.w	r1, [r11, #0x258]
   66c26: 46d1         	mov	r9, r10
   66c28: 46a0         	mov	r8, r4
   66c2a: 4c98         	ldr	r4, [pc, #0x260]        @ 0x66e8c <check_error+0x804>
   66c2c: f8cb 525c    	str.w	r5, [r11, #0x25c]
   66c30: 2324         	movs	r3, #0x24
   66c32: 4a97         	ldr	r2, [pc, #0x25c]        @ 0x66e90 <check_error+0x808>
   66c34: 46a3         	mov	r11, r4
   66c36: 4c97         	ldr	r4, [pc, #0x25c]        @ 0x66e94 <check_error+0x80c>
   66c38: 4472         	add	r2, lr
   66c3a: 46a2         	mov	r10, r4
   66c3c: 4c96         	ldr	r4, [pc, #0x258]        @ 0x66e98 <check_error+0x810>
   66c3e: b323         	cbz	r3, 0x66c8a <check_error+0x602> @ imm = #0x48
   66c40: 4646         	mov	r6, r8
   66c42: e9c2 1500    	strd	r1, r5, [r2]
   66c46: 465e         	mov	r6, r11
   66c48: f5a2 7590    	sub.w	r5, r2, #0x120
   66c4c: 4656         	mov	r6, r10
   66c4e: 5011         	str	r1, [r2, r0]
   66c50: 4e8a         	ldr	r6, [pc, #0x228]        @ 0x66e7c <check_error+0x7f4>
   66c52: 3b01         	subs	r3, #0x1
   66c54: 606e         	str	r6, [r5, #0x4]
   66c56: f5a2 65b4    	sub.w	r5, r2, #0x5a0
   66c5a: 4e88         	ldr	r6, [pc, #0x220]        @ 0x66e7c <check_error+0x7f4>
   66c5c: 606e         	str	r6, [r5, #0x4]
   66c5e: f5a2 6590    	sub.w	r5, r2, #0x480
   66c62: 4e86         	ldr	r6, [pc, #0x218]        @ 0x66e7c <check_error+0x7f4>
   66c64: 606e         	str	r6, [r5, #0x4]
   66c66: f5a2 7558    	sub.w	r5, r2, #0x360
   66c6a: 4e84         	ldr	r6, [pc, #0x210]        @ 0x66e7c <check_error+0x7f4>
   66c6c: 606e         	str	r6, [r5, #0x4]
   66c6e: f5a2 7510    	sub.w	r5, r2, #0x240
   66c72: 4e82         	ldr	r6, [pc, #0x208]        @ 0x66e7c <check_error+0x7f4>
   66c74: 606e         	str	r6, [r5, #0x4]
   66c76: f842 1008    	str.w	r1, [r2, r8]
   66c7a: f842 100b    	str.w	r1, [r2, r11]
   66c7e: f842 100a    	str.w	r1, [r2, r10]
   66c82: 5111         	str	r1, [r2, r4]
   66c84: 3208         	adds	r2, #0x8
   66c86: 4d7d         	ldr	r5, [pc, #0x1f4]        @ 0x66e7c <check_error+0x7f4>
   66c88: e7d9         	b	0x66c3e <check_error+0x5b6> @ imm = #-0x4e
   66c8a: 4884         	ldr	r0, [pc, #0x210]        @ 0x66e9c <check_error+0x814>
   66c8c: f240 3161    	movw	r1, #0x361
   66c90: 9e52         	ldr	r6, [sp, #0x148]
   66c92: 2200         	movs	r2, #0x0
   66c94: 9b32         	ldr	r3, [sp, #0xc8]
   66c96: 4470         	add	r0, lr
   66c98: 46ca         	mov	r10, r9
   66c9a: 46e3         	mov	r11, r12
   66c9c: b119         	cbz	r1, 0x66ca6 <check_error+0x61e> @ imm = #0x6
   66c9e: e8e0 2502    	strd	r2, r5, [r0], #8
   66ca2: 3901         	subs	r1, #0x1
   66ca4: e7fa         	b	0x66c9c <check_error+0x614> @ imm = #-0xc
   66ca6: 9931         	ldr	r1, [sp, #0xc4]
   66ca8: 2000         	movs	r0, #0x0
   66caa: 2224         	movs	r2, #0x24
   66cac: e9c3 0006    	strd	r0, r0, [r3, #24]
   66cb0: e9c3 0508    	strd	r0, r5, [r3, #32]
   66cb4: e9c1 0592    	strd	r0, r5, [r1, #584]
   66cb8: 4979         	ldr	r1, [pc, #0x1e4]        @ 0x66ea0 <check_error+0x818>
   66cba: 4471         	add	r1, lr
   66cbc: b13a         	cbz	r2, 0x66cce <check_error+0x646> @ imm = #0xe
   66cbe: e9c1 0548    	strd	r0, r5, [r1, #288]
   66cc2: 3a01         	subs	r2, #0x1
   66cc4: e9c1 0590    	strd	r0, r5, [r1, #576]
   66cc8: e8e1 0502    	strd	r0, r5, [r1], #8
   66ccc: e7f6         	b	0x66cbc <check_error+0x634> @ imm = #-0x14
   66cce: 4875         	ldr	r0, [pc, #0x1d4]        @ 0x66ea4 <check_error+0x81c>
   66cd0: f240 3161    	movw	r1, #0x361
   66cd4: 2200         	movs	r2, #0x0
   66cd6: 4470         	add	r0, lr
   66cd8: b119         	cbz	r1, 0x66ce2 <check_error+0x65a> @ imm = #0x6
   66cda: e8e0 2502    	strd	r2, r5, [r0], #8
   66cde: 3901         	subs	r1, #0x1
   66ce0: e7fa         	b	0x66cd8 <check_error+0x650> @ imm = #-0xc
   66ce2: 9936         	ldr	r1, [sp, #0xd8]
   66ce4: 2000         	movs	r0, #0x0
   66ce6: 4a70         	ldr	r2, [pc, #0x1c0]        @ 0x66ea8 <check_error+0x820>
   66ce8: 2400         	movs	r4, #0x0
   66cea: e9c3 05e4    	strd	r0, r5, [r3, #912]
   66cee: 4b6f         	ldr	r3, [pc, #0x1bc]        @ 0x66eac <check_error+0x824>
   66cf0: 4472         	add	r2, lr
   66cf2: e9c1 0008    	strd	r0, r0, [r1, #32]
   66cf6: e9c1 050a    	strd	r0, r5, [r1, #40]
   66cfa: 4473         	add	r3, lr
   66cfc: 7608         	strb	r0, [r1, #0x18]
   66cfe: 496c         	ldr	r1, [pc, #0x1b0]        @ 0x66eb0 <check_error+0x828>
   66d00: eb0e 0c01    	add.w	r12, lr, r1
   66d04: f5b4 7f90    	cmp.w	r4, #0x120
   66d08: d01a         	beq	0x66d40 <check_error+0x6b8> @ imm = #0x34
   66d0a: 495c         	ldr	r1, [pc, #0x170]        @ 0x66e7c <check_error+0x7f4>
   66d0c: 191d         	adds	r5, r3, r4
   66d0e: eb0c 0604    	add.w	r6, r12, r4
   66d12: f84c 0004    	str.w	r0, [r12, r4]
   66d16: e9c5 0190    	strd	r0, r1, [r5, #576]
   66d1a: 4958         	ldr	r1, [pc, #0x160]        @ 0x66e7c <check_error+0x7f4>
   66d1c: 5110         	str	r0, [r2, r4]
   66d1e: 5118         	str	r0, [r3, r4]
   66d20: e9c5 01d8    	strd	r0, r1, [r5, #864]
   66d24: 4955         	ldr	r1, [pc, #0x154]        @ 0x66e7c <check_error+0x7f4>
   66d26: 6071         	str	r1, [r6, #0x4]
   66d28: 1916         	adds	r6, r2, r4
   66d2a: 4954         	ldr	r1, [pc, #0x150]        @ 0x66e7c <check_error+0x7f4>
   66d2c: 3408         	adds	r4, #0x8
   66d2e: 6071         	str	r1, [r6, #0x4]
   66d30: 4952         	ldr	r1, [pc, #0x148]        @ 0x66e7c <check_error+0x7f4>
   66d32: 6069         	str	r1, [r5, #0x4]
   66d34: 4951         	ldr	r1, [pc, #0x144]        @ 0x66e7c <check_error+0x7f4>
   66d36: 9e52         	ldr	r6, [sp, #0x148]
   66d38: e9c5 0148    	strd	r0, r1, [r5, #288]
   66d3c: 4d4f         	ldr	r5, [pc, #0x13c]        @ 0x66e7c <check_error+0x7f4>
   66d3e: e7e1         	b	0x66d04 <check_error+0x67c> @ imm = #-0x3e
   66d40: 485c         	ldr	r0, [pc, #0x170]        @ 0x66eb4 <check_error+0x82c>
   66d42: f240 3161    	movw	r1, #0x361
   66d46: 4a5c         	ldr	r2, [pc, #0x170]        @ 0x66eb8 <check_error+0x830>
   66d48: 2300         	movs	r3, #0x0
   66d4a: 4470         	add	r0, lr
   66d4c: b141         	cbz	r1, 0x66d60 <check_error+0x6d8> @ imm = #0x10
   66d4e: f5a0 54e2    	sub.w	r4, r0, #0x1c40
   66d52: 5083         	str	r3, [r0, r2]
   66d54: e9c0 3500    	strd	r3, r5, [r0]
   66d58: 3901         	subs	r1, #0x1
   66d5a: 6065         	str	r5, [r4, #0x4]
   66d5c: 3008         	adds	r0, #0x8
   66d5e: e7f5         	b	0x66d4c <check_error+0x6c4> @ imm = #-0x16
   66d60: 9933         	ldr	r1, [sp, #0xcc]
   66d62: 2000         	movs	r0, #0x0
   66d64: f8be 8648    	ldrh.w	r8, [lr, #0x648]
   66d68: e9c1 0504    	strd	r0, r5, [r1, #16]
   66d6c: 9937         	ldr	r1, [sp, #0xdc]
   66d6e: e9c1 0504    	strd	r0, r5, [r1, #16]
   66d72: e9c1 0506    	strd	r0, r5, [r1, #24]
   66d76: f8ba 0380    	ldrh.w	r0, [r10, #0x380]
   66d7a: 4540         	cmp	r0, r8
   66d7c: f8cd b0e8    	str.w	r11, [sp, #0xe8]
   66d80: f040 817e    	bne.w	0x67080 <check_error+0x9f8> @ imm = #0x2fc
   66d84: 983d         	ldr	r0, [sp, #0xf4]
   66d86: 8831         	ldrh	r1, [r6]
   66d88: f8b0 0418    	ldrh.w	r0, [r0, #0x418]
   66d8c: 4281         	cmp	r1, r0
   66d8e: f240 8177    	bls.w	0x67080 <check_error+0x9f8> @ imm = #0x2ee
   66d92: f896 0896    	ldrb.w	r0, [r6, #0x896]
   66d96: 2801         	cmp	r0, #0x1
   66d98: f000 8172    	beq.w	0x67080 <check_error+0x9f8> @ imm = #0x2e4
   66d9c: 982c         	ldr	r0, [sp, #0xb0]
   66d9e: 992e         	ldr	r1, [sp, #0xb8]
   66da0: ed9a 8b10    	vldr	d8, [r10, #64]
   66da4: edd0 1b00    	vldr	d17, [r0]
   66da8: f891 0038    	ldrb.w	r0, [r1, #0x38]
   66dac: edda 0be2    	vldr	d16, [r10, #904]
   66db0: b188         	cbz	r0, 0x66dd6 <check_error+0x74e> @ imm = #0x22
   66db2: 2000         	movs	r0, #0x0
   66db4: ed9a 9bdc    	vldr	d9, [r10, #880]
   66db8: f881 0038    	strb.w	r0, [r1, #0x38]
   66dbc: ee71 1be0    	vsub.f64	d17, d17, d16
   66dc0: f8da 036c    	ldr.w	r0, [r10, #0x36c]
   66dc4: f8c1 01d0    	str.w	r0, [r1, #0x1d0]
   66dc8: f8dd 9088    	ldr.w	r9, [sp, #0x88]
   66dcc: edc1 0ba6    	vstr	d16, [r1, #664]
   66dd0: ed81 9b10    	vstr	d9, [r1, #64]
   66dd4: e08e         	b	0x66ef4 <check_error+0x86c> @ imm = #0x11c
   66dd6: f8da 036c    	ldr.w	r0, [r10, #0x36c]
   66dda: 460b         	mov	r3, r1
   66ddc: ed91 0a74    	vldr	s0, [r1, #464]
   66de0: 9a3d         	ldr	r2, [sp, #0xf4]
   66de2: eef8 2b40    	vcvt.f64.u32	d18, s0
   66de6: f8dd 9088    	ldr.w	r9, [sp, #0x88]
   66dea: f8b2 1624    	ldrh.w	r1, [r2, #0x624]
   66dee: ee00 0a10    	vmov	s0, r0
   66df2: eef8 3b40    	vcvt.f64.u32	d19, s0
   66df6: ee73 2be2    	vsub.f64	d18, d19, d18
   66dfa: ed5f 3bd5    	vldr	d19, [pc, #-852]        @ 0x66aa8 <check_error+0x420>
   66dfe: ee00 1a10    	vmov	s0, r1
   66e02: eec2 2ba3    	vdiv.f64	d18, d18, d19
   66e06: eef8 3b40    	vcvt.f64.u32	d19, s0
   66e0a: eef4 2b63    	vcmp.f64	d18, d19
   66e0e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66e12: d965         	bls	0x66ee0 <check_error+0x858> @ imm = #0xca
   66e14: f892 1620    	ldrb.w	r1, [r2, #0x620]
   66e18: f24c 22d4    	movw	r2, #0xc2d4
   66e1c: f24c 1338    	movw	r3, #0xc138
   66e20: eb0e 0081    	add.w	r0, lr, r1, lsl #2
   66e24: 4402         	add	r2, r0
   66e26: eb0e 00c1    	add.w	r0, lr, r1, lsl #3
   66e2a: 4418         	add	r0, r3
   66e2c: 3902         	subs	r1, #0x2
   66e2e: f1b1 3fff    	cmp.w	r1, #0xffffffff
   66e32: f341 8381    	ble.w	0x68538 <check_error+0x1eb0> @ imm = #0x1702
   66e36: edd0 1b00    	vldr	d17, [r0]
   66e3a: 4613         	mov	r3, r2
   66e3c: edd0 2b96    	vldr	d18, [r0, #600]
   66e40: 3901         	subs	r1, #0x1
   66e42: edc0 1b02    	vstr	d17, [r0, #8]
   66e46: f853 4d04    	ldr	r4, [r3, #-4]!
   66e4a: edd0 3bfa    	vldr	d19, [r0, #1000]
   66e4e: 6014         	str	r4, [r2]
   66e50: f500 64af    	add.w	r4, r0, #0x578
   66e54: f500 62b0    	add.w	r2, r0, #0x580
   66e58: edc0 2b98    	vstr	d18, [r0, #608]
   66e5c: edd4 1b00    	vldr	d17, [r4]
   66e60: edc0 3bfc    	vstr	d19, [r0, #1008]
   66e64: 3808         	subs	r0, #0x8
   66e66: edc2 1b00    	vstr	d17, [r2]
   66e6a: 461a         	mov	r2, r3
   66e6c: e7df         	b	0x66e2e <check_error+0x7a6> @ imm = #-0x42
   66e6e: bf00         	nop
   66e70: e0 fc ff ff  	.word	0xfffffce0
   66e74: 88 fa ff ff  	.word	0xfffffa88
   66e78: 70 fe ff ff  	.word	0xfffffe70
   66e7c: 00 00 f8 7f  	.word	0x7ff80000
   66e80: 50 15 01 00  	.word	0x00011550
   66e84: e0 fe ff ff  	.word	0xfffffee0
   66e88: 60 fa ff ff  	.word	0xfffffa60
   66e8c: 80 fb ff ff  	.word	0xfffffb80
   66e90: 30 37 01 00  	.word	0x00013730
   66e94: a0 fc ff ff  	.word	0xfffffca0
   66e98: c0 fd ff ff  	.word	0xfffffdc0
   66e9c: 58 38 01 00  	.word	0x00013858
   66ea0: 88 53 01 00  	.word	0x00015388
   66ea4: f0 56 01 00  	.word	0x000156f0
   66ea8: 00 c9 01 00  	.word	0x0001c900
   66eac: 30 8d 01 00  	.word	0x00018d30
   66eb0: d8 ac 01 00  	.word	0x0001acd8
   66eb4: f8 ad 01 00  	.word	0x0001adf8
   66eb8: c0 e3 ff ff  	.word	0xffffe3c0
   66ebc: 00 bf 00 bf  	.word	0xbf00bf00
   66ec0: 00 00 00 00  	.word	0x00000000
   66ec4: 00 c0 72 c0  	.word	0xc072c000
   66ec8: 00 00 00 00  	.word	0x00000000
   66ecc: 00 00 72 40  	.word	0x40720000
   66ed0: 00 00 00 00  	.word	0x00000000
   66ed4: 00 00 59 40  	.word	0x40590000
   66ed8: 00 00 00 00  	.word	0x00000000
   66edc: 00 00 f8 7f  	.word	0x7ff80000
   66ee0: ee71 1be0    	vsub.f64	d17, d17, d16
   66ee4: f8c3 01d0    	str.w	r0, [r3, #0x1d0]
   66ee8: ed9a 9bdc    	vldr	d9, [r10, #880]
   66eec: edc3 0ba6    	vstr	d16, [r3, #664]
   66ef0: ed83 9b10    	vstr	d9, [r3, #64]
   66ef4: edc9 1b64    	vstr	d17, [r9, #400]
   66ef8: ee78 0b60    	vsub.f64	d16, d8, d16
   66efc: 983d         	ldr	r0, [sp, #0xf4]
   66efe: edc9 0b00    	vstr	d16, [r9]
   66f02: ed5f 1b11    	vldr	d17, [pc, #-68]         @ 0x66ec0 <check_error+0x838>
   66f06: 8b80         	ldrh	r0, [r0, #0x1c]
   66f08: ed1f ab11    	vldr	d10, [pc, #-68]         @ 0x66ec8 <check_error+0x840>
   66f0c: ee00 0a10    	vmov	s0, r0
   66f10: eef8 0b40    	vcvt.f64.u32	d16, s0
   66f14: eec0 0ba1    	vdiv.f64	d16, d16, d17
   66f18: ee79 0b20    	vadd.f64	d16, d9, d16
   66f1c: ee80 0b8a    	vdiv.f64	d0, d16, d10
   66f20: f005 ff62    	bl	0x6cde8 <math_ceil>     @ imm = #0x5ec4
   66f24: eebc 0bc0    	vcvt.u32.f64	s0, d0
   66f28: ee10 4a10    	vmov	r4, s0
   66f2c: 2c1d         	cmp	r4, #0x1d
   66f2e: bf28         	it	hs
   66f30: 241d         	movhs	r4, #0x1d
   66f32: f8b9 0320    	ldrh.w	r0, [r9, #0x320]
   66f36: 42a0         	cmp	r0, r4
   66f38: d204         	bhs	0x66f44 <check_error+0x8bc> @ imm = #0x8
   66f3a: efc0 0010    	vmov.i32	d16, #0x0
   66f3e: f8a9 4320    	strh.w	r4, [r9, #0x320]
   66f42: e001         	b	0x66f48 <check_error+0x8c0> @ imm = #0x2
   66f44: edd9 0bd4    	vldr	d16, [r9, #848]
   66f48: 9b53         	ldr	r3, [sp, #0x14c]
   66f4a: f64c 1180    	movw	r1, #0xc980
   66f4e: edda 1be2    	vldr	d17, [r10, #904]
   66f52: ed5f 2b21    	vldr	d18, [pc, #-132]        @ 0x66ed0 <check_error+0x848>
   66f56: eb03 0044    	add.w	r0, r3, r4, lsl #1
   66f5a: eef7 3b00    	vmov.f64	d19, #1.000000e+00
   66f5e: 461d         	mov	r5, r3
   66f60: 5a42         	ldrh	r2, [r0, r1]
   66f62: 3201         	adds	r2, #0x1
   66f64: 5242         	strh	r2, [r0, r1]
   66f66: eef4 1b62    	vcmp.f64	d17, d18
   66f6a: b290         	uxth	r0, r2
   66f6c: f64c 0188    	movw	r1, #0xc888
   66f70: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66f74: bfc8         	it	gt
   66f76: eef0 3b61    	vmovgt.f64	d19, d17
   66f7a: ee78 1b61    	vsub.f64	d17, d8, d17
   66f7e: eec1 1ba3    	vdiv.f64	d17, d17, d19
   66f82: ee00 0a10    	vmov	s0, r0
   66f86: eb03 00c4    	add.w	r0, r3, r4, lsl #3
   66f8a: ee70 0ba1    	vadd.f64	d16, d16, d17
   66f8e: 4408         	add	r0, r1
   66f90: 993d         	ldr	r1, [sp, #0xf4]
   66f92: eef8 1b40    	vcvt.f64.u32	d17, s0
   66f96: eec0 1ba1    	vdiv.f64	d17, d16, d17
   66f9a: edc0 1b00    	vstr	d17, [r0]
   66f9e: edc9 0bd4    	vstr	d16, [r9, #848]
   66fa2: f8b1 0418    	ldrh.w	r0, [r1, #0x418]
   66fa6: ee00 0a10    	vmov	s0, r0
   66faa: f501 60dc    	add.w	r0, r1, #0x6e0
   66fae: eef8 0b40    	vcvt.f64.u32	d16, s0
   66fb2: edd0 1b00    	vldr	d17, [r0]
   66fb6: ee41 0b8a    	vmla.f64	d16, d17, d10
   66fba: ee80 0b8a    	vdiv.f64	d0, d16, d10
   66fbe: f005 ff13    	bl	0x6cde8 <math_ceil>     @ imm = #0x5e26
   66fc2: ee60 0b0a    	vmul.f64	d16, d0, d10
   66fc6: eeb4 9b60    	vcmp.f64	d9, d16
   66fca: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   66fce: d932         	bls	0x67036 <check_error+0x9ae> @ imm = #0x64
   66fd0: f899 0322    	ldrb.w	r0, [r9, #0x322]
   66fd4: 2800         	cmp	r0, #0x0
   66fd6: d053         	beq	0x67080 <check_error+0x9f8> @ imm = #0xa6
   66fd8: f64c 0088    	movw	r0, #0xc888
   66fdc: efc0 1010    	vmov.i32	d17, #0x0
   66fe0: 182a         	adds	r2, r5, r0
   66fe2: f64c 0053    	movw	r0, #0xc853
   66fe6: 182b         	adds	r3, r5, r0
   66fe8: f64c 1080    	movw	r0, #0xc980
   66fec: efc0 0010    	vmov.i32	d16, #0x0
   66ff0: 182c         	adds	r4, r5, r0
   66ff2: 2100         	movs	r1, #0x0
   66ff4: 2000         	movs	r0, #0x0
   66ff6: 2500         	movs	r5, #0x0
   66ff8: 2d1e         	cmp	r5, #0x1e
   66ffa: d022         	beq	0x67042 <check_error+0x9ba> @ imm = #0x44
   66ffc: edd2 2b00    	vldr	d18, [r2]
   67000: 5d5e         	ldrb	r6, [r3, r5]
   67002: eef4 2b62    	vcmp.f64	d18, d18
   67006: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6700a: d611         	bvs	0x67030 <check_error+0x9a8> @ imm = #0x22
   6700c: 2e01         	cmp	r6, #0x1
   6700e: d10b         	bne	0x67028 <check_error+0x9a0> @ imm = #0x16
   67010: ee71 1ba2    	vadd.f64	d17, d17, d18
   67014: 3101         	adds	r1, #0x1
   67016: f834 6015    	ldrh.w	r6, [r4, r5, lsl #1]
   6701a: 3001         	adds	r0, #0x1
   6701c: ee00 6a10    	vmov	s0, r6
   67020: eef8 2b40    	vcvt.f64.u32	d18, s0
   67024: ee70 0ba2    	vadd.f64	d16, d16, d18
   67028: 3208         	adds	r2, #0x8
   6702a: 3501         	adds	r5, #0x1
   6702c: 9e52         	ldr	r6, [sp, #0x148]
   6702e: e7e3         	b	0x66ff8 <check_error+0x970> @ imm = #-0x3a
   67030: 2e01         	cmp	r6, #0x1
   67032: d0f0         	beq	0x67016 <check_error+0x98e> @ imm = #-0x20
   67034: e7f8         	b	0x67028 <check_error+0x9a0> @ imm = #-0x10
   67036: 1928         	adds	r0, r5, r4
   67038: f64c 0153    	movw	r1, #0xc853
   6703c: 2201         	movs	r2, #0x1
   6703e: 5442         	strb	r2, [r0, r1]
   67040: e01e         	b	0x67080 <check_error+0x9f8> @ imm = #0x3c
   67042: ed5f 2b5b    	vldr	d18, [pc, #-364]        @ 0x66ed8 <check_error+0x850>
   67046: 060a         	lsls	r2, r1, #0x18
   67048: ef62 31b2    	vorr	d19, d18, d18
   6704c: d006         	beq	0x6705c <check_error+0x9d4> @ imm = #0xc
   6704e: b2c9         	uxtb	r1, r1
   67050: ee00 1a10    	vmov	s0, r1
   67054: eef8 3b40    	vcvt.f64.u32	d19, s0
   67058: eec1 3ba3    	vdiv.f64	d19, d17, d19
   6705c: 9a22         	ldr	r2, [sp, #0x88]
   6705e: 0601         	lsls	r1, r0, #0x18
   67060: edc2 3bd2    	vstr	d19, [r2, #840]
   67064: d006         	beq	0x67074 <check_error+0x9ec> @ imm = #0xc
   67066: b2c0         	uxtb	r0, r0
   67068: ee00 0a10    	vmov	s0, r0
   6706c: eef8 1b40    	vcvt.f64.u32	d17, s0
   67070: eec0 2ba1    	vdiv.f64	d18, d16, d17
   67074: 2000         	movs	r0, #0x0
   67076: f882 0322    	strb.w	r0, [r2, #0x322]
   6707a: 9821         	ldr	r0, [sp, #0x84]
   6707c: edc0 2b00    	vstr	d18, [r0]
   67080: 8830         	ldrh	r0, [r6]
   67082: f1b8 0f01    	cmp.w	r8, #0x1
   67086: 9023         	str	r0, [sp, #0x8c]
   67088: f04f 0c00    	mov.w	r12, #0x0
   6708c: 9863         	ldr	r0, [sp, #0x18c]
   6708e: f24e 42c8    	movw	r2, #0xe4c8
   67092: f8cd a0b4    	str.w	r10, [sp, #0xb4]
   67096: f64b 64f8    	movw	r4, #0xbef8
   6709a: 4bfb         	ldr	r3, [pc, #0x3ec]        @ 0x67488 <check_error+0xe00>
   6709c: edd0 0b00    	vldr	d16, [r0]
   670a0: bf02         	ittt	eq
   670a2: 6870         	ldreq	r0, [r6, #0x4]
   670a4: 993c         	ldreq	r1, [sp, #0xf0]
   670a6: f8c1 03a8    	streq.w	r0, [r1, #0x3a8]
   670aa: 48f8         	ldr	r0, [pc, #0x3e0]        @ 0x6748c <check_error+0xe04>
   670ac: f503 6e90    	add.w	lr, r3, #0x480
   670b0: 9050         	str	r0, [sp, #0x140]
   670b2: f503 6a8f    	add.w	r10, r3, #0x478
   670b6: f500 51fd    	add.w	r1, r0, #0x1fa0
   670ba: 9148         	str	r1, [sp, #0x120]
   670bc: f500 7158    	add.w	r1, r0, #0x360
   670c0: 914f         	str	r1, [sp, #0x13c]
   670c2: f500 7156    	add.w	r1, r0, #0x358
   670c6: 9155         	str	r1, [sp, #0x154]
   670c8: f500 7110    	add.w	r1, r0, #0x240
   670cc: 914e         	str	r1, [sp, #0x138]
   670ce: f500 710e    	add.w	r1, r0, #0x238
   670d2: 9160         	str	r1, [sp, #0x180]
   670d4: f500 7190    	add.w	r1, r0, #0x120
   670d8: f500 708c    	add.w	r0, r0, #0x118
   670dc: 905b         	str	r0, [sp, #0x16c]
   670de: 48ec         	ldr	r0, [pc, #0x3b0]        @ 0x67490 <check_error+0xe08>
   670e0: 9051         	str	r0, [sp, #0x144]
   670e2: f500 55d8    	add.w	r5, r0, #0x1b00
   670e6: f503 60b4    	add.w	r0, r3, #0x5a0
   670ea: 9063         	str	r0, [sp, #0x18c]
   670ec: f503 60b3    	add.w	r0, r3, #0x598
   670f0: 9062         	str	r0, [sp, #0x188]
   670f2: f503 7058    	add.w	r0, r3, #0x360
   670f6: 904c         	str	r0, [sp, #0x130]
   670f8: f503 7056    	add.w	r0, r3, #0x358
   670fc: 4ee5         	ldr	r6, [pc, #0x394]        @ 0x67494 <check_error+0xe0c>
   670fe: 905e         	str	r0, [sp, #0x178]
   67100: f503 700e    	add.w	r0, r3, #0x238
   67104: 905c         	str	r0, [sp, #0x170]
   67106: f506 50e2    	add.w	r0, r6, #0x1c40
   6710a: 914d         	str	r1, [sp, #0x134]
   6710c: f503 7110    	add.w	r1, r3, #0x240
   67110: 9056         	str	r0, [sp, #0x158]
   67112: f106 0808    	add.w	r8, r6, #0x8
   67116: 48e0         	ldr	r0, [pc, #0x380]        @ 0x67498 <check_error+0xe10>
   67118: 914b         	str	r1, [sp, #0x12c]
   6711a: f503 7190    	add.w	r1, r3, #0x120
   6711e: 9047         	str	r0, [sp, #0x11c]
   67120: 48de         	ldr	r0, [pc, #0x378]        @ 0x6749c <check_error+0xe14>
   67122: 914a         	str	r1, [sp, #0x128]
   67124: f503 718c    	add.w	r1, r3, #0x118
   67128: 9158         	str	r1, [sp, #0x160]
   6712a: 49dd         	ldr	r1, [pc, #0x374]        @ 0x674a0 <check_error+0xe18>
   6712c: 4681         	mov	r9, r0
   6712e: 9354         	str	r3, [sp, #0x150]
   67130: 9149         	str	r1, [sp, #0x124]
   67132: 9b53         	ldr	r3, [sp, #0x14c]
   67134: f5bc 7f8c    	cmp.w	r12, #0x118
   67138: f000 80f5    	beq.w	0x67326 <check_error+0xc9e> @ imm = #0x1ea
   6713c: eb03 010c    	add.w	r1, r3, r12
   67140: 9440         	str	r4, [sp, #0x100]
   67142: f501 413f    	add.w	r1, r1, #0xbf00
   67146: 441c         	add	r4, r3
   67148: 9862         	ldr	r0, [sp, #0x188]
   6714a: edd1 1b00    	vldr	d17, [r1]
   6714e: 1899         	adds	r1, r3, r2
   67150: e9cd c842    	strd	r12, r8, [sp, #264]
   67154: edc4 1b00    	vstr	d17, [r4]
   67158: edd4 1b4c    	vldr	d17, [r4, #304]
   6715c: f8cd e118    	str.w	lr, [sp, #0x118]
   67160: edc4 1b4a    	vstr	d17, [r4, #296]
   67164: eb03 0408    	add.w	r4, r3, r8
   67168: edd1 1b02    	vldr	d17, [r1, #8]
   6716c: f8dd 8128    	ldr.w	r8, [sp, #0x128]
   67170: edc1 1b00    	vstr	d17, [r1]
   67174: 1999         	adds	r1, r3, r6
   67176: edd4 1b00    	vldr	d17, [r4]
   6717a: eb03 040e    	add.w	r4, r3, lr
   6717e: f8dd e12c    	ldr.w	lr, [sp, #0x12c]
   67182: edc1 1b00    	vstr	d17, [r1]
   67186: eb03 010a    	add.w	r1, r3, r10
   6718a: edd4 1b00    	vldr	d17, [r4]
   6718e: f8dd c130    	ldr.w	r12, [sp, #0x130]
   67192: edc1 1b00    	vstr	d17, [r1]
   67196: 1819         	adds	r1, r3, r0
   67198: 9863         	ldr	r0, [sp, #0x18c]
   6719a: 9641         	str	r6, [sp, #0x104]
   6719c: 181c         	adds	r4, r3, r0
   6719e: 9856         	ldr	r0, [sp, #0x158]
   671a0: 9e4e         	ldr	r6, [sp, #0x138]
   671a2: edd4 1b00    	vldr	d17, [r4]
   671a6: 923f         	str	r2, [sp, #0xfc]
   671a8: edc1 1b00    	vstr	d17, [r1]
   671ac: 1819         	adds	r1, r3, r0
   671ae: 9854         	ldr	r0, [sp, #0x150]
   671b0: 9a47         	ldr	r2, [sp, #0x11c]
   671b2: 181c         	adds	r4, r3, r0
   671b4: 9858         	ldr	r0, [sp, #0x160]
   671b6: f8dd b120    	ldr.w	r11, [sp, #0x120]
   671ba: edd4 1b00    	vldr	d17, [r4]
   671be: eb03 0408    	add.w	r4, r3, r8
   671c2: f8cd 90f8    	str.w	r9, [sp, #0xf8]
   671c6: f108 0808    	add.w	r8, r8, #0x8
   671ca: edc1 1b00    	vstr	d17, [r1]
   671ce: 1819         	adds	r1, r3, r0
   671d0: edd4 1b00    	vldr	d17, [r4]
   671d4: eb03 040e    	add.w	r4, r3, lr
   671d8: 985c         	ldr	r0, [sp, #0x170]
   671da: f10e 0e08    	add.w	lr, lr, #0x8
   671de: edc1 1b00    	vstr	d17, [r1]
   671e2: 1819         	adds	r1, r3, r0
   671e4: edd4 1b00    	vldr	d17, [r4]
   671e8: eb03 040c    	add.w	r4, r3, r12
   671ec: 985e         	ldr	r0, [sp, #0x178]
   671ee: edc1 1b00    	vstr	d17, [r1]
   671f2: f10c 0c08    	add.w	r12, r12, #0x8
   671f6: 1819         	adds	r1, r3, r0
   671f8: edd4 1b00    	vldr	d17, [r4]
   671fc: 199c         	adds	r4, r3, r6
   671fe: 9855         	ldr	r0, [sp, #0x154]
   67200: edc1 1b00    	vstr	d17, [r1]
   67204: eb03 0109    	add.w	r1, r3, r9
   67208: f8dd 913c    	ldr.w	r9, [sp, #0x13c]
   6720c: 3608         	adds	r6, #0x8
   6720e: edd1 1b02    	vldr	d17, [r1, #8]
   67212: edd1 2b4a    	vldr	d18, [r1, #296]
   67216: edd1 3b92    	vldr	d19, [r1, #584]
   6721a: edc1 2b48    	vstr	d18, [r1, #288]
   6721e: edc1 3b90    	vstr	d19, [r1, #576]
   67222: edc1 1b00    	vstr	d17, [r1]
   67226: 9960         	ldr	r1, [sp, #0x180]
   67228: edd4 1b00    	vldr	d17, [r4]
   6722c: 189c         	adds	r4, r3, r2
   6722e: 4419         	add	r1, r3
   67230: 9545         	str	r5, [sp, #0x114]
   67232: f8cd a110    	str.w	r10, [sp, #0x110]
   67236: 3208         	adds	r2, #0x8
   67238: edc1 1b00    	vstr	d17, [r1]
   6723c: eb03 010b    	add.w	r1, r3, r11
   67240: edd4 1b00    	vldr	d17, [r4]
   67244: eb03 0409    	add.w	r4, r3, r9
   67248: f8dd a134    	ldr.w	r10, [sp, #0x134]
   6724c: f109 0908    	add.w	r9, r9, #0x8
   67250: edc1 1b00    	vstr	d17, [r1]
   67254: 1819         	adds	r1, r3, r0
   67256: edd4 1b00    	vldr	d17, [r4]
   6725a: f10b 0b08    	add.w	r11, r11, #0x8
   6725e: 9849         	ldr	r0, [sp, #0x124]
   67260: edc1 1b00    	vstr	d17, [r1]
   67264: 1819         	adds	r1, r3, r0
   67266: 3008         	adds	r0, #0x8
   67268: 9049         	str	r0, [sp, #0x124]
   6726a: edd1 1b00    	vldr	d17, [r1]
   6726e: 9862         	ldr	r0, [sp, #0x188]
   67270: ed41 1b02    	vstr	d17, [r1, #-8]
   67274: 1959         	adds	r1, r3, r5
   67276: 9d50         	ldr	r5, [sp, #0x140]
   67278: 3008         	adds	r0, #0x8
   6727a: 9062         	str	r0, [sp, #0x188]
   6727c: 195c         	adds	r4, r3, r5
   6727e: 9856         	ldr	r0, [sp, #0x158]
   67280: 3508         	adds	r5, #0x8
   67282: f8cd e12c    	str.w	lr, [sp, #0x12c]
   67286: edd4 1b00    	vldr	d17, [r4]
   6728a: eb03 040a    	add.w	r4, r3, r10
   6728e: 3008         	adds	r0, #0x8
   67290: 9056         	str	r0, [sp, #0x158]
   67292: edc1 1b00    	vstr	d17, [r1]
   67296: f10a 0a08    	add.w	r10, r10, #0x8
   6729a: 995b         	ldr	r1, [sp, #0x16c]
   6729c: edd4 1b00    	vldr	d17, [r4]
   672a0: 4419         	add	r1, r3
   672a2: 9858         	ldr	r0, [sp, #0x160]
   672a4: f8dd e118    	ldr.w	lr, [sp, #0x118]
   672a8: edc1 1b00    	vstr	d17, [r1]
   672ac: 3008         	adds	r0, #0x8
   672ae: 9954         	ldr	r1, [sp, #0x150]
   672b0: f10e 0e08    	add.w	lr, lr, #0x8
   672b4: 9058         	str	r0, [sp, #0x160]
   672b6: 3108         	adds	r1, #0x8
   672b8: 9154         	str	r1, [sp, #0x150]
   672ba: 9963         	ldr	r1, [sp, #0x18c]
   672bc: 985c         	ldr	r0, [sp, #0x170]
   672be: 3108         	adds	r1, #0x8
   672c0: 9163         	str	r1, [sp, #0x18c]
   672c2: 995e         	ldr	r1, [sp, #0x178]
   672c4: 3008         	adds	r0, #0x8
   672c6: 9c40         	ldr	r4, [sp, #0x100]
   672c8: 3108         	adds	r1, #0x8
   672ca: 915e         	str	r1, [sp, #0x178]
   672cc: 9960         	ldr	r1, [sp, #0x180]
   672ce: 3408         	adds	r4, #0x8
   672d0: 964e         	str	r6, [sp, #0x138]
   672d2: 9e41         	ldr	r6, [sp, #0x104]
   672d4: 3108         	adds	r1, #0x8
   672d6: 9247         	str	r2, [sp, #0x11c]
   672d8: 9a3f         	ldr	r2, [sp, #0xfc]
   672da: 3608         	adds	r6, #0x8
   672dc: f8cd 913c    	str.w	r9, [sp, #0x13c]
   672e0: f8dd 90f8    	ldr.w	r9, [sp, #0xf8]
   672e4: 3208         	adds	r2, #0x8
   672e6: 9550         	str	r5, [sp, #0x140]
   672e8: 9d45         	ldr	r5, [sp, #0x114]
   672ea: f109 0908    	add.w	r9, r9, #0x8
   672ee: f8cd a134    	str.w	r10, [sp, #0x134]
   672f2: f8dd a110    	ldr.w	r10, [sp, #0x110]
   672f6: 3508         	adds	r5, #0x8
   672f8: f8cd 8128    	str.w	r8, [sp, #0x128]
   672fc: f8cd c130    	str.w	r12, [sp, #0x130]
   67300: f10a 0a08    	add.w	r10, r10, #0x8
   67304: e9dd c842    	ldrd	r12, r8, [sp, #264]
   67308: 905c         	str	r0, [sp, #0x170]
   6730a: f108 0808    	add.w	r8, r8, #0x8
   6730e: 9855         	ldr	r0, [sp, #0x154]
   67310: f10c 0c08    	add.w	r12, r12, #0x8
   67314: 9160         	str	r1, [sp, #0x180]
   67316: 995b         	ldr	r1, [sp, #0x16c]
   67318: 3008         	adds	r0, #0x8
   6731a: f8cd b120    	str.w	r11, [sp, #0x120]
   6731e: 3108         	adds	r1, #0x8
   67320: 9055         	str	r0, [sp, #0x154]
   67322: 915b         	str	r1, [sp, #0x16c]
   67324: e706         	b	0x67134 <check_error+0xaac> @ imm = #-0x1f4
   67326: 4ddf         	ldr	r5, [pc, #0x37c]        @ 0x676a4 <check_error+0x101c>
   67328: 2000         	movs	r0, #0x0
   6732a: 9a38         	ldr	r2, [sp, #0xe0]
   6732c: 9b2b         	ldr	r3, [sp, #0xac]
   6732e: 993c         	ldr	r1, [sp, #0xf0]
   67330: e9c2 0548    	strd	r0, r5, [r2, #288]
   67334: 9a3a         	ldr	r2, [sp, #0xe8]
   67336: e9c3 0548    	strd	r0, r5, [r3, #288]
   6733a: e9c3 0590    	strd	r0, r5, [r3, #576]
   6733e: e9c2 0592    	strd	r0, r5, [r2, #584]
   67342: 9a31         	ldr	r2, [sp, #0xc4]
   67344: e9c3 05d8    	strd	r0, r5, [r3, #864]
   67348: 9b37         	ldr	r3, [sp, #0xdc]
   6734a: e9c2 0548    	strd	r0, r5, [r2, #288]
   6734e: e9c2 0590    	strd	r0, r5, [r2, #576]
   67352: e9c2 0500    	strd	r0, r5, [r2]
   67356: 9a32         	ldr	r2, [sp, #0xc8]
   67358: e9c3 054e    	strd	r0, r5, [r3, #312]
   6735c: 9b33         	ldr	r3, [sp, #0xcc]
   6735e: e9c2 059a    	strd	r0, r5, [r2, #616]
   67362: e9c2 05e2    	strd	r0, r5, [r2, #904]
   67366: e9c2 0552    	strd	r0, r5, [r2, #328]
   6736a: 9a30         	ldr	r2, [sp, #0xc0]
   6736c: edc1 0be8    	vstr	d16, [r1, #928]
   67370: ed91 0aea    	vldr	s0, [r1, #936]
   67374: 9952         	ldr	r1, [sp, #0x148]
   67376: e9c3 0502    	strd	r0, r5, [r3, #8]
   6737a: eef8 0b40    	vcvt.f64.u32	d16, s0
   6737e: e9c2 05d8    	strd	r0, r5, [r2, #864]
   67382: f44f 33d7    	mov.w	r3, #0x1ae00
   67386: f8dd a14c    	ldr.w	r10, [sp, #0x14c]
   6738a: ed91 0a01    	vldr	s0, [r1, #4]
   6738e: ed9f fbc6    	vldr	d15, [pc, #792]         @ 0x676a8 <check_error+0x1020>
   67392: eef8 1b40    	vcvt.f64.u32	d17, s0
   67396: 992e         	ldr	r1, [sp, #0xb8]
   67398: e9c2 0590    	strd	r0, r5, [r2, #576]
   6739c: e9c2 0548    	strd	r0, r5, [r2, #288]
   673a0: 9a53         	ldr	r2, [sp, #0x14c]
   673a2: ee71 0be0    	vsub.f64	d16, d17, d16
   673a6: eec0 0b8f    	vdiv.f64	d16, d16, d15
   673aa: edc1 0b0c    	vstr	d16, [r1, #48]
   673ae: 9934         	ldr	r1, [sp, #0xd0]
   673b0: e9c1 0548    	strd	r0, r5, [r1, #288]
   673b4: f64c 10c0    	movw	r0, #0xc9c0
   673b8: 1811         	adds	r1, r2, r0
   673ba: 9162         	str	r1, [sp, #0x188]
   673bc: 49bc         	ldr	r1, [pc, #0x2f0]        @ 0x676b0 <check_error+0x1028>
   673be: 4411         	add	r1, r2
   673c0: 9163         	str	r1, [sp, #0x18c]
   673c2: 4936         	ldr	r1, [pc, #0xd8]         @ 0x6749c <check_error+0xe14>
   673c4: f64f 1220    	movw	r2, #0xf920
   673c8: f501 5ef5    	add.w	lr, r1, #0x1ea0
   673cc: f501 785a    	add.w	r8, r1, #0x368
   673d0: 492d         	ldr	r1, [pc, #0xb4]         @ 0x67488 <check_error+0xe00>
   673d2: f501 69d9    	add.w	r9, r1, #0x6c8
   673d6: f501 6bd8    	add.w	r11, r1, #0x6c0
   673da: 492e         	ldr	r1, [pc, #0xb8]         @ 0x67494 <check_error+0xe0c>
   673dc: f501 76a0    	add.w	r6, r1, #0x140
   673e0: f501 719c    	add.w	r1, r1, #0x138
   673e4: 4cb3         	ldr	r4, [pc, #0x2cc]        @ 0x676b4 <check_error+0x102c>
   673e6: 42a3         	cmp	r3, r4
   673e8: d05e         	beq	0x674a8 <check_error+0xe20> @ imm = #0xbc
   673ea: eb0a 0400    	add.w	r4, r10, r0
   673ee: eb0a 0509    	add.w	r5, r10, r9
   673f2: f8dd c144    	ldr.w	r12, [sp, #0x144]
   673f6: f109 0908    	add.w	r9, r9, #0x8
   673fa: edd4 0b02    	vldr	d16, [r4, #8]
   673fe: edc4 0b00    	vstr	d16, [r4]
   67402: eb0a 0402    	add.w	r4, r10, r2
   67406: 3208         	adds	r2, #0x8
   67408: edd4 0b02    	vldr	d16, [r4, #8]
   6740c: edc4 0b00    	vstr	d16, [r4]
   67410: eb0a 040b    	add.w	r4, r10, r11
   67414: edd5 0b00    	vldr	d16, [r5]
   67418: f10b 0b08    	add.w	r11, r11, #0x8
   6741c: 9d62         	ldr	r5, [sp, #0x188]
   6741e: edc4 0b00    	vstr	d16, [r4]
   67422: eb0a 0408    	add.w	r4, r10, r8
   67426: 4405         	add	r5, r0
   67428: f108 0808    	add.w	r8, r8, #0x8
   6742c: edd4 0b02    	vldr	d16, [r4, #8]
   67430: edc4 0b00    	vstr	d16, [r4]
   67434: 9c63         	ldr	r4, [sp, #0x18c]
   67436: ed55 0b70    	vldr	d16, [r5, #-448]
   6743a: eb0a 0506    	add.w	r5, r10, r6
   6743e: 4404         	add	r4, r0
   67440: 3608         	adds	r6, #0x8
   67442: f5a4 4466    	sub.w	r4, r4, #0xe600
   67446: 3008         	adds	r0, #0x8
   67448: edc4 0b00    	vstr	d16, [r4]
   6744c: eb0a 0403    	add.w	r4, r10, r3
   67450: 3308         	adds	r3, #0x8
   67452: edd4 0b00    	vldr	d16, [r4]
   67456: ed44 0b02    	vstr	d16, [r4, #-8]
   6745a: eb0a 0401    	add.w	r4, r10, r1
   6745e: edd5 0b00    	vldr	d16, [r5]
   67462: eb0a 050c    	add.w	r5, r10, r12
   67466: f10c 0c08    	add.w	r12, r12, #0x8
   6746a: f8cd c144    	str.w	r12, [sp, #0x144]
   6746e: edc4 0b00    	vstr	d16, [r4]
   67472: eb0a 040e    	add.w	r4, r10, lr
   67476: edd5 0b00    	vldr	d16, [r5]
   6747a: 3108         	adds	r1, #0x8
   6747c: 4d89         	ldr	r5, [pc, #0x224]        @ 0x676a4 <check_error+0x101c>
   6747e: f10e 0e08    	add.w	lr, lr, #0x8
   67482: edc4 0b00    	vstr	d16, [r4]
   67486: e7ad         	b	0x673e4 <check_error+0xd5c> @ imm = #-0xa6
   67488: 98 31 01 00  	.word	0x00013198
   6748c: 38 8d 01 00  	.word	0x00018d38
   67490: 30 72 01 00  	.word	0x00017230
   67494: 50 15 01 00  	.word	0x00011550
   67498: e0 ac 01 00  	.word	0x0001ace0
   6749c: 88 53 01 00  	.word	0x00015388
   674a0: 08 c9 01 00  	.word	0x0001c908
   674a4: 2e cb 00 00  	.word	0x0000cb2e
   674a8: 9936         	ldr	r1, [sp, #0xd8]
   674aa: 2000         	movs	r0, #0x0
   674ac: 9c38         	ldr	r4, [sp, #0xe0]
   674ae: f8dd c0e8    	ldr.w	r12, [sp, #0xe8]
   674b2: e9c1 0500    	strd	r0, r5, [r1]
   674b6: 9937         	ldr	r1, [sp, #0xdc]
   674b8: f8dd e0c8    	ldr.w	lr, [sp, #0xc8]
   674bc: f8dd 914c    	ldr.w	r9, [sp, #0x14c]
   674c0: e9c1 0500    	strd	r0, r5, [r1]
   674c4: 9934         	ldr	r1, [sp, #0xd0]
   674c6: e9c4 0500    	strd	r0, r5, [r4]
   674ca: e9cc 0500    	strd	r0, r5, [r12]
   674ce: e9c1 0500    	strd	r0, r5, [r1]
   674d2: 9930         	ldr	r1, [sp, #0xc0]
   674d4: e9ce 0500    	strd	r0, r5, [lr]
   674d8: 4b77         	ldr	r3, [pc, #0x1dc]        @ 0x676b8 <check_error+0x1030>
   674da: e9c1 0500    	strd	r0, r5, [r1]
   674de: f24e 50f8    	movw	r0, #0xe5f8
   674e2: aa0a         	add	r2, sp, #0x28
   674e4: 4448         	add	r0, r9
   674e6: f502 5a67    	add.w	r10, r2, #0x39c0
   674ea: f44f 7110    	mov.w	r1, #0x240
   674ee: b131         	cbz	r1, 0x674fe <check_error+0xe76> @ imm = #0xc
   674f0: edd0 0b00    	vldr	d16, [r0]
   674f4: 3901         	subs	r1, #0x1
   674f6: ed40 0b02    	vstr	d16, [r0, #-8]
   674fa: 3008         	adds	r0, #0x8
   674fc: e7f7         	b	0x674ee <check_error+0xe66> @ imm = #-0x12
   674fe: 486f         	ldr	r0, [pc, #0x1bc]        @ 0x676bc <check_error+0x1034>
   67500: 2100         	movs	r1, #0x0
   67502: 4448         	add	r0, r9
   67504: f5b1 7f8c    	cmp.w	r1, #0x118
   67508: d010         	beq	0x6752c <check_error+0xea4> @ imm = #0x20
   6750a: eb09 0201    	add.w	r2, r9, r1
   6750e: 3108         	adds	r1, #0x8
   67510: f502 4278    	add.w	r2, r2, #0xf800
   67514: edd2 0b00    	vldr	d16, [r2]
   67518: f5a0 52e2    	sub.w	r2, r0, #0x1c40
   6751c: edc2 0b00    	vstr	d16, [r2]
   67520: edd0 0b00    	vldr	d16, [r0]
   67524: ed40 0b02    	vstr	d16, [r0, #-8]
   67528: 3008         	adds	r0, #0x8
   6752a: e7eb         	b	0x67504 <check_error+0xe7c> @ imm = #-0x2a
   6752c: 982f         	ldr	r0, [sp, #0xbc]
   6752e: 2400         	movs	r4, #0x0
   67530: edde 1be4    	vldr	d17, [lr, #912]
   67534: 9937         	ldr	r1, [sp, #0xdc]
   67536: edd0 0b4a    	vldr	d16, [r0, #296]
   6753a: e9c0 4500    	strd	r4, r5, [r0]
   6753e: e9c0 4548    	strd	r4, r5, [r0, #288]
   67542: e9c0 454a    	strd	r4, r5, [r0, #296]
   67546: 9831         	ldr	r0, [sp, #0xc4]
   67548: edcc 0b02    	vstr	d16, [r12, #8]
   6754c: edde 0b08    	vldr	d16, [lr, #32]
   67550: ed90 8b92    	vldr	d8, [r0, #584]
   67554: e9c0 4592    	strd	r4, r5, [r0, #584]
   67558: 9836         	ldr	r0, [sp, #0xd8]
   6755a: edce 0b0a    	vstr	d16, [lr, #40]
   6755e: ed9c 9b96    	vldr	d9, [r12, #600]
   67562: edd0 0b0a    	vldr	d16, [r0, #40]
   67566: edc0 1b02    	vstr	d17, [r0, #8]
   6756a: e9c0 4504    	strd	r4, r5, [r0, #16]
   6756e: e9c0 450a    	strd	r4, r5, [r0, #40]
   67572: edc0 0b0c    	vstr	d16, [r0, #48]
   67576: 9833         	ldr	r0, [sp, #0xcc]
   67578: e9cc 454a    	strd	r4, r5, [r12, #296]
   6757c: e9ce 4504    	strd	r4, r5, [lr, #16]
   67580: edd0 0b04    	vldr	d16, [r0, #16]
   67584: e9c0 4504    	strd	r4, r5, [r0, #16]
   67588: 983d         	ldr	r0, [sp, #0xf4]
   6758a: e9cc 4596    	strd	r4, r5, [r12, #600]
   6758e: ed8c 9b98    	vstr	d9, [r12, #608]
   67592: ed8e 8b02    	vstr	d8, [lr, #8]
   67596: e9ce 4508    	strd	r4, r5, [lr, #32]
   6759a: e9ce 45e4    	strd	r4, r5, [lr, #912]
   6759e: e9c1 4504    	strd	r4, r5, [r1, #16]
   675a2: edc1 0b02    	vstr	d16, [r1, #8]
   675a6: 4619         	mov	r1, r3
   675a8: f8b0 8700    	ldrh.w	r8, [r0, #0x700]
   675ac: 9e23         	ldr	r6, [sp, #0x8c]
   675ae: eba6 0008    	sub.w	r0, r6, r8
   675b2: b1a9         	cbz	r1, 0x675e0 <check_error+0xf58> @ imm = #0x2a
   675b4: eb09 0201    	add.w	r2, r9, r1
   675b8: 2300         	movs	r3, #0x0
   675ba: f8b2 2d0c    	ldrh.w	r2, [r2, #0xd0c]
   675be: 4290         	cmp	r0, r2
   675c0: bfb8         	it	lt
   675c2: 2301         	movlt	r3, #0x1
   675c4: 2a00         	cmp	r2, #0x0
   675c6: 4615         	mov	r5, r2
   675c8: bf18         	it	ne
   675ca: 2501         	movne	r5, #0x1
   675cc: 402b         	ands	r3, r5
   675ce: 42b2         	cmp	r2, r6
   675d0: f04f 0200    	mov.w	r2, #0x0
   675d4: bf98         	it	ls
   675d6: 2201         	movls	r2, #0x1
   675d8: 3102         	adds	r1, #0x2
   675da: 401a         	ands	r2, r3
   675dc: 4414         	add	r4, r2
   675de: e7e8         	b	0x675b2 <check_error+0xf2a> @ imm = #-0x30
   675e0: a80c         	add	r0, sp, #0x30
   675e2: f44f 7190    	mov.w	r1, #0x120
   675e6: f500 551f    	add.w	r5, r0, #0x27c0
   675ea: 4628         	mov	r0, r5
   675ec: f007 ed08    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7a10
   675f0: 4650         	mov	r0, r10
   675f2: f44f 7190    	mov.w	r1, #0x120
   675f6: f007 ed04    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7a08
   675fa: 9a53         	ldr	r2, [sp, #0x14c]
   675fc: fa1f f984    	uxth.w	r9, r4
   67600: f24c 0118    	movw	r1, #0xc018
   67604: ed9f eb2e    	vldr	d14, [pc, #184]         @ 0x676c0 <check_error+0x1038>
   67608: eba2 00c9    	sub.w	r0, r2, r9, lsl #3
   6760c: 46ac         	mov	r12, r5
   6760e: 4408         	add	r0, r1
   67610: f5c9 7190    	rsb.w	r1, r9, #0x120
   67614: 2501         	movs	r5, #0x1
   67616: 464b         	mov	r3, r9
   67618: eb02 01c1    	add.w	r1, r2, r1, lsl #3
   6761c: f244 22f8    	movw	r2, #0x42f8
   67620: 4411         	add	r1, r2
   67622: 2200         	movs	r2, #0x0
   67624: b1eb         	cbz	r3, 0x67662 <check_error+0xfda> @ imm = #0x3a
   67626: b2d6         	uxtb	r6, r2
   67628: ecf0 0b02    	vldmia	r0!, {d16}
   6762c: eb0c 04c6    	add.w	r4, r12, r6, lsl #3
   67630: ecf1 1b02    	vldmia	r1!, {d17}
   67634: edc4 0b00    	vstr	d16, [r4]
   67638: eb0a 04c6    	add.w	r4, r10, r6, lsl #3
   6763c: edc4 1b00    	vstr	d17, [r4]
   67640: eef0 1be0    	vabs.f64	d17, d16
   67644: eef4 1b4e    	vcmp.f64	d17, d14
   67648: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6764c: bf08         	it	eq
   6764e: 2500         	moveq	r5, #0x0
   67650: eef4 0b60    	vcmp.f64	d16, d16
   67654: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   67658: bf68         	it	vs
   6765a: 2500         	movvs	r5, #0x0
   6765c: 3b01         	subs	r3, #0x1
   6765e: 3201         	adds	r2, #0x1
   67660: e7e0         	b	0x67624 <check_error+0xf9c> @ imm = #-0x40
   67662: ae66         	add	r6, sp, #0x198
   67664: f44f 7190    	mov.w	r1, #0x120
   67668: 4630         	mov	r0, r6
   6766a: f007 ecca    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7994
   6766e: a802         	add	r0, sp, #0x8
   67670: f44f 7190    	mov.w	r1, #0x120
   67674: f500 50c9    	add.w	r0, r0, #0x1920
   67678: f007 ecc2    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7984
   6767c: 45c1         	cmp	r9, r8
   6767e: bf04         	itt	eq
   67680: b2e8         	uxtbeq	r0, r5
   67682: 2801         	cmpeq	r0, #0x1
   67684: d028         	beq	0x676d8 <check_error+0x1050> @ imm = #0x50
   67686: ed9f ab10    	vldr	d10, [pc, #64]          @ 0x676c8 <check_error+0x1040>
   6768a: 2000         	movs	r0, #0x0
   6768c: 4905         	ldr	r1, [pc, #0x14]         @ 0x676a4 <check_error+0x101c>
   6768e: ef2a 011a    	vorr	d0, d10, d10
   67692: 9e38         	ldr	r6, [sp, #0xe0]
   67694: 9d3d         	ldr	r5, [sp, #0xf4]
   67696: 9c3a         	ldr	r4, [sp, #0xe8]
   67698: f8dd 90c8    	ldr.w	r9, [sp, #0xc8]
   6769c: e9c6 0100    	strd	r0, r1, [r6]
   676a0: e059         	b	0x67756 <check_error+0x10ce> @ imm = #0xb2
   676a2: bf00         	nop
   676a4: 00 00 f8 7f  	.word	0x7ff80000
   676a8: 00 00 00 00  	.word	0x00000000
   676ac: 00 00 4e 40  	.word	0x404e0000
   676b0: f8 ad 01 00  	.word	0x0001adf8
   676b4: 00 c9 01 00  	.word	0x0001c900
   676b8: 3e f9 ff ff  	.word	0xfffff93e
   676bc: 38 14 01 00  	.word	0x00011438
   676c0: 00 00 00 00  	.word	0x00000000
   676c4: 00 00 f0 7f  	.word	0x7ff00000
   676c8: 00 00 00 00  	.word	0x00000000
   676cc: 00 00 f8 7f  	.word	0x7ff80000
   676d0: 00 00 00 00  	.word	0x00000000
   676d4: 00 00 59 40  	.word	0x40590000
   676d8: a80c         	add	r0, sp, #0x30
   676da: 4641         	mov	r1, r8
   676dc: f500 501f    	add.w	r0, r0, #0x27c0
   676e0: 4632         	mov	r2, r6
   676e2: f006 f82d    	bl	0x6d740 <smooth1q_err16> @ imm = #0x605a
   676e6: 983b         	ldr	r0, [sp, #0xec]
   676e8: ed5f 1b07    	vldr	d17, [pc, #-28]         @ 0x676d0 <check_error+0x1048>
   676ec: 9d3d         	ldr	r5, [sp, #0xf4]
   676ee: f8d0 0005    	ldr.w	r0, [r0, #0x5]
   676f2: f8b5 4700    	ldrh.w	r4, [r5, #0x700]
   676f6: ee00 0a10    	vmov	s0, r0
   676fa: eef7 0ac0    	vcvt.f64.f32	d16, s0
   676fe: eb06 00c4    	add.w	r0, r6, r4, lsl #3
   67702: eec0 0ba1    	vdiv.f64	d16, d16, d17
   67706: edd5 1b00    	vldr	d17, [r5]
   6770a: ee61 0ba0    	vmul.f64	d16, d17, d16
   6770e: ed50 1b02    	vldr	d17, [r0, #-8]
   67712: ee81 0ba0    	vdiv.f64	d0, d17, d16
   67716: f005 f81f    	bl	0x6c758 <math_round>    @ imm = #0x503e
   6771a: 9e38         	ldr	r6, [sp, #0xe0]
   6771c: 4621         	mov	r1, r4
   6771e: ed86 0b00    	vstr	d0, [r6]
   67722: a80a         	add	r0, sp, #0x28
   67724: aa02         	add	r2, sp, #0x8
   67726: f500 5067    	add.w	r0, r0, #0x39c0
   6772a: f502 54c9    	add.w	r4, r2, #0x1920
   6772e: 4622         	mov	r2, r4
   67730: f006 f806    	bl	0x6d740 <smooth1q_err16> @ imm = #0x600c
   67734: f8b5 0700    	ldrh.w	r0, [r5, #0x700]
   67738: eb04 00c0    	add.w	r0, r4, r0, lsl #3
   6773c: ed10 0b02    	vldr	d0, [r0, #-8]
   67740: f005 f80a    	bl	0x6c758 <math_round>    @ imm = #0x5014
   67744: f8dd 90c8    	ldr.w	r9, [sp, #0xc8]
   67748: 9c3a         	ldr	r4, [sp, #0xe8]
   6774a: ed99 8b02    	vldr	d8, [r9, #8]
   6774e: ed99 ab04    	vldr	d10, [r9, #16]
   67752: ed94 9b98    	vldr	d9, [r4, #608]
   67756: ed86 0b48    	vstr	d0, [r6, #288]
   6775a: a806         	add	r0, sp, #0x18
   6775c: f500 50a1    	add.w	r0, r0, #0x1420
   67760: 21b0         	movs	r1, #0xb0
   67762: f007 ec4e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x789c
   67766: 9a53         	ldr	r2, [sp, #0x14c]
   67768: a902         	add	r1, sp, #0x8
   6776a: 48fc         	ldr	r0, [pc, #0x3f0]        @ 0x67b5c <check_error+0x14d4>
   6776c: f501 5180    	add.w	r1, r1, #0x1000
   67770: f50d 56a2    	add.w	r6, sp, #0x1440
   67774: f8dd a0c4    	ldr.w	r10, [sp, #0xc4]
   67778: 4410         	add	r0, r2
   6777a: f8c1 0450    	str.w	r0, [r1, #0x450]
   6777e: 48f8         	ldr	r0, [pc, #0x3e0]        @ 0x67b60 <check_error+0x14d8>
   67780: f505 6ee8    	add.w	lr, r5, #0x740
   67784: edd4 0b94    	vldr	d16, [r4, #592]
   67788: f04f 0b00    	mov.w	r11, #0x0
   6778c: 4410         	add	r0, r2
   6778e: 60b0         	str	r0, [r6, #0x8]
   67790: f8d5 0708    	ldr.w	r0, [r5, #0x708]
   67794: 905b         	str	r0, [sp, #0x16c]
   67796: f8d5 070c    	ldr.w	r0, [r5, #0x70c]
   6779a: 9058         	str	r0, [sp, #0x160]
   6779c: f8d5 0710    	ldr.w	r0, [r5, #0x710]
   677a0: 9062         	str	r0, [sp, #0x188]
   677a2: f8d5 0714    	ldr.w	r0, [r5, #0x714]
   677a6: 9056         	str	r0, [sp, #0x158]
   677a8: f8d5 0718    	ldr.w	r0, [r5, #0x718]
   677ac: 9055         	str	r0, [sp, #0x154]
   677ae: f8d5 071c    	ldr.w	r0, [r5, #0x71c]
   677b2: 9054         	str	r0, [sp, #0x150]
   677b4: f8d5 0720    	ldr.w	r0, [r5, #0x720]
   677b8: 9051         	str	r0, [sp, #0x144]
   677ba: f8d5 0724    	ldr.w	r0, [r5, #0x724]
   677be: 9050         	str	r0, [sp, #0x140]
   677c0: f8d5 0730    	ldr.w	r0, [r5, #0x730]
   677c4: 4be7         	ldr	r3, [pc, #0x39c]        @ 0x67b64 <check_error+0x14dc>
   677c6: 904f         	str	r0, [sp, #0x13c]
   677c8: f8d5 0734    	ldr.w	r0, [r5, #0x734]
   677cc: f8b5 1752    	ldrh.w	r1, [r5, #0x752]
   677d0: edc6 0b04    	vstr	d16, [r6, #16]
   677d4: edda 0b46    	vldr	d16, [r10, #280]
   677d8: edda 1b8e    	vldr	d17, [r10, #568]
   677dc: 904e         	str	r0, [sp, #0x138]
   677de: f8b5 0754    	ldrh.w	r0, [r5, #0x754]
   677e2: e89e 5110    	ldm.w	lr, {r4, r8, r12, lr}
   677e6: f8b5 2750    	ldrh.w	r2, [r5, #0x750]
   677ea: 9160         	str	r1, [sp, #0x180]
   677ec: ea42 4101    	orr.w	r1, r2, r1, lsl #16
   677f0: ed86 9b00    	vstr	d9, [r6]
   677f4: ed86 8b0a    	vstr	d8, [r6, #40]
   677f8: edc6 0b0e    	vstr	d16, [r6, #56]
   677fc: 905e         	str	r0, [sp, #0x178]
   677fe: f8c6 b080    	str.w	r11, [r6, #0x80]
   67802: e9c6 3b21    	strd	r3, r11, [r6, #132]
   67806: e9c6 3b23    	strd	r3, r11, [r6, #140]
   6780a: e9c6 3b25    	strd	r3, r11, [r6, #148]
   6780e: f8c6 309c    	str.w	r3, [r6, #0x9c]
   67812: e9c6 b308    	strd	r11, r3, [r6, #32]
   67816: 2300         	movs	r3, #0x0
   67818: ed86 ab16    	vstr	d10, [r6, #88]
   6781c: edc6 1b12    	vstr	d17, [r6, #72]
   67820: 915c         	str	r1, [sp, #0x170]
   67822: aa08         	add	r2, sp, #0x20
   67824: e882 5110    	stm.w	r2, {r4, r8, r12, lr}
   67828: e9cd 100c    	strd	r1, r0, [sp, #48]
   6782c: a806         	add	r0, sp, #0x18
   6782e: f500 50a1    	add.w	r0, r0, #0x1420
   67832: e9cd 030e    	strd	r0, r3, [sp, #56]
   67836: 9862         	ldr	r0, [sp, #0x188]
   67838: 9000         	str	r0, [sp]
   6783a: 9856         	ldr	r0, [sp, #0x158]
   6783c: 9001         	str	r0, [sp, #0x4]
   6783e: 9855         	ldr	r0, [sp, #0x154]
   67840: 9002         	str	r0, [sp, #0x8]
   67842: 9854         	ldr	r0, [sp, #0x150]
   67844: 9003         	str	r0, [sp, #0xc]
   67846: 9851         	ldr	r0, [sp, #0x144]
   67848: 9004         	str	r0, [sp, #0x10]
   6784a: 9850         	ldr	r0, [sp, #0x140]
   6784c: 9005         	str	r0, [sp, #0x14]
   6784e: 984f         	ldr	r0, [sp, #0x13c]
   67850: 9006         	str	r0, [sp, #0x18]
   67852: 984e         	ldr	r0, [sp, #0x138]
   67854: 9007         	str	r0, [sp, #0x1c]
   67856: 49c4         	ldr	r1, [pc, #0x310]        @ 0x67b68 <check_error+0x14e0>
   67858: f8dd 814c    	ldr.w	r8, [sp, #0x14c]
   6785c: 9a5b         	ldr	r2, [sp, #0x16c]
   6785e: 4479         	add	r1, pc
   67860: 9b58         	ldr	r3, [sp, #0x160]
   67862: 4640         	mov	r0, r8
   67864: 9162         	str	r1, [sp, #0x188]
   67866: 4788         	blx	r1
   67868: 983a         	ldr	r0, [sp, #0xe8]
   6786a: f106 0180    	add.w	r1, r6, #0x80
   6786e: ed56 0b02    	vldr	d16, [r6, #-8]
   67872: 2200         	movs	r2, #0x0
   67874: edd6 1b04    	vldr	d17, [r6, #16]
   67878: edc0 0b96    	vstr	d16, [r0, #600]
   6787c: edc0 1b94    	vstr	d17, [r0, #592]
   67880: 982b         	ldr	r0, [sp, #0xac]
   67882: edd6 2b0c    	vldr	d18, [r6, #48]
   67886: edd6 3b10    	vldr	d19, [r6, #64]
   6788a: edc0 0b00    	vstr	d16, [r0]
   6788e: edca 2b48    	vstr	d18, [r10, #288]
   67892: edca 3b90    	vstr	d19, [r10, #576]
   67896: ecf1 0b08    	vldmia	r1!, {d16, d17, d18, d19}
   6789a: edc0 1b90    	vstr	d17, [r0, #576]
   6789e: edc0 0b48    	vstr	d16, [r0, #288]
   678a2: edc0 2bd8    	vstr	d18, [r0, #864]
   678a6: 69b0         	ldr	r0, [r6, #0x18]
   678a8: edca 3b00    	vstr	d19, [r10]
   678ac: f500 50d8    	add.w	r0, r0, #0x1b00
   678b0: f8dd b0d8    	ldr.w	r11, [sp, #0xd8]
   678b4: 49ab         	ldr	r1, [pc, #0x2ac]        @ 0x67b64 <check_error+0x14dc>
   678b6: edd0 0b00    	vldr	d16, [r0]
   678ba: 4cac         	ldr	r4, [pc, #0x2b0]        @ 0x67b6c <check_error+0x14e4>
   678bc: edc9 0b00    	vstr	d16, [r9]
   678c0: edd6 0b08    	vldr	d16, [r6, #32]
   678c4: 4444         	add	r4, r8
   678c6: e9c6 2108    	strd	r2, r1, [r6, #32]
   678ca: 2202         	movs	r2, #0x2
   678cc: edca 0b92    	vstr	d16, [r10, #584]
   678d0: edd6 0b16    	vldr	d16, [r6, #88]
   678d4: eddb 1b04    	vldr	d17, [r11, #16]
   678d8: edc9 0b04    	vstr	d16, [r9, #16]
   678dc: f8d5 0790    	ldr.w	r0, [r5, #0x790]
   678e0: edd9 0b06    	vldr	d16, [r9, #24]
   678e4: 905b         	str	r0, [sp, #0x16c]
   678e6: f8d5 0794    	ldr.w	r0, [r5, #0x794]
   678ea: 9058         	str	r0, [sp, #0x160]
   678ec: f8d5 0798    	ldr.w	r0, [r5, #0x798]
   678f0: edc6 0b04    	vstr	d16, [r6, #16]
   678f4: edd9 0b0a    	vldr	d16, [r9, #40]
   678f8: 9056         	str	r0, [sp, #0x158]
   678fa: f8d5 079c    	ldr.w	r0, [r5, #0x79c]
   678fe: 9055         	str	r0, [sp, #0x154]
   67900: f8d5 07a0    	ldr.w	r0, [r5, #0x7a0]
   67904: edc6 0b00    	vstr	d16, [r6]
   67908: eddb 0b02    	vldr	d16, [r11, #8]
   6790c: 9054         	str	r0, [sp, #0x150]
   6790e: f8d5 07a4    	ldr.w	r0, [r5, #0x7a4]
   67912: 9051         	str	r0, [sp, #0x144]
   67914: f8d5 07b0    	ldr.w	r0, [r5, #0x7b0]
   67918: edc6 0b0a    	vstr	d16, [r6, #40]
   6791c: edd9 0b98    	vldr	d16, [r9, #608]
   67920: 9050         	str	r0, [sp, #0x140]
   67922: f8d5 07b4    	ldr.w	r0, [r5, #0x7b4]
   67926: f8d5 e7c4    	ldr.w	lr, [r5, #0x7c4]
   6792a: f8d5 37cc    	ldr.w	r3, [r5, #0x7cc]
   6792e: 904f         	str	r0, [sp, #0x13c]
   67930: f8d5 07b8    	ldr.w	r0, [r5, #0x7b8]
   67934: edc6 0b0e    	vstr	d16, [r6, #56]
   67938: edd9 0be0    	vldr	d16, [r9, #896]
   6793c: 995c         	ldr	r1, [sp, #0x170]
   6793e: 904e         	str	r0, [sp, #0x138]
   67940: f8d5 07bc    	ldr.w	r0, [r5, #0x7bc]
   67944: f8d5 c7c0    	ldr.w	r12, [r5, #0x7c0]
   67948: f8d5 a7c8    	ldr.w	r10, [r5, #0x7c8]
   6794c: 910c         	str	r1, [sp, #0x30]
   6794e: 995e         	ldr	r1, [sp, #0x178]
   67950: 904d         	str	r0, [sp, #0x134]
   67952: 61b4         	str	r4, [r6, #0x18]
   67954: edc6 0b12    	vstr	d16, [r6, #72]
   67958: edc6 1b16    	vstr	d17, [r6, #88]
   6795c: e9cd ce08    	strd	r12, lr, [sp, #32]
   67960: e9cd a30a    	strd	r10, r3, [sp, #40]
   67964: 910d         	str	r1, [sp, #0x34]
   67966: a806         	add	r0, sp, #0x18
   67968: f500 51a1    	add.w	r1, r0, #0x1420
   6796c: e9cd 120e    	strd	r1, r2, [sp, #56]
   67970: 9956         	ldr	r1, [sp, #0x158]
   67972: 4640         	mov	r0, r8
   67974: 9100         	str	r1, [sp]
   67976: 9955         	ldr	r1, [sp, #0x154]
   67978: 9101         	str	r1, [sp, #0x4]
   6797a: 9954         	ldr	r1, [sp, #0x150]
   6797c: 9102         	str	r1, [sp, #0x8]
   6797e: 9951         	ldr	r1, [sp, #0x144]
   67980: 9103         	str	r1, [sp, #0xc]
   67982: 9950         	ldr	r1, [sp, #0x140]
   67984: 9104         	str	r1, [sp, #0x10]
   67986: 994f         	ldr	r1, [sp, #0x13c]
   67988: 9105         	str	r1, [sp, #0x14]
   6798a: 994e         	ldr	r1, [sp, #0x138]
   6798c: 9106         	str	r1, [sp, #0x18]
   6798e: 994d         	ldr	r1, [sp, #0x134]
   67990: 9107         	str	r1, [sp, #0x1c]
   67992: 9a5b         	ldr	r2, [sp, #0x16c]
   67994: 9b58         	ldr	r3, [sp, #0x160]
   67996: 9962         	ldr	r1, [sp, #0x188]
   67998: 4788         	blx	r1
   6799a: ed56 0b02    	vldr	d16, [r6, #-8]
   6799e: 46c4         	mov	r12, r8
   679a0: 69b0         	ldr	r0, [r6, #0x18]
   679a2: edd6 1b04    	vldr	d17, [r6, #16]
   679a6: edc9 0b08    	vstr	d16, [r9, #32]
   679aa: f500 50d8    	add.w	r0, r0, #0x1b00
   679ae: edd6 0b14    	vldr	d16, [r6, #80]
   679b2: edc9 1b06    	vstr	d17, [r9, #24]
   679b6: edc9 0b52    	vstr	d16, [r9, #328]
   679ba: edd0 0b00    	vldr	d16, [r0]
   679be: 4a6c         	ldr	r2, [pc, #0x1b0]        @ 0x67b70 <check_error+0x14e8>
   679c0: edd6 2b08    	vldr	d18, [r6, #32]
   679c4: edd6 3b0c    	vldr	d19, [r6, #48]
   679c8: 4442         	add	r2, r8
   679ca: edd6 1b16    	vldr	d17, [r6, #88]
   679ce: edcb 0b00    	vstr	d16, [r11]
   679d2: edd6 0b10    	vldr	d16, [r6, #64]
   679d6: 61b2         	str	r2, [r6, #0x18]
   679d8: edc9 0be2    	vstr	d16, [r9, #904]
   679dc: 9a63         	ldr	r2, [sp, #0x18c]
   679de: edcb 1b04    	vstr	d17, [r11, #16]
   679e2: edc9 3b9a    	vstr	d19, [r9, #616]
   679e6: edc9 2be4    	vstr	d18, [r9, #912]
   679ea: f8d5 07d0    	ldr.w	r0, [r5, #0x7d0]
   679ee: 66b2         	str	r2, [r6, #0x68]
   679f0: 4a60         	ldr	r2, [pc, #0x180]        @ 0x67b74 <check_error+0x14ec>
   679f2: 904f         	str	r0, [sp, #0x13c]
   679f4: f8d5 07d4    	ldr.w	r0, [r5, #0x7d4]
   679f8: 4442         	add	r2, r8
   679fa: 4b5a         	ldr	r3, [pc, #0x168]        @ 0x67b64 <check_error+0x14dc>
   679fc: 905e         	str	r0, [sp, #0x178]
   679fe: f8d5 07d8    	ldr.w	r0, [r5, #0x7d8]
   67a02: eddb 0b08    	vldr	d16, [r11, #32]
   67a06: f8dd a0dc    	ldr.w	r10, [sp, #0xdc]
   67a0a: 905c         	str	r0, [sp, #0x170]
   67a0c: f8d5 07dc    	ldr.w	r0, [r5, #0x7dc]
   67a10: 60b2         	str	r2, [r6, #0x8]
   67a12: 2200         	movs	r2, #0x0
   67a14: 905b         	str	r0, [sp, #0x16c]
   67a16: f8d5 07e0    	ldr.w	r0, [r5, #0x7e0]
   67a1a: edc6 0b04    	vstr	d16, [r6, #16]
   67a1e: eddb 0b0c    	vldr	d16, [r11, #48]
   67a22: e9c6 2324    	strd	r2, r3, [r6, #144]
   67a26: e9c6 231c    	strd	r2, r3, [r6, #112]
   67a2a: e9c6 231e    	strd	r2, r3, [r6, #120]
   67a2e: e9c6 2320    	strd	r2, r3, [r6, #128]
   67a32: e9c6 2322    	strd	r2, r3, [r6, #136]
   67a36: f10a 0208    	add.w	r2, r10, #0x8
   67a3a: 9058         	str	r0, [sp, #0x160]
   67a3c: f8d5 07e4    	ldr.w	r0, [r5, #0x7e4]
   67a40: 9056         	str	r0, [sp, #0x158]
   67a42: f8d5 07e8    	ldr.w	r0, [r5, #0x7e8]
   67a46: edc6 0b00    	vstr	d16, [r6]
   67a4a: ecf2 0b06    	vldmia	r2!, {d16, d17, d18}
   67a4e: f8dd 80c0    	ldr.w	r8, [sp, #0xc0]
   67a52: 904e         	str	r0, [sp, #0x138]
   67a54: f8d5 07f4    	ldr.w	r0, [r5, #0x7f4]
   67a58: 904d         	str	r0, [sp, #0x134]
   67a5a: f8d5 07f8    	ldr.w	r0, [r5, #0x7f8]
   67a5e: f8dd 90cc    	ldr.w	r9, [sp, #0xcc]
   67a62: 9055         	str	r0, [sp, #0x154]
   67a64: f8d5 07fc    	ldr.w	r0, [r5, #0x7fc]
   67a68: edc6 0b0a    	vstr	d16, [r6, #40]
   67a6c: edd8 0bd6    	vldr	d16, [r8, #856]
   67a70: 9054         	str	r0, [sp, #0x150]
   67a72: f8d5 0800    	ldr.w	r0, [r5, #0x800]
   67a76: 9051         	str	r0, [sp, #0x144]
   67a78: f8d5 0804    	ldr.w	r0, [r5, #0x804]
   67a7c: edc6 0b0e    	vstr	d16, [r6, #56]
   67a80: edd9 0b00    	vldr	d16, [r9]
   67a84: 9050         	str	r0, [sp, #0x140]
   67a86: f8b5 0818    	ldrh.w	r0, [r5, #0x818]
   67a8a: f8d5 e7ec    	ldr.w	lr, [r5, #0x7ec]
   67a8e: f8d5 47f0    	ldr.w	r4, [r5, #0x7f0]
   67a92: f8b5 181a    	ldrh.w	r1, [r5, #0x81a]
   67a96: edc6 0b12    	vstr	d16, [r6, #72]
   67a9a: f89b 2018    	ldrb.w	r2, [r11, #0x18]
   67a9e: f847 0c64    	str	r0, [r7, #-100]
   67aa2: f50d 5080    	add.w	r0, sp, #0x1000
   67aa6: f880 24e0    	strb.w	r2, [r0, #0x4e0]
   67aaa: 2200         	movs	r2, #0x0
   67aac: f857 0c64    	ldr	r0, [r7, #-100]
   67ab0: e9c6 2308    	strd	r2, r3, [r6, #32]
   67ab4: 2201         	movs	r2, #0x1
   67ab6: 9b60         	ldr	r3, [sp, #0x180]
   67ab8: 940a         	str	r4, [sp, #0x28]
   67aba: 4664         	mov	r4, r12
   67abc: edc6 1b16    	vstr	d17, [r6, #88]
   67ac0: ea40 4003    	orr.w	r0, r0, r3, lsl #16
   67ac4: 9b4e         	ldr	r3, [sp, #0x138]
   67ac6: e9cd 3e08    	strd	r3, lr, [sp, #32]
   67aca: 9b4d         	ldr	r3, [sp, #0x134]
   67acc: edc6 2b18    	vstr	d18, [r6, #96]
   67ad0: e9cd 300b    	strd	r3, r0, [sp, #44]
   67ad4: 910d         	str	r1, [sp, #0x34]
   67ad6: a806         	add	r0, sp, #0x18
   67ad8: f500 50a1    	add.w	r0, r0, #0x1420
   67adc: e9cd 020e    	strd	r0, r2, [sp, #56]
   67ae0: 985c         	ldr	r0, [sp, #0x170]
   67ae2: 9000         	str	r0, [sp]
   67ae4: 985b         	ldr	r0, [sp, #0x16c]
   67ae6: 9001         	str	r0, [sp, #0x4]
   67ae8: 9858         	ldr	r0, [sp, #0x160]
   67aea: 9002         	str	r0, [sp, #0x8]
   67aec: 9856         	ldr	r0, [sp, #0x158]
   67aee: 9003         	str	r0, [sp, #0xc]
   67af0: 9855         	ldr	r0, [sp, #0x154]
   67af2: 9004         	str	r0, [sp, #0x10]
   67af4: 9854         	ldr	r0, [sp, #0x150]
   67af6: 9005         	str	r0, [sp, #0x14]
   67af8: 9851         	ldr	r0, [sp, #0x144]
   67afa: 9a4f         	ldr	r2, [sp, #0x13c]
   67afc: 9b5e         	ldr	r3, [sp, #0x178]
   67afe: 9962         	ldr	r1, [sp, #0x188]
   67b00: 9006         	str	r0, [sp, #0x18]
   67b02: 9850         	ldr	r0, [sp, #0x140]
   67b04: 9007         	str	r0, [sp, #0x1c]
   67b06: 4660         	mov	r0, r12
   67b08: 4788         	blx	r1
   67b0a: 69b0         	ldr	r0, [r6, #0x18]
   67b0c: 46a6         	mov	lr, r4
   67b0e: ed56 0b02    	vldr	d16, [r6, #-8]
   67b12: edd6 1b04    	vldr	d17, [r6, #16]
   67b16: f500 50d8    	add.w	r0, r0, #0x1b00
   67b1a: edcb 0b0a    	vstr	d16, [r11, #40]
   67b1e: edcb 1b08    	vstr	d17, [r11, #32]
   67b22: edc8 0b00    	vstr	d16, [r8]
   67b26: edd0 0b00    	vldr	d16, [r0]
   67b2a: 6eb0         	ldr	r0, [r6, #0x68]
   67b2c: edca 0b00    	vstr	d16, [r10]
   67b30: edd6 0b1c    	vldr	d16, [r6, #112]
   67b34: f500 50d8    	add.w	r0, r0, #0x1b00
   67b38: 9934         	ldr	r1, [sp, #0xd0]
   67b3a: edca 0b4e    	vstr	d16, [r10, #312]
   67b3e: edd6 0b10    	vldr	d16, [r6, #64]
   67b42: edd6 2b08    	vldr	d18, [r6, #32]
   67b46: edc9 0b02    	vstr	d16, [r9, #8]
   67b4a: edd6 0b24    	vldr	d16, [r6, #144]
   67b4e: edd6 3b0c    	vldr	d19, [r6, #48]
   67b52: edd6 1b1e    	vldr	d17, [r6, #120]
   67b56: f000 b80f    	b.w	0x67b78 <check_error+0x14f0> @ imm = #0x1e
   67b5a: bf00         	nop
   67b5c: 58 38 01 00  	.word	0x00013858
   67b60: 88 16 01 00  	.word	0x00011688
   67b64: 00 00 f8 7f  	.word	0x7ff80000
   67b68: ef 60 00 00  	.word	0x000060ef
   67b6c: f0 56 01 00  	.word	0x000156f0
   67b70: b8 91 01 00  	.word	0x000191b8
   67b74: 28 72 01 00  	.word	0x00017228
   67b78: edd6 4b20    	vldr	d20, [r6, #128]
   67b7c: edc8 0b90    	vstr	d16, [r8, #576]
   67b80: edd6 0b16    	vldr	d16, [r6, #88]
   67b84: edc8 4b48    	vstr	d20, [r8, #288]
   67b88: edc8 3bd8    	vstr	d19, [r8, #864]
   67b8c: edc9 2b04    	vstr	d18, [r9, #16]
   67b90: edc1 1b48    	vstr	d17, [r1, #288]
   67b94: edca 0b04    	vstr	d16, [r10, #16]
   67b98: edca 0b06    	vstr	d16, [r10, #24]
   67b9c: edd0 0b00    	vldr	d16, [r0]
   67ba0: f50d 5080    	add.w	r0, sp, #0x1000
   67ba4: 9e52         	ldr	r6, [sp, #0x148]
   67ba6: f890 04e0    	ldrb.w	r0, [r0, #0x4e0]
   67baa: f88b 0018    	strb.w	r0, [r11, #0x18]
   67bae: edc1 0b00    	vstr	d16, [r1]
   67bb2: f8b4 0648    	ldrh.w	r0, [r4, #0x648]
   67bb6: f8b6 9000    	ldrh.w	r9, [r6]
   67bba: 2807         	cmp	r0, #0x7
   67bbc: 905e         	str	r0, [sp, #0x178]
   67bbe: d34a         	blo	0x67c56 <check_error+0x15ce> @ imm = #0x94
   67bc0: f8b5 0418    	ldrh.w	r0, [r5, #0x418]
   67bc4: f8be 1cfe    	ldrh.w	r1, [lr, #0xcfe]
   67bc8: f8dd a0b4    	ldr.w	r10, [sp, #0xb4]
   67bcc: 4281         	cmp	r1, r0
   67bce: d946         	bls	0x67c5e <check_error+0x15d6> @ imm = #0x8c
   67bd0: f24e 4190    	movw	r1, #0xe490
   67bd4: efc0 1010    	vmov.i32	d17, #0x0
   67bd8: efc0 2010    	vmov.i32	d18, #0x0
   67bdc: 4dd7         	ldr	r5, [pc, #0x35c]        @ 0x67f3c <check_error+0x18b4>
   67bde: f8dd b0e0    	ldr.w	r11, [sp, #0xe0]
   67be2: 4471         	add	r1, lr
   67be4: eddf 0bd6    	vldr	d16, [pc, #856]         @ 0x67f40 <check_error+0x18b8>
   67be8: 2200         	movs	r2, #0x0
   67bea: 2300         	movs	r3, #0x0
   67bec: 2a38         	cmp	r2, #0x38
   67bee: d049         	beq	0x67c84 <check_error+0x15fc> @ imm = #0x92
   67bf0: 188c         	adds	r4, r1, r2
   67bf2: ef62 41b2    	vorr	d20, d18, d18
   67bf6: edd4 3b00    	vldr	d19, [r4]
   67bfa: b29c         	uxth	r4, r3
   67bfc: 2c00         	cmp	r4, #0x0
   67bfe: bf08         	it	eq
   67c00: eef0 4b63    	vmoveq.f64	d20, d19
   67c04: eef0 5be3    	vabs.f64	d21, d19
   67c08: eef4 5b60    	vcmp.f64	d21, d16
   67c0c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   67c10: bf08         	it	eq
   67c12: eef0 4b62    	vmoveq.f64	d20, d18
   67c16: eef4 5b60    	vcmp.f64	d21, d16
   67c1a: bf68         	it	vs
   67c1c: eef0 4b62    	vmovvs.f64	d20, d18
   67c20: 2c00         	cmp	r4, #0x0
   67c22: f04f 0400    	mov.w	r4, #0x0
   67c26: ef61 21b1    	vorr	d18, d17, d17
   67c2a: bf08         	it	eq
   67c2c: eef0 2b63    	vmoveq.f64	d18, d19
   67c30: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   67c34: bf08         	it	eq
   67c36: eef0 2b61    	vmoveq.f64	d18, d17
   67c3a: bf68         	it	vs
   67c3c: eef0 2b61    	vmovvs.f64	d18, d17
   67c40: bf48         	it	mi
   67c42: 2401         	movmi	r4, #0x1
   67c44: bfc8         	it	gt
   67c46: 2401         	movgt	r4, #0x1
   67c48: ef62 11b2    	vorr	d17, d18, d18
   67c4c: 4423         	add	r3, r4
   67c4e: 3208         	adds	r2, #0x8
   67c50: ef64 21b4    	vorr	d18, d20, d20
   67c54: e7ca         	b	0x67bec <check_error+0x1564> @ imm = #-0x6c
   67c56: f8dd a0b4    	ldr.w	r10, [sp, #0xb4]
   67c5a: 2802         	cmp	r0, #0x2
   67c5c: d346         	blo	0x67cec <check_error+0x1664> @ imm = #0x8c
   67c5e: 9a3a         	ldr	r2, [sp, #0xe8]
   67c60: 2000         	movs	r0, #0x0
   67c62: 49b9         	ldr	r1, [pc, #0x2e4]        @ 0x67f48 <check_error+0x18c0>
   67c64: 9b2f         	ldr	r3, [sp, #0xbc]
   67c66: edd2 0b02    	vldr	d16, [r2, #8]
   67c6a: e9c2 014a    	strd	r0, r1, [r2, #296]
   67c6e: e9c3 0100    	strd	r0, r1, [r3]
   67c72: e9c3 0148    	strd	r0, r1, [r3, #288]
   67c76: e9c2 0192    	strd	r0, r1, [r2, #584]
   67c7a: edc2 0b00    	vstr	d16, [r2]
   67c7e: edc3 0b4a    	vstr	d16, [r3, #296]
   67c82: e043         	b	0x67d0c <check_error+0x1684> @ imm = #0x86
   67c84: b299         	uxth	r1, r3
   67c86: eddf 0bb2    	vldr	d16, [pc, #712]         @ 0x67f50 <check_error+0x18c8>
   67c8a: 2903         	cmp	r1, #0x3
   67c8c: f240 8315    	bls.w	0x682ba <check_error+0x1c32> @ imm = #0x62a
   67c90: 992e         	ldr	r1, [sp, #0xb8]
   67c92: edd1 3b00    	vldr	d19, [r1]
   67c96: edd1 4b0c    	vldr	d20, [r1, #48]
   67c9a: ee74 3be3    	vsub.f64	d19, d20, d19
   67c9e: eddf 4bae    	vldr	d20, [pc, #696]         @ 0x67f58 <check_error+0x18d0>
   67ca2: eef4 3b64    	vcmp.f64	d19, d20
   67ca6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   67caa: f200 8306    	bhi.w	0x682ba <check_error+0x1c32> @ imm = #0x60c
   67cae: f24e 4190    	movw	r1, #0xe490
   67cb2: 2200         	movs	r2, #0x0
   67cb4: 4471         	add	r1, lr
   67cb6: 2a38         	cmp	r2, #0x38
   67cb8: f000 82fd    	beq.w	0x682b6 <check_error+0x1c2e> @ imm = #0x5fa
   67cbc: 188b         	adds	r3, r1, r2
   67cbe: edd3 0b00    	vldr	d16, [r3]
   67cc2: eef4 0b60    	vcmp.f64	d16, d16
   67cc6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   67cca: d60d         	bvs	0x67ce8 <check_error+0x1660> @ imm = #0x1a
   67ccc: eef4 1b60    	vcmp.f64	d17, d16
   67cd0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   67cd4: bf48         	it	mi
   67cd6: eef0 1b60    	vmovmi.f64	d17, d16
   67cda: eef4 2b60    	vcmp.f64	d18, d16
   67cde: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   67ce2: bfc8         	it	gt
   67ce4: eef0 2b60    	vmovgt.f64	d18, d16
   67ce8: 3208         	adds	r2, #0x8
   67cea: e7e4         	b	0x67cb6 <check_error+0x162e> @ imm = #-0x38
   67cec: 4996         	ldr	r1, [pc, #0x258]        @ 0x67f48 <check_error+0x18c0>
   67cee: 2000         	movs	r0, #0x0
   67cf0: 9b2f         	ldr	r3, [sp, #0xbc]
   67cf2: 9a3a         	ldr	r2, [sp, #0xe8]
   67cf4: e9c3 0100    	strd	r0, r1, [r3]
   67cf8: e9c2 0100    	strd	r0, r1, [r2]
   67cfc: e9c3 0148    	strd	r0, r1, [r3, #288]
   67d00: e9c3 014a    	strd	r0, r1, [r3, #296]
   67d04: e9c2 014a    	strd	r0, r1, [r2, #296]
   67d08: e9c2 0192    	strd	r0, r1, [r2, #584]
   67d0c: 4d8b         	ldr	r5, [pc, #0x22c]        @ 0x67f3c <check_error+0x18b4>
   67d0e: f8dd b0e0    	ldr.w	r11, [sp, #0xe0]
   67d12: 9c3d         	ldr	r4, [sp, #0xf4]
   67d14: f8b4 8418    	ldrh.w	r8, [r4, #0x418]
   67d18: 45c1         	cmp	r9, r8
   67d1a: d968         	bls	0x67dee <check_error+0x1766> @ imm = #0xd0
   67d1c: f89a 004a    	ldrb.w	r0, [r10, #0x4a]
   67d20: f44f 7190    	mov.w	r1, #0x120
   67d24: 9058         	str	r0, [sp, #0x160]
   67d26: a80c         	add	r0, sp, #0x30
   67d28: f500 501f    	add.w	r0, r0, #0x27c0
   67d2c: f007 e968    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x72d0
   67d30: a80a         	add	r0, sp, #0x28
   67d32: f44f 7190    	mov.w	r1, #0x120
   67d36: f500 5067    	add.w	r0, r0, #0x39c0
   67d3a: f007 e962    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x72c4
   67d3e: a866         	add	r0, sp, #0x198
   67d40: f44f 7190    	mov.w	r1, #0x120
   67d44: f007 e95c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x72b8
   67d48: a802         	add	r0, sp, #0x8
   67d4a: f44f 7190    	mov.w	r1, #0x120
   67d4e: f500 50c9    	add.w	r0, r0, #0x1920
   67d52: f007 e956    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x72ac
   67d56: a806         	add	r0, sp, #0x18
   67d58: f44f 7190    	mov.w	r1, #0x120
   67d5c: f500 50a1    	add.w	r0, r0, #0x1420
   67d60: f007 e94e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x729c
   67d64: f50d 5080    	add.w	r0, sp, #0x1000
   67d68: f44f 7190    	mov.w	r1, #0x120
   67d6c: f007 e948    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7290
   67d70: f60d 2008    	addw	r0, sp, #0xa08
   67d74: f44f 7190    	mov.w	r1, #0x120
   67d78: f007 e942    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7284
   67d7c: a80a         	add	r0, sp, #0x28
   67d7e: f44f 7190    	mov.w	r1, #0x120
   67d82: f500 5011    	add.w	r0, r0, #0x2440
   67d86: f007 e93c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7278
   67d8a: a80c         	add	r0, sp, #0x30
   67d8c: f44f 7190    	mov.w	r1, #0x120
   67d90: f500 5000    	add.w	r0, r0, #0x2000
   67d94: f007 e934    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7268
   67d98: f50d 500c    	add.w	r0, sp, #0x2300
   67d9c: f44f 7190    	mov.w	r1, #0x120
   67da0: f007 e92e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x725c
   67da4: a802         	add	r0, sp, #0x8
   67da6: f44f 7190    	mov.w	r1, #0x120
   67daa: f500 50f6    	add.w	r0, r0, #0x1ec0
   67dae: f007 e928    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x7250
   67db2: f8b4 0702    	ldrh.w	r0, [r4, #0x702]
   67db6: 462a         	mov	r2, r5
   67db8: 9e53         	ldr	r6, [sp, #0x14c]
   67dba: eba9 0100    	sub.w	r1, r9, r0
   67dbe: 905b         	str	r0, [sp, #0x16c]
   67dc0: 2000         	movs	r0, #0x0
   67dc2: b1f2         	cbz	r2, 0x67e02 <check_error+0x177a> @ imm = #0x3c
   67dc4: 18b3         	adds	r3, r6, r2
   67dc6: 2400         	movs	r4, #0x0
   67dc8: f8b3 3d0c    	ldrh.w	r3, [r3, #0xd0c]
   67dcc: 4299         	cmp	r1, r3
   67dce: bfb8         	it	lt
   67dd0: 2401         	movlt	r4, #0x1
   67dd2: 2b00         	cmp	r3, #0x0
   67dd4: 461d         	mov	r5, r3
   67dd6: bf18         	it	ne
   67dd8: 2501         	movne	r5, #0x1
   67dda: 402c         	ands	r4, r5
   67ddc: 454b         	cmp	r3, r9
   67dde: f04f 0300    	mov.w	r3, #0x0
   67de2: bf98         	it	ls
   67de4: 2301         	movls	r3, #0x1
   67de6: 3202         	adds	r2, #0x2
   67de8: 4023         	ands	r3, r4
   67dea: 4418         	add	r0, r3
   67dec: e7e9         	b	0x67dc2 <check_error+0x173a> @ imm = #-0x2e
   67dee: 2000         	movs	r0, #0x0
   67df0: 2100         	movs	r1, #0x0
   67df2: 2907         	cmp	r1, #0x7
   67df4: f000 809c    	beq.w	0x67f30 <check_error+0x18a8> @ imm = #0x138
   67df8: 1872         	adds	r2, r6, r1
   67dfa: 3101         	adds	r1, #0x1
   67dfc: f882 088f    	strb.w	r0, [r2, #0x88f]
   67e00: e7f7         	b	0x67df2 <check_error+0x176a> @ imm = #-0x12
   67e02: b282         	uxth	r2, r0
   67e04: 4956         	ldr	r1, [pc, #0x158]        @ 0x67f60 <check_error+0x18d8>
   67e06: f8cd 9180    	str.w	r9, [sp, #0x180]
   67e0a: eba6 00c2    	sub.w	r0, r6, r2, lsl #3
   67e0e: ea4f 0bc2    	lsl.w	r11, r2, #0x3
   67e12: 4408         	add	r0, r1
   67e14: 9063         	str	r0, [sp, #0x18c]
   67e16: f1c2 0024    	rsb.w	r0, r2, #0x24
   67e1a: 4952         	ldr	r1, [pc, #0x148]        @ 0x67f64 <check_error+0x18dc>
   67e1c: f8cd 8158    	str.w	r8, [sp, #0x158]
   67e20: eb06 09c0    	add.w	r9, r6, r0, lsl #3
   67e24: 4850         	ldr	r0, [pc, #0x140]        @ 0x67f68 <check_error+0x18e0>
   67e26: 4449         	add	r1, r9
   67e28: 925c         	str	r2, [sp, #0x170]
   67e2a: 4448         	add	r0, r9
   67e2c: 9062         	str	r0, [sp, #0x188]
   67e2e: 484f         	ldr	r0, [pc, #0x13c]        @ 0x67f6c <check_error+0x18e4>
   67e30: eb09 0c00    	add.w	r12, r9, r0
   67e34: 484e         	ldr	r0, [pc, #0x138]        @ 0x67f70 <check_error+0x18e8>
   67e36: eb09 0e00    	add.w	lr, r9, r0
   67e3a: 484e         	ldr	r0, [pc, #0x138]        @ 0x67f74 <check_error+0x18ec>
   67e3c: eb09 0600    	add.w	r6, r9, r0
   67e40: 484d         	ldr	r0, [pc, #0x134]        @ 0x67f78 <check_error+0x18f0>
   67e42: eb09 0500    	add.w	r5, r9, r0
   67e46: 484d         	ldr	r0, [pc, #0x134]        @ 0x67f7c <check_error+0x18f4>
   67e48: eb09 0400    	add.w	r4, r9, r0
   67e4c: f24f 70f8    	movw	r0, #0xf7f8
   67e50: 4448         	add	r0, r9
   67e52: f04f 0900    	mov.w	r9, #0x0
   67e56: 45cb         	cmp	r11, r9
   67e58: f000 8092    	beq.w	0x67f80 <check_error+0x18f8> @ imm = #0x124
   67e5c: aa0c         	add	r2, sp, #0x30
   67e5e: f502 521f    	add.w	r2, r2, #0x27c0
   67e62: eb02 0a09    	add.w	r10, r2, r9
   67e66: 9a62         	ldr	r2, [sp, #0x188]
   67e68: eb02 0809    	add.w	r8, r2, r9
   67e6c: edd8 0b00    	vldr	d16, [r8]
   67e70: edca 0b00    	vstr	d16, [r10]
   67e74: aa0a         	add	r2, sp, #0x28
   67e76: 9b63         	ldr	r3, [sp, #0x18c]
   67e78: f502 5267    	add.w	r2, r2, #0x39c0
   67e7c: 444a         	add	r2, r9
   67e7e: 444b         	add	r3, r9
   67e80: edd3 0b00    	vldr	d16, [r3]
   67e84: eb0c 0309    	add.w	r3, r12, r9
   67e88: edc2 0b00    	vstr	d16, [r2]
   67e8c: aa66         	add	r2, sp, #0x198
   67e8e: 444a         	add	r2, r9
   67e90: edd3 2b90    	vldr	d18, [r3, #576]
   67e94: edd3 0b00    	vldr	d16, [r3]
   67e98: edd3 1b48    	vldr	d17, [r3, #288]
   67e9c: eb0e 0309    	add.w	r3, lr, r9
   67ea0: edc2 2b00    	vstr	d18, [r2]
   67ea4: aa02         	add	r2, sp, #0x8
   67ea6: f502 52c9    	add.w	r2, r2, #0x1920
   67eaa: 444a         	add	r2, r9
   67eac: edc2 0b00    	vstr	d16, [r2]
   67eb0: aa06         	add	r2, sp, #0x18
   67eb2: f502 52a1    	add.w	r2, r2, #0x1420
   67eb6: edd3 0b00    	vldr	d16, [r3]
   67eba: 444a         	add	r2, r9
   67ebc: eb06 0309    	add.w	r3, r6, r9
   67ec0: edc2 1b00    	vstr	d17, [r2]
   67ec4: f50d 5280    	add.w	r2, sp, #0x1000
   67ec8: 444a         	add	r2, r9
   67eca: edc2 0b00    	vstr	d16, [r2]
   67ece: f60d 2208    	addw	r2, sp, #0xa08
   67ed2: edd3 0b00    	vldr	d16, [r3]
   67ed6: 444a         	add	r2, r9
   67ed8: eb05 0309    	add.w	r3, r5, r9
   67edc: edc2 0b00    	vstr	d16, [r2]
   67ee0: aa0a         	add	r2, sp, #0x28
   67ee2: f502 5211    	add.w	r2, r2, #0x2440
   67ee6: edd3 0b00    	vldr	d16, [r3]
   67eea: 444a         	add	r2, r9
   67eec: eb04 0309    	add.w	r3, r4, r9
   67ef0: edc2 0b00    	vstr	d16, [r2]
   67ef4: aa0c         	add	r2, sp, #0x30
   67ef6: f502 5200    	add.w	r2, r2, #0x2000
   67efa: edd3 0b00    	vldr	d16, [r3]
   67efe: 444a         	add	r2, r9
   67f00: eb00 0309    	add.w	r3, r0, r9
   67f04: edc2 0b00    	vstr	d16, [r2]
   67f08: f50d 520c    	add.w	r2, sp, #0x2300
   67f0c: edd3 0b00    	vldr	d16, [r3]
   67f10: 444a         	add	r2, r9
   67f12: eb01 0309    	add.w	r3, r1, r9
   67f16: edc2 0b00    	vstr	d16, [r2]
   67f1a: aa02         	add	r2, sp, #0x8
   67f1c: f502 52f6    	add.w	r2, r2, #0x1ec0
   67f20: edd3 0b00    	vldr	d16, [r3]
   67f24: 444a         	add	r2, r9
   67f26: f109 0908    	add.w	r9, r9, #0x8
   67f2a: edc2 0b00    	vstr	d16, [r2]
   67f2e: e792         	b	0x67e56 <check_error+0x17ce> @ imm = #-0xdc
   67f30: 2000         	movs	r0, #0x0
   67f32: f886 07ac    	strb.w	r0, [r6, #0x7ac]
   67f36: f000 bddb    	b.w	0x68af0 <check_error+0x2468> @ imm = #0xbb6
   67f3a: bf00         	nop
   67f3c: 3e f9 ff ff  	.word	0xfffff93e
   67f40: 00 00 00 00  	.word	0x00000000
   67f44: 00 00 f0 7f  	.word	0x7ff00000
   67f48: 00 00 f8 7f  	.word	0x7ff80000
   67f4c: 00 bf 00 bf  	.word	0xbf00bf00
   67f50: 00 00 00 00  	.word	0x00000000
   67f54: 00 00 f8 7f  	.word	0x7ff80000
   67f58: 00 00 00 00  	.word	0x00000000
   67f5c: 00 00 44 40  	.word	0x40440000
   67f60: 20 ca 01 00  	.word	0x0001ca20
   67f64: 30 14 01 00  	.word	0x00011430
   67f68: d8 ac 01 00  	.word	0x0001acd8
   67f6c: 30 8d 01 00  	.word	0x00018d30
   67f70: 10 36 01 00  	.word	0x00013610
   67f74: 90 31 01 00  	.word	0x00013190
   67f78: d0 33 01 00  	.word	0x000133d0
   67f7c: 50 15 01 00  	.word	0x00011550
   67f80: 9836         	ldr	r0, [sp, #0xd8]
   67f82: 7e00         	ldrb	r0, [r0, #0x18]
   67f84: 2800         	cmp	r0, #0x0
   67f86: f000 80ed    	beq.w	0x68164 <check_error+0x1adc> @ imm = #0x1da
   67f8a: e9dd 105b    	ldrd	r1, r0, [sp, #364]
   67f8e: e9dd 6e52    	ldrd	r6, lr, [sp, #328]
   67f92: 4dde         	ldr	r5, [pc, #0x378]        @ 0x6830c <check_error+0x1c84>
   67f94: 4288         	cmp	r0, r1
   67f96: f8dd a0b4    	ldr.w	r10, [sp, #0xb4]
   67f9a: f8dd b0e0    	ldr.w	r11, [sp, #0xe0]
   67f9e: f8dd 9180    	ldr.w	r9, [sp, #0x180]
   67fa2: f040 8120    	bne.w	0x681e6 <check_error+0x1b5e> @ imm = #0x240
   67fa6: 993d         	ldr	r1, [sp, #0xf4]
   67fa8: 466a         	mov	r2, sp
   67faa: f501 60ff    	add.w	r0, r1, #0x7f8
   67fae: ed90 8b00    	vldr	d8, [r0]
   67fb2: f501 6000    	add.w	r0, r1, #0x800
   67fb6: edd0 0b00    	vldr	d16, [r0]
   67fba: f501 60e4    	add.w	r0, r1, #0x720
   67fbe: ed90 9b00    	vldr	d9, [r0]
   67fc2: edd0 1b02    	vldr	d17, [r0, #8]
   67fc6: f501 60e6    	add.w	r0, r1, #0x730
   67fca: ecf0 2b04    	vldmia	r0!, {d18, d19}
   67fce: f501 60eb    	add.w	r0, r1, #0x758
   67fd2: ed90 ab00    	vldr	d10, [r0]
   67fd6: edd0 4b02    	vldr	d20, [r0, #8]
   67fda: edd0 5b04    	vldr	d21, [r0, #16]
   67fde: a80e         	add	r0, sp, #0x38
   67fe0: f500 581c    	add.w	r8, r0, #0x2700
   67fe4: f108 0018    	add.w	r0, r8, #0x18
   67fe8: edc8 0b02    	vstr	d16, [r8, #8]
   67fec: ece0 1b06    	vstmia	r0!, {d17, d18, d19}
   67ff0: f501 60ee    	add.w	r0, r1, #0x770
   67ff4: edc8 4b0e    	vstr	d20, [r8, #56]
   67ff8: ed90 bb00    	vldr	d11, [r0]
   67ffc: edd0 0b02    	vldr	d16, [r0, #8]
   68000: edd0 1b04    	vldr	d17, [r0, #16]
   68004: f501 60f1    	add.w	r0, r1, #0x788
   68008: ed88 8b00    	vstr	d8, [r8]
   6800c: edd0 2b00    	vldr	d18, [r0]
   68010: f501 60f5    	add.w	r0, r1, #0x7a8
   68014: ed88 9b04    	vstr	d9, [r8, #16]
   68018: edd0 3b00    	vldr	d19, [r0]
   6801c: f501 60f6    	add.w	r0, r1, #0x7b0
   68020: ed88 ab0c    	vstr	d10, [r8, #48]
   68024: edd0 4b00    	vldr	d20, [r0]
   68028: f501 60f7    	add.w	r0, r1, #0x7b8
   6802c: 4641         	mov	r1, r8
   6802e: edc8 5b10    	vstr	d21, [r8, #64]
   68032: edd0 6b00    	vldr	d22, [r0]
   68036: f108 0050    	add.w	r0, r8, #0x50
   6803a: ed88 bb12    	vstr	d11, [r8, #72]
   6803e: ece0 0b0a    	vstmia	r0!, {d16, d17, d18, d19, d20}
   68042: 48b3         	ldr	r0, [pc, #0x2cc]        @ 0x68310 <check_error+0x1c88>
   68044: edc8 6b1e    	vstr	d22, [r8, #120]
   68048: f961 078d    	vld1.32	{d16}, [r1]!
   6804c: 3808         	subs	r0, #0x8
   6804e: f942 078d    	vst1.32	{d16}, [r2]!
   68052: d1f9         	bne	0x68048 <check_error+0x19c0> @ imm = #-0xe
   68054: 9c58         	ldr	r4, [sp, #0x160]
   68056: 4671         	mov	r1, lr
   68058: 9a5b         	ldr	r2, [sp, #0x16c]
   6805a: 4620         	mov	r0, r4
   6805c: f006 fa1c    	bl	0x6e498 <f_check_cgm_trend> @ imm = #0x6438
   68060: 2c02         	cmp	r4, #0x2
   68062: f886 088f    	strb.w	r0, [r6, #0x88f]
   68066: f200 8108    	bhi.w	0x6827a <check_error+0x1bf2> @ imm = #0x210
   6806a: 993d         	ldr	r1, [sp, #0xf4]
   6806c: f60d 2308    	addw	r3, sp, #0xa08
   68070: f50d 5480    	add.w	r4, sp, #0x1000
   68074: f04f 0c01    	mov.w	r12, #0x1
   68078: f601 0028    	addw	r0, r1, #0x828
   6807c: f04f 0901    	mov.w	r9, #0x1
   68080: f04f 0e01    	mov.w	lr, #0x1
   68084: f04f 0801    	mov.w	r8, #0x1
   68088: edd0 0b00    	vldr	d16, [r0]
   6808c: f501 6002    	add.w	r0, r1, #0x820
   68090: edd0 1b00    	vldr	d17, [r0]
   68094: a806         	add	r0, sp, #0x18
   68096: f500 51a1    	add.w	r1, r0, #0x1420
   6809a: a80a         	add	r0, sp, #0x28
   6809c: f500 5211    	add.w	r2, r0, #0x2440
   680a0: a802         	add	r0, sp, #0x8
   680a2: f500 55c9    	add.w	r5, r0, #0x1920
   680a6: ae66         	add	r6, sp, #0x198
   680a8: 985c         	ldr	r0, [sp, #0x170]
   680aa: 2800         	cmp	r0, #0x0
   680ac: f000 80e8    	beq.w	0x68280 <check_error+0x1bf8> @ imm = #0x1d0
   680b0: edd6 2b00    	vldr	d18, [r6]
   680b4: eef4 2b48    	vcmp.f64	d18, d8
   680b8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   680bc: dd02         	ble	0x680c4 <check_error+0x1a3c> @ imm = #0x4
   680be: f04f 0c00    	mov.w	r12, #0x0
   680c2: e004         	b	0x680ce <check_error+0x1a46> @ imm = #0x8
   680c4: eef4 2b62    	vcmp.f64	d18, d18
   680c8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   680cc: d6f7         	bvs	0x680be <check_error+0x1a36> @ imm = #-0x12
   680ce: edd5 2b00    	vldr	d18, [r5]
   680d2: eef4 2b61    	vcmp.f64	d18, d17
   680d6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   680da: da10         	bge	0x680fe <check_error+0x1a76> @ imm = #0x20
   680dc: eef4 2b62    	vcmp.f64	d18, d18
   680e0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   680e4: d60b         	bvs	0x680fe <check_error+0x1a76> @ imm = #0x16
   680e6: edd1 2b00    	vldr	d18, [r1]
   680ea: eef4 2b60    	vcmp.f64	d18, d16
   680ee: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   680f2: d904         	bls	0x680fe <check_error+0x1a76> @ imm = #0x8
   680f4: eef4 2b62    	vcmp.f64	d18, d18
   680f8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   680fc: d701         	bvc	0x68102 <check_error+0x1a7a> @ imm = #0x2
   680fe: f04f 0900    	mov.w	r9, #0x0
   68102: edd4 2b00    	vldr	d18, [r4]
   68106: eef4 2b49    	vcmp.f64	d18, d9
   6810a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6810e: dd02         	ble	0x68116 <check_error+0x1a8e> @ imm = #0x4
   68110: f04f 0e00    	mov.w	lr, #0x0
   68114: e004         	b	0x68120 <check_error+0x1a98> @ imm = #0x8
   68116: eef4 2b62    	vcmp.f64	d18, d18
   6811a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6811e: d6f7         	bvs	0x68110 <check_error+0x1a88> @ imm = #-0x12
   68120: edd3 2b00    	vldr	d18, [r3]
   68124: eef4 2b4a    	vcmp.f64	d18, d10
   68128: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6812c: da10         	bge	0x68150 <check_error+0x1ac8> @ imm = #0x20
   6812e: eef4 2b62    	vcmp.f64	d18, d18
   68132: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68136: d60b         	bvs	0x68150 <check_error+0x1ac8> @ imm = #0x16
   68138: edd2 2b00    	vldr	d18, [r2]
   6813c: eef4 2b4b    	vcmp.f64	d18, d11
   68140: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68144: d904         	bls	0x68150 <check_error+0x1ac8> @ imm = #0x8
   68146: eef4 2b62    	vcmp.f64	d18, d18
   6814a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6814e: d701         	bvc	0x68154 <check_error+0x1acc> @ imm = #0x2
   68150: f04f 0800    	mov.w	r8, #0x0
   68154: 3801         	subs	r0, #0x1
   68156: 3608         	adds	r6, #0x8
   68158: 3508         	adds	r5, #0x8
   6815a: 3408         	adds	r4, #0x8
   6815c: 3308         	adds	r3, #0x8
   6815e: 3208         	adds	r2, #0x8
   68160: 3108         	adds	r1, #0x8
   68162: e7a2         	b	0x680aa <check_error+0x1a22> @ imm = #-0xbc
   68164: e9dd 045b    	ldrd	r0, r4, [sp, #364]
   68168: e9dd 6e52    	ldrd	r6, lr, [sp, #328]
   6816c: 4d67         	ldr	r5, [pc, #0x19c]        @ 0x6830c <check_error+0x1c84>
   6816e: 4284         	cmp	r4, r0
   68170: f8dd a0b4    	ldr.w	r10, [sp, #0xb4]
   68174: f8dd b0e0    	ldr.w	r11, [sp, #0xe0]
   68178: f8dd 9180    	ldr.w	r9, [sp, #0x180]
   6817c: f8dd 8158    	ldr.w	r8, [sp, #0x158]
   68180: d13a         	bne	0x681f8 <check_error+0x1b70> @ imm = #0x74
   68182: 993d         	ldr	r1, [sp, #0xf4]
   68184: 2301         	movs	r3, #0x1
   68186: f501 6001    	add.w	r0, r1, #0x810
   6818a: edd0 0b00    	vldr	d16, [r0]
   6818e: f601 0008    	addw	r0, r1, #0x808
   68192: edd0 1b00    	vldr	d17, [r0]
   68196: a90a         	add	r1, sp, #0x28
   68198: aa0c         	add	r2, sp, #0x30
   6819a: f501 5167    	add.w	r1, r1, #0x39c0
   6819e: f502 521f    	add.w	r2, r2, #0x27c0
   681a2: 2001         	movs	r0, #0x1
   681a4: b364         	cbz	r4, 0x68200 <check_error+0x1b78> @ imm = #0x58
   681a6: edd2 2b00    	vldr	d18, [r2]
   681aa: eef4 2b61    	vcmp.f64	d18, d17
   681ae: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   681b2: dd01         	ble	0x681b8 <check_error+0x1b30> @ imm = #0x2
   681b4: 2000         	movs	r0, #0x0
   681b6: e004         	b	0x681c2 <check_error+0x1b3a> @ imm = #0x8
   681b8: eef4 2b62    	vcmp.f64	d18, d18
   681bc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   681c0: d6f8         	bvs	0x681b4 <check_error+0x1b2c> @ imm = #-0x10
   681c2: edd1 2b00    	vldr	d18, [r1]
   681c6: eef4 2b60    	vcmp.f64	d18, d16
   681ca: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   681ce: dd01         	ble	0x681d4 <check_error+0x1b4c> @ imm = #0x2
   681d0: 2300         	movs	r3, #0x0
   681d2: e004         	b	0x681de <check_error+0x1b56> @ imm = #0x8
   681d4: eef4 2b62    	vcmp.f64	d18, d18
   681d8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   681dc: d6f8         	bvs	0x681d0 <check_error+0x1b48> @ imm = #-0x10
   681de: 3c01         	subs	r4, #0x1
   681e0: 3208         	adds	r2, #0x8
   681e2: 3108         	adds	r1, #0x8
   681e4: e7de         	b	0x681a4 <check_error+0x1b1c> @ imm = #-0x44
   681e6: 2000         	movs	r0, #0x0
   681e8: f886 0891    	strb.w	r0, [r6, #0x891]
   681ec: f8a6 088f    	strh.w	r0, [r6, #0x88f]
   681f0: a80e         	add	r0, sp, #0x38
   681f2: f500 581c    	add.w	r8, r0, #0x2700
   681f6: e285         	b	0x68704 <check_error+0x207c> @ imm = #0x50a
   681f8: 2000         	movs	r0, #0x0
   681fa: f886 088f    	strb.w	r0, [r6, #0x88f]
   681fe: e032         	b	0x68266 <check_error+0x1bde> @ imm = #0x64
   68200: 2801         	cmp	r0, #0x1
   68202: bf02         	ittt	eq
   68204: 2b01         	cmpeq	r3, #0x1
   68206: 2001         	moveq	r0, #0x1
   68208: f886 088f    	strbeq.w	r0, [r6, #0x88f]
   6820c: 982e         	ldr	r0, [sp, #0xb8]
   6820e: edd0 0b10    	vldr	d16, [r0, #64]
   68212: eef4 0b60    	vcmp.f64	d16, d16
   68216: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6821a: d624         	bvs	0x68266 <check_error+0x1bde> @ imm = #0x48
   6821c: 982e         	ldr	r0, [sp, #0xb8]
   6821e: 6871         	ldr	r1, [r6, #0x4]
   68220: eddf 1b3d    	vldr	d17, [pc, #244]         @ 0x68318 <check_error+0x1c90>
   68224: f8d0 01d0    	ldr.w	r0, [r0, #0x1d0]
   68228: 1a08         	subs	r0, r1, r0
   6822a: ee00 0a10    	vmov	s0, r0
   6822e: 983d         	ldr	r0, [sp, #0xf4]
   68230: eef8 0b40    	vcvt.f64.u32	d16, s0
   68234: f500 60dd    	add.w	r0, r0, #0x6e8
   68238: eec0 0ba1    	vdiv.f64	d16, d16, d17
   6823c: edd0 1b00    	vldr	d17, [r0]
   68240: eef4 0b61    	vcmp.f64	d16, d17
   68244: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68248: d80d         	bhi	0x68266 <check_error+0x1bde> @ imm = #0x1a
   6824a: 9822         	ldr	r0, [sp, #0x88]
   6824c: edd0 0b64    	vldr	d16, [r0, #400]
   68250: 983d         	ldr	r0, [sp, #0xf4]
   68252: f500 60de    	add.w	r0, r0, #0x6f0
   68256: edd0 1b00    	vldr	d17, [r0]
   6825a: eef4 0b61    	vcmp.f64	d16, d17
   6825e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68262: f240 817a    	bls.w	0x6855a <check_error+0x1ed2> @ imm = #0x2f4
   68266: 2000         	movs	r0, #0x0
   68268: 2100         	movs	r1, #0x0
   6826a: 2906         	cmp	r1, #0x6
   6826c: f000 83db    	beq.w	0x68a26 <check_error+0x239e> @ imm = #0x7b6
   68270: 1872         	adds	r2, r6, r1
   68272: 3101         	adds	r1, #0x1
   68274: f882 0890    	strb.w	r0, [r2, #0x890]
   68278: e7f7         	b	0x6826a <check_error+0x1be2> @ imm = #-0x12
   6827a: 2000         	movs	r0, #0x0
   6827c: 9953         	ldr	r1, [sp, #0x14c]
   6827e: e181         	b	0x68584 <check_error+0x1efc> @ imm = #0x302
   68280: f089 0001    	eor	r0, r9, #0x1
   68284: f08c 0101    	eor	r1, r12, #0x1
   68288: 4308         	orrs	r0, r1
   6828a: f04f 0001    	mov.w	r0, #0x1
   6828e: f000 8172    	beq.w	0x68576 <check_error+0x1eee> @ imm = #0x2e4
   68292: f088 0101    	eor	r1, r8, #0x1
   68296: f08e 0201    	eor	r2, lr, #0x1
   6829a: 4311         	orrs	r1, r2
   6829c: fab1 f181    	clz	r1, r1
   682a0: 0949         	lsrs	r1, r1, #0x5
   682a2: e9dd 6152    	ldrd	r6, r1, [sp, #328]
   682a6: aa0e         	add	r2, sp, #0x38
   682a8: f8dd 9180    	ldr.w	r9, [sp, #0x180]
   682ac: f502 581c    	add.w	r8, r2, #0x2700
   682b0: f000 816a    	beq.w	0x68588 <check_error+0x1f00> @ imm = #0x2d4
   682b4: e166         	b	0x68584 <check_error+0x1efc> @ imm = #0x2cc
   682b6: ee71 0be2    	vsub.f64	d16, d17, d18
   682ba: 992f         	ldr	r1, [sp, #0xbc]
   682bc: f20e 644a    	addw	r4, lr, #0x64a
   682c0: 2200         	movs	r2, #0x0
   682c2: 462b         	mov	r3, r5
   682c4: edc1 0b00    	vstr	d16, [r1]
   682c8: 993d         	ldr	r1, [sp, #0xf4]
   682ca: f601 0138    	addw	r1, r1, #0x838
   682ce: edd1 1b00    	vldr	d17, [r1]
   682d2: eebd 0be1    	vcvt.s32.f64	s0, d17
   682d6: ee10 1a10    	vmov	r1, s0
   682da: eba9 0101    	sub.w	r1, r9, r1
   682de: b31b         	cbz	r3, 0x68328 <check_error+0x1ca0> @ imm = #0x46
   682e0: 18e5         	adds	r5, r4, r3
   682e2: f8b5 56c2    	ldrh.w	r5, [r5, #0x6c2]
   682e6: b175         	cbz	r5, 0x68306 <check_error+0x1c7e> @ imm = #0x1c
   682e8: 42a9         	cmp	r1, r5
   682ea: dc0c         	bgt	0x68306 <check_error+0x1c7e> @ imm = #0x18
   682ec: 4285         	cmp	r5, r0
   682ee: f04f 0600    	mov.w	r6, #0x0
   682f2: bf88         	it	hi
   682f4: 2601         	movhi	r6, #0x1
   682f6: 454d         	cmp	r5, r9
   682f8: f04f 0500    	mov.w	r5, #0x0
   682fc: bf98         	it	ls
   682fe: 2501         	movls	r5, #0x1
   68300: 4035         	ands	r5, r6
   68302: 9e52         	ldr	r6, [sp, #0x148]
   68304: 442a         	add	r2, r5
   68306: 4d01         	ldr	r5, [pc, #0x4]          @ 0x6830c <check_error+0x1c84>
   68308: 3302         	adds	r3, #0x2
   6830a: e7e8         	b	0x682de <check_error+0x1c56> @ imm = #-0x30
   6830c: 3e f9 ff ff  	.word	0xfffff93e
   68310: 80 00 00 00  	.word	0x00000080
   68314: 00 bf 00 bf  	.word	0xbf00bf00
   68318: 00 00 00 00  	.word	0x00000000
   6831c: 00 18 f5 40  	.word	0x40f51800
   68320: 00 00 00 00  	.word	0x00000000
   68324: 00 00 59 40  	.word	0x40590000
   68328: b291         	uxth	r1, r2
   6832a: f240 2041    	movw	r0, #0x241
   6832e: 1a40         	subs	r0, r0, r1
   68330: f24e 52f0    	movw	r2, #0xe5f0
   68334: 2300         	movs	r3, #0x0
   68336: eb0e 00c0    	add.w	r0, lr, r0, lsl #3
   6833a: 4402         	add	r2, r0
   6833c: 983d         	ldr	r0, [sp, #0xf4]
   6833e: f600 0068    	addw	r0, r0, #0x868
   68342: edd0 1b00    	vldr	d17, [r0]
   68346: 2000         	movs	r0, #0x0
   68348: b1c9         	cbz	r1, 0x6837e <check_error+0x1cf6> @ imm = #0x32
   6834a: edd2 2b00    	vldr	d18, [r2]
   6834e: eef4 2b62    	vcmp.f64	d18, d18
   68352: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68356: d60f         	bvs	0x68378 <check_error+0x1cf0> @ imm = #0x1e
   68358: eef5 2b40    	vcmp.f64	d18, #0
   6835c: eef1 3b62    	vneg.f64	d19, d18
   68360: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68364: bf48         	it	mi
   68366: eef0 2b63    	vmovmi.f64	d18, d19
   6836a: eef4 2b61    	vcmp.f64	d18, d17
   6836e: 3301         	adds	r3, #0x1
   68370: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68374: bf98         	it	ls
   68376: 3001         	addls	r0, #0x1
   68378: 3901         	subs	r1, #0x1
   6837a: 3208         	adds	r2, #0x8
   6837c: e7e4         	b	0x68348 <check_error+0x1cc0> @ imm = #-0x38
   6837e: b299         	uxth	r1, r3
   68380: ee00 1a10    	vmov	s0, r1
   68384: 993d         	ldr	r1, [sp, #0xf4]
   68386: eef8 1b40    	vcvt.f64.u32	d17, s0
   6838a: f501 6104    	add.w	r1, r1, #0x840
   6838e: edd1 2b00    	vldr	d18, [r1]
   68392: eef4 2b61    	vcmp.f64	d18, d17
   68396: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6839a: d850         	bhi	0x6843e <check_error+0x1db6> @ imm = #0xa0
   6839c: eef4 0b60    	vcmp.f64	d16, d16
   683a0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   683a4: d64b         	bvs	0x6843e <check_error+0x1db6> @ imm = #0x96
   683a6: b280         	uxth	r0, r0
   683a8: eef7 2b00    	vmov.f64	d18, #1.000000e+00
   683ac: f8dd 80e8    	ldr.w	r8, [sp, #0xe8]
   683b0: 2102         	movs	r1, #0x2
   683b2: eddb 0b4a    	vldr	d16, [r11, #296]
   683b6: ee00 0a10    	vmov	s0, r0
   683ba: ed1f 9b27    	vldr	d9, [pc, #-156]         @ 0x68320 <check_error+0x1c98>
   683be: ee30 bba2    	vadd.f64	d11, d16, d18
   683c2: 982f         	ldr	r0, [sp, #0xbc]
   683c4: eef8 0b40    	vcvt.f64.u32	d16, s0
   683c8: eec0 0ba1    	vdiv.f64	d16, d16, d17
   683cc: ee20 ab89    	vmul.f64	d10, d16, d9
   683d0: ed8b bb4a    	vstr	d11, [r11, #296]
   683d4: ed80 ab48    	vstr	d10, [r0, #288]
   683d8: ed98 8b02    	vldr	d8, [r8, #8]
   683dc: a802         	add	r0, sp, #0x8
   683de: f500 5080    	add.w	r0, r0, #0x1000
   683e2: ed00 8b02    	vstr	d8, [r0, #-8]
   683e6: ed80 ab00    	vstr	d10, [r0]
   683ea: f50d 5080    	add.w	r0, sp, #0x1000
   683ee: f006 f82b    	bl	0x6e448 <math_min>      @ imm = #0x6056
   683f2: 993d         	ldr	r1, [sp, #0xf4]
   683f4: ed88 0b00    	vstr	d0, [r8]
   683f8: f501 6003    	add.w	r0, r1, #0x830
   683fc: edd0 0b00    	vldr	d16, [r0]
   68400: eeb4 bb60    	vcmp.f64	d11, d16
   68404: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68408: da26         	bge	0x68458 <check_error+0x1dd0> @ imm = #0x4c
   6840a: f501 6007    	add.w	r0, r1, #0x870
   6840e: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   68412: 462a         	mov	r2, r5
   68414: edd0 0b00    	vldr	d16, [r0]
   68418: eebd 1be0    	vcvt.s32.f64	s2, d16
   6841c: ee11 0a10    	vmov	r0, s2
   68420: eba9 0100    	sub.w	r1, r9, r0
   68424: 2000         	movs	r0, #0x0
   68426: b3e2         	cbz	r2, 0x684a2 <check_error+0x1e1a> @ imm = #0x78
   68428: 18a3         	adds	r3, r4, r2
   6842a: f8b3 36c2    	ldrh.w	r3, [r3, #0x6c2]
   6842e: b123         	cbz	r3, 0x6843a <check_error+0x1db2> @ imm = #0x8
   68430: 4299         	cmp	r1, r3
   68432: dc02         	bgt	0x6843a <check_error+0x1db2> @ imm = #0x4
   68434: 454b         	cmp	r3, r9
   68436: bf98         	it	ls
   68438: 3001         	addls	r0, #0x1
   6843a: 3202         	adds	r2, #0x2
   6843c: e7f3         	b	0x68426 <check_error+0x1d9e> @ imm = #-0x1a
   6843e: 9a3a         	ldr	r2, [sp, #0xe8]
   68440: 2000         	movs	r0, #0x0
   68442: 49d4         	ldr	r1, [pc, #0x350]        @ 0x68794 <check_error+0x210c>
   68444: edd2 0b02    	vldr	d16, [r2, #8]
   68448: e9c2 014a    	strd	r0, r1, [r2, #296]
   6844c: e9c2 0192    	strd	r0, r1, [r2, #584]
   68450: 982f         	ldr	r0, [sp, #0xbc]
   68452: edc0 0b4a    	vstr	d16, [r0, #296]
   68456: e45c         	b	0x67d12 <check_error+0x168a> @ imm = #-0x748
   68458: eeb4 bb60    	vcmp.f64	d11, d16
   6845c: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   68460: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68464: dc58         	bgt	0x68518 <check_error+0x1e90> @ imm = #0xb0
   68466: eebc 0be0    	vcvt.u32.f64	s0, d16
   6846a: f240 3061    	movw	r0, #0x361
   6846e: f64f 1220    	movw	r2, #0xf920
   68472: ee10 1a10    	vmov	r1, s0
   68476: 1a40         	subs	r0, r0, r1
   68478: eb0e 00c0    	add.w	r0, lr, r0, lsl #3
   6847c: 4410         	add	r0, r2
   6847e: 2214         	movs	r2, #0x14
   68480: f005 fe76    	bl	0x6e170 <f_trimmed_mean> @ imm = #0x5cec
   68484: 982f         	ldr	r0, [sp, #0xbc]
   68486: ef20 8110    	vorr	d8, d0, d0
   6848a: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6848e: ed80 0b4a    	vstr	d0, [r0, #296]
   68492: f8be 1648    	ldrh.w	r1, [lr, #0x648]
   68496: 915e         	str	r1, [sp, #0x178]
   68498: f8b6 9000    	ldrh.w	r9, [r6]
   6849c: ed90 ab48    	vldr	d10, [r0, #288]
   684a0: e03d         	b	0x6851e <check_error+0x1e96> @ imm = #0x7a
   684a2: b280         	uxth	r0, r0
   684a4: f240 3161    	movw	r1, #0x361
   684a8: 1a09         	subs	r1, r1, r0
   684aa: eef8 0b00    	vmov.f64	d16, #-2.000000e+00
   684ae: f64f 1220    	movw	r2, #0xf920
   684b2: 4603         	mov	r3, r0
   684b4: eb0e 01c1    	add.w	r1, lr, r1, lsl #3
   684b8: 440a         	add	r2, r1
   684ba: 2100         	movs	r1, #0x0
   684bc: eef0 1b00    	vmov.f64	d17, #2.000000e+00
   684c0: b19b         	cbz	r3, 0x684ea <check_error+0x1e62> @ imm = #0x26
   684c2: edd2 2b00    	vldr	d18, [r2]
   684c6: ee72 3ba0    	vadd.f64	d19, d18, d16
   684ca: eeb4 0b63    	vcmp.f64	d0, d19
   684ce: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   684d2: db07         	blt	0x684e4 <check_error+0x1e5c> @ imm = #0xe
   684d4: ee72 2ba1    	vadd.f64	d18, d18, d17
   684d8: eeb4 0b62    	vcmp.f64	d0, d18
   684dc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   684e0: bf98         	it	ls
   684e2: 3101         	addls	r1, #0x1
   684e4: 3b01         	subs	r3, #0x1
   684e6: 3208         	adds	r2, #0x8
   684e8: e7ea         	b	0x684c0 <check_error+0x1e38> @ imm = #-0x2c
   684ea: ee01 0a10    	vmov	s2, r0
   684ee: 9a3d         	ldr	r2, [sp, #0xf4]
   684f0: eef8 1b41    	vcvt.f64.u32	d17, s2
   684f4: f602 0278    	addw	r2, r2, #0x878
   684f8: edd2 0b00    	vldr	d16, [r2]
   684fc: eef4 0b61    	vcmp.f64	d16, d17
   68500: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68504: d808         	bhi	0x68518 <check_error+0x1e90> @ imm = #0x10
   68506: b289         	uxth	r1, r1
   68508: 4281         	cmp	r1, r0
   6850a: d105         	bne	0x68518 <check_error+0x1e90> @ imm = #0xa
   6850c: 982f         	ldr	r0, [sp, #0xbc]
   6850e: ef20 8110    	vorr	d8, d0, d0
   68512: ed80 0b4a    	vstr	d0, [r0, #296]
   68516: e002         	b	0x6851e <check_error+0x1e96> @ imm = #0x4
   68518: 982f         	ldr	r0, [sp, #0xbc]
   6851a: ed80 8b4a    	vstr	d8, [r0, #296]
   6851e: ee7a 0b48    	vsub.f64	d16, d10, d8
   68522: 983a         	ldr	r0, [sp, #0xe8]
   68524: edc0 0b4a    	vstr	d16, [r0, #296]
   68528: eec0 0b88    	vdiv.f64	d16, d16, d8
   6852c: ee60 0b89    	vmul.f64	d16, d16, d9
   68530: edc0 0b92    	vstr	d16, [r0, #584]
   68534: f7ff bbed    	b.w	0x67d12 <check_error+0x168a> @ imm = #-0x826
   68538: 992e         	ldr	r1, [sp, #0xb8]
   6853a: ed9a 9bdc    	vldr	d9, [r10, #880]
   6853e: f8da 036c    	ldr.w	r0, [r10, #0x36c]
   68542: edc1 0ba6    	vstr	d16, [r1, #664]
   68546: ee78 0b60    	vsub.f64	d16, d8, d16
   6854a: f8c1 01d0    	str.w	r0, [r1, #0x1d0]
   6854e: ed81 9b10    	vstr	d9, [r1, #64]
   68552: edc9 0b64    	vstr	d16, [r9, #400]
   68556: f7fe bcd1    	b.w	0x66efc <check_error+0x874> @ imm = #-0x165e
   6855a: 9858         	ldr	r0, [sp, #0x160]
   6855c: 2802         	cmp	r0, #0x2
   6855e: f200 8214    	bhi.w	0x6898a <check_error+0x2302> @ imm = #0x428
   68562: 2000         	movs	r0, #0x0
   68564: 2100         	movs	r1, #0x0
   68566: 2906         	cmp	r1, #0x6
   68568: f43f ae7d    	beq.w	0x68266 <check_error+0x1bde> @ imm = #-0x306
   6856c: 1872         	adds	r2, r6, r1
   6856e: 3101         	adds	r1, #0x1
   68570: f882 088f    	strb.w	r0, [r2, #0x88f]
   68574: e7f7         	b	0x68566 <check_error+0x1ede> @ imm = #-0x12
   68576: e9dd 6152    	ldrd	r6, r1, [sp, #328]
   6857a: aa0e         	add	r2, sp, #0x38
   6857c: f502 581c    	add.w	r8, r2, #0x2700
   68580: f8dd 9180    	ldr.w	r9, [sp, #0x180]
   68584: f886 0890    	strb.w	r0, [r6, #0x890]
   68588: 9c3d         	ldr	r4, [sp, #0xf4]
   6858a: 4643         	mov	r3, r8
   6858c: 466a         	mov	r2, sp
   6858e: f504 600f    	add.w	r0, r4, #0x8f0
   68592: edd0 0b00    	vldr	d16, [r0]
   68596: f604 00f8    	addw	r0, r4, #0x8f8
   6859a: edd0 1b00    	vldr	d17, [r0]
   6859e: f504 6008    	add.w	r0, r4, #0x880
   685a2: ecf0 2b04    	vldmia	r0!, {d18, d19}
   685a6: f504 6009    	add.w	r0, r4, #0x890
   685aa: ecf0 4b04    	vldmia	r0!, {d20, d21}
   685ae: f504 600a    	add.w	r0, r4, #0x8a0
   685b2: ecf0 6b06    	vldmia	r0!, {d22, d23, d24}
   685b6: f604 00b8    	addw	r0, r4, #0x8b8
   685ba: ecc8 0b10    	vstmia	r8, {d16, d17, d18, d19, d20, d21, d22, d23}
   685be: ecf0 0b06    	vldmia	r0!, {d16, d17, d18}
   685c2: f504 600d    	add.w	r0, r4, #0x8d0
   685c6: edc8 8b10    	vstr	d24, [r8, #64]
   685ca: edd0 3b00    	vldr	d19, [r0]
   685ce: f604 00d8    	addw	r0, r4, #0x8d8
   685d2: edd0 4b00    	vldr	d20, [r0]
   685d6: f504 600e    	add.w	r0, r4, #0x8e0
   685da: edd0 5b00    	vldr	d21, [r0]
   685de: f604 00e8    	addw	r0, r4, #0x8e8
   685e2: edd0 6b00    	vldr	d22, [r0]
   685e6: f108 0048    	add.w	r0, r8, #0x48
   685ea: ece0 0b0e    	vstmia	r0!, {d16, d17, d18, d19, d20, d21, d22}
   685ee: 486a         	ldr	r0, [pc, #0x1a8]        @ 0x68798 <check_error+0x2110>
   685f0: f963 078d    	vld1.32	{d16}, [r3]!
   685f4: 3808         	subs	r0, #0x8
   685f6: f942 078d    	vst1.32	{d16}, [r2]!
   685fa: d1f9         	bne	0x685f0 <check_error+0x1f68> @ imm = #-0xe
   685fc: 9858         	ldr	r0, [sp, #0x160]
   685fe: 9a5b         	ldr	r2, [sp, #0x16c]
   68600: f005 ff4a    	bl	0x6e498 <f_check_cgm_trend> @ imm = #0x5e94
   68604: f504 6106    	add.w	r1, r4, #0x860
   68608: f04f 0c01    	mov.w	r12, #0x1
   6860c: 2601         	movs	r6, #0x1
   6860e: edd1 0b00    	vldr	d16, [r1]
   68612: f604 0158    	addw	r1, r4, #0x858
   68616: edd1 1b00    	vldr	d17, [r1]
   6861a: f504 6105    	add.w	r1, r4, #0x850
   6861e: f50d 540c    	add.w	r4, sp, #0x2300
   68622: edd1 2b00    	vldr	d18, [r1]
   68626: a90c         	add	r1, sp, #0x30
   68628: f501 5200    	add.w	r2, r1, #0x2000
   6862c: a902         	add	r1, sp, #0x8
   6862e: 9d5c         	ldr	r5, [sp, #0x170]
   68630: f501 53f6    	add.w	r3, r1, #0x1ec0
   68634: 2101         	movs	r1, #0x1
   68636: b365         	cbz	r5, 0x68692 <check_error+0x200a> @ imm = #0x58
   68638: edd4 3b00    	vldr	d19, [r4]
   6863c: eef4 3b62    	vcmp.f64	d19, d18
   68640: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68644: d904         	bls	0x68650 <check_error+0x1fc8> @ imm = #0x8
   68646: eef4 3b63    	vcmp.f64	d19, d19
   6864a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6864e: d701         	bvc	0x68654 <check_error+0x1fcc> @ imm = #0x2
   68650: f04f 0c00    	mov.w	r12, #0x0
   68654: edd3 3b00    	vldr	d19, [r3]
   68658: eef4 3b61    	vcmp.f64	d19, d17
   6865c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68660: d904         	bls	0x6866c <check_error+0x1fe4> @ imm = #0x8
   68662: eef4 3b63    	vcmp.f64	d19, d19
   68666: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6866a: d700         	bvc	0x6866e <check_error+0x1fe6> @ imm = #0x0
   6866c: 2100         	movs	r1, #0x0
   6866e: edd2 3b00    	vldr	d19, [r2]
   68672: eef4 3b60    	vcmp.f64	d19, d16
   68676: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6867a: d904         	bls	0x68686 <check_error+0x1ffe> @ imm = #0x8
   6867c: eef4 3b63    	vcmp.f64	d19, d19
   68680: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68684: d700         	bvc	0x68688 <check_error+0x2000> @ imm = #0x0
   68686: 2600         	movs	r6, #0x0
   68688: 3d01         	subs	r5, #0x1
   6868a: 3408         	adds	r4, #0x8
   6868c: 3308         	adds	r3, #0x8
   6868e: 3208         	adds	r2, #0x8
   68690: e7d1         	b	0x68636 <check_error+0x1fae> @ imm = #-0x5e
   68692: f081 0101    	eor	r1, r1, #0x1
   68696: f08c 0201    	eor	r2, r12, #0x1
   6869a: 4311         	orrs	r1, r2
   6869c: f086 0201    	eor	r2, r6, #0x1
   686a0: 4311         	orrs	r1, r2
   686a2: 9a58         	ldr	r2, [sp, #0x160]
   686a4: fab1 f181    	clz	r1, r1
   686a8: e9dd 6e52    	ldrd	r6, lr, [sp, #328]
   686ac: 4d3b         	ldr	r5, [pc, #0xec]         @ 0x6879c <check_error+0x2114>
   686ae: 0949         	lsrs	r1, r1, #0x5
   686b0: 2a64         	cmp	r2, #0x64
   686b2: d002         	beq	0x686ba <check_error+0x2032> @ imm = #0x4
   686b4: 9a58         	ldr	r2, [sp, #0x160]
   686b6: 2a03         	cmp	r2, #0x3
   686b8: d31e         	blo	0x686f8 <check_error+0x2070> @ imm = #0x3c
   686ba: 9a3d         	ldr	r2, [sp, #0xf4]
   686bc: f50d 530c    	add.w	r3, sp, #0x2300
   686c0: 9c5c         	ldr	r4, [sp, #0x170]
   686c2: f602 0248    	addw	r2, r2, #0x848
   686c6: edd2 0b00    	vldr	d16, [r2]
   686ca: 2201         	movs	r2, #0x1
   686cc: b17c         	cbz	r4, 0x686ee <check_error+0x2066> @ imm = #0x1e
   686ce: edd3 1b00    	vldr	d17, [r3]
   686d2: eef4 1b60    	vcmp.f64	d17, d16
   686d6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   686da: d904         	bls	0x686e6 <check_error+0x205e> @ imm = #0x8
   686dc: eef4 1b61    	vcmp.f64	d17, d17
   686e0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   686e4: d700         	bvc	0x686e8 <check_error+0x2060> @ imm = #0x0
   686e6: 2200         	movs	r2, #0x0
   686e8: 3c01         	subs	r4, #0x1
   686ea: 3308         	adds	r3, #0x8
   686ec: e7ee         	b	0x686cc <check_error+0x2044> @ imm = #-0x24
   686ee: 3a01         	subs	r2, #0x1
   686f0: fab2 f282    	clz	r2, r2
   686f4: 0952         	lsrs	r2, r2, #0x5
   686f6: 4311         	orrs	r1, r2
   686f8: 2801         	cmp	r0, #0x1
   686fa: d103         	bne	0x68704 <check_error+0x207c> @ imm = #0x6
   686fc: b111         	cbz	r1, 0x68704 <check_error+0x207c> @ imm = #0x4
   686fe: 2001         	movs	r0, #0x1
   68700: f886 0891    	strb.w	r0, [r6, #0x891]
   68704: 982e         	ldr	r0, [sp, #0xb8]
   68706: edd0 0b10    	vldr	d16, [r0, #64]
   6870a: eef4 0b60    	vcmp.f64	d16, d16
   6870e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68712: d617         	bvs	0x68744 <check_error+0x20bc> @ imm = #0x2e
   68714: ed90 0a74    	vldr	s0, [r0, #464]
   68718: ed9f 9b21    	vldr	d9, [pc, #132]          @ 0x687a0 <check_error+0x2118>
   6871c: eeb8 8b40    	vcvt.f64.u32	d8, s0
   68720: 983d         	ldr	r0, [sp, #0xf4]
   68722: f500 60dd    	add.w	r0, r0, #0x6e8
   68726: ed96 0a01    	vldr	s0, [r6, #4]
   6872a: edd0 1b00    	vldr	d17, [r0]
   6872e: eef8 0b40    	vcvt.f64.u32	d16, s0
   68732: ee70 0bc8    	vsub.f64	d16, d16, d8
   68736: eec0 0b89    	vdiv.f64	d16, d16, d9
   6873a: eef4 0b61    	vcmp.f64	d16, d17
   6873e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68742: d907         	bls	0x68754 <check_error+0x20cc> @ imm = #0xe
   68744: f8dd 8158    	ldr.w	r8, [sp, #0x158]
   68748: 2000         	movs	r0, #0x0
   6874a: f886 0894    	strb.w	r0, [r6, #0x894]
   6874e: f8a6 0892    	strh.w	r0, [r6, #0x892]
   68752: e168         	b	0x68a26 <check_error+0x239e> @ imm = #0x2d0
   68754: 983d         	ldr	r0, [sp, #0xf4]
   68756: 462b         	mov	r3, r5
   68758: f8b0 2626    	ldrh.w	r2, [r0, #0x626]
   6875c: 2000         	movs	r0, #0x0
   6875e: eba9 0102    	sub.w	r1, r9, r2
   68762: b34b         	cbz	r3, 0x687b8 <check_error+0x2130> @ imm = #0x52
   68764: eb0e 0403    	add.w	r4, lr, r3
   68768: 2500         	movs	r5, #0x0
   6876a: f8b4 4d0c    	ldrh.w	r4, [r4, #0xd0c]
   6876e: 42a1         	cmp	r1, r4
   68770: bfb8         	it	lt
   68772: 2501         	movlt	r5, #0x1
   68774: 2c00         	cmp	r4, #0x0
   68776: 4626         	mov	r6, r4
   68778: bf18         	it	ne
   6877a: 2601         	movne	r6, #0x1
   6877c: 4035         	ands	r5, r6
   6877e: 9e52         	ldr	r6, [sp, #0x148]
   68780: 454c         	cmp	r4, r9
   68782: f04f 0400    	mov.w	r4, #0x0
   68786: bf98         	it	ls
   68788: 2401         	movls	r4, #0x1
   6878a: 3302         	adds	r3, #0x2
   6878c: 402c         	ands	r4, r5
   6878e: 4d03         	ldr	r5, [pc, #0xc]          @ 0x6879c <check_error+0x2114>
   68790: 4420         	add	r0, r4
   68792: e7e6         	b	0x68762 <check_error+0x20da> @ imm = #-0x34
   68794: 00 00 f8 7f  	.word	0x7ff80000
   68798: 80 00 00 00  	.word	0x00000080
   6879c: 3e f9 ff ff  	.word	0xfffff93e
   687a0: 00 00 00 00  	.word	0x00000000
   687a4: 00 18 f5 40  	.word	0x40f51800
   687a8: 00 00 00 00  	.word	0x00000000
   687ac: 00 c0 72 c0  	.word	0xc072c000
   687b0: 00 00 00 00  	.word	0x00000000
   687b4: 00 00 72 40  	.word	0x40720000
   687b8: b280         	uxth	r0, r0
   687ba: 4290         	cmp	r0, r2
   687bc: d15d         	bne	0x6887a <check_error+0x21f2> @ imm = #0xba
   687be: 993d         	ldr	r1, [sp, #0xf4]
   687c0: f501 60d3    	add.w	r0, r1, #0x698
   687c4: edd0 0b00    	vldr	d16, [r0]
   687c8: f501 60d4    	add.w	r0, r1, #0x6a0
   687cc: edd0 1b00    	vldr	d17, [r0]
   687d0: f501 60c5    	add.w	r0, r1, #0x628
   687d4: ecf0 2b04    	vldmia	r0!, {d18, d19}
   687d8: f501 60c7    	add.w	r0, r1, #0x638
   687dc: ecf0 4b04    	vldmia	r0!, {d20, d21}
   687e0: f501 60c9    	add.w	r0, r1, #0x648
   687e4: ecf0 6b06    	vldmia	r0!, {d22, d23, d24}
   687e8: f501 60cc    	add.w	r0, r1, #0x660
   687ec: ecc8 0b10    	vstmia	r8, {d16, d17, d18, d19, d20, d21, d22, d23}
   687f0: ecf0 0b06    	vldmia	r0!, {d16, d17, d18}
   687f4: f501 60cf    	add.w	r0, r1, #0x678
   687f8: edc8 8b10    	vstr	d24, [r8, #64]
   687fc: edd0 3b00    	vldr	d19, [r0]
   68800: f501 60d0    	add.w	r0, r1, #0x680
   68804: edd0 4b00    	vldr	d20, [r0]
   68808: f501 60d1    	add.w	r0, r1, #0x688
   6880c: edd0 5b00    	vldr	d21, [r0]
   68810: f501 60d2    	add.w	r0, r1, #0x690
   68814: 4669         	mov	r1, sp
   68816: edd0 6b00    	vldr	d22, [r0]
   6881a: f108 0048    	add.w	r0, r8, #0x48
   6881e: ece0 0b0e    	vstmia	r0!, {d16, d17, d18, d19, d20, d21, d22}
   68822: 48e8         	ldr	r0, [pc, #0x3a0]        @ 0x68bc4 <check_error+0x253c>
   68824: f968 078d    	vld1.32	{d16}, [r8]!
   68828: 3808         	subs	r0, #0x8
   6882a: f941 078d    	vst1.32	{d16}, [r1]!
   6882e: d1f9         	bne	0x68824 <check_error+0x219c> @ imm = #-0xe
   68830: 9858         	ldr	r0, [sp, #0x160]
   68832: 4671         	mov	r1, lr
   68834: 4674         	mov	r4, lr
   68836: f005 fe2f    	bl	0x6e498 <f_check_cgm_trend> @ imm = #0x5c5e
   6883a: 2801         	cmp	r0, #0x1
   6883c: d125         	bne	0x6888a <check_error+0x2202> @ imm = #0x4a
   6883e: 9a3d         	ldr	r2, [sp, #0xf4]
   68840: f24c 5030    	movw	r0, #0xc530
   68844: f8dd 8158    	ldr.w	r8, [sp, #0x158]
   68848: 4420         	add	r0, r4
   6884a: f892 1620    	ldrb.w	r1, [r2, #0x620]
   6884e: f502 62d5    	add.w	r2, r2, #0x6a8
   68852: edd2 0b00    	vldr	d16, [r2]
   68856: 2201         	movs	r2, #0x1
   68858: b1f1         	cbz	r1, 0x68898 <check_error+0x2210> @ imm = #0x3c
   6885a: edd0 1b00    	vldr	d17, [r0]
   6885e: eef4 1b60    	vcmp.f64	d17, d16
   68862: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68866: da04         	bge	0x68872 <check_error+0x21ea> @ imm = #0x8
   68868: eef4 1b61    	vcmp.f64	d17, d17
   6886c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68870: d700         	bvc	0x68874 <check_error+0x21ec> @ imm = #0x0
   68872: 2200         	movs	r2, #0x0
   68874: 3901         	subs	r1, #0x1
   68876: 3008         	adds	r0, #0x8
   68878: e7ee         	b	0x68858 <check_error+0x21d0> @ imm = #-0x24
   6887a: f8dd 8158    	ldr.w	r8, [sp, #0x158]
   6887e: 2000         	movs	r0, #0x0
   68880: f886 0894    	strb.w	r0, [r6, #0x894]
   68884: f8a6 0892    	strh.w	r0, [r6, #0x892]
   68888: e0a5         	b	0x689d6 <check_error+0x234e> @ imm = #0x14a
   6888a: f8dd 8158    	ldr.w	r8, [sp, #0x158]
   6888e: 2000         	movs	r0, #0x0
   68890: 46a6         	mov	lr, r4
   68892: f8a6 0892    	strh.w	r0, [r6, #0x892]
   68896: e09c         	b	0x689d2 <check_error+0x234a> @ imm = #0x138
   68898: 2a01         	cmp	r2, #0x1
   6889a: d117         	bne	0x688cc <check_error+0x2244> @ imm = #0x2e
   6889c: 982e         	ldr	r0, [sp, #0xb8]
   6889e: ed90 0a76    	vldr	s0, [r0, #472]
   688a2: 983d         	ldr	r0, [sp, #0xf4]
   688a4: eef8 0b40    	vcvt.f64.u32	d16, s0
   688a8: f8b0 0622    	ldrh.w	r0, [r0, #0x622]
   688ac: ee78 0b60    	vsub.f64	d16, d8, d16
   688b0: eec0 0b89    	vdiv.f64	d16, d16, d9
   688b4: ee00 0a10    	vmov	s0, r0
   688b8: eef8 1b40    	vcvt.f64.u32	d17, s0
   688bc: eef4 0b61    	vcmp.f64	d16, d17
   688c0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   688c4: bf9c         	itt	ls
   688c6: 2001         	movls	r0, #0x1
   688c8: f886 0892    	strbls.w	r0, [r6, #0x892]
   688cc: 9c3d         	ldr	r4, [sp, #0xf4]
   688ce: ed5f 1b4a    	vldr	d17, [pc, #-296]        @ 0x687a8 <check_error+0x2120>
   688d2: 8ba0         	ldrh	r0, [r4, #0x1c]
   688d4: ee00 0a10    	vmov	s0, r0
   688d8: eef8 0b40    	vcvt.f64.u32	d16, s0
   688dc: eec0 0ba1    	vdiv.f64	d16, d16, d17
   688e0: ee00 9a10    	vmov	s0, r9
   688e4: eef8 1b40    	vcvt.f64.u32	d17, s0
   688e8: ee71 0ba0    	vadd.f64	d16, d17, d16
   688ec: ed5f 1b50    	vldr	d17, [pc, #-320]        @ 0x687b0 <check_error+0x2128>
   688f0: ee80 0ba1    	vdiv.f64	d0, d16, d17
   688f4: f004 fa78    	bl	0x6cde8 <math_ceil>     @ imm = #0x44f0
   688f8: eebc 0bc0    	vcvt.u32.f64	s0, d0
   688fc: f504 60db    	add.w	r0, r4, #0x6d8
   68900: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   68904: f64c 0288    	movw	r2, #0xc888
   68908: edd0 1b00    	vldr	d17, [r0]
   6890c: 9822         	ldr	r0, [sp, #0x88]
   6890e: edd0 0bd2    	vldr	d16, [r0, #840]
   68912: ee10 0a10    	vmov	r0, s0
   68916: ee70 2ba1    	vadd.f64	d18, d16, d17
   6891a: eb0e 01c0    	add.w	r1, lr, r0, lsl #3
   6891e: 4411         	add	r1, r2
   68920: edd1 1b00    	vldr	d17, [r1]
   68924: eef4 1b62    	vcmp.f64	d17, d18
   68928: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6892c: bf42         	ittt	mi
   6892e: 2201         	movmi	r2, #0x1
   68930: f886 2893    	strbmi.w	r2, [r6, #0x893]
   68934: edd1 1b00    	vldrmi	d17, [r1]
   68938: 993d         	ldr	r1, [sp, #0xf4]
   6893a: f501 61da    	add.w	r1, r1, #0x6d0
   6893e: edd1 2b00    	vldr	d18, [r1]
   68942: ee70 0ba2    	vadd.f64	d16, d16, d18
   68946: eef4 1b60    	vcmp.f64	d17, d16
   6894a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6894e: d542         	bpl	0x689d6 <check_error+0x234e> @ imm = #0x84
   68950: eb0e 0040    	add.w	r0, lr, r0, lsl #1
   68954: f64c 1180    	movw	r1, #0xc980
   68958: 5a40         	ldrh	r0, [r0, r1]
   6895a: 993d         	ldr	r1, [sp, #0xf4]
   6895c: ee00 0a10    	vmov	s0, r0
   68960: 9821         	ldr	r0, [sp, #0x84]
   68962: eef8 0b40    	vcvt.f64.u32	d16, s0
   68966: edd0 1b00    	vldr	d17, [r0]
   6896a: f501 60d7    	add.w	r0, r1, #0x6b8
   6896e: edd0 2b00    	vldr	d18, [r0]
   68972: eef4 1b62    	vcmp.f64	d17, d18
   68976: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6897a: d91e         	bls	0x689ba <check_error+0x2332> @ imm = #0x3c
   6897c: f501 60d9    	add.w	r0, r1, #0x6c8
   68980: edd0 2b00    	vldr	d18, [r0]
   68984: ee61 1ba2    	vmul.f64	d17, d17, d18
   68988: e01d         	b	0x689c6 <check_error+0x233e> @ imm = #0x3a
   6898a: 982e         	ldr	r0, [sp, #0xb8]
   6898c: edd0 0ba6    	vldr	d16, [r0, #664]
   68990: 983d         	ldr	r0, [sp, #0xf4]
   68992: f500 60df    	add.w	r0, r0, #0x6f8
   68996: edd0 1b00    	vldr	d17, [r0]
   6899a: eef4 0b61    	vcmp.f64	d16, d17
   6899e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   689a2: f63f ac60    	bhi.w	0x68266 <check_error+0x1bde> @ imm = #-0x740
   689a6: 2000         	movs	r0, #0x0
   689a8: 2100         	movs	r1, #0x0
   689aa: 2906         	cmp	r1, #0x6
   689ac: f43f ac5b    	beq.w	0x68266 <check_error+0x1bde> @ imm = #-0x74a
   689b0: 1872         	adds	r2, r6, r1
   689b2: 3101         	adds	r1, #0x1
   689b4: f882 088f    	strb.w	r0, [r2, #0x88f]
   689b8: e7f7         	b	0x689aa <check_error+0x2322> @ imm = #-0x12
   689ba: f501 60d8    	add.w	r0, r1, #0x6c0
   689be: edd0 2b00    	vldr	d18, [r0]
   689c2: ee71 1ba2    	vadd.f64	d17, d17, d18
   689c6: eef4 1b60    	vcmp.f64	d17, d16
   689ca: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   689ce: d502         	bpl	0x689d6 <check_error+0x234e> @ imm = #0x4
   689d0: 2001         	movs	r0, #0x1
   689d2: f886 0894    	strb.w	r0, [r6, #0x894]
   689d6: 9822         	ldr	r0, [sp, #0x88]
   689d8: edd0 0b64    	vldr	d16, [r0, #400]
   689dc: eef5 0b40    	vcmp.f64	d16, #0
   689e0: eef1 1b60    	vneg.f64	d17, d16
   689e4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   689e8: bf48         	it	mi
   689ea: eef0 0b61    	vmovmi.f64	d16, d17
   689ee: 983d         	ldr	r0, [sp, #0xf4]
   689f0: f500 60de    	add.w	r0, r0, #0x6f0
   689f4: edd0 1b00    	vldr	d17, [r0]
   689f8: eef4 0b61    	vcmp.f64	d16, d17
   689fc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68a00: d811         	bhi	0x68a26 <check_error+0x239e> @ imm = #0x22
   68a02: 9858         	ldr	r0, [sp, #0x160]
   68a04: 2803         	cmp	r0, #0x3
   68a06: f0c0 8305    	blo.w	0x69014 <check_error+0x298c> @ imm = #0x60a
   68a0a: 982e         	ldr	r0, [sp, #0xb8]
   68a0c: edd0 0ba6    	vldr	d16, [r0, #664]
   68a10: 983d         	ldr	r0, [sp, #0xf4]
   68a12: f500 60df    	add.w	r0, r0, #0x6f8
   68a16: edd0 1b00    	vldr	d17, [r0]
   68a1a: eef4 0b61    	vcmp.f64	d16, d17
   68a1e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68a22: f240 82f7    	bls.w	0x69014 <check_error+0x298c> @ imm = #0x5ee
   68a26: 9a3d         	ldr	r2, [sp, #0xf4]
   68a28: f24c 60c0    	movw	r0, #0xc6c0
   68a2c: 4470         	add	r0, lr
   68a2e: f892 1620    	ldrb.w	r1, [r2, #0x620]
   68a32: f502 62d6    	add.w	r2, r2, #0x6b0
   68a36: edd2 0b00    	vldr	d16, [r2]
   68a3a: 2201         	movs	r2, #0x1
   68a3c: b1d1         	cbz	r1, 0x68a74 <check_error+0x23ec> @ imm = #0x34
   68a3e: edd0 1b00    	vldr	d17, [r0]
   68a42: eef5 1b40    	vcmp.f64	d17, #0
   68a46: eef0 3b61    	vmov.f64	d19, d17
   68a4a: eef1 2b61    	vneg.f64	d18, d17
   68a4e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68a52: bf48         	it	mi
   68a54: eef0 3b62    	vmovmi.f64	d19, d18
   68a58: eef4 3b60    	vcmp.f64	d19, d16
   68a5c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68a60: d904         	bls	0x68a6c <check_error+0x23e4> @ imm = #0x8
   68a62: eef4 1b61    	vcmp.f64	d17, d17
   68a66: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68a6a: d700         	bvc	0x68a6e <check_error+0x23e6> @ imm = #0x0
   68a6c: 2200         	movs	r2, #0x0
   68a6e: 3901         	subs	r1, #0x1
   68a70: 3008         	adds	r0, #0x8
   68a72: e7e3         	b	0x68a3c <check_error+0x23b4> @ imm = #-0x3a
   68a74: 2a01         	cmp	r2, #0x1
   68a76: d11d         	bne	0x68ab4 <check_error+0x242c> @ imm = #0x3a
   68a78: 982e         	ldr	r0, [sp, #0xb8]
   68a7a: ed90 0a74    	vldr	s0, [r0, #464]
   68a7e: ed90 1a76    	vldr	s2, [r0, #472]
   68a82: eef8 1b40    	vcvt.f64.u32	d17, s0
   68a86: 983d         	ldr	r0, [sp, #0xf4]
   68a88: f8b0 0622    	ldrh.w	r0, [r0, #0x622]
   68a8c: eef8 0b41    	vcvt.f64.u32	d16, s2
   68a90: ee71 0be0    	vsub.f64	d16, d17, d16
   68a94: ed5f 1bbe    	vldr	d17, [pc, #-760]        @ 0x687a0 <check_error+0x2118>
   68a98: ee00 0a10    	vmov	s0, r0
   68a9c: eec0 0ba1    	vdiv.f64	d16, d16, d17
   68aa0: eef8 1b40    	vcvt.f64.u32	d17, s0
   68aa4: eef4 0b61    	vcmp.f64	d16, d17
   68aa8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68aac: bf9c         	itt	ls
   68aae: 2001         	movls	r0, #0x1
   68ab0: f886 0895    	strbls.w	r0, [r6, #0x895]
   68ab4: 985e         	ldr	r0, [sp, #0x178]
   68ab6: 2801         	cmp	r0, #0x1
   68ab8: d908         	bls	0x68acc <check_error+0x2444> @ imm = #0x10
   68aba: 9834         	ldr	r0, [sp, #0xd0]
   68abc: f890 0128    	ldrb.w	r0, [r0, #0x128]
   68ac0: 2801         	cmp	r0, #0x1
   68ac2: d103         	bne	0x68acc <check_error+0x2444> @ imm = #0x6
   68ac4: 2001         	movs	r0, #0x1
   68ac6: f886 07ac    	strb.w	r0, [r6, #0x7ac]
   68aca: e00e         	b	0x68aea <check_error+0x2462> @ imm = #0x1c
   68acc: 2000         	movs	r0, #0x0
   68ace: 2101         	movs	r1, #0x1
   68ad0: 2807         	cmp	r0, #0x7
   68ad2: d008         	beq	0x68ae6 <check_error+0x245e> @ imm = #0x10
   68ad4: 1832         	adds	r2, r6, r0
   68ad6: f892 288f    	ldrb.w	r2, [r2, #0x88f]
   68ada: 2a01         	cmp	r2, #0x1
   68adc: bf08         	it	eq
   68ade: f886 17ac    	strbeq.w	r1, [r6, #0x7ac]
   68ae2: 3001         	adds	r0, #0x1
   68ae4: e7f4         	b	0x68ad0 <check_error+0x2448> @ imm = #-0x18
   68ae6: f896 07ac    	ldrb.w	r0, [r6, #0x7ac]
   68aea: 9934         	ldr	r1, [sp, #0xd0]
   68aec: f881 0128    	strb.w	r0, [r1, #0x128]
   68af0: 982c         	ldr	r0, [sp, #0xb0]
   68af2: edd0 0b00    	vldr	d16, [r0]
   68af6: 983d         	ldr	r0, [sp, #0xf4]
   68af8: edca 0b10    	vstr	d16, [r10, #64]
   68afc: f8b0 0084    	ldrh.w	r0, [r0, #0x84]
   68b00: 4581         	cmp	r9, r0
   68b02: bf84         	itt	hi
   68b04: f8ba 0014    	ldrhhi.w	r0, [r10, #0x14]
   68b08: f5b0 7f90    	cmphi.w	r0, #0x120
   68b0c: d838         	bhi	0x68b80 <check_error+0x24f8> @ imm = #0x70
   68b0e: 45c1         	cmp	r9, r8
   68b10: d333         	blo	0x68b7a <check_error+0x24f2> @ imm = #0x66
   68b12: f1b8 0f00    	cmp.w	r8, #0x0
   68b16: d030         	beq	0x68b7a <check_error+0x24f2> @ imm = #0x60
   68b18: f89a 004a    	ldrb.w	r0, [r10, #0x4a]
   68b1c: 2864         	cmp	r0, #0x64
   68b1e: bf18         	it	ne
   68b20: 2800         	cmpne	r0, #0x0
   68b22: f040 810f    	bne.w	0x68d44 <check_error+0x26bc> @ imm = #0x21e
   68b26: 983d         	ldr	r0, [sp, #0xf4]
   68b28: f20e 624a    	addw	r2, lr, #0x64a
   68b2c: 2100         	movs	r1, #0x0
   68b2e: 462b         	mov	r3, r5
   68b30: edd0 0bf2    	vldr	d16, [r0, #968]
   68b34: eebd 0be0    	vcvt.s32.f64	s0, d16
   68b38: ee10 0a10    	vmov	r0, s0
   68b3c: eba9 0c00    	sub.w	r12, r9, r0
   68b40: b30b         	cbz	r3, 0x68b86 <check_error+0x24fe> @ imm = #0x42
   68b42: 45c1         	cmp	r9, r8
   68b44: f04f 0400    	mov.w	r4, #0x0
   68b48: bf88         	it	hi
   68b4a: 2401         	movhi	r4, #0x1
   68b4c: 18d5         	adds	r5, r2, r3
   68b4e: 2600         	movs	r6, #0x0
   68b50: f8b5 06c2    	ldrh.w	r0, [r5, #0x6c2]
   68b54: 4584         	cmp	r12, r0
   68b56: bfb8         	it	lt
   68b58: 2601         	movlt	r6, #0x1
   68b5a: 4605         	mov	r5, r0
   68b5c: 2800         	cmp	r0, #0x0
   68b5e: bf18         	it	ne
   68b60: 2501         	movne	r5, #0x1
   68b62: 4035         	ands	r5, r6
   68b64: 9e52         	ldr	r6, [sp, #0x148]
   68b66: 4548         	cmp	r0, r9
   68b68: f04f 0000    	mov.w	r0, #0x0
   68b6c: bf98         	it	ls
   68b6e: 2001         	movls	r0, #0x1
   68b70: 3302         	adds	r3, #0x2
   68b72: 4028         	ands	r0, r5
   68b74: 4020         	ands	r0, r4
   68b76: 4401         	add	r1, r0
   68b78: e7e2         	b	0x68b40 <check_error+0x24b8> @ imm = #-0x3c
   68b7a: f89a 004a    	ldrb.w	r0, [r10, #0x4a]
   68b7e: e0e1         	b	0x68d44 <check_error+0x26bc> @ imm = #0x1c2
   68b80: f89a 0016    	ldrb.w	r0, [r10, #0x16]
   68b84: e0dc         	b	0x68d40 <check_error+0x26b8> @ imm = #0x1b8
   68b86: b288         	uxth	r0, r1
   68b88: f24e 42c8    	movw	r2, #0xe4c8
   68b8c: f1c0 0124    	rsb.w	r1, r0, #0x24
   68b90: 4603         	mov	r3, r0
   68b92: eb0e 01c1    	add.w	r1, lr, r1, lsl #3
   68b96: 4411         	add	r1, r2
   68b98: 9a3d         	ldr	r2, [sp, #0xf4]
   68b9a: edd2 1bf4    	vldr	d17, [r2, #976]
   68b9e: 2201         	movs	r2, #0x1
   68ba0: b1b3         	cbz	r3, 0x68bd0 <check_error+0x2548> @ imm = #0x2c
   68ba2: edd1 2b00    	vldr	d18, [r1]
   68ba6: eef4 2b61    	vcmp.f64	d18, d17
   68baa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68bae: d501         	bpl	0x68bb4 <check_error+0x252c> @ imm = #0x2
   68bb0: 2200         	movs	r2, #0x0
   68bb2: e004         	b	0x68bbe <check_error+0x2536> @ imm = #0x8
   68bb4: eef4 2b62    	vcmp.f64	d18, d18
   68bb8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68bbc: d6f8         	bvs	0x68bb0 <check_error+0x2528> @ imm = #-0x10
   68bbe: 3b01         	subs	r3, #0x1
   68bc0: 3108         	adds	r1, #0x8
   68bc2: e7ed         	b	0x68ba0 <check_error+0x2518> @ imm = #-0x26
   68bc4: 80 00 00 00  	.word	0x00000080
   68bc8: 00 00 00 00  	.word	0x00000000
   68bcc: 00 00 59 40  	.word	0x40590000
   68bd0: ee00 0a10    	vmov	s0, r0
   68bd4: 2100         	movs	r1, #0x0
   68bd6: 2000         	movs	r0, #0x0
   68bd8: eef8 1b40    	vcvt.f64.u32	d17, s0
   68bdc: eef4 0b61    	vcmp.f64	d16, d17
   68be0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68be4: bf08         	it	eq
   68be6: 2001         	moveq	r0, #0x1
   68be8: 3a01         	subs	r2, #0x1
   68bea: fab2 f282    	clz	r2, r2
   68bee: 0952         	lsrs	r2, r2, #0x5
   68bf0: 4002         	ands	r2, r0
   68bf2: 4610         	mov	r0, r2
   68bf4: bf18         	it	ne
   68bf6: 2006         	movne	r0, #0x6
   68bf8: f8ba 3048    	ldrh.w	r3, [r10, #0x48]
   68bfc: 45c1         	cmp	r9, r8
   68bfe: d95c         	bls	0x68cba <check_error+0x2632> @ imm = #0xb8
   68c00: 3301         	adds	r3, #0x1
   68c02: eddb 0b48    	vldr	d16, [r11, #288]
   68c06: b29c         	uxth	r4, r3
   68c08: edda 1b14    	vldr	d17, [r10, #80]
   68c0c: edda 2b16    	vldr	d18, [r10, #88]
   68c10: ee00 4a10    	vmov	s0, r4
   68c14: f04f 34ff    	mov.w	r4, #0xffffffff
   68c18: fa14 f483    	uxtah	r4, r4, r3
   68c1c: ee71 3ba0    	vadd.f64	d19, d17, d16
   68c20: f8aa 3048    	strh.w	r3, [r10, #0x48]
   68c24: eef8 4b40    	vcvt.f64.u32	d20, s0
   68c28: ee00 4a10    	vmov	s0, r4
   68c2c: edca 3b14    	vstr	d19, [r10, #80]
   68c30: eec3 3ba4    	vdiv.f64	d19, d19, d20
   68c34: 9c3d         	ldr	r4, [sp, #0xf4]
   68c36: eef8 6bc0    	vcvt.f64.s32	d22, s0
   68c3a: eec1 1ba6    	vdiv.f64	d17, d17, d22
   68c3e: ee70 5be3    	vsub.f64	d21, d16, d19
   68c42: ee70 1be1    	vsub.f64	d17, d16, d17
   68c46: ee41 2ba5    	vmla.f64	d18, d17, d21
   68c4a: edca 2b16    	vstr	d18, [r10, #88]
   68c4e: eec2 1ba4    	vdiv.f64	d17, d18, d20
   68c52: eef1 1be1    	vsqrt.f64	d17, d17
   68c56: eec1 1ba3    	vdiv.f64	d17, d17, d19
   68c5a: ed5f 2b25    	vldr	d18, [pc, #-148]        @ 0x68bc8 <check_error+0x2540>
   68c5e: ee61 1ba2    	vmul.f64	d17, d17, d18
   68c62: edca 1b1c    	vstr	d17, [r10, #112]
   68c66: edd4 1bfc    	vldr	d17, [r4, #1008]
   68c6a: eef4 0b61    	vcmp.f64	d16, d17
   68c6e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68c72: db07         	blt	0x68c84 <check_error+0x25fc> @ imm = #0xe
   68c74: eef7 2b00    	vmov.f64	d18, #1.000000e+00
   68c78: edda 1b18    	vldr	d17, [r10, #96]
   68c7c: ee71 1ba2    	vadd.f64	d17, d17, d18
   68c80: edca 1b18    	vstr	d17, [r10, #96]
   68c84: 9d3d         	ldr	r5, [sp, #0xf4]
   68c86: f505 6480    	add.w	r4, r5, #0x400
   68c8a: edd4 1b00    	vldr	d17, [r4]
   68c8e: eef4 0b61    	vcmp.f64	d16, d17
   68c92: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68c96: db10         	blt	0x68cba <check_error+0x2632> @ imm = #0x20
   68c98: f505 6481    	add.w	r4, r5, #0x408
   68c9c: edd4 1b00    	vldr	d17, [r4]
   68ca0: eef4 0b61    	vcmp.f64	d16, d17
   68ca4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68ca8: d807         	bhi	0x68cba <check_error+0x2632> @ imm = #0xe
   68caa: eef7 1b00    	vmov.f64	d17, #1.000000e+00
   68cae: edda 0b1a    	vldr	d16, [r10, #104]
   68cb2: ee70 0ba1    	vadd.f64	d16, d16, d17
   68cb6: edca 0b1a    	vstr	d16, [r10, #104]
   68cba: 9d3d         	ldr	r5, [sp, #0xf4]
   68cbc: b29b         	uxth	r3, r3
   68cbe: f8b5 43d8    	ldrh.w	r4, [r5, #0x3d8]
   68cc2: 42a3         	cmp	r3, r4
   68cc4: bf2c         	ite	hs
   68cc6: 2006         	movhs	r0, #0x6
   68cc8: 2101         	movlo	r1, #0x1
   68cca: 4311         	orrs	r1, r2
   68ccc: d137         	bne	0x68d3e <check_error+0x26b6> @ imm = #0x6e
   68cce: ee00 3a10    	vmov	s0, r3
   68cd2: edda 1b14    	vldr	d17, [r10, #80]
   68cd6: edd5 2bf8    	vldr	d18, [r5, #992]
   68cda: eef8 0b40    	vcvt.f64.u32	d16, s0
   68cde: eec1 1ba0    	vdiv.f64	d17, d17, d16
   68ce2: eef4 1b62    	vcmp.f64	d17, d18
   68ce6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68cea: dc27         	bgt	0x68d3c <check_error+0x26b4> @ imm = #0x4e
   68cec: edd5 1bfa    	vldr	d17, [r5, #1000]
   68cf0: edda 2b1c    	vldr	d18, [r10, #112]
   68cf4: eef4 2b61    	vcmp.f64	d18, d17
   68cf8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68cfc: dc1e         	bgt	0x68d3c <check_error+0x26b4> @ imm = #0x3c
   68cfe: edda 1b18    	vldr	d17, [r10, #96]
   68d02: edd5 3bfe    	vldr	d19, [r5, #1016]
   68d06: eec1 2ba0    	vdiv.f64	d18, d17, d16
   68d0a: ed5f 1b51    	vldr	d17, [pc, #-324]        @ 0x68bc8 <check_error+0x2540>
   68d0e: ee62 2ba1    	vmul.f64	d18, d18, d17
   68d12: eef4 2b63    	vcmp.f64	d18, d19
   68d16: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68d1a: dc0f         	bgt	0x68d3c <check_error+0x26b4> @ imm = #0x1e
   68d1c: edda 2b1a    	vldr	d18, [r10, #104]
   68d20: f505 6082    	add.w	r0, r5, #0x410
   68d24: eec2 0ba0    	vdiv.f64	d16, d18, d16
   68d28: ee60 0ba1    	vmul.f64	d16, d16, d17
   68d2c: edd0 1b00    	vldr	d17, [r0]
   68d30: eef4 0b61    	vcmp.f64	d16, d17
   68d34: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   68d38: f142 8311    	bpl.w	0x6b35e <check_error+0x4cd6> @ imm = #0x2622
   68d3c: 2006         	movs	r0, #0x6
   68d3e: 4de7         	ldr	r5, [pc, #0x39c]        @ 0x690dc <check_error+0x2a54>
   68d40: f88a 004a    	strb.w	r0, [r10, #0x4a]
   68d44: f886 0798    	strb.w	r0, [r6, #0x798]
   68d48: f8be 1648    	ldrh.w	r1, [lr, #0x648]
   68d4c: 2901         	cmp	r1, #0x1
   68d4e: d121         	bne	0x68d94 <check_error+0x270c> @ imm = #0x42
   68d50: 2100         	movs	r1, #0x0
   68d52: f644 4028    	movw	r0, #0x4c28
   68d56: f8dd 809c    	ldr.w	r8, [sp, #0x9c]
   68d5a: 9b39         	ldr	r3, [sp, #0xe4]
   68d5c: f84e 1000    	str.w	r1, [lr, r0]
   68d60: 4470         	add	r0, lr
   68d62: 4adf         	ldr	r2, [pc, #0x37c]        @ 0x690e0 <check_error+0x2a58>
   68d64: f8c6 17b0    	str.w	r1, [r6, #0x7b0]
   68d68: f8c6 17b4    	str.w	r1, [r6, #0x7b4]
   68d6c: f8c6 17c0    	str.w	r1, [r6, #0x7c0]
   68d70: f8c6 17c4    	str.w	r1, [r6, #0x7c4]
   68d74: f886 17b8    	strb.w	r1, [r6, #0x7b8]
   68d78: 6119         	str	r1, [r3, #0x10]
   68d7a: e9c3 2105    	strd	r2, r1, [r3, #20]
   68d7e: e9c3 2107    	strd	r2, r1, [r3, #28]
   68d82: e9c3 2109    	strd	r2, r1, [r3, #36]
   68d86: e9c3 210b    	strd	r2, r1, [r3, #44]
   68d8a: e9c3 210d    	strd	r2, r1, [r3, #52]
   68d8e: 63da         	str	r2, [r3, #0x3c]
   68d90: 7101         	strb	r1, [r0, #0x4]
   68d92: e377         	b	0x69484 <check_error+0x2dfc> @ imm = #0x6ee
   68d94: f8be 0d08    	ldrh.w	r0, [lr, #0xd08]
   68d98: f8dd 809c    	ldr.w	r8, [sp, #0x9c]
   68d9c: eba9 0000    	sub.w	r0, r9, r0
   68da0: 2801         	cmp	r0, #0x1
   68da2: d154         	bne	0x68e4e <check_error+0x27c6> @ imm = #0xa8
   68da4: f8dd a0f4    	ldr.w	r10, [sp, #0xf4]
   68da8: f8ba 641a    	ldrh.w	r6, [r10, #0x41a]
   68dac: 45b1         	cmp	r9, r6
   68dae: d950         	bls	0x68e52 <check_error+0x27ca> @ imm = #0xa0
   68db0: f50d 78cc    	add.w	r8, sp, #0x198
   68db4: 9163         	str	r1, [sp, #0x18c]
   68db6: 21f0         	movs	r1, #0xf0
   68db8: 4640         	mov	r0, r8
   68dba: f006 e922    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x6244
   68dbe: f60d 2b08    	addw	r11, sp, #0xa08
   68dc2: efc0 0050    	vmov.i32	q8, #0x0
   68dc6: 464c         	mov	r4, r9
   68dc8: f04f 0900    	mov.w	r9, #0x0
   68dcc: 4658         	mov	r0, r11
   68dce: 2164         	movs	r1, #0x64
   68dd0: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   68dd4: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   68dd8: f8c0 9000    	str.w	r9, [r0]
   68ddc: f50d 5080    	add.w	r0, sp, #0x1000
   68de0: f8cd 9a2c    	str.w	r9, [sp, #0xa2c]
   68de4: f006 e90c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x6218
   68de8: a80c         	add	r0, sp, #0x30
   68dea: f44f 7148    	mov.w	r1, #0x320
   68dee: f500 501f    	add.w	r0, r0, #0x27c0
   68df2: f006 e906    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x620c
   68df6: a80a         	add	r0, sp, #0x28
   68df8: f44f 7148    	mov.w	r1, #0x320
   68dfc: f500 5067    	add.w	r0, r0, #0x39c0
   68e00: f006 e8fe    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x61fc
   68e04: f8ba 041c    	ldrh.w	r0, [r10, #0x41c]
   68e08: 1ba1         	subs	r1, r4, r6
   68e0a: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   68e0e: 462b         	mov	r3, r5
   68e10: 1a22         	subs	r2, r4, r0
   68e12: 2000         	movs	r0, #0x0
   68e14: f20c 6a4a    	addw	r10, r12, #0x64a
   68e18: 9460         	str	r4, [sp, #0x180]
   68e1a: b33b         	cbz	r3, 0x68e6c <check_error+0x27e4> @ imm = #0x4e
   68e1c: eb0a 0503    	add.w	r5, r10, r3
   68e20: f8b5 56c2    	ldrh.w	r5, [r5, #0x6c2]
   68e24: b18d         	cbz	r5, 0x68e4a <check_error+0x27c2> @ imm = #0x22
   68e26: 9c60         	ldr	r4, [sp, #0x180]
   68e28: 2600         	movs	r6, #0x0
   68e2a: 42ac         	cmp	r4, r5
   68e2c: f04f 0400    	mov.w	r4, #0x0
   68e30: bf88         	it	hi
   68e32: 2601         	movhi	r6, #0x1
   68e34: 42a9         	cmp	r1, r5
   68e36: bfd8         	it	le
   68e38: 2401         	movle	r4, #0x1
   68e3a: 4034         	ands	r4, r6
   68e3c: 4420         	add	r0, r4
   68e3e: 2400         	movs	r4, #0x0
   68e40: 42aa         	cmp	r2, r5
   68e42: bfd8         	it	le
   68e44: 2401         	movle	r4, #0x1
   68e46: 4034         	ands	r4, r6
   68e48: 44a1         	add	r9, r4
   68e4a: 3302         	adds	r3, #0x2
   68e4c: e7e5         	b	0x68e1a <check_error+0x2792> @ imm = #-0x36
   68e4e: 2000         	movs	r0, #0x0
   68e50: e001         	b	0x68e56 <check_error+0x27ce> @ imm = #0x2
   68e52: 2000         	movs	r0, #0x0
   68e54: 9e52         	ldr	r6, [sp, #0x148]
   68e56: f8c6 07b0    	str.w	r0, [r6, #0x7b0]
   68e5a: f8c6 07b4    	str.w	r0, [r6, #0x7b4]
   68e5e: f8c6 07c0    	str.w	r0, [r6, #0x7c0]
   68e62: f8c6 07c4    	str.w	r0, [r6, #0x7c4]
   68e66: f886 07b8    	strb.w	r0, [r6, #0x7b8]
   68e6a: e30b         	b	0x69484 <check_error+0x2dfc> @ imm = #0x616
   68e6c: 2100         	movs	r1, #0x0
   68e6e: 9c52         	ldr	r4, [sp, #0x148]
   68e70: 29f0         	cmp	r1, #0xf0
   68e72: d008         	beq	0x68e86 <check_error+0x27fe> @ imm = #0x10
   68e74: 1863         	adds	r3, r4, r1
   68e76: eb08 0201    	add.w	r2, r8, r1
   68e7a: 3108         	adds	r1, #0x8
   68e7c: edd3 0b34    	vldr	d16, [r3, #208]
   68e80: edc2 0b00    	vstr	d16, [r2]
   68e84: e7f4         	b	0x68e70 <check_error+0x27e8> @ imm = #-0x18
   68e86: 9939         	ldr	r1, [sp, #0xe4]
   68e88: ed91 9b12    	vldr	d9, [r1, #72]
   68e8c: 2100         	movs	r1, #0x0
   68e8e: 2928         	cmp	r1, #0x28
   68e90: d00a         	beq	0x68ea8 <check_error+0x2820> @ imm = #0x14
   68e92: 1863         	adds	r3, r4, r1
   68e94: eb0b 0201    	add.w	r2, r11, r1
   68e98: f503 63b0    	add.w	r3, r3, #0x580
   68e9c: 3108         	adds	r1, #0x8
   68e9e: edd3 0b00    	vldr	d16, [r3]
   68ea2: edc2 0b00    	vstr	d16, [r2]
   68ea6: e7f2         	b	0x68e8e <check_error+0x2806> @ imm = #-0x1c
   68ea8: b281         	uxth	r1, r0
   68eaa: f644 429c    	movw	r2, #0x4c9c
   68eae: 2964         	cmp	r1, #0x64
   68eb0: bf28         	it	hs
   68eb2: 2064         	movhs	r0, #0x64
   68eb4: b286         	uxth	r6, r0
   68eb6: ab0a         	add	r3, sp, #0x28
   68eb8: f644 71c0    	movw	r1, #0x4fc0
   68ebc: 4462         	add	r2, r12
   68ebe: ebac 00c6    	sub.w	r0, r12, r6, lsl #3
   68ec2: f503 5367    	add.w	r3, r3, #0x39c0
   68ec6: 4408         	add	r0, r1
   68ec8: 4271         	rsbs	r1, r6, #0
   68eca: f50d 5580    	add.w	r5, sp, #0x1000
   68ece: b141         	cbz	r1, 0x68ee2 <check_error+0x285a> @ imm = #0x10
   68ed0: 5c54         	ldrb	r4, [r2, r1]
   68ed2: 3101         	adds	r1, #0x1
   68ed4: ecf0 0b02    	vldmia	r0!, {d16}
   68ed8: ece3 0b02    	vstmia	r3!, {d16}
   68edc: f805 4b01    	strb	r4, [r5], #1
   68ee0: e7f5         	b	0x68ece <check_error+0x2846> @ imm = #-0x16
   68ee2: fa1f f089    	uxth.w	r0, r9
   68ee6: 2864         	cmp	r0, #0x64
   68ee8: bf28         	it	hs
   68eea: f04f 0964    	movhs.w	r9, #0x64
   68eee: fa1f f589    	uxth.w	r5, r9
   68ef2: f1c5 0064    	rsb.w	r0, r5, #0x64
   68ef6: f644 41a0    	movw	r1, #0x4ca0
   68efa: 462a         	mov	r2, r5
   68efc: eb0c 00c0    	add.w	r0, r12, r0, lsl #3
   68f00: 4408         	add	r0, r1
   68f02: a90c         	add	r1, sp, #0x30
   68f04: ab02         	add	r3, sp, #0x8
   68f06: f501 511f    	add.w	r1, r1, #0x27c0
   68f0a: f503 5cc9    	add.w	r12, r3, #0x1920
   68f0e: b12a         	cbz	r2, 0x68f1c <check_error+0x2894> @ imm = #0xa
   68f10: ecf0 0b02    	vldmia	r0!, {d16}
   68f14: 3a01         	subs	r2, #0x1
   68f16: ece1 0b02    	vstmia	r1!, {d16}
   68f1a: e7f8         	b	0x68f0e <check_error+0x2886> @ imm = #-0x10
   68f1c: 9839         	ldr	r0, [sp, #0xe4]
   68f1e: f50d 520c    	add.w	r2, sp, #0x2300
   68f22: 496f         	ldr	r1, [pc, #0x1bc]        @ 0x690e0 <check_error+0x2a58>
   68f24: f890 9044    	ldrb.w	r9, [r0, #0x44]
   68f28: f890 e043    	ldrb.w	lr, [r0, #0x43]
   68f2c: f890 4042    	ldrb.w	r4, [r0, #0x42]
   68f30: f8b0 3040    	ldrh.w	r3, [r0, #0x40]
   68f34: edd0 0b04    	vldr	d16, [r0, #16]
   68f38: ed90 ab06    	vldr	d10, [r0, #24]
   68f3c: ed90 db08    	vldr	d13, [r0, #32]
   68f40: edd0 1b0a    	vldr	d17, [r0, #40]
   68f44: ed90 bb0c    	vldr	d11, [r0, #48]
   68f48: ed90 cb0e    	vldr	d12, [r0, #56]
   68f4c: 982d         	ldr	r0, [sp, #0xb4]
   68f4e: ed90 fb00    	vldr	d15, [r0]
   68f52: 982a         	ldr	r0, [sp, #0xa8]
   68f54: ed90 8b00    	vldr	d8, [r0]
   68f58: 2000         	movs	r0, #0x0
   68f5a: e9c2 015a    	strd	r0, r1, [r2, #360]
   68f5e: aa02         	add	r2, sp, #0x8
   68f60: f502 52f6    	add.w	r2, r2, #0x1ec0
   68f64: e9c2 015a    	strd	r0, r1, [r2, #360]
   68f68: f8c2 0438    	str.w	r0, [r2, #0x438]
   68f6c: f8c2 143c    	str.w	r1, [r2, #0x43c]
   68f70: aa04         	add	r2, sp, #0x10
   68f72: f502 52c9    	add.w	r2, r2, #0x1920
   68f76: f88d 0fa0    	strb.w	r0, [sp, #0xfa0]
   68f7a: f8c2 159c    	str.w	r1, [r2, #0x59c]
   68f7e: f50d 5100    	add.w	r1, sp, #0x2000
   68f82: f8c2 0598    	str.w	r0, [r2, #0x598]
   68f86: f8a1 0738    	strh.w	r0, [r1, #0x738]
   68f8a: f50d 5180    	add.w	r1, sp, #0x1000
   68f8e: f881 0870    	strb.w	r0, [r1, #0x870]
   68f92: 9828         	ldr	r0, [sp, #0xa0]
   68f94: 9960         	ldr	r1, [sp, #0x180]
   68f96: 8800         	ldrh	r0, [r0]
   68f98: 4281         	cmp	r1, r0
   68f9a: f0c0 81ff    	blo.w	0x6939c <check_error+0x2d14> @ imm = #0x3fe
   68f9e: 2800         	cmp	r0, #0x0
   68fa0: f000 81fc    	beq.w	0x6939c <check_error+0x2d14> @ imm = #0x3f8
   68fa4: 4660         	mov	r0, r12
   68fa6: 21f0         	movs	r1, #0xf0
   68fa8: edcd 1b56    	vstr	d17, [sp, #344]
   68fac: edcd 0b58    	vstr	d16, [sp, #352]
   68fb0: e9cd 3e5b    	strd	r3, lr, [sp, #364]
   68fb4: 9462         	str	r4, [sp, #0x188]
   68fb6: f006 e824    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x6048
   68fba: eef1 0b08    	vmov.f64	d16, #6.000000e+00
   68fbe: a802         	add	r0, sp, #0x8
   68fc0: f500 54c9    	add.w	r4, r0, #0x1920
   68fc4: 2000         	movs	r0, #0x0
   68fc6: 2100         	movs	r1, #0x0
   68fc8: ef69 1119    	vorr	d17, d9, d9
   68fcc: b129         	cbz	r1, 0x68fda <check_error+0x2952> @ imm = #0xa
   68fce: 2905         	cmp	r1, #0x5
   68fd0: d02a         	beq	0x69028 <check_error+0x29a0> @ imm = #0x54
   68fd2: eb0b 02c1    	add.w	r2, r11, r1, lsl #3
   68fd6: ed52 1b02    	vldr	d17, [r2, #-8]
   68fda: eb0b 02c1    	add.w	r2, r11, r1, lsl #3
   68fde: edd2 2b00    	vldr	d18, [r2]
   68fe2: 2201         	movs	r2, #0x1
   68fe4: ee72 2be1    	vsub.f64	d18, d18, d17
   68fe8: eec2 2ba0    	vdiv.f64	d18, d18, d16
   68fec: 2a07         	cmp	r2, #0x7
   68fee: d00f         	beq	0x69010 <check_error+0x2988> @ imm = #0x1e
   68ff0: ee00 2a10    	vmov	s0, r2
   68ff4: b2c3         	uxtb	r3, r0
   68ff6: eef0 4b61    	vmov.f64	d20, d17
   68ffa: 3201         	adds	r2, #0x1
   68ffc: eb04 03c3    	add.w	r3, r4, r3, lsl #3
   69000: 3001         	adds	r0, #0x1
   69002: eef8 3bc0    	vcvt.f64.s32	d19, s0
   69006: ee42 4ba3    	vmla.f64	d20, d18, d19
   6900a: edc3 4b00    	vstr	d20, [r3]
   6900e: e7ed         	b	0x68fec <check_error+0x2964> @ imm = #-0x26
   69010: 3101         	adds	r1, #0x1
   69012: e7d9         	b	0x68fc8 <check_error+0x2940> @ imm = #-0x4e
   69014: 2000         	movs	r0, #0x0
   69016: 2100         	movs	r1, #0x0
   69018: 2906         	cmp	r1, #0x6
   6901a: f43f ad04    	beq.w	0x68a26 <check_error+0x239e> @ imm = #-0x5f8
   6901e: 1872         	adds	r2, r6, r1
   69020: 3101         	adds	r1, #0x1
   69022: f882 088f    	strb.w	r0, [r2, #0x88f]
   69026: e7f7         	b	0x69018 <check_error+0x2990> @ imm = #-0x12
   69028: ef80 9010    	vmov.i32	d9, #0x0
   6902c: 2000         	movs	r0, #0x0
   6902e: 28f0         	cmp	r0, #0xf0
   69030: d00c         	beq	0x6904c <check_error+0x29c4> @ imm = #0x18
   69032: 1821         	adds	r1, r4, r0
   69034: edd1 0b00    	vldr	d16, [r1]
   69038: eb08 0100    	add.w	r1, r8, r0
   6903c: 3008         	adds	r0, #0x8
   6903e: edd1 1b00    	vldr	d17, [r1]
   69042: ee71 0be0    	vsub.f64	d16, d17, d16
   69046: ee00 9ba0    	vmla.f64	d9, d16, d16
   6904a: e7f0         	b	0x6902e <check_error+0x29a6> @ imm = #-0x20
   6904c: a806         	add	r0, sp, #0x18
   6904e: 21e0         	movs	r1, #0xe0
   69050: f500 54a1    	add.w	r4, r0, #0x1420
   69054: 4620         	mov	r0, r4
   69056: f005 efd4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x5fa8
   6905a: 9b62         	ldr	r3, [sp, #0x188]
   6905c: ef6c 411c    	vorr	d20, d12, d12
   69060: e9dd ec5b    	ldrd	lr, r12, [sp, #364]
   69064: 2000         	movs	r0, #0x0
   69066: 28e0         	cmp	r0, #0xe0
   69068: d00c         	beq	0x69084 <check_error+0x29fc> @ imm = #0x18
   6906a: eb08 0200    	add.w	r2, r8, r0
   6906e: 1821         	adds	r1, r4, r0
   69070: 3008         	adds	r0, #0x8
   69072: edd2 0b02    	vldr	d16, [r2, #8]
   69076: edd2 1b04    	vldr	d17, [r2, #16]
   6907a: ee71 0be0    	vsub.f64	d16, d17, d16
   6907e: edc1 0b00    	vstr	d16, [r1]
   69082: e7f0         	b	0x69066 <check_error+0x29de> @ imm = #-0x20
   69084: 983d         	ldr	r0, [sp, #0xf4]
   69086: eef3 0b0e    	vmov.f64	d16, #3.000000e+01
   6908a: f500 6085    	add.w	r0, r0, #0x428
   6908e: edd0 1b00    	vldr	d17, [r0]
   69092: f50d 6000    	add.w	r0, sp, #0x800
   69096: eddd 3b68    	vldr	d19, [sp, #416]
   6909a: edd0 2b82    	vldr	d18, [r0, #520]
   6909e: ee72 2be1    	vsub.f64	d18, d18, d17
   690a2: eef4 3b62    	vcmp.f64	d19, d18
   690a6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   690aa: d51b         	bpl	0x690e4 <check_error+0x2a5c> @ imm = #0x36
   690ac: eef1 1b61    	vneg.f64	d17, d17
   690b0: 2000         	movs	r0, #0x0
   690b2: 2100         	movs	r1, #0x0
   690b4: 28e0         	cmp	r0, #0xe0
   690b6: d00a         	beq	0x690ce <check_error+0x2a46> @ imm = #0x14
   690b8: 1822         	adds	r2, r4, r0
   690ba: edd2 2b00    	vldr	d18, [r2]
   690be: eef4 2b61    	vcmp.f64	d18, d17
   690c2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   690c6: bfc8         	it	gt
   690c8: 3101         	addgt	r1, #0x1
   690ca: 3008         	adds	r0, #0x8
   690cc: e7f2         	b	0x690b4 <check_error+0x2a2c> @ imm = #-0x1c
   690ce: b2c8         	uxtb	r0, r1
   690d0: 281c         	cmp	r0, #0x1c
   690d2: d107         	bne	0x690e4 <check_error+0x2a5c> @ imm = #0xe
   690d4: 2001         	movs	r0, #0x1
   690d6: f04f 0b00    	mov.w	r11, #0x0
   690da: e006         	b	0x690ea <check_error+0x2a62> @ imm = #0xc
   690dc: 3e f9 ff ff  	.word	0xfffff93e
   690e0: 00 00 f8 7f  	.word	0x7ff80000
   690e4: 2000         	movs	r0, #0x0
   690e6: f04f 0b01    	mov.w	r11, #0x1
   690ea: 905e         	str	r0, [sp, #0x178]
   690ec: ee89 9b20    	vdiv.f64	d9, d9, d16
   690f0: ee38 cb4f    	vsub.f64	d12, d8, d15
   690f4: b3d3         	cbz	r3, 0x6916c <check_error+0x2ae4> @ imm = #0x74
   690f6: f50d 500c    	add.w	r0, sp, #0x2300
   690fa: f04f 0801    	mov.w	r8, #0x1
   690fe: f08c 0101    	eor	r1, r12, #0x1
   69102: eeb0 0b49    	vmov.f64	d0, d9
   69106: f50d 637a    	add.w	r3, sp, #0xfa0
   6910a: edc0 4b00    	vstr	d20, [r0]
   6910e: ef2a 211a    	vorr	d2, d10, d10
   69112: ed80 db5a    	vstr	d13, [r0, #360]
   69116: f50d 5080    	add.w	r0, sp, #0x1000
   6911a: eeb0 1b4c    	vmov.f64	d1, d12
   6911e: f880 8870    	strb.w	r8, [r0, #0x870]
   69122: f089 0001    	eor	r0, r9, #0x1
   69126: 4308         	orrs	r0, r1
   69128: bf18         	it	ne
   6912a: 4670         	movne	r0, lr
   6912c: e9cd 0900    	strd	r0, r9, [sp]
   69130: a80e         	add	r0, sp, #0x38
   69132: a90c         	add	r1, sp, #0x30
   69134: aa02         	add	r2, sp, #0x8
   69136: ef2b 311b    	vorr	d3, d11, d11
   6913a: f500 501c    	add.w	r0, r0, #0x2700
   6913e: f501 5100    	add.w	r1, r1, #0x2000
   69142: f502 52f6    	add.w	r2, r2, #0x1ec0
   69146: ef24 81b4    	vorr	d8, d20, d20
   6914a: f005 fbdd    	bl	0x6e908 <cal_threshold> @ imm = #0x57ba
   6914e: f89d efa0    	ldrb.w	lr, [sp, #0xfa0]
   69152: f1be 0f01    	cmp.w	lr, #0x1
   69156: d14e         	bne	0x691f6 <check_error+0x2b6e> @ imm = #0x9c
   69158: a802         	add	r0, sp, #0x8
   6915a: ef68 4118    	vorr	d20, d8, d8
   6915e: f500 50f6    	add.w	r0, r0, #0x1ec0
   69162: edd0 1b00    	vldr	d17, [r0]
   69166: edd0 0b5a    	vldr	d16, [r0, #360]
   6916a: e033         	b	0x691d4 <check_error+0x2b4c> @ imm = #0x66
   6916c: eeb0 0b49    	vmov.f64	d0, d9
   69170: e9cd ec00    	strd	lr, r12, [sp]
   69174: a80e         	add	r0, sp, #0x38
   69176: a90a         	add	r1, sp, #0x28
   69178: ab04         	add	r3, sp, #0x10
   6917a: f500 501c    	add.w	r0, r0, #0x2700
   6917e: f501 5111    	add.w	r1, r1, #0x2440
   69182: f50d 520c    	add.w	r2, sp, #0x2300
   69186: eeb0 1b4c    	vmov.f64	d1, d12
   6918a: f503 53c3    	add.w	r3, r3, #0x1860
   6918e: ed9d 2b58    	vldr	d2, [sp, #352]
   69192: ed9d 3b56    	vldr	d3, [sp, #344]
   69196: f005 fbb7    	bl	0x6e908 <cal_threshold> @ imm = #0x576e
   6919a: f50d 5080    	add.w	r0, sp, #0x1000
   6919e: f890 8870    	ldrb.w	r8, [r0, #0x870]
   691a2: f1b8 0f01    	cmp.w	r8, #0x1
   691a6: d12d         	bne	0x69204 <check_error+0x2b7c> @ imm = #0x5a
   691a8: 2001         	movs	r0, #0x1
   691aa: 2101         	movs	r1, #0x1
   691ac: 9062         	str	r0, [sp, #0x188]
   691ae: f50d 500c    	add.w	r0, sp, #0x2300
   691b2: f88d 1fa0    	strb.w	r1, [sp, #0xfa0]
   691b6: edd0 0b5a    	vldr	d16, [r0, #360]
   691ba: a902         	add	r1, sp, #0x8
   691bc: f501 51f6    	add.w	r1, r1, #0x1ec0
   691c0: edd0 1b00    	vldr	d17, [r0]
   691c4: ef61 41b1    	vorr	d20, d17, d17
   691c8: edc1 0b5a    	vstr	d16, [r1, #360]
   691cc: ef20 d1b0    	vorr	d13, d16, d16
   691d0: edc1 1b00    	vstr	d17, [r1]
   691d4: eeb4 db60    	vcmp.f64	d13, d16
   691d8: f04f 0801    	mov.w	r8, #0x1
   691dc: f04f 0e01    	mov.w	lr, #0x1
   691e0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   691e4: bf98         	it	ls
   691e6: eef0 0b4d    	vmovls.f64	d16, d13
   691ea: eef4 4b61    	vcmp.f64	d20, d17
   691ee: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   691f2: d913         	bls	0x6921c <check_error+0x2b94> @ imm = #0x26
   691f4: e014         	b	0x69220 <check_error+0x2b98> @ imm = #0x28
   691f6: ef6d 011d    	vorr	d16, d13, d13
   691fa: ef68 1118    	vorr	d17, d8, d8
   691fe: ef68 4118    	vorr	d20, d8, d8
   69202: e00d         	b	0x69220 <check_error+0x2b98> @ imm = #0x1a
   69204: 2000         	movs	r0, #0x0
   69206: f04f 0e00    	mov.w	lr, #0x0
   6920a: 9062         	str	r0, [sp, #0x188]
   6920c: f50d 500c    	add.w	r0, sp, #0x2300
   69210: ed90 db5a    	vldr	d13, [r0, #360]
   69214: edd0 4b00    	vldr	d20, [r0]
   69218: ef6d 011d    	vorr	d16, d13, d13
   6921c: ef64 11b4    	vorr	d17, d20, d20
   69220: 983d         	ldr	r0, [sp, #0xf4]
   69222: f500 6187    	add.w	r1, r0, #0x438
   69226: edd1 2b00    	vldr	d18, [r1]
   6922a: eef4 0b62    	vcmp.f64	d16, d18
   6922e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69232: d502         	bpl	0x6923a <check_error+0x2bb2> @ imm = #0x4
   69234: f500 638a    	add.w	r3, r0, #0x450
   69238: e018         	b	0x6926c <check_error+0x2be4> @ imm = #0x30
   6923a: f500 6188    	add.w	r1, r0, #0x440
   6923e: edd1 2b00    	vldr	d18, [r1]
   69242: eef4 0b62    	vcmp.f64	d16, d18
   69246: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6924a: d502         	bpl	0x69252 <check_error+0x2bca> @ imm = #0x4
   6924c: f200 4352    	addw	r3, r0, #0x452
   69250: e00c         	b	0x6926c <check_error+0x2be4> @ imm = #0x18
   69252: f500 6189    	add.w	r1, r0, #0x448
   69256: f200 4356    	addw	r3, r0, #0x456
   6925a: edd1 2b00    	vldr	d18, [r1]
   6925e: eef4 0b62    	vcmp.f64	d16, d18
   69262: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69266: bf48         	it	mi
   69268: f200 4354    	addwmi	r3, r0, #0x454
   6926c: f500 618d    	add.w	r1, r0, #0x468
   69270: 2200         	movs	r2, #0x0
   69272: edd1 2b00    	vldr	d18, [r1]
   69276: 2100         	movs	r1, #0x0
   69278: eeb4 9b62    	vcmp.f64	d9, d18
   6927c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69280: bfc8         	it	gt
   69282: 2201         	movgt	r2, #0x1
   69284: ea02 020b    	and.w	r2, r2, r11
   69288: f1b8 0f01    	cmp.w	r8, #0x1
   6928c: d112         	bne	0x692b4 <check_error+0x2c2c> @ imm = #0x24
   6928e: eeb4 9b60    	vcmp.f64	d9, d16
   69292: 2400         	movs	r4, #0x0
   69294: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69298: bfc8         	it	gt
   6929a: 2401         	movgt	r4, #0x1
   6929c: 983d         	ldr	r0, [sp, #0xf4]
   6929e: f500 608e    	add.w	r0, r0, #0x470
   692a2: edd0 3b00    	vldr	d19, [r0]
   692a6: eeb4 9b63    	vcmp.f64	d9, d19
   692aa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   692ae: bfc8         	it	gt
   692b0: 2101         	movgt	r1, #0x1
   692b2: 4021         	ands	r1, r4
   692b4: f8b3 c000    	ldrh.w	r12, [r3]
   692b8: a80a         	add	r0, sp, #0x28
   692ba: f50d 5480    	add.w	r4, sp, #0x1000
   692be: f500 5367    	add.w	r3, r0, #0x39c0
   692c2: b176         	cbz	r6, 0x692e2 <check_error+0x2c5a> @ imm = #0x1c
   692c4: edd3 3b00    	vldr	d19, [r3]
   692c8: eef4 3b62    	vcmp.f64	d19, d18
   692cc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   692d0: dd03         	ble	0x692da <check_error+0x2c52> @ imm = #0x6
   692d2: 7820         	ldrb	r0, [r4]
   692d4: 2800         	cmp	r0, #0x0
   692d6: bf08         	it	eq
   692d8: 3201         	addeq	r2, #0x1
   692da: 3e01         	subs	r6, #0x1
   692dc: 3308         	adds	r3, #0x8
   692de: 3401         	adds	r4, #0x1
   692e0: e7ef         	b	0x692c2 <check_error+0x2c3a> @ imm = #-0x22
   692e2: f1b8 0f01    	cmp.w	r8, #0x1
   692e6: d11d         	bne	0x69324 <check_error+0x2c9c> @ imm = #0x3a
   692e8: 983d         	ldr	r0, [sp, #0xf4]
   692ea: f500 608e    	add.w	r0, r0, #0x470
   692ee: edd0 2b00    	vldr	d18, [r0]
   692f2: a80c         	add	r0, sp, #0x30
   692f4: 9e52         	ldr	r6, [sp, #0x148]
   692f6: f500 531f    	add.w	r3, r0, #0x27c0
   692fa: b1a5         	cbz	r5, 0x69326 <check_error+0x2c9e> @ imm = #0x28
   692fc: ecf3 3b02    	vldmia	r3!, {d19}
   69300: 2000         	movs	r0, #0x0
   69302: 2400         	movs	r4, #0x0
   69304: eef4 3b62    	vcmp.f64	d19, d18
   69308: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6930c: bfc8         	it	gt
   6930e: 2001         	movgt	r0, #0x1
   69310: eef4 3b60    	vcmp.f64	d19, d16
   69314: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69318: bfc8         	it	gt
   6931a: 2401         	movgt	r4, #0x1
   6931c: 4020         	ands	r0, r4
   6931e: 3d01         	subs	r5, #0x1
   69320: 4401         	add	r1, r0
   69322: e7ea         	b	0x692fa <check_error+0x2c72> @ imm = #-0x2c
   69324: 9e52         	ldr	r6, [sp, #0x148]
   69326: 983d         	ldr	r0, [sp, #0xf4]
   69328: b2d2         	uxtb	r2, r2
   6932a: f890 0478    	ldrb.w	r0, [r0, #0x478]
   6932e: 4282         	cmp	r2, r0
   69330: d205         	bhs	0x6933e <check_error+0x2cb6> @ imm = #0xa
   69332: f1b8 0f01    	cmp.w	r8, #0x1
   69336: d105         	bne	0x69344 <check_error+0x2cbc> @ imm = #0xa
   69338: b2c8         	uxtb	r0, r1
   6933a: 4584         	cmp	r12, r0
   6933c: d802         	bhi	0x69344 <check_error+0x2cbc> @ imm = #0x4
   6933e: 2001         	movs	r0, #0x1
   69340: f886 07c9    	strb.w	r0, [r6, #0x7c9]
   69344: 9939         	ldr	r1, [sp, #0xe4]
   69346: ed81 db04    	vstr	d13, [r1, #16]
   6934a: edc1 0b08    	vstr	d16, [r1, #32]
   6934e: a802         	add	r0, sp, #0x8
   69350: f500 50f6    	add.w	r0, r0, #0x1ec0
   69354: 9a5e         	ldr	r2, [sp, #0x178]
   69356: edd0 0b5a    	vldr	d16, [r0, #360]
   6935a: edc1 0b06    	vstr	d16, [r1, #24]
   6935e: edd0 0b00    	vldr	d16, [r0]
   69362: 9862         	ldr	r0, [sp, #0x188]
   69364: f886 27b8    	strb.w	r2, [r6, #0x7b8]
   69368: f881 0042    	strb.w	r0, [r1, #0x42]
   6936c: f50d 5000    	add.w	r0, sp, #0x2000
   69370: edc1 4b0a    	vstr	d20, [r1, #40]
   69374: f8b0 0738    	ldrh.w	r0, [r0, #0x738]
   69378: f8a1 0040    	strh.w	r0, [r1, #0x40]
   6937c: f506 60f6    	add.w	r0, r6, #0x7b0
   69380: edc1 1b0e    	vstr	d17, [r1, #56]
   69384: edc1 0b0c    	vstr	d16, [r1, #48]
   69388: f881 e044    	strb.w	lr, [r1, #0x44]
   6938c: f881 8043    	strb.w	r8, [r1, #0x43]
   69390: ed80 9b00    	vstr	d9, [r0]
   69394: f506 60f8    	add.w	r0, r6, #0x7c0
   69398: ed80 cb00    	vstr	d12, [r0]
   6939c: 9827         	ldr	r0, [sp, #0x9c]
   6939e: 9e52         	ldr	r6, [sp, #0x148]
   693a0: f890 0e18    	ldrb.w	r0, [r0, #0xe18]
   693a4: 2801         	cmp	r0, #0x1
   693a6: d105         	bne	0x693b4 <check_error+0x2d2c> @ imm = #0xa
   693a8: 9863         	ldr	r0, [sp, #0x18c]
   693aa: 2802         	cmp	r0, #0x2
   693ac: bf24         	itt	hs
   693ae: 2001         	movhs	r0, #0x1
   693b0: f886 07c9    	strbhs.w	r0, [r6, #0x7c9]
   693b4: 983d         	ldr	r0, [sp, #0xf4]
   693b6: 2400         	movs	r4, #0x0
   693b8: 9d60         	ldr	r5, [sp, #0x180]
   693ba: 49ee         	ldr	r1, [pc, #0x3b8]        @ 0x69774 <check_error+0x30ec>
   693bc: f8b0 0420    	ldrh.w	r0, [r0, #0x420]
   693c0: ed9f fbed    	vldr	d15, [pc, #948]         @ 0x69778 <check_error+0x30f0>
   693c4: 1a28         	subs	r0, r5, r0
   693c6: b191         	cbz	r1, 0x693ee <check_error+0x2d66> @ imm = #0x24
   693c8: eb0a 0201    	add.w	r2, r10, r1
   693cc: f8b2 26c2    	ldrh.w	r2, [r2, #0x6c2]
   693d0: b15a         	cbz	r2, 0x693ea <check_error+0x2d62> @ imm = #0x16
   693d2: 42aa         	cmp	r2, r5
   693d4: f04f 0300    	mov.w	r3, #0x0
   693d8: bf98         	it	ls
   693da: 2301         	movls	r3, #0x1
   693dc: 4290         	cmp	r0, r2
   693de: f04f 0200    	mov.w	r2, #0x0
   693e2: bfd8         	it	le
   693e4: 2201         	movle	r2, #0x1
   693e6: 401a         	ands	r2, r3
   693e8: 4414         	add	r4, r2
   693ea: 3102         	adds	r1, #0x2
   693ec: e7eb         	b	0x693c6 <check_error+0x2d3e> @ imm = #-0x2a
   693ee: a80c         	add	r0, sp, #0x30
   693f0: f44f 71c8    	mov.w	r1, #0x190
   693f4: f500 551f    	add.w	r5, r0, #0x27c0
   693f8: 4628         	mov	r0, r5
   693fa: f005 ee02    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x5c04
   693fe: b2a0         	uxth	r0, r4
   69400: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   69404: 2864         	cmp	r0, #0x64
   69406: f04f 30ff    	mov.w	r0, #0xffffffff
   6940a: bf28         	it	hs
   6940c: 2464         	movhs	r4, #0x64
   6940e: fa10 f184    	uxtah	r1, r0, r4
   69412: b2a0         	uxth	r0, r4
   69414: f644 43a0    	movw	r3, #0x4ca0
   69418: f1c0 0265    	rsb.w	r2, r0, #0x65
   6941c: 462c         	mov	r4, r5
   6941e: f8dd 809c    	ldr.w	r8, [sp, #0x9c]
   69422: eb0e 02c2    	add.w	r2, lr, r2, lsl #3
   69426: 441a         	add	r2, r3
   69428: 2300         	movs	r3, #0x0
   6942a: 428b         	cmp	r3, r1
   6942c: da05         	bge	0x6943a <check_error+0x2db2> @ imm = #0xa
   6942e: ecf2 0b02    	vldmia	r2!, {d16}
   69432: 3301         	adds	r3, #0x1
   69434: ece4 0b02    	vstmia	r4!, {d16}
   69438: e7f7         	b	0x6942a <check_error+0x2da2> @ imm = #-0x12
   6943a: f506 62f6    	add.w	r2, r6, #0x7b0
   6943e: eb05 01c1    	add.w	r1, r5, r1, lsl #3
   69442: edd2 0b00    	vldr	d16, [r2]
   69446: edc1 0b00    	vstr	d16, [r1]
   6944a: 993d         	ldr	r1, [sp, #0xf4]
   6944c: f501 6199    	add.w	r1, r1, #0x4c8
   69450: edd1 0b00    	vldr	d16, [r1]
   69454: 2101         	movs	r1, #0x1
   69456: b180         	cbz	r0, 0x6947a <check_error+0x2df2> @ imm = #0x20
   69458: edd5 1b00    	vldr	d17, [r5]
   6945c: eef4 1b60    	vcmp.f64	d17, d16
   69460: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69464: d501         	bpl	0x6946a <check_error+0x2de2> @ imm = #0x2
   69466: 2100         	movs	r1, #0x0
   69468: e004         	b	0x69474 <check_error+0x2dec> @ imm = #0x8
   6946a: eef4 1b61    	vcmp.f64	d17, d17
   6946e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69472: d6f8         	bvs	0x69466 <check_error+0x2dde> @ imm = #-0x10
   69474: 3801         	subs	r0, #0x1
   69476: 3508         	adds	r5, #0x8
   69478: e7ed         	b	0x69456 <check_error+0x2dce> @ imm = #-0x26
   6947a: 2901         	cmp	r1, #0x1
   6947c: bf04         	itt	eq
   6947e: 2001         	moveq	r0, #0x1
   69480: f886 07c8    	strbeq.w	r0, [r6, #0x7c8]
   69484: f644 70c8    	movw	r0, #0x4fc8
   69488: f644 4139    	movw	r1, #0x4c39
   6948c: 4470         	add	r0, lr
   6948e: 4471         	add	r1, lr
   69490: 2200         	movs	r2, #0x0
   69492: 2a63         	cmp	r2, #0x63
   69494: d00e         	beq	0x694b4 <check_error+0x2e2c> @ imm = #0x1c
   69496: ed50 0bc8    	vldr	d16, [r0, #-800]
   6949a: 188b         	adds	r3, r1, r2
   6949c: ed40 0bca    	vstr	d16, [r0, #-808]
   694a0: 5c8c         	ldrb	r4, [r1, r2]
   694a2: 3201         	adds	r2, #0x1
   694a4: f803 4c01    	strb	r4, [r3, #-1]
   694a8: edd0 0b00    	vldr	d16, [r0]
   694ac: ed40 0b02    	vstr	d16, [r0, #-8]
   694b0: 3008         	adds	r0, #0x8
   694b2: e7ee         	b	0x69492 <check_error+0x2e0a> @ imm = #-0x24
   694b4: f506 60f6    	add.w	r0, r6, #0x7b0
   694b8: 9939         	ldr	r1, [sp, #0xe4]
   694ba: 9a3d         	ldr	r2, [sp, #0xf4]
   694bc: edd0 0b00    	vldr	d16, [r0]
   694c0: edc1 0bf4    	vstr	d16, [r1, #976]
   694c4: f896 07b8    	ldrb.w	r0, [r6, #0x7b8]
   694c8: f881 00b3    	strb.w	r0, [r1, #0xb3]
   694cc: f506 60f8    	add.w	r0, r6, #0x7c0
   694d0: edd0 0b00    	vldr	d16, [r0]
   694d4: f506 60b4    	add.w	r0, r6, #0x5a0
   694d8: edc8 0b00    	vstr	d16, [r8]
   694dc: f896 b7c9    	ldrb.w	r11, [r6, #0x7c9]
   694e0: f888 be18    	strb.w	r11, [r8, #0xe18]
   694e4: edd0 0b00    	vldr	d16, [r0]
   694e8: f8be 0648    	ldrh.w	r0, [lr, #0x648]
   694ec: edc1 0b12    	vstr	d16, [r1, #72]
   694f0: f8b2 1418    	ldrh.w	r1, [r2, #0x418]
   694f4: 4288         	cmp	r0, r1
   694f6: bf24         	itt	hs
   694f8: f8b2 44ba    	ldrhhs.w	r4, [r2, #0x4ba]
   694fc: 42a0         	cmphs	r0, r4
   694fe: f080 817a    	bhs.w	0x697f6 <check_error+0x316e> @ imm = #0x2f4
   69502: f1bb 0f01    	cmp.w	r11, #0x1
   69506: bf19         	ittee	ne
   69508: f896 07f2    	ldrbne.w	r0, [r6, #0x7f2]
   6950c: 2801         	cmpne	r0, #0x1
   6950e: 2001         	moveq	r0, #0x1
   69510: f886 07a8    	strbeq.w	r0, [r6, #0x7a8]
   69514: 2123         	movs	r1, #0x23
   69516: f246 00f2    	movw	r0, #0x60f2
   6951a: 4470         	add	r0, lr
   6951c: b129         	cbz	r1, 0x6952a <check_error+0x2ea2> @ imm = #0xa
   6951e: f810 2b01    	ldrb	r2, [r0], #1
   69522: 3901         	subs	r1, #0x1
   69524: f800 2c02    	strb	r2, [r0, #-2]
   69528: e7f8         	b	0x6951c <check_error+0x2e94> @ imm = #-0x10
   6952a: f896 07cb    	ldrb.w	r0, [r6, #0x7cb]
   6952e: f50d 79cc    	add.w	r9, sp, #0x198
   69532: f888 0e3c    	strb.w	r0, [r8, #0xe3c]
   69536: f44f 7180    	mov.w	r1, #0x100
   6953a: f896 07f1    	ldrb.w	r0, [r6, #0x7f1]
   6953e: 46f2         	mov	r10, lr
   69540: 2801         	cmp	r0, #0x1
   69542: bf04         	itt	eq
   69544: 2001         	moveq	r0, #0x1
   69546: f888 0e40    	strbeq.w	r0, [r8, #0xe40]
   6954a: 488d         	ldr	r0, [pc, #0x234]        @ 0x69780 <check_error+0x30f8>
   6954c: 2500         	movs	r5, #0x0
   6954e: f8c6 080c    	str.w	r0, [r6, #0x80c]
   69552: f8c6 0814    	str.w	r0, [r6, #0x814]
   69556: f8c6 081c    	str.w	r0, [r6, #0x81c]
   6955a: f8c6 0824    	str.w	r0, [r6, #0x824]
   6955e: f8c6 082c    	str.w	r0, [r6, #0x82c]
   69562: f8c6 0834    	str.w	r0, [r6, #0x834]
   69566: f8c6 083c    	str.w	r0, [r6, #0x83c]
   6956a: f8c6 0844    	str.w	r0, [r6, #0x844]
   6956e: f8c6 084c    	str.w	r0, [r6, #0x84c]
   69572: f8c6 085c    	str.w	r0, [r6, #0x85c]
   69576: 8830         	ldrh	r0, [r6]
   69578: 9062         	str	r0, [sp, #0x188]
   6957a: 4648         	mov	r0, r9
   6957c: f8c6 5808    	str.w	r5, [r6, #0x808]
   69580: f8c6 5810    	str.w	r5, [r6, #0x810]
   69584: f8c6 5818    	str.w	r5, [r6, #0x818]
   69588: f8c6 5820    	str.w	r5, [r6, #0x820]
   6958c: f8c6 5828    	str.w	r5, [r6, #0x828]
   69590: f8c6 5830    	str.w	r5, [r6, #0x830]
   69594: f8c6 5838    	str.w	r5, [r6, #0x838]
   69598: f8c6 5840    	str.w	r5, [r6, #0x840]
   6959c: f8c6 5848    	str.w	r5, [r6, #0x848]
   695a0: f8c6 5858    	str.w	r5, [r6, #0x858]
   695a4: f9be 4648    	ldrsh.w	r4, [lr, #0x648]
   695a8: f005 ed2a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x5a54
   695ac: 9e3d         	ldr	r6, [sp, #0xf4]
   695ae: fa1f fe84    	uxth.w	lr, r4
   695b2: f8b6 0502    	ldrh.w	r0, [r6, #0x502]
   695b6: fa0f fb80    	sxth.w	r11, r0
   695ba: 455c         	cmp	r4, r11
   695bc: f8cd e18c    	str.w	lr, [sp, #0x18c]
   695c0: dd28         	ble	0x69614 <check_error+0x2f8c> @ imm = #0x50
   695c2: f240 131f    	movw	r3, #0x11f
   695c6: eba3 0c00    	sub.w	r12, r3, r0
   695ca: f506 63aa    	add.w	r3, r6, #0x550
   695ce: f644 32f0    	movw	r2, #0x4bf0
   695d2: eba5 01c0    	sub.w	r1, r5, r0, lsl #3
   695d6: 4452         	add	r2, r10
   695d8: edd3 0b00    	vldr	d16, [r3]
   695dc: 2400         	movs	r4, #0x0
   695de: f04f 0800    	mov.w	r8, #0x0
   695e2: 46d6         	mov	lr, r10
   695e4: 2908         	cmp	r1, #0x8
   695e6: d020         	beq	0x6962a <check_error+0x2fa2> @ imm = #0x40
   695e8: 1850         	adds	r0, r2, r1
   695ea: fa5f f388    	uxtb.w	r3, r8
   695ee: eb09 03c3    	add.w	r3, r9, r3, lsl #3
   695f2: f108 0801    	add.w	r8, r8, #0x1
   695f6: edd0 1b00    	vldr	d17, [r0]
   695fa: eef4 1b60    	vcmp.f64	d17, d16
   695fe: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69602: bf59         	ittee	pl
   69604: edc3 1b00    	vstrpl	d17, [r3]
   69608: 3401         	addpl	r4, #0x1
   6960a: 485d         	ldrmi	r0, [pc, #0x174]        @ 0x69780 <check_error+0x30f8>
   6960c: e9c3 5000    	strdmi	r5, r0, [r3]
   69610: 3108         	adds	r1, #0x8
   69612: e7e7         	b	0x695e4 <check_error+0x2f5c> @ imm = #-0x32
   69614: 46d4         	mov	r12, r10
   69616: f8dd a0a8    	ldr.w	r10, [sp, #0xa8]
   6961a: a80c         	add	r0, sp, #0x30
   6961c: ef80 b010    	vmov.i32	d11, #0x0
   69620: f04f 0800    	mov.w	r8, #0x0
   69624: f500 531f    	add.w	r3, r0, #0x27c0
   69628: e1a1         	b	0x6996e <check_error+0x32e6> @ imm = #0x342
   6962a: 983d         	ldr	r0, [sp, #0xf4]
   6962c: f240 121f    	movw	r2, #0x11f
   69630: 9b52         	ldr	r3, [sp, #0x148]
   69632: fa5f fa88    	uxtb.w	r10, r8
   69636: f8b0 1500    	ldrh.w	r1, [r0, #0x500]
   6963a: 1a52         	subs	r2, r2, r1
   6963c: eb0e 0282    	add.w	r2, lr, r2, lsl #2
   69640: ed92 0a72    	vldr	s0, [r2, #456]
   69644: f500 62a1    	add.w	r2, r0, #0x508
   69648: eef8 0b40    	vcvt.f64.u32	d16, s0
   6964c: ed93 0a01    	vldr	s0, [r3, #4]
   69650: edd2 1b00    	vldr	d17, [r2]
   69654: eeb8 ab40    	vcvt.f64.u32	d10, s0
   69658: ee7a 0b60    	vsub.f64	d16, d10, d16
   6965c: eec0 0b8f    	vdiv.f64	d16, d16, d15
   69660: eef4 0b61    	vcmp.f64	d16, d17
   69664: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69668: d902         	bls	0x69670 <check_error+0x2fe8> @ imm = #0x4
   6966a: ed9f 8b47    	vldr	d8, [pc, #284]          @ 0x69788 <check_error+0x3100>
   6966e: e012         	b	0x69696 <check_error+0x300e> @ imm = #0x24
   69670: f1aa 0001    	sub.w	r0, r10, #0x1
   69674: eb09 02c0    	add.w	r2, r9, r0, lsl #3
   69678: 1a40         	subs	r0, r0, r1
   6967a: eb09 00c0    	add.w	r0, r9, r0, lsl #3
   6967e: edd2 1b00    	vldr	d17, [r2]
   69682: edd0 2b00    	vldr	d18, [r0]
   69686: f603 0008    	addw	r0, r3, #0x808
   6968a: ee71 1be2    	vsub.f64	d17, d17, d18
   6968e: ee81 8ba0    	vdiv.f64	d8, d17, d16
   69692: ed80 8b00    	vstr	d8, [r0]
   69696: eb0e 008c    	add.w	r0, lr, r12, lsl #2
   6969a: f44f 7180    	mov.w	r1, #0x100
   6969e: ed90 0a72    	vldr	s0, [r0, #456]
   696a2: a80c         	add	r0, sp, #0x30
   696a4: f500 551f    	add.w	r5, r0, #0x27c0
   696a8: eeb8 bb40    	vcvt.f64.u32	d11, s0
   696ac: 4628         	mov	r0, r5
   696ae: f005 eca8    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x5950
   696b2: 2000         	movs	r0, #0x0
   696b4: 4582         	cmp	r10, r0
   696b6: d007         	beq	0x696c8 <check_error+0x3040> @ imm = #0xe
   696b8: 3001         	adds	r0, #0x1
   696ba: ee00 0a10    	vmov	s0, r0
   696be: eef8 0bc0    	vcvt.f64.s32	d16, s0
   696c2: ece5 0b02    	vstmia	r5!, {d16}
   696c6: e7f5         	b	0x696b4 <check_error+0x302c> @ imm = #-0x16
   696c8: a80a         	add	r0, sp, #0x28
   696ca: efc0 0050    	vmov.i32	q8, #0x0
   696ce: f500 5067    	add.w	r0, r0, #0x39c0
   696d2: f940 0acf    	vst1.64	{d16, d17}, [r0]
   696d6: fa1f f08b    	uxth.w	r0, r11
   696da: ee00 0a10    	vmov	s0, r0
   696de: eef6 1b00    	vmov.f64	d17, #5.000000e-01
   696e2: eef8 0b40    	vcvt.f64.u32	d16, s0
   696e6: ee20 0ba1    	vmul.f64	d0, d16, d17
   696ea: f003 f835    	bl	0x6c758 <math_round>    @ imm = #0x306a
   696ee: b2e0         	uxtb	r0, r4
   696f0: ed9f 9b25    	vldr	d9, [pc, #148]          @ 0x69788 <check_error+0x3100>
   696f4: ee01 0a10    	vmov	s2, r0
   696f8: eef8 0b41    	vcvt.f64.u32	d16, s2
   696fc: eeb4 0b60    	vcmp.f64	d0, d16
   69700: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69704: d544         	bpl	0x69790 <check_error+0x3108> @ imm = #0x88
   69706: ee7a 0b4b    	vsub.f64	d16, d10, d11
   6970a: 983d         	ldr	r0, [sp, #0xf4]
   6970c: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   69710: f500 60a2    	add.w	r0, r0, #0x510
   69714: eec0 0b8f    	vdiv.f64	d16, d16, d15
   69718: edd0 1b00    	vldr	d17, [r0]
   6971c: a80c         	add	r0, sp, #0x30
   6971e: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   69722: f500 531f    	add.w	r3, r0, #0x27c0
   69726: eef4 0b61    	vcmp.f64	d16, d17
   6972a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6972e: d836         	bhi	0x6979e <check_error+0x3116> @ imm = #0x6c
   69730: f10b 0001    	add.w	r0, r11, #0x1
   69734: b282         	uxth	r2, r0
   69736: a80c         	add	r0, sp, #0x30
   69738: a966         	add	r1, sp, #0x198
   6973a: ab0a         	add	r3, sp, #0x28
   6973c: f500 501f    	add.w	r0, r0, #0x27c0
   69740: f503 5367    	add.w	r3, r3, #0x39c0
   69744: f004 fd64    	bl	0x6e210 <fit_simple_regression> @ imm = #0x4ac8
   69748: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   6974c: a80c         	add	r0, sp, #0x30
   6974e: e9dd 1c52    	ldrd	r1, r12, [sp, #328]
   69752: aa0a         	add	r2, sp, #0x28
   69754: f502 5267    	add.w	r2, r2, #0x39c0
   69758: f500 531f    	add.w	r3, r0, #0x27c0
   6975c: f501 6001    	add.w	r0, r1, #0x810
   69760: ed92 9b00    	vldr	d9, [r2]
   69764: ed80 9b00    	vstr	d9, [r0]
   69768: f601 0008    	addw	r0, r1, #0x808
   6976c: ed90 8b00    	vldr	d8, [r0]
   69770: e015         	b	0x6979e <check_error+0x3116> @ imm = #0x2a
   69772: bf00         	nop
   69774: 3e f9 ff ff  	.word	0xfffff93e
   69778: 00 00 00 00  	.word	0x00000000
   6977c: 00 00 4e 40  	.word	0x404e0000
   69780: 00 00 f8 7f  	.word	0x7ff80000
   69784: 00 bf 00 bf  	.word	0xbf00bf00
   69788: 00 00 00 00  	.word	0x00000000
   6978c: 00 00 f8 7f  	.word	0x7ff80000
   69790: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   69794: a80c         	add	r0, sp, #0x30
   69796: f500 531f    	add.w	r3, r0, #0x27c0
   6979a: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   6979e: eb09 00ca    	add.w	r0, r9, r10, lsl #3
   697a2: f1be 0f01    	cmp.w	lr, #0x1
   697a6: ed10 bb02    	vldr	d11, [r0, #-8]
   697aa: d116         	bne	0x697da <check_error+0x3152> @ imm = #0x2c
   697ac: eeb5 9b40    	vcmp.f64	d9, #0
   697b0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   697b4: ef2b 011b    	vorr	d0, d11, d11
   697b8: eeb5 8b40    	vcmp.f64	d8, #0
   697bc: eef1 0b49    	vneg.f64	d16, d9
   697c0: bf48         	it	mi
   697c2: eeb0 9b60    	vmovmi.f64	d9, d16
   697c6: eef1 0b48    	vneg.f64	d16, d8
   697ca: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   697ce: bf48         	it	mi
   697d0: eeb0 8b60    	vmovmi.f64	d8, d16
   697d4: f8dd a0a8    	ldr.w	r10, [sp, #0xa8]
   697d8: e0bc         	b	0x69954 <check_error+0x32cc> @ imm = #0x178
   697da: 9829         	ldr	r0, [sp, #0xa4]
   697dc: f8dd a0a8    	ldr.w	r10, [sp, #0xa8]
   697e0: 7800         	ldrb	r0, [r0]
   697e2: 2801         	cmp	r0, #0x1
   697e4: d171         	bne	0x698ca <check_error+0x3242> @ imm = #0xe2
   697e6: 9835         	ldr	r0, [sp, #0xd4]
   697e8: ed90 8b02    	vldr	d8, [r0, #8]
   697ec: ed90 9b04    	vldr	d9, [r0, #16]
   697f0: ed90 0b06    	vldr	d0, [r0, #24]
   697f4: e0ae         	b	0x69954 <check_error+0x32cc> @ imm = #0x15c
   697f6: f240 3161    	movw	r1, #0x361
   697fa: 8830         	ldrh	r0, [r6]
   697fc: 1b09         	subs	r1, r1, r4
   697fe: 1b00         	subs	r0, r0, r4
   69800: eb0e 0141    	add.w	r1, lr, r1, lsl #1
   69804: 3001         	adds	r0, #0x1
   69806: f8b1 164a    	ldrh.w	r1, [r1, #0x64a]
   6980a: 4288         	cmp	r0, r1
   6980c: f47f ae79    	bne.w	0x69502 <check_error+0x2e7a> @ imm = #-0x30e
   69810: f8b8 0e3e    	ldrh.w	r0, [r8, #0xe3e]
   69814: 2801         	cmp	r0, #0x1
   69816: d803         	bhi	0x69820 <check_error+0x3198> @ imm = #0x6
   69818: f898 0e40    	ldrb.w	r0, [r8, #0xe40]
   6981c: 2801         	cmp	r0, #0x1
   6981e: d102         	bne	0x69826 <check_error+0x319e> @ imm = #0x4
   69820: 2001         	movs	r0, #0x1
   69822: f886 07f2    	strb.w	r0, [r6, #0x7f2]
   69826: eb04 0184    	add.w	r1, r4, r4, lsl #2
   6982a: f245 22e0    	movw	r2, #0x52e0
   6982e: f1c1 00b4    	rsb.w	r0, r1, #0xb4
   69832: b289         	uxth	r1, r1
   69834: eb0e 00c0    	add.w	r0, lr, r0, lsl #3
   69838: 4410         	add	r0, r2
   6983a: f002 ff31    	bl	0x6c6a0 <math_mean>     @ imm = #0x2e62
   6983e: 993d         	ldr	r1, [sp, #0xf4]
   69840: eeb0 9b40    	vmov.f64	d9, d0
   69844: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   69848: f501 6092    	add.w	r0, r1, #0x490
   6984c: edd0 0b00    	vldr	d16, [r0]
   69850: f501 6093    	add.w	r0, r1, #0x498
   69854: ee20 db20    	vmul.f64	d13, d0, d16
   69858: edd0 0b00    	vldr	d16, [r0]
   6985c: f501 6091    	add.w	r0, r1, #0x488
   69860: ee20 cb20    	vmul.f64	d12, d0, d16
   69864: edd0 0b00    	vldr	d16, [r0]
   69868: f501 6096    	add.w	r0, r1, #0x4b0
   6986c: ee20 8b20    	vmul.f64	d8, d0, d16
   69870: edd0 0b00    	vldr	d16, [r0]
   69874: 983b         	ldr	r0, [sp, #0xec]
   69876: f8d0 0005    	ldr.w	r0, [r0, #0x5]
   6987a: ee00 0a10    	vmov	s0, r0
   6987e: f501 6095    	add.w	r0, r1, #0x4a8
   69882: eef7 1ac0    	vcvt.f64.f32	d17, s0
   69886: edd0 4b00    	vldr	d20, [r0]
   6988a: f501 6094    	add.w	r0, r1, #0x4a0
   6988e: ee60 3ba1    	vmul.f64	d19, d16, d17
   69892: f241 6121    	movw	r1, #0x1621
   69896: edd0 5b00    	vldr	d21, [r0]
   6989a: 2000         	movs	r0, #0x0
   6989c: 28b3         	cmp	r0, #0xb3
   6989e: f001 853b    	beq.w	0x6b318 <check_error+0x4c90> @ imm = #0x1a76
   698a2: eb0e 0280    	add.w	r2, lr, r0, lsl #2
   698a6: 3001         	adds	r0, #0x1
   698a8: f502 42b1    	add.w	r2, r2, #0x5880
   698ac: 460b         	mov	r3, r1
   698ae: f5a3 55b1    	sub.w	r5, r3, #0x1620
   698b2: 2db3         	cmp	r5, #0xb3
   698b4: d807         	bhi	0x698c6 <check_error+0x323e> @ imm = #0xe
   698b6: f85e 5023    	ldr.w	r5, [lr, r3, lsl #2]
   698ba: 3301         	adds	r3, #0x1
   698bc: 6816         	ldr	r6, [r2]
   698be: 42ae         	cmp	r6, r5
   698c0: 9e52         	ldr	r6, [sp, #0x148]
   698c2: d1f4         	bne	0x698ae <check_error+0x3226> @ imm = #-0x18
   698c4: e61d         	b	0x69502 <check_error+0x2e7a> @ imm = #-0x3c6
   698c6: 3101         	adds	r1, #0x1
   698c8: e7e8         	b	0x6989c <check_error+0x3214> @ imm = #-0x30
   698ca: eeb5 8b40    	vcmp.f64	d8, #0
   698ce: 9d35         	ldr	r5, [sp, #0xd4]
   698d0: edd5 0b02    	vldr	d16, [r5, #8]
   698d4: eef1 1b48    	vneg.f64	d17, d8
   698d8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   698dc: bf48         	it	mi
   698de: eeb0 8b61    	vmovmi.f64	d8, d17
   698e2: a804         	add	r0, sp, #0x10
   698e4: f500 50c9    	add.w	r0, r0, #0x1920
   698e8: ed00 8b02    	vstr	d8, [r0, #-8]
   698ec: edc0 0b00    	vstr	d16, [r0]
   698f0: a802         	add	r0, sp, #0x8
   698f2: 4c87         	ldr	r4, [pc, #0x21c]        @ 0x69b10 <check_error+0x3488>
   698f4: f500 50c9    	add.w	r0, r0, #0x1920
   698f8: 447c         	add	r4, pc
   698fa: 47a0         	blx	r4
   698fc: eeb5 9b40    	vcmp.f64	d9, #0
   69900: f50d 50a2    	add.w	r0, sp, #0x1440
   69904: eef1 0b49    	vneg.f64	d16, d9
   69908: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6990c: bf48         	it	mi
   6990e: eeb0 9b60    	vmovmi.f64	d9, d16
   69912: edd5 0b04    	vldr	d16, [r5, #16]
   69916: ed00 9b02    	vstr	d9, [r0, #-8]
   6991a: edc0 0b00    	vstr	d16, [r0]
   6991e: a806         	add	r0, sp, #0x18
   69920: f500 50a1    	add.w	r0, r0, #0x1420
   69924: eeb0 8b40    	vmov.f64	d8, d0
   69928: 47a0         	blx	r4
   6992a: edd5 0b06    	vldr	d16, [r5, #24]
   6992e: a802         	add	r0, sp, #0x8
   69930: f500 5080    	add.w	r0, r0, #0x1000
   69934: eeb0 9b40    	vmov.f64	d9, d0
   69938: ed00 bb02    	vstr	d11, [r0, #-8]
   6993c: edc0 0b00    	vstr	d16, [r0]
   69940: f50d 5080    	add.w	r0, sp, #0x1000
   69944: 47a0         	blx	r4
   69946: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   6994a: a80c         	add	r0, sp, #0x30
   6994c: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   69950: f500 531f    	add.w	r3, r0, #0x27c0
   69954: 9952         	ldr	r1, [sp, #0x148]
   69956: f501 6004    	add.w	r0, r1, #0x840
   6995a: ed80 0b00    	vstr	d0, [r0]
   6995e: f501 6003    	add.w	r0, r1, #0x830
   69962: ed80 9b00    	vstr	d9, [r0]
   69966: f501 6002    	add.w	r0, r1, #0x820
   6996a: ed80 8b00    	vstr	d8, [r0]
   6996e: 983d         	ldr	r0, [sp, #0xf4]
   69970: f8b0 5506    	ldrh.w	r5, [r0, #0x506]
   69974: fa0f f08e    	sxth.w	r0, lr
   69978: fa0f fb85    	sxth.w	r11, r5
   6997c: 4558         	cmp	r0, r11
   6997e: f340 8299    	ble.w	0x69eb4 <check_error+0x382c> @ imm = #0x532
   69982: 4618         	mov	r0, r3
   69984: f241 11f8    	movw	r1, #0x11f8
   69988: f005 eb3a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x5674
   6998c: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   69990: f246 101a    	movw	r0, #0x611a
   69994: 2100         	movs	r1, #0x0
   69996: eb0c 0200    	add.w	r2, r12, r0
   6999a: f246 3060    	movw	r0, #0x6360
   6999e: eb0c 0300    	add.w	r3, r12, r0
   699a2: 983d         	ldr	r0, [sp, #0xf4]
   699a4: f8b0 0504    	ldrh.w	r0, [r0, #0x504]
   699a8: 1a28         	subs	r0, r5, r0
   699aa: 2500         	movs	r5, #0x0
   699ac: 4285         	cmp	r5, r0
   699ae: dc18         	bgt	0x699e2 <check_error+0x335a> @ imm = #0x30
   699b0: 5d54         	ldrb	r4, [r2, r5]
   699b2: b99c         	cbnz	r4, 0x699dc <check_error+0x3354> @ imm = #0x26
   699b4: ae0c         	add	r6, sp, #0x30
   699b6: edd3 0b00    	vldr	d16, [r3]
   699ba: b28c         	uxth	r4, r1
   699bc: f506 561f    	add.w	r6, r6, #0x27c0
   699c0: eef5 0b40    	vcmp.f64	d16, #0
   699c4: eb06 04c4    	add.w	r4, r6, r4, lsl #3
   699c8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   699cc: eef1 1b60    	vneg.f64	d17, d16
   699d0: bf48         	it	mi
   699d2: eef0 0b61    	vmovmi.f64	d16, d17
   699d6: 3101         	adds	r1, #0x1
   699d8: edc4 0b00    	vstr	d16, [r4]
   699dc: 3308         	adds	r3, #0x8
   699de: 3501         	adds	r5, #0x1
   699e0: e7e4         	b	0x699ac <check_error+0x3324> @ imm = #-0x38
   699e2: fa1f f28b    	uxth.w	r2, r11
   699e6: eeb6 8b00    	vmov.f64	d8, #5.000000e-01
   699ea: b289         	uxth	r1, r1
   699ec: ee00 2a10    	vmov	s0, r2
   699f0: eef8 0b40    	vcvt.f64.u32	d16, s0
   699f4: ee00 1a10    	vmov	s0, r1
   699f8: ee60 0b88    	vmul.f64	d16, d16, d8
   699fc: eef8 1b40    	vcvt.f64.u32	d17, s0
   69a00: eef4 0b61    	vcmp.f64	d16, d17
   69a04: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69a08: d812         	bhi	0x69a30 <check_error+0x33a8> @ imm = #0x24
   69a0a: a80c         	add	r0, sp, #0x30
   69a0c: 2205         	movs	r2, #0x5
   69a0e: f500 501f    	add.w	r0, r0, #0x27c0
   69a12: f004 fbad    	bl	0x6e170 <f_trimmed_mean> @ imm = #0x475a
   69a16: e9dd 0c52    	ldrd	r0, r12, [sp, #328]
   69a1a: 993d         	ldr	r1, [sp, #0xf4]
   69a1c: f600 0028    	addw	r0, r0, #0x828
   69a20: ed80 0b00    	vstr	d0, [r0]
   69a24: f8b1 0504    	ldrh.w	r0, [r1, #0x504]
   69a28: f8b1 b506    	ldrh.w	r11, [r1, #0x506]
   69a2c: ebab 0000    	sub.w	r0, r11, r0
   69a30: f246 111a    	movw	r1, #0x611a
   69a34: ac0c         	add	r4, sp, #0x30
   69a36: eb0c 0201    	add.w	r2, r12, r1
   69a3a: f247 5158    	movw	r1, #0x7558
   69a3e: eb0c 0301    	add.w	r3, r12, r1
   69a42: f504 561f    	add.w	r6, r4, #0x27c0
   69a46: 2100         	movs	r1, #0x0
   69a48: 2500         	movs	r5, #0x0
   69a4a: 4285         	cmp	r5, r0
   69a4c: dc15         	bgt	0x69a7a <check_error+0x33f2> @ imm = #0x2a
   69a4e: 5d54         	ldrb	r4, [r2, r5]
   69a50: b984         	cbnz	r4, 0x69a74 <check_error+0x33ec> @ imm = #0x20
   69a52: edd3 0b00    	vldr	d16, [r3]
   69a56: b28c         	uxth	r4, r1
   69a58: eef5 0b40    	vcmp.f64	d16, #0
   69a5c: eb06 04c4    	add.w	r4, r6, r4, lsl #3
   69a60: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69a64: eef1 1b60    	vneg.f64	d17, d16
   69a68: bf48         	it	mi
   69a6a: eef0 0b61    	vmovmi.f64	d16, d17
   69a6e: 3101         	adds	r1, #0x1
   69a70: edc4 0b00    	vstr	d16, [r4]
   69a74: 3308         	adds	r3, #0x8
   69a76: 3501         	adds	r5, #0x1
   69a78: e7e7         	b	0x69a4a <check_error+0x33c2> @ imm = #-0x32
   69a7a: fa1f f28b    	uxth.w	r2, r11
   69a7e: b289         	uxth	r1, r1
   69a80: ee00 2a10    	vmov	s0, r2
   69a84: eef8 0b40    	vcvt.f64.u32	d16, s0
   69a88: ee00 1a10    	vmov	s0, r1
   69a8c: ee60 0b88    	vmul.f64	d16, d16, d8
   69a90: eef8 1b40    	vcvt.f64.u32	d17, s0
   69a94: eef4 0b61    	vcmp.f64	d16, d17
   69a98: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69a9c: d815         	bhi	0x69aca <check_error+0x3442> @ imm = #0x2a
   69a9e: a80c         	add	r0, sp, #0x30
   69aa0: 2205         	movs	r2, #0x5
   69aa2: f500 501f    	add.w	r0, r0, #0x27c0
   69aa6: f004 fb63    	bl	0x6e170 <f_trimmed_mean> @ imm = #0x46c6
   69aaa: a80c         	add	r0, sp, #0x30
   69aac: 993d         	ldr	r1, [sp, #0xf4]
   69aae: f500 561f    	add.w	r6, r0, #0x27c0
   69ab2: e9dd 0c52    	ldrd	r0, r12, [sp, #328]
   69ab6: f600 0038    	addw	r0, r0, #0x838
   69aba: f8b1 b506    	ldrh.w	r11, [r1, #0x506]
   69abe: ed80 0b00    	vstr	d0, [r0]
   69ac2: f8b1 0504    	ldrh.w	r0, [r1, #0x504]
   69ac6: ebab 0000    	sub.w	r0, r11, r0
   69aca: f246 111a    	movw	r1, #0x611a
   69ace: eb0c 0201    	add.w	r2, r12, r1
   69ad2: f248 7150    	movw	r1, #0x8750
   69ad6: eb0c 0301    	add.w	r3, r12, r1
   69ada: 2100         	movs	r1, #0x0
   69adc: 2500         	movs	r5, #0x0
   69ade: 4285         	cmp	r5, r0
   69ae0: dc18         	bgt	0x69b14 <check_error+0x348c> @ imm = #0x30
   69ae2: 5d54         	ldrb	r4, [r2, r5]
   69ae4: b984         	cbnz	r4, 0x69b08 <check_error+0x3480> @ imm = #0x20
   69ae6: edd3 0b00    	vldr	d16, [r3]
   69aea: b28c         	uxth	r4, r1
   69aec: eef5 0b40    	vcmp.f64	d16, #0
   69af0: eb06 04c4    	add.w	r4, r6, r4, lsl #3
   69af4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69af8: eef1 1b60    	vneg.f64	d17, d16
   69afc: bf48         	it	mi
   69afe: eef0 0b61    	vmovmi.f64	d16, d17
   69b02: 3101         	adds	r1, #0x1
   69b04: edc4 0b00    	vstr	d16, [r4]
   69b08: 3308         	adds	r3, #0x8
   69b0a: 3501         	adds	r5, #0x1
   69b0c: e7e7         	b	0x69ade <check_error+0x3456> @ imm = #-0x32
   69b0e: bf00         	nop
   69b10: 05 4b 00 00  	.word	0x00004b05
   69b14: fa1f f08b    	uxth.w	r0, r11
   69b18: b289         	uxth	r1, r1
   69b1a: ee00 0a10    	vmov	s0, r0
   69b1e: eef8 0b40    	vcvt.f64.u32	d16, s0
   69b22: ee00 1a10    	vmov	s0, r1
   69b26: ee60 0b88    	vmul.f64	d16, d16, d8
   69b2a: eeb8 9b40    	vcvt.f64.u32	d9, s0
   69b2e: eef4 0b49    	vcmp.f64	d16, d9
   69b32: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69b36: d814         	bhi	0x69b62 <check_error+0x34da> @ imm = #0x28
   69b38: a80c         	add	r0, sp, #0x30
   69b3a: 2205         	movs	r2, #0x5
   69b3c: f500 501f    	add.w	r0, r0, #0x27c0
   69b40: f004 fb16    	bl	0x6e170 <f_trimmed_mean> @ imm = #0x462c
   69b44: e9dd 0c52    	ldrd	r0, r12, [sp, #328]
   69b48: f600 0048    	addw	r0, r0, #0x848
   69b4c: ed80 0b00    	vstr	d0, [r0]
   69b50: 983d         	ldr	r0, [sp, #0xf4]
   69b52: f8b0 0506    	ldrh.w	r0, [r0, #0x506]
   69b56: ee00 0a10    	vmov	s0, r0
   69b5a: eef8 0b40    	vcvt.f64.u32	d16, s0
   69b5e: ee60 0b88    	vmul.f64	d16, d16, d8
   69b62: eef4 0b49    	vcmp.f64	d16, d9
   69b66: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   69b6a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69b6e: f200 81a1    	bhi.w	0x69eb4 <check_error+0x382c> @ imm = #0x342
   69b72: f8dd b148    	ldr.w	r11, [sp, #0x148]
   69b76: 2102         	movs	r1, #0x2
   69b78: 9d3d         	ldr	r5, [sp, #0xf4]
   69b7a: f50b 6002    	add.w	r0, r11, #0x820
   69b7e: 905e         	str	r0, [sp, #0x178]
   69b80: f505 64a3    	add.w	r4, r5, #0x518
   69b84: edd0 0b00    	vldr	d16, [r0]
   69b88: f60b 0028    	addw	r0, r11, #0x828
   69b8c: edd4 1b00    	vldr	d17, [r4]
   69b90: edd0 2b00    	vldr	d18, [r0]
   69b94: a80a         	add	r0, sp, #0x28
   69b96: f500 5067    	add.w	r0, r0, #0x39c0
   69b9a: ee62 1ba1    	vmul.f64	d17, d18, d17
   69b9e: edc0 1b00    	vstr	d17, [r0]
   69ba2: edc0 0b02    	vstr	d16, [r0, #8]
   69ba6: a80a         	add	r0, sp, #0x28
   69ba8: 4ed6         	ldr	r6, [pc, #0x358]        @ 0x69f04 <check_error+0x387c>
   69baa: f500 5067    	add.w	r0, r0, #0x39c0
   69bae: 447e         	add	r6, pc
   69bb0: 47b0         	blx	r6
   69bb2: f505 60a5    	add.w	r0, r5, #0x528
   69bb6: 9060         	str	r0, [sp, #0x180]
   69bb8: ed94 db02    	vldr	d13, [r4, #8]
   69bbc: 2102         	movs	r1, #0x2
   69bbe: edd0 0b00    	vldr	d16, [r0]
   69bc2: f60b 0038    	addw	r0, r11, #0x838
   69bc6: eeb0 8b40    	vmov.f64	d8, d0
   69bca: edd0 1b00    	vldr	d17, [r0]
   69bce: f50b 6003    	add.w	r0, r11, #0x830
   69bd2: 905c         	str	r0, [sp, #0x170]
   69bd4: ee61 0ba0    	vmul.f64	d16, d17, d16
   69bd8: edd0 1b00    	vldr	d17, [r0]
   69bdc: a804         	add	r0, sp, #0x10
   69bde: f500 50c9    	add.w	r0, r0, #0x1920
   69be2: ed40 0b02    	vstr	d16, [r0, #-8]
   69be6: edc0 1b00    	vstr	d17, [r0]
   69bea: a802         	add	r0, sp, #0x8
   69bec: f500 50c9    	add.w	r0, r0, #0x1920
   69bf0: 47b0         	blx	r6
   69bf2: f505 6aa8    	add.w	r10, r5, #0x540
   69bf6: f60b 0048    	addw	r0, r11, #0x848
   69bfa: f50b 6404    	add.w	r4, r11, #0x840
   69bfe: 2102         	movs	r1, #0x2
   69c00: ed90 cb00    	vldr	d12, [r0]
   69c04: edda 0b00    	vldr	d16, [r10]
   69c08: 9860         	ldr	r0, [sp, #0x180]
   69c0a: eeb0 ab40    	vmov.f64	d10, d0
   69c0e: ee6c 0b20    	vmul.f64	d16, d12, d16
   69c12: ed90 fb02    	vldr	d15, [r0, #8]
   69c16: f50d 50a2    	add.w	r0, sp, #0x1440
   69c1a: edd4 1b00    	vldr	d17, [r4]
   69c1e: ed40 0b02    	vstr	d16, [r0, #-8]
   69c22: edc0 1b00    	vstr	d17, [r0]
   69c26: a806         	add	r0, sp, #0x18
   69c28: f500 50a1    	add.w	r0, r0, #0x1420
   69c2c: 47b0         	blx	r6
   69c2e: edda 0b02    	vldr	d16, [r10, #8]
   69c32: f60b 0008    	addw	r0, r11, #0x808
   69c36: eeb0 9b40    	vmov.f64	d9, d0
   69c3a: edcd 0b60    	vstr	d16, [sp, #384]
   69c3e: edd0 0b00    	vldr	d16, [r0]
   69c42: eef4 0b60    	vcmp.f64	d16, d16
   69c46: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69c4a: f182 84c6    	bvs.w	0x6c5da <check_error+0x5f52> @ imm = #0x298c
   69c4e: ee68 1b0d    	vmul.f64	d17, d8, d13
   69c52: f8dd a0a8    	ldr.w	r10, [sp, #0xa8]
   69c56: eef4 0b61    	vcmp.f64	d16, d17
   69c5a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69c5e: db0d         	blt	0x69c7c <check_error+0x35f4> @ imm = #0x1a
   69c60: 983d         	ldr	r0, [sp, #0xf4]
   69c62: f500 60aa    	add.w	r0, r0, #0x550
   69c66: edd0 0b00    	vldr	d16, [r0]
   69c6a: eeb4 bb60    	vcmp.f64	d11, d16
   69c6e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69c72: dd03         	ble	0x69c7c <check_error+0x35f4> @ imm = #0x6
   69c74: 2001         	movs	r0, #0x1
   69c76: 9952         	ldr	r1, [sp, #0x148]
   69c78: f881 0860    	strb.w	r0, [r1, #0x860]
   69c7c: 9852         	ldr	r0, [sp, #0x148]
   69c7e: f500 6001    	add.w	r0, r0, #0x810
   69c82: ed90 8b00    	vldr	d8, [r0]
   69c86: eeb4 8b48    	vcmp.f64	d8, d8
   69c8a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69c8e: f182 84a9    	bvs.w	0x6c5e4 <check_error+0x5f5c> @ imm = #0x2952
   69c92: ee6a 0b0f    	vmul.f64	d16, d10, d15
   69c96: eeb4 8b60    	vcmp.f64	d8, d16
   69c9a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69c9e: bfa2         	ittt	ge
   69ca0: 2001         	movge	r0, #0x1
   69ca2: 9952         	ldrge	r1, [sp, #0x148]
   69ca4: f881 0861    	strbge.w	r0, [r1, #0x861]
   69ca8: 983d         	ldr	r0, [sp, #0xf4]
   69caa: eeb0 0b48    	vmov.f64	d0, d8
   69cae: 2103         	movs	r1, #0x3
   69cb0: f500 60a7    	add.w	r0, r0, #0x538
   69cb4: ed90 1b00    	vldr	d1, [r0]
   69cb8: 200a         	movs	r0, #0xa
   69cba: f002 fdb5    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x2b6a
   69cbe: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   69cc2: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   69cc6: b118         	cbz	r0, 0x69cd0 <check_error+0x3648> @ imm = #0x6
   69cc8: 2001         	movs	r0, #0x1
   69cca: 9952         	ldr	r1, [sp, #0x148]
   69ccc: f881 0862    	strb.w	r0, [r1, #0x862]
   69cd0: f1be 0f02    	cmp.w	lr, #0x2
   69cd4: d32c         	blo	0x69d30 <check_error+0x36a8> @ imm = #0x58
   69cd6: 9835         	ldr	r0, [sp, #0xd4]
   69cd8: f890 0020    	ldrb.w	r0, [r0, #0x20]
   69cdc: 2801         	cmp	r0, #0x1
   69cde: d109         	bne	0x69cf4 <check_error+0x366c> @ imm = #0x12
   69ce0: eeb5 8b40    	vcmp.f64	d8, #0
   69ce4: 2000         	movs	r0, #0x0
   69ce6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69cea: bfa8         	it	ge
   69cec: 2001         	movge	r0, #0x1
   69cee: 9952         	ldr	r1, [sp, #0x148]
   69cf0: f881 0860    	strb.w	r0, [r1, #0x860]
   69cf4: 9835         	ldr	r0, [sp, #0xd4]
   69cf6: f890 0021    	ldrb.w	r0, [r0, #0x21]
   69cfa: 2801         	cmp	r0, #0x1
   69cfc: d109         	bne	0x69d12 <check_error+0x368a> @ imm = #0x12
   69cfe: eeb5 8b40    	vcmp.f64	d8, #0
   69d02: 2000         	movs	r0, #0x0
   69d04: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69d08: bfa8         	it	ge
   69d0a: 2001         	movge	r0, #0x1
   69d0c: 9952         	ldr	r1, [sp, #0x148]
   69d0e: f881 0861    	strb.w	r0, [r1, #0x861]
   69d12: 9835         	ldr	r0, [sp, #0xd4]
   69d14: f890 0022    	ldrb.w	r0, [r0, #0x22]
   69d18: 2801         	cmp	r0, #0x1
   69d1a: d109         	bne	0x69d30 <check_error+0x36a8> @ imm = #0x12
   69d1c: eeb5 8b40    	vcmp.f64	d8, #0
   69d20: 2000         	movs	r0, #0x0
   69d22: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69d26: bfa8         	it	ge
   69d28: 2001         	movge	r0, #0x1
   69d2a: 9952         	ldr	r1, [sp, #0x148]
   69d2c: f881 0862    	strb.w	r0, [r1, #0x862]
   69d30: 9852         	ldr	r0, [sp, #0x148]
   69d32: eeb4 cb4c    	vcmp.f64	d12, d12
   69d36: f890 1860    	ldrb.w	r1, [r0, #0x860]
   69d3a: f890 0862    	ldrb.w	r0, [r0, #0x862]
   69d3e: 2901         	cmp	r1, #0x1
   69d40: bf01         	itttt	eq
   69d42: 2801         	cmpeq	r0, #0x1
   69d44: 2101         	moveq	r1, #0x1
   69d46: 9a52         	ldreq	r2, [sp, #0x148]
   69d48: f882 17fd    	strbeq.w	r1, [r2, #0x7fd]
   69d4c: 9952         	ldr	r1, [sp, #0x148]
   69d4e: f891 1861    	ldrb.w	r1, [r1, #0x861]
   69d52: 2901         	cmp	r1, #0x1
   69d54: bf01         	itttt	eq
   69d56: 2801         	cmpeq	r0, #0x1
   69d58: 2001         	moveq	r0, #0x1
   69d5a: 9952         	ldreq	r1, [sp, #0x148]
   69d5c: f881 07fe    	strbeq.w	r0, [r1, #0x7fe]
   69d60: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69d64: f182 8448    	bvs.w	0x6c5f8 <check_error+0x5f70> @ imm = #0x2890
   69d68: eddd 0b60    	vldr	d16, [sp, #384]
   69d6c: ee69 0b20    	vmul.f64	d16, d9, d16
   69d70: eeb4 bb60    	vcmp.f64	d11, d16
   69d74: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69d78: da03         	bge	0x69d82 <check_error+0x36fa> @ imm = #0x6
   69d7a: 9952         	ldr	r1, [sp, #0x148]
   69d7c: f891 07ff    	ldrb.w	r0, [r1, #0x7ff]
   69d80: e003         	b	0x69d8a <check_error+0x3702> @ imm = #0x6
   69d82: 2001         	movs	r0, #0x1
   69d84: 9952         	ldr	r1, [sp, #0x148]
   69d86: f881 07ff    	strb.w	r0, [r1, #0x7ff]
   69d8a: f891 17fd    	ldrb.w	r1, [r1, #0x7fd]
   69d8e: b101         	cbz	r1, 0x69d92 <check_error+0x370a> @ imm = #0x0
   69d90: b940         	cbnz	r0, 0x69da4 <check_error+0x371c> @ imm = #0x10
   69d92: 9952         	ldr	r1, [sp, #0x148]
   69d94: f891 17fe    	ldrb.w	r1, [r1, #0x7fe]
   69d98: 2900         	cmp	r1, #0x0
   69d9a: f000 84e4    	beq.w	0x6a766 <check_error+0x40de> @ imm = #0x9c8
   69d9e: 2800         	cmp	r0, #0x0
   69da0: f000 84e1    	beq.w	0x6a766 <check_error+0x40de> @ imm = #0x9c2
   69da4: 9952         	ldr	r1, [sp, #0x148]
   69da6: 2001         	movs	r0, #0x1
   69da8: f881 0800    	strb.w	r0, [r1, #0x800]
   69dac: 9829         	ldr	r0, [sp, #0xa4]
   69dae: 7800         	ldrb	r0, [r0]
   69db0: 2800         	cmp	r0, #0x0
   69db2: d06e         	beq	0x69e92 <check_error+0x380a> @ imm = #0xdc
   69db4: 9935         	ldr	r1, [sp, #0xd4]
   69db6: edd1 0b0a    	vldr	d16, [r1, #40]
   69dba: eef4 0b60    	vcmp.f64	d16, d16
   69dbe: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69dc2: bf78         	it	vc
   69dc4: eeb0 bb60    	vmovvc.f64	d11, d16
   69dc8: 9952         	ldr	r1, [sp, #0x148]
   69dca: 2800         	cmp	r0, #0x0
   69dcc: f601 0118    	addw	r1, r1, #0x818
   69dd0: ed81 bb00    	vstr	d11, [r1]
   69dd4: d06e         	beq	0x69eb4 <check_error+0x382c> @ imm = #0xdc
   69dd6: 993d         	ldr	r1, [sp, #0xf4]
   69dd8: f06f 0007    	mvn	r0, #0x7
   69ddc: 9e52         	ldr	r6, [sp, #0x148]
   69dde: f8b1 2568    	ldrh.w	r2, [r1, #0x568]
   69de2: eba0 03c2    	sub.w	r3, r0, r2, lsl #3
   69de6: fa5f f088    	uxtb.w	r0, r8
   69dea: eb09 04c0    	add.w	r4, r9, r0, lsl #3
   69dee: f501 60ab    	add.w	r0, r1, #0x558
   69df2: 2100         	movs	r1, #0x0
   69df4: edd0 1b00    	vldr	d17, [r0]
   69df8: 1c50         	adds	r0, r2, #0x1
   69dfa: ee60 0ba1    	vmul.f64	d16, d16, d17
   69dfe: b153         	cbz	r3, 0x69e16 <check_error+0x378e> @ imm = #0x14
   69e00: 18e5         	adds	r5, r4, r3
   69e02: edd5 1b00    	vldr	d17, [r5]
   69e06: eef4 1b60    	vcmp.f64	d17, d16
   69e0a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69e0e: bf48         	it	mi
   69e10: 3101         	addmi	r1, #0x1
   69e12: 3308         	adds	r3, #0x8
   69e14: e7f3         	b	0x69dfe <check_error+0x3776> @ imm = #-0x1a
   69e16: 2300         	movs	r3, #0x0
   69e18: eba3 04c2    	sub.w	r4, r3, r2, lsl #3
   69e1c: f248 7250    	movw	r2, #0x8750
   69e20: eb0c 0502    	add.w	r5, r12, r2
   69e24: 9a3d         	ldr	r2, [sp, #0xf4]
   69e26: f502 62ac    	add.w	r2, r2, #0x560
   69e2a: edd2 0b00    	vldr	d16, [r2]
   69e2e: 2200         	movs	r2, #0x0
   69e30: 2c08         	cmp	r4, #0x8
   69e32: d011         	beq	0x69e58 <check_error+0x37d0> @ imm = #0x22
   69e34: 192e         	adds	r6, r5, r4
   69e36: edd6 1b00    	vldr	d17, [r6]
   69e3a: 9e52         	ldr	r6, [sp, #0x148]
   69e3c: eef4 1b60    	vcmp.f64	d17, d16
   69e40: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69e44: bf48         	it	mi
   69e46: 3301         	addmi	r3, #0x1
   69e48: eef4 1b61    	vcmp.f64	d17, d17
   69e4c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69e50: bf68         	it	vs
   69e52: 2201         	movvs	r2, #0x1
   69e54: 3408         	adds	r4, #0x8
   69e56: e7eb         	b	0x69e30 <check_error+0x37a8> @ imm = #-0x2a
   69e58: eeb4 8b60    	vcmp.f64	d8, d16
   69e5c: b2c9         	uxtb	r1, r1
   69e5e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69e62: bf48         	it	mi
   69e64: 3301         	addmi	r3, #0x1
   69e66: b2db         	uxtb	r3, r3
   69e68: eeb4 8b48    	vcmp.f64	d8, d8
   69e6c: 4043         	eors	r3, r0
   69e6e: 4048         	eors	r0, r1
   69e70: 4318         	orrs	r0, r3
   69e72: bf18         	it	ne
   69e74: 2001         	movne	r0, #0x1
   69e76: 2100         	movs	r1, #0x0
   69e78: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69e7c: bf78         	it	vc
   69e7e: 2101         	movvc	r1, #0x1
   69e80: 4008         	ands	r0, r1
   69e82: b2d1         	uxtb	r1, r2
   69e84: 3901         	subs	r1, #0x1
   69e86: bf18         	it	ne
   69e88: 2101         	movne	r1, #0x1
   69e8a: 4008         	ands	r0, r1
   69e8c: f886 0800    	strb.w	r0, [r6, #0x800]
   69e90: e010         	b	0x69eb4 <check_error+0x382c> @ imm = #0x20
   69e92: 9852         	ldr	r0, [sp, #0x148]
   69e94: f600 0018    	addw	r0, r0, #0x818
   69e98: ed80 bb00    	vstr	d11, [r0]
   69e9c: 9835         	ldr	r0, [sp, #0xd4]
   69e9e: 3008         	adds	r0, #0x8
   69ea0: ecf0 0b06    	vldmia	r0!, {d16, d17, d18}
   69ea4: 985e         	ldr	r0, [sp, #0x178]
   69ea6: edc4 2b00    	vstr	d18, [r4]
   69eaa: edc0 0b00    	vstr	d16, [r0]
   69eae: 985c         	ldr	r0, [sp, #0x170]
   69eb0: edc0 1b00    	vstr	d17, [r0]
   69eb4: f246 101b    	movw	r0, #0x611b
   69eb8: f246 3160    	movw	r1, #0x6360
   69ebc: f248 7258    	movw	r2, #0x8758
   69ec0: 4b11         	ldr	r3, [pc, #0x44]         @ 0x69f08 <check_error+0x3880>
   69ec2: 9e52         	ldr	r6, [sp, #0x148]
   69ec4: 4460         	add	r0, r12
   69ec6: f8dd b188    	ldr.w	r11, [sp, #0x188]
   69eca: 4461         	add	r1, r12
   69ecc: 4462         	add	r2, r12
   69ece: b31b         	cbz	r3, 0x69f18 <check_error+0x3890> @ imm = #0x46
   69ed0: 18c4         	adds	r4, r0, r3
   69ed2: 3301         	adds	r3, #0x1
   69ed4: f894 523e    	ldrb.w	r5, [r4, #0x23e]
   69ed8: f884 523d    	strb.w	r5, [r4, #0x23d]
   69edc: f501 5490    	add.w	r4, r1, #0x1200
   69ee0: edd1 0b02    	vldr	d16, [r1, #8]
   69ee4: edc1 0b00    	vstr	d16, [r1]
   69ee8: 3108         	adds	r1, #0x8
   69eea: edd4 0b00    	vldr	d16, [r4]
   69eee: f5a2 5490    	sub.w	r4, r2, #0x1200
   69ef2: edc4 0b00    	vstr	d16, [r4]
   69ef6: edd2 0b00    	vldr	d16, [r2]
   69efa: ed42 0b02    	vstr	d16, [r2, #-8]
   69efe: 3208         	adds	r2, #0x8
   69f00: e7e5         	b	0x69ece <check_error+0x3846> @ imm = #-0x36
   69f02: bf00         	nop
   69f04: 97 48 00 00  	.word	0x00004897
   69f08: c2 fd ff ff  	.word	0xfffffdc2
   69f0c: 00 bf 00 bf  	.word	0xbf00bf00
   69f10: 00 00 00 00  	.word	0x00000000
   69f14: 00 00 f8 7f  	.word	0x7ff80000
   69f18: 9929         	ldr	r1, [sp, #0xa4]
   69f1a: f896 0800    	ldrb.w	r0, [r6, #0x800]
   69f1e: ed1f ab04    	vldr	d10, [pc, #-16]         @ 0x69f10 <check_error+0x3888>
   69f22: 7008         	strb	r0, [r1]
   69f24: f606 0008    	addw	r0, r6, #0x808
   69f28: 993d         	ldr	r1, [sp, #0xf4]
   69f2a: edd0 0b00    	vldr	d16, [r0]
   69f2e: 9824         	ldr	r0, [sp, #0x90]
   69f30: 4de6         	ldr	r5, [pc, #0x398]        @ 0x6a2cc <check_error+0x3c44>
   69f32: edc0 0b00    	vstr	d16, [r0]
   69f36: f506 6001    	add.w	r0, r6, #0x810
   69f3a: edd0 0b00    	vldr	d16, [r0]
   69f3e: 9825         	ldr	r0, [sp, #0x94]
   69f40: edc0 0b00    	vstr	d16, [r0]
   69f44: 9839         	ldr	r0, [sp, #0xe4]
   69f46: edd0 0b02    	vldr	d16, [r0, #8]
   69f4a: f501 60aa    	add.w	r0, r1, #0x550
   69f4e: ed90 8b00    	vldr	d8, [r0]
   69f52: f506 6002    	add.w	r0, r6, #0x820
   69f56: eef4 0b48    	vcmp.f64	d16, d8
   69f5a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   69f5e: bf48         	it	mi
   69f60: eef0 0b4a    	vmovmi.f64	d16, d10
   69f64: 9a35         	ldr	r2, [sp, #0xd4]
   69f66: edc2 0b00    	vstr	d16, [r2]
   69f6a: edd0 0b00    	vldr	d16, [r0]
   69f6e: f506 6003    	add.w	r0, r6, #0x830
   69f72: edc2 0b02    	vstr	d16, [r2, #8]
   69f76: edd0 0b00    	vldr	d16, [r0]
   69f7a: f506 6004    	add.w	r0, r6, #0x840
   69f7e: edc2 0b04    	vstr	d16, [r2, #16]
   69f82: edd0 0b00    	vldr	d16, [r0]
   69f86: edc2 0b06    	vstr	d16, [r2, #24]
   69f8a: f896 0860    	ldrb.w	r0, [r6, #0x860]
   69f8e: f882 0020    	strb.w	r0, [r2, #0x20]
   69f92: f896 0861    	ldrb.w	r0, [r6, #0x861]
   69f96: f882 0021    	strb.w	r0, [r2, #0x21]
   69f9a: f896 0862    	ldrb.w	r0, [r6, #0x862]
   69f9e: f882 0022    	strb.w	r0, [r2, #0x22]
   69fa2: f606 0018    	addw	r0, r6, #0x818
   69fa6: edd0 0b00    	vldr	d16, [r0]
   69faa: edc2 0b0a    	vstr	d16, [r2, #40]
   69fae: f8b1 14d6    	ldrh.w	r1, [r1, #0x4d6]
   69fb2: ed9a 9b00    	vldr	d9, [r10]
   69fb6: 458e         	cmp	lr, r1
   69fb8: f240 80af    	bls.w	0x6a11a <check_error+0x3a92> @ imm = #0x15e
   69fbc: ebab 0001    	sub.w	r0, r11, r1
   69fc0: f240 3361    	movw	r3, #0x361
   69fc4: 1a59         	subs	r1, r3, r1
   69fc6: 1c42         	adds	r2, r0, #0x1
   69fc8: eb0c 0141    	add.w	r1, r12, r1, lsl #1
   69fcc: f8b1 164a    	ldrh.w	r1, [r1, #0x64a]
   69fd0: 428a         	cmp	r2, r1
   69fd2: f040 80a2    	bne.w	0x6a11a <check_error+0x3a92> @ imm = #0x144
   69fd6: f20c 614a    	addw	r1, r12, #0x64a
   69fda: 2400         	movs	r4, #0x0
   69fdc: 462a         	mov	r2, r5
   69fde: b152         	cbz	r2, 0x69ff6 <check_error+0x396e> @ imm = #0x14
   69fe0: 188b         	adds	r3, r1, r2
   69fe2: f8b3 36c2    	ldrh.w	r3, [r3, #0x6c2]
   69fe6: b123         	cbz	r3, 0x69ff2 <check_error+0x396a> @ imm = #0x8
   69fe8: 4298         	cmp	r0, r3
   69fea: dc02         	bgt	0x69ff2 <check_error+0x396a> @ imm = #0x4
   69fec: 455b         	cmp	r3, r11
   69fee: bf98         	it	ls
   69ff0: 3401         	addls	r4, #0x1
   69ff2: 3202         	adds	r2, #0x2
   69ff4: e7f3         	b	0x69fde <check_error+0x3956> @ imm = #-0x1a
   69ff6: a80c         	add	r0, sp, #0x30
   69ff8: f44f 7148    	mov.w	r1, #0x320
   69ffc: f500 551f    	add.w	r5, r0, #0x27c0
   6a000: 4628         	mov	r0, r5
   6a002: f004 effe    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4ffc
   6a006: a80a         	add	r0, sp, #0x28
   6a008: f44f 7148    	mov.w	r1, #0x320
   6a00c: f500 5667    	add.w	r6, r0, #0x39c0
   6a010: 4630         	mov	r0, r6
   6a012: f004 eff6    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4fec
   6a016: b2a0         	uxth	r0, r4
   6a018: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   6a01c: 2864         	cmp	r0, #0x64
   6a01e: bf28         	it	hs
   6a020: 2464         	movhs	r4, #0x64
   6a022: b2a0         	uxth	r0, r4
   6a024: f642 2268    	movw	r2, #0x2a68
   6a028: f244 23f8    	movw	r3, #0x42f8
   6a02c: ed5f 0b48    	vldr	d16, [pc, #-288]        @ 0x69f10 <check_error+0x3888>
   6a030: ebac 01c0    	sub.w	r1, r12, r0, lsl #3
   6a034: 4411         	add	r1, r2
   6a036: f5c0 7290    	rsb.w	r2, r0, #0x120
   6a03a: eb0c 02c2    	add.w	r2, r12, r2, lsl #3
   6a03e: 441a         	add	r2, r3
   6a040: 4603         	mov	r3, r0
   6a042: b183         	cbz	r3, 0x6a066 <check_error+0x39de> @ imm = #0x20
   6a044: ecf1 1b02    	vldmia	r1!, {d17}
   6a048: ece5 1b02    	vstmia	r5!, {d17}
   6a04c: ecf2 1b02    	vldmia	r2!, {d17}
   6a050: eef4 1b48    	vcmp.f64	d17, d8
   6a054: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a058: bf48         	it	mi
   6a05a: eef0 1b60    	vmovmi.f64	d17, d16
   6a05e: ece6 1b02    	vstmia	r6!, {d17}
   6a062: 3b01         	subs	r3, #0x1
   6a064: e7ed         	b	0x6a042 <check_error+0x39ba> @ imm = #-0x26
   6a066: 9c3d         	ldr	r4, [sp, #0xf4]
   6a068: 2101         	movs	r1, #0x1
   6a06a: 9e52         	ldr	r6, [sp, #0x148]
   6a06c: 2501         	movs	r5, #0x1
   6a06e: f504 639c    	add.w	r3, r4, #0x4e0
   6a072: 9a3b         	ldr	r2, [sp, #0xec]
   6a074: edd3 0b00    	vldr	d16, [r3]
   6a078: f504 639f    	add.w	r3, r4, #0x4f8
   6a07c: f886 1853    	strb.w	r1, [r6, #0x853]
   6a080: 3205         	adds	r2, #0x5
   6a082: edd3 1b00    	vldr	d17, [r3]
   6a086: f894 34f1    	ldrb.w	r3, [r4, #0x4f1]
   6a08a: f886 1851    	strb.w	r1, [r6, #0x851]
   6a08e: ee00 3a10    	vmov	s0, r3
   6a092: ab0a         	add	r3, sp, #0x28
   6a094: ac0c         	add	r4, sp, #0x30
   6a096: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   6a09a: eeb8 0a40    	vcvt.f32.u32	s0, s0
   6a09e: f503 5367    	add.w	r3, r3, #0x39c0
   6a0a2: f504 541f    	add.w	r4, r4, #0x27c0
   6a0a6: b368         	cbz	r0, 0x6a104 <check_error+0x3a7c> @ imm = #0x5a
   6a0a8: 6816         	ldr	r6, [r2]
   6a0aa: ee01 6a10    	vmov	s2, r6
   6a0ae: 9e52         	ldr	r6, [sp, #0x148]
   6a0b0: ee21 1a00    	vmul.f32	s2, s2, s0
   6a0b4: eef7 2ac1    	vcvt.f64.f32	d18, s2
   6a0b8: ee71 3ba2    	vadd.f64	d19, d17, d18
   6a0bc: edd4 2b00    	vldr	d18, [r4]
   6a0c0: eef4 2b63    	vcmp.f64	d18, d19
   6a0c4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a0c8: d503         	bpl	0x6a0d2 <check_error+0x3a4a> @ imm = #0x6
   6a0ca: 2500         	movs	r5, #0x0
   6a0cc: f886 5851    	strb.w	r5, [r6, #0x851]
   6a0d0: e004         	b	0x6a0dc <check_error+0x3a54> @ imm = #0x8
   6a0d2: eef4 2b62    	vcmp.f64	d18, d18
   6a0d6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a0da: d6f6         	bvs	0x6a0ca <check_error+0x3a42> @ imm = #-0x14
   6a0dc: edd3 2b00    	vldr	d18, [r3]
   6a0e0: eef4 2b60    	vcmp.f64	d18, d16
   6a0e4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a0e8: d503         	bpl	0x6a0f2 <check_error+0x3a6a> @ imm = #0x6
   6a0ea: 2100         	movs	r1, #0x0
   6a0ec: f886 1853    	strb.w	r1, [r6, #0x853]
   6a0f0: e004         	b	0x6a0fc <check_error+0x3a74> @ imm = #0x8
   6a0f2: eef4 2b62    	vcmp.f64	d18, d18
   6a0f6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a0fa: d6f6         	bvs	0x6a0ea <check_error+0x3a62> @ imm = #-0x14
   6a0fc: 3801         	subs	r0, #0x1
   6a0fe: 3408         	adds	r4, #0x8
   6a100: 3308         	adds	r3, #0x8
   6a102: e7d0         	b	0x6a0a6 <check_error+0x3a1e> @ imm = #-0x60
   6a104: 2d01         	cmp	r5, #0x1
   6a106: 4d71         	ldr	r5, [pc, #0x1c4]        @ 0x6a2cc <check_error+0x3c44>
   6a108: bf03         	ittte	eq
   6a10a: 2901         	cmpeq	r1, #0x1
   6a10c: 2001         	moveq	r0, #0x1
   6a10e: f886 0864    	strbeq.w	r0, [r6, #0x864]
   6a112: f896 0864    	ldrbne.w	r0, [r6, #0x864]
   6a116: f886 07a9    	strb.w	r0, [r6, #0x7a9]
   6a11a: 9a3d         	ldr	r2, [sp, #0xf4]
   6a11c: f8b2 84d2    	ldrh.w	r8, [r2, #0x4d2]
   6a120: 45c6         	cmp	lr, r8
   6a122: d312         	blo	0x6a14a <check_error+0x3ac2> @ imm = #0x24
   6a124: f8b2 44d4    	ldrh.w	r4, [r2, #0x4d4]
   6a128: f240 3161    	movw	r1, #0x361
   6a12c: 1b09         	subs	r1, r1, r4
   6a12e: ebab 0004    	sub.w	r0, r11, r4
   6a132: 3001         	adds	r0, #0x1
   6a134: eb0c 0141    	add.w	r1, r12, r1, lsl #1
   6a138: f8b1 164a    	ldrh.w	r1, [r1, #0x64a]
   6a13c: 4288         	cmp	r0, r1
   6a13e: d104         	bne	0x6a14a <check_error+0x3ac2> @ imm = #0x8
   6a140: f8b2 04d0    	ldrh.w	r0, [r2, #0x4d0]
   6a144: 4583         	cmp	r11, r0
   6a146: f080 8216    	bhs.w	0x6a576 <check_error+0x3eee> @ imm = #0x42c
   6a14a: 4961         	ldr	r1, [pc, #0x184]        @ 0x6a2d0 <check_error+0x3c48>
   6a14c: 2000         	movs	r0, #0x0
   6a14e: 9a35         	ldr	r2, [sp, #0xd4]
   6a150: e9c2 010c    	strd	r0, r1, [r2, #48]
   6a154: f649 1080    	movw	r0, #0x9980
   6a158: 4460         	add	r0, r12
   6a15a: 2163         	movs	r1, #0x63
   6a15c: b131         	cbz	r1, 0x6a16c <check_error+0x3ae4> @ imm = #0xc
   6a15e: edd0 0b00    	vldr	d16, [r0]
   6a162: 3901         	subs	r1, #0x1
   6a164: ed40 0b02    	vstr	d16, [r0, #-8]
   6a168: 3008         	adds	r0, #0x8
   6a16a: e7f7         	b	0x6a15c <check_error+0x3ad4> @ imm = #-0x12
   6a16c: 4958         	ldr	r1, [pc, #0x160]        @ 0x6a2d0 <check_error+0x3c48>
   6a16e: 2000         	movs	r0, #0x0
   6a170: 9a35         	ldr	r2, [sp, #0xd4]
   6a172: e9c2 01d4    	strd	r0, r1, [r2, #848]
   6a176: f896 07a9    	ldrb.w	r0, [r6, #0x7a9]
   6a17a: f882 0358    	strb.w	r0, [r2, #0x358]
   6a17e: f649 40a0    	movw	r0, #0x9ca0
   6a182: f8bc 4648    	ldrh.w	r4, [r12, #0x648]
   6a186: 8831         	ldrh	r1, [r6]
   6a188: 4460         	add	r0, r12
   6a18a: 9163         	str	r1, [sp, #0x18c]
   6a18c: f44f 71b4    	mov.w	r1, #0x168
   6a190: b129         	cbz	r1, 0x6a19e <check_error+0x3b16> @ imm = #0xa
   6a192: edd0 0b3c    	vldr	d16, [r0, #240]
   6a196: 3901         	subs	r1, #0x1
   6a198: ece0 0b02    	vstmia	r0!, {d16}
   6a19c: e7f8         	b	0x6a190 <check_error+0x3b08> @ imm = #-0x10
   6a19e: f24a 70e0    	movw	r0, #0xa7e0
   6a1a2: 2100         	movs	r1, #0x0
   6a1a4: 4460         	add	r0, r12
   6a1a6: 29f0         	cmp	r1, #0xf0
   6a1a8: d007         	beq	0x6a1ba <check_error+0x3b32> @ imm = #0xe
   6a1aa: 1873         	adds	r3, r6, r1
   6a1ac: 1842         	adds	r2, r0, r1
   6a1ae: 3108         	adds	r1, #0x8
   6a1b0: edd3 0b34    	vldr	d16, [r3, #208]
   6a1b4: edc2 0b00    	vstr	d16, [r2]
   6a1b8: e7f5         	b	0x6a1a6 <check_error+0x3b1e> @ imm = #-0x16
   6a1ba: 983d         	ldr	r0, [sp, #0xf4]
   6a1bc: f20c 6b4a    	addw	r11, r12, #0x64a
   6a1c0: 9a63         	ldr	r2, [sp, #0x18c]
   6a1c2: 9450         	str	r4, [sp, #0x140]
   6a1c4: 2400         	movs	r4, #0x0
   6a1c6: f8b0 85f0    	ldrh.w	r8, [r0, #0x5f0]
   6a1ca: 9863         	ldr	r0, [sp, #0x18c]
   6a1cc: eba0 0608    	sub.w	r6, r0, r8
   6a1d0: 4628         	mov	r0, r5
   6a1d2: b158         	cbz	r0, 0x6a1ec <check_error+0x3b64> @ imm = #0x16
   6a1d4: eb0b 0100    	add.w	r1, r11, r0
   6a1d8: f8b1 16c2    	ldrh.w	r1, [r1, #0x6c2]
   6a1dc: b121         	cbz	r1, 0x6a1e8 <check_error+0x3b60> @ imm = #0x8
   6a1de: 428e         	cmp	r6, r1
   6a1e0: dc02         	bgt	0x6a1e8 <check_error+0x3b60> @ imm = #0x4
   6a1e2: 4291         	cmp	r1, r2
   6a1e4: bf98         	it	ls
   6a1e6: 3401         	addls	r4, #0x1
   6a1e8: 3002         	adds	r0, #0x2
   6a1ea: e7f2         	b	0x6a1d2 <check_error+0x3b4a> @ imm = #-0x1c
   6a1ec: a80c         	add	r0, sp, #0x30
   6a1ee: f44f 6143    	mov.w	r1, #0xc30
   6a1f2: f500 551f    	add.w	r5, r0, #0x27c0
   6a1f6: 4628         	mov	r0, r5
   6a1f8: f004 ef02    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4e04
   6a1fc: b2a0         	uxth	r0, r4
   6a1fe: 9b53         	ldr	r3, [sp, #0x14c]
   6a200: 2864         	cmp	r0, #0x64
   6a202: bf28         	it	hs
   6a204: 2464         	movhs	r4, #0x64
   6a206: ebc4 1004    	rsb	r0, r4, r4, lsl #4
   6a20a: f44f 71c3    	mov.w	r1, #0x186
   6a20e: f649 42a0    	movw	r2, #0x9ca0
   6a212: eba1 0140    	sub.w	r1, r1, r0, lsl #1
   6a216: 0040         	lsls	r0, r0, #0x1
   6a218: b289         	uxth	r1, r1
   6a21a: b280         	uxth	r0, r0
   6a21c: eb03 01c1    	add.w	r1, r3, r1, lsl #3
   6a220: 4411         	add	r1, r2
   6a222: 4602         	mov	r2, r0
   6a224: b12a         	cbz	r2, 0x6a232 <check_error+0x3baa> @ imm = #0xa
   6a226: ecf1 0b02    	vldmia	r1!, {d16}
   6a22a: 3a01         	subs	r2, #0x1
   6a22c: ece5 0b02    	vstmia	r5!, {d16}
   6a230: e7f8         	b	0x6a224 <check_error+0x3b9c> @ imm = #-0x10
   6a232: 993d         	ldr	r1, [sp, #0xf4]
   6a234: 9a3b         	ldr	r2, [sp, #0xec]
   6a236: f501 61b1    	add.w	r1, r1, #0x588
   6a23a: edd1 0b00    	vldr	d16, [r1]
   6a23e: ed91 ab02    	vldr	d10, [r1, #8]
   6a242: f852 1f05    	ldr	r1, [r2, #5]!
   6a246: 923b         	str	r2, [sp, #0xec]
   6a248: ee00 1a10    	vmov	s0, r1
   6a24c: b2a1         	uxth	r1, r4
   6a24e: eef7 1ac0    	vcvt.f64.f32	d17, s0
   6a252: ee60 0ba1    	vmul.f64	d16, d16, d17
   6a256: eef4 0b4a    	vcmp.f64	d16, d10
   6a25a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a25e: bf48         	it	mi
   6a260: eeb0 ab60    	vmovmi.f64	d10, d16
   6a264: 4541         	cmp	r1, r8
   6a266: d955         	bls	0x6a314 <check_error+0x3c8c> @ imm = #0xaa
   6a268: f240 3261    	movw	r2, #0x361
   6a26c: 1c71         	adds	r1, r6, #0x1
   6a26e: eba2 0208    	sub.w	r2, r2, r8
   6a272: eb03 0242    	add.w	r2, r3, r2, lsl #1
   6a276: f8b2 264a    	ldrh.w	r2, [r2, #0x64a]
   6a27a: 4291         	cmp	r1, r2
   6a27c: d14a         	bne	0x6a314 <check_error+0x3c8c> @ imm = #0x94
   6a27e: eef0 0b04    	vmov.f64	d16, #2.500000e+00
   6a282: 993d         	ldr	r1, [sp, #0xf4]
   6a284: f501 61bd    	add.w	r1, r1, #0x5e8
   6a288: ee6a 0b20    	vmul.f64	d16, d10, d16
   6a28c: edd1 1b00    	vldr	d17, [r1]
   6a290: eef4 1b60    	vcmp.f64	d17, d16
   6a294: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a298: bf48         	it	mi
   6a29a: eef0 0b61    	vmovmi.f64	d16, d17
   6a29e: aa0c         	add	r2, sp, #0x30
   6a2a0: 9b52         	ldr	r3, [sp, #0x148]
   6a2a2: f502 521f    	add.w	r2, r2, #0x27c0
   6a2a6: 2101         	movs	r1, #0x1
   6a2a8: b390         	cbz	r0, 0x6a310 <check_error+0x3c88> @ imm = #0x64
   6a2aa: edd2 1b00    	vldr	d17, [r2]
   6a2ae: eef4 1b60    	vcmp.f64	d17, d16
   6a2b2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a2b6: dd01         	ble	0x6a2bc <check_error+0x3c34> @ imm = #0x2
   6a2b8: 2100         	movs	r1, #0x0
   6a2ba: e004         	b	0x6a2c6 <check_error+0x3c3e> @ imm = #0x8
   6a2bc: eef4 1b61    	vcmp.f64	d17, d17
   6a2c0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a2c4: d6f8         	bvs	0x6a2b8 <check_error+0x3c30> @ imm = #-0x10
   6a2c6: 3801         	subs	r0, #0x1
   6a2c8: 3208         	adds	r2, #0x8
   6a2ca: e7ed         	b	0x6a2a8 <check_error+0x3c20> @ imm = #-0x26
   6a2cc: 3e f9 ff ff  	.word	0xfffff93e
   6a2d0: 00 00 f8 7f  	.word	0x7ff80000
   6a2d4: 00 bf 00 bf  	.word	0xbf00bf00
   6a2d8: 00 00 00 00  	.word	0x00000000
   6a2dc: 00 00 44 40  	.word	0x40440000
   6a2e0: 9a 99 99 99  	.word	0x9999999a
   6a2e4: 99 99 d9 3f  	.word	0x3fd99999
   6a2e8: 9a 99 99 99  	.word	0x9999999a
   6a2ec: 99 99 c9 3f  	.word	0x3fc99999
   6a2f0: 9a 99 99 99  	.word	0x9999999a
   6a2f4: 99 99 e9 3f  	.word	0x3fe99999
   6a2f8: 00 00 00 00  	.word	0x00000000
   6a2fc: 00 00 49 40  	.word	0x40490000
   6a300: 00 00 00 00  	.word	0x00000000
   6a304: 00 00 44 c0  	.word	0xc0440000
   6a308: 00 00 00 00  	.word	0x00000000
   6a30c: 00 00 59 40  	.word	0x40590000
   6a310: f883 1865    	strb.w	r1, [r3, #0x865]
   6a314: 9839         	ldr	r0, [sp, #0xe4]
   6a316: 21f0         	movs	r1, #0xf0
   6a318: ed9a 9b00    	vldr	d9, [r10]
   6a31c: ed90 8b02    	vldr	d8, [r0, #8]
   6a320: 4648         	mov	r0, r9
   6a322: f004 ee6e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4cdc
   6a326: 2000         	movs	r0, #0x0
   6a328: 9e52         	ldr	r6, [sp, #0x148]
   6a32a: f8dd 8140    	ldr.w	r8, [sp, #0x140]
   6a32e: 28f0         	cmp	r0, #0xf0
   6a330: d008         	beq	0x6a344 <check_error+0x3cbc> @ imm = #0x10
   6a332: 1832         	adds	r2, r6, r0
   6a334: eb09 0100    	add.w	r1, r9, r0
   6a338: 3008         	adds	r0, #0x8
   6a33a: edd2 0b34    	vldr	d16, [r2, #208]
   6a33e: edc1 0b00    	vstr	d16, [r1]
   6a342: e7f4         	b	0x6a32e <check_error+0x3ca6> @ imm = #-0x18
   6a344: 983d         	ldr	r0, [sp, #0xf4]
   6a346: 9963         	ldr	r1, [sp, #0x18c]
   6a348: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6a34c: f8b0 0418    	ldrh.w	r0, [r0, #0x418]
   6a350: 4281         	cmp	r1, r0
   6a352: d941         	bls	0x6a3d8 <check_error+0x3d50> @ imm = #0x82
   6a354: eef0 0b08    	vmov.f64	d16, #3.000000e+00
   6a358: 993d         	ldr	r1, [sp, #0xf4]
   6a35a: 2201         	movs	r2, #0x1
   6a35c: 2300         	movs	r3, #0x0
   6a35e: f501 61bf    	add.w	r1, r1, #0x5f8
   6a362: ee6a 0b20    	vmul.f64	d16, d10, d16
   6a366: edd1 1b00    	vldr	d17, [r1]
   6a36a: 2101         	movs	r1, #0x1
   6a36c: 2bf0         	cmp	r3, #0xf0
   6a36e: d01d         	beq	0x6a3ac <check_error+0x3d24> @ imm = #0x3a
   6a370: eb09 0403    	add.w	r4, r9, r3
   6a374: edd4 2b00    	vldr	d18, [r4]
   6a378: eef4 2b61    	vcmp.f64	d18, d17
   6a37c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a380: dd01         	ble	0x6a386 <check_error+0x3cfe> @ imm = #0x2
   6a382: 2200         	movs	r2, #0x0
   6a384: e004         	b	0x6a390 <check_error+0x3d08> @ imm = #0x8
   6a386: eef4 2b62    	vcmp.f64	d18, d18
   6a38a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a38e: d6f8         	bvs	0x6a382 <check_error+0x3cfa> @ imm = #-0x10
   6a390: eef4 2b60    	vcmp.f64	d18, d16
   6a394: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a398: dd01         	ble	0x6a39e <check_error+0x3d16> @ imm = #0x2
   6a39a: 2100         	movs	r1, #0x0
   6a39c: e004         	b	0x6a3a8 <check_error+0x3d20> @ imm = #0x8
   6a39e: eef4 2b62    	vcmp.f64	d18, d18
   6a3a2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a3a6: d6f8         	bvs	0x6a39a <check_error+0x3d12> @ imm = #-0x10
   6a3a8: 3308         	adds	r3, #0x8
   6a3aa: e7df         	b	0x6a36c <check_error+0x3ce4> @ imm = #-0x42
   6a3ac: ed5f 0b36    	vldr	d16, [pc, #-216]        @ 0x6a2d8 <check_error+0x3c50>
   6a3b0: eeb4 8b60    	vcmp.f64	d8, d16
   6a3b4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a3b8: d504         	bpl	0x6a3c4 <check_error+0x3d3c> @ imm = #0x8
   6a3ba: 2a01         	cmp	r2, #0x1
   6a3bc: bf04         	itt	eq
   6a3be: 2201         	moveq	r2, #0x1
   6a3c0: f886 2866    	strbeq.w	r2, [r6, #0x866]
   6a3c4: eeb4 8b60    	vcmp.f64	d8, d16
   6a3c8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a3cc: d504         	bpl	0x6a3d8 <check_error+0x3d50> @ imm = #0x8
   6a3ce: 2901         	cmp	r1, #0x1
   6a3d0: bf04         	itt	eq
   6a3d2: 2101         	moveq	r1, #0x1
   6a3d4: f886 1867    	strbeq.w	r1, [r6, #0x867]
   6a3d8: eef3 0b04    	vmov.f64	d16, #2.000000e+01
   6a3dc: eeb4 8b60    	vcmp.f64	d8, d16
   6a3e0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a3e4: d406         	bmi	0x6a3f4 <check_error+0x3d6c> @ imm = #0xc
   6a3e6: ed5f 0b42    	vldr	d16, [pc, #-264]        @ 0x6a2e0 <check_error+0x3c58>
   6a3ea: eeb4 9b60    	vcmp.f64	d9, d16
   6a3ee: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a3f2: d502         	bpl	0x6a3fa <check_error+0x3d72> @ imm = #0x4
   6a3f4: 2101         	movs	r1, #0x1
   6a3f6: f886 1868    	strb.w	r1, [r6, #0x868]
   6a3fa: 993b         	ldr	r1, [sp, #0xec]
   6a3fc: ed5f 1b46    	vldr	d17, [pc, #-280]        @ 0x6a2e8 <check_error+0x3c60>
   6a400: 6809         	ldr	r1, [r1]
   6a402: ee00 1a10    	vmov	s0, r1
   6a406: eef7 0ac0    	vcvt.f64.f32	d16, s0
   6a40a: ee60 1ba1    	vmul.f64	d17, d16, d17
   6a40e: ed5f 0b48    	vldr	d16, [pc, #-288]        @ 0x6a2f0 <check_error+0x3c68>
   6a412: eef4 1b60    	vcmp.f64	d17, d16
   6a416: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a41a: bf48         	it	mi
   6a41c: eef0 0b61    	vmovmi.f64	d16, d17
   6a420: 9963         	ldr	r1, [sp, #0x18c]
   6a422: f5b1 6ffc    	cmp.w	r1, #0x7e0
   6a426: d92e         	bls	0x6a486 <check_error+0x3dfe> @ imm = #0x5c
   6a428: f896 1798    	ldrb.w	r1, [r6, #0x798]
   6a42c: 2904         	cmp	r1, #0x4
   6a42e: d32a         	blo	0x6a486 <check_error+0x3dfe> @ imm = #0x54
   6a430: 2100         	movs	r1, #0x0
   6a432: 2200         	movs	r2, #0x0
   6a434: 2a03         	cmp	r2, #0x3
   6a436: d004         	beq	0x6a442 <check_error+0x3dba> @ imm = #0x8
   6a438: 18b3         	adds	r3, r6, r2
   6a43a: 3201         	adds	r2, #0x1
   6a43c: f883 1865    	strb.w	r1, [r3, #0x865]
   6a440: e7f8         	b	0x6a434 <check_error+0x3dac> @ imm = #-0x10
   6a442: 2101         	movs	r1, #0x1
   6a444: 2200         	movs	r2, #0x0
   6a446: 2af0         	cmp	r2, #0xf0
   6a448: d011         	beq	0x6a46e <check_error+0x3de6> @ imm = #0x22
   6a44a: eb09 0302    	add.w	r3, r9, r2
   6a44e: edd3 1b00    	vldr	d17, [r3]
   6a452: eef4 1b60    	vcmp.f64	d17, d16
   6a456: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a45a: dd01         	ble	0x6a460 <check_error+0x3dd8> @ imm = #0x2
   6a45c: 2100         	movs	r1, #0x0
   6a45e: e004         	b	0x6a46a <check_error+0x3de2> @ imm = #0x8
   6a460: eef4 1b61    	vcmp.f64	d17, d17
   6a464: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a468: d6f8         	bvs	0x6a45c <check_error+0x3dd4> @ imm = #-0x10
   6a46a: 3208         	adds	r2, #0x8
   6a46c: e7eb         	b	0x6a446 <check_error+0x3dbe> @ imm = #-0x2a
   6a46e: eef3 0b0e    	vmov.f64	d16, #3.000000e+01
   6a472: eeb4 8b60    	vcmp.f64	d8, d16
   6a476: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a47a: d401         	bmi	0x6a480 <check_error+0x3df8> @ imm = #0x2
   6a47c: 2901         	cmp	r1, #0x1
   6a47e: d102         	bne	0x6a486 <check_error+0x3dfe> @ imm = #0x4
   6a480: 2101         	movs	r1, #0x1
   6a482: f886 1869    	strb.w	r1, [r6, #0x869]
   6a486: f896 1865    	ldrb.w	r1, [r6, #0x865]
   6a48a: 2901         	cmp	r1, #0x1
   6a48c: bf1c         	itt	ne
   6a48e: f896 1866    	ldrbne.w	r1, [r6, #0x866]
   6a492: 2901         	cmpne	r1, #0x1
   6a494: d162         	bne	0x6a55c <check_error+0x3ed4> @ imm = #0xc4
   6a496: 2101         	movs	r1, #0x1
   6a498: f886 186a    	strb.w	r1, [r6, #0x86a]
   6a49c: 9963         	ldr	r1, [sp, #0x18c]
   6a49e: 4281         	cmp	r1, r0
   6a4a0: f240 8230    	bls.w	0x6a904 <check_error+0x427c> @ imm = #0x460
   6a4a4: f1b8 0f02    	cmp.w	r8, #0x2
   6a4a8: f0c0 822c    	blo.w	0x6a904 <check_error+0x427c> @ imm = #0x458
   6a4ac: 983c         	ldr	r0, [sp, #0xf0]
   6a4ae: f896 986a    	ldrb.w	r9, [r6, #0x86a]
   6a4b2: f890 0247    	ldrb.w	r0, [r0, #0x247]
   6a4b6: 2801         	cmp	r0, #0x1
   6a4b8: bf08         	it	eq
   6a4ba: f1b9 0f01    	cmpeq.w	r9, #0x1
   6a4be: f000 8221    	beq.w	0x6a904 <check_error+0x427c> @ imm = #0x442
   6a4c2: 9939         	ldr	r1, [sp, #0xe4]
   6a4c4: 2500         	movs	r5, #0x0
   6a4c6: 9863         	ldr	r0, [sp, #0x18c]
   6a4c8: 9b63         	ldr	r3, [sp, #0x18c]
   6a4ca: ecb1 8b04    	vldmia	r1!, {d8, d9}
   6a4ce: 3817         	subs	r0, #0x17
   6a4d0: 49d6         	ldr	r1, [pc, #0x358]        @ 0x6a82c <check_error+0x41a4>
   6a4d2: b159         	cbz	r1, 0x6a4ec <check_error+0x3e64> @ imm = #0x16
   6a4d4: eb0b 0201    	add.w	r2, r11, r1
   6a4d8: f8b2 26c2    	ldrh.w	r2, [r2, #0x6c2]
   6a4dc: b122         	cbz	r2, 0x6a4e8 <check_error+0x3e60> @ imm = #0x8
   6a4de: 4290         	cmp	r0, r2
   6a4e0: dc02         	bgt	0x6a4e8 <check_error+0x3e60> @ imm = #0x4
   6a4e2: 429a         	cmp	r2, r3
   6a4e4: bf98         	it	ls
   6a4e6: 3501         	addls	r5, #0x1
   6a4e8: 3102         	adds	r1, #0x2
   6a4ea: e7f2         	b	0x6a4d2 <check_error+0x3e4a> @ imm = #-0x1c
   6a4ec: a802         	add	r0, sp, #0x8
   6a4ee: 21c0         	movs	r1, #0xc0
   6a4f0: f500 58c9    	add.w	r8, r0, #0x1920
   6a4f4: 4640         	mov	r0, r8
   6a4f6: f004 ed84    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4b08
   6a4fa: b2a8         	uxth	r0, r5
   6a4fc: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6a500: 2818         	cmp	r0, #0x18
   6a502: bf28         	it	hs
   6a504: 2518         	movhs	r5, #0x18
   6a506: b2ad         	uxth	r5, r5
   6a508: f244 21f8    	movw	r1, #0x42f8
   6a50c: f5c5 7090    	rsb.w	r0, r5, #0x120
   6a510: 4642         	mov	r2, r8
   6a512: eb0e 00c0    	add.w	r0, lr, r0, lsl #3
   6a516: 4408         	add	r0, r1
   6a518: 4629         	mov	r1, r5
   6a51a: b129         	cbz	r1, 0x6a528 <check_error+0x3ea0> @ imm = #0xa
   6a51c: ecf0 0b02    	vldmia	r0!, {d16}
   6a520: 3901         	subs	r1, #0x1
   6a522: ece2 0b02    	vstmia	r2!, {d16}
   6a526: e7f8         	b	0x6a51a <check_error+0x3e92> @ imm = #-0x10
   6a528: 2d15         	cmp	r5, #0x15
   6a52a: d958         	bls	0x6a5de <check_error+0x3f56> @ imm = #0xb0
   6a52c: a80a         	add	r0, sp, #0x28
   6a52e: 21c0         	movs	r1, #0xc0
   6a530: f500 5667    	add.w	r6, r0, #0x39c0
   6a534: 4630         	mov	r0, r6
   6a536: f004 ed64    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4ac8
   6a53a: f108 0108    	add.w	r1, r8, #0x8
   6a53e: 1e68         	subs	r0, r5, #0x1
   6a540: 4602         	mov	r2, r0
   6a542: 460b         	mov	r3, r1
   6a544: 2a00         	cmp	r2, #0x0
   6a546: d05a         	beq	0x6a5fe <check_error+0x3f76> @ imm = #0xb4
   6a548: ed53 0b02    	vldr	d16, [r3, #-8]
   6a54c: 3a01         	subs	r2, #0x1
   6a54e: ecf3 1b02    	vldmia	r3!, {d17}
   6a552: ee71 0be0    	vsub.f64	d16, d17, d16
   6a556: ece6 0b02    	vstmia	r6!, {d16}
   6a55a: e7f3         	b	0x6a544 <check_error+0x3ebc> @ imm = #-0x1a
   6a55c: f896 1867    	ldrb.w	r1, [r6, #0x867]
   6a560: 2901         	cmp	r1, #0x1
   6a562: bf1c         	itt	ne
   6a564: f896 1868    	ldrbne.w	r1, [r6, #0x868]
   6a568: 2901         	cmpne	r1, #0x1
   6a56a: d094         	beq	0x6a496 <check_error+0x3e0e> @ imm = #-0xd8
   6a56c: f896 1869    	ldrb.w	r1, [r6, #0x869]
   6a570: 2901         	cmp	r1, #0x1
   6a572: d090         	beq	0x6a496 <check_error+0x3e0e> @ imm = #-0xe0
   6a574: e792         	b	0x6a49c <check_error+0x3e14> @ imm = #-0xdc
   6a576: a80c         	add	r0, sp, #0x30
   6a578: f44f 7180    	mov.w	r1, #0x100
   6a57c: f500 551f    	add.w	r5, r0, #0x27c0
   6a580: 4628         	mov	r0, r5
   6a582: f004 ed3e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4a7c
   6a586: a80a         	add	r0, sp, #0x28
   6a588: f44f 7180    	mov.w	r1, #0x100
   6a58c: f500 5667    	add.w	r6, r0, #0x39c0
   6a590: 4630         	mov	r0, r6
   6a592: f004 ed36    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x4a6c
   6a596: 1c60         	adds	r0, r4, #0x1
   6a598: 9a53         	ldr	r2, [sp, #0x14c]
   6a59a: f642 2168    	movw	r1, #0x2a68
   6a59e: fa1f fa80    	uxth.w	r10, r0
   6a5a2: eba2 00ca    	sub.w	r0, r2, r10, lsl #3
   6a5a6: 4408         	add	r0, r1
   6a5a8: f5ca 7190    	rsb.w	r1, r10, #0x120
   6a5ac: eb02 01c1    	add.w	r1, r2, r1, lsl #3
   6a5b0: f244 22f8    	movw	r2, #0x42f8
   6a5b4: 4411         	add	r1, r2
   6a5b6: 4652         	mov	r2, r10
   6a5b8: 2a00         	cmp	r2, #0x0
   6a5ba: d03f         	beq	0x6a63c <check_error+0x3fb4> @ imm = #0x7e
   6a5bc: ecf0 0b02    	vldmia	r0!, {d16}
   6a5c0: ece5 0b02    	vstmia	r5!, {d16}
   6a5c4: ecf1 0b02    	vldmia	r1!, {d16}
   6a5c8: eef4 0b48    	vcmp.f64	d16, d8
   6a5cc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a5d0: bf48         	it	mi
   6a5d2: eef0 0b4a    	vmovmi.f64	d16, d10
   6a5d6: ece6 0b02    	vstmia	r6!, {d16}
   6a5da: 3a01         	subs	r2, #0x1
   6a5dc: e7ec         	b	0x6a5b8 <check_error+0x3f30> @ imm = #-0x28
   6a5de: f896 0868    	ldrb.w	r0, [r6, #0x868]
   6a5e2: 2801         	cmp	r0, #0x1
   6a5e4: f040 8189    	bne.w	0x6a8fa <check_error+0x4272> @ imm = #0x312
   6a5e8: ee78 0b49    	vsub.f64	d16, d8, d9
   6a5ec: ed5f 1bbe    	vldr	d17, [pc, #-760]        @ 0x6a2f8 <check_error+0x3c70>
   6a5f0: eef4 0b61    	vcmp.f64	d16, d17
   6a5f4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a5f8: f300 8182    	bgt.w	0x6a900 <check_error+0x4278> @ imm = #0x304
   6a5fc: e17d         	b	0x6a8fa <check_error+0x4272> @ imm = #0x2fa
   6a5fe: aa0a         	add	r2, sp, #0x28
   6a600: e9dd 6e52    	ldrd	r6, lr, [sp, #328]
   6a604: f502 5267    	add.w	r2, r2, #0x39c0
   6a608: ed5f 0bc3    	vldr	d16, [pc, #-780]        @ 0x6a300 <check_error+0x3c78>
   6a60c: ed5f 1bc2    	vldr	d17, [pc, #-776]        @ 0x6a308 <check_error+0x3c80>
   6a610: 4603         	mov	r3, r0
   6a612: 2b00         	cmp	r3, #0x0
   6a614: d071         	beq	0x6a6fa <check_error+0x4072> @ imm = #0xe2
   6a616: edd2 2b00    	vldr	d18, [r2]
   6a61a: eef4 2b60    	vcmp.f64	d18, d16
   6a61e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a622: d807         	bhi	0x6a634 <check_error+0x3fac> @ imm = #0xe
   6a624: edd1 3b00    	vldr	d19, [r1]
   6a628: eef4 3b61    	vcmp.f64	d19, d17
   6a62c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a630: f100 8146    	bmi.w	0x6a8c0 <check_error+0x4238> @ imm = #0x28c
   6a634: 3b01         	subs	r3, #0x1
   6a636: 3208         	adds	r2, #0x8
   6a638: 3108         	adds	r1, #0x8
   6a63a: e7ea         	b	0x6a612 <check_error+0x3f8a> @ imm = #-0x2c
   6a63c: a80c         	add	r0, sp, #0x30
   6a63e: 4651         	mov	r1, r10
   6a640: f500 551f    	add.w	r5, r0, #0x27c0
   6a644: 4628         	mov	r0, r5
   6a646: f001 ffe3    	bl	0x6c610 <math_std>      @ imm = #0x1fc6
   6a64a: 4628         	mov	r0, r5
   6a64c: 4651         	mov	r1, r10
   6a64e: eeb0 8b40    	vmov.f64	d8, d0
   6a652: f002 f825    	bl	0x6c6a0 <math_mean>     @ imm = #0x204a
   6a656: eec8 0b00    	vdiv.f64	d16, d8, d0
   6a65a: 9e52         	ldr	r6, [sp, #0x148]
   6a65c: 4d73         	ldr	r5, [pc, #0x1cc]        @ 0x6a82c <check_error+0x41a4>
   6a65e: f606 0058    	addw	r0, r6, #0x858
   6a662: ed5f 1bd7    	vldr	d17, [pc, #-860]        @ 0x6a308 <check_error+0x3c80>
   6a666: ee20 bba1    	vmul.f64	d11, d16, d17
   6a66a: ed80 bb00    	vstr	d11, [r0]
   6a66e: 9863         	ldr	r0, [sp, #0x18c]
   6a670: 2801         	cmp	r0, #0x1
   6a672: bf1c         	itt	ne
   6a674: 9835         	ldrne	r0, [sp, #0xd4]
   6a676: ed90 ab0c    	vldrne	d10, [r0, #48]
   6a67a: 983b         	ldr	r0, [sp, #0xec]
   6a67c: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   6a680: f8d0 0005    	ldr.w	r0, [r0, #0x5]
   6a684: ee00 0a10    	vmov	s0, r0
   6a688: eef7 0ac0    	vcvt.f64.f32	d16, s0
   6a68c: eeb4 9b60    	vcmp.f64	d9, d16
   6a690: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a694: dd1e         	ble	0x6a6d4 <check_error+0x404c> @ imm = #0x3c
   6a696: eef0 0bc9    	vabs.f64	d16, d9
   6a69a: eef4 0b4e    	vcmp.f64	d16, d14
   6a69e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a6a2: d017         	beq	0x6a6d4 <check_error+0x404c> @ imm = #0x2e
   6a6a4: d616         	bvs	0x6a6d4 <check_error+0x404c> @ imm = #0x2c
   6a6a6: e7ff         	b	0x6a6a8 <check_error+0x4020> @ imm = #-0x2
   6a6a8: 983d         	ldr	r0, [sp, #0xf4]
   6a6aa: f500 609d    	add.w	r0, r0, #0x4e8
   6a6ae: edd0 0b00    	vldr	d16, [r0]
   6a6b2: eeb4 bb60    	vcmp.f64	d11, d16
   6a6b6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a6ba: d50b         	bpl	0x6a6d4 <check_error+0x404c> @ imm = #0x16
   6a6bc: eeb4 ab4a    	vcmp.f64	d10, d10
   6a6c0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a6c4: f180 861c    	bvs.w	0x6b300 <check_error+0x4c78> @ imm = #0xc38
   6a6c8: eeb4 ab49    	vcmp.f64	d10, d9
   6a6cc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a6d0: f340 8616    	ble.w	0x6b300 <check_error+0x4c78> @ imm = #0xc2c
   6a6d4: 9835         	ldr	r0, [sp, #0xd4]
   6a6d6: ed80 ab0c    	vstr	d10, [r0, #48]
   6a6da: ebab 0008    	sub.w	r0, r11, r8
   6a6de: f60c 5208    	addw	r2, r12, #0xd08
   6a6e2: 2100         	movs	r1, #0x0
   6a6e4: f511 7f58    	cmn.w	r1, #0x360
   6a6e8: f000 80d0    	beq.w	0x6a88c <check_error+0x4204> @ imm = #0x1a0
   6a6ec: f832 3011    	ldrh.w	r3, [r2, r1, lsl #1]
   6a6f0: b10b         	cbz	r3, 0x6a6f6 <check_error+0x406e> @ imm = #0x2
   6a6f2: 4298         	cmp	r0, r3
   6a6f4: da41         	bge	0x6a77a <check_error+0x40f2> @ imm = #0x82
   6a6f6: 3901         	subs	r1, #0x1
   6a6f8: e7f4         	b	0x6a6e4 <check_error+0x405c> @ imm = #-0x18
   6a6fa: aa0a         	add	r2, sp, #0x28
   6a6fc: 2100         	movs	r1, #0x0
   6a6fe: f502 5667    	add.w	r6, r2, #0x39c0
   6a702: f64f 7cff    	movw	r12, #0xffff
   6a706: f64f 73ff    	movw	r3, #0xffff
   6a70a: 4288         	cmp	r0, r1
   6a70c: d016         	beq	0x6a73c <check_error+0x40b4> @ imm = #0x2c
   6a70e: ecf6 2b02    	vldmia	r6!, {d18}
   6a712: 2200         	movs	r2, #0x0
   6a714: 2400         	movs	r4, #0x0
   6a716: eef4 2b4e    	vcmp.f64	d18, d14
   6a71a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a71e: bf48         	it	mi
   6a720: 2201         	movmi	r2, #0x1
   6a722: eef4 2b62    	vcmp.f64	d18, d18
   6a726: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a72a: bf78         	it	vc
   6a72c: 2401         	movvc	r4, #0x1
   6a72e: 4022         	ands	r2, r4
   6a730: bf1c         	itt	ne
   6a732: 460b         	movne	r3, r1
   6a734: eeb0 eb62    	vmovne.f64	d14, d18
   6a738: 3101         	adds	r1, #0x1
   6a73a: e7e6         	b	0x6a70a <check_error+0x4082> @ imm = #-0x34
   6a73c: b298         	uxth	r0, r3
   6a73e: eddf 2b3c    	vldr	d18, [pc, #240]         @ 0x6a830 <check_error+0x41a8>
   6a742: 4560         	cmp	r0, r12
   6a744: f000 80b9    	beq.w	0x6a8ba <check_error+0x4232> @ imm = #0x172
   6a748: b218         	sxth	r0, r3
   6a74a: ef62 31b2    	vorr	d19, d18, d18
   6a74e: 9e52         	ldr	r6, [sp, #0x148]
   6a750: 3001         	adds	r0, #0x1
   6a752: 42a8         	cmp	r0, r5
   6a754: f280 80b4    	bge.w	0x6a8c0 <check_error+0x4238> @ imm = #0x168
   6a758: eb08 00c0    	add.w	r0, r8, r0, lsl #3
   6a75c: eef0 2b4e    	vmov.f64	d18, d14
   6a760: edd0 3b00    	vldr	d19, [r0]
   6a764: e0ac         	b	0x6a8c0 <check_error+0x4238> @ imm = #0x158
   6a766: 9852         	ldr	r0, [sp, #0x148]
   6a768: f890 0800    	ldrb.w	r0, [r0, #0x800]
   6a76c: 2801         	cmp	r0, #0x1
   6a76e: f43f ab1d    	beq.w	0x69dac <check_error+0x3724> @ imm = #-0x9c6
   6a772: 9829         	ldr	r0, [sp, #0xa4]
   6a774: 7800         	ldrb	r0, [r0]
   6a776: f7ff bb1d    	b.w	0x69db4 <check_error+0x372c> @ imm = #-0x9c6
   6a77a: f1c1 0001    	rsb.w	r0, r1, #0x1
   6a77e: 2164         	movs	r1, #0x64
   6a780: fad1 f050    	uqsub16	r0, r1, r0
   6a784: f649 1178    	movw	r1, #0x9978
   6a788: b280         	uxth	r0, r0
   6a78a: 2501         	movs	r5, #0x1
   6a78c: 4654         	mov	r4, r10
   6a78e: eb0c 00c0    	add.w	r0, r12, r0, lsl #3
   6a792: 4408         	add	r0, r1
   6a794: ed90 cb00    	vldr	d12, [r0]
   6a798: 983d         	ldr	r0, [sp, #0xf4]
   6a79a: f890 04f0    	ldrb.w	r0, [r0, #0x4f0]
   6a79e: ee00 0a10    	vmov	s0, r0
   6a7a2: a80c         	add	r0, sp, #0x30
   6a7a4: f500 561f    	add.w	r6, r0, #0x27c0
   6a7a8: eef8 0b40    	vcvt.f64.u32	d16, s0
   6a7ac: ee2c 8b20    	vmul.f64	d8, d12, d16
   6a7b0: b1d4         	cbz	r4, 0x6a7e8 <check_error+0x4160> @ imm = #0x34
   6a7b2: ed96 9b00    	vldr	d9, [r6]
   6a7b6: 200a         	movs	r0, #0xa
   6a7b8: eeb0 1b48    	vmov.f64	d1, d8
   6a7bc: 2103         	movs	r1, #0x3
   6a7be: ef29 0119    	vorr	d0, d9, d9
   6a7c2: f002 f831    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x2062
   6a7c6: b148         	cbz	r0, 0x6a7dc <check_error+0x4154> @ imm = #0x12
   6a7c8: eeb4 9b49    	vcmp.f64	d9, d9
   6a7cc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a7d0: bf7c         	itt	vc
   6a7d2: eeb4 cb4c    	vcmpvc.f64	d12, d12
   6a7d6: eef1 fa10    	vmrsvc	APSR_nzcv, fpscr
   6a7da: d700         	bvc	0x6a7de <check_error+0x4156> @ imm = #0x0
   6a7dc: 2500         	movs	r5, #0x0
   6a7de: 3c01         	subs	r4, #0x1
   6a7e0: 3608         	adds	r6, #0x8
   6a7e2: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   6a7e6: e7e3         	b	0x6a7b0 <check_error+0x4128> @ imm = #-0x3a
   6a7e8: 983d         	ldr	r0, [sp, #0xf4]
   6a7ea: 9e52         	ldr	r6, [sp, #0x148]
   6a7ec: f500 609b    	add.w	r0, r0, #0x4d8
   6a7f0: edd0 0b00    	vldr	d16, [r0]
   6a7f4: 2001         	movs	r0, #0x1
   6a7f6: f886 5850    	strb.w	r5, [r6, #0x850]
   6a7fa: a90a         	add	r1, sp, #0x28
   6a7fc: 9a63         	ldr	r2, [sp, #0x18c]
   6a7fe: f501 5167    	add.w	r1, r1, #0x39c0
   6a802: f1ba 0f00    	cmp.w	r10, #0x0
   6a806: d01b         	beq	0x6a840 <check_error+0x41b8> @ imm = #0x36
   6a808: edd1 1b00    	vldr	d17, [r1]
   6a80c: eef4 1b60    	vcmp.f64	d17, d16
   6a810: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a814: d501         	bpl	0x6a81a <check_error+0x4192> @ imm = #0x2
   6a816: 2000         	movs	r0, #0x0
   6a818: e004         	b	0x6a824 <check_error+0x419c> @ imm = #0x8
   6a81a: eef4 1b61    	vcmp.f64	d17, d17
   6a81e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a822: d6f8         	bvs	0x6a816 <check_error+0x418e> @ imm = #-0x10
   6a824: f1aa 0a01    	sub.w	r10, r10, #0x1
   6a828: 3108         	adds	r1, #0x8
   6a82a: e7ea         	b	0x6a802 <check_error+0x417a> @ imm = #-0x2c
   6a82c: 3e f9 ff ff  	.word	0xfffff93e
   6a830: 00 00 00 00  	.word	0x00000000
   6a834: 00 00 f8 7f  	.word	0x7ff80000
   6a838: 00 00 00 00  	.word	0x00000000
   6a83c: 00 00 54 40  	.word	0x40540000
   6a840: 2d01         	cmp	r5, #0x1
   6a842: f886 0852    	strb.w	r0, [r6, #0x852]
   6a846: bf08         	it	eq
   6a848: 2801         	cmpeq	r0, #0x1
   6a84a: d10c         	bne	0x6a866 <check_error+0x41de> @ imm = #0x18
   6a84c: 983d         	ldr	r0, [sp, #0xf4]
   6a84e: f500 609d    	add.w	r0, r0, #0x4e8
   6a852: edd0 0b00    	vldr	d16, [r0]
   6a856: eeb4 bb60    	vcmp.f64	d11, d16
   6a85a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a85e: bf9c         	itt	ls
   6a860: 2001         	movls	r0, #0x1
   6a862: f886 0863    	strbls.w	r0, [r6, #0x863]
   6a866: 4dc5         	ldr	r5, [pc, #0x314]        @ 0x6ab7c <check_error+0x44f4>
   6a868: 2a02         	cmp	r2, #0x2
   6a86a: d304         	blo	0x6a876 <check_error+0x41ee> @ imm = #0x8
   6a86c: 9835         	ldr	r0, [sp, #0xd4]
   6a86e: f890 0358    	ldrb.w	r0, [r0, #0x358]
   6a872: 2801         	cmp	r0, #0x1
   6a874: d007         	beq	0x6a886 <check_error+0x41fe> @ imm = #0xe
   6a876: f896 0863    	ldrb.w	r0, [r6, #0x863]
   6a87a: 2801         	cmp	r0, #0x1
   6a87c: bf1c         	itt	ne
   6a87e: f896 0864    	ldrbne.w	r0, [r6, #0x864]
   6a882: 2801         	cmpne	r0, #0x1
   6a884: d102         	bne	0x6a88c <check_error+0x4204> @ imm = #0x4
   6a886: 2001         	movs	r0, #0x1
   6a888: f886 07a9    	strb.w	r0, [r6, #0x7a9]
   6a88c: f649 1080    	movw	r0, #0x9980
   6a890: 2163         	movs	r1, #0x63
   6a892: 4460         	add	r0, r12
   6a894: f8dd a0a8    	ldr.w	r10, [sp, #0xa8]
   6a898: b131         	cbz	r1, 0x6a8a8 <check_error+0x4220> @ imm = #0xc
   6a89a: edd0 0b00    	vldr	d16, [r0]
   6a89e: 3901         	subs	r1, #0x1
   6a8a0: ed40 0b02    	vstr	d16, [r0, #-8]
   6a8a4: 3008         	adds	r0, #0x8
   6a8a6: e7f7         	b	0x6a898 <check_error+0x4210> @ imm = #-0x12
   6a8a8: 9935         	ldr	r1, [sp, #0xd4]
   6a8aa: ed81 abd4    	vstr	d10, [r1, #848]
   6a8ae: f896 07a9    	ldrb.w	r0, [r6, #0x7a9]
   6a8b2: f881 0358    	strb.w	r0, [r1, #0x358]
   6a8b6: f7ff bc62    	b.w	0x6a17e <check_error+0x3af6> @ imm = #-0x73c
   6a8ba: ef62 31b2    	vorr	d19, d18, d18
   6a8be: 9e52         	ldr	r6, [sp, #0x148]
   6a8c0: eef4 2b60    	vcmp.f64	d18, d16
   6a8c4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a8c8: d807         	bhi	0x6a8da <check_error+0x4252> @ imm = #0xe
   6a8ca: eef4 3b61    	vcmp.f64	d19, d17
   6a8ce: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a8d2: d502         	bpl	0x6a8da <check_error+0x4252> @ imm = #0x4
   6a8d4: f1b9 0f01    	cmp.w	r9, #0x1
   6a8d8: d012         	beq	0x6a900 <check_error+0x4278> @ imm = #0x24
   6a8da: f896 0868    	ldrb.w	r0, [r6, #0x868]
   6a8de: 2801         	cmp	r0, #0x1
   6a8e0: d10b         	bne	0x6a8fa <check_error+0x4272> @ imm = #0x16
   6a8e2: eef4 2b60    	vcmp.f64	d18, d16
   6a8e6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a8ea: d806         	bhi	0x6a8fa <check_error+0x4272> @ imm = #0xc
   6a8ec: ed5f 0b2e    	vldr	d16, [pc, #-184]        @ 0x6a838 <check_error+0x41b0>
   6a8f0: eef4 3b60    	vcmp.f64	d19, d16
   6a8f4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a8f8: d402         	bmi	0x6a900 <check_error+0x4278> @ imm = #0x4
   6a8fa: 2000         	movs	r0, #0x0
   6a8fc: f886 086a    	strb.w	r0, [r6, #0x86a]
   6a900: f8dd 8140    	ldr.w	r8, [sp, #0x140]
   6a904: f64b 4079    	movw	r0, #0xbc79
   6a908: f240 213f    	movw	r1, #0x23f
   6a90c: 4470         	add	r0, lr
   6a90e: b129         	cbz	r1, 0x6a91c <check_error+0x4294> @ imm = #0xa
   6a910: f810 2b01    	ldrb	r2, [r0], #1
   6a914: 3901         	subs	r1, #0x1
   6a916: f800 2c02    	strb	r2, [r0, #-2]
   6a91a: e7f8         	b	0x6a90e <check_error+0x4286> @ imm = #-0x10
   6a91c: 983c         	ldr	r0, [sp, #0xf0]
   6a91e: f896 186a    	ldrb.w	r1, [r6, #0x86a]
   6a922: 914f         	str	r1, [sp, #0x13c]
   6a924: f880 1247    	strb.w	r1, [r0, #0x247]
   6a928: 2000         	movs	r0, #0x0
   6a92a: 2100         	movs	r1, #0x0
   6a92c: 2905         	cmp	r1, #0x5
   6a92e: d004         	beq	0x6a93a <check_error+0x42b2> @ imm = #0x8
   6a930: 1872         	adds	r2, r6, r1
   6a932: 3101         	adds	r1, #0x1
   6a934: f882 0888    	strb.w	r0, [r2, #0x888]
   6a938: e7f8         	b	0x6a92c <check_error+0x42a4> @ imm = #-0x10
   6a93a: a80a         	add	r0, sp, #0x28
   6a93c: f44f 6143    	mov.w	r1, #0xc30
   6a940: f500 5067    	add.w	r0, r0, #0x39c0
   6a944: f004 eb5c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x46b8
   6a948: f1b8 0f01    	cmp.w	r8, #0x1
   6a94c: d106         	bne	0x6a95c <check_error+0x42d4> @ imm = #0xc
   6a94e: edda 1b00    	vldr	d17, [r10]
   6a952: ef61 01b1    	vorr	d16, d17, d17
   6a956: 9c53         	ldr	r4, [sp, #0x14c]
   6a958: 9d26         	ldr	r5, [sp, #0x98]
   6a95a: e01a         	b	0x6a992 <check_error+0x430a> @ imm = #0x34
   6a95c: 9d26         	ldr	r5, [sp, #0x98]
   6a95e: edda 0b00    	vldr	d16, [r10]
   6a962: edd5 2b00    	vldr	d18, [r5]
   6a966: eef4 2b62    	vcmp.f64	d18, d18
   6a96a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a96e: f181 862b    	bvs.w	0x6c5c8 <check_error+0x5f40> @ imm = #0x1c56
   6a972: eef4 0b60    	vcmp.f64	d16, d16
   6a976: 9c53         	ldr	r4, [sp, #0x14c]
   6a978: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a97c: f181 8629    	bvs.w	0x6c5d2 <check_error+0x5f4a> @ imm = #0x1c52
   6a980: eef4 2b60    	vcmp.f64	d18, d16
   6a984: eef0 1b60    	vmov.f64	d17, d16
   6a988: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6a98c: bf48         	it	mi
   6a98e: eef0 1b62    	vmovmi.f64	d17, d18
   6a992: f506 6007    	add.w	r0, r6, #0x870
   6a996: f1b8 0f02    	cmp.w	r8, #0x2
   6a99a: edc0 1b00    	vstr	d17, [r0]
   6a99e: d30d         	blo	0x6a9bc <check_error+0x4334> @ imm = #0x1a
   6a9a0: 992d         	ldr	r1, [sp, #0xb4]
   6a9a2: edd1 2b00    	vldr	d18, [r1]
   6a9a6: f506 6108    	add.w	r1, r6, #0x880
   6a9aa: ee70 0be2    	vsub.f64	d16, d16, d18
   6a9ae: edc1 0b00    	vstr	d16, [r1]
   6a9b2: edd5 0b00    	vldr	d16, [r5]
   6a9b6: ee71 0be0    	vsub.f64	d16, d17, d16
   6a9ba: e007         	b	0x6a9cc <check_error+0x4344> @ imm = #0xe
   6a9bc: 2100         	movs	r1, #0x0
   6a9be: ed5f 0b64    	vldr	d16, [pc, #-400]        @ 0x6a830 <check_error+0x41a8>
   6a9c2: f8c6 1880    	str.w	r1, [r6, #0x880]
   6a9c6: 496e         	ldr	r1, [pc, #0x1b8]        @ 0x6ab80 <check_error+0x44f8>
   6a9c8: f8c6 1884    	str.w	r1, [r6, #0x884]
   6a9cc: f24b 12e0    	movw	r2, #0xb1e0
   6a9d0: f606 0178    	addw	r1, r6, #0x878
   6a9d4: 4422         	add	r2, r4
   6a9d6: 2332         	movs	r3, #0x32
   6a9d8: edc1 0b00    	vstr	d16, [r1]
   6a9dc: b133         	cbz	r3, 0x6a9ec <check_error+0x4364> @ imm = #0xc
   6a9de: edd2 0b00    	vldr	d16, [r2]
   6a9e2: 3b01         	subs	r3, #0x1
   6a9e4: ed42 0b02    	vstr	d16, [r2, #-8]
   6a9e8: 3208         	adds	r2, #0x8
   6a9ea: e7f7         	b	0x6a9dc <check_error+0x4354> @ imm = #-0x12
   6a9ec: f506 6208    	add.w	r2, r6, #0x880
   6a9f0: 9e3d         	ldr	r6, [sp, #0xf4]
   6a9f2: f44f 7390    	mov.w	r3, #0x120
   6a9f6: edd2 0b00    	vldr	d16, [r2]
   6a9fa: f24b 3278    	movw	r2, #0xb378
   6a9fe: 4422         	add	r2, r4
   6aa00: edc5 0b66    	vstr	d16, [r5, #408]
   6aa04: b133         	cbz	r3, 0x6aa14 <check_error+0x438c> @ imm = #0xc
   6aa06: edd2 0b00    	vldr	d16, [r2]
   6aa0a: 3b01         	subs	r3, #0x1
   6aa0c: ed42 0b02    	vstr	d16, [r2, #-8]
   6aa10: 3208         	adds	r2, #0x8
   6aa12: e7f7         	b	0x6aa04 <check_error+0x437c> @ imm = #-0x12
   6aa14: edd1 0b00    	vldr	d16, [r1]
   6aa18: f44f 7290    	mov.w	r2, #0x120
   6aa1c: 993c         	ldr	r1, [sp, #0xf0]
   6aa1e: edc1 0b00    	vstr	d16, [r1]
   6aa22: f64a 01d8    	movw	r1, #0xa8d8
   6aa26: 4421         	add	r1, r4
   6aa28: b132         	cbz	r2, 0x6aa38 <check_error+0x43b0> @ imm = #0xc
   6aa2a: edd1 0b00    	vldr	d16, [r1]
   6aa2e: 3a01         	subs	r2, #0x1
   6aa30: ed41 0b02    	vstr	d16, [r1, #-8]
   6aa34: 3108         	adds	r1, #0x8
   6aa36: e7f7         	b	0x6aa28 <check_error+0x43a0> @ imm = #-0x12
   6aa38: edd0 0b00    	vldr	d16, [r0]
   6aa3c: 2200         	movs	r2, #0x0
   6aa3e: 9863         	ldr	r0, [sp, #0x18c]
   6aa40: f04f 0c00    	mov.w	r12, #0x0
   6aa44: edc5 0b00    	vstr	d16, [r5]
   6aa48: f8b6 157e    	ldrh.w	r1, [r6, #0x57e]
   6aa4c: f1a0 0a17    	sub.w	r10, r0, #0x17
   6aa50: 914c         	str	r1, [sp, #0x130]
   6aa52: 1a41         	subs	r1, r0, r1
   6aa54: 9158         	str	r1, [sp, #0x160]
   6aa56: f8b6 1578    	ldrh.w	r1, [r6, #0x578]
   6aa5a: 1a41         	subs	r1, r0, r1
   6aa5c: 9156         	str	r1, [sp, #0x158]
   6aa5e: f8b6 1576    	ldrh.w	r1, [r6, #0x576]
   6aa62: 1a41         	subs	r1, r0, r1
   6aa64: 9155         	str	r1, [sp, #0x154]
   6aa66: f8b6 1574    	ldrh.w	r1, [r6, #0x574]
   6aa6a: 914d         	str	r1, [sp, #0x134]
   6aa6c: 1a41         	subs	r1, r0, r1
   6aa6e: 9154         	str	r1, [sp, #0x150]
   6aa70: f8b6 156e    	ldrh.w	r1, [r6, #0x56e]
   6aa74: 914b         	str	r1, [sp, #0x12c]
   6aa76: 1a41         	subs	r1, r0, r1
   6aa78: 9151         	str	r1, [sp, #0x144]
   6aa7a: f8b6 156a    	ldrh.w	r1, [r6, #0x56a]
   6aa7e: 914e         	str	r1, [sp, #0x138]
   6aa80: eba0 0801    	sub.w	r8, r0, r1
   6aa84: f506 61c0    	add.w	r1, r6, #0x600
   6aa88: ed91 ab00    	vldr	d10, [r1]
   6aa8c: eebd 0bca    	vcvt.s32.f64	s0, d10
   6aa90: ee10 1a10    	vmov	r1, s0
   6aa94: 1a45         	subs	r5, r0, r1
   6aa96: 4839         	ldr	r0, [pc, #0xe4]         @ 0x6ab7c <check_error+0x44f4>
   6aa98: 2100         	movs	r1, #0x0
   6aa9a: 4681         	mov	r9, r0
   6aa9c: 2000         	movs	r0, #0x0
   6aa9e: 905e         	str	r0, [sp, #0x178]
   6aaa0: 2000         	movs	r0, #0x0
   6aaa2: 905c         	str	r0, [sp, #0x170]
   6aaa4: 2000         	movs	r0, #0x0
   6aaa6: 9060         	str	r0, [sp, #0x180]
   6aaa8: 2000         	movs	r0, #0x0
   6aaaa: 9062         	str	r0, [sp, #0x188]
   6aaac: 2000         	movs	r0, #0x0
   6aaae: 905b         	str	r0, [sp, #0x16c]
   6aab0: f1b9 0f00    	cmp.w	r9, #0x0
   6aab4: d066         	beq	0x6ab84 <check_error+0x44fc> @ imm = #0xcc
   6aab6: eb0b 0609    	add.w	r6, r11, r9
   6aaba: f8b6 66c2    	ldrh.w	r6, [r6, #0x6c2]
   6aabe: 2e00         	cmp	r6, #0x0
   6aac0: d058         	beq	0x6ab74 <check_error+0x44ec> @ imm = #0xb0
   6aac2: 9863         	ldr	r0, [sp, #0x18c]
   6aac4: 465b         	mov	r3, r11
   6aac6: 460c         	mov	r4, r1
   6aac8: f04f 0b00    	mov.w	r11, #0x0
   6aacc: 4286         	cmp	r6, r0
   6aace: f04f 0100    	mov.w	r1, #0x0
   6aad2: bf98         	it	ls
   6aad4: f04f 0b01    	movls.w	r11, #0x1
   6aad8: 42b5         	cmp	r5, r6
   6aada: bfd8         	it	le
   6aadc: 2101         	movle	r1, #0x1
   6aade: 9862         	ldr	r0, [sp, #0x188]
   6aae0: ea01 010b    	and.w	r1, r1, r11
   6aae4: 46e6         	mov	lr, r12
   6aae6: 4408         	add	r0, r1
   6aae8: 9062         	str	r0, [sp, #0x188]
   6aaea: 9858         	ldr	r0, [sp, #0x160]
   6aaec: 2100         	movs	r1, #0x0
   6aaee: 42b0         	cmp	r0, r6
   6aaf0: bfd8         	it	le
   6aaf2: 2101         	movle	r1, #0x1
   6aaf4: 9860         	ldr	r0, [sp, #0x180]
   6aaf6: ea01 010b    	and.w	r1, r1, r11
   6aafa: 4408         	add	r0, r1
   6aafc: 9060         	str	r0, [sp, #0x180]
   6aafe: 9855         	ldr	r0, [sp, #0x154]
   6ab00: 2100         	movs	r1, #0x0
   6ab02: 42b0         	cmp	r0, r6
   6ab04: bfd8         	it	le
   6ab06: 2101         	movle	r1, #0x1
   6ab08: f8dd c170    	ldr.w	r12, [sp, #0x170]
   6ab0c: ea01 000b    	and.w	r0, r1, r11
   6ab10: 4484         	add	r12, r0
   6ab12: 9856         	ldr	r0, [sp, #0x158]
   6ab14: f8cd c170    	str.w	r12, [sp, #0x170]
   6ab18: 46f4         	mov	r12, lr
   6ab1a: 42b0         	cmp	r0, r6
   6ab1c: f04f 0000    	mov.w	r0, #0x0
   6ab20: bfa8         	it	ge
   6ab22: 2001         	movge	r0, #0x1
   6ab24: 4008         	ands	r0, r1
   6ab26: 4621         	mov	r1, r4
   6ab28: 1821         	adds	r1, r4, r0
   6ab2a: 9854         	ldr	r0, [sp, #0x150]
   6ab2c: 42b0         	cmp	r0, r6
   6ab2e: f04f 0000    	mov.w	r0, #0x0
   6ab32: bfd8         	it	le
   6ab34: 2001         	movle	r0, #0x1
   6ab36: 9c5e         	ldr	r4, [sp, #0x178]
   6ab38: ea00 000b    	and.w	r0, r0, r11
   6ab3c: 4404         	add	r4, r0
   6ab3e: 9851         	ldr	r0, [sp, #0x144]
   6ab40: 945e         	str	r4, [sp, #0x178]
   6ab42: 42b0         	cmp	r0, r6
   6ab44: f04f 0000    	mov.w	r0, #0x0
   6ab48: bfd8         	it	le
   6ab4a: 2001         	movle	r0, #0x1
   6ab4c: 45b0         	cmp	r8, r6
   6ab4e: ea00 000b    	and.w	r0, r0, r11
   6ab52: eb0e 0c00    	add.w	r12, lr, r0
   6ab56: f04f 0000    	mov.w	r0, #0x0
   6ab5a: bfd8         	it	le
   6ab5c: 2001         	movle	r0, #0x1
   6ab5e: 45b2         	cmp	r10, r6
   6ab60: ea00 000b    	and.w	r0, r0, r11
   6ab64: 4402         	add	r2, r0
   6ab66: bfde         	ittt	le
   6ab68: 985b         	ldrle	r0, [sp, #0x16c]
   6ab6a: 4458         	addle	r0, r11
   6ab6c: 905b         	strle	r0, [sp, #0x16c]
   6ab6e: 9e3d         	ldr	r6, [sp, #0xf4]
   6ab70: 469b         	mov	r11, r3
   6ab72: e000         	b	0x6ab76 <check_error+0x44ee> @ imm = #0x0
   6ab74: 9e3d         	ldr	r6, [sp, #0xf4]
   6ab76: f109 0902    	add.w	r9, r9, #0x2
   6ab7a: e799         	b	0x6aab0 <check_error+0x4428> @ imm = #-0xce
   6ab7c: 3e f9 ff ff  	.word	0xfffff93e
   6ab80: 00 00 f8 7f  	.word	0x7ff80000
   6ab84: f506 60b3    	add.w	r0, r6, #0x598
   6ab88: edd0 2b00    	vldr	d18, [r0]
   6ab8c: edd0 0b02    	vldr	d16, [r0, #8]
   6ab90: edd0 3b04    	vldr	d19, [r0, #16]
   6ab94: edd0 1b06    	vldr	d17, [r0, #24]
   6ab98: 983b         	ldr	r0, [sp, #0xec]
   6ab9a: 6800         	ldr	r0, [r0]
   6ab9c: ee00 0a10    	vmov	s0, r0
   6aba0: b290         	uxth	r0, r2
   6aba2: eef7 4ac0    	vcvt.f64.f32	d20, s0
   6aba6: ee63 3ba4    	vmul.f64	d19, d19, d20
   6abaa: ee62 2ba4    	vmul.f64	d18, d18, d20
   6abae: eef4 3b61    	vcmp.f64	d19, d17
   6abb2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6abb6: bf48         	it	mi
   6abb8: eef0 1b63    	vmovmi.f64	d17, d19
   6abbc: eef4 2b60    	vcmp.f64	d18, d16
   6abc0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6abc4: bf48         	it	mi
   6abc6: eef0 0b62    	vmovmi.f64	d16, d18
   6abca: 9b4e         	ldr	r3, [sp, #0x138]
   6abcc: 4298         	cmp	r0, r3
   6abce: d930         	bls	0x6ac32 <check_error+0x45aa> @ imm = #0x60
   6abd0: 9156         	str	r1, [sp, #0x158]
   6abd2: 280d         	cmp	r0, #0xd
   6abd4: bf28         	it	hs
   6abd6: 220d         	movhs	r2, #0xd
   6abd8: f1c2 000d    	rsb.w	r0, r2, #0xd
   6abdc: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6abe0: f649 41a0    	movw	r1, #0x9ca0
   6abe4: ebc0 1000    	rsb	r0, r0, r0, lsl #4
   6abe8: 4ddc         	ldr	r5, [pc, #0x370]        @ 0x6af5c <check_error+0x48d4>
   6abea: 0040         	lsls	r0, r0, #0x1
   6abec: b280         	uxth	r0, r0
   6abee: eb0e 00c0    	add.w	r0, lr, r0, lsl #3
   6abf2: 1843         	adds	r3, r0, r1
   6abf4: a90a         	add	r1, sp, #0x28
   6abf6: f8dd 90a0    	ldr.w	r9, [sp, #0xa0]
   6abfa: b290         	uxth	r0, r2
   6abfc: 9e52         	ldr	r6, [sp, #0x148]
   6abfe: f501 5467    	add.w	r4, r1, #0x39c0
   6ac02: f8dd 8140    	ldr.w	r8, [sp, #0x140]
   6ac06: 2200         	movs	r2, #0x0
   6ac08: f8dd a16c    	ldr.w	r10, [sp, #0x16c]
   6ac0c: 4282         	cmp	r2, r0
   6ac0e: d016         	beq	0x6ac3e <check_error+0x45b6> @ imm = #0x2c
   6ac10: 2500         	movs	r5, #0x0
   6ac12: 2df0         	cmp	r5, #0xf0
   6ac14: d007         	beq	0x6ac26 <check_error+0x459e> @ imm = #0xe
   6ac16: 195e         	adds	r6, r3, r5
   6ac18: 1961         	adds	r1, r4, r5
   6ac1a: 3508         	adds	r5, #0x8
   6ac1c: edd6 2b00    	vldr	d18, [r6]
   6ac20: edc1 2b00    	vstr	d18, [r1]
   6ac24: e7f5         	b	0x6ac12 <check_error+0x458a> @ imm = #-0x16
   6ac26: 33f0         	adds	r3, #0xf0
   6ac28: 34f0         	adds	r4, #0xf0
   6ac2a: 3201         	adds	r2, #0x1
   6ac2c: 9e52         	ldr	r6, [sp, #0x148]
   6ac2e: 4dcb         	ldr	r5, [pc, #0x32c]        @ 0x6af5c <check_error+0x48d4>
   6ac30: e7ec         	b	0x6ac0c <check_error+0x4584> @ imm = #-0x28
   6ac32: 9e52         	ldr	r6, [sp, #0x148]
   6ac34: f8dd c0a0    	ldr.w	r12, [sp, #0xa0]
   6ac38: f896 07aa    	ldrb.w	r0, [r6, #0x7aa]
   6ac3c: e1b7         	b	0x6afae <check_error+0x4926> @ imm = #0x36e
   6ac3e: 993d         	ldr	r1, [sp, #0xf4]
   6ac40: ebc0 1000    	rsb	r0, r0, r0, lsl #4
   6ac44: 0040         	lsls	r0, r0, #0x1
   6ac46: f8b1 2418    	ldrh.w	r2, [r1, #0x418]
   6ac4a: 9963         	ldr	r1, [sp, #0x18c]
   6ac4c: 9258         	str	r2, [sp, #0x160]
   6ac4e: 4291         	cmp	r1, r2
   6ac50: d915         	bls	0x6ac7e <check_error+0x45f6> @ imm = #0x2a
   6ac52: a90a         	add	r1, sp, #0x28
   6ac54: 2201         	movs	r2, #0x1
   6ac56: f501 5367    	add.w	r3, r1, #0x39c0
   6ac5a: b330         	cbz	r0, 0x6acaa <check_error+0x4622> @ imm = #0x4c
   6ac5c: edd3 0b00    	vldr	d16, [r3]
   6ac60: eef4 0b61    	vcmp.f64	d16, d17
   6ac64: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ac68: dd01         	ble	0x6ac6e <check_error+0x45e6> @ imm = #0x2
   6ac6a: 2200         	movs	r2, #0x0
   6ac6c: e004         	b	0x6ac78 <check_error+0x45f0> @ imm = #0x8
   6ac6e: eef4 0b60    	vcmp.f64	d16, d16
   6ac72: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ac76: d6f8         	bvs	0x6ac6a <check_error+0x45e2> @ imm = #-0x10
   6ac78: 3801         	subs	r0, #0x1
   6ac7a: 3308         	adds	r3, #0x8
   6ac7c: e7ed         	b	0x6ac5a <check_error+0x45d2> @ imm = #-0x26
   6ac7e: a90a         	add	r1, sp, #0x28
   6ac80: 2201         	movs	r2, #0x1
   6ac82: f501 5367    	add.w	r3, r1, #0x39c0
   6ac86: b180         	cbz	r0, 0x6acaa <check_error+0x4622> @ imm = #0x20
   6ac88: edd3 1b00    	vldr	d17, [r3]
   6ac8c: eef4 1b60    	vcmp.f64	d17, d16
   6ac90: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ac94: dd01         	ble	0x6ac9a <check_error+0x4612> @ imm = #0x2
   6ac96: 2200         	movs	r2, #0x0
   6ac98: e004         	b	0x6aca4 <check_error+0x461c> @ imm = #0x8
   6ac9a: eef4 1b61    	vcmp.f64	d17, d17
   6ac9e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6aca2: d6f8         	bvs	0x6ac96 <check_error+0x460e> @ imm = #-0x10
   6aca4: 3801         	subs	r0, #0x1
   6aca6: 3308         	adds	r3, #0x8
   6aca8: e7ed         	b	0x6ac86 <check_error+0x45fe> @ imm = #-0x26
   6acaa: 2a01         	cmp	r2, #0x1
   6acac: bf04         	itt	eq
   6acae: 2001         	moveq	r0, #0x1
   6acb0: f886 0888    	strbeq.w	r0, [r6, #0x888]
   6acb4: fa1f f08c    	uxth.w	r0, r12
   6acb8: f5b0 7f90    	cmp.w	r0, #0x120
   6acbc: bf88         	it	hi
   6acbe: f240 1c21    	movwhi	r12, #0x121
   6acc2: f8b9 3000    	ldrh.w	r3, [r9]
   6acc6: 9863         	ldr	r0, [sp, #0x18c]
   6acc8: 4298         	cmp	r0, r3
   6acca: f240 80a6    	bls.w	0x6ae1a <check_error+0x4792> @ imm = #0x14c
   6acce: 2b00         	cmp	r3, #0x0
   6acd0: f000 8081    	beq.w	0x6add6 <check_error+0x474e> @ imm = #0x102
   6acd4: 9863         	ldr	r0, [sp, #0x18c]
   6acd6: 9958         	ldr	r1, [sp, #0x160]
   6acd8: 4288         	cmp	r0, r1
   6acda: d97c         	bls	0x6add6 <check_error+0x474e> @ imm = #0xf8
   6acdc: 983d         	ldr	r0, [sp, #0xf4]
   6acde: 9963         	ldr	r1, [sp, #0x18c]
   6ace0: f8dd 90a0    	ldr.w	r9, [sp, #0xa0]
   6ace4: f8b0 0572    	ldrh.w	r0, [r0, #0x572]
   6ace8: f8dd a16c    	ldr.w	r10, [sp, #0x16c]
   6acec: 4281         	cmp	r1, r0
   6acee: d977         	bls	0x6ade0 <check_error+0x4758> @ imm = #0xee
   6acf0: 994b         	ldr	r1, [sp, #0x12c]
   6acf2: fa1f f28c    	uxth.w	r2, r12
   6acf6: 9254         	str	r2, [sp, #0x150]
   6acf8: 3901         	subs	r1, #0x1
   6acfa: 4291         	cmp	r1, r2
   6acfc: dc70         	bgt	0x6ade0 <check_error+0x4758> @ imm = #0xe0
   6acfe: 9963         	ldr	r1, [sp, #0x18c]
   6ad00: f60e 22ca    	addw	r2, lr, #0xaca
   6ad04: 9355         	str	r3, [sp, #0x154]
   6ad06: f44f 7310    	mov.w	r3, #0x240
   6ad0a: 1a09         	subs	r1, r1, r0
   6ad0c: f505 6090    	add.w	r0, r5, #0x480
   6ad10: b28c         	uxth	r4, r1
   6ad12: 2500         	movs	r5, #0x0
   6ad14: 4629         	mov	r1, r5
   6ad16: b140         	cbz	r0, 0x6ad2a <check_error+0x46a2> @ imm = #0x10
   6ad18: 1815         	adds	r5, r2, r0
   6ad1a: 1c5e         	adds	r6, r3, #0x1
   6ad1c: 3002         	adds	r0, #0x2
   6ad1e: f8b5 5242    	ldrh.w	r5, [r5, #0x242]
   6ad22: 42a5         	cmp	r5, r4
   6ad24: 461d         	mov	r5, r3
   6ad26: 4633         	mov	r3, r6
   6ad28: d9f4         	bls	0x6ad14 <check_error+0x468c> @ imm = #-0x18
   6ad2a: 9e52         	ldr	r6, [sp, #0x148]
   6ad2c: 2900         	cmp	r1, #0x0
   6ad2e: 4d8b         	ldr	r5, [pc, #0x22c]        @ 0x6af5c <check_error+0x48d4>
   6ad30: 9b55         	ldr	r3, [sp, #0x154]
   6ad32: d050         	beq	0x6add6 <check_error+0x474e> @ imm = #0xa0
   6ad34: f8dd 8150    	ldr.w	r8, [sp, #0x150]
   6ad38: f642 2268    	movw	r2, #0x2a68
   6ad3c: f04f 0900    	mov.w	r9, #0x0
   6ad40: f04f 0a00    	mov.w	r10, #0x0
   6ad44: ebae 00c8    	sub.w	r0, lr, r8, lsl #3
   6ad48: 1885         	adds	r5, r0, r2
   6ad4a: f1c8 0033    	rsb.w	r0, r8, #0x33
   6ad4e: f24b 12d8    	movw	r2, #0xb1d8
   6ad52: eb0e 00c0    	add.w	r0, lr, r0, lsl #3
   6ad56: 1884         	adds	r4, r0, r2
   6ad58: eb0e 00c1    	add.w	r0, lr, r1, lsl #3
   6ad5c: f249 61d0    	movw	r1, #0x96d0
   6ad60: 4408         	add	r0, r1
   6ad62: ed90 8b00    	vldr	d8, [r0]
   6ad66: 983d         	ldr	r0, [sp, #0xf4]
   6ad68: f500 60b9    	add.w	r0, r0, #0x5c8
   6ad6c: ed90 9b00    	vldr	d9, [r0]
   6ad70: f1b8 0f00    	cmp.w	r8, #0x0
   6ad74: d01c         	beq	0x6adb0 <check_error+0x4728> @ imm = #0x38
   6ad76: ef28 1118    	vorr	d1, d8, d8
   6ad7a: ecb5 0b02    	vldmia	r5!, {d0}
   6ad7e: 200a         	movs	r0, #0xa
   6ad80: 2104         	movs	r1, #0x4
   6ad82: f001 fd51    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x1aa2
   6ad86: ef29 1119    	vorr	d1, d9, d9
   6ad8a: 2800         	cmp	r0, #0x0
   6ad8c: bf18         	it	ne
   6ad8e: f109 0901    	addne.w	r9, r9, #0x1
   6ad92: ecb4 0b02    	vldmia	r4!, {d0}
   6ad96: 200a         	movs	r0, #0xa
   6ad98: 2104         	movs	r1, #0x4
   6ad9a: f001 fd45    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x1a8a
   6ad9e: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6ada2: f1a8 0801    	sub.w	r8, r8, #0x1
   6ada6: 2800         	cmp	r0, #0x0
   6ada8: bf18         	it	ne
   6adaa: f10a 0a01    	addne.w	r10, r10, #0x1
   6adae: e7df         	b	0x6ad70 <check_error+0x46e8> @ imm = #-0x42
   6adb0: 9954         	ldr	r1, [sp, #0x150]
   6adb2: fa1f f089    	uxth.w	r0, r9
   6adb6: 4d69         	ldr	r5, [pc, #0x1a4]        @ 0x6af5c <check_error+0x48d4>
   6adb8: f8dd 8140    	ldr.w	r8, [sp, #0x140]
   6adbc: 4288         	cmp	r0, r1
   6adbe: 9b55         	ldr	r3, [sp, #0x154]
   6adc0: d109         	bne	0x6add6 <check_error+0x474e> @ imm = #0x12
   6adc2: 983d         	ldr	r0, [sp, #0xf4]
   6adc4: fa1f f18a    	uxth.w	r1, r10
   6adc8: f890 05d0    	ldrb.w	r0, [r0, #0x5d0]
   6adcc: 4281         	cmp	r1, r0
   6adce: bf24         	itt	hs
   6add0: 2001         	movhs	r0, #0x1
   6add2: f886 0889    	strbhs.w	r0, [r6, #0x889]
   6add6: f8dd 90a0    	ldr.w	r9, [sp, #0xa0]
   6adda: f8dd a16c    	ldr.w	r10, [sp, #0x16c]
   6adde: b1e3         	cbz	r3, 0x6ae1a <check_error+0x4792> @ imm = #0x38
   6ade0: 983d         	ldr	r0, [sp, #0xf4]
   6ade2: f8b0 157c    	ldrh.w	r1, [r0, #0x57c]
   6ade6: 9863         	ldr	r0, [sp, #0x18c]
   6ade8: 4288         	cmp	r0, r1
   6adea: bf82         	ittt	hi
   6adec: 9863         	ldrhi	r0, [sp, #0x18c]
   6adee: 9a58         	ldrhi	r2, [sp, #0x160]
   6adf0: 4290         	cmphi	r0, r2
   6adf2: f200 81b8    	bhi.w	0x6b166 <check_error+0x4ade> @ imm = #0x370
   6adf6: 9a60         	ldr	r2, [sp, #0x180]
   6adf8: b290         	uxth	r0, r2
   6adfa: f5b0 7f90    	cmp.w	r0, #0x120
   6adfe: bf88         	it	hi
   6ae00: f240 1221    	movwhi	r2, #0x121
   6ae04: 983d         	ldr	r0, [sp, #0xf4]
   6ae06: f8b0 1580    	ldrh.w	r1, [r0, #0x580]
   6ae0a: 9863         	ldr	r0, [sp, #0x18c]
   6ae0c: 4288         	cmp	r0, r1
   6ae0e: bf82         	ittt	hi
   6ae10: 9863         	ldrhi	r0, [sp, #0x18c]
   6ae12: 9b58         	ldrhi	r3, [sp, #0x160]
   6ae14: 4298         	cmphi	r0, r3
   6ae16: f200 81f0    	bhi.w	0x6b1fa <check_error+0x4b72> @ imm = #0x3e0
   6ae1a: 9962         	ldr	r1, [sp, #0x188]
   6ae1c: efc0 1010    	vmov.i32	d17, #0x0
   6ae20: b288         	uxth	r0, r1
   6ae22: f5b0 7f90    	cmp.w	r0, #0x120
   6ae26: bf28         	it	hs
   6ae28: f44f 7190    	movhs.w	r1, #0x120
   6ae2c: b288         	uxth	r0, r1
   6ae2e: f644 31f8    	movw	r1, #0x4bf8
   6ae32: 4244         	rsbs	r4, r0, #0
   6ae34: 2201         	movs	r2, #0x1
   6ae36: ebae 0cc0    	sub.w	r12, lr, r0, lsl #3
   6ae3a: eb0c 0301    	add.w	r3, r12, r1
   6ae3e: f64b 61b8    	movw	r1, #0xbeb8
   6ae42: eb0e 0501    	add.w	r5, lr, r1
   6ae46: b14c         	cbz	r4, 0x6ae5c <check_error+0x47d4> @ imm = #0x12
   6ae48: ecf3 0b02    	vldmia	r3!, {d16}
   6ae4c: 5d29         	ldrb	r1, [r5, r4]
   6ae4e: ee71 1ba0    	vadd.f64	d17, d17, d16
   6ae52: 2900         	cmp	r1, #0x0
   6ae54: bf08         	it	eq
   6ae56: 460a         	moveq	r2, r1
   6ae58: 3401         	adds	r4, #0x1
   6ae5a: e7f4         	b	0x6ae46 <check_error+0x47be> @ imm = #-0x18
   6ae5c: fa1f f18a    	uxth.w	r1, r10
   6ae60: 2933         	cmp	r1, #0x33
   6ae62: bf28         	it	hs
   6ae64: f04f 0a33    	movhs.w	r10, #0x33
   6ae68: 9963         	ldr	r1, [sp, #0x18c]
   6ae6a: 9b58         	ldr	r3, [sp, #0x160]
   6ae6c: 4299         	cmp	r1, r3
   6ae6e: f240 8085    	bls.w	0x6af7c <check_error+0x48f4> @ imm = #0x10a
   6ae72: eeff 0b00    	vmov.f64	d16, #-1.000000e+00
   6ae76: ee00 0a10    	vmov	s0, r0
   6ae7a: ee7a 2b20    	vadd.f64	d18, d10, d16
   6ae7e: eef8 3b40    	vcvt.f64.u32	d19, s0
   6ae82: eef4 2b63    	vcmp.f64	d18, d19
   6ae86: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ae8a: d877         	bhi	0x6af7c <check_error+0x48f4> @ imm = #0xee
   6ae8c: b2d1         	uxtb	r1, r2
   6ae8e: 2901         	cmp	r1, #0x1
   6ae90: d174         	bne	0x6af7c <check_error+0x48f4> @ imm = #0xe8
   6ae92: eddf 2b33    	vldr	d18, [pc, #204]         @ 0x6af60 <check_error+0x48d8>
   6ae96: eef4 1b62    	vcmp.f64	d17, d18
   6ae9a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ae9e: d56d         	bpl	0x6af7c <check_error+0x48f4> @ imm = #0xda
   6aea0: 492e         	ldr	r1, [pc, #0xb8]         @ 0x6af5c <check_error+0x48d4>
   6aea2: f60e 2eca    	addw	lr, lr, #0xaca
   6aea6: 2400         	movs	r4, #0x0
   6aea8: f501 6290    	add.w	r2, r1, #0x480
   6aeac: 9963         	ldr	r1, [sp, #0x18c]
   6aeae: f1a1 0518    	sub.w	r5, r1, #0x18
   6aeb2: f44f 7110    	mov.w	r1, #0x240
   6aeb6: b2ae         	uxth	r6, r5
   6aeb8: 4625         	mov	r5, r4
   6aeba: b14a         	cbz	r2, 0x6aed0 <check_error+0x4848> @ imm = #0x12
   6aebc: eb0e 0402    	add.w	r4, lr, r2
   6aec0: 1c4b         	adds	r3, r1, #0x1
   6aec2: 3202         	adds	r2, #0x2
   6aec4: f8b4 4242    	ldrh.w	r4, [r4, #0x242]
   6aec8: 42b4         	cmp	r4, r6
   6aeca: 460c         	mov	r4, r1
   6aecc: 4619         	mov	r1, r3
   6aece: d9f3         	bls	0x6aeb8 <check_error+0x4830> @ imm = #-0x1a
   6aed0: e9dd 6452    	ldrd	r6, r4, [sp, #328]
   6aed4: 2d00         	cmp	r5, #0x0
   6aed6: d051         	beq	0x6af7c <check_error+0x48f4> @ imm = #0xa2
   6aed8: f642 2168    	movw	r1, #0x2a68
   6aedc: eb0c 0201    	add.w	r2, r12, r1
   6aee0: eb04 01c5    	add.w	r1, r4, r5, lsl #3
   6aee4: f249 63d0    	movw	r3, #0x96d0
   6aee8: 4419         	add	r1, r3
   6aeea: eef6 2b00    	vmov.f64	d18, #5.000000e-01
   6aeee: edd1 1b00    	vldr	d17, [r1]
   6aef2: 2101         	movs	r1, #0x1
   6aef4: ee61 2ba2    	vmul.f64	d18, d17, d18
   6aef8: b1a0         	cbz	r0, 0x6af24 <check_error+0x489c> @ imm = #0x28
   6aefa: edd2 3b00    	vldr	d19, [r2]
   6aefe: eef4 3b62    	vcmp.f64	d19, d18
   6af02: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6af06: dc09         	bgt	0x6af1c <check_error+0x4894> @ imm = #0x12
   6af08: eef4 3b63    	vcmp.f64	d19, d19
   6af0c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6af10: bf7c         	itt	vc
   6af12: eef4 1b61    	vcmpvc.f64	d17, d17
   6af16: eef1 fa10    	vmrsvc	APSR_nzcv, fpscr
   6af1a: d700         	bvc	0x6af1e <check_error+0x4896> @ imm = #0x0
   6af1c: 2100         	movs	r1, #0x0
   6af1e: 3801         	subs	r0, #0x1
   6af20: 3208         	adds	r2, #0x8
   6af22: e7e9         	b	0x6aef8 <check_error+0x4870> @ imm = #-0x2e
   6af24: fa1f f08a    	uxth.w	r0, r10
   6af28: f1c0 0233    	rsb.w	r2, r0, #0x33
   6af2c: f24b 13d8    	movw	r3, #0xb1d8
   6af30: efc0 1010    	vmov.i32	d17, #0x0
   6af34: eb04 02c2    	add.w	r2, r4, r2, lsl #3
   6af38: eef7 2b00    	vmov.f64	d18, #1.000000e+00
   6af3c: 441a         	add	r2, r3
   6af3e: b198         	cbz	r0, 0x6af68 <check_error+0x48e0> @ imm = #0x26
   6af40: ecf2 4b02    	vldmia	r2!, {d20}
   6af44: eef4 4b60    	vcmp.f64	d20, d16
   6af48: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6af4c: ee71 3ba2    	vadd.f64	d19, d17, d18
   6af50: bf48         	it	mi
   6af52: eef0 1b63    	vmovmi.f64	d17, d19
   6af56: 3801         	subs	r0, #0x1
   6af58: e7f1         	b	0x6af3e <check_error+0x48b6> @ imm = #-0x1e
   6af5a: bf00         	nop
   6af5c: 3e f9 ff ff  	.word	0xfffff93e
   6af60: 00 00 00 00  	.word	0x00000000
   6af64: 00 00 69 40  	.word	0x40690000
   6af68: 2901         	cmp	r1, #0x1
   6af6a: d107         	bne	0x6af7c <check_error+0x48f4> @ imm = #0xe
   6af6c: eef4 1b62    	vcmp.f64	d17, d18
   6af70: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6af74: bfa4         	itt	ge
   6af76: 2001         	movge	r0, #0x1
   6af78: f886 088c    	strbge.w	r0, [r6, #0x88c]
   6af7c: f1b8 0f01    	cmp.w	r8, #0x1
   6af80: d904         	bls	0x6af8c <check_error+0x4904> @ imm = #0x8
   6af82: 983c         	ldr	r0, [sp, #0xf0]
   6af84: f890 0248    	ldrb.w	r0, [r0, #0x248]
   6af88: 2801         	cmp	r0, #0x1
   6af8a: d008         	beq	0x6af9e <check_error+0x4916> @ imm = #0x10
   6af8c: 2000         	movs	r0, #0x0
   6af8e: 2805         	cmp	r0, #0x5
   6af90: d00a         	beq	0x6afa8 <check_error+0x4920> @ imm = #0x14
   6af92: 1831         	adds	r1, r6, r0
   6af94: 3001         	adds	r0, #0x1
   6af96: f891 1888    	ldrb.w	r1, [r1, #0x888]
   6af9a: 2901         	cmp	r1, #0x1
   6af9c: d1f7         	bne	0x6af8e <check_error+0x4906> @ imm = #-0x12
   6af9e: 2001         	movs	r0, #0x1
   6afa0: 46cc         	mov	r12, r9
   6afa2: f886 07aa    	strb.w	r0, [r6, #0x7aa]
   6afa6: e002         	b	0x6afae <check_error+0x4926> @ imm = #0x4
   6afa8: f896 07aa    	ldrb.w	r0, [r6, #0x7aa]
   6afac: 46cc         	mov	r12, r9
   6afae: 993c         	ldr	r1, [sp, #0xf0]
   6afb0: 2400         	movs	r4, #0x0
   6afb2: 9a53         	ldr	r2, [sp, #0x14c]
   6afb4: f04f 0900    	mov.w	r9, #0x0
   6afb8: 4bd5         	ldr	r3, [pc, #0x354]        @ 0x6b310 <check_error+0x4c88>
   6afba: f881 0248    	strb.w	r0, [r1, #0x248]
   6afbe: 983d         	ldr	r0, [sp, #0xf4]
   6afc0: f8b6 a000    	ldrh.w	r10, [r6]
   6afc4: f8a6 488d    	strh.w	r4, [r6, #0x88d]
   6afc8: f8b0 e60a    	ldrh.w	lr, [r0, #0x60a]
   6afcc: f8b0 8608    	ldrh.w	r8, [r0, #0x608]
   6afd0: f886 47ab    	strb.w	r4, [r6, #0x7ab]
   6afd4: ea6f 000e    	mvn.w	r0, lr
   6afd8: ebaa 0608    	sub.w	r6, r10, r8
   6afdc: 4450         	add	r0, r10
   6afde: f8b2 1648    	ldrh.w	r1, [r2, #0x648]
   6afe2: 9163         	str	r1, [sp, #0x18c]
   6afe4: b1d3         	cbz	r3, 0x6b01c <check_error+0x4994> @ imm = #0x34
   6afe6: eb0b 0203    	add.w	r2, r11, r3
   6afea: f8b2 26c2    	ldrh.w	r2, [r2, #0x6c2]
   6afee: b19a         	cbz	r2, 0x6b018 <check_error+0x4990> @ imm = #0x26
   6aff0: 4619         	mov	r1, r3
   6aff2: 4552         	cmp	r2, r10
   6aff4: f04f 0500    	mov.w	r5, #0x0
   6aff8: f04f 0300    	mov.w	r3, #0x0
   6affc: bf98         	it	ls
   6affe: 2501         	movls	r5, #0x1
   6b000: 4296         	cmp	r6, r2
   6b002: bfd8         	it	le
   6b004: 2301         	movle	r3, #0x1
   6b006: 402b         	ands	r3, r5
   6b008: 441c         	add	r4, r3
   6b00a: 4290         	cmp	r0, r2
   6b00c: dc03         	bgt	0x6b016 <check_error+0x498e> @ imm = #0x6
   6b00e: 4552         	cmp	r2, r10
   6b010: bf98         	it	ls
   6b012: f109 0901    	addls.w	r9, r9, #0x1
   6b016: 460b         	mov	r3, r1
   6b018: 3302         	adds	r3, #0x2
   6b01a: e7e3         	b	0x6afe4 <check_error+0x495c> @ imm = #-0x3a
   6b01c: 983d         	ldr	r0, [sp, #0xf4]
   6b01e: b2a4         	uxth	r4, r4
   6b020: f500 60c2    	add.w	r0, r0, #0x610
   6b024: edd0 1b00    	vldr	d17, [r0]
   6b028: edd0 0b02    	vldr	d16, [r0, #8]
   6b02c: 983b         	ldr	r0, [sp, #0xec]
   6b02e: 6800         	ldr	r0, [r0]
   6b030: ee00 0a10    	vmov	s0, r0
   6b034: f1a8 0001    	sub.w	r0, r8, #0x1
   6b038: eef7 2ac0    	vcvt.f64.f32	d18, s0
   6b03c: ee61 1ba2    	vmul.f64	d17, d17, d18
   6b040: eef4 1b60    	vcmp.f64	d17, d16
   6b044: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b048: bf48         	it	mi
   6b04a: eef0 0b61    	vmovmi.f64	d16, d17
   6b04e: 42a0         	cmp	r0, r4
   6b050: dd02         	ble	0x6b058 <check_error+0x49d0> @ imm = #0x4
   6b052: 2400         	movs	r4, #0x0
   6b054: 9e52         	ldr	r6, [sp, #0x148]
   6b056: e025         	b	0x6b0a4 <check_error+0x4a1c> @ imm = #0x4a
   6b058: f8bc 0000    	ldrh.w	r0, [r12]
   6b05c: 4582         	cmp	r10, r0
   6b05e: 9e52         	ldr	r6, [sp, #0x148]
   6b060: d900         	bls	0x6b064 <check_error+0x49dc> @ imm = #0x0
   6b062: b9f0         	cbnz	r0, 0x6b0a2 <check_error+0x4a1a> @ imm = #0x3c
   6b064: 9853         	ldr	r0, [sp, #0x14c]
   6b066: f642 2268    	movw	r2, #0x2a68
   6b06a: 2501         	movs	r5, #0x1
   6b06c: eba0 00c4    	sub.w	r0, r0, r4, lsl #3
   6b070: 4410         	add	r0, r2
   6b072: b184         	cbz	r4, 0x6b096 <check_error+0x4a0e> @ imm = #0x20
   6b074: edd0 1b00    	vldr	d17, [r0]
   6b078: eef4 1b60    	vcmp.f64	d17, d16
   6b07c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b080: dd01         	ble	0x6b086 <check_error+0x49fe> @ imm = #0x2
   6b082: 2500         	movs	r5, #0x0
   6b084: e004         	b	0x6b090 <check_error+0x4a08> @ imm = #0x8
   6b086: eef4 1b61    	vcmp.f64	d17, d17
   6b08a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b08e: d6f8         	bvs	0x6b082 <check_error+0x49fa> @ imm = #-0x10
   6b090: 3c01         	subs	r4, #0x1
   6b092: 3008         	adds	r0, #0x8
   6b094: e7ed         	b	0x6b072 <check_error+0x49ea> @ imm = #-0x26
   6b096: 2d01         	cmp	r5, #0x1
   6b098: d103         	bne	0x6b0a2 <check_error+0x4a1a> @ imm = #0x6
   6b09a: 2401         	movs	r4, #0x1
   6b09c: f886 488d    	strb.w	r4, [r6, #0x88d]
   6b0a0: e000         	b	0x6b0a4 <check_error+0x4a1c> @ imm = #0x0
   6b0a2: 2400         	movs	r4, #0x0
   6b0a4: 9a53         	ldr	r2, [sp, #0x14c]
   6b0a6: f64b 60b8    	movw	r0, #0xbeb8
   6b0aa: 1815         	adds	r5, r2, r0
   6b0ac: fa1f f089    	uxth.w	r0, r9
   6b0b0: 4243         	rsbs	r3, r0, #0
   6b0b2: 2000         	movs	r0, #0x0
   6b0b4: b123         	cbz	r3, 0x6b0c0 <check_error+0x4a38> @ imm = #0x8
   6b0b6: 5cea         	ldrb	r2, [r5, r3]
   6b0b8: 3301         	adds	r3, #0x1
   6b0ba: 4410         	add	r0, r2
   6b0bc: b280         	uxth	r0, r0
   6b0be: e7f9         	b	0x6b0b4 <check_error+0x4a2c> @ imm = #-0xe
   6b0c0: 45f2         	cmp	r10, lr
   6b0c2: d902         	bls	0x6b0ca <check_error+0x4a42> @ imm = #0x4
   6b0c4: 2000         	movs	r0, #0x0
   6b0c6: 9a53         	ldr	r2, [sp, #0x14c]
   6b0c8: e009         	b	0x6b0de <check_error+0x4a56> @ imm = #0x12
   6b0ca: 993d         	ldr	r1, [sp, #0xf4]
   6b0cc: 9a53         	ldr	r2, [sp, #0x14c]
   6b0ce: f8b1 160c    	ldrh.w	r1, [r1, #0x60c]
   6b0d2: 4288         	cmp	r0, r1
   6b0d4: bf26         	itte	hs
   6b0d6: 2001         	movhs	r0, #0x1
   6b0d8: f886 088e    	strbhs.w	r0, [r6, #0x88e]
   6b0dc: 2000         	movlo	r0, #0x0
   6b0de: 9963         	ldr	r1, [sp, #0x18c]
   6b0e0: 2902         	cmp	r1, #0x2
   6b0e2: d303         	blo	0x6b0ec <check_error+0x4a64> @ imm = #0x6
   6b0e4: 993c         	ldr	r1, [sp, #0xf0]
   6b0e6: f891 1249    	ldrb.w	r1, [r1, #0x249]
   6b0ea: b911         	cbnz	r1, 0x6b0f2 <check_error+0x4a6a> @ imm = #0x4
   6b0ec: 4320         	orrs	r0, r4
   6b0ee: 2801         	cmp	r0, #0x1
   6b0f0: d103         	bne	0x6b0fa <check_error+0x4a72> @ imm = #0x6
   6b0f2: 2001         	movs	r0, #0x1
   6b0f4: f886 07ab    	strb.w	r0, [r6, #0x7ab]
   6b0f8: e000         	b	0x6b0fc <check_error+0x4a74> @ imm = #0x0
   6b0fa: 2000         	movs	r0, #0x0
   6b0fc: 993c         	ldr	r1, [sp, #0xf0]
   6b0fe: f881 0249    	strb.w	r0, [r1, #0x249]
   6b102: 984f         	ldr	r0, [sp, #0x13c]
   6b104: 2801         	cmp	r0, #0x1
   6b106: bf1c         	itt	ne
   6b108: f896 0800    	ldrbne.w	r0, [r6, #0x800]
   6b10c: 2801         	cmpne	r0, #0x1
   6b10e: d125         	bne	0x6b15c <check_error+0x4ad4> @ imm = #0x4a
   6b110: 2001         	movs	r0, #0x1
   6b112: f886 07ad    	strb.w	r0, [r6, #0x7ad]
   6b116: f244 20ed    	movw	r0, #0x42ed
   6b11a: 2106         	movs	r1, #0x6
   6b11c: 4410         	add	r0, r2
   6b11e: b129         	cbz	r1, 0x6b12c <check_error+0x4aa4> @ imm = #0xa
   6b120: f810 2b01    	ldrb	r2, [r0], #1
   6b124: 3901         	subs	r1, #0x1
   6b126: f800 2c02    	strb	r2, [r0, #-2]
   6b12a: e7f8         	b	0x6b11e <check_error+0x4a96> @ imm = #-0x10
   6b12c: f896 07ad    	ldrb.w	r0, [r6, #0x7ad]
   6b130: f88c 000e    	strb.w	r0, [r12, #0xe]
   6b134: f857 0c6c    	ldr	r0, [r7, #-108]
   6b138: 4976         	ldr	r1, [pc, #0x1d8]        @ 0x6b314 <check_error+0x4c8c>
   6b13a: 4479         	add	r1, pc
   6b13c: 6809         	ldr	r1, [r1]
   6b13e: 6809         	ldr	r1, [r1]
   6b140: 4281         	cmp	r1, r0
   6b142: bf01         	itttt	eq
   6b144: f50d 4d8c    	addeq.w	sp, sp, #0x4600
   6b148: b00a         	addeq	sp, #0x28
   6b14a: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   6b14e: b001         	addeq	sp, #0x4
   6b150: bf04         	itt	eq
   6b152: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   6b156: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6b158: f003 ef6a    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x3ed4
   6b15c: f896 07c8    	ldrb.w	r0, [r6, #0x7c8]
   6b160: 2801         	cmp	r0, #0x1
   6b162: d0d5         	beq	0x6b110 <check_error+0x4a88> @ imm = #-0x56
   6b164: e7d7         	b	0x6b116 <check_error+0x4a8e> @ imm = #-0x52
   6b166: 985e         	ldr	r0, [sp, #0x178]
   6b168: fa1f fc80    	uxth.w	r12, r0
   6b16c: 984d         	ldr	r0, [sp, #0x134]
   6b16e: 1e42         	subs	r2, r0, #0x1
   6b170: 4562         	cmp	r2, r12
   6b172: f73f ae40    	bgt.w	0x6adf6 <check_error+0x476e> @ imm = #-0x380
   6b176: 9863         	ldr	r0, [sp, #0x18c]
   6b178: f60e 22ca    	addw	r2, lr, #0xaca
   6b17c: 9355         	str	r3, [sp, #0x154]
   6b17e: f44f 7410    	mov.w	r4, #0x240
   6b182: 1a43         	subs	r3, r0, r1
   6b184: f505 6190    	add.w	r1, r5, #0x480
   6b188: b29d         	uxth	r5, r3
   6b18a: 2600         	movs	r6, #0x0
   6b18c: 4633         	mov	r3, r6
   6b18e: b141         	cbz	r1, 0x6b1a2 <check_error+0x4b1a> @ imm = #0x10
   6b190: 1856         	adds	r6, r2, r1
   6b192: 1c60         	adds	r0, r4, #0x1
   6b194: 3102         	adds	r1, #0x2
   6b196: f8b6 6242    	ldrh.w	r6, [r6, #0x242]
   6b19a: 42ae         	cmp	r6, r5
   6b19c: 4626         	mov	r6, r4
   6b19e: 4604         	mov	r4, r0
   6b1a0: d9f4         	bls	0x6b18c <check_error+0x4b04> @ imm = #-0x18
   6b1a2: 9e52         	ldr	r6, [sp, #0x148]
   6b1a4: 2b00         	cmp	r3, #0x0
   6b1a6: f000 8097    	beq.w	0x6b2d8 <check_error+0x4c50> @ imm = #0x12e
   6b1aa: 985e         	ldr	r0, [sp, #0x178]
   6b1ac: f5bc 7f58    	cmp.w	r12, #0x360
   6b1b0: bf88         	it	hi
   6b1b2: f240 3061    	movwhi	r0, #0x361
   6b1b6: f642 2268    	movw	r2, #0x2a68
   6b1ba: b280         	uxth	r0, r0
   6b1bc: 9e3d         	ldr	r6, [sp, #0xf4]
   6b1be: ebae 01c0    	sub.w	r1, lr, r0, lsl #3
   6b1c2: 440a         	add	r2, r1
   6b1c4: eb0e 01c3    	add.w	r1, lr, r3, lsl #3
   6b1c8: f249 63d0    	movw	r3, #0x96d0
   6b1cc: 4419         	add	r1, r3
   6b1ce: 4603         	mov	r3, r0
   6b1d0: edd1 0b00    	vldr	d16, [r1]
   6b1d4: f506 61b7    	add.w	r1, r6, #0x5b8
   6b1d8: edd1 1b00    	vldr	d17, [r1]
   6b1dc: 2100         	movs	r1, #0x0
   6b1de: ee60 0ba1    	vmul.f64	d16, d16, d17
   6b1e2: 2b00         	cmp	r3, #0x0
   6b1e4: d04a         	beq	0x6b27c <check_error+0x4bf4> @ imm = #0x94
   6b1e6: ecf2 1b02    	vldmia	r2!, {d17}
   6b1ea: eef4 1b60    	vcmp.f64	d17, d16
   6b1ee: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b1f2: bf98         	it	ls
   6b1f4: 3101         	addls	r1, #0x1
   6b1f6: 3b01         	subs	r3, #0x1
   6b1f8: e7f3         	b	0x6b1e2 <check_error+0x4b5a> @ imm = #-0x1a
   6b1fa: 984c         	ldr	r0, [sp, #0x130]
   6b1fc: fa1f fc82    	uxth.w	r12, r2
   6b200: 1e42         	subs	r2, r0, #0x1
   6b202: 4562         	cmp	r2, r12
   6b204: f73f ae09    	bgt.w	0x6ae1a <check_error+0x4792> @ imm = #-0x3ee
   6b208: 9863         	ldr	r0, [sp, #0x18c]
   6b20a: f60e 22ca    	addw	r2, lr, #0xaca
   6b20e: f44f 7310    	mov.w	r3, #0x240
   6b212: 2600         	movs	r6, #0x0
   6b214: 1a44         	subs	r4, r0, r1
   6b216: f505 6190    	add.w	r1, r5, #0x480
   6b21a: b2a5         	uxth	r5, r4
   6b21c: 4634         	mov	r4, r6
   6b21e: b141         	cbz	r1, 0x6b232 <check_error+0x4baa> @ imm = #0x10
   6b220: 1856         	adds	r6, r2, r1
   6b222: 1c58         	adds	r0, r3, #0x1
   6b224: 3102         	adds	r1, #0x2
   6b226: f8b6 6242    	ldrh.w	r6, [r6, #0x242]
   6b22a: 42ae         	cmp	r6, r5
   6b22c: 461e         	mov	r6, r3
   6b22e: 4603         	mov	r3, r0
   6b230: d9f4         	bls	0x6b21c <check_error+0x4b94> @ imm = #-0x18
   6b232: 9e52         	ldr	r6, [sp, #0x148]
   6b234: 2c00         	cmp	r4, #0x0
   6b236: f43f adf0    	beq.w	0x6ae1a <check_error+0x4792> @ imm = #-0x420
   6b23a: ebae 00cc    	sub.w	r0, lr, r12, lsl #3
   6b23e: f642 2168    	movw	r1, #0x2a68
   6b242: 4401         	add	r1, r0
   6b244: eb0e 00c4    	add.w	r0, lr, r4, lsl #3
   6b248: f249 62d0    	movw	r2, #0x96d0
   6b24c: 4410         	add	r0, r2
   6b24e: 2200         	movs	r2, #0x0
   6b250: 4663         	mov	r3, r12
   6b252: edd0 0b00    	vldr	d16, [r0]
   6b256: 983d         	ldr	r0, [sp, #0xf4]
   6b258: f500 60b8    	add.w	r0, r0, #0x5c0
   6b25c: edd0 1b00    	vldr	d17, [r0]
   6b260: ee60 0ba1    	vmul.f64	d16, d16, d17
   6b264: 2b00         	cmp	r3, #0x0
   6b266: d044         	beq	0x6b2f2 <check_error+0x4c6a> @ imm = #0x88
   6b268: ecf1 1b02    	vldmia	r1!, {d17}
   6b26c: eef4 1b60    	vcmp.f64	d17, d16
   6b270: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b274: bf98         	it	ls
   6b276: 3201         	addls	r2, #0x1
   6b278: 3b01         	subs	r3, #0x1
   6b27a: e7f3         	b	0x6b264 <check_error+0x4bdc> @ imm = #-0x1a
   6b27c: 9a5c         	ldr	r2, [sp, #0x170]
   6b27e: f240 1321    	movw	r3, #0x121
   6b282: f64b 4478    	movw	r4, #0xbc78
   6b286: b292         	uxth	r2, r2
   6b288: 1a9b         	subs	r3, r3, r2
   6b28a: ebae 02c2    	sub.w	r2, lr, r2, lsl #3
   6b28e: 4414         	add	r4, r2
   6b290: 9a56         	ldr	r2, [sp, #0x158]
   6b292: b295         	uxth	r5, r2
   6b294: f506 62bb    	add.w	r2, r6, #0x5d8
   6b298: edd2 0b00    	vldr	d16, [r2]
   6b29c: 2200         	movs	r2, #0x0
   6b29e: b175         	cbz	r5, 0x6b2be <check_error+0x4c36> @ imm = #0x1c
   6b2a0: 085e         	lsrs	r6, r3, #0x1
   6b2a2: 2e90         	cmp	r6, #0x90
   6b2a4: d807         	bhi	0x6b2b6 <check_error+0x4c2e> @ imm = #0xe
   6b2a6: edd4 1b00    	vldr	d17, [r4]
   6b2aa: eef4 1b60    	vcmp.f64	d17, d16
   6b2ae: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b2b2: bf48         	it	mi
   6b2b4: 3201         	addmi	r2, #0x1
   6b2b6: 3d01         	subs	r5, #0x1
   6b2b8: 3301         	adds	r3, #0x1
   6b2ba: 3408         	adds	r4, #0x8
   6b2bc: e7ef         	b	0x6b29e <check_error+0x4c16> @ imm = #-0x22
   6b2be: 9e52         	ldr	r6, [sp, #0x148]
   6b2c0: b289         	uxth	r1, r1
   6b2c2: 4281         	cmp	r1, r0
   6b2c4: d108         	bne	0x6b2d8 <check_error+0x4c50> @ imm = #0x10
   6b2c6: 983d         	ldr	r0, [sp, #0xf4]
   6b2c8: b291         	uxth	r1, r2
   6b2ca: f8b0 05e0    	ldrh.w	r0, [r0, #0x5e0]
   6b2ce: 4281         	cmp	r1, r0
   6b2d0: bf3c         	itt	lo
   6b2d2: 2001         	movlo	r0, #0x1
   6b2d4: f886 088a    	strblo.w	r0, [r6, #0x88a]
   6b2d8: 9a60         	ldr	r2, [sp, #0x180]
   6b2da: 4d0d         	ldr	r5, [pc, #0x34]         @ 0x6b310 <check_error+0x4c88>
   6b2dc: b290         	uxth	r0, r2
   6b2de: f5b0 7f90    	cmp.w	r0, #0x120
   6b2e2: bf88         	it	hi
   6b2e4: f240 1221    	movwhi	r2, #0x121
   6b2e8: 9855         	ldr	r0, [sp, #0x154]
   6b2ea: 2800         	cmp	r0, #0x0
   6b2ec: f47f ad8a    	bne.w	0x6ae04 <check_error+0x477c> @ imm = #-0x4ec
   6b2f0: e593         	b	0x6ae1a <check_error+0x4792> @ imm = #-0x4da
   6b2f2: b290         	uxth	r0, r2
   6b2f4: 4560         	cmp	r0, r12
   6b2f6: bf04         	itt	eq
   6b2f8: 2001         	moveq	r0, #0x1
   6b2fa: f886 088b    	strbeq.w	r0, [r6, #0x88b]
   6b2fe: e58c         	b	0x6ae1a <check_error+0x4792> @ imm = #-0x4e8
   6b300: 9835         	ldr	r0, [sp, #0xd4]
   6b302: eeb0 ab49    	vmov.f64	d10, d9
   6b306: ed80 9b0c    	vstr	d9, [r0, #48]
   6b30a: f7ff b9e6    	b.w	0x6a6da <check_error+0x4052> @ imm = #-0xc34
   6b30e: bf00         	nop
   6b310: 3e f9 ff ff  	.word	0xfffff93e
   6b314: 96 80 00 00  	.word	0x00008096
   6b318: ee00 4a10    	vmov	s0, r4
   6b31c: f508 60b5    	add.w	r0, r8, #0x5a8
   6b320: eef1 1b04    	vmov.f64	d17, #5.000000e+00
   6b324: eef8 0b40    	vcvt.f64.u32	d16, s0
   6b328: eef2 2b04    	vmov.f64	d18, #1.000000e+01
   6b32c: ed90 0a00    	vldr	s0, [r0]
   6b330: f608 0074    	addw	r0, r8, #0x874
   6b334: ee40 2ba1    	vmla.f64	d18, d16, d17
   6b338: eef8 0b40    	vcvt.f64.u32	d16, s0
   6b33c: ed90 0a00    	vldr	s0, [r0]
   6b340: eef8 1b40    	vcvt.f64.u32	d17, s0
   6b344: ee71 0be0    	vsub.f64	d16, d17, d16
   6b348: eec0 0b8f    	vdiv.f64	d16, d16, d15
   6b34c: eef4 0b62    	vcmp.f64	d16, d18
   6b350: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b354: dd06         	ble	0x6b364 <check_error+0x4cdc> @ imm = #0xc
   6b356: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6b35a: f7fe b8d2    	b.w	0x69502 <check_error+0x2e7a> @ imm = #-0x1e5c
   6b35e: 2000         	movs	r0, #0x0
   6b360: f7fd bced    	b.w	0x68d3e <check_error+0x26b6> @ imm = #-0x2626
   6b364: edcd 5b60    	vstr	d21, [sp, #384]
   6b368: 21b4         	movs	r1, #0xb4
   6b36a: edcd 4b5c    	vstr	d20, [sp, #368]
   6b36e: edcd 3b5e    	vstr	d19, [sp, #376]
   6b372: a80e         	add	r0, sp, #0x38
   6b374: f500 501c    	add.w	r0, r0, #0x2700
   6b378: f003 ee42    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3c84
   6b37c: a80a         	add	r0, sp, #0x28
   6b37e: f44f 7134    	mov.w	r1, #0x2d0
   6b382: f500 5011    	add.w	r0, r0, #0x2440
   6b386: f003 ee3c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3c78
   6b38a: f50d 500c    	add.w	r0, sp, #0x2300
   6b38e: f04f 0800    	mov.w	r8, #0x0
   6b392: 3004         	adds	r0, #0x4
   6b394: f44f 71b2    	mov.w	r1, #0x164
   6b398: f8ad 8196    	strh.w	r8, [sp, #0x196]
   6b39c: f003 eea0    	blx	0x6f0e0 <sincos+0x6f0e0> @ imm = #0x3d40
   6b3a0: a80c         	add	r0, sp, #0x30
   6b3a2: f44f 7134    	mov.w	r1, #0x2d0
   6b3a6: f500 5000    	add.w	r0, r0, #0x2000
   6b3aa: f003 ee2a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3c54
   6b3ae: a802         	add	r0, sp, #0x8
   6b3b0: f44f 71b4    	mov.w	r1, #0x168
   6b3b4: f500 50f6    	add.w	r0, r0, #0x1ec0
   6b3b8: f003 ee22    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3c44
   6b3bc: a80c         	add	r0, sp, #0x30
   6b3be: f44f 61c8    	mov.w	r1, #0x640
   6b3c2: f500 501f    	add.w	r0, r0, #0x27c0
   6b3c6: f003 ee1c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3c38
   6b3ca: a80a         	add	r0, sp, #0x28
   6b3cc: f44f 71c8    	mov.w	r1, #0x190
   6b3d0: f500 5067    	add.w	r0, r0, #0x39c0
   6b3d4: f003 ee14    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3c28
   6b3d8: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6b3dc: 2501         	movs	r5, #0x1
   6b3de: f645 3a50    	movw	r10, #0x5b50
   6b3e2: 2db1         	cmp	r5, #0xb1
   6b3e4: dc4e         	bgt	0x6b484 <check_error+0x4dfc> @ imm = #0x9c
   6b3e6: eb0e 00c5    	add.w	r0, lr, r5, lsl #3
   6b3ea: 2101         	movs	r1, #0x1
   6b3ec: 4450         	add	r0, r10
   6b3ee: 4676         	mov	r6, lr
   6b3f0: ed90 ab00    	vldr	d10, [r0]
   6b3f4: ef2a 011a    	vorr	d0, d10, d10
   6b3f8: ed10 1b02    	vldr	d1, [r0, #-8]
   6b3fc: 200a         	movs	r0, #0xa
   6b3fe: f001 fa13    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x1426
   6b402: b308         	cbz	r0, 0x6b448 <check_error+0x4dc0> @ imm = #0x42
   6b404: 1c6c         	adds	r4, r5, #0x1
   6b406: ef2a 011a    	vorr	d0, d10, d10
   6b40a: 2101         	movs	r1, #0x1
   6b40c: eb06 00c4    	add.w	r0, r6, r4, lsl #3
   6b410: 4450         	add	r0, r10
   6b412: ed90 bb00    	vldr	d11, [r0]
   6b416: 200a         	movs	r0, #0xa
   6b418: ef2b 111b    	vorr	d1, d11, d11
   6b41c: f001 fa04    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x1408
   6b420: b1a8         	cbz	r0, 0x6b44e <check_error+0x4dc6> @ imm = #0x2a
   6b422: a90a         	add	r1, sp, #0x28
   6b424: fa1f f088    	uxth.w	r0, r8
   6b428: f501 5167    	add.w	r1, r1, #0x39c0
   6b42c: f108 0801    	add.w	r8, r8, #0x1
   6b430: f821 5010    	strh.w	r5, [r1, r0, lsl #1]
   6b434: a90c         	add	r1, sp, #0x30
   6b436: f501 511f    	add.w	r1, r1, #0x27c0
   6b43a: eb01 00c0    	add.w	r0, r1, r0, lsl #3
   6b43e: ed80 ab00    	vstr	d10, [r0]
   6b442: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6b446: e000         	b	0x6b44a <check_error+0x4dc2> @ imm = #0x0
   6b448: 46b6         	mov	lr, r6
   6b44a: 3501         	adds	r5, #0x1
   6b44c: e7c9         	b	0x6b3e2 <check_error+0x4d5a> @ imm = #-0x6e
   6b44e: ef2a 011a    	vorr	d0, d10, d10
   6b452: 200a         	movs	r0, #0xa
   6b454: ef2b 111b    	vorr	d1, d11, d11
   6b458: 2105         	movs	r1, #0x5
   6b45a: f001 f9e5    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x13ca
   6b45e: 2800         	cmp	r0, #0x0
   6b460: d0ef         	beq	0x6b442 <check_error+0x4dba> @ imm = #-0x22
   6b462: 3502         	adds	r5, #0x2
   6b464: 9853         	ldr	r0, [sp, #0x14c]
   6b466: ef2a 011a    	vorr	d0, d10, d10
   6b46a: 2105         	movs	r1, #0x5
   6b46c: eb00 00c5    	add.w	r0, r0, r5, lsl #3
   6b470: 4450         	add	r0, r10
   6b472: ed90 1b00    	vldr	d1, [r0]
   6b476: 200a         	movs	r0, #0xa
   6b478: f001 f9d6    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x13ac
   6b47c: 2800         	cmp	r0, #0x0
   6b47e: d1e0         	bne	0x6b442 <check_error+0x4dba> @ imm = #-0x40
   6b480: 4625         	mov	r5, r4
   6b482: e7de         	b	0x6b442 <check_error+0x4dba> @ imm = #-0x44
   6b484: fa1f f088    	uxth.w	r0, r8
   6b488: f8dd 809c    	ldr.w	r8, [sp, #0x9c]
   6b48c: 2800         	cmp	r0, #0x0
   6b48e: 9063         	str	r0, [sp, #0x18c]
   6b490: d060         	beq	0x6b554 <check_error+0x4ecc> @ imm = #0xc0
   6b492: f50d 5040    	add.w	r0, sp, #0x3000
   6b496: f8b0 09e8    	ldrh.w	r0, [r0, #0x9e8]
   6b49a: 2803         	cmp	r0, #0x3
   6b49c: d201         	bhs	0x6b4a2 <check_error+0x4e1a> @ imm = #0x2
   6b49e: 2501         	movs	r5, #0x1
   6b4a0: e00b         	b	0x6b4ba <check_error+0x4e32> @ imm = #0x16
   6b4a2: a80a         	add	r0, sp, #0x28
   6b4a4: 9963         	ldr	r1, [sp, #0x18c]
   6b4a6: f500 5067    	add.w	r0, r0, #0x39c0
   6b4aa: 2502         	movs	r5, #0x2
   6b4ac: eb00 0041    	add.w	r0, r0, r1, lsl #1
   6b4b0: f830 0c02    	ldrh	r0, [r0, #-2]
   6b4b4: 28b1         	cmp	r0, #0xb1
   6b4b6: bf88         	it	hi
   6b4b8: 2501         	movhi	r5, #0x1
   6b4ba: f645 3058    	movw	r0, #0x5b58
   6b4be: 2600         	movs	r6, #0x0
   6b4c0: 4470         	add	r0, lr
   6b4c2: 9062         	str	r0, [sp, #0x188]
   6b4c4: 9863         	ldr	r0, [sp, #0x18c]
   6b4c6: 4286         	cmp	r6, r0
   6b4c8: d041         	beq	0x6b54e <check_error+0x4ec6> @ imm = #0x82
   6b4ca: a80a         	add	r0, sp, #0x28
   6b4cc: f645 3150    	movw	r1, #0x5b50
   6b4d0: f500 5067    	add.w	r0, r0, #0x39c0
   6b4d4: f830 0016    	ldrh.w	r0, [r0, r6, lsl #1]
   6b4d8: eb05 0900    	add.w	r9, r5, r0
   6b4dc: f1b9 0fb3    	cmp.w	r9, #0xb3
   6b4e0: bf28         	it	hs
   6b4e2: f04f 09b3    	movhs.w	r9, #0xb3
   6b4e6: 1b40         	subs	r0, r0, r5
   6b4e8: ea20 74e0    	bic.w	r4, r0, r0, asr #31
   6b4ec: 9862         	ldr	r0, [sp, #0x188]
   6b4ee: eb00 0ac4    	add.w	r10, r0, r4, lsl #3
   6b4f2: eb0e 00c4    	add.w	r0, lr, r4, lsl #3
   6b4f6: 4408         	add	r0, r1
   6b4f8: 46a0         	mov	r8, r4
   6b4fa: ed90 ab00    	vldr	d10, [r0]
   6b4fe: 45c8         	cmp	r8, r9
   6b500: d215         	bhs	0x6b52e <check_error+0x4ea6> @ imm = #0x2a
   6b502: ecba bb02    	vldmia	r10!, {d11}
   6b506: ef2a 111a    	vorr	d1, d10, d10
   6b50a: 200a         	movs	r0, #0xa
   6b50c: 2101         	movs	r1, #0x1
   6b50e: f108 0801    	add.w	r8, r8, #0x1
   6b512: eeb0 0b4b    	vmov.f64	d0, d11
   6b516: f001 f987    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x130e
   6b51a: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6b51e: 2800         	cmp	r0, #0x0
   6b520: bf14         	ite	ne
   6b522: 4644         	movne	r4, r8
   6b524: eeb0 bb4a    	vmoveq.f64	d11, d10
   6b528: ef2b a11b    	vorr	d10, d11, d11
   6b52c: e7e7         	b	0x6b4fe <check_error+0x4e76> @ imm = #-0x32
   6b52e: a80a         	add	r0, sp, #0x28
   6b530: f500 5067    	add.w	r0, r0, #0x39c0
   6b534: f820 4016    	strh.w	r4, [r0, r6, lsl #1]
   6b538: a80c         	add	r0, sp, #0x30
   6b53a: f500 501f    	add.w	r0, r0, #0x27c0
   6b53e: eb00 00c6    	add.w	r0, r0, r6, lsl #3
   6b542: 3601         	adds	r6, #0x1
   6b544: f8dd 809c    	ldr.w	r8, [sp, #0x9c]
   6b548: ed80 ab00    	vstr	d10, [r0]
   6b54c: e7ba         	b	0x6b4c4 <check_error+0x4e3c> @ imm = #-0x8c
   6b54e: 9863         	ldr	r0, [sp, #0x18c]
   6b550: 2802         	cmp	r0, #0x2
   6b552: d202         	bhs	0x6b55a <check_error+0x4ed2> @ imm = #0x4
   6b554: 9e52         	ldr	r6, [sp, #0x148]
   6b556: f7fd bfd4    	b.w	0x69502 <check_error+0x2e7a> @ imm = #-0x2058
   6b55a: aa0c         	add	r2, sp, #0x30
   6b55c: 2000         	movs	r0, #0x0
   6b55e: f502 5800    	add.w	r8, r2, #0x2000
   6b562: 2100         	movs	r1, #0x0
   6b564: 9a63         	ldr	r2, [sp, #0x18c]
   6b566: 4291         	cmp	r1, r2
   6b568: d023         	beq	0x6b5b2 <check_error+0x4f2a> @ imm = #0x46
   6b56a: aa0a         	add	r2, sp, #0x28
   6b56c: f502 5267    	add.w	r2, r2, #0x39c0
   6b570: f832 3011    	ldrh.w	r3, [r2, r1, lsl #1]
   6b574: ac0e         	add	r4, sp, #0x38
   6b576: b282         	uxth	r2, r0
   6b578: f504 541c    	add.w	r4, r4, #0x2700
   6b57c: 4615         	mov	r5, r2
   6b57e: b12d         	cbz	r5, 0x6b58c <check_error+0x4f04> @ imm = #0xa
   6b580: f834 6b02    	ldrh	r6, [r4], #2
   6b584: 3d01         	subs	r5, #0x1
   6b586: 42b3         	cmp	r3, r6
   6b588: d1f9         	bne	0x6b57e <check_error+0x4ef6> @ imm = #-0xe
   6b58a: e010         	b	0x6b5ae <check_error+0x4f26> @ imm = #0x20
   6b58c: ac0e         	add	r4, sp, #0x38
   6b58e: 3001         	adds	r0, #0x1
   6b590: f504 541c    	add.w	r4, r4, #0x2700
   6b594: f824 3012    	strh.w	r3, [r4, r2, lsl #1]
   6b598: ab0c         	add	r3, sp, #0x30
   6b59a: f503 531f    	add.w	r3, r3, #0x27c0
   6b59e: eb03 03c1    	add.w	r3, r3, r1, lsl #3
   6b5a2: eb08 02c2    	add.w	r2, r8, r2, lsl #3
   6b5a6: edd3 0b00    	vldr	d16, [r3]
   6b5aa: edc2 0b00    	vstr	d16, [r2]
   6b5ae: 3101         	adds	r1, #0x1
   6b5b0: e7d8         	b	0x6b564 <check_error+0x4edc> @ imm = #-0x50
   6b5b2: f8ad 0194    	strh.w	r0, [sp, #0x194]
   6b5b6: a902         	add	r1, sp, #0x8
   6b5b8: f501 5cf6    	add.w	r12, r1, #0x1ec0
   6b5bc: a90e         	add	r1, sp, #0x38
   6b5be: b280         	uxth	r0, r0
   6b5c0: f501 561c    	add.w	r6, r1, #0x2700
   6b5c4: f44f 42b1    	mov.w	r2, #0x5880
   6b5c8: 4665         	mov	r5, r12
   6b5ca: 4603         	mov	r3, r0
   6b5cc: 4634         	mov	r4, r6
   6b5ce: b13b         	cbz	r3, 0x6b5e0 <check_error+0x4f58> @ imm = #0xe
   6b5d0: f834 1b02    	ldrh	r1, [r4], #2
   6b5d4: 3b01         	subs	r3, #0x1
   6b5d6: eb0e 0181    	add.w	r1, lr, r1, lsl #2
   6b5da: 5889         	ldr	r1, [r1, r2]
   6b5dc: c502         	stm	r5!, {r1}
   6b5de: e7f6         	b	0x6b5ce <check_error+0x4f46> @ imm = #-0x14
   6b5e0: a902         	add	r1, sp, #0x8
   6b5e2: 1e45         	subs	r5, r0, #0x1
   6b5e4: f501 53f6    	add.w	r3, r1, #0x1ec0
   6b5e8: f50d 510c    	add.w	r1, sp, #0x2300
   6b5ec: f108 0908    	add.w	r9, r8, #0x8
   6b5f0: 2000         	movs	r0, #0x0
   6b5f2: edd3 0b5a    	vldr	d16, [r3, #360]
   6b5f6: f04f 0a01    	mov.w	r10, #0x1
   6b5fa: 681a         	ldr	r2, [r3]
   6b5fc: 600a         	str	r2, [r1]
   6b5fe: edc1 0b5a    	vstr	d16, [r1, #360]
   6b602: f10c 0104    	add.w	r1, r12, #0x4
   6b606: 9163         	str	r1, [sp, #0x18c]
   6b608: eb09 04c0    	add.w	r4, r9, r0, lsl #3
   6b60c: 42a8         	cmp	r0, r5
   6b60e: da3f         	bge	0x6b690 <check_error+0x5008> @ imm = #0x7e
   6b610: ed94 ab00    	vldr	d10, [r4]
   6b614: 4680         	mov	r8, r0
   6b616: eeb0 1b48    	vmov.f64	d1, d8
   6b61a: ee3a 0b60    	vsub.f64	d0, d10, d16
   6b61e: eeb5 0b40    	vcmp.f64	d0, #0
   6b622: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b626: eef1 0b40    	vneg.f64	d16, d0
   6b62a: bf48         	it	mi
   6b62c: eeb0 0b60    	vmovmi.f64	d0, d16
   6b630: 200a         	movs	r0, #0xa
   6b632: 2102         	movs	r1, #0x2
   6b634: f001 f8f8    	bl	0x6c828 <fun_comp_decimals> @ imm = #0x11f0
   6b638: b198         	cbz	r0, 0x6b662 <check_error+0x4fda> @ imm = #0x26
   6b63a: eb06 0148    	add.w	r1, r6, r8, lsl #1
   6b63e: f836 0018    	ldrh.w	r0, [r6, r8, lsl #1]
   6b642: 3408         	adds	r4, #0x8
   6b644: 8849         	ldrh	r1, [r1, #0x2]
   6b646: 1a08         	subs	r0, r1, r0
   6b648: ee00 0a10    	vmov	s0, r0
   6b64c: f108 0001    	add.w	r0, r8, #0x1
   6b650: eef8 0bc0    	vcvt.f64.s32	d16, s0
   6b654: eeb4 cb60    	vcmp.f64	d12, d16
   6b658: eef0 0b4a    	vmov.f64	d16, d10
   6b65c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b660: dcd4         	bgt	0x6b60c <check_error+0x4f84> @ imm = #-0x58
   6b662: 9863         	ldr	r0, [sp, #0x18c]
   6b664: f50d 520c    	add.w	r2, sp, #0x2300
   6b668: fa1f f18a    	uxth.w	r1, r10
   6b66c: f10a 0a01    	add.w	r10, r10, #0x1
   6b670: eef0 0b4a    	vmov.f64	d16, d10
   6b674: f850 0028    	ldr.w	r0, [r0, r8, lsl #2]
   6b678: f842 0021    	str.w	r0, [r2, r1, lsl #2]
   6b67c: a80a         	add	r0, sp, #0x28
   6b67e: f500 5011    	add.w	r0, r0, #0x2440
   6b682: eb00 00c1    	add.w	r0, r0, r1, lsl #3
   6b686: ed80 ab00    	vstr	d10, [r0]
   6b68a: f108 0001    	add.w	r0, r8, #0x1
   6b68e: e7bb         	b	0x6b608 <check_error+0x4f80> @ imm = #-0x8a
   6b690: 9e52         	ldr	r6, [sp, #0x148]
   6b692: fa1f f08a    	uxth.w	r0, r10
   6b696: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6b69a: 2802         	cmp	r0, #0x2
   6b69c: 4ccb         	ldr	r4, [pc, #0x32c]        @ 0x6b9cc <check_error+0x5344>
   6b69e: f8dd 809c    	ldr.w	r8, [sp, #0x9c]
   6b6a2: f886 a7f3    	strb.w	r10, [r6, #0x7f3]
   6b6a6: f8ad a196    	strh.w	r10, [sp, #0x196]
   6b6aa: f4fd af2a    	blo.w	0x69502 <check_error+0x2e7a> @ imm = #-0x21ac
   6b6ae: a80a         	add	r0, sp, #0x28
   6b6b0: f50d 7acb    	add.w	r10, sp, #0x196
   6b6b4: f500 5811    	add.w	r8, r0, #0x2440
   6b6b8: f50d 500c    	add.w	r0, sp, #0x2300
   6b6bc: f8cd 8000    	str.w	r8, [sp]
   6b6c0: e9cd 0a01    	strd	r0, r10, [sp, #4]
   6b6c4: a80e         	add	r0, sp, #0x38
   6b6c6: a90c         	add	r1, sp, #0x30
   6b6c8: f500 501c    	add.w	r0, r0, #0x2700
   6b6cc: f501 5900    	add.w	r9, r1, #0x2000
   6b6d0: a902         	add	r1, sp, #0x8
   6b6d2: f501 5bf6    	add.w	r11, r1, #0x1ec0
   6b6d6: ab65         	add	r3, sp, #0x194
   6b6d8: 4649         	mov	r1, r9
   6b6da: 465a         	mov	r2, r11
   6b6dc: f003 f98e    	bl	0x6e9fc <err1_TD_var_update> @ imm = #0x331c
   6b6e0: a802         	add	r0, sp, #0x8
   6b6e2: f44f 61b3    	mov.w	r1, #0x598
   6b6e6: f500 50c9    	add.w	r0, r0, #0x1920
   6b6ea: f100 0608    	add.w	r6, r0, #0x8
   6b6ee: 4630         	mov	r0, r6
   6b6f0: f003 ec86    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x390c
   6b6f4: f50d 51a2    	add.w	r1, sp, #0x1440
   6b6f8: 2000         	movs	r0, #0x0
   6b6fa: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6b6fe: f8c1 04e8    	str.w	r0, [r1, #0x4e8]
   6b702: f8c1 44ec    	str.w	r4, [r1, #0x4ec]
   6b706: f645 3158    	movw	r1, #0x5b58
   6b70a: 4471         	add	r1, lr
   6b70c: f5b0 6fb3    	cmp.w	r0, #0x598
   6b710: d013         	beq	0x6b73a <check_error+0x50b2> @ imm = #0x26
   6b712: ed51 0b02    	vldr	d16, [r1, #-8]
   6b716: 1832         	adds	r2, r6, r0
   6b718: ecf1 1b02    	vldmia	r1!, {d17}
   6b71c: ee71 0be0    	vsub.f64	d16, d17, d16
   6b720: eef5 0b40    	vcmp.f64	d16, #0
   6b724: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b728: eef1 1b60    	vneg.f64	d17, d16
   6b72c: bf48         	it	mi
   6b72e: eef0 0b61    	vmovmi.f64	d16, d17
   6b732: 3008         	adds	r0, #0x8
   6b734: edc2 0b00    	vstr	d16, [r2]
   6b738: e7e8         	b	0x6b70c <check_error+0x5084> @ imm = #-0x30
   6b73a: f8bd 0194    	ldrh.w	r0, [sp, #0x194]
   6b73e: f50e 44b1    	add.w	r4, lr, #0x5880
   6b742: 9e52         	ldr	r6, [sp, #0x148]
   6b744: aa02         	add	r2, sp, #0x8
   6b746: f502 5cc9    	add.w	r12, r2, #0x1920
   6b74a: 2100         	movs	r1, #0x0
   6b74c: 4281         	cmp	r1, r0
   6b74e: d011         	beq	0x6b774 <check_error+0x50ec> @ imm = #0x22
   6b750: f85b 3021    	ldr.w	r3, [r11, r1, lsl #2]
   6b754: 2200         	movs	r2, #0x0
   6b756: 2ab4         	cmp	r2, #0xb4
   6b758: d00a         	beq	0x6b770 <check_error+0x50e8> @ imm = #0x14
   6b75a: f854 5022    	ldr.w	r5, [r4, r2, lsl #2]
   6b75e: 429d         	cmp	r5, r3
   6b760: d001         	beq	0x6b766 <check_error+0x50de> @ imm = #0x2
   6b762: 3201         	adds	r2, #0x1
   6b764: e7f7         	b	0x6b756 <check_error+0x50ce> @ imm = #-0x12
   6b766: ab0e         	add	r3, sp, #0x38
   6b768: f503 531c    	add.w	r3, r3, #0x2700
   6b76c: f823 2011    	strh.w	r2, [r3, r1, lsl #1]
   6b770: 3101         	adds	r1, #0x1
   6b772: e7eb         	b	0x6b74c <check_error+0x50c4> @ imm = #-0x2a
   6b774: f8bd 1196    	ldrh.w	r1, [sp, #0x196]
   6b778: 2200         	movs	r2, #0x0
   6b77a: 4282         	cmp	r2, r0
   6b77c: d031         	beq	0x6b7e2 <check_error+0x515a> @ imm = #0x62
   6b77e: ab0e         	add	r3, sp, #0x38
   6b780: f503 531c    	add.w	r3, r3, #0x2700
   6b784: f833 3012    	ldrh.w	r3, [r3, r2, lsl #1]
   6b788: 2b05         	cmp	r3, #0x5
   6b78a: d317         	blo	0x6b7bc <check_error+0x5134> @ imm = #0x2e
   6b78c: 2bae         	cmp	r3, #0xae
   6b78e: d815         	bhi	0x6b7bc <check_error+0x5134> @ imm = #0x2a
   6b790: eb0c 03c3    	add.w	r3, r12, r3, lsl #3
   6b794: f06f 0627    	mvn	r6, #0x27
   6b798: f106 0508    	add.w	r5, r6, #0x8
   6b79c: 2d38         	cmp	r5, #0x38
   6b79e: d01d         	beq	0x6b7dc <check_error+0x5154> @ imm = #0x3a
   6b7a0: 441e         	add	r6, r3
   6b7a2: edd6 0b00    	vldr	d16, [r6]
   6b7a6: eef4 0b4d    	vcmp.f64	d16, d13
   6b7aa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b7ae: da05         	bge	0x6b7bc <check_error+0x5134> @ imm = #0xa
   6b7b0: eef4 0b60    	vcmp.f64	d16, d16
   6b7b4: 462e         	mov	r6, r5
   6b7b6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6b7ba: d7ed         	bvc	0x6b798 <check_error+0x5110> @ imm = #-0x26
   6b7bc: b28d         	uxth	r5, r1
   6b7be: f85b 3022    	ldr.w	r3, [r11, r2, lsl #2]
   6b7c2: f50d 560c    	add.w	r6, sp, #0x2300
   6b7c6: 3101         	adds	r1, #0x1
   6b7c8: f846 3025    	str.w	r3, [r6, r5, lsl #2]
   6b7cc: eb08 03c5    	add.w	r3, r8, r5, lsl #3
   6b7d0: eb09 05c2    	add.w	r5, r9, r2, lsl #3
   6b7d4: edd5 0b00    	vldr	d16, [r5]
   6b7d8: edc3 0b00    	vstr	d16, [r3]
   6b7dc: 3201         	adds	r2, #0x1
   6b7de: 9e52         	ldr	r6, [sp, #0x148]
   6b7e0: e7cb         	b	0x6b77a <check_error+0x50f2> @ imm = #-0x6a
   6b7e2: b288         	uxth	r0, r1
   6b7e4: f886 17f4    	strb.w	r1, [r6, #0x7f4]
   6b7e8: 2802         	cmp	r0, #0x2
   6b7ea: f8ad 1196    	strh.w	r1, [sp, #0x196]
   6b7ee: f0c0 86e5    	blo.w	0x6c5bc <check_error+0x5f34> @ imm = #0xdca
   6b7f2: f50d 500c    	add.w	r0, sp, #0x2300
   6b7f6: f8cd 8000    	str.w	r8, [sp]
   6b7fa: e9cd 0a01    	strd	r0, r10, [sp, #4]
   6b7fe: a80c         	add	r0, sp, #0x30
   6b800: f500 5100    	add.w	r1, r0, #0x2000
   6b804: ab65         	add	r3, sp, #0x194
   6b806: a80e         	add	r0, sp, #0x38
   6b808: 465a         	mov	r2, r11
   6b80a: f500 501c    	add.w	r0, r0, #0x2700
   6b80e: f003 f8f5    	bl	0x6e9fc <err1_TD_var_update> @ imm = #0x31ea
   6b812: f8bd 0194    	ldrh.w	r0, [sp, #0x194]
   6b816: 2600         	movs	r6, #0x0
   6b818: 2100         	movs	r1, #0x0
   6b81a: 4281         	cmp	r1, r0
   6b81c: d013         	beq	0x6b846 <check_error+0x51be> @ imm = #0x26
   6b81e: f85b 3021    	ldr.w	r3, [r11, r1, lsl #2]
   6b822: 2200         	movs	r2, #0x0
   6b824: 2ab4         	cmp	r2, #0xb4
   6b826: d00c         	beq	0x6b842 <check_error+0x51ba> @ imm = #0x18
   6b828: f854 5022    	ldr.w	r5, [r4, r2, lsl #2]
   6b82c: 429d         	cmp	r5, r3
   6b82e: d001         	beq	0x6b834 <check_error+0x51ac> @ imm = #0x2
   6b830: 3201         	adds	r2, #0x1
   6b832: e7f7         	b	0x6b824 <check_error+0x519c> @ imm = #-0x12
   6b834: ad0e         	add	r5, sp, #0x38
   6b836: b2f3         	uxtb	r3, r6
   6b838: f505 551c    	add.w	r5, r5, #0x2700
   6b83c: 3601         	adds	r6, #0x1
   6b83e: f825 2013    	strh.w	r2, [r5, r3, lsl #1]
   6b842: 3101         	adds	r1, #0x1
   6b844: e7e9         	b	0x6b81a <check_error+0x5192> @ imm = #-0x2e
   6b846: a804         	add	r0, sp, #0x10
   6b848: 21b4         	movs	r1, #0xb4
   6b84a: f500 50c3    	add.w	r0, r0, #0x1860
   6b84e: f003 ebd8    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x37b0
   6b852: f04f 30ff    	mov.w	r0, #0xffffffff
   6b856: 9953         	ldr	r1, [sp, #0x14c]
   6b858: fa50 f886    	uxtab	r8, r0, r6
   6b85c: b2f0         	uxtb	r0, r6
   6b85e: 2802         	cmp	r0, #0x2
   6b860: d35f         	blo	0x6b922 <check_error+0x529a> @ imm = #0xbe
   6b862: f645 3050    	movw	r0, #0x5b50
   6b866: f04f 0b00    	mov.w	r11, #0x0
   6b86a: 4408         	add	r0, r1
   6b86c: 9062         	str	r0, [sp, #0x188]
   6b86e: f8cd 818c    	str.w	r8, [sp, #0x18c]
   6b872: 45c3         	cmp	r11, r8
   6b874: d037         	beq	0x6b8e6 <check_error+0x525e> @ imm = #0x6e
   6b876: a80e         	add	r0, sp, #0x38
   6b878: f10b 0901    	add.w	r9, r11, #0x1
   6b87c: f500 501c    	add.w	r0, r0, #0x2700
   6b880: f645 3250    	movw	r2, #0x5b50
   6b884: 2400         	movs	r4, #0x0
   6b886: 2500         	movs	r5, #0x0
   6b888: f830 a01b    	ldrh.w	r10, [r0, r11, lsl #1]
   6b88c: f830 0019    	ldrh.w	r0, [r0, r9, lsl #1]
   6b890: eba0 060a    	sub.w	r6, r0, r10
   6b894: 9862         	ldr	r0, [sp, #0x188]
   6b896: eb00 08ca    	add.w	r8, r0, r10, lsl #3
   6b89a: eb01 00ca    	add.w	r0, r1, r10, lsl #3
   6b89e: 4410         	add	r0, r2
   6b8a0: ed90 ab00    	vldr	d10, [r0]
   6b8a4: 42b5         	cmp	r5, r6
   6b8a6: dc13         	bgt	0x6b8d0 <check_error+0x5248> @ imm = #0x26
   6b8a8: ecb8 bb02    	vldmia	r8!, {d11}
   6b8ac: ef2a 111a    	vorr	d1, d10, d10
   6b8b0: 200a         	movs	r0, #0xa
   6b8b2: 2102         	movs	r1, #0x2
   6b8b4: eeb0 0b4b    	vmov.f64	d0, d11
   6b8b8: f000 ffb6    	bl	0x6c828 <fun_comp_decimals> @ imm = #0xf6c
   6b8bc: 2800         	cmp	r0, #0x0
   6b8be: 9953         	ldr	r1, [sp, #0x14c]
   6b8c0: bf14         	ite	ne
   6b8c2: 462c         	movne	r4, r5
   6b8c4: eeb0 bb4a    	vmoveq.f64	d11, d10
   6b8c8: 3501         	adds	r5, #0x1
   6b8ca: ef2b a11b    	vorr	d10, d11, d11
   6b8ce: e7e9         	b	0x6b8a4 <check_error+0x521c> @ imm = #-0x2e
   6b8d0: aa04         	add	r2, sp, #0x10
   6b8d2: fa5a f084    	uxtab	r0, r10, r4
   6b8d6: f502 52c3    	add.w	r2, r2, #0x1860
   6b8da: f8dd 818c    	ldr.w	r8, [sp, #0x18c]
   6b8de: f822 001b    	strh.w	r0, [r2, r11, lsl #1]
   6b8e2: 46cb         	mov	r11, r9
   6b8e4: e7c5         	b	0x6b872 <check_error+0x51ea> @ imm = #-0x76
   6b8e6: a80a         	add	r0, sp, #0x28
   6b8e8: aa04         	add	r2, sp, #0x10
   6b8ea: f500 5011    	add.w	r0, r0, #0x2440
   6b8ee: f50d 540c    	add.w	r4, sp, #0x2300
   6b8f2: f502 52c3    	add.w	r2, r2, #0x1860
   6b8f6: f645 3c50    	movw	r12, #0x5b50
   6b8fa: f44f 4eb1    	mov.w	lr, #0x5880
   6b8fe: 4645         	mov	r5, r8
   6b900: b17d         	cbz	r5, 0x6b922 <check_error+0x529a> @ imm = #0x1e
   6b902: f832 6b02    	ldrh	r6, [r2], #2
   6b906: 3d01         	subs	r5, #0x1
   6b908: eb01 03c6    	add.w	r3, r1, r6, lsl #3
   6b90c: 4463         	add	r3, r12
   6b90e: edd3 0b00    	vldr	d16, [r3]
   6b912: eb01 0386    	add.w	r3, r1, r6, lsl #2
   6b916: f853 300e    	ldr.w	r3, [r3, lr]
   6b91a: ece0 0b02    	vstmia	r0!, {d16}
   6b91e: c408         	stm	r4!, {r3}
   6b920: e7ee         	b	0x6b900 <check_error+0x5278> @ imm = #-0x24
   6b922: a806         	add	r0, sp, #0x18
   6b924: f44f 6187    	mov.w	r1, #0x438
   6b928: f500 5aa1    	add.w	r10, r0, #0x1420
   6b92c: 4650         	mov	r0, r10
   6b92e: f003 eb68    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x36d0
   6b932: a80c         	add	r0, sp, #0x30
   6b934: f44f 6107    	mov.w	r1, #0x870
   6b938: f500 501f    	add.w	r0, r0, #0x27c0
   6b93c: f003 eb60    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x36c0
   6b940: f50d 5b80    	add.w	r11, sp, #0x1000
   6b944: f44f 6187    	mov.w	r1, #0x438
   6b948: 4658         	mov	r0, r11
   6b94a: f003 eb5a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x36b4
   6b94e: a80a         	add	r0, sp, #0x28
   6b950: f44f 6107    	mov.w	r1, #0x870
   6b954: f500 5467    	add.w	r4, r0, #0x39c0
   6b958: 4620         	mov	r0, r4
   6b95a: f003 eb52    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x36a4
   6b95e: a802         	add	r0, sp, #0x8
   6b960: f104 0910    	add.w	r9, r4, #0x10
   6b964: f500 50f6    	add.w	r0, r0, #0x1ec0
   6b968: f10b 0208    	add.w	r2, r11, #0x8
   6b96c: f100 0c04    	add.w	r12, r0, #0x4
   6b970: a80c         	add	r0, sp, #0x30
   6b972: f500 5000    	add.w	r0, r0, #0x2000
   6b976: 2500         	movs	r5, #0x0
   6b978: f100 0108    	add.w	r1, r0, #0x8
   6b97c: a80a         	add	r0, sp, #0x28
   6b97e: f500 5e11    	add.w	lr, r0, #0x2440
   6b982: 464e         	mov	r6, r9
   6b984: 2400         	movs	r4, #0x0
   6b986: 4544         	cmp	r4, r8
   6b988: da26         	bge	0x6b9d8 <check_error+0x5350> @ imm = #0x4c
   6b98a: a802         	add	r0, sp, #0x8
   6b98c: eb05 0345    	add.w	r3, r5, r5, lsl #1
   6b990: f500 50f6    	add.w	r0, r0, #0x1ec0
   6b994: 445b         	add	r3, r11
   6b996: ed51 0b02    	vldr	d16, [r1, #-8]
   6b99a: 3401         	adds	r4, #0x1
   6b99c: 5940         	ldr	r0, [r0, r5]
   6b99e: f842 0c08    	str	r0, [r2, #-8]
   6b9a2: f50d 500c    	add.w	r0, sp, #0x2300
   6b9a6: ecf1 1b02    	vldmia	r1!, {d17}
   6b9aa: 5940         	ldr	r0, [r0, r5]
   6b9ac: ecfe 2b02    	vldmia	lr!, {d18}
   6b9b0: 6058         	str	r0, [r3, #0x4]
   6b9b2: f85c 0005    	ldr.w	r0, [r12, r5]
   6b9b6: 3504         	adds	r5, #0x4
   6b9b8: ed46 0b04    	vstr	d16, [r6, #-16]
   6b9bc: ed46 2b02    	vstr	d18, [r6, #-8]
   6b9c0: edc6 1b00    	vstr	d17, [r6]
   6b9c4: 3618         	adds	r6, #0x18
   6b9c6: f842 0b0c    	str	r0, [r2], #12
   6b9ca: e7dc         	b	0x6b986 <check_error+0x52fe> @ imm = #-0x48
   6b9cc: 00 00 f8 7f  	.word	0x7ff80000
   6b9d0: 7b 14 ae 47  	.word	0x47ae147b
   6b9d4: e1 7a 94 3f  	.word	0x3f947ae1
   6b9d8: ed5f 0b03    	vldr	d16, [pc, #-12]         @ 0x6b9d0 <check_error+0x5348>
   6b9dc: f50d 5180    	add.w	r1, sp, #0x1000
   6b9e0: 9a52         	ldr	r2, [sp, #0x148]
   6b9e2: fa5f fc88    	uxtb.w	r12, r8
   6b9e6: ee69 0b20    	vmul.f64	d16, d9, d16
   6b9ea: 2300         	movs	r3, #0x0
   6b9ec: f882 87f5    	strb.w	r8, [r2, #0x7f5]
   6b9f0: a80a         	add	r0, sp, #0x28
   6b9f2: f500 5b67    	add.w	r11, r0, #0x39c0
   6b9f6: f04f 0800    	mov.w	r8, #0x0
   6b9fa: 46de         	mov	lr, r11
   6b9fc: 4563         	cmp	r3, r12
   6b9fe: d04d         	beq	0x6ba9c <check_error+0x5414> @ imm = #0x9a
   6ba00: eb03 0043    	add.w	r0, r3, r3, lsl #1
   6ba04: eb0b 00c0    	add.w	r0, r11, r0, lsl #3
   6ba08: edd0 1b02    	vldr	d17, [r0, #8]
   6ba0c: edd0 2b04    	vldr	d18, [r0, #16]
   6ba10: ee72 2be1    	vsub.f64	d18, d18, d17
   6ba14: eef5 2b40    	vcmp.f64	d18, #0
   6ba18: eef1 3b62    	vneg.f64	d19, d18
   6ba1c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ba20: bf48         	it	mi
   6ba22: eef0 2b63    	vmovmi.f64	d18, d19
   6ba26: eef4 2b60    	vcmp.f64	d18, d16
   6ba2a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ba2e: d511         	bpl	0x6ba54 <check_error+0x53cc> @ imm = #0x22
   6ba30: edd0 2b00    	vldr	d18, [r0]
   6ba34: ee72 1be1    	vsub.f64	d17, d18, d17
   6ba38: eef5 1b40    	vcmp.f64	d17, #0
   6ba3c: eef1 2b61    	vneg.f64	d18, d17
   6ba40: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ba44: bf48         	it	mi
   6ba46: eef0 1b62    	vmovmi.f64	d17, d18
   6ba4a: eef4 1b60    	vcmp.f64	d17, d16
   6ba4e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ba52: d41e         	bmi	0x6ba92 <check_error+0x540a> @ imm = #0x3c
   6ba54: fa5f f088    	uxtb.w	r0, r8
   6ba58: aa0c         	add	r2, sp, #0x30
   6ba5a: 0040         	lsls	r0, r0, #0x1
   6ba5c: f502 521f    	add.w	r2, r2, #0x27c0
   6ba60: fa50 f088    	uxtab	r0, r0, r8
   6ba64: eb02 06c0    	add.w	r6, r2, r0, lsl #3
   6ba68: eb0a 0580    	add.w	r5, r10, r0, lsl #2
   6ba6c: 2000         	movs	r0, #0x0
   6ba6e: 4672         	mov	r2, lr
   6ba70: 2803         	cmp	r0, #0x3
   6ba72: d009         	beq	0x6ba88 <check_error+0x5400> @ imm = #0x12
   6ba74: f851 4020    	ldr.w	r4, [r1, r0, lsl #2]
   6ba78: ecf2 1b02    	vldmia	r2!, {d17}
   6ba7c: f845 4020    	str.w	r4, [r5, r0, lsl #2]
   6ba80: 3001         	adds	r0, #0x1
   6ba82: ece6 1b02    	vstmia	r6!, {d17}
   6ba86: e7f3         	b	0x6ba70 <check_error+0x53e8> @ imm = #-0x1a
   6ba88: 9a52         	ldr	r2, [sp, #0x148]
   6ba8a: f108 0801    	add.w	r8, r8, #0x1
   6ba8e: f88d 8193    	strb.w	r8, [sp, #0x193]
   6ba92: 310c         	adds	r1, #0xc
   6ba94: f10e 0e18    	add.w	lr, lr, #0x18
   6ba98: 3301         	adds	r3, #0x1
   6ba9a: e7af         	b	0x6b9fc <check_error+0x5374> @ imm = #-0xa2
   6ba9c: f50d 657a    	add.w	r5, sp, #0xfa0
   6baa0: 2600         	movs	r6, #0x0
   6baa2: 215a         	movs	r1, #0x5a
   6baa4: f882 87f6    	strb.w	r8, [r2, #0x7f6]
   6baa8: 4628         	mov	r0, r5
   6baaa: f88d 8192    	strb.w	r8, [sp, #0x192]
   6baae: f88d 6193    	strb.w	r6, [sp, #0x193]
   6bab2: f003 eaa6    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x354c
   6bab6: a90c         	add	r1, sp, #0x30
   6bab8: f04f 30ff    	mov.w	r0, #0xffffffff
   6babc: f501 511f    	add.w	r1, r1, #0x27c0
   6bac0: fa50 f088    	uxtab	r0, r0, r8
   6bac4: 3120         	adds	r1, #0x20
   6bac6: fa5f fb88    	uxtb.w	r11, r8
   6baca: 2200         	movs	r2, #0x0
   6bacc: eb02 0342    	add.w	r3, r2, r2, lsl #1
   6bad0: eb01 03c3    	add.w	r3, r1, r3, lsl #3
   6bad4: 4282         	cmp	r2, r0
   6bad6: da3f         	bge	0x6bb58 <check_error+0x54d0> @ imm = #0x7e
   6bad8: ed53 1b06    	vldr	d17, [r3, #-24]
   6badc: ed53 0b04    	vldr	d16, [r3, #-16]
   6bae0: ee70 1be1    	vsub.f64	d17, d16, d17
   6bae4: eef5 1b40    	vcmp.f64	d17, #0
   6bae8: eef1 2b61    	vneg.f64	d18, d17
   6baec: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6baf0: bf48         	it	mi
   6baf2: eef0 1b62    	vmovmi.f64	d17, d18
   6baf6: eef4 1b48    	vcmp.f64	d17, d8
   6bafa: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bafe: d523         	bpl	0x6bb48 <check_error+0x54c0> @ imm = #0x46
   6bb00: ed53 1b02    	vldr	d17, [r3, #-8]
   6bb04: ee70 0be1    	vsub.f64	d16, d16, d17
   6bb08: eef5 0b40    	vcmp.f64	d16, #0
   6bb0c: eef1 2b60    	vneg.f64	d18, d16
   6bb10: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bb14: bf48         	it	mi
   6bb16: eef0 0b62    	vmovmi.f64	d16, d18
   6bb1a: eef4 0b48    	vcmp.f64	d16, d8
   6bb1e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bb22: d511         	bpl	0x6bb48 <check_error+0x54c0> @ imm = #0x22
   6bb24: edd3 0b00    	vldr	d16, [r3]
   6bb28: ee71 0be0    	vsub.f64	d16, d17, d16
   6bb2c: eef5 0b40    	vcmp.f64	d16, #0
   6bb30: eef1 1b60    	vneg.f64	d17, d16
   6bb34: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bb38: bf48         	it	mi
   6bb3a: eef0 0b61    	vmovmi.f64	d16, d17
   6bb3e: eef4 0b48    	vcmp.f64	d16, d8
   6bb42: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bb46: d402         	bmi	0x6bb4e <check_error+0x54c6> @ imm = #0x4
   6bb48: 3201         	adds	r2, #0x1
   6bb4a: 3318         	adds	r3, #0x18
   6bb4c: e7c2         	b	0x6bad4 <check_error+0x544c> @ imm = #-0x7c
   6bb4e: b2f3         	uxtb	r3, r6
   6bb50: 3601         	adds	r6, #0x1
   6bb52: 54ea         	strb	r2, [r5, r3]
   6bb54: 3201         	adds	r2, #0x1
   6bb56: e7b9         	b	0x6bacc <check_error+0x5444> @ imm = #-0x8e
   6bb58: f50d 6874    	add.w	r8, sp, #0xf40
   6bb5c: 215a         	movs	r1, #0x5a
   6bb5e: f88d 6191    	strb.w	r6, [sp, #0x191]
   6bb62: 4640         	mov	r0, r8
   6bb64: f003 ea4c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3498
   6bb68: b2f0         	uxtb	r0, r6
   6bb6a: f50d 627a    	add.w	r2, sp, #0xfa0
   6bb6e: 2101         	movs	r1, #0x1
   6bb70: 9e52         	ldr	r6, [sp, #0x148]
   6bb72: b1a8         	cbz	r0, 0x6bba0 <check_error+0x5518> @ imm = #0x2a
   6bb74: f812 3b01    	ldrb	r3, [r2], #1
   6bb78: 3801         	subs	r0, #0x1
   6bb7a: f808 1003    	strb.w	r1, [r8, r3]
   6bb7e: eb03 0343    	add.w	r3, r3, r3, lsl #1
   6bb82: eb0a 0483    	add.w	r4, r10, r3, lsl #2
   6bb86: f85a 5023    	ldr.w	r5, [r10, r3, lsl #2]
   6bb8a: 60e5         	str	r5, [r4, #0xc]
   6bb8c: ac0c         	add	r4, sp, #0x30
   6bb8e: f504 541f    	add.w	r4, r4, #0x27c0
   6bb92: eb04 03c3    	add.w	r3, r4, r3, lsl #3
   6bb96: edd3 0b00    	vldr	d16, [r3]
   6bb9a: edc3 0b06    	vstr	d16, [r3, #24]
   6bb9e: e7e8         	b	0x6bb72 <check_error+0x54ea> @ imm = #-0x30
   6bba0: a80c         	add	r0, sp, #0x30
   6bba2: f04f 0c00    	mov.w	r12, #0x0
   6bba6: f500 5e1f    	add.w	lr, r0, #0x27c0
   6bbaa: 4651         	mov	r1, r10
   6bbac: 2300         	movs	r3, #0x0
   6bbae: 455b         	cmp	r3, r11
   6bbb0: d026         	beq	0x6bc00 <check_error+0x5578> @ imm = #0x4c
   6bbb2: f818 2003    	ldrb.w	r2, [r8, r3]
   6bbb6: b9f2         	cbnz	r2, 0x6bbf6 <check_error+0x556e> @ imm = #0x3c
   6bbb8: fa5f f28c    	uxtb.w	r2, r12
   6bbbc: a80c         	add	r0, sp, #0x30
   6bbbe: 0052         	lsls	r2, r2, #0x1
   6bbc0: f500 501f    	add.w	r0, r0, #0x27c0
   6bbc4: fa52 f28c    	uxtab	r2, r2, r12
   6bbc8: 2500         	movs	r5, #0x0
   6bbca: eb0a 0682    	add.w	r6, r10, r2, lsl #2
   6bbce: eb00 04c2    	add.w	r4, r0, r2, lsl #3
   6bbd2: 4672         	mov	r2, lr
   6bbd4: 2d03         	cmp	r5, #0x3
   6bbd6: d009         	beq	0x6bbec <check_error+0x5564> @ imm = #0x12
   6bbd8: f851 0025    	ldr.w	r0, [r1, r5, lsl #2]
   6bbdc: ecf2 0b02    	vldmia	r2!, {d16}
   6bbe0: f846 0025    	str.w	r0, [r6, r5, lsl #2]
   6bbe4: 3501         	adds	r5, #0x1
   6bbe6: ece4 0b02    	vstmia	r4!, {d16}
   6bbea: e7f3         	b	0x6bbd4 <check_error+0x554c> @ imm = #-0x1a
   6bbec: 9e52         	ldr	r6, [sp, #0x148]
   6bbee: f10c 0c01    	add.w	r12, r12, #0x1
   6bbf2: f88d c193    	strb.w	r12, [sp, #0x193]
   6bbf6: 310c         	adds	r1, #0xc
   6bbf8: f10e 0e18    	add.w	lr, lr, #0x18
   6bbfc: 3301         	adds	r3, #0x1
   6bbfe: e7d6         	b	0x6bbae <check_error+0x5526> @ imm = #-0x54
   6bc00: f20d 1193    	addw	r1, sp, #0x193
   6bc04: f20d 1091    	addw	r0, sp, #0x191
   6bc08: f50d 647a    	add.w	r4, sp, #0xfa0
   6bc0c: f886 c7f7    	strb.w	r12, [r6, #0x7f7]
   6bc10: e9cd a100    	strd	r10, r1, [sp]
   6bc14: f50d 5180    	add.w	r1, sp, #0x1000
   6bc18: e9cd 4002    	strd	r4, r0, [sp, #8]
   6bc1c: a80c         	add	r0, sp, #0x30
   6bc1e: f500 531f    	add.w	r3, r0, #0x27c0
   6bc22: a80a         	add	r0, sp, #0x28
   6bc24: f50d 72c9    	add.w	r2, sp, #0x192
   6bc28: f500 5067    	add.w	r0, r0, #0x39c0
   6bc2c: f002 ff0c    	bl	0x6ea48 <err1_TD_trio_update> @ imm = #0x2e18
   6bc30: f89d b192    	ldrb.w	r11, [sp, #0x192]
   6bc34: 2300         	movs	r3, #0x0
   6bc36: f89d c191    	ldrb.w	r12, [sp, #0x191]
   6bc3a: f1ab 0201    	sub.w	r2, r11, #0x1
   6bc3e: 4293         	cmp	r3, r2
   6bc40: da25         	bge	0x6bc8e <check_error+0x5606> @ imm = #0x4a
   6bc42: ed59 1b04    	vldr	d17, [r9, #-16]
   6bc46: ed59 0b02    	vldr	d16, [r9, #-8]
   6bc4a: ee71 1be0    	vsub.f64	d17, d17, d16
   6bc4e: eef4 1b48    	vcmp.f64	d17, d8
   6bc52: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bc56: dd16         	ble	0x6bc86 <check_error+0x55fe> @ imm = #0x2c
   6bc58: edd9 1b00    	vldr	d17, [r9]
   6bc5c: ee71 0be0    	vsub.f64	d16, d17, d16
   6bc60: eef4 0b48    	vcmp.f64	d16, d8
   6bc64: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bc68: d50d         	bpl	0x6bc86 <check_error+0x55fe> @ imm = #0x1a
   6bc6a: edd9 0b02    	vldr	d16, [r9, #8]
   6bc6e: ee70 0be1    	vsub.f64	d16, d16, d17
   6bc72: eef4 0b48    	vcmp.f64	d16, d8
   6bc76: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bc7a: bfc2         	ittt	gt
   6bc7c: fa5f f08c    	uxtbgt.w	r0, r12
   6bc80: 5423         	strbgt	r3, [r4, r0]
   6bc82: f10c 0c01    	addgt.w	r12, r12, #0x1
   6bc86: f109 0918    	add.w	r9, r9, #0x18
   6bc8a: 3301         	adds	r3, #0x1
   6bc8c: e7d7         	b	0x6bc3e <check_error+0x55b6> @ imm = #-0x52
   6bc8e: f88d b193    	strb.w	r11, [sp, #0x193]
   6bc92: f50d 5680    	add.w	r6, sp, #0x1000
   6bc96: f88d c191    	strb.w	r12, [sp, #0x191]
   6bc9a: a80c         	add	r0, sp, #0x30
   6bc9c: f500 581f    	add.w	r8, r0, #0x27c0
   6bca0: a80a         	add	r0, sp, #0x28
   6bca2: a906         	add	r1, sp, #0x18
   6bca4: f500 5067    	add.w	r0, r0, #0x39c0
   6bca8: f501 5aa1    	add.w	r10, r1, #0x1420
   6bcac: 2400         	movs	r4, #0x0
   6bcae: 46c6         	mov	lr, r8
   6bcb0: 4653         	mov	r3, r10
   6bcb2: 455c         	cmp	r4, r11
   6bcb4: d015         	beq	0x6bce2 <check_error+0x565a> @ imm = #0x2a
   6bcb6: 2500         	movs	r5, #0x0
   6bcb8: 4601         	mov	r1, r0
   6bcba: 4672         	mov	r2, lr
   6bcbc: 2d03         	cmp	r5, #0x3
   6bcbe: d009         	beq	0x6bcd4 <check_error+0x564c> @ imm = #0x12
   6bcc0: f856 9025    	ldr.w	r9, [r6, r5, lsl #2]
   6bcc4: ecf1 0b02    	vldmia	r1!, {d16}
   6bcc8: f843 9025    	str.w	r9, [r3, r5, lsl #2]
   6bccc: 3501         	adds	r5, #0x1
   6bcce: ece2 0b02    	vstmia	r2!, {d16}
   6bcd2: e7f3         	b	0x6bcbc <check_error+0x5634> @ imm = #-0x1a
   6bcd4: 360c         	adds	r6, #0xc
   6bcd6: 330c         	adds	r3, #0xc
   6bcd8: 3018         	adds	r0, #0x18
   6bcda: f10e 0e18    	add.w	lr, lr, #0x18
   6bcde: 3401         	adds	r4, #0x1
   6bce0: e7e7         	b	0x6bcb2 <check_error+0x562a> @ imm = #-0x32
   6bce2: f50d 697a    	add.w	r9, sp, #0xfa0
   6bce6: 9e52         	ldr	r6, [sp, #0x148]
   6bce8: fa5f f08c    	uxtb.w	r0, r12
   6bcec: 4649         	mov	r1, r9
   6bcee: b178         	cbz	r0, 0x6bd10 <check_error+0x5688> @ imm = #0x1e
   6bcf0: f811 2b01    	ldrb	r2, [r1], #1
   6bcf4: 3801         	subs	r0, #0x1
   6bcf6: eb02 0242    	add.w	r2, r2, r2, lsl #1
   6bcfa: eb0a 0382    	add.w	r3, r10, r2, lsl #2
   6bcfe: eb08 02c2    	add.w	r2, r8, r2, lsl #3
   6bd02: edd2 0b06    	vldr	d16, [r2, #24]
   6bd06: 68dd         	ldr	r5, [r3, #0xc]
   6bd08: 609d         	str	r5, [r3, #0x8]
   6bd0a: edc2 0b04    	vstr	d16, [r2, #16]
   6bd0e: e7ee         	b	0x6bcee <check_error+0x5666> @ imm = #-0x24
   6bd10: f20d 1093    	addw	r0, sp, #0x193
   6bd14: e9cd 0901    	strd	r0, r9, [sp, #4]
   6bd18: f20d 1091    	addw	r0, sp, #0x191
   6bd1c: f8cd a000    	str.w	r10, [sp]
   6bd20: 9003         	str	r0, [sp, #0xc]
   6bd22: a80c         	add	r0, sp, #0x30
   6bd24: f500 531f    	add.w	r3, r0, #0x27c0
   6bd28: a80a         	add	r0, sp, #0x28
   6bd2a: f500 5567    	add.w	r5, r0, #0x39c0
   6bd2e: f50d 5480    	add.w	r4, sp, #0x1000
   6bd32: f50d 72c9    	add.w	r2, sp, #0x192
   6bd36: 4628         	mov	r0, r5
   6bd38: 4621         	mov	r1, r4
   6bd3a: f002 fe85    	bl	0x6ea48 <err1_TD_trio_update> @ imm = #0x2d0a
   6bd3e: f89d c191    	ldrb.w	r12, [sp, #0x191]
   6bd42: f105 0218    	add.w	r2, r5, #0x18
   6bd46: f89d a192    	ldrb.w	r10, [sp, #0x192]
   6bd4a: f104 0308    	add.w	r3, r4, #0x8
   6bd4e: 2501         	movs	r5, #0x1
   6bd50: 4555         	cmp	r5, r10
   6bd52: d233         	bhs	0x6bdbc <check_error+0x5734> @ imm = #0x66
   6bd54: ed52 0b02    	vldr	d16, [r2, #-8]
   6bd58: edd2 1b00    	vldr	d17, [r2]
   6bd5c: ee70 0be1    	vsub.f64	d16, d16, d17
   6bd60: eef4 0b48    	vcmp.f64	d16, d8
   6bd64: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bd68: dd24         	ble	0x6bdb4 <check_error+0x572c> @ imm = #0x48
   6bd6a: edd2 0b02    	vldr	d16, [r2, #8]
   6bd6e: ee71 1be0    	vsub.f64	d17, d17, d16
   6bd72: eef5 1b40    	vcmp.f64	d17, #0
   6bd76: eef1 2b61    	vneg.f64	d18, d17
   6bd7a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bd7e: bf48         	it	mi
   6bd80: eef0 1b62    	vmovmi.f64	d17, d18
   6bd84: eef4 1b48    	vcmp.f64	d17, d8
   6bd88: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bd8c: d512         	bpl	0x6bdb4 <check_error+0x572c> @ imm = #0x24
   6bd8e: edd2 1b04    	vldr	d17, [r2, #16]
   6bd92: ee71 0be0    	vsub.f64	d16, d17, d16
   6bd96: eef4 0b48    	vcmp.f64	d16, d8
   6bd9a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6bd9e: dd09         	ble	0x6bdb4 <check_error+0x572c> @ imm = #0x12
   6bda0: e9d3 0100    	ldrd	r0, r1, [r3]
   6bda4: 4288         	cmp	r0, r1
   6bda6: bf1e         	ittt	ne
   6bda8: fa5f f08c    	uxtbne.w	r0, r12
   6bdac: f809 5000    	strbne.w	r5, [r9, r0]
   6bdb0: f10c 0c01    	addne.w	r12, r12, #0x1
   6bdb4: 3218         	adds	r2, #0x18
   6bdb6: 330c         	adds	r3, #0xc
   6bdb8: 3501         	adds	r5, #0x1
   6bdba: e7c9         	b	0x6bd50 <check_error+0x56c8> @ imm = #-0x6e
   6bdbc: f88d a193    	strb.w	r10, [sp, #0x193]
   6bdc0: f50d 5480    	add.w	r4, sp, #0x1000
   6bdc4: f88d c191    	strb.w	r12, [sp, #0x191]
   6bdc8: a80c         	add	r0, sp, #0x30
   6bdca: f500 5e1f    	add.w	lr, r0, #0x27c0
   6bdce: a80a         	add	r0, sp, #0x28
   6bdd0: f500 5167    	add.w	r1, r0, #0x39c0
   6bdd4: a806         	add	r0, sp, #0x18
   6bdd6: f500 59a1    	add.w	r9, r0, #0x1420
   6bdda: f04f 0b00    	mov.w	r11, #0x0
   6bdde: 4675         	mov	r5, lr
   6bde0: 464b         	mov	r3, r9
   6bde2: 45d3         	cmp	r11, r10
   6bde4: d016         	beq	0x6be14 <check_error+0x578c> @ imm = #0x2c
   6bde6: 2000         	movs	r0, #0x0
   6bde8: 460e         	mov	r6, r1
   6bdea: 462a         	mov	r2, r5
   6bdec: 2803         	cmp	r0, #0x3
   6bdee: d009         	beq	0x6be04 <check_error+0x577c> @ imm = #0x12
   6bdf0: f854 8020    	ldr.w	r8, [r4, r0, lsl #2]
   6bdf4: ecf6 0b02    	vldmia	r6!, {d16}
   6bdf8: f843 8020    	str.w	r8, [r3, r0, lsl #2]
   6bdfc: 3001         	adds	r0, #0x1
   6bdfe: ece2 0b02    	vstmia	r2!, {d16}
   6be02: e7f3         	b	0x6bdec <check_error+0x5764> @ imm = #-0x1a
   6be04: 340c         	adds	r4, #0xc
   6be06: 330c         	adds	r3, #0xc
   6be08: 3118         	adds	r1, #0x18
   6be0a: 3518         	adds	r5, #0x18
   6be0c: f10b 0b01    	add.w	r11, r11, #0x1
   6be10: 9e52         	ldr	r6, [sp, #0x148]
   6be12: e7e6         	b	0x6bde2 <check_error+0x575a> @ imm = #-0x34
   6be14: f50d 657a    	add.w	r5, sp, #0xfa0
   6be18: fa5f f08c    	uxtb.w	r0, r12
   6be1c: 4629         	mov	r1, r5
   6be1e: b188         	cbz	r0, 0x6be44 <check_error+0x57bc> @ imm = #0x22
   6be20: f811 2b01    	ldrb	r2, [r1], #1
   6be24: 3801         	subs	r0, #0x1
   6be26: eb02 0242    	add.w	r2, r2, r2, lsl #1
   6be2a: eb09 0382    	add.w	r3, r9, r2, lsl #2
   6be2e: f853 3c04    	ldr	r3, [r3, #-4]
   6be32: f849 3022    	str.w	r3, [r9, r2, lsl #2]
   6be36: eb0e 02c2    	add.w	r2, lr, r2, lsl #3
   6be3a: ed52 0b02    	vldr	d16, [r2, #-8]
   6be3e: edc2 0b00    	vstr	d16, [r2]
   6be42: e7ec         	b	0x6be1e <check_error+0x5796> @ imm = #-0x28
   6be44: f20d 1093    	addw	r0, sp, #0x193
   6be48: e9cd 0501    	strd	r0, r5, [sp, #4]
   6be4c: f20d 1091    	addw	r0, sp, #0x191
   6be50: f8cd 9000    	str.w	r9, [sp]
   6be54: 9003         	str	r0, [sp, #0xc]
   6be56: a80a         	add	r0, sp, #0x28
   6be58: a90c         	add	r1, sp, #0x30
   6be5a: f50d 5480    	add.w	r4, sp, #0x1000
   6be5e: f501 531f    	add.w	r3, r1, #0x27c0
   6be62: f500 5067    	add.w	r0, r0, #0x39c0
   6be66: f50d 72c9    	add.w	r2, sp, #0x192
   6be6a: 4621         	mov	r1, r4
   6be6c: f002 fdec    	bl	0x6ea48 <err1_TD_trio_update> @ imm = #0x2bd8
   6be70: f89d b191    	ldrb.w	r11, [sp, #0x191]
   6be74: 1d20         	adds	r0, r4, #0x4
   6be76: f89d a192    	ldrb.w	r10, [sp, #0x192]
   6be7a: 2100         	movs	r1, #0x0
   6be7c: 458a         	cmp	r10, r1
   6be7e: d00c         	beq	0x6be9a <check_error+0x5812> @ imm = #0x18
   6be80: f850 2c04    	ldr	r2, [r0, #-4]
   6be84: 6803         	ldr	r3, [r0]
   6be86: 429a         	cmp	r2, r3
   6be88: bf02         	ittt	eq
   6be8a: fa5f f28b    	uxtbeq.w	r2, r11
   6be8e: 54a9         	strbeq	r1, [r5, r2]
   6be90: f10b 0b01    	addeq.w	r11, r11, #0x1
   6be94: 300c         	adds	r0, #0xc
   6be96: 3101         	adds	r1, #0x1
   6be98: e7f0         	b	0x6be7c <check_error+0x57f4> @ imm = #-0x20
   6be9a: f88d b191    	strb.w	r11, [sp, #0x191]
   6be9e: a80c         	add	r0, sp, #0x30
   6bea0: f500 591f    	add.w	r9, r0, #0x27c0
   6bea4: a80a         	add	r0, sp, #0x28
   6bea6: f500 5e67    	add.w	lr, r0, #0x39c0
   6beaa: a806         	add	r0, sp, #0x18
   6beac: f500 53a1    	add.w	r3, r0, #0x1420
   6beb0: f50d 5280    	add.w	r2, sp, #0x1000
   6beb4: f04f 0c00    	mov.w	r12, #0x0
   6beb8: 4648         	mov	r0, r9
   6beba: 45d4         	cmp	r12, r10
   6bebc: d017         	beq	0x6beee <check_error+0x5866> @ imm = #0x2e
   6bebe: 2600         	movs	r6, #0x0
   6bec0: 4671         	mov	r1, lr
   6bec2: 4605         	mov	r5, r0
   6bec4: 2e03         	cmp	r6, #0x3
   6bec6: d009         	beq	0x6bedc <check_error+0x5854> @ imm = #0x12
   6bec8: f852 4026    	ldr.w	r4, [r2, r6, lsl #2]
   6becc: ecf1 0b02    	vldmia	r1!, {d16}
   6bed0: f843 4026    	str.w	r4, [r3, r6, lsl #2]
   6bed4: 3601         	adds	r6, #0x1
   6bed6: ece5 0b02    	vstmia	r5!, {d16}
   6beda: e7f3         	b	0x6bec4 <check_error+0x583c> @ imm = #-0x1a
   6bedc: 320c         	adds	r2, #0xc
   6bede: 330c         	adds	r3, #0xc
   6bee0: f10e 0e18    	add.w	lr, lr, #0x18
   6bee4: 3018         	adds	r0, #0x18
   6bee6: f10c 0c01    	add.w	r12, r12, #0x1
   6beea: 9e52         	ldr	r6, [sp, #0x148]
   6beec: e7e5         	b	0x6beba <check_error+0x5832> @ imm = #-0x36
   6beee: f50d 686e    	add.w	r8, sp, #0xee0
   6bef2: 215a         	movs	r1, #0x5a
   6bef4: 4640         	mov	r0, r8
   6bef6: f003 e884    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x3108
   6befa: ab06         	add	r3, sp, #0x18
   6befc: fa5f f08b    	uxtb.w	r0, r11
   6bf00: f50d 627a    	add.w	r2, sp, #0xfa0
   6bf04: f503 5ba1    	add.w	r11, r3, #0x1420
   6bf08: 2101         	movs	r1, #0x1
   6bf0a: b1a0         	cbz	r0, 0x6bf36 <check_error+0x58ae> @ imm = #0x28
   6bf0c: 7813         	ldrb	r3, [r2]
   6bf0e: b16b         	cbz	r3, 0x6bf2c <check_error+0x58a4> @ imm = #0x1a
   6bf10: eb03 0443    	add.w	r4, r3, r3, lsl #1
   6bf14: eb0b 0584    	add.w	r5, r11, r4, lsl #2
   6bf18: eb09 04c4    	add.w	r4, r9, r4, lsl #3
   6bf1c: 68ae         	ldr	r6, [r5, #0x8]
   6bf1e: f845 6c04    	str	r6, [r5, #-4]
   6bf22: 9e52         	ldr	r6, [sp, #0x148]
   6bf24: edd4 0b04    	vldr	d16, [r4, #16]
   6bf28: ed44 0b02    	vstr	d16, [r4, #-8]
   6bf2c: f808 1003    	strb.w	r1, [r8, r3]
   6bf30: 3801         	subs	r0, #0x1
   6bf32: 3201         	adds	r2, #0x1
   6bf34: e7e9         	b	0x6bf0a <check_error+0x5882> @ imm = #-0x2e
   6bf36: f89d c193    	ldrb.w	r12, [sp, #0x193]
   6bf3a: 2000         	movs	r0, #0x0
   6bf3c: 465a         	mov	r2, r11
   6bf3e: 46ce         	mov	lr, r9
   6bf40: 4550         	cmp	r0, r10
   6bf42: d023         	beq	0x6bf8c <check_error+0x5904> @ imm = #0x46
   6bf44: f818 3000    	ldrb.w	r3, [r8, r0]
   6bf48: b9db         	cbnz	r3, 0x6bf82 <check_error+0x58fa> @ imm = #0x36
   6bf4a: fa5f f38c    	uxtb.w	r3, r12
   6bf4e: 2600         	movs	r6, #0x0
   6bf50: 005b         	lsls	r3, r3, #0x1
   6bf52: fa53 f38c    	uxtab	r3, r3, r12
   6bf56: eb0b 0483    	add.w	r4, r11, r3, lsl #2
   6bf5a: eb09 05c3    	add.w	r5, r9, r3, lsl #3
   6bf5e: 4673         	mov	r3, lr
   6bf60: 2e03         	cmp	r6, #0x3
   6bf62: d009         	beq	0x6bf78 <check_error+0x58f0> @ imm = #0x12
   6bf64: f852 1026    	ldr.w	r1, [r2, r6, lsl #2]
   6bf68: ecf3 0b02    	vldmia	r3!, {d16}
   6bf6c: f844 1026    	str.w	r1, [r4, r6, lsl #2]
   6bf70: 3601         	adds	r6, #0x1
   6bf72: ece5 0b02    	vstmia	r5!, {d16}
   6bf76: e7f3         	b	0x6bf60 <check_error+0x58d8> @ imm = #-0x1a
   6bf78: 9e52         	ldr	r6, [sp, #0x148]
   6bf7a: f10c 0c01    	add.w	r12, r12, #0x1
   6bf7e: f88d c193    	strb.w	r12, [sp, #0x193]
   6bf82: 320c         	adds	r2, #0xc
   6bf84: f10e 0e18    	add.w	lr, lr, #0x18
   6bf88: 3001         	adds	r0, #0x1
   6bf8a: e7d9         	b	0x6bf40 <check_error+0x58b8> @ imm = #-0x4e
   6bf8c: f20d 1093    	addw	r0, sp, #0x193
   6bf90: 9001         	str	r0, [sp, #0x4]
   6bf92: f50d 607a    	add.w	r0, sp, #0xfa0
   6bf96: 9002         	str	r0, [sp, #0x8]
   6bf98: f20d 1091    	addw	r0, sp, #0x191
   6bf9c: f886 c7f8    	strb.w	r12, [r6, #0x7f8]
   6bfa0: f8cd b000    	str.w	r11, [sp]
   6bfa4: f50d 5a80    	add.w	r10, sp, #0x1000
   6bfa8: 9003         	str	r0, [sp, #0xc]
   6bfaa: a80a         	add	r0, sp, #0x28
   6bfac: f500 5b67    	add.w	r11, r0, #0x39c0
   6bfb0: f50d 72c9    	add.w	r2, sp, #0x192
   6bfb4: 4651         	mov	r1, r10
   6bfb6: 464b         	mov	r3, r9
   6bfb8: 4658         	mov	r0, r11
   6bfba: f002 fd45    	bl	0x6ea48 <err1_TD_trio_update> @ imm = #0x2a8a
   6bfbe: f60d 68c8    	addw	r8, sp, #0xec8
   6bfc2: efc0 0050    	vmov.i32	q8, #0x0
   6bfc6: f50d 666b    	add.w	r6, sp, #0xeb0
   6bfca: f04f 0900    	mov.w	r9, #0x0
   6bfce: 4640         	mov	r0, r8
   6bfd0: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6bfd4: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   6bfd8: f8c0 9000    	str.w	r9, [r0]
   6bfdc: 4630         	mov	r0, r6
   6bfde: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   6bfe2: f8c0 9000    	str.w	r9, [r0]
   6bfe6: f50d 606a    	add.w	r0, sp, #0xea0
   6bfea: f8cd 9edc    	str.w	r9, [sp, #0xedc]
   6bfee: f940 0acf    	vst1.64	{d16, d17}, [r0]
   6bff2: f89d 0192    	ldrb.w	r0, [sp, #0x192]
   6bff6: f8cd 9ec4    	str.w	r9, [sp, #0xec4]
   6bffa: 9063         	str	r0, [sp, #0x18c]
   6bffc: 9863         	ldr	r0, [sp, #0x18c]
   6bffe: 4581         	cmp	r9, r0
   6c000: d05c         	beq	0x6c0bc <check_error+0x5a34> @ imm = #0xb8
   6c002: 9828         	ldr	r0, [sp, #0xa0]
   6c004: 2100         	movs	r1, #0x0
   6c006: 4652         	mov	r2, r10
   6c008: 6840         	ldr	r0, [r0, #0x4]
   6c00a: 2918         	cmp	r1, #0x18
   6c00c: d014         	beq	0x6c038 <check_error+0x59b0> @ imm = #0x28
   6c00e: eb0b 0401    	add.w	r4, r11, r1
   6c012: 1873         	adds	r3, r6, r1
   6c014: edd4 0b00    	vldr	d16, [r4]
   6c018: ca10         	ldm	r2!, {r4}
   6c01a: 1a24         	subs	r4, r4, r0
   6c01c: edc3 0b00    	vstr	d16, [r3]
   6c020: eb08 0301    	add.w	r3, r8, r1
   6c024: ee00 4a10    	vmov	s0, r4
   6c028: 3108         	adds	r1, #0x8
   6c02a: eef8 0b40    	vcvt.f64.u32	d16, s0
   6c02e: eec0 0b8f    	vdiv.f64	d16, d16, d15
   6c032: edc3 0b00    	vstr	d16, [r3]
   6c036: e7e8         	b	0x6c00a <check_error+0x5982> @ imm = #-0x30
   6c038: f50d 646a    	add.w	r4, sp, #0xea0
   6c03c: 4640         	mov	r0, r8
   6c03e: 4631         	mov	r1, r6
   6c040: 2203         	movs	r2, #0x3
   6c042: 4623         	mov	r3, r4
   6c044: f002 f8e4    	bl	0x6e210 <fit_simple_regression> @ imm = #0x21c8
   6c048: 4620         	mov	r0, r4
   6c04a: 4641         	mov	r1, r8
   6c04c: 4632         	mov	r2, r6
   6c04e: 2303         	movs	r3, #0x3
   6c050: f002 f95e    	bl	0x6e310 <f_rsq>         @ imm = #0x22bc
   6c054: eddd 0b60    	vldr	d16, [sp, #384]
   6c058: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6c05c: eeb4 0b60    	vcmp.f64	d0, d16
   6c060: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c064: d523         	bpl	0x6c0ae <check_error+0x5a26> @ imm = #0x46
   6c066: f89d c193    	ldrb.w	r12, [sp, #0x193]
   6c06a: a806         	add	r0, sp, #0x18
   6c06c: f500 50a1    	add.w	r0, r0, #0x1420
   6c070: 2300         	movs	r3, #0x0
   6c072: 2400         	movs	r4, #0x0
   6c074: eb0c 024c    	add.w	r2, r12, r12, lsl #1
   6c078: eb00 0182    	add.w	r1, r0, r2, lsl #2
   6c07c: a80c         	add	r0, sp, #0x30
   6c07e: f500 501f    	add.w	r0, r0, #0x27c0
   6c082: eb00 02c2    	add.w	r2, r0, r2, lsl #3
   6c086: 2c03         	cmp	r4, #0x3
   6c088: d00d         	beq	0x6c0a6 <check_error+0x5a1e> @ imm = #0x1a
   6c08a: f85a 0024    	ldr.w	r0, [r10, r4, lsl #2]
   6c08e: eb0b 0503    	add.w	r5, r11, r3
   6c092: f841 0024    	str.w	r0, [r1, r4, lsl #2]
   6c096: 18d0         	adds	r0, r2, r3
   6c098: 3308         	adds	r3, #0x8
   6c09a: edd5 0b00    	vldr	d16, [r5]
   6c09e: 3401         	adds	r4, #0x1
   6c0a0: edc0 0b00    	vstr	d16, [r0]
   6c0a4: e7ef         	b	0x6c086 <check_error+0x59fe> @ imm = #-0x22
   6c0a6: f10c 0001    	add.w	r0, r12, #0x1
   6c0aa: f88d 0193    	strb.w	r0, [sp, #0x193]
   6c0ae: f10a 0a0c    	add.w	r10, r10, #0xc
   6c0b2: f10b 0b18    	add.w	r11, r11, #0x18
   6c0b6: f109 0901    	add.w	r9, r9, #0x1
   6c0ba: e79f         	b	0x6bffc <check_error+0x5974> @ imm = #-0xc2
   6c0bc: f89d 0193    	ldrb.w	r0, [sp, #0x193]
   6c0c0: 9e52         	ldr	r6, [sp, #0x148]
   6c0c2: 2800         	cmp	r0, #0x0
   6c0c4: f886 07f9    	strb.w	r0, [r6, #0x7f9]
   6c0c8: f000 8278    	beq.w	0x6c5bc <check_error+0x5f34> @ imm = #0x4f0
   6c0cc: a806         	add	r0, sp, #0x18
   6c0ce: f50d 5a80    	add.w	r10, sp, #0x1000
   6c0d2: f500 5ba1    	add.w	r11, r0, #0x1420
   6c0d6: f20d 1093    	addw	r0, sp, #0x193
   6c0da: 9001         	str	r0, [sp, #0x4]
   6c0dc: f50d 607a    	add.w	r0, sp, #0xfa0
   6c0e0: 9002         	str	r0, [sp, #0x8]
   6c0e2: f20d 1091    	addw	r0, sp, #0x191
   6c0e6: f8cd b000    	str.w	r11, [sp]
   6c0ea: f50d 72c9    	add.w	r2, sp, #0x192
   6c0ee: 9003         	str	r0, [sp, #0xc]
   6c0f0: a80a         	add	r0, sp, #0x28
   6c0f2: f500 5467    	add.w	r4, r0, #0x39c0
   6c0f6: ab0c         	add	r3, sp, #0x30
   6c0f8: f503 531f    	add.w	r3, r3, #0x27c0
   6c0fc: 4651         	mov	r1, r10
   6c0fe: 4620         	mov	r0, r4
   6c100: f002 fca2    	bl	0x6ea48 <err1_TD_trio_update> @ imm = #0x2944
   6c104: f89d 9193    	ldrb.w	r9, [sp, #0x193]
   6c108: f04f 0800    	mov.w	r8, #0x0
   6c10c: f89d 0192    	ldrb.w	r0, [sp, #0x192]
   6c110: 4653         	mov	r3, r10
   6c112: eddf 0beb    	vldr	d16, [pc, #940]         @ 0x6c4c0 <check_error+0x5e38>
   6c116: 46a6         	mov	lr, r4
   6c118: 3801         	subs	r0, #0x1
   6c11a: 9062         	str	r0, [sp, #0x188]
   6c11c: fa5f f089    	uxtb.w	r0, r9
   6c120: 0040         	lsls	r0, r0, #0x1
   6c122: fa50 f589    	uxtab	r5, r0, r9
   6c126: a80c         	add	r0, sp, #0x30
   6c128: f500 501f    	add.w	r0, r0, #0x27c0
   6c12c: eb0b 0285    	add.w	r2, r11, r5, lsl #2
   6c130: eb00 04c5    	add.w	r4, r0, r5, lsl #3
   6c134: 9862         	ldr	r0, [sp, #0x188]
   6c136: 4580         	cmp	r8, r0
   6c138: da6e         	bge	0x6c218 <check_error+0x5b90> @ imm = #0xdc
   6c13a: eb08 0148    	add.w	r1, r8, r8, lsl #1
   6c13e: f108 0c01    	add.w	r12, r8, #0x1
   6c142: f8cd e18c    	str.w	lr, [sp, #0x18c]
   6c146: eb0a 0081    	add.w	r0, r10, r1, lsl #2
   6c14a: e9d0 6002    	ldrd	r6, r0, [r0, #8]
   6c14e: 4286         	cmp	r6, r0
   6c150: d14e         	bne	0x6c1f0 <check_error+0x5b68> @ imm = #0x9c
   6c152: eb0c 0e4c    	add.w	lr, r12, r12, lsl #1
   6c156: f85a b021    	ldr.w	r11, [r10, r1, lsl #2]
   6c15a: eb0a 008e    	add.w	r0, r10, lr, lsl #2
   6c15e: 6880         	ldr	r0, [r0, #0x8]
   6c160: eba0 060b    	sub.w	r6, r0, r11
   6c164: ee00 6a10    	vmov	s0, r6
   6c168: eef8 1b40    	vcvt.f64.u32	d17, s0
   6c16c: eec1 1b8f    	vdiv.f64	d17, d17, d15
   6c170: eef4 1b60    	vcmp.f64	d17, d16
   6c174: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c178: d53a         	bpl	0x6c1f0 <check_error+0x5b68> @ imm = #0x74
   6c17a: ae06         	add	r6, sp, #0x18
   6c17c: 6090         	str	r0, [r2, #0x8]
   6c17e: f506 56a1    	add.w	r6, r6, #0x1420
   6c182: f846 b025    	str.w	r11, [r6, r5, lsl #2]
   6c186: a80a         	add	r0, sp, #0x28
   6c188: f500 5567    	add.w	r5, r0, #0x39c0
   6c18c: eb05 00ce    	add.w	r0, r5, lr, lsl #3
   6c190: 46b3         	mov	r11, r6
   6c192: edd0 1b02    	vldr	d17, [r0, #8]
   6c196: edd0 2b04    	vldr	d18, [r0, #16]
   6c19a: eb05 00c1    	add.w	r0, r5, r1, lsl #3
   6c19e: ecf0 3b04    	vldmia	r0!, {d19, d20}
   6c1a2: eef4 4b61    	vcmp.f64	d20, d17
   6c1a6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c1aa: eef4 4b61    	vcmp.f64	d20, d17
   6c1ae: eef0 5b64    	vmov.f64	d21, d20
   6c1b2: bf88         	it	hi
   6c1b4: eef0 5b61    	vmovhi.f64	d21, d17
   6c1b8: edc4 3b00    	vstr	d19, [r4]
   6c1bc: edc4 5b02    	vstr	d21, [r4, #8]
   6c1c0: edc4 2b04    	vstr	d18, [r4, #16]
   6c1c4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c1c8: bf88         	it	hi
   6c1ca: 46e0         	movhi	r8, r12
   6c1cc: eb08 0048    	add.w	r0, r8, r8, lsl #1
   6c1d0: 9e52         	ldr	r6, [sp, #0x148]
   6c1d2: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   6c1d6: eb0a 0080    	add.w	r0, r10, r0, lsl #2
   6c1da: 6840         	ldr	r0, [r0, #0x4]
   6c1dc: 6050         	str	r0, [r2, #0x4]
   6c1de: f109 0901    	add.w	r9, r9, #0x1
   6c1e2: f88d 9193    	strb.w	r9, [sp, #0x193]
   6c1e6: 330c         	adds	r3, #0xc
   6c1e8: f10e 0e18    	add.w	lr, lr, #0x18
   6c1ec: 46e0         	mov	r8, r12
   6c1ee: e795         	b	0x6c11c <check_error+0x5a94> @ imm = #-0xd6
   6c1f0: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   6c1f4: 2500         	movs	r5, #0x0
   6c1f6: 9e52         	ldr	r6, [sp, #0x148]
   6c1f8: a806         	add	r0, sp, #0x18
   6c1fa: f500 5ba1    	add.w	r11, r0, #0x1420
   6c1fe: 4671         	mov	r1, lr
   6c200: 2d03         	cmp	r5, #0x3
   6c202: d0ec         	beq	0x6c1de <check_error+0x5b56> @ imm = #-0x28
   6c204: f853 0025    	ldr.w	r0, [r3, r5, lsl #2]
   6c208: ecf1 1b02    	vldmia	r1!, {d17}
   6c20c: f842 0025    	str.w	r0, [r2, r5, lsl #2]
   6c210: 3501         	adds	r5, #0x1
   6c212: ece4 1b02    	vstmia	r4!, {d17}
   6c216: e7f3         	b	0x6c200 <check_error+0x5b78> @ imm = #-0x1a
   6c218: 9862         	ldr	r0, [sp, #0x188]
   6c21a: ab0a         	add	r3, sp, #0x28
   6c21c: f503 5367    	add.w	r3, r3, #0x39c0
   6c220: 2500         	movs	r5, #0x0
   6c222: eb00 0040    	add.w	r0, r0, r0, lsl #1
   6c226: eb0a 0180    	add.w	r1, r10, r0, lsl #2
   6c22a: eb03 03c0    	add.w	r3, r3, r0, lsl #3
   6c22e: 2d03         	cmp	r5, #0x3
   6c230: d009         	beq	0x6c246 <check_error+0x5bbe> @ imm = #0x12
   6c232: f851 0025    	ldr.w	r0, [r1, r5, lsl #2]
   6c236: ecf3 0b02    	vldmia	r3!, {d16}
   6c23a: f842 0025    	str.w	r0, [r2, r5, lsl #2]
   6c23e: 3501         	adds	r5, #0x1
   6c240: ece4 0b02    	vstmia	r4!, {d16}
   6c244: e7f3         	b	0x6c22e <check_error+0x5ba6> @ imm = #-0x1a
   6c246: f109 0001    	add.w	r0, r9, #0x1
   6c24a: f886 07fa    	strb.w	r0, [r6, #0x7fa]
   6c24e: f88d 0193    	strb.w	r0, [sp, #0x193]
   6c252: f20d 1093    	addw	r0, sp, #0x193
   6c256: 9001         	str	r0, [sp, #0x4]
   6c258: f50d 607a    	add.w	r0, sp, #0xfa0
   6c25c: 9002         	str	r0, [sp, #0x8]
   6c25e: f20d 1091    	addw	r0, sp, #0x191
   6c262: f8cd b000    	str.w	r11, [sp]
   6c266: f50d 72c9    	add.w	r2, sp, #0x192
   6c26a: 9003         	str	r0, [sp, #0xc]
   6c26c: a80a         	add	r0, sp, #0x28
   6c26e: f500 5867    	add.w	r8, r0, #0x39c0
   6c272: ab0c         	add	r3, sp, #0x30
   6c274: f503 531f    	add.w	r3, r3, #0x27c0
   6c278: 4651         	mov	r1, r10
   6c27a: 4640         	mov	r0, r8
   6c27c: f002 fbe4    	bl	0x6ea48 <err1_TD_trio_update> @ imm = #0x27c8
   6c280: f89d e193    	ldrb.w	lr, [sp, #0x193]
   6c284: 2000         	movs	r0, #0x0
   6c286: f89d c192    	ldrb.w	r12, [sp, #0x192]
   6c28a: 4653         	mov	r3, r10
   6c28c: eddd 1b5c    	vldr	d17, [sp, #368]
   6c290: 46c1         	mov	r9, r8
   6c292: 4560         	cmp	r0, r12
   6c294: d036         	beq	0x6c304 <check_error+0x5c7c> @ imm = #0x6c
   6c296: eb00 0240    	add.w	r2, r0, r0, lsl #1
   6c29a: f85a 4022    	ldr.w	r4, [r10, r2, lsl #2]
   6c29e: eb0a 0282    	add.w	r2, r10, r2, lsl #2
   6c2a2: 6892         	ldr	r2, [r2, #0x8]
   6c2a4: 1b12         	subs	r2, r2, r4
   6c2a6: ee00 2a10    	vmov	s0, r2
   6c2aa: eef8 0b40    	vcvt.f64.u32	d16, s0
   6c2ae: eec0 0b8f    	vdiv.f64	d16, d16, d15
   6c2b2: eef4 0b61    	vcmp.f64	d16, d17
   6c2b6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c2ba: d51e         	bpl	0x6c2fa <check_error+0x5c72> @ imm = #0x3c
   6c2bc: fa5f f28e    	uxtb.w	r2, lr
   6c2c0: a90c         	add	r1, sp, #0x30
   6c2c2: 0052         	lsls	r2, r2, #0x1
   6c2c4: f501 511f    	add.w	r1, r1, #0x27c0
   6c2c8: fa52 f28e    	uxtab	r2, r2, lr
   6c2cc: 464c         	mov	r4, r9
   6c2ce: eb0b 0682    	add.w	r6, r11, r2, lsl #2
   6c2d2: eb01 05c2    	add.w	r5, r1, r2, lsl #3
   6c2d6: 2200         	movs	r2, #0x0
   6c2d8: 2a03         	cmp	r2, #0x3
   6c2da: d009         	beq	0x6c2f0 <check_error+0x5c68> @ imm = #0x12
   6c2dc: f853 1022    	ldr.w	r1, [r3, r2, lsl #2]
   6c2e0: ecf4 0b02    	vldmia	r4!, {d16}
   6c2e4: f846 1022    	str.w	r1, [r6, r2, lsl #2]
   6c2e8: 3201         	adds	r2, #0x1
   6c2ea: ece5 0b02    	vstmia	r5!, {d16}
   6c2ee: e7f3         	b	0x6c2d8 <check_error+0x5c50> @ imm = #-0x1a
   6c2f0: 9e52         	ldr	r6, [sp, #0x148]
   6c2f2: f10e 0e01    	add.w	lr, lr, #0x1
   6c2f6: f88d e193    	strb.w	lr, [sp, #0x193]
   6c2fa: 330c         	adds	r3, #0xc
   6c2fc: f109 0918    	add.w	r9, r9, #0x18
   6c300: 3001         	adds	r0, #0x1
   6c302: e7c6         	b	0x6c292 <check_error+0x5c0a> @ imm = #-0x74
   6c304: f20d 1093    	addw	r0, sp, #0x193
   6c308: 9001         	str	r0, [sp, #0x4]
   6c30a: f50d 607a    	add.w	r0, sp, #0xfa0
   6c30e: f886 e7fb    	strb.w	lr, [r6, #0x7fb]
   6c312: 9002         	str	r0, [sp, #0x8]
   6c314: f20d 1091    	addw	r0, sp, #0x191
   6c318: 9003         	str	r0, [sp, #0xc]
   6c31a: f50d 5680    	add.w	r6, sp, #0x1000
   6c31e: f8cd b000    	str.w	r11, [sp]
   6c322: ab0c         	add	r3, sp, #0x30
   6c324: f503 591f    	add.w	r9, r3, #0x27c0
   6c328: f50d 72c9    	add.w	r2, sp, #0x192
   6c32c: 4640         	mov	r0, r8
   6c32e: 4631         	mov	r1, r6
   6c330: 464b         	mov	r3, r9
   6c332: f002 fb89    	bl	0x6ea48 <err1_TD_trio_update> @ imm = #0x2712
   6c336: f89d a193    	ldrb.w	r10, [sp, #0x193]
   6c33a: 2000         	movs	r0, #0x0
   6c33c: f89d c192    	ldrb.w	r12, [sp, #0x192]
   6c340: 46c6         	mov	lr, r8
   6c342: eddd 3b5e    	vldr	d19, [sp, #376]
   6c346: 4560         	cmp	r0, r12
   6c348: d049         	beq	0x6c3de <check_error+0x5d56> @ imm = #0x92
   6c34a: eb00 0140    	add.w	r1, r0, r0, lsl #1
   6c34e: eb08 01c1    	add.w	r1, r8, r1, lsl #3
   6c352: edd1 1b00    	vldr	d17, [r1]
   6c356: edd1 0b02    	vldr	d16, [r1, #8]
   6c35a: ee70 1be1    	vsub.f64	d17, d16, d17
   6c35e: eef5 1b40    	vcmp.f64	d17, #0
   6c362: eef1 2b61    	vneg.f64	d18, d17
   6c366: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c36a: bf48         	it	mi
   6c36c: eef0 1b62    	vmovmi.f64	d17, d18
   6c370: eef4 1b63    	vcmp.f64	d17, d19
   6c374: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c378: db2c         	blt	0x6c3d4 <check_error+0x5d4c> @ imm = #0x58
   6c37a: edd1 1b04    	vldr	d17, [r1, #16]
   6c37e: ee70 0be1    	vsub.f64	d16, d16, d17
   6c382: eef5 0b40    	vcmp.f64	d16, #0
   6c386: eef1 1b60    	vneg.f64	d17, d16
   6c38a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c38e: bf48         	it	mi
   6c390: eef0 0b61    	vmovmi.f64	d16, d17
   6c394: eef4 0b63    	vcmp.f64	d16, d19
   6c398: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c39c: db1a         	blt	0x6c3d4 <check_error+0x5d4c> @ imm = #0x34
   6c39e: fa5f f18a    	uxtb.w	r1, r10
   6c3a2: 4672         	mov	r2, lr
   6c3a4: 0049         	lsls	r1, r1, #0x1
   6c3a6: fa51 f18a    	uxtab	r1, r1, r10
   6c3aa: eb0b 0381    	add.w	r3, r11, r1, lsl #2
   6c3ae: eb09 05c1    	add.w	r5, r9, r1, lsl #3
   6c3b2: 2100         	movs	r1, #0x0
   6c3b4: 2903         	cmp	r1, #0x3
   6c3b6: d009         	beq	0x6c3cc <check_error+0x5d44> @ imm = #0x12
   6c3b8: f856 4021    	ldr.w	r4, [r6, r1, lsl #2]
   6c3bc: ecf2 0b02    	vldmia	r2!, {d16}
   6c3c0: f843 4021    	str.w	r4, [r3, r1, lsl #2]
   6c3c4: 3101         	adds	r1, #0x1
   6c3c6: ece5 0b02    	vstmia	r5!, {d16}
   6c3ca: e7f3         	b	0x6c3b4 <check_error+0x5d2c> @ imm = #-0x1a
   6c3cc: f10a 0a01    	add.w	r10, r10, #0x1
   6c3d0: f88d a193    	strb.w	r10, [sp, #0x193]
   6c3d4: 360c         	adds	r6, #0xc
   6c3d6: f10e 0e18    	add.w	lr, lr, #0x18
   6c3da: 3001         	adds	r0, #0x1
   6c3dc: e7b3         	b	0x6c346 <check_error+0x5cbe> @ imm = #-0x9a
   6c3de: 9e52         	ldr	r6, [sp, #0x148]
   6c3e0: f50d 6564    	add.w	r5, sp, #0xe40
   6c3e4: 215a         	movs	r1, #0x5a
   6c3e6: 4628         	mov	r0, r5
   6c3e8: f886 a7fc    	strb.w	r10, [r6, #0x7fc]
   6c3ec: f002 ee08    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2c10
   6c3f0: fa5f f08a    	uxtb.w	r0, r10
   6c3f4: f04f 0800    	mov.w	r8, #0x0
   6c3f8: fa5f fa88    	uxtb.w	r10, r8
   6c3fc: 2801         	cmp	r0, #0x1
   6c3fe: db1c         	blt	0x6c43a <check_error+0x5db2> @ imm = #0x38
   6c400: 3801         	subs	r0, #0x1
   6c402: f50d 6264    	add.w	r2, sp, #0xe40
   6c406: 4653         	mov	r3, r10
   6c408: eb00 0140    	add.w	r1, r0, r0, lsl #1
   6c40c: eb0b 0181    	add.w	r1, r11, r1, lsl #2
   6c410: 3104         	adds	r1, #0x4
   6c412: b163         	cbz	r3, 0x6c42e <check_error+0x5da6> @ imm = #0x18
   6c414: f812 4b01    	ldrb	r4, [r2], #1
   6c418: 3b01         	subs	r3, #0x1
   6c41a: 680e         	ldr	r6, [r1]
   6c41c: eb04 0444    	add.w	r4, r4, r4, lsl #1
   6c420: eb0b 0484    	add.w	r4, r11, r4, lsl #2
   6c424: 6864         	ldr	r4, [r4, #0x4]
   6c426: 42a6         	cmp	r6, r4
   6c428: d1f3         	bne	0x6c412 <check_error+0x5d8a> @ imm = #-0x1a
   6c42a: 9e52         	ldr	r6, [sp, #0x148]
   6c42c: e7e6         	b	0x6c3fc <check_error+0x5d74> @ imm = #-0x34
   6c42e: f805 000a    	strb.w	r0, [r5, r10]
   6c432: f108 0801    	add.w	r8, r8, #0x1
   6c436: 9e52         	ldr	r6, [sp, #0x148]
   6c438: e7de         	b	0x6c3f8 <check_error+0x5d70> @ imm = #-0x44
   6c43a: f1aa 0c01    	sub.w	r12, r10, #0x1
   6c43e: 2100         	movs	r1, #0x0
   6c440: 458c         	cmp	r12, r1
   6c442: dd10         	ble	0x6c466 <check_error+0x5dde> @ imm = #0x20
   6c444: ebac 0201    	sub.w	r2, r12, r1
   6c448: 2300         	movs	r3, #0x0
   6c44a: 4293         	cmp	r3, r2
   6c44c: da09         	bge	0x6c462 <check_error+0x5dda> @ imm = #0x12
   6c44e: 18ee         	adds	r6, r5, r3
   6c450: 5cec         	ldrb	r4, [r5, r3]
   6c452: 7870         	ldrb	r0, [r6, #0x1]
   6c454: 4284         	cmp	r4, r0
   6c456: bf84         	itt	hi
   6c458: 54e8         	strbhi	r0, [r5, r3]
   6c45a: 7074         	strbhi	r4, [r6, #0x1]
   6c45c: 3301         	adds	r3, #0x1
   6c45e: 9e52         	ldr	r6, [sp, #0x148]
   6c460: e7f3         	b	0x6c44a <check_error+0x5dc2> @ imm = #-0x1a
   6c462: 3101         	adds	r1, #0x1
   6c464: e7ec         	b	0x6c440 <check_error+0x5db8> @ imm = #-0x28
   6c466: f60d 2408    	addw	r4, sp, #0xa08
   6c46a: f44f 6187    	mov.w	r1, #0x438
   6c46e: 4620         	mov	r0, r4
   6c470: f002 edc6    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2b8c
   6c474: f50d 7bcc    	add.w	r11, sp, #0x198
   6c478: f44f 6107    	mov.w	r1, #0x870
   6c47c: 4658         	mov	r0, r11
   6c47e: f002 edc0    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2b80
   6c482: f04f 0e00    	mov.w	lr, #0x0
   6c486: 4621         	mov	r1, r4
   6c488: 46dc         	mov	r12, r11
   6c48a: 45d6         	cmp	lr, r10
   6c48c: d023         	beq	0x6c4d6 <check_error+0x5e4e> @ imm = #0x46
   6c48e: f815 200e    	ldrb.w	r2, [r5, lr]
   6c492: a806         	add	r0, sp, #0x18
   6c494: f500 50a1    	add.w	r0, r0, #0x1420
   6c498: 2600         	movs	r6, #0x0
   6c49a: eb02 0242    	add.w	r2, r2, r2, lsl #1
   6c49e: eb00 0382    	add.w	r3, r0, r2, lsl #2
   6c4a2: eb09 04c2    	add.w	r4, r9, r2, lsl #3
   6c4a6: 4662         	mov	r2, r12
   6c4a8: 2e03         	cmp	r6, #0x3
   6c4aa: d00d         	beq	0x6c4c8 <check_error+0x5e40> @ imm = #0x1a
   6c4ac: f853 0026    	ldr.w	r0, [r3, r6, lsl #2]
   6c4b0: ecf4 0b02    	vldmia	r4!, {d16}
   6c4b4: f841 0026    	str.w	r0, [r1, r6, lsl #2]
   6c4b8: 3601         	adds	r6, #0x1
   6c4ba: ece2 0b02    	vstmia	r2!, {d16}
   6c4be: e7f3         	b	0x6c4a8 <check_error+0x5e20> @ imm = #-0x1a
   6c4c0: 9a 99 99 99  	.word	0x9999999a
   6c4c4: 99 19 34 40  	.word	0x40341999
   6c4c8: 310c         	adds	r1, #0xc
   6c4ca: f10c 0c18    	add.w	r12, r12, #0x18
   6c4ce: f10e 0e01    	add.w	lr, lr, #0x1
   6c4d2: 9e52         	ldr	r6, [sp, #0x148]
   6c4d4: e7d9         	b	0x6c48a <check_error+0x5e02> @ imm = #-0x4e
   6c4d6: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6c4da: ea5f 6008    	lsls.w	r0, r8, #0x18
   6c4de: f886 87ca    	strb.w	r8, [r6, #0x7ca]
   6c4e2: d01c         	beq	0x6c51e <check_error+0x5e96> @ imm = #0x38
   6c4e4: ea4f 004a    	lsl.w	r0, r10, #0x1
   6c4e8: fa50 f188    	uxtab	r1, r0, r8
   6c4ec: f60d 2008    	addw	r0, sp, #0xa08
   6c4f0: f506 64fb    	add.w	r4, r6, #0x7d8
   6c4f4: eb00 0081    	add.w	r0, r0, r1, lsl #2
   6c4f8: eb0b 01c1    	add.w	r1, r11, r1, lsl #3
   6c4fc: 3918         	subs	r1, #0x18
   6c4fe: 2200         	movs	r2, #0x0
   6c500: f06f 030b    	mvn	r3, #0xb
   6c504: b15b         	cbz	r3, 0x6c51e <check_error+0x5e96> @ imm = #0x16
   6c506: 188e         	adds	r6, r1, r2
   6c508: 58c5         	ldr	r5, [r0, r3]
   6c50a: 50e5         	str	r5, [r4, r3]
   6c50c: 18a5         	adds	r5, r4, r2
   6c50e: edd6 0b00    	vldr	d16, [r6]
   6c512: 3304         	adds	r3, #0x4
   6c514: 9e52         	ldr	r6, [sp, #0x148]
   6c516: 3208         	adds	r2, #0x8
   6c518: edc5 0b00    	vstr	d16, [r5]
   6c51c: e7f2         	b	0x6c504 <check_error+0x5e7c> @ imm = #-0x1c
   6c51e: 983d         	ldr	r0, [sp, #0xf4]
   6c520: f8b0 04bc    	ldrh.w	r0, [r0, #0x4bc]
   6c524: 4550         	cmp	r0, r10
   6c526: d304         	blo	0x6c532 <check_error+0x5eaa> @ imm = #0x8
   6c528: 9827         	ldr	r0, [sp, #0x9c]
   6c52a: f890 0e3c    	ldrb.w	r0, [r0, #0xe3c]
   6c52e: 2800         	cmp	r0, #0x0
   6c530: d044         	beq	0x6c5bc <check_error+0x5f34> @ imm = #0x88
   6c532: 983d         	ldr	r0, [sp, #0xf4]
   6c534: f8b0 04be    	ldrh.w	r0, [r0, #0x4be]
   6c538: 4550         	cmp	r0, r10
   6c53a: d103         	bne	0x6c544 <check_error+0x5ebc> @ imm = #0x6
   6c53c: 9827         	ldr	r0, [sp, #0x9c]
   6c53e: f890 0e3c    	ldrb.w	r0, [r0, #0xe3c]
   6c542: b358         	cbz	r0, 0x6c59c <check_error+0x5f14> @ imm = #0x56
   6c544: f1ba 0f04    	cmp.w	r10, #0x4
   6c548: d811         	bhi	0x6c56e <check_error+0x5ee6> @ imm = #0x22
   6c54a: 9827         	ldr	r0, [sp, #0x9c]
   6c54c: f890 0e3c    	ldrb.w	r0, [r0, #0xe3c]
   6c550: 2801         	cmp	r0, #0x1
   6c552: d10c         	bne	0x6c56e <check_error+0x5ee6> @ imm = #0x18
   6c554: f246 00f1    	movw	r0, #0x60f1
   6c558: eb0e 0100    	add.w	r1, lr, r0
   6c55c: 2000         	movs	r0, #0x0
   6c55e: 2200         	movs	r2, #0x0
   6c560: 2a24         	cmp	r2, #0x24
   6c562: d00e         	beq	0x6c582 <check_error+0x5efa> @ imm = #0x1c
   6c564: 5c8b         	ldrb	r3, [r1, r2]
   6c566: 3201         	adds	r2, #0x1
   6c568: 4418         	add	r0, r3
   6c56a: b2c0         	uxtb	r0, r0
   6c56c: e7f8         	b	0x6c560 <check_error+0x5ed8> @ imm = #-0x10
   6c56e: 983d         	ldr	r0, [sp, #0xf4]
   6c570: f8b0 04c0    	ldrh.w	r0, [r0, #0x4c0]
   6c574: 4550         	cmp	r0, r10
   6c576: bf9c         	itt	ls
   6c578: f240 1001    	movwls	r0, #0x101
   6c57c: f8a6 07f1    	strhls.w	r0, [r6, #0x7f1]
   6c580: e01c         	b	0x6c5bc <check_error+0x5f34> @ imm = #0x38
   6c582: 993d         	ldr	r1, [sp, #0xf4]
   6c584: f8b1 14ba    	ldrh.w	r1, [r1, #0x4ba]
   6c588: 4288         	cmp	r0, r1
   6c58a: bf34         	ite	lo
   6c58c: 2001         	movlo	r0, #0x1
   6c58e: 2000         	movhs	r0, #0x0
   6c590: 9e52         	ldr	r6, [sp, #0x148]
   6c592: f8dd e14c    	ldr.w	lr, [sp, #0x14c]
   6c596: f886 07cb    	strb.w	r0, [r6, #0x7cb]
   6c59a: e00f         	b	0x6c5bc <check_error+0x5f34> @ imm = #0x1e
   6c59c: 9a27         	ldr	r2, [sp, #0x9c]
   6c59e: 2001         	movs	r0, #0x1
   6c5a0: f886 07f0    	strb.w	r0, [r6, #0x7f0]
   6c5a4: f886 07cb    	strb.w	r0, [r6, #0x7cb]
   6c5a8: f8b2 1e3e    	ldrh.w	r1, [r2, #0xe3e]
   6c5ac: 3101         	adds	r1, #0x1
   6c5ae: f8a2 1e3e    	strh.w	r1, [r2, #0xe3e]
   6c5b2: b289         	uxth	r1, r1
   6c5b4: 2902         	cmp	r1, #0x2
   6c5b6: bf28         	it	hs
   6c5b8: f886 07f2    	strbhs.w	r0, [r6, #0x7f2]
   6c5bc: f896 b7c9    	ldrb.w	r11, [r6, #0x7c9]
   6c5c0: f8dd 809c    	ldr.w	r8, [sp, #0x9c]
   6c5c4: f7fc bf9d    	b.w	0x69502 <check_error+0x2e7a> @ imm = #-0x30c6
   6c5c8: ef60 11b0    	vorr	d17, d16, d16
   6c5cc: 9c53         	ldr	r4, [sp, #0x14c]
   6c5ce: f7fe b9e0    	b.w	0x6a992 <check_error+0x430a> @ imm = #-0x1c40
   6c5d2: ef62 11b2    	vorr	d17, d18, d18
   6c5d6: f7fe b9dc    	b.w	0x6a992 <check_error+0x430a> @ imm = #-0x1c48
   6c5da: 2000         	movs	r0, #0x0
   6c5dc: f8dd a0a8    	ldr.w	r10, [sp, #0xa8]
   6c5e0: f7fd bb49    	b.w	0x69c76 <check_error+0x35ee> @ imm = #-0x296e
   6c5e4: 9952         	ldr	r1, [sp, #0x148]
   6c5e6: 2000         	movs	r0, #0x0
   6c5e8: f8dd c14c    	ldr.w	r12, [sp, #0x14c]
   6c5ec: f8dd e18c    	ldr.w	lr, [sp, #0x18c]
   6c5f0: f881 0861    	strb.w	r0, [r1, #0x861]
   6c5f4: f7fd bb69    	b.w	0x69cca <check_error+0x3642> @ imm = #-0x292e
   6c5f8: 2000         	movs	r0, #0x0
   6c5fa: f7fd bbc3    	b.w	0x69d84 <check_error+0x36fc> @ imm = #-0x287a

0006c5fe <copy_mem>:
   6c5fe: b12a         	cbz	r2, 0x6c60c <copy_mem+0xe> @ imm = #0xa
   6c600: f811 3b01    	ldrb	r3, [r1], #1
   6c604: 3a01         	subs	r2, #0x1
   6c606: f800 3b01    	strb	r3, [r0], #1
   6c60a: e7f8         	b	0x6c5fe <copy_mem>      @ imm = #-0x10
   6c60c: 4770         	bx	lr
   6c60e: d4d4         	bmi	0x6c5ba <check_error+0x5f32> @ imm = #-0x58

0006c610 <math_std>:
   6c610: b5b0         	push	{r4, r5, r7, lr}
   6c612: af02         	add	r7, sp, #0x8
   6c614: b129         	cbz	r1, 0x6c622 <math_std+0x12> @ imm = #0xa
   6c616: 460c         	mov	r4, r1
   6c618: 2901         	cmp	r1, #0x1
   6c61a: d105         	bne	0x6c628 <math_std+0x18> @ imm = #0xa
   6c61c: ef80 0010    	vmov.i32	d0, #0x0
   6c620: bdb0         	pop	{r4, r5, r7, pc}
   6c622: ed9f 0b0f    	vldr	d0, [pc, #60]           @ 0x6c660 <math_std+0x50>
   6c626: bdb0         	pop	{r4, r5, r7, pc}
   6c628: 4621         	mov	r1, r4
   6c62a: 4605         	mov	r5, r0
   6c62c: f000 f838    	bl	0x6c6a0 <math_mean>     @ imm = #0x70
   6c630: efc0 0010    	vmov.i32	d16, #0x0
   6c634: 4620         	mov	r0, r4
   6c636: b138         	cbz	r0, 0x6c648 <math_std+0x38> @ imm = #0xe
   6c638: ecf5 1b02    	vldmia	r5!, {d17}
   6c63c: 3801         	subs	r0, #0x1
   6c63e: ee71 1bc0    	vsub.f64	d17, d17, d0
   6c642: ee41 0ba1    	vmla.f64	d16, d17, d17
   6c646: e7f6         	b	0x6c636 <math_std+0x26> @ imm = #-0x14
   6c648: 1e60         	subs	r0, r4, #0x1
   6c64a: ee00 0a10    	vmov	s0, r0
   6c64e: eef8 1bc0    	vcvt.f64.s32	d17, s0
   6c652: eec0 0ba1    	vdiv.f64	d16, d16, d17
   6c656: eeb1 0be0    	vsqrt.f64	d0, d16
   6c65a: bdb0         	pop	{r4, r5, r7, pc}
   6c65c: bf00         	nop
   6c65e: bf00         	nop
   6c660: 00 00 00 00  	.word	0x00000000
   6c664: 00 00 f8 7f  	.word	0x7ff80000

0006c668 <delete_element>:
   6c668: b5b0         	push	{r4, r5, r7, lr}
   6c66a: af02         	add	r7, sp, #0x8
   6c66c: 780b         	ldrb	r3, [r1]
   6c66e: b1a3         	cbz	r3, 0x6c69a <delete_element+0x32> @ imm = #0x28
   6c670: 4293         	cmp	r3, r2
   6c672: d912         	bls	0x6c69a <delete_element+0x32> @ imm = #0x24
   6c674: eb00 00c2    	add.w	r0, r0, r2, lsl #3
   6c678: f04f 34ff    	mov.w	r4, #0xffffffff
   6c67c: 3008         	adds	r0, #0x8
   6c67e: fa54 f583    	uxtab	r5, r4, r3
   6c682: 42aa         	cmp	r2, r5
   6c684: da07         	bge	0x6c696 <delete_element+0x2e> @ imm = #0xe
   6c686: edd0 0b00    	vldr	d16, [r0]
   6c68a: 3201         	adds	r2, #0x1
   6c68c: ed40 0b02    	vstr	d16, [r0, #-8]
   6c690: 3008         	adds	r0, #0x8
   6c692: 780b         	ldrb	r3, [r1]
   6c694: e7f3         	b	0x6c67e <delete_element+0x16> @ imm = #-0x1a
   6c696: 1e58         	subs	r0, r3, #0x1
   6c698: 7008         	strb	r0, [r1]
   6c69a: bdb0         	pop	{r4, r5, r7, pc}
   6c69c: d4d4         	bmi	0x6c648 <math_std+0x38> @ imm = #-0x58
   6c69e: d4d4         	bmi	0x6c64a <math_std+0x3a> @ imm = #-0x58

0006c6a0 <math_mean>:
   6c6a0: b1f1         	cbz	r1, 0x6c6e0 <math_mean+0x40> @ imm = #0x3c
   6c6a2: efc0 0010    	vmov.i32	d16, #0x0
   6c6a6: eddf 1b12    	vldr	d17, [pc, #72]          @ 0x6c6f0 <math_mean+0x50>
   6c6aa: 2200         	movs	r2, #0x0
   6c6ac: b181         	cbz	r1, 0x6c6d0 <math_mean+0x30> @ imm = #0x20
   6c6ae: ecf0 2b02    	vldmia	r0!, {d18}
   6c6b2: ef61 31b1    	vorr	d19, d17, d17
   6c6b6: eef4 2b62    	vcmp.f64	d18, d18
   6c6ba: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c6be: bf78         	it	vc
   6c6c0: 3201         	addvc	r2, #0x1
   6c6c2: bf78         	it	vc
   6c6c4: eef0 3b62    	vmovvc.f64	d19, d18
   6c6c8: ee70 0ba3    	vadd.f64	d16, d16, d19
   6c6cc: 3901         	subs	r1, #0x1
   6c6ce: e7ed         	b	0x6c6ac <math_mean+0xc> @ imm = #-0x26
   6c6d0: b290         	uxth	r0, r2
   6c6d2: ee00 0a10    	vmov	s0, r0
   6c6d6: eef8 1b40    	vcvt.f64.u32	d17, s0
   6c6da: ee80 0ba1    	vdiv.f64	d0, d16, d17
   6c6de: 4770         	bx	lr
   6c6e0: ed9f 0b01    	vldr	d0, [pc, #4]            @ 0x6c6e8 <math_mean+0x48>
   6c6e4: 4770         	bx	lr
   6c6e6: bf00         	nop
   6c6e8: 00 00 00 00  	.word	0x00000000
   6c6ec: 00 00 f8 7f  	.word	0x7ff80000
   6c6f0: 00 00 00 00  	.word	0x00000000
   6c6f4: 00 00 00 80  	.word	0x80000000

0006c6f8 <eliminate_peak>:
   6c6f8: b5b0         	push	{r4, r5, r7, lr}
   6c6fa: af02         	add	r7, sp, #0x8
   6c6fc: ed2d 8b02    	vpush	{d8}
   6c700: 460c         	mov	r4, r1
   6c702: 211e         	movs	r1, #0x1e
   6c704: 4605         	mov	r5, r0
   6c706: f7ff ffcb    	bl	0x6c6a0 <math_mean>     @ imm = #-0x6a
   6c70a: 4628         	mov	r0, r5
   6c70c: 211e         	movs	r1, #0x1e
   6c70e: eeb0 8b40    	vmov.f64	d8, d0
   6c712: f7ff ff7d    	bl	0x6c610 <math_std>      @ imm = #-0x106
   6c716: ee70 1b00    	vadd.f64	d17, d0, d0
   6c71a: 2000         	movs	r0, #0x0
   6c71c: ee71 0b88    	vadd.f64	d16, d17, d8
   6c720: ee78 1b61    	vsub.f64	d17, d8, d17
   6c724: 28f0         	cmp	r0, #0xf0
   6c726: d014         	beq	0x6c752 <eliminate_peak+0x5a> @ imm = #0x28
   6c728: 1829         	adds	r1, r5, r0
   6c72a: edd1 2b00    	vldr	d18, [r1]
   6c72e: 1821         	adds	r1, r4, r0
   6c730: eef4 2b61    	vcmp.f64	d18, d17
   6c734: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c738: d404         	bmi	0x6c744 <eliminate_peak+0x4c> @ imm = #0x8
   6c73a: eef4 2b60    	vcmp.f64	d18, d16
   6c73e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c742: dd02         	ble	0x6c74a <eliminate_peak+0x52> @ imm = #0x4
   6c744: ed81 8b00    	vstr	d8, [r1]
   6c748: e001         	b	0x6c74e <eliminate_peak+0x56> @ imm = #0x2
   6c74a: edc1 2b00    	vstr	d18, [r1]
   6c74e: 3008         	adds	r0, #0x8
   6c750: e7e8         	b	0x6c724 <eliminate_peak+0x2c> @ imm = #-0x30
   6c752: ecbd 8b02    	vpop	{d8}
   6c756: bdb0         	pop	{r4, r5, r7, pc}

0006c758 <math_round>:
   6c758: b580         	push	{r7, lr}
   6c75a: 466f         	mov	r7, sp
   6c75c: eeb4 0b40    	vcmp.f64	d0, d0
   6c760: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c764: d615         	bvs	0x6c792 <math_round+0x3a> @ imm = #0x2a
   6c766: eeb5 0b40    	vcmp.f64	d0, #0
   6c76a: eefe 0b00    	vmov.f64	d16, #-5.000000e-01
   6c76e: eef6 1b00    	vmov.f64	d17, #5.000000e-01
   6c772: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c776: bfb8         	it	lt
   6c778: eef0 1b60    	vmovlt.f64	d17, d16
   6c77c: ee71 0b80    	vadd.f64	d16, d17, d0
   6c780: ec51 0b30    	vmov	r0, r1, d16
   6c784: f002 ea80    	blx	0x6ec88 <__fixdfdi>     @ imm = #0x2500
   6c788: f002 eabe    	blx	0x6ed08 <__floatdidf>   @ imm = #0x257c
   6c78c: ec41 0b10    	vmov	d0, r0, r1
   6c790: bd80         	pop	{r7, pc}
   6c792: ed9f 0b01    	vldr	d0, [pc, #4]            @ 0x6c798 <math_round+0x40>
   6c796: bd80         	pop	{r7, pc}
   6c798: 00 00 00 00  	.word	0x00000000
   6c79c: 00 00 f8 7f  	.word	0x7ff80000

0006c7a0 <quick_median>:
   6c7a0: b5f0         	push	{r4, r5, r6, r7, lr}
   6c7a2: af03         	add	r7, sp, #0xc
   6c7a4: f84d bd04    	str	r11, [sp, #-4]!
   6c7a8: ed2d 8b02    	vpush	{d8}
   6c7ac: b169         	cbz	r1, 0x6c7ca <quick_median+0x2a> @ imm = #0x1a
   6c7ae: 460c         	mov	r4, r1
   6c7b0: 4605         	mov	r5, r0
   6c7b2: 291d         	cmp	r1, #0x1d
   6c7b4: d80c         	bhi	0x6c7d0 <quick_median+0x30> @ imm = #0x18
   6c7b6: 4628         	mov	r0, r5
   6c7b8: 4621         	mov	r1, r4
   6c7ba: ecbd 8b02    	vpop	{d8}
   6c7be: f85d bb04    	ldr	r11, [sp], #4
   6c7c2: e8bd 40f0    	pop.w	{r4, r5, r6, r7, lr}
   6c7c6: f000 b8c3    	b.w	0x6c950 <math_median>   @ imm = #0x186
   6c7ca: ed9f 0b15    	vldr	d0, [pc, #84]           @ 0x6c820 <quick_median+0x80>
   6c7ce: e014         	b	0x6c7fa <quick_median+0x5a> @ imm = #0x28
   6c7d0: 0866         	lsrs	r6, r4, #0x1
   6c7d2: 07e0         	lsls	r0, r4, #0x1f
   6c7d4: d116         	bne	0x6c804 <quick_median+0x64> @ imm = #0x2c
   6c7d6: 4628         	mov	r0, r5
   6c7d8: 4621         	mov	r1, r4
   6c7da: 4632         	mov	r2, r6
   6c7dc: f000 f920    	bl	0x6ca20 <quick_select>  @ imm = #0x240
   6c7e0: 1c72         	adds	r2, r6, #0x1
   6c7e2: 4628         	mov	r0, r5
   6c7e4: 4621         	mov	r1, r4
   6c7e6: eeb0 8b40    	vmov.f64	d8, d0
   6c7ea: f000 f919    	bl	0x6ca20 <quick_select>  @ imm = #0x232
   6c7ee: ee78 0b00    	vadd.f64	d16, d8, d0
   6c7f2: eef6 1b00    	vmov.f64	d17, #5.000000e-01
   6c7f6: ee20 0ba1    	vmul.f64	d0, d16, d17
   6c7fa: ecbd 8b02    	vpop	{d8}
   6c7fe: f85d bb04    	ldr	r11, [sp], #4
   6c802: bdf0         	pop	{r4, r5, r6, r7, pc}
   6c804: 1c72         	adds	r2, r6, #0x1
   6c806: 4628         	mov	r0, r5
   6c808: 4621         	mov	r1, r4
   6c80a: ecbd 8b02    	vpop	{d8}
   6c80e: f85d bb04    	ldr	r11, [sp], #4
   6c812: e8bd 40f0    	pop.w	{r4, r5, r6, r7, lr}
   6c816: f000 b903    	b.w	0x6ca20 <quick_select>  @ imm = #0x206
   6c81a: bf00         	nop
   6c81c: bf00         	nop
   6c81e: bf00         	nop
   6c820: 00 00 00 00  	.word	0x00000000
   6c824: 00 00 f8 7f  	.word	0x7ff80000

0006c828 <fun_comp_decimals>:
   6c828: b5f0         	push	{r4, r5, r6, r7, lr}
   6c82a: af03         	add	r7, sp, #0xc
   6c82c: e92d 0700    	push.w	{r8, r9, r10}
   6c830: ed2d 8b04    	vpush	{d8, d9}
   6c834: eeb4 0b40    	vcmp.f64	d0, d0
   6c838: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c83c: bf7e         	ittt	vc
   6c83e: eeb0 8b41    	vmovvc.f64	d8, d1
   6c842: eeb4 1b41    	vcmpvc.f64	d1, d1
   6c846: eef1 fa10    	vmrsvc	APSR_nzcv, fpscr
   6c84a: f180 807d    	bvs.w	0x6c948 <fun_comp_decimals+0x120> @ imm = #0xfa
   6c84e: 4688         	mov	r8, r1
   6c850: 4605         	mov	r5, r0
   6c852: eeb0 9b40    	vmov.f64	d9, d0
   6c856: f000 f9bb    	bl	0x6cbd0 <math_round_digits> @ imm = #0x376
   6c85a: eeb0 0b48    	vmov.f64	d0, d8
   6c85e: 1c44         	adds	r4, r0, #0x1
   6c860: 4682         	mov	r10, r0
   6c862: 4628         	mov	r0, r5
   6c864: 4689         	mov	r9, r1
   6c866: f141 4600    	adc	r6, r1, #0x80000000
   6c86a: f000 f9b1    	bl	0x6cbd0 <math_round_digits> @ imm = #0x362
   6c86e: 4602         	mov	r2, r0
   6c870: 1ea0         	subs	r0, r4, #0x2
   6c872: f176 0000    	sbcs	r0, r6, #0x0
   6c876: d308         	blo	0x6c88a <fun_comp_decimals+0x62> @ imm = #0x10
   6c878: 1c50         	adds	r0, r2, #0x1
   6c87a: f141 4300    	adc	r3, r1, #0x80000000
   6c87e: 2400         	movs	r4, #0x0
   6c880: f1d0 0001    	rsbs.w	r0, r0, #0x1
   6c884: eb74 0003    	sbcs.w	r0, r4, r3
   6c888: d30f         	blo	0x6c8aa <fun_comp_decimals+0x82> @ imm = #0x1e
   6c88a: f1a8 0001    	sub.w	r0, r8, #0x1
   6c88e: 2803         	cmp	r0, #0x3
   6c890: d819         	bhi	0x6c8c6 <fun_comp_decimals+0x9e> @ imm = #0x32
   6c892: e8df f000    	tbb	[pc, r0]
   6c896: 02 20 28 2e  	.word	0x2e282002
   6c89a: eeb4 9b48    	vcmp.f64	d9, d8
   6c89e: 2000         	movs	r0, #0x0
   6c8a0: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c8a4: bfc8         	it	gt
   6c8a6: 2001         	movgt	r0, #0x1
   6c8a8: e049         	b	0x6c93e <fun_comp_decimals+0x116> @ imm = #0x92
   6c8aa: f1a8 0001    	sub.w	r0, r8, #0x1
   6c8ae: 2803         	cmp	r0, #0x3
   6c8b0: d827         	bhi	0x6c902 <fun_comp_decimals+0xda> @ imm = #0x4e
   6c8b2: e8df f000    	tbb	[pc, r0]
   6c8b6: 02 2f 37 3d  	.word	0x3d372f02
   6c8ba: 2000         	movs	r0, #0x0
   6c8bc: ebb2 020a    	subs.w	r2, r2, r10
   6c8c0: eb71 0109    	sbcs.w	r1, r1, r9
   6c8c4: e02b         	b	0x6c91e <fun_comp_decimals+0xf6> @ imm = #0x56
   6c8c6: eeb4 9b48    	vcmp.f64	d9, d8
   6c8ca: 2000         	movs	r0, #0x0
   6c8cc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c8d0: bf08         	it	eq
   6c8d2: 2001         	moveq	r0, #0x1
   6c8d4: e033         	b	0x6c93e <fun_comp_decimals+0x116> @ imm = #0x66
   6c8d6: eeb4 9b48    	vcmp.f64	d9, d8
   6c8da: 2000         	movs	r0, #0x0
   6c8dc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c8e0: bf48         	it	mi
   6c8e2: 2001         	movmi	r0, #0x1
   6c8e4: e02b         	b	0x6c93e <fun_comp_decimals+0x116> @ imm = #0x56
   6c8e6: eeb4 9b48    	vcmp.f64	d9, d8
   6c8ea: 2000         	movs	r0, #0x0
   6c8ec: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c8f0: e023         	b	0x6c93a <fun_comp_decimals+0x112> @ imm = #0x46
   6c8f2: eeb4 9b48    	vcmp.f64	d9, d8
   6c8f6: 2000         	movs	r0, #0x0
   6c8f8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c8fc: bf98         	it	ls
   6c8fe: 2001         	movls	r0, #0x1
   6c900: e01d         	b	0x6c93e <fun_comp_decimals+0x116> @ imm = #0x3a
   6c902: ea8a 0002    	eor.w	r0, r10, r2
   6c906: ea81 0109    	eor.w	r1, r1, r9
   6c90a: 4308         	orrs	r0, r1
   6c90c: fab0 f080    	clz	r0, r0
   6c910: 0940         	lsrs	r0, r0, #0x5
   6c912: e014         	b	0x6c93e <fun_comp_decimals+0x116> @ imm = #0x28
   6c914: 2000         	movs	r0, #0x0
   6c916: ebba 0202    	subs.w	r2, r10, r2
   6c91a: eb79 0101    	sbcs.w	r1, r9, r1
   6c91e: bfb8         	it	lt
   6c920: 2001         	movlt	r0, #0x1
   6c922: e00c         	b	0x6c93e <fun_comp_decimals+0x116> @ imm = #0x18
   6c924: 2000         	movs	r0, #0x0
   6c926: ebba 0202    	subs.w	r2, r10, r2
   6c92a: eb79 0101    	sbcs.w	r1, r9, r1
   6c92e: e004         	b	0x6c93a <fun_comp_decimals+0x112> @ imm = #0x8
   6c930: 2000         	movs	r0, #0x0
   6c932: ebb2 020a    	subs.w	r2, r2, r10
   6c936: eb71 0109    	sbcs.w	r1, r1, r9
   6c93a: bfa8         	it	ge
   6c93c: 2001         	movge	r0, #0x1
   6c93e: ecbd 8b04    	vpop	{d8, d9}
   6c942: e8bd 0700    	pop.w	{r8, r9, r10}
   6c946: bdf0         	pop	{r4, r5, r6, r7, pc}
   6c948: 2000         	movs	r0, #0x0
   6c94a: e7f8         	b	0x6c93e <fun_comp_decimals+0x116> @ imm = #-0x10
   6c94c: d4d4         	bmi	0x6c8f8 <fun_comp_decimals+0xd0> @ imm = #-0x58
   6c94e: d4d4         	bmi	0x6c8fa <fun_comp_decimals+0xd2> @ imm = #-0x58

0006c950 <math_median>:
   6c950: b5f0         	push	{r4, r5, r6, r7, lr}
   6c952: af03         	add	r7, sp, #0xc
   6c954: f84d bd04    	str	r11, [sp, #-4]!
   6c958: f6ad 1d68    	subw	sp, sp, #0x968
   6c95c: 4605         	mov	r5, r0
   6c95e: 482e         	ldr	r0, [pc, #0xb8]         @ 0x6ca18 <math_median+0xc8>
   6c960: 460c         	mov	r4, r1
   6c962: f44f 6116    	mov.w	r1, #0x960
   6c966: 4478         	add	r0, pc
   6c968: 6800         	ldr	r0, [r0]
   6c96a: 6800         	ldr	r0, [r0]
   6c96c: f847 0c14    	str	r0, [r7, #-20]
   6c970: 4668         	mov	r0, sp
   6c972: f002 eb46    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x268c
   6c976: b3c4         	cbz	r4, 0x6c9ea <math_median+0x9a> @ imm = #0x70
   6c978: 46ec         	mov	r12, sp
   6c97a: 4621         	mov	r1, r4
   6c97c: 4660         	mov	r0, r12
   6c97e: b129         	cbz	r1, 0x6c98c <math_median+0x3c> @ imm = #0xa
   6c980: ecf5 0b02    	vldmia	r5!, {d16}
   6c984: 3901         	subs	r1, #0x1
   6c986: ece0 0b02    	vstmia	r0!, {d16}
   6c98a: e7f8         	b	0x6c97e <math_median+0x2e> @ imm = #-0x10
   6c98c: f10c 0108    	add.w	r1, r12, #0x8
   6c990: 1e62         	subs	r2, r4, #0x1
   6c992: 2000         	movs	r0, #0x0
   6c994: 4290         	cmp	r0, r2
   6c996: d018         	beq	0x6c9ca <math_median+0x7a> @ imm = #0x30
   6c998: eb0c 05c0    	add.w	r5, r12, r0, lsl #3
   6c99c: 3001         	adds	r0, #0x1
   6c99e: 460e         	mov	r6, r1
   6c9a0: 4603         	mov	r3, r0
   6c9a2: 42a3         	cmp	r3, r4
   6c9a4: d20f         	bhs	0x6c9c6 <math_median+0x76> @ imm = #0x1e
   6c9a6: edd6 1b00    	vldr	d17, [r6]
   6c9aa: edd5 0b00    	vldr	d16, [r5]
   6c9ae: eef4 0b61    	vcmp.f64	d16, d17
   6c9b2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6c9b6: bfc4         	itt	gt
   6c9b8: edc5 1b00    	vstrgt	d17, [r5]
   6c9bc: edc6 0b00    	vstrgt	d16, [r6]
   6c9c0: 3608         	adds	r6, #0x8
   6c9c2: 3301         	adds	r3, #0x1
   6c9c4: e7ed         	b	0x6c9a2 <math_median+0x52> @ imm = #-0x26
   6c9c6: 3108         	adds	r1, #0x8
   6c9c8: e7e4         	b	0x6c994 <math_median+0x44> @ imm = #-0x38
   6c9ca: 0860         	lsrs	r0, r4, #0x1
   6c9cc: eb0c 00c0    	add.w	r0, r12, r0, lsl #3
   6c9d0: 07e1         	lsls	r1, r4, #0x1f
   6c9d2: ed90 0b00    	vldr	d0, [r0]
   6c9d6: d10a         	bne	0x6c9ee <math_median+0x9e> @ imm = #0x14
   6c9d8: ed50 0b02    	vldr	d16, [r0, #-8]
   6c9dc: eef6 1b00    	vmov.f64	d17, #5.000000e-01
   6c9e0: ee70 0b20    	vadd.f64	d16, d0, d16
   6c9e4: ee20 0ba1    	vmul.f64	d0, d16, d17
   6c9e8: e001         	b	0x6c9ee <math_median+0x9e> @ imm = #0x2
   6c9ea: ed9f 0b09    	vldr	d0, [pc, #36]           @ 0x6ca10 <math_median+0xc0>
   6c9ee: f857 0c14    	ldr	r0, [r7, #-20]
   6c9f2: 490a         	ldr	r1, [pc, #0x28]         @ 0x6ca1c <math_median+0xcc>
   6c9f4: 4479         	add	r1, pc
   6c9f6: 6809         	ldr	r1, [r1]
   6c9f8: 6809         	ldr	r1, [r1]
   6c9fa: 4281         	cmp	r1, r0
   6c9fc: bf02         	ittt	eq
   6c9fe: f60d 1d68    	addweq	sp, sp, #0x968
   6ca02: f85d bb04    	ldreq	r11, [sp], #4
   6ca06: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6ca08: f002 eb12    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x2624
   6ca0c: bf00         	nop
   6ca0e: bf00         	nop
   6ca10: 00 00 00 00  	.word	0x00000000
   6ca14: 00 00 f8 7f  	.word	0x7ff80000
   6ca18: 6a 68 00 00  	.word	0x0000686a
   6ca1c: dc 67 00 00  	.word	0x000067dc

0006ca20 <quick_select>:
   6ca20: b5f0         	push	{r4, r5, r6, r7, lr}
   6ca22: af03         	add	r7, sp, #0xc
   6ca24: e92d 0f00    	push.w	{r8, r9, r10, r11}
   6ca28: b08b         	sub	sp, #0x2c
   6ca2a: 4682         	mov	r10, r0
   6ca2c: 485d         	ldr	r0, [pc, #0x174]        @ 0x6cba4 <quick_select+0x184>
   6ca2e: 2901         	cmp	r1, #0x1
   6ca30: 4478         	add	r0, pc
   6ca32: 6800         	ldr	r0, [r0]
   6ca34: 6800         	ldr	r0, [r0]
   6ca36: 900a         	str	r0, [sp, #0x28]
   6ca38: d102         	bne	0x6ca40 <quick_select+0x20> @ imm = #0x4
   6ca3a: ed9a 0b00    	vldr	d0, [r10]
   6ca3e: e0a3         	b	0x6cb88 <quick_select+0x168> @ imm = #0x146
   6ca40: edda 0b00    	vldr	d16, [r10]
   6ca44: eb0a 00c1    	add.w	r0, r10, r1, lsl #3
   6ca48: 468b         	mov	r11, r1
   6ca4a: eef0 1b08    	vmov.f64	d17, #3.000000e+00
   6ca4e: 4690         	mov	r8, r2
   6ca50: edcd 0b00    	vstr	d16, [sp]
   6ca54: ee00 ba10    	vmov	s0, r11
   6ca58: ed50 0b02    	vldr	d16, [r0, #-8]
   6ca5c: 0888         	lsrs	r0, r1, #0x2
   6ca5e: eb0a 01c0    	add.w	r1, r10, r0, lsl #3
   6ca62: eb00 0040    	add.w	r0, r0, r0, lsl #1
   6ca66: edcd 0b08    	vstr	d16, [sp, #32]
   6ca6a: edd1 0b00    	vldr	d16, [r1]
   6ca6e: f06f 0104    	mvn	r1, #0x4
   6ca72: ea01 018b    	and.w	r1, r1, r11, lsl #2
   6ca76: eb0a 00c0    	add.w	r0, r10, r0, lsl #3
   6ca7a: 4451         	add	r1, r10
   6ca7c: edcd 0b02    	vstr	d16, [sp, #8]
   6ca80: edd1 0b00    	vldr	d16, [r1]
   6ca84: 2105         	movs	r1, #0x5
   6ca86: edcd 0b04    	vstr	d16, [sp, #16]
   6ca8a: edd0 0b00    	vldr	d16, [r0]
   6ca8e: 4668         	mov	r0, sp
   6ca90: edcd 0b06    	vstr	d16, [sp, #24]
   6ca94: eef8 0b40    	vcvt.f64.u32	d16, s0
   6ca98: ee60 0ba1    	vmul.f64	d16, d16, d17
   6ca9c: eef5 1b00    	vmov.f64	d17, #2.500000e-01
   6caa0: ee60 0ba1    	vmul.f64	d16, d16, d17
   6caa4: eebc 0be0    	vcvt.u32.f64	s0, d16
   6caa8: ee10 9a10    	vmov	r9, s0
   6caac: f7ff ff50    	bl	0x6c950 <math_median>   @ imm = #-0x160
   6cab0: eef0 0b40    	vmov.f64	d16, d0
   6cab4: f04f 0c00    	mov.w	r12, #0x0
   6cab8: 2100         	movs	r1, #0x0
   6caba: 4655         	mov	r5, r10
   6cabc: 465e         	mov	r6, r11
   6cabe: 2200         	movs	r2, #0x0
   6cac0: 2300         	movs	r3, #0x0
   6cac2: b1fe         	cbz	r6, 0x6cb04 <quick_select+0xe4> @ imm = #0x3e
   6cac4: edd5 1b00    	vldr	d17, [r5]
   6cac8: eef4 1b40    	vcmp.f64	d17, d0
   6cacc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cad0: d506         	bpl	0x6cae0 <quick_select+0xc0> @ imm = #0xc
   6cad2: 4838         	ldr	r0, [pc, #0xe0]         @ 0x6cbb4 <quick_select+0x194>
   6cad4: b28c         	uxth	r4, r1
   6cad6: 3101         	adds	r1, #0x1
   6cad8: 4478         	add	r0, pc
   6cada: eb00 00c4    	add.w	r0, r0, r4, lsl #3
   6cade: e00a         	b	0x6caf6 <quick_select+0xd6> @ imm = #0x14
   6cae0: eef4 1b40    	vcmp.f64	d17, d0
   6cae4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cae8: dd08         	ble	0x6cafc <quick_select+0xdc> @ imm = #0x10
   6caea: 4c33         	ldr	r4, [pc, #0xcc]         @ 0x6cbb8 <quick_select+0x198>
   6caec: b290         	uxth	r0, r2
   6caee: 3201         	adds	r2, #0x1
   6caf0: 447c         	add	r4, pc
   6caf2: eb04 00c0    	add.w	r0, r4, r0, lsl #3
   6caf6: edc0 1b00    	vstr	d17, [r0]
   6cafa: e000         	b	0x6cafe <quick_select+0xde> @ imm = #0x0
   6cafc: 3301         	adds	r3, #0x1
   6cafe: 3508         	adds	r5, #0x8
   6cb00: 3e01         	subs	r6, #0x1
   6cb02: e7de         	b	0x6cac2 <quick_select+0xa2> @ imm = #-0x44
   6cb04: f1bb 0f05    	cmp.w	r11, #0x5
   6cb08: d90e         	bls	0x6cb28 <quick_select+0x108> @ imm = #0x1c
   6cb0a: b288         	uxth	r0, r1
   6cb0c: 4548         	cmp	r0, r9
   6cb0e: bf9c         	itt	ls
   6cb10: b290         	uxthls	r0, r2
   6cb12: 4548         	cmpls	r0, r9
   6cb14: d90a         	bls	0x6cb2c <quick_select+0x10c> @ imm = #0x14
   6cb16: f10c 0c01    	add.w	r12, r12, #0x1
   6cb1a: fa1f f08c    	uxth.w	r0, r12
   6cb1e: eb0a 00c0    	add.w	r0, r10, r0, lsl #3
   6cb22: ed90 0b00    	vldr	d0, [r0]
   6cb26: e7c7         	b	0x6cab8 <quick_select+0x98> @ imm = #-0x72
   6cb28: eeb0 0b60    	vmov.f64	d0, d16
   6cb2c: b289         	uxth	r1, r1
   6cb2e: 4541         	cmp	r1, r8
   6cb30: d215         	bhs	0x6cb5e <quick_select+0x13e> @ imm = #0x2a
   6cb32: 1c48         	adds	r0, r1, #0x1
   6cb34: 4540         	cmp	r0, r8
   6cb36: d027         	beq	0x6cb88 <quick_select+0x168> @ imm = #0x4e
   6cb38: fa11 f083    	uxtah	r0, r1, r3
   6cb3c: eba8 0000    	sub.w	r0, r8, r0
   6cb40: 2801         	cmp	r0, #0x1
   6cb42: db21         	blt	0x6cb88 <quick_select+0x168> @ imm = #0x42
   6cb44: b291         	uxth	r1, r2
   6cb46: 4a1d         	ldr	r2, [pc, #0x74]         @ 0x6cbbc <quick_select+0x19c>
   6cb48: 4b1d         	ldr	r3, [pc, #0x74]         @ 0x6cbc0 <quick_select+0x1a0>
   6cb4a: 447a         	add	r2, pc
   6cb4c: 460c         	mov	r4, r1
   6cb4e: 447b         	add	r3, pc
   6cb50: b1ac         	cbz	r4, 0x6cb7e <quick_select+0x15e> @ imm = #0x2a
   6cb52: ecf2 0b02    	vldmia	r2!, {d16}
   6cb56: 3c01         	subs	r4, #0x1
   6cb58: ece3 0b02    	vstmia	r3!, {d16}
   6cb5c: e7f8         	b	0x6cb50 <quick_select+0x130> @ imm = #-0x10
   6cb5e: 4812         	ldr	r0, [pc, #0x48]         @ 0x6cba8 <quick_select+0x188>
   6cb60: 460b         	mov	r3, r1
   6cb62: 4a12         	ldr	r2, [pc, #0x48]         @ 0x6cbac <quick_select+0x18c>
   6cb64: 4478         	add	r0, pc
   6cb66: 447a         	add	r2, pc
   6cb68: b12b         	cbz	r3, 0x6cb76 <quick_select+0x156> @ imm = #0xa
   6cb6a: ecf0 0b02    	vldmia	r0!, {d16}
   6cb6e: 3b01         	subs	r3, #0x1
   6cb70: ece2 0b02    	vstmia	r2!, {d16}
   6cb74: e7f8         	b	0x6cb68 <quick_select+0x148> @ imm = #-0x10
   6cb76: 480e         	ldr	r0, [pc, #0x38]         @ 0x6cbb0 <quick_select+0x190>
   6cb78: 4642         	mov	r2, r8
   6cb7a: 4478         	add	r0, pc
   6cb7c: e002         	b	0x6cb84 <quick_select+0x164> @ imm = #0x4
   6cb7e: b282         	uxth	r2, r0
   6cb80: 4810         	ldr	r0, [pc, #0x40]         @ 0x6cbc4 <quick_select+0x1a4>
   6cb82: 4478         	add	r0, pc
   6cb84: f7ff ff4c    	bl	0x6ca20 <quick_select>  @ imm = #-0x168
   6cb88: 980a         	ldr	r0, [sp, #0x28]
   6cb8a: 490f         	ldr	r1, [pc, #0x3c]         @ 0x6cbc8 <quick_select+0x1a8>
   6cb8c: 4479         	add	r1, pc
   6cb8e: 6809         	ldr	r1, [r1]
   6cb90: 6809         	ldr	r1, [r1]
   6cb92: 4281         	cmp	r1, r0
   6cb94: bf02         	ittt	eq
   6cb96: b00b         	addeq	sp, #0x2c
   6cb98: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   6cb9c: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6cb9e: f002 ea48    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x2490
   6cba2: bf00         	nop
   6cba4: a0 67 00 00  	.word	0x000067a0
   6cba8: a0 64 02 00  	.word	0x000264a0
   6cbac: ae 9a 02 00  	.word	0x00029aae
   6cbb0: 9a 9a 02 00  	.word	0x00029a9a
   6cbb4: 2c 65 02 00  	.word	0x0002652c
   6cbb8: 1c 80 02 00  	.word	0x0002801c
   6cbbc: c2 7f 02 00  	.word	0x00027fc2
   6cbc0: c6 9a 02 00  	.word	0x00029ac6
   6cbc4: 92 9a 02 00  	.word	0x00029a92
   6cbc8: 44 66 00 00  	.word	0x00006644
   6cbcc: d4 d4 d4 d4  	.word	0xd4d4d4d4

0006cbd0 <math_round_digits>:
   6cbd0: b5d0         	push	{r4, r6, r7, lr}
   6cbd2: af02         	add	r7, sp, #0x8
   6cbd4: ed2d 8b02    	vpush	{d8}
   6cbd8: eef2 0b04    	vmov.f64	d16, #1.000000e+01
   6cbdc: eeb0 8b40    	vmov.f64	d8, d0
   6cbe0: ee00 0a10    	vmov	s0, r0
   6cbe4: ec51 4b30    	vmov	r4, r1, d16
   6cbe8: eef8 0b40    	vcvt.f64.u32	d16, s0
   6cbec: ec53 2b30    	vmov	r2, r3, d16
   6cbf0: 4620         	mov	r0, r4
   6cbf2: f002 ea66    	blx	0x6f0c0 <sincos+0x6f0c0> @ imm = #0x24cc
   6cbf6: ec41 0b30    	vmov	d16, r0, r1
   6cbfa: ee60 0b88    	vmul.f64	d16, d16, d8
   6cbfe: eef5 0b40    	vcmp.f64	d16, #0
   6cc02: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cc06: da0a         	bge	0x6cc1e <math_round_digits+0x4e> @ imm = #0x14
   6cc08: eddf 1b15    	vldr	d17, [pc, #84]          @ 0x6cc60 <math_round_digits+0x90>
   6cc0c: eef4 0b61    	vcmp.f64	d16, d17
   6cc10: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cc14: d50f         	bpl	0x6cc36 <math_round_digits+0x66> @ imm = #0x1e
   6cc16: f04f 4100    	mov.w	r1, #0x80000000
   6cc1a: 2000         	movs	r0, #0x0
   6cc1c: e016         	b	0x6cc4c <math_round_digits+0x7c> @ imm = #0x2c
   6cc1e: eddf 1b0e    	vldr	d17, [pc, #56]          @ 0x6cc58 <math_round_digits+0x88>
   6cc22: eef4 0b61    	vcmp.f64	d16, d17
   6cc26: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cc2a: dd07         	ble	0x6cc3c <math_round_digits+0x6c> @ imm = #0xe
   6cc2c: f06f 4100    	mvn	r1, #0x80000000
   6cc30: f04f 30ff    	mov.w	r0, #0xffffffff
   6cc34: e00a         	b	0x6cc4c <math_round_digits+0x7c> @ imm = #0x14
   6cc36: eefe 1b00    	vmov.f64	d17, #-5.000000e-01
   6cc3a: e001         	b	0x6cc40 <math_round_digits+0x70> @ imm = #0x2
   6cc3c: eef6 1b00    	vmov.f64	d17, #5.000000e-01
   6cc40: ee70 0ba1    	vadd.f64	d16, d16, d17
   6cc44: ec51 0b30    	vmov	r0, r1, d16
   6cc48: f002 e81e    	blx	0x6ec88 <__fixdfdi>     @ imm = #0x203c
   6cc4c: ecbd 8b02    	vpop	{d8}
   6cc50: bdd0         	pop	{r4, r6, r7, pc}
   6cc52: bf00         	nop
   6cc54: bf00         	nop
   6cc56: bf00         	nop
   6cc58: 30 d2 da fd  	.word	0xfddad230
   6cc5c: ff ff df 43  	.word	0x43dfffff
   6cc60: 30 d2 da fd  	.word	0xfddad230
   6cc64: ff ff df c3  	.word	0xc3dfffff

0006cc68 <cal_average_without_min_max>:
   6cc68: edd0 0b00    	vldr	d16, [r0]
   6cc6c: efc0 1010    	vmov.i32	d17, #0x0
   6cc70: ef60 21b0    	vorr	d18, d16, d16
   6cc74: 460a         	mov	r2, r1
   6cc76: b1aa         	cbz	r2, 0x6cca4 <cal_average_without_min_max+0x3c> @ imm = #0x2a
   6cc78: edd0 3b00    	vldr	d19, [r0]
   6cc7c: eef4 3b60    	vcmp.f64	d19, d16
   6cc80: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cc84: dd02         	ble	0x6cc8c <cal_average_without_min_max+0x24> @ imm = #0x4
   6cc86: eef0 0b63    	vmov.f64	d16, d19
   6cc8a: e006         	b	0x6cc9a <cal_average_without_min_max+0x32> @ imm = #0xc
   6cc8c: eef4 3b62    	vcmp.f64	d19, d18
   6cc90: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cc94: bf48         	it	mi
   6cc96: eef0 2b63    	vmovmi.f64	d18, d19
   6cc9a: ee71 1ba3    	vadd.f64	d17, d17, d19
   6cc9e: 3008         	adds	r0, #0x8
   6cca0: 3a01         	subs	r2, #0x1
   6cca2: e7e8         	b	0x6cc76 <cal_average_without_min_max+0xe> @ imm = #-0x30
   6cca4: ee71 1be2    	vsub.f64	d17, d17, d18
   6cca8: 1e88         	subs	r0, r1, #0x2
   6ccaa: ee00 0a10    	vmov	s0, r0
   6ccae: ee71 0be0    	vsub.f64	d16, d17, d16
   6ccb2: eef8 1bc0    	vcvt.f64.s32	d17, s0
   6ccb6: ee80 0ba1    	vdiv.f64	d0, d16, d17
   6ccba: 4770         	bx	lr

0006ccbc <smooth_sg>:
   6ccbc: b5f0         	push	{r4, r5, r6, r7, lr}
   6ccbe: af03         	add	r7, sp, #0xc
   6ccc0: e92d 0700    	push.w	{r8, r9, r10}
   6ccc4: ed2d 8b02    	vpush	{d8}
   6ccc8: b0b8         	sub	sp, #0xe0
   6ccca: 4682         	mov	r10, r0
   6cccc: 4843         	ldr	r0, [pc, #0x10c]        @ 0x6cddc <smooth_sg+0x120>
   6ccce: 460e         	mov	r6, r1
   6ccd0: 2150         	movs	r1, #0x50
   6ccd2: 4478         	add	r0, pc
   6ccd4: 4690         	mov	r8, r2
   6ccd6: eeb0 8b40    	vmov.f64	d8, d0
   6ccda: 6800         	ldr	r0, [r0]
   6ccdc: 6800         	ldr	r0, [r0]
   6ccde: 9037         	str	r0, [sp, #0xdc]
   6cce0: ac22         	add	r4, sp, #0x88
   6cce2: 4620         	mov	r0, r4
   6cce4: f002 e98c    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2318
   6cce8: f10d 0938    	add.w	r9, sp, #0x38
   6ccec: 2150         	movs	r1, #0x50
   6ccee: 4648         	mov	r0, r9
   6ccf0: f002 e986    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x230c
   6ccf4: efc0 0050    	vmov.i32	q8, #0x0
   6ccf8: 4668         	mov	r0, sp
   6ccfa: 4602         	mov	r2, r0
   6ccfc: 2100         	movs	r1, #0x0
   6ccfe: 910d         	str	r1, [sp, #0x34]
   6cd00: f942 0acd    	vst1.64	{d16, d17}, [r2]!
   6cd04: f942 0acd    	vst1.64	{d16, d17}, [r2]!
   6cd08: f942 0acd    	vst1.64	{d16, d17}, [r2]!
   6cd0c: 6011         	str	r1, [r2]
   6cd0e: 4a34         	ldr	r2, [pc, #0xd0]         @ 0x6cde0 <smooth_sg+0x124>
   6cd10: 447a         	add	r2, pc
   6cd12: 2938         	cmp	r1, #0x38
   6cd14: d00c         	beq	0x6cd30 <smooth_sg+0x74> @ imm = #0x18
   6cd16: 1853         	adds	r3, r2, r1
   6cd18: edd3 0b00    	vldr	d16, [r3]
   6cd1c: 1873         	adds	r3, r6, r1
   6cd1e: edd3 1b00    	vldr	d17, [r3]
   6cd22: 1843         	adds	r3, r0, r1
   6cd24: 3108         	adds	r1, #0x8
   6cd26: ee61 0ba0    	vmul.f64	d16, d17, d16
   6cd2a: edc3 0b00    	vstr	d16, [r3]
   6cd2e: e7f0         	b	0x6cd12 <smooth_sg+0x56> @ imm = #-0x20
   6cd30: edda 0b12    	vldr	d16, [r10, #72]
   6cd34: 2100         	movs	r1, #0x0
   6cd36: 2950         	cmp	r1, #0x50
   6cd38: d00c         	beq	0x6cd54 <smooth_sg+0x98> @ imm = #0x18
   6cd3a: eb0a 0301    	add.w	r3, r10, r1
   6cd3e: 1862         	adds	r2, r4, r1
   6cd40: 3108         	adds	r1, #0x8
   6cd42: edd3 1b00    	vldr	d17, [r3]
   6cd46: ee71 1be0    	vsub.f64	d17, d17, d16
   6cd4a: eec1 1b88    	vdiv.f64	d17, d17, d8
   6cd4e: edc2 1b00    	vstr	d17, [r2]
   6cd52: e7f0         	b	0x6cd36 <smooth_sg+0x7a> @ imm = #-0x20
   6cd54: 3018         	adds	r0, #0x18
   6cd56: 2103         	movs	r1, #0x3
   6cd58: 290d         	cmp	r1, #0xd
   6cd5a: d01e         	beq	0x6cd9a <smooth_sg+0xde> @ imm = #0x3c
   6cd5c: eb09 02c1    	add.w	r2, r9, r1, lsl #3
   6cd60: 2300         	movs	r3, #0x0
   6cd62: efc0 0010    	vmov.i32	d16, #0x0
   6cd66: 4606         	mov	r6, r0
   6cd68: f842 3d18    	str	r3, [r2, #-24]!
   6cd6c: 6053         	str	r3, [r2, #0x4]
   6cd6e: ac22         	add	r4, sp, #0x88
   6cd70: f113 050a    	adds.w	r5, r3, #0xa
   6cd74: d00e         	beq	0x6cd94 <smooth_sg+0xd8> @ imm = #0x1c
   6cd76: 18cd         	adds	r5, r1, r3
   6cd78: 2d06         	cmp	r5, #0x6
   6cd7a: d807         	bhi	0x6cd8c <smooth_sg+0xd0> @ imm = #0xe
   6cd7c: edd6 1b00    	vldr	d17, [r6]
   6cd80: edd4 2b00    	vldr	d18, [r4]
   6cd84: ee42 0ba1    	vmla.f64	d16, d18, d17
   6cd88: edc2 0b00    	vstr	d16, [r2]
   6cd8c: 3408         	adds	r4, #0x8
   6cd8e: 3e08         	subs	r6, #0x8
   6cd90: 3b01         	subs	r3, #0x1
   6cd92: e7ed         	b	0x6cd70 <smooth_sg+0xb4> @ imm = #-0x26
   6cd94: 3008         	adds	r0, #0x8
   6cd96: 3101         	adds	r1, #0x1
   6cd98: e7de         	b	0x6cd58 <smooth_sg+0x9c> @ imm = #-0x44
   6cd9a: 2000         	movs	r0, #0x0
   6cd9c: 2850         	cmp	r0, #0x50
   6cd9e: d00d         	beq	0x6cdbc <smooth_sg+0x100> @ imm = #0x1a
   6cda0: eb09 0100    	add.w	r1, r9, r0
   6cda4: edda 1b12    	vldr	d17, [r10, #72]
   6cda8: edd1 0b00    	vldr	d16, [r1]
   6cdac: eb08 0100    	add.w	r1, r8, r0
   6cdb0: 3008         	adds	r0, #0x8
   6cdb2: ee40 1b88    	vmla.f64	d17, d16, d8
   6cdb6: edc1 1b00    	vstr	d17, [r1]
   6cdba: e7ef         	b	0x6cd9c <smooth_sg+0xe0> @ imm = #-0x22
   6cdbc: 9837         	ldr	r0, [sp, #0xdc]
   6cdbe: 4909         	ldr	r1, [pc, #0x24]         @ 0x6cde4 <smooth_sg+0x128>
   6cdc0: 4479         	add	r1, pc
   6cdc2: 6809         	ldr	r1, [r1]
   6cdc4: 6809         	ldr	r1, [r1]
   6cdc6: 4281         	cmp	r1, r0
   6cdc8: bf01         	itttt	eq
   6cdca: b038         	addeq	sp, #0xe0
   6cdcc: ecbd 8b02    	vpopeq	{d8}
   6cdd0: e8bd 0700    	popeq.w	{r8, r9, r10}
   6cdd4: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6cdd6: f002 e92c    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x2258
   6cdda: bf00         	nop
   6cddc: fe 64 00 00  	.word	0x000064fe
   6cde0: f4 43 fc ff  	.word	0xfffc43f4
   6cde4: 10 64 00 00  	.word	0x00006410

0006cde8 <math_ceil>:
   6cde8: eeb4 0b40    	vcmp.f64	d0, d0
   6cdec: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cdf0: bf64         	itt	vs
   6cdf2: ed9f 0b0f    	vldrvs	d0, [pc, #60]           @ 0x6ce30 <math_ceil+0x48>
   6cdf6: 4770         	bxvs	lr
   6cdf8: eebd 1bc0    	vcvt.s32.f64	s2, d0
   6cdfc: 2100         	movs	r1, #0x0
   6cdfe: 2200         	movs	r2, #0x0
   6ce00: ee11 0a10    	vmov	r0, s2
   6ce04: eef8 0bc1    	vcvt.f64.s32	d16, s2
   6ce08: eef4 0b40    	vcmp.f64	d16, d0
   6ce0c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ce10: bf18         	it	ne
   6ce12: 2201         	movne	r2, #0x1
   6ce14: eeb5 0b40    	vcmp.f64	d0, #0
   6ce18: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ce1c: bfc8         	it	gt
   6ce1e: 2101         	movgt	r1, #0x1
   6ce20: 4011         	ands	r1, r2
   6ce22: 4408         	add	r0, r1
   6ce24: ee00 0a10    	vmov	s0, r0
   6ce28: eeb8 0bc0    	vcvt.f64.s32	d0, s0
   6ce2c: 4770         	bx	lr
   6ce2e: bf00         	nop
   6ce30: 00 00 00 00  	.word	0x00000000
   6ce34: 00 00 f8 7f  	.word	0x7ff80000

0006ce38 <regress_cal>:
   6ce38: b5f0         	push	{r4, r5, r6, r7, lr}
   6ce3a: af03         	add	r7, sp, #0xc
   6ce3c: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   6ce40: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   6ce44: f5ad 6d78    	sub.w	sp, sp, #0xf80
   6ce48: 4605         	mov	r5, r0
   6ce4a: f8df 0584    	ldr.w	r0, [pc, #0x584]        @ 0x6d3d0 <regress_cal+0x598>
   6ce4e: f50d 6859    	add.w	r8, sp, #0xd90
   6ce52: 468a         	mov	r10, r1
   6ce54: 4478         	add	r0, pc
   6ce56: f44f 71f0    	mov.w	r1, #0x1e0
   6ce5a: f50d 6b3b    	add.w	r11, sp, #0xbb0
   6ce5e: 6800         	ldr	r0, [r0]
   6ce60: 6800         	ldr	r0, [r0]
   6ce62: f847 0c6c    	str	r0, [r7, #-108]
   6ce66: 4640         	mov	r0, r8
   6ce68: f002 e8ca    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2194
   6ce6c: f50d 693b    	add.w	r9, sp, #0xbb0
   6ce70: f44f 71f0    	mov.w	r1, #0x1e0
   6ce74: 4648         	mov	r0, r9
   6ce76: f002 e8c4    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2188
   6ce7a: f244 2028    	movw	r0, #0x4228
   6ce7e: 5c29         	ldrb	r1, [r5, r0]
   6ce80: f505 5037    	add.w	r0, r5, #0x2dc0
   6ce84: 29ff         	cmp	r1, #0xff
   6ce86: 49e3         	ldr	r1, [pc, #0x38c]        @ 0x6d214 <regress_cal+0x3dc>
   6ce88: 4479         	add	r1, pc
   6ce8a: 913d         	str	r1, [sp, #0xf4]
   6ce8c: d032         	beq	0x6cef4 <regress_cal+0xbc> @ imm = #0x64
   6ce8e: 7801         	ldrb	r1, [r0]
   6ce90: 2901         	cmp	r1, #0x1
   6ce92: d03c         	beq	0x6cf0e <regress_cal+0xd6> @ imm = #0x78
   6ce94: 2902         	cmp	r1, #0x2
   6ce96: d12d         	bne	0x6cef4 <regress_cal+0xbc> @ imm = #0x5a
   6ce98: 9a3d         	ldr	r2, [sp, #0xf4]
   6ce9a: f642 6108    	movw	r1, #0x2e08
   6ce9e: 4429         	add	r1, r5
   6cea0: 2600         	movs	r6, #0x0
   6cea2: f8b2 22d2    	ldrh.w	r2, [r2, #0x2d2]
   6cea6: ee00 2a10    	vmov	s0, r2
   6ceaa: 2232         	movs	r2, #0x32
   6ceac: eef8 0b40    	vcvt.f64.u32	d16, s0
   6ceb0: 2a00         	cmp	r2, #0x0
   6ceb2: d059         	beq	0x6cf68 <regress_cal+0x130> @ imm = #0xb2
   6ceb4: f811 3c10    	ldrb	r3, [r1, #-16]
   6ceb8: 2b01         	cmp	r3, #0x1
   6ceba: d118         	bne	0x6ceee <regress_cal+0xb6> @ imm = #0x30
   6cebc: ed51 1b0e    	vldr	d17, [r1, #-56]
   6cec0: edd0 2b04    	vldr	d18, [r0, #16]
   6cec4: ee72 1be1    	vsub.f64	d17, d18, d17
   6cec8: eef4 1b60    	vcmp.f64	d17, d16
   6cecc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6ced0: d80d         	bhi	0x6ceee <regress_cal+0xb6> @ imm = #0x1a
   6ced2: b2f3         	uxtb	r3, r6
   6ced4: 3601         	adds	r6, #0x1
   6ced6: ed51 1b02    	vldr	d17, [r1, #-8]
   6ceda: eb08 04c3    	add.w	r4, r8, r3, lsl #3
   6cede: edd1 2b00    	vldr	d18, [r1]
   6cee2: eb09 03c3    	add.w	r3, r9, r3, lsl #3
   6cee6: edc4 2b00    	vstr	d18, [r4]
   6ceea: edc3 1b00    	vstr	d17, [r3]
   6ceee: 3168         	adds	r1, #0x68
   6cef0: 3a01         	subs	r2, #0x1
   6cef2: e7dd         	b	0x6ceb0 <regress_cal+0x78> @ imm = #-0x46
   6cef4: edd0 0b10    	vldr	d16, [r0, #64]
   6cef8: 2401         	movs	r4, #0x1
   6cefa: edd0 1b12    	vldr	d17, [r0, #72]
   6cefe: f50d 6040    	add.w	r0, sp, #0xc00
   6cf02: 2601         	movs	r6, #0x1
   6cf04: edcb 0b00    	vstr	d16, [r11]
   6cf08: edc0 1b64    	vstr	d17, [r0, #400]
   6cf0c: e030         	b	0x6cf70 <regress_cal+0x138> @ imm = #0x60
   6cf0e: 9a3d         	ldr	r2, [sp, #0xf4]
   6cf10: f642 6108    	movw	r1, #0x2e08
   6cf14: 4429         	add	r1, r5
   6cf16: 2600         	movs	r6, #0x0
   6cf18: f8b2 22d0    	ldrh.w	r2, [r2, #0x2d0]
   6cf1c: ee00 2a10    	vmov	s0, r2
   6cf20: 2232         	movs	r2, #0x32
   6cf22: eef8 0b40    	vcvt.f64.u32	d16, s0
   6cf26: b1fa         	cbz	r2, 0x6cf68 <regress_cal+0x130> @ imm = #0x3e
   6cf28: f811 3c10    	ldrb	r3, [r1, #-16]
   6cf2c: 2b01         	cmp	r3, #0x1
   6cf2e: d118         	bne	0x6cf62 <regress_cal+0x12a> @ imm = #0x30
   6cf30: ed51 1b0e    	vldr	d17, [r1, #-56]
   6cf34: edd0 2b04    	vldr	d18, [r0, #16]
   6cf38: ee72 1be1    	vsub.f64	d17, d18, d17
   6cf3c: eef4 1b60    	vcmp.f64	d17, d16
   6cf40: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cf44: d80d         	bhi	0x6cf62 <regress_cal+0x12a> @ imm = #0x1a
   6cf46: b2f3         	uxtb	r3, r6
   6cf48: 3601         	adds	r6, #0x1
   6cf4a: ed51 1b02    	vldr	d17, [r1, #-8]
   6cf4e: eb08 04c3    	add.w	r4, r8, r3, lsl #3
   6cf52: edd1 2b00    	vldr	d18, [r1]
   6cf56: eb09 03c3    	add.w	r3, r9, r3, lsl #3
   6cf5a: edc4 2b00    	vstr	d18, [r4]
   6cf5e: edc3 1b00    	vstr	d17, [r3]
   6cf62: 3168         	adds	r1, #0x68
   6cf64: 3a01         	subs	r2, #0x1
   6cf66: e7de         	b	0x6cf26 <regress_cal+0xee> @ imm = #-0x44
   6cf68: b2f4         	uxtb	r4, r6
   6cf6a: 2c00         	cmp	r4, #0x0
   6cf6c: f000 8202    	beq.w	0x6d374 <regress_cal+0x53c> @ imm = #0x404
   6cf70: b2f5         	uxtb	r5, r6
   6cf72: f50d 6859    	add.w	r8, sp, #0xd90
   6cf76: 46d9         	mov	r9, r11
   6cf78: 4640         	mov	r0, r8
   6cf7a: 4629         	mov	r1, r5
   6cf7c: f7ff fb90    	bl	0x6c6a0 <math_mean>     @ imm = #-0x8e0
   6cf80: f50d 6b3b    	add.w	r11, sp, #0xbb0
   6cf84: 4629         	mov	r1, r5
   6cf86: eeb0 8b40    	vmov.f64	d8, d0
   6cf8a: 4658         	mov	r0, r11
   6cf8c: f7ff fb88    	bl	0x6c6a0 <math_mean>     @ imm = #-0x8f0
   6cf90: 9a3d         	ldr	r2, [sp, #0xf4]
   6cf92: 4643         	mov	r3, r8
   6cf94: f892 02b0    	ldrb.w	r0, [r2, #0x2b0]
   6cf98: 4285         	cmp	r5, r0
   6cf9a: bf88         	it	hi
   6cf9c: 4606         	movhi	r6, r0
   6cf9e: b2f0         	uxtb	r0, r6
   6cfa0: edd2 0bb2    	vldr	d16, [r2, #712]
   6cfa4: 00e1         	lsls	r1, r4, #0x3
   6cfa6: 465a         	mov	r2, r11
   6cfa8: 4605         	mov	r5, r0
   6cfaa: b15d         	cbz	r5, 0x6cfc4 <regress_cal+0x18c> @ imm = #0x16
   6cfac: 185e         	adds	r6, r3, r1
   6cfae: ecf3 1b02    	vldmia	r3!, {d17}
   6cfb2: 3d01         	subs	r5, #0x1
   6cfb4: edc6 1b00    	vstr	d17, [r6]
   6cfb8: 1856         	adds	r6, r2, r1
   6cfba: ecf2 1b02    	vldmia	r2!, {d17}
   6cfbe: edc6 1b00    	vstr	d17, [r6]
   6cfc2: e7f2         	b	0x6cfaa <regress_cal+0x172> @ imm = #-0x1c
   6cfc4: 1826         	adds	r6, r4, r0
   6cfc6: f50d 6140    	add.w	r1, sp, #0xc00
   6cfca: 9a3d         	ldr	r2, [sp, #0xf4]
   6cfcc: f50d 64fe    	add.w	r4, sp, #0x7f0
   6cfd0: eb08 00c6    	add.w	r0, r8, r6, lsl #3
   6cfd4: edd1 1b64    	vldr	d17, [r1, #400]
   6cfd8: edc0 1b00    	vstr	d17, [r0]
   6cfdc: eb0b 00c6    	add.w	r0, r11, r6, lsl #3
   6cfe0: edd9 1b00    	vldr	d17, [r9]
   6cfe4: edd2 2bb0    	vldr	d18, [r2, #704]
   6cfe8: edc0 1b00    	vstr	d17, [r0]
   6cfec: 1c70         	adds	r0, r6, #0x1
   6cfee: ee78 1b40    	vsub.f64	d17, d8, d0
   6cff2: eb08 01c0    	add.w	r1, r8, r0, lsl #3
   6cff6: eb0b 00c0    	add.w	r0, r11, r0, lsl #3
   6cffa: ee61 0ba0    	vmul.f64	d16, d17, d16
   6cffe: edd2 1bae    	vldr	d17, [r2, #696]
   6d002: ee70 3ba1    	vadd.f64	d19, d16, d17
   6d006: ee70 0ba2    	vadd.f64	d16, d16, d18
   6d00a: edc0 1b00    	vstr	d17, [r0]
   6d00e: 1cb0         	adds	r0, r6, #0x2
   6d010: edc1 3b00    	vstr	d19, [r1]
   6d014: eb08 01c0    	add.w	r1, r8, r0, lsl #3
   6d018: eb0b 00c0    	add.w	r0, r11, r0, lsl #3
   6d01c: edc1 0b00    	vstr	d16, [r1]
   6d020: f44f 7170    	mov.w	r1, #0x3c0
   6d024: edc0 2b00    	vstr	d18, [r0]
   6d028: 4620         	mov	r0, r4
   6d02a: f001 efea    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1fd4
   6d02e: f50d 65c2    	add.w	r5, sp, #0x610
   6d032: f44f 71f0    	mov.w	r1, #0x1e0
   6d036: 4628         	mov	r0, r5
   6d038: f001 efe2    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1fc4
   6d03c: 1cf0         	adds	r0, r6, #0x3
   6d03e: 49e2         	ldr	r1, [pc, #0x388]        @ 0x6d3c8 <regress_cal+0x590>
   6d040: 2200         	movs	r2, #0x0
   6d042: fa5f fb80    	uxtb.w	r11, r0
   6d046: f104 0008    	add.w	r0, r4, #0x8
   6d04a: 465b         	mov	r3, r11
   6d04c: b153         	cbz	r3, 0x6d064 <regress_cal+0x22c> @ imm = #0x14
   6d04e: ecf8 0b02    	vldmia	r8!, {d16}
   6d052: 3b01         	subs	r3, #0x1
   6d054: e940 2102    	strd	r2, r1, [r0, #-8]
   6d058: edc0 0b00    	vstr	d16, [r0]
   6d05c: 3010         	adds	r0, #0x10
   6d05e: e8e5 2102    	strd	r2, r1, [r5], #8
   6d062: e7f3         	b	0x6d04c <regress_cal+0x214> @ imm = #-0x1a
   6d064: f50d 6cbe    	add.w	r12, sp, #0x5f0
   6d068: efc0 0050    	vmov.i32	q8, #0x0
   6d06c: f50d 6efe    	add.w	lr, sp, #0x7f0
   6d070: 2100         	movs	r1, #0x0
   6d072: 4660         	mov	r0, r12
   6d074: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   6d078: f940 0acf    	vst1.64	{d16, d17}, [r0]
   6d07c: 2902         	cmp	r1, #0x2
   6d07e: d021         	beq	0x6d0c4 <regress_cal+0x28c> @ imm = #0x42
   6d080: f50d 60fe    	add.w	r0, sp, #0x7f0
   6d084: 2300         	movs	r3, #0x0
   6d086: 2b02         	cmp	r3, #0x2
   6d088: d018         	beq	0x6d0bc <regress_cal+0x284> @ imm = #0x30
   6d08a: eb0c 1201    	add.w	r2, r12, r1, lsl #4
   6d08e: 4676         	mov	r6, lr
   6d090: eb02 04c3    	add.w	r4, r2, r3, lsl #3
   6d094: 4605         	mov	r5, r0
   6d096: 465a         	mov	r2, r11
   6d098: b16a         	cbz	r2, 0x6d0b6 <regress_cal+0x27e> @ imm = #0x1a
   6d09a: edd5 0b00    	vldr	d16, [r5]
   6d09e: 3510         	adds	r5, #0x10
   6d0a0: edd6 1b00    	vldr	d17, [r6]
   6d0a4: 3610         	adds	r6, #0x10
   6d0a6: edd4 2b00    	vldr	d18, [r4]
   6d0aa: 3a01         	subs	r2, #0x1
   6d0ac: ee41 2ba0    	vmla.f64	d18, d17, d16
   6d0b0: edc4 2b00    	vstr	d18, [r4]
   6d0b4: e7f0         	b	0x6d098 <regress_cal+0x260> @ imm = #-0x20
   6d0b6: 3008         	adds	r0, #0x8
   6d0b8: 3301         	adds	r3, #0x1
   6d0ba: e7e4         	b	0x6d086 <regress_cal+0x24e> @ imm = #-0x38
   6d0bc: f10e 0e08    	add.w	lr, lr, #0x8
   6d0c0: 3101         	adds	r1, #0x1
   6d0c2: e7db         	b	0x6d07c <regress_cal+0x244> @ imm = #-0x4a
   6d0c4: f50d 68fe    	add.w	r8, sp, #0x7f0
   6d0c8: efc0 0050    	vmov.i32	q8, #0x0
   6d0cc: f50d 60bc    	add.w	r0, sp, #0x5e0
   6d0d0: 2100         	movs	r1, #0x0
   6d0d2: 4642         	mov	r2, r8
   6d0d4: f940 0acf    	vst1.64	{d16, d17}, [r0]
   6d0d8: 2902         	cmp	r1, #0x2
   6d0da: d016         	beq	0x6d10a <regress_cal+0x2d2> @ imm = #0x2c
   6d0dc: eb00 03c1    	add.w	r3, r0, r1, lsl #3
   6d0e0: f50d 643b    	add.w	r4, sp, #0xbb0
   6d0e4: 4616         	mov	r6, r2
   6d0e6: 465d         	mov	r5, r11
   6d0e8: b165         	cbz	r5, 0x6d104 <regress_cal+0x2cc> @ imm = #0x18
   6d0ea: ecf4 0b02    	vldmia	r4!, {d16}
   6d0ee: 3d01         	subs	r5, #0x1
   6d0f0: edd6 1b00    	vldr	d17, [r6]
   6d0f4: 3610         	adds	r6, #0x10
   6d0f6: edd3 2b00    	vldr	d18, [r3]
   6d0fa: ee41 2ba0    	vmla.f64	d18, d17, d16
   6d0fe: edc3 2b00    	vstr	d18, [r3]
   6d102: e7f1         	b	0x6d0e8 <regress_cal+0x2b0> @ imm = #-0x1e
   6d104: 3208         	adds	r2, #0x8
   6d106: 3101         	adds	r1, #0x1
   6d108: e7e6         	b	0x6d0d8 <regress_cal+0x2a0> @ imm = #-0x34
   6d10a: f50d 649d    	add.w	r4, sp, #0x4e8
   6d10e: 21e0         	movs	r1, #0xe0
   6d110: f104 0018    	add.w	r0, r4, #0x18
   6d114: f001 ef74    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1ee8
   6d118: 4620         	mov	r0, r4
   6d11a: 21f8         	movs	r1, #0xf8
   6d11c: f7f9 faaa    	bl	0x66674 <clear_mem>     @ imm = #-0x6aac
   6d120: f240 3002    	movw	r0, #0x302
   6d124: 49a9         	ldr	r1, [pc, #0x2a4]        @ 0x6d3cc <regress_cal+0x594>
   6d126: f8ad 05d8    	strh.w	r0, [sp, #0x5d8]
   6d12a: f104 00f8    	add.w	r0, r4, #0xf8
   6d12e: 466a         	mov	r2, sp
   6d130: f8cd a0e8    	str.w	r10, [sp, #0xe8]
   6d134: ecf0 0b0c    	vldmia	r0!, {d16, d17, d18, d19, d20, d21}
   6d138: f104 0010    	add.w	r0, r4, #0x10
   6d13c: ecc4 2b04    	vstmia	r4, {d18, d19}
   6d140: edc4 0b04    	vstr	d16, [r4, #16]
   6d144: edc4 4b0c    	vstr	d20, [r4, #48]
   6d148: edc4 5b0e    	vstr	d21, [r4, #56]
   6d14c: edc4 1b10    	vstr	d17, [r4, #64]
   6d150: f960 078d    	vld1.32	{d16}, [r0]!
   6d154: 3908         	subs	r1, #0x8
   6d156: f942 078d    	vst1.32	{d16}, [r2]!
   6d15a: d1f9         	bne	0x6d150 <regress_cal+0x318> @ imm = #-0xe
   6d15c: f50d 639d    	add.w	r3, sp, #0x4e8
   6d160: cb0f         	ldm	r3, {r0, r1, r2, r3}
   6d162: f000 f979    	bl	0x6d458 <solve_linear>  @ imm = #0x2f2
   6d166: a8c2         	add	r0, sp, #0x308
   6d168: f44f 71f0    	mov.w	r1, #0x1e0
   6d16c: f001 ef48    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1e90
   6d170: a84a         	add	r0, sp, #0x128
   6d172: f44f 71f0    	mov.w	r1, #0x1e0
   6d176: f001 ef44    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1e88
   6d17a: eeb7 db00    	vmov.f64	d13, #1.000000e+00
   6d17e: f108 0008    	add.w	r0, r8, #0x8
   6d182: f50d 7984    	add.w	r9, sp, #0x108
   6d186: f10d 08f8    	add.w	r8, sp, #0xf8
   6d18a: 903c         	str	r0, [sp, #0xf0]
   6d18c: 2000         	movs	r0, #0x0
   6d18e: ef80 8050    	vmov.i32	q4, #0x0
   6d192: ed9f ab87    	vldr	d10, [pc, #540]         @ 0x6d3b0 <regress_cal+0x578>
   6d196: ed9f bb88    	vldr	d11, [pc, #544]         @ 0x6d3b8 <regress_cal+0x580>
   6d19a: ed9f cb89    	vldr	d12, [pc, #548]         @ 0x6d3c0 <regress_cal+0x588>
   6d19e: 2832         	cmp	r0, #0x32
   6d1a0: f000 80f0    	beq.w	0x6d384 <regress_cal+0x54c> @ imm = #0x1e0
   6d1a4: 903d         	str	r0, [sp, #0xf4]
   6d1a6: 4648         	mov	r0, r9
   6d1a8: f900 8acd    	vst1.64	{d8, d9}, [r0]!
   6d1ac: f04f 0e00    	mov.w	lr, #0x0
   6d1b0: f50d 6cfe    	add.w	r12, sp, #0x7f0
   6d1b4: ec9a eb04    	vldmia	r10, {d14, d15}
   6d1b8: f900 8acf    	vst1.64	{d8, d9}, [r0]
   6d1bc: f1be 0f02    	cmp.w	lr, #0x2
   6d1c0: d02a         	beq	0x6d218 <regress_cal+0x3e0> @ imm = #0x54
   6d1c2: f50d 66fe    	add.w	r6, sp, #0x7f0
   6d1c6: 2200         	movs	r2, #0x0
   6d1c8: 2a02         	cmp	r2, #0x2
   6d1ca: d01e         	beq	0x6d20a <regress_cal+0x3d2> @ imm = #0x3c
   6d1cc: eb09 100e    	add.w	r0, r9, lr, lsl #4
   6d1d0: f50d 65c2    	add.w	r5, sp, #0x610
   6d1d4: eb00 04c2    	add.w	r4, r0, r2, lsl #3
   6d1d8: 4661         	mov	r1, r12
   6d1da: 4633         	mov	r3, r6
   6d1dc: 4658         	mov	r0, r11
   6d1de: b188         	cbz	r0, 0x6d204 <regress_cal+0x3cc> @ imm = #0x22
   6d1e0: ecf5 0b02    	vldmia	r5!, {d16}
   6d1e4: 3801         	subs	r0, #0x1
   6d1e6: edd1 1b00    	vldr	d17, [r1]
   6d1ea: 3110         	adds	r1, #0x10
   6d1ec: edd4 2b00    	vldr	d18, [r4]
   6d1f0: ee61 0ba0    	vmul.f64	d16, d17, d16
   6d1f4: edd3 1b00    	vldr	d17, [r3]
   6d1f8: 3310         	adds	r3, #0x10
   6d1fa: ee40 2ba1    	vmla.f64	d18, d16, d17
   6d1fe: edc4 2b00    	vstr	d18, [r4]
   6d202: e7ec         	b	0x6d1de <regress_cal+0x3a6> @ imm = #-0x28
   6d204: 3608         	adds	r6, #0x8
   6d206: 3201         	adds	r2, #0x1
   6d208: e7de         	b	0x6d1c8 <regress_cal+0x390> @ imm = #-0x44
   6d20a: f10c 0c08    	add.w	r12, r12, #0x8
   6d20e: f10e 0e01    	add.w	lr, lr, #0x1
   6d212: e7d3         	b	0x6d1bc <regress_cal+0x384> @ imm = #-0x5a
   6d214: 1c 58 02 00  	.word	0x0002581c
   6d218: f50d 61fe    	add.w	r1, sp, #0x7f0
   6d21c: 2000         	movs	r0, #0x0
   6d21e: f908 8acf    	vst1.64	{d8, d9}, [r8]
   6d222: 2802         	cmp	r0, #0x2
   6d224: d01c         	beq	0x6d260 <regress_cal+0x428> @ imm = #0x38
   6d226: eb08 02c0    	add.w	r2, r8, r0, lsl #3
   6d22a: f50d 63c2    	add.w	r3, sp, #0x610
   6d22e: f50d 643b    	add.w	r4, sp, #0xbb0
   6d232: 460d         	mov	r5, r1
   6d234: 465e         	mov	r6, r11
   6d236: b186         	cbz	r6, 0x6d25a <regress_cal+0x422> @ imm = #0x20
   6d238: ecf3 0b02    	vldmia	r3!, {d16}
   6d23c: 3e01         	subs	r6, #0x1
   6d23e: edd5 1b00    	vldr	d17, [r5]
   6d242: 3510         	adds	r5, #0x10
   6d244: edd2 2b00    	vldr	d18, [r2]
   6d248: ee61 0ba0    	vmul.f64	d16, d17, d16
   6d24c: ecf4 1b02    	vldmia	r4!, {d17}
   6d250: ee40 2ba1    	vmla.f64	d18, d16, d17
   6d254: edc2 2b00    	vstr	d18, [r2]
   6d258: e7ed         	b	0x6d236 <regress_cal+0x3fe> @ imm = #-0x26
   6d25a: 3108         	adds	r1, #0x8
   6d25c: 3001         	adds	r0, #0x1
   6d25e: e7e0         	b	0x6d222 <regress_cal+0x3ea> @ imm = #-0x40
   6d260: f50d 649d    	add.w	r4, sp, #0x4e8
   6d264: 21f8         	movs	r1, #0xf8
   6d266: 4620         	mov	r0, r4
   6d268: f7f9 fa04    	bl	0x66674 <clear_mem>     @ imm = #-0x6bf8
   6d26c: f240 3002    	movw	r0, #0x302
   6d270: 4956         	ldr	r1, [pc, #0x158]        @ 0x6d3cc <regress_cal+0x594>
   6d272: f8ad 05d8    	strh.w	r0, [sp, #0x5d8]
   6d276: a842         	add	r0, sp, #0x108
   6d278: eddd 4b3e    	vldr	d20, [sp, #248]
   6d27c: 466a         	mov	r2, sp
   6d27e: ecf0 0b08    	vldmia	r0!, {d16, d17, d18, d19}
   6d282: f104 0010    	add.w	r0, r4, #0x10
   6d286: eddd 5b40    	vldr	d21, [sp, #256]
   6d28a: ecc4 0b04    	vstmia	r4, {d16, d17}
   6d28e: edc4 4b04    	vstr	d20, [r4, #16]
   6d292: edc4 2b0c    	vstr	d18, [r4, #48]
   6d296: edc4 3b0e    	vstr	d19, [r4, #56]
   6d29a: edc4 5b10    	vstr	d21, [r4, #64]
   6d29e: f8cd a0e8    	str.w	r10, [sp, #0xe8]
   6d2a2: f960 078d    	vld1.32	{d16}, [r0]!
   6d2a6: 3908         	subs	r1, #0x8
   6d2a8: f942 078d    	vst1.32	{d16}, [r2]!
   6d2ac: d1f9         	bne	0x6d2a2 <regress_cal+0x46a> @ imm = #-0xe
   6d2ae: f50d 639d    	add.w	r3, sp, #0x4e8
   6d2b2: cb0f         	ldm	r3, {r0, r1, r2, r3}
   6d2b4: f000 f8d0    	bl	0x6d458 <solve_linear>  @ imm = #0x1a0
   6d2b8: a9c2         	add	r1, sp, #0x308
   6d2ba: aa4a         	add	r2, sp, #0x128
   6d2bc: f50d 603b    	add.w	r0, sp, #0xbb0
   6d2c0: 9b3c         	ldr	r3, [sp, #0xf0]
   6d2c2: 465c         	mov	r4, r11
   6d2c4: b1ec         	cbz	r4, 0x6d302 <regress_cal+0x4ca> @ imm = #0x3a
   6d2c6: edd3 3b00    	vldr	d19, [r3]
   6d2ca: ecda 0b04    	vldmia	r10, {d16, d17}
   6d2ce: ee63 1ba1    	vmul.f64	d17, d19, d17
   6d2d2: ed53 2b02    	vldr	d18, [r3, #-8]
   6d2d6: ee42 1ba0    	vmla.f64	d17, d18, d16
   6d2da: ecf0 0b02    	vldmia	r0!, {d16}
   6d2de: ee70 0be1    	vsub.f64	d16, d16, d17
   6d2e2: eef5 0b40    	vcmp.f64	d16, #0
   6d2e6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d2ea: ece1 0b02    	vstmia	r1!, {d16}
   6d2ee: eef1 1b60    	vneg.f64	d17, d16
   6d2f2: bf48         	it	mi
   6d2f4: eef0 0b61    	vmovmi.f64	d16, d17
   6d2f8: 3310         	adds	r3, #0x10
   6d2fa: 3c01         	subs	r4, #0x1
   6d2fc: ece2 0b02    	vstmia	r2!, {d16}
   6d300: e7e0         	b	0x6d2c4 <regress_cal+0x48c> @ imm = #-0x40
   6d302: a84a         	add	r0, sp, #0x128
   6d304: 4659         	mov	r1, r11
   6d306: f7ff fa4b    	bl	0x6c7a0 <quick_median>  @ imm = #-0xb6a
   6d30a: ef6b 011b    	vorr	d16, d11, d11
   6d30e: f50d 60c2    	add.w	r0, sp, #0x610
   6d312: a9c2         	add	r1, sp, #0x308
   6d314: 465a         	mov	r2, r11
   6d316: ee40 0b0a    	vmla.f64	d16, d0, d10
   6d31a: b1b2         	cbz	r2, 0x6d34a <regress_cal+0x512> @ imm = #0x2c
   6d31c: ecf1 1b02    	vldmia	r1!, {d17}
   6d320: eef0 2b4d    	vmov.f64	d18, d13
   6d324: eec1 1ba0    	vdiv.f64	d17, d17, d16
   6d328: ee41 2be1    	vmls.f64	d18, d17, d17
   6d32c: eef4 1b4d    	vcmp.f64	d17, d13
   6d330: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d334: efc0 1010    	vmov.i32	d17, #0x0
   6d338: ee62 2ba2    	vmul.f64	d18, d18, d18
   6d33c: bf48         	it	mi
   6d33e: eef0 1b62    	vmovmi.f64	d17, d18
   6d342: 3a01         	subs	r2, #0x1
   6d344: ece0 1b02    	vstmia	r0!, {d17}
   6d348: e7e7         	b	0x6d31a <regress_cal+0x4e2> @ imm = #-0x32
   6d34a: ecda 0b04    	vldmia	r10, {d16, d17}
   6d34e: ee71 1bcf    	vsub.f64	d17, d17, d15
   6d352: 983d         	ldr	r0, [sp, #0xf4]
   6d354: 3001         	adds	r0, #0x1
   6d356: ee61 1ba1    	vmul.f64	d17, d17, d17
   6d35a: ee70 0bce    	vsub.f64	d16, d16, d14
   6d35e: ee40 1ba0    	vmla.f64	d17, d16, d16
   6d362: eef1 0be1    	vsqrt.f64	d16, d17
   6d366: eef4 0b4c    	vcmp.f64	d16, d12
   6d36a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d36e: f57f af16    	bpl.w	0x6d19e <regress_cal+0x366> @ imm = #-0x1d4
   6d372: e007         	b	0x6d384 <regress_cal+0x54c> @ imm = #0xe
   6d374: edd0 0b0c    	vldr	d16, [r0, #48]
   6d378: edca 0b00    	vstr	d16, [r10]
   6d37c: edd0 0b0a    	vldr	d16, [r0, #40]
   6d380: edca 0b02    	vstr	d16, [r10, #8]
   6d384: f857 0c6c    	ldr	r0, [r7, #-108]
   6d388: 4912         	ldr	r1, [pc, #0x48]         @ 0x6d3d4 <regress_cal+0x59c>
   6d38a: 4479         	add	r1, pc
   6d38c: 6809         	ldr	r1, [r1]
   6d38e: 6809         	ldr	r1, [r1]
   6d390: 4281         	cmp	r1, r0
   6d392: bf01         	itttt	eq
   6d394: f50d 6d78    	addeq.w	sp, sp, #0xf80
   6d398: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   6d39c: b001         	addeq	sp, #0x4
   6d39e: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   6d3a2: bf08         	it	eq
   6d3a4: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6d3a6: f001 ee44    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x1c88
   6d3aa: bf00         	nop
   6d3ac: bf00         	nop
   6d3ae: bf00         	nop
   6d3b0: 3d 0a d7 a3  	.word	0xa3d70a3d
   6d3b4: 70 bd 12 40  	.word	0x4012bd70
   6d3b8: bc 89 d8 97  	.word	0x97d889bc
   6d3bc: b2 d2 9c 3c  	.word	0x3c9cd2b2
   6d3c0: 8d ed b5 a0  	.word	0xa0b5ed8d
   6d3c4: f7 c6 b0 3e  	.word	0x3eb0c6f7
   6d3c8: 00 00 f0 3f  	.word	0x3ff00000
   6d3cc: e8 00 00 00  	.word	0x000000e8
   6d3d0: 7c 63 00 00  	.word	0x0000637c
   6d3d4: 46 5e 00 00  	.word	0x00005e46

0006d3d8 <check_boundary>:
   6d3d8: 481e         	ldr	r0, [pc, #0x78]         @ 0x6d454 <check_boundary+0x7c>
   6d3da: 4478         	add	r0, pc
   6d3dc: edd0 0bbc    	vldr	d16, [r0, #752]
   6d3e0: eef4 0b41    	vcmp.f64	d16, d1
   6d3e4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d3e8: d832         	bhi	0x6d450 <check_boundary+0x78> @ imm = #0x64
   6d3ea: edd0 2bba    	vldr	d18, [r0, #744]
   6d3ee: eef4 2b41    	vcmp.f64	d18, d1
   6d3f2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d3f6: db2b         	blt	0x6d450 <check_boundary+0x78> @ imm = #0x56
   6d3f8: edd0 3bb8    	vldr	d19, [r0, #736]
   6d3fc: eef4 3b40    	vcmp.f64	d19, d0
   6d400: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d404: d824         	bhi	0x6d450 <check_boundary+0x78> @ imm = #0x48
   6d406: edd0 1bb6    	vldr	d17, [r0, #728]
   6d40a: eef4 1b40    	vcmp.f64	d17, d0
   6d40e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d412: db1d         	blt	0x6d450 <check_boundary+0x78> @ imm = #0x3a
   6d414: ee70 2be2    	vsub.f64	d18, d16, d18
   6d418: ee71 3be3    	vsub.f64	d19, d17, d19
   6d41c: eec3 2ba2    	vdiv.f64	d18, d19, d18
   6d420: ee42 1be0    	vmls.f64	d17, d18, d16
   6d424: edd0 0bbe    	vldr	d16, [r0, #760]
   6d428: ee71 3be0    	vsub.f64	d19, d17, d16
   6d42c: ee42 3b81    	vmla.f64	d19, d18, d1
   6d430: eef4 3b40    	vcmp.f64	d19, d0
   6d434: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d438: d80a         	bhi	0x6d450 <check_boundary+0x78> @ imm = #0x14
   6d43a: ee70 0ba1    	vadd.f64	d16, d16, d17
   6d43e: ee42 0b81    	vmla.f64	d16, d18, d1
   6d442: eef4 0b40    	vcmp.f64	d16, d0
   6d446: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d44a: bfa4         	itt	ge
   6d44c: 2001         	movge	r0, #0x1
   6d44e: 4770         	bxge	lr
   6d450: 2000         	movs	r0, #0x0
   6d452: 4770         	bx	lr
   6d454: ca 52 02 00  	.word	0x000252ca

0006d458 <solve_linear>:
   6d458: b084         	sub	sp, #0x10
   6d45a: b5f0         	push	{r4, r5, r6, r7, lr}
   6d45c: af03         	add	r7, sp, #0xc
   6d45e: e92d 0fe0    	push.w	{r5, r6, r7, r8, r9, r10, r11}
   6d462: f897 c0f8    	ldrb.w	r12, [r7, #0xf8]
   6d466: f107 0408    	add.w	r4, r7, #0x8
   6d46a: c40f         	stm	r4!, {r0, r1, r2, r3}
   6d46c: fa4f f08c    	sxtb.w	r0, r12
   6d470: 2801         	cmp	r0, #0x1
   6d472: bfa2         	ittt	ge
   6d474: f107 0b08    	addge.w	r11, r7, #0x8
   6d478: f99b 00f1    	ldrsbge.w	r0, [r11, #0xf1]
   6d47c: 2801         	cmpge	r0, #0x1
   6d47e: db07         	blt	0x6d490 <solve_linear+0x38> @ imm = #0xe
   6d480: f1bc 0f05    	cmp.w	r12, #0x5
   6d484: bf9c         	itt	ls
   6d486: fa5f f880    	uxtbls.w	r8, r0
   6d48a: f1b8 0f06    	cmpls.w	r8, #0x6
   6d48e: d905         	bls	0x6d49c <solve_linear+0x44> @ imm = #0xa
   6d490: e8bd 0f0e    	pop.w	{r1, r2, r3, r8, r9, r10, r11}
   6d494: e8bd 40f0    	pop.w	{r4, r5, r6, r7, lr}
   6d498: b004         	add	sp, #0x10
   6d49a: 4770         	bx	lr
   6d49c: f1ac 0001    	sub.w	r0, r12, #0x1
   6d4a0: ea4f 05c8    	lsl.w	r5, r8, #0x3
   6d4a4: f10b 0e30    	add.w	lr, r11, #0x30
   6d4a8: 9001         	str	r0, [sp, #0x4]
   6d4aa: f04f 0900    	mov.w	r9, #0x0
   6d4ae: 4659         	mov	r1, r11
   6d4b0: 9801         	ldr	r0, [sp, #0x4]
   6d4b2: 4581         	cmp	r9, r0
   6d4b4: d06c         	beq	0x6d590 <solve_linear+0x138> @ imm = #0xd8
   6d4b6: eb09 0049    	add.w	r0, r9, r9, lsl #1
   6d4ba: f109 0201    	add.w	r2, r9, #0x1
   6d4be: 4676         	mov	r6, lr
   6d4c0: 9202         	str	r2, [sp, #0x8]
   6d4c2: eb0b 1000    	add.w	r0, r11, r0, lsl #4
   6d4c6: eb00 03c9    	add.w	r3, r0, r9, lsl #3
   6d4ca: 4562         	cmp	r2, r12
   6d4cc: d235         	bhs	0x6d53a <solve_linear+0xe2> @ imm = #0x6a
   6d4ce: eb02 0042    	add.w	r0, r2, r2, lsl #1
   6d4d2: eb0b 1000    	add.w	r0, r11, r0, lsl #4
   6d4d6: eb00 00c9    	add.w	r0, r0, r9, lsl #3
   6d4da: edd0 0b00    	vldr	d16, [r0]
   6d4de: eef5 0b40    	vcmp.f64	d16, #0
   6d4e2: eef1 1b60    	vneg.f64	d17, d16
   6d4e6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d4ea: bf48         	it	mi
   6d4ec: eef0 0b61    	vmovmi.f64	d16, d17
   6d4f0: edd3 1b00    	vldr	d17, [r3]
   6d4f4: eef5 1b40    	vcmp.f64	d17, #0
   6d4f8: eef1 2b61    	vneg.f64	d18, d17
   6d4fc: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d500: bf48         	it	mi
   6d502: eef0 1b62    	vmovmi.f64	d17, d18
   6d506: eef4 1b60    	vcmp.f64	d17, d16
   6d50a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d50e: d510         	bpl	0x6d532 <solve_linear+0xda> @ imm = #0x20
   6d510: 4608         	mov	r0, r1
   6d512: 4674         	mov	r4, lr
   6d514: 46c2         	mov	r10, r8
   6d516: f1ba 0f00    	cmp.w	r10, #0x0
   6d51a: d00a         	beq	0x6d532 <solve_linear+0xda> @ imm = #0x14
   6d51c: edd0 0b00    	vldr	d16, [r0]
   6d520: f1aa 0a01    	sub.w	r10, r10, #0x1
   6d524: edd4 1b00    	vldr	d17, [r4]
   6d528: ece0 1b02    	vstmia	r0!, {d17}
   6d52c: ece4 0b02    	vstmia	r4!, {d16}
   6d530: e7f1         	b	0x6d516 <solve_linear+0xbe> @ imm = #-0x1e
   6d532: f10e 0e30    	add.w	lr, lr, #0x30
   6d536: 3201         	adds	r2, #0x1
   6d538: e7c7         	b	0x6d4ca <solve_linear+0x72> @ imm = #-0x72
   6d53a: 9c02         	ldr	r4, [sp, #0x8]
   6d53c: 46b6         	mov	lr, r6
   6d53e: 4632         	mov	r2, r6
   6d540: 4564         	cmp	r4, r12
   6d542: d21f         	bhs	0x6d584 <solve_linear+0x12c> @ imm = #0x3e
   6d544: eb04 0044    	add.w	r0, r4, r4, lsl #1
   6d548: edd3 1b00    	vldr	d17, [r3]
   6d54c: eb0b 1000    	add.w	r0, r11, r0, lsl #4
   6d550: eb00 00c9    	add.w	r0, r0, r9, lsl #3
   6d554: edd0 0b00    	vldr	d16, [r0]
   6d558: 2000         	movs	r0, #0x0
   6d55a: eef1 0b60    	vneg.f64	d16, d16
   6d55e: eec0 0ba1    	vdiv.f64	d16, d16, d17
   6d562: 4285         	cmp	r5, r0
   6d564: d00b         	beq	0x6d57e <solve_linear+0x126> @ imm = #0x16
   6d566: 180e         	adds	r6, r1, r0
   6d568: edd6 1b00    	vldr	d17, [r6]
   6d56c: 1816         	adds	r6, r2, r0
   6d56e: 3008         	adds	r0, #0x8
   6d570: edd6 2b00    	vldr	d18, [r6]
   6d574: ee40 2ba1    	vmla.f64	d18, d16, d17
   6d578: edc6 2b00    	vstr	d18, [r6]
   6d57c: e7f1         	b	0x6d562 <solve_linear+0x10a> @ imm = #-0x1e
   6d57e: 3230         	adds	r2, #0x30
   6d580: 3401         	adds	r4, #0x1
   6d582: e7dd         	b	0x6d540 <solve_linear+0xe8> @ imm = #-0x46
   6d584: f8dd 9008    	ldr.w	r9, [sp, #0x8]
   6d588: 3130         	adds	r1, #0x30
   6d58a: f10e 0e30    	add.w	lr, lr, #0x30
   6d58e: e78f         	b	0x6d4b0 <solve_linear+0x58> @ imm = #-0xe2
   6d590: ebcc 00cc    	rsb	r0, r12, r12, lsl #3
   6d594: f8d7 9100    	ldr.w	r9, [r7, #0x100]
   6d598: 9901         	ldr	r1, [sp, #0x4]
   6d59a: f1a8 0401    	sub.w	r4, r8, #0x1
   6d59e: eb0b 00c0    	add.w	r0, r11, r0, lsl #3
   6d5a2: eb09 0ecc    	add.w	lr, r9, r12, lsl #3
   6d5a6: f1a0 0a30    	sub.w	r10, r0, #0x30
   6d5aa: 2900         	cmp	r1, #0x0
   6d5ac: f53f af70    	bmi.w	0x6d490 <solve_linear+0x38> @ imm = #-0x120
   6d5b0: eb01 0041    	add.w	r0, r1, r1, lsl #1
   6d5b4: eb09 02c1    	add.w	r2, r9, r1, lsl #3
   6d5b8: 4676         	mov	r6, lr
   6d5ba: 4653         	mov	r3, r10
   6d5bc: eb0b 1500    	add.w	r5, r11, r0, lsl #4
   6d5c0: eb05 00c4    	add.w	r0, r5, r4, lsl #3
   6d5c4: edd0 0b00    	vldr	d16, [r0]
   6d5c8: 4660         	mov	r0, r12
   6d5ca: 42a0         	cmp	r0, r4
   6d5cc: edc2 0b00    	vstr	d16, [r2]
   6d5d0: da07         	bge	0x6d5e2 <solve_linear+0x18a> @ imm = #0xe
   6d5d2: ecf6 1b02    	vldmia	r6!, {d17}
   6d5d6: 3001         	adds	r0, #0x1
   6d5d8: ecf3 2b02    	vldmia	r3!, {d18}
   6d5dc: ee42 0be1    	vmls.f64	d16, d18, d17
   6d5e0: e7f3         	b	0x6d5ca <solve_linear+0x172> @ imm = #-0x1a
   6d5e2: eb05 00c1    	add.w	r0, r5, r1, lsl #3
   6d5e6: f1ae 0e08    	sub.w	lr, lr, #0x8
   6d5ea: f1ac 0c01    	sub.w	r12, r12, #0x1
   6d5ee: f1aa 0a38    	sub.w	r10, r10, #0x38
   6d5f2: edd0 1b00    	vldr	d17, [r0]
   6d5f6: 3901         	subs	r1, #0x1
   6d5f8: eec0 0ba1    	vdiv.f64	d16, d16, d17
   6d5fc: edc2 0b00    	vstr	d16, [r2]
   6d600: e7d3         	b	0x6d5aa <solve_linear+0x152> @ imm = #-0x5a
   6d602: d4d4         	bmi	0x6d5ae <solve_linear+0x156> @ imm = #-0x58
   6d604: d4d4         	bmi	0x6d5b0 <solve_linear+0x158> @ imm = #-0x58
   6d606: d4d4         	bmi	0x6d5b2 <solve_linear+0x15a> @ imm = #-0x58

0006d608 <apply_simple_smooth>:
   6d608: b5f0         	push	{r4, r5, r6, r7, lr}
   6d60a: af03         	add	r7, sp, #0xc
   6d60c: f84d 8d04    	str	r8, [sp, #-4]!
   6d610: ed2d 8b02    	vpush	{d8}
   6d614: b0b8         	sub	sp, #0xe0
   6d616: 4605         	mov	r5, r0
   6d618: 4845         	ldr	r0, [pc, #0x114]        @ 0x6d730 <apply_simple_smooth+0x128>
   6d61a: 4688         	mov	r8, r1
   6d61c: 4614         	mov	r4, r2
   6d61e: 4478         	add	r0, pc
   6d620: 2238         	movs	r2, #0x38
   6d622: 6800         	ldr	r0, [r0]
   6d624: 6800         	ldr	r0, [r0]
   6d626: 9037         	str	r0, [sp, #0xdc]
   6d628: a828         	add	r0, sp, #0xa0
   6d62a: 4942         	ldr	r1, [pc, #0x108]        @ 0x6d734 <apply_simple_smooth+0x12c>
   6d62c: 4479         	add	r1, pc
   6d62e: f001 ecf0    	blx	0x6f010 <sincos+0x6f010> @ imm = #0x19e0
   6d632: 4841         	ldr	r0, [pc, #0x104]        @ 0x6d738 <apply_simple_smooth+0x130>
   6d634: 4478         	add	r0, pc
   6d636: f890 1210    	ldrb.w	r1, [r0, #0x210]
   6d63a: 42a9         	cmp	r1, r5
   6d63c: d90d         	bls	0x6d65a <apply_simple_smooth+0x52> @ imm = #0x1a
   6d63e: eb08 00c1    	add.w	r0, r8, r1, lsl #3
   6d642: 2100         	movs	r1, #0x0
   6d644: 3838         	subs	r0, #0x38
   6d646: 2938         	cmp	r1, #0x38
   6d648: d05e         	beq	0x6d708 <apply_simple_smooth+0x100> @ imm = #0xbc
   6d64a: 1843         	adds	r3, r0, r1
   6d64c: 1862         	adds	r2, r4, r1
   6d64e: 3108         	adds	r1, #0x8
   6d650: edd3 0b00    	vldr	d16, [r3]
   6d654: edc2 0b00    	vstr	d16, [r2]
   6d658: e7f5         	b	0x6d646 <apply_simple_smooth+0x3e> @ imm = #-0x16
   6d65a: 4640         	mov	r0, r8
   6d65c: f7fe ffd8    	bl	0x6c610 <math_std>      @ imm = #-0x1050
   6d660: eddf 0b31    	vldr	d16, [pc, #196]         @ 0x6d728 <apply_simple_smooth+0x120>
   6d664: eeb4 0b60    	vcmp.f64	d0, d16
   6d668: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6d66c: d50c         	bpl	0x6d688 <apply_simple_smooth+0x80> @ imm = #0x18
   6d66e: f108 0018    	add.w	r0, r8, #0x18
   6d672: 2100         	movs	r1, #0x0
   6d674: 2938         	cmp	r1, #0x38
   6d676: d047         	beq	0x6d708 <apply_simple_smooth+0x100> @ imm = #0x8e
   6d678: 1843         	adds	r3, r0, r1
   6d67a: 1862         	adds	r2, r4, r1
   6d67c: 3108         	adds	r1, #0x8
   6d67e: edd3 0b00    	vldr	d16, [r3]
   6d682: edc2 0b00    	vstr	d16, [r2]
   6d686: e7f5         	b	0x6d674 <apply_simple_smooth+0x6c> @ imm = #-0x16
   6d688: ad14         	add	r5, sp, #0x50
   6d68a: 2150         	movs	r1, #0x50
   6d68c: eeb0 8b40    	vmov.f64	d8, d0
   6d690: 4628         	mov	r0, r5
   6d692: f001 ecb6    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x196c
   6d696: 466e         	mov	r6, sp
   6d698: 2150         	movs	r1, #0x50
   6d69a: 4630         	mov	r0, r6
   6d69c: f001 ecb0    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1960
   6d6a0: eeb0 0b48    	vmov.f64	d0, d8
   6d6a4: a928         	add	r1, sp, #0xa0
   6d6a6: 4640         	mov	r0, r8
   6d6a8: 4632         	mov	r2, r6
   6d6aa: f7ff fb07    	bl	0x6ccbc <smooth_sg>     @ imm = #-0x9f2
   6d6ae: 2000         	movs	r0, #0x0
   6d6b0: 2850         	cmp	r0, #0x50
   6d6b2: d007         	beq	0x6d6c4 <apply_simple_smooth+0xbc> @ imm = #0xe
   6d6b4: 1832         	adds	r2, r6, r0
   6d6b6: 1829         	adds	r1, r5, r0
   6d6b8: 3008         	adds	r0, #0x8
   6d6ba: edd2 0b00    	vldr	d16, [r2]
   6d6be: edc1 0b00    	vstr	d16, [r1]
   6d6c2: e7f5         	b	0x6d6b0 <apply_simple_smooth+0xa8> @ imm = #-0x16
   6d6c4: eef6 0b00    	vmov.f64	d16, #5.000000e-01
   6d6c8: f105 0008    	add.w	r0, r5, #0x8
   6d6cc: 2100         	movs	r1, #0x0
   6d6ce: 2940         	cmp	r1, #0x40
   6d6d0: d00d         	beq	0x6d6ee <apply_simple_smooth+0xe6> @ imm = #0x1a
   6d6d2: 1873         	adds	r3, r6, r1
   6d6d4: 1842         	adds	r2, r0, r1
   6d6d6: 3108         	adds	r1, #0x8
   6d6d8: edd3 1b00    	vldr	d17, [r3]
   6d6dc: edd3 2b04    	vldr	d18, [r3, #16]
   6d6e0: ee71 1ba2    	vadd.f64	d17, d17, d18
   6d6e4: ee61 1ba0    	vmul.f64	d17, d17, d16
   6d6e8: edc2 1b00    	vstr	d17, [r2]
   6d6ec: e7ef         	b	0x6d6ce <apply_simple_smooth+0xc6> @ imm = #-0x22
   6d6ee: f105 0018    	add.w	r0, r5, #0x18
   6d6f2: 2100         	movs	r1, #0x0
   6d6f4: 2938         	cmp	r1, #0x38
   6d6f6: d007         	beq	0x6d708 <apply_simple_smooth+0x100> @ imm = #0xe
   6d6f8: 1843         	adds	r3, r0, r1
   6d6fa: 1862         	adds	r2, r4, r1
   6d6fc: 3108         	adds	r1, #0x8
   6d6fe: edd3 0b00    	vldr	d16, [r3]
   6d702: edc2 0b00    	vstr	d16, [r2]
   6d706: e7f5         	b	0x6d6f4 <apply_simple_smooth+0xec> @ imm = #-0x16
   6d708: 9837         	ldr	r0, [sp, #0xdc]
   6d70a: 490c         	ldr	r1, [pc, #0x30]         @ 0x6d73c <apply_simple_smooth+0x134>
   6d70c: 4479         	add	r1, pc
   6d70e: 6809         	ldr	r1, [r1]
   6d710: 6809         	ldr	r1, [r1]
   6d712: 4281         	cmp	r1, r0
   6d714: bf01         	itttt	eq
   6d716: b038         	addeq	sp, #0xe0
   6d718: ecbd 8b02    	vpopeq	{d8}
   6d71c: f85d 8b04    	ldreq	r8, [sp], #4
   6d720: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6d722: f001 ec86    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x190c
   6d726: bf00         	nop
   6d728: f1 68 e3 88  	.word	0x88e368f1
   6d72c: b5 f8 e4 3e  	.word	0x3ee4f8b5
   6d730: b2 5b 00 00  	.word	0x00005bb2
   6d734: 10 3b fc ff  	.word	0xfffc3b10
   6d738: 70 50 02 00  	.word	0x00025070
   6d73c: c4 5a 00 00  	.word	0x00005ac4

0006d740 <smooth1q_err16>:
   6d740: b5f0         	push	{r4, r5, r6, r7, lr}
   6d742: af03         	add	r7, sp, #0xc
   6d744: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   6d748: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   6d74c: f5ad 6d9d    	sub.w	sp, sp, #0x4e8
   6d750: 9201         	str	r2, [sp, #0x4]
   6d752: 4682         	mov	r10, r0
   6d754: 487c         	ldr	r0, [pc, #0x1f0]        @ 0x6d948 <smooth1q_err16+0x208>
   6d756: 468b         	mov	r11, r1
   6d758: f44f 71c8    	mov.w	r1, #0x190
   6d75c: 4478         	add	r0, pc
   6d75e: 6800         	ldr	r0, [r0]
   6d760: 6800         	ldr	r0, [r0]
   6d762: f847 0c68    	str	r0, [r7, #-104]
   6d766: aed4         	add	r6, sp, #0x350
   6d768: 4630         	mov	r0, r6
   6d76a: f001 ec4a    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1894
   6d76e: ee00 ba10    	vmov	s0, r11
   6d772: ed9f 9b6d    	vldr	d9, [pc, #436]          @ 0x6d928 <smooth1q_err16+0x1e8>
   6d776: eeb0 ab00    	vmov.f64	d10, #2.000000e+00
   6d77a: ea4f 044b    	lsl.w	r4, r11, #0x1
   6d77e: 2500         	movs	r5, #0x0
   6d780: eeb8 8b40    	vcvt.f64.u32	d8, s0
   6d784: 42ac         	cmp	r4, r5
   6d786: d015         	beq	0x6d7b4 <smooth1q_err16+0x74> @ imm = #0x2a
   6d788: ee00 5a10    	vmov	s0, r5
   6d78c: eef8 0bc0    	vcvt.f64.s32	d16, s0
   6d790: ee60 0b89    	vmul.f64	d16, d16, d9
   6d794: eec0 0b88    	vdiv.f64	d16, d16, d8
   6d798: ec51 0b30    	vmov	r0, r1, d16
   6d79c: f001 ec98    	blx	0x6f0d0 <sincos+0x6f0d0> @ imm = #0x1930
   6d7a0: ec41 0b30    	vmov	d16, r0, r1
   6d7a4: 3502         	adds	r5, #0x2
   6d7a6: ee70 0ba0    	vadd.f64	d16, d16, d16
   6d7aa: ee7a 0b60    	vsub.f64	d16, d10, d16
   6d7ae: ece6 0b02    	vstmia	r6!, {d16}
   6d7b2: e7e7         	b	0x6d784 <smooth1q_err16+0x44> @ imm = #-0x32
   6d7b4: a80c         	add	r0, sp, #0x30
   6d7b6: f44f 7148    	mov.w	r1, #0x320
   6d7ba: f001 ec22    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1844
   6d7be: eeb7 bb00    	vmov.f64	d11, #1.000000e+00
   6d7c2: ac0a         	add	r4, sp, #0x28
   6d7c4: ae08         	add	r6, sp, #0x20
   6d7c6: f04f 0800    	mov.w	r8, #0x0
   6d7ca: ef80 9010    	vmov.i32	d9, #0x0
   6d7ce: ed9f cb5a    	vldr	d12, [pc, #360]         @ 0x6d938 <smooth1q_err16+0x1f8>
   6d7d2: efc0 1010    	vmov.i32	d17, #0x0
   6d7d6: 45d8         	cmp	r8, r11
   6d7d8: d054         	beq	0x6d884 <smooth1q_err16+0x144> @ imm = #0xa8
   6d7da: eddf 0b55    	vldr	d16, [pc, #340]         @ 0x6d930 <smooth1q_err16+0x1f0>
   6d7de: ef80 e010    	vmov.i32	d14, #0x0
   6d7e2: ef80 d010    	vmov.i32	d13, #0x0
   6d7e6: 4655         	mov	r5, r10
   6d7e8: ee21 aba0    	vmul.f64	d10, d17, d16
   6d7ec: 46d9         	mov	r9, r11
   6d7ee: ef80 f010    	vmov.i32	d15, #0x0
   6d7f2: edcd 1b02    	vstr	d17, [sp, #8]
   6d7f6: f1b9 0f00    	cmp.w	r9, #0x0
   6d7fa: d020         	beq	0x6d83e <smooth1q_err16+0xfe> @ imm = #0x40
   6d7fc: ee6a 0b0d    	vmul.f64	d16, d10, d13
   6d800: 4622         	mov	r2, r4
   6d802: 4633         	mov	r3, r6
   6d804: eec0 0b88    	vdiv.f64	d16, d16, d8
   6d808: ec51 0b30    	vmov	r0, r1, d16
   6d80c: f001 ec50    	blx	0x6f0b0 <sincos+0x6f0b0> @ imm = #0x18a0
   6d810: eddd 0b08    	vldr	d16, [sp, #32]
   6d814: f1a9 0901    	sub.w	r9, r9, #0x1
   6d818: ecf5 2b02    	vldmia	r5!, {d18}
   6d81c: ee60 1b89    	vmul.f64	d17, d16, d9
   6d820: eddd 3b0a    	vldr	d19, [sp, #40]
   6d824: ee3d db0b    	vadd.f64	d13, d13, d11
   6d828: ee42 1ba3    	vmla.f64	d17, d18, d19
   6d82c: ee3e eb21    	vadd.f64	d14, d14, d17
   6d830: ee63 1b8c    	vmul.f64	d17, d19, d12
   6d834: ee42 1ba0    	vmla.f64	d17, d18, d16
   6d838: ee3f fb21    	vadd.f64	d15, d15, d17
   6d83c: e7db         	b	0x6d7f6 <smooth1q_err16+0xb6> @ imm = #-0x4a
   6d83e: a8d4         	add	r0, sp, #0x350
   6d840: eef0 2b4b    	vmov.f64	d18, d11
   6d844: eb00 00c8    	add.w	r0, r0, r8, lsl #3
   6d848: edd0 0b00    	vldr	d16, [r0]
   6d84c: a80c         	add	r0, sp, #0x30
   6d84e: eb00 1008    	add.w	r0, r0, r8, lsl #4
   6d852: f108 0801    	add.w	r8, r8, #0x1
   6d856: ee60 1b88    	vmul.f64	d17, d16, d8
   6d85a: ee41 2ba0    	vmla.f64	d18, d17, d16
   6d85e: eecb 0b22    	vdiv.f64	d16, d11, d18
   6d862: ee6f 1b09    	vmul.f64	d17, d15, d9
   6d866: ee6e 2b0c    	vmul.f64	d18, d14, d12
   6d86a: ee40 1b8e    	vmla.f64	d17, d16, d14
   6d86e: ee40 2b8f    	vmla.f64	d18, d16, d15
   6d872: edc0 1b02    	vstr	d17, [r0, #8]
   6d876: eddd 1b02    	vldr	d17, [sp, #8]
   6d87a: edc0 2b00    	vstr	d18, [r0]
   6d87e: ee71 1b8b    	vadd.f64	d17, d17, d11
   6d882: e7a8         	b	0x6d7d6 <smooth1q_err16+0x96> @ imm = #-0xb0
   6d884: ed9f 9b2e    	vldr	d9, [pc, #184]          @ 0x6d940 <smooth1q_err16+0x200>
   6d888: f10d 0a18    	add.w	r10, sp, #0x18
   6d88c: f10d 0910    	add.w	r9, sp, #0x10
   6d890: a80c         	add	r0, sp, #0x30
   6d892: 2500         	movs	r5, #0x0
   6d894: 3008         	adds	r0, #0x8
   6d896: 9002         	str	r0, [sp, #0x8]
   6d898: 455d         	cmp	r5, r11
   6d89a: d032         	beq	0x6d902 <smooth1q_err16+0x1c2> @ imm = #0x64
   6d89c: ef80 a010    	vmov.i32	d10, #0x0
   6d8a0: 2400         	movs	r4, #0x0
   6d8a2: 9e02         	ldr	r6, [sp, #0x8]
   6d8a4: 46d8         	mov	r8, r11
   6d8a6: f1bb 0f00    	cmp.w	r11, #0x0
   6d8aa: d022         	beq	0x6d8f2 <smooth1q_err16+0x1b2> @ imm = #0x44
   6d8ac: ee00 4a10    	vmov	s0, r4
   6d8b0: 4652         	mov	r2, r10
   6d8b2: 464b         	mov	r3, r9
   6d8b4: eef8 0bc0    	vcvt.f64.s32	d16, s0
   6d8b8: ee60 0b89    	vmul.f64	d16, d16, d9
   6d8bc: eec0 0b88    	vdiv.f64	d16, d16, d8
   6d8c0: ec51 0b30    	vmov	r0, r1, d16
   6d8c4: f001 ebf4    	blx	0x6f0b0 <sincos+0x6f0b0> @ imm = #0x17e8
   6d8c8: ed56 0b02    	vldr	d16, [r6, #-8]
   6d8cc: 442c         	add	r4, r5
   6d8ce: eddd 2b04    	vldr	d18, [sp, #16]
   6d8d2: f1ab 0b01    	sub.w	r11, r11, #0x1
   6d8d6: edd6 1b00    	vldr	d17, [r6]
   6d8da: 3610         	adds	r6, #0x10
   6d8dc: ee60 0ba2    	vmul.f64	d16, d16, d18
   6d8e0: eddd 2b06    	vldr	d18, [sp, #24]
   6d8e4: ee42 0be1    	vmls.f64	d16, d18, d17
   6d8e8: eec0 0b88    	vdiv.f64	d16, d16, d8
   6d8ec: ee3a ab20    	vadd.f64	d10, d10, d16
   6d8f0: e7d9         	b	0x6d8a6 <smooth1q_err16+0x166> @ imm = #-0x4e
   6d8f2: 9801         	ldr	r0, [sp, #0x4]
   6d8f4: 46c3         	mov	r11, r8
   6d8f6: eb00 00c5    	add.w	r0, r0, r5, lsl #3
   6d8fa: 3501         	adds	r5, #0x1
   6d8fc: ed80 ab00    	vstr	d10, [r0]
   6d900: e7ca         	b	0x6d898 <smooth1q_err16+0x158> @ imm = #-0x6c
   6d902: f857 0c68    	ldr	r0, [r7, #-104]
   6d906: 4911         	ldr	r1, [pc, #0x44]         @ 0x6d94c <smooth1q_err16+0x20c>
   6d908: 4479         	add	r1, pc
   6d90a: 6809         	ldr	r1, [r1]
   6d90c: 6809         	ldr	r1, [r1]
   6d90e: 4281         	cmp	r1, r0
   6d910: bf01         	itttt	eq
   6d912: f50d 6d9d    	addeq.w	sp, sp, #0x4e8
   6d916: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   6d91a: b001         	addeq	sp, #0x4
   6d91c: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   6d920: bf08         	it	eq
   6d922: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6d924: f001 eb84    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x1708
   6d928: 18 2d 44 54  	.word	0x54442d18
   6d92c: fb 21 09 40  	.word	0x400921fb
   6d930: 18 2d 44 54  	.word	0x54442d18
   6d934: fb 21 19 c0  	.word	0xc01921fb
   6d938: 00 00 00 00  	.word	0x00000000
   6d93c: 00 00 00 80  	.word	0x80000000
   6d940: 18 2d 44 54  	.word	0x54442d18
   6d944: fb 21 19 40  	.word	0x401921fb
   6d948: 74 5a 00 00  	.word	0x00005a74
   6d94c: c8 58 00 00  	.word	0x000058c8

0006d950 <f_cgm_trend>:
   6d950: b5f0         	push	{r4, r5, r6, r7, lr}
   6d952: af03         	add	r7, sp, #0xc
   6d954: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   6d958: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   6d95c: f5ad 5d49    	sub.w	sp, sp, #0x3240
   6d960: b08e         	sub	sp, #0x38
   6d962: 4682         	mov	r10, r0
   6d964: f8df 0768    	ldr.w	r0, [pc, #0x768]        @ 0x6e0d0 <f_cgm_trend+0x780>
   6d968: f50d 59b9    	add.w	r9, sp, #0x1720
   6d96c: f641 3108    	movw	r1, #0x1b08
   6d970: 4478         	add	r0, pc
   6d972: 461e         	mov	r6, r3
   6d974: 4615         	mov	r5, r2
   6d976: 6800         	ldr	r0, [r0]
   6d978: 6800         	ldr	r0, [r0]
   6d97a: f847 0c6c    	str	r0, [r7, #-108]
   6d97e: 6bf8         	ldr	r0, [r7, #0x3c]
   6d980: f847 0c74    	str	r0, [r7, #-116]
   6d984: 6bb8         	ldr	r0, [r7, #0x38]
   6d986: f847 0c78    	str	r0, [r7, #-120]
   6d98a: 6b78         	ldr	r0, [r7, #0x34]
   6d98c: f847 0c7c    	str	r0, [r7, #-124]
   6d990: 6b38         	ldr	r0, [r7, #0x30]
   6d992: f847 0c80    	str	r0, [r7, #-128]
   6d996: 6af8         	ldr	r0, [r7, #0x2c]
   6d998: f847 0c84    	str	r0, [r7, #-132]
   6d99c: 6ab8         	ldr	r0, [r7, #0x28]
   6d99e: f847 0c88    	str	r0, [r7, #-136]
   6d9a2: 6a78         	ldr	r0, [r7, #0x24]
   6d9a4: f847 0c8c    	str	r0, [r7, #-140]
   6d9a8: 6a38         	ldr	r0, [r7, #0x20]
   6d9aa: f847 0c90    	str	r0, [r7, #-144]
   6d9ae: 69f8         	ldr	r0, [r7, #0x1c]
   6d9b0: f847 0c94    	str	r0, [r7, #-148]
   6d9b4: 69b8         	ldr	r0, [r7, #0x18]
   6d9b6: f847 0c98    	str	r0, [r7, #-152]
   6d9ba: 6978         	ldr	r0, [r7, #0x14]
   6d9bc: f847 0c9c    	str	r0, [r7, #-156]
   6d9c0: 6938         	ldr	r0, [r7, #0x10]
   6d9c2: f847 0ca0    	str	r0, [r7, #-160]
   6d9c6: 68f8         	ldr	r0, [r7, #0xc]
   6d9c8: f847 0ca4    	str	r0, [r7, #-164]
   6d9cc: 68b8         	ldr	r0, [r7, #0x8]
   6d9ce: f847 0ca8    	str	r0, [r7, #-168]
   6d9d2: f8ba b648    	ldrh.w	r11, [r10, #0x648]
   6d9d6: 48dd         	ldr	r0, [pc, #0x374]        @ 0x6dd4c <f_cgm_trend+0x3fc>
   6d9d8: e947 232c    	strd	r2, r3, [r7, #-176]
   6d9dc: 4478         	add	r0, pc
   6d9de: 8804         	ldrh	r4, [r0]
   6d9e0: 4648         	mov	r0, r9
   6d9e2: f001 eb0e    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x161c
   6d9e6: edd7 0b02    	vldr	d16, [r7, #8]
   6d9ea: ec46 5b1a    	vmov	d10, r5, r6
   6d9ee: 4ad8         	ldr	r2, [pc, #0x360]        @ 0x6dd50 <f_cgm_trend+0x400>
   6d9f0: f20a 664a    	addw	r6, r10, #0x64a
   6d9f4: eebd 0be0    	vcvt.s32.f64	s0, d16
   6d9f8: e9d7 5c10    	ldrd	r5, r12, [r7, #64]
   6d9fc: 2100         	movs	r1, #0x0
   6d9fe: ee10 0a10    	vmov	r0, s0
   6da02: ed97 8b0c    	vldr	d8, [r7, #48]
   6da06: 1a20         	subs	r0, r4, r0
   6da08: ed97 9b0a    	vldr	d9, [r7, #40]
   6da0c: edd7 0b04    	vldr	d16, [r7, #16]
   6da10: b152         	cbz	r2, 0x6da28 <f_cgm_trend+0xd8> @ imm = #0x14
   6da12: 18b3         	adds	r3, r6, r2
   6da14: f8b3 36c2    	ldrh.w	r3, [r3, #0x6c2]
   6da18: b123         	cbz	r3, 0x6da24 <f_cgm_trend+0xd4> @ imm = #0x8
   6da1a: 4298         	cmp	r0, r3
   6da1c: dc02         	bgt	0x6da24 <f_cgm_trend+0xd4> @ imm = #0x4
   6da1e: 42a3         	cmp	r3, r4
   6da20: bf98         	it	ls
   6da22: 3101         	addls	r1, #0x1
   6da24: 3202         	adds	r2, #0x2
   6da26: e7f3         	b	0x6da10 <f_cgm_trend+0xc0> @ imm = #-0x1a
   6da28: fa1f f881    	uxth.w	r8, r1
   6da2c: ee00 8a10    	vmov	s0, r8
   6da30: eef8 1b40    	vcvt.f64.u32	d17, s0
   6da34: eef4 0b61    	vcmp.f64	d16, d17
   6da38: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6da3c: d911         	bls	0x6da62 <f_cgm_trend+0x112> @ imm = #0x22
   6da3e: f1bb 0f02    	cmp.w	r11, #0x2
   6da42: d348         	blo	0x6dad6 <f_cgm_trend+0x186> @ imm = #0x90
   6da44: edd5 0b02    	vldr	d16, [r5, #8]
   6da48: f1bc 0f02    	cmp.w	r12, #0x2
   6da4c: edc5 0b00    	vstr	d16, [r5]
   6da50: f040 81b7    	bne.w	0x6ddc2 <f_cgm_trend+0x472> @ imm = #0x36e
   6da54: 48bf         	ldr	r0, [pc, #0x2fc]        @ 0x6dd54 <f_cgm_trend+0x404>
   6da56: 4450         	add	r0, r10
   6da58: edd0 0b00    	vldr	d16, [r0]
   6da5c: edc5 0b16    	vstr	d16, [r5, #88]
   6da60: e1b5         	b	0x6ddce <f_cgm_trend+0x47e> @ imm = #0x36a
   6da62: f240 3061    	movw	r0, #0x361
   6da66: eba0 0308    	sub.w	r3, r0, r8
   6da6a: f64c 11c0    	movw	r1, #0xc9c0
   6da6e: ed9f bbba    	vldr	d11, [pc, #744]         @ 0x6dd58 <f_cgm_trend+0x408>
   6da72: eb0a 00c3    	add.w	r0, r10, r3, lsl #3
   6da76: 46de         	mov	lr, r11
   6da78: 4408         	add	r0, r1
   6da7a: f04f 0b00    	mov.w	r11, #0x0
   6da7e: 4645         	mov	r5, r8
   6da80: 4641         	mov	r1, r8
   6da82: b1a9         	cbz	r1, 0x6dab0 <f_cgm_trend+0x160> @ imm = #0x2a
   6da84: edd0 0b00    	vldr	d16, [r0]
   6da88: eef0 1be0    	vabs.f64	d17, d16
   6da8c: eef4 1b4b    	vcmp.f64	d17, d11
   6da90: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6da94: d009         	beq	0x6daaa <f_cgm_trend+0x15a> @ imm = #0x12
   6da96: d608         	bvs	0x6daaa <f_cgm_trend+0x15a> @ imm = #0x10
   6da98: e7ff         	b	0x6da9a <f_cgm_trend+0x14a> @ imm = #-0x2
   6da9a: fa1f f28b    	uxth.w	r2, r11
   6da9e: f10b 0b01    	add.w	r11, r11, #0x1
   6daa2: eb09 02c2    	add.w	r2, r9, r2, lsl #3
   6daa6: edc2 0b00    	vstr	d16, [r2]
   6daaa: 3008         	adds	r0, #0x8
   6daac: 3901         	subs	r1, #0x1
   6daae: e7e8         	b	0x6da82 <f_cgm_trend+0x132> @ imm = #-0x30
   6dab0: f1bc 0f00    	cmp.w	r12, #0x0
   6dab4: e9cd 6e01    	strd	r6, lr, [sp, #4]
   6dab8: 9403         	str	r4, [sp, #0xc]
   6daba: d02a         	beq	0x6db12 <f_cgm_trend+0x1c2> @ imm = #0x54
   6dabc: f1bc 0f01    	cmp.w	r12, #0x1
   6dac0: f040 8123    	bne.w	0x6dd0a <f_cgm_trend+0x3ba> @ imm = #0x246
   6dac4: f50d 50b9    	add.w	r0, sp, #0x1720
   6dac8: fa1f f18b    	uxth.w	r1, r11
   6dacc: 2214         	movs	r2, #0x14
   6dace: 461e         	mov	r6, r3
   6dad0: f000 fb4e    	bl	0x6e170 <f_trimmed_mean> @ imm = #0x69c
   6dad4: e025         	b	0x6db22 <f_cgm_trend+0x1d2> @ imm = #0x4a
   6dad6: 48a2         	ldr	r0, [pc, #0x288]        @ 0x6dd60 <f_cgm_trend+0x410>
   6dad8: 2100         	movs	r1, #0x0
   6dada: f1bc 0f02    	cmp.w	r12, #0x2
   6dade: f44f 54d8    	mov.w	r4, #0x1b00
   6dae2: e9c5 1000    	strd	r1, r0, [r5]
   6dae6: bf1a         	itte	ne
   6dae8: e9c5 1022    	strdne	r1, r0, [r5, #136]
   6daec: f105 0198    	addne.w	r1, r5, #0x98
   6daf0: f105 0158    	addeq.w	r1, r5, #0x58
   6daf4: 6a2b         	ldr	r3, [r5, #0x20]
   6daf6: 2200         	movs	r2, #0x0
   6daf8: 600a         	str	r2, [r1]
   6dafa: 511a         	str	r2, [r3, r4]
   6dafc: 6048         	str	r0, [r1, #0x4]
   6dafe: f503 51d8    	add.w	r1, r3, #0x1b00
   6db02: 6048         	str	r0, [r1, #0x4]
   6db04: e9c5 2012    	strd	r2, r0, [r5, #72]
   6db08: e9c5 200e    	strd	r2, r0, [r5, #56]
   6db0c: e9c5 200a    	strd	r2, r0, [r5, #40]
   6db10: e2bc         	b	0x6e08c <f_cgm_trend+0x73c> @ imm = #0x578
   6db12: f50d 50b9    	add.w	r0, sp, #0x1720
   6db16: fa1f f18b    	uxth.w	r1, r11
   6db1a: 220a         	movs	r2, #0xa
   6db1c: 461e         	mov	r6, r3
   6db1e: f000 fadf    	bl	0x6e0e0 <calcPercentile> @ imm = #0x5be
   6db22: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6db26: 4633         	mov	r3, r6
   6db28: 6bfa         	ldr	r2, [r7, #0x3c]
   6db2a: f04f 0900    	mov.w	r9, #0x0
   6db2e: f8dc 0010    	ldr.w	r0, [r12, #0x10]
   6db32: ed8c 0b00    	vstr	d0, [r12]
   6db36: f500 51d8    	add.w	r1, r0, #0x1b00
   6db3a: eb00 00c6    	add.w	r0, r0, r6, lsl #3
   6db3e: ed81 0b00    	vstr	d0, [r1]
   6db42: b17d         	cbz	r5, 0x6db64 <f_cgm_trend+0x214> @ imm = #0x1e
   6db44: ecf0 0b02    	vldmia	r0!, {d16}
   6db48: f109 0101    	add.w	r1, r9, #0x1
   6db4c: eef0 0be0    	vabs.f64	d16, d16
   6db50: eef4 0b4b    	vcmp.f64	d16, d11
   6db54: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6db58: bf48         	it	mi
   6db5a: 4689         	movmi	r9, r1
   6db5c: bfc8         	it	gt
   6db5e: 4689         	movgt	r9, r1
   6db60: 3d01         	subs	r5, #0x1
   6db62: e7ee         	b	0x6db42 <f_cgm_trend+0x1f2> @ imm = #-0x24
   6db64: f641 3008    	movw	r0, #0x1b08
   6db68: 2401         	movs	r4, #0x1
   6db6a: eba0 00c8    	sub.w	r0, r0, r8, lsl #3
   6db6e: 9006         	str	r0, [sp, #0x18]
   6db70: 6c78         	ldr	r0, [r7, #0x44]
   6db72: ef80 c050    	vmov.i32	q6, #0x0
   6db76: f1a7 06b0    	sub.w	r6, r7, #0xb0
   6db7a: ed9f eb7b    	vldr	d14, [pc, #492]         @ 0x6dd68 <f_cgm_trend+0x418>
   6db7e: 2800         	cmp	r0, #0x0
   6db80: eb0a 0043    	add.w	r0, r10, r3, lsl #1
   6db84: f200 604a    	addw	r0, r0, #0x64a
   6db88: bf08         	it	eq
   6db8a: 2402         	moveq	r4, #0x2
   6db8c: 9009         	str	r0, [sp, #0x24]
   6db8e: f60a 500c    	addw	r0, r10, #0xd0c
   6db92: 9008         	str	r0, [sp, #0x20]
   6db94: f2a3 3061    	subw	r0, r3, #0x361
   6db98: f04f 0a00    	mov.w	r10, #0x0
   6db9c: 9004         	str	r0, [sp, #0x10]
   6db9e: b290         	uxth	r0, r2
   6dba0: 9007         	str	r0, [sp, #0x1c]
   6dba2: 9405         	str	r4, [sp, #0x14]
   6dba4: 45a2         	cmp	r10, r4
   6dba6: f000 8147    	beq.w	0x6de38 <f_cgm_trend+0x4e8> @ imm = #0x28e
   6dbaa: a80a         	add	r0, sp, #0x28
   6dbac: f44f 6116    	mov.w	r1, #0x960
   6dbb0: f001 ea26    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x144c
   6dbb4: f50d 605c    	add.w	r0, sp, #0xdc0
   6dbb8: f44f 6116    	mov.w	r1, #0x960
   6dbbc: f001 ea20    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x1440
   6dbc0: eb06 004a    	add.w	r0, r6, r10, lsl #1
   6dbc4: 8f05         	ldrh	r5, [r0, #0x38]
   6dbc6: fa1f f089    	uxth.w	r0, r9
   6dbca: 4285         	cmp	r5, r0
   6dbcc: d23f         	bhs	0x6dc4e <f_cgm_trend+0x2fe> @ imm = #0x7e
   6dbce: 9c06         	ldr	r4, [sp, #0x18]
   6dbd0: 2600         	movs	r6, #0x0
   6dbd2: f8dd 8010    	ldr.w	r8, [sp, #0x10]
   6dbd6: f04f 0b00    	mov.w	r11, #0x0
   6dbda: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6dbde: f1b8 0f00    	cmp.w	r8, #0x0
   6dbe2: d03f         	beq	0x6dc64 <f_cgm_trend+0x314> @ imm = #0x7e
   6dbe4: f8dc 0010    	ldr.w	r0, [r12, #0x10]
   6dbe8: 4420         	add	r0, r4
   6dbea: ed90 fb00    	vldr	d15, [r0]
   6dbee: eef0 0bcf    	vabs.f64	d16, d15
   6dbf2: eef4 0b4b    	vcmp.f64	d16, d11
   6dbf6: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6dbfa: d024         	beq	0x6dc46 <f_cgm_trend+0x2f6> @ imm = #0x48
   6dbfc: d623         	bvs	0x6dc46 <f_cgm_trend+0x2f6> @ imm = #0x46
   6dbfe: e7ff         	b	0x6dc00 <f_cgm_trend+0x2b0> @ imm = #-0x2
   6dc00: fa1f f08b    	uxth.w	r0, r11
   6dc04: 4629         	mov	r1, r5
   6dc06: f001 e8be    	blx	0x6ed84 <__aeabi_uidivmod> @ imm = #0x117c
   6dc0a: b9c1         	cbnz	r1, 0x6dc3e <f_cgm_trend+0x2ee> @ imm = #0x30
   6dc0c: 4858         	ldr	r0, [pc, #0x160]        @ 0x6dd70 <f_cgm_trend+0x420>
   6dc0e: f50d 615c    	add.w	r1, sp, #0xdc0
   6dc12: ea00 00c6    	and.w	r0, r0, r6, lsl #3
   6dc16: 3601         	adds	r6, #0x1
   6dc18: 4401         	add	r1, r0
   6dc1a: ed81 fb00    	vstr	d15, [r1]
   6dc1e: a90a         	add	r1, sp, #0x28
   6dc20: 4408         	add	r0, r1
   6dc22: 9908         	ldr	r1, [sp, #0x20]
   6dc24: 9a09         	ldr	r2, [sp, #0x24]
   6dc26: f831 1018    	ldrh.w	r1, [r1, r8, lsl #1]
   6dc2a: 8812         	ldrh	r2, [r2]
   6dc2c: 1a89         	subs	r1, r1, r2
   6dc2e: ee00 1a10    	vmov	s0, r1
   6dc32: eef8 0bc0    	vcvt.f64.s32	d16, s0
   6dc36: eec0 0b8e    	vdiv.f64	d16, d16, d14
   6dc3a: edc0 0b00    	vstr	d16, [r0]
   6dc3e: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6dc42: f10b 0b01    	add.w	r11, r11, #0x1
   6dc46: 3408         	adds	r4, #0x8
   6dc48: f108 0801    	add.w	r8, r8, #0x1
   6dc4c: e7c7         	b	0x6dbde <f_cgm_trend+0x28e> @ imm = #-0x72
   6dc4e: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6dc52: 2100         	movs	r1, #0x0
   6dc54: 4a42         	ldr	r2, [pc, #0x108]        @ 0x6dd60 <f_cgm_trend+0x410>
   6dc56: eb0c 00ca    	add.w	r0, r12, r10, lsl #3
   6dc5a: e9c0 1222    	strd	r1, r2, [r0, #136]
   6dc5e: e9c0 1226    	strd	r1, r2, [r0, #152]
   6dc62: e04f         	b	0x6dd04 <f_cgm_trend+0x3b4> @ imm = #0x9e
   6dc64: f50d 605b    	add.w	r0, sp, #0xdb0
   6dc68: b2b5         	uxth	r5, r6
   6dc6a: f900 cacf    	vst1.64	{d12, d13}, [r0]
   6dc6e: 9807         	ldr	r0, [sp, #0x1c]
   6dc70: 4285         	cmp	r5, r0
   6dc72: d208         	bhs	0x6dc86 <f_cgm_trend+0x336> @ imm = #0x10
   6dc74: 4a3a         	ldr	r2, [pc, #0xe8]         @ 0x6dd60 <f_cgm_trend+0x410>
   6dc76: eb0c 00ca    	add.w	r0, r12, r10, lsl #3
   6dc7a: 2100         	movs	r1, #0x0
   6dc7c: e9c0 1222    	strd	r1, r2, [r0, #136]
   6dc80: e9c0 1226    	strd	r1, r2, [r0, #152]
   6dc84: e03b         	b	0x6dcfe <f_cgm_trend+0x3ae> @ imm = #0x76
   6dc86: f1ba 0f01    	cmp.w	r10, #0x1
   6dc8a: d119         	bne	0x6dcc0 <f_cgm_trend+0x370> @ imm = #0x32
   6dc8c: ae0a         	add	r6, sp, #0x28
   6dc8e: f50d 685c    	add.w	r8, sp, #0xdc0
   6dc92: f50d 645b    	add.w	r4, sp, #0xdb0
   6dc96: 462a         	mov	r2, r5
   6dc98: 4630         	mov	r0, r6
   6dc9a: 4641         	mov	r1, r8
   6dc9c: 4623         	mov	r3, r4
   6dc9e: f000 fab7    	bl	0x6e210 <fit_simple_regression> @ imm = #0x56e
   6dca2: 4620         	mov	r0, r4
   6dca4: 4631         	mov	r1, r6
   6dca6: 4642         	mov	r2, r8
   6dca8: 462b         	mov	r3, r5
   6dcaa: f000 fb31    	bl	0x6e310 <f_rsq>         @ imm = #0x662
   6dcae: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6dcb2: edd4 0b00    	vldr	d16, [r4]
   6dcb6: ed8c 0b28    	vstr	d0, [r12, #160]
   6dcba: edcc 0b24    	vstr	d16, [r12, #144]
   6dcbe: e01e         	b	0x6dcfe <f_cgm_trend+0x3ae> @ imm = #0x3c
   6dcc0: 9e07         	ldr	r6, [sp, #0x1c]
   6dcc2: a90a         	add	r1, sp, #0x28
   6dcc4: f50d 645b    	add.w	r4, sp, #0xdb0
   6dcc8: 1ba8         	subs	r0, r5, r6
   6dcca: 4632         	mov	r2, r6
   6dccc: 4623         	mov	r3, r4
   6dcce: eb01 05c0    	add.w	r5, r1, r0, lsl #3
   6dcd2: f50d 615c    	add.w	r1, sp, #0xdc0
   6dcd6: eb01 08c0    	add.w	r8, r1, r0, lsl #3
   6dcda: 4628         	mov	r0, r5
   6dcdc: 4641         	mov	r1, r8
   6dcde: f000 fa97    	bl	0x6e210 <fit_simple_regression> @ imm = #0x52e
   6dce2: 4620         	mov	r0, r4
   6dce4: 4629         	mov	r1, r5
   6dce6: 4642         	mov	r2, r8
   6dce8: 4633         	mov	r3, r6
   6dcea: f000 fb11    	bl	0x6e310 <f_rsq>         @ imm = #0x622
   6dcee: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6dcf2: edd4 0b00    	vldr	d16, [r4]
   6dcf6: ed8c 0b26    	vstr	d0, [r12, #152]
   6dcfa: edcc 0b22    	vstr	d16, [r12, #136]
   6dcfe: 9c05         	ldr	r4, [sp, #0x14]
   6dd00: f1a7 06b0    	sub.w	r6, r7, #0xb0
   6dd04: f10a 0a01    	add.w	r10, r10, #0x1
   6dd08: e74c         	b	0x6dba4 <f_cgm_trend+0x254> @ imm = #-0x168
   6dd0a: ac0a         	add	r4, sp, #0x28
   6dd0c: f640 5184    	movw	r1, #0xd84
   6dd10: 4620         	mov	r0, r4
   6dd12: f001 e976    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x12ec
   6dd16: eeb2 bb04    	vmov.f64	d11, #1.000000e+01
   6dd1a: fa1f f58b    	uxth.w	r5, r11
   6dd1e: f50d 58b9    	add.w	r8, sp, #0x1720
   6dd22: 46a1         	mov	r9, r4
   6dd24: 462e         	mov	r6, r5
   6dd26: b32e         	cbz	r6, 0x6dd74 <f_cgm_trend+0x424> @ imm = #0x4a
   6dd28: ecf8 0b02    	vldmia	r8!, {d16}
   6dd2c: ee80 0b8b    	vdiv.f64	d0, d16, d11
   6dd30: f7fe fd12    	bl	0x6c758 <math_round>    @ imm = #-0x15dc
   6dd34: eebd 0bc0    	vcvt.s32.f64	s0, d0
   6dd38: 3e01         	subs	r6, #0x1
   6dd3a: ee10 0a10    	vmov	r0, s0
   6dd3e: eb00 0080    	add.w	r0, r0, r0, lsl #2
   6dd42: 0040         	lsls	r0, r0, #0x1
   6dd44: f849 0b04    	str	r0, [r9], #4
   6dd48: e7ed         	b	0x6dd26 <f_cgm_trend+0x3d6> @ imm = #-0x26
   6dd4a: bf00         	nop
   6dd4c: 20 44 02 00  	.word	0x00024420
   6dd50: 3e f9 ff ff  	.word	0xfffff93e
   6dd54: 98 54 01 00  	.word	0x00015498
   6dd58: 00 00 00 00  	.word	0x00000000
   6dd5c: 00 00 f0 7f  	.word	0x7ff00000
   6dd60: 00 00 f8 7f  	.word	0x7ff80000
   6dd64: 00 bf 00 bf  	.word	0xbf00bf00
   6dd68: 00 00 00 00  	.word	0x00000000
   6dd6c: 00 00 72 40  	.word	0x40720000
   6dd70: f8 ff 07 00  	.word	0x0007fff8
   6dd74: ea5f 400b    	lsls.w	r0, r11, #0x10
   6dd78: d054         	beq	0x6de24 <f_cgm_trend+0x4d4> @ imm = #0xa8
   6dd7a: f8dd c028    	ldr.w	r12, [sp, #0x28]
   6dd7e: f04f 0e00    	mov.w	lr, #0x0
   6dd82: f04f 0800    	mov.w	r8, #0x0
   6dd86: 45a8         	cmp	r8, r5
   6dd88: d035         	beq	0x6ddf6 <f_cgm_trend+0x4a6> @ imm = #0x6a
   6dd8a: 4643         	mov	r3, r8
   6dd8c: f108 0801    	add.w	r8, r8, #0x1
   6dd90: 2601         	movs	r6, #0x1
   6dd92: 4642         	mov	r2, r8
   6dd94: 42aa         	cmp	r2, r5
   6dd96: d208         	bhs	0x6ddaa <f_cgm_trend+0x45a> @ imm = #0x10
   6dd98: f854 0022    	ldr.w	r0, [r4, r2, lsl #2]
   6dd9c: f854 1023    	ldr.w	r1, [r4, r3, lsl #2]
   6dda0: 4281         	cmp	r1, r0
   6dda2: bf08         	it	eq
   6dda4: 3601         	addeq	r6, #0x1
   6dda6: 3201         	adds	r2, #0x1
   6dda8: e7f4         	b	0x6dd94 <f_cgm_trend+0x444> @ imm = #-0x18
   6ddaa: 4576         	cmp	r6, lr
   6ddac: dbeb         	blt	0x6dd86 <f_cgm_trend+0x436> @ imm = #-0x2a
   6ddae: f854 2023    	ldr.w	r2, [r4, r3, lsl #2]
   6ddb2: d103         	bne	0x6ddbc <f_cgm_trend+0x46c> @ imm = #0x6
   6ddb4: 4594         	cmp	r12, r2
   6ddb6: bfc8         	it	gt
   6ddb8: 4694         	movgt	r12, r2
   6ddba: e7e4         	b	0x6dd86 <f_cgm_trend+0x436> @ imm = #-0x38
   6ddbc: 46b6         	mov	lr, r6
   6ddbe: 4694         	mov	r12, r2
   6ddc0: e7e1         	b	0x6dd86 <f_cgm_trend+0x436> @ imm = #-0x3e
   6ddc2: 48c2         	ldr	r0, [pc, #0x308]        @ 0x6e0cc <f_cgm_trend+0x77c>
   6ddc4: 2100         	movs	r1, #0x0
   6ddc6: e9c5 1022    	strd	r1, r0, [r5, #136]
   6ddca: e9c5 1026    	strd	r1, r0, [r5, #152]
   6ddce: 6a28         	ldr	r0, [r5, #0x20]
   6ddd0: edd5 0b0c    	vldr	d16, [r5, #48]
   6ddd4: f500 50d8    	add.w	r0, r0, #0x1b00
   6ddd8: edc0 0b00    	vstr	d16, [r0]
   6dddc: edd5 0b0c    	vldr	d16, [r5, #48]
   6dde0: edd5 1b10    	vldr	d17, [r5, #64]
   6dde4: edd5 2b14    	vldr	d18, [r5, #80]
   6dde8: edc5 0b0a    	vstr	d16, [r5, #40]
   6ddec: edc5 1b0e    	vstr	d17, [r5, #56]
   6ddf0: edc5 2b12    	vstr	d18, [r5, #72]
   6ddf4: e14a         	b	0x6e08c <f_cgm_trend+0x73c> @ imm = #0x294
   6ddf6: ee00 ca10    	vmov	s0, r12
   6ddfa: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6ddfe: eef8 0bc0    	vcvt.f64.s32	d16, s0
   6de02: ee00 ea10    	vmov	s0, lr
   6de06: edcc 0b00    	vstr	d16, [r12]
   6de0a: eef8 0bc0    	vcvt.f64.s32	d16, s0
   6de0e: ee00 5a10    	vmov	s0, r5
   6de12: eef8 1b40    	vcvt.f64.u32	d17, s0
   6de16: eec0 0ba1    	vdiv.f64	d16, d16, d17
   6de1a: eddf 1ba7    	vldr	d17, [pc, #668]         @ 0x6e0b8 <f_cgm_trend+0x768>
   6de1e: ee60 0ba1    	vmul.f64	d16, d16, d17
   6de22: e007         	b	0x6de34 <f_cgm_trend+0x4e4> @ imm = #0xe
   6de24: 48a9         	ldr	r0, [pc, #0x2a4]        @ 0x6e0cc <f_cgm_trend+0x77c>
   6de26: 2100         	movs	r1, #0x0
   6de28: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6de2c: eddf 0ba4    	vldr	d16, [pc, #656]         @ 0x6e0c0 <f_cgm_trend+0x770>
   6de30: e9cc 1000    	strd	r1, r0, [r12]
   6de34: edcc 0b16    	vstr	d16, [r12, #88]
   6de38: 48a6         	ldr	r0, [pc, #0x298]        @ 0x6e0d4 <f_cgm_trend+0x784>
   6de3a: 9903         	ldr	r1, [sp, #0xc]
   6de3c: 4478         	add	r0, pc
   6de3e: f8dd 8008    	ldr.w	r8, [sp, #0x8]
   6de42: 4da1         	ldr	r5, [pc, #0x284]        @ 0x6e0c8 <f_cgm_trend+0x778>
   6de44: f8b0 0418    	ldrh.w	r0, [r0, #0x418]
   6de48: 4281         	cmp	r1, r0
   6de4a: f240 80ae    	bls.w	0x6dfaa <f_cgm_trend+0x65a> @ imm = #0x15c
   6de4e: eef7 1b00    	vmov.f64	d17, #1.000000e+00
   6de52: eddc 0b06    	vldr	d16, [r12, #24]
   6de56: ee70 0ba1    	vadd.f64	d16, d16, d17
   6de5a: edcc 0b06    	vstr	d16, [r12, #24]
   6de5e: eddc 0b00    	vldr	d16, [r12]
   6de62: eddc 1b0c    	vldr	d17, [r12, #48]
   6de66: edcd 0b0a    	vstr	d16, [sp, #40]
   6de6a: edcd 1b0c    	vstr	d17, [sp, #48]
   6de6e: a80a         	add	r0, sp, #0x28
   6de70: f000 fac6    	bl	0x6e400 <math_max>      @ imm = #0x58c
   6de74: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6de78: f8dc 2020    	ldr.w	r2, [r12, #0x20]
   6de7c: f502 50d8    	add.w	r0, r2, #0x1b00
   6de80: ed80 0b00    	vstr	d0, [r0]
   6de84: eddc 0b06    	vldr	d16, [r12, #24]
   6de88: eef4 0b4a    	vcmp.f64	d16, d10
   6de8c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6de90: da15         	bge	0x6debe <f_cgm_trend+0x56e> @ imm = #0x2a
   6de92: eebd 1bc9    	vcvt.s32.f64	s2, d9
   6de96: 9903         	ldr	r1, [sp, #0xc]
   6de98: 462b         	mov	r3, r5
   6de9a: 9d01         	ldr	r5, [sp, #0x4]
   6de9c: 9e03         	ldr	r6, [sp, #0xc]
   6de9e: ee11 0a10    	vmov	r0, s2
   6dea2: 1a09         	subs	r1, r1, r0
   6dea4: 2000         	movs	r0, #0x0
   6dea6: b30b         	cbz	r3, 0x6deec <f_cgm_trend+0x59c> @ imm = #0x42
   6dea8: 18ec         	adds	r4, r5, r3
   6deaa: f8b4 46c2    	ldrh.w	r4, [r4, #0x6c2]
   6deae: b124         	cbz	r4, 0x6deba <f_cgm_trend+0x56a> @ imm = #0x8
   6deb0: 42a1         	cmp	r1, r4
   6deb2: dc02         	bgt	0x6deba <f_cgm_trend+0x56a> @ imm = #0x4
   6deb4: 42b4         	cmp	r4, r6
   6deb6: bf98         	it	ls
   6deb8: 3001         	addls	r0, #0x1
   6deba: 3302         	adds	r3, #0x2
   6debc: e7f3         	b	0x6dea6 <f_cgm_trend+0x556> @ imm = #-0x1a
   6debe: eef4 0b4a    	vcmp.f64	d16, d10
   6dec2: 2001         	movs	r0, #0x1
   6dec4: f88c 00a8    	strb.w	r0, [r12, #0xa8]
   6dec8: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6decc: dc58         	bgt	0x6df80 <f_cgm_trend+0x630> @ imm = #0xb0
   6dece: eebc 0bca    	vcvt.u32.f64	s0, d10
   6ded2: f240 3061    	movw	r0, #0x361
   6ded6: ee10 1a10    	vmov	r1, s0
   6deda: 1a40         	subs	r0, r0, r1
   6dedc: eb02 00c0    	add.w	r0, r2, r0, lsl #3
   6dee0: 2214         	movs	r2, #0x14
   6dee2: f000 f945    	bl	0x6e170 <f_trimmed_mean> @ imm = #0x28a
   6dee6: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6deea: e04e         	b	0x6df8a <f_cgm_trend+0x63a> @ imm = #0x9c
   6deec: 6c79         	ldr	r1, [r7, #0x44]
   6deee: b109         	cbz	r1, 0x6def4 <f_cgm_trend+0x5a4> @ imm = #0x2
   6def0: 2902         	cmp	r1, #0x2
   6def2: d113         	bne	0x6df1c <f_cgm_trend+0x5cc> @ imm = #0x26
   6def4: b281         	uxth	r1, r0
   6def6: f240 3361    	movw	r3, #0x361
   6defa: 1a5b         	subs	r3, r3, r1
   6defc: 4d72         	ldr	r5, [pc, #0x1c8]        @ 0x6e0c8 <f_cgm_trend+0x778>
   6defe: 460c         	mov	r4, r1
   6df00: eb02 03c3    	add.w	r3, r2, r3, lsl #3
   6df04: 2200         	movs	r2, #0x0
   6df06: b35c         	cbz	r4, 0x6df60 <f_cgm_trend+0x610> @ imm = #0x56
   6df08: ecf3 0b02    	vldmia	r3!, {d16}
   6df0c: eef4 0b40    	vcmp.f64	d16, d0
   6df10: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6df14: bf08         	it	eq
   6df16: 3201         	addeq	r2, #0x1
   6df18: 3c01         	subs	r4, #0x1
   6df1a: e7f4         	b	0x6df06 <f_cgm_trend+0x5b6> @ imm = #-0x18
   6df1c: b281         	uxth	r1, r0
   6df1e: f240 3361    	movw	r3, #0x361
   6df22: 1a5b         	subs	r3, r3, r1
   6df24: eef9 0b04    	vmov.f64	d16, #-5.000000e+00
   6df28: 4d67         	ldr	r5, [pc, #0x19c]        @ 0x6e0c8 <f_cgm_trend+0x778>
   6df2a: 460c         	mov	r4, r1
   6df2c: eb02 03c3    	add.w	r3, r2, r3, lsl #3
   6df30: 2200         	movs	r2, #0x0
   6df32: eef1 1b04    	vmov.f64	d17, #5.000000e+00
   6df36: b19c         	cbz	r4, 0x6df60 <f_cgm_trend+0x610> @ imm = #0x26
   6df38: edd3 2b00    	vldr	d18, [r3]
   6df3c: ee72 3ba0    	vadd.f64	d19, d18, d16
   6df40: eeb4 0b63    	vcmp.f64	d0, d19
   6df44: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6df48: db07         	blt	0x6df5a <f_cgm_trend+0x60a> @ imm = #0xe
   6df4a: ee72 2ba1    	vadd.f64	d18, d18, d17
   6df4e: eeb4 0b62    	vcmp.f64	d0, d18
   6df52: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6df56: bf98         	it	ls
   6df58: 3201         	addls	r2, #0x1
   6df5a: 3308         	adds	r3, #0x8
   6df5c: 3c01         	subs	r4, #0x1
   6df5e: e7ea         	b	0x6df36 <f_cgm_trend+0x5e6> @ imm = #-0x2c
   6df60: b292         	uxth	r2, r2
   6df62: 428a         	cmp	r2, r1
   6df64: d109         	bne	0x6df7a <f_cgm_trend+0x62a> @ imm = #0x12
   6df66: b280         	uxth	r0, r0
   6df68: ee01 0a10    	vmov	s2, r0
   6df6c: eef8 0b41    	vcvt.f64.u32	d16, s2
   6df70: eeb4 8b60    	vcmp.f64	d8, d16
   6df74: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6df78: d907         	bls	0x6df8a <f_cgm_trend+0x63a> @ imm = #0xe
   6df7a: f1b8 0f02    	cmp.w	r8, #0x2
   6df7e: d302         	blo	0x6df86 <f_cgm_trend+0x636> @ imm = #0x4
   6df80: ed9c 0b0c    	vldr	d0, [r12, #48]
   6df84: e001         	b	0x6df8a <f_cgm_trend+0x63a> @ imm = #0x2
   6df86: ed9f 0b4e    	vldr	d0, [pc, #312]          @ 0x6e0c0 <f_cgm_trend+0x770>
   6df8a: eddc 0b00    	vldr	d16, [r12]
   6df8e: eddf 1b4a    	vldr	d17, [pc, #296]         @ 0x6e0b8 <f_cgm_trend+0x768>
   6df92: ee70 0bc0    	vsub.f64	d16, d16, d0
   6df96: edcc 0b0e    	vstr	d16, [r12, #56]
   6df9a: eec0 0b80    	vdiv.f64	d16, d16, d0
   6df9e: ee60 0ba1    	vmul.f64	d16, d16, d17
   6dfa2: ed8c 0b0a    	vstr	d0, [r12, #40]
   6dfa6: edcc 0b12    	vstr	d16, [r12, #72]
   6dfaa: 6c78         	ldr	r0, [r7, #0x44]
   6dfac: 2801         	cmp	r0, #0x1
   6dfae: d16d         	bne	0x6e08c <f_cgm_trend+0x73c> @ imm = #0xda
   6dfb0: eddc 0b00    	vldr	d16, [r12]
   6dfb4: eddc 1b1a    	vldr	d17, [r12, #104]
   6dfb8: edcd 0b0a    	vstr	d16, [sp, #40]
   6dfbc: edcd 1b0c    	vstr	d17, [sp, #48]
   6dfc0: a80a         	add	r0, sp, #0x28
   6dfc2: f000 fa1d    	bl	0x6e400 <math_max>      @ imm = #0x43a
   6dfc6: eebd 1bc9    	vcvt.s32.f64	s2, d9
   6dfca: f8d7 c040    	ldr.w	r12, [r7, #0x40]
   6dfce: 9e03         	ldr	r6, [sp, #0xc]
   6dfd0: 462b         	mov	r3, r5
   6dfd2: 9d01         	ldr	r5, [sp, #0x4]
   6dfd4: f8dc 1070    	ldr.w	r1, [r12, #0x70]
   6dfd8: f501 50d8    	add.w	r0, r1, #0x1b00
   6dfdc: ed80 0b00    	vstr	d0, [r0]
   6dfe0: ee11 0a10    	vmov	r0, s2
   6dfe4: 1a32         	subs	r2, r6, r0
   6dfe6: 2000         	movs	r0, #0x0
   6dfe8: b163         	cbz	r3, 0x6e004 <f_cgm_trend+0x6b4> @ imm = #0x18
   6dfea: 461c         	mov	r4, r3
   6dfec: 442b         	add	r3, r5
   6dfee: f8b3 36c2    	ldrh.w	r3, [r3, #0x6c2]
   6dff2: b123         	cbz	r3, 0x6dffe <f_cgm_trend+0x6ae> @ imm = #0x8
   6dff4: 429a         	cmp	r2, r3
   6dff6: dc02         	bgt	0x6dffe <f_cgm_trend+0x6ae> @ imm = #0x4
   6dff8: 42b3         	cmp	r3, r6
   6dffa: bf98         	it	ls
   6dffc: 3001         	addls	r0, #0x1
   6dffe: 4623         	mov	r3, r4
   6e000: 1ca3         	adds	r3, r4, #0x2
   6e002: e7f1         	b	0x6dfe8 <f_cgm_trend+0x698> @ imm = #-0x1e
   6e004: b280         	uxth	r0, r0
   6e006: f240 3261    	movw	r2, #0x361
   6e00a: 1a12         	subs	r2, r2, r0
   6e00c: eef9 0b04    	vmov.f64	d16, #-5.000000e+00
   6e010: 4603         	mov	r3, r0
   6e012: eb01 02c2    	add.w	r2, r1, r2, lsl #3
   6e016: 2100         	movs	r1, #0x0
   6e018: eef1 1b04    	vmov.f64	d17, #5.000000e+00
   6e01c: b19b         	cbz	r3, 0x6e046 <f_cgm_trend+0x6f6> @ imm = #0x26
   6e01e: edd2 2b00    	vldr	d18, [r2]
   6e022: ee72 3ba0    	vadd.f64	d19, d18, d16
   6e026: eeb4 0b63    	vcmp.f64	d0, d19
   6e02a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e02e: db07         	blt	0x6e040 <f_cgm_trend+0x6f0> @ imm = #0xe
   6e030: ee72 2ba1    	vadd.f64	d18, d18, d17
   6e034: eeb4 0b62    	vcmp.f64	d0, d18
   6e038: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e03c: bf98         	it	ls
   6e03e: 3101         	addls	r1, #0x1
   6e040: 3208         	adds	r2, #0x8
   6e042: 3b01         	subs	r3, #0x1
   6e044: e7ea         	b	0x6e01c <f_cgm_trend+0x6cc> @ imm = #-0x2c
   6e046: ee01 0a10    	vmov	s2, r0
   6e04a: eef8 0b41    	vcvt.f64.u32	d16, s2
   6e04e: eeb4 8b60    	vcmp.f64	d8, d16
   6e052: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e056: d802         	bhi	0x6e05e <f_cgm_trend+0x70e> @ imm = #0x4
   6e058: b289         	uxth	r1, r1
   6e05a: 4281         	cmp	r1, r0
   6e05c: d006         	beq	0x6e06c <f_cgm_trend+0x71c> @ imm = #0xc
   6e05e: f1b8 0f02    	cmp.w	r8, #0x2
   6e062: bf2c         	ite	hs
   6e064: ed9c 0b1a    	vldrhs	d0, [r12, #104]
   6e068: ed9f 0b15    	vldrlo	d0, [pc, #84]           @ 0x6e0c0 <f_cgm_trend+0x770>
   6e06c: eddc 0b00    	vldr	d16, [r12]
   6e070: eddf 2b11    	vldr	d18, [pc, #68]          @ 0x6e0b8 <f_cgm_trend+0x768>
   6e074: ee70 0bc0    	vsub.f64	d16, d16, d0
   6e078: eec0 1b80    	vdiv.f64	d17, d16, d0
   6e07c: ee61 1ba2    	vmul.f64	d17, d17, d18
   6e080: ed8c 0b18    	vstr	d0, [r12, #96]
   6e084: edcc 0b1e    	vstr	d16, [r12, #120]
   6e088: edcc 1b20    	vstr	d17, [r12, #128]
   6e08c: f857 0c6c    	ldr	r0, [r7, #-108]
   6e090: 4911         	ldr	r1, [pc, #0x44]         @ 0x6e0d8 <f_cgm_trend+0x788>
   6e092: 4479         	add	r1, pc
   6e094: 6809         	ldr	r1, [r1]
   6e096: 6809         	ldr	r1, [r1]
   6e098: 4281         	cmp	r1, r0
   6e09a: bf01         	itttt	eq
   6e09c: f50d 5d49    	addeq.w	sp, sp, #0x3240
   6e0a0: b00e         	addeq	sp, #0x38
   6e0a2: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   6e0a6: b001         	addeq	sp, #0x4
   6e0a8: bf04         	itt	eq
   6e0aa: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   6e0ae: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6e0b0: f000 efbe    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xf7c
   6e0b4: bf00         	nop
   6e0b6: bf00         	nop
   6e0b8: 00 00 00 00  	.word	0x00000000
   6e0bc: 00 00 59 40  	.word	0x40590000
   6e0c0: 00 00 00 00  	.word	0x00000000
   6e0c4: 00 00 f8 7f  	.word	0x7ff80000
   6e0c8: 3e f9 ff ff  	.word	0xfffff93e
   6e0cc: 00 00 f8 7f  	.word	0x7ff80000
   6e0d0: 60 58 00 00  	.word	0x00005860
   6e0d4: 68 48 02 00  	.word	0x00024868
   6e0d8: 3e 51 00 00  	.word	0x0000513e
   6e0dc: d4 d4 d4 d4  	.word	0xd4d4d4d4

0006e0e0 <calcPercentile>:
   6e0e0: b5d0         	push	{r4, r6, r7, lr}
   6e0e2: af02         	add	r7, sp, #0x8
   6e0e4: ee00 2a10    	vmov	s0, r2
   6e0e8: 4b1f         	ldr	r3, [pc, #0x7c]         @ 0x6e168 <calcPercentile+0x88>
   6e0ea: eddf 1b1b    	vldr	d17, [pc, #108]         @ 0x6e158 <calcPercentile+0x78>
   6e0ee: 2200         	movs	r2, #0x0
   6e0f0: eef8 0b40    	vcvt.f64.u32	d16, s0
   6e0f4: 447b         	add	r3, pc
   6e0f6: b199         	cbz	r1, 0x6e120 <calcPercentile+0x40> @ imm = #0x26
   6e0f8: edd0 2b00    	vldr	d18, [r0]
   6e0fc: eef0 3be2    	vabs.f64	d19, d18
   6e100: eef4 3b61    	vcmp.f64	d19, d17
   6e104: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e108: d007         	beq	0x6e11a <calcPercentile+0x3a> @ imm = #0xe
   6e10a: d606         	bvs	0x6e11a <calcPercentile+0x3a> @ imm = #0xc
   6e10c: e7ff         	b	0x6e10e <calcPercentile+0x2e> @ imm = #-0x2
   6e10e: b294         	uxth	r4, r2
   6e110: 3201         	adds	r2, #0x1
   6e112: eb03 04c4    	add.w	r4, r3, r4, lsl #3
   6e116: edc4 2b00    	vstr	d18, [r4]
   6e11a: 3008         	adds	r0, #0x8
   6e11c: 3901         	subs	r1, #0x1
   6e11e: e7ea         	b	0x6e0f6 <calcPercentile+0x16> @ imm = #-0x2c
   6e120: eddf 1b0f    	vldr	d17, [pc, #60]          @ 0x6e160 <calcPercentile+0x80>
   6e124: b291         	uxth	r1, r2
   6e126: eef6 2b00    	vmov.f64	d18, #5.000000e-01
   6e12a: 4810         	ldr	r0, [pc, #0x40]         @ 0x6e16c <calcPercentile+0x8c>
   6e12c: 4478         	add	r0, pc
   6e12e: ee60 0ba1    	vmul.f64	d16, d16, d17
   6e132: ee00 1a10    	vmov	s0, r1
   6e136: eef8 1b40    	vcvt.f64.u32	d17, s0
   6e13a: ee40 2ba1    	vmla.f64	d18, d16, d17
   6e13e: eebc 0be2    	vcvt.u32.f64	s0, d18
   6e142: ee10 2a10    	vmov	r2, s0
   6e146: 2a00         	cmp	r2, #0x0
   6e148: e8bd 40d0    	pop.w	{r4, r6, r7, lr}
   6e14c: bf18         	it	ne
   6e14e: f7fe bc67    	bne.w	0x6ca20 <quick_select>  @ imm = #-0x1732
   6e152: f000 b979    	b.w	0x6e448 <math_min>      @ imm = #0x2f2
   6e156: bf00         	nop
   6e158: 00 00 00 00  	.word	0x00000000
   6e15c: 00 00 f0 7f  	.word	0x7ff00000
   6e160: 7b 14 ae 47  	.word	0x47ae147b
   6e164: e1 7a 84 3f  	.word	0x3f847ae1
   6e168: 20 85 02 00  	.word	0x00028520
   6e16c: e8 84 02 00  	.word	0x000284e8

0006e170 <f_trimmed_mean>:
   6e170: b5f0         	push	{r4, r5, r6, r7, lr}
   6e172: af03         	add	r7, sp, #0xc
   6e174: f84d bd04    	str	r11, [sp, #-4]!
   6e178: ed2d 8b08    	vpush	{d8, d9, d10, d11}
   6e17c: 4616         	mov	r6, r2
   6e17e: 460c         	mov	r4, r1
   6e180: 4605         	mov	r5, r0
   6e182: f7ff ffad    	bl	0x6e0e0 <calcPercentile> @ imm = #-0xa6
   6e186: f1c6 0064    	rsb.w	r0, r6, #0x64
   6e18a: 4621         	mov	r1, r4
   6e18c: b2c2         	uxtb	r2, r0
   6e18e: 4628         	mov	r0, r5
   6e190: eeb0 8b40    	vmov.f64	d8, d0
   6e194: f7ff ffa4    	bl	0x6e0e0 <calcPercentile> @ imm = #-0xb8
   6e198: eeb4 8b40    	vcmp.f64	d8, d0
   6e19c: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e1a0: d109         	bne	0x6e1b6 <f_trimmed_mean+0x46> @ imm = #0x12
   6e1a2: 4628         	mov	r0, r5
   6e1a4: 4621         	mov	r1, r4
   6e1a6: ecbd 8b08    	vpop	{d8, d9, d10, d11}
   6e1aa: f85d bb04    	ldr	r11, [sp], #4
   6e1ae: e8bd 40f0    	pop.w	{r4, r5, r6, r7, lr}
   6e1b2: f7fe ba75    	b.w	0x6c6a0 <math_mean>     @ imm = #-0x1b16
   6e1b6: eeb0 9b40    	vmov.f64	d9, d0
   6e1ba: 2600         	movs	r6, #0x0
   6e1bc: ef80 b010    	vmov.i32	d11, #0x0
   6e1c0: b1cc         	cbz	r4, 0x6e1f6 <f_trimmed_mean+0x86> @ imm = #0x32
   6e1c2: ed95 ab00    	vldr	d10, [r5]
   6e1c6: 200a         	movs	r0, #0xa
   6e1c8: eeb0 1b48    	vmov.f64	d1, d8
   6e1cc: 2103         	movs	r1, #0x3
   6e1ce: ef2a 011a    	vorr	d0, d10, d10
   6e1d2: f7fe fb29    	bl	0x6c828 <fun_comp_decimals> @ imm = #-0x19ae
   6e1d6: b158         	cbz	r0, 0x6e1f0 <f_trimmed_mean+0x80> @ imm = #0x16
   6e1d8: eeb0 1b49    	vmov.f64	d1, d9
   6e1dc: 200a         	movs	r0, #0xa
   6e1de: 2104         	movs	r1, #0x4
   6e1e0: ef2a 011a    	vorr	d0, d10, d10
   6e1e4: f7fe fb20    	bl	0x6c828 <fun_comp_decimals> @ imm = #-0x19c0
   6e1e8: b110         	cbz	r0, 0x6e1f0 <f_trimmed_mean+0x80> @ imm = #0x4
   6e1ea: ee3b bb0a    	vadd.f64	d11, d11, d10
   6e1ee: 3601         	adds	r6, #0x1
   6e1f0: 3508         	adds	r5, #0x8
   6e1f2: 3c01         	subs	r4, #0x1
   6e1f4: e7e4         	b	0x6e1c0 <f_trimmed_mean+0x50> @ imm = #-0x38
   6e1f6: b2b0         	uxth	r0, r6
   6e1f8: ee00 0a10    	vmov	s0, r0
   6e1fc: eef8 0b40    	vcvt.f64.u32	d16, s0
   6e200: ee8b 0b20    	vdiv.f64	d0, d11, d16
   6e204: ecbd 8b08    	vpop	{d8, d9, d10, d11}
   6e208: f85d bb04    	ldr	r11, [sp], #4
   6e20c: bdf0         	pop	{r4, r5, r6, r7, pc}
   6e20e: d4d4         	bmi	0x6e1ba <f_trimmed_mean+0x4a> @ imm = #-0x58

0006e210 <fit_simple_regression>:
   6e210: b5f0         	push	{r4, r5, r6, r7, lr}
   6e212: af03         	add	r7, sp, #0xc
   6e214: e92d 0700    	push.w	{r8, r9, r10}
   6e218: f5ad 5d96    	sub.w	sp, sp, #0x12c0
   6e21c: b082         	sub	sp, #0x8
   6e21e: 4604         	mov	r4, r0
   6e220: 4839         	ldr	r0, [pc, #0xe4]         @ 0x6e308 <fit_simple_regression+0xf8>
   6e222: f50d 6916    	add.w	r9, sp, #0x960
   6e226: 460e         	mov	r6, r1
   6e228: 4478         	add	r0, pc
   6e22a: f44f 6116    	mov.w	r1, #0x960
   6e22e: 4698         	mov	r8, r3
   6e230: 4615         	mov	r5, r2
   6e232: 6800         	ldr	r0, [r0]
   6e234: 6800         	ldr	r0, [r0]
   6e236: f847 0c20    	str	r0, [r7, #-32]
   6e23a: 4648         	mov	r0, r9
   6e23c: f000 eee0    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xdc0
   6e240: 46ea         	mov	r10, sp
   6e242: f44f 6116    	mov.w	r1, #0x960
   6e246: 4650         	mov	r0, r10
   6e248: f000 eeda    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xdb4
   6e24c: efc0 0010    	vmov.i32	d16, #0x0
   6e250: 2000         	movs	r0, #0x0
   6e252: efc0 1010    	vmov.i32	d17, #0x0
   6e256: b305         	cbz	r5, 0x6e29a <fit_simple_regression+0x8a> @ imm = #0x40
   6e258: edd6 2b00    	vldr	d18, [r6]
   6e25c: eef4 2b62    	vcmp.f64	d18, d18
   6e260: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e264: bf7f         	itttt	vc
   6e266: edd4 3b00    	vldrvc	d19, [r4]
   6e26a: eef4 3b63    	vcmpvc.f64	d19, d19
   6e26e: eef1 fa10    	vmrsvc	APSR_nzcv, fpscr
   6e272: b2c1         	uxtbvc	r1, r0
   6e274: bf7f         	itttt	vc
   6e276: eb0a 02c1    	addvc.w	r2, r10, r1, lsl #3
   6e27a: edc2 2b00    	vstrvc	d18, [r2]
   6e27e: eb09 01c1    	addvc.w	r1, r9, r1, lsl #3
   6e282: edc1 3b00    	vstrvc	d19, [r1]
   6e286: bf7e         	ittt	vc
   6e288: ee70 0ba2    	vaddvc.f64	d16, d16, d18
   6e28c: ee71 1ba3    	vaddvc.f64	d17, d17, d19
   6e290: 3001         	addvc	r0, #0x1
   6e292: 3408         	adds	r4, #0x8
   6e294: 3608         	adds	r6, #0x8
   6e296: 3d01         	subs	r5, #0x1
   6e298: e7dd         	b	0x6e256 <fit_simple_regression+0x46> @ imm = #-0x46
   6e29a: b2c0         	uxtb	r0, r0
   6e29c: f50d 6116    	add.w	r1, sp, #0x960
   6e2a0: 466a         	mov	r2, sp
   6e2a2: efc0 3010    	vmov.i32	d19, #0x0
   6e2a6: ee00 0a10    	vmov	s0, r0
   6e2aa: eef8 2b40    	vcvt.f64.u32	d18, s0
   6e2ae: eec0 0ba2    	vdiv.f64	d16, d16, d18
   6e2b2: eec1 1ba2    	vdiv.f64	d17, d17, d18
   6e2b6: efc0 2010    	vmov.i32	d18, #0x0
   6e2ba: b168         	cbz	r0, 0x6e2d8 <fit_simple_regression+0xc8> @ imm = #0x1a
   6e2bc: ecf2 4b02    	vldmia	r2!, {d20}
   6e2c0: 3801         	subs	r0, #0x1
   6e2c2: ecf1 5b02    	vldmia	r1!, {d21}
   6e2c6: ee74 4be0    	vsub.f64	d20, d20, d16
   6e2ca: ee75 5be1    	vsub.f64	d21, d21, d17
   6e2ce: ee45 2ba4    	vmla.f64	d18, d21, d20
   6e2d2: ee45 3ba5    	vmla.f64	d19, d21, d21
   6e2d6: e7f0         	b	0x6e2ba <fit_simple_regression+0xaa> @ imm = #-0x20
   6e2d8: eec2 2ba3    	vdiv.f64	d18, d18, d19
   6e2dc: ee42 0be1    	vmls.f64	d16, d18, d17
   6e2e0: edc8 2b00    	vstr	d18, [r8]
   6e2e4: edc8 0b02    	vstr	d16, [r8, #8]
   6e2e8: f857 0c20    	ldr	r0, [r7, #-32]
   6e2ec: 4907         	ldr	r1, [pc, #0x1c]         @ 0x6e30c <fit_simple_regression+0xfc>
   6e2ee: 4479         	add	r1, pc
   6e2f0: 6809         	ldr	r1, [r1]
   6e2f2: 6809         	ldr	r1, [r1]
   6e2f4: 4281         	cmp	r1, r0
   6e2f6: bf01         	itttt	eq
   6e2f8: f50d 5d96    	addeq.w	sp, sp, #0x12c0
   6e2fc: b002         	addeq	sp, #0x8
   6e2fe: e8bd 0700    	popeq.w	{r8, r9, r10}
   6e302: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6e304: f000 ee94    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xd28
   6e308: a8 4f 00 00  	.word	0x00004fa8
   6e30c: e2 4e 00 00  	.word	0x00004ee2

0006e310 <f_rsq>:
   6e310: b5f0         	push	{r4, r5, r6, r7, lr}
   6e312: af03         	add	r7, sp, #0xc
   6e314: e92d 0b00    	push.w	{r8, r9, r11}
   6e318: f6ad 1d68    	subw	sp, sp, #0x968
   6e31c: 4605         	mov	r5, r0
   6e31e: 4836         	ldr	r0, [pc, #0xd8]         @ 0x6e3f8 <f_rsq+0xe8>
   6e320: 466c         	mov	r4, sp
   6e322: 460e         	mov	r6, r1
   6e324: 4478         	add	r0, pc
   6e326: f44f 6116    	mov.w	r1, #0x960
   6e32a: 4699         	mov	r9, r3
   6e32c: 4690         	mov	r8, r2
   6e32e: 6800         	ldr	r0, [r0]
   6e330: 6800         	ldr	r0, [r0]
   6e332: f847 0c1c    	str	r0, [r7, #-28]
   6e336: 4620         	mov	r0, r4
   6e338: f000 ee62    	blx	0x6f000 <sincos+0x6f000> @ imm = #0xcc4
   6e33c: 4648         	mov	r0, r9
   6e33e: b148         	cbz	r0, 0x6e354 <f_rsq+0x44> @ imm = #0x12
   6e340: ecf6 0b02    	vldmia	r6!, {d16}
   6e344: 3801         	subs	r0, #0x1
   6e346: ecd5 1b04    	vldmia	r5, {d17, d18}
   6e34a: ee41 2ba0    	vmla.f64	d18, d17, d16
   6e34e: ece4 2b02    	vstmia	r4!, {d18}
   6e352: e7f4         	b	0x6e33e <f_rsq+0x2e>    @ imm = #-0x18
   6e354: 4640         	mov	r0, r8
   6e356: 4649         	mov	r1, r9
   6e358: f7fe f9a2    	bl	0x6c6a0 <math_mean>     @ imm = #-0x1cbc
   6e35c: efc0 0010    	vmov.i32	d16, #0x0
   6e360: 4668         	mov	r0, sp
   6e362: efc0 1010    	vmov.i32	d17, #0x0
   6e366: f1b9 0f00    	cmp.w	r9, #0x0
   6e36a: d00e         	beq	0x6e38a <f_rsq+0x7a>    @ imm = #0x1c
   6e36c: ecf8 2b02    	vldmia	r8!, {d18}
   6e370: f1a9 0901    	sub.w	r9, r9, #0x1
   6e374: ee72 2bc0    	vsub.f64	d18, d18, d0
   6e378: ee42 1ba2    	vmla.f64	d17, d18, d18
   6e37c: ecf0 2b02    	vldmia	r0!, {d18}
   6e380: ee72 2bc0    	vsub.f64	d18, d18, d0
   6e384: ee42 0ba2    	vmla.f64	d16, d18, d18
   6e388: e7ed         	b	0x6e366 <f_rsq+0x56>    @ imm = #-0x26
   6e38a: eddf 2b17    	vldr	d18, [pc, #92]          @ 0x6e3e8 <f_rsq+0xd8>
   6e38e: eef4 1b62    	vcmp.f64	d17, d18
   6e392: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e396: d502         	bpl	0x6e39e <f_rsq+0x8e>    @ imm = #0x4
   6e398: ed9f 0b11    	vldr	d0, [pc, #68]           @ 0x6e3e0 <f_rsq+0xd0>
   6e39c: e011         	b	0x6e3c2 <f_rsq+0xb2>    @ imm = #0x22
   6e39e: ee80 0ba1    	vdiv.f64	d0, d16, d17
   6e3a2: eddf 1b13    	vldr	d17, [pc, #76]          @ 0x6e3f0 <f_rsq+0xe0>
   6e3a6: eef0 0bc0    	vabs.f64	d16, d0
   6e3aa: eef4 0b61    	vcmp.f64	d16, d17
   6e3ae: eddf 2b0c    	vldr	d18, [pc, #48]          @ 0x6e3e0 <f_rsq+0xd0>
   6e3b2: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e3b6: bf08         	it	eq
   6e3b8: eeb0 0b62    	vmoveq.f64	d0, d18
   6e3bc: bf68         	it	vs
   6e3be: eeb0 0b62    	vmovvs.f64	d0, d18
   6e3c2: f857 0c1c    	ldr	r0, [r7, #-28]
   6e3c6: 490d         	ldr	r1, [pc, #0x34]         @ 0x6e3fc <f_rsq+0xec>
   6e3c8: 4479         	add	r1, pc
   6e3ca: 6809         	ldr	r1, [r1]
   6e3cc: 6809         	ldr	r1, [r1]
   6e3ce: 4281         	cmp	r1, r0
   6e3d0: bf02         	ittt	eq
   6e3d2: f60d 1d68    	addweq	sp, sp, #0x968
   6e3d6: e8bd 0b00    	popeq.w	{r8, r9, r11}
   6e3da: bdf0         	popeq	{r4, r5, r6, r7, pc}
   6e3dc: f000 ee28    	blx	0x6f030 <sincos+0x6f030> @ imm = #0xc50
   6e3e0: 00 00 00 00  	.word	0x00000000
   6e3e4: 00 00 f8 7f  	.word	0x7ff80000
   6e3e8: 3a 8c 30 e2  	.word	0xe2308c3a
   6e3ec: 8e 79 45 3e  	.word	0x3e45798e
   6e3f0: 00 00 00 00  	.word	0x00000000
   6e3f4: 00 00 f0 7f  	.word	0x7ff00000
   6e3f8: ac 4e 00 00  	.word	0x00004eac
   6e3fc: 08 4e 00 00  	.word	0x00004e08

0006e400 <math_max>:
   6e400: ef80 0010    	vmov.i32	d0, #0x0
   6e404: 2100         	movs	r1, #0x0
   6e406: 2200         	movs	r2, #0x0
   6e408: 2910         	cmp	r1, #0x10
   6e40a: d012         	beq	0x6e432 <math_max+0x32> @ imm = #0x24
   6e40c: 1843         	adds	r3, r0, r1
   6e40e: edd3 0b00    	vldr	d16, [r3]
   6e412: eef4 0b60    	vcmp.f64	d16, d16
   6e416: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e41a: d608         	bvs	0x6e42e <math_max+0x2e> @ imm = #0x10
   6e41c: b122         	cbz	r2, 0x6e428 <math_max+0x28> @ imm = #0x8
   6e41e: eef4 0b40    	vcmp.f64	d16, d0
   6e422: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e426: dd02         	ble	0x6e42e <math_max+0x2e> @ imm = #0x4
   6e428: eeb0 0b60    	vmov.f64	d0, d16
   6e42c: 2201         	movs	r2, #0x1
   6e42e: 3108         	adds	r1, #0x8
   6e430: e7ea         	b	0x6e408 <math_max+0x8>  @ imm = #-0x2c
   6e432: eddf 0b03    	vldr	d16, [pc, #12]          @ 0x6e440 <math_max+0x40>
   6e436: 2a00         	cmp	r2, #0x0
   6e438: bf08         	it	eq
   6e43a: eeb0 0b60    	vmoveq.f64	d0, d16
   6e43e: 4770         	bx	lr
   6e440: 00 00 00 00  	.word	0x00000000
   6e444: 00 00 f8 7f  	.word	0x7ff80000

0006e448 <math_min>:
   6e448: b1e9         	cbz	r1, 0x6e486 <math_min+0x3e> @ imm = #0x3a
   6e44a: ef80 0010    	vmov.i32	d0, #0x0
   6e44e: 2200         	movs	r2, #0x0
   6e450: b191         	cbz	r1, 0x6e478 <math_min+0x30> @ imm = #0x24
   6e452: edd0 0b00    	vldr	d16, [r0]
   6e456: eef4 0b60    	vcmp.f64	d16, d16
   6e45a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e45e: d608         	bvs	0x6e472 <math_min+0x2a> @ imm = #0x10
   6e460: b122         	cbz	r2, 0x6e46c <math_min+0x24> @ imm = #0x8
   6e462: eef4 0b40    	vcmp.f64	d16, d0
   6e466: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e46a: d502         	bpl	0x6e472 <math_min+0x2a> @ imm = #0x4
   6e46c: eeb0 0b60    	vmov.f64	d0, d16
   6e470: 2201         	movs	r2, #0x1
   6e472: 3008         	adds	r0, #0x8
   6e474: 3901         	subs	r1, #0x1
   6e476: e7eb         	b	0x6e450 <math_min+0x8>  @ imm = #-0x2a
   6e478: eddf 0b05    	vldr	d16, [pc, #20]          @ 0x6e490 <math_min+0x48>
   6e47c: 2a00         	cmp	r2, #0x0
   6e47e: bf08         	it	eq
   6e480: eeb0 0b60    	vmoveq.f64	d0, d16
   6e484: 4770         	bx	lr
   6e486: ed9f 0b02    	vldr	d0, [pc, #8]            @ 0x6e490 <math_min+0x48>
   6e48a: 4770         	bx	lr
   6e48c: bf00         	nop
   6e48e: bf00         	nop
   6e490: 00 00 00 00  	.word	0x00000000
   6e494: 00 00 f8 7f  	.word	0x7ff80000

0006e498 <f_check_cgm_trend>:
   6e498: b5f0         	push	{r4, r5, r6, r7, lr}
   6e49a: af03         	add	r7, sp, #0xc
   6e49c: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   6e4a0: ed2d 4b16    	vpush	{d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14}
   6e4a4: 4683         	mov	r11, r0
   6e4a6: 48ef         	ldr	r0, [pc, #0x3bc]        @ 0x6e864 <f_check_cgm_trend+0x3cc>
   6e4a8: 4cef         	ldr	r4, [pc, #0x3bc]        @ 0x6e868 <f_check_cgm_trend+0x3d0>
   6e4aa: f201 634a    	addw	r3, r1, #0x64a
   6e4ae: 4478         	add	r0, pc
   6e4b0: f107 0e08    	add.w	lr, r7, #0x8
   6e4b4: f04f 0900    	mov.w	r9, #0x0
   6e4b8: 8800         	ldrh	r0, [r0]
   6e4ba: eba0 0c02    	sub.w	r12, r0, r2
   6e4be: b1a4         	cbz	r4, 0x6e4ea <f_check_cgm_trend+0x52> @ imm = #0x28
   6e4c0: 191d         	adds	r5, r3, r4
   6e4c2: 2600         	movs	r6, #0x0
   6e4c4: f8b5 26c2    	ldrh.w	r2, [r5, #0x6c2]
   6e4c8: 4594         	cmp	r12, r2
   6e4ca: bfb8         	it	lt
   6e4cc: 2601         	movlt	r6, #0x1
   6e4ce: 4615         	mov	r5, r2
   6e4d0: 2a00         	cmp	r2, #0x0
   6e4d2: bf18         	it	ne
   6e4d4: 2501         	movne	r5, #0x1
   6e4d6: 4035         	ands	r5, r6
   6e4d8: 4282         	cmp	r2, r0
   6e4da: f04f 0200    	mov.w	r2, #0x0
   6e4de: bf98         	it	ls
   6e4e0: 2201         	movls	r2, #0x1
   6e4e2: 3402         	adds	r4, #0x2
   6e4e4: 402a         	ands	r2, r5
   6e4e6: 4491         	add	r9, r2
   6e4e8: e7e9         	b	0x6e4be <f_check_cgm_trend+0x26> @ imm = #-0x2e
   6e4ea: f1bb 0f64    	cmp.w	r11, #0x64
   6e4ee: d127         	bne	0x6e540 <f_check_cgm_trend+0xa8> @ imm = #0x4e
   6e4f0: fa1f f489    	uxth.w	r4, r9
   6e4f4: f1c4 0024    	rsb.w	r0, r4, #0x24
   6e4f8: ecbe 8b04    	vldmia	lr!, {d8, d9}
   6e4fc: f04f 0800    	mov.w	r8, #0x0
   6e500: eb01 00c0    	add.w	r0, r1, r0, lsl #3
   6e504: 2500         	movs	r5, #0x0
   6e506: 49d9         	ldr	r1, [pc, #0x364]        @ 0x6e86c <f_check_cgm_trend+0x3d4>
   6e508: 1846         	adds	r6, r0, r1
   6e50a: 2c00         	cmp	r4, #0x0
   6e50c: d06b         	beq	0x6e5e6 <f_check_cgm_trend+0x14e> @ imm = #0xd6
   6e50e: eeb0 1b48    	vmov.f64	d1, d8
   6e512: 200a         	movs	r0, #0xa
   6e514: 2104         	movs	r1, #0x4
   6e516: ed16 0b48    	vldr	d0, [r6, #-288]
   6e51a: f7fe f985    	bl	0x6c828 <fun_comp_decimals> @ imm = #-0x1cf6
   6e51e: ef29 1119    	vorr	d1, d9, d9
   6e522: 2800         	cmp	r0, #0x0
   6e524: bf18         	it	ne
   6e526: f108 0801    	addne.w	r8, r8, #0x1
   6e52a: ecb6 0b02    	vldmia	r6!, {d0}
   6e52e: 200a         	movs	r0, #0xa
   6e530: 2104         	movs	r1, #0x4
   6e532: f7fe f979    	bl	0x6c828 <fun_comp_decimals> @ imm = #-0x1d0e
   6e536: 2800         	cmp	r0, #0x0
   6e538: bf18         	it	ne
   6e53a: 3501         	addne	r5, #0x1
   6e53c: 3c01         	subs	r4, #0x1
   6e53e: e7e4         	b	0x6e50a <f_check_cgm_trend+0x72> @ imm = #-0x38
   6e540: fa1f f689    	uxth.w	r6, r9
   6e544: f1c6 0024    	rsb.w	r0, r6, #0x24
   6e548: f1bb 0f02    	cmp.w	r11, #0x2
   6e54c: e9cd 6901    	strd	r6, r9, [sp, #4]
   6e550: eb01 01c0    	add.w	r1, r1, r0, lsl #3
   6e554: 48e5         	ldr	r0, [pc, #0x394]        @ 0x6e8ec <f_check_cgm_trend+0x454>
   6e556: d958         	bls	0x6e60a <f_check_cgm_trend+0x172> @ imm = #0xb0
   6e558: eb01 0900    	add.w	r9, r1, r0
   6e55c: f10e 0010    	add.w	r0, lr, #0x10
   6e560: 9105         	str	r1, [sp, #0x14]
   6e562: ef80 c010    	vmov.i32	d12, #0x0
   6e566: ecb0 8b08    	vldmia	r0!, {d8, d9, d10, d11}
   6e56a: ef80 d811    	vmov.i16	d13, #0x1
   6e56e: 4634         	mov	r4, r6
   6e570: f645 1a60    	movw	r10, #0x5960
   6e574: 48e3         	ldr	r0, [pc, #0x38c]        @ 0x6e904 <f_check_cgm_trend+0x46c>
   6e576: 4478         	add	r0, pc
   6e578: 9006         	str	r0, [sp, #0x18]
   6e57a: f8dd 8018    	ldr.w	r8, [sp, #0x18]
   6e57e: 2c00         	cmp	r4, #0x0
   6e580: d07a         	beq	0x6e678 <f_check_cgm_trend+0x1e0> @ imm = #0xf4
   6e582: f5a9 40b5    	sub.w	r0, r9, #0x5a80
   6e586: eeb0 1b48    	vmov.f64	d1, d8
   6e58a: 2104         	movs	r1, #0x4
   6e58c: ed90 0b00    	vldr	d0, [r0]
   6e590: 200a         	movs	r0, #0xa
   6e592: 47c0         	blx	r8
   6e594: 4605         	mov	r5, r0
   6e596: eba9 000a    	sub.w	r0, r9, r10
   6e59a: ef2a 111a    	vorr	d1, d10, d10
   6e59e: 2104         	movs	r1, #0x4
   6e5a0: ed90 0b00    	vldr	d0, [r0]
   6e5a4: 200a         	movs	r0, #0xa
   6e5a6: 47c0         	blx	r8
   6e5a8: ef29 1119    	vorr	d1, d9, d9
   6e5ac: ed19 0b48    	vldr	d0, [r9, #-288]
   6e5b0: 4606         	mov	r6, r0
   6e5b2: 200a         	movs	r0, #0xa
   6e5b4: 2104         	movs	r1, #0x4
   6e5b6: 47c0         	blx	r8
   6e5b8: ee0e 5b30    	vmov.16	d14[0], r5
   6e5bc: ef2b 111b    	vorr	d1, d11, d11
   6e5c0: 2104         	movs	r1, #0x4
   6e5c2: ecb9 0b02    	vldmia	r9!, {d0}
   6e5c6: ee0e 6b70    	vmov.16	d14[1], r6
   6e5ca: ee2e 0b30    	vmov.16	d14[2], r0
   6e5ce: 200a         	movs	r0, #0xa
   6e5d0: 47c0         	blx	r8
   6e5d2: ee2e 0b70    	vmov.16	d14[3], r0
   6e5d6: 3c01         	subs	r4, #0x1
   6e5d8: fff5 010e    	vceq.i16	d16, d14, #0
   6e5dc: ef5d 0130    	vbic	d16, d13, d16
   6e5e0: ef1c c820    	vadd.i16	d12, d12, d16
   6e5e4: e7cb         	b	0x6e57e <f_check_cgm_trend+0xe6> @ imm = #-0x6a
   6e5e6: b2e8         	uxtb	r0, r5
   6e5e8: fa5f f188    	uxtb.w	r1, r8
   6e5ec: ea80 0009    	eor.w	r0, r0, r9
   6e5f0: ea81 0109    	eor.w	r1, r1, r9
   6e5f4: 4308         	orrs	r0, r1
   6e5f6: b280         	uxth	r0, r0
   6e5f8: fab0 f080    	clz	r0, r0
   6e5fc: 0940         	lsrs	r0, r0, #0x5
   6e5fe: ecbd 4b16    	vpop	{d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14}
   6e602: b001         	add	sp, #0x4
   6e604: e8bd 0f00    	pop.w	{r8, r9, r10, r11}
   6e608: bdf0         	pop	{r4, r5, r6, r7, pc}
   6e60a: 9106         	str	r1, [sp, #0x18]
   6e60c: 180c         	adds	r4, r1, r0
   6e60e: 48b8         	ldr	r0, [pc, #0x2e0]        @ 0x6e8f0 <f_check_cgm_trend+0x458>
   6e610: f04f 0b00    	mov.w	r11, #0x0
   6e614: ec9e 8b04    	vldmia	lr, {d8, d9}
   6e618: f04f 0800    	mov.w	r8, #0x0
   6e61c: eb01 0a00    	add.w	r10, r1, r0
   6e620: f04f 0900    	mov.w	r9, #0x0
   6e624: ed9e ab1a    	vldr	d10, [lr, #104]
   6e628: 4db5         	ldr	r5, [pc, #0x2d4]        @ 0x6e900 <f_check_cgm_trend+0x468>
   6e62a: 447d         	add	r5, pc
   6e62c: 2e00         	cmp	r6, #0x0
   6e62e: f000 80b2    	beq.w	0x6e796 <f_check_cgm_trend+0x2fe> @ imm = #0x164
   6e632: eeb0 1b48    	vmov.f64	d1, d8
   6e636: 200a         	movs	r0, #0xa
   6e638: 2104         	movs	r1, #0x4
   6e63a: ed14 0b48    	vldr	d0, [r4, #-288]
   6e63e: 47a8         	blx	r5
   6e640: ef29 1119    	vorr	d1, d9, d9
   6e644: 2800         	cmp	r0, #0x0
   6e646: bf18         	it	ne
   6e648: f10b 0b01    	addne.w	r11, r11, #0x1
   6e64c: ecb4 0b02    	vldmia	r4!, {d0}
   6e650: 200a         	movs	r0, #0xa
   6e652: 2104         	movs	r1, #0x4
   6e654: 47a8         	blx	r5
   6e656: ef2a 111a    	vorr	d1, d10, d10
   6e65a: 2800         	cmp	r0, #0x0
   6e65c: bf18         	it	ne
   6e65e: f108 0801    	addne.w	r8, r8, #0x1
   6e662: ecba 0b02    	vldmia	r10!, {d0}
   6e666: 200a         	movs	r0, #0xa
   6e668: 2101         	movs	r1, #0x1
   6e66a: 47a8         	blx	r5
   6e66c: 2800         	cmp	r0, #0x0
   6e66e: bf18         	it	ne
   6e670: f109 0901    	addne.w	r9, r9, #0x1
   6e674: 3e01         	subs	r6, #0x1
   6e676: e7d9         	b	0x6e62c <f_check_cgm_trend+0x194> @ imm = #-0x4e
   6e678: 9802         	ldr	r0, [sp, #0x8]
   6e67a: ff87 cb3f    	vbic.i16	d12, #0xff00
   6e67e: f1bb 0f05    	cmp.w	r11, #0x5
   6e682: ee80 0bb0    	vdup.16	d16, r0
   6e686: ff50 089c    	vceq.i16	d16, d16, d12
   6e68a: ee90 0bf0    	vmov.u16	r0, d16[1]
   6e68e: ee90 1bb0    	vmov.u16	r1, d16[0]
   6e692: f000 0001    	and	r0, r0, #0x1
   6e696: f001 0101    	and	r1, r1, #0x1
   6e69a: ea41 0040    	orr.w	r0, r1, r0, lsl #1
   6e69e: eeb0 1bb0    	vmov.u16	r1, d16[2]
   6e6a2: f001 0101    	and	r1, r1, #0x1
   6e6a6: ea40 0081    	orr.w	r0, r0, r1, lsl #2
   6e6aa: eeb0 1bf0    	vmov.u16	r1, d16[3]
   6e6ae: ea40 00c1    	orr.w	r0, r0, r1, lsl #3
   6e6b2: f000 000f    	and	r0, r0, #0xf
   6e6b6: f0c0 80ce    	blo.w	0x6e856 <f_check_cgm_trend+0x3be> @ imm = #0x19c
   6e6ba: 9000         	str	r0, [sp]
   6e6bc: f04f 0800    	mov.w	r8, #0x0
   6e6c0: 488e         	ldr	r0, [pc, #0x238]        @ 0x6e8fc <f_check_cgm_trend+0x464>
   6e6c2: f04f 0b00    	mov.w	r11, #0x0
   6e6c6: 9905         	ldr	r1, [sp, #0x14]
   6e6c8: f8dd a004    	ldr.w	r10, [sp, #0x4]
   6e6cc: 180e         	adds	r6, r1, r0
   6e6ce: f24f 70f8    	movw	r0, #0xf7f8
   6e6d2: eb01 0900    	add.w	r9, r1, r0
   6e6d6: f107 0008    	add.w	r0, r7, #0x8
   6e6da: f100 0150    	add.w	r1, r0, #0x50
   6e6de: 9c06         	ldr	r4, [sp, #0x18]
   6e6e0: ed90 bb0e    	vldr	d11, [r0, #56]
   6e6e4: ed90 cb10    	vldr	d12, [r0, #64]
   6e6e8: 2000         	movs	r0, #0x0
   6e6ea: ecb1 8b06    	vldmia	r1!, {d8, d9, d10}
   6e6ee: 9005         	str	r0, [sp, #0x14]
   6e6f0: 2000         	movs	r0, #0x0
   6e6f2: 9004         	str	r0, [sp, #0x10]
   6e6f4: 2000         	movs	r0, #0x0
   6e6f6: 9003         	str	r0, [sp, #0xc]
   6e6f8: f1ba 0f00    	cmp.w	r10, #0x0
   6e6fc: f000 80ad    	beq.w	0x6e85a <f_check_cgm_trend+0x3c2> @ imm = #0x15a
   6e700: ed16 db90    	vldr	d13, [r6, #-576]
   6e704: ef2b 111b    	vorr	d1, d11, d11
   6e708: ef2d 011d    	vorr	d0, d13, d13
   6e70c: 200a         	movs	r0, #0xa
   6e70e: 2102         	movs	r1, #0x2
   6e710: 47a0         	blx	r4
   6e712: 2800         	cmp	r0, #0x0
   6e714: 9805         	ldr	r0, [sp, #0x14]
   6e716: bf18         	it	ne
   6e718: 3001         	addne	r0, #0x1
   6e71a: ecb6 eb02    	vldmia	r6!, {d14}
   6e71e: 2101         	movs	r1, #0x1
   6e720: eeb0 1b48    	vmov.f64	d1, d8
   6e724: 9005         	str	r0, [sp, #0x14]
   6e726: 200a         	movs	r0, #0xa
   6e728: eeb0 0b4e    	vmov.f64	d0, d14
   6e72c: 47a0         	blx	r4
   6e72e: eeb5 db40    	vcmp.f64	d13, #0
   6e732: 2800         	cmp	r0, #0x0
   6e734: 9804         	ldr	r0, [sp, #0x10]
   6e736: bf18         	it	ne
   6e738: 3001         	addne	r0, #0x1
   6e73a: 9004         	str	r0, [sp, #0x10]
   6e73c: eef1 0b4d    	vneg.f64	d16, d13
   6e740: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e744: bf48         	it	mi
   6e746: eeb0 db60    	vmovmi.f64	d13, d16
   6e74a: ef2d 011d    	vorr	d0, d13, d13
   6e74e: 200a         	movs	r0, #0xa
   6e750: ef2c 111c    	vorr	d1, d12, d12
   6e754: 2102         	movs	r1, #0x2
   6e756: 47a0         	blx	r4
   6e758: eeb0 0b4e    	vmov.f64	d0, d14
   6e75c: 4605         	mov	r5, r0
   6e75e: 200a         	movs	r0, #0xa
   6e760: 2101         	movs	r1, #0x1
   6e762: ef29 1119    	vorr	d1, d9, d9
   6e766: 47a0         	blx	r4
   6e768: 2800         	cmp	r0, #0x0
   6e76a: 9803         	ldr	r0, [sp, #0xc]
   6e76c: ef2a 111a    	vorr	d1, d10, d10
   6e770: bf18         	it	ne
   6e772: 3001         	addne	r0, #0x1
   6e774: ecb9 0b02    	vldmia	r9!, {d0}
   6e778: 2101         	movs	r1, #0x1
   6e77a: 9003         	str	r0, [sp, #0xc]
   6e77c: 200a         	movs	r0, #0xa
   6e77e: 47a0         	blx	r4
   6e780: 2800         	cmp	r0, #0x0
   6e782: bf18         	it	ne
   6e784: f10b 0b01    	addne.w	r11, r11, #0x1
   6e788: 2d00         	cmp	r5, #0x0
   6e78a: bf18         	it	ne
   6e78c: f108 0801    	addne.w	r8, r8, #0x1
   6e790: f1aa 0a01    	sub.w	r10, r10, #0x1
   6e794: e7b0         	b	0x6e6f8 <f_check_cgm_trend+0x260> @ imm = #-0xa0
   6e796: 9a02         	ldr	r2, [sp, #0x8]
   6e798: fa5f f088    	uxtb.w	r0, r8
   6e79c: fa5f f18b    	uxtb.w	r1, r11
   6e7a0: f8dd 8004    	ldr.w	r8, [sp, #0x4]
   6e7a4: 4050         	eors	r0, r2
   6e7a6: 4051         	eors	r1, r2
   6e7a8: 4308         	orrs	r0, r1
   6e7aa: fa5f f189    	uxtb.w	r1, r9
   6e7ae: b280         	uxth	r0, r0
   6e7b0: fab0 f080    	clz	r0, r0
   6e7b4: 0940         	lsrs	r0, r0, #0x5
   6e7b6: 4588         	cmp	r8, r1
   6e7b8: f47f af21    	bne.w	0x6e5fe <f_check_cgm_trend+0x166> @ imm = #-0x1be
   6e7bc: 9005         	str	r0, [sp, #0x14]
   6e7be: f04f 0b00    	mov.w	r11, #0x0
   6e7c2: 484c         	ldr	r0, [pc, #0x130]        @ 0x6e8f4 <f_check_cgm_trend+0x45c>
   6e7c4: f04f 0900    	mov.w	r9, #0x0
   6e7c8: 9906         	ldr	r1, [sp, #0x18]
   6e7ca: f04f 0a00    	mov.w	r10, #0x0
   6e7ce: 180c         	adds	r4, r1, r0
   6e7d0: 4849         	ldr	r0, [pc, #0x124]        @ 0x6e8f8 <f_check_cgm_trend+0x460>
   6e7d2: 180e         	adds	r6, r1, r0
   6e7d4: f107 0008    	add.w	r0, r7, #0x8
   6e7d8: ed90 8b04    	vldr	d8, [r0, #16]
   6e7dc: ed90 9b0a    	vldr	d9, [r0, #40]
   6e7e0: ed90 ab1c    	vldr	d10, [r0, #112]
   6e7e4: ed90 bb1e    	vldr	d11, [r0, #120]
   6e7e8: 2000         	movs	r0, #0x0
   6e7ea: 9006         	str	r0, [sp, #0x18]
   6e7ec: f1b8 0f00    	cmp.w	r8, #0x0
   6e7f0: d03e         	beq	0x6e870 <f_check_cgm_trend+0x3d8> @ imm = #0x7c
   6e7f2: ef2a 111a    	vorr	d1, d10, d10
   6e7f6: ed94 0b00    	vldr	d0, [r4]
   6e7fa: 200a         	movs	r0, #0xa
   6e7fc: 2104         	movs	r1, #0x4
   6e7fe: 47a8         	blx	r5
   6e800: 2800         	cmp	r0, #0x0
   6e802: 9806         	ldr	r0, [sp, #0x18]
   6e804: ef2b 111b    	vorr	d1, d11, d11
   6e808: bf18         	it	ne
   6e80a: 3001         	addne	r0, #0x1
   6e80c: ed94 0b48    	vldr	d0, [r4, #288]
   6e810: 2104         	movs	r1, #0x4
   6e812: 9006         	str	r0, [sp, #0x18]
   6e814: 200a         	movs	r0, #0xa
   6e816: 47a8         	blx	r5
   6e818: ef28 1118    	vorr	d1, d8, d8
   6e81c: 2800         	cmp	r0, #0x0
   6e81e: bf18         	it	ne
   6e820: f10b 0b01    	addne.w	r11, r11, #0x1
   6e824: ed96 0b00    	vldr	d0, [r6]
   6e828: 200a         	movs	r0, #0xa
   6e82a: 2104         	movs	r1, #0x4
   6e82c: 47a8         	blx	r5
   6e82e: ef29 1119    	vorr	d1, d9, d9
   6e832: 2800         	cmp	r0, #0x0
   6e834: bf18         	it	ne
   6e836: f109 0901    	addne.w	r9, r9, #0x1
   6e83a: ed96 0b48    	vldr	d0, [r6, #288]
   6e83e: 200a         	movs	r0, #0xa
   6e840: 2104         	movs	r1, #0x4
   6e842: 47a8         	blx	r5
   6e844: 2800         	cmp	r0, #0x0
   6e846: bf18         	it	ne
   6e848: f10a 0a01    	addne.w	r10, r10, #0x1
   6e84c: 3408         	adds	r4, #0x8
   6e84e: 3608         	adds	r6, #0x8
   6e850: f1a8 0801    	sub.w	r8, r8, #0x1
   6e854: e7ca         	b	0x6e7ec <f_check_cgm_trend+0x354> @ imm = #-0x6c
   6e856: 380f         	subs	r0, #0xf
   6e858: e6ce         	b	0x6e5f8 <f_check_cgm_trend+0x160> @ imm = #-0x264
   6e85a: 9800         	ldr	r0, [sp]
   6e85c: 280f         	cmp	r0, #0xf
   6e85e: d022         	beq	0x6e8a6 <f_check_cgm_trend+0x40e> @ imm = #0x44
   6e860: 2000         	movs	r0, #0x0
   6e862: e6cc         	b	0x6e5fe <f_check_cgm_trend+0x166> @ imm = #-0x268
   6e864: 4e 39 02 00  	.word	0x0002394e
   6e868: 3e f9 ff ff  	.word	0xfffff93e
   6e86c: 90 90 01 00  	.word	0x00019090
   6e870: 9b02         	ldr	r3, [sp, #0x8]
   6e872: fa5f f08a    	uxtb.w	r0, r10
   6e876: fa5f f189    	uxtb.w	r1, r9
   6e87a: 9a06         	ldr	r2, [sp, #0x18]
   6e87c: 4058         	eors	r0, r3
   6e87e: 4059         	eors	r1, r3
   6e880: 4308         	orrs	r0, r1
   6e882: fa5f f18b    	uxtb.w	r1, r11
   6e886: b2d2         	uxtb	r2, r2
   6e888: 4059         	eors	r1, r3
   6e88a: 405a         	eors	r2, r3
   6e88c: b280         	uxth	r0, r0
   6e88e: 4311         	orrs	r1, r2
   6e890: fab0 f080    	clz	r0, r0
   6e894: b289         	uxth	r1, r1
   6e896: 0940         	lsrs	r0, r0, #0x5
   6e898: fab1 f181    	clz	r1, r1
   6e89c: 0949         	lsrs	r1, r1, #0x5
   6e89e: 4301         	orrs	r1, r0
   6e8a0: 9805         	ldr	r0, [sp, #0x14]
   6e8a2: 4008         	ands	r0, r1
   6e8a4: e6ab         	b	0x6e5fe <f_check_cgm_trend+0x166> @ imm = #-0x2aa
   6e8a6: 9905         	ldr	r1, [sp, #0x14]
   6e8a8: fa5f f08b    	uxtb.w	r0, r11
   6e8ac: 9c01         	ldr	r4, [sp, #0x4]
   6e8ae: b2c9         	uxtb	r1, r1
   6e8b0: 428c         	cmp	r4, r1
   6e8b2: bf02         	ittt	eq
   6e8b4: 9904         	ldreq	r1, [sp, #0x10]
   6e8b6: b2c9         	uxtbeq	r1, r1
   6e8b8: 428c         	cmpeq	r4, r1
   6e8ba: d012         	beq	0x6e8e2 <f_check_cgm_trend+0x44a> @ imm = #0x24
   6e8bc: 9903         	ldr	r1, [sp, #0xc]
   6e8be: fa5f f288    	uxtb.w	r2, r8
   6e8c2: 9b02         	ldr	r3, [sp, #0x8]
   6e8c4: 1a20         	subs	r0, r4, r0
   6e8c6: b2c9         	uxtb	r1, r1
   6e8c8: fab0 f080    	clz	r0, r0
   6e8cc: 4059         	eors	r1, r3
   6e8ce: 405a         	eors	r2, r3
   6e8d0: 4311         	orrs	r1, r2
   6e8d2: 0940         	lsrs	r0, r0, #0x5
   6e8d4: b289         	uxth	r1, r1
   6e8d6: fab1 f181    	clz	r1, r1
   6e8da: 0949         	lsrs	r1, r1, #0x5
   6e8dc: 4201         	tst	r1, r0
   6e8de: d0bf         	beq	0x6e860 <f_check_cgm_trend+0x3c8> @ imm = #-0x82
   6e8e0: e001         	b	0x6e8e6 <f_check_cgm_trend+0x44e> @ imm = #0x2
   6e8e2: 4284         	cmp	r4, r0
   6e8e4: d1bc         	bne	0x6e860 <f_check_cgm_trend+0x3c8> @ imm = #-0x88
   6e8e6: 2001         	movs	r0, #0x1
   6e8e8: e689         	b	0x6e5fe <f_check_cgm_trend+0x166> @ imm = #-0x2ee
   6e8ea: bf00         	nop
   6e8ec: 90 90 01 00  	.word	0x00019090
   6e8f0: 88 53 01 00  	.word	0x00015388
   6e8f4: a8 54 01 00  	.word	0x000154a8
   6e8f8: 10 36 01 00  	.word	0x00013610
   6e8fc: f0 34 01 00  	.word	0x000134f0
   6e900: fb e1 ff ff  	.word	0xffffe1fb
   6e904: af e2 ff ff  	.word	0xffffe2af

0006e908 <cal_threshold>:
   6e908: b5f0         	push	{r4, r5, r6, r7, lr}
   6e90a: af03         	add	r7, sp, #0xc
   6e90c: f84d bd04    	str	r11, [sp, #-4]!
   6e910: eeb5 1b40    	vcmp.f64	d1, #0
   6e914: 68bd         	ldr	r5, [r7, #0x8]
   6e916: eef1 0b41    	vneg.f64	d16, d1
   6e91a: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e91e: bf48         	it	mi
   6e920: eeb0 1b60    	vmovmi.f64	d1, d16
   6e924: 4e34         	ldr	r6, [pc, #0xd0]         @ 0x6e9f8 <cal_threshold+0xf0>
   6e926: f893 e000    	ldrb.w	lr, [r3]
   6e92a: 447e         	add	r6, pc
   6e92c: edd2 0b00    	vldr	d16, [r2]
   6e930: f8b6 447a    	ldrh.w	r4, [r6, #0x47a]
   6e934: 42ac         	cmp	r4, r5
   6e936: d915         	bls	0x6e964 <cal_threshold+0x5c> @ imm = #0x2a
   6e938: b325         	cbz	r5, 0x6e984 <cal_threshold+0x7c> @ imm = #0x48
   6e93a: eeb4 2b42    	vcmp.f64	d2, d2
   6e93e: f105 0c01    	add.w	r12, r5, #0x1
   6e942: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e946: eddf 1b2a    	vldr	d17, [pc, #168]         @ 0x6e9f0 <cal_threshold+0xe8>
   6e94a: bf68         	it	vs
   6e94c: eeb0 2b61    	vmovvs.f64	d2, d17
   6e950: ee32 0b00    	vadd.f64	d0, d2, d0
   6e954: eeb4 3b43    	vcmp.f64	d3, d3
   6e958: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e95c: d645         	bvs	0x6e9ea <cal_threshold+0xe2> @ imm = #0x8a
   6e95e: ee71 0b03    	vadd.f64	d16, d1, d3
   6e962: e037         	b	0x6e9d4 <cal_threshold+0xcc> @ imm = #0x6e
   6e964: f8b0 c000    	ldrh.w	r12, [r0]
   6e968: d109         	bne	0x6e97e <cal_threshold+0x76> @ imm = #0x12
   6e96a: 68fc         	ldr	r4, [r7, #0xc]
   6e96c: 2c01         	cmp	r4, #0x1
   6e96e: d117         	bne	0x6e9a0 <cal_threshold+0x98> @ imm = #0x2e
   6e970: f04f 0e01    	mov.w	lr, #0x1
   6e974: eeb0 0b42    	vmov.f64	d0, d2
   6e978: eef0 0b43    	vmov.f64	d16, d3
   6e97c: e02a         	b	0x6e9d4 <cal_threshold+0xcc> @ imm = #0x54
   6e97e: ed91 0b00    	vldr	d0, [r1]
   6e982: e027         	b	0x6e9d4 <cal_threshold+0xcc> @ imm = #0x4e
   6e984: f506 6490    	add.w	r4, r6, #0x480
   6e988: f04f 0c01    	mov.w	r12, #0x1
   6e98c: edd4 1b00    	vldr	d17, [r4]
   6e990: eeb4 1b61    	vcmp.f64	d1, d17
   6e994: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6e998: dd1c         	ble	0x6e9d4 <cal_threshold+0xcc> @ imm = #0x38
   6e99a: eef0 0b41    	vmov.f64	d16, d1
   6e99e: e019         	b	0x6e9d4 <cal_threshold+0xcc> @ imm = #0x32
   6e9a0: ee00 5a10    	vmov	s0, r5
   6e9a4: f896 547d    	ldrb.w	r5, [r6, #0x47d]
   6e9a8: f896 447c    	ldrb.w	r4, [r6, #0x47c]
   6e9ac: f04f 0e01    	mov.w	lr, #0x1
   6e9b0: eef8 1b40    	vcvt.f64.u32	d17, s0
   6e9b4: eec3 0b21    	vdiv.f64	d16, d3, d17
   6e9b8: eec2 1b21    	vdiv.f64	d17, d2, d17
   6e9bc: ee00 5a10    	vmov	s0, r5
   6e9c0: eef8 2b40    	vcvt.f64.u32	d18, s0
   6e9c4: ee00 4a10    	vmov	s0, r4
   6e9c8: ee60 0ba2    	vmul.f64	d16, d16, d18
   6e9cc: eef8 2b40    	vcvt.f64.u32	d18, s0
   6e9d0: ee21 0ba2    	vmul.f64	d0, d17, d18
   6e9d4: ed81 0b00    	vstr	d0, [r1]
   6e9d8: f8a0 c000    	strh.w	r12, [r0]
   6e9dc: edc2 0b00    	vstr	d16, [r2]
   6e9e0: f883 e000    	strb.w	lr, [r3]
   6e9e4: f85d bb04    	ldr	r11, [sp], #4
   6e9e8: bdf0         	pop	{r4, r5, r6, r7, pc}
   6e9ea: f506 6490    	add.w	r4, r6, #0x480
   6e9ee: e7cd         	b	0x6e98c <cal_threshold+0x84> @ imm = #-0x66
   6e9f0: 00 00 00 00  	.word	0x00000000
   6e9f4: 00 00 00 80  	.word	0x80000000
   6e9f8: 7a 3d 02 00  	.word	0x00023d7a

0006e9fc <err1_TD_var_update>:
   6e9fc: b5f0         	push	{r4, r5, r6, r7, lr}
   6e9fe: af03         	add	r7, sp, #0xc
   6ea00: f84d 8d04    	str	r8, [sp, #-4]!
   6ea04: f8d7 c010    	ldr.w	r12, [r7, #0x10]
   6ea08: f04f 0800    	mov.w	r8, #0x0
   6ea0c: e9d7 4e02    	ldrd	r4, lr, [r7, #8]
   6ea10: 2600         	movs	r6, #0x0
   6ea12: 2e5a         	cmp	r6, #0x5a
   6ea14: d00f         	beq	0x6ea36 <err1_TD_var_update+0x3a> @ imm = #0x1e
   6ea16: f85e 5026    	ldr.w	r5, [lr, r6, lsl #2]
   6ea1a: edd4 0b00    	vldr	d16, [r4]
   6ea1e: f842 5026    	str.w	r5, [r2, r6, lsl #2]
   6ea22: ece1 0b02    	vstmia	r1!, {d16}
   6ea26: f820 8016    	strh.w	r8, [r0, r6, lsl #1]
   6ea2a: f84e 8026    	str.w	r8, [lr, r6, lsl #2]
   6ea2e: 3601         	adds	r6, #0x1
   6ea30: e8e4 8802    	strd	r8, r8, [r4], #8
   6ea34: e7ed         	b	0x6ea12 <err1_TD_var_update+0x16> @ imm = #-0x26
   6ea36: f8bc 0000    	ldrh.w	r0, [r12]
   6ea3a: 8018         	strh	r0, [r3]
   6ea3c: 2000         	movs	r0, #0x0
   6ea3e: f8ac 0000    	strh.w	r0, [r12]
   6ea42: f85d 8b04    	ldr	r8, [sp], #4
   6ea46: bdf0         	pop	{r4, r5, r6, r7, pc}

0006ea48 <err1_TD_trio_update>:
   6ea48: b5f0         	push	{r4, r5, r6, r7, lr}
   6ea4a: af03         	add	r7, sp, #0xc
   6ea4c: e92d 0f00    	push.w	{r8, r9, r10, r11}
   6ea50: f8d7 8010    	ldr.w	r8, [r7, #0x10]
   6ea54: f04f 0a00    	mov.w	r10, #0x0
   6ea58: e9d7 be02    	ldrd	r11, lr, [r7, #8]
   6ea5c: f04f 0900    	mov.w	r9, #0x0
   6ea60: f1b9 0f5a    	cmp.w	r9, #0x5a
   6ea64: d01c         	beq	0x6eaa0 <err1_TD_trio_update+0x58> @ imm = #0x38
   6ea66: 2400         	movs	r4, #0x0
   6ea68: 4606         	mov	r6, r0
   6ea6a: 461d         	mov	r5, r3
   6ea6c: 2c03         	cmp	r4, #0x3
   6ea6e: d00d         	beq	0x6ea8c <err1_TD_trio_update+0x44> @ imm = #0x1a
   6ea70: f85b c024    	ldr.w	r12, [r11, r4, lsl #2]
   6ea74: edd5 0b00    	vldr	d16, [r5]
   6ea78: f841 c024    	str.w	r12, [r1, r4, lsl #2]
   6ea7c: f84b a024    	str.w	r10, [r11, r4, lsl #2]
   6ea80: 3401         	adds	r4, #0x1
   6ea82: ece6 0b02    	vstmia	r6!, {d16}
   6ea86: e8e5 aa02    	strd	r10, r10, [r5], #8
   6ea8a: e7ef         	b	0x6ea6c <err1_TD_trio_update+0x24> @ imm = #-0x22
   6ea8c: f808 a009    	strb.w	r10, [r8, r9]
   6ea90: 3018         	adds	r0, #0x18
   6ea92: 3318         	adds	r3, #0x18
   6ea94: 310c         	adds	r1, #0xc
   6ea96: f10b 0b0c    	add.w	r11, r11, #0xc
   6ea9a: f109 0901    	add.w	r9, r9, #0x1
   6ea9e: e7df         	b	0x6ea60 <err1_TD_trio_update+0x18> @ imm = #-0x42
   6eaa0: 6979         	ldr	r1, [r7, #0x14]
   6eaa2: f89e 0000    	ldrb.w	r0, [lr]
   6eaa6: 7010         	strb	r0, [r2]
   6eaa8: 2000         	movs	r0, #0x0
   6eaaa: f88e 0000    	strb.w	r0, [lr]
   6eaae: 7008         	strb	r0, [r1]
   6eab0: e8bd 0f00    	pop.w	{r8, r9, r10, r11}
   6eab4: bdf0         	pop	{r4, r5, r6, r7, pc}
   6eab6: d4d4         	bmi	0x6ea62 <err1_TD_trio_update+0x1a> @ imm = #-0x58

0006eab8 <__udivsi3>:
   6eab8: e3510001     	cmp	r1, #1
   6eabc: 3a00000b     	blo	0x6eaf0 <__udivsi3+0x38> @ imm = #0x2c
   6eac0: 012fff1e     	bxeq	lr
   6eac4: e1500001     	cmp	r0, r1
   6eac8: 33a00000     	movlo	r0, #0
   6eacc: 312fff1e     	bxlo	lr
   6ead0: e16fcf10     	clz	r12, r0
   6ead4: e16f3f11     	clz	r3, r1
   6ead8: e043300c     	sub	r3, r3, r12
   6eadc: e28fce19     	add	r12, pc, #400
   6eae0: e04cc103     	sub	r12, r12, r3, lsl #2
   6eae4: e04cc183     	sub	r12, r12, r3, lsl #3
   6eae8: e3a03000     	mov	r3, #0
   6eaec: e12fff1c     	bx	r12
   6eaf0: e3b00000     	movs	r0, #0
   6eaf4: e92d4080     	push	{r7, lr}
   6eaf8: eb0000a0     	bl	0x6ed80 <__aeabi_idiv0> @ imm = #0x280
   6eafc: e8bd8080     	pop	{r7, pc}
   6eb00: e1500f81     	cmp	r0, r1, lsl #31
   6eb04: 22833102     	addhs	r3, r3, #-2147483648
   6eb08: 20400f81     	subhs	r0, r0, r1, lsl #31
   6eb0c: e1500f01     	cmp	r0, r1, lsl #30
   6eb10: 22833101     	addhs	r3, r3, #1073741824
   6eb14: 20400f01     	subhs	r0, r0, r1, lsl #30
   6eb18: e1500e81     	cmp	r0, r1, lsl #29
   6eb1c: 22833202     	addhs	r3, r3, #536870912
   6eb20: 20400e81     	subhs	r0, r0, r1, lsl #29
   6eb24: e1500e01     	cmp	r0, r1, lsl #28
   6eb28: 22833201     	addhs	r3, r3, #268435456
   6eb2c: 20400e01     	subhs	r0, r0, r1, lsl #28
   6eb30: e1500d81     	cmp	r0, r1, lsl #27
   6eb34: 22833302     	addhs	r3, r3, #134217728
   6eb38: 20400d81     	subhs	r0, r0, r1, lsl #27
   6eb3c: e1500d01     	cmp	r0, r1, lsl #26
   6eb40: 22833301     	addhs	r3, r3, #67108864
   6eb44: 20400d01     	subhs	r0, r0, r1, lsl #26
   6eb48: e1500c81     	cmp	r0, r1, lsl #25
   6eb4c: 22833402     	addhs	r3, r3, #33554432
   6eb50: 20400c81     	subhs	r0, r0, r1, lsl #25
   6eb54: e1500c01     	cmp	r0, r1, lsl #24
   6eb58: 22833401     	addhs	r3, r3, #16777216
   6eb5c: 20400c01     	subhs	r0, r0, r1, lsl #24
   6eb60: e1500b81     	cmp	r0, r1, lsl #23
   6eb64: 22833502     	addhs	r3, r3, #8388608
   6eb68: 20400b81     	subhs	r0, r0, r1, lsl #23
   6eb6c: e1500b01     	cmp	r0, r1, lsl #22
   6eb70: 22833501     	addhs	r3, r3, #4194304
   6eb74: 20400b01     	subhs	r0, r0, r1, lsl #22
   6eb78: e1500a81     	cmp	r0, r1, lsl #21
   6eb7c: 22833602     	addhs	r3, r3, #2097152
   6eb80: 20400a81     	subhs	r0, r0, r1, lsl #21
   6eb84: e1500a01     	cmp	r0, r1, lsl #20
   6eb88: 22833601     	addhs	r3, r3, #1048576
   6eb8c: 20400a01     	subhs	r0, r0, r1, lsl #20
   6eb90: e1500981     	cmp	r0, r1, lsl #19
   6eb94: 22833702     	addhs	r3, r3, #524288
   6eb98: 20400981     	subhs	r0, r0, r1, lsl #19
   6eb9c: e1500901     	cmp	r0, r1, lsl #18
   6eba0: 22833701     	addhs	r3, r3, #262144
   6eba4: 20400901     	subhs	r0, r0, r1, lsl #18
   6eba8: e1500881     	cmp	r0, r1, lsl #17
   6ebac: 22833802     	addhs	r3, r3, #131072
   6ebb0: 20400881     	subhs	r0, r0, r1, lsl #17
   6ebb4: e1500801     	cmp	r0, r1, lsl #16
   6ebb8: 22833801     	addhs	r3, r3, #65536
   6ebbc: 20400801     	subhs	r0, r0, r1, lsl #16
   6ebc0: e1500781     	cmp	r0, r1, lsl #15
   6ebc4: 22833902     	addhs	r3, r3, #32768
   6ebc8: 20400781     	subhs	r0, r0, r1, lsl #15
   6ebcc: e1500701     	cmp	r0, r1, lsl #14
   6ebd0: 22833901     	addhs	r3, r3, #16384
   6ebd4: 20400701     	subhs	r0, r0, r1, lsl #14
   6ebd8: e1500681     	cmp	r0, r1, lsl #13
   6ebdc: 22833a02     	addhs	r3, r3, #8192
   6ebe0: 20400681     	subhs	r0, r0, r1, lsl #13
   6ebe4: e1500601     	cmp	r0, r1, lsl #12
   6ebe8: 22833a01     	addhs	r3, r3, #4096
   6ebec: 20400601     	subhs	r0, r0, r1, lsl #12
   6ebf0: e1500581     	cmp	r0, r1, lsl #11
   6ebf4: 22833b02     	addhs	r3, r3, #2048
   6ebf8: 20400581     	subhs	r0, r0, r1, lsl #11
   6ebfc: e1500501     	cmp	r0, r1, lsl #10
   6ec00: 22833b01     	addhs	r3, r3, #1024
   6ec04: 20400501     	subhs	r0, r0, r1, lsl #10
   6ec08: e1500481     	cmp	r0, r1, lsl #9
   6ec0c: 22833c02     	addhs	r3, r3, #512
   6ec10: 20400481     	subhs	r0, r0, r1, lsl #9
   6ec14: e1500401     	cmp	r0, r1, lsl #8
   6ec18: 22833c01     	addhs	r3, r3, #256
   6ec1c: 20400401     	subhs	r0, r0, r1, lsl #8
   6ec20: e1500381     	cmp	r0, r1, lsl #7
   6ec24: 22833080     	addhs	r3, r3, #128
   6ec28: 20400381     	subhs	r0, r0, r1, lsl #7
   6ec2c: e1500301     	cmp	r0, r1, lsl #6
   6ec30: 22833040     	addhs	r3, r3, #64
   6ec34: 20400301     	subhs	r0, r0, r1, lsl #6
   6ec38: e1500281     	cmp	r0, r1, lsl #5
   6ec3c: 22833020     	addhs	r3, r3, #32
   6ec40: 20400281     	subhs	r0, r0, r1, lsl #5
   6ec44: e1500201     	cmp	r0, r1, lsl #4
   6ec48: 22833010     	addhs	r3, r3, #16
   6ec4c: 20400201     	subhs	r0, r0, r1, lsl #4
   6ec50: e1500181     	cmp	r0, r1, lsl #3
   6ec54: 22833008     	addhs	r3, r3, #8
   6ec58: 20400181     	subhs	r0, r0, r1, lsl #3
   6ec5c: e1500101     	cmp	r0, r1, lsl #2
   6ec60: 22833004     	addhs	r3, r3, #4
   6ec64: 20400101     	subhs	r0, r0, r1, lsl #2
   6ec68: e1500081     	cmp	r0, r1, lsl #1
   6ec6c: 22833002     	addhs	r3, r3, #2
   6ec70: 20400081     	subhs	r0, r0, r1, lsl #1
   6ec74: e1500001     	cmp	r0, r1
   6ec78: 22833001     	addhs	r3, r3, #1
   6ec7c: 20400001     	subhs	r0, r0, r1
   6ec80: e1a00003     	mov	r0, r3
   6ec84: e12fff1e     	bx	lr

0006ec88 <__fixdfdi>:
   6ec88: ec410b30     	vmov	d16, r0, r1
   6ec8c: eef50b40     	vcmp.f64	d16, #0
   6ec90: eef1fa10     	vmrs	APSR_nzcv, fpscr
   6ec94: 5a000006     	bpl	0x6ecb4 <__fixdfdi+0x2c> @ imm = #0x18
   6ec98: e92d4800     	push	{r11, lr}
   6ec9c: eef10b60     	vneg.f64	d16, d16
   6eca0: ec510b30     	vmov	r0, r1, d16
   6eca4: eb000003     	bl	0x6ecb8 <__fixunsdfdi>  @ imm = #0xc
   6eca8: e2700000     	rsbs	r0, r0, #0
   6ecac: e2e11000     	rsc	r1, r1, #0
   6ecb0: e8bd8800     	pop	{r11, pc}
   6ecb4: eaffffff     	b	0x6ecb8 <__fixunsdfdi>  @ imm = #-0x4

0006ecb8 <__fixunsdfdi>:
   6ecb8: ec410b30     	vmov	d16, r0, r1
   6ecbc: e3a00000     	mov	r0, #0
   6ecc0: eef50b40     	vcmp.f64	d16, #0
   6ecc4: e3a01000     	mov	r1, #0
   6ecc8: eef1fa10     	vmrs	APSR_nzcv, fpscr
   6eccc: 912fff1e     	bxls	lr
   6ecd0: eddf1b08     	vldr	d17, [pc, #32]          @ 0x6ecf8 <__fixunsdfdi+0x40>
   6ecd4: eddf2b09     	vldr	d18, [pc, #36]          @ 0x6ed00 <__fixunsdfdi+0x48>
   6ecd8: ee601ba1     	vmul.f64	d17, d16, d17
   6ecdc: eebc0be1     	vcvt.u32.f64	s0, d17
   6ece0: eef81b40     	vcvt.f64.u32	d17, s0
   6ece4: ee410ba2     	vmla.f64	d16, d17, d18
   6ece8: ee101a10     	vmov	r1, s0
   6ecec: eebc0be0     	vcvt.u32.f64	s0, d16
   6ecf0: ee100a10     	vmov	r0, s0
   6ecf4: e12fff1e     	bx	lr
   6ecf8: 00 00 00 00  	.word	0x00000000
   6ecfc: 00 00 f0 3d  	.word	0x3df00000
   6ed00: 00 00 00 00  	.word	0x00000000
   6ed04: 00 00 f0 c1  	.word	0xc1f00000

0006ed08 <__floatdidf>:
   6ed08: ee001a10     	vmov	s0, r1
   6ed0c: eddf1b09     	vldr	d17, [pc, #36]          @ 0x6ed38 <__floatdidf+0x30>
   6ed10: eddf2b0a     	vldr	d18, [pc, #40]          @ 0x6ed40 <__floatdidf+0x38>
   6ed14: e3001000     	movw	r1, #0x0
   6ed18: eef80bc0     	vcvt.f64.s32	d16, s0
   6ed1c: e3441330     	movt	r1, #0x4330
   6ed20: ee402ba1     	vmla.f64	d18, d16, d17
   6ed24: ec410b30     	vmov	d16, r0, r1
   6ed28: ee720ba0     	vadd.f64	d16, d18, d16
   6ed2c: ec510b30     	vmov	r0, r1, d16
   6ed30: e12fff1e     	bx	lr
   6ed34: e320f000     	nop
   6ed38: 00 00 00 00  	.word	0x00000000
   6ed3c: 00 00 f0 41  	.word	0x41f00000
   6ed40: 00 00 00 00  	.word	0x00000000
   6ed44: 00 00 30 c3  	.word	0xc3300000

0006ed48 <__floatundidf>:
   6ed48: e3002000     	movw	r2, #0x0
   6ed4c: eddf0b09     	vldr	d16, [pc, #36]          @ 0x6ed78 <__floatundidf+0x30>
   6ed50: e3442530     	movt	r2, #0x4530
   6ed54: ec421b31     	vmov	d17, r1, r2
   6ed58: e3001000     	movw	r1, #0x0
   6ed5c: e3441330     	movt	r1, #0x4330
   6ed60: ee710ba0     	vadd.f64	d16, d17, d16
   6ed64: ec410b31     	vmov	d17, r0, r1
   6ed68: ee700ba1     	vadd.f64	d16, d16, d17
   6ed6c: ec510b30     	vmov	r0, r1, d16
   6ed70: e12fff1e     	bx	lr
   6ed74: e320f000     	nop
   6ed78: 00 00 10 00  	.word	0x00100000
   6ed7c: 00 00 30 c5  	.word	0xc5300000

0006ed80 <__aeabi_idiv0>:
   6ed80: e12fff1e     	bx	lr

0006ed84 <__aeabi_uidivmod>:
   6ed84: e52de004     	str	lr, [sp, #-0x4]!
   6ed88: e24dd004     	sub	sp, sp, #4
   6ed8c: e1a0200d     	mov	r2, sp
   6ed90: eb000002     	bl	0x6eda0 <__udivmodsi4>  @ imm = #0x8
   6ed94: e59d1000     	ldr	r1, [sp]
   6ed98: e28dd004     	add	sp, sp, #4
   6ed9c: e49df004     	ldr	pc, [sp], #4

0006eda0 <__udivmodsi4>:
   6eda0: e3510001     	cmp	r1, #1
   6eda4: 3a000073     	blo	0x6ef78 <__udivmodsi4+0x1d8> @ imm = #0x1cc
   6eda8: 0a00006f     	beq	0x6ef6c <__udivmodsi4+0x1cc> @ imm = #0x1bc
   6edac: e1500001     	cmp	r0, r1
   6edb0: 3a00006a     	blo	0x6ef60 <__udivmodsi4+0x1c0> @ imm = #0x1a8
   6edb4: e16fcf10     	clz	r12, r0
   6edb8: e16f3f11     	clz	r3, r1
   6edbc: e043300c     	sub	r3, r3, r12
   6edc0: e28fcd06     	add	r12, pc, #384
   6edc4: e04cc103     	sub	r12, r12, r3, lsl #2
   6edc8: e04cc183     	sub	r12, r12, r3, lsl #3
   6edcc: e3a03000     	mov	r3, #0
   6edd0: e12fff1c     	bx	r12
   6edd4: e1500f81     	cmp	r0, r1, lsl #31
   6edd8: 22833102     	addhs	r3, r3, #-2147483648
   6eddc: 20400f81     	subhs	r0, r0, r1, lsl #31
   6ede0: e1500f01     	cmp	r0, r1, lsl #30
   6ede4: 22833101     	addhs	r3, r3, #1073741824
   6ede8: 20400f01     	subhs	r0, r0, r1, lsl #30
   6edec: e1500e81     	cmp	r0, r1, lsl #29
   6edf0: 22833202     	addhs	r3, r3, #536870912
   6edf4: 20400e81     	subhs	r0, r0, r1, lsl #29
   6edf8: e1500e01     	cmp	r0, r1, lsl #28
   6edfc: 22833201     	addhs	r3, r3, #268435456
   6ee00: 20400e01     	subhs	r0, r0, r1, lsl #28
   6ee04: e1500d81     	cmp	r0, r1, lsl #27
   6ee08: 22833302     	addhs	r3, r3, #134217728
   6ee0c: 20400d81     	subhs	r0, r0, r1, lsl #27
   6ee10: e1500d01     	cmp	r0, r1, lsl #26
   6ee14: 22833301     	addhs	r3, r3, #67108864
   6ee18: 20400d01     	subhs	r0, r0, r1, lsl #26
   6ee1c: e1500c81     	cmp	r0, r1, lsl #25
   6ee20: 22833402     	addhs	r3, r3, #33554432
   6ee24: 20400c81     	subhs	r0, r0, r1, lsl #25
   6ee28: e1500c01     	cmp	r0, r1, lsl #24
   6ee2c: 22833401     	addhs	r3, r3, #16777216
   6ee30: 20400c01     	subhs	r0, r0, r1, lsl #24
   6ee34: e1500b81     	cmp	r0, r1, lsl #23
   6ee38: 22833502     	addhs	r3, r3, #8388608
   6ee3c: 20400b81     	subhs	r0, r0, r1, lsl #23
   6ee40: e1500b01     	cmp	r0, r1, lsl #22
   6ee44: 22833501     	addhs	r3, r3, #4194304
   6ee48: 20400b01     	subhs	r0, r0, r1, lsl #22
   6ee4c: e1500a81     	cmp	r0, r1, lsl #21
   6ee50: 22833602     	addhs	r3, r3, #2097152
   6ee54: 20400a81     	subhs	r0, r0, r1, lsl #21
   6ee58: e1500a01     	cmp	r0, r1, lsl #20
   6ee5c: 22833601     	addhs	r3, r3, #1048576
   6ee60: 20400a01     	subhs	r0, r0, r1, lsl #20
   6ee64: e1500981     	cmp	r0, r1, lsl #19
   6ee68: 22833702     	addhs	r3, r3, #524288
   6ee6c: 20400981     	subhs	r0, r0, r1, lsl #19
   6ee70: e1500901     	cmp	r0, r1, lsl #18
   6ee74: 22833701     	addhs	r3, r3, #262144
   6ee78: 20400901     	subhs	r0, r0, r1, lsl #18
   6ee7c: e1500881     	cmp	r0, r1, lsl #17
   6ee80: 22833802     	addhs	r3, r3, #131072
   6ee84: 20400881     	subhs	r0, r0, r1, lsl #17
   6ee88: e1500801     	cmp	r0, r1, lsl #16
   6ee8c: 22833801     	addhs	r3, r3, #65536
   6ee90: 20400801     	subhs	r0, r0, r1, lsl #16
   6ee94: e1500781     	cmp	r0, r1, lsl #15
   6ee98: 22833902     	addhs	r3, r3, #32768
   6ee9c: 20400781     	subhs	r0, r0, r1, lsl #15
   6eea0: e1500701     	cmp	r0, r1, lsl #14
   6eea4: 22833901     	addhs	r3, r3, #16384
   6eea8: 20400701     	subhs	r0, r0, r1, lsl #14
   6eeac: e1500681     	cmp	r0, r1, lsl #13
   6eeb0: 22833a02     	addhs	r3, r3, #8192
   6eeb4: 20400681     	subhs	r0, r0, r1, lsl #13
   6eeb8: e1500601     	cmp	r0, r1, lsl #12
   6eebc: 22833a01     	addhs	r3, r3, #4096
   6eec0: 20400601     	subhs	r0, r0, r1, lsl #12
   6eec4: e1500581     	cmp	r0, r1, lsl #11
   6eec8: 22833b02     	addhs	r3, r3, #2048
   6eecc: 20400581     	subhs	r0, r0, r1, lsl #11
   6eed0: e1500501     	cmp	r0, r1, lsl #10
   6eed4: 22833b01     	addhs	r3, r3, #1024
   6eed8: 20400501     	subhs	r0, r0, r1, lsl #10
   6eedc: e1500481     	cmp	r0, r1, lsl #9
   6eee0: 22833c02     	addhs	r3, r3, #512
   6eee4: 20400481     	subhs	r0, r0, r1, lsl #9
   6eee8: e1500401     	cmp	r0, r1, lsl #8
   6eeec: 22833c01     	addhs	r3, r3, #256
   6eef0: 20400401     	subhs	r0, r0, r1, lsl #8
   6eef4: e1500381     	cmp	r0, r1, lsl #7
   6eef8: 22833080     	addhs	r3, r3, #128
   6eefc: 20400381     	subhs	r0, r0, r1, lsl #7
   6ef00: e1500301     	cmp	r0, r1, lsl #6
   6ef04: 22833040     	addhs	r3, r3, #64
   6ef08: 20400301     	subhs	r0, r0, r1, lsl #6
   6ef0c: e1500281     	cmp	r0, r1, lsl #5
   6ef10: 22833020     	addhs	r3, r3, #32
   6ef14: 20400281     	subhs	r0, r0, r1, lsl #5
   6ef18: e1500201     	cmp	r0, r1, lsl #4
   6ef1c: 22833010     	addhs	r3, r3, #16
   6ef20: 20400201     	subhs	r0, r0, r1, lsl #4
   6ef24: e1500181     	cmp	r0, r1, lsl #3
   6ef28: 22833008     	addhs	r3, r3, #8
   6ef2c: 20400181     	subhs	r0, r0, r1, lsl #3
   6ef30: e1500101     	cmp	r0, r1, lsl #2
   6ef34: 22833004     	addhs	r3, r3, #4
   6ef38: 20400101     	subhs	r0, r0, r1, lsl #2
   6ef3c: e1500081     	cmp	r0, r1, lsl #1
   6ef40: 22833002     	addhs	r3, r3, #2
   6ef44: 20400081     	subhs	r0, r0, r1, lsl #1
   6ef48: e1500001     	cmp	r0, r1
   6ef4c: 22833001     	addhs	r3, r3, #1
   6ef50: 20400001     	subhs	r0, r0, r1
   6ef54: e5820000     	str	r0, [r2]
   6ef58: e1a00003     	mov	r0, r3
   6ef5c: e12fff1e     	bx	lr
   6ef60: e5820000     	str	r0, [r2]
   6ef64: e3a00000     	mov	r0, #0
   6ef68: e12fff1e     	bx	lr
   6ef6c: e3a03000     	mov	r3, #0
   6ef70: e5823000     	str	r3, [r2]
   6ef74: e12fff1e     	bx	lr
   6ef78: e3a00000     	mov	r0, #0
   6ef7c: eaffff7f     	b	0x6ed80 <__aeabi_idiv0> @ imm = #-0x204

0006ef80 <__ThumbV7PILongThunk_close>:
   6ef80: f240 0c64    	movw	r12, #0x64
   6ef84: f2c0 0c00    	movt	r12, #0x0
   6ef88: 44fc         	add	r12, pc
   6ef8a: 4760         	bx	r12

Disassembly of section .plt:

0006ef90 <.plt>:
   6ef90: e52de004     	str	lr, [sp, #-0x4]!
   6ef94: e28fe600     	add	lr, pc, #0, #12
   6ef98: e28eea04     	add	lr, lr, #4, #20
   6ef9c: e5bef26c     	ldr	pc, [lr, #0x26c]!
   6efa0: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6efa4: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6efa8: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6efac: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6efb0: e28fc600     	add	r12, pc, #0, #12
   6efb4: e28cca04     	add	r12, r12, #4, #20
   6efb8: e5bcf254     	ldr	pc, [r12, #0x254]!
   6efbc: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6efc0: e28fc600     	add	r12, pc, #0, #12
   6efc4: e28cca04     	add	r12, r12, #4, #20
   6efc8: e5bcf248     	ldr	pc, [r12, #0x248]!
   6efcc: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6efd0: e28fc600     	add	r12, pc, #0, #12
   6efd4: e28cca04     	add	r12, r12, #4, #20
   6efd8: e5bcf23c     	ldr	pc, [r12, #0x23c]!
   6efdc: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6efe0: e28fc600     	add	r12, pc, #0, #12
   6efe4: e28cca04     	add	r12, r12, #4, #20
   6efe8: e5bcf230     	ldr	pc, [r12, #0x230]!
   6efec: d4 d4 d4 d4  	.word	0xd4d4d4d4
   6eff0: e28fc600     	add	r12, pc, #0, #12
   6eff4: e28cca04     	add	r12, r12, #4, #20
   6eff8: e5bcf224     	ldr	pc, [r12, #0x224]!
   6effc: d4 d4 d4 d4  	.word	0xd4d4d4d4
