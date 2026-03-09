
vendor/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
