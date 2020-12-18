Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C152DE43B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgLROfV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:34529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgLROfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:20 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MplPh-1kIFED0xaP-00qCoo; Fri, 18 Dec 2020 15:32:00 +0100
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
Date:   Fri, 18 Dec 2020 15:31:09 +0100
Message-Id: <20201218143122.19459-11-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201218143122.19459-1-info@metux.net>
References: <20201218143122.19459-1-info@metux.net>
X-Provags-ID: V03:K1:6TL4KPw+Ks7RU+AOsNXR+Ltfqz8XJW1b6vQsJcdupkFn/HGWZEu
 Pxb0W8VDuSp/eowGr2QZ2YYTQOeQIZ9sqLBhLlV4U0gn+9wxn0ZUCYDi1tihD8RSGfUeK0C
 FGo4l2UrGrTty9YtCH6eYRewFkVOo2b5I9IK1HudQLPzVrlY+lg/sg4fjnmPhPdkFl0hPAj
 +B/DBmIm2JthV5pOD9Lkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UEl1mf8Ej6U=:vVuWyafI8JwPT8IqekTwUf
 kJjVjnagJeZHcYrcEXI6WwIlGSzMR+6bJyDiDgrQgM7iWZQNxupfE9+KZ4CH8xwAl9bz0An2S
 g9SX/sJHYF9btvrHzN98Mv01lN2WXq/JdCqiiTmep8ayCtPYeqZm1MWA+VpMPBqXCiySp4nKx
 YrriRyCaFlryZz82ICVCzrhapzFYKL90MwPaC/6LLngk9MDuAZXPEeA0CD9w5aVk5j4WXyXy5
 moMvzvbBtoDNV/k1qA+tVeoczyKN9TMEwdpIVorDrHaUiPErxH0/+N3nGQGgxmN6gMk3qWGdm
 EQ926JDJncMRW18rLb97838aejHl2X+vn6odNyiZ81k15fjExFGn5Wsknjg4EIF4+ChUIckPq
 +B2MnXPkaLoMWdjQowJZMdiHVoEkc5t1KkUtVQLM/6nWRTJu4GUgNhKYVSNhR
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

