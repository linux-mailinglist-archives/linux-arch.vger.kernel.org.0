Return-Path: <linux-arch+bounces-14492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD5C2DE0F
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 20:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F74ED0FA
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 19:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED323F9FB;
	Mon,  3 Nov 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxDbbKHa"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413F2116F4
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197607; cv=none; b=Aztx1KZVCExYYFvyKRDTJJPrdHl+9Ji0f4I+Fy0GSZGIdUNdtDXT/bamta4hDFaoXu4Yhd7/8z02jQ1osbyAlMAywFgPX066UKO2/Yx9GOdyQDbLf/+ShsjesaZSISnFM4/6ZNjq+ayp3rjBR6+rg1Z2DMd0UNyL+ARFyC/Fvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197607; c=relaxed/simple;
	bh=TaZ8VgcWPtgQM1En6kezQIgJCGrgiPugVdB3W0Sr/3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IxuYVfv6B9dKnmFH4I5cz1HsIlLxzFYWvk5Z75lfv+3k0o1tZgaXc+QG3BZ3mkohdJf++pfOraT1uF3cost6JRo/ETMgKuD25hYWXrkd/NjhvmB/DkNa7eGz23+XvvbfxUcgoaEEyn8vrgEWCqTBysP1N823r203GtTfNPdHdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxDbbKHa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762197603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSxeyNIhJ0/LZwJpQYCXx38W3Gj9Tp+hUkja7RtNKNs=;
	b=RxDbbKHaIyXKXbaNjCvW+iKQl70f+4BEbXemOQ4+Ug79fL9i7GIUSMp30E0OAoxnYlcwxc
	dU/9oOsvqQmlnkbiI91lmJN7Mc8L2e74UyY5sskx3U4SdeZZXFkmpw5xOMkqwEzFg38LN7
	eZqHjC2fX6AW0uyHq/rqs/P+hKqrTCw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-QbTa9iZDODOfs6_KuNvrow-1; Mon,
 03 Nov 2025 14:20:00 -0500
X-MC-Unique: QbTa9iZDODOfs6_KuNvrow-1
X-Mimecast-MFC-AGG-ID: QbTa9iZDODOfs6_KuNvrow_1762197597
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F6F81800654;
	Mon,  3 Nov 2025 19:19:55 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E021956056;
	Mon,  3 Nov 2025 19:19:49 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  LKML
 <linux-kernel@vger.kernel.org>,  Peter Zijlstra <peterz@infradead.org>,
  "Paul E. McKenney" <paulmck@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Jonathan Corbet <corbet@lwn.net>,  Prakash
 Sangappa <prakash.sangappa@oracle.com>,  Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>,  K Prateek Nayak <kprateek.nayak@amd.com>,
  Steven Rostedt <rostedt@goodmis.org>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Arnd Bergmann <arnd@arndb.de>,
  linux-arch@vger.kernel.org,  "carlos@redhat.com" <carlos@redhat.com>,
  Dmitry Vyukov <dvyukov@google.com>,  Marco Elver <elver@google.com>,
  Peter Oskolkov <posk@posk.io>
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
In-Reply-To: <8181a3e3-f49f-4278-9b15-67211d6151e0@efficios.com> (Mathieu
	Desnoyers's message of "Mon, 3 Nov 2025 12:00:30 -0500")
References: <20251029125514.496134233@linutronix.de>
	<20251029130403.542731428@linutronix.de>
	<7e44ca0b-e898-4b7f-aaaa-30d8ac52c643@efficios.com>
	<87bjlmss8j.ffs@tglx>
	<8181a3e3-f49f-4278-9b15-67211d6151e0@efficios.com>
Date: Mon, 03 Nov 2025 20:19:46 +0100
Message-ID: <lhu8qgm7wkt.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Mathieu Desnoyers:

> On 2025-10-31 16:58, Thomas Gleixner wrote:
>> On Fri, Oct 31 2025 at 15:31, Mathieu Desnoyers wrote:
>>> On 2025-10-29 09:22, Thomas Gleixner wrote:
>>> [...]
>>>> +
>>>> +The thread has to enable the functionality via prctl(2)::
>>>> +
>>>> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
>>>> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
>>>
>>> Enabling specifically for each thread requires hooking into thread
>>> creation, and is not a good fit for enabling this from executable or
>>> library constructor function.
>> Where is the problem? It's not rocket science to handle that in user
>> space.
>
> Overhead at thread creation is a metric that is closely followed
> by glibc developers. If we want a fine-grained per-thread control over
> the slice extension mechanism, it would be good if we can think of a way
> to allow userspace to enable it through either clone3 or rseq so
> we don't add another round-trip to the kernel at thread creation.
> This could be done either as an addition to this prctl, or as a
> replacement if we don't want to add two ways to do the same thing.

I think this is a bit exaggerated. 8-)

I'm more concerned about this: If it's a separate system call like the
quoted prctl, we'll likely have cases where the program launches and
this feature automatically gets enabled for the main thread by glibc.
Then the application installs a seccomp filter that doesn't allow the
prctl, and calls pthread_create.  At this point we either end up with a
partially enabled feature (depending on which thread the code runs), or
we have to fail the pthread_create call.  Neither option is great.

So something enabled by rseq flags seems better to me.  Maybe
default-enable and disable with a non-zero flag if backwards
compatibility is sufficient?  As far I understand it, this series has
performance improvements that more than offset the slice extension cost?

Thanks,
Florian


