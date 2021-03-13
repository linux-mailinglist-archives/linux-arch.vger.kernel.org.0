Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD278339C64
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 07:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhCMGmu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 01:42:50 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42724 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232431AbhCMGmi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Mar 2021 01:42:38 -0500
Received: from localhost.localdomain (unknown [222.209.9.50])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGda4XkxgjLUYAA--.9506S2;
        Sat, 13 Mar 2021 14:42:06 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH V2]: add DYNAMC_FTRACE_WITH_REGS and
Date:   Sat, 13 Mar 2021 14:41:43 +0800
Message-Id: <20210313064149.29276-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxGda4XkxgjLUYAA--.9506S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Gw4xKF1kur45CF4UArb_yoWrZrW3pF
        W3ZrnIvr48JrZ0kr4jvrW5Zr1SgrW5CrWDuFn5Gr1rA3Z0kF4Syw18G3W8XrW7GrykArWj
        qF1jkrykuFyDJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JU3HUDUUUUU=
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

V2:
+. fix ftrace regs test failure

+. fix kprobe test failure with adding KPROBES_ON_FTRACE


This series add DYNAMC_FTRACE_WITH_REGS and KPROBES_ON_FTRACE support 
without depending on _mcount and -pg, and try to address following issue

+. _mcount stub size is 3 insns in vmlinux  and  4 insns in .ko, too much

+. complex handing MIPS32 and MIPS64 in _mcount, especially sp pointer in
MIPS32

+. stub is called with sp adjusted in Callee(the traced function), which
is hard for livepatch to restore the original sp pointer

Remaining Issues
################

+. reserve three nops or four nops for <= MIPS R5 ?

Without direct call, three nops is enough. With direct call, we need to 
hack ftrace to save the first instruction somewhere. Four nops is enough 
for all cases

MIPS R6 only need three nops without hacking

+. MIPS32 support, working on it

+. checking for gcc version, can previous two bug back porting to gcc 8.5?
We should check gcc's version

+. stack backstrace

GCC
#########

+. GCC 8 add -fpatchable-function-entry=N[, M] support to insert N 
nops before real start, for more info, see gcc 8 manual

+. GCC/MIPS has two bug: 93242 (fixed in gcc 10), 99217 (with a fix, but
not accepted) about this option. With fixes applyed in gcc 8.3, vmlinux is OK


Design
#########

+. Caller A calls Callee B, with -fpatchable-function-entry=3, B has 
three nops at its entry,

------------
	::

		A:

		......
			jal	B
			nop
		......

		B:
			nop
			nop
			nop

		#B: real start 
			INSN_B_first

+. With ftrace initialized or module loaded, this three nop got
replaced,

------------
	::

		A:

		......
			jal	B
			nop
		......

		B:
			lui	at, %hi(ftrace_regs_caller)
			nop
			li	t0, 0

		#B: real start 
			INSN_B_first

Obviously, ftrace_regs_caller is 64KB aligned, thanks He Jinyang
<hejinyang@loongson.cn>
	
+. To enable tracing , take nop into "jalr at, at“, 

PS: 

"jalr at, at" jump and link into addr in "at", and save the return address
in "at";

With this, no touching parent return address in ra

------------
	::

		A:

		......
			jal	B
			nop
		......

		B:
			lui	at, %hi(ftrace_regs_caller)
			jalr	at, at
			li	t0, 0

		#B: real start 
			INSN_B_first
	

+. To disable tracing, take "jalr at, at" into nop

------------
	::

		A:
		......

			jal	B
			nop
		......

		B:
			lui	at, %hi(ftrace_regs_caller)
			nop
			li	t0, 0

		#B: real start 
			INSN_B_first
	
+. when tracing without regs, replace "li t0, 0' with "li t0, 1"

------------
	::

		A:
		......

			jal	B
			nop
		......
		B:
			lui	at, %hi(ftrace_regs_caller)
			jalr	at, at
			li	t0, 1
		#B: real start 
			INSN_B_first

With only one instruction modified, it is atomic and no sync needed (
_mcount need sync between two writes) on both MIPS32 and MIPS64, I got 
this from ARM64.

we need transfrom from tracing disabled into tracing without regs, first
replace "li t0, 0" with "li t0, 1", then "nop" with "jalr at, at", still
no sync between

------------
	::

		A:

		......
			jal	B
			nop
		......
		B:
			lui	at, %hi(ftrace_regs_caller)
			jalr	at, at
			li	t0, 1

		#B: real start 
			INSN_B_first


PS:

In mcount-based ftrace of MIPS32 vmlinux, the _mcount calling sequence
like this:

------------
	::

		A:
		......

			jal	B
			nop
		......
		B:
			move	at, ra
			jal	_mcount
			addiu	sp, sp, -32
		#B: real start 
			INSN_B_first

------------
	::

		A:
		......

			jal	B
			nop
		......
		B:
			move	at, ra
			nop
			nop
		#B: real start 
			INSN_B_first

no matter disabing and enabling tracing, we can not atomically change
both "jalr" and "addiu"(sync does not help here), on MIP32/SMP, whether
this 

------------
	::

		A:

		......
			jal	B
			nop
		......
		B:
			move	at, ra
			nop
			addiu	sp, sp, -32
		#B: real start 
			INSN_B_first

or this

------------
	::

		A:
		......
			jal	B
			nop
		......
		B:
			move	at, ra
			nop
			addiu	sp, sp, -32
		#B: real start 
			INSN_B_first

would wreck the ftrace

+. When B is ok to be patched, replace first four instruction with new 
function B'

------------
	::

		A:
		......
			jal	B
			nop
		......
		B:
			lui	at, %hi(B')	// second, fill new B'high
			addiu	at, %lo(B')	// first, fill nop
						// third, fill new B' low
			jr	at		// at last, fill jr
		#B: real start 
			nop			//forth, fill nop
						//Watch Out! 
						//first instruction 
						// clobbered. we
						//need to save it somewhere
						//or we must use four nops

if tracing enabled, we need to disable tracing first, and we need sync 
before fill "jr"
	
***Or use 4 nops for stub***

Patches
###########

Patch 1 - Patch 3 

This prepares new MIPS/ftrace with DYNAMIC_FTRACE_WITH_REGS and KPROBES_ON_FTACE 
in parallel with old MIPS/Ftrace 

NO function changed, these three patches can be merge into one patch


Patch 4 - Patch 5

this is needed for all RISC


Patch 6

Add DYNAMC_FTRACE_WITH_REGS and KPROBES_ON_FTACE support 



