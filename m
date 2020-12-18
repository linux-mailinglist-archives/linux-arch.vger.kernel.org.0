Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE72DE4AF
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgLROgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:36:24 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:33283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgLROfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:16 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N79q8-1k0RMc0XIS-017Sgh; Fri, 18 Dec 2020 15:31:54 +0100
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
Subject: [PATCH 07/23] arch: parisc: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:31:06 +0100
Message-Id: <20201218143122.19459-8-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:8XuWB7AgjNDVCJZHoIt3V93rDTw/Wbyeoq2FH+H0K+l/YvRSa2h
 A61OlKcwAbiT481cWOcJuA8+Z5mShBGPgmvHkLHtKNYOQseGYtjnvCr7X48RiHbawLm0/82
 /usNV5JSRuFCye7OVFS61pbzr5MtutApEwNrCscNg8E/qkrBL4wOEaLHqh7CatFn0s3C5Di
 oPQcgJY3LJGKRvYOncfjQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DrYBb3VzWUM=:loxX1s4BhdzFYbZ7m5YrVV
 5WdMdAcvhvYxZrApHR7TfaZuTw+gOn2tDHn12uhoxCuO2F12KFrlDh7eYnVGtNN1dfJTcYOMk
 Ad31ZM7rXKRiMzXSLBrCMWO97q4yE2O93UQZvKODDFPI2JXainGBAP2wdUWX1KRtroukUXUlr
 yrQRN4+c1RfpM5YZlZG+v8ywj8yVAujxK9ObSGG7B+/H1gbcR8xYLUFx6cmRwTcLAmOY3P1KJ
 qLnbJY+2EHprywJ4Fn1QJT2kDv/JQU6rkn4gaaI4k0enqfmXqg0kavTV1Auwe5SA2IttfyqHE
 hooOot6HywFJy8cKLmObNu0V7rQhOO4K+Iz1jlJHl1TtGztiSt7CAZDAS22dHmtbS+c26tUH/
 qllgmkSn6Ah4eAK2+QhUSeSN+2Bbvy3WXatw4mQJh/mQygbq+EDj/5KnSkeGe
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
 arch/parisc/include/asm/hardirq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index fad29aa6f45f..78b581f00bb3 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -34,6 +34,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 #define __ARCH_IRQ_STAT
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
-#define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
+#define ack_bad_irq(irq)
 
 #endif /* _PARISC_HARDIRQ_H */
-- 
2.11.0

