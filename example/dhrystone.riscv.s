
dhrystone.riscv:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000080000000 <_start>:
    80000000:	4081                	li	ra,0
    80000002:	4101                	li	sp,0
    80000004:	4181                	li	gp,0
    80000006:	4201                	li	tp,0
    80000008:	4281                	li	t0,0
    8000000a:	4301                	li	t1,0
    8000000c:	4381                	li	t2,0
    8000000e:	4401                	li	s0,0
    80000010:	4481                	li	s1,0
    80000012:	4501                	li	a0,0
    80000014:	4581                	li	a1,0
    80000016:	4601                	li	a2,0
    80000018:	4681                	li	a3,0
    8000001a:	4701                	li	a4,0
    8000001c:	4781                	li	a5,0
    8000001e:	4801                	li	a6,0
    80000020:	4881                	li	a7,0
    80000022:	4901                	li	s2,0
    80000024:	4981                	li	s3,0
    80000026:	4a01                	li	s4,0
    80000028:	4a81                	li	s5,0
    8000002a:	4b01                	li	s6,0
    8000002c:	4b81                	li	s7,0
    8000002e:	4c01                	li	s8,0
    80000030:	4c81                	li	s9,0
    80000032:	4d01                	li	s10,0
    80000034:	4d81                	li	s11,0
    80000036:	4e01                	li	t3,0
    80000038:	4e81                	li	t4,0
    8000003a:	4f01                	li	t5,0
    8000003c:	4f81                	li	t6,0
    8000003e:	62f9                	lui	t0,0x1e
    80000040:	3002a073          	csrs	mstatus,t0
    80000044:	4285                	li	t0,1
    80000046:	02fe                	slli	t0,t0,0x1f
    80000048:	0002d863          	bgez	t0,80000058 <_start+0x58>
    8000004c:	4505                	li	a0,1
    8000004e:	00001297          	auipc	t0,0x1
    80000052:	faa2a923          	sw	a0,-78(t0) # 80001000 <tohost>
    80000056:	bfdd                	j	8000004c <_start+0x4c>
    80000058:	00000297          	auipc	t0,0x0
    8000005c:	09028293          	addi	t0,t0,144 # 800000e8 <_start+0xe8>
    80000060:	30529073          	csrw	mtvec,t0
    80000064:	00301073          	fssr	zero
    80000068:	f0000053          	fmv.w.x	ft0,zero
    8000006c:	f00000d3          	fmv.w.x	ft1,zero
    80000070:	f0000153          	fmv.w.x	ft2,zero
    80000074:	f00001d3          	fmv.w.x	ft3,zero
    80000078:	f0000253          	fmv.w.x	ft4,zero
    8000007c:	f00002d3          	fmv.w.x	ft5,zero
    80000080:	f0000353          	fmv.w.x	ft6,zero
    80000084:	f00003d3          	fmv.w.x	ft7,zero
    80000088:	f0000453          	fmv.w.x	fs0,zero
    8000008c:	f00004d3          	fmv.w.x	fs1,zero
    80000090:	f0000553          	fmv.w.x	fa0,zero
    80000094:	f00005d3          	fmv.w.x	fa1,zero
    80000098:	f0000653          	fmv.w.x	fa2,zero
    8000009c:	f00006d3          	fmv.w.x	fa3,zero
    800000a0:	f0000753          	fmv.w.x	fa4,zero
    800000a4:	f00007d3          	fmv.w.x	fa5,zero
    800000a8:	f0000853          	fmv.w.x	fa6,zero
    800000ac:	f00008d3          	fmv.w.x	fa7,zero
    800000b0:	f0000953          	fmv.w.x	fs2,zero
    800000b4:	f00009d3          	fmv.w.x	fs3,zero
    800000b8:	f0000a53          	fmv.w.x	fs4,zero
    800000bc:	f0000ad3          	fmv.w.x	fs5,zero
    800000c0:	f0000b53          	fmv.w.x	fs6,zero
    800000c4:	f0000bd3          	fmv.w.x	fs7,zero
    800000c8:	f0000c53          	fmv.w.x	fs8,zero
    800000cc:	f0000cd3          	fmv.w.x	fs9,zero
    800000d0:	f0000d53          	fmv.w.x	fs10,zero
    800000d4:	f0000dd3          	fmv.w.x	fs11,zero
    800000d8:	f0000e53          	fmv.w.x	ft8,zero
    800000dc:	f0000ed3          	fmv.w.x	ft9,zero
    800000e0:	f0000f53          	fmv.w.x	ft10,zero
    800000e4:	f0000fd3          	fmv.w.x	ft11,zero
    800000e8:	00000297          	auipc	t0,0x0
    800000ec:	03c28293          	addi	t0,t0,60 # 80000124 <trap_entry>
    800000f0:	30529073          	csrw	mtvec,t0
    800000f4:	00003197          	auipc	gp,0x3
    800000f8:	f8c18193          	addi	gp,gp,-116 # 80003080 <__global_pointer$>
    800000fc:	00005217          	auipc	tp,0x5
    80000100:	04320213          	addi	tp,tp,67 # 8000513f <_end+0x3f>
    80000104:	fc027213          	andi	tp,tp,-64
    80000108:	f1402573          	csrr	a0,mhartid
    8000010c:	4585                	li	a1,1
    8000010e:	00b57063          	bleu	a1,a0,8000010e <_start+0x10e>
    80000112:	01151613          	slli	a2,a0,0x11
    80000116:	9232                	add	tp,tp,a2
    80000118:	00150113          	addi	sp,a0,1
    8000011c:	0146                	slli	sp,sp,0x11
    8000011e:	9112                	add	sp,sp,tp
    80000120:	7240106f          	j	80001844 <_init>

0000000080000124 <trap_entry>:
    80000124:	716d                	addi	sp,sp,-272
    80000126:	e406                	sd	ra,8(sp)
    80000128:	e80a                	sd	sp,16(sp)
    8000012a:	ec0e                	sd	gp,24(sp)
    8000012c:	f012                	sd	tp,32(sp)
    8000012e:	f416                	sd	t0,40(sp)
    80000130:	f81a                	sd	t1,48(sp)
    80000132:	fc1e                	sd	t2,56(sp)
    80000134:	e0a2                	sd	s0,64(sp)
    80000136:	e4a6                	sd	s1,72(sp)
    80000138:	e8aa                	sd	a0,80(sp)
    8000013a:	ecae                	sd	a1,88(sp)
    8000013c:	f0b2                	sd	a2,96(sp)
    8000013e:	f4b6                	sd	a3,104(sp)
    80000140:	f8ba                	sd	a4,112(sp)
    80000142:	fcbe                	sd	a5,120(sp)
    80000144:	e142                	sd	a6,128(sp)
    80000146:	e546                	sd	a7,136(sp)
    80000148:	e94a                	sd	s2,144(sp)
    8000014a:	ed4e                	sd	s3,152(sp)
    8000014c:	f152                	sd	s4,160(sp)
    8000014e:	f556                	sd	s5,168(sp)
    80000150:	f95a                	sd	s6,176(sp)
    80000152:	fd5e                	sd	s7,184(sp)
    80000154:	e1e2                	sd	s8,192(sp)
    80000156:	e5e6                	sd	s9,200(sp)
    80000158:	e9ea                	sd	s10,208(sp)
    8000015a:	edee                	sd	s11,216(sp)
    8000015c:	f1f2                	sd	t3,224(sp)
    8000015e:	f5f6                	sd	t4,232(sp)
    80000160:	f9fa                	sd	t5,240(sp)
    80000162:	fdfe                	sd	t6,248(sp)
    80000164:	34202573          	csrr	a0,mcause
    80000168:	341025f3          	csrr	a1,mepc
    8000016c:	860a                	mv	a2,sp
    8000016e:	512010ef          	jal	ra,80001680 <handle_trap>
    80000172:	34151073          	csrw	mepc,a0
    80000176:	000022b7          	lui	t0,0x2
    8000017a:	8002829b          	addiw	t0,t0,-2048
    8000017e:	3002a073          	csrs	mstatus,t0
    80000182:	60a2                	ld	ra,8(sp)
    80000184:	6142                	ld	sp,16(sp)
    80000186:	61e2                	ld	gp,24(sp)
    80000188:	7202                	ld	tp,32(sp)
    8000018a:	72a2                	ld	t0,40(sp)
    8000018c:	7342                	ld	t1,48(sp)
    8000018e:	73e2                	ld	t2,56(sp)
    80000190:	6406                	ld	s0,64(sp)
    80000192:	64a6                	ld	s1,72(sp)
    80000194:	6546                	ld	a0,80(sp)
    80000196:	65e6                	ld	a1,88(sp)
    80000198:	7606                	ld	a2,96(sp)
    8000019a:	76a6                	ld	a3,104(sp)
    8000019c:	7746                	ld	a4,112(sp)
    8000019e:	77e6                	ld	a5,120(sp)
    800001a0:	680a                	ld	a6,128(sp)
    800001a2:	68aa                	ld	a7,136(sp)
    800001a4:	694a                	ld	s2,144(sp)
    800001a6:	69ea                	ld	s3,152(sp)
    800001a8:	7a0a                	ld	s4,160(sp)
    800001aa:	7aaa                	ld	s5,168(sp)
    800001ac:	7b4a                	ld	s6,176(sp)
    800001ae:	7bea                	ld	s7,184(sp)
    800001b0:	6c0e                	ld	s8,192(sp)
    800001b2:	6cae                	ld	s9,200(sp)
    800001b4:	6d4e                	ld	s10,208(sp)
    800001b6:	6dee                	ld	s11,216(sp)
    800001b8:	7e0e                	ld	t3,224(sp)
    800001ba:	7eae                	ld	t4,232(sp)
    800001bc:	7f4e                	ld	t5,240(sp)
    800001be:	7fee                	ld	t6,248(sp)
    800001c0:	6151                	addi	sp,sp,272
    800001c2:	30200073          	mret

Disassembly of section .text:

0000000080001048 <Proc_2>:
    80001048:	00002717          	auipc	a4,0x2
    8000104c:	86974703          	lbu	a4,-1943(a4) # 800028b1 <Ch_1_Glob>
    80001050:	04100793          	li	a5,65
    80001054:	00f70363          	beq	a4,a5,8000105a <Proc_2+0x12>
    80001058:	8082                	ret
    8000105a:	411c                	lw	a5,0(a0)
    8000105c:	00002717          	auipc	a4,0x2
    80001060:	85c70713          	addi	a4,a4,-1956 # 800028b8 <Int_Glob>
    80001064:	4318                	lw	a4,0(a4)
    80001066:	27a5                	addiw	a5,a5,9
    80001068:	9f99                	subw	a5,a5,a4
    8000106a:	c11c                	sw	a5,0(a0)
    8000106c:	8082                	ret

000000008000106e <Proc_3>:
    8000106e:	84818793          	addi	a5,gp,-1976 # 800028c8 <Ptr_Glob>
    80001072:	6390                	ld	a2,0(a5)
    80001074:	c601                	beqz	a2,8000107c <Proc_3+0xe>
    80001076:	6218                	ld	a4,0(a2)
    80001078:	e118                	sd	a4,0(a0)
    8000107a:	6390                	ld	a2,0(a5)
    8000107c:	00002797          	auipc	a5,0x2
    80001080:	83c78793          	addi	a5,a5,-1988 # 800028b8 <Int_Glob>
    80001084:	438c                	lw	a1,0(a5)
    80001086:	0641                	addi	a2,a2,16
    80001088:	4529                	li	a0,10
    8000108a:	0ee0006f          	j	80001178 <Proc_7>

