Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D642241705C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 12:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhIXKfX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 06:35:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhIXKfX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 06:35:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632479629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=3qlwpik2ZScVioRdtjZP8dq5+cHoEHM42Y3IpVn8O9Q=;
        b=AvrQWPehTUVeCLggZJeZ3UYEa+fnpn39vXJdpbQqIG/r6Rui1EN4hlJBV8UQ3zBeDSB3BQ
        BKkOHaQ+yVzL/HOgB+9iWi5Lz8GXpxPAUhdUHWPcTQSpFVcCqywiA78Ymd32UcKZNbt9fx
        +LRZJgrq/4BtoDPDFofUuyLpwpSG2ggTdIRBAQ5joeXEfvlBBs/38u7pJvrCmbtzys8/Nl
        9ZRYAuD2f7OWTC2rwXKqv47ryeVecQ/PxQqhrpNbghize7ara9fFRGmibIfxomh1lqQUxy
        Q/Wqpk+OIJuQGgSPMcaw7+fnBIA+HNrXLpVtvtGVAeq9qpFI2qFZNrxGZ2IB4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632479629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=3qlwpik2ZScVioRdtjZP8dq5+cHoEHM42Y3IpVn8O9Q=;
        b=ne6ljzK1+lXK4uvd1YB/lXPIykpTmY7pn0htgpsCu3j7Zq1g8CpGd2UYATKTaqbfUhth9B
        EEY3Lsa/5HpuihBQ==
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
Subject: Re: [RFC PATCH 09/13] x86/uintr: Introduce vector registration and
 uintr_fd syscall
In-Reply-To: <20210913200132.3396598-10-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 12:33:48 +0200
Message-ID: <87wnn6dzzn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>  static void free_upid(struct uintr_upid_ctx *upid_ctx)
>  {
> +	put_task_struct(upid_ctx->task);

That's current, right?

>  	kfree(upid_ctx->upid);
>  	upid_ctx->upid = NULL;
>  	kfree(upid_ctx);
> @@ -93,6 +93,7 @@ static struct uintr_upid_ctx *alloc_upid(void)
>  
>  	upid_ctx->upid = upid;
>  	refcount_set(&upid_ctx->refs, 1);
> +	upid_ctx->task = get_task_struct(current);

Current takes a refcount on it's own task struct when allocating upid,
and releases it at some point when freeing upid, right?

What for? Comments are overrated, except for comments describing
the obvious in the wrong way.

If this ever comes back in some form, then I pretty please want the life
time rules of this documented properly. The current state is
unreviewable.

>  	return upid_ctx;
>  }
> @@ -103,6 +104,77 @@ static void put_upid_ref(struct uintr_upid_ctx *upid_ctx)
>  		free_upid(upid_ctx);
>  }
>  
> +static struct uintr_upid_ctx *get_upid_ref(struct uintr_upid_ctx *upid_ctx)
> +{
> +	refcount_inc(&upid_ctx->refs);
> +	return upid_ctx;
> +}
> +
> +static void __clear_vector_from_upid(u64 uvec, struct uintr_upid *upid)
> +{
> +	clear_bit(uvec, (unsigned long *)&upid->puir);
> +}
> +
> +static void __clear_vector_from_task(u64 uvec)
> +{
> +	struct task_struct *t = current;
> +
> +	pr_debug("recv: task=%d free vector %llu\n", t->pid, uvec);
> +
> +	if (!(BIT_ULL(uvec) & t->thread.ui_recv->uvec_mask))
> +		return;
> +
> +	clear_bit(uvec, (unsigned long *)&t->thread.ui_recv->uvec_mask);
> +
> +	if (!t->thread.ui_recv->uvec_mask)
> +		pr_debug("recv: task=%d unregistered all user vectors\n", t->pid);

Once you are done debugging this complex function can you please turn it
into an unconditional clear_bit(...) at the call site?

> +/* Callback to clear the vector structures when a vector is unregistered. */
> +static void receiver_clear_uvec(struct callback_head *head)
> +{
> +	struct uintr_receiver_info *r_info;
> +	struct uintr_upid_ctx *upid_ctx;
> +	struct task_struct *t = current;
> +	u64 uvec;
> +
> +	r_info = container_of(head, struct uintr_receiver_info, twork);
> +	uvec = r_info->uvec;
> +	upid_ctx = r_info->upid_ctx;
> +
> +	/*
> +	 * If a task has unregistered the interrupt handler the vector
> +	 * structures would have already been cleared.

would ? No. They must have been cleared already, anything else is a bug.

> +	 */
> +	if (is_uintr_receiver(t)) {
> +		/*
> +		 * The UPID context in the callback might differ from the one
> +		 * on the task if the task unregistered its interrupt handler
> +		 * and then registered itself again. The vector structures
> +		 * related to the previous UPID would have already been cleared
> +		 * in that case.
> +		 */
> +		if (t->thread.ui_recv->upid_ctx != upid_ctx) {
> +			pr_debug("recv: task %d is now using a different UPID\n",
> +				 t->pid);
> +			goto out_free;
> +		}
> +
> +		/*
> +		 * If the vector has been recognized in the UIRR don't modify
> +		 * it. We need to disable User Interrupts before modifying the
> +		 * UIRR. It might be better to just let that interrupt get
> +		 * delivered.

Might be better? Please provide coherent explanations why this is correct.

> +		 */
> +		__clear_vector_from_upid(uvec, upid_ctx->upid);
> +		__clear_vector_from_task(uvec);
> +	}
> +
> +out_free:
> +	put_upid_ref(upid_ctx);
> +	kfree(r_info);
> +}
> +
>  int do_uintr_unregister_handler(void)
>  {
>  	struct task_struct *t = current;
> @@ -239,6 +311,53 @@ int do_uintr_register_handler(u64 handler)
>  	return 0;
>  }
>  
> +void do_uintr_unregister_vector(struct uintr_receiver_info *r_info)
> +{
> +	int ret;
> +
> +	pr_debug("recv: Adding task work to clear vector %llu added for task=%d\n",
> +		 r_info->uvec, r_info->upid_ctx->task->pid);
> +
> +	init_task_work(&r_info->twork, receiver_clear_uvec);

How is this safe? Reinitialization has to be serialized against other
usage. Again: Document the life time and serialization rules. Your
pr_debugs sprinkled all over the place are not a replacement for that.

> +	ret = task_work_add(r_info->upid_ctx->task, &r_info->twork, true);

Care to look at the type of the third argument of task_work_add()?

> +struct uintrfd_ctx {
> +	struct uintr_receiver_info *r_info;

Yet another wrapper struct? What for?

> +/*
> + * sys_uintr_create_fd - Create a uintr_fd for the registered interrupt vector.

So this creates a file descriptor for a vector which is already
allocated and then it calls do_uintr_register_vector() which allocates
the vector?

> + */
> +SYSCALL_DEFINE2(uintr_create_fd, u64, vector, unsigned int, flags)
> +{

Thanks,

        tglx
