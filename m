Return-Path: <linux-arch+bounces-12338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C474AAD850F
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 09:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AD3164287
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579562DA745;
	Fri, 13 Jun 2025 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iHSviwGD"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13CD2DA747;
	Fri, 13 Jun 2025 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801309; cv=none; b=jmeXCA5sc4qeYEvmGJyQj3MPavA0nlBP/pH2tr215b5cI5babp6MpNXbwYZDoKGQKIf2Lio2KyIayHw3xycFeNqsGw0P//sYGmqyZqn11PuAIm4yYmV8Gi+McA8sgd778alBG/pC0dXhZFoTclOzxTKvV0T9fczARjlq4wgepZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801309; c=relaxed/simple;
	bh=bbP+XtmImDmyo1O60/+0zsZ6h9lo1pg4BmbooaslguI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8BQYfMfoS39fZ/fZzjG9qhRDR4fzTSGPK+YWTYHQeTJioVKKEoG8dSgjZfuWR6oV6sUJZUv3dUWuSBirWjYYYuPZkqQCreykhqUWlyNxkSzQfU3gZAwCBAa4sup5kdKfgI8t6MMMCr0yxAOnYCyDEqg+qyKTtSFeyp+CaLifRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iHSviwGD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qvLSHHM5imsyzb1NQRe9PrbIn9fT9/7q6eeM8YHTaI4=; b=iHSviwGDuQcN4JYdKqCedz7pFP
	OaH4MXef62Q6ydksJvZVqxmA2hJBgB3AXrhcKQOM4Ap5DQXId2SQwqyTEtFrmtQx9KZbgfiZx3Ddi
	cIrflQ2OK334Vy4gpxSW27CFD/A63YPd6GL7BYp5nDALknyAG5MrorbdKq7h2GOYe4zbMBGORTDuU
	SIUuJO4PPQzolf/w5b6cgJMsybxeUil+ajCGMfm06LhkSsJD6vxuEfnaQqNQb3ZgH1ggXIdXiZScn
	wc7/px7KpqihiEPui0etXAB8V7SU8odHL1CD0gDR4jHoJ1mBL2hYDI7TbVZ2ntijcIgQLaz4XC8DW
	eSjEJokA==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzFf-00000002uRp-0qaP;
	Fri, 13 Jun 2025 07:55:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 13DF430BC02; Fri, 13 Jun 2025 09:55:01 +0200 (CEST)
Date: Fri, 13 Jun 2025 09:55:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Haas <t.haas@tu-bs.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>

On Thu, Jun 12, 2025 at 04:55:28PM +0200, Thomas Haas wrote:
> We have been taking a look if mixed-size accesses (MSA) can affect the
> correctness of qspinlock.
> We are focusing on aarch64 which is the only memory model with MSA support
> [1].
> For this we extended the dartagnan [2] tool to support MSA and now it
> reports liveness, synchronization, and mutex issues.
> Notice that we did something similar in the past for LKMM, but we were
> ignoring MSA [3].
> 
> The culprit of all these issues is that atomicity of single load
> instructions is not guaranteed in the presence of smaller-sized stores
> (observed on real hardware according to [1] and Fig. 21/22)
> Consider the following pseudo code:
> 
>     int16 old = xchg16_rlx(&lock, 42);
>     int32 l = load32_acq(&lock);
> 
> Then the hardware can treat the code as (likely due to store-forwarding)
> 
>     int16 old = xchg16_rlx(&lock, 42);
>     int16 l1 = load16_acq(&lock);
>     int16 l2 = load16_acq(&lock + 2); // Assuming byte-precise pointer
> arithmetic
> 
> and reorder it to
> 
>     int16 l2 = load16_acq(&lock + 2);
>     int16 old = xchg16_rlx(&lock, 42);
>     int16 l1 = load16_acq(&lock);
> 
> Now another thread can overwrite "lock" in between the first two accesses so
> that the original l (l1 and l2) ends up containing
> parts of a lock value that is older than what the xchg observed.

Oops :-(

(snip the excellent details)

> ### Solutions
> 
> The problematic executions rely on the fact that T2 can move half of its
> load operation (1) to before the xchg_tail (3).
> Preventing this reordering solves all issues. Possible solutions are:
>     - make the xchg_tail full-sized (i.e, also touch lock/pending bits).
>       Note that if the kernel is configured with >= 16k cpus, then the tail
> becomes larger than 16 bits and needs to be encoded in parts of the pending
> byte as well.
>       In this case, the kernel makes a full-sized (32-bit) access for the
> xchg. So the above bugs are only present in the < 16k cpus setting.

Right, but that is the more expensive option for some.

>     - make the xchg_tail an acquire operation.
>     - make the xchg_tail a release operation (this is an odd solution by
> itself but works for aarch64 because it preserves REL->ACQ ordering). In
> this case, maybe the preceding "smp_wmb()" can be removed.

I think I prefer this one, it move a barrier, not really adding
additional overhead. Will?

>     - put some other read-read barrier between the xchg_tail and the load.
> 
> 
> ### Implications for qspinlock executed on non-ARM architectures.
> 
> Unfortunately, there are no MSA extensions for other hardware memory models,
> so we have to speculate based on whether the problematic reordering is
> permitted if the problematic load was treated as two individual
> instructions.
> It seems Power and RISCV would have no problem reordering the instructions,
> so qspinlock might also break on those architectures.

Power (and RiscV without ZABHA) 'emulate' the short XCHG using a full
word LL/SC and should be good.

But yes, ZABHA might be equally broken.

> TSO, on the other hand, does not permit such reordering. Also, the xchg_tail
> is a rmw operation which acts like a full memory barrier under TSO, so even
> if load-load reordering was permitted, the rmw would prevent this.

Right.

