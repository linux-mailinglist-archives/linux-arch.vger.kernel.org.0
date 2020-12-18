Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002CA2DE608
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLRPBO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:14 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:46187 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLRPBN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:13 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxV4T-1jsyRe3BBR-00xr1G; Fri, 18 Dec 2020 15:58:03 +0100
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
Date:   Fri, 18 Dec 2020 15:57:24 +0100
Message-Id: <20201218145746.24205-2-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:sNvhDkhkHXSckZsIcYNRvhSxb4brkTcSkjpsXzG++3eNb3snJ0g
 J9Qv02uTs0nLp3/Ko4ksdZTvqxTqsz/VJHyYyKuCFEMndBxaiM7R6Nof8j/9Bc9v3uf5xpe
 63QhWeMZuMwyVcEvebQIrDokrsdpA8FvkxHUgTyntRUgah4L5gvEw4KA3yYR+yPnDkLUVC3
 8MNk6k5JHeB3igb+vXtww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9PanUVZdncQ=:ruo0TGsTgyRzC2TD10Yg7n
 tmilzgQTchCUSCtJB+uJD3tGAJPZ9rwFCJr6cZE5MH5SbA2m0AOTtj8oqqDNWs8cLtj8MBzny
 OhaA/tPgAr4XHJ3zLyN+a0GPhlRq80gQgL+Ir6o8L7/nzU8QaaUASC4VwN+2lsvHJnbu/dD2E
 9D88ErzP/g7tyF5JbwFxJzVax960xo3H+WX5YZFCZY+Xcj+4xol4bg6k52Ta6nTcF3SzEjyHC
 ikW+qSf4SJlMh7T8archj1wmz3XI/Y3jh3j8E9P9Uzw5ETe/syz3q2DMAcV1VplhWFe+b6f6E
 xxspiEAqDYUOfrIIQhqv6q9qB51Wdw+U8KHXfmVbQvQSu23IvSIptkF+o6GiMZ74cbRjOBudF
 mpN2jme8ZtPkVAXOogvV4r9jproDuTrmcbv3Eh6uWCxvZnez2YLonKGvYn2my
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