000000008000108e <Proc_1>:
    8000108e:	1101                	addi	sp,sp,-32
    80001090:	e04a                	sd	s2,0(sp)
    80001092:	84818913          	addi	s2,gp,-1976 # 800028c8 <Ptr_Glob>
    80001096:	00093783          	ld	a5,0(s2)
    8000109a:	e822                	sd	s0,16(sp)
    8000109c:	6100                	ld	s0,0(a0)
    8000109e:	6398                	ld	a4,0(a5)
    800010a0:	e426                	sd	s1,8(sp)
    800010a2:	0107b803          	ld	a6,16(a5)
    800010a6:	6f8c                	ld	a1,24(a5)
    800010a8:	7390                	ld	a2,32(a5)
    800010aa:	7794                	ld	a3,40(a5)
    800010ac:	ec06                	sd	ra,24(sp)
    800010ae:	84aa                	mv	s1,a0
    800010b0:	6788                	ld	a0,8(a5)
    800010b2:	7b9c                	ld	a5,48(a5)
    800010b4:	e018                	sd	a4,0(s0)
    800010b6:	6098                	ld	a4,0(s1)
    800010b8:	01043823          	sd	a6,16(s0)
    800010bc:	e408                	sd	a0,8(s0)
    800010be:	f81c                	sd	a5,48(s0)
    800010c0:	ec0c                	sd	a1,24(s0)
    800010c2:	4795                	li	a5,5
    800010c4:	f010                	sd	a2,32(s0)
    800010c6:	f414                	sd	a3,40(s0)
    800010c8:	c89c                	sw	a5,16(s1)
    800010ca:	c81c                	sw	a5,16(s0)
    800010cc:	e018                	sd	a4,0(s0)
    800010ce:	8522                	mv	a0,s0
    800010d0:	f9fff0ef          	jal	ra,8000106e <Proc_3>
    800010d4:	441c                	lw	a5,8(s0)
    800010d6:	cb95                	beqz	a5,8000110a <Proc_1+0x7c>
    800010d8:	609c                	ld	a5,0(s1)
    800010da:	60e2                	ld	ra,24(sp)
    800010dc:	6442                	ld	s0,16(sp)
    800010de:	0007b883          	ld	a7,0(a5)
    800010e2:	0087b803          	ld	a6,8(a5)
    800010e6:	6b8c                	ld	a1,16(a5)
    800010e8:	6f90                	ld	a2,24(a5)
    800010ea:	7394                	ld	a3,32(a5)
    800010ec:	7798                	ld	a4,40(a5)
    800010ee:	7b9c                	ld	a5,48(a5)
    800010f0:	0114b023          	sd	a7,0(s1)
    800010f4:	0104b423          	sd	a6,8(s1)
    800010f8:	e88c                	sd	a1,16(s1)
    800010fa:	ec90                	sd	a2,24(s1)
    800010fc:	f094                	sd	a3,32(s1)
    800010fe:	f498                	sd	a4,40(s1)
    80001100:	f89c                	sd	a5,48(s1)
    80001102:	6902                	ld	s2,0(sp)
    80001104:	64a2                	ld	s1,8(sp)
    80001106:	6105                	addi	sp,sp,32
    80001108:	8082                	ret
    8000110a:	44c8                	lw	a0,12(s1)
    8000110c:	4799                	li	a5,6
    8000110e:	00c40593          	addi	a1,s0,12
    80001112:	c81c                	sw	a5,16(s0)
    80001114:	11c000ef          	jal	ra,80001230 <Proc_6>
    80001118:	00093783          	ld	a5,0(s2)
    8000111c:	4808                	lw	a0,16(s0)
    8000111e:	01040613          	addi	a2,s0,16
    80001122:	639c                	ld	a5,0(a5)
    80001124:	60e2                	ld	ra,24(sp)
    80001126:	64a2                	ld	s1,8(sp)
    80001128:	e01c                	sd	a5,0(s0)
    8000112a:	6442                	ld	s0,16(sp)
    8000112c:	6902                	ld	s2,0(sp)
    8000112e:	45a9                	li	a1,10
    80001130:	6105                	addi	sp,sp,32
    80001132:	0460006f          	j	80001178 <Proc_7>

0000000080001136 <Proc_4>:
    80001136:	00001717          	auipc	a4,0x1
    8000113a:	77e70713          	addi	a4,a4,1918 # 800028b4 <Bool_Glob>
    8000113e:	4314                	lw	a3,0(a4)
    80001140:	00001797          	auipc	a5,0x1
    80001144:	7717c783          	lbu	a5,1905(a5) # 800028b1 <Ch_1_Glob>
    80001148:	fbf78793          	addi	a5,a5,-65
    8000114c:	0017b793          	seqz	a5,a5
    80001150:	8fd5                	or	a5,a5,a3
    80001152:	c31c                	sw	a5,0(a4)
    80001154:	04200793          	li	a5,66
    80001158:	00001717          	auipc	a4,0x1
    8000115c:	74f70c23          	sb	a5,1880(a4) # 800028b0 <Ch_2_Glob>
    80001160:	8082                	ret

0000000080001162 <Proc_5>:
    80001162:	04100793          	li	a5,65
    80001166:	00001717          	auipc	a4,0x1
    8000116a:	74f705a3          	sb	a5,1867(a4) # 800028b1 <Ch_1_Glob>
    8000116e:	00001797          	auipc	a5,0x1
    80001172:	7407a323          	sw	zero,1862(a5) # 800028b4 <Bool_Glob>
    80001176:	8082                	ret

0000000080001178 <Proc_7>:
    80001178:	2509                	addiw	a0,a0,2
    8000117a:	9da9                	addw	a1,a1,a0
    8000117c:	c20c                	sw	a1,0(a2)
    8000117e:	8082                	ret

0000000080001180 <Proc_8>:
    80001180:	0056079b          	addiw	a5,a2,5
    80001184:	0c800713          	li	a4,200
    80001188:	02e78733          	mul	a4,a5,a4
    8000118c:	883e                	mv	a6,a5
    8000118e:	060a                	slli	a2,a2,0x2
    80001190:	078a                	slli	a5,a5,0x2
    80001192:	953e                	add	a0,a0,a5
    80001194:	c114                	sw	a3,0(a0)
    80001196:	c154                	sw	a3,4(a0)
    80001198:	07052c23          	sw	a6,120(a0)
    8000119c:	00c707b3          	add	a5,a4,a2
    800011a0:	97ae                	add	a5,a5,a1
    800011a2:	4b94                	lw	a3,16(a5)
    800011a4:	0107aa23          	sw	a6,20(a5)
    800011a8:	0107ac23          	sw	a6,24(a5)
    800011ac:	2685                	addiw	a3,a3,1
    800011ae:	cb94                	sw	a3,16(a5)
    800011b0:	411c                	lw	a5,0(a0)
    800011b2:	95ba                	add	a1,a1,a4
    800011b4:	95b2                	add	a1,a1,a2
    800011b6:	6605                	lui	a2,0x1
    800011b8:	95b2                	add	a1,a1,a2
    800011ba:	faf5aa23          	sw	a5,-76(a1)
    800011be:	4795                	li	a5,5
    800011c0:	00001717          	auipc	a4,0x1
    800011c4:	6ef72c23          	sw	a5,1784(a4) # 800028b8 <Int_Glob>
    800011c8:	8082                	ret

00000000800011ca <Func_1>:
    800011ca:	0ff57513          	andi	a0,a0,255
    800011ce:	0ff5f593          	andi	a1,a1,255
    800011d2:	00b50463          	beq	a0,a1,800011da <Func_1+0x10>
    800011d6:	4501                	li	a0,0
    800011d8:	8082                	ret
    800011da:	00001797          	auipc	a5,0x1
    800011de:	6ca78ba3          	sb	a0,1751(a5) # 800028b1 <Ch_1_Glob>
    800011e2:	4505                	li	a0,1
    800011e4:	8082                	ret

00000000800011e6 <Func_2>:
    800011e6:	1101                	addi	sp,sp,-32
    800011e8:	e822                	sd	s0,16(sp)
    800011ea:	e426                	sd	s1,8(sp)
    800011ec:	ec06                	sd	ra,24(sp)
    800011ee:	842a                	mv	s0,a0
    800011f0:	84ae                	mv	s1,a1
    800011f2:	0034c583          	lbu	a1,3(s1)
    800011f6:	00244503          	lbu	a0,2(s0)
    800011fa:	fd1ff0ef          	jal	ra,800011ca <Func_1>
    800011fe:	2501                	sext.w	a0,a0
    80001200:	f96d                	bnez	a0,800011f2 <Func_2+0xc>
    80001202:	85a6                	mv	a1,s1
    80001204:	8522                	mv	a0,s0
    80001206:	730000ef          	jal	ra,80001936 <strcmp>
    8000120a:	4781                	li	a5,0
    8000120c:	00a05863          	blez	a0,8000121c <Func_2+0x36>
    80001210:	47a9                	li	a5,10
    80001212:	00001717          	auipc	a4,0x1
    80001216:	6af72323          	sw	a5,1702(a4) # 800028b8 <Int_Glob>
    8000121a:	4785                	li	a5,1
    8000121c:	60e2                	ld	ra,24(sp)
    8000121e:	6442                	ld	s0,16(sp)
    80001220:	64a2                	ld	s1,8(sp)
    80001222:	853e                	mv	a0,a5
    80001224:	6105                	addi	sp,sp,32
    80001226:	8082                	ret

0000000080001228 <Func_3>:
    80001228:	1579                	addi	a0,a0,-2
    8000122a:	00153513          	seqz	a0,a0
    8000122e:	8082                	ret

0000000080001230 <Proc_6>:
    80001230:	1101                	addi	sp,sp,-32
    80001232:	e822                	sd	s0,16(sp)
    80001234:	e426                	sd	s1,8(sp)
    80001236:	ec06                	sd	ra,24(sp)
    80001238:	842a                	mv	s0,a0
    8000123a:	84ae                	mv	s1,a1
    8000123c:	fedff0ef          	jal	ra,80001228 <Func_3>
    80001240:	c115                	beqz	a0,80001264 <Proc_6+0x34>
    80001242:	c080                	sw	s0,0(s1)
    80001244:	4705                	li	a4,1
    80001246:	02e40463          	beq	s0,a4,8000126e <Proc_6+0x3e>
    8000124a:	c81d                	beqz	s0,80001280 <Proc_6+0x50>
    8000124c:	4789                	li	a5,2
    8000124e:	04f40063          	beq	s0,a5,8000128e <Proc_6+0x5e>
    80001252:	4711                	li	a4,4
    80001254:	00e41363          	bne	s0,a4,8000125a <Proc_6+0x2a>
    80001258:	c09c                	sw	a5,0(s1)
    8000125a:	60e2                	ld	ra,24(sp)
    8000125c:	6442                	ld	s0,16(sp)
    8000125e:	64a2                	ld	s1,8(sp)
    80001260:	6105                	addi	sp,sp,32
    80001262:	8082                	ret
    80001264:	478d                	li	a5,3
    80001266:	c09c                	sw	a5,0(s1)
    80001268:	4705                	li	a4,1
    8000126a:	fee410e3          	bne	s0,a4,8000124a <Proc_6+0x1a>
    8000126e:	00001797          	auipc	a5,0x1
    80001272:	64a78793          	addi	a5,a5,1610 # 800028b8 <Int_Glob>
    80001276:	4398                	lw	a4,0(a5)
    80001278:	06400793          	li	a5,100
    8000127c:	00e7df63          	ble	a4,a5,8000129a <Proc_6+0x6a>
    80001280:	60e2                	ld	ra,24(sp)
    80001282:	6442                	ld	s0,16(sp)
    80001284:	0004a023          	sw	zero,0(s1)
    80001288:	64a2                	ld	s1,8(sp)
    8000128a:	6105                	addi	sp,sp,32
    8000128c:	8082                	ret
    8000128e:	60e2                	ld	ra,24(sp)
    80001290:	6442                	ld	s0,16(sp)
    80001292:	c098                	sw	a4,0(s1)
    80001294:	64a2                	ld	s1,8(sp)
    80001296:	6105                	addi	sp,sp,32
    80001298:	8082                	ret
    8000129a:	478d                	li	a5,3
    8000129c:	c09c                	sw	a5,0(s1)
    8000129e:	bf75                	j	8000125a <Proc_6+0x2a>

00000000800012a0 <debug_printf>:
    800012a0:	7139                	addi	sp,sp,-64
    800012a2:	e42e                	sd	a1,8(sp)
    800012a4:	e832                	sd	a2,16(sp)
    800012a6:	ec36                	sd	a3,24(sp)
    800012a8:	f03a                	sd	a4,32(sp)
    800012aa:	f43e                	sd	a5,40(sp)
    800012ac:	f842                	sd	a6,48(sp)
    800012ae:	fc46                	sd	a7,56(sp)
    800012b0:	6121                	addi	sp,sp,64
    800012b2:	8082                	ret

