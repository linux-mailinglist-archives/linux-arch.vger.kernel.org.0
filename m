Return-Path: <linux-arch+bounces-14357-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C70C0FA4B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9BD64E59F7
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8E1DE892;
	Mon, 27 Oct 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vMzgk6Wx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OrYxJg0"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9A13C695;
	Mon, 27 Oct 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586242; cv=none; b=oTn9GgKeHV3np5XPSTgxtb6vFySMkkwGOY8JKXWBJO6RXGwq3wrZ4zRmsMx/ej73H9tFJXqUDHx5k8hP3jVZttgua0Rv8wPwGpBT10BBipP/L1s4VGC0qILIj4Nw/diuOXopqmJ7uvvjVtX7UBX02JYDQv48VqGvqUeqKz8dcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586242; c=relaxed/simple;
	bh=4uL4+wZX1tAxEbB5K4ulkpXLKyuE+ppntXBswzt3hOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Polg4bpep7LsEIc5g98Osbf1dVhyJkw+SdDlJ3N8JuiiMa/fXUifbh6tJiQRHNkrqGYPy31P2ULZsPNL4OhX507QlWPZBlNUFzDM7UnGXksQxkMnXZutYXroubIYG3rb3kwVdkV/3wwrVdSNSLMWO/FLYTDGNMbyYEtjYaSOweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vMzgk6Wx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2OrYxJg0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 18:30:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761586239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rckQcIlgYaN9EIAyFLDnQzQv4OpVdXN3PzywVzOoI64=;
	b=vMzgk6WxR5HJAqiUkOlDBjOCVIvt4Y7f2eUDXPCRL8i6rSJUJ1q2v6pEuC3uAzgRDzo8F+
	R+N4u01yRxZZr89uyI6vW57Jeg1HFZcZ87X4qPTTkGBaaqmoaodR0F9ecC2eYIxQCgjq+i
	iePK4ZCyzK/f+pdORjAgZ8+Lso0NY3g7Z1wmQ+zNGMwvVfE9nr1oENyL6mCwLlbPxgytYt
	N0FhCTAUtQmxMajY1rEZtelQWhsTDpafDZJpNBEL18Qo0sp9INrvK0x79Io+8dtyJtmTxZ
	yFjomobeJ/d5gTqiIoazoep2T6/TiS6Ie2wbNWAgPvU/vOnLZewaQ562QBQdaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761586239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rckQcIlgYaN9EIAyFLDnQzQv4OpVdXN3PzywVzOoI64=;
	b=2OrYxJg0K0QKsrHHT7DEY11DKWeDUjJxYsK9QTx8e+kWdNAlEHY6ILKRR6dLjyxif5SXoL
	Hh7t9cSWBj4UTMDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zilstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: Re: [patch V2 00/12] rseq: Implement time slice extension mechanism
Message-ID: <20251027173037.Cj4b_alm@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251022110646.839870156@linutronix.de>

On 2025-10-22 14:57:28 [+0200], Thomas Gleixner wrote:
> Time slice extensions are an attempt to provide opportunistic priority
> ceiling without the overhead of an actual priority ceiling protocol, but
> also without the guarantees such a protocol provides.
>=20
> The intent is to avoid situations where a user space thread is interrupted
> in a critical section and scheduled out, while holding a resource on which
> the preempting thread or other threads in the system might block on. That
> obviously prevents those threads from making progress in the worst case f=
or
> at least a full time slice. Especially in the context of user space
> spinlocks, which are a patently bad idea to begin with, but that's also
> true for other mechanisms.

I've been playing with it a bit with RT enabled and started to debug
this:

|       slice_test-2903    [001] d.h..  2313.285439: local_timer_entry: vec=
tor=3D236
|       slice_test-2903    [001] d.h1.  2313.285440: hrtimer_cancel: hrtime=
r=3D000000000507e6d5
|       slice_test-2903    [001] d.h..  2313.285440: hrtimer_expire_entry: =
hrtimer=3D000000000507e6d5 function=3Dtick_nohz_handler now=3D2313208001152
|       slice_test-2903    [001] d.h1.  2313.285449: sched_stat_runtime: co=
mm=3Dslice_test pid=3D2903 runtime=3D3982905 [ns]
|       slice_test-2903    [001] dlh..  2313.285452: softirq_raise: vec=3D7=
 [action=3DSCHED]
