Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD68416934
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 03:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbhIXBDz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 21:03:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbhIXBDz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 21:03:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632445341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQk2GihfSjtSeZUWZy1F+u7jfH25EFIJlwAQfvaVLi0=;
        b=1LVRE8MVY421IfWRt9am8QgddckQOV4Jq+7iSes11mrYMdt7vzrInJeEr6W26CgBOyBS4H
        /RNeRYnri1xJRRPY6UNmkCEvfjCzg+7BhrQBPKRKHnzZ/kCxnP0r0c3mIC4NxKLvlkXHTO
        KfxwvHyJ1p//1O8yyGqtqmfEwXE3d/k6az+MZpjj0UJ30/0Y8cyjaIHl65G2W7j90AGvGy
        Rqf7VO1KMMTxOReGXUy63pSN/JYBmV24Grclj6m44UfAlGsmDP72hORGFXPt2NDBpQxqhP
        AkKRshaPbCTMuhFlT1gSLa6k70JxRKI53wf3I2tbuxYy04xqm9IOTacD2qBnvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632445341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQk2GihfSjtSeZUWZy1F+u7jfH25EFIJlwAQfvaVLi0=;
        b=3aPjjZKeE1+jA9HmIhDpgs4l8/mPEyArvUVFnsXiH/YzTv7WWpGSUEXQQP5L73JRWfFD2F
        fgGmIXzaeL/EpKBg==
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
Subject: Re: [RFC PATCH 08/13] x86/process/64: Clean up uintr task fork and
 exit paths
In-Reply-To: <20210913200132.3396598-9-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-9-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 03:02:21 +0200
Message-ID: <8735pug50i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:

> The user interrupt MSRs and the user interrupt state is task specific.
> During task fork and exit clear the task state, clear the MSRs and
> dereference the shared resources.
>
> Some of the memory resources like the UPID are referenced in the file
> descriptor and could be in use while the uintr_fd is still valid.
> Instead of freeing up  the UPID just dereference it.

Derefencing the UPID, i.e. accessing task->upid->foo helps in which way?

You want to drop the reference count I assume. Then please write that
so. 

> Eventually when every user releases the reference the memory resource
> will be freed up.

Yeah, eventually or not...

> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c

> @@ -260,6 +260,7 @@ int fpu_clone(struct task_struct *dst)
>  {
>  	struct fpu *src_fpu = &current->thread.fpu;
>  	struct fpu *dst_fpu = &dst->thread.fpu;
> +	struct uintr_state *uintr_state;
>  
>  	/* The new task's FPU state cannot be valid in the hardware. */
>  	dst_fpu->last_cpu = -1;
> @@ -284,6 +285,14 @@ int fpu_clone(struct task_struct *dst)
>  
>  	else
>  		save_fpregs_to_fpstate(dst_fpu);
> +
> +	/* UINTR state is not expected to be inherited (in the current design). */
> +	if (static_cpu_has(X86_FEATURE_UINTR)) {
> +		uintr_state = get_xsave_addr(&dst_fpu->state.xsave, XFEATURE_UINTR);
> +		if (uintr_state)
> +			memset(uintr_state, 0, sizeof(*uintr_state));
> +	}

1) If the FPU registers are up to date then this can be completely
   avoided by excluding the UINTR component from XSAVES

2) If the task never used that muck then UINTR is in init state and
   clearing that memory is a redunant exercise because it has been
   cleared already

So yes, this clearly is evidence how this is enhancing performance.

> +/*
> + * This should only be called from exit_thread().

Should? Would? Maybe or what?

> + * exit_thread() can happen in current context when the current thread is
> + * exiting or it can happen for a new thread that is being created.

A right that makes sense. If a new thread is created then it can call
exit_thread(), right?

> + * For new threads is_uintr_receiver() should fail.

Should fail?

> + */
> +void uintr_free(struct task_struct *t)
> +{
> +	struct uintr_receiver *ui_recv;
> +	struct fpu *fpu;
> +
> +	if (!static_cpu_has(X86_FEATURE_UINTR) || !is_uintr_receiver(t))
> +		return;
> +
> +	if (WARN_ON_ONCE(t != current))
> +		return;
> +
> +	fpu = &t->thread.fpu;
> +
> +	fpregs_lock();
> +
> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
> +		wrmsrl(MSR_IA32_UINTR_MISC, 0ULL);
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
> +			p->uirr = 0;
> +			p->upid_addr = 0;
> +			p->stack_adjust = 0;
> +			p->uinv = 0;
> +		}
> +	}
> +
> +	/* Check: Can a thread be context switched while it is exiting? */

This looks like a question which should be answered _before_ writing
such code.

> +	ui_recv = t->thread.ui_recv;
> +
> +	/*
> +	 * Suppress notifications so that no further interrupts are
> +	 * generated based on this UPID.
> +	 */
> +	set_bit(UPID_SN, (unsigned long *)&ui_recv->upid_ctx->upid->nc.status);
> +	put_upid_ref(ui_recv->upid_ctx);
> +	kfree(ui_recv);
> +	t->thread.ui_recv = NULL;

Again, why needs all this put/kfree muck be within the fpregs locked section?

> +	fpregs_unlock();
> +}

Thanks,

        tglx
