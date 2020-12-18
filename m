Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34A92DE4CE
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgLROgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:36:45 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:53589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgLROfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:13 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjSHa-1kO2md3GAM-00ky1B; Fri, 18 Dec 2020 15:32:05 +0100
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
Date:   Fri, 18 Dec 2020 15:31:12 +0100
Message-Id: <20201218143122.19459-14-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:M8aLFwZQt8q/gF3VPIe1M+mslyreXcwR+vIpx4HR0fXlsa/ah7/
 +gpub2bmnwbbfk2vmmd6wqU45nrLu4R8WoBDzlf/sEt8wti8ZNkB2N2Sn2RULrqS35jZqVv
 znY27DxrEH8DcfZBtVtCCD8FZ+9L/4eAR8+CpjqGf2MloaS+b2sZc2tB/+AISxdJcTKKsXj
 JY+ucp7lvJopx9QUjLklw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q1EC+mZUefQ=:GWO/RZjVZ6sQFibA31f9Li
 ecpis2odSRaO8+Go9GXugExpCogb5QHG6jNXU6SjPi/S/x+bzgo7UbVx4UfZCEt1pCuR65h8T
 BfLchQL8Ga2M+Z4iVE76JpqiYI8iKFmB2FWytSxVjIo5JoYZclIhl0xwm1kdd+EeYZJ7ayZ9m
 R05/FDLyX0pws33QW/IDqCovyrlVQPrNyzee0JLBBepkm4Nkv+L7RVBdzzbSnee1qaGSW7Jlt
 i0yymjKfv/qQsx/0NNcIRAMnvLLXUWmWR1Lf1l8XwnftGUWgjM9ryakDKd/sDz3pnwavpUbef
 yDHmiqJ+iHZL+JG6mq6tJdTLwzxduVYn6IlDZR8hMTr1Yy0x3ubJgbfDwnAr9agzmf1S63WpX
 vVVl/hcXPLDGnMprSZjAOlXYJSfmfOU81FiRdChJw1XfU4b6e6p0euhp/z3ez
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

