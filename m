Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB17622419
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 07:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKIGuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 01:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKIGuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 01:50:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3217423;
        Tue,  8 Nov 2022 22:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CF837CE1D14;
        Wed,  9 Nov 2022 06:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA54C433C1;
        Wed,  9 Nov 2022 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667976609;
        bh=ut7EzIUNIiE0yhwgdV7ZbRJKon0eflJ3Fbn5UHXoL04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TMNa28F5RRTMFGUaIb/uf6YrbkzsOwFQK8PGvRMUQ9xyrB9/PuUT9ztiKteYlIM2r
         JC3eJrbZoUguf6W7EPJaY6zTNH83U6UY9BO6o932xt14lvKbh6uT9k+Q2nh5lwAcSo
         cb6vXzzkKiqqUVNgkZBru/VUoh+Dkff6049EZ3xDzChiRDGwG+ac5tKbDNJoM/72Aj
         PNCz/PMJh6y9xCF7FfR6CBOPbaNsnlFmy+xkbs9a9P/lT6vA0NK8J/8Dex2oZgKPqu
         nuR9B2r8wqaAHjkKyvg035wpt9Oj1y7dryM6AGVBWoUBeFzqMCN+WC+9nEUPRJnMqd
         AnsobWmxO0v3w==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, peterz@infradead.org,
        arnd@arndb.de, linux-arch@vger.kernel.org, keescook@chromium.org,
        paulmck@kernel.org, frederic@kernel.org, nsaenzju@redhat.com,
        changbin.du@intel.com, vincent.chen@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 2/2] riscv: stacktrace: Make walk_stackframe cross pt_regs frame
Date:   Wed,  9 Nov 2022 01:49:37 -0500
Message-Id: <20221109064937.3643993-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221109064937.3643993-1-guoren@kernel.org>
References: <20221109064937.3643993-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The current walk_stackframe with FRAME_POINTER would stop unwinding at
ret_from_exception:
  BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1518
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: init
  CPU: 0 PID: 1 Comm: init Not tainted 5.10.113-00021-g15c15974895c-dirty #192
  Call Trace:
  [<ffffffe0002038c8>] walk_stackframe+0x0/0xee
  [<ffffffe000aecf48>] show_stack+0x32/0x4a
  [<ffffffe000af1618>] dump_stack_lvl+0x72/0x8e
  [<ffffffe000af1648>] dump_stack+0x14/0x1c
  [<ffffffe000239ad2>] ___might_sleep+0x12e/0x138
  [<ffffffe000239aec>] __might_sleep+0x10/0x18
  [<ffffffe000afe3fe>] down_read+0x22/0xa4
  [<ffffffe000207588>] do_page_fault+0xb0/0x2fe
  [<ffffffe000201b80>] ret_from_exception+0x0/0xc

The optimization would help walk_stackframe cross the pt_regs frame and
get more backtrace of debug info:
  BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1518
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: init
  CPU: 0 PID: 1 Comm: init Not tainted 5.10.113-00021-g15c15974895c-dirty #192
  Call Trace:
  [<ffffffe0002038c8>] walk_stackframe+0x0/0xee
  [<ffffffe000aecf48>] show_stack+0x32/0x4a
  [<ffffffe000af1618>] dump_stack_lvl+0x72/0x8e
  [<ffffffe000af1648>] dump_stack+0x14/0x1c
  [<ffffffe000239ad2>] ___might_sleep+0x12e/0x138
  [<ffffffe000239aec>] __might_sleep+0x10/0x18
  [<ffffffe000afe3fe>] down_read+0x22/0xa4
  [<ffffffe000207588>] do_page_fault+0xb0/0x2fe
  [<ffffffe000201b80>] ret_from_exception+0x0/0xc
  [<ffffffe000613c06>] riscv_intc_irq+0x1a/0x72
  [<ffffffe000201b80>] ret_from_exception+0x0/0xc
  [<ffffffe00033f44a>] vma_link+0x54/0x160
  [<ffffffe000341d7a>] mmap_region+0x2cc/0x4d0
  [<ffffffe000342256>] do_mmap+0x2d8/0x3ac
  [<ffffffe000326318>] vm_mmap_pgoff+0x70/0xb8
  [<ffffffe00032638a>] vm_mmap+0x2a/0x36
  [<ffffffe0003cfdde>] elf_map+0x72/0x84
  [<ffffffe0003d05f8>] load_elf_binary+0x69a/0xec8
  [<ffffffe000376240>] bprm_execve+0x246/0x53a
  [<ffffffe00037786c>] kernel_execve+0xe8/0x124
  [<ffffffe000aecdf2>] run_init_process+0xfa/0x10c
  [<ffffffe000aece16>] try_to_run_init_process+0x12/0x3c
  [<ffffffe000afa920>] kernel_init+0xb4/0xf8
  [<ffffffe000201b80>] ret_from_exception+0x0/0xc

Here is the error injection test code for the above output:
 drivers/irqchip/irq-riscv-intc.c:
 static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
        unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
+       u32 tmp; __get_user(tmp, (u32 *)0);

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Changbin Du <changbin.du@intel.com>
---
 arch/riscv/kernel/entry.S      | 2 +-
 arch/riscv/kernel/stacktrace.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b9eda3fcbd6d..329cf51fcd4d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -248,7 +248,7 @@ ret_from_syscall_rejected:
 	andi t0, t0, _TIF_SYSCALL_WORK
 	bnez t0, handle_syscall_trace_exit
 
-ret_from_exception:
+ENTRY(ret_from_exception)
 	REG_L s0, PT_STATUS(sp)
 	csrc CSR_STATUS, SR_IE
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index bcfe9eb55f80..75c8dd64fc48 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,6 +16,8 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
+extern asmlinkage void ret_from_exception(void);
+
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
@@ -59,6 +61,13 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 						   &frame->ra);
+			if (pc == (unsigned long)ret_from_exception) {
+				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
+					break;
+
+				pc = ((struct pt_regs *)sp)->epc;
+				fp = ((struct pt_regs *)sp)->s0;
+			}
 		}
 
 	}
-- 
2.36.1

