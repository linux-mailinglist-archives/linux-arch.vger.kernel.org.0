Return-Path: <linux-arch+bounces-15508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08ECCDF24
	for <lists+linux-arch@lfdr.de>; Fri, 19 Dec 2025 00:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422E830671EE
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26882BDC03;
	Thu, 18 Dec 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGbyevzc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hsu4QtRg"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A13299924;
	Thu, 18 Dec 2025 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100536; cv=none; b=CF4nTgks/Wd016YqDfOhO3h1zlMk0JwgIZpkpOKSQral2DTNGYbF2uSXTRWVIZV4JZl7sMtczDvvJDTB/kjK7T106DIakgJyV6feJJRcpSngGXizWw88e9iElEerPdMl8InfZ8r2JPgoWWfZxXiVetmLaMw//aVWPAAUbz6aEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100536; c=relaxed/simple;
	bh=gLT2kJn3Y9GdnD0bh1VxM9JZkUy1QiSBr0Hzfqpy9oA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kgqt1v+gR4r3TSUdNKplrQ6mX4jrZHljGUhz5f7kMq7p9K/sPm5mhHI22/il+7HGW8+Ydz3QnapuICW+57B7LBH6XMaHx+kv6k/dTgpExyqmN8qGOPGO591T22f0sSF+OK3h90tnpefWyK/QIiU05NEKP6ceZsTkaH46by/WIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGbyevzc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hsu4QtRg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766100531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLT2kJn3Y9GdnD0bh1VxM9JZkUy1QiSBr0Hzfqpy9oA=;
	b=rGbyevzc6idwmDHtYaEewa2BUSylQC5HMbJgFHIty/E/up6v1syOeIZlivIyUY1Dq85TSE
	lpb/vQUcvU75wE4NEXjz6okLyRhcT2gJgbNarTL1dsL+verbuEefLg4FhvPMfO3t9IjdSN
	0PjSOWadWY9+qaw2WXdk8XcAZm+XnLy84FqH6uLw5vb+a5Crzjrcjx/IhEZKZm0s5qb8HZ
	c4Logna8J160LcX4Gt/R5aGftmYEpu+aXmnrn5050wqjOTCPh6/byu8c6YxyGS5l7nbBKw
	IcOdX2QqhWeCH58qVHsvPVU/rp0UyXQVRLLd1h/KbD0l8KbNWuzSQbo16Y9TJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766100531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLT2kJn3Y9GdnD0bh1VxM9JZkUy1QiSBr0Hzfqpy9oA=;
	b=hsu4QtRgI7L6H2M+aZ/Atw8qzE8WV/rKER9KQfvYbOyUzhd2OJs0ERQiL3UkqSgHAmyYwB
	671YfSIPj5ukZYBA==
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
Subject: Re: [patch V6 09/11] rseq: Implement rseq_grant_slice_extension()
In-Reply-To: <0cb26892-c68e-4a57-8029-8c582f868505@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.195303303@linutronix.de>
 <0cb26892-c68e-4a57-8029-8c582f868505@efficios.com>
Date: Fri, 19 Dec 2025 00:28:50 +0100
Message-ID: <87bjjvbc99.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 16 2025 at 10:25, Mathieu Desnoyers wrote:
> On 2025-12-15 13:24, Thomas Gleixner wrote:
> [...]
>> In case that the user space access faults or invalid state is detected, the
>> task is terminated with SIGSEGV.
>
> It appears that only access faults trigger SIGSEGV. Perhaps removing
> "or invalid state is detected" should be removed, or the code is missing
> some state validation ?

Seems I dropped a debug path somewhere down the road.

