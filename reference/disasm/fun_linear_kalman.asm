
vendor/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

00040528 <fun_linear_kalman>:
   40528: b5f0         	push	{r4, r5, r6, r7, lr}
   4052a: af03         	add	r7, sp, #0xc
   4052c: e92d 0f80    	push.w	{r7, r8, r9, r10, r11}
   40530: ed2d 8b10    	vpush	{d8, d9, d10, d11, d12, d13, d14, d15}
   40534: b0da         	sub	sp, #0x168
   40536: ed8d 0b06    	vstr	d0, [sp, #24]
   4053a: 4604         	mov	r4, r0
   4053c: f8df 0684    	ldr.w	r0, [pc, #0x684]        @ 0x40bc4 <fun_linear_kalman+0x69c>
   40540: 460e         	mov	r6, r1
   40542: 2148         	movs	r1, #0x48
   40544: 4615         	mov	r5, r2
   40546: 4478         	add	r0, pc
   40548: 6800         	ldr	r0, [r0]
   4054a: 6800         	ldr	r0, [r0]
   4054c: 9059         	str	r0, [sp, #0x164]
   4054e: a834         	add	r0, sp, #0xd0
   40550: f02e ed56    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2eaac
   40554: a822         	add	r0, sp, #0x88
   40556: 2148         	movs	r1, #0x48
   40558: f02e ed52    	blx	0x6f000 <sincos+0x6f000> @ imm = #0x2eaa4
   4055c: f9b6 00a5    	ldrsh.w	r0, [r6, #0xa5]
   40560: f204 2a69    	addw	r10, r4, #0x269
   40564: ed9f abac    	vldr	d10, [pc, #688]         @ 0x40818 <fun_linear_kalman+0x2f0>
   40568: 9401         	str	r4, [sp, #0x4]
   4056a: ee00 0a10    	vmov	s0, r0
   4056e: 9509         	str	r5, [sp, #0x24]
   40570: eef8 0bc0    	vcvt.f64.s32	d16, s0
   40574: b135         	cbz	r5, 0x40584 <fun_linear_kalman+0x5c> @ imm = #0xc
   40576: f10a 0560    	add.w	r5, r10, #0x60
   4057a: f10a 0458    	add.w	r4, r10, #0x58
   4057e: f10a 0950    	add.w	r9, r10, #0x50
   40582: e005         	b	0x40590 <fun_linear_kalman+0x68> @ imm = #0xa
   40584: f10a 0588    	add.w	r5, r10, #0x88
   40588: f10a 0480    	add.w	r4, r10, #0x80
   4058c: f10a 0978    	add.w	r9, r10, #0x78
   40590: eec0 0b8a    	vdiv.f64	d16, d16, d10
   40594: f50d 7b8c    	add.w	r11, sp, #0x118
   40598: f10b 0010    	add.w	r0, r11, #0x10
   4059c: 2108         	movs	r1, #0x8
   4059e: f04f 0800    	mov.w	r8, #0x0
   405a2: edcd 0b02    	vstr	d16, [sp, #8]
   405a6: efc0 0050    	vmov.i32	q8, #0x0
   405aa: f940 0ac1    	vst1.64	{d16, d17}, [r0], r1
   405ae: f8c0 8008    	str.w	r8, [r0, #0x8]
   405b2: f10b 0030    	add.w	r0, r11, #0x30
   405b6: f940 0acd    	vst1.64	{d16, d17}, [r0]!
   405ba: f8c0 8000    	str.w	r8, [r0]
   405be: 4898         	ldr	r0, [pc, #0x260]        @ 0x40820 <fun_linear_kalman+0x2f8>
   405c0: 9051         	str	r0, [sp, #0x144]
   405c2: e9cd 084f    	strd	r0, r8, [sp, #316]
   405c6: 9057         	str	r0, [sp, #0x15c]
   405c8: f896 0091    	ldrb.w	r0, [r6, #0x91]
   405cc: f896 1092    	ldrb.w	r1, [r6, #0x92]
   405d0: ee00 0a10    	vmov	s0, r0
   405d4: 4248         	rsbs	r0, r1, #0
   405d6: eef8 0b40    	vcvt.f64.u32	d16, s0
   405da: ee00 0a10    	vmov	s0, r0
   405de: eef8 1bc0    	vcvt.f64.s32	d17, s0
   405e2: eec1 0ba0    	vdiv.f64	d16, d17, d16
   405e6: ec51 0b30    	vmov	r0, r1, d16
   405ea: f02e ed52    	blx	0x6f090 <sincos+0x6f090> @ imm = #0x2eaa4
   405ee: eef7 0b00    	vmov.f64	d16, #1.000000e+00
   405f2: f106 0c93    	add.w	r12, r6, #0x93
   405f6: ec41 0b35    	vmov	d21, r0, r1
   405fa: f964 270f    	vld1.8	{d18}, [r4]
   405fe: ee70 6be5    	vsub.f64	d22, d16, d21
   40602: edcd 5b46    	vstr	d21, [sp, #280]
   40606: edcd 6b48    	vstr	d22, [sp, #288]
   4060a: f965 070f    	vld1.8	{d16}, [r5]
   4060e: f969 170f    	vld1.8	{d17}, [r9]
   40612: a934         	add	r1, sp, #0xd0
   40614: aa22         	add	r2, sp, #0x88
   40616: f1b8 0f03    	cmp.w	r8, #0x3
   4061a: d020         	beq	0x4065e <fun_linear_kalman+0x136> @ imm = #0x40
   4061c: 2300         	movs	r3, #0x0
   4061e: 4666         	mov	r6, r12
   40620: 465d         	mov	r5, r11
   40622: 2b18         	cmp	r3, #0x18
   40624: d012         	beq	0x4064c <fun_linear_kalman+0x124> @ imm = #0x24
   40626: f936 0b02    	ldrsh	r0, [r6], #2
   4062a: 18cc         	adds	r4, r1, r3
   4062c: edd5 3b00    	vldr	d19, [r5]
   40630: 3518         	adds	r5, #0x18
   40632: ee00 0a10    	vmov	s0, r0
   40636: edc4 3b00    	vstr	d19, [r4]
   4063a: 18d4         	adds	r4, r2, r3
   4063c: 3308         	adds	r3, #0x8
   4063e: eef8 3bc0    	vcvt.f64.s32	d19, s0
   40642: eec3 3b8a    	vdiv.f64	d19, d19, d10
   40646: edc4 3b00    	vstr	d19, [r4]
   4064a: e7ea         	b	0x40622 <fun_linear_kalman+0xfa> @ imm = #-0x2c
   4064c: f10c 0c06    	add.w	r12, r12, #0x6
   40650: 3218         	adds	r2, #0x18
   40652: f10b 0b08    	add.w	r11, r11, #0x8
   40656: 3118         	adds	r1, #0x18
   40658: f108 0801    	add.w	r8, r8, #0x1
   4065c: e7db         	b	0x40616 <fun_linear_kalman+0xee> @ imm = #-0x4a
   4065e: efc0 a010    	vmov.i32	d26, #0x0
   40662: 9909         	ldr	r1, [sp, #0x24]
   40664: ef62 31b2    	vorr	d19, d18, d18
   40668: edcd 2b0a    	vstr	d18, [sp, #40]
   4066c: 2900         	cmp	r1, #0x0
   4066e: edcd 1b0c    	vstr	d17, [sp, #48]
   40672: ee41 3baa    	vmla.f64	d19, d17, d26
   40676: edcd 0b0e    	vstr	d16, [sp, #56]
   4067a: ee70 3ba3    	vadd.f64	d19, d16, d19
   4067e: edcd 3b04    	vstr	d19, [sp, #16]
   40682: ee62 3ba6    	vmul.f64	d19, d18, d22
   40686: ee45 3ba1    	vmla.f64	d19, d21, d17
   4068a: ee40 3baa    	vmla.f64	d19, d16, d26
   4068e: f000 80c9    	beq.w	0x40824 <fun_linear_kalman+0x2fc> @ imm = #0x192
   40692: f10a 0018    	add.w	r0, r10, #0x18
   40696: f92a 070f    	vld1.8	{d0}, [r10]
   4069a: f920 270f    	vld1.8	{d2}, [r0]
   4069e: f10a 0030    	add.w	r0, r10, #0x30
   406a2: f920 370f    	vld1.8	{d3}, [r0]
   406a6: f10a 0008    	add.w	r0, r10, #0x8
   406aa: f920 470f    	vld1.8	{d4}, [r0]
   406ae: f10a 0020    	add.w	r0, r10, #0x20
   406b2: ee64 2b2a    	vmul.f64	d18, d4, d26
   406b6: f920 570f    	vld1.8	{d5}, [r0]
   406ba: f10a 0038    	add.w	r0, r10, #0x38
   406be: f920 670f    	vld1.8	{d6}, [r0]
   406c2: f10a 0010    	add.w	r0, r10, #0x10
   406c6: f920 b70f    	vld1.8	{d11}, [r0]
   406ca: f10a 0028    	add.w	r0, r10, #0x28
   406ce: ee6b bb2a    	vmul.f64	d27, d11, d26
   406d2: ee60 0b2a    	vmul.f64	d16, d0, d26
   406d6: eef0 4b62    	vmov.f64	d20, d18
   406da: ee45 4b2a    	vmla.f64	d20, d5, d26
   406de: eef0 7b6b    	vmov.f64	d23, d27
   406e2: eef0 1b60    	vmov.f64	d17, d16
   406e6: f920 c70f    	vld1.8	{d12}, [r0]
   406ea: f10a 0040    	add.w	r0, r10, #0x40
   406ee: ee42 1b2a    	vmla.f64	d17, d2, d26
   406f2: ee4c 7b2a    	vmla.f64	d23, d12, d26
   406f6: ee76 4b24    	vadd.f64	d20, d6, d20
   406fa: ed9d 7b3e    	vldr	d7, [sp, #248]
   406fe: f920 d70f    	vld1.8	{d13}, [r0]
   40702: eddd fb3a    	vldr	d31, [sp, #232]
   40706: ed9d fb3c    	vldr	d15, [sp, #240]
   4070a: ee7d 8b27    	vadd.f64	d24, d13, d23
   4070e: ee64 9b87    	vmul.f64	d25, d20, d7
   40712: ee64 7b8f    	vmul.f64	d23, d20, d15
   40716: ee6f 4ba4    	vmul.f64	d20, d31, d20
   4071a: ee73 1b21    	vadd.f64	d17, d3, d17
   4071e: eddd eb34    	vldr	d30, [sp, #208]
   40722: ed9d 9b40    	vldr	d9, [sp, #256]
   40726: ee41 4bae    	vmla.f64	d20, d17, d30
   4072a: ed9d 1b36    	vldr	d1, [sp, #216]
   4072e: ed9d ab38    	vldr	d10, [sp, #224]
   40732: ee48 4b89    	vmla.f64	d20, d24, d9
   40736: ee41 9b8a    	vmla.f64	d25, d17, d10
   4073a: ee41 7b81    	vmla.f64	d23, d17, d1
   4073e: ed9d eb44    	vldr	d14, [sp, #272]
   40742: ed9d 8b42    	vldr	d8, [sp, #264]
   40746: eddd 1b2e    	vldr	d17, [sp, #184]
   4074a: ee48 9b8e    	vmla.f64	d25, d24, d14
   4074e: ee48 7b88    	vmla.f64	d23, d24, d8
   40752: ee74 8ba1    	vadd.f64	d24, d20, d17
   40756: ee72 1b85    	vadd.f64	d17, d18, d5
   4075a: ee76 1b21    	vadd.f64	d17, d6, d17
   4075e: ee70 0b82    	vadd.f64	d16, d16, d2
   40762: ee61 2b87    	vmul.f64	d18, d17, d7
   40766: ee73 0b20    	vadd.f64	d16, d3, d16
   4076a: ee7b 4b8c    	vadd.f64	d20, d27, d12
   4076e: ee40 2b8a    	vmla.f64	d18, d16, d10
   40772: ee7d 4b24    	vadd.f64	d20, d13, d20
   40776: ee44 2b8e    	vmla.f64	d18, d20, d14
   4077a: eddd bb2c    	vldr	d27, [sp, #176]
   4077e: eddd db28    	vldr	d29, [sp, #160]
   40782: ee72 bbab    	vadd.f64	d27, d18, d27
   40786: ee61 2b8f    	vmul.f64	d18, d17, d15
   4078a: ee61 1baf    	vmul.f64	d17, d17, d31
   4078e: ee40 1bae    	vmla.f64	d17, d16, d30
   40792: ee40 2b81    	vmla.f64	d18, d16, d1
   40796: ee44 1b89    	vmla.f64	d17, d20, d9
   4079a: ee44 2b88    	vmla.f64	d18, d20, d8
   4079e: ee71 dbad    	vadd.f64	d29, d17, d29
   407a2: ee66 1b82    	vmul.f64	d17, d22, d2
   407a6: ee45 1b80    	vmla.f64	d17, d21, d0
   407aa: ee26 0b85    	vmul.f64	d0, d22, d5
   407ae: ee05 0b84    	vmla.f64	d0, d21, d4
   407b2: ee43 1b2a    	vmla.f64	d17, d3, d26
   407b6: ee26 3b8c    	vmul.f64	d3, d22, d12
   407ba: ee06 0b2a    	vmla.f64	d0, d6, d26
   407be: ee05 3b8b    	vmla.f64	d3, d21, d11
   407c2: ee20 2b07    	vmul.f64	d2, d0, d7
   407c6: ee0d 3b2a    	vmla.f64	d3, d13, d26
   407ca: ee01 2b8a    	vmla.f64	d2, d17, d10
   407ce: eddd 4b26    	vldr	d20, [sp, #152]
   407d2: ee03 2b0e    	vmla.f64	d2, d3, d14
   407d6: eddd cb30    	vldr	d28, [sp, #192]
   407da: ee74 6b82    	vadd.f64	d22, d20, d2
   407de: ee60 4b0f    	vmul.f64	d20, d0, d15
   407e2: ee41 4b81    	vmla.f64	d20, d17, d1
   407e6: ee43 4b08    	vmla.f64	d20, d3, d8
   407ea: ee77 7bac    	vadd.f64	d23, d23, d28
   407ee: eddd cb2a    	vldr	d28, [sp, #168]
   407f2: eddd 0b22    	vldr	d16, [sp, #136]
   407f6: ee72 cbac    	vadd.f64	d28, d18, d28
   407fa: eddd 2b24    	vldr	d18, [sp, #144]
   407fe: ee72 aba4    	vadd.f64	d26, d18, d20
   40802: ee6f 2b80    	vmul.f64	d18, d31, d0
   40806: ee41 2bae    	vmla.f64	d18, d17, d30
   4080a: ee43 2b09    	vmla.f64	d18, d3, d9
   4080e: ee70 eba2    	vadd.f64	d30, d16, d18
   40812: e0c9         	b	0x409a8 <fun_linear_kalman+0x480> @ imm = #0x192
   40814: bf00         	nop
   40816: bf00         	nop
   40818: 00 00 00 00  	.word	0x00000000
   4081c: 00 00 59 40  	.word	0x40590000
   40820: 00 00 f0 3f  	.word	0x3ff00000
   40824: f10a 0098    	add.w	r0, r10, #0x98
   40828: ed9d 8b3c    	vldr	d8, [sp, #240]
   4082c: ed9d 1b36    	vldr	d1, [sp, #216]
   40830: f920 070f    	vld1.8	{d0}, [r0]
   40834: f10a 00b0    	add.w	r0, r10, #0xb0
   40838: ee60 bb2a    	vmul.f64	d27, d0, d26
   4083c: eef0 7b6b    	vmov.f64	d23, d27
   40840: f920 270f    	vld1.8	{d2}, [r0]
   40844: f10a 00c8    	add.w	r0, r10, #0xc8
   40848: f920 370f    	vld1.8	{d3}, [r0]
   4084c: f10a 00a0    	add.w	r0, r10, #0xa0
   40850: ee42 7b2a    	vmla.f64	d23, d2, d26
   40854: f920 470f    	vld1.8	{d4}, [r0]
   40858: f10a 00b8    	add.w	r0, r10, #0xb8
   4085c: ee64 cb2a    	vmul.f64	d28, d4, d26
   40860: ee73 8b27    	vadd.f64	d24, d3, d23
   40864: eef0 7b6c    	vmov.f64	d23, d28
   40868: f920 570f    	vld1.8	{d5}, [r0]
   4086c: f10a 00d0    	add.w	r0, r10, #0xd0
   40870: f920 670f    	vld1.8	{d6}, [r0]
   40874: f10a 00a8    	add.w	r0, r10, #0xa8
   40878: ee45 7b2a    	vmla.f64	d23, d5, d26
   4087c: f920 b70f    	vld1.8	{d11}, [r0]
   40880: f10a 00c0    	add.w	r0, r10, #0xc0
   40884: ee6b 0b2a    	vmul.f64	d16, d11, d26
   40888: ee76 db27    	vadd.f64	d29, d6, d23
   4088c: eef0 7b60    	vmov.f64	d23, d16
   40890: f920 c70f    	vld1.8	{d12}, [r0]
   40894: f10a 00d8    	add.w	r0, r10, #0xd8
   40898: f920 d70f    	vld1.8	{d13}, [r0]
   4089c: ee4c 7b2a    	vmla.f64	d23, d12, d26
   408a0: ee7d 1b27    	vadd.f64	d17, d13, d23
   408a4: ee6d 7b88    	vmul.f64	d23, d29, d8
   408a8: ee48 7b81    	vmla.f64	d23, d24, d1
   408ac: ed9d 7b3e    	vldr	d7, [sp, #248]
   408b0: eddd fb3a    	vldr	d31, [sp, #232]
   408b4: ee6d 9b87    	vmul.f64	d25, d29, d7
   408b8: ee6f dbad    	vmul.f64	d29, d31, d29
   408bc: ed9d fb42    	vldr	d15, [sp, #264]
   408c0: eddd eb34    	vldr	d30, [sp, #208]
   408c4: ee41 7b8f    	vmla.f64	d23, d17, d15
   408c8: ee48 dbae    	vmla.f64	d29, d24, d30
   408cc: ed9d 9b30    	vldr	d9, [sp, #192]
   408d0: ed9d ab38    	vldr	d10, [sp, #224]
   408d4: ee77 7b89    	vadd.f64	d23, d23, d9
   408d8: ed9d 9b40    	vldr	d9, [sp, #256]
   408dc: ee48 9b8a    	vmla.f64	d25, d24, d10
   408e0: ee41 db89    	vmla.f64	d29, d17, d9
   408e4: ed9d eb44    	vldr	d14, [sp, #272]
   408e8: ee70 0b8c    	vadd.f64	d16, d16, d12
   408ec: ee41 9b8e    	vmla.f64	d25, d17, d14
   408f0: eddd 1b2e    	vldr	d17, [sp, #184]
   408f4: ee7d 0b20    	vadd.f64	d16, d13, d16
   408f8: ee7d 8ba1    	vadd.f64	d24, d29, d17
   408fc: ee7b 1b82    	vadd.f64	d17, d27, d2
   40900: ee7c bb85    	vadd.f64	d27, d28, d5
   40904: ee76 db2b    	vadd.f64	d29, d6, d27
   40908: ee6d bb87    	vmul.f64	d27, d29, d7
   4090c: ee73 1b21    	vadd.f64	d17, d3, d17
   40910: ee41 bb8a    	vmla.f64	d27, d17, d10
   40914: eddd cb2c    	vldr	d28, [sp, #176]
   40918: ee40 bb8e    	vmla.f64	d27, d16, d14
   4091c: eddd 2b2a    	vldr	d18, [sp, #168]
   40920: ee7b bbac    	vadd.f64	d27, d27, d28
   40924: ee6d cb88    	vmul.f64	d28, d29, d8
   40928: ee41 cb81    	vmla.f64	d28, d17, d1
   4092c: eddd 4b26    	vldr	d20, [sp, #152]
   40930: ee40 cb8f    	vmla.f64	d28, d16, d15
   40934: ee7c cba2    	vadd.f64	d28, d28, d18
   40938: ee6d 2baf    	vmul.f64	d18, d29, d31
   4093c: ee41 2bae    	vmla.f64	d18, d17, d30
   40940: eddd db28    	vldr	d29, [sp, #160]
   40944: ee40 2b89    	vmla.f64	d18, d16, d9
   40948: eddd 1b24    	vldr	d17, [sp, #144]
   4094c: ee72 dbad    	vadd.f64	d29, d18, d29
   40950: ee66 2b82    	vmul.f64	d18, d22, d2
   40954: ee45 2b80    	vmla.f64	d18, d21, d0
   40958: ee26 0b85    	vmul.f64	d0, d22, d5
   4095c: ee05 0b84    	vmla.f64	d0, d21, d4
   40960: ee43 2b2a    	vmla.f64	d18, d3, d26
   40964: ee26 3b8c    	vmul.f64	d3, d22, d12
   40968: ee06 0b2a    	vmla.f64	d0, d6, d26
   4096c: ee05 3b8b    	vmla.f64	d3, d21, d11
   40970: ee20 2b07    	vmul.f64	d2, d0, d7
   40974: ee0d 3b2a    	vmla.f64	d3, d13, d26
   40978: ee02 2b8a    	vmla.f64	d2, d18, d10
   4097c: eddd 0b22    	vldr	d16, [sp, #136]
   40980: ee03 2b0e    	vmla.f64	d2, d3, d14
   40984: ee74 6b82    	vadd.f64	d22, d20, d2
   40988: ee60 4b08    	vmul.f64	d20, d0, d8
   4098c: ee42 4b81    	vmla.f64	d20, d18, d1
   40990: ee43 4b0f    	vmla.f64	d20, d3, d15
   40994: ee71 aba4    	vadd.f64	d26, d17, d20
   40998: ee6f 1b80    	vmul.f64	d17, d31, d0
   4099c: ee42 1bae    	vmla.f64	d17, d18, d30
   409a0: ee43 1b09    	vmla.f64	d17, d3, d9
   409a4: ee70 eba1    	vadd.f64	d30, d16, d17
   409a8: efc0 f010    	vmov.i32	d31, #0x0
   409ac: ed9d 0b32    	vldr	d0, [sp, #200]
   409b0: eef0 0b6e    	vmov.f64	d16, d30
   409b4: ee4d 0baf    	vmla.f64	d16, d29, d31
   409b8: ee6c 2baf    	vmul.f64	d18, d28, d31
   409bc: ee67 1baf    	vmul.f64	d17, d23, d31
   409c0: ee7a 4ba2    	vadd.f64	d20, d26, d18
   409c4: ee48 0baf    	vmla.f64	d16, d24, d31
   409c8: ee71 4ba4    	vadd.f64	d20, d17, d20
   409cc: ee79 9b80    	vadd.f64	d25, d25, d0
   409d0: ee44 0baf    	vmla.f64	d16, d20, d31
   409d4: ee6b 4baf    	vmul.f64	d20, d27, d31
   409d8: ee29 0baf    	vmul.f64	d0, d25, d31
   409dc: ee76 5ba4    	vadd.f64	d21, d22, d20
   409e0: ee70 5b25    	vadd.f64	d21, d0, d21
   409e4: ee45 0baf    	vmla.f64	d16, d21, d31
   409e8: ee78 1ba1    	vadd.f64	d17, d24, d17
   409ec: eddd 5b02    	vldr	d21, [sp, #8]
   409f0: ee70 1b21    	vadd.f64	d17, d0, d17
   409f4: ee75 0ba0    	vadd.f64	d16, d21, d16
   409f8: eec1 5ba0    	vdiv.f64	d21, d17, d16
   409fc: ee65 1baf    	vmul.f64	d17, d21, d31
   40a00: ee2b 0ba1    	vmul.f64	d0, d27, d17
   40a04: ee05 0ba6    	vmla.f64	d0, d21, d22
   40a08: ee01 0ba9    	vmla.f64	d0, d17, d25
   40a0c: ee39 0bc0    	vsub.f64	d0, d25, d0
   40a10: ed8d 0b20    	vstr	d0, [sp, #128]
   40a14: ee2c 0ba1    	vmul.f64	d0, d28, d17
   40a18: ee05 0baa    	vmla.f64	d0, d21, d26
   40a1c: ee01 0ba7    	vmla.f64	d0, d17, d23
   40a20: ee37 0bc0    	vsub.f64	d0, d23, d0
   40a24: ed8d 0b1e    	vstr	d0, [sp, #120]
   40a28: ee2d 0ba1    	vmul.f64	d0, d29, d17
   40a2c: ee05 0bae    	vmla.f64	d0, d21, d30
   40a30: ee01 0ba8    	vmla.f64	d0, d17, d24
   40a34: ee78 1bc0    	vsub.f64	d17, d24, d0
   40a38: edcd 1b1c    	vstr	d17, [sp, #112]
   40a3c: ee7d 1ba2    	vadd.f64	d17, d29, d18
   40a40: ee74 1ba1    	vadd.f64	d17, d20, d17
   40a44: eec1 1ba0    	vdiv.f64	d17, d17, d16
   40a48: ee61 2baf    	vmul.f64	d18, d17, d31
   40a4c: ee6b 4ba2    	vmul.f64	d20, d27, d18
   40a50: ee41 4ba6    	vmla.f64	d20, d17, d22
   40a54: ee42 4ba9    	vmla.f64	d20, d18, d25
   40a58: ee7b 4be4    	vsub.f64	d20, d27, d20
   40a5c: edcd 4b1a    	vstr	d20, [sp, #104]
   40a60: ee6c 4ba2    	vmul.f64	d20, d28, d18
   40a64: ee41 4baa    	vmla.f64	d20, d17, d26
   40a68: ee42 4ba7    	vmla.f64	d20, d18, d23
   40a6c: ee7c 4be4    	vsub.f64	d20, d28, d20
   40a70: edcd 4b18    	vstr	d20, [sp, #96]
   40a74: ee6d 4ba2    	vmul.f64	d20, d29, d18
   40a78: ee41 4bae    	vmla.f64	d20, d17, d30
   40a7c: ee42 4ba8    	vmla.f64	d20, d18, d24
   40a80: ee7d 2be4    	vsub.f64	d18, d29, d20
   40a84: edcd 2b16    	vstr	d18, [sp, #88]
   40a88: eef0 2b6e    	vmov.f64	d18, d30
   40a8c: ee4a 2baf    	vmla.f64	d18, d26, d31
   40a90: ee46 2baf    	vmla.f64	d18, d22, d31
   40a94: eec2 0ba0    	vdiv.f64	d16, d18, d16
   40a98: ee60 2baf    	vmul.f64	d18, d16, d31
   40a9c: ee6b 4ba2    	vmul.f64	d20, d27, d18
   40aa0: ee40 4ba6    	vmla.f64	d20, d16, d22
   40aa4: ee42 4ba9    	vmla.f64	d20, d18, d25
   40aa8: ee76 4be4    	vsub.f64	d20, d22, d20
   40aac: edcd 4b14    	vstr	d20, [sp, #80]
   40ab0: ee6c 4ba2    	vmul.f64	d20, d28, d18
   40ab4: ee40 4baa    	vmla.f64	d20, d16, d26
   40ab8: ee42 4ba7    	vmla.f64	d20, d18, d23
   40abc: eddd 7b04    	vldr	d23, [sp, #16]
   40ac0: ee7a 4be4    	vsub.f64	d20, d26, d20
   40ac4: edcd 4b12    	vstr	d20, [sp, #72]
   40ac8: ee6d 4ba2    	vmul.f64	d20, d29, d18
   40acc: ee40 4bae    	vmla.f64	d20, d16, d30
   40ad0: ee42 4ba8    	vmla.f64	d20, d18, d24
   40ad4: ee7e 2be4    	vsub.f64	d18, d30, d20
   40ad8: edcd 2b10    	vstr	d18, [sp, #64]
   40adc: ee67 2baf    	vmul.f64	d18, d23, d31
   40ae0: ee72 4ba3    	vadd.f64	d20, d18, d19
   40ae4: ee72 2ba4    	vadd.f64	d18, d18, d20
   40ae8: eddd 4b06    	vldr	d20, [sp, #24]
   40aec: ee74 6be2    	vsub.f64	d22, d20, d18
   40af0: ee41 7ba6    	vmla.f64	d23, d17, d22
   40af4: ee40 3ba6    	vmla.f64	d19, d16, d22
   40af8: b301         	cbz	r1, 0x40b3c <fun_linear_kalman+0x614> @ imm = #0x40
   40afa: a910         	add	r1, sp, #0x40
   40afc: eddd 1b0a    	vldr	d17, [sp, #40]
   40b00: 2000         	movs	r0, #0x0
   40b02: 4652         	mov	r2, r10
   40b04: 2803         	cmp	r0, #0x3
   40b06: d00e         	beq	0x40b26 <fun_linear_kalman+0x5fe> @ imm = #0x1c
   40b08: 2300         	movs	r3, #0x0
   40b0a: 2b18         	cmp	r3, #0x18
   40b0c: d007         	beq	0x40b1e <fun_linear_kalman+0x5f6> @ imm = #0xe
   40b0e: 18cd         	adds	r5, r1, r3
   40b10: 18d4         	adds	r4, r2, r3
   40b12: 3308         	adds	r3, #0x8
   40b14: edd5 0b00    	vldr	d16, [r5]
   40b18: f944 070f    	vst1.8	{d16}, [r4]
   40b1c: e7f5         	b	0x40b0a <fun_linear_kalman+0x5e2> @ imm = #-0x16
   40b1e: 3118         	adds	r1, #0x18
   40b20: 3218         	adds	r2, #0x18
   40b22: 3001         	adds	r0, #0x1
   40b24: e7ee         	b	0x40b04 <fun_linear_kalman+0x5dc> @ imm = #-0x24
   40b26: f10a 0058    	add.w	r0, r10, #0x58
   40b2a: f940 770f    	vst1.8	{d23}, [r0]
   40b2e: f10a 0050    	add.w	r0, r10, #0x50
   40b32: f940 370f    	vst1.8	{d19}, [r0]
   40b36: f10a 0060    	add.w	r0, r10, #0x60
   40b3a: e021         	b	0x40b80 <fun_linear_kalman+0x658> @ imm = #0x42
   40b3c: 9801         	ldr	r0, [sp, #0x4]
   40b3e: aa10         	add	r2, sp, #0x40
   40b40: eddd 1b0a    	vldr	d17, [sp, #40]
   40b44: 2100         	movs	r1, #0x0
   40b46: f200 3001    	addw	r0, r0, #0x301
   40b4a: 2903         	cmp	r1, #0x3
   40b4c: d00e         	beq	0x40b6c <fun_linear_kalman+0x644> @ imm = #0x1c
   40b4e: 2300         	movs	r3, #0x0
   40b50: 2b18         	cmp	r3, #0x18
   40b52: d007         	beq	0x40b64 <fun_linear_kalman+0x63c> @ imm = #0xe
   40b54: 18d5         	adds	r5, r2, r3
   40b56: 18c4         	adds	r4, r0, r3
   40b58: 3308         	adds	r3, #0x8
   40b5a: edd5 0b00    	vldr	d16, [r5]
   40b5e: f944 070f    	vst1.8	{d16}, [r4]
   40b62: e7f5         	b	0x40b50 <fun_linear_kalman+0x628> @ imm = #-0x16
   40b64: 3218         	adds	r2, #0x18
   40b66: 3018         	adds	r0, #0x18
   40b68: 3101         	adds	r1, #0x1
   40b6a: e7ee         	b	0x40b4a <fun_linear_kalman+0x622> @ imm = #-0x24
   40b6c: f10a 0080    	add.w	r0, r10, #0x80
   40b70: f940 770f    	vst1.8	{d23}, [r0]
   40b74: f10a 0078    	add.w	r0, r10, #0x78
   40b78: f940 370f    	vst1.8	{d19}, [r0]
   40b7c: f10a 0088    	add.w	r0, r10, #0x88
   40b80: efc0 0010    	vmov.i32	d16, #0x0
   40b84: eddd 2b0c    	vldr	d18, [sp, #48]
   40b88: ee61 1ba0    	vmul.f64	d17, d17, d16
   40b8c: ee42 1ba0    	vmla.f64	d17, d18, d16
   40b90: eddd 0b0e    	vldr	d16, [sp, #56]
   40b94: ee70 0ba1    	vadd.f64	d16, d16, d17
   40b98: ee45 0ba6    	vmla.f64	d16, d21, d22
   40b9c: f940 070f    	vst1.8	{d16}, [r0]
   40ba0: 9859         	ldr	r0, [sp, #0x164]
   40ba2: 4909         	ldr	r1, [pc, #0x24]         @ 0x40bc8 <fun_linear_kalman+0x6a0>
   40ba4: 4479         	add	r1, pc
   40ba6: 6809         	ldr	r1, [r1]
   40ba8: 6809         	ldr	r1, [r1]
   40baa: 4281         	cmp	r1, r0
   40bac: bf01         	itttt	eq
   40bae: b05a         	addeq	sp, #0x168
   40bb0: ecbd 8b10    	vpopeq	{d8, d9, d10, d11, d12, d13, d14, d15}
   40bb4: b001         	addeq	sp, #0x4
   40bb6: e8bd 0f00    	popeq.w	{r8, r9, r10, r11}
   40bba: bf08         	it	eq
   40bbc: bdf0         	popeq	{r4, r5, r6, r7, pc}
   40bbe: f02e ea38    	blx	0x6f030 <sincos+0x6f030> @ imm = #0x2e470
   40bc2: bf00         	nop
   40bc4: 8a 2c 03 00  	.word	0x00032c8a
   40bc8: 2c 26 03 00  	.word	0x0003262c
   40bcc: d4 d4 d4 d4  	.word	0xd4d4d4d4

00040bd0 <cal_threshold>:
   40bd0: b5f0         	push	{r4, r5, r6, r7, lr}
   40bd2: af03         	add	r7, sp, #0xc
   40bd4: f84d bd04    	str	r11, [sp, #-4]!
   40bd8: eeb5 1b40    	vcmp.f64	d1, #0
   40bdc: 693e         	ldr	r6, [r7, #0x10]
   40bde: 68bd         	ldr	r5, [r7, #0x8]
   40be0: eef1 0b41    	vneg.f64	d16, d1
   40be4: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   40be8: bf48         	it	mi
   40bea: eeb0 1b60    	vmovmi.f64	d1, d16
   40bee: f8b6 410f    	ldrh.w	r4, [r6, #0x10f]
   40bf2: f893 e000    	ldrb.w	lr, [r3]
   40bf6: edd2 0b00    	vldr	d16, [r2]
   40bfa: 42ac         	cmp	r4, r5
   40bfc: d915         	bls	0x40c2a <cal_threshold+0x5a> @ imm = #0x2a
   40bfe: b325         	cbz	r5, 0x40c4a <cal_threshold+0x7a> @ imm = #0x48
   40c00: eeb4 2b42    	vcmp.f64	d2, d2
   40c04: f105 0c01    	add.w	r12, r5, #0x1
   40c08: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   40c0c: eddf 1b2c    	vldr	d17, [pc, #176]         @ 0x40cc0 <cal_threshold+0xf0>
   40c10: bf68         	it	vs
   40c12: eeb0 2b61    	vmovvs.f64	d2, d17
   40c16: ee32 0b00    	vadd.f64	d0, d2, d0
   40c1a: eeb4 3b43    	vcmp.f64	d3, d3
   40c1e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   40c22: d647         	bvs	0x40cb4 <cal_threshold+0xe4> @ imm = #0x8e
   40c24: ee71 0b03    	vadd.f64	d16, d1, d3
   40c28: e039         	b	0x40c9e <cal_threshold+0xce> @ imm = #0x72
   40c2a: f8b0 c000    	ldrh.w	r12, [r0]
   40c2e: d109         	bne	0x40c44 <cal_threshold+0x74> @ imm = #0x12
   40c30: 68fc         	ldr	r4, [r7, #0xc]
   40c32: 2c01         	cmp	r4, #0x1
   40c34: d119         	bne	0x40c6a <cal_threshold+0x9a> @ imm = #0x32
   40c36: f04f 0e01    	mov.w	lr, #0x1
   40c3a: eeb0 0b42    	vmov.f64	d0, d2
   40c3e: eef0 0b43    	vmov.f64	d16, d3
   40c42: e02c         	b	0x40c9e <cal_threshold+0xce> @ imm = #0x58
   40c44: ed91 0b00    	vldr	d0, [r1]
   40c48: e029         	b	0x40c9e <cal_threshold+0xce> @ imm = #0x52
   40c4a: f8d6 4113    	ldr.w	r4, [r6, #0x113]
   40c4e: f04f 0c01    	mov.w	r12, #0x1
   40c52: ee02 4a10    	vmov	s4, r4
   40c56: eef7 1ac2    	vcvt.f64.f32	d17, s4
   40c5a: eeb4 1b61    	vcmp.f64	d1, d17
   40c5e: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   40c62: dd1c         	ble	0x40c9e <cal_threshold+0xce> @ imm = #0x38
   40c64: eef0 0b41    	vmov.f64	d16, d1
   40c68: e019         	b	0x40c9e <cal_threshold+0xce> @ imm = #0x32
   40c6a: ee00 5a10    	vmov	s0, r5
   40c6e: f896 5112    	ldrb.w	r5, [r6, #0x112]
   40c72: f896 4111    	ldrb.w	r4, [r6, #0x111]
   40c76: f04f 0e01    	mov.w	lr, #0x1
   40c7a: eef8 1b40    	vcvt.f64.u32	d17, s0
   40c7e: eec3 0b21    	vdiv.f64	d16, d3, d17
   40c82: eec2 1b21    	vdiv.f64	d17, d2, d17
   40c86: ee00 5a10    	vmov	s0, r5
   40c8a: eef8 2b40    	vcvt.f64.u32	d18, s0
   40c8e: ee00 4a10    	vmov	s0, r4
   40c92: ee60 0ba2    	vmul.f64	d16, d16, d18
   40c96: eef8 2b40    	vcvt.f64.u32	d18, s0
   40c9a: ee21 0ba2    	vmul.f64	d0, d17, d18
   40c9e: ed81 0b00    	vstr	d0, [r1]
   40ca2: f8a0 c000    	strh.w	r12, [r0]
   40ca6: edc2 0b00    	vstr	d16, [r2]
   40caa: f883 e000    	strb.w	lr, [r3]
   40cae: f85d bb04    	ldr	r11, [sp], #4
   40cb2: bdf0         	pop	{r4, r5, r6, r7, pc}
   40cb4: f8d6 4113    	ldr.w	r4, [r6, #0x113]
   40cb8: e7cb         	b	0x40c52 <cal_threshold+0x82> @ imm = #-0x6a
   40cba: bf00         	nop
   40cbc: bf00         	nop
   40cbe: bf00         	nop
   40cc0: 00 00 00 00  	.word	0x00000000
   40cc4: 00 00 00 80  	.word	0x80000000

00040cc8 <calcPercentile>:
   40cc8: b5d0         	push	{r4, r6, r7, lr}
   40cca: af02         	add	r7, sp, #0x8
   40ccc: f240 3361    	movw	r3, #0x361
   40cd0: 460c         	mov	r4, r1
   40cd2: 1a5b         	subs	r3, r3, r1
   40cd4: eb00 00c3    	add.w	r0, r0, r3, lsl #3
   40cd8: 4b15         	ldr	r3, [pc, #0x54]         @ 0x40d30 <calcPercentile+0x68>
   40cda: f500 6047    	add.w	r0, r0, #0xc70
   40cde: 447b         	add	r3, pc
   40ce0: b134         	cbz	r4, 0x40cf0 <calcPercentile+0x28> @ imm = #0xc
   40ce2: f960 070f    	vld1.8	{d16}, [r0]
   40ce6: 3008         	adds	r0, #0x8
   40ce8: 3c01         	subs	r4, #0x1
   40cea: ece3 0b02    	vstmia	r3!, {d16}
   40cee: e7f7         	b	0x40ce0 <calcPercentile+0x18> @ imm = #-0x12
   40cf0: ee00 2a10    	vmov	s0, r2
   40cf4: eddf 1b0c    	vldr	d17, [pc, #48]          @ 0x40d28 <calcPercentile+0x60>
   40cf8: eef6 2b00    	vmov.f64	d18, #5.000000e-01
   40cfc: 480d         	ldr	r0, [pc, #0x34]         @ 0x40d34 <calcPercentile+0x6c>
   40cfe: 4478         	add	r0, pc
   40d00: eef8 0b40    	vcvt.f64.u32	d16, s0
   40d04: ee60 0ba1    	vmul.f64	d16, d16, d17
   40d08: ee00 1a10    	vmov	s0, r1
   40d0c: eef8 1b40    	vcvt.f64.u32	d17, s0
   40d10: ee40 2ba1    	vmla.f64	d18, d16, d17
   40d14: eebc 0be2    	vcvt.u32.f64	s0, d18
   40d18: ee10 2a10    	vmov	r2, s0
   40d1c: e8bd 40d0    	pop.w	{r4, r6, r7, lr}
   40d20: f7ff ba1a    	b.w	0x40158 <quick_select>  @ imm = #-0xbcc
   40d24: bf00         	nop
   40d26: bf00         	nop
   40d28: 7b 14 ae 47  	.word	0x47ae147b
   40d2c: e1 7a 84 3f  	.word	0x3f847ae1
   40d30: 06 04 04 00  	.word	0x00040406
   40d34: e6 03 04 00  	.word	0x000403e6