00000000800012b4 <vprintfmt>:
    800012b4:	710d                	addi	sp,sp,-352
    800012b6:	eaa2                	sd	s0,336(sp)
    800012b8:	e6a6                	sd	s1,328(sp)
    800012ba:	e2ca                	sd	s2,320(sp)
    800012bc:	fa52                	sd	s4,304(sp)
    800012be:	f25a                	sd	s6,288(sp)
    800012c0:	ee5e                	sd	s7,280(sp)
    800012c2:	ee86                	sd	ra,344(sp)
    800012c4:	fe4e                	sd	s3,312(sp)
    800012c6:	f656                	sd	s5,296(sp)
    800012c8:	ea62                	sd	s8,272(sp)
    800012ca:	e666                	sd	s9,264(sp)
    800012cc:	e26a                	sd	s10,256(sp)
    800012ce:	892a                	mv	s2,a0
    800012d0:	84ae                	mv	s1,a1
    800012d2:	8432                	mv	s0,a2
    800012d4:	8bb6                	mv	s7,a3
    800012d6:	02500a13          	li	s4,37
    800012da:	00001b17          	auipc	s6,0x1
    800012de:	44eb0b13          	addi	s6,s6,1102 # 80002728 <main+0xd5e>
    800012e2:	a029                	j	800012ec <vprintfmt+0x38>
    800012e4:	c131                	beqz	a0,80001328 <vprintfmt+0x74>
    800012e6:	85a6                	mv	a1,s1
    800012e8:	0405                	addi	s0,s0,1
    800012ea:	9902                	jalr	s2
    800012ec:	00044503          	lbu	a0,0(s0)
    800012f0:	ff451ae3          	bne	a0,s4,800012e4 <vprintfmt+0x30>
    800012f4:	00144683          	lbu	a3,1(s0)
    800012f8:	00140a93          	addi	s5,s0,1
    800012fc:	8756                	mv	a4,s5
    800012fe:	02000c13          	li	s8,32
    80001302:	59fd                	li	s3,-1
    80001304:	5cfd                	li	s9,-1
    80001306:	4501                	li	a0,0
    80001308:	05500613          	li	a2,85
    8000130c:	45a5                	li	a1,9
    8000130e:	fdd6879b          	addiw	a5,a3,-35
    80001312:	0ff7f793          	andi	a5,a5,255
    80001316:	00170413          	addi	s0,a4,1
    8000131a:	1cf66f63          	bltu	a2,a5,800014f8 <vprintfmt+0x244>
    8000131e:	078a                	slli	a5,a5,0x2
    80001320:	97da                	add	a5,a5,s6
    80001322:	439c                	lw	a5,0(a5)
    80001324:	97da                	add	a5,a5,s6
    80001326:	8782                	jr	a5
    80001328:	60f6                	ld	ra,344(sp)
    8000132a:	6456                	ld	s0,336(sp)
    8000132c:	64b6                	ld	s1,328(sp)
    8000132e:	6916                	ld	s2,320(sp)
    80001330:	79f2                	ld	s3,312(sp)
    80001332:	7a52                	ld	s4,304(sp)
    80001334:	7ab2                	ld	s5,296(sp)
    80001336:	7b12                	ld	s6,288(sp)
    80001338:	6bf2                	ld	s7,280(sp)
    8000133a:	6c52                	ld	s8,272(sp)
    8000133c:	6cb2                	ld	s9,264(sp)
    8000133e:	6d12                	ld	s10,256(sp)
    80001340:	6135                	addi	sp,sp,352
    80001342:	8082                	ret
    80001344:	4721                	li	a4,8
    80001346:	4785                	li	a5,1
    80001348:	008b8693          	addi	a3,s7,8
    8000134c:	08a7c763          	blt	a5,a0,800013da <vprintfmt+0x126>
    80001350:	e549                	bnez	a0,800013da <vprintfmt+0x126>
    80001352:	000be783          	lwu	a5,0(s7)
    80001356:	8bb6                	mv	s7,a3
    80001358:	02e7f9b3          	remu	s3,a5,a4
    8000135c:	2c01                	sext.w	s8,s8
    8000135e:	0054                	addi	a3,sp,4
    80001360:	4a85                	li	s5,1
    80001362:	c04e                	sw	s3,0(sp)
    80001364:	00e7f463          	bleu	a4,a5,8000136c <vprintfmt+0xb8>
    80001368:	aaf9                	j	80001546 <vprintfmt+0x292>
    8000136a:	8aea                	mv	s5,s10
    8000136c:	02e7d7b3          	divu	a5,a5,a4
    80001370:	0691                	addi	a3,a3,4
    80001372:	001a8d1b          	addiw	s10,s5,1
    80001376:	02e7f9b3          	remu	s3,a5,a4
    8000137a:	ff36ae23          	sw	s3,-4(a3)
    8000137e:	fee7f6e3          	bleu	a4,a5,8000136a <vprintfmt+0xb6>
    80001382:	019d5963          	ble	s9,s10,80001394 <vprintfmt+0xe0>
    80001386:	2c81                	sext.w	s9,s9
    80001388:	3cfd                	addiw	s9,s9,-1
    8000138a:	85a6                	mv	a1,s1
    8000138c:	8562                	mv	a0,s8
    8000138e:	9902                	jalr	s2
    80001390:	ff9d4ce3          	blt	s10,s9,80001388 <vprintfmt+0xd4>
    80001394:	002a9c13          	slli	s8,s5,0x2
    80001398:	01810ab3          	add	s5,sp,s8
    8000139c:	418a8c33          	sub	s8,s5,s8
    800013a0:	4ca5                	li	s9,9
    800013a2:	a021                	j	800013aa <vprintfmt+0xf6>
    800013a4:	ffcaa983          	lw	s3,-4(s5)
    800013a8:	1af1                	addi	s5,s5,-4
    800013aa:	05700513          	li	a0,87
    800013ae:	013ce463          	bltu	s9,s3,800013b6 <vprintfmt+0x102>
    800013b2:	03000513          	li	a0,48
    800013b6:	85a6                	mv	a1,s1
    800013b8:	0135053b          	addw	a0,a0,s3
    800013bc:	9902                	jalr	s2
    800013be:	ff5c13e3          	bne	s8,s5,800013a4 <vprintfmt+0xf0>
    800013c2:	b72d                	j	800012ec <vprintfmt+0x38>
    800013c4:	03000513          	li	a0,48
    800013c8:	85a6                	mv	a1,s1
    800013ca:	9902                	jalr	s2
    800013cc:	85a6                	mv	a1,s1
    800013ce:	07800513          	li	a0,120
    800013d2:	9902                	jalr	s2
    800013d4:	008b8693          	addi	a3,s7,8
    800013d8:	4741                	li	a4,16
    800013da:	000bb783          	ld	a5,0(s7)
    800013de:	8bb6                	mv	s7,a3
    800013e0:	bfa5                	j	80001358 <vprintfmt+0xa4>
    800013e2:	000bba83          	ld	s5,0(s7)
    800013e6:	0ba1                	addi	s7,s7,8
    800013e8:	180a8163          	beqz	s5,8000156a <vprintfmt+0x2b6>
    800013ec:	15905763          	blez	s9,8000153a <vprintfmt+0x286>
    800013f0:	02d00793          	li	a5,45
    800013f4:	10fc1c63          	bne	s8,a5,8000150c <vprintfmt+0x258>
    800013f8:	000ac503          	lbu	a0,0(s5)
    800013fc:	c105                	beqz	a0,8000141c <vprintfmt+0x168>
    800013fe:	5c7d                	li	s8,-1
    80001400:	0009c563          	bltz	s3,8000140a <vprintfmt+0x156>
    80001404:	39fd                	addiw	s3,s3,-1
    80001406:	01898963          	beq	s3,s8,80001418 <vprintfmt+0x164>
    8000140a:	85a6                	mv	a1,s1
    8000140c:	0a85                	addi	s5,s5,1
    8000140e:	9902                	jalr	s2
    80001410:	000ac503          	lbu	a0,0(s5)
    80001414:	3cfd                	addiw	s9,s9,-1
    80001416:	f56d                	bnez	a0,80001400 <vprintfmt+0x14c>
    80001418:	ed905ae3          	blez	s9,800012ec <vprintfmt+0x38>
    8000141c:	3cfd                	addiw	s9,s9,-1
    8000141e:	85a6                	mv	a1,s1
    80001420:	02000513          	li	a0,32
    80001424:	9902                	jalr	s2
    80001426:	fe0c9be3          	bnez	s9,8000141c <vprintfmt+0x168>
    8000142a:	b5c9                	j	800012ec <vprintfmt+0x38>
    8000142c:	4729                	li	a4,10
    8000142e:	bf21                	j	80001346 <vprintfmt+0x92>
    80001430:	00174683          	lbu	a3,1(a4)
    80001434:	8722                	mv	a4,s0
    80001436:	bde1                	j	8000130e <vprintfmt+0x5a>
    80001438:	85a6                	mv	a1,s1
    8000143a:	02500513          	li	a0,37
    8000143e:	9902                	jalr	s2
    80001440:	b575                	j	800012ec <vprintfmt+0x38>
    80001442:	4741                	li	a4,16
    80001444:	b709                	j	80001346 <vprintfmt+0x92>
    80001446:	000ba983          	lw	s3,0(s7)
    8000144a:	00174683          	lbu	a3,1(a4)
    8000144e:	0ba1                	addi	s7,s7,8
    80001450:	8722                	mv	a4,s0
    80001452:	ea0cdee3          	bgez	s9,8000130e <vprintfmt+0x5a>
    80001456:	8cce                	mv	s9,s3
    80001458:	59fd                	li	s3,-1
    8000145a:	bd55                	j	8000130e <vprintfmt+0x5a>
    8000145c:	00174683          	lbu	a3,1(a4)
    80001460:	02d00c13          	li	s8,45
    80001464:	8722                	mv	a4,s0
    80001466:	b565                	j	8000130e <vprintfmt+0x5a>
    80001468:	fffcc793          	not	a5,s9
    8000146c:	97fd                	srai	a5,a5,0x3f
    8000146e:	00fcfcb3          	and	s9,s9,a5
    80001472:	00174683          	lbu	a3,1(a4)
    80001476:	2c81                	sext.w	s9,s9
    80001478:	8722                	mv	a4,s0
    8000147a:	bd51                	j	8000130e <vprintfmt+0x5a>
    8000147c:	00174683          	lbu	a3,1(a4)
    80001480:	03000c13          	li	s8,48
    80001484:	8722                	mv	a4,s0
    80001486:	b561                	j	8000130e <vprintfmt+0x5a>
    80001488:	fd06899b          	addiw	s3,a3,-48
    8000148c:	00174683          	lbu	a3,1(a4)
    80001490:	8722                	mv	a4,s0
    80001492:	fd06879b          	addiw	a5,a3,-48
    80001496:	0006881b          	sext.w	a6,a3
    8000149a:	faf5ece3          	bltu	a1,a5,80001452 <vprintfmt+0x19e>
    8000149e:	0705                	addi	a4,a4,1
    800014a0:	0029979b          	slliw	a5,s3,0x2
    800014a4:	00074683          	lbu	a3,0(a4)
    800014a8:	013789bb          	addw	s3,a5,s3
    800014ac:	0019999b          	slliw	s3,s3,0x1
    800014b0:	010989bb          	addw	s3,s3,a6
    800014b4:	fd06879b          	addiw	a5,a3,-48
    800014b8:	fd09899b          	addiw	s3,s3,-48
    800014bc:	0006881b          	sext.w	a6,a3
    800014c0:	fcf5ffe3          	bleu	a5,a1,8000149e <vprintfmt+0x1ea>
    800014c4:	b779                	j	80001452 <vprintfmt+0x19e>
    800014c6:	000ba503          	lw	a0,0(s7)
    800014ca:	85a6                	mv	a1,s1
    800014cc:	0ba1                	addi	s7,s7,8
    800014ce:	9902                	jalr	s2
    800014d0:	bd31                	j	800012ec <vprintfmt+0x38>
    800014d2:	4785                	li	a5,1
    800014d4:	008b8a93          	addi	s5,s7,8
    800014d8:	00a7c363          	blt	a5,a0,800014de <vprintfmt+0x22a>
    800014dc:	c93d                	beqz	a0,80001552 <vprintfmt+0x29e>
    800014de:	000bb983          	ld	s3,0(s7)
    800014e2:	0609cb63          	bltz	s3,80001558 <vprintfmt+0x2a4>
    800014e6:	87ce                	mv	a5,s3
    800014e8:	8bd6                	mv	s7,s5
    800014ea:	4729                	li	a4,10
    800014ec:	b5b5                	j	80001358 <vprintfmt+0xa4>
    800014ee:	00174683          	lbu	a3,1(a4)
    800014f2:	2505                	addiw	a0,a0,1
    800014f4:	8722                	mv	a4,s0
    800014f6:	bd21                	j	8000130e <vprintfmt+0x5a>
    800014f8:	85a6                	mv	a1,s1
    800014fa:	02500513          	li	a0,37
    800014fe:	9902                	jalr	s2
    80001500:	8456                	mv	s0,s5
    80001502:	b3ed                	j	800012ec <vprintfmt+0x38>
    80001504:	00001a97          	auipc	s5,0x1
    80001508:	1dca8a93          	addi	s5,s5,476 # 800026e0 <main+0xd16>
    8000150c:	06098d63          	beqz	s3,80001586 <vprintfmt+0x2d2>
    80001510:	000ac783          	lbu	a5,0(s5)
    80001514:	cbad                	beqz	a5,80001586 <vprintfmt+0x2d2>
    80001516:	001a8793          	addi	a5,s5,1
    8000151a:	013a8633          	add	a2,s5,s3
    8000151e:	a029                	j	80001528 <vprintfmt+0x274>
    80001520:	0785                	addi	a5,a5,1
    80001522:	fff7c703          	lbu	a4,-1(a5)
    80001526:	cb25                	beqz	a4,80001596 <vprintfmt+0x2e2>
    80001528:	86be                	mv	a3,a5
    8000152a:	fef61be3          	bne	a2,a5,80001520 <vprintfmt+0x26c>
    8000152e:	415606bb          	subw	a3,a2,s5
    80001532:	40dc8cbb          	subw	s9,s9,a3
    80001536:	05904863          	bgtz	s9,80001586 <vprintfmt+0x2d2>
    8000153a:	000ac503          	lbu	a0,0(s5)
    8000153e:	da0507e3          	beqz	a0,800012ec <vprintfmt+0x38>
    80001542:	5c7d                	li	s8,-1
    80001544:	bd75                	j	80001400 <vprintfmt+0x14c>
    80001546:	4785                	li	a5,1
    80001548:	4a81                	li	s5,0
    8000154a:	4d05                	li	s10,1
    8000154c:	e397cde3          	blt	a5,s9,80001386 <vprintfmt+0xd2>
    80001550:	b591                	j	80001394 <vprintfmt+0xe0>
    80001552:	000ba983          	lw	s3,0(s7)
    80001556:	b771                	j	800014e2 <vprintfmt+0x22e>
    80001558:	85a6                	mv	a1,s1
    8000155a:	02d00513          	li	a0,45
    8000155e:	9902                	jalr	s2
    80001560:	8bd6                	mv	s7,s5
    80001562:	413007b3          	neg	a5,s3
    80001566:	4729                	li	a4,10
    80001568:	bbc5                	j	80001358 <vprintfmt+0xa4>
    8000156a:	01905663          	blez	s9,80001576 <vprintfmt+0x2c2>
    8000156e:	02d00793          	li	a5,45
    80001572:	f8fc19e3          	bne	s8,a5,80001504 <vprintfmt+0x250>
    80001576:	00001a97          	auipc	s5,0x1
    8000157a:	16aa8a93          	addi	s5,s5,362 # 800026e0 <main+0xd16>
    8000157e:	02800513          	li	a0,40
    80001582:	5c7d                	li	s8,-1
    80001584:	bdb5                	j	80001400 <vprintfmt+0x14c>
    80001586:	2c01                	sext.w	s8,s8
    80001588:	3cfd                	addiw	s9,s9,-1
    8000158a:	85a6                	mv	a1,s1
    8000158c:	8562                	mv	a0,s8
    8000158e:	9902                	jalr	s2
    80001590:	fe0c9ce3          	bnez	s9,80001588 <vprintfmt+0x2d4>
    80001594:	b75d                	j	8000153a <vprintfmt+0x286>
    80001596:	415686bb          	subw	a3,a3,s5
    8000159a:	bf61                	j	80001532 <vprintfmt+0x27e>

