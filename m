Return-Path: <linux-arch+bounces-12832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6608B08B68
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0184EA4160D
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B08529E0EA;
	Thu, 17 Jul 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZ81kXZK"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C629C33E;
	Thu, 17 Jul 2025 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749778; cv=none; b=gy/SknQRBKp1K650McLbIMRmgAl8ec1VCgoN7+xMy4iJDklLVegWZFTbMugxAm/7Z1tSnk1aSk4j+9xGzPhSwgs8ZZYPRiMaUQjYUvwu31JqKKi9cx8p6O7Y2n2qDmb9LD090LvRdjJ3X04y8s0WX2OtEJokCa2r8yLq6wSxgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749778; c=relaxed/simple;
	bh=3M/AOQVTLSDh5r3YKRTNFCJGSOna/TBA4qCj/m7bPAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLRmZLMU1ZQp9epqMpExdftFWe9lqIwMcT6g1gIxse0QgDu/9D7L3KK2Up5O2sgLn941xMv1WmawlZXE3JTVmbl6QMX3461I0ws25Qa2H16ivtgawaPVoD1/EToSQ/DO4OV1YQ04tCH7w3S51S7a0CFiV+SJCxCWNHNTGgmE6iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cZ81kXZK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BmmpUxNUC6XMNwTNVZDcW7v4Pq1RnOf8oWukxWYtaoU=; b=cZ81kXZKAfh8nI8K2/i7JPNtlU
	q4+HoNdJwzvH6Rl1w/cf4hP1K9k1Ga+RvuWN3pPd9V0EypsX2RtJpLBtKXE9vWXh84dZNONrlkIJp
	2Pi1Td3J1hDV3Z3HENRw1wOKcPThj4J7+GOIPnLlW2Q3eu+tJbHNp8Wxne64+Z9kVxCgQKvm/Su89
	yUNnrNadjFWvecppjK2BFkTyE4J1f2tNRIKzuxg/0FPDwk0ppivY2q387tRbl6uErbXLUKlYB2nfP
	gSiOv6Gsp04WmUlvkLS9PfiDj8QeVvGB+ZaOJYKbco6eZILxUG4JHLFqOPQ497wyKIaTHe8Xbxqhw
	h0cvhmRg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucMHM-0000000AGIF-0Owe;
	Thu, 17 Jul 2025 10:55:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40C35300186; Thu, 17 Jul 2025 12:55:54 +0200 (CEST)
Date: Thu, 17 Jul 2025 12:55:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>,
	Linux CPU Architectures Development <linux-arch@vger.kernel.org>,
	Linux LKMM <lkmm@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Dan Williams <dan.j.williams@intel.com>, Xavier <xavier_qy@163.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/4] Convert atomic_*.txt and memory-barriers.txt to reST
Message-ID: <20250717105554.GA1479557@noisy.programming.kicks-ass.net>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717080617.35577-1-bagasdotme@gmail.com>

On Thu, Jul 17, 2025 at 03:06:13PM +0700, Bagas Sanjaya wrote:
> Atomic types, atomic bitops, and memory barriers docs are included in kernel
> docs build since commit e40573a43d163a ("docs: put atomic*.txt and
> memory-barriers.txt into the core-api book") as a wrapper stub for
> corresponding uncoverted txt docs. Let's turn them into full-fledged reST docs. 
> 
> Bagas Sanjaya (4):
>   Documentation: memory-barriers: Convert to reST format
>   Documentation: atomic_bitops: Convert to reST format
>   Documentation: atomic_t: Convert to reST format
>   Documentation: atomic_bitops, atomic_t, memory-barriers: Link to
>     newly-converted docs

NAK

If these are merged I will no longer touch / update these files.

