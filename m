Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00CAF3F1D
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfKHFDQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46733 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHFDQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so3211331plt.13
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ga7DpaOcUSR7BV36NuhR/y/dLMORGuKevF27Vxhb2zQ=;
        b=paC8Uqt27q5imEMberxjdf/yripnpIhazBnKLVFWd1fZ/w3X/lxWHqJp64nKHBR2nJ
         /4Ubk/5bjthfYCM8abrPdwPFnKRS8wLG1kjgJFrUZ9S+TkAA4Zsp5+hCvnJCDC4zKP/V
         OQtSSaUZTBlGX6AUNR3MiMcljEt6+PSbdH9YJru7eY28ugX2RHjUQ33cm8LZqVygWKUK
         HAraxJio28Nb120AGyzQw4AGgSjhdBMRtELP4G6wt6wWIwdACSUUp0ae/2BpSxj8+zBW
         H0+Om9AhHR5W1fzvgV13iiniWxyTc4RpPILAFxNKvU97Tj9lP5COA4dfzcvlDQkSUHtQ
         RMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ga7DpaOcUSR7BV36NuhR/y/dLMORGuKevF27Vxhb2zQ=;
        b=uUTIKYDitsc4VfGlQOzOhByna1Aq2pvQb5GjwNzYsWXFHZwnkcJHpNb/DdnBSjNirQ
         +dwNNrM1Zk/HF++0z2iDoJMiLgYhXtc4IydCGYH6VMo/hy6Vmp9Csdgr+O+l/SF8vmrV
         VN5iCA6nZ4uHZYnmz55Vo+hlqQ2lvFB34+4azyKSidyJnp9VfGaDeTb+/RpoznUw90YC
         Gp/Oh6HYDXDf7foy8ASLta1gjhh5TjO5FjheVK9LfJbSdGy+1lasWdvEvZzRV5E416+3
         cUVh0FxsnThW7oQ8pLi2dthWFOGMZZnrNaAvdcQc5RRJDx3POQPYVeoLK8xxiPnVRO06
         SFpg==
X-Gm-Message-State: APjAAAVT2/S0Fr1Vf7nx93WWx+Vd9Xxa9WMBixeLOErmWvSbNf2aes+E
        Mxg9nXBrbuDp9NGtY7AJYb3t6ikWHVkNiA==
X-Google-Smtp-Source: APXvYqxrU2mQjeOvmCmEfkVkaJIGnPfzrghdk4dtCDrmuDopI9kBLwB0+c7naf0x+2KN/CvvJ53bDA==
X-Received: by 2002:a17:90a:7309:: with SMTP id m9mr10630783pjk.10.1573189395084;
        Thu, 07 Nov 2019 21:03:15 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id 83sm3248388pgh.86.2019.11.07.21.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:13 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id A396F201ACFCA6; Fri,  8 Nov 2019 14:03:11 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>
Subject: [RFC v2 07/37] lkl: interrupt support
Date:   Fri,  8 Nov 2019 14:02:22 +0900
Message-Id: <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

Add APIs that allows the host to reserve and free and interrupt number
and also to trigger an interrupt.

The trigger operation will simply store the interrupt data in
queue. The interrupt handler is run later, at the first opportunity it
has to avoid races with any kernel threads.

Currently, interrupts are run on the first interrupt enable operation
if interrupts are disabled and if we are not already in interrupt
context.

When triggering an interrupt, it uses GCC's built-in functions for
atomic memory access to synchronize and simple boolean flags.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/irq.h             |  13 ++
 arch/um/lkl/include/uapi/asm/irq.h        |  36 ++++
 arch/um/lkl/include/uapi/asm/sigcontext.h |  16 ++
 arch/um/lkl/kernel/irq.c                  | 193 ++++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/irq.h
 create mode 100644 arch/um/lkl/include/uapi/asm/irq.h
 create mode 100644 arch/um/lkl/include/uapi/asm/sigcontext.h
 create mode 100644 arch/um/lkl/kernel/irq.c

