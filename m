Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55F5996EA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbiHSIRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346622AbiHSIRI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:17:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE69EB274B;
        Fri, 19 Aug 2022 01:17:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32v5Rv9isI4EAA--.18159S4;
        Fri, 19 Aug 2022 16:16:58 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 8/9] LoongArch: ftrace: Add CALLER_ADDRx macros
Date:   Fri, 19 Aug 2022 16:16:56 +0800
Message-Id: <20220819081657.7254-3-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220819081657.7254-1-zhangqing@loongson.cn>
References: <20220819081657.7254-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx32v5Rv9isI4EAA--.18159S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8Cr4DZF18JrWftFy7KFg_yoWrJryxpF
        97ArZ3GrW0kwn7trZrXr15ur15AFn7Gw12ga129a45Ar12qr17uw1kZ34qqFn5tayxG3yI
        qFWrCrWayF4DJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
        nUUI43ZEXa7sRRD73JUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CALLER_ADDRx returns caller's address at specified level in call stacks.
They are used for several tracers like irqsoff and preemptoff.

do_vint
  irqentry_exit
    trace_hardirqs_on
      tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1)

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ftrace.h    |  2 ++
 arch/loongarch/include/asm/processor.h |  2 --
 arch/loongarch/kernel/Makefile         |  4 +--
 arch/loongarch/kernel/return_address.c | 45 ++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 4 deletions(-)
 create mode 100644 arch/loongarch/kernel/return_address.c

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index f96adef0e4a5..6afc9fc712f4 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -16,6 +16,8 @@
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
 #ifndef __ASSEMBLY__
+extern void *return_address(unsigned int);
+#define ftrace_return_address(n) return_address(n)
 #ifndef CONFIG_DYNAMIC_FTRACE
 extern void _mcount(void);
 #define mcount _mcount
diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index 1c4b4308378d..5eb45e55f3c7 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -201,8 +201,6 @@ unsigned long __get_wchan(struct task_struct *p);
 #define KSTK_EUEN(tsk) (task_pt_regs(tsk)->csr_euen)
 #define KSTK_ECFG(tsk) (task_pt_regs(tsk)->csr_ecfg)
 
-#define return_address() ({__asm__ __volatile__("":::"$1"); __builtin_return_address(0);})
-
 #ifdef CONFIG_CPU_HAS_PREFETCH
 
 #define ARCH_HAS_PREFETCH
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index a73599619466..9a3df7c1f6e8 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -6,8 +6,8 @@
 extra-y		:= head.o vmlinux.lds
 
 obj-y		+= cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
-		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
-		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
+		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o return_address.o \
+		   switch.o elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
 
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_EFI) 		+= efi.o
diff --git a/arch/loongarch/kernel/return_address.c b/arch/loongarch/kernel/return_address.c
new file mode 100644
index 000000000000..ed8121dd2b0f
--- /dev/null
+++ b/arch/loongarch/kernel/return_address.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/export.h>
+#include <linux/ftrace.h>
+#include <linux/kprobes.h>
+#include <linux/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static bool save_return_addr(void *d, unsigned long pc)
+{
+	struct return_address_data *data = d;
+
+	if (!data->level) {
+		data->addr = (void *)pc;
+		return false;
+	} else {
+		--data->level;
+		return true;
+	}
+}
+NOKPROBE_SYMBOL(save_return_addr);
+
+void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+
+	data.level = level + 2;
+	data.addr = NULL;
+
+	arch_stack_walk(save_return_addr, &data, current, NULL);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);
-- 
2.36.1

