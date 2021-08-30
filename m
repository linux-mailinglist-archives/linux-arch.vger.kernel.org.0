Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C645D3FBBDD
	for <lists+linux-arch@lfdr.de>; Mon, 30 Aug 2021 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhH3SSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Aug 2021 14:18:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:43858 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238694AbhH3SR2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Aug 2021 14:17:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205460115"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="205460115"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:16:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530533355"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:16:21 -0700
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
Subject: [PATCH v30 26/32] x86/cet/shstk: Introduce shadow stack token setup/verify routines
Date:   Mon, 30 Aug 2021 11:15:22 -0700
Message-Id: <20210830181528.1569-27-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210830181528.1569-1-yu-cheng.yu@intel.com>
References: <20210830181528.1569-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A shadow stack restore token marks a restore point of the shadow stack, and
the address in a token must point directly above the token, which is within
the same shadow stack.  This is distinctively different from other pointers
on the shadow stack, since those pointers point to executable code area.

Introduce token setup and verify routines.  Also introduce WRUSS, which is
a kernel-mode instruction but writes directly to user shadow stack.  It is
used to construct user signal stack as described above.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v30:
- Update commit log, remove description about signals.
- Update various comments.
- Remove variable 'ssp' init and adjust return value accordingly.
- Check get_user_shstk_addr() return value.
- Replace 'ia32' with 'proc32'.

v29:
- Update comments for the use of get_xsave_addr().

v28:
- Add comments for get_xsave_addr().

v27:
- For shstk_check_rstor_token(), instead of an input param, use current
  shadow stack pointer.
- In response to comments, fix/simplify a few syntax/format issues.

v25:
- Update inline assembly syntax, use %[].
- Change token address from (unsigned long) to (u64/u32 __user *).
- Change -EPERM to -EFAULT.
---
 arch/x86/include/asm/cet.h           |   7 ++
 arch/x86/include/asm/special_insns.h |  30 ++++++
 arch/x86/kernel/shstk.c              | 139 +++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index cae76b8241b0..e6c85a6f7cec 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -18,6 +18,9 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 			     unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 void shstk_disable(void);
+int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
+			    unsigned long *new_ssp);
+int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp);
 #else
 static inline int shstk_setup(void) { return 0; }
 static inline int shstk_alloc_thread_stack(struct task_struct *p,
@@ -25,6 +28,10 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 					   unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 static inline void shstk_disable(void) {}
+static inline int shstk_setup_rstor_token(bool proc32, unsigned long restorer,
+					  unsigned long *new_ssp) { return 0; }
+static inline int shstk_check_rstor_token(bool proc32,
+					  unsigned long *new_ssp) { return 0; }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f3fbb84ff8a7..c6df3773b44c 100644
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
index ee80ed0316da..986a2b4b4b0b 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
 #include <asm/cet.h>
+#include <asm/special_insns.h>
 
 static void start_update_msrs(void)
 {
@@ -193,3 +194,141 @@ void shstk_disable(void)
 
 	shstk_free(current);
 }
+
+static unsigned long get_user_shstk_addr(void)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	unsigned long ssp;
+
+	fpregs_lock();
+
+	if (fpregs_state_valid(fpu, smp_processor_id())) {
+		rdmsrl(MSR_IA32_PL3_SSP, ssp);
+	} else {
+		struct cet_user_state *p;
+
+		/*
+		 * When the xstates are valid and get_xsave_addr() of
+		 * XFEAUTRE_CET_USER returns null, the feature is in init
+		 * state.  This can happen when shadow stack is enabled,
+		 * but the shadow stack component in memory is corrupted.
+		 */
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
+		if (p)
+			ssp = p->user_ssp;
+		else
+			ssp = 0;
+	}
+
+	fpregs_unlock();
+
+	return ssp;
+}
+
+/*
+ * Create a restore token on the shadow stack.  A token is always 8-byte
+ * and aligned to 8.
+ */
+static int create_rstor_token(bool proc32, unsigned long ssp,
+			       unsigned long *token_addr)
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
2.21.0

