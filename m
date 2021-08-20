Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6383F3358
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhHTSWJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 14:22:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:22426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237460AbhHTSVb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Aug 2021 14:21:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="302407838"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="302407838"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="533074769"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:51 -0700
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
Subject: [PATCH v29 25/32] x86/cet/shstk: Handle thread shadow stack
Date:   Fri, 20 Aug 2021 11:11:54 -0700
Message-Id: <20210820181201.31490-26-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820181201.31490-1-yu-cheng.yu@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For clone() with CLONE_VM, except vfork, the child and the parent must have
separate shadow stacks.  Thus, the kernel allocates, and frees on thread
exit a new shadow stack for the child.

Use stack_size passed from clone3() syscall for thread shadow stack size.
A compat-mode thread shadow stack size is further reduced to 1/4.  This
allows more threads to run in a 32-bit address space.

The earlier version of clone() did not have stack_size passed in.  In that
case, use RLIMIT_STACK size and cap to 4 GB.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v29:
- WARN_ON_ONCE() when get_xsave_addr() returns NULL, and update comments.
  (Dave Hansen)

v28:
- Split out copy_thread() argument name changes to a new patch.
- Add compatibility for earlier clone(), which does not pass stack_size.
- Add comment for get_xsave_addr(), explain the handling of null return
  value.
---
 arch/x86/include/asm/cet.h         |  5 +++
 arch/x86/include/asm/mmu_context.h |  3 ++
 arch/x86/kernel/process.c          |  6 +++
 arch/x86/kernel/shstk.c            | 63 +++++++++++++++++++++++++++++-
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 6432baf4de1f..4314a41ab3c9 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -17,10 +17,15 @@ struct thread_shstk {
 
 #ifdef CONFIG_X86_SHADOW_STACK
 int shstk_setup(void);
+int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
+			     unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 void shstk_disable(void);
 #else
 static inline int shstk_setup(void) { return 0; }
+static inline int shstk_alloc_thread_stack(struct task_struct *p,
+					   unsigned long clone_flags,
+					   unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 static inline void shstk_disable(void) {}
 #endif
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..e1dd083261a5 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -12,6 +12,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
+#include <asm/cet.h>
 
 extern atomic64_t last_mm_ctx_id;
 
@@ -146,6 +147,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		shstk_free(tsk);		\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e6e4d8bc9023..bade6a594d63 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/cet.h>
 
 #include "process.h"
 
@@ -103,6 +104,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	shstk_free(tsk);
 	fpu__drop(fpu);
 }
 
@@ -200,6 +202,10 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	if (clone_flags & CLONE_SETTLS)
 		ret = set_new_tls(p, tls);
 
+	/* Allocate a new shadow stack for pthread */
+	if (!ret)
+		ret = shstk_alloc_thread_stack(p, clone_flags, stack_size);
+
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 5993aa8db338..7c1ca2476a5e 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -75,6 +75,61 @@ int shstk_setup(void)
 	return err;
 }
 
+int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+			     unsigned long stack_size)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+	struct cet_user_state *state;
+	unsigned long addr;
+
+	if (!shstk->size)
+		return 0;
+
+	/*
+	 * Earlier clone() does not pass stack_size.  Use RLIMIT_STACK and
+	 * cap to 4 GB.
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
+	/*
+	 * 'tsk' is configured with a shadow stack and the fpu.state is
+	 * up to date since it was just copied from the parent.  There
+	 * must be a valid non-init CET state location in the buffer.
+	 */
+	state = get_xsave_addr(&tsk->thread.fpu.state.xsave, XFEATURE_CET_USER);
+	if (WARN_ON_ONCE(!state))
+		return -EINVAL;
+
+	/*
+	 * Compat-mode pthreads share a limited address space.
+	 * If each function call takes an average of four slots
+	 * stack space, allocate 1/4 of stack size for shadow stack.
+	 */
+	if (in_compat_syscall())
+		stack_size /= 4;
+
+	stack_size = round_up(stack_size, PAGE_SIZE);
+	addr = alloc_shstk(stack_size);
+	if (IS_ERR_VALUE(addr)) {
+		shstk->base = 0;
+		shstk->size = 0;
+		return PTR_ERR((void *)addr);
+	}
+
+	state->user_ssp = (u64)(addr + stack_size);
+	shstk->base = addr;
+	shstk->size = stack_size;
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
@@ -84,7 +139,13 @@ void shstk_free(struct task_struct *tsk)
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
 
 	while (1) {
-- 
2.21.0

