Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F967D31B
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjAZR0u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 12:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjAZR0Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 12:26:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918F6C116;
        Thu, 26 Jan 2023 09:26:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE28618B4;
        Thu, 26 Jan 2023 17:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0432C433EF;
        Thu, 26 Jan 2023 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674753977;
        bh=NZL7k5T/gq/CBdcI/CQC/x9NElRVpSMRhseuithZiTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEooqbqVMsn2TlMRnXsNo9Y+PaFPnvDX3csu/9gIT177v+8ZILm2Wzk3PESi+bHlG
         mkE6nY6+naMdQcujHVEdccadtYSM8U79429TADKGRiVV+yoC4nEGulZ10sgZMhq40Y
         Um6vru9wBz1AZCvv/OUOaCqXVGBMRu3ozl5nAJG91SIiUX90n80J9tin0JFX8rmrI1
         F5IKtNA2pPv7e+ZmeSB8EawgCsgqAyrLirnWkDSCiO5F/TOtKrdo93O9SkENtoPVQe
         ao3+fDIkJWs9cCuXSsGGBY9TS7NfXIH77GYkagvDaHXaBMA34hruRzwYWVKyrnCe+s
         cjMqggrp5dSyA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V15 6/7] riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork
Date:   Thu, 26 Jan 2023 12:25:15 -0500
Message-Id: <20230126172516.1580058-7-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126172516.1580058-1-guoren@kernel.org>
References: <20230126172516.1580058-1-guoren@kernel.org>
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

