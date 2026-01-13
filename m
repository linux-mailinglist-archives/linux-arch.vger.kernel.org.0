Return-Path: <linux-arch+bounces-15790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B346D1BBEC
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 00:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C288301D657
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01142773FC;
	Tue, 13 Jan 2026 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJG6cK0V"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD161BC08F
	for <linux-arch@vger.kernel.org>; Tue, 13 Jan 2026 23:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347973; cv=none; b=uEL5pHkWnpbjBNo8CEYJhKEcI3NbpfQdR9eOyuRS8TcvuTsQIlMv/xWWSDxVI3EVPQf1KbyW296ZRJv7S6q8caGluPRgeTAyngXApeKm+tmWoGdDLKnXiw+QXW+/qpnaY6m/86ZTO6BU/N26kGKw5ExMlki+ImkE6VDWI3347Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347973; c=relaxed/simple;
	bh=nSdP3HrW9iuR4NuegmVwuOru56ZkoJwnpe6xdX8o7gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKIEn/bgdW2rC6Pptizj7X7pDEep9GgVPW/e9mvwZ3wz4Xl/K/diSvGc8sZkWGeZjXlP8hhhAwEbq3yPqysMpSUYyAwk/anNCQDaMmfAXli9FyFZ+TDfvHMCcJacitiWjd/faQaEVOJZlBM/vG5L8hkhglbH+kJgHRbRnb4DGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJG6cK0V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768347971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DXPqAQ/gddAb6fWL3d3+ZRcDVd8+OsmA1rq1PZbNuY=;
	b=iJG6cK0VXn5faWzFvoU4R8pdD4mh/lFbBCzwMim4ax5X2hq25LpuWYwFJXmr6NYPA8wyVz
	/MwPAsIMn3E9vB8hlIM0itgK9q/a5f9pMVb0oTL00nbp/LCa8Gj8D++xDDc8mkBrsZoSyl
	y3aECdXsnlp8CEBR1/CMlgI4ewoHAbc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-NxnTPfRcNgan3FBbiTySLA-1; Tue,
 13 Jan 2026 18:46:07 -0500
X-MC-Unique: NxnTPfRcNgan3FBbiTySLA-1
X-Mimecast-MFC-AGG-ID: NxnTPfRcNgan3FBbiTySLA_1768347965
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D93E19560B7;
	Tue, 13 Jan 2026 23:46:04 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22EF30001A2;
	Tue, 13 Jan 2026 23:45:57 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  LKML
 <linux-kernel@vger.kernel.org>,  "Paul E. McKenney" <paulmck@kernel.org>,
  Boqun Feng <boqun.feng@gmail.com>,  Jonathan Corbet <corbet@lwn.net>,
  Prakash Sangappa <prakash.sangappa@oracle.com>,  Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>,  K Prateek Nayak <kprateek.nayak@amd.com>,
  Steven Rostedt <rostedt@goodmis.org>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Arnd Bergmann <arnd@arndb.de>,
  linux-arch@vger.kernel.org,  Randy Dunlap <rdunlap@infradead.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Ron Geva <rongevarg@gmail.com>,  Waiman
 Long <longman@redhat.com>,  "carlos@redhat.com" <carlos@redhat.com>,
  Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <87ldi4gjm3.ffs@tglx> (Thomas Gleixner's message of "Sun, 11 Jan
	2026 18:11:16 +0100")
References: <20251215155615.870031952@linutronix.de>
	<20251215155708.669472597@linutronix.de>
	<d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
	<87jyyjbclh.ffs@tglx>
	<225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
	<87ldi4gjm3.ffs@tglx>
Date: Wed, 14 Jan 2026 00:45:54 +0100
Message-ID: <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Thomas Gleixner:

> I'm not completely opposed to make it process wide. For threads created
> after enablement, that's trivial because that can be done when the per
> thread RSEQ is registered. But when it gets enabled _after_ threads have
> been created already then we need code to chase the threads and enable
> it after the fact because we are not going to query the enablement in
> curr->mm::whatever just to have another conditional and another
> cacheline to access.

In glibc, we make sure that the registration for restartable sequences
happens before any user code (with the exception of IFUNC resolvers) can
run.  This includes code from signal handlers.  We started masking
signals on newly created threads for this reason, to make these
partially initialized states unobservable.

It's not clear to me what the expected outcome is.  If we ever want to
offer deadline extension as a mutex attribute (for example), then we
have to switch this on at process start unconditionally because we don't
know if this new API will be used by the new process (potentially after
dlopen, so we can't even use things likely analyzing the symbol
footprint ahead of time).

> The only option is to reject enablement when there is already more than
> one thread in the process, but there is a reasonable argument that a
> process might only enable it for a subset of threads, which have actual
> lock interaction and not bother with it for other things. I'm not seeing
> a reason to restrict the flexibility of configuration just because you
> envision magic use cases all over the place.

Sure, but it looks like this needs a custom/minimal libc.  It's like
repurposing set_robust_list for something else.  It can be done, but it
has a significant cost in terms of compatibility because some
functionality (that other libraries in the process depend on) will stop
working.

> On the other hand there is no guarantee that libc registers RSEQ when a
> thread is started as it can be disabled or not supported, so you have
> exactly the same problem there that the code which wants to use it needs
> to ensure that a RSEQ area is registered, no?

With glibc, if RSEQ is registered on the main thread, it will be
registered on all other threads, too.  Technically, it's possible to
unregister RSEQ with the kernel, of course, but that's totally
undefined, like unmapping memory originally returned from malloc.

>>> The prctl allows you to query the state, so all parties can make
>>> informed decisions. It's not any different from other mechanisms, which
>>> require coordination between different parts.
>>
>> I'm fine with having prctl enable the feature (for the whole process)
>> and query its state.
>>
>> The part I'm concerned with is the prctl disabling the feature, as
>> we're losing the availability invariant after setup.
>
>   close(0);
>
> has the same problem. How many instances of bugs in that area have you
> seen so far?

We've had significant issues due to incorrect close calls (maybe not
close(0) in particular, but definitely with double-closes removing
descriptors created by other threads.

We need the prctl to unregister for CRIU, though, otherwise CRIU won't
be able to use glibc directly (or would have to re-exec itself in a new
configuration).

Thanks,
Florian


