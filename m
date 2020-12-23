Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FB2E1187
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 02:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgLWB6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Dec 2020 20:58:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:49021 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgLWB6b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Dec 2020 20:58:31 -0500
IronPort-SDR: dIrxy9JpBdxncSI3AvF6UfODRvY3ZoRPwlnvdhqc/Ypux8wU0tqV35+WCjlVrBkO8D1HhdtZ5P
 gHLitJUhP3ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="237508810"
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; 
   d="scan'208";a="237508810"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 17:57:39 -0800
IronPort-SDR: 2iC4ku/AQH/vA/7CKujV/e6uES2g8t+A54AKTmW/yAhBKhPS2diVEsV7ahGjj8Mw0pzqrXBp87
 baQzAs0ovHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,440,1599548400"; 
   d="scan'208";a="457755742"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2020 17:57:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 3/4] x86/signal: Prevent an alternate stack overflow before a signal delivery
Date:   Tue, 22 Dec 2020 17:53:11 -0800
Message-Id: <20201223015312.4882-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223015312.4882-1-chang.seok.bae@intel.com>
References: <20201223015312.4882-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel pushes data on the userspace stack when entering a signal. If
using a sigaltstack(), the kernel precisely knows the user stack size.

When the kernel knows that the user stack is too small, avoid the overflow
and do an immediate SIGSEGV instead.

This overflow is known to occur on systems with large XSAVE state. The
effort to increase the size typically used for altstacks reduces the
frequency of these overflows, but this approach is still useful for legacy
binaries.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
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

