Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869959E14E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbiHWKhF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 06:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355037AbiHWKeP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 06:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51516A59B5;
        Tue, 23 Aug 2022 02:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5C236156F;
        Tue, 23 Aug 2022 09:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9FDC433C1;
        Tue, 23 Aug 2022 09:06:48 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add SysRq-x (TLB Dump) support
Date:   Tue, 23 Aug 2022 17:06:36 +0800
Message-Id: <20220823090636.526090-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add SysRq-x (TLB Dump) support for LoongArch, which is useful for
debugging.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/Makefile |  2 ++
 arch/loongarch/kernel/sysrq.c  | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 arch/loongarch/kernel/sysrq.c

diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index a213e994db68..7225916dd378 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -23,6 +23,8 @@ obj-$(CONFIG_SMP)		+= smp.o
 
 obj-$(CONFIG_NUMA)		+= numa.o
 
+obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
+
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
 obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
diff --git a/arch/loongarch/kernel/sysrq.c b/arch/loongarch/kernel/sysrq.c
new file mode 100644
index 000000000000..366baef72d29
--- /dev/null
+++ b/arch/loongarch/kernel/sysrq.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LoongArch specific sysrq operations.
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/sysrq.h>
+#include <linux/workqueue.h>
+
+#include <asm/cpu-features.h>
+#include <asm/tlb.h>
+
+/*
+ * Dump TLB entries on all CPUs.
+ */
+
+static DEFINE_SPINLOCK(show_lock);
+
+static void sysrq_tlbdump_single(void *dummy)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&show_lock, flags);
+
+	pr_info("CPU%d:\n", smp_processor_id());
+	dump_tlb_regs();
+	pr_info("\n");
+	dump_tlb_all();
+	pr_info("\n");
+
+	spin_unlock_irqrestore(&show_lock, flags);
+}
+
+#ifdef CONFIG_SMP
+static void sysrq_tlbdump_othercpus(struct work_struct *dummy)
+{
+	smp_call_function(sysrq_tlbdump_single, NULL, 0);
+}
+
+static DECLARE_WORK(sysrq_tlbdump, sysrq_tlbdump_othercpus);
+#endif
+
+static void sysrq_handle_tlbdump(int key)
+{
+	sysrq_tlbdump_single(NULL);
+#ifdef CONFIG_SMP
+	schedule_work(&sysrq_tlbdump);
+#endif
+}
+
+static struct sysrq_key_op sysrq_tlbdump_op = {
+	.handler        = sysrq_handle_tlbdump,
+	.help_msg       = "show-tlbs(x)",
+	.action_msg     = "Show TLB entries",
+	.enable_mask	= SYSRQ_ENABLE_DUMP,
+};
+
+static int __init loongarch_sysrq_init(void)
+{
+	return register_sysrq_key('x', &sysrq_tlbdump_op);
+}
+arch_initcall(loongarch_sysrq_init);
-- 
2.31.1

