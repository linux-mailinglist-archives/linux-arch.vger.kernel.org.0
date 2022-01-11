Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1134648BAEE
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 23:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiAKWs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 17:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiAKWs2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 17:48:28 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784E4C06173F
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 14:48:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o3so1542479pjs.1
        for <linux-arch@vger.kernel.org>; Tue, 11 Jan 2022 14:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=lpFKN40DyxTWyRxzkU0ZUWfinXqAMBHi9VPv4F+Npfw=;
        b=ZkuPy4r7nnq1ohyEgAbJ/LC4fCzV6zlJn8YO03u624kEPiEmJR3ks2TQGevKmZ1PBI
         Zr72hvTEvemwECj8NtI/RWMCNouhzbJIzu82NUicHAWt2W6/fj/cWMkuIZJ2g92sboGe
         f6fUxs4At7QcHXqD/SsAJ7TKqIIPJaGUYPIMFu7pm2ajGLs6DDTKapEtYcCrDxjZzqOv
         GrtdF/WGKRr4oqvgh4mOB40AlKh9S3l/TWV1MMF2KDtETHySIAd0g8Ux9PlTWkUK48Ei
         flAF7VsgfDx7STfqZatynO0XXpwyt+wLV0ElBKzVtCORsu0R+pMhcITEWVRFzvgrQvdl
         L+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=lpFKN40DyxTWyRxzkU0ZUWfinXqAMBHi9VPv4F+Npfw=;
        b=f9r4k0dmC4/yeKUN8tI1pAx6yPZqimdjA4Rzm9Z+eK9UeeMXt4ke3FdL12XYi7F0ts
         S1oR2Yak+WcyRB7P/QrIuibX5As5MTXE5UpKfZ46Le4hpUuWgFc5fqxY6y3KYQTYjvGw
         rC592kaWLUvqBqqOZakmOsUkxCDvlSTbGCDgXDFz7ZguZjTc7ZF1tkqgzQNibgGAy8Z8
         LM1E2LmXP3TV40bqnxo47IS+afl88fgvuL+9WzWLTACR2xITtMihfjia1TFvefrgx3S7
         yQovhjMOfEutbHRX3V1lJWtiMLDmRhUi2N/5waSmPh3YvO2rVli/WO8IVTK1wVWcY2ew
         LEnQ==
X-Gm-Message-State: AOAM53238bSALXMwnzN2VIBOhX8j5sSH1PkM1r55xgympl1p2Kr7RZ/z
        LcatA4+HyFO+WG7SPMnnFkO1XesxCIQ=
X-Google-Smtp-Source: ABdhPJxvjb3mcVW6oQgYBa6k/4H2aoGsj4/RRTLeC9kNZdfKjA2+S/VPbMWIvsv4zboOAw7cJ1PFlQ==
X-Received: by 2002:a62:7997:0:b0:4bf:508a:2f78 with SMTP id u145-20020a627997000000b004bf508a2f78mr6685120pfc.16.1641941307844;
        Tue, 11 Jan 2022 14:48:27 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id g9sm11610248pfj.123.2022.01.11.14.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:48:27 -0800 (PST)
Date:   Wed, 12 Jan 2022 08:48:22 +1000
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
        <1641867901.xve7qy78q6.astroid@bobo.none>
        <c35e696f-7463-49f6-ab89-793ba2dba6bf@www.fastmail.com>
In-Reply-To: <c35e696f-7463-49f6-ab89-793ba2dba6bf@www.fastmail.com>
MIME-Version: 1.0
Message-Id: <1641939251.s7ciy8cys4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of January 12, 2022 1:39 am:
>=20
>=20
> On Mon, Jan 10, 2022, at 7:10 PM, Nicholas Piggin wrote:
>> Excerpts from Andy Lutomirski's message of January 11, 2022 6:52 am:
>>>=20
>>>=20
>>> On Sun, Jan 9, 2022, at 8:56 PM, Nicholas Piggin wrote:
>>>> Excerpts from Linus Torvalds's message of January 10, 2022 7:51 am:
>>>>> [ Ugh, I actually went back and looked at Nick's patches again, to
>>>>> just verify my memory, and they weren't as pretty as I thought they
>>>>> were ]
>>>>>=20
>>>>> On Sun, Jan 9, 2022 at 12:48 PM Linus Torvalds
>>>>> <torvalds@linux-foundation.org> wrote:
>>>>>>
>>>>>> I'd much rather have a *much* smaller patch that says "on x86 and
>>>>>> powerpc, we don't need this overhead at all".
>>>>>=20
>>>>> For some reason I thought Nick's patch worked at "last mmput" time an=
d
>>>>> the TLB flush IPIs that happen at that point anyway would then make
>>>>> sure any lazy TLB is cleaned up.
>>>>>=20
>>>>> But that's not actually what it does. It ties the
>>>>> MMU_LAZY_TLB_REFCOUNT to an explicit TLB shootdown triggered by the
>>>>> last mmdrop() instead. Because it really tied the whole logic to the
>>>>> mm_count logic (and made lazy tlb to not do mm_count) rather than the
>>>>> mm_users thing I mis-remembered it doing.
>>>>
>>>> It does this because on powerpc with hash MMU, we can't use IPIs for
>>>> TLB shootdowns.
>>>=20
>>> I know nothing about powerpc=E2=80=99s mmu. If you can=E2=80=99t do IPI=
 shootdowns,
