Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785EF5B127A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 04:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIHC0O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 22:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIHCZt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 22:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FD7C745;
        Wed,  7 Sep 2022 19:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D561261B38;
        Thu,  8 Sep 2022 02:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F4BC43140;
        Thu,  8 Sep 2022 02:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662603946;
        bh=Zb4Hmj1kW5/CGOJFKVCs2eG+dRN6j+fP3pwPcfq9g0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8r0hlT8FWO5Nzf8Ijp2K2cTeilQoFMTldBS5lav+XQSaLfxad35Fsk0x9ZLWKHEN
         fudyy9O45Z3xyvNmIwT41rM0HnK88WfiAsf1hWI7j1lESkcXJJQPaU7xpoBj4Y2iGh
         0ilK188HSkvCU0Wsx5VJqYnTrv0NSKCIJPor4mTOwl/ZFLP5q5kouw0KIn62qZdfki
         FYCsMi5LHl+iDotRAufAIm0phsu5owUzMsnNjXo4KZ50NbgoLRR1KGhUZlgCbuQoza
         M+Z2/eDeT2fAgKhwHcORss7aAczA/5lkLWiXJSiRG/2XV4UqXkbNVTo1XMImCV+W0f
         cD/gv0WLWFaIA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 4/8] riscv: traps: Add noinstr to prevent instrumentation inserted
Date:   Wed,  7 Sep 2022 22:25:02 -0400
Message-Id: <20220908022506.1275799-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220908022506.1275799-1-guoren@kernel.org>
References: <20220908022506.1275799-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Without noinstr the compiler is free to insert instrumentation (think
all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
yet ready to run this early in the entry path, for instance it could
rely on RCU which isn't on yet, or expect lockdep state. (by peterz)

Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/raw
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/traps.c | 8 ++++----
 arch/riscv/mm/fault.c     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 635e6ec26938..3ed3dbec250d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -97,7 +97,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #define __trap_section
 #endif
 #define DO_ERROR_INFO(name, signo, code, str)				\
-asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
+asmlinkage __visible __trap_section void noinstr name(struct pt_regs *regs)	\
 {									\
 	do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 }
@@ -121,7 +121,7 @@ DO_ERROR_INFO(do_trap_store_misaligned,
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
 
-asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs *regs)
+asmlinkage __trap_section void noinstr do_trap_load_misaligned(struct pt_regs *regs)
 {
 	if (!handle_misaligned_load(regs))
 		return;
@@ -129,7 +129,7 @@ asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs *regs)
 		      "Oops - load address misaligned");
 }
 
-asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs *regs)
+asmlinkage __trap_section void noinstr do_trap_store_misaligned(struct pt_regs *regs)
 {
 	if (!handle_misaligned_store(regs))
 		return;
@@ -156,7 +156,7 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return GET_INSN_LENGTH(insn);
 }
 
-asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
+asmlinkage __visible __trap_section void noinstr do_trap_break(struct pt_regs *regs)
 {
 #ifdef CONFIG_KPROBES
 	if (kprobe_single_step_handler(regs))
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index f2fbd1400b7c..c7829289e806 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -203,7 +203,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
  */
-asmlinkage void do_page_fault(struct pt_regs *regs)
+asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
 {
 	struct task_struct *tsk;
 	struct vm_area_struct *vma;
-- 
2.36.1

