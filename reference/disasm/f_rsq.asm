
/tmp/caresens-air/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
