Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F24A3A35
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356645AbiA3VZe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:25:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356648AbiA3VYU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577860; x=1675113860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=t3JrZFhF1CwcBiNV2/x8DFu6hUw9NbjzQecxrm091YQ=;
  b=aZ6GdfkmrrEBFzN0fsQtrz+PE4+2ua0PdNKWVXZ9Q5MUU/oZBLWIxbgC
   s7DFK1ubikxeyjh2HTqmxZMioH+23kQczKa0x55LOl/v+c35LqkndSlxJ
   qjoEb5Drqr86FkZkedhNPFjDHCEAQoJFTyS/ZwnAXwcRrSV+xCCdpDv9w
   hqOXzHThWPRZdm+nXoNH+e4LMp14S5zfioiul05KHdvI3/tCv7fZhRFbk
   cXoOPwT/L1tgxK/O0+qhxeE4TYGPA3juuL+PZdUSx7Ujqjmbv4/ZgswMK
   Bbd6ZNcUm1nPgl3MZ+rmTT/HHVvLMpElXHCYVopazM3pL2Pn6wWuBnp/D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104961"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104961"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856868"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:03 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 23/35] x86/fpu: Add helpers for modifying supervisor xstate
Date:   Sun, 30 Jan 2022 13:18:26 -0800
Message-Id: <20220130211838.8382-24-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add helpers that can be used to modify supervisor xstate safely for the
current task.

State for supervisors xstate based features can be live and
accesses via MSR's, or saved in memory in an xsave buffer. When the
kernel needs to modify this state it needs to be sure to operate on it
in the right place, so the modifications don't get clobbered.

In the past supervisor xstate features have used get_xsave_addr()
directly, and performed open coded logic handle operating on the saved
state correctly. This has posed two problems:
 1. It has logic that has been gotten wrong more than once.
 2. To reduce code, less common path's are not optimized. Determination
    of which path's are less common is based on assumptions about far away
    code that could change.

In addition, now that get_xsave_addr() is not available outside of the
core fpu code, there isn't even a way for these supervisor features to
modify the in memory state.

To resolve these problems, add some helpers that encapsulate the correct
logic to operate on the correct copy of the state. Map the MSR's to the
struct field location in a case statements in __get_xsave_member().

Use the helpers like this, to write to either the MSR or saved state:
void *xstate;

xstate = start_update_xsave_msrs(XFEATURE_FOO);
r = xsave_rdmsrl(state, MSR_IA32_FOO_1, &val)
if (r)
	xsave_wrmsrl(state, MSR_IA32_FOO_2, FOO_ENABLE);
end_update_xsave_msrs();

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - New patch.

 arch/x86/include/asm/fpu/api.h |   5 ++
 arch/x86/kernel/fpu/xstate.c   | 134 +++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index c83b3020350a..6aec27984b62 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -165,4 +165,9 @@ static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 struct task_struct;
 extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2);
 
+void *start_update_xsave_msrs(int xfeature_nr);
+void end_update_xsave_msrs(void);
+int xsave_rdmsrl(void *state, unsigned int msr, unsigned long long *p);
+int xsave_wrmsrl(void *state, u32 msr, u64 val);
+int xsave_set_clear_bits_msrl(void *state, u32 msr, u64 set, u64 clear);
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 44397202762b..c5e20e0d0725 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1867,3 +1867,137 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+static u64 *__get_xsave_member(void *xstate, u32 msr)
+{
+	switch (msr) {
+	/* Currently there are no MSR's supported */
+	default:
+		WARN_ONCE(1, "x86/fpu: unsupported xstate msr (%u)\n", msr);
+		return NULL;
+	}
+}
+
+/*
+ * Return a pointer to the xstate for the feature if it should be used, or NULL
+ * if the MSRs should be written to directly. To do this safely, using the
+ * associated read/write helpers is required.
+ */
+void *start_update_xsave_msrs(int xfeature_nr)
+{
+	void *xstate;
+
+	/*
+	 * fpregs_lock() only disables preemption (mostly). So modifing state
+	 * in an interrupt could screw up some in progress fpregs operation,
+	 * but appear to work. Warn about it.
+	 */
+	WARN_ON_ONCE(!in_task());
+	WARN_ON_ONCE(current->flags & PF_KTHREAD);
+
+	fpregs_lock();
+
+	fpregs_assert_state_consistent();
+
+	/*
+	 * If the registers don't need to be reloaded. Go ahead and operate on the
+	 * registers.
+	 */
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
+		return NULL;
+
+	xstate = get_xsave_addr(&current->thread.fpu.fpstate->regs.xsave, xfeature_nr);
+
+	/*
+	 * If regs are in the init state, they can't be retrieved from
+	 * init_fpstate due to the init optimization, but are not nessarily
+	 * zero. The only option is to restore to make everything live and
+	 * operate on registers. This will clear TIF_NEED_FPU_LOAD.
+	 *
+	 * Otherwise, if not in the init state but TIF_NEED_FPU_LOAD is set,
+	 * operate on the buffer. The registers will be restored before going
+	 * to userspace in any case, but the task might get preempted before
+	 * then, so this possibly saves an xsave.
+	 */
+	if (!xstate)
+		fpregs_restore_userregs();
+	return xstate;
+}
+
+void end_update_xsave_msrs(void)
+{
+	fpregs_unlock();
+}
+
+/*
+ * When TIF_NEED_FPU_LOAD is set and fpregs_state_valid() is true, the saved
+ * state and fp state match. In this case, the kernel has some good options -
+ * it can skip the restore before returning to userspace or it could skip
+ * an xsave if preempted before then.
+ *
+ * But if this correspondence is broken by either a write to the in-memory
+ * buffer or the registers, the kernel needs to be notified so it doesn't miss
+ * an xsave or restore. __xsave_msrl_prepare_write() peforms this check and
+ * notifies the kernel if needed. Use before writes only, to not take away
+ * the kernel's options when not required.
+ *
+ * If TIF_NEED_FPU_LOAD is set, then the logic in start_update_xsave_msrs()
+ * must have resulted in targeting the in-memory state, so invaliding the
+ * registers is the right thing to do.
+ */
+static void __xsave_msrl_prepare_write(void)
+{
+	if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
+	    fpregs_state_valid(&current->thread.fpu, smp_processor_id()))
+		__fpu_invalidate_fpregs_state(&current->thread.fpu);
+}
+
+int xsave_rdmsrl(void *xstate, unsigned int msr, unsigned long long *p)
+{
+	u64 *member_ptr;
+
+	if (!xstate)
+		return rdmsrl_safe(msr, p);
+
+	member_ptr = __get_xsave_member(xstate, msr);
+	if (!member_ptr)
+		return 1;
+
+	*p = *member_ptr;
+
+	return 0;
+}
+
+int xsave_wrmsrl(void *xstate, u32 msr, u64 val)
+{
+	u64 *member_ptr;
+
+	__xsave_msrl_prepare_write();
+	if (!xstate)
+		return wrmsrl_safe(msr, val);
+
+	member_ptr = __get_xsave_member(xstate, msr);
+	if (!member_ptr)
+		return 1;
+
+	*member_ptr = val;
+
+	return 0;
+}
+
+int xsave_set_clear_bits_msrl(void *xstate, u32 msr, u64 set, u64 clear)
+{
+	u64 val, new_val;
+	int ret;
+
+	ret = xsave_rdmsrl(xstate, msr, &val);
+	if (ret)
+		return ret;
+
+	new_val = (val & ~clear) | set;
+
+	if (new_val != val)
+		return xsave_wrmsrl(xstate, msr, new_val);
+
+	return 0;
+}
-- 
2.17.1

