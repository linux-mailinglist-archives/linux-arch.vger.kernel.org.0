Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934912DE41F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgLROfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:42439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgLROfJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:09 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPXpS-1kUsIP1N8E-00MbYH; Fri, 18 Dec 2020 15:31:43 +0100
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
Subject: [PATCH 02/23] arch: alpha: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:31:01 +0100
Message-Id: <20201218143122.19459-3-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:pUJzS/tNjFJ37SufUPmB6VHWpKthVZUGxvQ+xKtdprNr8l6YI/1
 KtXA5HiAMRvqC4e/n10rheKKOjnn6zs1jeHwcJ76JSfq/uaXTL12yjWHrsp+aEn4sFIwxGT
 lJtCDGmWiqtjf5DzjgjVtAXh0OE9P2QTM6JEU0+jDRqoh4w+LQlvJQkqtSE/m7lPjEpULQY
 EPZQOPAseqzUM9KoALtEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ImHgQfa9yos=:RMkUA47rpXzNJoIXDG7cLd
 bTIMK4FppxwMKyK22fDhDPRoT6ptco+6GEFPygCKPM3rqApxb1zc8N2Q9IlzRZztk4Mqspi6D
 EuSQLV7z2fEh8QrWp3rs7OPAeetvZb6aDKXn9A7Ga1rUJ1jEzmR/49pLCF7uhaFPSEWVS1iCL
 suvxGUV2sYC9MxuGtuiAG+MWMMbD9qXO8zYXwkujMFVcxMcyH8TmHBCIhoqZ3IdyhU1uYZEd8
 2WqgQk85s0gjS0zLWzGGRKzEC1JigGxQf0B8WdHUmSJh1LFYUVom4P2AHZw+H6DArC2p5KOxz
 x+JqeuLY6uvPHlbVff8Ida8an42pyFx/Dwg6qSQ6w/WH6zt9hco0jJg3PoOelM+wOibrEGeUY
 weYR0zzUBTrMjLce4GumPryxUSHszmfx7+lOptoiMHwpwf+pVLRG6INWMbNJW
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
 arch/alpha/kernel/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index f6d2946edbd2..c1980eea75a6 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -35,7 +35,6 @@ DEFINE_PER_CPU(unsigned long, irq_pmi_count);
 void ack_bad_irq(unsigned int irq)
 {
 	irq_err_count++;
-	printk(KERN_CRIT "Unexpected IRQ trap at vector %u\n", irq);
 }
 
 #ifdef CONFIG_SMP 
-- 
2.11.0

