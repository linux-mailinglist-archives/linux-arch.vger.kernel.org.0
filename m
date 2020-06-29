Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C020D279
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgF2Sti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F2C033C0B;
        Mon, 29 Jun 2020 11:26:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002Dth-DQ; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 09/41] sparc64: switch genregs32_get() to use of get_from_target()
Date:   Mon, 29 Jun 2020 19:25:56 +0100
Message-Id: <20200629182628.529995-9-viro@ZenIV.linux.org.uk>
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

... for fetching the register window from target's stack, rather
than open-coding it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/kernel/ptrace_64.c | 59 ++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 7122efb4b1cc..f7b2ddfc81d6 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -518,10 +518,10 @@ static int genregs32_get(struct task_struct *target,
 			 void *kbuf, void __user *ubuf)
 {
 	const struct pt_regs *regs = task_pt_regs(target);
-	compat_ulong_t __user *reg_window;
 	compat_ulong_t *k = kbuf;
 	compat_ulong_t __user *u = ubuf;
-	compat_ulong_t reg;
+	u32 uregs[16];
+	u32 reg;
 
 	if (target == current)
 		flushw_user();
@@ -533,52 +533,25 @@ static int genregs32_get(struct task_struct *target,
 		for (; count > 0 && pos < 16; count--)
 			*k++ = regs->u_regs[pos++];
 
-		reg_window = (compat_ulong_t __user *) regs->u_regs[UREG_I6];
-		reg_window -= 16;
-		if (target == current) {
-			for (; count > 0 && pos < 32; count--) {
-				if (get_user(*k++, &reg_window[pos++]))
-					return -EFAULT;
-			}
-		} else {
-			for (; count > 0 && pos < 32; count--) {
-				if (access_process_vm(target,
-						      (unsigned long)
-						      &reg_window[pos],
-						      k, sizeof(*k),
-						      FOLL_FORCE)
-				    != sizeof(*k))
-					return -EFAULT;
-				k++;
-				pos++;
-			}
+		if (count && pos < 32) {
+			if (get_from_target(target, regs->u_regs[UREG_I6],
+					uregs, sizeof(uregs)))
+				return -EFAULT;
+			for (; count > 0 && pos < 32; count--)
+				*k++ = uregs[pos++ - 16];
+
 		}
 	} else {
-		for (; count > 0 && pos < 16; count--) {
+		for (; count > 0 && pos < 16; count--)
 			if (put_user((compat_ulong_t) regs->u_regs[pos++], u++))
 				return -EFAULT;
-		}
-
-		reg_window = (compat_ulong_t __user *) regs->u_regs[UREG_I6];
-		reg_window -= 16;
-		if (target == current) {
-			for (; count > 0 && pos < 32; count--) {
-				if (get_user(reg, &reg_window[pos++]) ||
-				    put_user(reg, u++))
-					return -EFAULT;
-			}
-		} else {
-			for (; count > 0 && pos < 32; count--) {
-				if (access_process_vm(target,
-						      (unsigned long)
-						      &reg_window[pos++],
-						      &reg, sizeof(reg),
-						      FOLL_FORCE)
-				    != sizeof(reg))
-					return -EFAULT;
-				if (put_user(reg, u++))
+		if (count && pos < 32) {
+			if (get_from_target(target, regs->u_regs[UREG_I6],
+					uregs, sizeof(uregs)))
+				return -EFAULT;
+			for (; count > 0 && pos < 32; count--)
+				if (put_user(uregs[pos++ - 16], u++))
 					return -EFAULT;
-			}
 		}
 	}
 	while (count > 0) {
-- 
2.11.0

