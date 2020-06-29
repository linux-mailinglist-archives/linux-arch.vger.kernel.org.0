Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5E20E4C9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgF2V26 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgF2Smm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CDEC033C0E;
        Mon, 29 Jun 2020 11:26:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpyU9-002DtV-8b; Mon, 29 Jun 2020 18:26:29 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 07/41] [ia64] access_uarea(): stop bothering with gpregs_[gs]et()
Date:   Mon, 29 Jun 2020 19:25:54 +0100
Message-Id: <20200629182628.529995-7-viro@ZenIV.linux.org.uk>
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

We know this won't be called for child == current, so we don't need
to bother with callbacks, etc. - just do unw_init_from_blocked_task(),
unw_unwind_to_user() and do the payload of gpregs_[gs]et().  For
one register.  Which is to say, access_elf_reg().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/ptrace.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index be635f6f93c9..e0813c8e4b47 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1936,15 +1936,14 @@ access_uarea(struct task_struct *child, unsigned long addr,
 	}
 
 	if (pos != -1) {
-		if (write_access)
-			ret = gpregs_set(child, NULL, pos,
-				sizeof(unsigned long), data, NULL);
-		else
-			ret = gpregs_get(child, NULL, pos,
-				sizeof(unsigned long), data, NULL);
-		if (ret != 0)
-			return -1;
-		return 0;
+		struct unw_frame_info info;
+
+		memset(&info, 0, sizeof(info));
+		unw_init_from_blocked_task(&info, child);
+		if (unw_unwind_to_user(&info) < 0)
+			return 0;
+
+		return access_elf_reg(child, &info, pos, data, write_access);
 	}
 
 	/* access debug registers */
-- 
2.11.0

