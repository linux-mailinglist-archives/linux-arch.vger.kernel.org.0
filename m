Return-Path: <linux-arch+bounces-7346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296997AFD9
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E712D1F237D5
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19221531CC;
	Tue, 17 Sep 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Op8M+Ud/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nv/BsxsS"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BE14BFBF;
	Tue, 17 Sep 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573972; cv=none; b=K5wPwa9/aams7whlpUyP/sbzbUzytL1wRrPQRq2zGHyPHkK5YPU81TAkBJHNDfV0J6L1NHRomkvph6bRSBpd4M42rcUDGIODBimD3agk213wRSUd2UoI7JYr04Ze3A4ZD0laeJDDZxlMJ5ykfOArMO2K43p6yLVEbwf4B9E9+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573972; c=relaxed/simple;
	bh=XyJSjIDRupdeEJC9SuMT/izTX1qvkFBcETjsJkfr4VE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEhwee/E6melPCEM+2NHyQZHAciKLe2ykASvj90FAmcejedv3rd2ipaTS7Rv3IpMPtiY8y5g0yyyU5hwYdWq6b+v3omgVOaY46vy60fDj2pnzt76/n9Fuk/J+LJBd3BayF1USow0gNeZzf5a7Tn4PrTrpp5dqWPMJDAs/GCL9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Op8M+Ud/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nv/BsxsS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726573969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7bX+ckDiWzV0UXiUsEpBvHAAjmkCz9ocHzwV5JJ1Gn4=;
	b=Op8M+Ud/ecXwHOTy7YoUTH4slRc/9pzpxC5sgAbCKhScsfynbjtvzjn7cI2VkPtpaHNByX
	6lDCZXjvLs1v5TxMEN0E5LIQFZmHVb8+FsmBvsCGeD9e55FZ0mtwfU0KHpqR/3mwHJNyj5
	RxL8beQJgpw/sg3Cx9smitqJm9CAimomZxHQycly883Y7B0DFZiDDnX6887epqDFHeXqyP
	6XY5FHyUejTAz1HsZYNaI/BcL6pnFZyIYyC4c1KuHBemn88f9eBxsFnYyuPydGqo9nhV9Q
	VbvIEW4dOOiGVjm7zccRVtSfsK5R8tJDEYbkkVE3k6CIHccCilknBxwF42Q3Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726573969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7bX+ckDiWzV0UXiUsEpBvHAAjmkCz9ocHzwV5JJ1Gn4=;
	b=Nv/BsxsS8N1MMLS0Mu4yS1B+iTF5E4Cmt408LhLBA/k+P/2xsFm9tPkhB/8+UpN3tp9U+F
	oG+6WW/C6AQoWtCw==
To: Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, "Christoph Lameter (Ampere)" <cl@gentwo.org>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
Date: Tue, 17 Sep 2024 13:52:48 +0200
Message-ID: <87o74m1oq7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 12 2024 at 15:44, Christoph Lameter via wrote:

$Subject: .....

You still fail to provide a proper subsystem prefix. It's not rocket science.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
>
> Some architectures support load acquire which can save us a memory
> barrier and save some cycles.
>
> A typical sequence
>
> 	do {
> 		seq = read_seqcount_begin(&s);
> 		<something>
> 	} while (read_seqcount_retry(&s, seq);
>
> requires 13 cycles on ARM64 for an empty loop. Two read memory
> barriers are needed. One for each of the seqcount_* functions.
>
> We can replace the first read barrier with a load acquire of
> the seqcount which saves us one barrier.

We ....

Please write changelogs using passive voice. 'We' means nothing here.

Thanks,

        tglx

