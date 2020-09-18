Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27D26FD5D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIRMri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 08:47:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgIRMrA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 08:47:00 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTRAS-1jtycg3laG-00Ti0L; Fri, 18 Sep 2020 14:46:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/9] ARM: traps: use get_kernel_nofault instead of set_fs()
Date:   Fri, 18 Sep 2020 14:46:17 +0200
Message-Id: <20200918124624.1469673-3-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918124624.1469673-1-arnd@arndb.de>
References: <20200918124624.1469673-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gy/6r3hP6+Xw0VZ1kPuBOfmudRbDMtnh6jF154kk+qnOsu9JUCQ
 cQK0bo1hDNYXTK9JI2Na6UKfmHCGL9OWP+7LGyS/kOe6Uc9yJbO9xExzSioQ0OF5BPd/C1V
 nmlIEcSh3DpIrVLDUZebSlnT9QnSnvqCMQd9I2RYk49O2SSMFV8/sb0VnF6GCOz06mOntBv
 vtRVwI+wzeyGhICf15/8w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DMblnyBKhY4=:9xYkhBDiYrvF2PKMOZ5/jd
 7itoiVV6ScsHcK8wPs3xmfxSSrugMrRfii48gNLwyhVjnLhHsCHeIToONufxWhSJtWjqp50Rd
 dIhEumG+L/4r73Q7OyhK/FrDYOmZctzBbZbyaVJ4wQqNud37Mn9XLeJ8YXD11XGCYC0p6i9Ge
 aOPWKJtnHknCvEXZxHrj6X8nCWU097zi0wIqq8hmcU+urPAHVQ7Y29zGk/ELMlP4oGdhPlU52
 6I+dJDkdUkKfntHzL5sCVutRX7EueaRKoTpxc2faPKlwJQxnGn7NyNFxjeypshD9UPmkv0qIz
 uylSZc/nektnaiR3D6IRhQZJMwJDykBoIe8C3jk0bbNnCInQBu4lL/0wQ2RHfnusS4U0glwC8
 SD2DQohnsrGmHMGnbqEnN7XTejaUW+b9phi85MVOtGtIEuN4980eeaFVIsMTkklxbhhq3oHCf
 L/0jbGnUehzANInlLiBFQiyHWJ6O4vsTWFpWso1N3zvn1ePT3/CLrnhkUTYZrdnoAHZ+GQAbH
 3ZfCZ13w4NlZrcq9AiIZ93tkymhgVfkaxx4TATAiRc5BNr+tkMSj0wWdKy4ArwL6Sk95+LKBK
 GxcEz1kzhIFPShl/11Yi7N2GGdiN0cZntPvNNU8dwnwdzcSzUnJS8OjxdNgYRBjR8O6eyP7Cr
 dlsU4otbC8UOXe3bQ6WT2de5wyXNscPVST3gquGhFq+RSacYFwmiUJq4YwmSjeapSR6o3uXck
 zD+Ip58BziCarZCj5aMUGzFfn/jRUcoejVakvpvdBJ3pK87EOfqMQYxnulXte+co+uheW/4yI
 FNjRnYXt1zm6T5mNTFcR7DRZP8334b7k9fdnpA8MGg/BI710j6z9SMcAT4z3EUHAhn6bPeJ
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM uses set_fs() and __get_user() to allow the stack dumping code to
access possibly invalid pointers carefully. These can be changed to the
simpler get_kernel_nofault(), and allow the eventual removal of set_fs().

dump_instr() will print either kernel or user space pointers,
depending on how it was called. For dump_mem(), I assume we are only
interested in kernel pointers, and the only time that this is called
with user_mode(regs)==true is when the regs themselves are unreliable
as a result of the condition that caused the trap.

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

