Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8E48B0C0
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 16:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbiAKPXh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 10:23:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34064 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343546AbiAKPXX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 10:23:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 321FB6165A
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 15:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6993C36AF3;
        Tue, 11 Jan 2022 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641914602;
        bh=EJY5+kJbU75glzYd5Kp73CBKCdCrt4ymyiUsTLY/xt4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=moiD9Zd94LsL13tPFoWV+8zJSSNjERmWMF4FbkKX3Rd3peWdXaBBaiIS5ZKcGzMyV
         d0mBOo988GW5MWNPNXRO8+vekI0IzwF+lNMfHu1i/d0g7Pn02DaB8vc/4D+fWrlmIQ
         OnJGsspZS20RgoJV6ETMj5sq7XVe3DdcJigTySuk63xis1nsh9RZe7ICrZWLWQhjgj
         6KnR/EJNG9HRO9M9hpuolmX0JVlrZfqPHBPJiyVvuKYwXcsDkq24sjzmmR68h6MP2d
         1U6FtWJ+HPCjQNGH+7Z4B80exgGTc5fte0ketENY6LbyqXUbWoP7NfWk/8E8QOUM/j
         l+61M7VZj0I9w==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 72C0127C0054;
        Tue, 11 Jan 2022 10:23:20 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Tue, 11 Jan 2022 10:23:20 -0500
X-ME-Sender: <xms:56DdYeo0PgplyWPzdHDK-tsDVCK53unk_L1foQAsyDLxUx46SrqMWg>
    <xme:56DdYcrftDtFmy6_9xgq4L-pVWuj3fAkqDna8at7_hxtYSmzNMxmuIzPq24V-e1bP
    wejXlG06YqWW3HAgC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpefhlefhudegtedvhfefueevvedtgeeukefhffehtefftdelvedthedt
    iedvueevudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuth
    hopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:56DdYTMdq14jq1ixuqXYG2ofX6llg61CXPZOaev9r5lVQEie5XRowA>
    <xmx:56DdYd6s_nQv424fPU4h343tqpZUDoC8Ec1KgUMfXtNsgdJpKxYvmQ>
    <xmx:56DdYd7Sqrz1n6V_-Ct4KbTxqm2QYpHo4jtYfyq5cDnDW-e6aDwBGQ>
    <xmx:6KDdYcTaa7OlybY3DmJtsFGLB_sdLZt4i6hCz2_3YcYMJ3bA5VUOzt7WaY6NTKk8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B208C21E0073; Tue, 11 Jan 2022 10:23:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <5bc65fb9-9c9d-4fe3-b4cc-657e45378131@www.fastmail.com>
In-Reply-To: <20220111103953.GA10037@willie-the-truck>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
 <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
 <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
 <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
 <20220111103953.GA10037@willie-the-truck>
Date:   Tue, 11 Jan 2022 07:22:54 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Will Deacon" <will@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
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



On Tue, Jan 11, 2022, at 2:39 AM, Will Deacon wrote:
> Hi Andy, Linus,
>
> On Sun, Jan 09, 2022 at 12:48:42PM -0800, Linus Torvalds wrote:
>> On Sun, Jan 9, 2022 at 12:20 PM Andy Lutomirski <luto@kernel.org> wrote:

>> That said, I still don't actually know the arm64 ASID management code.
>
> That appears to be a common theme in this thread, so hopefully I can shed
> some light on the arm64 side of things:
>

Thanks!

>
> FWIW, we have a TLA+ model of some of this, which may (or may not) be easier
> to follow than my text:

Yikes. Your fine hardware engineers should consider 64-bit ASIDs :)

I suppose x86-on-AMD could copy this, but eww.  OTOH x86 can easily have more CPUs than ASIDs, so maybe not.

>
> https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/asidalloc.tla
>
> although the syntax is pretty hard going :(
>
>> The thing about TLB flushes is that it's ok to do them spuriously (as
>> long as you don't do _too_ many of them and tank performance), so two
>> different mm's can have the same hw ASID on two different cores and
>> that just makes cross-CPU TLB invalidates too aggressive. You can't
>> share an ASID on the _same_ core without flushing in between context
>> switches, because then the TLB on that core might be re-used for a
>> different mm. So the flushing rules aren't necessarily 100% 1:1 with
>> the "in use" rules, and who knows if the arm64 ASID management
>> actually ends up just matching what that whole "this lazy TLB is still
>> in use on another CPU".
>
> The shared TLBs (Arm calls this "Common-not-private") make this problematic,
> as the TLB is no longer necessarily per-core.
>
>> So I don't really know the arm64 situation. And i's possible that lazy
>> TLB isn't even worth it on arm64 in the first place.
>
> ASID allocation aside, I think there are a few useful things to point out
> for arm64:
>
> 	- We only have "local" or "all" TLB invalidation; nothing targetted
> 	  (and for KVM guests this is always "all").
>
> 	- Most mms end up running on more than one CPU (at least, when I
> 	  last looked at this a fork+exec would end up with the mm having
> 	  been installed on two CPUs)
>
> 	- We don't track mm_cpumask as it showed up as a bottleneck in the
> 	  past and, because of the earlier points, it wasn't very useful
> 	  anyway
>
> 	- mmgrab() should be fast for us (it's a posted atomic add),
> 	  although mmdrop() will be slower as it has to return data to
> 	  check against the count going to zero.
>
> So it doesn't feel like an obvious win to me for us to scan these new hazard
> pointers on arm64. At least, I would love to see some numbers if we're going
> to make changes here.

I will table the hazard pointer scheme, then, and adjust the series to do shootdowns.

I would guess that once arm64 hits a few hundred CPUs, you'll start finding workloads where mmdrop() at least starts to hurt.  But we can cross that bridge when we get to it.
