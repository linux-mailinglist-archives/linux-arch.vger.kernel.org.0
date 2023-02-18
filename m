Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5076469BC72
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBRVRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBRVRC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:17:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0871632B;
        Sat, 18 Feb 2023 13:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676754969; x=1708290969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=I2MatxMVauhJIHVRqc02oKKO+hrjMuY4waDrBBWGcyY=;
  b=a744BWiVh7X9zWJictiASk82rIAWugzoKE17e/b+Eifb4PP0F+o2OSAf
   jQP6QfcuNMDQcIKOJEOki6AFLx9Yunr9X3UNsrlBwrLCyGyl9e46cMnYF
   i6yeHV+3ujiYmBbDqveFKGi/eCgK6lNuU1a6bmCpfizklQW0oTtfu8wY1
   44MI90StuD+Nbe4tQFcehHbVqGfo8NBia75uLSRTQWOmVvKrFRgE9Uiso
   dqWCW4SumSNLtvTNc8Ig6p9Blb6ylQCV5Jip1ir1kZfbYTT2w8tWLpDHO
   8Gb5DH+yyKVigBtnW2If1Kq59IGafCAcT1avqovkZx9tbVBcJ2s0/Iiy/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427226"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427226"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241598"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241598"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:01 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v6 07/41] x86: Move control protection handler to separate file
Date:   Sat, 18 Feb 2023 13:13:59 -0800
Message-Id: <20230218211433.26859-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Today the control protection handler is defined in traps.c and used only
for the kernel IBT feature. To reduce ifdeffery, move it to it's own file.
In future patches, functionality will be added to make this handler also
handle user shadow stack faults. So name the file cet.c.

No functional change.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v6:
 - Split move to cet.c and shadow stack enhancements to fault handler to
   separate files. (Kees)
---
 arch/x86/kernel/Makefile |  2 ++
 arch/x86/kernel/cet.c    | 76 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c  | 75 ---------------------------------------
 3 files changed, 78 insertions(+), 75 deletions(-)
 create mode 100644 arch/x86/kernel/cet.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index dd61752f4c96..92446f1dedd7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -144,6 +144,8 @@ obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
 
+obj-$(CONFIG_X86_CET)			+= cet.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
new file mode 100644
index 000000000000..7ad22b705b64
--- /dev/null
+++ b/arch/x86/kernel/cet.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ptrace.h>
+#include <asm/bugs.h>
+#include <asm/traps.h>
+
+static __ro_after_init bool ibt_fatal = true;
+
+extern void ibt_selftest_ip(void); /* code label defined in asm below */
+
+enum cp_error_code {
+	CP_EC        = (1 << 15) - 1,
+
+	CP_RET       = 1,
+	CP_IRET      = 2,
+	CP_ENDBR     = 3,
+	CP_RSTRORSSP = 4,
+	CP_SETSSBSY  = 5,
+
+	CP_ENCL	     = 1 << 15,
+};
+
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
+		pr_err("Unexpected #CP\n");
+		BUG();
+	}
+
+	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
+		return;
+
+	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
+		regs->ax = 0;
+		return;
+	}
+
+	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
+	if (!ibt_fatal) {
+		printk(KERN_DEFAULT CUT_HERE);
+		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		return;
+	}
+	BUG();
+}
+
+/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
+noinline bool ibt_selftest(void)
+{
+	unsigned long ret;
+
+	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
+	     ANNOTATE_RETPOLINE_SAFE
+	     "	jmp *%%rax\n\t"
+	     "ibt_selftest_ip:\n\t"
+	     UNWIND_HINT_FUNC
+	     ANNOTATE_NOENDBR
+	     "	nop\n\t"
+
+	     : "=a" (ret) : : "memory");
+
+	return !ret;
+}
+
+static int __init ibt_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		setup_clear_cpu_cap(X86_FEATURE_IBT);
+
+	if (!strcmp(str, "warn"))
+		ibt_fatal = false;
+
+	return 1;
+}
+
+__setup("ibt=", ibt_setup);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d317dc3d06a3..cc223e60aba2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -213,81 +213,6 @@ DEFINE_IDTENTRY(exc_overflow)
 	do_error_trap(regs, 0, "overflow", X86_TRAP_OF, SIGSEGV, 0, NULL);
 }
 
-#ifdef CONFIG_X86_KERNEL_IBT
-
-static __ro_after_init bool ibt_fatal = true;
-
-extern void ibt_selftest_ip(void); /* code label defined in asm below */
-
-enum cp_error_code {
-	CP_EC        = (1 << 15) - 1,
-
-	CP_RET       = 1,
-	CP_IRET      = 2,
-	CP_ENDBR     = 3,
-	CP_RSTRORSSP = 4,
-	CP_SETSSBSY  = 5,
-
-	CP_ENCL	     = 1 << 15,
-};
-
-DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
-		pr_err("Unexpected #CP\n");
-		BUG();
-	}
-
-	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
-		return;
-
-	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
-		regs->ax = 0;
-		return;
-	}
-
-	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
-	if (!ibt_fatal) {
-		printk(KERN_DEFAULT CUT_HERE);
-		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
-		return;
-	}
-	BUG();
-}
-
-/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
-noinline bool ibt_selftest(void)
-{
-	unsigned long ret;
-
-	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
-	     ANNOTATE_RETPOLINE_SAFE
-	     "	jmp *%%rax\n\t"
-	     "ibt_selftest_ip:\n\t"
-	     UNWIND_HINT_FUNC
-	     ANNOTATE_NOENDBR
-	     "	nop\n\t"
-
-	     : "=a" (ret) : : "memory");
-
-	return !ret;
-}
-
-static int __init ibt_setup(char *str)
-{
-	if (!strcmp(str, "off"))
-		setup_clear_cpu_cap(X86_FEATURE_IBT);
-
-	if (!strcmp(str, "warn"))
-		ibt_fatal = false;
-
-	return 1;
-}
-
-__setup("ibt=", ibt_setup);
-
-#endif /* CONFIG_X86_KERNEL_IBT */
-
 #ifdef CONFIG_X86_F00F_BUG
 void handle_invalid_op(struct pt_regs *regs)
 #else
-- 
2.17.1

