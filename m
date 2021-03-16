Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0741833CE39
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 07:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhCPG5q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 02:57:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:31159 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233790AbhCPG5N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 02:57:13 -0400
IronPort-SDR: Dq0y7RTLxeF2B/Ed0CXgq+68qXxh0HXwr09Kvce2GQOmVQKa2xSPWTDdShqTlqhKR0X0Ki2HSh
 wFnRCNjDPwqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="189260174"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="189260174"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:57:12 -0700
IronPort-SDR: NaWqtLNwjoxz1cY7Ox75cbdrrOG+hk9XyQPDsHE5yNF2A4zKN/T9br7P9Zt0SeASMrJCAAyT2F
 JcJ6ZcB9cqoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="511296086"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2021 23:57:12 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal stack overflow
Date:   Mon, 15 Mar 2021 23:52:14 -0700
Message-Id: <20210316065215.23768-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316065215.23768-1-chang.seok.bae@intel.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
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

Instead of calling on_sig_stack(), directly check the new stack pointer
whether in the bounds.

While the kernel allows new source code to discover and use a sufficient
alternate signal stack size, this check is still necessary to protect
binaries with insufficient alternate signal stack size from data
corruption.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Fixed the overflow check. (Andy Lutomirski)
* Updated the changelog.

Changes from v3:
* Updated the changelog (Borislav Petkov)

Changes from v2:
* Simplified the implementation (Jann Horn)
---
 arch/x86/kernel/signal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 0d24f64d0145..9a62604fbf63 100644
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
@@ -272,7 +275,8 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	 * If we are on the alternate signal stack and would overflow it, don't.
 	 * Return an always-bogus address instead so we will die with SIGSEGV.
 	 */
-	if (onsigstack && !likely(on_sig_stack(sp)))
+	if (onsigstack && unlikely(sp <= current->sas_ss_sp ||
+				   sp - current->sas_ss_sp > current->sas_ss_size))
 		return (void __user *)-1L;
 
 	/* save i387 and extended state */
-- 
2.17.1

