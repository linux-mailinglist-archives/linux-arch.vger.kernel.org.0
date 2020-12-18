Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13EB2DE61B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgLRPDV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:03:21 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgLRPBO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:14 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mo77T-1kK1VW1xBj-00pdXc; Fri, 18 Dec 2020 15:58:05 +0100
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
Date:   Fri, 18 Dec 2020 15:57:25 +0100
Message-Id: <20201218145746.24205-3-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:PqfaMTt25KQVxSXJTsfozmpBAeruFGG1jC3nsUehROhD0z4rSWE
 IaehytI/o5f6AoCsRTbYyuxgmId5X0qoSvyCMuRnkNj7LNq5/UmiaBRQ00TZS8ksxE8tlTK
 Z9+ACa+Zo53iDchZquHqWbo9V4ZzVTjuuoRD+GatwY7YnsMFfYTqB2Hjg0NnSpL67XfIodJ
 9BxvEx894cQB3s69Eu2JQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cohc8wk3vdI=:mzsvjvsWiiIwFiETSEotKA
 VmihfaVOaUQkByRjx7upE0UZT9zku+CzaTER2s+0cjRSYZ+F8ERiobaxCWYZbhD/zpbJAQ6BO
 Jxo98tjMSAykS3PAHuIs+mxtSplM92YWW8TseGJyHkOYQ3QZdyBpza4/hxXYN4Ebc95vJxs7w
 Wa3Fc2C+/6ZRKWZVYMWHF0FBNgUrG8cXl7VxhNWwC2H88W112L8bfPGLfl8vkZEZqPvuxHxHg
 qcIRWC53JqO9xuu8oj92R32XrMwvVUAg9/uYE9F/vUOV2HsU/JKe11720K5SEjUesaIUGHRzN
 2mba0rBnOH42YIy00q/nB8X2aw6OJqinSdqwaFlRTPK2+24XwcR4uomPWxEmPCYlwQQi10QC0
 rs5ksIwNEmKimqOI4pxpTTh9yzKt9scYRBbflDEdABGUepE9fNlb8iHrjRZDgIi2VbdVmqvA3
 2uNlI59NRmXmKPW0jDnIUVD59WP8M72uBTTY8d1uA/l8d0Ld50snZ/ksflXjV6BMsN+t38hj/
 ogRH9PXkj6nrxUFRuWUZWM=
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

