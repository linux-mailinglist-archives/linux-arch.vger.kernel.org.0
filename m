Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C795A37E23
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfFFUPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:15:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:47825 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbfFFUPk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:15:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 13:15:40 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2019 13:15:38 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 24/27] x86/cet/shstk: Handle thread shadow stack
Date:   Thu,  6 Jun 2019 13:06:43 -0700
Message-Id: <20190606200646.3951-25-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606200646.3951-1-yu-cheng.yu@intel.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The shadow stack for clone/fork is handled as the following:

(1) If ((clone_flags & (CLONE_VFORK | CLONE_VM)) == CLONE_VM),
    the kernel allocates (and frees on thread exit) a new SHSTK
    for the child.

    It is possible for the kernel to complete the clone syscall
    and set the child's SHSTK pointer to NULL and let the child
    thread allocate a SHSTK for itself.  There are two issues
    in this approach: It is not compatible with existing code
    that does inline syscall and it cannot handle signals before
    the child can successfully allocate a SHSTK.

(2) For (clone_flags & CLONE_VFORK), the child uses the existing
    SHSTK.

(3) For all other cases, the SHSTK is copied/reused whenever the
    parent or the child does a call/ret.

This patch handles cases (1) & (2).  Case (3) is handled in the
SHSTK page fault patches.

A 64-bit SHSTK has a fixed size of RLIMIT_STACK. A compat-mode
thread SHSTK has a fixed size of 1/4 RLIMIT_STACK.  This allows
more threads to share a 32-bit address space.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h         |  2 ++
 arch/x86/include/asm/mmu_context.h |  3 +++
 arch/x86/kernel/cet.c              | 41 ++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c          |  1 +
 arch/x86/kernel/process_64.c       |  7 +++++
 5 files changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 422ccb8adbb7..52c506a68848 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -19,12 +19,14 @@ struct cet_status {
 
 #ifdef CONFIG_X86_INTEL_CET
 int cet_setup_shstk(void);
+int cet_setup_thread_shstk(struct task_struct *p);
 void cet_disable_shstk(void);
 void cet_disable_free_shstk(struct task_struct *p);
 int cet_restore_signal(bool ia32, struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
 static inline int cet_setup_shstk(void) { return -EINVAL; }
+static inline int cet_setup_thread_shstk(struct task_struct *p) { return 0; }
 static inline void cet_disable_shstk(void) {}
 static inline void cet_disable_free_shstk(struct task_struct *p) {}
 static inline int cet_restore_signal(bool ia32, struct sc_ext *sc) { return -EINVAL; }
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 9024236693d2..a9a768529540 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/mpx.h>
+#include <asm/cet.h>
 #include <asm/debugreg.h>
 
 extern atomic64_t last_mm_ctx_id;
@@ -228,6 +229,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		cet_disable_free_shstk(tsk);	\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index b247cd15c1e2..9ef1af617d38 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -151,6 +151,47 @@ int cet_setup_shstk(void)
 	return 0;
 }
 
+int cet_setup_thread_shstk(struct task_struct *tsk)
+{
+	unsigned long addr, size;
+	struct cet_user_state *state;
+
+	if (!current->thread.cet.shstk_enabled)
+		return 0;
+
+	state = get_xsave_addr(&tsk->thread.fpu.state.xsave,
+			       XFEATURE_CET_USER);
+
+	if (!state)
+		return -EINVAL;
+
+	size = rlimit(RLIMIT_STACK);
+
+	/*
+	 * Compat-mode pthreads share a limited address space.
+	 * If each function call takes an average of four slots
+	 * stack space, we need 1/4 of stack size for shadow stack.
+	 */
+	if (in_compat_syscall())
+		size /= 4;
+
+	addr = do_mmap_locked(0, size, PROT_READ,
+			      MAP_ANONYMOUS | MAP_PRIVATE, VM_SHSTK);
+
+	if (addr >= TASK_SIZE_MAX) {
+		tsk->thread.cet.shstk_base = 0;
+		tsk->thread.cet.shstk_size = 0;
+		tsk->thread.cet.shstk_enabled = 0;
+		return -ENOMEM;
+	}
+
+	fpu__prepare_write(&tsk->thread.fpu);
+	state->user_ssp = (u64)(addr + size - sizeof(u64));
+	tsk->thread.cet.shstk_base = addr;
+	tsk->thread.cet.shstk_size = size;
+	return 0;
+}
+
 void cet_disable_shstk(void)
 {
 	u64 r;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index a4deb79b1089..58b1c52b38b5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -130,6 +130,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	cet_disable_free_shstk(tsk);
 	fpu__drop(fpu);
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c51df5b4e116..5fa0d9ab18f1 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -421,6 +421,13 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	if (sp)
 		childregs->sp = sp;
 
+	/* Allocate a new shadow stack for pthread */
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) == CLONE_VM) {
+		err = cet_setup_thread_shstk(p);
+		if (err)
+			goto out;
+	}
+
 	err = -ENOMEM;
 	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
-- 
2.17.1

