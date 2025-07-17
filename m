Return-Path: <linux-arch+bounces-12839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10339B08E53
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6BC18942BB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D682EBBBE;
	Thu, 17 Jul 2025 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JmDw+Dkj"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B12EBBB0;
	Thu, 17 Jul 2025 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759248; cv=none; b=MaYYkP6AhzO5CIQ1WBu5uIVVxVYXW1g2wSMP0trN921vTXF8md46nXmO+l3z50pHLE7tW8KA1urcVGGVpBxptk9I0TlzNQbSDlKTn6q1YfH0KDK2fm7NQv2b2lcWRuEJC+zKYvNVj05v13dDLwTz58R4+IL92QdQ1riELFdWX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759248; c=relaxed/simple;
	bh=qyF6AcQjjMFZLje8IOQ87WS6iReSfovpUMWsJYjRghc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A8D1VbCtM9n6kU86HmA5B1ZqKnxYo966vHcmTxUTA5GNDVNGs6jVThB/8aG3Ea8qcssL/gdSf22WIHpQEUS4qu8d7dJfTQkMy+hCJ62ODvImFaNHYy+HmLZakw15FZMPX7reokaAksGpv7jFCmfTEcbClKIx6DOk8rNdcLXaGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JmDw+Dkj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0181F403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752759241; bh=kInJGEeRErYfW6zXowaP+WNNDVN8pRfm9KIQ0doInVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JmDw+DkjX2UBmvYwZDInKCYi2owhdRyxnfQXpuJXaM2KKN4H6RIzQvOOiH2ftAnJL
	 35IkpCeZhh0tiUZPi+WvleXpH+da/JEO4GDiZV9WglnUkkw3ztN8xNHvgmECEGO5pq
	 COWv/MwFwjPRcUx/X2M7z3WgHdp5efeFVXtys2Wx7co9HNWnM31S8EFwZ3crUmhnMY
	 luAWBR116LgkY+CiDnID5XIJ3y0gLO0KqfoCK7Y7ph6w6Xu3M3TDf/VHmwIbtSj5mQ
	 UrREIZHeqwvQyBDKyz/1U40ydizTri1fGC4MB6fI31z80cqIBbiNo6WITsgQiXvMvl
	 oxsfyBLHXqelw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0181F403E1;
	Thu, 17 Jul 2025 13:34:01 +0000 (UTC)
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
In-Reply-To: <20250717080617.35577-1-bagasdotme@gmail.com>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
Date: Thu, 17 Jul 2025 07:34:00 -0600
Message-ID: <878qknc56f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Atomic types, atomic bitops, and memory barriers docs are included in kernel
> docs build since commit e40573a43d163a ("docs: put atomic*.txt and
> memory-barriers.txt into the core-api book") as a wrapper stub for
> corresponding uncoverted txt docs. Let's turn them into full-fledged reST docs. 

Did it occur to you to look at the changelog for the commit you cite,
which explains why those documents are handled the way they are...?

jon

