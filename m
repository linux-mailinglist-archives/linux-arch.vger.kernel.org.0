Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866C435225E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhDAWMs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:12:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:34674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235858AbhDAWML (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:12:11 -0400
IronPort-SDR: 3qIEJHZxUjuhQ7ipo78W/DpuFefgiYO6ZOMTxDUu6p+7WrzcXm3ZkDwDsbyP7lI8MIWGijAy8O
 tcgKZ04I9Hwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084631"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084631"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:26 -0700
IronPort-SDR: KLJM9BnUYLRXJHaSY7MgXOzQRarqdFKppyMQWVh/PnFvPPFGxm9HkclOD35O7+bGXyonuT7Y8V
 Cqq+8xAEuupA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513946"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:26 -0700
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
Subject: [PATCH v24 24/30] x86/cet/shstk: Introduce shadow stack token setup/verify routines
Date:   Thu,  1 Apr 2021 15:10:58 -0700
Message-Id: <20210401221104.31584-25-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
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
 arch/x86/include/asm/cet.h           |   9 ++
 arch/x86/include/asm/special_insns.h |  32 +++++++
 arch/x86/kernel/shstk.c              | 126 +++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 8b83ded577cc..ef6155213b7e 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -20,6 +20,10 @@ int shstk_setup_thread(struct task_struct *p, unsigned long clone_flags,
 		       unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 void shstk_disable(void);
+int shstk_setup_rstor_token(bool ia32, unsigned long rstor,
+			    unsigned long *token_addr, unsigned long *new_ssp);
+int shstk_check_rstor_token(bool ia32, unsigned long token_addr,
+			    unsigned long *new_ssp);
 #else
 static inline int shstk_setup(void) { return 0; }
 static inline int shstk_setup_thread(struct task_struct *p,
@@ -27,6 +31,11 @@ static inline int shstk_setup_thread(struct task_struct *p,
 				     unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 static inline void shstk_disable(void) {}
+static inline int shstk_setup_rstor_token(bool ia32, unsigned long rstor,
+					  unsigned long *token_addr,
+					  unsigned long *new_ssp) { return 0; }
+static inline int shstk_check_rstor_token(bool ia32, unsigned long token_addr,
+					  unsigned long *new_ssp) { return 0; }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 1d3cbaef4bb7..c41c371f6c7d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,6 +234,38 @@ static inline void clwb(volatile void *__p)
 		: [pax] "a" (p));
 }
 
+#ifdef CONFIG_X86_SHADOW_STACK
+#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
+static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
+{
+	asm_volatile_goto("1: wrussd %1, (%0)\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: "r" (addr), "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EPERM;
+}
+#else
+static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
+{
+	WARN_ONCE(1, "%s used but not supported.\n", __func__);
+	return -EFAULT;
+}
+#endif
+
+static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
+{
+	asm_volatile_goto("1: wrussq %1, (%0)\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: "r" (addr), "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EPERM;
+}
+#endif /* CONFIG_X86_SHADOW_STACK */
+
 #define nop() asm volatile ("nop")
 
 static inline void serialize(void)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 9c80785535b9..6fa98b228ee3 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -20,6 +20,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
 #include <asm/cet.h>
+#include <asm/special_insns.h>
 
 static void start_update_msrs(void)
 {
@@ -181,3 +182,128 @@ void shstk_disable(void)
 
 	shstk_free(current);
 }
+
+static unsigned long _get_user_shstk_addr(void)
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
+	return ssp;
+}
+
+#define TOKEN_MODE_MASK	3UL
+#define TOKEN_MODE_64	1UL
+#define IS_TOKEN_64(token) (((token) & TOKEN_MODE_MASK) == TOKEN_MODE_64)
+#define IS_TOKEN_32(token) (((token) & TOKEN_MODE_MASK) == 0)
+
+/*
+ * Create a restore token on the shadow stack.  A token is always 8-byte
+ * and aligned to 8.
+ */
+static int _create_rstor_token(bool ia32, unsigned long ssp,
+			       unsigned long *token_addr)
+{
+	unsigned long addr;
+
+	*token_addr = 0;
+
+	if ((!ia32 && !IS_ALIGNED(ssp, 8)) || !IS_ALIGNED(ssp, 4))
+		return -EINVAL;
+
+	addr = ALIGN_DOWN(ssp, 8) - 8;
+
+	/* Is the token for 64-bit? */
+	if (!ia32)
+		ssp |= TOKEN_MODE_64;
+
+	if (write_user_shstk_64(addr, ssp))
+		return -EFAULT;
+
+	*token_addr = addr;
+	return 0;
+}
+
+/*
+ * Create a restore token on shadow stack, and then push the user-mode
+ * function return address.
+ */
+int shstk_setup_rstor_token(bool ia32, unsigned long ret_addr,
+			    unsigned long *token_addr, unsigned long *new_ssp)
+{
+	struct cet_status *cet = &current->thread.cet;
+	unsigned long ssp = 0;
+	int err = 0;
+
+	if (cet->shstk_size) {
+		if (!ret_addr)
+			return -EINVAL;
+
+		ssp = _get_user_shstk_addr();
+		err = _create_rstor_token(ia32, ssp, token_addr);
+		if (err)
+			return err;
+
+		if (ia32) {
+			*new_ssp = *token_addr - sizeof(u32);
+			err = write_user_shstk_32(*new_ssp, (unsigned int)ret_addr);
+		} else {
+			*new_ssp = *token_addr - sizeof(u64);
+			err = write_user_shstk_64(*new_ssp, ret_addr);
+		}
+	}
+
+	return err;
+}
+
+/*
+ * Verify token_addr point to a valid token, and then set *new_ssp
+ * according to the token.
+ */
+int shstk_check_rstor_token(bool ia32, unsigned long token_addr, unsigned long *new_ssp)
+{
+	unsigned long token;
+
+	*new_ssp = 0;
+
+	if (!IS_ALIGNED(token_addr, 8))
+		return -EINVAL;
+
+	if (get_user(token, (unsigned long __user *)token_addr))
+		return -EFAULT;
+
+	/* Is 64-bit mode flag correct? */
+	if (!ia32 && !IS_TOKEN_64(token))
+		return -EINVAL;
+	else if (ia32 && !IS_TOKEN_32(token))
+		return -EINVAL;
+
+	token &= ~TOKEN_MODE_MASK;
+
+	/*
+	 * Restore address properly aligned?
+	 */
+	if ((!ia32 && !IS_ALIGNED(token, 8)) || !IS_ALIGNED(token, 4))
+		return -EINVAL;
+
+	/*
+	 * Token was placed properly?
+	 */
+	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
+		return -EINVAL;
+
+	*new_ssp = token;
+	return 0;
+}
-- 
2.21.0

