Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D998A48AB8F
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 11:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348687AbiAKKkE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 05:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349249AbiAKKkE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 05:40:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC3C06173F
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 02:40:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 998C9B819DB
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 10:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606ACC36AE9;
        Tue, 11 Jan 2022 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641897601;
        bh=FrMBVCsT0Kvus803frANc3Qo9Rrs5mzq5iYz8nTzt3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1UBe8q5PcKaU83h04h/iDtc/YV24Ii0YQ06FLMnva4BRm3ACVrINixrcSwCLzJfg
         ybtFTzgSU7X5SfyjMQbrb1co9TX1f3kAklBfGxtNDa8OZ1Rns4bFbVwd8Ic5g1wvY3
         cXMfRaoMQD5v5coG4Pxw4JB6lTxvtCgpJLh4AqsHO2BMbOSsvWPJljae3thhUczNvN
         /R/9DQQx7HWEPFVME8BC9N0sG9s0FkoX4d6K/g0E7Aq5/oCb1ZCverRflM7yW7ou/C
         79DZGqCfFzXgTEa2TTchz/yv/MGaUIHP2aIX/GyAkUILZ6xaRzIV245zHNbmWaTNZ0
         /HhhAWzAwomkA==
Date:   Tue, 11 Jan 2022 10:39:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab
 lazy mms
Message-ID: <20220111103953.GA10037@willie-the-truck>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
 <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
 <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
 <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy, Linus,

On Sun, Jan 09, 2022 at 12:48:42PM -0800, Linus Torvalds wrote:
> On Sun, Jan 9, 2022 at 12:20 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Are you *sure*? The ASID management code on x86 is (as mentioned
> > before) completely unaware of whether an ASID is actually in use
> > anywhere.
> 
> Right.
> 
> But the ASID situation on x86 is very very different, exactly because
> x86 doesn't have cross-CPU TLB invalidates.
> 
> Put another way: x86 TLB hardware is fundamentally per-cpu. As such,
> any ASID management is also per-cpu.
> 
> That's fundamentally not true on arm64.  And that's not some "arm64
> implementation detail". That's fundamental to doing cross-CPU TLB
> invalidates in hardware.
> 
> If your TLB invalidates act across CPU's, then the state they act on
> are also obviously across CPU's.
> 
> So the ASID situation is fundamentally different depending on the
> hardware usage. On x86, TLB's are per-core, and on arm64 they are not,
> and that's reflected in our code too.
> 
> As a result, on x86, each mm has a per-cpu ASID, and there's a small
> array of per-cpu "mm->asid" mappings.
> 
> On arm, each mm has an asid, and it's allocated from a global asid
> space - so there is no need for that "mm->asid" mapping, because the
> asid is there in the mm, and it's shared across cpus.
> 
> That said, I still don't actually know the arm64 ASID management code.

That appears to be a common theme in this thread, so hopefully I can shed
some light on the arm64 side of things:

The CPU supports either 8-bit or 16-bit ASIDs and we require that we don't
have more CPUs than we can represent in the ASID space (well, we WARN in
this case but it's likely to go badly wrong). We reserve ASID 0 for things
like the idmap, so as far as the allocator is concerned ASID 0 is "invalid"
and we rely on this.

As Linus says above, the ASID is per-'mm' and we require that all threads
of an 'mm' use the same ASID at the same time, otherwise the hardware TLB
broadcasting isn't going to work properly because the invalidations are
typically tagged by ASID.

As Andy points out later, this means that we have to reuse ASIDs for
different 'mm's once we have enough of them. We do this using a 64-bit
context ID in mm_context_t, where the lower bits are the ASID for the 'mm'
and the upper bits are a generation count. The ASID allocator keeps an
internal generation count which is incremented whenever we fail to allocate
an ASID and are forced to invalidate them all and start re-allocating. We
assume that the generation count doesn't overflow.

When switching to an 'mm', we check if the generation count held in the
'mm' is behind the allocator's current generation count. If it is, then
we know that the 'mm' needs to be allocated a new ASID. Allocation is
performed with a spinlock held and basically involves a setting a new bit
in the bitmap and updating the 'mm' with the new ASID and current
generation. We don't reclaim ASIDs greedily on 'mm' teardown -- this was
pretty slow when I looked at it in the past.

So far so good, but it gets more complicated when we look at the details of
the overflow handling. Overflow is always detected on the allocation path
with the spinlock held but other CPUs could happily be running other code
(inc. user code) at this point. Therefore, we can't simply invalidate the
TLBs, clear the bitmap and start re-allocating ASIDs because we could end up
with an ASID shared between two running 'mm's, leading to both invalidation
interference but also the potential to hit stale TLB entries allocated after
the invalidation on rollover. We handle this with a couple of per-cpu
variables, 'active_asids' and 'reserved_asids'.

'active_asids' is set to the current ASID in switch_mm() just before
writing the actual TTBR register. On a rollover, the CPU holding the lock
goes through each CPU's 'active_asids' entry, atomic xchg()s it to 0 and
writes the result into the corresponding 'reserved_asids' entry. These
'reserved_asids' are then immediately marked as allocated and a flag is
set for each CPU to indicate that its TLBs are dirty. This allows the
CPU handling the rollover to continue with its allocation without stopping
the world and without broadcasting TLB invalidation; other CPUs will
hit a generation mismatch on their next switch_mm(), notice that they are
running a reserved ASID from an older generation, upgrade the generation
(i.e. keep the same ASID) and then invalidate their local TLB.

So we do have some tracking of which ASIDs are where, but we can't generally
say "is this ASID dirty in the TLBs of this CPU". That also gets more
complicated on some systems where a TLB can be shared between some of the
CPUs (I haven't covered that case above, since I think that this is enough
detail already.)

FWIW, we have a TLA+ model of some of this, which may (or may not) be easier
to follow than my text:

https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/asidalloc.tla

although the syntax is pretty hard going :(

> The thing about TLB flushes is that it's ok to do them spuriously (as
> long as you don't do _too_ many of them and tank performance), so two
> different mm's can have the same hw ASID on two different cores and
> that just makes cross-CPU TLB invalidates too aggressive. You can't
> share an ASID on the _same_ core without flushing in between context
> switches, because then the TLB on that core might be re-used for a
> different mm. So the flushing rules aren't necessarily 100% 1:1 with
> the "in use" rules, and who knows if the arm64 ASID management
> actually ends up just matching what that whole "this lazy TLB is still
> in use on another CPU".

The shared TLBs (Arm calls this "Common-not-private") make this problematic,
as the TLB is no longer necessarily per-core.

> So I don't really know the arm64 situation. And i's possible that lazy
> TLB isn't even worth it on arm64 in the first place.

ASID allocation aside, I think there are a few useful things to point out
for arm64:

	- We only have "local" or "all" TLB invalidation; nothing targetted
	  (and for KVM guests this is always "all").

	- Most mms end up running on more than one CPU (at least, when I
	  last looked at this a fork+exec would end up with the mm having
	  been installed on two CPUs)

	- We don't track mm_cpumask as it showed up as a bottleneck in the
	  past and, because of the earlier points, it wasn't very useful
	  anyway

	- mmgrab() should be fast for us (it's a posted atomic add),
	  although mmdrop() will be slower as it has to return data to
	  check against the count going to zero.

So it doesn't feel like an obvious win to me for us to scan these new hazard
pointers on arm64. At least, I would love to see some numbers if we're going
to make changes here.

Will
