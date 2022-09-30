Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915ED5F00C3
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiI2Why (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiI2Wgt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:36:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C2402C1;
        Thu, 29 Sep 2022 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490756; x=1696026756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qC94pWx3ETPKg6Jl0TVzncTVpDWyMDjZ00/mG9Fm96U=;
  b=efKfdBUjIieOmKhkHqNAsjFfJ/bpYDmzo8b3rMlyCCtNOUjVRgsTNAb2
   TdjZ3GX5QWCZto1dWd8O0jMVBi8t0SmG/pbgWgK00DyJK2X1MZd2BFP7D
   kqTANRsuMwn4aEB8bL8CMTIaHA4mFb5u+qYtdMEc63BFWArL6M2iVXUze
   kpi/bXCWNbiKtbEGjVPFuyXlNZFa1imqMSTEJjYiGs+UYvrI/d7WgD8DZ
   KYbEdBGNodYCetdxQ1/v1sHyz1oSSljZi/AhSf4o2cUCZCWl5I1WaS9H7
   FN5WJBtVdHRO4gWEtCv1uI0mkKExkLfnd6p8CbdjpyXnjxefgLCvvB/27
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182233"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182233"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:31:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016422"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016422"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:31:06 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com
Subject: [OPTIONAL/RFC v2 39/39] x86: Add alt shadow stack support
Date:   Thu, 29 Sep 2022 15:29:36 -0700
Message-Id: <20220929222936.14584-40-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To handle stack overflows, applications can register a separate signal alt
stack to use for the stack to handle signals. To handle shadow stack
overflows the kernel can similarly provide the ability to have an alt
shadow stack.

Signals push information about the execution context to the stack that
will handle the signal. The data pushed is use to restore registers
and other state after the signal. In the case of handling the signal on
a normal stack, the stack just needs to be unwound over the stack frame,
but in the case of alt stacks, the saved stack pointer is important for
the sigreturn to find it’s way back to the thread. With shadow stack
there is a new type of stack pointer, the shadow stack pointer (SSP), that
needs to be restored. Just like the regular stack pointer, it needs to be
saved somewhere in order to implement shadow alt stacks. This is already
done as part of the token placed to prevent SROP attacks, so on sigreturn
from an alt shadow stack, the kernel can easily know which SSP to restore.

But to enable SS_AUTODISARM like functionality, the kernel also needs to
push the shadow alt stack and size somewhere, like happens in regular
alt stacks. So push this data using the same format. In the end the
shadow stack sigframe looks like this:
|1...old SSP|1...alt stack size|1...alt stack base| 0|

In the future, any other data could come between the alt stack base and
the guard zero. The guard zero is to prevent tricking the kernel into
processing half of one frame and half of the adjacent frame.

In past designs for userspace shadow stacks, shadow alt stacks were not
supported. Since there was only one shadow stack, longjmp() could jump out
of a signal by using incssp to unwind the SSP to the place where the
setjmp() was called. Since alt shadow stacks are a new thing, simply don't
support longjmp()ing from an alt shadow stacks.

Introduce a new syscall "sigaltshstk" that behaves similarly to
sigaltstack. Have it take new and old stack_t's to specify the base and
length of the alt shadow stack. Don't have it adopt the same flag
semantics though, because not all alt stack flags will necessarily apply
to alt shadow stacks. As long as the syscall is getting new flag meanings
make SS_AUTODISARM the default behavior for sigaltshstk(), and not require
a flag. Today the only flag supported is SS_DISABLE, and a !SS_AUTODISARM
mode is not supported.

So when a signal hits it will jump to the location specified in
sigaltshstk(). Currently (without WRSS), userspace doesn’t have the
ability to arbitrarily set the SSP. But telling the kernel to set the
SSP to an arbitrary point on signal is kind of like that. So there would
be a weakening of the shadow stack protections unless additional checks
are made. With the SS_AUTODISARM-style behavior, the SSP will only jump to
the shadow stack if the SSP is not already on the shadow stack, otherwise
it will just push the SSP. So have the kernel checks for a token
whenever transitioning to the alt stack from a place other than the alt
stack. This token can be written by the kernel during shadow stack
allocation, using the map_shadow_stack syscall.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - New patch

 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/include/asm/cet.h                    |   2 +
 arch/x86/include/asm/processor.h              |   3 +
 arch/x86/kernel/process.c                     |   3 +
 arch/x86/kernel/shstk.c                       | 178 +++++++++++++++---
 include/linux/syscalls.h                      |   1 +
 kernel/sys_ni.c                               |   1 +
 .../testing/selftests/x86/test_shadow_stack.c |  75 ++++++++
 8 files changed, 240 insertions(+), 24 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index d9639e3e0a33..a2dd5d56caa4 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,7 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	map_shadow_stack	sys_map_shadow_stack
+452	common	sigaltshstk		sys_sigaltshstk
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index edf681d4843a..52119b913ed6 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -26,6 +26,7 @@ void reset_thread_shstk(void);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
 int wrss_control(bool enable);
+void reset_alt_shstk(void);
 #else
 static inline long cet_prctl(struct task_struct *task, int option,
 		      unsigned long features) { return -EINVAL; }
@@ -40,6 +41,7 @@ static inline void reset_thread_shstk(void) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
 static inline int wrss_control(bool enable) { return -EOPNOTSUPP; }
+static inline void reset_alt_shstk(void) {}
 #endif /* CONFIG_X86_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3a0c9d9d4d1d..b9fb966edec7 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -536,6 +536,9 @@ struct thread_struct {
 
 #ifdef CONFIG_X86_SHADOW_STACK
 	struct thread_shstk	shstk;
+	unsigned long			sas_shstk_sp;
+	size_t				sas_shstk_size;
+	unsigned int			sas_shstk_flags;
 #endif
 
 	/* Floating point and extended processor state */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5e63d190becd..b71eb2d6a20f 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -176,6 +176,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
+	if ((clone_flags & (CLONE_VM|CLONE_VFORK)) == CLONE_VM)
+		reset_alt_shstk();
+
 	/* Allocate a new shadow stack for pthread if needed */
 	ret = shstk_alloc_thread_stack(p, clone_flags, args->flags, &shstk_addr);
 	if (ret)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index af1255164f0c..05ee3793b60f 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -25,6 +25,7 @@
 #include <asm/special_insns.h>
 #include <asm/fpu/api.h>
 #include <asm/prctl.h>
+#include <asm/signal.h>
 
 #define SS_FRAME_SIZE 8
 
@@ -149,11 +150,18 @@ int shstk_setup(void)
 	return 0;
 }
 
