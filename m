Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E575ADE38
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 05:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiIFD4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 23:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiIFDzd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 23:55:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335A1B78A;
        Mon,  5 Sep 2022 20:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4660CB815FB;
        Tue,  6 Sep 2022 03:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9116C433C1;
        Tue,  6 Sep 2022 03:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662436517;
        bh=zdFYpvuTPe6RpWrIfdMW7NpG1CnfQ2kCKBqmLquyd8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfPG+khfb4XlIUR/FIVaqCHHDPvsnx6Sb1VRM6Hk6s5vsC4AF9UGyR4xKzPRKCuf1
         E0gojBwnwJsnAfXM/n4cK60741Uug8h1K5dn54NY6zrx8NWOzOGdjRZUZ1FsZ6Ukyp
         U4B99KDfU9FGb2rFKPn/GUD/4LBte/PGrm8bjEOcYtaeOPKmMPTns0u2WsoiBS8wos
         ewKBnpETdC40Zy7g7XKqYHBxCLoAJX9bt5moJuSNTgMGh0f0ZGZL7DqzaI8Y+OpzwS
         ITk4YA3mfcpW8yxrVthne927+82I/NuIsvcRNXPpMQHXrPJi+bU6NmxLjCksLb1kx4
         l+yFp29UGuaxQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 6/7] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Mon,  5 Sep 2022 23:54:22 -0400
Message-Id: <20220906035423.634617-7-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220906035423.634617-1-guoren@kernel.org>
References: <20220906035423.634617-1-guoren@kernel.org>
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
index 5ad4952203c5..c09cd4d28308 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -11,6 +11,7 @@
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 #include <asm/vmap_stack.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_IRQ_STACKS
 static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
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

