Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1E4AD401
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 09:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiBHIvz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 03:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiBHIvy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 03:51:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E330C03FEC0;
        Tue,  8 Feb 2022 00:51:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644310310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJ79wyb5Lwd0oOIyLi7EdNFXw/Kg+AetB4rjQlV4euY=;
        b=Vo/Wf5HZXC4C5DbflcKdxPDd5NLcagBb3LRcch//UU2kUhPY5USLVHI9QqH+F8SISO8N84
        52MUrytJVAs93QmAB1t/OTtvQ15sJrBFsuCU12QFrnhIcy0elEwW3s15bRNkko/Ofp9IM9
        PgUXxIR5zYvZtK+FUjAoFZcdcj/wdPgZDH5G6ArlfkXOnxaAP80bvBLosozZ91ZyKpcGQf
        oxsyanOnf8HDIWmdBSCqt4tEHnzdK33vqeNj+xDkM2c63oMa3PucrS5YEcUA07JE5SJFxH
        RBRuMjbl0XR0lABKtYd2cROIJ1GhmTRzLBJH5N/j34VskfRyXXxhMiSverYQZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644310310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJ79wyb5Lwd0oOIyLi7EdNFXw/Kg+AetB4rjQlV4euY=;
        b=5GC5P3IhZqkENu7N/SwNjQh9dGS+KnmjUmqgaaDWtxoojyYDcv+pRC8S/GhWfRzuydJNAq
        42un091nwOSGM7Aw==
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH 23/35] x86/fpu: Add helpers for modifying supervisor xstate
In-Reply-To: <20220130211838.8382-24-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-24-rick.p.edgecombe@intel.com>
Date:   Tue, 08 Feb 2022 09:51:50 +0100
Message-ID: <87pmnxvizd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30 2022 at 13:18, Rick Edgecombe wrote:
> In addition, now that get_xsave_addr() is not available outside of the
> core fpu code, there isn't even a way for these supervisor features to
> modify the in memory state.
>
> To resolve these problems, add some helpers that encapsulate the correct
> logic to operate on the correct copy of the state. Map the MSR's to the
> struct field location in a case statements in __get_xsave_member().

I like the approach in principle, but you still expose the xstate
internals via the void pointer. It's just a question of time that this
is type casted and abused in interesting ways.

Something like the below untested (on top of the whole series) preserves
the encapsulation and reduces the code at the call sites.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -165,12 +165,7 @@ static inline bool fpstate_is_confidenti
 struct task_struct;
 extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2);
 
