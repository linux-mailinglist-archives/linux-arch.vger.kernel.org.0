Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854C83FBC3C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Aug 2021 20:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhH3SYZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Aug 2021 14:24:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:57612 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238530AbhH3SYF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Aug 2021 14:24:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="303905713"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="303905713"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:23:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="540650954"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:23:09 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v30 04/10] x86/cet/ibt: Disable IBT for ia32
Date:   Mon, 30 Aug 2021 11:22:15 -0700
Message-Id: <20210830182221.3535-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210830182221.3535-1-yu-cheng.yu@intel.com>
References: <20210830182221.3535-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In a signal, a task's IBT status needs to be saved to the signal frame, and
later restored in sigreturn.  For the purpose, previous versions of the
series add a new struct to the signal frame.  However, a new signal frame
format (or re-using a reserved space) introduces complex compatibility
issues.

In the discussion (see link below), Andy Lutomirski proposed using a
ucontext flag.  The approach is clean and eliminates most compatibility
issues.

However, a legacy IA32 signal frame does not have ucontext and cannot
support a uc flag.  Thus,

- Disable IBT for ia32.
- In ia32 sigreturn, verify ibt is disabled.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/linux-api/f6e61dae-9805-c855-8873-7481ceb7ea79@intel.com/
---
 arch/x86/ia32/ia32_signal.c |  7 +++++++
 arch/x86/include/asm/elf.h  | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 77d0fa90cc19..946039cb3150 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -104,6 +104,13 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
 	sigset_t set;
 
+	/*
+	 * Verify legacy sigreturn does not have IBT enabled.
+	 */
+#ifdef CONFIG_X86_IBT
+	if (current->thread.shstk.ibt)
+		goto badframe;
+#endif
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 3281a3d01bd2..cf9eeb30c00c 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -6,6 +6,7 @@
  * ELF register definitions..
  */
 #include <linux/thread_info.h>
+#include <uapi/linux/elf.h>
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
@@ -403,7 +404,17 @@ struct arch_elf_state {
 }
 
 #define arch_elf_pt_proc(ehdr, phdr, elf, interp, state) (0)
-#define arch_check_elf(ehdr, interp, interp_ehdr, state) (0)
+static inline int arch_check_elf(void *ehdr, bool interp,
+				 void *interp_ehdr,
+				 struct arch_elf_state *state)
+{
+	/*
+	 * Disable IBT for ia32
+	 */
+	if (elf_check_arch_ia32((struct elf32_hdr *)ehdr))
+		state->gnu_property &= ~GNU_PROPERTY_X86_FEATURE_1_IBT;
+	return 0;
+}
 
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
-- 
2.21.0

