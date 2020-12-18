Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56C2DE556
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgLRPBa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:30 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:48879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgLRPB3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:29 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MirX2-1kBSkS2U8y-00ewYZ; Fri, 18 Dec 2020 15:58:20 +0100
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
Subject: [PATCH 11/23] arch: sparc: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:57:34 +0100
Message-Id: <20201218145746.24205-12-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:PrIh9ptnry2iRq4Mx3UP2iHIAvXo2nMAiiq3tP5jbdjQCpBFjqO
 3ySbh/k8vY07uczZqzeZ+Fu/cv71D0Pa6PrsOUt8ZN53XV8mE/27YSicbx11WrRLSKvujG5
 iUWDGTqX4IPmQOVsUHSDKQeG2ojJv7iaZPw/hA7EV2Tz17NrO/VXgNx2nA5mDPZBychhm/7
 U558HJoCjNGxea/p6G6Bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QSqUnzGzKoI=:1RKvWdbnF3qQKmnLDyloG2
 cqgnxcP3BVO/SgQfaAYZXKEQAXE2j4+WxKWW1xIJamb+GzRy4exUCeWZnlxXF+WRDA1sJaA0O
 1vbz++Wi8IPGKiv8DTihePwG8WNkboP9FZmPjbVqMsBlUG17KKEgI4GluUSW1EdzF/CzaTH9/
 k3N99CCsoXP4WRzdHljOiyz0Ui+DDiVy0ScYiul/RdDQlMNgSpjrzBf1Zod6NJf3p8HMPbH2s
 1JXJzW3y/N7qNV4d2PLhz406dA3cc9ayIevg1II0vH3/IXRNy6c9RrpXuVxzf8Rn77hEbEMSo
 tE5WNTst0W5SlLTcMOFm++RWdRqmXdbwLPFyxOKOpGVGwMe4yFXXucPxwzX400dKjXZm29+8P
 h/+dtZRhpXVhWxHIm8tnRmEXrJQE4jC9IrRB283coi5QhBx9uT2d6B6jYlx0mYanXw/aA1BAP
 8isbTAw64zK2xgkmj4vHE4iA8v/d6xHcx/EHNP3F66NPLLPrWDL4WlpaV4sAhQQcBxzTsZWsM
 Sw2HZYEEdehqFnILi6vkAU=
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
 arch/sparc/include/asm/hardirq_64.h | 2 +-
 arch/sparc/kernel/irq_64.c          | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/hardirq_64.h b/arch/sparc/include/asm/hardirq_64.h
index 75b92bfe04b5..874151f520de 100644
--- a/arch/sparc/include/asm/hardirq_64.h
+++ b/arch/sparc/include/asm/hardirq_64.h
@@ -14,6 +14,6 @@
 #define local_softirq_pending_ref \
 	__cpu_data.__softirq_pending
 
-void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq(irq)
 
 #endif /* !(__SPARC64_HARDIRQ_H) */
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3ec9f1402aad..ea2a52f7fe53 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -284,11 +284,6 @@ static unsigned int sysino_exists(u32 devhandle, unsigned int devino)
 	return irq;
 }
 
-void ack_bad_irq(unsigned int irq)
-{
-	pr_crit("BAD IRQ ack %d\n", irq);
-}
-
 void irq_install_pre_handler(int irq,
 			     void (*func)(unsigned int, void *, void *),
 			     void *arg1, void *arg2)
-- 
2.11.0

