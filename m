Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0D32E623
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhCEKUk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:20:40 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49264 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229709AbhCEKUX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 05:20:23 -0500
Received: from localhost.localdomain (unknown [182.149.161.105])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9fCBUJgPcwUAA--.6604S2;
        Fri, 05 Mar 2021 18:19:51 +0800 (CST)
From:   Huang Pei <huangpei@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC]: MIPS: new ftrace implementation
Date:   Fri,  5 Mar 2021 18:19:29 +0800
Message-Id: <20210305101933.9799-1-huangpei@loongson.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxr9fCBUJgPcwUAA--.6604S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UWw1rKF4fuFyfZF4kCrg_yoW5Zw1DpF
        W3XwnFqr48X3yqkr1jv3y5Zr1Sgry5CrZ7uFn5Gw1rJ3Z8CF4Sya48Wa18X347Gr9xArWj
        vF1j9ryUuFW5Kw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series add DYNAMC_FTRACE_WITH_REGS support without depending _mcount
and -pg, and try to address following issue

+. _mcount stub size is 3 insns in vmlinux  and  4 insns in .ko, too much

+. complex handing MIPS32 and MIPS64 in _mcount, especially sp pointer in
MIPS32

+. _mcount is called with sp adjusted in Callee(the traced function), which
is hard for livepatch to restore the sp pointer


GCC
#########

+. gcc 8 add -fpatchable-function-entry=N[, M] support to insert N 
nops before real start, for more info, see gcc 8 manual

+. gcc/mips has two bug: 93242 (fixed in gcc 10), 99217 (with a fix, but
not accepted) about this option. With fixes applyed in gcc 8.3, vmlinux is OK


Design
#########

+. Caller A calls Callee B, with -fpatchable-function-entry=3, B has 
three nops at its entry

------------
	::

		A:

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

------------
	::

		A:

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

			jal	B
			nop
		......
		B:
			lui	at, %hi(ftrace_regs_caller)
			jalr	at, at
			li	t0, 1

		#B: real start 
			INSN_B_first

+. When B is ok to be patched, replace first four instruction with new 
function B'

------------
	::

		A:

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
	
Patches
###########

Patch 1 - Patch 3 

This make new MIPS/ftrace with DYNAMIC_FTRACE_WITH_REGS in parallel with 
old MIPS/Ftrace 

Patch 4

Add DYNAMC_FTRACE_WITH_REGS support 

Remaining Issues
################

+. reserve three nops or four nops for <= MIPS R5 ?

Without direct call, three nops is enough. With direct call, we need to 
hack ftrace to save the first instruction somewhere. Four nops is enough 
for all cases

MIPS R6 only need three nops without hacking, but this version does not
support MIPS R6

+. MIPS32 support, working on it

+. checking for gcc version, can previous two bug back porting to gcc 8.5?
We should check gcc's version

+. stack backstrace


