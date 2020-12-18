Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E92DE421
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgLROfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgLROfJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:09 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKbc4-1kVQWl3lds-00Kwal; Fri, 18 Dec 2020 15:31:48 +0100
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
Subject: [PATCH 04/23] arch: c6x: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:31:03 +0100
Message-Id: <20201218143122.19459-5-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:LpND6+qlyx9AmGzooMou6Vf89HHTFuGLvWMR4fa2jE7KkvluiyQ
 HqgepSPJvSoquixtsLOVm+5iPC4lBlEuZqhzLMv6Gb39cQKFrL17Oy010oVncqAG1hs8ZLb
 pGhAnGzWftumzuN8fhte+J6A0Ofdx/haEbbuFjfqYrl0ZwJ97Mj0nh0dHoPAmWSljvPyBYo
 oj+4mi1bx8jhOre4f7beA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:84I6lyo19tM=:zj+0LdIy55dgj0XHWliHlu
 Z6IKSuWDQ1jjOF8yZCwA+1YWvrGO3DoiBv3ZgcLSKjOz0No0LNOfcA5IENpYgnEjP5Hyg7eF9
 Acr1srgzIAfrzoxVvReEJn6hodNaMiluUJJ4wAyoPFsORwPYP7zv0H1L3PH7AaenUVtOOotQy
 iMBJJV5YM9QbZ4ZeWrCswa1OAXsKNWV0YqhNAlkUQDN9z57gglGl3Vi5GCEsqr/3vT4gxQSop
 RKGgd9gIwDzD/9l5YndWHU0kT9xylbz3DwQuGVqCw4pVhW5yEq+gDn9wr9xXEUP5tWH3yfoIY
 m9ktZtYpbKzqkXtVXJVU1h7nUO6F6hLqjtv8Lyrgbg20wUqy49AHWpak7jjdXFQNyev+foz8D
 mskfV6gct5deZth1Yvg3FfFtrQF72YBxjuRJEDSfr2CzGLxOES+7x30oU5n3V
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
 arch/c6x/kernel/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/c6x/kernel/irq.c b/arch/c6x/kernel/irq.c
index e4c53d185b62..b9f7cfa2ed21 100644
--- a/arch/c6x/kernel/irq.c
+++ b/arch/c6x/kernel/irq.c
@@ -116,7 +116,6 @@ void __init init_IRQ(void)
 
 void ack_bad_irq(int irq)
 {
-	printk(KERN_ERR "IRQ: spurious interrupt %d\n", irq);
 	irq_err_count++;
 }
 
-- 
2.11.0

