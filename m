Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792712800F5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgJAOND (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:13:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43633 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgJAONC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:13:02 -0400
Received: from threadripper.lan ([46.223.126.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mi2Fj-1ksOCT0Dcf-00e4nJ; Thu, 01 Oct 2020 16:12:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 02/10] ARM: traps: use get_kernel_nofault instead of set_fs()
Date:   Thu,  1 Oct 2020 16:12:25 +0200
Message-Id: <20201001141233.119343-3-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201001141233.119343-1-arnd@arndb.de>
References: <20201001141233.119343-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bdOfhwwBBRSt/4DOOJUnmGtWrsvKQpezNqOznMTEofVRfuUQlXA
 X87CCp0XIB1Oa5guDvzEWLOmiOSrvDxOopnL87e93NYoWsre4aIkXzGrxlbH2ym5kNTLI18
 ca4Ho0AXD0m7+Cy6A5vM4/eBgni/drXtxn7O69DSEVOkarAPXcTfVI0bU1cTLu0pQssoo8f
 Iu8KTgt6Y7CliDwvjbTMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Szc4dFsfUBQ=:nxTDskwhGfcu7ntfGfAaY+
 Dd87fn4NarNP2ZDAd34jAMNnWjle8Z8Y40KlZCId3CLHJNmcd0VgIUH435tCedDcA2iVG8Mjp
 NI0saGFNQSvCKjYXru9oVIK/Hu092AIEmlXuoNUCk3V2i7yUjpBMMDCc0ob9H5Ic3SIU9p+JN
 QGxDJr6PArOdidNfXE3U+xPQoQbpA8dwL3i/0ogruuC806fXckMTOzE4GAXxo76Ojr03s13Ex
 im9qJpp7afwvZpqFNovt7YSI9So/vMueQFtQHr26MTMMMjigvHADShV/GmuGrYN6g741Hg7OM
 PSlm271Fxk65rjbFKDYIWPqLXiHoYQOlurJUtnCBHu1kKY1PS+JDFLJLR+kp73clhD7i/RyMB
 qz1APo7A05M8MxbFenXvRuD1WgYD7wGeU3yb39ZjOkydYpGOv20hPRLUJa0jqFx44mxFijmpj
 Y85WbeYL3D7nTEW9OQt6Su7gHvJpNvJ+VG0WccfE475shveN+wOJaHHa7CD6oguiWrstxvqHc
 NFqSeZJk8BBgRYi1dvnuT42ndGFJ2akvvG1Mamzu8vORSer1FlTexDM6jbujYolrzjkJolI7T
 igB/ESc3cepL10X/CjspXmECItQEIK8HesSTXpGBP0OScOVJoCPAEfrEtlSzjbJS6KIqiUkNI
 zv/BqMkN6ZZqr3evUfbyGktFanBMPpjUDHsJHc32+h3AlEas9uzZrrCXrocTpNFfGbXWGKZPL
 ur9R/fXrEFYrhIejn6Vx1oONXWDU/euG/FLAfAZLXkNqaz5kd7L8zPdE6M59pfmfgTwt5detd
 N0IZHwqihu/kbX6kNo+kiU+H6mrT/4miiTzZ7ku9FblfrbvepgUylk5KkgXSD4sruVXmZzI
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

