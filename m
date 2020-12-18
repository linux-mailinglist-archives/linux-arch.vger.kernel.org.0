Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56252DE5C7
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgLRPCZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:02:25 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:45487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgLRPBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:30 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4hex-1k7pjp3to7-011gFY; Fri, 18 Dec 2020 15:58:19 +0100
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
Subject: [PATCH 10/23] arch: sh: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:57:33 +0100
Message-Id: <20201218145746.24205-11-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:n12oP3JSFdzHbdPHfGLc/eyYhy99xvRd/Zl5J0TLtYnt5jRmItv
 iBoKqGJzKtE1cptmOrCYFnpxsT2kddEHwQF+M+hdBpwplwB8LieM/+oZLoePAQ1Jbo8ZNUK
 WvZWJRmTU8H7efFxfvGQDAgF/VzmaZFVYYVXPIucMwQtPBZB18ir086XAMcctmg0knXV+nh
 XJAYldaOgDjpgd+dswptQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HjWPrqnCh9g=:nWXKZzOD/GGnb7cDBprLO6
 ltg75MxwEjQU6yee9vlY+d0VqCWO3tEvvA5MwKZg6SKMyexKOYIREKI5Kp71yRtBpIWjN+j7f
 sH8FtAzk+AHl5eAaONphhT/ihtKttLsgoqoDQ0Jv4Tzqtq3GMXompZ/rwxwJ3UREY5RvAQg4t
 GxwMHPuRcSE31pQ+FmeYTBTETpmHcB2zkdBjDfSHCzwUkF9iVw+w4MftOE23kbKIiKVfr0IA4
 Jd2PrwrS5E+YbwHtFxfL54dgMVF1V8lItNBerRHGFs1iVwiKF/yqcwZ29wnzw16hIZcWRdi9T
 PSjDgJD7APPGIotv/zHmUNTD3xOapj4yXPzDi4sKcbNrC9UeNyn/PZRLXJJSFWgW0CDxWj1WZ
 lkFvc3qffLVHibMSlRKfcnbdJwMJ7Xjts6XNamB6l2a4y0RWLv+aRPfk/2dxH7kVRIpO+Wlqu
 e8w9kgL7YOxE6hH/FNlmzdSXRxw4tOLSPJcHgrhXuphsfEXP8PNQ5QL6KEvH3PCi2mkk80ebH
 Zq6rOqLGBYfsv6bh4zUwZE=
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
 arch/sh/kernel/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index ab5f790b0cd2..c14a142efe60 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -31,7 +31,6 @@ atomic_t irq_err_count;
 void ack_bad_irq(unsigned int irq)
 {
 	atomic_inc(&irq_err_count);
-	printk("unexpected IRQ trap at vector %02x\n", irq);
 }
 
 #if defined(CONFIG_PROC_FS)
-- 
2.11.0

