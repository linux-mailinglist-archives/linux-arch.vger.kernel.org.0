Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16900417092
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 13:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244606AbhIXLGB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 07:06:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbhIXLGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 07:06:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632481466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0xmbt7Av+GwVclLZhRHdpujH9c0cVpxkWZDFBaxUtM=;
        b=OsU5VzNgLGtvscowoSnpo57k/J92eaphSGiTNWv8fOkgM9kvbwSbg3BzhDg5z2shi90pF7
        sx8bFGSIY/PLP/Pm4QOwON/6l9t8NQwzid0k8fbAs4/ZsaOz4MsvpjKkt1u98P7za/S7Dd
        cVEJbdAtNnSrfv3qVySmTASvY4yKUiqn8Zs49FxlYx/DIc+5tO6tna0q9GqRZ+a5iweaEt
        ufZHJxBR1M1K3Os9x8r5wSL8xobVsMh8hcUrXwuMoSihqtLPAZie0AXMbe7NgjytJO7ie3
        MkIbp0v63kSbVe/jxLfqRmDcHh8/2fCDIoMmf2Dy+hbXYVT0fFISwAupCo88RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632481466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0xmbt7Av+GwVclLZhRHdpujH9c0cVpxkWZDFBaxUtM=;
        b=ADW+qoGHk4FKZa85mQXSXh5rJDACF1IJmkDonEbagVzDoaNlHD9Bf0S5UTGdfeByEe4oy1
        H4oboX/eR8q281Ag==
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
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
In-Reply-To: <20210913200132.3396598-12-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-12-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 13:04:25 +0200
Message-ID: <87r1dedykm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
> Add a new system call to allow applications to block in the kernel and
> wait for user interrupts.
>
> <The current implementation doesn't support waking up from other
> blocking system calls like sleep(), read(), epoll(), etc.
>
> uintr_wait() is a placeholder syscall while we decide on that
> behaviour.>
>
> When the application makes this syscall the notification vector is
> switched to a new kernel vector. Any new SENDUIPI will invoke the kernel
> interrupt which is then used to wake up the process.
>
> Currently, the task wait list is global one. To make the implementation
> scalable there is a need to move to a distributed per-cpu wait list.

How are per cpu wait lists going to solve the problem?

> +
> +/*
> + * Handler for UINTR_KERNEL_VECTOR.
> + */
> +DEFINE_IDTENTRY_SYSVEC(sysvec_uintr_kernel_notification)
> +{
> +	/* TODO: Add entry-exit tracepoints */
> +	ack_APIC_irq();
> +	inc_irq_stat(uintr_kernel_notifications);
> +
> +	uintr_wake_up_process();

So this interrupt happens for any of those notifications. How are they
differentiated? 
>  
> +int uintr_receiver_wait(void)
> +{
> +	struct uintr_upid_ctx *upid_ctx;
> +	unsigned long flags;
> +
> +	if (!is_uintr_receiver(current))
> +		return -EOPNOTSUPP;
> +
> +	upid_ctx = current->thread.ui_recv->upid_ctx;
> +	upid_ctx->upid->nc.nv = UINTR_KERNEL_VECTOR;
> +	upid_ctx->waiting = true;
> +	spin_lock_irqsave(&uintr_wait_lock, flags);
> +	list_add(&upid_ctx->node, &uintr_wait_list);
> +	spin_unlock_irqrestore(&uintr_wait_lock, flags);
> +
> +	set_current_state(TASK_INTERRUPTIBLE);

Because we have not enough properly implemented wait primitives you need
to open code one which is blantantly wrong vs. a concurrent wake up?

> +	schedule();

How is that correct vs. a spurious wakeup? What takes care that the
entry is removed from the list?

Again. We have proper wait primitives.

> +	return -EINTR;
> +}
> +
> +/*
> + * Runs in interrupt context.
> + * Scan through all UPIDs to check if any interrupt is on going.
> + */
> +void uintr_wake_up_process(void)
> +{
> +	struct uintr_upid_ctx *upid_ctx, *tmp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uintr_wait_lock, flags);
> +	list_for_each_entry_safe(upid_ctx, tmp, &uintr_wait_list, node) {
> +		if (test_bit(UPID_ON, (unsigned long*)&upid_ctx->upid->nc.status)) {
> +			set_bit(UPID_SN, (unsigned long *)&upid_ctx->upid->nc.status);
> +			upid_ctx->upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
> +			upid_ctx->waiting = false;
> +			wake_up_process(upid_ctx->task);
> +			list_del(&upid_ctx->node);

So any of these notification interrupts does a global mass wake up? How
does that make sense?

> +		}
> +	}
> +	spin_unlock_irqrestore(&uintr_wait_lock, flags);
> +}
> +
> +/* Called when task is unregistering/exiting */
> +static void uintr_remove_task_wait(struct task_struct *task)
> +{
> +	struct uintr_upid_ctx *upid_ctx, *tmp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&uintr_wait_lock, flags);
> +	list_for_each_entry_safe(upid_ctx, tmp, &uintr_wait_list, node) {
> +		if (upid_ctx->task == task) {
> +			pr_debug("wait: Removing task %d from wait\n",
> +				 upid_ctx->task->pid);
> +			upid_ctx->upid->nc.nv = UINTR_NOTIFICATION_VECTOR;
> +			upid_ctx->waiting = false;
> +			list_del(&upid_ctx->node);
> +		}

What? You have to do a global list walk to find the entry which you
added yourself?

Thanks,

        tglx
 
