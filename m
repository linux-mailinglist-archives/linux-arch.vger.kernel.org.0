Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10FD31E27A
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 23:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhBQWfV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 17:35:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:13773 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234189AbhBQWdJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 17:33:09 -0500
IronPort-SDR: OQdov+cT+x0pbaLe+ZDFx/XSb70M6DpI8+Pvolqu3AIwZUo6KQVwUqWTQDukDEY9XxnaoVyyWF
 TgvWydDNw52w==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183461486"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="183461486"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:28:07 -0800
IronPort-SDR: 0fX0I6lYCcw00Cwh9hfaeeoeKSxawfoT+dcpqMlC4CiKHt60x6WgLzm7I0j7mn2J6fXbHqoEx0
 bjxqtiLj2L+Q==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="400172687"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:28:07 -0800
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
Subject: [PATCH v21 23/26] x86/cet/shstk: Handle thread shadow stack
Date:   Wed, 17 Feb 2021 14:27:27 -0800
Message-Id: <20210217222730.15819-24-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210217222730.15819-1-yu-cheng.yu@intel.com>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel allocates (and frees on thread exit) a new shadow stack for a
pthread child.

    It is possible for the kernel to complete the clone syscall and set the
    child's shadow stack pointer to NULL and let the child thread allocate
    a shadow stack for itself.  There are two issues in this approach: It
    is not compatible with existing code that does inline syscall and it
    cannot handle signals before the child can successfully allocate a
    shadow stack.

Use stack_size passed from clone3() syscall for thread shadow stack size,
but cap it to min(RLIMIT_STACK, 4 GB).  A compat-mode thread shadow stack
size is further reduced to 1/4.  This allows more threads to run in a 32-
bit address space.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h         |  5 +++
 arch/x86/include/asm/mmu_context.h |  3 ++
 arch/x86/kernel/cet.c              | 49 ++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c          | 15 +++++++--
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 73435856ce54..5d66340c7a13 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -18,12 +18,17 @@ struct cet_status {
 
 #ifdef CONFIG_X86_CET
 int cet_setup_shstk(void);
+int cet_setup_thread_shstk(struct task_struct *p, unsigned long clone_flags,
+			   unsigned long stack_size);
 void cet_disable_shstk(void);
 void cet_free_shstk(struct task_struct *p);
 int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp);
 void cet_restore_signal(struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
+static inline int cet_setup_thread_shstk(struct task_struct *p,
+					 unsigned long clone_flags,
+					 unsigned long stack_size) { return 0; }
 static inline void cet_disable_shstk(void) {}
 static inline void cet_free_shstk(struct task_struct *p) {}
 static inline void cet_restore_signal(struct sc_ext *sc) { return; }
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 27516046117a..e90bd2ee8498 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -11,6 +11,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
+#include <asm/cet.h>
 #include <asm/debugreg.h>
 
 extern atomic64_t last_mm_ctx_id;
@@ -146,6 +147,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		cet_free_shstk(tsk);		\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 08e43d9b5176..12738cdfb5f2 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -172,6 +172,55 @@ int cet_setup_shstk(void)
 	return 0;
 }
 
+int cet_setup_thread_shstk(struct task_struct *tsk, unsigned long clone_flags,
+			   unsigned long stack_size)
+{
+	unsigned long addr, size;
+	struct cet_user_state *state;
+	struct cet_status *cet = &tsk->thread.cet;
+
+	if (!cet->shstk_size)
+		return 0;
+
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+		return 0;
+
+	state = get_xsave_addr(&tsk->thread.fpu.state.xsave,
+			       XFEATURE_CET_USER);
+
+	if (!state)
+		return -EINVAL;
+
+	if (stack_size == 0)
+		return -EINVAL;
+
+	/* Cap shadow stack size to 4 GB */
+	size = min(rlimit(RLIMIT_STACK), 1UL << 32);
+	size = min(size, stack_size);
+
+	/*
+	 * Compat-mode pthreads share a limited address space.
+	 * If each function call takes an average of four slots
+	 * stack space, allocate 1/4 of stack size for shadow stack.
+	 */
+	if (in_compat_syscall())
+		size /= 4;
+	size = round_up(size, PAGE_SIZE);
+	addr = alloc_shstk(size, 0);
+
+	if (IS_ERR_VALUE(addr)) {
+		cet->shstk_base = 0;
+		cet->shstk_size = 0;
+		return PTR_ERR((void *)addr);
+	}
+
+	fpu__prepare_write(&tsk->thread.fpu);
+	state->user_ssp = (u64)(addr + size);
+	cet->shstk_base = addr;
+	cet->shstk_size = size;
+	return 0;
+}
+
 void cet_disable_shstk(void)
 {
 	struct cet_status *cet = &current->thread.cet;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 145a7ac0c19a..82ae42240392 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/cet.h>
 
 #include "process.h"
 
@@ -109,6 +110,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	cet_free_shstk(tsk);
 	fpu__drop(fpu);
 }
 
@@ -122,8 +124,9 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
-		struct task_struct *p, unsigned long tls)
+int copy_thread(unsigned long clone_flags, unsigned long sp,
+		unsigned long stack_size, struct task_struct *p,
+		unsigned long tls)
 {
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
@@ -163,7 +166,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
-		kthread_frame_init(frame, sp, arg);
+		kthread_frame_init(frame, sp, stack_size);
 		return 0;
 	}
 
@@ -181,6 +184,12 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	if (clone_flags & CLONE_SETTLS)
 		ret = set_new_tls(p, tls);
 
+#ifdef CONFIG_X86_64
+	/* Allocate a new shadow stack for pthread */
+	if (!ret)
+		ret = cet_setup_thread_shstk(p, clone_flags, stack_size);
+#endif
+
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
-- 
2.21.0

