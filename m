Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADEB2DE5DE
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgLRPCn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:02:43 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgLRPB1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:27 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIdNt-1ktuFe2Uib-00EeMY; Fri, 18 Dec 2020 15:58:15 +0100
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
Subject: [PATCH 08/23] arch: powerpc: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:57:31 +0100
Message-Id: <20201218145746.24205-9-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:ieOuUKl8ThT454nzt+aV4PfH51j5uenC5RGUqeSvczG2Sqio5dm
 rnj7G5yCvs2qtVCBI9dUALWjHZ3LqLvCeeFb/LHnSWV7wc13TMFFnZOqLjjSE6RKIfRoU03
 9prPmxJYuT4mFYzS0QqQgXSWuHn59YpFcfX8YTLYlZXVKlTffExE6ECEPv527ddz92ShPOi
 DKplTRPkmcwVhVh6rr4BA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BlqCMXzsJL4=:lproxcv+QWWhQxS5wyXHNB
 W7GBf2KYPt+Ey8J9XFT2h7Fa5GCekIAGPikERbyy1o/Y9pAPNwdJiYaq1/e3ZM/DV4fk+S0+I
 zwZHE0M9/XAA8GGvNj7FHuRbNgVlsWmV5ForiWw6uZS91CaqrRXCvBQYv1k/DmRiDwXk3fqG1
 HEXBoPwJ5obvmE1qpF3hOehyWDr9FHv/hAOcSxSDxWuQBoaWoaJgF3kdqCfc8k4M6sWuM0pwp
 Ab57LJaI+Z20J2nCLEwJvdT3XIvw3C1+GySvHbZMi/kNN8/xeCxF46GzFi2PK7WTM5Y7nfXLK
 dDvuPEIi+FX/qlOLy1y5w1QB10S2nTRn13lgx2j3+g/JJ/L6LBO2qZ3egKqPxKwU9upV6Vc1q
 AV/7gfZJy531v3sV1PN/9fo9Kk9B0etcg2yX5Vrrl0WZq570Yg/rY1JpFXJwh1vbCiixcY4g+
 qz3peG6Y3QqKC5tguLBVU52O00pTr3pp5BPE3CM0LQ+ixkfoj/KooSSX4jbBww9t1u0m/h3v8
 ixBmeLvZdnEsTwn3MpZTU0=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The warning in ack_bad_irq() is misleading in several ways:
* the term "vector" isn't quite correct
* the printing format isn't consistent across the archs: some print decimal,
  some hex, some hex w/o 0x prefix.
* the printed linux irq isn't meaningful in all cases - we actually would
  want it to print the hw irq.

Since all call sites already print out more detailed and correct information,
we just don't need to duplicate this in each single arch. So just drop it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/powerpc/include/asm/hardirq.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index f133b5930ae1..4138193c2367 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -27,10 +27,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 #define __ARCH_IRQ_STAT
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
+#define ack_bad_irq(irq)
 
 extern u64 arch_irq_stat_cpu(unsigned int cpu);
 #define arch_irq_stat_cpu	arch_irq_stat_cpu
-- 
2.11.0

