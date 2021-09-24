Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0541707D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbhIXK4J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbhIXKzs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 06:55:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8023C061756;
        Fri, 24 Sep 2021 03:54:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632480853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7ACTzCKCJ8fwwf3NKIamkJEmGqQfZ3neuf/bUWLhh4=;
        b=WxF8rGiwvf1wvxuvzyKyMSchqrD0yZKbzEfkzG0wI6AOaPBxJ/jeiXwxvJ94Eg/E9cYxmf
        3FgatXPU71L+df75qc2V1eebCNqphQZjW+VTS855o3tzG/ah0wQWrwYxpQ1/ldSqvvcIwm
        YoN5DPycOsKS/UZ5LtkI4FXY3DhVDUrQSn+uUfEMF2LpfBVeJPgsyw53T9qMi9vUn51Dz4
        9eOBavCSJ5NDNpLsgy2O2/1kT+oewcOf0EXmCJlb9hOuchF7+BwfM314xtIawEv7XOR/Aj
        +f4DgFZTTVrf2LrcEEpgykcudT1UhjmHVgzkjW6VL/lbZxJ9wYf8yH2nVFYjFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632480853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7ACTzCKCJ8fwwf3NKIamkJEmGqQfZ3neuf/bUWLhh4=;
        b=F3HUGypPhoXARUuEk506nAxHNIZzPBZIIK5AavJ/nhx9YV+Pe2P8r2P1/l/9fazJhebx0u
        l4ESm1OK9zEbocDQ==
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
Subject: Re: [RFC PATCH 10/13] x86/uintr: Introduce user IPI sender syscalls
In-Reply-To: <20210913200132.3396598-11-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-11-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 12:54:12 +0200
Message-ID: <87tuiadz1n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
> +/*
> + * No lock is needed to read the active flag. Writes only happen from
> + * r_info->task that owns the UPID. Everyone else would just read this flag.
> + *
> + * This only provides a static check. The receiver may become inactive right
> + * after this check. The primary reason to have this check is to prevent future
> + * senders from connecting with this UPID, since the receiver task has already
> + * made this UPID inactive.

How is that not racy?

> +static void free_uitt(struct uintr_uitt_ctx *uitt_ctx)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uitt_ctx->uitt_lock, flags);
> +	kfree(uitt_ctx->uitt);

Again. Please move kfree() outside of the lock held region. But aside of
that what is this lock protecting here?

> +	uitt_ctx->uitt = NULL;
> +	spin_unlock_irqrestore(&uitt_ctx->uitt_lock, flags);

If there is concurrency then the other task which is blocked on
uitt_lock will operate on uitt_ctx while the same is freed.

Again, this lacks any life time and serialization rules. Just sprinkling
locks all over the place does not make it magically correct.

> +	kfree(uitt_ctx);
> +}

> +static void put_uitt_ref(struct uintr_uitt_ctx *uitt_ctx)
> +{
> +	if (refcount_dec_and_test(&uitt_ctx->refs))
> +		free_uitt(uitt_ctx);
> +}


> +static struct uintr_uitt_ctx *get_uitt_ref(struct uintr_uitt_ctx *uitt_ctx)
> +{
> +	refcount_inc(&uitt_ctx->refs);
> +	return uitt_ctx;
> +}
> +
> +static inline void mark_uitte_invalid(struct uintr_sender_info *s_info)
> +{
> +	struct uintr_uitt_entry *uitte;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&s_info->uitt_ctx->uitt_lock, flags);
> +	uitte = &s_info->uitt_ctx->uitt[s_info->uitt_index];
> +	uitte->valid = 0;
> +	spin_unlock_irqrestore(&s_info->uitt_ctx->uitt_lock, flags);
> +}
> +
>  static void __clear_vector_from_upid(u64 uvec, struct uintr_upid *upid)
>  {
>  	clear_bit(uvec, (unsigned long *)&upid->puir);
> @@ -175,6 +290,210 @@ static void receiver_clear_uvec(struct callback_head *head)
>  	kfree(r_info);
>  }
>  
> +static void teardown_uitt(void)
> +{
> +	struct task_struct *t = current;
> +	struct fpu *fpu = &t->thread.fpu;
> +	u64 msr64;
> +
> +	put_uitt_ref(t->thread.ui_send->uitt_ctx);
> +	kfree(t->thread.ui_send);
> +	t->thread.ui_send = NULL;
> +
> +	fpregs_lock();
> +
> +	if (fpregs_state_valid(fpu, smp_processor_id())) {
> +		/* Modify only the relevant bits of the MISC MSR */
> +		rdmsrl(MSR_IA32_UINTR_MISC, msr64);
> +		msr64 &= GENMASK_ULL(63, 32);