000000008000159c <sprintf_putch.3143>:
    8000159c:	619c                	ld	a5,0(a1)
    8000159e:	00a78023          	sb	a0,0(a5)
    800015a2:	619c                	ld	a5,0(a1)
    800015a4:	0785                	addi	a5,a5,1
    800015a6:	e19c                	sd	a5,0(a1)
    800015a8:	8082                	ret

00000000800015aa <putchar>:
    800015aa:	04022803          	lw	a6,64(tp) # 40 <buflen.3029>
    800015ae:	00020793          	mv	a5,tp
    800015b2:	97c2                	add	a5,a5,a6
    800015b4:	7159                	addi	sp,sp,-112
    800015b6:	0018071b          	addiw	a4,a6,1
    800015ba:	04e22023          	sw	a4,64(tp) # 40 <buflen.3029>
    800015be:	00a78023          	sb	a0,0(a5)
    800015c2:	45a9                	li	a1,10
    800015c4:	03f10793          	addi	a5,sp,63
    800015c8:	fc07f793          	andi	a5,a5,-64
    800015cc:	00b50963          	beq	a0,a1,800015de <putchar+0x34>
    800015d0:	04000593          	li	a1,64
    800015d4:	00b70563          	beq	a4,a1,800015de <putchar+0x34>
    800015d8:	4501                	li	a0,0
    800015da:	6165                	addi	sp,sp,112
    800015dc:	8082                	ret
    800015de:	04000593          	li	a1,64
    800015e2:	e38c                	sd	a1,0(a5)
    800015e4:	4585                	li	a1,1
    800015e6:	e78c                	sd	a1,8(a5)
    800015e8:	00020693          	mv	a3,tp
    800015ec:	eb94                	sd	a3,16(a5)
    800015ee:	ef98                	sd	a4,24(a5)
    800015f0:	0ff0000f          	fence
    800015f4:	00000697          	auipc	a3,0x0
    800015f8:	a4c68693          	addi	a3,a3,-1460 # 80001040 <fromhost>
    800015fc:	00000717          	auipc	a4,0x0
    80001600:	a0f73223          	sd	a5,-1532(a4) # 80001000 <tohost>
    80001604:	6298                	ld	a4,0(a3)
    80001606:	df7d                	beqz	a4,80001604 <putchar+0x5a>
    80001608:	00000717          	auipc	a4,0x0
    8000160c:	a2073c23          	sd	zero,-1480(a4) # 80001040 <fromhost>
    80001610:	0ff0000f          	fence
    80001614:	04022023          	sw	zero,64(tp) # 40 <buflen.3029>
    80001618:	639c                	ld	a5,0(a5)
    8000161a:	4501                	li	a0,0
    8000161c:	6165                	addi	sp,sp,112
    8000161e:	8082                	ret

0000000080001620 <setStats>:
    80001620:	b00027f3          	csrr	a5,mcycle
    80001624:	00004717          	auipc	a4,0x4
    80001628:	a8470713          	addi	a4,a4,-1404 # 800050a8 <counters>
    8000162c:	e919                	bnez	a0,80001642 <setStats+0x22>
    8000162e:	6314                	ld	a3,0(a4)
    80001630:	00001617          	auipc	a2,0x1
    80001634:	0b860613          	addi	a2,a2,184 # 800026e8 <main+0xd1e>
    80001638:	00004597          	auipc	a1,0x4
    8000163c:	a8c5b023          	sd	a2,-1408(a1) # 800050b8 <counter_names>
    80001640:	8f95                	sub	a5,a5,a3
    80001642:	00004697          	auipc	a3,0x4
    80001646:	a6f6b323          	sd	a5,-1434(a3) # 800050a8 <counters>
    8000164a:	b02027f3          	csrr	a5,minstret
    8000164e:	e919                	bnez	a0,80001664 <setStats+0x44>
    80001650:	6718                	ld	a4,8(a4)
    80001652:	00001697          	auipc	a3,0x1
    80001656:	09e68693          	addi	a3,a3,158 # 800026f0 <main+0xd26>
    8000165a:	00004617          	auipc	a2,0x4
    8000165e:	a6d63323          	sd	a3,-1434(a2) # 800050c0 <counter_names+0x8>
    80001662:	8f99                	sub	a5,a5,a4
    80001664:	00004717          	auipc	a4,0x4
    80001668:	a4f73623          	sd	a5,-1460(a4) # 800050b0 <counters+0x8>
    8000166c:	8082                	ret

000000008000166e <tohost_exit>:
    8000166e:	00151793          	slli	a5,a0,0x1
    80001672:	0017e793          	ori	a5,a5,1
    80001676:	00000717          	auipc	a4,0x0
    8000167a:	98f73523          	sd	a5,-1654(a4) # 80001000 <tohost>
    8000167e:	a001                	j	8000167e <tohost_exit+0x10>

0000000080001680 <handle_trap>:
    80001680:	6785                	lui	a5,0x1
    80001682:	a7378793          	addi	a5,a5,-1421 # a73 <_tbss_end+0xa2f>
    80001686:	00000717          	auipc	a4,0x0
    8000168a:	96f73d23          	sd	a5,-1670(a4) # 80001000 <tohost>
    8000168e:	a001                	j	8000168e <handle_trap+0xe>

0000000080001690 <exit>:
    80001690:	1141                	addi	sp,sp,-16
    80001692:	e406                	sd	ra,8(sp)
    80001694:	fdbff0ef          	jal	ra,8000166e <tohost_exit>

0000000080001698 <abort>:
    80001698:	10d00793          	li	a5,269
    8000169c:	00000717          	auipc	a4,0x0
    800016a0:	96f73223          	sd	a5,-1692(a4) # 80001000 <tohost>
    800016a4:	a001                	j	800016a4 <abort+0xc>

00000000800016a6 <printstr>:
    800016a6:	00054783          	lbu	a5,0(a0)
    800016aa:	7159                	addi	sp,sp,-112
    800016ac:	03f10693          	addi	a3,sp,63
    800016b0:	fc06f693          	andi	a3,a3,-64
    800016b4:	c3b9                	beqz	a5,800016fa <printstr+0x54>
    800016b6:	87aa                	mv	a5,a0
    800016b8:	0785                	addi	a5,a5,1
    800016ba:	0007c703          	lbu	a4,0(a5)
    800016be:	ff6d                	bnez	a4,800016b8 <printstr+0x12>
    800016c0:	8f89                	sub	a5,a5,a0
    800016c2:	04000713          	li	a4,64
    800016c6:	e298                	sd	a4,0(a3)
    800016c8:	4705                	li	a4,1
    800016ca:	e698                	sd	a4,8(a3)
    800016cc:	ea88                	sd	a0,16(a3)
    800016ce:	ee9c                	sd	a5,24(a3)
    800016d0:	0ff0000f          	fence
    800016d4:	00000717          	auipc	a4,0x0
    800016d8:	96c70713          	addi	a4,a4,-1684 # 80001040 <fromhost>
    800016dc:	00000797          	auipc	a5,0x0
    800016e0:	92d7b223          	sd	a3,-1756(a5) # 80001000 <tohost>
    800016e4:	631c                	ld	a5,0(a4)
    800016e6:	dffd                	beqz	a5,800016e4 <printstr+0x3e>
    800016e8:	00000797          	auipc	a5,0x0
    800016ec:	9407bc23          	sd	zero,-1704(a5) # 80001040 <fromhost>
    800016f0:	0ff0000f          	fence
    800016f4:	629c                	ld	a5,0(a3)
    800016f6:	6165                	addi	sp,sp,112
    800016f8:	8082                	ret
    800016fa:	4781                	li	a5,0
    800016fc:	b7d9                	j	800016c2 <printstr+0x1c>

00000000800016fe <thread_entry>:
    800016fe:	c111                	beqz	a0,80001702 <thread_entry+0x4>
    80001700:	a001                	j	80001700 <thread_entry+0x2>
    80001702:	8082                	ret

0000000080001704 <printhex>:
    80001704:	7179                	addi	sp,sp,-48
    80001706:	862a                	mv	a2,a0
    80001708:	f406                	sd	ra,40(sp)
    8000170a:	0028                	addi	a0,sp,8
    8000170c:	01710693          	addi	a3,sp,23
    80001710:	4825                	li	a6,9
    80001712:	a011                	j	80001716 <printhex+0x12>
    80001714:	86be                	mv	a3,a5
    80001716:	00f67793          	andi	a5,a2,15
    8000171a:	03000593          	li	a1,48
    8000171e:	0ff7f713          	andi	a4,a5,255
    80001722:	00f87463          	bleu	a5,a6,8000172a <printhex+0x26>
    80001726:	05700593          	li	a1,87
    8000172a:	00b707bb          	addw	a5,a4,a1
    8000172e:	00f68023          	sb	a5,0(a3)
    80001732:	8211                	srli	a2,a2,0x4
    80001734:	fff68793          	addi	a5,a3,-1
    80001738:	fcd51ee3          	bne	a0,a3,80001714 <printhex+0x10>
    8000173c:	00010c23          	sb	zero,24(sp)
    80001740:	f67ff0ef          	jal	ra,800016a6 <printstr>
    80001744:	70a2                	ld	ra,40(sp)
    80001746:	6145                	addi	sp,sp,48
    80001748:	8082                	ret

