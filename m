Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA4038D0F4
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhEUWQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:16:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:55681 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhEUWPI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:15:08 -0400
IronPort-SDR: sK12sDNWfbZy4kVvMTiJ+06juY5x3jPVRB3U1VIU9+BtcPcDdKmhWmHSsyeDjhG/f7ayVznXM1
 X/g/xix31Fvw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201618782"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201618782"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:21 -0700
IronPort-SDR: 9grkf+SI7ppJ+5YNiyUxWQdmGXyuFHoYom/p4zvTvihQMWd68GcVfyfkZMWGVmqXfxwHXYHNwC
 ylQ1fAtfgsAw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441116233"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:21 -0700
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v27 25/31] x86/cet/shstk: Introduce shadow stack token setup/verify routines
Date:   Fri, 21 May 2021 15:12:05 -0700
Message-Id: <20210521221211.29077-26-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221211.29077-1-yu-cheng.yu@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A shadow stack restore token marks a restore point of the shadow stack, and
the address in a token must point directly above the token, which is within
the same shadow stack.  This is distinctively different from other pointers
on the shadow stack, since those pointers point to executable code area.

The restore token can be used as an extra protection for signal handling.
To deliver a signal, create a shadow stack restore token and put the token
and the signal restorer address on the shadow stack.  In sigreturn, verify
the token and restore from it the shadow stack pointer.

Introduce token setup and verify routines.  Also introduce WRUSS, which is
a kernel-mode instruction but writes directly to user shadow stack.  It is
used to construct user signal stack as described above.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v27:
- For shstk_check_rstor_token(), instead of an input param, use current
  shadow stack pointer.
- In response to comments, fix/simplify a few syntax/format issues.

v25:
- Update inline assembly syntax, use %[].
- Change token address from (unsigned long) to (u64/u32 __user *).
- Change -EPERM to -EFAULT.

 arch/x86/include/asm/cet.h           |   7 ++
 arch/x86/include/asm/special_insns.h |  30 ++++++
 arch/x86/kernel/shstk.c              | 133 +++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 4314a41ab3c9..aa533700ba31 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -21,6 +21,9 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 			     unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 void shstk_disable(void);
+int shstk_setup_rstor_token(bool ia32, unsigned long restorer,
+			    unsigned long *new_ssp);
+int shstk_check_rstor_token(bool ia32, unsigned long *new_ssp);
 #else
 static inline int shstk_setup(void) { return 0; }
 static inline int shstk_alloc_thread_stack(struct task_struct *p,
@@ -28,6 +31,10 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
 					   unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 static inline void shstk_disable(void) {}
+static inline int shstk_setup_rstor_token(bool ia32, unsigned long restorer,
+					  unsigned long *new_ssp) { return 0; }
+static inline int shstk_check_rstor_token(bool ia32,
+					  unsigned long *new_ssp) { return 0; }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2acd6cb62328..5b48c91fa8d4 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,36 @@ static inline void clwb(volatile void *__p)
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
index 8e5f772181b9..61ec300c1a97 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
 #include <asm/cet.h>
+#include <asm/special_insns.h>
 
 static void start_update_msrs(void)
 {
@@ -181,3 +182,135 @@ void shstk_disable(void)
 
 	shstk_free(current);
 }
+
+static unsigned long get_user_shstk_addr(void)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	unsigned long ssp = 0;
+
+	fpregs_lock();
+
+	if (fpregs_state_valid(fpu, smp_processor_id())) {
+		rdmsrl(MSR_IA32_PL3_SSP, ssp);
+	} else {
+		struct cet_user_state *p;
+
+		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
+		if (p)
+			ssp = p->user_ssp;
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
+static int create_rstor_token(bool ia32, unsigned long ssp,
+			       unsigned long *token_addr)
+{
+	unsigned long addr;
+
+	/* Aligned to 8 is aligned to 4, so test 8 first */
+	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
+		return -EINVAL;
+
+	addr = ALIGN_DOWN(ssp, 8) - 8;
+
+	/* Is the token for 64-bit? */
+	if (!ia32)
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
+int shstk_setup_rstor_token(bool ia32, unsigned long ret_addr,
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
+	err = create_rstor_token(ia32, ssp, &token_addr);
+	if (err)
+		return err;
+
+	if (ia32) {
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
+ * Verify token_addr points to a valid token, and then set *new_ssp
+ * according to the token.
+ */
+int shstk_check_rstor_token(bool proc32, unsigned long *new_ssp)
+{
+	unsigned long token_addr;
+	unsigned long token;
+	bool shstk32;
+
+	token_addr = get_user_shstk_addr();
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
+	/*
+	 * Restore address aligned?
+	 */
+	if ((!proc32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
+		return -EINVAL;
+
+	/*
+	 * Token placed properly?
+	 */
+	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
+		return -EINVAL;
+
+	*new_ssp = token;
+
+	return 0;
+}
-- 
2.21.0