-void *start_update_xsave_msrs(int xfeature_nr);
-void end_update_xsave_msrs(void);
-int xsave_rdmsrl(void *xstate, unsigned int msr, unsigned long long *p);
-int xsave_wrmsrl(void *xstate, u32 msr, u64 val);
-int xsave_set_clear_bits_msrl(void *xstate, u32 msr, u64 set, u64 clear);
-
-void *get_xsave_buffer_unsafe(struct fpu *fpu, int xfeature_nr);
-int xsave_wrmsrl_unsafe(void *xstate, u32 msr, u64 val);
+int xsave_rdmsrs(int xfeature_nr, struct xstate_msr *xmsr, int num_msrs);
+int xsave_wrmsrs(int xfeature_nr, struct xstate_msr *xmsr, int num_msrs);
+int xsave_wrmsrs_on_task(struct task_struct *tsk, int xfeature_nr, struct xstate_msr *xmsr, int num_msrs);
 #endif /* _ASM_X86_FPU_API_H */
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -601,4 +601,12 @@ struct fpu_state_config {
 /* FPU state configuration information */
 extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
 
+struct xstate_msr {
+	unsigned int	msr;
+	unsigned int	bitop;
+	u64		val;
+	u64		set;
+	u64		clear;
+};
+
 #endif /* _ASM_X86_FPU_H */
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1868,7 +1868,7 @@ int proc_pid_arch_status(struct seq_file
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
 
-static u64 *__get_xsave_member(void *xstate, u32 msr)
+static u64 *xstate_get_member(void *xstate, u32 msr)
 {
 	switch (msr) {
 	case MSR_IA32_PL3_SSP:
@@ -1882,22 +1882,11 @@ static u64 *__get_xsave_member(void *xst
 }
 
 /*
- * Operate on the xsave buffer directly. It makes no gaurantees that the
- * buffer will stay valid now or in the futre. This function is pretty
- * much only useful when the caller knows the fpu's thread can't be
- * scheduled or otherwise operated on concurrently.
- */
-void *get_xsave_buffer_unsafe(struct fpu *fpu, int xfeature_nr)
-{
-	return get_xsave_addr(&fpu->fpstate->regs.xsave, xfeature_nr);
-}
-
-/*
  * Return a pointer to the xstate for the feature if it should be used, or NULL
  * if the MSRs should be written to directly. To do this safely, using the
  * associated read/write helpers is required.
  */
-void *start_update_xsave_msrs(int xfeature_nr)
+static void *xsave_msrs_op_start(int xfeature_nr)
 {
 	void *xstate;
 
@@ -1938,7 +1927,7 @@ void *start_update_xsave_msrs(int xfeatu
 	return xstate;
 }
 
-void end_update_xsave_msrs(void)
+static void xsave_msrs_op_end(void)
 {
 	fpregs_unlock();
 }
@@ -1951,7 +1940,7 @@ void end_update_xsave_msrs(void)
  *
  * But if this correspondence is broken by either a write to the in-memory
  * buffer or the registers, the kernel needs to be notified so it doesn't miss
- * an xsave or restore. __xsave_msrl_prepare_write() peforms this check and
+ * an xsave or restore. xsave_msrs_prepare_write() performs this check and
  * notifies the kernel if needed. Use before writes only, to not take away
  * the kernel's options when not required.
  *
@@ -1959,65 +1948,107 @@ void end_update_xsave_msrs(void)
  * must have resulted in targeting the in-memory state, so invaliding the
  * registers is the right thing to do.
  */
-static void __xsave_msrl_prepare_write(void)
+static void xsave_msrs_prepare_write(void)
 {
 	if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
 	    fpregs_state_valid(&current->thread.fpu, smp_processor_id()))
 		__fpu_invalidate_fpregs_state(&current->thread.fpu);
 }
 
-int xsave_rdmsrl(void *xstate, unsigned int msr, unsigned long long *p)
+static int read_xstate_or_msr(struct xstate_msr *xmsr, void *xstate)
 {
 	u64 *member_ptr;
 
 	if (!xstate)
-		return rdmsrl_safe(msr, p);
+		return rdmsrl_safe(xmsr->msr, &xmsr->val);
 
-	member_ptr = __get_xsave_member(xstate, msr);
+	member_ptr = xstate_get_member(xstate, xmsr->msr);
 	if (!member_ptr)
 		return 1;
 
-	*p = *member_ptr;
-
+	xmsr->val = *member_ptr;
 	return 0;
 }
 
+int xsave_rdmsrs(int xfeature_nr, struct xstate_msr *xmsr, int num_msrs)
+{
+	void *xstate = xsave_msrs_op_start(xfeature_nr);
+	int i, ret;
+
+	for (i = 0, ret = 0; !ret && i < num_msrs; i++, xmsr++)
+		ret = read_xstate_or_msr(xmsr, xstate);
+
+	xsave_msrs_op_end();
+	return ret;
+}
 
-int xsave_wrmsrl_unsafe(void *xstate, u32 msr, u64 val)
+static int write_xstate(struct xstate_msr *xmsr, void *xstate)
 {
-	u64 *member_ptr;
+	u64 *member_ptr = xstate_get_member(xstate, xmsr->msr);
 
-	member_ptr = __get_xsave_member(xstate, msr);
 	if (!member_ptr)
 		return 1;
 
-	*member_ptr = val;
-
+	*member_ptr = xmsr->val;
 	return 0;
 }
 
-int xsave_wrmsrl(void *xstate, u32 msr, u64 val)
+static int write_xstate_or_msr(struct xstate_msr *xmsr, void *xstate)
 {
-	__xsave_msrl_prepare_write();
 	if (!xstate)
-		return wrmsrl_safe(msr, val);
-
-	return xsave_wrmsrl_unsafe(xstate, msr, val);
+		return wrmsrl_safe(xmsr->msr, xmsr->val);
+	return write_xstate(xmsr, xstate);
 }
 
-int xsave_set_clear_bits_msrl(void *xstate, u32 msr, u64 set, u64 clear)
+static int mod_xstate_or_msr_bits(struct xstate_msr *xmsr, void *xstate)
 {
-	u64 val, new_val;
+	u64 val;
 	int ret;
 
-	ret = xsave_rdmsrl(xstate, msr, &val);
+	ret = read_xstate_or_msr(xmsr, xstate);
 	if (ret)
 		return ret;
 
-	new_val = (val & ~clear) | set;
+	val = xmsr->val;
+	xmsr->val = (val & ~xmsr->clear) | xmsr->set;
 
-	if (new_val != val)
-		return xsave_wrmsrl(xstate, msr, new_val);
+	if (val != xmsr->val)
+		return write_xstate_or_msr(xmsr, xstate);
 
 	return 0;
 }
+
+static int __xsave_wrmsrs(void *xstate, struct xstate_msr *xmsr, int num_msrs)
+{
+	int i, ret;
+
+	for (i = 0, ret = 0; !ret && i < num_msrs; i++, xmsr++) {
+		if (!xmsr->bitop)
+			ret = write_xstate_or_msr(xmsr, xstate);
+		else
+			ret = mod_xstate_or_msr_bits(xmsr, xstate);
+	}
+
+	return ret;
+}
+
+int xsave_wrmsrs(int xfeature_nr, struct xstate_msr *xmsr, int num_msrs)
+{
+	void *xstate = xsave_msrs_op_start(xfeature_nr);
+	int ret;
+
+	xsave_msrs_prepare_write();
+	ret = __xsave_wrmsrs(xstate, xmsr, num_msrs);
+	xsave_msrs_op_end();
+	return ret;
+}
+
+int xsave_wrmsrs_on_task(struct task_struct *tsk, int xfeature_nr, struct xstate_msr *xmsr,
+			 int num_msrs)
+{
+	void *xstate = get_xsave_addr(&tsk->thread.fpu.fpstate->regs.xsave, xfeature_nr);
+
+	if (WARN_ON_ONCE(!xstate))
+		return -EINVAL;
+	return __xsave_wrmsrs(xstate, xmsr, num_msrs);
+}
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -106,8 +106,7 @@ int shstk_setup(void)
 {
 	struct thread_shstk *shstk = &current->thread.shstk;
 	unsigned long addr, size;
-	void *xstate;
-	int err;
+	struct xstate_msr xmsr[2];
 
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
 	    shstk->size ||
@@ -119,13 +118,10 @@ int shstk_setup(void)
 	if (IS_ERR_VALUE(addr))
 		return 1;
 
-	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
-	err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, addr + size);
-	if (!err)
-		err = xsave_wrmsrl(xstate, MSR_IA32_U_CET, CET_SHSTK_EN);
-	end_update_xsave_msrs();
+	xmsr[0] = (struct xstate_msr) { .msr = MSR_IA32_PL3_SSP, .val = addr + size };
+	xmsr[0] = (struct xstate_msr) { .msr = MSR_IA32_U_CET, .val = CET_SHSTK_EN };
 
-	if (err) {
+	if (xsave_wrmsrs(XFEATURE_CET_USER, xmsr, ARRAY_SIZE(xmsr))) {
 		/*
 		 * Don't leak shadow stack if something went wrong with writing the
 		 * msrs. Warn about it because things may be in a weird state.
@@ -150,8 +146,8 @@ int shstk_alloc_thread_stack(struct task
 			     unsigned long stack_size)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
+	struct xstate_msr xmsr[1];
 	unsigned long addr;
-	void *xstate;
 
 	/*
 	 * If shadow stack is not enabled on the new thread, skip any
@@ -183,15 +179,6 @@ int shstk_alloc_thread_stack(struct task
 	if (in_compat_syscall())
 		stack_size /= 4;
 
-	/*
-	 * 'tsk' is configured with a shadow stack and the fpu.state is
-	 * up to date since it was just copied from the parent.  There
-	 * must be a valid non-init CET state location in the buffer.
-	 */
-	xstate = get_xsave_buffer_unsafe(&tsk->thread.fpu, XFEATURE_CET_USER);
-	if (WARN_ON_ONCE(!xstate))
-		return -EINVAL;
-
 	stack_size = PAGE_ALIGN(stack_size);
 	addr = alloc_shstk(stack_size, stack_size, false);
 	if (IS_ERR_VALUE(addr)) {
@@ -200,7 +187,11 @@ int shstk_alloc_thread_stack(struct task
 		return PTR_ERR((void *)addr);
 	}
 
-	xsave_wrmsrl_unsafe(xstate, MSR_IA32_PL3_SSP, (u64)(addr + stack_size));
+	xmsr[0] = (struct xstate_msr) { .msr = MSR_IA32_PL3_SSP, .val = addr + stack_size };
+	if (xsave_wrmsrs_on_task(tsk, XFEATURE_CET_USER, xmsr, ARRAY_SIZE(xmsr))) {
+		unmap_shadow_stack(addr, stack_size);
+		return 1;
+	}
 	shstk->base = addr;
 	shstk->size = stack_size;
 	return 0;
@@ -232,8 +223,8 @@ void shstk_free(struct task_struct *tsk)
 
 int wrss_control(bool enable)
 {
+	struct xstate_msr xmsr[1] = {[0] = { .msr = MSR_IA32_U_CET, .bitop = 1,}, };
 	struct thread_shstk *shstk = &current->thread.shstk;
-	void *xstate;
 	int err;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
@@ -246,13 +237,11 @@ int wrss_control(bool enable)
 	if (!shstk->size || shstk->wrss == enable)
 		return 1;
 
-	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
 	if (enable)
-		err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, CET_WRSS_EN, 0);
+		xmsr[0].set = CET_WRSS_EN;
 	else
-		err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, 0, CET_WRSS_EN);
-	end_update_xsave_msrs();
-
+		xmsr[0].clear = CET_WRSS_EN;
+	err = xsave_wrmsrs(XFEATURE_CET_USER, xmsr, ARRAY_SIZE(xmsr));
 	if (err)
 		return 1;
 
@@ -263,7 +252,7 @@ int wrss_control(bool enable)
 int shstk_disable(void)
 {
 	struct thread_shstk *shstk = &current->thread.shstk;
-	void *xstate;
+	struct xstate_msr xmsr[2];
 	int err;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
@@ -271,14 +260,11 @@ int shstk_disable(void)
 	    !shstk->base)
 		return 1;
 
-	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
-	/* Disable WRSS too when disabling shadow stack */
-	err = xsave_set_clear_bits_msrl(xstate, MSR_IA32_U_CET, 0,
-					CET_SHSTK_EN | CET_WRSS_EN);
-	if (!err)
-		err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, 0);
-	end_update_xsave_msrs();
+	xmsr[0] = (struct xstate_msr) { .msr = MSR_IA32_U_CET, .bitop = 1,
+		.set = 0, .clear = CET_SHSTK_EN | CET_WRSS_EN };
+	xmsr[1] = (struct xstate_msr) { .msr = MSR_IA32_PL3_SSP, .val = 0 };
 
+	err = xsave_wrmsrs(XFEATURE_CET_USER, xmsr, ARRAY_SIZE(xmsr));
 	if (err)
 		return 1;
 
@@ -289,16 +275,10 @@ int shstk_disable(void)
 
 static unsigned long get_user_shstk_addr(void)
 {
-	void *xstate;
-	unsigned long long ssp;
-
-	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
-
-	xsave_rdmsrl(xstate, MSR_IA32_PL3_SSP, &ssp);
-
-	end_update_xsave_msrs();
+	struct xstate_msr xmsr[1] = { [0] = {.msr = MSR_IA32_PL3_SSP, }, };
 
-	return ssp;
+	xsave_rdmsrs(XFEATURE_CET_USER, xmsr, ARRAY_SIZE(xmsr));
+	return xmsr[0].val;
 }
 
 /*
@@ -385,8 +365,8 @@ int shstk_check_rstor_token(bool proc32,
 int setup_signal_shadow_stack(int proc32, void __user *restorer)
 {
 	struct thread_shstk *shstk = &current->thread.shstk;
+	struct xstate_msr xmsr[1];
 	unsigned long new_ssp;
-	void *xstate;
 	int err;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) || !shstk->size)
@@ -397,18 +377,15 @@ int setup_signal_shadow_stack(int proc32
 	if (err)
 		return err;
 
-	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
-	err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, new_ssp);
-	end_update_xsave_msrs();
-
-	return err;
+	xmsr[0] = (struct xstate_msr) { .msr = MSR_IA32_PL3_SSP, .val = new_ssp };
+	return xsave_wrmsrs(XFEATURE_CET_USER, xmsr, ARRAY_SIZE(xmsr));
 }
 
 int restore_signal_shadow_stack(void)
 {
 	struct thread_shstk *shstk = &current->thread.shstk;
-	void *xstate;
 	int proc32 = in_ia32_syscall();
+	struct xstate_msr xmsr[1];
 	unsigned long new_ssp;
 	int err;
 
@@ -419,11 +396,8 @@ int restore_signal_shadow_stack(void)
 	if (err)
 		return err;
 
-	xstate = start_update_xsave_msrs(XFEATURE_CET_USER);
-	err = xsave_wrmsrl(xstate, MSR_IA32_PL3_SSP, new_ssp);
-	end_update_xsave_msrs();
-
-	return err;
+	xmsr[0] = (struct xstate_msr) { .msr = MSR_IA32_PL3_SSP, .val = new_ssp };
+	return xsave_wrmsrs(XFEATURE_CET_USER, xmsr, ARRAY_SIZE(xmsr));
 }
 
 SYSCALL_DEFINE2(map_shadow_stack, unsigned long, size, unsigned int, flags)
