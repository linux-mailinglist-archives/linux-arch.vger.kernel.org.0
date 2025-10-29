Return-Path: <linux-arch+bounces-14423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B3C1D812
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 22:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2883BC97D
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF42E0919;
	Wed, 29 Oct 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALcdaJBB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWXQhz/j"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7B231A21;
	Wed, 29 Oct 2025 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774376; cv=none; b=lHzTBQxOrrHris5uUv/cILRZg4odCzM4HsApKAltQKGZYfquYUAU7Pl5yjovF4XWdH3hdrpBGahATuGGZ7b66B+KTmOgld59C8ApkmazO5SRMyFWjfryuPRyEfXHsPfqUbPEfTh47foluaCDZCin8QeAkUu8D0ypoMTDw8hY3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774376; c=relaxed/simple;
	bh=oUVq9T0BribGrtHTzW8NUeoOdTkxqt7zLvPRcgX3Tmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0hhoOdw1FWkEXw0VXr5RtiL6wyVrg+foiRb6gXHvOfHyysaT5xxoZjvNaV08bsG6TQpCRY02qnfrBkrfJVX6cmF4HQYlai/aDCLzYmUMASPU+2T5Jwsb2xcplIs3Yi7dyDPjxIoaJlsqTJo5cgeUnKgF5JEv6KpZxJWj0bOaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALcdaJBB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWXQhz/j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761774373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mm2CEk/mPOeuapP6PBjLIIKJfWyInNAFbDpswPeDTd0=;
	b=ALcdaJBBKOxDyZPNQzSz40g8uqCVW4NJOhwLxmTVN+TyZb0HPjlDtHAVqnHGp5y5QmJLEa
	ZT7pJt59d9/Nce7192ImarQho22GiD14tLj6XnsHHSLvHR8bTofLhSXmv/lYScp+qXcVxj
	U4+kc0sGHoZ2irTix5D9EO+e7loGry6oZ4Z8nGBdosY8h5FXNlr6XWaMfmZm9HlUgSiEnN
	mIi6CfkQIsDz5v+MaEtyVMQQjjb+m1CcgFt04hF01JlqDEAq8N6PBCcsHCYqNJ+sw+UHPs
	rmf9QC8Zjx8INBnFd4kcPDwFl+y0ldMRGk0kmaSeS7et+nWdUxc629pDtMUFWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761774373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mm2CEk/mPOeuapP6PBjLIIKJfWyInNAFbDpswPeDTd0=;
	b=XWXQhz/jHJMpVBYVUON9l/1rUZ5f/dAUZsg2KQ48vnw93qUhNHenZBUioZUDcuN3LqMuGQ
	NXZ7233R2spLYyAw==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann
 <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [patch V3 10/12] rseq: Implement rseq_grant_slice_extension()
In-Reply-To: <20251029160859.22bb6eed@gandalf.local.home>
References: <20251029125514.496134233@linutronix.de>
 <20251029130404.051555060@linutronix.de>
 <20251029160859.22bb6eed@gandalf.local.home>
Date: Wed, 29 Oct 2025 22:46:12 +0100
Message-ID: <87jz0dtm8r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 16:08, Steven Rostedt wrote:
> On Wed, 29 Oct 2025 14:22:30 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> +		/*
>> +		 * Quick check conditions where a grant is not possible or
>> +		 * needs to be revoked.
>> +		 *
>> +		 *  1) Any TIF bit which needs to do extra work aside of
>> +		 *     rescheduling prevents a grant.
>> +		 *
>
> I'm curious to why any other TIF bit causes this to refuse a grant?
>
> If deferred unwinding gets implemented, and profiling is enabled, it uses
> task_work. From my understanding, task_work will set a TIF bit. Would this
> mean that we would not be able to profile this feature with the deferred
> unwinder? As profiling it will prevent it from being used?

You still can use it. The point is that a set TIF bit will do extra
work, which means extra scheduling latency. The extra work might be
short enough to still make the grant useful, but that's something which
needs to be worked out and analyzed. Quite some of the TIF bits actually
end up with another reschedule request.

As this whole thing is an opportunistic poor mans priority ceiling
attempt, I opted for the simple decision of not granting it when other
TIF bits are set. KISS rules :)

That's not set in stone and has no user space ABI relevance because it's
solely a kernel implementation detail.

> -- Steve

Can you please trim your replies as anybody else does?

Thanks,

        tglx

