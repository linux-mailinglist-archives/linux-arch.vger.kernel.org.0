Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04AD488795
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 04:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiAID7N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 22:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiAID7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 22:59:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D058C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 19:59:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 063DAB80AE6
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 03:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC80C36AF2;
        Sun,  9 Jan 2022 03:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641700747;
        bh=+L7G1MBtRoEP4p+JQL01btQZhmstBgPb4+y549PQS8s=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=qeslNJnRLa6Z1KP0yv4IadzEOPBpGaA9Cw69QQSOsbXXN1+VLSQWdjG0YqDrZfyIB
         99+tdhq9JY9anNB/URqiXpKCRhBsEMbtMpbWOnZQV6xEobpCzkXPlFlQK55N6Z5ewY
         p5x+/xRnDmK1n6aWcSITBBpz7sleJt2HgowNyCHryMp8xhs2aMuw+69B6b2/3hmcTi
         b15v1EyCuJ3y0q6r3DDwClAJIuB/OTUhBsg51vkHh7z9bdB5zjjsrRlLIaZvKFbuBk
         q9s9b8Ig9wDO4k3mw1Pf0Gs0d6bHps9+mcdmwrasp6PaLxwJhmF0nUyVP4NKrFWHfJ
         gyOF5QufG+svw==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 082BC27C0054;
        Sat,  8 Jan 2022 22:59:05 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sat, 08 Jan 2022 22:59:06 -0500
X-ME-Sender: <xms:iF3aYaL0cXC3Y3VQaeyrtRLBRsq3nRBsX1kt4w_xsp3dk0_14IzMQg>
    <xme:iF3aYSLRnIuhHCCCwlEu4MkR5k-H48X5P12zqiNL5DJU73ndjjQr0L42_ikSfaGua
    Bw9PvOE8LwPmx445Qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegiedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpefhlefhudegtedvhfefueevvedtgeeukefhffehtefftdelvedthedt
    iedvueevudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuth
    hopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:iF3aYavvYZRFTgOcsH1f5v54RsyTiB2HQywDNDEsTKP9sn5sHN4BBg>
    <xmx:iF3aYfYZjqsljBN9fsnv55hQFKVZstixqGs_sEDQ6kHfMiLmzVbwjA>
    <xmx:iF3aYRbW3zUQY8iiRwJvVwMuPx7MOB_8H1fbFw2GOZ02_lI5DE0BuA>
    <xmx:iV3aYXz337AqGvV6-NPprxSeMMoWC3eFpLj9HyTZpm-GiDVjcT6NtiY98GeD2B6P>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1FC7821E006E; Sat,  8 Jan 2022 22:59:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
In-Reply-To: <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
 <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
Date:   Sat, 08 Jan 2022 19:58:39 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Anton Blanchard" <anton@ozlabs.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@ozlabs.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rik van Riel" <riel@surriel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Sat, Jan 8, 2022, at 4:53 PM, Linus Torvalds wrote:
> [ Let's try this again, without the html crud this time. Apologies to
> the people who see this reply twice ]
>
> On Sat, Jan 8, 2022 at 2:04 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> So this requires that all architectures actually walk all relevant
>> CPUs to see if an IPI is needed and send that IPI. On architectures
>> that actually need an IPI anyway (x86 bare metal, powerpc (I think)
>> and others, fine. But on architectures with a broadcast-to-all-CPUs
>> flush (ARM64 IIUC), then the extra IPI will be much much slower than a
>> simple load-acquire in a loop.
>
> ... hmm. How about a hybrid scheme?
>
>  (a) architectures that already require that IPI anyway for TLB
> invalidation (ie x86, but others too), just make the rule be that the
> TLB flush by exit_mmap() get rid of any lazy TLB mm references. Which
> they already do.
>
>  (b) architectures like arm64 that do hw-assisted TLB shootdown will
> have an ASID allocator model, and what you do is to use that to either
>     (b') increment/decrement the mm_count at mm ASID allocation/freeing time
>     (b'') use the existing ASID tracking data to find the CPU's that
> have that ASID
>
>  (c) can you really imagine hardware TLB shootdown without ASID
> allocation? That doesn't seem to make sense. But if it exists, maybe
> that kind of crazy case would do the percpu array walking.
>

So I can go over a handful of TLB flush schemes:

1. x86 bare metal.  As noted, just plain shootdown would work.  (Unless we switch to inexact mm_cpumask() tracking, which might be enough of a win that it's worth it.)  Right now, "ASID" (i.e. PCID, thanks Intel) is allocated per cpu.  They are never explicitly freed -- they just expire off a percpu LRU.  The data structures have no idea whether an mm still exists -- instead they track mm->context.ctx_id, which is 64 bits and never reused.

2. x86 paravirt.  This is just like bare metal except there's a hypercall to flush a specific target cpu.  (I think this is mutually exclusive with PCID, but I'm not sure.  I haven't looked that hard.  I'm not sure exactly what is implemented right now.  It could be an operation to flush (cpu, pcid), but that gets awkward for reasons that aren't too relevant to this discussion.)  In this model, the exit_mmap() shootdown would either need to switch to a non-paravirt flush or we need a fancy mm_count solution of some sort.

3. Hypothetical better x86.  AMD has INVLPGB, which is almost useless right now.  But it's *so* close to being very useful, and I've asked engineers at AMD and Intel to improve this.  Specifically, I want PCID to be widened to 64 bits.  (This would, as I understand it, not affect the TLB hardware at all.  It would affect the tiny table that sits in front of the real PCID and maintains the illusion that PCID is 12 bits, and it would affect the MOV CR3 instruction.  The latter makes it complicated.)  And INVLPGB would invalidate a given 64-bit PCID system-wide.  In this model, there would be no such thing as freeing an ASID.  So I think we would want something very much like this patch.

4. ARM64.  I only barely understand it, but I think it's an intermediate scheme with ASIDs that are wide enough to be useful but narrow enough to run out on occasion.  I don't think they're tracked -- I think the whole world just gets invalidated when they overflow.  I could be wrong.

In any event, ASID lifetimes aren't a magic solution -- how do we know when to expire an ASID?  Presumably it would be when an mm is fully freed (__mmdrop), which gets us right back to square one.

In any case, what I particularly like about my patch is that, while it's subtle, it's subtle just once.  I think it can handle all the interesting arch cases by merely redefining for_each_possible_lazymm_cpu() to do the right thing.

> (Honesty in advertising: I don't know the arm64 ASID code - I used to
> know the old alpha version I wrote in a previous lifetime - but afaik
> any ASID allocator has to be able to track CPU's that have a
> particular ASID in use and be able to invalidate it).
>
> Hmm. The x86 maintainers are on this thread, but they aren't even the
> problem. Adding Catalin and Will to this, I think they should know
> if/how this would fit with the arm64 ASID allocator.
>

Well, I am an x86 mm maintainer, and there is definitely a performance problem on large x86 systems right now. :)

> Will/Catalin, background here:
>
>    
> https://lore.kernel.org/all/CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com/
>
> for my objection to that special "keep non-refcounted magic per-cpu
> pointer to lazy tlb mm".
>
>            Linus

--Andy
