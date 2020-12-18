Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6793B2DE59D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgLRPCK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:02:10 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgLRPBg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:36 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MacjC-1kFIV732Ak-00cDGr; Fri, 18 Dec 2020 15:58:27 +0100
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
Subject: [PATCH 15/23] arch: mips: use generic irq error counter
Date:   Fri, 18 Dec 2020 15:57:38 +0100
Message-Id: <20201218145746.24205-16-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:SdN9vyeiw7Sqh7Jer05Pc9wqPKjuW/N7DC2ExB/+Z0e4UsPZjuY
 IVIksISvFPlfrycs0XkDqyyQu3RUfXmwk8bmLnzscK+/goeuPZoqBwahQ41Dn5YaxPeKXw6
 2r2htjRyV7oboXLoAweAedHgZPJl4RrSsXj84rphj0T748PsWAwNl/m49AdOas5TE3eb+G2
 HpeA6RCDnMz3PiIwindkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qE8TlXvgWpk=:AELVwPuRevTxXVGs6VPBaw
 UIcP5c0AOxLGfOEGIOYPeUX8xf4sXzh8TC2LOhcT7i1zF9mi3+RGCZYDpsbmDwGzbMGrNbt0L
 5GPfUp5uK1FLE8y2YU7DQwmLj2Zceyrpzzs0RKCS6MebnriP8JQeu7aM+B0kkCveeeYCzWE80
 ss6IlJ8Lp7mJqiJW4vSML41DkQWi6eisEpRtCaOxNJZ0bRvlEWcfx5b9KFyhvNkxaKGdFKPk8
 AHwgHfg+riN+GxLwhUivpN5j28rHHPGIBPcWUy9eJBnNHyzN+tYpt/mJvMehUEClOczCeq8v1
 8aPRxAebXmJez7aLpBo4lqygPIo4ywetKc3oYgmeMlqS/tvTgoEY9MVXvjshGiTKVsMy2YrDH
 zkDhl/2QdFwpq6vK04xHkdpTT+LDT95zfQRb/pQBwkL3Uy+m0qmsjqmcgPu97
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the newly introduced irq error counter, that's already maintained
by all callers of ack_bad_irq(), in order to remove duplicate code.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/mips/include/asm/hw_irq.h | 4 ----
 arch/mips/kernel/irq-gt641xx.c | 3 ++-
 arch/mips/kernel/irq.c         | 7 +++----
 arch/mips/sni/rm200.c          | 3 ++-
 arch/mips/vr41xx/common/icu.c  | 3 ++-
 arch/mips/vr41xx/common/irq.c  | 5 +++--
 drivers/gpio/gpio-vr41xx.c     | 4 ++--
 7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/hw_irq.h b/arch/mips/include/asm/hw_irq.h
index 9e8ef5994c9c..b75fe2c4377f 100644
--- a/arch/mips/include/asm/hw_irq.h
+++ b/arch/mips/include/asm/hw_irq.h
@@ -8,10 +8,6 @@
 #ifndef __ASM_HW_IRQ_H
 #define __ASM_HW_IRQ_H
 
-#include <linux/atomic.h>
-
-extern atomic_t irq_err_count;
-
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/mips/kernel/irq-gt641xx.c b/arch/mips/kernel/irq-gt641xx.c
index 93bcf5736a6f..e2c877287bee 100644
--- a/arch/mips/kernel/irq-gt641xx.c
+++ b/arch/mips/kernel/irq-gt641xx.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 
 #include <asm/gt64120.h>
+#include <asm-generic/irq-err.h>
 
 #define GT641XX_IRQ_TO_BIT(irq) (1U << (irq - GT641XX_IRQ_BASE))
 
@@ -97,7 +98,7 @@ void gt641xx_irq_dispatch(void)
 		}
 	}
 
-	atomic_inc(&irq_err_count);
+	irq_err_inc();
 }
 
 void __init gt641xx_irq_init(void)
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index c98be305fab6..3ea3e4280648 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1992 Linus Torvalds
  * Copyright (C) 1994 - 2000 Ralf Baechle
  */
