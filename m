Return-Path: <linux-arch+bounces-15418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8071ECBF2C1
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 597E630A35CC
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E5342513;
	Mon, 15 Dec 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Zz73sIg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbTPDRX8"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE392342506;
	Mon, 15 Dec 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817527; cv=none; b=f7l8QextTC7T2R/2aJ0uNnt8A9LF+lY+CIqcLqxrP3VMreCxi5bODc5mpnD6FCDd8ADP3h2XLbn1Q8VlleU+WkZmGi7JHlAYBpu2YFg7sN6lOtasfde4bx5Ntpb9C4UptMcOd751smbTKphwATg/ty85Uo3k3fWCpfbr9Qxw9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817527; c=relaxed/simple;
	bh=qMC/3WaPWPsEC8GpkNEeJ/+onzOIu61ZnRMKgIhJqWs=;
	h=Message-ID:From:To:Cc:Subject:Date; b=XalPmzL2nc5SMvutz7cbtYjzHoid7/Xb17nAZN9bCobg9HN9JaR9bGn54zA5JDRCFKnX+U5bnNjAVD+W3vPofd1MIBRc4lJOEB4pdB5IpVCXfuuW1x/61HI3LN7i8qOnRVEiKm39hVT8lhuMFnvwfkpL+zqF7t/HKRly41QpbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Zz73sIg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbTPDRX8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155615.870031952@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765817523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=4dTT3aJAqWsVF4pZKsCUZEHviWLQKtu1DpUBLD2IFv0=;
	b=1Zz73sIg28zTHw+N3V/dMtBvqjWBnpe2u3YcF8ZxGGFf1vFwKuXn5IDH7fPZq4kIsdHnzI
	xHv66LXe17eFqjtHv0ImwlWGLWGqI1ZigMnYpJ1NVYlIsqZt+TU2R+Inu26UH1hZ5d2kRV
	80OXRA1hU/SyyeEagufn6G1kSFphTK+UyWcLRf/xBkuVFpFHX//XM6j8PhswlwJB/EdO+v
	HpsCUWyhyh8zT4cV6rxEHm3dRLdXF17EVO5xA+ItOORhawjdHmNMrv9Vh1yXammaCjt4h9
	He4mOKg6RJJAXPwnowe3WX+234+/BNcBYGB5V+yrKUUmnY+NYa8A6H8fpfWQhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765817523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=4dTT3aJAqWsVF4pZKsCUZEHviWLQKtu1DpUBLD2IFv0=;
	b=DbTPDRX8V/wk1aGk4XNpgv2BMQj/dud4bYxkADcBo/cYvLv8X22zy/AeIldc7lWL4MOEv7
	uB3PVEKGax3gp7DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch V6 00/11] rseq: Implement time slice extension mechanism
Date: Mon, 15 Dec 2025 17:52:01 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

This is a follow up on the V5 version:

     https://lore.kernel.org/20251128225931.959481199@linutronix.de

V1 contains a detailed explanation:

     https://lore.kernel.org/20250908225709.144709889@linutronix.de

TLDR: Time slice extensions are an attempt to provide opportunistic
priority ceiling without the overhead of an actual priority ceiling
protocol, but also without the guarantees such a protocol provides.

The intent is to avoid situations where a user space thread is interrupted
in a critical section and scheduled out, while holding a resource on which
the preempting thread or other threads in the system might block on. That
obviously prevents those threads from making progress in the worst case for
at least a full time slice. Especially in the context of user space
spinlocks, which are a patently bad idea to begin with, but that's also
true for other mechanisms.

This series uses the existing RSEQ user memory to implement it.

Changes vs. V5:

   - Rebase on v6.19-rc1

   - Fold typo fixes - Sebastian

   - Switch to syscall number 471

The series is based on v6.19-rc1 and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice

Thanks,

	tglx

