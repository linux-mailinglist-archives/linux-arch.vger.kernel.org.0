Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAF48B10C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 16:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiAKPkL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 10:40:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42106 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbiAKPkJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 10:40:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9701B616A6
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 15:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D223C36AF2;
        Tue, 11 Jan 2022 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641915609;
        bh=sPWSkIYDlYfT02Hpas2HPEp6+9rOTMQVMnd1y9rhwMQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=vQ0yJX4sF8TiQA0lDHDPzX0psc4X8AovsRrSsfvrP5LrJQqri8h0677DAYXfhbWhq
         RUBbKt1wlVbImNdUZaU9Qx5DBoypFhU0xP6UPayeCiigQf/ojxglyB9h5LWVsoh5hi
         6HsMDF7xDJbw9qPLMUx15FbaWKRy7Ei6XGW1Kp9ROYKOgSVUbBW4o2dXl3U8SpuTez
         IqyRLfJtUKRuvRBH8qQZB/9MrRGgrkrWiXjBi24CVeA3HU85+1Lk+PFb4zGir3+qDe
         w5Uqv6DuXKba6ThODsr5NBKDRcOc2ATZcu1NeYzeejckCkuOyUxdWDFquVgVoieMz+
         D+E3EOtkMosTw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2790E27C005A;
        Tue, 11 Jan 2022 10:40:07 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute5.internal (MEProxy); Tue, 11 Jan 2022 10:40:07 -0500
X-ME-Sender: <xms:1aTdYQLewj0XPEr0G9_tQ8siYPKTbP1jvKTN2rTa_sKy765j0JLvzQ>
    <xme:1aTdYQJvPA2CpKJhZsNnjkVAmuMQRLO0sAmMjG9pVyBAtR9pVbVN80i5QeSjE0XYY
    PygwXSoJDl7yUTBYTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:1aTdYQtor_d0mVVGfhwIGCpPfOGcbZJFEUWhFREOTo7lPYcoNvnoJQ>
    <xmx:1aTdYdaaMMbRfLhuIb_iMaELDBd3bjIOmLPjiImBbp2Y2NWD3Y3uHQ>
    <xmx:1aTdYXb1WZtUphfHZaoU1CkxTocr7xVlx9SVyxP1PduMLHYpVa5OAQ>
    <xmx:16TdYdzEOEW4zAudLLg9eDXWvRJYv5afzN8mjH4_SIWWKtyBHfcDIoG63P-guakF>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6C81321E006E; Tue, 11 Jan 2022 10:40:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <c35e696f-7463-49f6-ab89-793ba2dba6bf@www.fastmail.com>
In-Reply-To: <1641867901.xve7qy78q6.astroid@bobo.none>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
 <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
 <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
 <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
 <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
 <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
 <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
 <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
 <1641790309.2vqc26hwm3.astroid@bobo.none>
 <0d905aef-f53c-4102-931f-a22edd084fae@www.fastmail.com>
 <1641867901.xve7qy78q6.astroid@bobo.none>
