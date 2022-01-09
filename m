Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5628488C5B
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 21:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiAIUsc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 15:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiAIUsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 15:48:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0BC06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 12:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BB03B80E3A
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 20:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3623DC36AE3;
        Sun,  9 Jan 2022 20:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641761307;
        bh=LsHeiNVZfdCTH6ss1wKhfos+xXMSUASjz79/xSlYqL4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=krDGV2YzWlKoFmCkH2ukFo1N3fRA8GMf8aU/kIWrzKO0Kgvv83DJXfI9K1431nI5Z
         3I8Ykynazlre9CGfJcc50NnXSkO/THagrvnd48LF4pgp98t5zLuGyCqq5+KdFLQAHd
         lal+KB3b4rfIE3v8vzgEHeo4wn5pOig0lPf6FCkXobT0u+Tm++vbHx4wcNUbXbBHjK
         w1Ol6ViIbdH7OElwLtOQN/QYOJTMCjzL1hKMaTmwl9OusfBaI7i64sZvnVHovvrAJq
         GgNcOzOW5NgQ+gIqLRtefj919/3LEyppsD5fDlZTodIwCl4jpev2bL8Yb75g3qE1qH
         OAXy0xLdUaTkQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0734227C0054;
        Sun,  9 Jan 2022 15:48:25 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Sun, 09 Jan 2022 15:48:26 -0500
X-ME-Sender: <xms:GUrbYZN-WAjsYo8CEwLSpHlMi1SPCVnDXUw7qp4AbHp26HY-haPhBw>
    <xme:GUrbYb8S4ICV_bPO8XGbZzXX9QQonhisIpcihmu6G68TZz68P8WLp6K--un3wAPuX
    etNjc1sm0Z0k_-5BPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:GUrbYYTtsxENVYNVylmcyr3eTzr1d0Ov3LvtIeCNGJQqeMbcLqOtCQ>
    <xmx:GUrbYVsllOM8bJN2htDM1GS5icniynnqFa4jG-S_FFlHip8BDagcZg>
    <xmx:GUrbYRduy5UayFHGWAWPfxG5o1-0U6__wVmIb4hR2eyYxLMMmW2TZw>
    <xmx:GUrbYf0P1wqxha43VIIZ42D3vfIVwRTuAoQg2hPtzjjZtOIH8ApFBOp-tNtBPQtS>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7ABA521E006E; Sun,  9 Jan 2022 15:48:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4526-gbc24f4957e-fm-20220105.001-gbc24f495
Mime-Version: 1.0
Message-Id: <c6ca5f41-e433-4203-929f-1853605ad88a@www.fastmail.com>
In-Reply-To: <0B23F7F5-96F1-4E2C-8C17-0ECC21CA14C6@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
 <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
 <CAHk-=wgtS7aNL=bxuwVFKiUzijc1EFiFXWTNLH-CHEgxciUVdg@mail.gmail.com>
 <355c148c-06a8-4e15-a77b-0ea2e22bf708@www.fastmail.com>
 <0B23F7F5-96F1-4E2C-8C17-0ECC21CA14C6@gmail.com>
Date:   Sun, 09 Jan 2022 13:48:05 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nadav Amit" <nadav.amit@gmail.com>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
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
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Sun, Jan 9, 2022, at 1:34 PM, Nadav Amit wrote:
>> On Jan 9, 2022, at 11:52 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> 
>> On Sun, Jan 9, 2022, at 11:10 AM, Linus Torvalds wrote:
>>> On Sun, Jan 9, 2022 at 12:49 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>>>> 
>>>> I do not know whether it is a pure win, but there is a tradeoff.
>>> 
>>> Hmm. I guess only some serious testing would tell.
>>> 
>>> On x86, I'd be a bit worried about removing lazy TLB simply because
>>> even with ASID support there (called PCIDs by Intel for NIH reasons),
>>> the actual ASID space on x86 was at least originally very very
>>> limited.
>>> 
>>> Architecturally, x86 may expose 12 bits of ASID space, but iirc at
>>> least the first few implementations actually only internally had one
>>> or two bits, and hashed the 12 bits down to that internal very limited
>>> hardware TLB ID space.
>>> 
>>> We only use a handful of ASIDs per CPU on x86 partly for this reason
>>> (but also since there's no remote hardware TLB shootdown, there's no
>>> reason to have a bigger global ASID space, so ASIDs aren't _that_
>>> common).
>>> 
>>> And I don't know how many non-PCID x86 systems (perhaps virtualized?)
>>> there might be out there.
>>> 
>>> But it would be very interesting to test some "disable lazy tlb"
>>> patch. The main problem workloads tend to be IO, and I'm not sure how
>>> many of the automated performance tests would catch issues. I guess
>>> some threaded pipe ping-pong test (with each thread pinned to
>>> different cores) would show it.
>> 
>> My original PCID series actually did remove lazy TLB on x86.  I don't remember why, but people objected.  The issue isn't the limited PCID space -- IIRC it's just that MOV CR3 is slooooow.  If we get rid of lazy TLB on x86, then we are writing CR3 twice on even a very short idle.  That adds maybe 1k cycles, which isn't great.
>
> Just for the record: I just ran a short test when CPUs are on max freq
> on my skylake. MOV-CR3 without flush is 250-300 cycles. One can argue
> that you mostly only care for one of the switches for the idle thread
> (once you wake up). And waking up by itself has its overheads.
>
> But you are the master of micro optimizations, and as Rik said, I
> mostly think of TLB shootdowns and might miss the big picture. Just
> trying to make your life easier by less coding and my life simpler
> in understanding your super-smart code. ;-)

As Rik pointed out, the mm_cpumask manipulation is also expensive if we get rid of lazy. Let me ponder how to do this nicely.
