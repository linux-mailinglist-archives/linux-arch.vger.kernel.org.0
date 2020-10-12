Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6228BC5D
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 17:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390582AbgJLPko (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 11:40:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:1310 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390468AbgJLPk0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 11:40:26 -0400
IronPort-SDR: nkArb2aAKWOx4cK6ijiDb8BtfZy9C9YKGR2AgiWRBpGrZcdKA4ukTLlj1vbjcmMjwLVrWxZNKg
 tAyZ0upGnhVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="250452730"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="250452730"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:40:00 -0700
IronPort-SDR: aomhbvFCcGr+YXAz+RATdp5xkR2VENwmacunYu45cxfJ8MpDLqhj+B2DiP94gn+aQFVc9cL/ug
 EGwo3B80ZDXg==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="530010935"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:39:59 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 24/26] x86/cet/shstk: Handle thread shadow stack
Date:   Mon, 12 Oct 2020 08:38:48 -0700
Message-Id: <20201012153850.26996-25-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201012153850.26996-1-yu-cheng.yu@intel.com>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
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

A 64-bit shadow stack has a size of min(RLIMIT_STACK, 4 GB).  A compat-mode
thread shadow stack has a size of 1/4 min(RLIMIT_STACK, 4 GB).  This allows
more threads to run in a 32-bit address space.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/cet.h         |  3 ++
 arch/x86/include/asm/mmu_context.h |  3 ++
 arch/x86/kernel/cet.c              | 44 ++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c          |  7 +++++
 4 files changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 73435856ce54..ec4b5e62d0ce 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -18,12 +18,15 @@ struct cet_status {
 
 #ifdef CONFIG_X86_CET
 int cet_setup_shstk(void);
+int cet_setup_thread_shstk(struct task_struct *p, unsigned long clone_flags);
 void cet_disable_shstk(void);
 void cet_free_shstk(struct task_struct *p);
 int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp);
 void cet_restore_signal(struct sc_ext *sc);
 int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
 #else
+static inline int cet_setup_thread_shstk(struct task_struct *p,
+					 unsigned long clone_flags) { return 0; }
 static inline void cet_disable_shstk(void) {}
 static inline void cet_free_shstk(struct task_struct *p) {}
 static inline void cet_restore_signal(struct sc_ext *sc) { return; }
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index d98016b83755..ceb593e405e1 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -11,6 +11,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
+#include <asm/cet.h>
 #include <asm/debugreg.h>
 
 extern atomic64_t last_mm_ctx_id;
@@ -142,6 +143,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		cet_free_shstk(tsk);		\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 728d9baceb74..d57f3a433af9 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -172,6 +172,50 @@ int cet_setup_shstk(void)
 	return 0;
 }
 
+int cet_setup_thread_shstk(struct task_struct *tsk, unsigned long clone_flags)
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
+	/* Cap shadow stack size to 4 GB */
+	size = min(rlimit(RLIMIT_STACK), 1UL << 32);
+
+	/*
+	 * Compat-mode pthreads share a limited address space.
+	 * If each function call takes an average of four slots
+	 * stack space, we need 1/4 of stack size for shadow stack.
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
index ff3b44d6740b..67632ba893b7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -110,6 +110,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	cet_free_shstk(tsk);
 	fpu__drop(fpu);
 }
 
@@ -182,6 +183,12 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	if (clone_flags & CLONE_SETTLS)
 		ret = set_new_tls(p, tls);
 
+#ifdef CONFIG_X86_64
+	/* Allocate a new shadow stack for pthread */
+	if (!ret)
+		ret = cet_setup_thread_shstk(p, clone_flags);
+#endif
+
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
-- 
2.21.0