+#include <asm-generic/irq-err.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -27,17 +28,15 @@
 
 void *irq_stack[NR_CPUS];
 
-atomic_t irq_err_count;
-
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
-	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
+	seq_printf(p, "%*s: %10u\n", prec, "ERR", irq_err_get());
 	return 0;
 }
 
 asmlinkage void spurious_interrupt(void)
 {
-	atomic_inc(&irq_err_count);
+	irq_err_inc();
 }
 
 void __init init_IRQ(void)
diff --git a/arch/mips/sni/rm200.c b/arch/mips/sni/rm200.c
index d84744ca871d..c61d60a4dcc5 100644
--- a/arch/mips/sni/rm200.c
+++ b/arch/mips/sni/rm200.c
@@ -21,6 +21,7 @@
 #include <asm/sni.h>
 #include <asm/time.h>
 #include <asm/irq_cpu.h>
+#include <asm-generic/irq-err.h>
 
 #define RM200_I8259A_IRQ_BASE 32
 
@@ -270,7 +271,7 @@ void sni_rm200_mask_and_ack_8259A(struct irq_data *d)
 			       "spurious RM200 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
-		atomic_inc(&irq_err_count);
+		irq_err_inc();
 		/*
 		 * Theoretically we do not have to handle this IRQ,
 		 * but in Linux this does not cause problems and is
diff --git a/arch/mips/vr41xx/common/icu.c b/arch/mips/vr41xx/common/icu.c
index 7b7f25b4b057..462f559ad978 100644
--- a/arch/mips/vr41xx/common/icu.c
+++ b/arch/mips/vr41xx/common/icu.c
@@ -27,6 +27,7 @@
 #include <asm/io.h>
 #include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
+#include <asm-generic/irq-err.h>
 
 static void __iomem *icu1_base;
 static void __iomem *icu2_base;
@@ -640,7 +641,7 @@ static int icu_get_irq(unsigned int irq)
 
 	printk(KERN_ERR "spurious ICU interrupt: %04x,%04x\n", pend1, pend2);
 
-	atomic_inc(&irq_err_count);
+	irq_err_inc();
 
 	return -1;
 }
diff --git a/arch/mips/vr41xx/common/irq.c b/arch/mips/vr41xx/common/irq.c
index 8f68446ff2d9..b2580de08e25 100644
--- a/arch/mips/vr41xx/common/irq.c
+++ b/arch/mips/vr41xx/common/irq.c
@@ -10,6 +10,7 @@
 
 #include <asm/irq_cpu.h>
 #include <asm/vr41xx/irq.h>
+#include <asm-generic/irq-err.h>
 
 typedef struct irq_cascade {
 	int (*get_irq)(unsigned int);
@@ -46,7 +47,7 @@ static void irq_dispatch(unsigned int irq)
 	irq_cascade_t *cascade;
 
 	if (irq >= NR_IRQS) {
-		atomic_inc(&irq_err_count);
+		irq_err_inc();
 		return;
 	}
 
@@ -66,7 +67,7 @@ static void irq_dispatch(unsigned int irq)
 		ret = cascade->get_irq(irq);
 		irq = ret;
 		if (ret < 0)
-			atomic_inc(&irq_err_count);
+			irq_err_inc();
 		else
 			irq_dispatch(irq);
 		if (!irqd_irq_disabled(idata) && chip->irq_unmask)
diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index 98cd715ccc33..c1dbd933d291 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-
+#include <asm-generic/irq-err.h>
 #include <asm/vr41xx/giu.h>
 #include <asm/vr41xx/irq.h>
 #include <asm/vr41xx/vr41xx.h>
@@ -217,7 +217,7 @@ static int giu_get_irq(unsigned int irq)
 	printk(KERN_ERR "spurious GIU interrupt: %04x(%04x),%04x(%04x)\n",
 	       maskl, pendl, maskh, pendh);
 
-	atomic_inc(&irq_err_count);
+	irq_err_inc();
 
 	return -EINVAL;
 }
-- 
2.11.0

