Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF322A0A5E
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJ3Pte (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 11:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgJ3Ptd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:33 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B6C2151B;
        Fri, 30 Oct 2020 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604072972;
        bh=ZWVfnKETIZSkSXx6wtt9uwQPqWB73y+8PUTcomvoy2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWyfwhH4qhKP35A1ntbbH2uTPQAKolFdHFHrtSWwJy5Sq5MvZ555anM/3vysGQt3y
         VQVFD3UKiR9sA0ZvC/Z2NGFLAwjkgRWm6gMwYLIrEkgPnGIiqou5iSFnPMElVNJU08
         Q5LxJVIxJgvA6T5x1TmH6oh+G31HTu67VEszV24o=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        viro@zeniv.linux.org.uk, linus.walleij@linaro.org, arnd@arndb.de
Subject: [PATCH 2/9] ARM: traps: use get_kernel_nofault instead of set_fs()
Date:   Fri, 30 Oct 2020 16:49:12 +0100
Message-Id: <20201030154919.1246645-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030154919.1246645-1-arnd@kernel.org>
References: <20201030154519.1245983-1-arnd@kernel.org>
 <20201030154919.1246645-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/traps.c | 47 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 17d5a785df28..c3964a283b63 100644
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
2.27.0

