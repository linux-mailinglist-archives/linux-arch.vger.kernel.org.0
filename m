Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174D32DE54D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLRPBZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:25 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgLRPBX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:23 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsZ7T-1jxu6T2b19-00u1Gq; Fri, 18 Dec 2020 15:58:10 +0100
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
Subject: [PATCH 05/23] arch: ia64: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:57:28 +0100
Message-Id: <20201218145746.24205-6-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:Kj2U1IX7ryjw5cKrOzUXYJpQNFOW7CX9Si6kyRrMMQGGY2QbEbe
 NAKnClvg5kWFWYVKOK0yNd/zanHNfpRsebQLJyJbvrl65B/ojKUxxJhEzA0/q58WMmCe7d8
 JjMySWsHaJSoAyc+u4O0V5W9Fur9DshKYhquflTZSigSkwgr8YxIm7c9bcix0tZKtZZcNlU
 CT+IaOvoZ1CXRGb0dxEGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jo/jeyC06JQ=:0f9E4K6fSimqNf7RovGUWs
 3DMEdcpM3V2qseOZgadhZCUBrKGXS2BsS8oq4BzQYi6hXhYJ/DkpSgf5HH2X09Mki1oImJ/lq
 vXiGC+5gHA+yfKgzAXFDe2WAw6p+0KsZXbIg5IvVa63xwmMPATv1yG23eRJ6rHpX6z89ltbWT
 BiPlDTrHH3RDdo9yJeFRQsfxMrBlYEntmuSlCK3Yr8YlEQY7g1WynmbFW3Z151xUUWoE9+1up
 4O+QHCRn6k9DYxlouUf6uoAWn6F/3bt1xiDxkwy2h4NIc8hWr5F/3KckViaEQYBma5QZ+KXHm
 0s4aJ/Ke3PWUcft8nMQiVdVsxyKqBBVi4m7x1fmE0cZ4/hwNYkjO881UBgiazLRToA9OWF+fp
 xkcU2i+WXgTvYGADve7fJ22tZIld7qNrr/wHO/d8f5WFEtjXLSrryrKGGSSVh
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The warning in ack_bad_irq() is misleading in several ways:
* the term "vector" isn't quite correct
* the printing format isn't consistent across the archs: some print decimal,
  some hex, some hex w/o "0x" prefix.
* the printed linux irq isn't meaningful in all cases - we actually would
  want it to print the hw irq.

Since all call sites already print out more detailed and correct information,
we just don't need to duplicate this in each single arch. So just drop it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/ia64/include/asm/hardirq.h | 2 +-
 arch/ia64/kernel/irq.c          | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/ia64/include/asm/hardirq.h b/arch/ia64/include/asm/hardirq.h
index ccde7c2ba00f..dddaafaf84e0 100644
--- a/arch/ia64/include/asm/hardirq.h
+++ b/arch/ia64/include/asm/hardirq.h
@@ -22,6 +22,6 @@
 
 extern void __iomem *ipi_base_addr;
 
-void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq(irq)
 
 #endif /* _ASM_IA64_HARDIRQ_H */
diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index ecef17c7c35b..1365c7cf2095 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -28,15 +28,6 @@
 #include <asm/xtp.h>
 
 /*
- * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves.
- */
-void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_ERR "Unexpected irq vector 0x%x on CPU %u!\n", irq, smp_processor_id());
-}
-
-/*
  * Interrupt statistics:
  */
 
-- 
2.11.0

