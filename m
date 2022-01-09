Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF10488C27
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 20:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiAITxY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 14:53:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43002 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiAITxX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 14:53:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4D05B80E24
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 19:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A14BC36AE3;
        Sun,  9 Jan 2022 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641758001;
        bh=yCZUstcghgu9NSj/hFbT7xlPKiqKj92jtzc7pZLwNpU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ODKraXgcpU5/fZQIUwZxTMxp+EsJ9gKu1/6wbL1sTHhpUbdrKnIHqEP+8POLRDbpk
         UQdhbxWPv7LZNPd3Mk8hIwPXhjYyC5h4JB1GyMpGx5VhlVutdMe1Cqv1TL4idjQnPT
         vx8afs+Xv8/FscIYx3BEx/RZki9wAyzWmWwlTKyM3RoFGdptj2n3R+laSzndRFp+mk
         /PGT3z8tAhZdZHTpOOIWVumQL1lsGXOfImjla8N7D7SNcuH5EOePMClZtCWNIkZVfa
         0pmIPtQPNKMhGPiasTBGveGhkueHqEviUuXdmtURVzhNDmtMhr0F0U1V6qoQoe6C5o
         rtmoMYMtypgRQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 52E8727C0054;
        Sun,  9 Jan 2022 14:53:19 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sun, 09 Jan 2022 14:53:19 -0500
X-ME-Sender: <xms:LT3bYTo6ZMcnoJOJJ44cyrqbJjnbpIknQxTWUVcoGAi4ThYGcCS4Kw>
    <xme:LT3bYdoCazNicU1oWd_WOzkemMtK7-HBj6_2QerX9OjbahyjKfl0JZx97UCjab6ec
    5JIIiiCZI-VPo1LCqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:LT3bYQNreK0xamrK93M3gkbTx_A2cV8jXn3cnLLsgM-5BuR0SBKkcQ>
    <xmx:LT3bYW6uEZIZqzsajKXLgJ6s3SPUFAoWNhOoLWI1uH_DzKOJPuZamw>
    <xmx:LT3bYS7d6YH-YWJ19qwkFV0e50CGzd6EwII28o2F0CBjJ1Gzw1hjjg>
    <xmx:Lz3bYSwAIHRSBZsryDp4nKjdFaV_IPDwu7ncjFayKFcNp7pyOh-bKSwOY9ZIrilA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9DAD121E0073; Sun,  9 Jan 2022 14:53:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <355c148c-06a8-4e15-a77b-0ea2e22bf708@www.fastmail.com>
In-Reply-To: <CAHk-=wgtS7aNL=bxuwVFKiUzijc1EFiFXWTNLH-CHEgxciUVdg@mail.gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
 <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
 <CAHk-=wgtS7aNL=bxuwVFKiUzijc1EFiFXWTNLH-CHEgxciUVdg@mail.gmail.com>
Date:   Sun, 09 Jan 2022 11:52:52 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Nadav Amit" <nadav.amit@gmail.com>
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
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 9, 2022, at 11:10 AM, Linus Torvalds wrote:
> On Sun, Jan 9, 2022 at 12:49 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>>
>> I do not know whether it is a pure win, but there is a tradeoff.
>
> Hmm. I guess only some serious testing would tell.
>
> On x86, I'd be a bit worried about removing lazy TLB simply because
> even with ASID support there (called PCIDs by Intel for NIH reasons),
> the actual ASID space on x86 was at least originally very very
> limited.
>
> Architecturally, x86 may expose 12 bits of ASID space, but iirc at
> least the first few implementations actually only internally had one
> or two bits, and hashed the 12 bits down to that internal very limited
> hardware TLB ID space.
>
> We only use a handful of ASIDs per CPU on x86 partly for this reason
> (but also since there's no remote hardware TLB shootdown, there's no
> reason to have a bigger global ASID space, so ASIDs aren't _that_
> common).
>
> And I don't know how many non-PCID x86 systems (perhaps virtualized?)
> there might be out there.
>
> But it would be very interesting to test some "disable lazy tlb"
> patch. The main problem workloads tend to be IO, and I'm not sure how
> many of the automated performance tests would catch issues. I guess
> some threaded pipe ping-pong test (with each thread pinned to
> different cores) would show it.

My original PCID series actually did remove lazy TLB on x86.  I don't remember why, but people objected.  The issue isn't the limited PCID space -- IIRC it's just that MOV CR3 is slooooow.  If we get rid of lazy TLB on x86, then we are writing CR3 twice on even a very short idle.  That adds maybe 1k cycles, which isn't great.

>
> And I guess there is some load that triggered the original powerpc
> patch by Nick&co, and that Andy has been using..

I don't own a big enough machine.  The workloads I'm aware of with the problem have massively multithreaded programs using many CPUs, and transitions into and out of lazy mode ping-pong the cacheline.

>
> Anybody willing to cook up a patch and run some benchmarks? Perhaps
> one that basically just replaces "set ->mm to NULL" with "set ->mm to
> &init_mm" - so that the lazy TLB code is still *there*, but it never
> triggers..

It would 

>
> I think it's mainly 'copy_thread()' in kernel/fork.c and the 'init_mm'
> initializer in mm/init-mm.c, but there's probably other things too
> that have that knowledge of the special "tsk->mm = NULL" situation.

I think, for a little test, we would leave all the mm == NULL code alone and just change the enter-lazy logic.  On top of all the cleanups in this series, that would be trivial.

>
>                   Linus
