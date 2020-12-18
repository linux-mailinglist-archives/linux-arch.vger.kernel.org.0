Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5516D2DE5AA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgLRPBe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:34 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:42299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLRPBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:31 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mfpf7-1kAdnV0ZXF-00gK8Q; Fri, 18 Dec 2020 15:58:24 +0100
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
Subject: [PATCH 13/23] arch: generic: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:57:36 +0100
Message-Id: <20201218145746.24205-14-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:cqi4G+m4FTr606+5GhtTSDyQJgpbRwMl5WhK+q+f4UEydU6IG9T
 6NbWVpudp/5L1dgq1A9ySLCK4Bn4NGB80INvM32MyUB8+gksTy2aleHOf+UmkFG+F2JN1YA
 3PBL2Y2xDGRvKYWDUajTgYMB1dLGrFsD/bXEv1o9JhWZj6+VAEclEvh63f/Zbgu8mf5Zp1T
 aNN7Xqbq8LGVi2d6zXKQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKlAQJCLliE=:UpLOMLJDpnIRmq0iclG2Q0
 4Hl9vZrCyPoZALgcAT+7fZsOLxJyN4hmmQzjFAcznIc5ciZeBa5ounj8E35j1YtIoIJNAedAo
 XMR4qkbUiO8ET6cGWdOLeWeiXfmmw4lyrgqLURBmBPxWuxuct2in+BfFsiPpl60pztNirYCS+
 /mAzL1urLT9NN28tZTrqZJGz2X5CwBM38OSVHZbbhPGrHlLG/SNlZl37LIsbJJ0aVUTcvHwDm
 QkOn+UDsmriJkUbWLfbxwAfTT1HAjcsXcIDv/eS+LZg2PTvxTuJxY/R8npn/zWnhqn7fifmbX
 QnjgTIIRAKEoI48LR9yBZbX/oltTOc6XrZOhRxQTbxfXTngXpFL9UZwe3DVpDqESa6X6BcmiG
 GT3nE6rtyLwYQ8QSCxqFV+BhoviVTy5lIOcVyK0LmRFv6JM9KPAw7wm/+bTmVKYtthxJ1DUc7
 r+a9EGv7HsyHGaEQLydmGUuEXJSCGPb5RmOA13mTm2KR4E4rpG8Sl4jr87dFg0z9R/rPcFDXC
 ovtuIoQgVGk6vLCizR/2T0=
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
 include/asm-generic/hardirq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index 7317e8258b48..f5a0240cbf52 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -19,7 +19,6 @@ DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
 #ifndef ack_bad_irq
 static inline void ack_bad_irq(unsigned int irq)
 {
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
 }
 #endif
 
-- 
2.11.0

