Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F12DE46D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgLROfg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:36437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgLROfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:24 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M42fA-1kqGnc0F3A-0006st; Fri, 18 Dec 2020 15:32:04 +0100
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
Subject: [PATCH 12/23] arch: x86: drop misleading warning on spurious IRQ
Date:   Fri, 18 Dec 2020 15:31:11 +0100
Message-Id: <20201218143122.19459-13-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:jAhMgmIuYk2J8NKZ9SFKCkplZOUtOwgm9ia2R2hOI6d6hkWMDXo
 iyC887gdKx8bRRQf7zooldt1XEwNpLvB8K9Jo3nbgTlWV+rCsfAQJWlxe3LIgDBGMn5Y5gT
 3EqwPsMd4WHX05XydxpJQn3hoBwqfy34ja9J66j2jo36wiLwDSqqzmuk75B/7qQH+OJj05d
 qsQcuhVdpm6SmibPPwQJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O9JxHLNp5Wc=:GuRSCiY0TUhLU4o5UCAtMj
 ZXvYyBX+IgPiKFIUxg+COqWGxgd3jFAqpqKGJ4ygOO5Jbv0URXhrrvXOh1fIO2ykGOUXM1vIi
 dK0yx0NjB39dQLPPjVOqXrrYoPgJ3+Dh7rcnBCEDAJS+pMdbMgdcHa+bPIJ377/0fdLFH1Ctt
 70rCfjyS5tp+118CYmjws6wh63CBoMRIM/QShfcI8A3WoUqg2jMA3BWoijPggxatuFF7MIYKW
 /4xwmK4IHk7lRSa7ou5pkIwM7J46NfIp7imXyvmKGutNW8GG+/ub83Uz2gcZZOacsU7Q6s5G1
 70UTjuq4b7VjK+HYKG7tUfJvqtvv7WLRle6ImIi6EJ0Kd6HYxWsN4nwFkWRv/Xwx8XJpvnFQe
 ksoiysqq3Qi6g+p1om2pf8qOa0IlFabSumvgQ6vKakEkVS9Fxnk+iHFW/dHFx
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
 arch/x86/kernel/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c5dd50369e2f..5c66c44b6b60 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -36,9 +36,6 @@ atomic_t irq_err_count;
  */
 void ack_bad_irq(unsigned int irq)
 {
-	if (printk_ratelimit())
-		pr_err("unexpected IRQ trap at vector %02x\n", irq);
-
 	/*
 	 * Currently unexpected vectors happen only on SMP and APIC.
 	 * We _must_ ack these because every local APIC has only N
-- 
2.11.0

