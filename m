Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D555F0084
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiI2WfP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiI2WeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:34:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3901BB6F0;
        Thu, 29 Sep 2022 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490685; x=1696026685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sfY0qfAAMaBKBaoxmspQvWEjmGcNq7mh/op82wqEfzo=;
  b=HLUey5L+GvNyRmvpSPDurVQdomfh6Vl1KOalXVapHoPBNoaf71Kyp2qA
   4KXrVJ3JAFZW8kqLYEzkEx2rx9gzxA+XRQiDdjnCiPg67rCNhyAip53+/
   HINP+UlMSAnkpGVsiEXa0C0eLeQ7aTiU/hlnTl43L7jeyyl4L2USDS2YL
   KRdKz1W0B/9kgRTP1f3oGoCeta+glQO5Fg/xxTeWZ1F3tM+71xAfNUsSi
   8yGUF06euKiAifVhFOVhB6VdRwv9NtG726ZYgqtqhVF3fiYKaIn1sVgzZ
   Pmvn9pr14u7O1LHh6dsbAkoPbngn8pMrYJJaclR+jtBMyLTTgzSyZ0E3D
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182056"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182056"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016319"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016319"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:38 -0700
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
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 25/39] x86/cet/shstk: Handle thread shadow stack
Date:   Thu, 29 Sep 2022 15:29:22 -0700
Message-Id: <20220929222936.14584-26-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

When a process is duplicated, but the child shares the address space with
the parent, there is potential for the threads sharing a single stack to
cause conflicts for each other. In the normal non-cet case this is handled
in two ways.

With regular CLONE_VM a new stack is provided by userspace such that the
parent and child have different stacks.

For vfork, the parent is suspended until the child exits. So as long as
the child doesn't return from the vfork()/CLONE_VFORK calling function and
sticks to a limited set of operations, the parent and child can share the
same stack.

For shadow stack, these scenarios present similar sharing problems. For the
CLONE_VM case, the child and the parent must have separate shadow stacks.
Instead of changing clone to take a shadow stack, have the kernel just
allocate one and switch to it.

Use stack_size passed from clone3() syscall for thread shadow stack size. A
compat-mode thread shadow stack size is further reduced to 1/4. This
allows more threads to run in a 32-bit address space. The clone() does not
pass stack_size, which was added to clone3(). In that case, use
RLIMIT_STACK size and cap to 4 GB.

For shadow stack enabled vfork(), the parent and child can share the same
shadow stack, like they can share a normal stack. Since the parent is
suspended until the child terminates, the child will not interfere with
the parent while executing as long as it doesn't return from the vfork()
and overwrite up the shadow stack. The child can safely overwrite down
the shadow stack, as the parent can just overwrite this later. So CET does
not add any additional limitations for vfork().

Userspace implementing posix vfork() can actually prevent the child from
returning from the vfork() calling function, using CET. Glibc does this
by adjusting the shadow stack pointer in the child, so that the child
receives a #CP if it tries to return from vfork() calling function.

Free the shadow stack on thread exit by doing it in mm_release(). Skip
this when exiting a vfork() child since the stack is shared in the
parent.

During this operation, the shadow stack pointer of the new thread needs
to be updated to point to the newly allocated shadow stack. Since the
ability to do this is confined to the FPU subsystem, change
fpu_clone() to take the new shadow stack pointer, and update it
internally inside the FPU subsystem. This part was suggested by Thomas
Gleixner.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Have fpu_clone() take new shadow stack pointer and update SSP in
   xsave buffer for new task. (tglx)

v1:
 - Expand commit log.
 - Add more comments.
 - Switch to xsave helpers.

Yu-cheng v30:
 - Update comments about clone()/clone3(). (Borislav Petkov)

Yu-cheng v29:
 - WARN_ON_ONCE() when get_xsave_addr() returns NULL, and update comments.
   (Dave Hansen)

 arch/x86/include/asm/cet.h         |  7 +++++
 arch/x86/include/asm/fpu/sched.h   |  3 +-
 arch/x86/include/asm/mmu_context.h |  2 ++
 arch/x86/kernel/fpu/core.c         | 40 ++++++++++++++++++++++++-
 arch/x86/kernel/process.c          | 17 ++++++++++-
 arch/x86/kernel/shstk.c            | 48 +++++++++++++++++++++++++++++-
 6 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index a4a1f4c0089b..924de99e0c61 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -16,6 +16,9 @@ struct thread_shstk {
 long cet_prctl(struct task_struct *task, int option,
 		      unsigned long features);
 int shstk_setup(void);
+int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
+			     unsigned long stack_size,
+			     unsigned long *shstk_addr);
 void shstk_free(struct task_struct *p);
 int shstk_disable(void);
 void reset_thread_shstk(void);
@@ -23,6 +26,10 @@ void reset_thread_shstk(void);
 static inline long cet_prctl(struct task_struct *task, int option,
 		      unsigned long features) { return -EINVAL; }
 static inline int shstk_setup(void) { return -EOPNOTSUPP; }
