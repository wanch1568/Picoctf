	.arch armv8-a
	.file	"chall_1.c"
	.text
	.align	2
	.global	func
	.type	func, %function
func:
	#spから32引いた値をspに
	sub	sp, sp, #32
	#w0の値をsp+12に
	str	w0, [sp, 12]
	#w0に83を格納
	mov	w0, 83
	#w0の値83をsp+16に格納
	str	w0, [sp, 16]
	#wzr(常にゼロを持つレジスタ)の値をsp+20に格納
	str	wzr, [sp, 20]
	#w0に3を格納
	mov	w0, 3
	#w0の値3をsp+24の位置に格納
	str	w0, [sp, 24]
	#sp+20の値wzr(ゼロ)をw0にいれる
	ldr	w0, [sp, 20]
	#w1にsp+16の値83をいれる
	ldr	w1, [sp, 16]
	#w1の値83をw0の値wzr(ゼロ)だけlsl(左論理シフト)してw0に格納
	lsl	w0, w1, w0
	#w0の値をsp+28の位置に格納
	str	w0, [sp, 28]
	#w1にsp+28(83をwzr(ゼロ)だけ左論理シフトした値)を格納
	ldr	w1, [sp, 28]
	#w0にsp+24の値3を格納
	ldr	w0, [sp, 24]
	#w1の値83をw0の値3で割った商をw0に入れる(w0=27)
	sdiv	w0, w1, w0
	#w0の値をsp+28に入れる
	str	w0, [sp, 28]
	#w1に先ほどの値27をいれる
	ldr	w1, [sp, 28]
	#w0にsp+12の値を入れる
	ldr	w0, [sp, 12]
	#w1(27)からw0を引いてw0に(この値が0ならwin、つまり0000001b(27)が正解のフラグ)
	sub	w0, w1, w0
	#w0の値をsp+28にいれる
	str	w0, [sp, 28]
	#w0に先ほどの値を入れる、この値が0ならwin
	ldr	w0, [sp, 28]
	#spを元の位置に戻す
	add	sp, sp, 32
	ret
	.size	func, .-func
	.section	.rodata
	.align	3
.LC0:
	.string	"You win!"
	.align	3
.LC1:
	.string	"You Lose :("
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -48]!
	add	x29, sp, 0
	str	w0, [x29, 28]
	str	x1, [x29, 16]
	ldr	x0, [x29, 16]
	add	x0, x0, 8
	ldr	x0, [x0]
	bl	atoi
	str	w0, [x29, 44]
	ldr	w0, [x29, 44]
	bl	func
	cmp	w0, 0
	#もしw0が0でなかった場合は.L4にとびLOSE
	bne	.L4
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts
	b	.L6
.L4:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	puts
.L6:
	nop
	ldp	x29, x30, [sp], 48
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
