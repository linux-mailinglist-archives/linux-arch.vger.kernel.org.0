Return-Path: <linux-arch+bounces-14422-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A070C1D74F
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 22:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834CB1888416
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 21:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626BA318135;
	Wed, 29 Oct 2025 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Z/kQAgm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LplNfuDh"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AD13C914;
	Wed, 29 Oct 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773841; cv=none; b=oobkQxFrldUvkZEGo8BvrGyKR8255VB8Vga+R30R2vUzdq5XKd7pe2z12btLzHfQw/xAsTWy34RTx9xC4Vr5+m6SBqWwsd98QHgikTjr/m0pmBtPW0fbk4/ZbLSs78ljqBpgr/+fGDIhDNjx4b1pYJVelcHj6C3f3d4IMJecc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773841; c=relaxed/simple;
	bh=/6NAAiKqdPU9WwnzqHNIq3AzKl8jVMeea4+qrYpblg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qRXdFkmo1rZy/mhuZJUNhghooyBImf8Zf+DRBgLfODUCwvu76NH8xaidJKkAAOidXviOw3YTX2Ji8dPm+4ZjN+ST5IkxrlN+ftMafCPWdGSEDgIJ/ncGyj64Zqm0lW75aKfpZTq2socGJFyeH3IJNKIQt0yS7jdpYczwG0r/bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Z/kQAgm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LplNfuDh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761773837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NyOjAPbVVoq3R+vYHIIlKhyz4q3mwtc5uiKlsJciins=;
	b=0Z/kQAgmSiw21n3lCILuFOPlzZvCZYwftlhi9Mvv/6d247uP9oRiUkJJ4N+/QnIUOL5wtv
	/x3XAxQvhjDBFJmHo34qyRHQSeoNUJimYXBEMVB0yjJ6hC8PzgEwvHZ9T0/fkvoaoRZUNI
	ERHA5PXe8vnlKyaO1XWK7FNEM4Pd+MPDNKQhMV6YIJxLrm6GN1XGSF83TYm5SVnFmwO0DM
	OPnTZa+/ca9uU9VkpxE39zpgExbHlbron3Oz3vUt+OwzZRkfiInBopbilNoWh8tlNpPf8e
	ykYHMCMqdIU1Z8Zj6vPpvPqvFV0EGeEK5S1FDmD4ypkOJ4TSYtP8bxhnRwY+sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761773837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NyOjAPbVVoq3R+vYHIIlKhyz4q3mwtc5uiKlsJciins=;
	b=LplNfuDh1UuhG/s6RLNiysNRpxVCVje4Ntub6/S5kskNx1+WXvFXNp6NCF/H+moma8Bm5O
	JDL0xzS1aZKX95Cg==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [patch V3 08/12] rseq: Implement time slice extension
 enforcement timer
In-Reply-To: <20251029144538.5eb5c772@gandalf.local.home>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.923191772@linutronix.de>
 <20251029144538.5eb5c772@gandalf.local.home>
