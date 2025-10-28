Return-Path: <linux-arch+bounces-14375-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C02C13AD7
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 10:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84474FE2E3
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932162DE6F8;
	Tue, 28 Oct 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mrOoXqfR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZYLzoWQH"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF412DC787;
	Tue, 28 Oct 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642019; cv=none; b=ohgG5GW8r/XqTyqEcWH2EJUbacEvxa4gZSEUfIMy1QGoIKhmFLfFs9z48o6VWZzr+0aVBTcdNGL83MCNgkT6/W2jF9b6Ib3DWOxBN4THOmibtzCc7bz5mH3gqFeZsY6r3aeqc+naQEjf3RIHv5d1mxdG+p6jWEL9wuuePG3ETgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642019; c=relaxed/simple;
	bh=CFA1rn2tpJ4+HDZVFQmiB9SKB7uTemgwFuaLHwqwRuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDO7djj3KiAfx2HxZ39pmtlByd7F2BIdFP5rjQqxoELjNKT3gyL08WrYeByr9LBbKkYF1m3h4e/Aonpo8mTMASczTcHvPmTCg9STh9eP0XkmuldknFW6tV9hj+y6KBFiCXrxO0su+6/zrza6FQcRAJ8dt6QnB9ZUNpKJvVL/0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mrOoXqfR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZYLzoWQH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 10:00:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761642016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqZKQaJV3pb2fnig7xHxtQURPVvUylxqU+UUNMCHFLM=;
	b=mrOoXqfRPQzGnPkqLRXINyKflU5w1zDHX4XlfFz2jDj9YbqLrmXBQ0HDgN38Hy5F2IdPpm
	nZRNINLNrn36a5/oAeVVJMfVQ93bPJjJw1HshIADuHdhCM0HbF5HOyNf3Xe1GA2Gx5o0Or
	qmdTS9w/s7QAPgjCuFMfagUlSw5L2/wXUuMDDo0wjmXfdh01ffhg6N1hJ+/OFhDi9UaMnV
	8AehjP8c3Z6m6Z7rtiRhjrLzDtYx81bIl2oH/IzDUkwmkopmbcHftt1lFyq8E1sC3KznVl
	FvJryry7JUyBsiw89OyCaqhGEErc6ZJfEEYE9ktZFwOFskLR73deZjDoQeaC2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761642016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqZKQaJV3pb2fnig7xHxtQURPVvUylxqU+UUNMCHFLM=;
	b=ZYLzoWQHFI4LYKoVgPnN0fjSlPJmBs0/woCr1LJPGPodDmDaXBsvs1/LfhyJpeatKOj0aA
	lPwjoOxlNBE6woBw==
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
Message-ID: <20251028090015.hcvhq9YP@linutronix.de>
References: <20251022110646.839870156@linutronix.de>
 <20251022121427.406689298@linutronix.de>
 <20251027113822.UfDZz0mf@linutronix.de>
 <87cy68wbt6.ffs@tglx>
 <20251028083356.cDl403Q9@linutronix.de>
 <db7f7264-6ccf-4f55-929a-4c2e813dd8f5@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <db7f7264-6ccf-4f55-929a-4c2e813dd8f5@amd.com>

On 2025-10-28 14:21:24 [+0530], K Prateek Nayak wrote:
> Hello Sebastian,
>=20
> On 10/28/2025 2:03 PM, Sebastian Andrzej Siewior wrote:
> > On 2025-10-27 17:26:29 [+0100], Thomas Gleixner wrote:
> >> On Mon, Oct 27 2025 at 12:38, Sebastian Andrzej Siewior wrote:
> >>> On 2025-10-22 14:57:38 [+0200], Thomas Gleixner wrote:
> >>>> +static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
> >>>> +{
> >>>> +	struct slice_timer *st =3D container_of(tmr, struct slice_timer, t=
imer);
> >>>> +
> >>>> +	if (st->cookie =3D=3D current && current->rseq.slice.state.granted=
) {
> >>>> +		rseq_stat_inc(rseq_stats.s_expired);
> >>>> +		set_need_resched_current();
> >>>> +	}
> >>>
> >>> You arm the timer while leaving to userland. Once in userland the task
> >>> can be migrated to another CPU. Once migrated, this CPU can host anot=
her
> >>> task while the timer fires and does nothing.
> >>
> >> That's inevitable. If the scheduler decides to do that then there is
> >> nothing which can be done about it and that's why the cookie pointer
> >> exists.
> >=20
> > Without an interrupt on the target CPU, there is nothing stopping the
> > task from overstepping its fair share.
>=20
> When the task moves CPU, the rseq_exit_user_update() would clear all
> of the slice extension state before running the task again. The task
> will start off again with "rseq->slice_ctrl.request" and
> "rseq->slice_ctrl.granted" both at 0 signifying the task was
> rescheduled.

I wasn't aware this is done once the task is in userland and then
relocated to another CPU.

> As for overstepping the limits on the previous CPU, the EEVDF
> algorithm (using the task's "vlag" - the vruntime deviation from the
> "avg_vruntime") would penalize it accordingly when enqueued.

So it wouldn't be the initial delay which is enforced by the timer, but
the regular scheduler that would put an end to it. Somehow forgot that
we still have a scheduler=E2=80=A6

> The previous CPU would just get a spurious interrupt and since the
> timer cookie doesn't match with "current", the handler does
> nothing and goes away.

Yeah, that is fine.

Sebastian

