Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344036C7894
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 08:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCXHO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 03:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCXHOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 03:14:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7F10261;
        Fri, 24 Mar 2023 00:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2276B8228C;
        Fri, 24 Mar 2023 07:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C6BC433EF;
        Fri, 24 Mar 2023 07:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679642076;
        bh=l0++r3py708ypvnpG587Sveo6OJJ1+QXcd11boQ5cIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UthNUi9qbVxLX0I5M6PIRNMzRwMK4TbxHJwwS0nY/c/rhga6JndjgfbZ4faDxjoqe
         wlWXFOCy5TEsqNMqqOvRkJBsCmZvS7dHRX6EUHAbdNZCbBB8W04kYJrs4+xmSRfsky
         ll7PQG9oYCF2oK+lrv2jeCmjC8q+UTNeIY+mIXaUuRApeVu/PQyaFBoda+shaE2V2g
         dpMtopr6YjShYsvGO7yGvG4Urho0B63mKLUq9bZ9qDaOHf+b9EcjoJ2P3CrHDyES8H
         vK+LI0hx74qL1UbZmAp/69awh8KPIx2h8lWi7Siyoz6XzJVcfbjUno6iaHtN9Gy1v9
         TUrcTPlsyHPXg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V11 2/3] riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Fri, 24 Mar 2023 03:12:38 -0400
Message-Id: <20230324071239.151677-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230324071239.151677-1-guoren@kernel.org>
References: <20230324071239.151677-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the HAVE_SOFTIRQ_ON_OWN_STACK feature for the IRQ_STACKS config. The
irq and softirq use the same independent irq_stack of percpu by time
division multiplexing.

Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig      |  7 ++++---
 arch/riscv/kernel/irq.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb3c40d3a21b..7b10af7d2479 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -494,12 +494,13 @@ config FPU
 	  If you don't know what to do here, say Y.
 
 config IRQ_STACKS
-	bool "Independent irq stacks" if EXPERT
+	bool "Independent irq & softirq stacks" if EXPERT
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
index 52f2fa44a9bb..0592c2e99b5f 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -10,6 +10,8 @@
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 #include <asm/vmap_stack.h>
+#include <asm/softirq_stack.h>
+#include <asm/stacktrace.h>
 
 #ifdef CONFIG_IRQ_STACKS
 DEFINE_PER_CPU(ulong *, irq_stack_ptr);
@@ -37,6 +39,38 @@ static void init_irq_stacks(void)
 		per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
 }
 #endif /* CONFIG_VMAP_STACK */
+
+#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+void do_softirq_own_stack(void)
+{
+#ifdef CONFIG_IRQ_STACKS
+	if (on_thread_stack()) {
+		ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id())
+					+ IRQ_STACK_SIZE/sizeof(ulong);
+		__asm__ __volatile(
+		"addi	sp, sp, -"RISCV_SZPTR  "\n"
+		REG_S"  ra, (sp)		\n"
+		"addi	sp, sp, -"RISCV_SZPTR  "\n"
+		REG_S"  s0, (sp)		\n"
+		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
+		"move	sp, %[sp]		\n"
+		"call	__do_softirq		\n"
+		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
+		REG_L"  s0, (sp)		\n"
+		"addi	sp, sp, "RISCV_SZPTR   "\n"
+		REG_L"  ra, (sp)		\n"
+		"addi	sp, sp, "RISCV_SZPTR   "\n"
+		:
+		: [sp] "r" (sp)
+		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
+		  "memory");
+	} else
+#endif
+		__do_softirq();
+}
+#endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
+
 #else
 static void init_irq_stacks(void) {}
 #endif /* CONFIG_IRQ_STACKS */
-- 
2.36.1

