Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884E01526DA
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgBEHa5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:30:57 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37100 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBEHa4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:30:56 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so612476pjb.2
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jCkvWfQhOU4AOa+0RXaW2kDut5pFJiGfQTQQ4QZcTO0=;
        b=EBxV8h+plmtkydpRNcdJSdbOLLSM1krskdIgea+C6AuK6BnZdZbrVynsnOS8IaVO/q
         RnM97tJSvuCuG4Vh06HPXiOCOtmmVUbxxG+ty2tzDXlNvT2P7ItmGhzXCkAMatGM1oE/
         +HtNRNMChmQnBsPDmJhRjt77Eor4RPI56aE6vy5FPs59RcZx8KSYYTB1L43CqpA7vIAb
         bWvDn2CJvZ9eEZV0l89vDGCeUO5QEJsttmOrZ7tb3arRqPfHV1RjdH/CxYxgYnmTe1Rf
         Ltx0Bqjpq+tDolrgkLC9GgD9YUMR1vg4kRqe1V83h/gVhCovxyu/JND8xgA6/A6BEfqr
         XSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCkvWfQhOU4AOa+0RXaW2kDut5pFJiGfQTQQ4QZcTO0=;
        b=RzSfSHMXzqA6/wr00CEn1RAZhtiYixrD1wZ068wAmraoMLhci+KjVt9t81qKa7F2hH
         1sf5xUoTnisPtEqKOKK2ckw0SwNWMycsVsBhgOngDFj1Mdz7h3exwSYEoUM6asXPNc3l
         u7g3CVaKKi9unlcHGh36KNfhX2VXcaqpkaEdByMzr4zFlz74nEsW3PAWMZXYFfJ5lGeB
         GphVjLNzblvq9TqXtc74p6eiFHD6sTsrgwRpZx1MhQM03kHlFVopzBRtgWRInCXBc4gX
         Vvsyj4qKRDX6t96dj/xpuGYxWfvZ0uvNLiR1fTNv8J6Ls8FNBldGgLvfwF8NC9j9PMaU
         1cLA==
X-Gm-Message-State: APjAAAUzSzLWuxE4hbaVODJExQ6uIMoyFXovQFK8Amcq55QQidMeuzUt
        RFEXm4LPjCmo4f1nYHfD9JY=
X-Google-Smtp-Source: APXvYqyLS+u6Z2nR5UsxPemX4A24peAL7CjXUj68pUIgWACxdIbBsPloaXfst454F7HA/8CmXRRVzw==
X-Received: by 2002:a17:90a:8a12:: with SMTP id w18mr4021463pjn.68.1580887855859;
        Tue, 04 Feb 2020 23:30:55 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id i68sm27102086pfe.173.2020.02.04.23.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:30:54 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 73293202572FD1; Wed,  5 Feb 2020 16:30:53 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 07/26] um lkl: interrupt support
Date:   Wed,  5 Feb 2020 16:30:16 +0900
Message-Id: <9d6f93f061b2b248c0fa0a7f1530792936f8e7be.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
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

Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
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
2.21.0 (Apple Git-122.2)