Date:   Tue, 11 Jan 2022 07:39:39 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Anton Blanchard" <anton@ozlabs.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Paul Mackerras" <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Rik van Riel" <riel@surriel.com>, "Will Deacon" <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Mon, Jan 10, 2022, at 7:10 PM, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of January 11, 2022 6:52 am:
>>=20
>>=20
>> On Sun, Jan 9, 2022, at 8:56 PM, Nicholas Piggin wrote:
>>> Excerpts from Linus Torvalds's message of January 10, 2022 7:51 am:
>>>> [ Ugh, I actually went back and looked at Nick's patches again, to
>>>> just verify my memory, and they weren't as pretty as I thought they
>>>> were ]
>>>>=20
>>>> On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
>>>> <torvalds@linux-foundation.org> wrote:
>>>>>
>>>>> I'd much rather have a *much* smaller patch that says "on x86 and
>>>>> powerpc, we don't need this overhead at all".
>>>>=20
>>>> For some reason I thought Nick's patch worked at "last mmput" time =
and
>>>> the TLB flush IPIs that happen at that point anyway would then make
>>>> sure any lazy TLB is cleaned up.
>>>>=20
>>>> But that's not actually what it does. It ties the
>>>> MMU_LAZY_TLB_REFCOUNT to an explicit TLB shootdown triggered by the
>>>> last mmdrop() instead. Because it really tied the whole logic to the
>>>> mm_count logic (and made lazy tlb to not do mm_count) rather than t=
he
>>>> mm_users thing I mis-remembered it doing.
>>>
>>> It does this because on powerpc with hash MMU, we can't use IPIs for
>>> TLB shootdowns.
>>=20
>> I know nothing about powerpc=E2=80=99s mmu. If you can=E2=80=99t do I=
PI shootdowns,
>
> The paravirtualised hash MMU environment doesn't because it has a sing=
le=20
> level translation and the guest uses hypercalls to insert and remove=20
> translations and the hypervisor flushes TLBs. The HV could flush TLBs
> with IPIs but obviously the guest can't use those to execute the lazy
> switch. In radix guests (and all bare metal) the OS flushes its own
> TLBs.
>
> We are moving over to radix, but powerpc also has a hardware broadcast=20
> flush instruction which can be a bit faster than IPIs and is usable by=20
> bare metal and radix guests so those can also avoid the IPIs if they=20
> want. Part of the powerpc patch I just sent to combine the lazy switch=20
> with the final TLB flush is to force it to always take the IPI path an=
d=20
> not use TLBIE instruction on the final exit.
>
> So hazard points could avoid some IPIs there too.
>
>> it sounds like the hazard pointer scheme might actually be pretty goo=
d.
>
> Some IPIs in the exit path just aren't that big a concern. I measured,
> got numbers, tried to irritate it, just wasn't really a problem. Some
> archs use IPIs for all threaded TLB shootdowns and exits not that
> frequent. Very fast short lived processes that do a lot of exits just
> don't tend to spread across a lot of CPUs leaving lazy tlb mms to shoo=
t,
> and long lived and multi threaded ones that do don't exit at high rate=
s.
>
> So from what I can see it's premature optimization. Actually maybe not
> even optimization because IIRC it adds complexity and even a barrier on
> powerpc in the context switch path which is a lot more critical than
> exit() for us we don't want slowdowns there.
>
> It's a pretty high complexity boutique kind of synchronization. Which
> don't get me wrong is the kind of thing I like, it is clever and may be
> perfectly bug free but it needs to prove itself over the simple dumb
> shoot lazies approach.
>
>>>> So at least some of my arguments were based on me just mis-remember=
ing
>>>> what Nick's patch actually did (mainly because I mentally recreated
>>>> the patch from "Nick did something like this" and what I thought wo=
uld
>>>> be the way to do it on x86).
>>>
>>> With powerpc with the radix MMU using IPI based shootdowns, we can=20
>>> actually do the switch-away-from-lazy on the final TLB flush and the
>>> final broadcast shootdown thing becomes a no-op. I didn't post that
>>> additional patch because it's powerpc-specific and I didn't want to
>>> post more code so widely.
>>>
>>>> So I guess I have to recant my arguments.
>>>>=20
>>>> I still think my "get rid of lazy at last mmput" model should work,
>>>> and would be a perfect match for x86, but I can't really point to N=
ick
>>>> having done that.
>>>>=20
>>>> So I was full of BS.
>>>>=20
>>>> Hmm. I'd love to try to actually create a patch that does that "Nick
>>>> thing", but on last mmput() (ie when __mmput triggers). Because I
>>>> think this is interesting. But then I look at my schedule for the
>>>> upcoming week, and I go "I don't have a leg to stand on in this
>>>> discussion, and I'm just all hot air".
>>>
>>> I agree Andy's approach is very complicated and adds more overhead t=
han
>>> necessary for powerpc, which is why I don't want to use it. I'm still
>>> not entirely sure what the big problem would be to convert x86 to use
>>> it, I admit I haven't kept up with the exact details of its lazy tlb
>>> mm handling recently though.
>>=20
>> The big problem is the entire remainder of this series!  If x86 is go=
ing to do shootdowns without mm_count, I want the result to work and be =
maintainable. A few of the issues that needed solving:
>>=20
>> - x86 tracks usage of the lazy mm on CPUs that have it loaded into th=
e MMU, not CPUs that have it in active_mm.  Getting this in sync needed =
core changes.
>
> Definitely should have been done at the time x86 deviated, but better=20
> late than never.
>

