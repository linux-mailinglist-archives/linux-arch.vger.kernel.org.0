Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA3488C3B
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 21:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiAIUUC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 15:20:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55874 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiAIUUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 15:20:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9511760FE1
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 20:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAAFC36AEF;
        Sun,  9 Jan 2022 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641759601;
        bh=7ver5Q0fbRLHrNe3OvsaiHAdy8pr3KMt4fSM4nXVrsQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=W59Y+wWSTooGJOfKudK26FNzSj7JPLHNINKqlWZ9HPoJR1lgO2Qz9H5q1+DDqVj6h
         GLMm4ja7Cskf7P90hvvLiBpiTBvF8088ww0+vB2Ij1DZi0hbuCJCBiXVncRIa11KWC
         FQhxOmei0cqjz0tvKbQosP5t/AT/A+NYTco1ExxR6SvtJoOeJX1QDET5ZGSSjcEtun
         +pGwPGPqvjzBAJTof8SKbaXdFayYkj/5yWIAtRJPI/e8lcQ52AA5xhl6coAQJRent5
         tCBFuYVmNJ30jkpYtlTYwF8t3EVPyi/bMHk8t+xuxhb1RRuGWP4lh/PkaIDYmhUlHA
         kVKeQP6/aOfmg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 00A7727C0054;
        Sun,  9 Jan 2022 15:19:58 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sun, 09 Jan 2022 15:19:59 -0500
X-ME-Sender: <xms:bkPbYSDQ9pbqTLvYwplbrvwS3SpiLcuA3Hke812GyCmlKgr4tzKuAA>
    <xme:bkPbYch5ieuWLMiB57cFHulbm2HgmURlXO4WRf1DiCoGmQDHzMsTgTdmcnVupZr0-
    mOTlTebpKTP0PdQ_CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:bkPbYVnisngOecU35AZf4NCzZ8p-qrjOi2Op6CZrNyA2yaQUvC8Czg>
    <xmx:bkPbYQzCdTj2J7hKIqM5xvBsWRNdFg1aQm_08GZW6U5IGAzew3vKkw>
    <xmx:bkPbYXQrzl2MW2nd-NSQsYKUZATjYGnXJjjoYQQsIR_nG3pj3PSjng>
    <xmx:bkPbYTpQH2U8niUymGdCpqkti5MW4Gb4cnXMkVz7gnmaH8rgyL1eAhdPa67Kr1qP>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3033C21E006E; Sun,  9 Jan 2022 15:19:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
In-Reply-To: <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
 <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
 <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
Date:   Sun, 09 Jan 2022 12:19:31 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
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



On Sat, Jan 8, 2022, at 8:38 PM, Linus Torvalds wrote:
> On Sat, Jan 8, 2022 at 7:59 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> > Hmm. The x86 maintainers are on this thread, but they aren't even the
>> > problem. Adding Catalin and Will to this, I think they should know
>> > if/how this would fit with the arm64 ASID allocator.
>> >
>>
>> Well, I am an x86 mm maintainer, and there is definitely a performance problem on large x86 systems right now. :)
>
> Well, my point was that on x86, the complexities of the patch you
> posted are completely pointless.
>
> So on x86, you can just remove the mmgrab/mmdrop reference counts from
> the lazy mm use entirely, and voila, that performance problem is gone.
> We don't _need_ reference counting on x86 at all, if we just say that
> the rule is that a lazy mm is always associated with a
> honest-to-goodness live mm.
>
> So on x86 - and any platform with the IPI model - there is no need for
> hundreds of lines of complexity at all.
>
> THAT is my point. Your patch adds complexity that buys you ABSOLUTELY NOTHING.
>
> You then saying that the mmgrab/mmdrop is a performance problem is
> just trying to muddy the water. You can just remove it entirely.
>
> Now, I do agree that that depends on the whole "TLB IPI will get rid
> of any lazy mm users on other cpus". So I agree that if you have
> hardware TLB invalidation that then doesn't have that software
> component to it, you need something else.
>
> But my argument _then_ was that hardware TLB invalidation then needs
> the hardware ASID thing to be useful, and the ASID management code
> already effectively keeps track of "this ASID is used on other CPU's".
> And that's exactly the same kind of information that your patch
> basically added a separate percpu array for.
>

Are you *sure*?  The ASID management code on x86 is (as mentioned before) completely unaware of whether an ASID is actually in use anywhere.  The x86 ASID code is a per-cpu LRU -- it tracks whether an mm has been recently used on a cpu, not whether the mm exists.  If an mm hasn't been used recently, the ASID gets recycled.  If we had more bits, we wouldn't even recycle it.  An ASID can and does get recycled while the mm still exists.

> So I think that even for that hardware TLB shootdown case, your patch
> only adds overhead.

The overhead is literally:

exit_mmap();
for each cpu still in mm_cpumask:
  smp_load_acquire

That's it, unless the mm is actually in use, in which 

>
> And it potentially adds a *LOT* of overhead, if you replace an atomic
> refcount with a "for_each_possible_cpu()" loop that has to do cmpxchg
> things too.

The cmpxchg is only in the case in which the mm is actually in use on that CPU.  I'm having trouble imagining a workload in which the loop is even measurable unless the bit scan itself is somehow problematic.

On a very large arm64 system, I would believe there could be real overhead.  But these very large systems are exactly the systems that currently ping-pong mm_count.

>
> Btw, you don't even need to really solve the arm64 TLB invalidate
> thing - we could make the rule be that we only do the mmgrab/mmput at
> all on platforms that don't do that IPI flush.
>
> I think that's basically exactly what Nick Piggin wanted to do on powerpc, no?

More or less, but...

>
> But you hated that patch, for non-obvious reasons, and are now
> introducing this new patch that is clearly non-optimal on x86.

I hated that patch because it's messy and it leaves the core lazy handling in an IMO quite regrettable state, not because I'm particularly opposed to shooting down lazies on platforms where it makes sense (powerpc and mostly x86).

As just the most obvious issue, note the kasan_check_byte() in this patch that verifies that ->active_mm doesn't point to freed memory when the scheduler is entered.  If we flipped shoot-lazies on on x86, then KASAN would blow up with that.

For perspective, this whole series is 23 patches.  Exactly two of them are directly related to my hazard pointer scheme: patches 16 and 22.  The rest of them are, in my opinion, cleanups and some straight-up bugfixes that are worthwhile no matter what we do with lazy mm handling per se.

>
> So I think there's some intellectual dishonesty on your part here.

I never said I hated shoot-lazies.  I didn't like the *code*.  I thought I could do better, and I still think my hazard pointer scheme is nifty and, aside from some complexity, quite nice, and it even reduces to shoot-lazies if for_each_possible_lazymm_cpu() is defined to do nothing, but I mainly wanted the code to be better.  So I went and did it.  I could respin this series without the hazard pointers quite easily.

--Andy
