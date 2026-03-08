
vendor/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
