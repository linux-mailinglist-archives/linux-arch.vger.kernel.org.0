Return-Path: <linux-arch+bounces-14683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A14CC547B1
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 21:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B94824E2A7F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA702BEC21;
	Wed, 12 Nov 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtf1FhYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlYtGFEX"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE962C08AD;
	Wed, 12 Nov 2025 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979515; cv=none; b=tXWSnm/pd2NVYswVlczkm+2mPV013R5Z7E+YY+qB2NNBgOq2zMxKei4ljMlIbgopd+W5FWHeUStK2seu0yMYDwJtzOuaukRPOdKGB4VnYx3i/GyQ2qGTTkwtmMNXp71pY1qvRgSQBk+F7SZjCgohx1CJ2z9bZbJDINxvL6XCQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979515; c=relaxed/simple;
	bh=3MJbhA5Y/xbFkmpLunUbKVCFFbpAX+ITME3bJr8If28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZc9wHHPULvgMaENuqsRS9eKY6hXdRay+i3bp+TkA7piOKpm7TSvVllQubBHrXktJg4hrd6BdwLAwFLiwomgFYYXLKnMJMgW0CO28WzaG75BjZPGayTfa0MQwDg+LehedknXnH9itoGMOcVHLn7aSO9rVpo8XIo/kL+7elu7cXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtf1FhYk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlYtGFEX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762979511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cvVnICnIIlP5Z4QIxKkWodfWE52RrJgSevVX5hDnmtc=;
	b=gtf1FhYknnrVU508dixgW1kgfRllHqOWUEAIJaEyoae70msXYrYZ72LAEDxvEshgNT5i/4
	RBkOFH3Pp+zUADZRKEyOiwSG64qFss6ZDPXEU/+k5qYGd+ch6XY82lcXwgK4r3wh5kPNFi
	Wy/KGcJ54Nyp2N6tR2boOEjMf8MQDLQvm7w4UhgE/uJoqTC/M31hJDYZmspk2cTmwQiLN4
	lIKyrPAZqV5w964eC0H37PhwmCaJKyl7hWIHHfIlLT1iOqD/p9U+94Iwc9VsQLvIODV1rt
	MYaazq/dzDykLCZB09jcp/P/cfyDoiw1zxkRTN8FlvYMdDreYvIgo3+5dNSuQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762979511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cvVnICnIIlP5Z4QIxKkWodfWE52RrJgSevVX5hDnmtc=;
	b=qlYtGFEXvhJMtrIlh6U/yLErUfjqHnn0NkZ8B8mg0rGXTzjV9xhykbuP0lHv0kMjhRoXz1
	mYVHAdLrQHTbLPAQ==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Prakash Sangappa
 <prakash.sangappa@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
Date: Wed, 12 Nov 2025 21:31:49 +0100
Message-ID: <87ldkbdmbu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 11 2025 at 11:42, Mathieu Desnoyers wrote:
> On 2025-11-10 09:23, Mathieu Desnoyers wrote:
> I've spent some time digging through Thomas' implementation of
> mm_cid management. I've spotted something which may explain
> the watchdog panic. Here is the scenario:
>
> 1) A process is constrained to a subset of the possible CPUs,
>     and has enough threads to swap from per-thread to per-cpu mm_cid
>     mode. It runs happily in that per-cpu mode.
>
> 2) The number of allowed CPUs is increased for a process, thus invoking
>     mm_update_cpus_allowed. This switches the mode back to per-thread,
>     but delays invocation of mm_cid_work_fn to some point in the future,
>     in thread context, through irq_work + schedule_work.
>
>     At that point, because only __mm_update_max_cids was called by
>     mm_update_cpus_allowed, the max_cids is updated, but mc->transit
>     is still zero.
>
>     Also, until mm_cid_fixup_cpus_to_tasks is invoked by either the
>     scheduled work or near the end of sched_mm_cid_fork, or by
>     sched_mm_cid_exit, we are in a state where mm_cids are still
>     owned by CPUs, but we are now in per-thread mm_cid mode, which
>     means that the mc->max_cids value depends on the number of threads.

No. It stays in per CPU mode. The mode switch itself happens either in
the worker or on fork/exit whatever comes first.

> 3) At that point, a new thread is cloned, thus invoking
>     sched_mm_cid_fork. Calling sched_mm_cid_add_user increases the user
>     count and invokes mm_update_max_cids, which updates the mc->max_cids
>     limit, but does not set the mc->transit flag because this call does not
>     swap from per-cpu to per-task mode (the mode is already per-task).

No. mm::mm_cid::percpu is still set. So mm::mm_cid::transit is irrelevant.

>     Immediately after the call to sched_mm_cid_add_user, sched_mm_cid_fork()
>     attempts to call mm_get_cid while the mm_cid mutex and mm_cid lock
>     are held, and loops forever because the mm_cid mask has all
>     the max_cids IDs reserved because of the stale per-cpu CIDs.

Definitely not. sched_mm_cid_add_user() invokes mm_update_max_cids()
which does the mode switch in mm_cid, sets transit and returns true,
which means that fork() goes and does the transition game and allocates
the CID for the new task after that completed.

There was an issue in V3 with the not-initialized transit member and a
off by one in one of the transition functions. It's fixed in the git
tree, but I haven't posted it yet because I was AFK for a week.

I did not notice the V3 issue because tests passed on a small machine,
but after I did a rebase to the tip rseq and uaccess bits, I noticed the
failure because I tested on a larger box.

Thanks,

        tglx