More magic numbers.

> +		wrmsrl(MSR_IA32_UINTR_MISC, msr64);
> +		wrmsrl(MSR_IA32_UINTR_TT, 0ULL);

> +static void __free_uitt_entry(unsigned int entry)
> +{
> +	struct task_struct *t = current;
> +	unsigned long flags;
> +
> +	if (entry >= UINTR_MAX_UITT_NR)
> +		return;
> +
> +	if (!is_uintr_sender(t))
> +		return;
> +
> +	pr_debug("send: Freeing UITTE entry %d for task=%d\n", entry, t->pid);
> +
> +	spin_lock_irqsave(&t->thread.ui_send->uitt_ctx->uitt_lock, flags);
> +	memset(&t->thread.ui_send->uitt_ctx->uitt[entry], 0,
> +	       sizeof(struct uintr_uitt_entry));
> +	spin_unlock_irqrestore(&t->thread.ui_send->uitt_ctx->uitt_lock,
> flags);

What's the spinlock protecting here?

> +	clear_bit(entry, (unsigned long *)t->thread.ui_send->uitt_mask);
> +
> +	if (is_uitt_empty(t)) {
> +		pr_debug("send: UITT mask is empty. Dereference and teardown UITT\n");
> +		teardown_uitt();
> +	}
> +}

> +void do_uintr_unregister_sender(struct uintr_receiver_info *r_info,
> +				struct uintr_sender_info *s_info)
> +{
> +	int ret;
> +
> +	/*
> +	 * To make sure any new senduipi result in a #GP fault.
> +	 * The task work might take non-zero time to kick the process out.

-ENOPARSE

> +	 */
> +	mark_uitte_invalid(s_info);
> +
> +	pr_debug("send: Adding Free UITTE %d task work for task=%d\n",
> +		 s_info->uitt_index, s_info->task->pid);
> +
> +	init_task_work(&s_info->twork, sender_free_uitte);
> +	ret = task_work_add(s_info->task, &s_info->twork, true);
> +	if (ret) {
> +		/*
> +		 * Dereferencing the UITT and UPID here since the task has
> +		 * exited.
> +		 */
> +		pr_debug("send: Free UITTE %d task=%d has already exited\n",
> +			 s_info->uitt_index, s_info->task->pid);
> +		put_upid_ref(s_info->r_upid_ctx);
> +		put_uitt_ref(s_info->uitt_ctx);
> +		put_task_struct(s_info->task);
> +		kfree(s_info);
> +		return;
> +	}
> +}
> +
> +int do_uintr_register_sender(struct uintr_receiver_info *r_info,
> +			     struct uintr_sender_info *s_info)
> +{
> +	struct uintr_uitt_entry *uitte = NULL;
> +	struct uintr_sender *ui_send;
> +	struct task_struct *t = current;
> +	unsigned long flags;
> +	int entry;
> +	int ret;
> +
> +	/*
> +	 * Only a static check. Receiver could exit anytime after this check.
> +	 * This check only prevents connections using uintr_fd after the
> +	 * receiver has already exited/unregistered.
> +	 */
> +	if (!uintr_is_receiver_active(r_info))
> +		return -ESHUTDOWN;

How is this safe against a concurrent unregister/exit operation?

Thanks,

        tglx
