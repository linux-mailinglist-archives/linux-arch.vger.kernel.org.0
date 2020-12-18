Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840D52DE478
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgLROfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:43 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:43585 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgLROfX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:23 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpUQm-1kHyFH35FU-00pvpv; Fri, 18 Dec 2020 15:32:07 +0100
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
Date:   Fri, 18 Dec 2020 15:31:13 +0100
Message-Id: <20201218143122.19459-15-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:Gw/bTtXok8p4vHk5nFrQVdFJ5MnOqVYTkF8qTqw26vjFIHJCyDK
 gWsI7rxnKihIOBi2JvYSwf+jSyWv5F+CX1+be0BzmKQrBr3azK9kodLyNb33JKW/mMhCjsj
 CRdMozs58Ybrwu5DzpMGw+pON0xSJpSE4ZeNixUusENMyncAeVENXSEGQGxvzLQqD8SXw6H
 2brEnhBShdNjRMc3ZWXiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IvDb0vCjKHw=:+26MMkVB/QLEF9LqzmJqJq
 gOmWB/hkRyWf9K9+YpOnE6/IsiVzUe3h8hVdk37yTgE1wrWp1dM9IMvWFDjirSORFXg2zRoqb
 onrR+fOHpR/aoO060PlrUsvxz8SxmywyHG/fJk6Bw9F58Mw+Iu2RztYyO2iDoobQezyCvU8nu
 Bt80Oxqb8xfFoxGrcn6js/zYH24qrp5tSbs/XbF8iPT8L3QH+miIBh2sCsG1Nm5BKvKWS7Hrq
 dIoTgaqijW5BGaacT01S37khgMPnvZobjkv1Uk9xSgxgSakDg56BY3JjpyAtSFGTDjxtbXrqG
 mqWEPJWclB5j0pKsqmKU23r2gb7/KurkTNxRc8+ufvsvpW4W5kdtOM2iNSNiurTOPDZxqddXj
 64Qz4Yigw3ixveE26VUWTA9PfQIeXMBGObhUKlN3zt/eaSNDA2vk46WEnBhsb
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