000000008000174a <printf>:
    8000174a:	711d                	addi	sp,sp,-96
    8000174c:	02810313          	addi	t1,sp,40
    80001750:	f42e                	sd	a1,40(sp)
    80001752:	f832                	sd	a2,48(sp)
    80001754:	fc36                	sd	a3,56(sp)
    80001756:	862a                	mv	a2,a0
    80001758:	869a                	mv	a3,t1
    8000175a:	00000517          	auipc	a0,0x0
    8000175e:	e5050513          	addi	a0,a0,-432 # 800015aa <putchar>
    80001762:	4581                	li	a1,0
    80001764:	ec06                	sd	ra,24(sp)
    80001766:	e0ba                	sd	a4,64(sp)
    80001768:	e4be                	sd	a5,72(sp)
    8000176a:	e8c2                	sd	a6,80(sp)
    8000176c:	ecc6                	sd	a7,88(sp)
    8000176e:	e41a                	sd	t1,8(sp)
    80001770:	b45ff0ef          	jal	ra,800012b4 <vprintfmt>
    80001774:	60e2                	ld	ra,24(sp)
    80001776:	4501                	li	a0,0
    80001778:	6125                	addi	sp,sp,96
    8000177a:	8082                	ret

000000008000177c <sprintf>:
    8000177c:	711d                	addi	sp,sp,-96
    8000177e:	03010313          	addi	t1,sp,48
    80001782:	f022                	sd	s0,32(sp)
    80001784:	e42a                	sd	a0,8(sp)
    80001786:	f832                	sd	a2,48(sp)
    80001788:	fc36                	sd	a3,56(sp)
    8000178a:	842a                	mv	s0,a0
    8000178c:	862e                	mv	a2,a1
    8000178e:	00000517          	auipc	a0,0x0
    80001792:	e0e50513          	addi	a0,a0,-498 # 8000159c <sprintf_putch.3143>
    80001796:	002c                	addi	a1,sp,8
    80001798:	869a                	mv	a3,t1
    8000179a:	f406                	sd	ra,40(sp)
    8000179c:	e4be                	sd	a5,72(sp)
    8000179e:	e0ba                	sd	a4,64(sp)
    800017a0:	e8c2                	sd	a6,80(sp)
    800017a2:	ecc6                	sd	a7,88(sp)
    800017a4:	ec1a                	sd	t1,24(sp)
    800017a6:	b0fff0ef          	jal	ra,800012b4 <vprintfmt>
    800017aa:	67a2                	ld	a5,8(sp)
    800017ac:	00078023          	sb	zero,0(a5)
    800017b0:	6522                	ld	a0,8(sp)
    800017b2:	70a2                	ld	ra,40(sp)
    800017b4:	9d01                	subw	a0,a0,s0
    800017b6:	7402                	ld	s0,32(sp)
    800017b8:	6125                	addi	sp,sp,96
    800017ba:	8082                	ret

00000000800017bc <memcpy>:
    800017bc:	00c5e7b3          	or	a5,a1,a2
    800017c0:	8fc9                	or	a5,a5,a0
    800017c2:	8b9d                	andi	a5,a5,7
    800017c4:	00c506b3          	add	a3,a0,a2
    800017c8:	cf91                	beqz	a5,800017e4 <memcpy+0x28>
    800017ca:	962e                	add	a2,a2,a1
    800017cc:	87aa                	mv	a5,a0
    800017ce:	02d57763          	bleu	a3,a0,800017fc <memcpy+0x40>
    800017d2:	0585                	addi	a1,a1,1
    800017d4:	fff5c703          	lbu	a4,-1(a1)
    800017d8:	0785                	addi	a5,a5,1
    800017da:	fee78fa3          	sb	a4,-1(a5)
    800017de:	feb61ae3          	bne	a2,a1,800017d2 <memcpy+0x16>
    800017e2:	8082                	ret
    800017e4:	fed57fe3          	bleu	a3,a0,800017e2 <memcpy+0x26>
    800017e8:	87aa                	mv	a5,a0
    800017ea:	05a1                	addi	a1,a1,8
    800017ec:	ff85b703          	ld	a4,-8(a1)
    800017f0:	07a1                	addi	a5,a5,8
    800017f2:	fee7bc23          	sd	a4,-8(a5)
    800017f6:	fed7eae3          	bltu	a5,a3,800017ea <memcpy+0x2e>
    800017fa:	8082                	ret
    800017fc:	8082                	ret

00000000800017fe <memset>:
    800017fe:	00c567b3          	or	a5,a0,a2
    80001802:	8b9d                	andi	a5,a5,7
    80001804:	962a                	add	a2,a2,a0
    80001806:	0ff5f593          	andi	a1,a1,255
    8000180a:	cb91                	beqz	a5,8000181e <memset+0x20>
    8000180c:	87aa                	mv	a5,a0
    8000180e:	02c57a63          	bleu	a2,a0,80001842 <memset+0x44>
    80001812:	0785                	addi	a5,a5,1
    80001814:	feb78fa3          	sb	a1,-1(a5)
    80001818:	fef61de3          	bne	a2,a5,80001812 <memset+0x14>
    8000181c:	8082                	ret
    8000181e:	00859713          	slli	a4,a1,0x8
    80001822:	8f4d                	or	a4,a4,a1
    80001824:	01071593          	slli	a1,a4,0x10
    80001828:	8f4d                	or	a4,a4,a1
    8000182a:	02071793          	slli	a5,a4,0x20
    8000182e:	8f5d                	or	a4,a4,a5
    80001830:	fec576e3          	bleu	a2,a0,8000181c <memset+0x1e>
    80001834:	87aa                	mv	a5,a0
    80001836:	07a1                	addi	a5,a5,8
    80001838:	fee7bc23          	sd	a4,-8(a5)
    8000183c:	fec7ede3          	bltu	a5,a2,80001836 <memset+0x38>
    80001840:	8082                	ret
    80001842:	8082                	ret

0000000080001844 <_init>:
    80001844:	7171                	addi	sp,sp,-176
    80001846:	f122                	sd	s0,160(sp)
    80001848:	ed26                	sd	s1,152(sp)
    8000184a:	00020493          	mv	s1,tp
    8000184e:	00020413          	mv	s0,tp
    80001852:	40848433          	sub	s0,s1,s0
    80001856:	8622                	mv	a2,s0
    80001858:	e54e                	sd	s3,136(sp)
    8000185a:	e152                	sd	s4,128(sp)
    8000185c:	89aa                	mv	s3,a0
    8000185e:	8a2e                	mv	s4,a1
    80001860:	8512                	mv	a0,tp
    80001862:	00004597          	auipc	a1,0x4
    80001866:	89e58593          	addi	a1,a1,-1890 # 80005100 <_end>
    8000186a:	f506                	sd	ra,168(sp)
    8000186c:	e94a                	sd	s2,144(sp)
    8000186e:	fcd6                	sd	s5,120(sp)
    80001870:	8a92                	mv	s5,tp
    80001872:	f4bff0ef          	jal	ra,800017bc <memcpy>
    80001876:	04420613          	addi	a2,tp,68 # 44 <_tbss_end>
    8000187a:	8e05                	sub	a2,a2,s1
    8000187c:	4581                	li	a1,0
    8000187e:	008a8533          	add	a0,s5,s0
    80001882:	f7dff0ef          	jal	ra,800017fe <memset>
    80001886:	854e                	mv	a0,s3
    80001888:	85d2                	mv	a1,s4
    8000188a:	e75ff0ef          	jal	ra,800016fe <thread_entry>
    8000188e:	4581                	li	a1,0
    80001890:	4501                	li	a0,0
    80001892:	138000ef          	jal	ra,800019ca <main>
    80001896:	00004417          	auipc	s0,0x4
    8000189a:	81240413          	addi	s0,s0,-2030 # 800050a8 <counters>
    8000189e:	6014                	ld	a3,0(s0)
    800018a0:	03f10913          	addi	s2,sp,63
    800018a4:	fc097913          	andi	s2,s2,-64
    800018a8:	89aa                	mv	s3,a0
    800018aa:	e695                	bnez	a3,800018d6 <_init+0x92>
    800018ac:	6414                	ld	a3,8(s0)
    800018ae:	e681                	bnez	a3,800018b6 <_init+0x72>
    800018b0:	854e                	mv	a0,s3
    800018b2:	dbdff0ef          	jal	ra,8000166e <tohost_exit>
    800018b6:	84ca                	mv	s1,s2
    800018b8:	6c10                	ld	a2,24(s0)
    800018ba:	8526                	mv	a0,s1
    800018bc:	00001597          	auipc	a1,0x1
    800018c0:	e5c58593          	addi	a1,a1,-420 # 80002718 <main+0xd4e>
    800018c4:	eb9ff0ef          	jal	ra,8000177c <sprintf>
    800018c8:	94aa                	add	s1,s1,a0
    800018ca:	fe9903e3          	beq	s2,s1,800018b0 <_init+0x6c>
    800018ce:	854a                	mv	a0,s2
    800018d0:	dd7ff0ef          	jal	ra,800016a6 <printstr>
    800018d4:	bff1                	j	800018b0 <_init+0x6c>
    800018d6:	6810                	ld	a2,16(s0)
    800018d8:	00001597          	auipc	a1,0x1
    800018dc:	e4058593          	addi	a1,a1,-448 # 80002718 <main+0xd4e>
    800018e0:	854a                	mv	a0,s2
    800018e2:	e9bff0ef          	jal	ra,8000177c <sprintf>
    800018e6:	6414                	ld	a3,8(s0)
    800018e8:	00a904b3          	add	s1,s2,a0
    800018ec:	def9                	beqz	a3,800018ca <_init+0x86>
    800018ee:	b7e9                	j	800018b8 <_init+0x74>

00000000800018f0 <strlen>:
    800018f0:	00054783          	lbu	a5,0(a0)
    800018f4:	cb89                	beqz	a5,80001906 <strlen+0x16>
    800018f6:	87aa                	mv	a5,a0
    800018f8:	0785                	addi	a5,a5,1
    800018fa:	0007c703          	lbu	a4,0(a5)
    800018fe:	ff6d                	bnez	a4,800018f8 <strlen+0x8>
    80001900:	40a78533          	sub	a0,a5,a0
    80001904:	8082                	ret
    80001906:	4501                	li	a0,0
    80001908:	8082                	ret

000000008000190a <strnlen>:
    8000190a:	cd91                	beqz	a1,80001926 <strnlen+0x1c>
    8000190c:	00054783          	lbu	a5,0(a0)
    80001910:	c38d                	beqz	a5,80001932 <strnlen+0x28>
    80001912:	00b506b3          	add	a3,a0,a1
    80001916:	87aa                	mv	a5,a0
    80001918:	a021                	j	80001920 <strnlen+0x16>
    8000191a:	0007c703          	lbu	a4,0(a5)
    8000191e:	c711                	beqz	a4,8000192a <strnlen+0x20>
    80001920:	0785                	addi	a5,a5,1
    80001922:	fed79ce3          	bne	a5,a3,8000191a <strnlen+0x10>
    80001926:	852e                	mv	a0,a1
    80001928:	8082                	ret
    8000192a:	40a785b3          	sub	a1,a5,a0
    8000192e:	852e                	mv	a0,a1
    80001930:	8082                	ret
    80001932:	4581                	li	a1,0
    80001934:	bfcd                	j	80001926 <strnlen+0x1c>

0000000080001936 <strcmp>:
    80001936:	0505                	addi	a0,a0,1
    80001938:	fff54783          	lbu	a5,-1(a0)
    8000193c:	0585                	addi	a1,a1,1
    8000193e:	fff5c703          	lbu	a4,-1(a1)
    80001942:	c799                	beqz	a5,80001950 <strcmp+0x1a>
    80001944:	fee789e3          	beq	a5,a4,80001936 <strcmp>
    80001948:	0007851b          	sext.w	a0,a5
    8000194c:	9d19                	subw	a0,a0,a4
    8000194e:	8082                	ret
    80001950:	4501                	li	a0,0
    80001952:	bfed                	j	8000194c <strcmp+0x16>

0000000080001954 <strcpy>:
    80001954:	87aa                	mv	a5,a0
    80001956:	0585                	addi	a1,a1,1
    80001958:	fff5c703          	lbu	a4,-1(a1)
    8000195c:	0785                	addi	a5,a5,1
    8000195e:	fee78fa3          	sb	a4,-1(a5)
    80001962:	fb75                	bnez	a4,80001956 <strcpy+0x2>
    80001964:	8082                	ret

