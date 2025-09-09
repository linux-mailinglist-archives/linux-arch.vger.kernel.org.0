Return-Path: <linux-arch+bounces-13454-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CA3B4FB63
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 14:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559BD1C601EE
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 12:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C332A3D8;
	Tue,  9 Sep 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVIEy9P3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2xlJSqd/"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257AA322DB4;
	Tue,  9 Sep 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421477; cv=none; b=aKy7WL1hK3CPBJpCCshkhEPmMb6AfJ+NH1mFcw3zHoSZIE0VQZ/kMhbe/c5JMJ28uCXp1Gmr8L7OruWRRQRVLmCl2ZJMfYvZq1KOT+tqVGtA+kICijLPRGfe7r3hyPVBQQH1OsLZmskBZOo1ulGQT92Jpah1/YT/e7Xwi7h7Ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421477; c=relaxed/simple;
	bh=H8hZBFuaGCxEuXIGV38vj5JgKcCgDj247yDqFpnurRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ePHwhdtkiE10kjDYsONjX5w4be8W6fz3wHbo/YBF+WvnR9z3BoG94yI7o9DA5WExBzL7sJ351XCevCSRPHhWa3ZkBhY83CrRMfL9bFkGRQ6UaoNtbWeqlTr5kD43dbiNOJp1qNbLo3z5feX/YRRn2tMq/jhnyCLR+5NqsGQ2dj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVIEy9P3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2xlJSqd/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757421474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Um56MO6Hq4AwOnzJ7D/qva49PwBVaEV0uBgzg3toHk=;
	b=gVIEy9P3ljh8c2xVFo99+PSRIH5lMlI555kLIYmKiG1Fb0K602eAAKi6/HWoOMG2slDmvS
	aVOIkejHz5j/Lg7qNWZg6C1aMnx7xx90lh8R5kccVYp9EBcdUnZIvIeQZO05Ddvcb/rAjM
	TfkpILWlHyPQz536W7e76hggep4PAEOGOYCZOHnzjAujkuu+lPOg6W6KEUj8HLuwfmdvG7
	SxZe+PmPs8hvnv2nP4NLChPRwkoyekK4AZ4YlUu4rLVPb44jt+p1WOFmBEtwKocHS59K+i
	+ZGqU1usd64lvu8aSLPPfpgUy/I2mnc2QEL7Dx+V/6c/nYOuX/+q9NwI7GWKHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757421474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Um56MO6Hq4AwOnzJ7D/qva49PwBVaEV0uBgzg3toHk=;
	b=2xlJSqd/+rzD+Im+p2LcvY0WGrQPCgDbgaLKsr4e2bTGkGHgCtXpYzvYcPM1eHGvhOgnA7
	nrQHPoxAOXXLGqDA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>, Peter Zijlstra
 <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <20250908225709.144709889@linutronix.de>
References: <20250908225709.144709889@linutronix.de>
Date: Tue, 09 Sep 2025 14:37:53 +0200
Message-ID: <87ms73vm1q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 00:59, Thomas Gleixner wrote:
> For your convenience all of it is also available as a conglomerate from
> git:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Force pushed a new version into the branch, which addresses the initial
feedback and fallout.

Thanks,

        tglx

