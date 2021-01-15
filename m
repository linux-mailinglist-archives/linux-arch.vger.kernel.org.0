Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4622F8762
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbhAOVQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:16:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:45834 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbhAOVQi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Jan 2021 16:16:38 -0500
IronPort-SDR: b53fLE8qeGQ/NaGRf/xXQBr0r3g2DKTTuBYLiCPsRsCgEwehQbLOwAghQgxB/83Bmx1MTPBab4
 QS9+/SdIPLvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="166277109"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="166277109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:15:15 -0800
IronPort-SDR: n7CKBxPaxKjx3ZV66DcDZNB4rCprG6ugLaAR6/NGBPP3U0WkIxmg9lSdYhjcH8TYK8vmeXjFvC
 wymICGm5DwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="401418973"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2021 13:15:15 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v4 3/4] x86/signal: Detect and prevent an alternate signal stack overflow
Date:   Fri, 15 Jan 2021 13:10:37 -0800
Message-Id: <20210115211038.2072-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115211038.2072-1-chang.seok.bae@intel.com>
References: <20210115211038.2072-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel pushes context on to the userspace stack to prepare for the
user's signal handler. When the user has supplied an alternate signal
stack, via sigaltstack(2), it is easy for the kernel to verify that the
stack size is sufficient for the current hardware context.

Check if writing the hardware context to the alternate stack will exceed
it's size. If yes, then instead of corrupting user-data and proceeding with
the original signal handler, an immediate SIGSEGV signal is delivered.

While previous patches in this series allow new source code to discover and
use a sufficient alternate signal stack size, this check is still necessary
to protect binaries with insufficient alternate signal stack size from data
corruption.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Updated the changelog (Borislav Petkov)

Changes from v2:
* Simplified the implementation (Jann Horn)
---
 arch/x86/kernel/signal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 761d856f8ef7..91056a940271 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -242,7 +242,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int onsigstack = on_sig_stack(sp);
+	bool onsigstack = on_sig_stack(sp);
 	int ret;
 
 	/* redzone */
@@ -251,8 +251,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(sp) == 0)
+		if (sas_ss_flags(sp) == 0) {
 			sp = current->sas_ss_sp + current->sas_ss_size;
+			/* On the alternate signal stack */
+			onsigstack = true;
+		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
 		   !onsigstack &&
 		   regs->ss != __USER_DS &&
-- 
2.17.1

