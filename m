Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0DF20E493
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390971AbgF2V0t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgF2Smp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:45 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AABC033C21;
        Mon, 29 Jun 2020 11:26:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUB-002Dw3-VL; Mon, 29 Jun 2020 18:26:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 28/41] ia64: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:15 +0100
Message-Id: <20200629182628.529995-28-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/ptrace.c | 149 ++++++++++++++++++----------------------------
 1 file changed, 58 insertions(+), 91 deletions(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index eae7b094f608..990ac8caae8c 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1489,9 +1489,17 @@ access_elf_reg(struct task_struct *target, struct unw_frame_info *info,
 		return access_elf_areg(target, info, addr, data, write_access);
 }
 
+struct regset_membuf {
+	struct membuf to;
+	int ret;
+};
+
 void do_gpregs_get(struct unw_frame_info *info, void *arg)
 {
-	struct regset_getset *dst = arg;
+	struct regset_membuf *dst = arg;
+	struct membuf to = dst->to;
+	unsigned int n;
+	elf_greg_t reg;
 
 	if (unw_unwind_to_user(info) < 0)
 		return;
@@ -1509,35 +1517,13 @@ void do_gpregs_get(struct unw_frame_info *info, void *arg)
 
 
 	/* Skip r0 */
-	if (dst->count > 0 && dst->pos < ELF_GR_OFFSET(1)) {
-		dst->ret = user_regset_copyout_zero(&dst->pos, &dst->count,
-						      &dst->u.get.kbuf,
-						      &dst->u.get.ubuf,
-						      0, ELF_GR_OFFSET(1));
-		if (dst->ret)
+	membuf_zero(&to, 8);
+	for (n = 8; to.left && n < ELF_AR_END_OFFSET; n += 8) {
+		if (access_elf_reg(info->task, info, n, &reg, 0) < 0) {
+			dst->ret = -EIO;
 			return;
-	}
-
-	while (dst->count && dst->pos < ELF_AR_END_OFFSET) {
-		unsigned int n, from, to;
-		elf_greg_t tmp[16];
-
-		from = dst->pos;
-		to = from + min(dst->count, (unsigned)sizeof(tmp));
-		if (to > ELF_AR_END_OFFSET)
-			to = ELF_AR_END_OFFSET;
-		for (n = 0; from < to; from += sizeof(elf_greg_t), n++) {
-			if (access_elf_reg(dst->target, info, from,
-						&tmp[n], 0) < 0) {
-				dst->ret = -EIO;
-				return;
-			}
 		}
-		dst->ret = user_regset_copyout(&dst->pos, &dst->count,
-				&dst->u.get.kbuf, &dst->u.get.ubuf, tmp,
-				dst->pos, to);
-		if (dst->ret)
-			return;
+		membuf_store(&to, reg);
 	}
 }
 
@@ -1588,60 +1574,36 @@ void do_gpregs_set(struct unw_frame_info *info, void *arg)
 
 void do_fpregs_get(struct unw_frame_info *info, void *arg)
 {
-	struct regset_getset *dst = arg;
-	struct task_struct *task = dst->target;
-	elf_fpreg_t tmp[30];
-	int index, min_copy, i;
+	struct task_struct *task = info->task;
+	struct regset_membuf *dst = arg;
+	struct membuf to = dst->to;
+	elf_fpreg_t reg;
+	unsigned int n;
 
 	if (unw_unwind_to_user(info) < 0)
 		return;
 
 	/* Skip pos 0 and 1 */
-	if (dst->count > 0 && dst->pos < ELF_FP_OFFSET(2)) {
-		dst->ret = user_regset_copyout_zero(&dst->pos, &dst->count,
-						      &dst->u.get.kbuf,
-						      &dst->u.get.ubuf,
-						      0, ELF_FP_OFFSET(2));
-		if (dst->count == 0 || dst->ret)
-			return;
-	}
+	membuf_zero(&to, 2 * sizeof(elf_fpreg_t));
 
 	/* fr2-fr31 */
-	if (dst->count > 0 && dst->pos < ELF_FP_OFFSET(32)) {
-		index = (dst->pos - ELF_FP_OFFSET(2)) / sizeof(elf_fpreg_t);
-
-		min_copy = min(((unsigned int)ELF_FP_OFFSET(32)),
-				dst->pos + dst->count);
-		for (i = dst->pos; i < min_copy; i += sizeof(elf_fpreg_t),
-				index++)
-			if (unw_get_fr(info, i / sizeof(elf_fpreg_t),
-					 &tmp[index])) {
-				dst->ret = -EIO;
-				return;
-			}
-		dst->ret = user_regset_copyout(&dst->pos, &dst->count,
-				&dst->u.get.kbuf, &dst->u.get.ubuf, tmp,
-				ELF_FP_OFFSET(2), ELF_FP_OFFSET(32));
-		if (dst->count == 0 || dst->ret)
+	for (n = 2; to.left && n < 32; n++) {
+		if (unw_get_fr(info, n, &reg)) {
+			dst->ret = -EIO;
 			return;
+		}
+		membuf_write(&to, &reg, sizeof(reg));
 	}
 
 	/* fph */
-	if (dst->count > 0) {
-		ia64_flush_fph(dst->target);
-		if (task->thread.flags & IA64_THREAD_FPH_VALID)
-			dst->ret = user_regset_copyout(
-				&dst->pos, &dst->count,
-				&dst->u.get.kbuf, &dst->u.get.ubuf,
-				&dst->target->thread.fph,
-				ELF_FP_OFFSET(32), -1);
-		else
-			/* Zero fill instead.  */
-			dst->ret = user_regset_copyout_zero(
-				&dst->pos, &dst->count,
-				&dst->u.get.kbuf, &dst->u.get.ubuf,
-				ELF_FP_OFFSET(32), -1);
-	}
+	if (!to.left)
+		return;
+
+	ia64_flush_fph(task);
+	if (task->thread.flags & IA64_THREAD_FPH_VALID)
+		membuf_write(&to, &task->thread.fph, 96 * sizeof(reg));
+	else
+		membuf_zero(&to, 96 * sizeof(reg));
 }
 
 void do_fpregs_set(struct unw_frame_info *info, void *arg)
@@ -1717,6 +1679,20 @@ void do_fpregs_set(struct unw_frame_info *info, void *arg)
 	}
 }
 
+static void
+unwind_and_call(void (*call)(struct unw_frame_info *, void *),
+	       struct task_struct *target, void *data)
+{
+	if (target == current)
+		unw_init_running(call, data);
+	else {
+		struct unw_frame_info info;
+		memset(&info, 0, sizeof(info));
+		unw_init_from_blocked_task(&info, target);
+		(*call)(&info, data);
+	}
+}
+
 static int
 do_regset_call(void (*call)(struct unw_frame_info *, void *),
 	       struct task_struct *target,
@@ -1728,27 +1704,18 @@ do_regset_call(void (*call)(struct unw_frame_info *, void *),
 				 .pos = pos, .count = count,
 				 .u.set = { .kbuf = kbuf, .ubuf = ubuf },
 				 .ret = 0 };
-
-	if (target == current)
-		unw_init_running(call, &info);
-	else {
-		struct unw_frame_info ufi;
-		memset(&ufi, 0, sizeof(ufi));
-		unw_init_from_blocked_task(&ufi, target);
-		(*call)(&ufi, &info);
-	}
-
+	unwind_and_call(call, target, &info);
 	return info.ret;
 }
 
 static int
 gpregs_get(struct task_struct *target,
 	   const struct user_regset *regset,
-	   unsigned int pos, unsigned int count,
-	   void *kbuf, void __user *ubuf)
+	   struct membuf to)
 {
-	return do_regset_call(do_gpregs_get, target, regset, pos, count,
-		kbuf, ubuf);
+	struct regset_membuf info = {.to = to};
+	unwind_and_call(do_gpregs_get, target, &info);
+	return info.ret;
 }
 
 static int gpregs_set(struct task_struct *target,
@@ -1790,11 +1757,11 @@ fpregs_active(struct task_struct *target, const struct user_regset *regset)
 
 static int fpregs_get(struct task_struct *target,
 		const struct user_regset *regset,
-		unsigned int pos, unsigned int count,
-		void *kbuf, void __user *ubuf)
+		struct membuf to)
 {
-	return do_regset_call(do_fpregs_get, target, regset, pos, count,
-		kbuf, ubuf);
+	struct regset_membuf info = {.to = to};
+	unwind_and_call(do_fpregs_get, target, &info);
+	return info.ret;
 }
 
 static int fpregs_set(struct task_struct *target,
@@ -2033,14 +2000,14 @@ static const struct user_regset native_regsets[] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = ELF_NGREG,
 		.size = sizeof(elf_greg_t), .align = sizeof(elf_greg_t),
-		.get = gpregs_get, .set = gpregs_set,
+		.get2 = gpregs_get, .set = gpregs_set,
 		.writeback = gpregs_writeback
 	},
 	{
 		.core_note_type = NT_PRFPREG,
 		.n = ELF_NFPREG,
 		.size = sizeof(elf_fpreg_t), .align = sizeof(elf_fpreg_t),
-		.get = fpregs_get, .set = fpregs_set, .active = fpregs_active
+		.get2 = fpregs_get, .set = fpregs_set, .active = fpregs_active
 	},
 };
 
-- 
2.11.0

