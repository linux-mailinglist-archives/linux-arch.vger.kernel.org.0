Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564B3522A8
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhDAWOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:14:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:20480 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236020AbhDAWOd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:14:33 -0400
IronPort-SDR: fppWngKzR0ZKcPAIn20CTxyok2Xmsx9+dpeayuhnuF4w8BuRMr7qc1Lmm8Q7oYtuqt0lIynUjg
 cyVZxczsJFoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="256322604"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="256322604"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:29 -0700
IronPort-SDR: uUvZ559LvnbZb72AI8yapz1/IojTv+Q7saMhNrUEgXHYcM0A1aAwAxmJvb2YoHrhzkdwfhyYem
 9ioDIcKIY90Q==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394700358"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:23 -0700
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v24 7/9] x86/vdso: Introduce ENDBR macro
Date:   Thu,  1 Apr 2021 15:14:01 -0700
Message-Id: <20210401221403.32253-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221403.32253-1-yu-cheng.yu@intel.com>
References: <20210401221403.32253-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
component of CET.  IBT prevents attacks by ensuring that (most) indirect
branches and function calls may only land at ENDBR instructions.  Branches
that don't follow the rules will result in control flow (#CF) exceptions.

ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
instructions are inserted automatically by the compiler, but branch
targets written in assembly must have ENDBR added manually.

There are two ENDBR versions: endbr64 and endbr32.  The compilers (gcc and
clang) have _CET_ENDBR defined for the proper one.  Introduce ENDBR macro,
which equals the compiler macro when enabled, otherwise nothing.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/entry/vdso/Makefile |  1 +
 arch/x86/include/asm/vdso.h  | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index a773a5f03b63..be2ce5c8cb42 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -95,6 +95,7 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(
 
 ifdef CONFIG_X86_IBT
 $(vobjs) $(vobjs32): KBUILD_CFLAGS += -fcf-protection=branch
+$(vobjs) $(vobjs32): KBUILD_AFLAGS += -fcf-protection=branch
 endif
 
 #
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 98aa103eb4ab..0128486ba09f 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -52,6 +52,23 @@ extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 extern bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 				 unsigned long error_code,
 				 unsigned long fault_addr);
-#endif /* __ASSEMBLER__ */
+#else /* __ASSEMBLER__ */
+
+/*
+ * ENDBR is an instruction for the Indirect Branch Tracking (IBT) component
+ * of CET.  IBT prevents attacks by ensuring that (most) indirect branches
+ * function calls may only land at ENDBR instructions.  Branches that don't
+ * follow the rules will result in control flow (#CF) exceptions.
+ * ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
+ * instructions are inserted automatically by the compiler, but branch
+ * targets written in assembly must have ENDBR added manually.
+ */
+#ifdef __CET__
+#include <cet.h>
+#define ENDBR _CET_ENDBR
+#else
+#define ENDBR
+#endif
 
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_VDSO_H */
-- 
2.21.0

