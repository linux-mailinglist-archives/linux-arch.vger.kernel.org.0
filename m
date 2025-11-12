Return-Path: <linux-arch+bounces-14686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16AC54A92
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 22:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258A03A4761
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 21:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62102E5B0D;
	Wed, 12 Nov 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2oTveuv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cj8Goiph"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8D29B233;
	Wed, 12 Nov 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984462; cv=none; b=DOjzT2K9g492MvmPRdJWSFmWDbURYP/eh6TN6iXvTCwyKHrbzCK34UA6ukECcUegWfq6QxiHLinI3gu8xcbAYnMXCkZ2t1AMshDabekajWY18YCeYhbmvBnm5kYEVDI/7oHznliK5yhIvn7uWj30GOW+jhkOXn+sBRF6i1ckKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984462; c=relaxed/simple;
	bh=vy3Z/BpNW0xbQ8hrd2pZdbCa6OqDrTid72iM3mZurgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mulnlDw4zWPyYzBapPgEkOXZ/pE4MwAqyqkS8U9tMRYAj80nIuv43T/aRwJ2QLvAJzRzXpLdZuVGTdoHJi5Gsp6KKBMwyOpjsCr+2N+2E8SRnSUkNulN2nzxnC2ZehSbqzLQNXNRp+lr6b8wAToIy9kB5Nu1xwlbIq0qshSKNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2oTveuv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cj8Goiph; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762984458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy3Z/BpNW0xbQ8hrd2pZdbCa6OqDrTid72iM3mZurgg=;
	b=L2oTveuv4TT6Z4Tv85GCjyU8tzmbQNPg+gX1ahkdehAnWw3J1PccS6AR5HbjhOk1pqoYVT
	+Vnk84fkk4BylnRu6lZGQ/sxUeIT6VV7YN83c6Gq17rUaWm9F8dAOMvCNXln641jVgZKgm
	JOe+nWDRBsDzqPL3oOgjGl8WWBAMbANxEScDsEoojT232si/eQwShlLZlP1Jo5glZS/gJJ
	YPDft0TBU5f4VYDU2rjFDgEfUvPDTD7Ik7YApQCYo4bizwFpx0wZ9N9RB32zTqDoZFK2GB
	ufyeGkqMU5YH0No38GkQwcnIzIIwpjUo2YXPBkcNGlwty9yWqGwB87LlR9lBAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762984458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy3Z/BpNW0xbQ8hrd2pZdbCa6OqDrTid72iM3mZurgg=;
	b=Cj8Goiph0lJvbH3un95layiWPGdUSvnc1HwvbMVVfsnCE9jUYvyQWYnf1w8bJZtxVYyhdD
	n0slSrxXGvFp2bDA==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Prakash Sangappa
 <prakash.sangappa@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <3a0f1467-7fff-48c6-b0d1-772917cc6143@efficios.com>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com> <87ldkbdmbu.ffs@tglx>
 <3a0f1467-7fff-48c6-b0d1-772917cc6143@efficios.com>
Date: Wed, 12 Nov 2025 22:54:17 +0100
Message-ID: <87fraiex2u.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 15:46, Mathieu Desnoyers wrote:
> On 2025-11-12 15:31, Thomas Gleixner wrote:
>> I did not notice the V3 issue because tests passed on a small machine,
>> but after I did a rebase to the tip rseq and uaccess bits, I noticed the
>> failure because I tested on a larger box.
>
> Good ! We'll see if this fixes the issue observed by Prakash. If not,
> I'm curious to validate that num_possible_cpus() is always set to its
> final value before _any_ mm is created.

It _is_ set to it's final value in start_kernel() before
setup_per_cpu_areas() is invoked. Otherwise the kernel would not work at
all.

