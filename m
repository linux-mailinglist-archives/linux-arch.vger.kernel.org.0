Return-Path: <linux-arch+bounces-15505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C799CCDEC1
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 00:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589013015873
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1E25332E;
	Thu, 18 Dec 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l39VazhY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y3TI7GLB"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F122F77B;
	Thu, 18 Dec 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100096; cv=none; b=jV/zolU4iWfyaDmoZwVc9MrR/xgQqOgaq3KH3WkjeM1VaVdcqsbEHwQd7on8bp9Jv4Otw+yr8zLkVxb3hRUjfJAW85QDmPZSuyCwiEjYKuURAm6OC7HTX216wx2HS9LlwfI7hE6GqEx56ZWvKMny7aHx5mg5bHnWoLj9HyvT4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100096; c=relaxed/simple;
	bh=WDXofnHGR7Prt0x/KTVeAVcVNVJFy+Rd5Gy6YLbW8uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntmUVUBkMl5H1X0rwlrTzQeQzjtwlIZWAt0xKuGwb9rwEOFdA30CK9idLg/0Lpo/k3Rg80wJxxSfzAA0SZ5zzec+8IfUOZJWvvKjVoaIkrOXPNM5jTHUxVl6pXoRIpu3qZOXYGaicoq2p1M48flQYhr7ts7cqM/LnbmpZqMgXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l39VazhY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y3TI7GLB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766100091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MlM92sMLXMfLycFlkI0rH6Gid+YZl8jKK5jUtWoQQdg=;
	b=l39VazhYFqy4Ag49B65C1WmugZOLogIIPmrU2jLtPgjeVfi/4zb8Nt629IxSKycFHbaaAM
	LU8qhFRNf6auAr6cXWhzakdO0vGeQJ8mRDOTjxthTARQa42BfZQ3dkXHv0gp0NlE/6FsA2
	YqTGn0ZK3dynz76nLE/nPuL+Z1KmagaVX7WMsNR0XVIN44BZp4oHJ61531kchXfgNivSQa
	1LW7tUDaKABVzIPA2yOwtO7c6pxahVnvz3BCQ3Lppqs3Ih7QLmodYucZ+ydDdac0/QSHlX
	quqvzJ/XNVGyhnwPczWJucZ6fJnbCLl2d3tPaxKwfBWnxVKw4N2f5hUYkLKUsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766100091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MlM92sMLXMfLycFlkI0rH6Gid+YZl8jKK5jUtWoQQdg=;
	b=Y3TI7GLB2pC3F2l7QHLEHPascLggW5HShmzunbQSOvaVkvC5VJRZgSUMEeGKYFFu0YcBUb
	ABuBGP32WV4JGmDQ==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Peter
 Zijlstra <peterz@infradead.org>, Ron Geva <rongevarg@gmail.com>, Waiman
 Long <longman@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 "carlos@redhat.com" <carlos@redhat.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
Date: Fri, 19 Dec 2025 00:21:30 +0100
Message-ID: <87jyyjbclh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 16 2025 at 09:36, Mathieu Desnoyers wrote:
> On 2025-12-15 13:24, Thomas Gleixner wrote:
> [...]
>> +The thread has to enable the functionality via prctl(2)::
>> +
>> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
>> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
>
> Although it is not documented, it appears that a thread can
> also use this prctl to disable slice extension.

Obviously. Controls are supposed to be symmetrical.

> How is it meant to compose once we have libc trying to use slice
> extension internally and the application also using it or wishing to
> disable it, unaware that libc is also trying to use it ?

Tons of prctls have the same "issue". What's so special about this?

> Applications are composed of various libraries, each of which may want

I'm well aware of that fact.

> to use the feature. It's unclear to me how the per-thread slice
> extension enable/disable state fits in this context. Unless we address
> this, it will become either:
>
> - Owned and used by a single library, or
>
> - Owned and used by the application, unavailable to libraries.

The prctl allows you to query the state, so all parties can make
informed decisions. It's not any different from other mechanisms, which
require coordination between different parts.

> This goes against the design goals of RSEQ features.

These goals are documented where?

What I've seen so far at least from the implementation is that it aims
to enable the maximum amount of features, aka. overhead, unconditionally
even if nothing uses them, e.g. CID.

Your vision/goal of RSEQ being useful everywhere simply does not match
the reality.

As I pointed out in the previous submission, the benefits of time slice
extensions are limited. In low contention scenarios they result in
measurable regressions, so it's not the magic panacea which solves all
locking/critical section problems at once.

The idea that cobbling random libraries together in the hope that
everything goes well has never worked. That's simply a wet dream and
Java has proven that to the maximum extent decades ago. Nevertheless all
other programming models went down the same yawning abyss and everyone
expects that the kernel is magically solving their problems by adding
more abusable [mis]features.

Systems have to be designed carefully as a whole if you want to achieve
the maximum performance. That's not any different from other targets
like real-time. A real-time enabled kernel does not magically create a
real-time system.

TBH, the prctl should be the least of your worries. There are worse
problems with uncoordinated usage:

    set(REQUEST)
    ....

 -> Interrupt
      clr(REQUEST)
      set(GRANTED)

   lib1fn()
      set(REQUEST)            <- Inconsistent state

      if (a) {
            lib2fn()
              syscall()       <- RSEQ debug will kill the task....
      } else {
        ...
 -> Interrupt
                              <- RSEQ debug will kill the task....

And no, we are not going to lift this restriction because it allows
abuse of the mechanism unless we track more state and inflict more
overhead on the kernel for no good reason.

Thanks,

        tglx

