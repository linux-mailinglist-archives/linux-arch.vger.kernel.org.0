Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E32748A614
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiAKDKQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 22:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiAKDKP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 22:10:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B1C06173F
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 19:10:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso2416041pjm.4
        for <linux-arch@vger.kernel.org>; Mon, 10 Jan 2022 19:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=KGhXskeWeF++6Qq+O+6sYoul9PU/Gvc9NNDfObNCvXk=;
        b=LFnoIQBYPLd7U8Y7ffu26TgmqHwmHz/RaLrxz/t89/ObSSbNqZNcEOdQkvs6D9jBE+
         VrpQ9/RaKScu2kv0ANIrwzLJAEHCkTjF56emG0yJPUBaYtdYkPX7v8HdKBSsDhv0WoPl
         ZSsSjNlJVQ97pPSvPlDSEXaVoZosCQL8AePVpTsN8b6z4samVeIqsl9IkkB4/F/9ZOFV
         f6WqV3eUB9ABhfzPIk4ExYnG2EdT24wr8bJlbEIPyqjvfeojs/+Uhlkn0MK3xuj++rQr
         aE+aL6xq9VGenG/StzZztTMgqA8FEVp7h+oA2KttoY52g0pVUDBOArpqvlgDnQZigrCv
         O73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=KGhXskeWeF++6Qq+O+6sYoul9PU/Gvc9NNDfObNCvXk=;
        b=nbTGk2Aw7Jsdz1ad3E9Z78OFrroAeEfIgoIco4lsEIeEJ4LPYOPYeQm9cs3PTMqXmz
         3ehXHeAPj3d2T4W6AC1g+OWwOtLsbjy8aMhkLK6r+3b4gVXYe6cy0yFhYV5YtIGNv5M0
         ++l9cqokXOz0birykuxroQu/OdNTKhAd9QRs25VTn47XJsHRg96SAlL2uGcRHIIy4ooq
         GT9Yyu1ma6hepFMNTryIujIT0ZN0l//tXYu7NTQ3UHzlPoMdb3gjssg73y76AWUXCAIc
         H/zyccer7W9Zid0YSIk0laXoyBBK0IaprRlpGPRTuh0ZcZhYzqZPdYk/ovDxfQCCwjWo
         kGKg==
X-Gm-Message-State: AOAM530oLFLQODFolllGQD8Swcs49g3n55QQSoXp0oOB4E/OL32IBbJx
        RRfM75cTESTG2Cz9NrGkl0E=
X-Google-Smtp-Source: ABdhPJzUnuqhIAjqQ+jrRPi+mo64hhbmaXgiYDjCvcR6PCYx/fPkQh5u/JokOwh7Q3nZKMfi5nQQnw==
X-Received: by 2002:a17:902:830b:b0:149:5f4d:e178 with SMTP id bd11-20020a170902830b00b001495f4de178mr2674408plb.152.1641870615090;
        Mon, 10 Jan 2022 19:10:15 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id d13sm8354088pfl.18.2022.01.10.19.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:10:14 -0800 (PST)
Date:   Tue, 11 Jan 2022 13:10:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
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
In-Reply-To: <0d905aef-f53c-4102-931f-a22edd084fae@www.fastmail.com>
MIME-Version: 1.0
Message-Id: <1641867901.xve7qy78q6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of January 11, 2022 6:52 am:
>=20
>=20
> On Sun, Jan 9, 2022, at 8:56 PM, Nicholas Piggin wrote:
>> Excerpts from Linus Torvalds's message of January 10, 2022 7:51 am:
>>> [ Ugh, I actually went back and looked at Nick's patches again, to
>>> just verify my memory, and they weren't as pretty as I thought they
>>> were ]
>>>=20
>>> On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> I'd much rather have a *much* smaller patch that says "on x86 and
>>>> powerpc, we don't need this overhead at all".
>>>=20
>>> For some reason I thought Nick's patch worked at "last mmput" time and
>>> the TLB flush IPIs that happen at that point anyway would then make
>>> sure any lazy TLB is cleaned up.
>>>=20
>>> But that's not actually what it does. It ties the
>>> MMU_LAZY_TLB_REFCOUNT to an explicit TLB shootdown triggered by the
>>> last mmdrop() instead. Because it really tied the whole logic to the
>>> mm_count logic (and made lazy tlb to not do mm_count) rather than the
>>> mm_users thing I mis-remembered it doing.
>>
>> It does this because on powerpc with hash MMU, we can't use IPIs for
>> TLB shootdowns.
>=20
> I know nothing about powerpc=E2=80=99s mmu. If you can=E2=80=99t do IPI s=
hootdowns,

The paravirtualised hash MMU environment doesn't because it has a single=20
level translation and the guest uses hypercalls to insert and remove=20
translations and the hypervisor flushes TLBs. The HV could flush TLBs
with IPIs but obviously the guest can't use those to execute the lazy
switch. In radix guests (and all bare metal) the OS flushes its own
TLBs.

