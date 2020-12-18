Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB12DE5F4
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLRPC5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:02:57 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:59769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgLRPBV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:21 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1g3U-1k5urV3sfw-011xdL; Fri, 18 Dec 2020 15:58:14 +0100
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
Date:   Fri, 18 Dec 2020 15:57:30 +0100
Message-Id: <20201218145746.24205-8-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:oGmlfGkhJekOloE3MpuxkxNd1aPEER14Z6qxAgGlYdvB4SGRB7p
 7y9tiukZZ7CHa+D5i7nGvfnSW+R5wAvqp5z+61y5/MFB4lzPUEK1Ipf0OaxnnWdvUVtvQiY
 6FWp0hyc8Mmb2OoGtPFhz/88H0erdT/ig9y1yLOh95gO4aMsdyEeDo370OU+WSBUslEzplB
 udeX1JvpZlfy6olW+YCDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jeNZqaIrx4k=:iIZtJxLlwz4tSNkf59yuDp
 C8mkbAUeD1J1RRXMEWXpGvtrBGXW7cplJTteLoSP47lg8IeVCFNFUd5dezkStbdp6VOt7Ycmb
 PmcoCYYtQBYkW83gWQopEg/C8lk8UI5bRRZvUqC7j8lb+aFO66Yli/sD0xYmBX+8nLxUqqWjN
 cVUGYYsmTILE0qAFSs3WOVYQhDuhMoajYHDo+OlEzHs93WrIGfNP5gPjV6gmMZy+/39fBqSrT
 /sUF82JtABYtvr6gsH7UoWpKjArQ242DJ7cZh04+eCHZRZNzmmxjlBn1Uo35gNOqszE+X6z56
 pSWB5RIVFsfoNiwVqswKL/Vlmcg3E2v6dfz1hj9Kv5rkN7YajR4aq6HMJsgx9Bret+rFctGAL
 LrKCJT3mWC3+wmJ8F7iyW/tTCA2YpawqJVe2ZnBsFT9ZKZO3P/06X6iDsxsqjcyZSoEw56D8U
 31OCFgTkKNaH+O6ldSIrFXyqvW/Q6mvUOcVpRPGYyKG/POMQmcybdeakmavlTYncgc+71qZjm
 OB4buYEqw8y1sho5C/FCo0=
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

