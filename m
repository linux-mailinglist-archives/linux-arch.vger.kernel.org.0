Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234E763CE06
	for <lists+linux-arch@lfdr.de>; Wed, 30 Nov 2022 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiK3DpB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 22:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiK3DoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 22:44:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CA95BB;
        Tue, 29 Nov 2022 19:43:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EBAA2CE0B8A;
        Wed, 30 Nov 2022 03:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEB9C433D6;
        Wed, 30 Nov 2022 03:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669779825;
        bh=lnoKu28Fc9fEyibwcuIO3LwBsdtybFxiOBpzcEMK9/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C87B5dL2USumUlkcea4T+WHtUwUPBI7DadEe/HbMQYsoYp1OvMXectEjCfyMye5Hv
         b1nbWU0HOC9asmo32ux7z6+0tY2ETmsljMeGC0w2CgN9pJRwOtNQ3u8PDCCkJCJHy6
         P0t4acjHlJFCmDQ5FGzECFV1WSuCsCNoo055gBxosGLMO6M7WEBwNWIzRhCU9x0xWk
         rIMheOnadphxptAm8icMZoVCXK/wYZ9pyXDXK7cmcihBZZaE/TXAI8NgbcQq2KzhBq
         CL8zfjOaBn8R+iVDWIRevX0avPkXdRwlYfuKJE3lYpIt0WKldxdnbGNZi7IqBZwa7q
         WOquzcKvYllvQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH -next V9 13/14] riscv: consolidate ret_from_kernel_thread into ret_from_fork
Date:   Tue, 29 Nov 2022 22:40:58 -0500
Message-Id: <20221130034059.826599-14-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221130034059.826599-1-guoren@kernel.org>
References: <20221130034059.826599-1-guoren@kernel.org>
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

From: Jisheng Zhang <jszhang@kernel.org>

The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
the only difference is whether call the fn(arg) or not, this can be
achieved by testing fn is NULL or not, I.E s0 is 0 or not. Many
architectures have done the same thing, it make entry.S more clean.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/entry.S   | 12 +++---------
 arch/riscv/kernel/process.c |  5 ++---
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b1babad5f829..d4c061f7fbfa 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -132,7 +132,6 @@ END(handle_exception)
  * caller list:
  *  - handle_exception
  *  - ret_from_fork
- *  - ret_from_kernel_thread
  */
 ENTRY(ret_from_exception)
 	REG_L s0, PT_STATUS(sp)
@@ -326,20 +325,15 @@ END(handle_kernel_stack_overflow)
 
 ENTRY(ret_from_fork)
 	call schedule_tail
-	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
-	tail syscall_exit_to_user_mode
-ENDPROC(ret_from_fork)
-
-ENTRY(ret_from_kernel_thread)
-	call schedule_tail
+	beqz s0, 1f	/* not from kernel thread */
 	/* Call fn(arg) */
 	move a0, s1
 	jalr s0
+1:
 	move a0, sp /* pt_regs */
 	la ra, ret_from_exception
 	tail syscall_exit_to_user_mode
-ENDPROC(ret_from_kernel_thread)
+ENDPROC(ret_from_fork)
 
 
 /*
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index b0c63e8e867e..5108c76a14dd 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -34,7 +34,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
 extern asmlinkage void ret_from_fork(void);
-extern asmlinkage void ret_from_kernel_thread(void);
 
 void arch_cpu_idle(void)
 {
@@ -172,7 +171,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 
-		p->thread.ra = (unsigned long)ret_from_kernel_thread;
 		p->thread.s[0] = (unsigned long)args->fn;
 		p->thread.s[1] = (unsigned long)args->fn_arg;
 	} else {
@@ -182,8 +180,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
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

