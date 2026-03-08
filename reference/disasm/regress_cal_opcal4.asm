
/tmp/caresens-air/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
