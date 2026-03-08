
/tmp/caresens-air/native/lib/armeabi-v7a/libCALCULATION.so:	file format elf32-littlearm

Disassembly of section .text:

0006cc68 <cal_average_without_min_max>:
   6cc68: edd0 0b00    	vldr	d16, [r0]
   6cc6c: efc0 1010    	vmov.i32	d17, #0x0
   6cc70: ef60 21b0    	vorr	d18, d16, d16
   6cc74: 460a         	mov	r2, r1
   6cc76: b1aa         	cbz	r2, 0x6cca4 <cal_average_without_min_max+0x3c> @ imm = #0x2a
   6cc78: edd0 3b00    	vldr	d19, [r0]
   6cc7c: eef4 3b60    	vcmp.f64	d19, d16
   6cc80: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cc84: dd02         	ble	0x6cc8c <cal_average_without_min_max+0x24> @ imm = #0x4
   6cc86: eef0 0b63    	vmov.f64	d16, d19
   6cc8a: e006         	b	0x6cc9a <cal_average_without_min_max+0x32> @ imm = #0xc
   6cc8c: eef4 3b62    	vcmp.f64	d19, d18
   6cc90: eef1 fa10    	vmrs	APSR_nzcv, fpscr
   6cc94: bf48         	it	mi
   6cc96: eef0 2b63    	vmovmi.f64	d18, d19
   6cc9a: ee71 1ba3    	vadd.f64	d17, d17, d19
   6cc9e: 3008         	adds	r0, #0x8
   6cca0: 3a01         	subs	r2, #0x1
   6cca2: e7e8         	b	0x6cc76 <cal_average_without_min_max+0xe> @ imm = #-0x30
   6cca4: ee71 1be2    	vsub.f64	d17, d17, d18
   6cca8: 1e88         	subs	r0, r1, #0x2
   6ccaa: ee00 0a10    	vmov	s0, r0
   6ccae: ee71 0be0    	vsub.f64	d16, d17, d16
   6ccb2: eef8 1bc0    	vcvt.f64.s32	d17, s0
   6ccb6: ee80 0ba1    	vdiv.f64	d0, d16, d17
   6ccba: 4770         	bx	lr
