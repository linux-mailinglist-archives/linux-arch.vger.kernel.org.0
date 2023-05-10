Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D36FE296
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjEJQf1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjEJQfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 12:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7E87EF5;
        Wed, 10 May 2023 09:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A084964A05;
        Wed, 10 May 2023 16:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40CFC433D2;
        Wed, 10 May 2023 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683736518;
        bh=rdwY2xPsMRjdNsYlKkpqfjxeCKdDEMu/9hjRoCJFxdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jt9AEIH+Dyddi6upgEhmzbo0fW2sCgcsIL5E6plZniKbKA3pV+N8YJjYfNbgcfwfI
         pU1FPgMKrfhVZfDOq4TC9Q91xNagOIHErXf/eUG2TF2iqO+4KO9SGWCkhZJHqVxbmn
         1PkCFUgUyAHLUXY2Vvb2OLi7TpcCFCcr0JhL9dkLRaUOnRSpf3OZFHe6ZWj5H0OXKf
         R4VZ6XsZHX6vPyZ6rpZNo10EDdTAMHqE807ESgfFQIjq6IhlEoSjMFntg6+cYWX0Ws
         CBxsWm9Qc4APR2g/yPNAeym0GCuDnX9NzSsw6YgWtAu37F4NQw7Wc7K9SB/MAaSPfy
         6xuhdKDTG25lg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Schaffner Tobias <tobias.schaffner@siemens.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RT 2/3] riscv: add lazy preempt support
Date:   Thu, 11 May 2023 00:24:05 +0800
Message-Id: <20230510162406.1955-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510162406.1955-1-jszhang@kernel.org>
References: <20230510162406.1955-1-jszhang@kernel.org>
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

Implement the lazy preempt for riscv.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig                   | 1 +
 arch/riscv/include/asm/thread_info.h | 5 ++++-
 arch/riscv/kernel/asm-offsets.c      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..89e9d9fb35c4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -118,6 +118,7 @@ config RISCV
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_PREEMPT_LAZY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index e0d202134b44..c5e9223e9b91 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -59,6 +59,7 @@ extern unsigned long spin_shadow_stack;
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	int			preempt_lazy_count;	/* 0=>preemptible, <0=>BUG */
 	/*
 	 * These stack pointers are overwritten on every system call or
 	 * exception.  SP is also saved to the stack it can be recovered when
@@ -90,6 +91,7 @@ struct thread_info {
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
+#define TIF_NEED_RESCHED_LAZY	0	/* lazy rescheduling */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
@@ -104,9 +106,10 @@ struct thread_info {
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 
 #define _TIF_WORK_MASK \
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
+	 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index d6a75aac1d27..1f8cccacb44e 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -36,6 +36,7 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
 	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
+	OFFSET(TASK_TI_PREEMPT_LAZY_COUNT, task_struct, thread_info.preempt_lazy_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
 
-- 
2.40.1

