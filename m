Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D56520E4A9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbgF2V1k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FCDC033C15;
        Mon, 29 Jun 2020 11:26:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyUA-002DuT-71; Mon, 29 Jun 2020 18:26:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 16/41] arm64: sanitize compat_ptrace_write_user()
Date:   Mon, 29 Jun 2020 19:26:03 +0100
Message-Id: <20200629182628.529995-16-viro@ZenIV.linux.org.uk>
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

don't bother with copy_regset_from_user() (not to mention
set_fs())

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d5f3da5197a1..9f769e862f68 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1553,8 +1553,8 @@ static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
 static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 				    compat_ulong_t val)
 {
-	int ret;
-	mm_segment_t old_fs = get_fs();
+	struct pt_regs newregs = *task_pt_regs(tsk);
+	unsigned int idx = off / 4;
 
 	if (off & 3 || off >= COMPAT_USER_SZ)
 		return -EIO;
@@ -1562,14 +1562,25 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
 	if (off >= sizeof(compat_elf_gregset_t))
 		return 0;
 
-	set_fs(KERNEL_DS);
-	ret = copy_regset_from_user(tsk, &user_aarch32_view,
-				    REGSET_COMPAT_GPR, off,
-				    sizeof(compat_ulong_t),
-				    &val);
-	set_fs(old_fs);
+	switch (idx) {
+	case 15:
+		newregs.pc = val;
+		break;
+	case 16:
+		newregs.pstate = compat_psr_to_pstate(val);
+		break;
+	case 17:
+		newregs.orig_x0 = val;
+		break;
+	default:
+		newregs.regs[idx] = val;
+	}
+
+	if (!valid_user_regs(&newregs.user_regs, tsk))
+		return -EINVAL;
 
-	return ret;
+	*task_pt_regs(tsk) = newregs;
+	return 0;
 }
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-- 
2.11.0

