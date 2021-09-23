Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052444168A0
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 01:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbhIWXyT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 19:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhIWXyT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 19:54:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B96C061574;
        Thu, 23 Sep 2021 16:52:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632441164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8t9Mp0mSo0gdX5tqhZywcW0+ZyH+wD62qovNnFG0fek=;
        b=Gfq5Y6o+jxu7HwFOFE571xUEos/tju+rt6TXz5RBhGT2qVKcOp/Dkxw/9IWTVvz01njN+V
        GaDQpO5JF8YnurogoFD+WpAQ6QAZoV+05n2wvgQm9tD6CifE+QA1B3sTGD3+VFDrN3lInY
        tMBHA4X29TGXQPq7zu+kY316Y2G+Hrts1T+eh6LFer239caINbAkKCiF3pb7eWMHijxied
        x/nIXYTwWuOsOUHTAUdenqvk3em4LDxj3u0CQy8MTQscfjTiDOtbkATJyzAx1Baaj3X35d
        l03MvQBBDkoABz3vezQT3gaAef9+YlF0ZI9ku3NlzrNoYhUbdrnBznsYLDraGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632441164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8t9Mp0mSo0gdX5tqhZywcW0+ZyH+wD62qovNnFG0fek=;
        b=DKQ0n3ESTHzTib/idxiRZH2/ZqyuWEs1TOhVgHpFx3VgNTNjyPAnSu0DJc9X7P8jSMTD+V
        B6U0xc6L5SwUplDg==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
In-Reply-To: <20210913200132.3396598-7-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-7-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 01:52:43 +0200
Message-ID: <87czoyg88k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
> +/* User Posted Interrupt Descriptor (UPID) */
> +struct uintr_upid {
> +	struct {
> +		u8 status;	/* bit 0: ON, bit 1: SN, bit 2-7: reserved */
> +		u8 reserved1;	/* Reserved */
> +		u8 nv;		/* Notification vector */
> +		u8 reserved2;	/* Reserved */
> +		u32 ndst;	/* Notification destination */
> +	} nc __packed;		/* Notification control */
> +	u64 puir;		/* Posted user interrupt requests */
> +} __aligned(64);
> +
> +/* UPID Notification control status */
> +#define UPID_ON		0x0	/* Outstanding notification */
> +#define UPID_SN		0x1	/* Suppressed notification */

Come on. This are bits in upid.status, right? So why can't the comment
above these defines says so and why can't the names not reflect that?

> +struct uintr_upid_ctx {
> +	struct uintr_upid *upid;
> +	refcount_t refs;

Please use tabular format for struct members. 

> +};
> +
> +struct uintr_receiver {
> +	struct uintr_upid_ctx *upid_ctx;
> +};

So we need a struct to wrap a pointer to another struct. Why?

> +inline bool uintr_arch_enabled(void)

What's this arch_enabled indirection for? Is this used anywhere in
non-architecture code?

