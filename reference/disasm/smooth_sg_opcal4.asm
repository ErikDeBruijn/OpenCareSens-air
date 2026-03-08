
/tmp/caresens-air/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

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
