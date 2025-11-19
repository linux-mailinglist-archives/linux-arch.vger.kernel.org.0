Return-Path: <linux-arch+bounces-14918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B80C6FAAB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CD004F1706
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ED73612D7;
	Wed, 19 Nov 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzfpYcHA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAeTJ3dl"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0E347BB5;
	Wed, 19 Nov 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565909; cv=none; b=UFd7rR3dsrrjRk5Mnp4Cf9/PatCbvyKT8wmLFY0BGDu9jvJH1rLJBny8Noj+0q1kkq+gUmAcheAJyJ0j4syFOoOHM2bNz3GlGfHwksqVLzFHqyzgTW5DVznhWJJL4EGM9TqD1Uuz/MeljIxCT6lTXQwcaoBj3Mf4K3DE7m1Ljrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565909; c=relaxed/simple;
	bh=MK1iCNnFZ5Z+DvktDN+BYmWRmVYNFF81HzUnqULBYnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLISx1/u8XXxuPwjdTSoo00ZMRovCnIDi5JfZhn2YK1J4sLzA89swAEez125CQZX/O/dXCvzLhccmIrTbTQZIWsn/39F7FqC2QTJ78rYkHvfIv3nHMUIPJ9+18YYUCpW0phn1sm4MWrLAMMFgQcmwIZIQtcXlZx/IVznDF4f/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzfpYcHA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAeTJ3dl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763565904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAFMavc2gKW14alLAtKK7wf+FUimmeLcYgKD5BbiATA=;
	b=VzfpYcHAXhjibz/wh9RQdv7GQraaddzMg11V04Ase1MND0Nn/Z3k+StqRJTVOFCUc7jxUH
	b1rBlz/vFjQp1HEw4BTjDDyrWNnDj14SOG9vAHSJCdiAbkfJ/i8txHvVk91kbjSVdde+a0
	Nyxx1/2zihe9M+kX/oc6Yh2m0d8MINxTa0JnCcf6JGmkENXWDJBC7fwyr0pw1D3s6IXoU6
	acWfJf36FtokJibvg+HVecfgWLsjiVI6jsqXMvWCWuqeuiVGf0sJdoj2XMtkfL76MO2KVG
	2zKbbpYgrQjaBWaTrrfaj+GkKzdWGZGRbZcR3JaMfFVS/Xt8z0c9D9tjvIsDnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763565904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DAFMavc2gKW14alLAtKK7wf+FUimmeLcYgKD5BbiATA=;
	b=oAeTJ3dlCvFDUKVLO4RA5MFcehImPw1CxtPHOS39UpGtgCSNYAVt4fVilZHV3BSsncPSS2
	IImvpcAR2Xi9naDg==
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
In-Reply-To: <261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.860155882@linutronix.de>
 <261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com>
Date: Wed, 19 Nov 2025 16:25:03 +0100
Message-ID: <874iqqm4dr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19 2025 at 00:20, Prakash Sangappa wrote:
>> On Oct 29, 2025, at 6:22=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
>> + if (put_user(0U, &curr->rseq.usrptr->slice_ctrl.all) || syscall !=3D _=
_NR_rseq_slice_yield)
>> + force_sig(SIGSEGV);
>> +}
>
> I have been trying to get our Database team to implement changes to
> use the slice extension API.  They encounter the issue with a system
> call being made within the slice extension window and the process dies
> with SEGV.

Good. Works as designed.

> Apparently it will be hard to enforce not calling a system call in the
> slice extension window due to layering.

Why do I have a smell of rotten onions in my nose right now?

> For the DB use case, It is fine to terminate the slice extension if a
> system call is made, but the process getting killed will not work.

That's not a question of being fine or not.

The point is that on PREEMPT_NONE/VOLUNATRY that arbitrary syscall can
consume tons of CPU cycles until it either schedules out voluntarily or
reaches __exit_to_user_mode_loop(), which is defeating the whole
mechanism. The timer does not help in that case because once the task is
in the kernel it won't be preempted on return from interrupt.

sys_rseq_sched_yield() is time bound, which is why it was implemented
that way.

I was absolutely right when I asked to tie this mechanism to
PREEMPT_LAZY|FULL in the first place. That would nicely avoid the whole
problem.

Something like the uncompiled and untested below should work. Though I
hate it with a passion.

Thanks,

        tglx
---
Subject: rseq/slice: Handle rotten onions gracefully
From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 19 Nov 2025 16:07:15 +0100

Add rant here.

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/rseq.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -643,13 +643,21 @@ void rseq_syscall_enter_work(long syscal
 	}
=20
 	curr->rseq.slice.state.granted =3D false;
+	/* Clear the grant in user space. */
+	if (put_user(0U, &curr->rseq.usrptr->slice_ctrl.all))
+		force_sig(SIGSEGV);
+
 	/*
-	 * Clear the grant in user space and check whether this was the
-	 * correct syscall to yield. If the user access fails or the task
-	 * used an arbitrary syscall, terminate it.
+	 * Grudgingly support onion layer applications which cannot
+	 * guarantee that rseq_slice_yield() is used to yield the CPU for
+	 * terminating a grant. This is a NOP on PREEMPT_FULL/LAZY because
+	 * enabling preemption above already scheduled, but required for
+	 * PREEMPT_NONE/VOLUNTARY to prevent that the slice is further
+	 * expanded up to the point where the syscall code schedules
+	 * voluntarily or reaches exit_to_user_mode_loop().
 	 */
-	if (put_user(0U, &curr->rseq.usrptr->slice_ctrl.all) || syscall !=3D __NR=
_rseq_slice_yield)
-		force_sig(SIGSEGV);
+	if (syscall !=3D __NR_rseq_slice_yield)
+		cond_resched();
 }
=20
 int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)


