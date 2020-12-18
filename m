Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66C2DE441
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgLROfW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:22 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:58097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgLROfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:19 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mc02Z-1kERs31cCN-00dZVM; Fri, 18 Dec 2020 15:31:56 +0100
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
Date:   Fri, 18 Dec 2020 15:31:07 +0100
Message-Id: <20201218143122.19459-9-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:961O0xhqjt06JiBAQ8Yncab4D353QPKNLI0x7+d8iArc+FX9JJc
 0fYjZ1qnDNl4kr3Aekh/iVsP+OGXI1qqwH32vJEuKlfCSjqCn9YE13jC6MEjNSaajNcbOvw
 t7/ZFEBBowcuZjc5pvaIr454zwTWgvpLVJwAzTfwLuLhbouuyN43H6ItJWuM9l2Mp/fqA2O
 hYFPkEMktMx8l6+KWzxHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmyd5L+c8oo=:af1DwGEi2rqk8/XvBYK887
 Qc0FMsYeXbJ44alPx5v/X6YbB6kQrzzJzD+BOwatOt6U/VcQ7ccBHRIz0ddrI1NFDknST0W30
 yrXcKQg6D1oa41C+DY0PG8k82fCE6yE0VVnC8nvwBukc9ERNvNyyqm2vUOSERsg/ImRDRK6/v
 ovwMqhJu0aS9KLrm3VCnyB3M1UrWmK2OV0vA1MdFDISYcfVveeO6gsySzzBl1V01Q3yfCFkpf
 CLOPUMg8i7ywroK5iGwC3G/GsQ/CJsDgwu2Uz5j6to+hhIZ35tBExY7flR1DvF4N8L9hTqVgK
 FxmyUF9bQFsZAVu5URE92FPVB8UGH+fpcnEdFw0J1lryWJp8ClH7NRgAMMR/agS7mQE+ENfIT
 +HBZTVYR2NI9F5zQ8qAC/Fo7eUachb1YeZDE5FlSG/Sjax16/Y4MuROWJM7CH
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

