Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E014A3A2A
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356767AbiA3VZK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:25:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:9102 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356858AbiA3VXn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577823; x=1675113823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=EqRq2q1dVEJOlLae8vGVwGnmb22Q/jCe3uza6jx7E4E=;
  b=SEQPdXswVuKKQR0j59zigkANcH/Qo6D4Msfp7s96CsJ/RSjL6lQVDcZy
   I47gVAkAqI+NAhKrIS0gtE6K55L7pqne3k94bTSU2qAotf+H0paR80j+w
   6/F6fiJpMHpssu2CTmpsRZA7nte6OhCqkuX7E7Ri0T3c52izhVH8Lzdya
   E6ovBDySn++DdtpPfjm8Vh4KtGMWn/VfwEN6d9wXdXVsFQKAhPTkYNIKA
   OBBMZQEGM8P5Zeb/NEaQ9E6cq+aY8njcmEFkNGgXCgNkKbX3JAXeL2/CM
   degvzXxGDkWKVw4djKlnoolrVX45K7Ra6XnxXoCOXhOwJ28wc4IKDpqDy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310685825"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="310685825"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856960"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:09 -0800
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 29/35] x86/cet/shstk: Introduce shadow stack token setup/verify routines
Date:   Sun, 30 Jan 2022 13:18:32 -0800
Message-Id: <20220130211838.8382-30-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

A shadow stack restore token marks a restore point of the shadow stack, and
the address in a token must point directly above the token, which is within
the same shadow stack.  This is distinctively different from other pointers
on the shadow stack, since those pointers point to executable code area.

Introduce token setup and verify routines.  Also introduce WRUSS, which is
a kernel-mode instruction but writes directly to user shadow stack.  It is
used to construct user signal stack as described above.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v1:
 - Use xsave helpers.

Yu-cheng v30:
 - Update commit log, remove description about signals.
 - Update various comments.
 - Remove variable 'ssp' init and adjust return value accordingly.
 - Check get_user_shstk_addr() return value.
 - Replace 'ia32' with 'proc32'.

Yu-cheng v29:
 - Update comments for the use of get_xsave_addr().

Yu-cheng v28:
 - Add comments for get_xsave_addr().

Yu-cheng v27:
 - For shstk_check_rstor_token(), instead of an input param, use current
   shadow stack pointer.
 - In response to comments, fix/simplify a few syntax/format issues.

 arch/x86/include/asm/cet.h           |   7 ++
 arch/x86/include/asm/special_insns.h |  30 +++++++
 arch/x86/kernel/shstk.c              | 122 +++++++++++++++++++++++++++
 3 files changed, 159 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 63ee8b45080d..6e8a7a807dcc 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -19,6 +19,9 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 void shstk_free(struct task_struct *p);
 int shstk_disable(void);
 void reset_thread_shstk(void);
+int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
+			    unsigned long *new_ssp);
+int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp);
 #else
 static inline void shstk_setup(void) {}
 static inline int shstk_alloc_thread_stack(struct task_struct *p,
@@ -27,6 +30,10 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 static inline void shstk_free(struct task_struct *p) {}
 static inline void shstk_disable(void) {}
 static inline void reset_thread_shstk(void) {}
+static inline int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
+					  unsigned long *new_ssp) { return 0; }
+static inline int shstk_check_rstor_token(bool proc32,
+					  unsigned long *new_ssp) { return 0; }
 #endif /* CONFIG_X86_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a3de0d..f45f378ca1fc 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -222,6 +222,36 @@ static inline void clwb(volatile void *__p)
 		: [pax] "a" (p));
 }
 
