Return-Path: <linux-arch+bounces-15861-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3E1D3A5AC
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C8923053715
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029229898B;
	Mon, 19 Jan 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dcez2PzV"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E7286419
	for <linux-arch@vger.kernel.org>; Mon, 19 Jan 2026 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819634; cv=none; b=kV9Ns8ETy7r5TFb5RZmeDJ/UMxGMzjzce4eaGef2Al5Sm5B4jwrQa85GMSx0SIhKEMGwpKbzQodnainfE/oS5pxkbRwVQnu/v/YYRU9M+JAng3kI653QdwRVEVwUtHaMHc07D+BzYAzvOLLvesHlyT9e9h/N2lI3lVUcrKY61j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819634; c=relaxed/simple;
	bh=lbSm9dCStmZlmyPftoxBVs6faUaWFkAG38XKclkCSWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ucmWvI6/6oQY6F8ppc93nfJ62ypK2XFN0ZdCP5tl6bi6xMf2BkSVkJcKRBa7hknw6YGpkzOPZHY9SATm337GPfKFqUkg6Yi5PI3gSyevuJmmN+8jR/GCkcllSrXGZ/jCQ+fF8Toi6CzUxnjwu6pAZqB/KCdtRitrv56S3/l8uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dcez2PzV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768819632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NkTfYTOgyDyq9zTC+QFnQk1zBEkgtIki928ZacAuUck=;
	b=Dcez2PzVaj02lXduufdXOvMa0+ongoJEmK8KMGHhFM8hYHnN3kn6KhBti8wKy4EJ0sOb41
	O3Lpjv+B50NsqDqI32QhFmwKKy1vfwzjaEspJtyDI1E+A+cc8TNick5rgfdkvj2xwEwdAO
	XGQXQ8TXNkvAxbsBO/9Q0T1JkESfMxY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-HUsZb-C1OhKeap8G5KrJlA-1; Mon,
 19 Jan 2026 05:47:08 -0500
X-MC-Unique: HUsZb-C1OhKeap8G5KrJlA-1
X-Mimecast-MFC-AGG-ID: HUsZb-C1OhKeap8G5KrJlA_1768819626
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5069F1800357;
	Mon, 19 Jan 2026 10:47:05 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89E0819560AB;
	Mon, 19 Jan 2026 10:46:58 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  Thomas Gleixner
 <tglx@kernel.org>,  LKML <linux-kernel@vger.kernel.org>,  "Paul E.
 McKenney" <paulmck@kernel.org>,  Boqun Feng <boqun.feng@gmail.com>,
  Jonathan Corbet <corbet@lwn.net>,  Prakash Sangappa
 <prakash.sangappa@oracle.com>,  Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>,  K Prateek Nayak <kprateek.nayak@amd.com>,
  Steven Rostedt <rostedt@goodmis.org>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Arnd Bergmann <arnd@arndb.de>,
  linux-arch@vger.kernel.org,  Randy Dunlap <rdunlap@infradead.org>,  Ron
 Geva <rongevarg@gmail.com>,  Waiman Long <longman@redhat.com>,
  "carlos@redhat.com" <carlos@redhat.com>,  Michael Jeanson
 <mjeanson@efficios.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <20260119102138.GQ830755@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Mon, 19 Jan 2026 11:21:38 +0100")
References: <20251215155615.870031952@linutronix.de>
	<20251215155708.669472597@linutronix.de>
	<d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
	<87jyyjbclh.ffs@tglx>
	<225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
	<87ldi4gjm3.ffs@tglx> <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
	<45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>
	<20260119102138.GQ830755@noisy.programming.kicks-ass.net>
Date: Mon, 19 Jan 2026 11:46:56 +0100
Message-ID: <lhu1pjlhobj.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Peter Zijlstra:

> On Sat, Jan 17, 2026 at 05:16:16PM +0100, Mathieu Desnoyers wrote:
>
>> My main concern is about the overhead of added system calls at thread
>> creation. I recall that doing an additional rseq system call at thread
>> creation was analyzed thoroughly for performance regressions at the
>> libc level. I would not want to start requiring libc to issue a
>> handful of additional prctl system calls per thread creation for no good
>> reason.
>
> A wee something like so?
>
> That would allow registering rseq with RSEQ_FLAG_SLICE_EXT_DEFAULT_ON
> set and if all the stars align, it will then have it on at the end.

I think this would work for glibc because it will only show up in
__rseq_flags if we set the flag on process startup, and then all threads
would get it.  It doesn't matter that __rseq_flags is not per-thread.

Thanks,
Florian