diff --git a/arch/um/lkl/include/asm/irq.h b/arch/um/lkl/include/asm/irq.h
new file mode 100644
index 000000000000..948fc54cb76c
--- /dev/null
+++ b/arch/um/lkl/include/asm/irq.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_IRQ_H
+#define _ASM_LKL_IRQ_H
+
+#define IRQ_STATUS_BITS		(sizeof(long) * 8)
+#define NR_IRQS			((int)(IRQ_STATUS_BITS * IRQ_STATUS_BITS))
+
+void run_irqs(void);
+void set_irq_pending(int irq);
+
+#include <uapi/asm/irq.h>
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/irq.h b/arch/um/lkl/include/uapi/asm/irq.h
new file mode 100644
index 000000000000..666628b233eb
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/irq.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_UAPI_LKL_IRQ_H
+#define _ASM_UAPI_LKL_IRQ_H
+
+/**
+ * lkl_trigger_irq - generate an interrupt
+ *
+ * This function is used by the device host side to signal its Linux counterpart
+ * that some event happened.
+ *
+ * @irq - the irq number to signal
+ */
+int lkl_trigger_irq(int irq);
+
+/**
+ * lkl_get_free_irq - find and reserve a free IRQ number
+ *
+ * This function is called by the host device code to find an unused IRQ number
+ * and reserved it for its own use.
+ *
+ * @user - a string to identify the user
+ * @returns - and irq number that can be used by request_irq or an negative
+ * value in case of an error
+ */
+int lkl_get_free_irq(const char *user);
+
+/**
+ * lkl_put_irq - release an IRQ number previously obtained with lkl_get_free_irq
+ *
+ * @irq - irq number to release
+ * @user - string identifying the user; should be the same as the one passed to
+ * lkl_get_free_irq when the irq number was obtained
+ */
+void lkl_put_irq(int irq, const char *name);
+
+#endif
diff --git a/arch/um/lkl/include/uapi/asm/sigcontext.h b/arch/um/lkl/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..2f4848843d1d
--- /dev/null
+++ b/arch/um/lkl/include/uapi/asm/sigcontext.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_UAPI_LKL_SIGCONTEXT_H
+#define _ASM_UAPI_LKL_SIGCONTEXT_H
+
+#include <asm/ptrace.h>
+
+struct pt_regs {
+	void *irq_data;
+};
+
+struct sigcontext {
+	struct pt_regs regs;
+	unsigned long oldmask;
+};
+
+#endif
diff --git a/arch/um/lkl/kernel/irq.c b/arch/um/lkl/kernel/irq.c
new file mode 100644
index 000000000000..e3b59e46ca50
--- /dev/null
+++ b/arch/um/lkl/kernel/irq.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+#include <asm/irq_regs.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/tick.h>
+#include <asm/irqflags.h>
+#include <asm/host_ops.h>
+#include <asm/cpu.h>
+
+/*
+ * To avoid much overhead we use an indirect approach: the irqs are marked using
+ * a bitmap (array of longs) and a summary of the modified bits is kept in a
+ * separate "index" long - one bit for each sizeof(long). Thus we can support
+ * 4096 irqs on 64bit platforms and 1024 irqs on 32bit platforms.
+ *
+ * Whenever an irq is trigger both the array and the index is updated. To find
+ * which irqs were triggered we first search the index and then the
+ * corresponding part of the arrary.
+ */
+static unsigned long irq_status[NR_IRQS / IRQ_STATUS_BITS];
+static unsigned long irq_index_status;
+
+static inline unsigned long test_and_clear_irq_index_status(void)
+{
+	if (!irq_index_status)
+		return 0;
+	return __sync_fetch_and_and(&irq_index_status, 0);
+}
+
+static inline unsigned long test_and_clear_irq_status(int index)
+{
+	if (!&irq_status[index])
+		return 0;
+	return __sync_fetch_and_and(&irq_status[index], 0);
+}
+
+void set_irq_pending(int irq)
+{
+	int index = irq / IRQ_STATUS_BITS;
+	int bit = irq % IRQ_STATUS_BITS;
+
+	__sync_fetch_and_or(&irq_status[index], BIT(bit));
+	__sync_fetch_and_or(&irq_index_status, BIT(index));
+}
+
+static struct irq_info {
+	const char *user;
+} irqs[NR_IRQS];
+
+static bool irqs_enabled;
+
+static struct pt_regs dummy;
+
+static void run_irq(int irq)
+{
+	unsigned long flags;
+	struct pt_regs *old_regs = set_irq_regs((struct pt_regs *)&dummy);
+
+	/* interrupt handlers need to run with interrupts disabled */
+	local_irq_save(flags);
+	irq_enter();
+	generic_handle_irq(irq);
+	irq_exit();
+	set_irq_regs(old_regs);
+	local_irq_restore(flags);
+}
+
+/**
+ * This function can be called from arbitrary host threads, so do not
+ * issue any Linux calls (e.g. prink) if lkl_cpu_get() was not issued
+ * before.
+ */
+int lkl_trigger_irq(int irq)
+{
+	int ret;
+
+	if (!irq || irq > NR_IRQS)
+		return -EINVAL;
+
+	ret = lkl_cpu_try_run_irq(irq);
+	if (ret <= 0)
+		return ret;
+
+	/*
+	 * Since this can be called from Linux context (e.g. lkl_trigger_irq ->
+	 * IRQ -> softirq -> lkl_trigger_irq) make sure we are actually allowed
+	 * to run irqs at this point
+	 */
+	if (!irqs_enabled) {
+		set_irq_pending(irq);
+		lkl_cpu_put();
+		return 0;
+	}
+
+	run_irq(irq);
+
+	lkl_cpu_put();
+
+	return 0;
+}
+
+static inline void for_each_bit(unsigned long word, void (*f)(int, int), int j)
+{
+	int i = 0;
+
+	while (word) {
+		if (word & 1)
+			f(i, j);
+		word >>= 1;
+		i++;
+	}
+}
+
+static inline void deliver_irq(int bit, int index)
+{
+	run_irq(index * IRQ_STATUS_BITS + bit);
+}
+
+static inline void check_irq_status(int i, int unused)
+{
+	for_each_bit(test_and_clear_irq_status(i), deliver_irq, i);
+}
+
+void run_irqs(void)
+{
+	for_each_bit(test_and_clear_irq_index_status(), check_irq_status, 0);
+}
+
+int show_interrupts(struct seq_file *p, void *v)
+{
+	return 0;
+}
+
+int lkl_get_free_irq(const char *user)
+{
+	int i;
+	int ret = -EBUSY;
+
+	/* 0 is not a valid IRQ */
+	for (i = 1; i < NR_IRQS; i++) {
+		if (!irqs[i].user) {
+			irqs[i].user = user;
+			irq_set_chip_and_handler(i, &dummy_irq_chip,
+						 handle_simple_irq);
+			ret = i;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+void lkl_put_irq(int i, const char *user)
+{
+	if (!irqs[i].user || strcmp(irqs[i].user, user) != 0) {
+		WARN("%s tried to release %s's irq %d", user, irqs[i].user, i);
+		return;
+	}
+
+	irqs[i].user = NULL;
+}
+
+unsigned long arch_local_save_flags(void)
+{
+	return irqs_enabled;
+}
+
+void arch_local_irq_restore(unsigned long flags)
+{
+	if (flags == ARCH_IRQ_ENABLED && irqs_enabled == ARCH_IRQ_DISABLED &&
+	    !in_interrupt())
+		run_irqs();
+	irqs_enabled = flags;
+}
+
+void init_IRQ(void)
+{
+	int i;
+
+	for (i = 0; i < NR_IRQS; i++)
+		irq_set_chip_and_handler(i, &dummy_irq_chip, handle_simple_irq);
+
+	pr_info("lkl: irqs initialized\n");
+}
+
+void cpu_yield_to_irqs(void)
+{
+	cpu_relax();
+}
-- 
2.20.1 (Apple Git-117)

