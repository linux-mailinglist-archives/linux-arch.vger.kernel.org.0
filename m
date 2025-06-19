Return-Path: <linux-arch+bounces-12395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D5AE05DA
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22FF16836F
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1F23D2A5;
	Thu, 19 Jun 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swYDkP7J"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91F22C35D;
	Thu, 19 Jun 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336209; cv=none; b=XxHVrAMQbXQ/THVSQA/CIbr+Q3OakkLvQnjzd0MyN25mSDmHs6D+4TSheB4XkcUSE2ie1hpwNAWWmX+hxQZMux2ZCJjvX8fscpWbmlArLwKw4myKbQDgF5F8G3d9QOpJ9aFAdnPmUHTP0SnyfSlXPRqmYK86fwyZBKVfka7Ni48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336209; c=relaxed/simple;
	bh=+tfprZLkDpyF3dYneGjV6I0yjtC8Y9weI88akNDjiLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/E+ktufNkfMPyUJUG0vGjiutXC3iDAQarSrD3RnWb3cmYg9Q2mUNTHG/Kr3sQfpyLkvRB7V8Yiq+NZ4Z4p33zvORK55Upl5i/+rDTeQxSMGGhutledxTqHVbI62eGN8aik8AJgxRG4ElU1pnTb24OcrcWGE4ZpiIDnHUQ7k/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swYDkP7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E416C4CEEA;
	Thu, 19 Jun 2025 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750336209;
	bh=+tfprZLkDpyF3dYneGjV6I0yjtC8Y9weI88akNDjiLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swYDkP7J++md93+X4jTkf568pg2I0xO/GqQE5qbjypL0+uysWbsp4M6uZkxKqXqXF
	 eEIMnRTIDt95jmJsUBjvWm21wjqK+KlgBMq5vG+6mpgPH//9LSgx4EUPr3LZKZLzb+
	 jgdhCQEXXLtmudxUWgZi03+w3Z6GuGfgfSlZvmoOB+SN3DEveXwUZNYs1Zs95RlqqE
	 pK/00CoEt/112GBH0NijKXUNsp/RKAQzr1B0gh4uofJhe61sJ4k7temJ85GI69NDKf
	 RcTQ44R/zvnBjOdywSiZ2baXULQj7Qi+oZvD+moSGMI6mypzfWwMvW44YSu9/OuLNU
	 Yr/6zb1KFiovg==
Date: Thu, 19 Jun 2025 13:30:02 +0100
From: Will Deacon <will@kernel.org>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Thomas Haas <t.haas@tu-bs.de>, Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
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
	lkmm@lists.linux.dev, jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <20250619123002.GC21372@willie-the-truck>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <20250616142347.GA17781@willie-the-truck>
 <d66d0351-b523-40da-ae47-8b06f37bf3b6@tu-bs.de>
 <2b11f09d-b938-4a8e-8c3a-c39b6fea2b21@huaweicloud.com>
 <20250617141704.GB19021@willie-the-truck>
 <7a20b873-3c26-4a52-b118-c816ede7298d@tu-bs.de>
 <218abf15-b4ed-4d13-9541-aab975bd3835@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <218abf15-b4ed-4d13-9541-aab975bd3835@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jun 17, 2025 at 09:00:30PM +0200, Hernan Ponce de Leon wrote:
> On 6/17/2025 4:23 PM, Thomas Haas wrote:
> > 
> > 
> > On 17.06.25 16:17, Will Deacon wrote:
> > > On Tue, Jun 17, 2025 at 10:42:04AM +0200, Hernan Ponce de Leon wrote:
> > > > On 6/17/2025 8:19 AM, Thomas Haas wrote:
> > > > > On 16.06.25 16:23, Will Deacon wrote:
> > > > > > I'm half inclined to think that the Arm memory model
> > > > > > should be tightened
> > > > > > here; I can raise that with Arm and see what they say.
> > > > > > 
> > > > > > Although the cited paper does give examples of store-forwarding from a
> > > > > > narrow store to a wider load, the case in qspinlock is further
> > > > > > constrained by having the store come from an atomic rmw and the load
> > > > > > having acquire semantics. Setting aside the MSA part,
> > > > > > that specific case
> > > > > > _is_ ordered in the Arm memory model (and C++ release
> > > > > > sequences rely on
> > > > > > it iirc), so it's fair to say that Arm CPUs don't permit
> > > > > > forwarding from
> > > > > > an atomic rmw to an acquire load.
> > > > > > 
> > > > > > Given that, I don't see how this is going to occur in practice.
> > > > > 
> > > > > You are probably right. The ARM model's atomic-ordered-before relation
> > > > > 
> > > > >        let aob = rmw | [range(rmw)]; lrs; [A | Q]
> > > > > 
> > > > > clearly orders the rmw-store with subsequent acquire loads
> > > > > (lrs = local-
> > > > > read-successor, A = acquire).
> > > > > If we treat this relation (at least the second part) as a "global
> > > > > ordering" and extend it by "si" (same-instruction), then the
> > > > > problematic
> > > > > reordering under MSA should be gone.
> > > > > I quickly ran Dartagnan on the MSA litmus tests with this change to the
> > > > > ARM model and all the tests still pass.
> > > > 
> > > > Even with this change I still get violations (both safety and
> > > > termination)
> > > > for qspinlock with dartagnan.
> > > 
> > > Please can you be more specific about the problems you see?
> > 
> > I talked to Hernán personally and it turned out that he used the generic
> > implementation of smp_cond_acquire (not sure if the name is correct)
> > which uses a relaxed load followed by a barrier. In that case, replacing
> > aob by aob;si does not change anything.
> > Indeed, even in the reported problem we used the generic implementation
> > (I was unaware of this), though it is easy to check that changing the
> > relaxed load to acquire does not give sufficient orderings.
> 
> Yes, my bad. I was using the generic header rather than the aarch64 specific
> one and then the changes to the model were having not effect (as they
> should).
> 
> Now I am using the aarch64 specific ones and I can confirm dartagnan still
> reports the violations with the current model and making the change proposed
> by Thomas (adding ;si just to the second part seems to be enough) indeed
> removes all violations.

That's great! Thanks for working together to get to the bottom of it. I
was worried that this was the tip of the iceberg.

I'll try to follow-up with Arm to see if that ';si' addition is an
acceptable to atomic-ordered before. If not, we'll absorb the smp_wmb()
into xchg_release() with a fat comment about RCsc and mixed-size
accesses.

Will

