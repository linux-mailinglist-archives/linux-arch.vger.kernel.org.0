Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB65AC331
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiIDH2B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiIDH1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 03:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC44CA31;
        Sun,  4 Sep 2022 00:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC9760F08;
        Sun,  4 Sep 2022 07:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D7CC433C1;
        Sun,  4 Sep 2022 07:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662276461;
        bh=wIy71lGYCPRkK7R4Hp1uuSN4vpnFFig0KmZzO6RIDd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjZYFIqxH/4QsR8FgYQBQQy5AH3p2SGHULQUz3DmjUy9ehnFwZVtZ6RihwB5CxoO4
         8if6qCtpE57LUovKAjTrOM8Cvm1b7X7/3RsLhOHpGTQiUDORH/sYCfvN7rWLPIBIsO
         IBauVcXNBajdfQJtTpCcbmzUBcZgx/lj3nET/QGP5i9ZZIBfWhdPkTh+GJBQIbpLWY
         e0Q56PrOW73GeJ19Y8QFyxsrLSso60BpC3Qq0s4tNnbHjfetBeQzMM3GLSyjc12/7q
         dW36MVHChFo8PStK+Wl2CU+ZaWm7i5kUr8ZUfMymeWq8z7Ab/wE3ON+Ob8zLcZbK5y
         w9fI/PzmSyGBA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 4/6] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Sun,  4 Sep 2022 03:26:35 -0400
Message-Id: <20220904072637.8619-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220904072637.8619-1-guoren@kernel.org>
References: <20220904072637.8619-1-guoren@kernel.org>
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

Add the HAVE_SOFTIRQ_ON_OWN_STACK feature for the IRQ_STACKS config. The
irq and softirq use the same independent irq_stack of percpu by time
division multiplexing.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig      |  7 ++++---
 arch/riscv/kernel/irq.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a8a12b4ba1a9..da548ed7d107 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -434,12 +434,13 @@ config FPU
 	  If you don't know what to do here, say Y.
 
 config IRQ_STACKS
-	bool "Independent irq stacks"
+	bool "Independent irq & softirq stacks"
 	default y
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	help
-	  Add independent irq stacks for percpu to prevent kernel stack overflows.
-	  We may save some memory footprint by disabling IRQ_STACKS.
+	  Add independent irq & softirq stacks for percpu to prevent kernel stack
+	  overflows. We may save some memory footprint by disabling IRQ_STACKS.
 
 endmenu # "Platform type"
 
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 3ac16391ae2e..e2196b22f6f4 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -11,6 +11,7 @@
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 #include <asm/vmap_stack.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_IRQ_STACKS
 DEFINE_PER_CPU(ulong *, irq_stack_ptr);
@@ -38,6 +39,21 @@ static void init_irq_stacks(void)
 		per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
 }
 #endif /* CONFIG_VMAP_STACK */
+
+#ifndef CONFIG_PREEMPT_RT
+static void do_riscv_softirq(struct pt_regs *regs)
+{
+	__do_softirq();
+}
+
+void do_softirq_own_stack(void)
+{
+	ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id());
+
+	call_on_stack(NULL, sp, do_riscv_softirq, 0);
+}
+#endif /* CONFIG_PREEMPT_RT */
+
 #else
 static void init_irq_stacks(void) {}
 #endif /* CONFIG_IRQ_STACKS */
-- 
2.36.1

