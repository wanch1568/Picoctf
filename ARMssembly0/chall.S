	.arch armv8-a
	.file	"chall.c"
	.text
	.align	2
	.global	func1
	.type	func1, %function
func1:
	#x0~x30は64ビット汎用レジスタをさす
	#w0~w30は上記64ビット汎用レジスタの下位32ビットをさす
	#スタックポインターの値を16下げてスタックフレームを16確保
	sub	sp, sp, #16
	#レジスタw0の値を現在のスタックポインターの値+12のところに配置
	str	w0, [sp, 12]
	#レジスタw1の値を現在のスタックポインターの値+8のところに配置
	str	w1, [sp, 8]
	#レジスタw1に現在のスタックポインターの値+12の値を格納
	ldr	w1, [sp, 12]
	#レジスタw0に現在のスタックポインターの値+8の値を格納
	ldr	w0, [sp, 8]
	#w1とw0の値を比較
	cmp	w1, w0
	#Banch if Lower or Same,w1の値がw0より小さいか同じ場合.L2にジャンプ
	bls	.L2
	#それ以外の場合
	ldr	w0, [sp, 12]
	b	.L3
.L2:
	#w0に現在のスタックポインターの値+8の値を格納
	ldr	w0, [sp, 8]
.L3:
	#スタックポインターの値を16あげて確保していたスタックフレームを解放
	add	sp, sp, 16
	ret
	.size	func1, .-func1
	.section	.rodata
	.align	3
.LC0:
	.string	"Result: %ld\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	#store pair,x29=フレームポインター、x30=リターンアドレス
	stp	x29, x30, [sp, -48]!
	#現在のスタックポインターの値を64ビット汎用レジスタx29に格納
	add	x29, sp, 0
	#x0-x7は最初の8つの引数を入れるのにつかわれる
	#x8は構造体などを返す時などの特定の状況でポインターとして使われる
	#x9-x15は関数内部のみで使用するデータの保存などに使われる
	#x16,x17はIPレジスタで関数呼び出しなどに使われる
	#x18はosやプラットフォームにより異なる
	#x19-x28は関数内でデータを保存し外部で使用するために使う
	#現在のspから16バイト足した位置にx19の値を格納
	str	x19, [sp, 16]
	#x29(=sp)から44バイトバイト足した位置にw0(32ビット)の値を格納
	str	w0, [x29, 44]
	#x29(=sp)から32バイトバイト足した位置にx1(64ビット)の値を格納
	str	x1, [x29, 32]
	#x0に先ほどのx1の値を保存
	ldr	x0, [x29, 32]
	#x0に8足す、結果x0=x1+8
	add	x0, x0, 8
	ldr	x0, [x0]
	#w19にw0の内容(x0の下位32ビットを保存)
	mov	w19, w0
	#再度x1の内容をx0に保存
	ldr	x0, [x29, 32]
	#今度はx0に16足す
	add	x0, x0, 16
	ldr	x0, [x0]
	#Branch to Linkは関数呼び出し,atoiは前の行で使用されたx0に保存された文字列を整数に変換する
	bl	atoi
	#w0は(x29+32バイトのところに保存されていたアドレス)+16バイトの位置(≠x29+32+16)に保存されていたデータ
	mov	w1, w0
	#w19は(x29+32バイトのところに保存されていたアドレス)+8バイトの位置に保存されていたデータ
	mov	w0, w19
	#func1はw0とw1の内容を比較
	bl	func1
	mov	w1, w0
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	mov	w0, 0
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