+void reset_alt_shstk(void)
+{
+	current->thread.sas_shstk_sp = 0;
+	current->thread.sas_shstk_size = 0;
+}
+
 void reset_thread_shstk(void)
 {
 	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
 	current->thread.features = 0;
 	current->thread.features_locked = 0;
+	reset_alt_shstk();
 }
 
 int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
@@ -238,39 +246,67 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
 	return 0;
 }
 
+static bool on_alt_shstk(unsigned long ssp)
+{
+	unsigned long alt_ss_start = current->thread.sas_shstk_sp;
+	unsigned long alt_ss_end = alt_ss_start + current->thread.sas_shstk_size;
+
+	return ssp >= alt_ss_start && ssp < alt_ss_end;
+}
+
+static bool alt_shstk_active(void)
+{
+	return current->thread.sas_shstk_sp;
+}
+
+static bool alt_shstk_valid(unsigned long ssp, size_t size)
+{
+	if (ssp && (size < PAGE_SIZE || size >= TASK_SIZE_MAX))
+		return -EINVAL;
+
+	if (ssp >= TASK_SIZE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
- * Create a restore token on shadow stack, and then push the user-mode
- * function return address.
+ * Verify the user shadow stack has a valid token on it, and then set
+ * *new_ssp according to the token.
  */
-static int shstk_setup_rstor_token(unsigned long ret_addr, unsigned long *new_ssp)
+static int shstk_check_rstor_token(unsigned long token_addr, unsigned long *new_ssp)
 {
-	unsigned long ssp, token_addr;
-	int err;
+	unsigned long token;
 
-	if (!ret_addr)
+	if (get_user(token, (unsigned long __user *)token_addr))
+		return -EFAULT;
+
+	/* Is mode flag correct? */
+	if (!(token & BIT(0)))
 		return -EINVAL;
 
-	ssp = get_user_shstk_addr();
-	if (!ssp)
+	/* Is busy flag set? */
+	if (token & BIT(1))
 		return -EINVAL;
 
-	err = create_rstor_token(ssp, &token_addr);
-	if (err)
-		return err;
+	/* Mask out flags */
+	token &= ~3UL;
+
+	/* Restore address aligned? */
+	if (!IS_ALIGNED(token, 8))
+		return -EINVAL;
 
-	ssp = token_addr - sizeof(u64);
-	err = write_user_shstk_64((u64 __user *)ssp, (u64)ret_addr);
+	/* Token placed properly? */
+	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
+		return -EINVAL;
 
-	if (!err)
-		*new_ssp = ssp;
+	*new_ssp = token;
 
-	return err;
+	return 0;
 }
 
-static int shstk_push_sigframe(unsigned long *ssp)
+static int shstk_push_sigframe(unsigned long *ssp, unsigned long target_ssp)
 {
-	unsigned long target_ssp = *ssp;
-
 	/* Token must be aligned */
 	if (!IS_ALIGNED(*ssp, 8))
 		return -EINVAL;
@@ -278,17 +314,32 @@ static int shstk_push_sigframe(unsigned long *ssp)
 	if (!IS_ALIGNED(target_ssp, 8))
 		return -EINVAL;
 
+	*ssp -= SS_FRAME_SIZE;
+	if (write_user_shstk_64((u64 __user *)*ssp, 0))
+		return -EFAULT;
+
+	*ssp -= SS_FRAME_SIZE;
+	if (put_shstk_data((u64 __user *)*ssp, current->thread.sas_shstk_sp))
+		return -EFAULT;
+
+	*ssp -= SS_FRAME_SIZE;
+	if (put_shstk_data((u64 __user *)*ssp, current->thread.sas_shstk_size))
+		return -EFAULT;
+
 	*ssp -= SS_FRAME_SIZE;
 	if (put_shstk_data((void *__user)*ssp, target_ssp))
 		return -EFAULT;
 
+	current->thread.sas_shstk_sp = 0;
+	current->thread.sas_shstk_size = 0;
+
 	return 0;
 }
 
 
 static int shstk_pop_sigframe(unsigned long *ssp)
 {
-	unsigned long token_addr;
+	unsigned long token_addr, shstk_sp, shstk_size;
 	int err;
 
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
@@ -303,7 +354,38 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	if (unlikely(token_addr >= TASK_SIZE_MAX))
 		return -EINVAL;
 
+	*ssp += SS_FRAME_SIZE;
+	err = get_shstk_data(&shstk_size, (void __user *)*ssp);
+	if (unlikely(err))
+		return err;
+
+	*ssp += SS_FRAME_SIZE;
+	err = get_shstk_data(&shstk_sp, (void __user *)*ssp);
+	if (unlikely(err))
+		return err;
+
+	if (unlikely(alt_shstk_valid((unsigned long)shstk_sp, shstk_size)))
+		return -EINVAL;
+
 	*ssp = token_addr;
+	current->thread.sas_shstk_sp = shstk_sp;
+	current->thread.sas_shstk_size = shstk_size;
+
+	return 0;
+}
+
+static unsigned long get_sig_start_ssp(unsigned long orig_ssp, unsigned long *ssp)
+{
+	unsigned long sp_end = (current->thread.sas_shstk_sp +
+				current->thread.sas_shstk_size) - SS_FRAME_SIZE;
+
+	if (!alt_shstk_active() || on_alt_shstk(*ssp)) {
+		*ssp = orig_ssp;
+		return 0;
+	}
+
+	if (shstk_check_rstor_token(sp_end, ssp))
+		return -EINVAL;
 
 	return 0;
 }
@@ -311,7 +393,7 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 int setup_signal_shadow_stack(struct ksignal *ksig)
 {
 	void __user *restorer = ksig->ka.sa.sa_restorer;
-	unsigned long ssp;
+	unsigned long ssp, orig_ssp;
 	int err;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
@@ -321,11 +403,15 @@ int setup_signal_shadow_stack(struct ksignal *ksig)
 	if (!restorer)
 		return -EINVAL;
 
-	ssp = get_user_shstk_addr();
-	if (unlikely(!ssp))
+	orig_ssp = get_user_shstk_addr();
+	if (unlikely(!orig_ssp))
 		return -EINVAL;
 
-	err = shstk_push_sigframe(&ssp);
+	err = get_sig_start_ssp(orig_ssp, &ssp);
+	if (unlikely(err))
+		return err;
+
+	err = shstk_push_sigframe(&ssp, orig_ssp);
 	if (unlikely(err))
 		return err;
 
@@ -496,3 +582,47 @@ long cet_prctl(struct task_struct *task, int option, unsigned long features)
 		return wrss_control(true);
 	return -EINVAL;
 }
+
+SYSCALL_DEFINE2(sigaltshstk, const stack_t __user *, uss, stack_t __user *, uoss)
+{
+	unsigned long ssp;
+	stack_t new, old;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return -ENOSYS;
+
+	ssp = get_user_shstk_addr();
+
+	if (unlikely(!ssp || on_alt_shstk(ssp)))
+		return -EPERM;
+
+	if (uss) {
+		if (unlikely(copy_from_user(&new, uss, sizeof(stack_t))))
+			return -EFAULT;
+
+		if (unlikely(alt_shstk_valid((unsigned long)new.ss_sp,
+					     new.ss_size)))
+			return -EINVAL;
+
+		if (new.ss_flags & SS_DISABLE) {
+			current->thread.sas_shstk_sp = 0;
+			current->thread.sas_shstk_size = 0;
+			return 0;
+		}
+
+		current->thread.sas_shstk_sp = (unsigned long) new.ss_sp;
+		current->thread.sas_shstk_size = new.ss_size;
+		/* No saved flags for now */
+	}
+
+	if (!uoss)
+		return 0;
+
+	memset(&old, 0, sizeof(stack_t));
+	old.ss_sp = (void __user *)current->thread.sas_shstk_sp;
+	old.ss_size = current->thread.sas_shstk_size;
+	if (copy_to_user(uoss, &old, sizeof(stack_t)))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3ae05cbdea5b..7b7e7bb992c2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1057,6 +1057,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 					    unsigned long home_node,
 					    unsigned long flags);
 asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
+asmlinkage long sys_sigaltshstk(const struct sigaltstack *uss, struct sigaltstack *uoss);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index cb9aebd34646..3a5f8b76e7a4 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -382,6 +382,7 @@ COND_SYSCALL(modify_ldt);
 COND_SYSCALL(vm86);
 COND_SYSCALL(kexec_file_load);
 COND_SYSCALL(map_shadow_stack);
+COND_SYSCALL(sigaltshstk);
 
 /* s390 */
 COND_SYSCALL(s390_pci_mmio_read);
diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 249397736d0d..22b856de5cdd 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -492,6 +492,76 @@ int test_userfaultfd(void)
 	return 1;
 }
 
+volatile bool segv_pass;
+
+long sigaltshstk(stack_t *uss, stack_t *ouss)
+{
+	return syscall(__NR_sigaltshstk, uss, ouss);
+}
+
+void segv_alt_handler(int signum, siginfo_t *si, void *uc)
+{
+	unsigned long min = (unsigned long)shstk_ptr;
+	unsigned long max = (unsigned long)shstk_ptr + SS_SIZE;
+	unsigned long ssp = get_ssp();
+	stack_t alt_shstk_stackt;
+
+	if (sigaltshstk(NULL, &alt_shstk_stackt))
+		goto fail;
+
+	if (alt_shstk_stackt.ss_sp || alt_shstk_stackt.ss_size)
+		goto fail;
+
+	if (ssp < min || ssp > max - 8)
+		goto fail;
+
+	segv_pass = true;
+	return;
+fail:
+	segv_pass = false;
+}
+
+int test_shstk_alt_stack(void)
+{
+	stack_t alt_shstk_stackt;
+	struct sigaction sa;
+	int ret = 1;
+
+	sa.sa_sigaction = segv_alt_handler;
+	if (sigaction(SIGUSR1, &sa, NULL))
+		return 1;
+	sa.sa_flags = SA_SIGINFO;
+
+	shstk_ptr = create_shstk(0);
+	if (shstk_ptr == MAP_FAILED)
+		goto err_sig;
+
+	alt_shstk_stackt.ss_sp = shstk_ptr;
+	alt_shstk_stackt.ss_size = SS_SIZE;
+	if (sigaltshstk(&alt_shstk_stackt, NULL) == -1)
+		goto err_shstk;
+
+	segv_pass = false;
+
+	/* Make sure segv_was_on_alt is set before signal */
+	asm volatile("" : : : "memory");
+
+	raise(SIGUSR1);
+
+	if (segv_pass) {
+		printf("[OK]\tAlt shadow stack test.\n");
+		ret = 0;
+	}
+
+err_shstk:
+	alt_shstk_stackt.ss_flags = SS_DISABLE;
+	sigaltshstk(&alt_shstk_stackt, NULL);
+	free_shstk(shstk_ptr);
+err_sig:
+	signal(SIGUSR1, SIG_DFL);
+	return ret;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
@@ -556,6 +626,11 @@ int main(int argc, char *argv[])
 		printf("[FAIL]\tUserfaultfd test\n");
 	}
 
+	if (test_shstk_alt_stack()) {
+		ret = 1;
+		printf("[FAIL]\tAlt shadow stack test\n");
+	}
+
 out:
 	/*
 	 * Disable shadow stack before the function returns, or there will be a
-- 
2.17.1

