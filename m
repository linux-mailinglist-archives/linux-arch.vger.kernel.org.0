Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19082DE4BA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgLROfP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:15 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgLROfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:13 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MNKuI-1kSfN03xpi-00OoTh; Fri, 18 Dec 2020 15:31:41 +0100
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
Subject: [PATCH 01/23] kernel: irq: irqdescs: warn on spurious IRQ
Date:   Fri, 18 Dec 2020 15:31:00 +0100
Message-Id: <20201218143122.19459-2-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:LV+vlieoH9S7FVeRD54ZyNGq0lXxd7A7eeGG73dV5SKsuNXUfZI
 t5Tc1dALRs2AtPOwYKoApPnoyxW7/Lxyitn6jmEk7odPc1fXKRQf1B17b0Xo7GSaZpMx5dW
 TGMTjUj10cvONDT+2jdjeydrLJOMscAH46e6N0Uv313zK0Un9DMFeG3NocxtaL9uYHwBWUE
 aSQQOOS63nbzmSA0OZCyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+jizveWrAag=:xi1E+afKqBPbuitFr74tH/
 Pqa93R1CfB6VGpKCdCeA3imHCGUzmR1wu1gjA3PGPF+dMp9C4DR3rt99LswhF1TegW/RnTDot
 7d+qHzUK0gNbP/ybW7PGmodvcbOApL7/3hR0HaBIPYze29okX0qVKNaN0uUOc0aMPNrJm/lHf
 rCFjulnbgKj9sYd2ill1azgaxbVSkzVmRlEPbAXZ+0ALMS8qEDGet+OtJmWpacsNa46vQXnQR
 mVE6jRttoXsNQa2wg7diSy8ElyG3YIRCwJEWAPOcEpIC4aPBtfkksUoly5a7/5EKCc4EvuICg
 YHQlmrQSz8cwd325SSQ2jSl5oaE8TxRVgzjar1+yw/FjC2rs1pHYfkD4L/u2NKSTYhAEHWZqD
 //Tdu1h6FpFg7G/m1MYCJBESvLEx03W/xk08EHJHT4hVa+Y58QzG42CuKoHzR
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a warning on spurious IRQs to __handle_domain_irq(), also telling the
linux IRQ number (if any), the hw IRQ number and the max nr of IRQs.

That's far more informative than the warnings in (some of) the individual
arch's ack_bad_irq()'s. These aren't really helpful since either the
other callers already had printed more detailed information or (when called
by __handle_domain_irq()) the printout just doesn't tell anything useful.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 kernel/irq/irqdesc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index e810eb9906ea..62a381351775 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -681,6 +681,9 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	 * than crashing, do something sensible.
 	 */
 	if (unlikely(!irq || irq >= nr_irqs)) {
+		if (printk_ratelimit())
+			pr_warn("spurious IRQ: irq=%d hwirq=%d nr_irqs=%d\n",
+				irq, hwirq, nr_irqs);
 		ack_bad_irq(irq);
 		ret = -EINVAL;
 	} else {
-- 
2.11.0