> +{
> +	return static_cpu_has(X86_FEATURE_UINTR);
> +}
> +
> +static inline bool is_uintr_receiver(struct task_struct *t)
> +{
> +	return !!t->thread.ui_recv;
> +}
> +
> +static inline u32 cpu_to_ndst(int cpu)
> +{
> +	u32 apicid = (u32)apic->cpu_present_to_apicid(cpu);
> +
> +	WARN_ON_ONCE(apicid == BAD_APICID);

Brilliant. If x2apic is not enabled then this case returns

> +	if (!x2apic_enabled())
> +		return (apicid << 8) & 0xFF00;

  (BAD_APICID << 8) & 0xFF00 == 0xFF ....

> +int do_uintr_unregister_handler(void)
> +{
> +	struct task_struct *t = current;
> +	struct fpu *fpu = &t->thread.fpu;
> +	struct uintr_receiver *ui_recv;
> +	u64 msr64;
> +
> +	if (!is_uintr_receiver(t))
> +		return -EINVAL;
> +
> +	pr_debug("recv: Unregister handler and clear MSRs for task=%d\n",
> +		 t->pid);
> +
> +	/*
> +	 * TODO: Evaluate usage of fpregs_lock() and get_xsave_addr(). Bugs
> +	 * have been reported recently for PASID and WRPKRU.

Again. Which bugs and why haven't they been evaluated before posting?

> +	 * UPID and ui_recv will be referenced during context switch. Need to
> +	 * disable preemption while modifying the MSRs, UPID and ui_recv thread
> +	 * struct.
> +	 */
> +	fpregs_lock();

And because you need to disable preemption you need to use
fpregs_lock(), right? That's not what fpregs_lock() is about.

> +	/* Clear only the receiver specific state. Sender related state is not modified */
> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
> +		/* Modify only the relevant bits of the MISC MSR */
> +		rdmsrl(MSR_IA32_UINTR_MISC, msr64);
> +		msr64 &= ~GENMASK_ULL(39, 32);

This is exactly the crap which results from not defining stuff
properly. Random numbers in code which nobody can understand.

> +		wrmsrl(MSR_IA32_UINTR_MISC, msr64);
> +		wrmsrl(MSR_IA32_UINTR_PD, 0ULL);
> +		wrmsrl(MSR_IA32_UINTR_RR, 0ULL);
> +		wrmsrl(MSR_IA32_UINTR_STACKADJUST, 0ULL);
> +		wrmsrl(MSR_IA32_UINTR_HANDLER, 0ULL);
> +	} else {
> +		struct uintr_state *p;
> +
> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
> +		if (p) {
> +			p->handler = 0;
> +			p->stack_adjust = 0;
> +			p->upid_addr = 0;
> +			p->uinv = 0;
> +			p->uirr = 0;
> +		}

So p == NULL is expected here?

> +	}
> +
> +	ui_recv = t->thread.ui_recv;
> +	/*
> +	 * Suppress notifications so that no further interrupts are generated
> +	 * based on this UPID.
> +	 */
> +	set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
> +
> +	put_upid_ref(ui_recv->upid_ctx);
> +	kfree(ui_recv);
> +	t->thread.ui_recv = NULL;

Why has this put/kfree stuff to be in the fpregs locked section?

> +	fpregs_unlock();
> +
> +	return 0;
> +}
> +
> +int do_uintr_register_handler(u64 handler)
> +{
> +	struct uintr_receiver *ui_recv;
> +	struct uintr_upid *upid;
> +	struct task_struct *t = current;
> +	struct fpu *fpu = &t->thread.fpu;
> +	u64 misc_msr;
> +	int cpu;
> +
> +	if (is_uintr_receiver(t))
> +		return -EBUSY;
> +
> +	ui_recv = kzalloc(sizeof(*ui_recv), GFP_KERNEL);
> +	if (!ui_recv)
> +		return -ENOMEM;
> +
> +	ui_recv->upid_ctx = alloc_upid();
> +	if (!ui_recv->upid_ctx) {
> +		kfree(ui_recv);
> +		pr_debug("recv: alloc upid failed for task=%d\n", t->pid);
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * TODO: Evaluate usage of fpregs_lock() and get_xsave_addr(). Bugs
> +	 * have been reported recently for PASID and WRPKRU.

Oh well.

> +	 * UPID and ui_recv will be referenced during context switch. Need to
> +	 * disable preemption while modifying the MSRs, UPID and ui_recv thread
> +	 * struct.

See above.

> +	 */
> +	fpregs_lock();
> +
> +	cpu = smp_processor_id();
> +	upid = ui_recv->upid_ctx->upid;
> +	upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
> +	upid->nc.ndst = cpu_to_ndst(cpu);
> +
> +	t->thread.ui_recv = ui_recv;
> +
> +	if (fpregs_state_valid(fpu, cpu)) {
> +		wrmsrl(MSR_IA32_UINTR_HANDLER, handler);
> +		wrmsrl(MSR_IA32_UINTR_PD, (u64)ui_recv->upid_ctx->upid);
> +
> +		/* Set value as size of ABI redzone */
> +		wrmsrl(MSR_IA32_UINTR_STACKADJUST, 128);
> +
> +		/* Modify only the relevant bits of the MISC MSR */
> +		rdmsrl(MSR_IA32_UINTR_MISC, misc_msr);
> +		misc_msr |= (u64)UINTR_NOTIFICATION_VECTOR << 32;
> +		wrmsrl(MSR_IA32_UINTR_MISC, misc_msr);
> +	} else {
> +		struct xregs_state *xsave;
> +		struct uintr_state *p;
> +
> +		xsave = &fpu->state.xsave;
> +		xsave->header.xfeatures |= XFEATURE_MASK_UINTR;
> +		p = get_xsave_addr(&fpu->state.xsave, XFEATURE_UINTR);
> +		if (p) {
> +			p->handler = handler;
> +			p->upid_addr = (u64)ui_recv->upid_ctx->upid;
> +			p->stack_adjust = 128;
> +			p->uinv = UINTR_NOTIFICATION_VECTOR;
> +		}

Again. How is p supposed to be NULL and if so, why is this silently
treating this as success?

> +	}
> +
> +	fpregs_unlock();

Thanks,

        tglx
