Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29D55ABFCB
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiICQYO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiICQYF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 12:24:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D33DBE8;
        Sat,  3 Sep 2022 09:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A5B39CE0494;
        Sat,  3 Sep 2022 16:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F72C433B5;
        Sat,  3 Sep 2022 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662222240;
        bh=cGpgA7bsAcBu9cM5k7EvryK/rECLcgu+ArqhQVWAdzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNT4uPAZzNgEikgI4Tv1F4v0oQtzH4tIjUhl/cJA/YVa6QRSRGDxTafbzszqINzUO
         tqsJihurGXByqEToL7OKYmvozHPC85pvH3OQ1ING+FLiyj8b29mWczHjOq3aok7IkK
         DnRiBGkzL1WjZ89jCx75dHqWGZatw84FR+Lh/kUIHPU58dRmpHYk0TJz5CIC3Mk5sD
         WY2rx5GYBukKbAeCm3PA2k+xx+p2jUXmRBBV/ilo2d0myUtNurY7VwSvd8kYBq1QVD
         bx9p/H6H1CFsRm+JgTcXArsNNteVqQKa5G28zWPlO5IMZLUskgFw+9hPGGv3Ar+mnv
         Jfp80Mx78OLKw==
From:   guoren@kernel.org
To:     oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
        monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
        davem@davemloft.net, arnd@arndb.de, shorne@gmail.com,
        guoren@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 3/3] arch: ptrace: Cleanup ptrace_disable
Date:   Sat,  3 Sep 2022 12:23:27 -0400
Message-Id: <20220903162328.1952477-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220903162328.1952477-1-guoren@kernel.org>
References: <20220903162328.1952477-1-guoren@kernel.org>
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

Add a weak empty function in common and remove architectures' duplicated
ones.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/arc/kernel/ptrace.c        |  4 ----
 arch/arm/kernel/ptrace.c        |  8 --------
 arch/microblaze/kernel/ptrace.c |  5 -----
 arch/nios2/kernel/ptrace.c      |  5 -----
 arch/riscv/kernel/ptrace.c      |  4 ----
 arch/sparc/kernel/ptrace_32.c   | 10 ----------
 arch/sparc/kernel/ptrace_64.c   | 10 ----------
 kernel/ptrace.c                 |  8 ++++++++
 8 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index da7542cea0d8..c227e145fede 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -317,10 +317,6 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &user_arc_view;
 }
 
-void ptrace_disable(struct task_struct *child)
-{
-}
-
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index bfe88c6e60d5..b85f5bdc56ef 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -186,14 +186,6 @@ put_user_reg(struct task_struct *task, int offset, long data)
 	return ret;
 }
 
-/*
- * Called by kernel/ptrace.c when detaching..
- */
-void ptrace_disable(struct task_struct *child)
-{
-	/* Nothing to do. */
-}
-
 /*
  * Handle hitting a breakpoint.
  */
diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 5234d0c1dcaa..72e3eece72aa 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -162,8 +162,3 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
 		ptrace_report_syscall_exit(regs, step);
 }
-
-void ptrace_disable(struct task_struct *child)
-{
-	/* nothing to do */
-}
diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
index cd62f310778b..de5f4199c45f 100644
--- a/arch/nios2/kernel/ptrace.c
+++ b/arch/nios2/kernel/ptrace.c
@@ -117,11 +117,6 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &nios2_user_view;
 }
 
-void ptrace_disable(struct task_struct *child)
-{
-
-}
-
 long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
 		 unsigned long data)
 {
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 44f4b1ca315d..19e4d8057e24 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -210,10 +210,6 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
 		return 0;
 }
 
-void ptrace_disable(struct task_struct *child)
-{
-}
-
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index e7db48acb838..f6df84e12739 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -29,16 +29,6 @@
 
 /* #define ALLOW_INIT_TRACING */
 
-/*
- * Called by kernel/ptrace.c when detaching..
- *
- * Make sure single step bits etc are not set.
- */
-void ptrace_disable(struct task_struct *child)
-{
-	/* nothing to do */
-}
-
 enum sparc_regset {
 	REGSET_GENERAL,
 	REGSET_FP,
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 86a7eb5c27ba..b20a16ebe533 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -83,16 +83,6 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_END,
 };
 
-/*
- * Called by kernel/ptrace.c when detaching..
- *
- * Make sure single step bits etc are not set.
- */
-void ptrace_disable(struct task_struct *child)
-{
-	/* nothing to do */
-}
-
 /* To get the necessary page struct, access_process_vm() first calls
  * get_user_pages().  This has done a flush_dcache_page() on the
  * accessed page.  Then our caller (copy_{to,from}_user_page()) did
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 1893d909e45c..77299bb65d97 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -579,6 +579,14 @@ static bool __ptrace_detach(struct task_struct *tracer, struct task_struct *p)
 	return dead;
 }
 
+__weak void ptrace_disable(struct task_struct *child)
+{
+	/*
+	 * Nothing to do.., some architectures would replace it with
+	 * their own function.
+	 */
+}
+
 static int ptrace_detach(struct task_struct *child, unsigned int data)
 {
 	if (!valid_signal(data))
-- 
2.36.1

