Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED47820D22E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgF2SrU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D2C033C2C;
        Mon, 29 Jun 2020 11:26:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUD-002DxR-O7; Mon, 29 Jun 2020 18:26:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 36/41] parisc: switch to ->get2()
Date:   Mon, 29 Jun 2020 19:26:23 +0100
Message-Id: <20200629182628.529995-36-viro@ZenIV.linux.org.uk>
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
 arch/parisc/kernel/ptrace.c | 84 +++++++++------------------------------------
 1 file changed, 16 insertions(+), 68 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index b51418ad8655..6dd7a4debb9c 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -391,31 +391,11 @@ void do_syscall_trace_exit(struct pt_regs *regs)
 
 static int fpr_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
 	struct pt_regs *regs = task_regs(target);
-	__u64 *k = kbuf;
-	__u64 __user *u = ubuf;
-	__u64 reg;
-
-	pos /= sizeof(reg);
-	count /= sizeof(reg);
-
-	if (kbuf)
-		for (; count > 0 && pos < ELF_NFPREG; --count)
-			*k++ = regs->fr[pos++];
-	else
-		for (; count > 0 && pos < ELF_NFPREG; --count)
-			if (__put_user(regs->fr[pos++], u++))
-				return -EFAULT;
 
-	kbuf = k;
-	ubuf = u;
-	pos *= sizeof(reg);
-	count *= sizeof(reg);
-	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					ELF_NFPREG * sizeof(reg), -1);
+	return membuf_write(&to, regs->fr, ELF_NFPREG * sizeof(__u64));
 }
 
 static int fpr_set(struct task_struct *target,
@@ -527,30 +507,14 @@ static void set_reg(struct pt_regs *regs, int num, unsigned long val)
 
 static int gpr_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
 	struct pt_regs *regs = task_regs(target);
-	unsigned long *k = kbuf;
-	unsigned long __user *u = ubuf;
-	unsigned long reg;
+	unsigned int pos;
 
-	pos /= sizeof(reg);
-	count /= sizeof(reg);
-
-	if (kbuf)
-		for (; count > 0 && pos < ELF_NGREG; --count)
-			*k++ = get_reg(regs, pos++);
-	else
-		for (; count > 0 && pos < ELF_NGREG; --count)
-			if (__put_user(get_reg(regs, pos++), u++))
-				return -EFAULT;
-	kbuf = k;
-	ubuf = u;
-	pos *= sizeof(reg);
-	count *= sizeof(reg);
-	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					ELF_NGREG * sizeof(reg), -1);
+	for (pos = 0; pos < ELF_NGREG; pos++)
+		membuf_store(&to, get_reg(regs, pos));
+	return 0;
 }
 
 static int gpr_set(struct task_struct *target,
@@ -588,12 +552,12 @@ static const struct user_regset native_regsets[] = {
 	[REGSET_GENERAL] = {
 		.core_note_type = NT_PRSTATUS, .n = ELF_NGREG,
 		.size = sizeof(long), .align = sizeof(long),
-		.get = gpr_get, .set = gpr_set
+		.get2 = gpr_get, .set = gpr_set
 	},
 	[REGSET_FP] = {
 		.core_note_type = NT_PRFPREG, .n = ELF_NFPREG,
 		.size = sizeof(__u64), .align = sizeof(__u64),
-		.get = fpr_get, .set = fpr_set
+		.get2 = fpr_get, .set = fpr_set
 	}
 };
 
@@ -607,31 +571,15 @@ static const struct user_regset_view user_parisc_native_view = {
 
 static int gpr32_get(struct task_struct *target,
 		     const struct user_regset *regset,
-		     unsigned int pos, unsigned int count,
-		     void *kbuf, void __user *ubuf)
+		     struct membuf to)
 {
 	struct pt_regs *regs = task_regs(target);
-	compat_ulong_t *k = kbuf;
-	compat_ulong_t __user *u = ubuf;
-	compat_ulong_t reg;
+	unsigned int pos;
 
-	pos /= sizeof(reg);
-	count /= sizeof(reg);
+	for (pos = 0; pos < ELF_NGREG; pos++)
+		membuf_store(&to, (compat_ulong_t)get_reg(regs, pos));
 
-	if (kbuf)
-		for (; count > 0 && pos < ELF_NGREG; --count)
-			*k++ = get_reg(regs, pos++);
-	else
-		for (; count > 0 && pos < ELF_NGREG; --count)
-			if (__put_user((compat_ulong_t) get_reg(regs, pos++), u++))
-				return -EFAULT;
-
-	kbuf = k;
-	ubuf = u;
-	pos *= sizeof(reg);
-	count *= sizeof(reg);
-	return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
-					ELF_NGREG * sizeof(reg), -1);
+	return 0;
 }
 
 static int gpr32_set(struct task_struct *target,
@@ -672,12 +620,12 @@ static const struct user_regset compat_regsets[] = {
 	[REGSET_GENERAL] = {
 		.core_note_type = NT_PRSTATUS, .n = ELF_NGREG,
 		.size = sizeof(compat_long_t), .align = sizeof(compat_long_t),
-		.get = gpr32_get, .set = gpr32_set
+		.get2 = gpr32_get, .set = gpr32_set
 	},
 	[REGSET_FP] = {
 		.core_note_type = NT_PRFPREG, .n = ELF_NFPREG,
 		.size = sizeof(__u64), .align = sizeof(__u64),
-		.get = fpr_get, .set = fpr_set
+		.get2 = fpr_get, .set = fpr_set
 	}
 };
 
-- 
2.11.0

