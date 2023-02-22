Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD92A69ED83
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 04:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBVDcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 22:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjBVDcK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 22:32:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CE735264;
        Tue, 21 Feb 2023 19:31:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF0F3B811CC;
        Wed, 22 Feb 2023 03:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59BEC433A4;
        Wed, 22 Feb 2023 03:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677036689;
        bh=NZL7k5T/gq/CBdcI/CQC/x9NElRVpSMRhseuithZiTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaHIiiao0dVo9Olz4EIBjJKFW4ZTyh9RGZa4YlHKMoBLI7cqLFl08A+EVcUPKRjH8
         A5KevupFGLOPH1wcg7tKvs4+sZB4Ub721zuxitBP3QQTv6qHHb1I0Z+ddwhRKBBDop
         H3qROuzNuxkifnGmGfHPxXjPtW0Y6ckK5/i09yEi7nz7smvKFkQSxaUVGymVcEfrGZ
         7GbQt/2WxGtbPmI0qQVwv6myajx2dA0s0MkW7Ny8rVLAs3ECa7yDbPHbh8/ZOnTFQp
         4A2yqi1xGS5dRimJOZ8CYhM09XfcI+AqJ9xx7yIcsW4Vsy1lmrUTdeHp2dwAUj+Hny
         xImOhU51aeyBg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org,
        palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V17 6/7] riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork
Date:   Tue, 21 Feb 2023 22:30:20 -0500
Message-Id: <20230222033021.983168-7-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230222033021.983168-1-guoren@kernel.org>
References: <20230222033021.983168-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
the only difference is whether call the fn(arg) or not, this can be
achieved by testing fn is NULL or not, I.E s0 is 0 or not. Many
architectures have done the same thing, it makes entry.S more clean.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/entry.S   | 12 +++---------
 arch/riscv/kernel/process.c |  5 ++---
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index bc322f92ba34..5ccef259498d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -132,7 +132,6 @@ SYM_CODE_END(handle_exception)
  * caller list:
  *  - handle_exception
  *  - ret_from_fork
- *  - ret_from_kernel_thread
  */
 SYM_CODE_START_NOALIGN(ret_from_exception)
 	REG_L s0, PT_STATUS(sp)
@@ -334,20 +333,15 @@ SYM_CODE_END(handle_kernel_stack_overflow)
 
 SYM_CODE_START(ret_from_fork)
 	call schedule_tail
-	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
-	tail syscall_exit_to_user_mode
-SYM_CODE_END(ret_from_fork)
-
-SYM_CODE_START(ret_from_kernel_thread)
-	call schedule_tail
+	beqz s0, 1f	/* not from kernel thread */
 	/* Call fn(arg) */
 	move a0, s1
 	jalr s0
+1:
 	move a0, sp /* pt_regs */
 	la ra, ret_from_exception
 	tail syscall_exit_to_user_mode
-SYM_CODE_END(ret_from_kernel_thread)
+SYM_CODE_END(ret_from_fork)
 
 /*
  * Integer register context switch
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 8955f2432c2d..46806d5d10fa 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -34,7 +34,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
 extern asmlinkage void ret_from_fork(void);
-extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
@@ -174,7 +173,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 
-		p->thread.ra = (unsigned long)ret_from_kernel_thread;
 		p->thread.s[0] = (unsigned long)args->fn;
 		p->thread.s[1] = (unsigned long)args->fn_arg;
 	} else {
@@ -184,8 +182,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		if (clone_flags & CLONE_SETTLS)
 			childregs->tp = tls;
 		childregs->a0 = 0; /* Return value of fork() */
-		p->thread.ra = (unsigned long)ret_from_fork;
+		p->thread.s[0] = 0;
 	}
+	p->thread.ra = (unsigned long)ret_from_fork;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
 }
-- 
2.36.1

