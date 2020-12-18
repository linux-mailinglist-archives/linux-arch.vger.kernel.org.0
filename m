Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2632DE5D3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLRPB1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:27 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLRPB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:26 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQ6C0-1kUE7V11ge-00M2E7; Fri, 18 Dec 2020 15:58:17 +0100
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
Date:   Fri, 18 Dec 2020 15:57:32 +0100
Message-Id: <20201218145746.24205-10-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:QEAmA5iKAY7yb6fpx739pkgHqKb//azl6Ie4ED83yqgmc8uzz78
 je0zJbCosnMbIWEiXz8jt+KbDWZXeuggHKDVT2W8jxEfaVb6Dj85q+aDZ0eG+C5z3C7yTQJ
 zHjuLDxxS3QYN/9impytgSfa9fXOrYPqa3SB4neTbcKQOvRpaTdzr5iqb/+5WQpFAU9o+Ha
 SEyQbLyqZlBbYk6p+/IjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YV3sSSFnJq0=:YZVk0tQ3J+WnmWr/Pu0Pm1
 7SOKrhIwQrQMJPSefezvPQve2Pi0TFI7iW56s+zi1RtaEzCrb9S8aIKjRZdrtJH/6M9cDLbTt
 OyCjUYsHiUYU07uV56uXxP/7KQsSNztjn2ponpcQOguphmvQlkrbsDBUnt2pSzZm3SNmOKeUN
 Ajjq1Cl9aGow14Ychv31B1uCtcuUfeFK0pR48KmA7P1VFrwoXey4a+rTaQ5cP+reHLyhV+jC6
 3sWgxHQaoQs7iSJEAvZpUH/WD1gDagDqYWSdl9HgX7wGphIEj2ebmhHSRydFR7QyoSiFUfIF8
 vupQd0MUMVFKtUFPM5cDaoQ6ThXrFaZbtCLXCOLvbJPpxD5EuNUcNX9er3gaJ5cd+gMS7d4av
 6ZXR4YirUjnR9RP0tlYLITw0YDmLKN/tSfVS2Yys7jMaN5hKjEdeWFAm3nBi7sDNoeQKP0dLB
 NDGqie0ThRtnt/wBlAreQg0mK3Ip3+U9h49dECSG2tvEFMnTYEPAcwMhqbziOCYZ+mvsGdGGS
 twE+rsC0hFMVmkoqwYuazc=
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

