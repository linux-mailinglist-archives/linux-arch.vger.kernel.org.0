Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6B20D1A6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgF2Smo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgF2Smm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C9C033C09;
        Mon, 29 Jun 2020 11:26:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002DtD-0S; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 04/41] [ia64] sanitize elf_access_gpreg()
Date:   Mon, 29 Jun 2020 19:25:51 +0100
Message-Id: <20200629182628.529995-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
References: <20200629182349.GA2786714@ZenIV.linux.org.uk>
 <20200629182628.529995-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The function takes the register number, finds the corresponding field
of pt_regs for registers that are saved there or does the unwind for the
registers that end up spilled on the kernel stack.  Then it reads from
or writes to the resulting location.

Unfortunately, finding the required pt_regs field is done by rather
horrible switch.  It's microoptimized in all the wrong places - it
even uses the knowledge that fields for r8..r11 follow each other
in pt_regs layout, while r12..r13 are not adjacent to those, etc.

All of that is to encode the mapping from register numbers to offsets +
the information that r4..r7 are not to be found in pt_regs.

It's deeply in nasal demon territory, at that - the games it plays
with pointer arithmetics on addresses of structure members are
undefined behaviour.

Valid C ends up with better code in this case: just initialize a constant
array with offsets of relevant pt_regs fields and we don't need that
switch anymore.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/ptrace.c | 57 +++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 82aaacf64583..b9d068903b98 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1273,52 +1273,41 @@ struct regset_getset {
 	int ret;
 };
 
+static const ptrdiff_t pt_offsets[16] =
+{
+#define R(n) offsetof(struct pt_regs, r##n)
+	[0] = -1, R(1), R(2), R(3),
+	[4] = -1, [5] = -1, [6] = -1, [7] = -1,
+	R(8), R(9), R(10), R(11), R(12), R(13), R(14), R(15),
+#undef R
+};
+
 static int
 access_elf_gpreg(struct task_struct *target, struct unw_frame_info *info,
 		unsigned long addr, unsigned long *data, int write_access)
 {
-	struct pt_regs *pt;
-	unsigned long *ptr = NULL;
-	int ret;
-	char nat = 0;
+	struct pt_regs *pt = task_pt_regs(target);
+	unsigned reg = addr / sizeof(unsigned long);
+	ptrdiff_t d = pt_offsets[reg];
 
-	pt = task_pt_regs(target);
-	switch (addr) {
-	case ELF_GR_OFFSET(1):
-		ptr = &pt->r1;
-		break;
-	case ELF_GR_OFFSET(2):
-	case ELF_GR_OFFSET(3):
-		ptr = (void *)&pt->r2 + (addr - ELF_GR_OFFSET(2));
-		break;
-	case ELF_GR_OFFSET(4) ... ELF_GR_OFFSET(7):
+	if (d >= 0) {
+		unsigned long *ptr = (void *)pt + d;
+		if (write_access)
+			*ptr = *data;
+		else
+			*data = *ptr;
+		return 0;
+	} else {
+		char nat = 0;
 		if (write_access) {
 			/* read NaT bit first: */
 			unsigned long dummy;
-
-			ret = unw_get_gr(info, addr/8, &dummy, &nat);
+			int ret = unw_get_gr(info, reg, &dummy, &nat);
 			if (ret < 0)
 				return ret;
 		}
-		return unw_access_gr(info, addr/8, data, &nat, write_access);
-	case ELF_GR_OFFSET(8) ... ELF_GR_OFFSET(11):
-		ptr = (void *)&pt->r8 + addr - ELF_GR_OFFSET(8);
-		break;
-	case ELF_GR_OFFSET(12):
-	case ELF_GR_OFFSET(13):
-		ptr = (void *)&pt->r12 + addr - ELF_GR_OFFSET(12);
-		break;
-	case ELF_GR_OFFSET(14):
-		ptr = &pt->r14;
-		break;
-	case ELF_GR_OFFSET(15):
-		ptr = &pt->r15;
+		return unw_access_gr(info, reg, data, &nat, write_access);
 	}
-	if (write_access)
-		*ptr = *data;
-	else
-		*data = *ptr;
-	return 0;
 }
 
 static int
-- 
2.11.0