+#ifdef CONFIG_X86_SHADOW_STACK
+static inline int write_user_shstk_32(u32 __user *addr, u32 val)
+{
+	if (WARN_ONCE(!IS_ENABLED(CONFIG_IA32_EMULATION) &&
+		      !IS_ENABLED(CONFIG_X86_X32),
+		      "%s used but not supported.\n", __func__)) {
+		return -EFAULT;
+	}
+
+	asm_volatile_goto("1: wrussd %[val], (%[addr])\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: [addr] "r" (addr), [val] "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EFAULT;
+}
+
+static inline int write_user_shstk_64(u64 __user *addr, u64 val)
+{
+	asm_volatile_goto("1: wrussq %[val], (%[addr])\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: [addr] "r" (addr), [val] "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EFAULT;
+}
+#endif /* CONFIG_X86_SHADOW_STACK */
+
 #define nop() asm volatile ("nop")
 
 static inline void serialize(void)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 358f24e806cc..e0caab50ca77 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -23,6 +23,33 @@
 #include <asm/special_insns.h>
 #include <asm/fpu/api.h>
 
+/*
+ * Create a restore token on the shadow stack.  A token is always 8-byte
+ * and aligned to 8.
+ */
+static int create_rstor_token(bool proc32, unsigned long ssp,
+			      unsigned long *token_addr)
+{
+	unsigned long addr;
+
+	/* Aligned to 8 is aligned to 4, so test 8 first */
+	if ((!proc32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
+		return -EINVAL;
+
+	addr = ALIGN_DOWN(ssp, 8) - 8;
+
+	/* Is the token for 64-bit? */
+	if (!proc32)
+		ssp |= BIT(0);
+
+	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
+		return -EFAULT;
+
+	*token_addr = addr;
+
+	return 0;
+}
+
 static unsigned long alloc_shstk(unsigned long size)
 {
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
@@ -213,3 +240,98 @@ int shstk_disable(void)
 	shstk_free(current);
 	return 0;
 }
+
+static unsigned long get_user_shstk_addr(void)
+{
+	void *xstate;
+	unsigned long long ssp;
+
+	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
+
+	xsave_rdmsrl(xstate, MSR_IA32_PL3_SSP, &ssp);
+
+	end_update_xsave_msrs();
+
+	return ssp;
+}
+
+/*
+ * Create a restore token on shadow stack, and then push the user-mode
+ * function return address.
+ */
+int shstk_setup_rstor_token(bool proc32, unsigned long ret_addr,
+			    unsigned long *new_ssp)
+{
+	struct thread_shstk *shstk = &current->thread.shstk;
+	unsigned long ssp, token_addr;
+	int err;
+
+	if (!shstk->size)
+		return 0;
+
+	if (!ret_addr)
+		return -EINVAL;
+
+	ssp = get_user_shstk_addr();
+	if (!ssp)
+		return -EINVAL;
+
+	err = create_rstor_token(proc32, ssp, &token_addr);
+	if (err)
+		return err;
+
+	if (proc32) {
+		ssp = token_addr - sizeof(u32);
+		err = write_user_shstk_32((u32 __user *)ssp, (u32)ret_addr);
+	} else {
+		ssp = token_addr - sizeof(u64);
+		err = write_user_shstk_64((u64 __user *)ssp, (u64)ret_addr);
+	}
+
+	if (!err)
+		*new_ssp = ssp;
+
+	return err;
+}
+
+/*
+ * Verify the user shadow stack has a valid token on it, and then set
+ * *new_ssp according to the token.
+ */
+int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp)
+{
+	unsigned long token_addr;
+	unsigned long token;
+	bool shstk32;
+
+	token_addr = get_user_shstk_addr();
+	if (!token_addr)
+		return -EINVAL;
+
+	if (get_user(token, (unsigned long __user *)token_addr))
+		return -EFAULT;
+
+	/* Is mode flag correct? */
+	shstk32 = !(token & BIT(0));
+	if (proc32 ^ shstk32)
+		return -EINVAL;
+
+	/* Is busy flag set? */
+	if (token & BIT(1))
+		return -EINVAL;
+
+	/* Mask out flags */
+	token &= ~3UL;
+
+	/* Restore address aligned? */
+	if ((!proc32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
+		return -EINVAL;
+
+	/* Token placed properly? */
+	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
+		return -EINVAL;
+
+	*new_ssp = token;
+
+	return 0;
+}
-- 
2.17.1