0000000080001966 <atol>:
    80001966:	00054783          	lbu	a5,0(a0)
    8000196a:	02000713          	li	a4,32
    8000196e:	00e79763          	bne	a5,a4,8000197c <atol+0x16>
    80001972:	0505                	addi	a0,a0,1
    80001974:	00054783          	lbu	a5,0(a0)
    80001978:	fee78de3          	beq	a5,a4,80001972 <atol+0xc>
    8000197c:	fd57871b          	addiw	a4,a5,-43
    80001980:	0fd77713          	andi	a4,a4,253
    80001984:	c715                	beqz	a4,800019b0 <atol+0x4a>
    80001986:	00054683          	lbu	a3,0(a0)
    8000198a:	87aa                	mv	a5,a0
    8000198c:	4601                	li	a2,0
    8000198e:	ce85                	beqz	a3,800019c6 <atol+0x60>
    80001990:	4501                	li	a0,0
    80001992:	0785                	addi	a5,a5,1
    80001994:	fd06859b          	addiw	a1,a3,-48
    80001998:	00251713          	slli	a4,a0,0x2
    8000199c:	0007c683          	lbu	a3,0(a5)
    800019a0:	953a                	add	a0,a0,a4
    800019a2:	0506                	slli	a0,a0,0x1
    800019a4:	952e                	add	a0,a0,a1
    800019a6:	f6f5                	bnez	a3,80001992 <atol+0x2c>
    800019a8:	c219                	beqz	a2,800019ae <atol+0x48>
    800019aa:	40a00533          	neg	a0,a0
    800019ae:	8082                	ret
    800019b0:	00154683          	lbu	a3,1(a0)
    800019b4:	fd378793          	addi	a5,a5,-45
    800019b8:	0017b613          	seqz	a2,a5
    800019bc:	00150793          	addi	a5,a0,1
    800019c0:	fae1                	bnez	a3,80001990 <atol+0x2a>
    800019c2:	4501                	li	a0,0
    800019c4:	b7d5                	j	800019a8 <atol+0x42>
    800019c6:	4501                	li	a0,0
    800019c8:	8082                	ret

Disassembly of section .text.startup:

