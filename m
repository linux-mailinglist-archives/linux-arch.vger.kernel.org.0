Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA68B20E481
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgF2V0D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgF2Sms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DDC033C08;
        Mon, 29 Jun 2020 11:26:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002DtP-5t; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 06/41] [ia64] regularize do_gpregs_[gs]et()
Date:   Mon, 29 Jun 2020 19:25:53 +0100
Message-Id: <20200629182628.529995-6-viro@ZenIV.linux.org.uk>
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

now access_elf_reg() does the right thing for everything other than
r0, we can simplify do_grepgs_[gs]et()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/ptrace.c | 155 ++++++++++------------------------------------
 1 file changed, 31 insertions(+), 124 deletions(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 37b5140d0dfe..be635f6f93c9 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1491,10 +1491,7 @@ access_elf_reg(struct task_struct *target, struct unw_frame_info *info,
 
 void do_gpregs_get(struct unw_frame_info *info, void *arg)
 {
-	struct pt_regs *pt;
 	struct regset_getset *dst = arg;
-	elf_greg_t tmp[16];
-	unsigned int i, index, min_copy;
 
 	if (unw_unwind_to_user(info) < 0)
 		return;
@@ -1517,160 +1514,70 @@ void do_gpregs_get(struct unw_frame_info *info, void *arg)
 						      &dst->u.get.kbuf,
 						      &dst->u.get.ubuf,
 						      0, ELF_GR_OFFSET(1));
-		if (dst->ret || dst->count == 0)
-			return;
-	}
-
-	/* gr1 - gr15 */
-	if (dst->count > 0 && dst->pos < ELF_GR_OFFSET(16)) {
-		index = (dst->pos - ELF_GR_OFFSET(1)) / sizeof(elf_greg_t);
-		min_copy = ELF_GR_OFFSET(16) > (dst->pos + dst->count) ?
-			 (dst->pos + dst->count) : ELF_GR_OFFSET(16);
-		for (i = dst->pos; i < min_copy; i += sizeof(elf_greg_t),
-				index++)
-			if (access_elf_reg(dst->target, info, i,
-						&tmp[index], 0) < 0) {
-				dst->ret = -EIO;
-				return;
-			}
-		dst->ret = user_regset_copyout(&dst->pos, &dst->count,
-				&dst->u.get.kbuf, &dst->u.get.ubuf, tmp,
-				ELF_GR_OFFSET(1), ELF_GR_OFFSET(16));
-		if (dst->ret || dst->count == 0)
-			return;
-	}
-
-	/* r16-r31 */
-	if (dst->count > 0 && dst->pos < ELF_NAT_OFFSET) {
-		pt = task_pt_regs(dst->target);
-		dst->ret = user_regset_copyout(&dst->pos, &dst->count,
-				&dst->u.get.kbuf, &dst->u.get.ubuf, &pt->r16,
-				ELF_GR_OFFSET(16), ELF_NAT_OFFSET);
-		if (dst->ret || dst->count == 0)
+		if (dst->ret)
 			return;
 	}
 
-	/* nat, pr, b0 - b7 */
-	if (dst->count > 0 && dst->pos < ELF_CR_IIP_OFFSET) {
-		index = (dst->pos - ELF_NAT_OFFSET) / sizeof(elf_greg_t);
-		min_copy = ELF_CR_IIP_OFFSET > (dst->pos + dst->count) ?
-			 (dst->pos + dst->count) : ELF_CR_IIP_OFFSET;
-		for (i = dst->pos; i < min_copy; i += sizeof(elf_greg_t),
-				index++)
-			if (access_elf_reg(dst->target, info, i,
-						&tmp[index], 0) < 0) {
+	while (dst->count && dst->pos < ELF_AR_END_OFFSET) {
+		unsigned int n, from, to;
+		elf_greg_t tmp[16];
+
+		from = dst->pos;
+		to = from + min(dst->count, (unsigned)sizeof(tmp));
+		if (to > ELF_AR_END_OFFSET)
+			to = ELF_AR_END_OFFSET;
+		for (n = 0; from < to; from += sizeof(elf_greg_t), n++) {
+			if (access_elf_reg(dst->target, info, from,
+						&tmp[n], 0) < 0) {
 				dst->ret = -EIO;
 				return;
 			}
+		}
 		dst->ret = user_regset_copyout(&dst->pos, &dst->count,
 				&dst->u.get.kbuf, &dst->u.get.ubuf, tmp,
-				ELF_NAT_OFFSET, ELF_CR_IIP_OFFSET);
-		if (dst->ret || dst->count == 0)
+				dst->pos, to);
+		if (dst->ret)
 			return;
 	}
-
-	/* ip cfm psr ar.rsc ar.bsp ar.bspstore ar.rnat
-	 * ar.ccv ar.unat ar.fpsr ar.pfs ar.lc ar.ec ar.csd ar.ssd
-	 */
-	if (dst->count > 0 && dst->pos < (ELF_AR_END_OFFSET)) {
-		index = (dst->pos - ELF_CR_IIP_OFFSET) / sizeof(elf_greg_t);
-		min_copy = ELF_AR_END_OFFSET > (dst->pos + dst->count) ?
-			 (dst->pos + dst->count) : ELF_AR_END_OFFSET;
-		for (i = dst->pos; i < min_copy; i += sizeof(elf_greg_t),
-				index++)
-			if (access_elf_reg(dst->target, info, i,
-						&tmp[index], 0) < 0) {
-				dst->ret = -EIO;
-				return;
-			}
-		dst->ret = user_regset_copyout(&dst->pos, &dst->count,
-				&dst->u.get.kbuf, &dst->u.get.ubuf, tmp,
-				ELF_CR_IIP_OFFSET, ELF_AR_END_OFFSET);
-	}
 }
 
 void do_gpregs_set(struct unw_frame_info *info, void *arg)
 {
-	struct pt_regs *pt;
 	struct regset_getset *dst = arg;
-	elf_greg_t tmp[16];
-	unsigned int i, index;
 
 	if (unw_unwind_to_user(info) < 0)
 		return;
 
+	if (!dst->count)
+		return;
 	/* Skip r0 */
-	if (dst->count > 0 && dst->pos < ELF_GR_OFFSET(1)) {
+	if (dst->pos < ELF_GR_OFFSET(1)) {
 		dst->ret = user_regset_copyin_ignore(&dst->pos, &dst->count,
 						       &dst->u.set.kbuf,
 						       &dst->u.set.ubuf,
 						       0, ELF_GR_OFFSET(1));
-		if (dst->ret || dst->count == 0)
-			return;
-	}
-
-	/* gr1-gr15 */
-	if (dst->count > 0 && dst->pos < ELF_GR_OFFSET(16)) {
-		i = dst->pos;
-		index = (dst->pos - ELF_GR_OFFSET(1)) / sizeof(elf_greg_t);
-		dst->ret = user_regset_copyin(&dst->pos, &dst->count,
-				&dst->u.set.kbuf, &dst->u.set.ubuf, tmp,
-				ELF_GR_OFFSET(1), ELF_GR_OFFSET(16));
 		if (dst->ret)
 			return;
-		for ( ; i < dst->pos; i += sizeof(elf_greg_t), index++)
-			if (access_elf_reg(dst->target, info, i,
-						&tmp[index], 1) < 0) {
-				dst->ret = -EIO;
-				return;
-			}
-		if (dst->count == 0)
-			return;
-	}
-
-	/* gr16-gr31 */
-	if (dst->count > 0 && dst->pos < ELF_NAT_OFFSET) {
-		pt = task_pt_regs(dst->target);
-		dst->ret = user_regset_copyin(&dst->pos, &dst->count,
-				&dst->u.set.kbuf, &dst->u.set.ubuf, &pt->r16,
-				ELF_GR_OFFSET(16), ELF_NAT_OFFSET);
-		if (dst->ret || dst->count == 0)
-			return;
 	}
 
-	/* nat, pr, b0 - b7 */
-	if (dst->count > 0 && dst->pos < ELF_CR_IIP_OFFSET) {
-		i = dst->pos;
-		index = (dst->pos - ELF_NAT_OFFSET) / sizeof(elf_greg_t);
-		dst->ret = user_regset_copyin(&dst->pos, &dst->count,
-				&dst->u.set.kbuf, &dst->u.set.ubuf, tmp,
-				ELF_NAT_OFFSET, ELF_CR_IIP_OFFSET);
-		if (dst->ret)
-			return;
-		for (; i < dst->pos; i += sizeof(elf_greg_t), index++)
-			if (access_elf_reg(dst->target, info, i,
-						&tmp[index], 1) < 0) {
-				dst->ret = -EIO;
-				return;
-			}
-		if (dst->count == 0)
-			return;
-	}
+	while (dst->count && dst->pos < ELF_AR_END_OFFSET) {
+		unsigned int n, from, to;
+		elf_greg_t tmp[16];
 
-	/* ip cfm psr ar.rsc ar.bsp ar.bspstore ar.rnat
-	 * ar.ccv ar.unat ar.fpsr ar.pfs ar.lc ar.ec ar.csd ar.ssd
-	 */
-	if (dst->count > 0 && dst->pos < (ELF_AR_END_OFFSET)) {
-		i = dst->pos;
-		index = (dst->pos - ELF_CR_IIP_OFFSET) / sizeof(elf_greg_t);
+		from = dst->pos;
+		to = from + sizeof(tmp);
+		if (to > ELF_AR_END_OFFSET)
+			to = ELF_AR_END_OFFSET;
+		/* get up to 16 values */
 		dst->ret = user_regset_copyin(&dst->pos, &dst->count,
 				&dst->u.set.kbuf, &dst->u.set.ubuf, tmp,
-				ELF_CR_IIP_OFFSET, ELF_AR_END_OFFSET);
+				from, to);
 		if (dst->ret)
 			return;
-		for ( ; i < dst->pos; i += sizeof(elf_greg_t), index++)
-			if (access_elf_reg(dst->target, info, i,
-						&tmp[index], 1) < 0) {
+		/* now copy them into registers */
+		for (n = 0; from < dst->pos; from += sizeof(elf_greg_t), n++)
+			if (access_elf_reg(dst->target, info, from,
+						&tmp[n], 1) < 0) {
 				dst->ret = -EIO;
 				return;
 			}
-- 
2.11.0