Date: Wed, 29 Oct 2025 22:37:17 +0100
Message-ID: <87ms59tmnm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 14:45, Steven Rostedt wrote:
> On Wed, 29 Oct 2025 14:22:26 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>  rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
>>  {
>> -	if (likely(!test_tif_rseq(ti_work)))
>> -		return false;
>> -
>> -	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
>> -		current->rseq.event.slowpath = true;
>> -		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
>> -		return true;
>> +	if (unlikely(test_tif_rseq(ti_work))) {
>> +		if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
>> +			current->rseq.event.slowpath = true;
>> +			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
>> +			return true;
>
> Just to make sure I understand this. By setting TIF_NOTIFY_RESUME and
> returning true it can still comeback to set the timer?

No. NOTIFY_RESUME is only set when the access faults or when the user
space memory is corrupted and the grant is moot in that case.

But if TIF_RSEQ is set then a previously granted extensionn is anyway
revoked because that means:

        granted();
        ---> preemption (evtl. migration): Set's TIF_RSEQ
           schedule()
        rseq_exit_to_user_mode_restart()
           if (TIF_RSEQ is set)
              handle_rseq()
                 revoke_grant()
                 
> I guess this also begs the question of if user space can use both the
> restartable sequences at the same time as requesting an extended time slice?

It can and that actually makes sense.

       enter_cs()
         request_grant()
         set_cs()
         ...

interrupt
        set_need_resched()
        exit_to_user_mode()
           if (need_resched()
              grant_extention() // clears NEED_RESCHED
           ...
        rseq_exit_to_user_mode_restart()
           if (IF_RSEQ is set)  // Branch not taken
              ...
           arm_timer()
        return_to_user()

        leave_cs()
          if (granted)
             sys_rseq_sched_yield()

which means the extension grant prevented the critical section to be
aborted. If the extension is not granted or revoked then this behaves
like a regular RSEQ CS abort.

>> +	 * This check prevents that a granted time slice extension exceeds
>
>	   This check prevents a granted time slice ...
>
>> +	 * the maximum scheduling latency when the grant expired before

I'm not a native speaker, but your suggested edit is bogus. Let me
put it into the full sentence:

	   This check prevents a granted time slice extension exceeds
           the maximum ....

Can you spot the fail?

>> +	/*
>> +	 * Store the task pointer as a cookie for comparison in the timer
>> +	 * function. This is safe as the timer is CPU local and cannot be
>> +	 * in the expiry function at this point.
>> +	 */
>
> I'm just curious in this scenario:
>
>   1) Task A requests an extension and is granted.
>       st->cookie = Task A
>       hrtimer_start();
>
>   2) Before getting back to user space, a RT kernel thread wakes up and
>      preempts Task A. Does this clear the timer?

No.

>   3) RT kernel thread finishes but then schedules Task B within the expiry.
>
>   4) Task B requests an extension (assuming it had a short time slice that
>      allowed it to end before the expiry of the original timer).
>
> I guess it doesn't matter that st->cookie = Task B, as Task A was already
> scheduled out. But would calling hrtimer_start() on an existing timer cause
> any issue?

No. The timer is canceled and reprogrammed.

> I guess it doesn't matter as it looks like the code in hrtimer_start() does
> indeed remove an existing timer.

You guessed right :)

>> +	st->cookie = curr;
>> +	hrtimer_start(&st->timer, curr->rseq.slice.expires, HRTIMER_MODE_ABS_PINNED_HARD);
>> +	/* Arm the syscall entry work */
>> +	set_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
>> +	return false;
>> +}
>> +
>> +static void rseq_cancel_slice_extension_timer(void)
>> +{
>> +	struct slice_timer *st = this_cpu_ptr(&slice_timer);
>> +
>> +	/*
>> +	 * st->cookie can be safely read as preemption is disabled and the
>> +	 * timer is CPU local.
>> +	 *
>> +	 * As this is most probably the first expiring timer, the cancel is
>
>            As this is probably the first ...
>
>> +	 * expensive as it has to reprogram the hardware, but that's less
>> +	 * expensive than going through a full hrtimer_interrupt() cycle
>> +	 * for nothing.
>> +	 *
>> +	 * hrtimer_try_to_cancel() is sufficient here as the timer is CPU
>> +	 * local and once the hrtimer code disabled interrupts the timer
>> +	 * callback cannot be running.
>> +	 */
>> +	if (st->cookie == current)
>> +		hrtimer_try_to_cancel(&st->timer);
>
> If the above scenario did happen, the timer will go off as
> st->cookie == current would likely be false?
>
> Hmm, if it does go off and the task did schedule back in, would it get its
> need_resched set? This is a very unlikely scenario thus I guess it doesn't
> really matter.

Correct.

> I'm just thinking about corner cases and how it could affect this code and
> possibly cause noticeable issues.

Right. That corner case exists and there is not much to be done about it
unless you inflict the timer cancelation into schedule(), which is not
an option at all.

> -- Steve

/me trims 50+ lines of pointless quotation.

Thanks,

        tglx

