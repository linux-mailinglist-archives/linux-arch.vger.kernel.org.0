Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5952DE4B3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgLROgX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:36:23 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:38775 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgLROfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:16 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MD9Kj-1kzJDr1AGX-0099IA; Fri, 18 Dec 2020 15:31:58 +0100
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
Subject: [PATCH 09/23] arch: s390: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:31:08 +0100
Message-Id: <20201218143122.19459-10-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:+Fk5XG1M51DsDMqllxhuk9QMdwKM8nFiYzagO2Q/2cSgAuejovr
 dtmISK1c/qztd4178uEaymF5uh/0I6XlA2Tqnyx7Bfb0v6ONN47Yqppdl3VTdau8eLZW2Uv
 /pHid2mGQ+3dMXHd9bKt92Duo1y1rPLeQr5rGle5B4uBkwH7iz9s0bsnzCRdN3jFBUhSf/r
 +0OdIMQ80t8v/+o43h3+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z2f4lndISjI=:zHUd/iqf0O3qag8NkEcoBz
 x4x9TA7Ovp04jopysG/BlFtt1L5oIEmvskqof0AHt9vQMAKkztiscW5ztKv8l1IPCHM4FRUK7
 ob3aoPzcMvd0E5ijhnPp1qaioD3QFkMaBe+oev+iwsti2I965xNEIIOKQakRqrgwN7V2zYzBB
 8XgP9bUY+3Tiv6CMn8DT42WJvWvHPiqPqpw8bGh8YBe9MMOekLpBZz6OTOzdFxDgJdyVlkxMc
 Woo6ULY0pjIcEj/2+3mzbmDNZrNjx4xo4WB6FTNIsI5UvulnLwvmYxAQR8juEJf6ShH7cGcxY
 kk6tE44rK5SWHHMaqfK5sZEBFToA3VUjtPeCZxjWMfyLWLVp6UOq4BJ74AXDFlPs57qLm8Xbb
 uH6PiWBNvirOZkAb5kUMzlHPjSXYR1xgbCzp2pBMri5zdtt3HN0eVFGqhHnrw
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
 arch/s390/include/asm/hardirq.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index dfbc3c6c0674..56d95fcb310a 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -21,9 +21,6 @@
 #define __ARCH_HAS_DO_SOFTIRQ
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
+#define ack_bad_irq(irq)
 
 #endif /* __ASM_HARDIRQ_H */
-- 
2.11.0

