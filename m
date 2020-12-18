Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3B2DE576
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgLRPBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:53 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgLRPBm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:42 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mr8zO-1kKqPm3BF0-00oFxl; Fri, 18 Dec 2020 15:58:32 +0100
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
Subject: [PATCH 18/23] arch: arm64: use generic irq error counter
Date:   Fri, 18 Dec 2020 15:57:41 +0100
Message-Id: <20201218145746.24205-19-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:Yatqmx7dUhdHudnM7bXWKwvGoIf7DjlwTsFL0y8vDL2kEOJIcZV
 qre3/kqekGdcYHtJOZbjaUUCSghkwLjUm7Q9unQ8yQvH/w2dVrMpjKSqQxIdl3HpP+U+P2i
 IG/PwCcxFiM0+f3WLDyC9P5mmfhvz9MD782vrtAFzTxyPM1f5Q2knUsQZa6uj1E5CrTzNkz
 dEbwriVZ0Rw6uRvKQrnkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D/qofcJnr7A=:lqfIM7MLSH33InKyh0wDk1
 vr6OTiC0sZdH6ZqfcsixvFPKx35Tb09kOaK+HXOUNEVBYmtpL1Ar1Yve1lYPk/BJsNzK9p+bL
 wG+Til40BeIWwdqYICuBj8PZUU/c10YzUoOW4jZ/PHkVtRr3nhifs5bqR1xNknnkozGVVGeik
 1ElFule9UWg/i3Kf1VobGBWzce+MC2aduJc5lk1R1fTmcwNGR4apLJRk6z/xsX6nbOHzpKp+2
 5t6fD4bSbTaeZVgjp+4vfp+NF4wXnruxQdaK10RYvXcAy9kVX1utKEZnegv6uXIHiTTGh/7wp
 P4PsHo7+OYqB1ZzE+poIDGxA68qf5TASLlxfutlboaLVBo8I0HRLxMakQ40qzYkvLbDXzRAVK
 89DqsXEZSlzb7pImU6pjTmbi1iLdA/XH9s47PVryiSm46SP9M3cLRLWgwPRlf
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the newly introduced irq error counter, that's already maintained
by all callers of ack_bad_irq(), in order to remove duplicate code.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/arm64/include/asm/hardirq.h | 9 ++-------
 arch/arm64/kernel/smp.c          | 6 ++----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index cbfa7b6f2e09..760922571084 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,7 +13,8 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-#define ack_bad_irq ack_bad_irq
+#define ack_bad_irq(irq)
+
 #include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
@@ -85,10 +86,4 @@ do {									\
 		write_sysreg(___hcr, hcr_el2);				\
 } while (0)
 
-static inline void ack_bad_irq(unsigned int irq)
-{
-	extern unsigned long irq_err_count;
-	irq_err_count++;
-}
-
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2499b895efea..0edc565ea735 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -33,7 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kvm_host.h>
-
+#include <asm-generic/irq-err.h>
 #include <asm/alternative.h>
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
@@ -798,8 +798,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
-unsigned long irq_err_count;
-
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
@@ -813,7 +811,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
 
-	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
+	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_get());
 	return 0;
 }
 
-- 
2.11.0

