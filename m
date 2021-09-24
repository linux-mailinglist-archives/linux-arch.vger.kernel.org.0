Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A33416906
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 02:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbhIXAme (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 20:42:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXAme (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 20:42:34 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632444060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zXfTZ+GYJuAlTvwD0gnPMLpPOiMWxUhIpzWwItpbK8=;
        b=tka5/WaXLIDBZlHLfEZCHr7T0SiqtjE7qZcco4BbPl4YB90XQp+taEfxOKZ2ZFJWaAQm1H
        9Xl4dqSbLas3FcdhvM78Phi2GPzbSRxOSFgs8sm0Z9500MieXyNMjMLHsR5R7s0pDPmEZV
        316hzAWPBheq8c7udmnVyzQsvhWwJ9dXxbN7DeIlrlCmhM0CtYHFtI/K+9bgPiWLLvbLgE
        WFv/sQ2nm1Oa3+zgTlHScgRD72m/KO2fx0L47FdUEnRF1vUAsJ7aAKDjqM1kK0vEV/tL48
        WUIT8kdzllvj8MklbFXOdg4xeLjY8nVU04lxsIoNleNQjKJ0N/zz/N5LZpaKow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632444060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zXfTZ+GYJuAlTvwD0gnPMLpPOiMWxUhIpzWwItpbK8=;
        b=RNyvEZn376kZqZ+xtEIN+2+MV6KdIbQ8d44pdw8DiLgNHwH0p0pjzxW7lLpfQvOr5pNdIS
        ZGHNKLk/zpV/q6Cg==
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
Subject: Re: [RFC PATCH 07/13] x86/process/64: Add uintr task context switch
 support
In-Reply-To: <20210913200132.3396598-8-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-8-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 02:41:00 +0200
Message-ID: <877df6g603.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:

> User interrupt state is saved and restored using xstate supervisor
> feature support. This includes the MSR state and the User Interrupt Flag
> (UIF) value.
>
> During context switch update the UPID for a uintr task to reflect the
> current state of the task; namely whether the task should receive
> interrupt notifications and which cpu the task is currently running on.
>
> XSAVES clears the notification vector (UINV) in the MISC MSR to prevent
> interrupts from being recognized in the UIRR MSR while the task is being
> context switched. The UINV is restored back when the kernel does an
> XRSTORS.
>
> However, this conflicts with the kernel's lazy restore optimization
> which skips an XRSTORS if the kernel is scheduling the same user task
> back and the underlying MSR state hasn't been modified. Special handling
> is needed for a uintr task in the context switch path to keep using this
> optimization.

And this special handling is?

Distinct void of content here.

>  /* Check that the stack and regs on entry from user mode are sane. */
>  static __always_inline void arch_check_user_regs(struct pt_regs *regs)
> @@ -57,6 +58,9 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
>  		switch_fpu_return();
>  
> +	if (static_cpu_has(X86_FEATURE_UINTR))
> +		switch_uintr_return();
> +

...

> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -95,6 +95,14 @@ EXPORT_SYMBOL(irq_fpu_usable);
>   * over the place.
>   *
>   * FXSAVE and all XSAVE variants preserve the FPU register state.
> + *
> + * When XSAVES is called with XFEATURE_UINTR enabled it
> + * saves the FPU state and clears the interrupt notification
> + * vector byte of the MISC_MSR [bits 39:32]. This is required
> + * to stop detecting additional User Interrupts after we
> + * have saved the FPU state. Before going back to userspace
> + * we would correct this and only program the byte that was

we would?

This simply has to be done before returning to user space no matter
what. And _we_ can't do that. Please do not impersonate code.

> + * cleared.
>   */
>  void save_fpregs_to_fpstate(struct fpu *fpu)
>  {
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index ec0d836a13b1..62b82137db9c 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -53,6 +53,7 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/vdso.h>
>  #include <asm/resctrl.h>
> +#include <asm/uintr.h>
>  #include <asm/unistd.h>
>  #include <asm/fsgsbase.h>
>  #ifdef CONFIG_IA32_EMULATION
> @@ -565,6 +566,9 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
>  		     this_cpu_read(hardirq_stack_inuse));
>  
> +	if (static_cpu_has(X86_FEATURE_UINTR))

cpu_feature_enabled() please.

> +		switch_uintr_prepare(prev_p);
> +
>  	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
>  		switch_fpu_prepare(prev_fpu, cpu);
>  
> diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
> index 2c6042a6840a..7a29888050ad 100644
> --- a/arch/x86/kernel/uintr_core.c
> +++ b/arch/x86/kernel/uintr_core.c
> @@ -238,3 +238,78 @@ int do_uintr_register_handler(u64 handler)
>  
>  	return 0;
>  }
> +
> +/* Suppress notifications since this task is being context switched out */
> +void switch_uintr_prepare(struct task_struct *prev)
> +{
> +	struct uintr_upid *upid;
> +
> +	if (is_uintr_receiver(prev)) {
> +		upid = prev->thread.ui_recv->upid_ctx->upid;
> +		set_bit(UPID_SN, (unsigned long *)&upid->nc.status);

Please add a comment why this needs to be a locked instruction.

> +	}
> +}
> +
> +/*
> + * Do this right before we are going back to userspace after the FPU has been
> + * reloaded i.e. TIF_NEED_FPU_LOAD is clear.
> + * Called from arch_exit_to_user_mode_prepare() with interrupts disabled.
> + */
> +void switch_uintr_return(void)
> +{
> +	struct uintr_upid *upid;
> +	u64 misc_msr;
> +
> +	if (is_uintr_receiver(current)) {
> +		/*
> +		 * The XSAVES instruction clears the UINTR notification
> +		 * vector(UINV) in the UINT_MISC MSR when user context gets
> +		 * saved. Before going back to userspace we need to restore the
> +		 * notification vector. XRSTORS would automatically restore the
> +		 * notification but we can't be sure that XRSTORS will always
> +		 * be called when going back to userspace. Also if XSAVES gets
> +		 * called twice the UINV stored in the Xstate buffer will be
> +		 * overwritten. Threfore, before going back to userspace we
> +		 * always check if the UINV is set and reprogram if needed.
> +		 *
> +		 * Alternatively, we could combine this with
> +		 * switch_fpu_return() and program the MSR whenever we are
> +		 * skipping the XRSTORS. We need special precaution to make
> +		 * sure the UINV value in the XSTATE buffer doesn't get
> +		 * overwritten by calling XSAVES twice.
> +		 */
> +		WARN_ON_ONCE(test_thread_flag(TIF_NEED_FPU_LOAD));
> +
> +		/* Modify only the relevant bits of the MISC MSR */

I surely appreciate the well thought out hardware design which requires
yet another rdmsrl/wrmsrl pair here.

Of course this is invoked unconditionally when the CPU has
X86_FEATURE_UINTR:

> +	if (static_cpu_has(X86_FEATURE_UINTR))
> +		switch_uintr_return();

Why?

If the sequence is:

     syscall()
     do_stuff()
     return_to_user()

then what on earth has modified that MSR state? Nothing at all, but you
still run this code. What for?

> +		rdmsrl(MSR_IA32_UINTR_MISC, misc_msr);
> +		if (!(misc_msr & GENMASK_ULL(39, 32))) {

Hardcoded random numbers ...

> +			misc_msr |= (u64)UINTR_NOTIFICATION_VECTOR << 32;

Hardcoded numerical shift value...

> +			wrmsrl(MSR_IA32_UINTR_MISC, misc_msr);
> +		}
> +
> +		/*
> +		 * It is necessary to clear the SN bit after we set UINV and
> +		 * NDST to avoid incorrect interrupt routing.

Right, because if the task did not go through schedule() this state has not
been changed at all and therefore you need to clear SN just in case to
make sure that it hasn't been set by accident, right?

> +		 */
> +		upid = current->thread.ui_recv->upid_ctx->upid;
> +		upid->nc.ndst = cpu_to_ndst(smp_processor_id());
> +		clear_bit(UPID_SN, (unsigned long *)&upid->nc.status);
> +
> +		/*
> +		 * Interrupts might have accumulated in the UPID while the
> +		 * thread was preempted. In this case invoke the hardware
> +		 * detection sequence manually by sending a self IPI with UINV.
> +		 * Since UINV is set and SN is cleared, any new UINTR
> +		 * notifications due to the self IPI or otherwise would result
> +		 * in the hardware updating the UIRR directly.
> +		 * No real interrupt would be generated as a result of this.
> +		 *
> +		 * The alternative is to atomically read and clear the UPID and
> +		 * program the UIRR. In that case the kernel would need to
> +		 * carefully manage the race with the hardware if the UPID gets
> +		 * updated after the read.
> +		 */
> +		if (READ_ONCE(upid->puir))
> +			apic->send_IPI_self(UINTR_NOTIFICATION_VECTOR);

So sending an self IPI is more performant than doing it purely in
memory with some care? I seriously doubt that.

Oh well, I was under the impression that this is about performance and
not about adding as much overhead as possible.

But what do I know....

Thanks,

        tglx