00000000800019ca <main>:
    800019ca:	7155                	addi	sp,sp,-208
    800019cc:	e586                	sd	ra,200(sp)
    800019ce:	e1a2                	sd	s0,192(sp)
    800019d0:	fd26                	sd	s1,184(sp)
    800019d2:	0980                	addi	s0,sp,208
    800019d4:	f94a                	sd	s2,176(sp)
    800019d6:	f54e                	sd	s3,168(sp)
    800019d8:	f152                	sd	s4,160(sp)
    800019da:	ed56                	sd	s5,152(sp)
    800019dc:	e95a                	sd	s6,144(sp)
    800019de:	e55e                	sd	s7,136(sp)
    800019e0:	e162                	sd	s8,128(sp)
    800019e2:	fce6                	sd	s9,120(sp)
    800019e4:	f8ea                	sd	s10,112(sp)
    800019e6:	f4ee                	sd	s11,104(sp)
    800019e8:	00000797          	auipc	a5,0x0
    800019ec:	6d878793          	addi	a5,a5,1752 # 800020c0 <main+0x6f6>
    800019f0:	7139                	addi	sp,sp,-64
    800019f2:	860a                	mv	a2,sp
    800019f4:	00c7a383          	lw	t2,12(a5)
    800019f8:	0107a283          	lw	t0,16(a5)
    800019fc:	0147af83          	lw	t6,20(a5)
    80001a00:	0187af03          	lw	t5,24(a5)
    80001a04:	01c7de83          	lhu	t4,28(a5)
    80001a08:	01e7ce03          	lbu	t3,30(a5)
    80001a0c:	0007a983          	lw	s3,0(a5)
    80001a10:	0047a903          	lw	s2,4(a5)
    80001a14:	7139                	addi	sp,sp,-64
    80001a16:	4784                	lw	s1,8(a5)
    80001a18:	4785                	li	a5,1
    80001a1a:	868a                	mv	a3,sp
    80001a1c:	1786                	slli	a5,a5,0x21
    80001a1e:	e69c                	sd	a5,8(a3)
    80001a20:	02800793          	li	a5,40
    80001a24:	00001717          	auipc	a4,0x1
    80001a28:	c5c70713          	addi	a4,a4,-932 # 80002680 <main+0xcb6>
    80001a2c:	e290                	sd	a2,0(a3)
    80001a2e:	ca9c                	sw	a5,16(a3)
    80001a30:	0136aa23          	sw	s3,20(a3)
    80001a34:	4f08                	lw	a0,24(a4)
    80001a36:	01c75583          	lhu	a1,28(a4)
    80001a3a:	00073303          	ld	t1,0(a4)
    80001a3e:	00873883          	ld	a7,8(a4)
    80001a42:	01073803          	ld	a6,16(a4)
    80001a46:	00001097          	auipc	ra,0x1
    80001a4a:	e6c0bd23          	sd	a2,-390(ra) # 800028c0 <Next_Ptr_Glob>
    80001a4e:	01e74783          	lbu	a5,30(a4)
    80001a52:	0126ac23          	sw	s2,24(a3)
    80001a56:	cec4                	sw	s1,28(a3)
    80001a58:	0276a023          	sw	t2,32(a3)
    80001a5c:	0256a223          	sw	t0,36(a3)
    80001a60:	03f6a423          	sw	t6,40(a3)
    80001a64:	03e6a623          	sw	t5,44(a3)
    80001a68:	03d69823          	sh	t4,48(a3)
    80001a6c:	03c68923          	sb	t3,50(a3)
    80001a70:	f6a42423          	sw	a0,-152(s0)
    80001a74:	f6f40723          	sb	a5,-146(s0)
    80001a78:	00001517          	auipc	a0,0x1
    80001a7c:	8e850513          	addi	a0,a0,-1816 # 80002360 <main+0x996>
    80001a80:	47a9                	li	a5,10
    80001a82:	00001717          	auipc	a4,0x1
    80001a86:	56f72923          	sw	a5,1394(a4) # 80002ff4 <Arr_2_Glob+0x65c>
    80001a8a:	84d1b423          	sd	a3,-1976(gp) # 800028c8 <Ptr_Glob>
    80001a8e:	f4643823          	sd	t1,-176(s0)
    80001a92:	f5143c23          	sd	a7,-168(s0)
    80001a96:	f7043023          	sd	a6,-160(s0)
    80001a9a:	f6b41623          	sh	a1,-148(s0)
    80001a9e:	cadff0ef          	jal	ra,8000174a <printf>
    80001aa2:	00000597          	auipc	a1,0x0
    80001aa6:	63e58593          	addi	a1,a1,1598 # 800020e0 <main+0x716>
    80001aaa:	00000517          	auipc	a0,0x0
    80001aae:	64650513          	addi	a0,a0,1606 # 800020f0 <main+0x726>
    80001ab2:	c99ff0ef          	jal	ra,8000174a <printf>
    80001ab6:	00001797          	auipc	a5,0x1
    80001aba:	df678793          	addi	a5,a5,-522 # 800028ac <Reg>
    80001abe:	439c                	lw	a5,0(a5)
    80001ac0:	5c078d63          	beqz	a5,8000209a <main+0x6d0>
    80001ac4:	00000517          	auipc	a0,0x0
    80001ac8:	65450513          	addi	a0,a0,1620 # 80002118 <main+0x74e>
    80001acc:	c7fff0ef          	jal	ra,8000174a <printf>
    80001ad0:	000f4637          	lui	a2,0xf4
    80001ad4:	24060613          	addi	a2,a2,576 # f4240 <_tbss_end+0xf41fc>
    80001ad8:	00000597          	auipc	a1,0x0
    80001adc:	6a058593          	addi	a1,a1,1696 # 80002178 <main+0x7ae>
    80001ae0:	00000517          	auipc	a0,0x0
    80001ae4:	6a850513          	addi	a0,a0,1704 # 80002188 <main+0x7be>
    80001ae8:	c63ff0ef          	jal	ra,8000174a <printf>
    80001aec:	00001517          	auipc	a0,0x1
    80001af0:	87450513          	addi	a0,a0,-1932 # 80002360 <main+0x996>
    80001af4:	c57ff0ef          	jal	ra,8000174a <printf>
    80001af8:	1f400793          	li	a5,500
    80001afc:	f2f43823          	sd	a5,-208(s0)
    80001b00:	00001a97          	auipc	s5,0x1
    80001b04:	ba0a8a93          	addi	s5,s5,-1120 # 800026a0 <main+0xcd6>
    80001b08:	00001797          	auipc	a5,0x1
    80001b0c:	da07a023          	sw	zero,-608(a5) # 800028a8 <Done>
    80001b10:	84818d13          	addi	s10,gp,-1976 # 800028c8 <Ptr_Glob>
    80001b14:	00001997          	auipc	s3,0x1
    80001b18:	d9c98993          	addi	s3,s3,-612 # 800028b0 <Ch_2_Glob>
    80001b1c:	00001497          	auipc	s1,0x1
    80001b20:	ba448493          	addi	s1,s1,-1116 # 800026c0 <main+0xcf6>
    80001b24:	f3043903          	ld	s2,-208(s0)
    80001b28:	00000517          	auipc	a0,0x0
    80001b2c:	67850513          	addi	a0,a0,1656 # 800021a0 <main+0x7d6>
    80001b30:	85ca                	mv	a1,s2
    80001b32:	c19ff0ef          	jal	ra,8000174a <printf>
    80001b36:	4505                	li	a0,1
    80001b38:	ae9ff0ef          	jal	ra,80001620 <setStats>
    80001b3c:	b00027f3          	csrr	a5,mcycle
    80001b40:	4a05                	li	s4,1
    80001b42:	00190c9b          	addiw	s9,s2,1
    80001b46:	00001717          	auipc	a4,0x1
    80001b4a:	d4f73d23          	sd	a5,-678(a4) # 800028a0 <Begin_Time>
    80001b4e:	4c09                	li	s8,2
    80001b50:	4b85                	li	s7,1
    80001b52:	4909                	li	s2,2
    80001b54:	e0eff0ef          	jal	ra,80001162 <Proc_5>
    80001b58:	ddeff0ef          	jal	ra,80001136 <Proc_4>
    80001b5c:	010ab603          	ld	a2,16(s5)
    80001b60:	01eac783          	lbu	a5,30(s5)
    80001b64:	000ab883          	ld	a7,0(s5)
    80001b68:	008ab803          	ld	a6,8(s5)
    80001b6c:	018aa683          	lw	a3,24(s5)
    80001b70:	01cad703          	lhu	a4,28(s5)
    80001b74:	f7040593          	addi	a1,s0,-144
    80001b78:	f5040513          	addi	a0,s0,-176
    80001b7c:	f8c43023          	sd	a2,-128(s0)
    80001b80:	f8f40723          	sb	a5,-114(s0)
    80001b84:	f5842223          	sw	s8,-188(s0)
    80001b88:	f7143823          	sd	a7,-144(s0)
    80001b8c:	f7043c23          	sd	a6,-136(s0)
    80001b90:	f8d42423          	sw	a3,-120(s0)
    80001b94:	f8e41623          	sh	a4,-116(s0)
    80001b98:	f5742623          	sw	s7,-180(s0)
    80001b9c:	e4aff0ef          	jal	ra,800011e6 <Func_2>
    80001ba0:	f4442603          	lw	a2,-188(s0)
    80001ba4:	00153513          	seqz	a0,a0
    80001ba8:	00001797          	auipc	a5,0x1
    80001bac:	d0a7a623          	sw	a0,-756(a5) # 800028b4 <Bool_Glob>
    80001bb0:	02c94663          	blt	s2,a2,80001bdc <main+0x212>
    80001bb4:	0026179b          	slliw	a5,a2,0x2
    80001bb8:	9fb1                	addw	a5,a5,a2
    80001bba:	37f5                	addiw	a5,a5,-3
    80001bbc:	8532                	mv	a0,a2
    80001bbe:	458d                	li	a1,3
    80001bc0:	f4840613          	addi	a2,s0,-184
    80001bc4:	f4f42423          	sw	a5,-184(s0)
    80001bc8:	db0ff0ef          	jal	ra,80001178 <Proc_7>
    80001bcc:	f4442783          	lw	a5,-188(s0)
    80001bd0:	0017861b          	addiw	a2,a5,1
    80001bd4:	f4c42223          	sw	a2,-188(s0)
    80001bd8:	fcc95ee3          	ble	a2,s2,80001bb4 <main+0x1ea>
    80001bdc:	f4842683          	lw	a3,-184(s0)
    80001be0:	00001597          	auipc	a1,0x1
    80001be4:	db858593          	addi	a1,a1,-584 # 80002998 <Arr_2_Glob>
    80001be8:	85018513          	addi	a0,gp,-1968 # 800028d0 <Arr_1_Glob>
    80001bec:	d94ff0ef          	jal	ra,80001180 <Proc_8>
    80001bf0:	000d3503          	ld	a0,0(s10)
    80001bf4:	c9aff0ef          	jal	ra,8000108e <Proc_1>
    80001bf8:	0009c703          	lbu	a4,0(s3)
    80001bfc:	04000793          	li	a5,64
    80001c00:	44e7fe63          	bleu	a4,a5,8000205c <main+0x692>
    80001c04:	04100b13          	li	s6,65
    80001c08:	4d8d                	li	s11,3
    80001c0a:	a801                	j	80001c1a <main+0x250>
    80001c0c:	0009c783          	lbu	a5,0(s3)
    80001c10:	2b05                	addiw	s6,s6,1
    80001c12:	0ffb7b13          	andi	s6,s6,255
    80001c16:	0767e163          	bltu	a5,s6,80001c78 <main+0x2ae>
    80001c1a:	04300593          	li	a1,67
    80001c1e:	855a                	mv	a0,s6
    80001c20:	daaff0ef          	jal	ra,800011ca <Func_1>
    80001c24:	f4c42783          	lw	a5,-180(s0)
    80001c28:	2501                	sext.w	a0,a0
    80001c2a:	fea791e3          	bne	a5,a0,80001c0c <main+0x242>
    80001c2e:	f4c40593          	addi	a1,s0,-180
    80001c32:	4501                	li	a0,0
    80001c34:	dfcff0ef          	jal	ra,80001230 <Proc_6>
    80001c38:	01e4c783          	lbu	a5,30(s1)
    80001c3c:	6088                	ld	a0,0(s1)
    80001c3e:	648c                	ld	a1,8(s1)
    80001c40:	f8f40723          	sb	a5,-114(s0)
    80001c44:	6890                	ld	a2,16(s1)
    80001c46:	4c94                	lw	a3,24(s1)
    80001c48:	01c4d703          	lhu	a4,28(s1)
    80001c4c:	00001797          	auipc	a5,0x1
    80001c50:	c747a623          	sw	s4,-916(a5) # 800028b8 <Int_Glob>
    80001c54:	0009c783          	lbu	a5,0(s3)
    80001c58:	2b05                	addiw	s6,s6,1
    80001c5a:	f6a43823          	sd	a0,-144(s0)
    80001c5e:	f6b43c23          	sd	a1,-136(s0)
    80001c62:	f8c43023          	sd	a2,-128(s0)
    80001c66:	f8d42423          	sw	a3,-120(s0)
    80001c6a:	f8e41623          	sh	a4,-116(s0)
    80001c6e:	0ffb7b13          	andi	s6,s6,255
    80001c72:	8dd2                	mv	s11,s4
    80001c74:	fb67f3e3          	bleu	s6,a5,80001c1a <main+0x250>
    80001c78:	f4442783          	lw	a5,-188(s0)
    80001c7c:	f4842b03          	lw	s6,-184(s0)
    80001c80:	2a05                	addiw	s4,s4,1
    80001c82:	03b78dbb          	mulw	s11,a5,s11
    80001c86:	f4440513          	addi	a0,s0,-188
    80001c8a:	036dc73b          	divw	a4,s11,s6
    80001c8e:	f2e43c23          	sd	a4,-200(s0)
    80001c92:	f4e42223          	sw	a4,-188(s0)
    80001c96:	bb2ff0ef          	jal	ra,80001048 <Proc_2>
    80001c9a:	eb9a1de3          	bne	s4,s9,80001b54 <main+0x18a>
    80001c9e:	b00027f3          	csrr	a5,mcycle
    80001ca2:	4501                	li	a0,0
    80001ca4:	00001717          	auipc	a4,0x1
    80001ca8:	bef73a23          	sd	a5,-1036(a4) # 80002898 <End_Time>
    80001cac:	975ff0ef          	jal	ra,80001620 <setStats>
    80001cb0:	00001797          	auipc	a5,0x1
    80001cb4:	be878793          	addi	a5,a5,-1048 # 80002898 <End_Time>
    80001cb8:	00001717          	auipc	a4,0x1
    80001cbc:	be870713          	addi	a4,a4,-1048 # 800028a0 <Begin_Time>
    80001cc0:	6318                	ld	a4,0(a4)
    80001cc2:	639c                	ld	a5,0(a5)
    80001cc4:	8f99                	sub	a5,a5,a4
    80001cc6:	00001717          	auipc	a4,0x1
    80001cca:	bcf73523          	sd	a5,-1078(a4) # 80002890 <User_Time>
    80001cce:	38f05963          	blez	a5,80002060 <main+0x696>
    80001cd2:	4785                	li	a5,1
    80001cd4:	00001717          	auipc	a4,0x1
    80001cd8:	bcf72a23          	sw	a5,-1068(a4) # 800028a8 <Done>
    80001cdc:	00000517          	auipc	a0,0x0
    80001ce0:	52450513          	addi	a0,a0,1316 # 80002200 <main+0x836>
    80001ce4:	a67ff0ef          	jal	ra,8000174a <printf>
    80001ce8:	00000517          	auipc	a0,0x0
    80001cec:	67850513          	addi	a0,a0,1656 # 80002360 <main+0x996>
    80001cf0:	a5bff0ef          	jal	ra,8000174a <printf>
    80001cf4:	00001797          	auipc	a5,0x1
    80001cf8:	bc478793          	addi	a5,a5,-1084 # 800028b8 <Int_Glob>
    80001cfc:	438c                	lw	a1,0(a5)
    80001cfe:	00000517          	auipc	a0,0x0
    80001d02:	53a50513          	addi	a0,a0,1338 # 80002238 <main+0x86e>
    80001d06:	00001497          	auipc	s1,0x1
    80001d0a:	bba48493          	addi	s1,s1,-1094 # 800028c0 <Next_Ptr_Glob>
    80001d0e:	a3dff0ef          	jal	ra,8000174a <printf>
    80001d12:	4595                	li	a1,5
    80001d14:	00000517          	auipc	a0,0x0
    80001d18:	54450513          	addi	a0,a0,1348 # 80002258 <main+0x88e>
    80001d1c:	a2fff0ef          	jal	ra,8000174a <printf>
    80001d20:	00001797          	auipc	a5,0x1
    80001d24:	b9478793          	addi	a5,a5,-1132 # 800028b4 <Bool_Glob>
    80001d28:	438c                	lw	a1,0(a5)
    80001d2a:	00000517          	auipc	a0,0x0
    80001d2e:	54e50513          	addi	a0,a0,1358 # 80002278 <main+0x8ae>
    80001d32:	416d8b3b          	subw	s6,s11,s6
    80001d36:	a15ff0ef          	jal	ra,8000174a <printf>
    80001d3a:	4585                	li	a1,1
    80001d3c:	00000517          	auipc	a0,0x0
    80001d40:	51c50513          	addi	a0,a0,1308 # 80002258 <main+0x88e>
    80001d44:	a07ff0ef          	jal	ra,8000174a <printf>
    80001d48:	00001597          	auipc	a1,0x1
    80001d4c:	b695c583          	lbu	a1,-1175(a1) # 800028b1 <Ch_1_Glob>
    80001d50:	00000517          	auipc	a0,0x0
    80001d54:	54850513          	addi	a0,a0,1352 # 80002298 <main+0x8ce>
    80001d58:	9f3ff0ef          	jal	ra,8000174a <printf>
    80001d5c:	04100593          	li	a1,65
    80001d60:	00000517          	auipc	a0,0x0
    80001d64:	55850513          	addi	a0,a0,1368 # 800022b8 <main+0x8ee>
    80001d68:	9e3ff0ef          	jal	ra,8000174a <printf>
    80001d6c:	00001597          	auipc	a1,0x1
    80001d70:	b445c583          	lbu	a1,-1212(a1) # 800028b0 <Ch_2_Glob>
    80001d74:	00000517          	auipc	a0,0x0
    80001d78:	56450513          	addi	a0,a0,1380 # 800022d8 <main+0x90e>
    80001d7c:	9cfff0ef          	jal	ra,8000174a <printf>
    80001d80:	04200593          	li	a1,66
    80001d84:	00000517          	auipc	a0,0x0
    80001d88:	53450513          	addi	a0,a0,1332 # 800022b8 <main+0x8ee>
    80001d8c:	9bfff0ef          	jal	ra,8000174a <printf>
    80001d90:	85018793          	addi	a5,gp,-1968 # 800028d0 <Arr_1_Glob>
    80001d94:	538c                	lw	a1,32(a5)
    80001d96:	00000517          	auipc	a0,0x0
    80001d9a:	56250513          	addi	a0,a0,1378 # 800022f8 <main+0x92e>
    80001d9e:	9adff0ef          	jal	ra,8000174a <printf>
    80001da2:	459d                	li	a1,7
    80001da4:	00000517          	auipc	a0,0x0
    80001da8:	4b450513          	addi	a0,a0,1204 # 80002258 <main+0x88e>
    80001dac:	99fff0ef          	jal	ra,8000174a <printf>
    80001db0:	00001797          	auipc	a5,0x1
    80001db4:	be878793          	addi	a5,a5,-1048 # 80002998 <Arr_2_Glob>
    80001db8:	65c7a583          	lw	a1,1628(a5)
    80001dbc:	00000517          	auipc	a0,0x0
    80001dc0:	55c50513          	addi	a0,a0,1372 # 80002318 <main+0x94e>
    80001dc4:	987ff0ef          	jal	ra,8000174a <printf>
    80001dc8:	00000517          	auipc	a0,0x0
    80001dcc:	57050513          	addi	a0,a0,1392 # 80002338 <main+0x96e>
    80001dd0:	97bff0ef          	jal	ra,8000174a <printf>
    80001dd4:	00000517          	auipc	a0,0x0
    80001dd8:	59450513          	addi	a0,a0,1428 # 80002368 <main+0x99e>
    80001ddc:	96fff0ef          	jal	ra,8000174a <printf>
    80001de0:	000d3783          	ld	a5,0(s10)
    80001de4:	00000517          	auipc	a0,0x0
    80001de8:	59450513          	addi	a0,a0,1428 # 80002378 <main+0x9ae>
    80001dec:	638c                	ld	a1,0(a5)
    80001dee:	95dff0ef          	jal	ra,8000174a <printf>
    80001df2:	00000517          	auipc	a0,0x0
    80001df6:	5a650513          	addi	a0,a0,1446 # 80002398 <main+0x9ce>
    80001dfa:	951ff0ef          	jal	ra,8000174a <printf>
    80001dfe:	000d3783          	ld	a5,0(s10)
    80001e02:	00000517          	auipc	a0,0x0
    80001e06:	5ce50513          	addi	a0,a0,1486 # 800023d0 <main+0xa06>
    80001e0a:	478c                	lw	a1,8(a5)
    80001e0c:	93fff0ef          	jal	ra,8000174a <printf>
    80001e10:	4581                	li	a1,0
    80001e12:	00000517          	auipc	a0,0x0
    80001e16:	44650513          	addi	a0,a0,1094 # 80002258 <main+0x88e>
    80001e1a:	931ff0ef          	jal	ra,8000174a <printf>
    80001e1e:	000d3783          	ld	a5,0(s10)
    80001e22:	00000517          	auipc	a0,0x0
    80001e26:	5ce50513          	addi	a0,a0,1486 # 800023f0 <main+0xa26>
    80001e2a:	47cc                	lw	a1,12(a5)
    80001e2c:	91fff0ef          	jal	ra,8000174a <printf>
    80001e30:	4589                	li	a1,2
    80001e32:	00000517          	auipc	a0,0x0
    80001e36:	42650513          	addi	a0,a0,1062 # 80002258 <main+0x88e>
    80001e3a:	911ff0ef          	jal	ra,8000174a <printf>
    80001e3e:	000d3783          	ld	a5,0(s10)
    80001e42:	00000517          	auipc	a0,0x0
    80001e46:	5ce50513          	addi	a0,a0,1486 # 80002410 <main+0xa46>
    80001e4a:	4b8c                	lw	a1,16(a5)
    80001e4c:	8ffff0ef          	jal	ra,8000174a <printf>
    80001e50:	45c5                	li	a1,17
    80001e52:	00000517          	auipc	a0,0x0
    80001e56:	40650513          	addi	a0,a0,1030 # 80002258 <main+0x88e>
    80001e5a:	8f1ff0ef          	jal	ra,8000174a <printf>
    80001e5e:	000d3583          	ld	a1,0(s10)
    80001e62:	00000517          	auipc	a0,0x0
    80001e66:	5ce50513          	addi	a0,a0,1486 # 80002430 <main+0xa66>
    80001e6a:	05d1                	addi	a1,a1,20
    80001e6c:	8dfff0ef          	jal	ra,8000174a <printf>
    80001e70:	00000517          	auipc	a0,0x0
    80001e74:	5e050513          	addi	a0,a0,1504 # 80002450 <main+0xa86>
    80001e78:	8d3ff0ef          	jal	ra,8000174a <printf>
    80001e7c:	00000517          	auipc	a0,0x0
    80001e80:	60c50513          	addi	a0,a0,1548 # 80002488 <main+0xabe>
    80001e84:	8c7ff0ef          	jal	ra,8000174a <printf>
    80001e88:	609c                	ld	a5,0(s1)
    80001e8a:	00000517          	auipc	a0,0x0
    80001e8e:	4ee50513          	addi	a0,a0,1262 # 80002378 <main+0x9ae>
    80001e92:	638c                	ld	a1,0(a5)
    80001e94:	8b7ff0ef          	jal	ra,8000174a <printf>
    80001e98:	00000517          	auipc	a0,0x0
    80001e9c:	60850513          	addi	a0,a0,1544 # 800024a0 <main+0xad6>
    80001ea0:	8abff0ef          	jal	ra,8000174a <printf>
    80001ea4:	609c                	ld	a5,0(s1)
    80001ea6:	00000517          	auipc	a0,0x0
    80001eaa:	52a50513          	addi	a0,a0,1322 # 800023d0 <main+0xa06>
    80001eae:	478c                	lw	a1,8(a5)
    80001eb0:	89bff0ef          	jal	ra,8000174a <printf>
    80001eb4:	4581                	li	a1,0
    80001eb6:	00000517          	auipc	a0,0x0
    80001eba:	3a250513          	addi	a0,a0,930 # 80002258 <main+0x88e>
    80001ebe:	88dff0ef          	jal	ra,8000174a <printf>
    80001ec2:	609c                	ld	a5,0(s1)
    80001ec4:	00000517          	auipc	a0,0x0
    80001ec8:	52c50513          	addi	a0,a0,1324 # 800023f0 <main+0xa26>
    80001ecc:	47cc                	lw	a1,12(a5)
    80001ece:	87dff0ef          	jal	ra,8000174a <printf>
    80001ed2:	4585                	li	a1,1
    80001ed4:	00000517          	auipc	a0,0x0
    80001ed8:	38450513          	addi	a0,a0,900 # 80002258 <main+0x88e>
    80001edc:	86fff0ef          	jal	ra,8000174a <printf>
    80001ee0:	609c                	ld	a5,0(s1)
    80001ee2:	00000517          	auipc	a0,0x0
    80001ee6:	52e50513          	addi	a0,a0,1326 # 80002410 <main+0xa46>
    80001eea:	4b8c                	lw	a1,16(a5)
    80001eec:	85fff0ef          	jal	ra,8000174a <printf>
    80001ef0:	45c9                	li	a1,18
    80001ef2:	00000517          	auipc	a0,0x0
    80001ef6:	36650513          	addi	a0,a0,870 # 80002258 <main+0x88e>
    80001efa:	851ff0ef          	jal	ra,8000174a <printf>
    80001efe:	608c                	ld	a1,0(s1)
    80001f00:	00000517          	auipc	a0,0x0
    80001f04:	53050513          	addi	a0,a0,1328 # 80002430 <main+0xa66>
    80001f08:	05d1                	addi	a1,a1,20
    80001f0a:	841ff0ef          	jal	ra,8000174a <printf>
    80001f0e:	00000517          	auipc	a0,0x0
    80001f12:	54250513          	addi	a0,a0,1346 # 80002450 <main+0xa86>
    80001f16:	835ff0ef          	jal	ra,8000174a <printf>
    80001f1a:	f4442583          	lw	a1,-188(s0)
    80001f1e:	00000517          	auipc	a0,0x0
    80001f22:	5c250513          	addi	a0,a0,1474 # 800024e0 <main+0xb16>
    80001f26:	825ff0ef          	jal	ra,8000174a <printf>
    80001f2a:	4595                	li	a1,5
    80001f2c:	00000517          	auipc	a0,0x0
    80001f30:	32c50513          	addi	a0,a0,812 # 80002258 <main+0x88e>
    80001f34:	817ff0ef          	jal	ra,8000174a <printf>
    80001f38:	003b179b          	slliw	a5,s6,0x3
    80001f3c:	41678b3b          	subw	s6,a5,s6
    80001f40:	f3843783          	ld	a5,-200(s0)
    80001f44:	00000517          	auipc	a0,0x0
    80001f48:	5bc50513          	addi	a0,a0,1468 # 80002500 <main+0xb36>
    80001f4c:	40fb05bb          	subw	a1,s6,a5
    80001f50:	ffaff0ef          	jal	ra,8000174a <printf>
    80001f54:	45b5                	li	a1,13
    80001f56:	00000517          	auipc	a0,0x0
    80001f5a:	30250513          	addi	a0,a0,770 # 80002258 <main+0x88e>
    80001f5e:	fecff0ef          	jal	ra,8000174a <printf>
    80001f62:	f4842583          	lw	a1,-184(s0)
    80001f66:	00000517          	auipc	a0,0x0
    80001f6a:	5ba50513          	addi	a0,a0,1466 # 80002520 <main+0xb56>
    80001f6e:	fdcff0ef          	jal	ra,8000174a <printf>
    80001f72:	459d                	li	a1,7
    80001f74:	00000517          	auipc	a0,0x0
    80001f78:	2e450513          	addi	a0,a0,740 # 80002258 <main+0x88e>
    80001f7c:	fceff0ef          	jal	ra,8000174a <printf>
    80001f80:	f4c42583          	lw	a1,-180(s0)
    80001f84:	00000517          	auipc	a0,0x0
    80001f88:	5bc50513          	addi	a0,a0,1468 # 80002540 <main+0xb76>
    80001f8c:	fbeff0ef          	jal	ra,8000174a <printf>
    80001f90:	4585                	li	a1,1
    80001f92:	00000517          	auipc	a0,0x0
    80001f96:	2c650513          	addi	a0,a0,710 # 80002258 <main+0x88e>
    80001f9a:	fb0ff0ef          	jal	ra,8000174a <printf>
    80001f9e:	f5040593          	addi	a1,s0,-176
    80001fa2:	00000517          	auipc	a0,0x0
    80001fa6:	5be50513          	addi	a0,a0,1470 # 80002560 <main+0xb96>
    80001faa:	fa0ff0ef          	jal	ra,8000174a <printf>
    80001fae:	00000517          	auipc	a0,0x0
    80001fb2:	5d250513          	addi	a0,a0,1490 # 80002580 <main+0xbb6>
    80001fb6:	f94ff0ef          	jal	ra,8000174a <printf>
    80001fba:	f7040593          	addi	a1,s0,-144
    80001fbe:	00000517          	auipc	a0,0x0
    80001fc2:	5fa50513          	addi	a0,a0,1530 # 800025b8 <main+0xbee>
    80001fc6:	f84ff0ef          	jal	ra,8000174a <printf>
    80001fca:	00000517          	auipc	a0,0x0
    80001fce:	60e50513          	addi	a0,a0,1550 # 800025d8 <main+0xc0e>
    80001fd2:	f78ff0ef          	jal	ra,8000174a <printf>
    80001fd6:	00000517          	auipc	a0,0x0
    80001fda:	38a50513          	addi	a0,a0,906 # 80002360 <main+0x996>
    80001fde:	f6cff0ef          	jal	ra,8000174a <printf>
    80001fe2:	f3043603          	ld	a2,-208(s0)
    80001fe6:	000f4737          	lui	a4,0xf4
    80001fea:	2407071b          	addiw	a4,a4,576
    80001fee:	02c7073b          	mulw	a4,a4,a2
    80001ff2:	00001797          	auipc	a5,0x1
    80001ff6:	89e78793          	addi	a5,a5,-1890 # 80002890 <User_Time>
    80001ffa:	6394                	ld	a3,0(a5)
    80001ffc:	00000517          	auipc	a0,0x0
    80002000:	61450513          	addi	a0,a0,1556 # 80002610 <main+0xc46>
    80002004:	02c6c7b3          	div	a5,a3,a2
    80002008:	02d74733          	div	a4,a4,a3
    8000200c:	85be                	mv	a1,a5
    8000200e:	00001697          	auipc	a3,0x1
    80002012:	86f6bd23          	sd	a5,-1926(a3) # 80002888 <Microseconds>
    80002016:	00001797          	auipc	a5,0x1
    8000201a:	86e7b523          	sd	a4,-1942(a5) # 80002880 <Dhrystones_Per_Second>
    8000201e:	f2cff0ef          	jal	ra,8000174a <printf>
    80002022:	00001797          	auipc	a5,0x1
    80002026:	85e78793          	addi	a5,a5,-1954 # 80002880 <Dhrystones_Per_Second>
    8000202a:	638c                	ld	a1,0(a5)
    8000202c:	00000517          	auipc	a0,0x0
    80002030:	61c50513          	addi	a0,a0,1564 # 80002648 <main+0xc7e>
    80002034:	f16ff0ef          	jal	ra,8000174a <printf>
    80002038:	f3040113          	addi	sp,s0,-208
    8000203c:	60ae                	ld	ra,200(sp)
    8000203e:	4501                	li	a0,0
    80002040:	640e                	ld	s0,192(sp)
    80002042:	74ea                	ld	s1,184(sp)
    80002044:	794a                	ld	s2,176(sp)
    80002046:	79aa                	ld	s3,168(sp)
    80002048:	7a0a                	ld	s4,160(sp)
    8000204a:	6aea                	ld	s5,152(sp)
    8000204c:	6b4a                	ld	s6,144(sp)
    8000204e:	6baa                	ld	s7,136(sp)
    80002050:	6c0a                	ld	s8,128(sp)
    80002052:	7ce6                	ld	s9,120(sp)
    80002054:	7d46                	ld	s10,112(sp)
    80002056:	7da6                	ld	s11,104(sp)
    80002058:	6169                	addi	sp,sp,208
    8000205a:	8082                	ret
    8000205c:	4d8d                	li	s11,3
    8000205e:	b929                	j	80001c78 <main+0x2ae>
    80002060:	00000517          	auipc	a0,0x0
    80002064:	16850513          	addi	a0,a0,360 # 800021c8 <main+0x7fe>
    80002068:	ee2ff0ef          	jal	ra,8000174a <printf>
    8000206c:	f3043703          	ld	a4,-208(s0)
    80002070:	00000517          	auipc	a0,0x0
    80002074:	2f050513          	addi	a0,a0,752 # 80002360 <main+0x996>
    80002078:	0027179b          	slliw	a5,a4,0x2
    8000207c:	9fb9                	addw	a5,a5,a4
    8000207e:	0017979b          	slliw	a5,a5,0x1
    80002082:	f2f43823          	sd	a5,-208(s0)
    80002086:	ec4ff0ef          	jal	ra,8000174a <printf>
    8000208a:	00001797          	auipc	a5,0x1
    8000208e:	81e78793          	addi	a5,a5,-2018 # 800028a8 <Done>
    80002092:	439c                	lw	a5,0(a5)
    80002094:	a80788e3          	beqz	a5,80001b24 <main+0x15a>
    80002098:	b191                	j	80001cdc <main+0x312>
    8000209a:	00000517          	auipc	a0,0x0
    8000209e:	0ae50513          	addi	a0,a0,174 # 80002148 <main+0x77e>
    800020a2:	ea8ff0ef          	jal	ra,8000174a <printf>
    800020a6:	b42d                	j	80001ad0 <main+0x106>
    800020a8:	1141                	addi	sp,sp,-16
    800020aa:	00000517          	auipc	a0,0x0
    800020ae:	65650513          	addi	a0,a0,1622 # 80002700 <main+0xd36>
    800020b2:	e406                	sd	ra,8(sp)
    800020b4:	df2ff0ef          	jal	ra,800016a6 <printstr>
    800020b8:	60a2                	ld	ra,8(sp)
    800020ba:	557d                	li	a0,-1
    800020bc:	0141                	addi	sp,sp,16
    800020be:	8082                	ret
