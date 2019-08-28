Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B49A0704
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfH1QND (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 12:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1QND (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Aug 2019 12:13:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CFDF20828;
        Wed, 28 Aug 2019 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567008781;
        bh=HqrBhiKqWjQX4dFN5T5Ap5MOVi6uLuKfUH92vCuqnNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1/TPQxrt7DwtjZiUnrv0BZtkBuwtARMu5FWDI7sbTL2SU85mZvnW5ZKiFNruw3zx
         dWWtwECcxxvT0qxLYtxsga2Q8S02Gbb2ruLMnrMiXBhg9pNjF+lgT83m+kK2RXe2MZ
         +ftcWYRVbg36kpNPKLOeHEP8gC50rXFHpqOm8v7c=
Date:   Wed, 28 Aug 2019 17:12:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] Fix TLB invalidation on arm64
Message-ID: <20190828161256.uevoohval4sko24m@willie-the-truck>
References: <20190827131818.14724-1-will@kernel.org>
 <1566947104.2uma6s0pl1.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566947104.2uma6s0pl1.astroid@bobo.none>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

On Wed, Aug 28, 2019 at 10:35:24AM +1000, Nicholas Piggin wrote:
> Will Deacon's on August 27, 2019 11:18 pm:
> > So far, so good, but the final piece of the puzzle isn't quite so rosy.
> > 
> > *** Other architecture maintainers -- start here! ***
> > 
> > In the case that one CPU maps a page and then sets a flag to tell another
> > CPU:
> > 
> > 	CPU 0
> > 	-----
> > 
> > 	MOV	X0, <valid pte>
> > 	STR	X0, [Xptep]	// Store new PTE to page table
> > 	DSB	ISHST
> > 	ISB
> > 	MOV	X1, #1
> > 	STR	X1, [Xflag]	// Set the flag
> > 
> > 	CPU 1
> > 	-----
> > 
> > loop:	LDAR	X0, [Xflag]	// Poll flag with Acquire semantics
> > 	CBZ	X0, loop
> > 	LDR	X1, [X2]	// Translates using the new PTE
> > 
> > then the final load on CPU 1 can raise a translation fault for the same
> > reasons as mentioned at the start of this description.
> 
> powerpc's ptesync instruction is defined to order MMU memory accesses on
> all other CPUs. ptesync does not go out to the fabric though. How does
> it work then?
> 
> Because the MMU coherency problem (at least we have) is not that the
> load will begin to "partially" execute ahead of the store, enough to
> kick off a table walk that goes ahead of the store, but not so much
> that it violates the regular CPU barriers. It's just that the loads
> from the MMU don't participate in the LSU pipeline, they don't snoop
> the store queues aren't inserted into load queues so the regular
> memory barrier instructions won't see stores from other threads cuasing
> ordering violations.
> 
> In your first example, if powerpc just has a normal memory barrier
> there instead of a ptesync, it could all execute completely
> non-speculatively and in-order but still cause a fault, because the
> table walker's loads didn't see the store in the store queue.

Ah, so I think this is where our DSB comes in, as opposed to our usual
DMB. DMB provides ordering guarantees and is generally the only barrier
instruction you need for shared memory communication. DSB, on the other
hand, has additional properties such as making page-table updates visible
to the table walker and completing pending TLB invalidation.

So in practice, DSB is likely to drain the store buffer to ensure that
pending page-table writes are visible at L1, which is coherent with all
CPUs (and their page-table walkers).

> From the other side of the fabric you have no such problem. The table
> walker is cache coherent apart from the local stores, so we don't need a 
> special barrier on the other side. That's why ptesync doesn't broadcast.

Curious: but do you need to do anything extra to take into account
instruction fetch on remote CPUs if you're mapping an executable page?
We added an IPI to flush_icache_range() in 3b8c9f1cdfc5 to handle this,
because our broadcast I-cache maintenance doesn't force a pipeline flush
for remote CPUs (and may even execute as a NOP on recent cores).

> I would be surprised if ARM's issue is different, but interested to 
> hear if it is.

If you take the four scenarios of Map/Unmap for the UP/SMP cases:

	Map+UP		// Some sort of fence instruction (DSB;ISB/ptesync)
	Map+SMP		// Same as above
	Unmap+UP	// Local TLB invalidation
	Unmap+SMP	// Broadcast TLB invalidation

then the most interesting case is Map+SMP, where one CPU transitions a PTE
from invalid to valid and executes its DSB;ISB/PTESYNC sequence without
affecting the remote CPU. That's what I'm trying to get at in my example
below:

> > 	CPU 0				CPU 1
> > 	-----				-----
> > 	spin_lock(&lock);		spin_lock(&lock);
> > 	set_fixmap(0, paddr, prot);	if (mapped)
> > 	mapped = true;				foo = *fix_to_virt(0);
> > 	spin_unlock(&lock);		spin_unlock(&lock);
> > 
> > could fault.
> 
> This is kind of a different issue, or part of a wider one at least.
> Consider speculative execution more generally, any branch mispredict can 
> send us off to crazy town executing instructions using nonsense register
> values. CPU0 does not have to be in the picture, or any kernel page 
> table modification at all, CPU1 alone will be doing speculative loads 
> wildly all over the kernel address space and trying to access pages with
> no pte.
> 
> Yet we don't have to flush TLB when creating a new kernel mapping, and
> we don't get spurious kernel faults. The page table walker won't
> install negative entries, at least not "architectural" i.e., that cause
> faults and require flushing. My guess is ARM is similar, or you would 
> have seen bigger problems by now?

Right, we don't allow negative (invalid) entries to be cached in the TLB,
but CPUs can effectively cache the result of a translation for a load/store
instruction whilst that instruction flows down the pipe after its virtual
address is known. /That/ caching is not restricted to valid translations.
For example, if we just take a simple message passing example where we have
two global variables: a 'mapped' flag (initialised to zero) and a pointer
(initialised to point at a page that is not yet mapped):

[please excuse the mess I've made of your assembly language]

	CPU 0

	// Set PTE which maps the page pointed to by pointer
	stw	r5, 0(r4)
	ptesync
	lwsync

	// Set 'mapped' flag to 1
	li	r9, 1
	stb	r9, 0(r3)


	CPU 1

	// Poll for 'mapped' flag to be set
loop:	lbz	r9, 0(r3)
	lwsync
	cmpdi	cr7, r0, 0
	beq	cr7, loop

	// Dereference pointer
	lwz	r4, 0(r5)


So in this example, I think it's surprising that CPU 1's dereference of
'pointer' can fault. The way this happens on arm64 is that CPU 1 can
translate the 'pointer' dereference before the load of the 'mapped' flag has
returned its data. The walker may come back with a fault, but then if the
flag data later comes back as 1, the fault will be taken when the lwz
commits. In other words, translation table walks can occur out-of-order
with respect to the accesses they are translating for, even in the presence
of memory barriers.

In practice, I think this kind of code sequence is unusual and triggering
the problem relies on CPU 1 knowing the virtual address it's going to
dereference before it's actually mapped. However, this could conceivably
happen with the fixmap and possibly also if the page-table itself was
being written concurrently using cmpxchg(), in which case you might use
the actual pte value in the same way as the 'mapped' flag above.

But yes, adding the spurious fault handler is belt and braces, which is
why I've kept a WARN_RATELIMIT() in there if it ever triggers.

> If you have CPU0 doing a ro->rw upgrade on a kernel PTE, then it may
> be possible another CPU1 would speculatively install a ro TLB and then
> spurious fault on it when attempting to store to it. But no amount of
> barriers would help because CPU1 could have picked up that TLB any time
> in the past.

Transitioning from ro->rw requires TLB invalidation, and so that falls
into the Unmap+SMP combination which I'm not worried about because it
doesn't pose a problem for us.

Will