I suspect that this code may predate there being anything for x86 to dev=
iate from.

>>=20
>> - mmgrab and mmdrop are barriers, and core code relies on that. If we=
 get rid of a bunch of calls (conditionally), we need to stop depending =
on the barriers. I fixed this.
>
> membarrier relied on a call that mmdrop was providing. Adding a smp_mb=
()
> instead if mmdrop is a no-op is fine. Patches changing membarrier's=20
> ordering requirements can be concurrent and are not fundmentally tied
> to lazy tlb mm switching, it just reuses an existing ordering point.

smp_mb() is rather expensive on x86 at least, and I think on powerpc to.=
  Let's not.

Also, IMO my cleanups here generally make sense and make the code better=
, so I think we should just go with them.

>
>> - There were too many mmgrab and mmdrop calls, and the call sites had=
 different semantics and different refcounting rules (thanks, kthread). =
 I cleaned this up.
>
> Seems like a decent cleanup. Again lazy tlb specific, just general swi=
tch
> code should be factored and better contained in kernel/sched/ which is
> fine, but concurrent to lazy tlb improvements.

I personally rather dislike the model of:

...
mmgrab_lazy();
...
mmdrop_lazy();
...
mmgrab_lazy();
...
mmdrop_lazy();
...

where the different calls have incompatible logic at the call sites and =
a magic config option NOPs them all away and adds barriers.  I'm persona=
lly a big fan of cleaning up code before making it even more complicated.

>
>> - If we do a shootdown instead of a refcount, then, when exit() tears=
 down its mm, we are lazily using *that* mm when we do the shootdowns. I=
f active_mm continues to point to the being-freed mm and an NMI tries to=
 dereference it, we=E2=80=99re toast. I fixed those issues.
>
> My shoot lazies patch has no such issues with that AFAIKS. What exact=20
> issue is it and where did you fix it?

Without my unlazy_mm_irqs_off() (or something similar), x86's very sensi=
ble (and very old!) code to unlazy a lazy CPU when flushing leaves activ=
e_mm pointing to the old lazy mm.  That's not a problem at all on curren=
t kernels, but in a shootdown-lazy world, those active_mm pointers will =
stick around.  Even with that fixed, without some care, an NMI during th=
e shootdown CPU could dereference ->active_mm at a time when it's not be=
ing actively kept alive.

Fixed by unlazy_mm_irqs_off(), the patches that use it, and the patches =
that make x86 stop inappropriately using ->active_mm.

>
>>=20
>> - If we do a UEFI runtime service call while lazy or a text_poke whil=
e lazy and the mm goes away while this is happening, we would blow up. R=
efcounting prevents this but, in current kernels, a shootdown IPI on x86=
 would not prevent this.  I fixed these issues (and removed duplicate co=
de).
>>=20
>> My point here is that the current lazy mm code is a huge mess. 90% of=
 the complexity in this series is cleaning up core messiness and x86 mes=
siness. I would still like to get rid of ->active_mm entirely (it appear=
s to serve no good purpose on any architecture),  it that can be saved f=
or later, I think.
>
> I disagree, the lazy mm code is very clean and simple. And I can't see=20
> how you would propose to remove active_mm from core code I'm skeptical
> but would be very interested to see, but that's nothing to do with my
> shoot lazies patch and can also be concurrent except for mechanical
> merge issues.

I think we may just have to agree to disagree.  The more I looked at the=
 lazy code, the more problems I found.  So I fixed them.  That work is d=
one now (as far as I'm aware) except for rebasing and review.

--Andy
