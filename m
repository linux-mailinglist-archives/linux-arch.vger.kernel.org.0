Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E243D5B01
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhGZNb0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234214AbhGZNbW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:31:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FD1A60F55;
        Mon, 26 Jul 2021 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627308711;
        bh=en+PAmlM0caG8kJ2VCv1dbeWPj0LXJV1wbRzu3p7AmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JC54lRSurzWqC72r0vaMWfndqofRq/mZ/p1HUHrNHldVfSI7yepI+BOFTrQgDVxWs
         i5G1nmc4x2hCZz7ufzcSHUzWZTuj9M6b2I5eyQHTByVNe9AYawmlafA/hJyGi7+RRk
         Sq7R/07wWvPCeakSLBAiNh8/+Iqmqg9w03wdDqBzogYHg0wbwxSZG6ZJFUS/b1ve6o
         JHtNN19vPYzbxyr02SfNNDJ9f6ZIRzpSTiVIph+tuo6qMpURr1DNf6pMmORnJhf4VM
         PaRpsbWoo/+zTeXIByNRzjTHTwu5IjZJ3bG3OH637j9sgfBIeWCqZa5vakwdDToR+J
         ZEa0dJ+ki/IrQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 02/10] ARM: traps: use get_kernel_nofault instead of set_fs()
Date:   Mon, 26 Jul 2021 16:11:33 +0200
Message-Id: <20210726141141.2839385-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726141141.2839385-1-arnd@kernel.org>
References: <20210726141141.2839385-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

ARM uses set_fs() and __get_user() to allow the stack dumping code to
access possibly invalid pointers carefully. These can be changed to the
simpler get_kernel_nofault(), and allow the eventual removal of set_fs().

dump_instr() will print either kernel or user space pointers,
depending on how it was called. For dump_mem(), I assume we are only
interested in kernel pointers, and the only time that this is called
with user_mode(regs)==true is when the regs themselves are unreliable
as a result of the condition that caused the trap.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/traps.c | 47 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 64308e3a5d0c..10dd3ef1f398 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -122,17 +122,8 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		     unsigned long top)
 {
 	unsigned long first;
-	mm_segment_t fs;
 	int i;
 
-	/*
-	 * We need to switch to kernel mode so that we can use __get_user
-	 * to safely read from kernel space.  Note that we now dump the
-	 * code first, just in case the backtrace kills us.
-	 */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	printk("%s%s(0x%08lx to 0x%08lx)\n", lvl, str, bottom, top);
 
 	for (first = bottom & ~31; first < top; first += 32) {
@@ -145,7 +136,7 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
 			if (p >= bottom && p < top) {
 				unsigned long val;
-				if (__get_user(val, (unsigned long *)p) == 0)
+				if (get_kernel_nofault(val, (unsigned long *)p))
 					sprintf(str + i * 9, " %08lx", val);
 				else
 					sprintf(str + i * 9, " ????????");
@@ -153,11 +144,9 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 		}
 		printk("%s%04lx:%s\n", lvl, first & 0xffff, str);
 	}
-
-	set_fs(fs);
 }
 
-static void __dump_instr(const char *lvl, struct pt_regs *regs)
+static void dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
 	const int thumb = thumb_mode(regs);
@@ -173,10 +162,20 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 	for (i = -4; i < 1 + !!thumb; i++) {
 		unsigned int val, bad;
 
-		if (thumb)
-			bad = get_user(val, &((u16 *)addr)[i]);
-		else
-			bad = get_user(val, &((u32 *)addr)[i]);
+		if (!user_mode(regs)) {
+			if (thumb) {
+				u16 val16;
+				bad = get_kernel_nofault(val16, &((u16 *)addr)[i]);
+				val = val16;
+			} else {
+				bad = get_kernel_nofault(val, &((u32 *)addr)[i]);
+			}
+		} else {
+			if (thumb)
+				bad = get_user(val, &((u16 *)addr)[i]);
+			else
+				bad = get_user(val, &((u32 *)addr)[i]);
+		}
 
 		if (!bad)
 			p += sprintf(p, i == 0 ? "(%0*x) " : "%0*x ",
@@ -189,20 +188,6 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
-static void dump_instr(const char *lvl, struct pt_regs *regs)
-{
-	mm_segment_t fs;
-
-	if (!user_mode(regs)) {
-		fs = get_fs();
-		set_fs(KERNEL_DS);
-		__dump_instr(lvl, regs);
-		set_fs(fs);
-	} else {
-		__dump_instr(lvl, regs);
-	}
-}
-
 #ifdef CONFIG_ARM_UNWIND
 static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 				  const char *loglvl)
-- 
2.29.2

