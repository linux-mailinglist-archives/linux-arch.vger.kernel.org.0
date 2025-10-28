Return-Path: <linux-arch+bounces-14378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD44C14144
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 11:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96526354DEA
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA52DA746;
	Tue, 28 Oct 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P+zSjRqn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dyAY4zFr"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A812D4813;
	Tue, 28 Oct 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646934; cv=none; b=UQxYDaFrIcY4awQ8QA5QueWJ62fiQT2+3MBcFyOnv/vOmbLB11WBkmu+85aTxQfI/N4eaBtErNa/d6j68ggtPdSaSZuZH3IMwPaANStrlxNu2BMfndYcJueoP6FOgSn4eyYI/axJURygzOzYXAovXo9i+0tEBx9v3BLhR6MbrlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646934; c=relaxed/simple;
	bh=RxDH30hTWVyGK3YAycsQ7zhxP8UKcyJwKW0kR40f58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQQ9xrAgOt6CCBxZI5VNVqi9BS2dF1gH9vWj4pBMK11SySgxc1/u2mSwJC9ALZk6R3oGkx7Ij31jAMW76hAlTgtYz+81zB5hWF7mCvxAeuHvtbbM4nVGqoGUk3HqeyA8YPV+hPuIPJ1Y7ITbQ5TOVnBVs8bKvvd4ObE1bSEFKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P+zSjRqn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dyAY4zFr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 11:22:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761646926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o9/8xBGz5vf17dmWUq7pyomEgCiv9Yum+FNVxKn7fT0=;
	b=P+zSjRqnaBKeiQp+nsMAzYo3RYJrGgB4Gnlc/yIPw4se7dPutXjBWt9nL0NUaXFnzld6P9
	D7yFxkOW35UWm7Z2/CmvIgAK9pywHesynzTquDYaaI+iEDTVFKQY76kw7zQYLcgIUymtfD
	rhJyfrdWqi5v/7HIA4fhXgcdEfUNyx7kgqdtTQl3+KcJAksZJGFAbnMsNO+7ZIbrIeFD7S
	vnicJebONxRLFR6uU4Jr0hB98T3qA7DsCSS/oviRQ4L0tgS7LFkBWa+ckv3H9XnpTCANJl
	+ZjrGxsnx1yk/thfz1HEqpYty641LI7TJi/MbdjkVUivwDRIui3joTRf9/JR/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761646926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o9/8xBGz5vf17dmWUq7pyomEgCiv9Yum+FNVxKn7fT0=;
	b=dyAY4zFr3tJGnduAAjOk4V6V7Zv6eQncLt2+aMrzc6QQnlObaYK61mTE8LrlLFBvajbsiR
	Y+fZ33rYjpI0cTDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V2 08/12] rseq: Implement time slice extension
 enforcement timer
Message-ID: <20251028102205.D6mh4eAL@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
 <20251027113822.UfDZz0mf@linutronix.de>
 <87cy68wbt6.ffs@tglx>
 <20251028083356.cDl403Q9@linutronix.de>
 <db7f7264-6ccf-4f55-929a-4c2e813dd8f5@amd.com>
 <20251028090015.hcvhq9YP@linutronix.de>
 <f27bc532-f87b-4a46-9ffb-b38409b02c97@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f27bc532-f87b-4a46-9ffb-b38409b02c97@amd.com>

On 2025-10-28 14:52:09 [+0530], K Prateek Nayak wrote:
> On 10/28/2025 2:30 PM, Sebastian Andrzej Siewior wrote:
> >>> Without an interrupt on the target CPU, there is nothing stopping the
> >>> task from overstepping its fair share.
> >>
> >> When the task moves CPU, the rseq_exit_user_update() would clear all
> >> of the slice extension state before running the task again. The task
> >> will start off again with "rseq->slice_ctrl.request" and
> >> "rseq->slice_ctrl.granted" both at 0 signifying the task was
> >> rescheduled.
> > 
> > I wasn't aware this is done once the task is in userland and then
> > relocated to another CPU.
> 
> The exact path based on my understanding is:
> 
>   /* Task migrates to another CPU; Has to resume from kernel. */
>   __schedule()
>     context_switch()
>       rseq_sched_switch_event()
>         t->rseq.event.sched_switch = true;
>         set_tsk_thread_flag(t, TIF_RSEQ);
> 
>     ...
>     exit_to_user_mode_loop()
>       rseq_exit_to_user_mode_restart()
>         __rseq_exit_to_user_mode_restart()
>           /* Sees t->rseq.event.sched_switch to be true. */
>           rseq_exit_user_update()
>             if (rseq_slice_extension_enabled())
>               unsafe_put_user(0U, &rseq->slice_ctrl.all, efault); /* Unconditionally clears all of "rseq_ctrl" */

You are right. The migration thread preempts it on the old CPU and then
it gets scheduled in on the new CPU.

Sebastian

