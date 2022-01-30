Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92804A3A59
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357033AbiA3V0Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:26:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:52048 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356883AbiA3VZf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577935; x=1675113935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fNETiia0npgO2OFNbSIMbUM/Mgq6q17fU9ocx82tnFk=;
  b=ZVOa90XmSBlZ9Ui1B25XGMbRIKIPmFa2YS4L2BmVXIivS2ymigLbgo57
   wWCi1OLUY7xbt/z+dD/+R538kUTfWdqkZHkkgBHXGruMV1smir/eEBxvg
   pQrJ3C7nUTyd/3tTkNaiNvHbCcn+nfo7yvD9ipTiJGSv7myvwLtIqEgJ1
   sZTa4M4YLEC3Jpjn54zygkyIrYyBIprMBo4vr22ug6fcfZevOq7a1zpoi
   oeBTid+1+qGi1FlrHELYfSniCoT+MhvYYDg9MQEe9tjNBe01iwmKAzP7/
   e/BqogKcIzXqXtYeO4Z8mB5G9cNovSkWycUUWGfyzNBxahIJfVG2nfh10
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104979"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104979"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856940"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:08 -0800
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
Subject: [PATCH 28/35] x86/cet/shstk: Handle thread shadow stack
Date:   Sun, 30 Jan 2022 13:18:31 -0800
Message-Id: <20220130211838.8382-29-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
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

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - Expand commit log.
 - Add more comments.
 - Switch to xsave helpers.

Yu-cheng v30:
 - Update comments about clone()/clone3(). (Borislav Petkov)

Yu-cheng v29:
 - WARN_ON_ONCE() when get_xsave_addr() returns NULL, and update comments.
   (Dave Hansen)

Yu-cheng v28:
 - Split out copy_thread() argument name changes to a new patch.
 - Add compatibility for earlier clone(), which does not pass stack_size.
 - Add comment for get_xsave_addr(), explain the handling of null return
   value.

 arch/x86/include/asm/cet.h         |  5 +++
 arch/x86/include/asm/mmu_context.h |  2 +
 arch/x86/kernel/process.c          |  6 +++
 arch/x86/kernel/shstk.c            | 68 +++++++++++++++++++++++++++++-
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index de90e4ae083a..63ee8b45080d 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -14,11 +14,16 @@ struct thread_shstk {
 
 #ifdef CONFIG_X86_SHADOW_STACK
 int shstk_setup(void);
+int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
+			     unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 int shstk_disable(void);
 void reset_thread_shstk(void);
 #else
 static inline void shstk_setup(void) {}
+static inline int shstk_alloc_thread_stack(struct task_struct *p,
+					   unsigned long clone_flags,
+					   unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 static inline void shstk_disable(void) {}
 static inline void reset_thread_shstk(void) {}
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..8e721d2c45d5 100644
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
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 82a816178e7f..0fbcf33255fa 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -46,6 +46,7 @@
 #include <asm/proto.h>
 #include <asm/frame.h>
 #include <asm/unwind.h>
+#include <asm/cet.h>
 
 #include "process.h"
 
@@ -117,6 +118,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	shstk_free(tsk);
 	fpu__drop(fpu);
 }
 
@@ -217,6 +219,10 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	if (clone_flags & CLONE_SETTLS)
 		ret = set_new_tls(p, tls);
 
+	/* Allocate a new shadow stack for pthread */
+	if (!ret)
+		ret = shstk_alloc_thread_stack(p, clone_flags, stack_size);
+
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 4e8686ed885f..358f24e806cc 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -106,6 +106,66 @@ void reset_thread_shstk(void)
 	memset(&current->thread.shstk, 0, sizeof(struct thread_shstk));
 }
 
+int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+			     unsigned long stack_size)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+	unsigned long addr;
+	void *xstate;
+
+	/*
+	 * If shadow stack is not enabled on the new thread, skip any
+	 * switch to a new shadow stack.
+	 */
+	if (!shstk->size)
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
+	/*
+	 * Compat-mode pthreads share a limited address space.
+	 * If each function call takes an average of four slots
+	 * stack space, allocate 1/4 of stack size for shadow stack.
+	 */
+	if (in_compat_syscall())
+		stack_size /= 4;
+
+	/*
+	 * 'tsk' is configured with a shadow stack and the fpu.state is
+	 * up to date since it was just copied from the parent.  There
+	 * must be a valid non-init CET state location in the buffer.
+	 */
+	xstate = get_xsave_buffer_unsafe(&tsk->thread.fpu, XFEATURE_CET_USER);
+	if (WARN_ON_ONCE(!xstate))
+		return -EINVAL;
+
+	stack_size = PAGE_ALIGN(stack_size);
+	addr = alloc_shstk(stack_size);
+	if (IS_ERR_VALUE(addr)) {
+		shstk->base = 0;
+		shstk->size = 0;
+		return PTR_ERR((void *)addr);
+	}
+
+	xsave_wrmsrl_unsafe(xstate, MSR_IA32_PL3_SSP, (u64)(addr + stack_size));
+	shstk->base = addr;
+	shstk->size = stack_size;
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
@@ -115,7 +175,13 @@ void shstk_free(struct task_struct *tsk)
 	    !shstk->base)
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

