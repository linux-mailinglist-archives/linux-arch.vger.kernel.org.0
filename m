Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD59250D3D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgHYAbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:31:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:28750 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgHYAak (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:30:40 -0400
IronPort-SDR: gwqbSS0rL6CaDx7mGG+l47DFdeEAzogMte8oXw5tPg5Bei2NJG+1Y5CdcE1FwHbk8pPOdi4kCk
 oj8h2i9S5F8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="174053275"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="174053275"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:36 -0700
IronPort-SDR: sag8XSvzJd3jS7rbio7FMhabhFQ4iyYHrusWVG806CizD/87vdJCkYCrboG5zqXv07i8o0mNfU
 SVNQCLxxXIKQ==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443429324"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:36 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
Date:   Mon, 24 Aug 2020 17:26:41 -0700
Message-Id: <20200825002645.3658-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002645.3658-1-yu-cheng.yu@intel.com>
References: <20200825002645.3658-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:

    IA32_U_CET (user-mode CET settings) and
    IA32_PL3_SSP (user-mode Shadow Stack)

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/fpu/regset.h |  7 ++---
 arch/x86/kernel/fpu/regset.c      | 44 +++++++++++++++++++++++++++++++
 arch/x86/kernel/ptrace.c          | 16 +++++++++++
 include/uapi/linux/elf.h          |  1 +
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
index 4f928d6a367b..8622184d87f5 100644
--- a/arch/x86/include/asm/fpu/regset.h
+++ b/arch/x86/include/asm/fpu/regset.h
@@ -7,11 +7,12 @@
 
 #include <linux/regset.h>
 
-extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
+extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active,
+				cetregs_active;
 extern user_regset_get2_fn fpregs_get, xfpregs_get, fpregs_soft_get,
-				 xstateregs_get;
+				 xstateregs_get, cetregs_get;
 extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
-				 xstateregs_set;
+				 xstateregs_set, cetregs_set;
 
 /*
  * xstateregs_active == regset_fpregs_active. Please refer to the comment
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index c413756ba89f..8860d57eed35 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -149,6 +149,50 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+int cetregs_active(struct task_struct *target, const struct user_regset *regset)
+{
+#ifdef CONFIG_X86_INTEL_CET
+	if (target->thread.cet.shstk_size || target->thread.cet.ibt_enabled)
+		return regset->n;
+#endif
+	return 0;
+}
+
+int cetregs_get(struct task_struct *target, const struct user_regset *regset,
+		struct membuf to)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct cet_user_state *cetregs;
+
+	if (!boot_cpu_has(X86_FEATURE_SHSTK))
+		return -ENODEV;
+
+	fpu__prepare_read(fpu);
+	cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
+	if (!cetregs)
+		return -EFAULT;
+
+	return membuf_write(&to, cetregs, sizeof(struct cet_user_state));
+}
+
+int cetregs_set(struct task_struct *target, const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  const void *kbuf, const void __user *ubuf)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct cet_user_state *cetregs;
+
+	if (!boot_cpu_has(X86_FEATURE_SHSTK))
+		return -ENODEV;
+
+	fpu__prepare_write(fpu);
+	cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
+	if (!cetregs)
+		return -EFAULT;
+
+	return user_regset_copyin(&pos, &count, &kbuf, &ubuf, cetregs, 0, -1);
+}
+
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 5679aa3fdcb8..ea54317f087e 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -52,7 +52,9 @@ enum x86_regset {
 	REGSET_IOPERM64 = REGSET_XFP,
 	REGSET_XSTATE,
 	REGSET_TLS,
+	REGSET_CET64 = REGSET_TLS,
 	REGSET_IOPERM32,
+	REGSET_CET32,
 };
 
 struct pt_regs_offset {
@@ -1229,6 +1231,13 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.size = sizeof(long), .align = sizeof(long),
 		.active = ioperm_active, .regset_get = ioperm_get
 	},
+	[REGSET_CET64] = {
+		.core_note_type = NT_X86_CET,
+		.n = sizeof(struct cet_user_state) / sizeof(u64),
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = cetregs_active, .regset_get = cetregs_get,
+		.set = cetregs_set
+	},
 };
 
 static const struct user_regset_view user_x86_64_view = {
@@ -1284,6 +1293,13 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = ioperm_active, .regset_get = ioperm_get
 	},
+	[REGSET_CET32] = {
+		.core_note_type = NT_X86_CET,
+		.n = sizeof(struct cet_user_state) / sizeof(u64),
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = cetregs_active, .regset_get = cetregs_get,
+		.set = cetregs_set
+	},
 };
 
 static const struct user_regset_view user_x86_32_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index ca5875f384f6..d2a895369bcc 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -402,6 +402,7 @@ typedef struct elf64_shdr {
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+#define NT_X86_CET	0x203		/* x86 cet state */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.21.0

