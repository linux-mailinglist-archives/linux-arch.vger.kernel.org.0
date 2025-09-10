Return-Path: <linux-arch+bounces-13469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 855ADB50FF8
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70F91C26C27
	for <lists+linux-arch@lfdr.de>; Wed, 10 Sep 2025 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14923E335;
	Wed, 10 Sep 2025 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCHLGpuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SyjhIxdl"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86437241139;
	Wed, 10 Sep 2025 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490551; cv=none; b=FjtQqIGTh7BxdCPxBx4OjEAlmM4zHB43UKZA2n1KCWMoEHPE9CEGzFXL2JQbWYEIbeB/qzVtX5NlAflVYnMII9nXri0TE4R+iomNxTbXuL/87/JlWSADBFpHVTiSpCQO3PvkM3PQM8OQxyeBzUL9p1IepPJl8MOddlekorNPv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490551; c=relaxed/simple;
	bh=YcbNLRwOobCcOOt8Z1TWXPjn7EOh3UzfBzPPrJ3iP+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTOpgchGMhKAFSTJ292kkP5vytTcBMk4l9N3IvfS1Yv99LOkPmdkoFIyx1Fyh/97HA7Hcw6Jup91gd/jVrogi7nr3+vhYDXDBBE4nVFpEbnjJS3tjmOQO+JI+tmsZ5w23Ps4Y8Fkk3XnXxWF41uSfTW276r7OoJ+GZ2wOElPc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCHLGpuL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SyjhIxdl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757490547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9emZbZmgTB06eYlDuPxhoQsTb5CjKcX+ELCNcB9xyo=;
	b=BCHLGpuLDXl/eeWBj8+P8+rJSSFEfRozipRB/CMffMhdE37HKx8iK5UjEPwn8VGh2MujBJ
	ZbIdB7cUyi6BlsYGuzcNKOSp2p3VYLa9vopwYtcbYWD54qLkQ6+qxOy6jIu0LkGyCoWR80
	dYxJoSL6abV4YXslFwpx48dIXRlIZrpwu2ydVZFo6cIafdzKnJkPW6rZVkKBOrEIXY07Cp
	apwR0ASB9w4ObiWRJKuw5G8tDoexAce4ToV3o0/NqjygyO0ttxkJHx/O7WBdBSW0BXHaha
	8yKILecSBOIxpWJINP4y6i4giofpptJBQjYBTwnGqOVPUioTu3Qlh7nWDOng5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757490547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9emZbZmgTB06eYlDuPxhoQsTb5CjKcX+ELCNcB9xyo=;
	b=SyjhIxdl9Pia9C0mByYI4KEkzTcHAZtaSTkYOUv15e466W5nsGdOr1TdrrP+8MJG+mD6tA
	4lgQbpNOhyyAmTBg==
To: K Prateek Nayak <kprateek.nayak@amd.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash
 Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch 07/12] rseq: Implement syscall entry work for time slice
 extensions
In-Reply-To: <45b4a0db-dab6-4b9d-9ee8-f564eaa202bf@amd.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225753.012514970@linutronix.de>
 <45b4a0db-dab6-4b9d-9ee8-f564eaa202bf@amd.com>
Date: Wed, 10 Sep 2025 09:49:06 +0200
Message-ID: <87plbyu4r1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 10:52, K. Prateek Nayak wrote:
> On 9/9/2025 4:30 AM, Thomas Gleixner wrote:
>> +static inline void rseq_slice_set_need_resched(struct task_struct *curr)
>> +{
>> +	/*
>> +	 * The interrupt guard is required to prevent inconsistent state in
>> +	 * this case:
>> +	 *
>> +	 * set_tsk_need_resched()
>> +	 * --> Interrupt
>> +	 *       wakeup()
>> +	 *        set_tsk_need_resched()
>> +	 *	  set_preempt_need_resched()
>> +	 *     schedule_on_return()
>> +	 *        clear_tsk_need_resched()
>> +	 *	  clear_preempt_need_resched()
>> +	 * set_preempt_need_resched()		<- Inconsistent state
>> +	 *
>> +	 * This is safe vs. a remote set of TIF_NEED_RESCHED because that
>> +	 * only sets the already set bit and does not create inconsistent
>> +	 * state.
>> +	 */
>> +	scoped_guard(irq)
>> +		set_need_resched_current();
>
> nit. any specific reason for using a scoped_guard() instead of just a
> guard() here (and in rseq_cancel_slice_extension_timer()) other than to
> prominently highlight what is being guarded?

Yes, the intention was to highlight it and scoped_guard() really
does. From a code generation perspective it's the same outcome.

Thanks,

        tglx

