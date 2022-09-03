Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3685ABFD6
	for <lists+linux-arch@lfdr.de>; Sat,  3 Sep 2022 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiICQi7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 12:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiICQit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 12:38:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D52756B9B;
        Sat,  3 Sep 2022 09:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5C5AB80B09;
        Sat,  3 Sep 2022 16:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71876C433D7;
        Sat,  3 Sep 2022 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662223113;
        bh=kkU88ruHZB/3z5MRfFsNgiX+HAQDk+V3gAcd/JsO0+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8XnIC0r0bcarId5VzdVbkRlr7RFqTBlvRUb9R09OAvUMk1XTmuCvbHwLTOuS+3oF
         rs9SeRyzFpg3OCeFLZX2mZaVLrdc/Ru/apJanGXXUMlpIDMxNj0ZPQqXelszDS3525
         Kh1tYFpmuVZImtQlWHFwyGKggSKQajtbX8YXCTBMxHkyiIxIktzMqhutTv8ivWQP9U
         4spvQz+be7CzBZ2dZg/fm2YZrgnY2tNSyPAtWJ7tEtRYNYibmI4KbvFEMvU/Y1yNil
         7WGMpVn3h1EBFdzrkU3B8jrK2QB2I0vtvvhUYCLlbCoUNZx5ACYwSFk0qAeOh8d0EE
         vUleH5KCQK3Dg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/3] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Sat,  3 Sep 2022 12:38:08 -0400
Message-Id: <20220903163808.1954131-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220903163808.1954131-1-guoren@kernel.org>
References: <20220903163808.1954131-1-guoren@kernel.org>
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
 arch/riscv/kernel/irq.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

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
index eec5c38100b6..282acfee7304 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -38,6 +38,21 @@ static void init_irq_stacks(void)
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

