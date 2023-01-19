Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238EB6744F7
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjASVlw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjASVhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:37:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996804616D;
        Thu, 19 Jan 2023 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163667; x=1705699667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sY0pQZGQdI/cNzp/wwjwE3pcURvBjqOaRcvBZzBOV/8=;
  b=OHCpMTPWUmNj04Fp5VChAxn2AXun00RS8ZHkrzi26EnwqVZ4K22PGQVu
   TfCB/4DJxatHln6urSoUDoSkK6MobjXOHzuAatNlPPQOMt80wNWWk4u6L
   SPDvBcZxnuayHEuMQCuSD4tFOU80xndLSW9s7pcD+XL5PCSoorA8zkalc
   uFu2kslB99HkZjhpc+KPoilaoYZcf8a8OHTe1aAefs9rK/dwXomNux8Xf
   xaz8cezIh5UL0Ushs80Ki7CpiJYkniiZWdMUyVGB/QgZ58CvxEgkQy7sR
   /uTLtWF/vkZ+TunLpUzXA2ujWVfmxe1o2iiYfgmsjBmNyO0T4GIp2U/uQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119861"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119861"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139140"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139140"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:08 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v5 28/39] x86/shstk: Handle thread shadow stack
Date:   Thu, 19 Jan 2023 13:23:06 -0800
Message-Id: <20230119212317.8324-29-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v3:
 - Fix update_fpu_shstk() stub (Mike Rapoport)
 - Fix chunks around alloc_shstk() in wrong patch (Kees)
 - Fix stack_size/flags swap (Kees)
 - Use centalized stack size logic (Kees)

v2:
 - Have fpu_clone() take new shadow stack pointer and update SSP in
   xsave buffer for new task. (tglx)

v1:
 - Expand commit log.
 - Add more comments.
 - Switch to xsave helpers.

Yu-cheng v30:
 - Update comments about clone()/clone3(). (Borislav Petkov)

 arch/x86/include/asm/fpu/sched.h   |  3 +-
 arch/x86/include/asm/mmu_context.h |  2 ++
 arch/x86/include/asm/shstk.h       |  7 +++++
 arch/x86/kernel/fpu/core.c         | 41 +++++++++++++++++++++++++++-
 arch/x86/kernel/process.c          | 18 +++++++++++-
 arch/x86/kernel/shstk.c            | 44 ++++++++++++++++++++++++++++--
 6 files changed, 110 insertions(+), 5 deletions(-)

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
index e01aa74a6de7..9714f08d941b 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -147,6 +147,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		shstk_free(tsk);		\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index f40414a982e8..172a69052770 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -15,11 +15,18 @@ struct thread_shstk {
 
 long shstk_prctl(struct task_struct *task, int option, unsigned long features);
 void reset_thread_features(void);
+int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
+			     unsigned long stack_size,
+			     unsigned long *shstk_addr);
 void shstk_free(struct task_struct *p);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			     unsigned long features) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
+static inline int shstk_alloc_thread_stack(struct task_struct *p,
+					   unsigned long clone_flags,
+					   unsigned long stack_size,
+					   unsigned long *shstk_addr) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 7317bfd5ea36..c72262479f03 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -552,8 +552,41 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 	}
 }
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
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
+	return 0;
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
@@ -613,6 +646,12 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
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
index e57cd31bfec4..13a0a81d70b9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -48,6 +48,7 @@
 #include <asm/frame.h>
 #include <asm/unwind.h>
 #include <asm/tdx.h>
+#include <asm/shstk.h>
 
 #include "process.h"
 
@@ -119,6 +120,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	shstk_free(tsk);
 	fpu__drop(fpu);
 }
 
@@ -140,6 +142,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
 	struct pt_regs *childregs;
+	unsigned long shstk_addr = 0;
 	int ret = 0;
 
 	childregs = task_pt_regs(p);
@@ -174,7 +177,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
-	fpu_clone(p, clone_flags, args->fn);
+	/* Allocate a new shadow stack for pthread if needed */
+	ret = shstk_alloc_thread_stack(p, clone_flags, args->stack_size,
+				       &shstk_addr);
+	if (ret)
+		return ret;
+
+	fpu_clone(p, clone_flags, args->fn, shstk_addr);
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
@@ -220,6 +229,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
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
index f39e5d3b9303..111ea56115d2 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -47,7 +47,7 @@ static unsigned long alloc_shstk(unsigned long size)
 	unsigned long addr, unused;
 
 	mmap_write_lock(mm);
-	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+	addr = do_mmap(NULL, 0, size, PROT_READ, flags,
 		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
 
 	mmap_write_unlock(mm);
@@ -126,6 +126,40 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
+int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+			     unsigned long stack_size, unsigned long *shstk_addr)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+	unsigned long addr, size;
+
+	/*
+	 * If shadow stack is not enabled on the new thread, skip any
+	 * switch to a new shadow stack.
+	 */
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	/*
+	 * For CLONE_VM, except vfork, the child needs a separate shadow
+	 * stack.
+	 */
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+		return 0;
+
+
+	size = adjust_shstk_size(stack_size);
+	addr = alloc_shstk(size);
+	if (IS_ERR_VALUE(addr))
+		return PTR_ERR((void *)addr);
+
+	shstk->base = addr;
+	shstk->size = size;
+
+	*shstk_addr = addr + size;
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
@@ -134,7 +168,13 @@ void shstk_free(struct task_struct *tsk)
 	    !features_enabled(ARCH_SHSTK_SHSTK))
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