|       slice_test-2903    [001] dlh..  2313.285452: hrtimer_expire_exit: h=
rtimer=3D000000000507e6d5
|       slice_test-2903    [001] dlh1.  2313.285452: hrtimer_start: hrtimer=
=3D000000000507e6d5 function=3Dtick_nohz_handler expires=3D2313212000000 so=
ftexpires=3D2313212000000 mode=3DABS
|       slice_test-2903    [001] dlh..  2313.285453: local_timer_exit: vect=
or=3D236
|       slice_test-2903    [001] dl.2.  2313.285453: sched_waking: comm=3Dk=
softirqd/1 pid=3D32 prio=3D120 target_cpu=3D001
|       slice_test-2903    [001] dl.3.  2313.285456: sched_wakeup: comm=3Dk=
softirqd/1 pid=3D32 prio=3D120 target_cpu=3D001
|       slice_test-2903    [001] d....  2313.285457: irqentry_exit: rseq_gr=
ant_slice_extension(216)

granting the extension and removing the lazy wakup. We are still on
return from IRQ but the 'h' flag has been already removed=E2=80=A6

|       slice_test-2903    [001] d..1.  2313.285458: hrtimer_start: hrtimer=
=3D0000000030a688cc function=3Drseq_slice_expired expires=3D2313208047790 s=
oftexpires=3D2313208047790 mode=3DABS|PINNED|HARD
|       slice_test-2903    [001] d....  2313.285458: __rseq_arm_slice_exten=
sion_timer: timer
|       slice_test-2903    [001] d..2.  2313.285484: hrtimer_cancel: hrtime=
r=3D0000000030a688cc
extension granted, timer started and revoked and set need resched.

|       slice_test-2903    [001] dN.2.  2313.285487: sched_stat_runtime: co=
mm=3Dslice_test pid=3D2903 runtime=3D36886 [ns]
This is coming from schedule() already. It took me a while since I was
hunting a missing clear of need-resched.

|       slice_test-2903    [001] d..2.  2313.285489: sched_switch: prev_com=
m=3Dslice_test prev_pid=3D2903 prev_prio=3D120 prev_state=3DR+ =3D=3D> next=
_comm=3Dksoftirqd/1 next_pid=3D32 next_prio=3D120
|      ksoftirqd/1-32      [001] ..s.1  2313.285490: softirq_entry: vec=3D7=
 [action=3DSCHED]
|      ksoftirqd/1-32      [001] ..s.1  2313.285501: softirq_exit: vec=3D7 =
[action=3DSCHED]
|      ksoftirqd/1-32      [001] d..2.  2313.285502: sched_stat_runtime: co=
mm=3Dksoftirqd/1 pid=3D32 runtime=3D16438 [ns]
|      ksoftirqd/1-32      [001] d..2.  2313.285503: sched_switch: prev_com=
m=3Dksoftirqd/1 prev_pid=3D32 prev_prio=3D120 prev_state=3DS =3D=3D> next_c=
omm=3Dslice_test next_pid=3D2904 next_prio=3D120
|       slice_test-2904    [001] .....  2313.285507: sys_enter: NR 230 (1, =
0, 7f4692c7baa0, 0, 0, 0)
|       slice_test-2904    [001] .....  2313.285507: hrtimer_setup: hrtimer=
=3D00000000f2d53899 clockid=3DCLOCK_MONOTONIC mode=3DREL
|       slice_test-2904    [001] d..1.  2313.285507: hrtimer_start: hrtimer=
=3D00000000f2d53899 function=3Dhrtimer_wakeup expires=3D2313208168792 softe=
xpires=3D2313208118792 mode=3DREL
|       slice_test-2904    [001] d..2.  2313.285508: sched_stat_runtime: co=
mm=3Dslice_test pid=3D2904 runtime=3D6149 [ns]
|       slice_test-2904    [001] d..2.  2313.285510: sched_switch: prev_com=
m=3Dslice_test prev_pid=3D2904 prev_prio=3D120 prev_state=3DS =3D=3D> next_=
comm=3Dslice_test next_pid=3D2903 next_prio=3D120
|       slice_test-2903    [001] .....  2313.285510: sys_enter: NR 470 (7ff=
fc04f1ff0, c350, 11a0e0, 0, 7f4692e99000, 0)

slice_test-2903 enters _now_ rseq_slice_yield() so it must have been in
userland during the suppressed wake up at 2313.285457.
But a few iterations later it turns at out this trace event is recorded
_after_ the rseq magic happens at sys_enter time. We entered
rseq_slice_yield() a few cycles after the extension was granted. Buh.
So it seems to work as intended but it is not obvious tell from tracing
why it does not work.

Sebastian

