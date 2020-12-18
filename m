Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D842B2DE5C5
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgLRPCZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:02:25 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgLRPBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:30 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0Fh1-1jucJt14Nz-00xIWK; Fri, 18 Dec 2020 15:58:22 +0100
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
Date:   Fri, 18 Dec 2020 15:57:35 +0100
Message-Id: <20201218145746.24205-13-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:0sbtQbefw8DQehEDviccuy0g2n3RO+b59+ihLBG4lLCKZynjSrI
 NPySoNrWbmhPWz0zjwKwrHWKuL/81jaRyevBRrHOPztRsHF4wxMuMRTaSK51mrdACZ96DRC
 Bun60UcXXd1iKXb9KhVkLzHK1IV0u6XGuGbtMZI5aJNMMlLVJLjYDgh8A4AwsQEFLHZoUHu
 5JUvMnmUoCKVsXwMey7XQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EnZ1T1GVBLA=:CKePjyo1KyFCkC4uxmd+BO
 Z3yoeE4a4pCsGC1fG8PmlRC5S2hwgdnyWHnBriA5prvGI/QUTQBVWU21S6V6h3cTpKFbFfEV5
 NNFXWLmW99vgTGiPqP77i45iQCeZMwUpfzuqawXJyZQ8823Z3w33M+2WIIT6HzHRL8VDlu0hH
 GnnNvQUmlileL1b+T8E7bvrtIFJ1564KNxdvQuF7Vqgi6esH5rpeZOLc/CpBI4XTTy6U6fkG+
 8DTTVUP5gL9zafWjgP7ZHMOzo1TinGD/C9mKLaC0CsASAmEyGbErnBRvWbyqYo3F8/8eLlvm9
 YYNdihZLUyVTzmxnwfWq681RURVj9eNqo0rJFVEYVvWX3MHOthIIkfhhKn/P9HwnBX3JLPr1C
 3TkDt/bSNRY8PWcqeM6DdV60QgkJ0h72AymRd5hD8bOJhDdkIRkym6xulIk1N
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