We are moving over to radix, but powerpc also has a hardware broadcast=20
flush instruction which can be a bit faster than IPIs and is usable by=20
bare metal and radix guests so those can also avoid the IPIs if they=20
want. Part of the powerpc patch I just sent to combine the lazy switch=20
with the final TLB flush is to force it to always take the IPI path and=20
not use TLBIE instruction on the final exit.

So hazard points could avoid some IPIs there too.

> it sounds like the hazard pointer scheme might actually be pretty good.

Some IPIs in the exit path just aren't that big a concern. I measured,
got numbers, tried to irritate it, just wasn't really a problem. Some
archs use IPIs for all threaded TLB shootdowns and exits not that
frequent. Very fast short lived processes that do a lot of exits just
don't tend to spread across a lot of CPUs leaving lazy tlb mms to shoot,
and long lived and multi threaded ones that do don't exit at high rates.

So from what I can see it's premature optimization. Actually maybe not
even optimization because IIRC it adds complexity and even a barrier on
powerpc in the context switch path which is a lot more critical than
exit() for us we don't want slowdowns there.

It's a pretty high complexity boutique kind of synchronization. Which
don't get me wrong is the kind of thing I like, it is clever and may be
perfectly bug free but it needs to prove itself over the simple dumb
shoot lazies approach.

>>> So at least some of my arguments were based on me just mis-remembering
>>> what Nick's patch actually did (mainly because I mentally recreated
>>> the patch from "Nick did something like this" and what I thought would
>>> be the way to do it on x86).
>>
>> With powerpc with the radix MMU using IPI based shootdowns, we can=20
>> actually do the switch-away-from-lazy on the final TLB flush and the
>> final broadcast shootdown thing becomes a no-op. I didn't post that
>> additional patch because it's powerpc-specific and I didn't want to
>> post more code so widely.
>>
>>> So I guess I have to recant my arguments.
>>>=20
>>> I still think my "get rid of lazy at last mmput" model should work,
>>> and would be a perfect match for x86, but I can't really point to Nick
>>> having done that.
>>>=20
>>> So I was full of BS.
>>>=20
>>> Hmm. I'd love to try to actually create a patch that does that "Nick
>>> thing", but on last mmput() (ie when __mmput triggers). Because I
>>> think this is interesting. But then I look at my schedule for the
>>> upcoming week, and I go "I don't have a leg to stand on in this
>>> discussion, and I'm just all hot air".
>>
>> I agree Andy's approach is very complicated and adds more overhead than
>> necessary for powerpc, which is why I don't want to use it. I'm still
>> not entirely sure what the big problem would be to convert x86 to use
>> it, I admit I haven't kept up with the exact details of its lazy tlb
>> mm handling recently though.
>=20
> The big problem is the entire remainder of this series!  If x86 is going =
to do shootdowns without mm_count, I want the result to work and be maintai=
nable. A few of the issues that needed solving:
>=20
> - x86 tracks usage of the lazy mm on CPUs that have it loaded into the MM=
U, not CPUs that have it in active_mm.  Getting this in sync needed core ch=
anges.

Definitely should have been done at the time x86 deviated, but better=20
late than never.

>=20
> - mmgrab and mmdrop are barriers, and core code relies on that. If we get=
 rid of a bunch of calls (conditionally), we need to stop depending on the =
barriers. I fixed this.

membarrier relied on a call that mmdrop was providing. Adding a smp_mb()
instead if mmdrop is a no-op is fine. Patches changing membarrier's=20
ordering requirements can be concurrent and are not fundmentally tied
to lazy tlb mm switching, it just reuses an existing ordering point.

> - There were too many mmgrab and mmdrop calls, and the call sites had dif=
ferent semantics and different refcounting rules (thanks, kthread).  I clea=
ned this up.

Seems like a decent cleanup. Again lazy tlb specific, just general switch
code should be factored and better contained in kernel/sched/ which is
fine, but concurrent to lazy tlb improvements.

> - If we do a shootdown instead of a refcount, then, when exit() tears dow=
n its mm, we are lazily using *that* mm when we do the shootdowns. If activ=
e_mm continues to point to the being-freed mm and an NMI tries to dereferen=
ce it, we=E2=80=99re toast. I fixed those issues.

My shoot lazies patch has no such issues with that AFAIKS. What exact=20
issue is it and where did you fix it?

>=20
> - If we do a UEFI runtime service call while lazy or a text_poke while la=
zy and the mm goes away while this is happening, we would blow up. Refcount=
ing prevents this but, in current kernels, a shootdown IPI on x86 would not=
 prevent this.  I fixed these issues (and removed duplicate code).
>=20
> My point here is that the current lazy mm code is a huge mess. 90% of the=
 complexity in this series is cleaning up core messiness and x86 messiness.=
 I would still like to get rid of ->active_mm entirely (it appears to serve=
 no good purpose on any architecture),  it that can be saved for later, I t=
hink.

I disagree, the lazy mm code is very clean and simple. And I can't see=20
how you would propose to remove active_mm from core code I'm skeptical
but would be very interested to see, but that's nothing to do with my
shoot lazies patch and can also be concurrent except for mechanical
merge issues.

Thanks,
Nick