>>
>> The paravirtualised hash MMU environment doesn't because it has a single=
=20
>> level translation and the guest uses hypercalls to insert and remove=20
>> translations and the hypervisor flushes TLBs. The HV could flush TLBs
>> with IPIs but obviously the guest can't use those to execute the lazy
>> switch. In radix guests (and all bare metal) the OS flushes its own
>> TLBs.
>>
>> We are moving over to radix, but powerpc also has a hardware broadcast=20
>> flush instruction which can be a bit faster than IPIs and is usable by=20
>> bare metal and radix guests so those can also avoid the IPIs if they=20
>> want. Part of the powerpc patch I just sent to combine the lazy switch=20
>> with the final TLB flush is to force it to always take the IPI path and=20
>> not use TLBIE instruction on the final exit.
>>
>> So hazard points could avoid some IPIs there too.
>>
>>> it sounds like the hazard pointer scheme might actually be pretty good.
>>
>> Some IPIs in the exit path just aren't that big a concern. I measured,
>> got numbers, tried to irritate it, just wasn't really a problem. Some
>> archs use IPIs for all threaded TLB shootdowns and exits not that
>> frequent. Very fast short lived processes that do a lot of exits just
>> don't tend to spread across a lot of CPUs leaving lazy tlb mms to shoot,
>> and long lived and multi threaded ones that do don't exit at high rates.
>>
>> So from what I can see it's premature optimization. Actually maybe not
>> even optimization because IIRC it adds complexity and even a barrier on
>> powerpc in the context switch path which is a lot more critical than
>> exit() for us we don't want slowdowns there.
>>
>> It's a pretty high complexity boutique kind of synchronization. Which
>> don't get me wrong is the kind of thing I like, it is clever and may be
>> perfectly bug free but it needs to prove itself over the simple dumb
>> shoot lazies approach.
>>
>>>>> So at least some of my arguments were based on me just mis-rememberin=
g
>>>>> what Nick's patch actually did (mainly because I mentally recreated
>>>>> the patch from "Nick did something like this" and what I thought woul=
d
>>>>> be the way to do it on x86).
>>>>
>>>> With powerpc with the radix MMU using IPI based shootdowns, we can=20
>>>> actually do the switch-away-from-lazy on the final TLB flush and the
>>>> final broadcast shootdown thing becomes a no-op. I didn't post that
>>>> additional patch because it's powerpc-specific and I didn't want to
>>>> post more code so widely.
>>>>
>>>>> So I guess I have to recant my arguments.
>>>>>=20
>>>>> I still think my "get rid of lazy at last mmput" model should work,
>>>>> and would be a perfect match for x86, but I can't really point to Nic=
k
>>>>> having done that.
>>>>>=20
>>>>> So I was full of BS.
>>>>>=20
>>>>> Hmm. I'd love to try to actually create a patch that does that "Nick
>>>>> thing", but on last mmput() (ie when __mmput triggers). Because I
>>>>> think this is interesting. But then I look at my schedule for the
>>>>> upcoming week, and I go "I don't have a leg to stand on in this
>>>>> discussion, and I'm just all hot air".
>>>>
>>>> I agree Andy's approach is very complicated and adds more overhead tha=
n
>>>> necessary for powerpc, which is why I don't want to use it. I'm still
>>>> not entirely sure what the big problem would be to convert x86 to use
>>>> it, I admit I haven't kept up with the exact details of its lazy tlb
>>>> mm handling recently though.
>>>=20
>>> The big problem is the entire remainder of this series!  If x86 is goin=
g to do shootdowns without mm_count, I want the result to work and be maint=
ainable. A few of the issues that needed solving:
>>>=20
>>> - x86 tracks usage of the lazy mm on CPUs that have it loaded into the =
MMU, not CPUs that have it in active_mm.  Getting this in sync needed core =
changes.
>>
>> Definitely should have been done at the time x86 deviated, but better=20
>> late than never.
>>
>=20
> I suspect that this code may predate there being anything for x86 to devi=
ate from.

Interesting, active_mm came in 2.3.11 and x86's cpu_tlbstate[].active_mm=20
2.3.43. Longer than I thought.

