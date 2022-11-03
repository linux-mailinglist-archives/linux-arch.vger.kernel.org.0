Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72B561780B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 08:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiKCHxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKCHwm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 03:52:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B66310;
        Thu,  3 Nov 2022 00:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90FD4B82695;
        Thu,  3 Nov 2022 07:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4473FC433B5;
        Thu,  3 Nov 2022 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667461947;
        bh=0K2hv/sIizd7ky6ouBl81veZ36d3hA0AYFyvgZS3ciY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCITk7V8W/fqya7h7EU4wMXFagRpx8Ck6z7+nm7uTCSD6GoEvvNTStoQaGvDxADNK
         OjODZttEb0iS2G1Lpjalryw1Xwn/1hGgf/8THv/b5pzg3+GWUBi8smp0kEYd0ioIne
         Q6gv8GAsgAYDTVX45/O4hOW8q2X+ScnZ4wtnsyB7MDu9G0cDXa+YzbT9JoJRWK36H+
         kR0NEscwaZA6eUB1Oo9yy2vtgowZ1cemjM77IvDFEj22XUJl37nccMsSLJhfWLwu3l
         cbb2WCPf+8qGdfwMlqiYcsKUKH2kti4ilOvBJey/VdYCxhAq9R7+gUqIT7j4xL2vbD
         qVFSuxAfwP2+Q==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V8 08/14] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Thu,  3 Nov 2022 03:50:41 -0400
Message-Id: <20221103075047.1634923-9-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221103075047.1634923-1-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/riscv/Kconfig      |  7 ++++---
 arch/riscv/kernel/irq.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2653a381cc62..85241415a935 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -446,12 +446,13 @@ config FPU
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
index 5d77f692b198..a6406da34937 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -11,6 +11,7 @@
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 #include <asm/vmap_stack.h>
+#include <asm/softirq_stack.h>
 
 #ifdef CONFIG_IRQ_STACKS
 static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
@@ -38,6 +39,38 @@ static void init_irq_stacks(void)
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

