Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B152DE489
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgLROf7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:59 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:36429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgLROfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:21 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKsaz-1kVhVj3qdZ-00LDZe; Fri, 18 Dec 2020 15:32:15 +0100
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
Date:   Fri, 18 Dec 2020 15:31:17 +0100
Message-Id: <20201218143122.19459-19-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:ztAWgZI6xXIfs5hYABBMduPYxgBBPoOn3rTgKXCVjuQRy90ITLt
 Kg8k1YgqROrNsUA/RyLZJBzZVI3ZD2zezon+kPruX0g7F21+kdHyFQBv2S1Ck+zsXTj1H0m
 /BRMIKeXSwSpOj7tOcC2/xNNtF4ZZHCgr4LHlae/yPoEZlwrECyZ3alMstYrejssMsxs1Ny
 6EQOPvdu2hC5uMp1enYzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qd7gra9QKvU=:O3jAGv/c5nlZ9E1xiuVgIk
 I/ROuH1PlRfC/WrQnnVjkPgr48uJhGUs7PhqJrDCP4BZ7svz+H8cFCnoO2qKASLLVdZHp/JdD
 VdC0OmwMj2BnLqdOCiobtrS3RVOdzl940UD3oVWN487csDRsWTQ2UO39aAcVPD7XmQxJ1DVUi
 A6tB+zOj2ZCmwIFtkDpXNdVTUqi1lvAZA0DctLKqrlxVTNOVGSwOuLuLziGW4/Yil5+BivZFe
 ce/U2cXBCqEnBZxzfOHXp9ubtzOiBXFGtiVHr4CG9A/lFXvcerxsZEuApO8vUj6+Rg7f+FowC
 Ic7l7LAYUWOJ3Hm+9/0UsiOnt0iOPdXzrfQ0sEc8YmI5bbS+r9TYGLdfpzOw24Pm8evwda6DG
 ciSq2XP5sWHyCQt/mDsjjemlN2Uu6RiGXg1++FaAB32SN3jJZ93zYxKEySUBl
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

