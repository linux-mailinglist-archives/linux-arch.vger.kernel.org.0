Return-Path: <linux-arch+bounces-12845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CAB09592
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 22:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21967A5257
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608B1EF091;
	Thu, 17 Jul 2025 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qYCc5Pq8"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6520FAB6;
	Thu, 17 Jul 2025 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752783321; cv=none; b=X/V1ksPzHcUjUOHrMfCPtvtPUquqN6Gk4nPJua3AV0qlbuL+BIIIgffJ0ZNfg4VnTk9HHacNDZKgHkP1iefyNcO3iKEBMFwjl3wRxDJguftAk5ouWyhhQvPTAOLJks7jgE2neARHvSrYQTJI7eP77JTNE0dwCACg/rosfV4aMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752783321; c=relaxed/simple;
	bh=orGo+e6PmYRc0yhWBvx1j4JissPIl+skfAa2q8N5kA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lwSJuI0uAhR+b6PT/HeVK5cilLlii/+FzBe/dF0qaMvIewnrp5VL7wCdmk8gxZ0LH8UsuTWJNi9TzdjkzvgtDJpeRRAz9/cMBPMpHci4V6l9iPnsHZyXBnaIxk9rksvMOo3ZYYNE1o2WBAAa+/aOfFJBHadTWP6sVJEumn9Qz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qYCc5Pq8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EAA3C403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752783319; bh=JyCg4buwTgeSf92B/ckI/zvTVv0LR8OvvXEMHW9FLS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qYCc5Pq80L6NNEBj2nIkMRSfXwRNZVFA142TIKS71oO93QeMrUiwUaGDZ/y7nfxfx
	 +90gEWFUHF12P+VtJRq1VQ2M0/Oja9691zPeOzeF231p7EhN9jqjSl4ngmWxWAP1+3
	 FMGh3GIAtNSGzQDpkZEo0p88oolcTwiDszuxwRW8R0di9EOWUDPd7h7I0Z9oYPMY7n
	 VK0T1VmZQCfIsfH2pQfbU1E19FiXStyvhtDqMYJlM9RjxTy/B6Lz8EUkgWe6xsMiHm
	 Io5WHV/mpecywRV8aiQDXNeywsfh6aSr6nDggpO3XQMZBkz3k7UIl9q81huOsI+AxG
	 E8tNUWD+HFvxQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EAA3C403E1;
	Thu, 17 Jul 2025 20:15:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux RCU <rcu@vger.kernel.org>, Linux CPU
 Architectures Development <linux-arch@vger.kernel.org>, Linux LKMM
 <lkmm@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin
 <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave
 <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira
 Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Mark
 Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, Waiman
 Long <longman@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Bagas
 Sanjaya <bagasdotme@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Tejun Heo <tj@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Xavier <xavier_qy@163.com>, Randy Dunlap
 <rdunlap@infradead.org>, Maarten Lankhorst <dev@lankhorst.se>, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/4] Convert atomic_*.txt and memory-barriers.txt to reST
In-Reply-To: <878qknc56f.fsf@trenco.lwn.net>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
 <878qknc56f.fsf@trenco.lwn.net>
Date: Thu, 17 Jul 2025 14:15:18 -0600
Message-ID: <87freua815.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
>> Atomic types, atomic bitops, and memory barriers docs are included in kernel
>> docs build since commit e40573a43d163a ("docs: put atomic*.txt and
>> memory-barriers.txt into the core-api book") as a wrapper stub for
>> corresponding uncoverted txt docs. Let's turn them into full-fledged reST docs. 
>
> Did it occur to you to look at the changelog for the commit you cite,
> which explains why those documents are handled the way they are...?

I'm sorry, that caught me at the wrong time, and I was rather more harsh
than I should have been.  I should not have responded that way.

For future reference, though, when somebody has gone out of their way to
accomplish a task in a specific way, there usually *is* a reason for it.
If you can't find that reason, the best thing to do is usually to ask.

Thanks,

jon

