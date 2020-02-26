	#Authors: Andreas Kyrou(3160211)- Giorgos Polykarpou (3160213)
	#Date: 8/1/2018
	
	
	
	#kataxorites
	#$t0=i epilogi gia to menou kai stin methodo delete o akeraios pou tha diagrapsoume
	#$t1=o dixtis p epistrefi i malloc
	#$t3=o metritis gia tous komvous tis listas
	#$t4=xrisimopioite stin decreasing gia na diatrexoume tin lista kai stin methodo firstnode prosorina
	#$t5=xrisimopioite stin insert gia tin sigkrisi ton akeraion kai stin less gia na taksinomisoume sosta tin lista
	#$t6= prosorinos kataxoritis g na sigkrinoume tn akeraio p diavazoume me ton proigoumeno
	#$s2=i thesi tou protou akeraiou p meta metavalete g tin delete
	#$s3=thesi next node
	.text
	.globl main
main:
	li $t2,0	#vazoume ston kataxoriti t2 to null epidi mpori na ton xrisimopioisoume otan diagrapsoume kapio komvo
	la $a0,msg
	li $v0,4
	syscall		#tiponoume to menu
	
	li $v0,5	#diavazoume tin epilogi
	syscall
	
	move $t0,$v0
	beq	$t0,1,insert	#an o xristis dosi tin timi 1 vazoume neo komvo
	beq $t0,2,delete		#an dosi ton arithmo 2 kanoume delete ton komvo p tha mas dosi
	beq $t0,3,increasing	#an dosi ton arithmo 3 kanoume print tin lista me auksousa sira
	beq $t0,4,decreasing	#an dosi ton arithmo 4 kanoume prin tin lista me fthinousa sira
	
	j main
insert:
	jal malloc
	move $t1,$v0	#vazoume ston t1 tin thesi mnimis p desmefsame
	beqz $t3,firstNode	#an ine o protos komvos pigene sto firstNode
	la $a0,num
	li $v0,4
	syscall
	li $v0,5
	syscall		#diavazo kainourgio akeraio
	move $t6,$v0	#vazoume prosorina ton arithmo p diavasame ston t6 gia na ton sigkrinoume me ton proigoumeno
	sw $t6,($t1)	#vazoume stin mnimi p desmefsame ton akeraio
	sw $zero,4($t1)		#vazoume stin thesi tou next node to 0
	addi $t4,$t1,0		#vazoume ston kataxoriti t4  tin thesi mnimis p desmefsame g ton akeraio
	addi $t7,$t1,-8		#vazoume ston kataxoriti t7 tin thesi tou proigoumenou akeraiou
	lw $t5,($t7)		#vazoume ston kataxoriti t5 ton proigoumeno akeraio
	bgt $t6,$t5,grand	#an o akeraio p dosame ine megaliteros apo ton proigoumeno pigene stin methodo grand
	blt $t6,$t5,less	#an o akeraios p dosame ine mikroteros apo ton proigoumeno pigene stin methodo less
	j main
less:
	lw $t5,($t7)	#vazi ston kataxoriti t5 ton proigoumeno akeraio
	sw $t5,($t1)	#vale stin nea thesi mnimis ton proigoumeno akeraio
	sw $t6,($t7)	#vale stin thesi tou proigoumenou akeraiou ton neo akeraio p edose o xristis
	addi $t7,$t7,4	#prostheto ston dixti tou proigoumenou akeraiou 4 g na exo tin dieuthinsi tou next node tou proigoumenou
	sw $t1,($t7)	
	addi $t7,$t7,-12	#apothikefse ston t7 tin thesi tou proigoumenou akeraiou meta tin metatropi
	addi $t1,$t1,-8	#vazoume o t1 na dixni stin nea thesi tou neou stixiou
	lw $t5,($t7)	#vazoume ston t5 ton akeraio stin proigoumeni thesi gia na ton sigkrinoume me auton p edose o xristis
	blt $t6,$t5,less	#an o proigoumenos akeraios ine megaliteros apo ton akeraio p edose o xristis ektelese ksana ton algorithmo tis less
	addi $t3,$t3,1		#auksise ton metriti kata 1
	j main
	
	
