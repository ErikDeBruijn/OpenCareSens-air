
vendor/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
