Return-Path: <linux-arch+bounces-12352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8073ADB3CC
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jun 2025 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5503E3A1C81
	for <lists+linux-arch@lfdr.de>; Mon, 16 Jun 2025 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8120A5EA;
	Mon, 16 Jun 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgCS+wpw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01A1F37A1;
	Mon, 16 Jun 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083835; cv=none; b=BboZrGNL0nmyuNeBsnqYNjrEevNXfTk2mrhDm+d6x3ySgV0FBIInuEWEI1DmLjh0lGmLzmSYaB9tDy3JKnXcNnuG9chdAyuDoIW2YLLv/GaU2AwWumhj63bYOOxaEQpJ/tKIYa1n6OlNrKbwLkXFVbbV8KUeJAjH81LrrSZNqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083835; c=relaxed/simple;
	bh=SjeTU9CRzCMCuDl9wQmBCaedzKuW1zjtaXm4rqznbAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnhwZC9a3szutmdSh757rm++q9ffbVmPlVmN18yx0mlyxnx6OZs+a4ludGfq4bFtwVt7hvYg+hdI1/7Igv/5zrlic0uiFimnOh4+6bONMXryiqJMf1Qa0IkvGvnWn/8psSBgtAQJmHY3iBDobn5J7R+FJ6N7qXFNNoH/1/NBygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgCS+wpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C096FC4CEED;
	Mon, 16 Jun 2025 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083835;
	bh=SjeTU9CRzCMCuDl9wQmBCaedzKuW1zjtaXm4rqznbAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgCS+wpwykXbD+wISZIhwinLdT9LbwpOlU+NO2xJh/ALv+fjV+msvHzGmUhnKNlUC
	 mATBSJHVp5aVzUq3saBHhi/3KUU6ptQWyuWwAhgOrOGvqt7r6LJ64cPW3fMorLEXNg
	 NVZWFFLCByrVZwiwRf2C8xhvJ+unmcT85nTTXtOdfbHkaEQTjJoyU4CNbgY2tGDNUB
	 8qTWKdGVxA+60fe/dlxGhyIXVmUXUQiE5ZQ5IhIyoZrvzk4ItaNc1awqH55erHakYL
	 siudZXDOKOG56JbBxWRcJK4Z8DxBH6wex75lZUiUOgpsz8cTjtGLb9bBDlKdb4qmOM
	 LnziRCLMay/gw==
Date: Mon, 16 Jun 2025 15:23:48 +0100
From: Will Deacon <will@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Haas <t.haas@tu-bs.de>, Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <20250616142347.GA17781@willie-the-truck>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jun 13, 2025 at 09:55:01AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 12, 2025 at 04:55:28PM +0200, Thomas Haas wrote:
> > We have been taking a look if mixed-size accesses (MSA) can affect the
> > correctness of qspinlock.
> > We are focusing on aarch64 which is the only memory model with MSA support
> > [1].
> > For this we extended the dartagnan [2] tool to support MSA and now it
> > reports liveness, synchronization, and mutex issues.
> > Notice that we did something similar in the past for LKMM, but we were
> > ignoring MSA [3].
> > 
> > The culprit of all these issues is that atomicity of single load
> > instructions is not guaranteed in the presence of smaller-sized stores
> > (observed on real hardware according to [1] and Fig. 21/22)
> > Consider the following pseudo code:
> > 
> >     int16 old = xchg16_rlx(&lock, 42);
> >     int32 l = load32_acq(&lock);
> > 
> > Then the hardware can treat the code as (likely due to store-forwarding)
> > 
> >     int16 old = xchg16_rlx(&lock, 42);
> >     int16 l1 = load16_acq(&lock);
> >     int16 l2 = load16_acq(&lock + 2); // Assuming byte-precise pointer
> > arithmetic
> > 
> > and reorder it to
> > 
> >     int16 l2 = load16_acq(&lock + 2);
> >     int16 old = xchg16_rlx(&lock, 42);
> >     int16 l1 = load16_acq(&lock);
> > 
> > Now another thread can overwrite "lock" in between the first two accesses so
> > that the original l (l1 and l2) ends up containing
> > parts of a lock value that is older than what the xchg observed.
> 
> Oops :-(
> 
> (snip the excellent details)
> 
> > ### Solutions
> > 
> > The problematic executions rely on the fact that T2 can move half of its
> > load operation (1) to before the xchg_tail (3).
> > Preventing this reordering solves all issues. Possible solutions are:
> >     - make the xchg_tail full-sized (i.e, also touch lock/pending bits).
> >       Note that if the kernel is configured with >= 16k cpus, then the tail
> > becomes larger than 16 bits and needs to be encoded in parts of the pending
> > byte as well.
> >       In this case, the kernel makes a full-sized (32-bit) access for the
> > xchg. So the above bugs are only present in the < 16k cpus setting.
> 
> Right, but that is the more expensive option for some.
> 
> >     - make the xchg_tail an acquire operation.
> >     - make the xchg_tail a release operation (this is an odd solution by
> > itself but works for aarch64 because it preserves REL->ACQ ordering). In
> > this case, maybe the preceding "smp_wmb()" can be removed.
> 
> I think I prefer this one, it move a barrier, not really adding
> additional overhead. Will?

I'm half inclined to think that the Arm memory model should be tightened
here; I can raise that with Arm and see what they say.

Although the cited paper does give examples of store-forwarding from a
narrow store to a wider load, the case in qspinlock is further
constrained by having the store come from an atomic rmw and the load
having acquire semantics. Setting aside the MSA part, that specific case
_is_ ordered in the Arm memory model (and C++ release sequences rely on
it iirc), so it's fair to say that Arm CPUs don't permit forwarding from
an atomic rmw to an acquire load.

Given that, I don't see how this is going to occur in practice.

Will

