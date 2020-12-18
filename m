Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19B2DE5AC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgLRPBe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:34 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgLRPBd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:33 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mw9Dg-1jyB5Z3fc4-00s5jD; Fri, 18 Dec 2020 15:58:26 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, msalter@redhat.com, jacquiot.aurelien@gmail.com,
        gerg@linux-m68k.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        maz@kernel.org, tony@atomide.com, arnd@arndb.de,
        linux-alpha@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 14/23] kernel: generic counter for interrupt errors
Date:   Fri, 18 Dec 2020 15:57:37 +0100
Message-Id: <20201218145746.24205-15-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:gZ1AXPEm/UpRwsPFrMGAGszpsHbZZaJP10eli6lGCRG6/DR2s0K
 laIvbu34GqIRj0w9mIrrQ0kU/6V6QXjxGNERZBTiVPdMGr/2NWcs17qv5AD97lpj56Eo6+Z
 B2x1Hjvljzx6AIB31mJZYrl317A/2mZYO2rL2D5bshE3EhzGKi7YQcgjplB+ECxJwJTEf8/
 HDqOWpc4M+HK0zIufqs6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9BtoKY0pAkM=:XiRIkNOEXyQAOICMGyj6/h
 rdwcJIj3F+18aXK5p8iKo2bYehs363JE6H5HtRGpbLFyPaiSQZatY4t1v/7J79JDMblGl+DIX
 NgKOS+OJz8BXckrdcPo/RMAH/Gqlcfy31TtTpFocQFmQhQ4AVvLUwEzjRR4+PASWYlVc3hcIo
 RTf1eO5e+S209py/650FkCiCJoB7UPQDtHwpz8NTOqjD3e/rb7OAvVkpc6jLMZpQoAS6uKTfb
 fQsZQ9TFlyRB/CGpmjgW6HQ/Z8ypsK1epPaL2P00KR8vx9swbhXbMYk3RkjehDEtUVODv6RXF
 kLSbQGPB0clrK5UTJRw1TA9kD0kgVQ14hVGz6boG6ReMcJWfoZbR9qOmzrMKxHg67kHHLyodU
 o5G4A5iZWArA2MKM6Ls6uBcncvcEIfvFKW75zMwh0tEAu7nZtR3XjpdDHl3+n
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We currently have counters for spurious interrupt spread over all the
individual architectures. Mostly done in the arch's ack_bad_irq(),
sometimes also in arch specific drivers.

It's time to consolidate this code duplication:

  * introduce a global counter and inlined accessors
  * increase the counter in all call sites of ack_bad_irq()
  * subsequent patches will transform the individual archs one by one

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/asm-generic/irq-err.h | 17 +++++++++++++++++
 kernel/irq/dummychip.c        |  2 ++
 kernel/irq/handle.c           |  4 ++++
 kernel/irq/irqdesc.c          |  2 ++
 4 files changed, 25 insertions(+)
 create mode 100644 include/asm-generic/irq-err.h

diff --git a/include/asm-generic/irq-err.h b/include/asm-generic/irq-err.h
new file mode 100644
index 000000000000..33c75eb50c10
--- /dev/null
+++ b/include/asm-generic/irq-err.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_IRQ_ERR_H
+#define __ASM_GENERIC_IRQ_ERR_H
+
+extern atomic_t irq_err_counter;
+
+static inline void irq_err_inc(void)
+{
+	atomic_inc(&irq_err_counter);
+}
+
+static inline int irq_err_get(void)
+{
+	return atomic_read(&irq_err_counter);
+}
+
+#endif /* __ASM_GENERIC_IRQ_ERR_H */
diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
index 0b0cdf206dc4..93585dab9bd0 100644
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/export.h>
+#include <asm-generic/irq-err.h>
 
 #include "internals.h"
 
@@ -20,6 +21,7 @@ static void ack_bad(struct irq_data *data)
 	struct irq_desc *desc = irq_data_to_desc(data);
 
 	print_irq_desc(data->irq, desc);
+	irq_err_inc();
 	ack_bad_irq(data->irq);
 }
 
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 762a928e18f9..ad90f5a56c3a 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -13,11 +13,14 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <asm-generic/irq-err.h>
 
 #include <trace/events/irq.h>
 
 #include "internals.h"
 
+atomic_t irq_err_counter;
+
 #ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
 #endif
@@ -34,6 +37,7 @@ void handle_bad_irq(struct irq_desc *desc)
 
 	print_irq_desc(irq, desc);
 	kstat_incr_irqs_this_cpu(desc);
+	irq_err_inc();
 	ack_bad_irq(irq);
 }
 EXPORT_SYMBOL_GPL(handle_bad_irq);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 62a381351775..6192672be4d2 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -16,6 +16,7 @@
 #include <linux/bitmap.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
+#include <asm-generic/irq-err.h>
 
 #include "internals.h"
 
@@ -684,6 +685,7 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 		if (printk_ratelimit())
 			pr_warn("spurious IRQ: irq=%d hwirq=%d nr_irqs=%d\n",
 				irq, hwirq, nr_irqs);
+		irq_err_inc();
 		ack_bad_irq(irq);
 		ret = -EINVAL;
 	} else {
-- 
2.11.0

