
vendor/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
