Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78302DE5F7
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgLRPBV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:21 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:45275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLRPBT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:19 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZCrZ-1kdKnx3N4r-00V4mg; Fri, 18 Dec 2020 15:58:09 +0100
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
Date:   Fri, 18 Dec 2020 15:57:27 +0100
Message-Id: <20201218145746.24205-5-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218145746.24205-1-info@metux.net>
References: <20201218145746.24205-1-info@metux.net>
X-Provags-ID: V03:K1:gDN+tfC1WayznC4KJBWf12CrfD19o/lE/XbtVVLhscNrRB7gWg1
 Vds4YKpH0BcdAUFWRKPE6U7CB0zNVoGprjXD0HNU5mY/cL9JZ2C61KcLtCHdMtMeKmRsK2u
 sGPBLqMBMF2UQuyDRRjLhSWq2H4N16poMBoiqVCf58AwRx2yU2Cy6diDJO0RxTO+LKhZ3Dc
 U+V3J7YKyzDx9EkuuDsIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vrGjq169sr0=:3ZxaxoQ6clszTP12SF+WrC
 nuEktM8jCWgAyBbSFvd8SZ2xXR5h7hBFwAt6Nn/tOtXnniRqw2R1B0ufcHnwcGupEGCxID1PR
 wFPWGj8k/UadYQIC0dfKEWumuas4Jh1HQSpOCbunHMLWRy3guj1zFYnYyRPqfA/TCvUja7Klu
 zyIjniE9DSd7NwlZ/JC6Fj0xGQKv0RQpRT1CJXJVRauwjlbuf0gUiFq49rnAJfZhAzNgXmoH3
 oJofeVSlgEr4B5TvyIeJyQu5JVTfvQW/pyUwKxsI8IhmO8rAOGqiQEs69Ssd6zV3HQK6wgPaL
 Pq/ckWUmavU5mDpIbmxQEwd+bzV6ZJrrQxSIHbZBEJ26Fzle21T0BUUvefu5kpPTZbcarrfSD
 DkeHLzlxH4h/BadwHPzZEA07v+i9rkiXIBNNvv+/oimjY9xQ7eRGQesMLqSJjf7uS65HScJRz
 tkpPz3EK/TfYQIc6ZZ+L4E0G4A+sM2vlQeDBFg7xGOjuwz2cOKBLYYiNVOVrZixIDRAox5mon
 PMc+LqQAuN9+TADEDDmbp8=
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