grand:
	addi $t7,$t7,4	#auksanoume tin timi p exi o t7 kata 4 diladi vazoume ton t7 na dixni ston dixti next node tou proigoumenou akeraiou
	sw $t1,($t7)	#vazoume ton dikti next node tou proigoumenou akeraiou na dixni stin thesi mnimis tou kenourgiou
	addi $t3,$t3,1	#auksanoume ton metriti kata 1
	j main
	
firstNode:
	la $a0,num
	li $v0,4
	syscall
	li $v0,5
	syscall		#diavazoume ton akeraio apo ton xristis
	sw $v0,($t1)	#vazo stin proti thesi tis mnimis ton akeraio p edose o xristis
	move $t4,$t1	#vazo ston t4 tin thesi mnimis tou protou akeraiou
	addi $s2,$t4,0	#vazoume ston kataxoriti s2 tin thesi mnimis tou protou akeraiou tis listas
	sw $zero,4($t1)	#vazo stin deuteri thesi to 0 os null pointer
	addi $s0,$t4,4	#vazo ston s0 ton dixti p dixni ston next node tou protou komvou
	addi $t3,$t3,1	#auksano ton metriti kata ena
	j main
	
	
malloc:
	li $a0,8
	li $v0,9
	syscall
	jr $ra	#desmevoume mnimi gia dio akeraious stin proti thesi tha ine o arithmos kai stin deuteri o diktis g ton epomeno
decreasing:
	lw $s6,($t4)	#vazoume ston kataxoriti s6 ton akeraio prin apo auton p tiposame
	beq $s6,$t2,lastNode_del	#an o akeraios exi tin timi 0 pragma p smn i oti diagrafike i oti den iparxi allos akeraios
decreasing_print:
	beqz $t3,exit #mexri o metritis na gini 0
	la $a0,msg2
	li $v0,4
	syscall
	lw $a0,($t4) #tiponi to teleuteo stixeio tis listas
	li $v0,1
	syscall
	sub $t4,$t4,8	#aferoume 4 apo ton kataxoriti t4 pou ousiastika periexi tin thesi mnimis tou teleutaiou akeraiou
	lw $s6,($t4)	#vazoume ston kataxoriti s6 ton akeraio prin apo auton p tiposame
	beq $s6,$t2,sub_8	#an o akeraios exi tin timi 0 pragma p smn i oti diagrafike i oti den iparxi allos akeraios
	sub $t3,$t3,1	#aferese ena apo ton metriti
	j decreasing
sub_8:
	sub $t4,$t4,8	#aferese 8 apo ton t4 etsi oste o t4 na periexi tin thesi mnimis tou epomenou stixeiou p theloume na emfanisoume
	sub $t3,$t3,1	#aferese ena apo tn metriti
	beqz $t3,exit 	#an o t3 exi tin timi 0 klini to programa
	j decreasing
lastNode_del:
	sub $t4,$t4,8	#aferese 8 apo ton t4 etsi oste o t4 na periexi tin thesi mnimis tou epomenou stixeiou p theloume na emfanisoume
	j decreasing
increasing:
	la $a0,msg2
	li $v0,4
	syscall
	lw $a0,($s2)	#tiponoume ton akeraio ston opio dixni o s2
	li $v0,1
	syscall
	addi $s2,$s2,4	#auksanoume ton s2 pou stin arxi edixne ston proto akeraio tis listas outos oste na dixni ston dixti next node kathe fora
	lw $s2,($s2)	#vazoume ston s2 tin thesi mnimis tou epomenou akeraiou kai otan ksana kalesti i lw $a0,($s2) na tipothi o akeraios stin thesi pou dixni o s2
	beq $s2,$t2,exit 	#otan o dixtis nextNode ine 0 diladi otan ftasoume sto telos tis listas klini to programma
	
	j increasing
