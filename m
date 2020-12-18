Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84182DE610
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgLRPDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:03:11 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgLRPBQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:16 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McpeM-1kHUQ10gK2-00a0LR; Fri, 18 Dec 2020 15:58:07 +0100
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
Subject: [PATCH 03/23] arch: arm: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:57:26 +0100
Message-Id: <20201218145746.24205-4-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:0+9gMsQwvdqpJQQBUrPevb7lZTXdAu+bb56tdMJu2QYV0ZAzLWa
 WwVXpII0LliKSEnZk+U4QwBd4l6rae4ItxjdHon5KUO1igPURSNy1szXq/EreYUVBmrRLwX
 opegkBwrH8H3b76d6WrMQBudz/Aa+csr+C0WJ+Xq4VSs6PghBibMAfpRzinhNyR06+5EKgy
 XXqMUwoSCXOp59VNnBMPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:leH2LsGSVfE=:ZfGQ4qJq3e6eIJuMuvT1Ze
 XKki5mcYdtDJZqNkZKfePoRGl4rvJAgpfX8KGaMUlx8FS6SvpsCMGh52hgNhW3nmJPzJrWQfB
 1vR9Rn4pwKxmnzkQvx8xkWIeMg2d4aHS7rzfq3+7TDCy5mcsofgJ/IYIbRnFTcStuihzZuQ5l
 a0t9I4FL+MZHVH1vtEAS28Z+e1Tr1ys42Kf/4JClqS2+w03DZfPMPPlMoEcDktI8DFIE3b3H+
 MadcJochoKovJ6F4MMEBonfiAW8F26IomcTpC0XPTWkbUBw61AZe6gYZH0Mp+ONwe95608i3c
 DHqCuWSrvisC08hesFJ/RrJGEAgLSpMc/kxxXryWXNWTBar7DypPcWJMcp4RQnhBCjepxfAzC
 9s2BzACaOIcqrXxKGug/TYt/rW5Dj9noPCGVS6bsZcS1xH1x0OEofUT8RF0cJEbeo/muiFTXk
 grhHVxuK8rwdhxd5PLzt2D8SmMMgN+M2v3kNa5/5e2/cNYrIdb7Ig3wSOyn+Fnd5gux5ESaZ1
 qx+5tRnc5rWsZfee3St84Y=
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
 arch/arm/include/asm/hw_irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
index cecc13214ef1..5305c7e33aee 100644
--- a/arch/arm/include/asm/hw_irq.h
+++ b/arch/arm/include/asm/hw_irq.h
@@ -9,7 +9,6 @@ static inline void ack_bad_irq(int irq)
 {
 	extern unsigned long irq_err_count;
 	irq_err_count++;
-	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
 }
 
 #define ARCH_IRQ_INIT_FLAGS	(IRQ_NOREQUEST | IRQ_NOPROBE)
-- 
2.11.0

