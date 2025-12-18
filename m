Return-Path: <linux-arch+bounces-15503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BACCDD77
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 23:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69BF33038F6B
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E8341ACB;
	Thu, 18 Dec 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QIWfd7IA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nC2wXSzw"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5834214C;
	Thu, 18 Dec 2025 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096932; cv=none; b=JlIFU/rOUN3lFAuPIcpuSgHrmeSH/eZPXu6460qgaJtYQYH2Pa15LebjsCzW1tk7+1DatTvtblZsSKhJxsLd1+fQmqoDLEy7MytniaK4RyrwsiN8XHgvN6J6Nz9gTXLAElpODAupNtA5/E72Vp3yi9rE8l2m5NYymWTkvKpQZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096932; c=relaxed/simple;
	bh=vX5u4Q8A53RsvTwbDPsp/btoIHU3hjvI7ZQnBWf6n4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nEsClYMIQZtYaXGKNVmL03wgxXlEh9URg3ss010+2J23GepA5qvVFTssYaN0DxBigWvL/AGE6WflB1FHWCNQAsmK0g20qWGSa1BGCiv10y+zdXSUfYPGCyAlREwLTHGOknn3si6rFmbCEslh13b6LCNSD+17a7dYUV6zR45bdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QIWfd7IA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nC2wXSzw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766096929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5s6K964YXMQPPxZrD+nBg9vLu3s7LV9ZPAf8dVxyP4=;
	b=QIWfd7IA7ouPc5VlLSAAsbKoYobquVcokJ7Y4G3N592UHtOsauv0dGIgYViVFGdWqXPz+J
	8uvCwzN7RTVEq5fRnqZy3igrd62w9ElzqFts79Ut9CEq2kofHIyjqqT+0UgFKxxXlM2E5C
	SqhoqbhGoos0C+IzHwFAskZplPTvvh4/KnOApyNsi4/xb2bKoBhByWchOzqsaD7hPswImH
	iU+Tsk2yEsp5R5CdZbMMVaz3hJAw5yWMn7rz06q7U3RSMpDgiJM2JWSHSZNMM+ohitDrYO
	DHaDvyDW57nKCsFHZtSB3VJU3WXArjD/B4f7XpmauZhFLQQIpxJ41l9kNqQF4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766096929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5s6K964YXMQPPxZrD+nBg9vLu3s7LV9ZPAf8dVxyP4=;
	b=nC2wXSzwhuY7sstJAOmD8eqyhrcKvZlCDULIJqZic9CgUb9fLrmHCNmtEQvrTrtBGJApd1
	+J48nsq/mTkY8KDw==
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
 Long <longman@redhat.com>
Subject: Re: [patch V6 06/11] rseq: Implement syscall entry work for time
 slice extensions
In-Reply-To: <6a0344be-e105-4f09-bf41-02940e730293@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.005777059@linutronix.de>
 <6a0344be-e105-4f09-bf41-02940e730293@efficios.com>
Date: Thu, 18 Dec 2025 23:28:48 +0100
Message-ID: <87ms3fbf1b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 16 2025 at 10:05, Mathieu Desnoyers wrote:
> On 2025-12-15 13:24, Thomas Gleixner wrote:
> [...]
>> 
>> If the code detects inconsistent user space that result in a SIGSEGV for
>> the application.
>
> With these last updates that allow userspace to call arbitrary system
> calls to terminate the grant, the only scenario which triggers SIGSEGV
> is if the put_user() storing to the rseq area fails. Perhaps we should

Nope. There is also the debug path which will catch offenders which
fiddle with the state.

Thanks,

        tglx