delete:
	la $a0,delete_num	#print to minima gia na dosi ton arithmo pou theli na diagrapsoume
	li $v0,4
	syscall
	li $v0,5		#diavazoume ton arithmo
	syscall
	move $t0,$v0	#vazoume ton arithmo p edose o xristis ston kataxoriti t0
	lw $s4,($s2)	#vazoume ston s4 ton proto akeraio tis listas
	move $s3,$s2	#vazoume ston s3 tin thesi mnimis tou protou akeraiou
	beq $s4,$t0,delete_1 #an o arithmos p edose o xristis ine o protos pigene stin methodo delete_1
	
delete_first_step:
	addi $s3,$s3,4	#vazoume ton s3 na dixni sto nextNode
	lw $s3,($s3)	#vazoume ston s3 to periexomeno tou diladi tin thesi mnimis tou epomenou akeraiou
	lw $s4,($s3)	#vazoume ston s4 ton epomeno akeraio
	beq $t0,$s4,delete_last_step	#ekteli ton algorithmo mexri na isounte i dio akeraioi kai otan ginoun isi na pai stin methodo delete_last_step
	j delete_first_step
delete_last_step:		
	lw $s5,4($s3)
	beqz $s5,delete_last
	sw $t2,($s3)	#vazoume stin thesi tou akeraiou ton arithmo 0 oste otan pame na tiposoume tin lista me fthinousa sira na ton prosperasi
	sw $zero,4($s3)	#vazoume stin thesi nextNode tou akeraiou pou tha diagrapsoume to 0 oste na min sindeete me ton epomeno akeraio
	addi $s4,$s3,8	#vazoume ston kataxoriti s4 ton s3+8 diladi tin thesi mnimis tou akeraiou meta apo auton p tha diagrapsoume 
	sub $s3,$s3,4	#vazoume ston kataxoriti s3 to periexomeno tou s3-4 diladi tin thesi mnimis tou nextNode tou akeraiou prin apo auton p diagrapsame
	sw $s4,($s3)	#vazoume ton nextNode tou akeraiou prin apo auton p diagrapsame na dixni ston epomeno akeraio 
	sub $t3,$t3,1	#aferoume ena apo ton metriti
	j main
delete_1:
	sw $t2,($s3)	#vazoume stin thesi tou akeraiou ton t2 diladi null oste otan pame na tiposoume tin lista me fthinousa sira na ton prosperasi
	sw $zero,4($s3)	#vazoume stin thesi nextNode tou akeraiou pou tha diagrapsoume to 0 oste na min tsindeete me ton epomeno akeraio
	addi $s2,$s2,8	#vazoume ton kataxoriti s2 na dixni ston deutero komvo opote aftomata o deuteros komvos ginete protos
	sub $t3,$t3,1	#aferoume ena apo ton metriti
	j main
delete_last:
	sub $s3,$s3,4	#vazoume ston kataxoriti s3 to periexomeno tou s3-4 diladi tin thesi mnimis tou nextNode tou akeraiou prin apo auton p diagrapsame
	sw $t2,($s3)	#vazoume stin thesi nextNode tou akeraiou pou tha diagrapsoume to 0 oste na min sindeete me ton epomeno akeraio
	sub $t3,$t3,1	#aferoume ena apo ton metriti
	j main
exit:
	li $v0,10	#klini to programma 
	syscall
	
	
	
	
	
	
	
	.data
msg: .asciiz" Give 1 to insert a new Node,\n Give 2 to delete a Node,\n Give 3 to print increasing the list, \n Give 4 to print decreasing the list: \n"
num: .asciiz "Give num: "
crlf: .asciiz "\n"
msg2: .asciiz "\nThe integer in current node is: "
delete_num:.asciiz "\n Give the integer you want to delete:"