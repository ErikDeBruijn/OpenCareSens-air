
/tmp/caresens-air/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
