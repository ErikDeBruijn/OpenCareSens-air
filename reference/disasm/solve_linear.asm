
/tmp/caresens-air/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
