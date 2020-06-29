Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA420E4BC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgF2V22 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgF2Smn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DEC033C0A;
        Mon, 29 Jun 2020 11:26:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002Dtb-B5; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 08/41] [ia64] access_uarea(): don't bother with fpregs_[gs]et()
Date:   Mon, 29 Jun 2020 19:25:55 +0100
Message-Id: <20200629182628.529995-8-viro@ZenIV.linux.org.uk>
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

similar to previous commit...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/ptrace.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index e0813c8e4b47..eae7b094f608 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1811,7 +1811,6 @@ access_uarea(struct task_struct *child, unsigned long addr,
 	      unsigned long *data, int write_access)
 {
 	unsigned int pos = -1; /* an invalid value */
-	int ret;
 	unsigned long *ptr, regnum;
 
 	if ((addr & 0x7) != 0) {
@@ -1843,14 +1842,39 @@ access_uarea(struct task_struct *child, unsigned long addr,
 	}
 
 	if (pos != -1) {
-		if (write_access)
-			ret = fpregs_set(child, NULL, pos,
-				sizeof(unsigned long), data, NULL);
-		else
-			ret = fpregs_get(child, NULL, pos,
-				sizeof(unsigned long), data, NULL);
-		if (ret != 0)
-			return -1;
+		unsigned reg = pos / sizeof(elf_fpreg_t);
+		int which_half = (pos / sizeof(unsigned long)) & 1;
+
+		if (reg < 32) { /* fr2-fr31 */
+			struct unw_frame_info info;
+			elf_fpreg_t fpreg;
+
+			memset(&info, 0, sizeof(info));
+			unw_init_from_blocked_task(&info, child);
+			if (unw_unwind_to_user(&info) < 0)
+				return 0;
+
+			if (unw_get_fr(&info, reg, &fpreg))
+				return -1;
+			if (write_access) {
+				fpreg.u.bits[which_half] = *data;
+				if (unw_set_fr(&info, reg, fpreg))
+					return -1;
+			} else {
+				*data = fpreg.u.bits[which_half];
+			}
+		} else { /* fph */
+			elf_fpreg_t *p = &child->thread.fph[reg - 32];
+			unsigned long *bits = &p->u.bits[which_half];
+
+			ia64_sync_fph(child);
+			if (write_access)
+				*bits = *data;
+			else if (child->thread.flags & IA64_THREAD_FPH_VALID)
+				*data = *bits;
+			else
+				*data = 0;
+		}
 		return 0;
 	}
 
-- 
2.11.0

