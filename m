Return-Path: <linux-arch+bounces-14424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A445CC1D81E
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 22:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0793BE8B5
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 21:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E8274FE8;
	Wed, 29 Oct 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wM+/bLof";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nnja9PTA"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207F26FDBF;
	Wed, 29 Oct 2025 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774552; cv=none; b=CMtzQM2yIpwQP33eZdjVPodh090JhWlZN8PGiajh2VTadkU7RQjt9x2KgTgPEno/vJduQv6iBVFmjSK0LshtIku3J8jTLvmentM0Ofrq+of36SoDgaw1tIK5ItuOUGjj25Ukt+kh1vVBQnp2XTweo1mVYB9uxb2+vCMvumdeW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774552; c=relaxed/simple;
	bh=PdakDEMwDpKEunjCNPeKNOneLY3Fpl6Ym+Yp+6prNhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lAeFRguvZHpHE6Y6EpAR02rmYJ1YIFlEmaTGsCyctdBuscWRNDktx4DD4xR92MQ8SGPCR0+NrbynkwRUipdqiSj7XR4xRkxSg6i9mOvzO56FjgCAzfRZ3gg5yu+k3jLao2CLUJ4akXzDcPAzaCCsEEf+ruBGjGQTWXivAMe6Vsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wM+/bLof; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nnja9PTA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761774549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a+1+g+BBSioCLO7lofYehLGt49t+sSorvoz7gc+WYOI=;
	b=wM+/bLofdPFjQap+KDNuoMQQ6fjPctXzq/sIJF89moyK1+romjHG7GFFJ7GmdgpnLYcekA
	oxmjJmlxZOmfNmNHENWkBTu8ywFmh0kRM3sspAzbh6aS+wct5P2jmS3uWDOVxnjp6meCRr
	qSkfZgHJ2heDwF5h1oOgjzPLlfFA+4KLpiokvIVut5TEN8PzQQFO28oti+HlXPTNDojXFF
	7cygcx6kBP9t+U5kiYLKvcSA6bsNbAFvG9wAMjEmqXMf3vq4Bc4qMiNmO7kH5vQmakwAKp
	jPzpRs1KSTWaK0b1dQdvppo+R7yyBKKmdjwmffoMZGecnT2JOtrSvSiUlbgJIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761774549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a+1+g+BBSioCLO7lofYehLGt49t+sSorvoz7gc+WYOI=;
	b=Nnja9PTAuXyepD+aRUEpd/II28H5erWb4dwlSNcTCcB3mduwkozXs0umHzw7YZL7qN9vuF
	gNV1yupshOQuQvCg==
To: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <20251029114049.1686a619@gandalf.local.home>
References: <20251029125514.496134233@linutronix.de>
 <20251029151055.SA-WMUQ_@linutronix.de>
 <20251029114049.1686a619@gandalf.local.home>
Date: Wed, 29 Oct 2025 22:49:08 +0100
Message-ID: <87h5vhtm3v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 11:40, Steven Rostedt wrote:
> On Wed, 29 Oct 2025 16:10:55 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
>> > and in git:
>> > 
>> >     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid
>> > 
>> > For your convenience all of it is also available as a conglomerate from
>> > git:
>> > 
>> >     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice  
>> 
>> rseq/slice is older than rseq/cid. rseq/slice has the
>> __put_kernel_nofault typo. rseq/cid looks correct.
>
> Yeah, I started looking at both too, and checking out req/slice and trying
> to do a rebase on top of rseq/cid causes a bunch of conflicts.
>
> I'm continuing the rebase and just skipping the changed commits.

Forgot to push the updated branch out....

Fixed now.

Thanks,

        tglx