>>>=20
>>> - mmgrab and mmdrop are barriers, and core code relies on that. If we g=
et rid of a bunch of calls (conditionally), we need to stop depending on th=
e barriers. I fixed this.
>>
>> membarrier relied on a call that mmdrop was providing. Adding a smp_mb()
>> instead if mmdrop is a no-op is fine. Patches changing membarrier's=20
>> ordering requirements can be concurrent and are not fundmentally tied
>> to lazy tlb mm switching, it just reuses an existing ordering point.
>=20
> smp_mb() is rather expensive on x86 at least, and I think on powerpc to. =
 Let's not.

You misunderstand me. If mmdrop is not there to provide the required=20
ordering that membarrier needs, then the membarrier code does its own
smp_mb(). It's not _more_ expensive than before because the full barrier
from the mmdrop is gone.

> Also, IMO my cleanups here generally make sense and make the code better,=
 so I think we should just go with them.

Sure if you can make the membarrier code better and avoid this ordering
requirement that's nice. This is orthogonal to the lazy tlb code though
and they can go in parallel (again aside from mechanical merge issues).

I'm not sure what you don't understand about this, that ordering is a
membarrier requirement, and it happens to be using an existing barrier
that the lazy mm code had anyway, which is perfectly fine and something
that is done all over the kernel in performance critical code.

>>> - There were too many mmgrab and mmdrop calls, and the call sites had d=
ifferent semantics and different refcounting rules (thanks, kthread).  I cl=
eaned this up.
>>
>> Seems like a decent cleanup. Again lazy tlb specific, just general switc=
h
>> code should be factored and better contained in kernel/sched/ which is
>> fine, but concurrent to lazy tlb improvements.
>=20
> I personally rather dislike the model of:
>=20
> ...
> mmgrab_lazy();
> ...
> mmdrop_lazy();
> ...
> mmgrab_lazy();
> ...
> mmdrop_lazy();
> ...
>=20
> where the different calls have incompatible logic at the call sites and a=
 magic config option NOPs them all away and adds barriers.  I'm personally =
a big fan of cleaning up code before making it even more complicated.

Not sure what model that is though. Call sites don't have to know=20
anything at all about the options or barriers. The rule is simply
that the lazy tlb mm reference is manipulated with the _lazy variants.

It was just mostly duplicated code. Again, can go in parallel and no
dependencies other than mechanical merge.

>=20
>>
>>> - If we do a shootdown instead of a refcount, then, when exit() tears d=
own its mm, we are lazily using *that* mm when we do the shootdowns. If act=
ive_mm continues to point to the being-freed mm and an NMI tries to derefer=
ence it, we=E2=80=99re toast. I fixed those issues.
>>
>> My shoot lazies patch has no such issues with that AFAIKS. What exact=20
>> issue is it and where did you fix it?
>=20
> Without my unlazy_mm_irqs_off() (or something similar), x86's very sensib=
le (and very old!) code to unlazy a lazy CPU when flushing leaves active_mm=
 pointing to the old lazy mm.  That's not a problem at all on current kerne=
ls, but in a shootdown-lazy world, those active_mm pointers will stick arou=
nd.  Even with that fixed, without some care, an NMI during the shootdown C=
PU could dereference ->active_mm at a time when it's not being actively kep=
t alive.
>=20
> Fixed by unlazy_mm_irqs_off(), the patches that use it, and the patches t=
hat make x86 stop inappropriately using ->active_mm.

Oh you're talking about some x86 specific issue where you would have
problems if you didn't do the port properly? Don't tell me this is why
you've been nacking my patches for 15 months.

>>> - If we do a UEFI runtime service call while lazy or a text_poke while =
lazy and the mm goes away while this is happening, we would blow up. Refcou=
nting prevents this but, in current kernels, a shootdown IPI on x86 would n=
ot prevent this.  I fixed these issues (and removed duplicate code).
>>>=20
>>> My point here is that the current lazy mm code is a huge mess. 90% of t=
he complexity in this series is cleaning up core messiness and x86 messines=
s. I would still like to get rid of ->active_mm entirely (it appears to ser=
ve no good purpose on any architecture),  it that can be saved for later, I=
 think.
>>
>> I disagree, the lazy mm code is very clean and simple. And I can't see=20
>> how you would propose to remove active_mm from core code I'm skeptical
>> but would be very interested to see, but that's nothing to do with my
>> shoot lazies patch and can also be concurrent except for mechanical
>> merge issues.
>=20
> I think we may just have to agree to disagree.  The more I looked at the =
lazy code, the more problems I found.  So I fixed them.  That work is done =
now (as far as I'm aware) except for rebasing and review.

I don't see any problems with the lazy tlb mm code outside arch/x86 or=20
anything your series fixed with it aside from a bit of code duplication.

Anyway I will try to take a look over and review bits I can before the
5.18 merge window. For 5.17 my series has been ready to go for a year or
so and very small so let's merge that first since Linus wants to try go
with that approach rather than the refcount one.

Thanks,
Nick