+static inline int shstk_alloc_thread_stack(struct task_struct *p,
+					   unsigned long clone_flags,
+					   unsigned long stack_size,
+					   unsigned long *shstk_addr) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 static inline int shstk_disable(void) { return -EOPNOTSUPP; }
 static inline void reset_thread_shstk(void) {}
diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index b2486b2cbc6e..54c9c2fd1907 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -11,7 +11,8 @@
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal);
+extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
+		      unsigned long shstk_addr);
 extern void fpu_flush_thread(void);
 
 /*
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..d29988cbdf20 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -146,6 +146,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		shstk_free(tsk);		\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 778d3054ccc7..f332e9b42b6d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -555,8 +555,40 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 	}
 }
 
+#ifdef CONFIG_X86_SHADOW_STACK
+static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
+{
+	struct cet_user_state *xstate;
+
+	/* If ssp update is not needed. */
+	if (!ssp)
+		return 0;
+
+	xstate = get_xsave_addr(&dst->thread.fpu.fpstate->regs.xsave,
+				XFEATURE_CET_USER);
+
+	/*
+	 * If there is a non-zero ssp, then 'dst' must be configured with a shadow
+	 * stack and the fpu state should be up to date since it was just copied
+	 * from the parent in fpu_clone(). So there must be a valid non-init CET
+	 * state location in the buffer.
+	 */
+	if (WARN_ON_ONCE(!xstate))
+		return 1;
+
+	xstate->user_ssp = (u64)ssp;
+
+	return 0;
+}
+#else
+static int update_fpu_shstk(struct task_struct *dst, unsigned long shstk_addr)
+{
+}
+#endif
+
 /* Clone current's FPU state on fork */
-int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
+int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
+	      unsigned long ssp)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
@@ -616,6 +648,12 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 	if (use_xsave())
 		dst_fpu->fpstate->regs.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
 
+	/*
+	 * Update shadow stack pointer, in case it changed during clone.
+	 */
+	if (update_fpu_shstk(dst, ssp))
+		return 1;
+
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 034880311e6b..5e63d190becd 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/frame.h>
 #include <asm/unwind.h>
 #include <asm/tdx.h>
+#include <asm/cet.h>
 
 #include "process.h"
 
@@ -118,6 +119,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	shstk_free(tsk);
 	fpu__drop(fpu);
 }
 
@@ -139,6 +141,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
 	struct pt_regs *childregs;
+	unsigned long shstk_addr = 0;
 	int ret = 0;
 
 	childregs = task_pt_regs(p);
@@ -173,7 +176,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
-	fpu_clone(p, clone_flags, args->fn);
+	/* Allocate a new shadow stack for pthread if needed */
+	ret = shstk_alloc_thread_stack(p, clone_flags, args->flags, &shstk_addr);
+	if (ret)
+		return ret;
+
+	fpu_clone(p, clone_flags, args->fn, shstk_addr);
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
@@ -219,6 +227,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
+	/*
+	 * If copy_thread() if failing, don't leak the shadow stack possibly
+	 * allocated in shstk_alloc_thread_stack() above.
+	 */
+	if (ret)
+		shstk_free(p);
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index a0b8d4adb2bf..db4e53f9fdaf 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -118,6 +118,46 @@ void reset_thread_shstk(void)
 	current->thread.features_locked = 0;
 }
 
+int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+			     unsigned long stack_size, unsigned long *shstk_addr)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+	unsigned long addr;
+
+	/*
+	 * If shadow stack is not enabled on the new thread, skip any
+	 * switch to a new shadow stack.
+	 */
+	if (!feature_enabled(CET_SHSTK))
+		return 0;
+
+	/*
+	 * clone() does not pass stack_size, which was added to clone3().
+	 * Use RLIMIT_STACK and cap to 4 GB.
+	 */
+	if (!stack_size)
+		stack_size = min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G);
+
+	/*
+	 * For CLONE_VM, except vfork, the child needs a separate shadow
+	 * stack.
+	 */
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+		return 0;
+
+
+	stack_size = PAGE_ALIGN(stack_size);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	shstk->base = addr;
+	shstk->size = stack_size;
+
+	*shstk_addr = addr + stack_size;
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
@@ -126,7 +166,13 @@ void shstk_free(struct task_struct *tsk)
 	    !feature_enabled(CET_SHSTK))
 		return;
 
-	if (!tsk->mm)
+	/*
+	 * When fork() with CLONE_VM fails, the child (tsk) already has a
+	 * shadow stack allocated, and exit_thread() calls this function to
+	 * free it.  In this case the parent (current) and the child share
+	 * the same mm struct.
+	 */
+	if (!tsk->mm || tsk->mm != current->mm)
 		return;
 
 	unmap_shadow_stack(shstk->base, shstk->size);
-- 
2.17.1

