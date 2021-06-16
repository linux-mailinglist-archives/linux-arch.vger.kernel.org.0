Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1931C3A8E03
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhFPBEe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 21:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFPBEe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 21:04:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF3FC061574;
        Tue, 15 Jun 2021 18:02:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g22so581659pgk.1;
        Tue, 15 Jun 2021 18:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ZoVtmwAOKak/TM27yLe/rsSgPR3PjnRpu6GHf/Fg/Yk=;
        b=AGbDg0UtusOVrQYBCTriZhlbymMg3F/wJIw+DSg/8fDIMkZpf7wmvcezTu6NbuCra8
         adJw/H6GskZgOgcZJNfM0veaIpKmMti+uibFGDwqgWCLok3e4IZz7OjlfdcbR2ohO5gg
         wMetAqL+9GzvfNBH2M5giKJZbvCG1mfLepo06mNspEwrlwe8GwKgGWqxB+3+hBtw4Yc3
         nUlKB1xjbP/kZyVeKEGtSCdkBB/KwGXJCqZI0sM2+Rot+iItxzwweK66tHAdO7wcMVSO
         646zxbJqR+S3aFLWSrIJchyT+yX/HbGkMXzayozS81H2aNQsP/nwrHO265d+WC2+EQ3Z
         V0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ZoVtmwAOKak/TM27yLe/rsSgPR3PjnRpu6GHf/Fg/Yk=;
        b=lz/lQGSRsA/r/Uyt9BADb2JF5aNK2GxWxC5eWkCRgy8Y/UNhPKPLlPxxnntMPAjRPY
         8Nd2De8Zc/sYwaqN7P38+Bb5DK3SaU7A+ueK5cMCp9Th9WC1cVIMDAcsqsYXZdRs/l7W
         1+8oUvSuMkj8z3KLzibQWdtecS0ESyM7XNrwaqWVfPjlR5dbzhDry0Ybz5wO2KVqNAMY
         y9fYD2toVwePs0rHXaKAGp3tP/FV9AUhEpCbf3TNwD0HzhuFX8GbSJZU30GCq/5r0qLa
         WNa4rCYEXgr4R3G/VtdwZBAGxJHJ+U9VvIfkO3px1/G6Sz5c51OyAe3K+v2X5OKTUSIc
         PQpA==
X-Gm-Message-State: AOAM533bS0EylHLN3r9dUuFvuEEbjmcaZ97f8pEPJOmG97oO8kjPAfi8
        Hr3f/9lEjXT0AE+gjqGJe7I=
X-Google-Smtp-Source: ABdhPJx2VXXsI0QjB3AAzCjAUUOT6GPU9221rXxiBiQykVfxhfc7HTA8F+V7K5QXwYIZdeis5XNSKg==
X-Received: by 2002:a63:c4d:: with SMTP id 13mr2304541pgm.102.1623805347655;
        Tue, 15 Jun 2021 18:02:27 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id 1sm3676108pjm.8.2021.06.15.18.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 18:02:27 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:02:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-3-npiggin@gmail.com>
        <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
        <1623629185.fxzl5xdab6.astroid@bobo.none>
        <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
        <1623643443.b9twp3txmw.astroid@bobo.none>
        <1623645385.u2cqbcn3co.astroid@bobo.none>
        <1623647326.0np4yc0lo0.astroid@bobo.none>
        <aecf5bc8-9018-c021-287d-6a975b7a6235@kernel.org>
        <1623715482.4lskm3cx10.astroid@bobo.none>
        <3b9eb877-5d1e-d565-5577-575229d18b6e@kernel.org>
In-Reply-To: <3b9eb877-5d1e-d565-5577-575229d18b6e@kernel.org>
MIME-Version: 1.0
Message-Id: <1623803360.zd3fo9zm1z.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 16, 2021 10:14 am:
> On 6/14/21 5:55 PM, Nicholas Piggin wrote:
>> Excerpts from Andy Lutomirski's message of June 15, 2021 2:20 am:
>>> Replying to several emails at once...
>>>
>=20
>>=20
>> So the only documentation relating to the current active_mm value or=20
>> refcounting is that it may not match what the x86 specific code is=20
>> doing?
>>=20
>> All this complexity you accuse me of adding is entirely in x86 code.
>> On other architectures, it's very simple and understandable, and=20
>> documented. I don't know how else to explain this.
>=20
> And the docs you referred me to will be *wrong* with your patches
> applied.  They are your patches, and they break the semantics.

No they aren't wrong, I've documented the shootdown refcounting scheme=20
and Linus' historical email is still right about the active_mm concept,
and the refcounting details still match the CONFIG_MMU_TLB_REFCOUNT=3Dy
case.

If you have some particular place you would like to see more=20
documentation added, please tell me where I'll add something before
the series gets upstreamed.

>>>>>>
>>>>>>> With your patch applied:
>>>>>>>
>>>>>>>  To support all that, the "struct mm_struct" now has two counters: =
a
>>>>>>>  "mm_users" counter that is how many "real address space users" the=
re are,
>>>>>>>  and a "mm_count" counter that is the number of "lazy" users (ie an=
onymous
>>>>>>>  users) plus one if there are any real users.
>>>>>>>
>>>>>>> isn't even true any more.
>>>>>>
>>>>>> Well yeah but the active_mm concept hasn't changed. The refcounting=20
>>>>>> change is hopefully reasonably documented?
>>>
>>> active_mm is *only* refcounting in the core code.  See below.
>>=20
>> It's just not. It's passed in to switch_mm. Most architectures except=20
>> for x86 require this.
>>=20
>=20
> Sorry, I was obviously blatantly wrong.  Let me say it differently.
> active_mm does two things:
>=20
> 1. It keeps an mm alive via a refcounting scheme.
>=20
> 2. It passes a parameter to switch_mm() to remind the arch code what the
> most recently switch-to mm was.
>=20
> #2 is basically useless.  An architecture can handle *that* with a
> percpu variable and two lines of code.
>=20
> If you are getting rid of functionality #1 in the core code via a new
> arch opt-out, please get rid of #2 as well.  *Especially* because, when
> the arch asks the core code to stop refcounting active_mm, there is
> absolutely nothing guaranteeing that the parameter that the core code
> will pass to switch_mm() points to memory that hasn't been freed and
> reused for another purpose.

You're confused about the patch. It's not opting out of lazy tlb mm or=20
opting out of active_mm, it is changing how the refcounting is done.

You were just before trying to tell me it would make the code simpler to=20
remove it, but it clearly wouldn't if powerpc just had to reimplement it=20
in arch code anyway, would it?

powerpc is not going to add code to reimplement the exact same thing as=20
active_mm, because it uses active_mm and so does everyone else. For the
last time I'm not going to change that.

That is something x86 wants. This series is not for x86. It doesn't=20
change anything that x86 does. I have kindly tried to give you=20
suggestions and patches about what you might do with x86, and it can=20
easily be changed, but that is not the purpose of my patch. Please don't=20
reply again telling me to get rid of active_mm. We'll draw a line under
this and move on.

>>> I don't understand what contract you're talking about.  The core code
>>> maintains an active_mm counter and keeps that mm_struct from
>>> disappearing.  That's *it*.  The core code does not care that active_mm
>>> is active, and x86 provides evidence of that -- on x86,
>>> current->active_mm may well be completely unused.
>>=20
>> I already acknowledged archs can do their own thing under the covers if=20
>> they want.
>=20
> No.
>=20
> I am *not* going to write x86 patches that use your feature in a way
> that will cause the core code to pass around a complete garbage pointer
> to an mm_struct that is completely unreferenced and may well be deleted.
>  Doing something private in arch code is one thing.  Doing something
> that causes basic common sense to be violated in core code is another
> thing entirely.

I'm talking about the relationship between core code's idea of active_mm=20
and the arch's idea as it stands now. I'm not talking about what you might
do with x86.

The whole point of this was that you have been operating under the=20
misconception that active_mm is not a core kernel concept, because x86=20
has gone and done its own thing and doesn't use it. That does not mean=20
it is not a core kernel concept!

>=20
>>>
>>> static inline void do_switch_mm(struct task_struct *prev_task, ...)
>>> {
>>> #ifdef CONFIG_MMU_TLB_REFCOUNT
>>> 	switch_mm(...);
>>> #else
>>> 	switch_mm(fewer parameters);
>>> 	/* or pass NULL or whatever. */
>>> #endif
>>> }
>>=20
>> And prev_task comes from active_mm, ergo core code requires the concept=20
>> of active_mm.
>=20
> I don't see why this concept is hard.  We are literally quibbling about
> this single line of core code in kernel/sched/core.c:
>=20
> switch_mm_irqs_off(prev->active_mm, next->mm, next);
>=20
> This is not rocket science.  There are any number of ways to fix it.
> For example:
>=20
> #ifdef CONFIG_MMU_TLB_REFCOUNT
> 	switch_mm_irqs_off(prev->active_mm, next->mm, next);
> #else
> 	switch_mm_irqs_off(NULL, next->mm, next);
> #endif
>=20
> If you don't like the NULL, then make the signature depend on the config
> option.
>=20
> What you may not do is what your patch actually does:
>=20
> switch_mm_irqs_off(random invalid pointer, next->mm, next);

You're totally confused about the code, and my patch series. That's not=20
what it does at all. Unless you have spotted a bug, in which case point=20
it out.

>=20
> Now maybe it works because powerpc's lifecycle rules happen to keep
> active_mm alive, but I haven't verified it.  x86's lifecycle rules *do no=
t*.
>=20
>>>>
>>>> That's understandable, but please redirect your objections to the prop=
er=20
>>>> place. git blame suggests 3d28ebceaffab.
>>>
>>> Thanks for the snark.
>>=20
>> Is it not true? I don't mean that one patch causing all the x86=20
>> complexity or even making the situation worse itself. But you seem to be=
=20
>> asking my series to do things that really apply to the x86 changes over
>> the past few years that got us here.
>=20
> With just my patch from 4.15 applied, task->active_mm points to an
> actual mm_struct, and that mm_struct will not be freed early.  If I opt
> x86 into your patch's new behavior, then task->active_mm may be freed.
>=20
> akpm, please drop this series until it's fixed.  It's a core change to
> better support arch usecases, but it's unnecessarily fragile, and there
> is already an arch maintainer pointing out that it's inadequate to
> robustly support arch usecases.  There is no reason to merge it in its
> present state.
>=20

No, you've been sniping these for nearly a year now, and I've been pretty=20
accommodating not pushing it upstream, and trying to get anything out of=20
you, a patch or an actual description of the problem, but it's like=20
getting blood from a stone. I've tried to ask what help x86 needs, but=20
nothing. You didn't even reply to my (actual working) patch or questions=20
about it in the last comment! Doing that then throwing out NAK like it's=20
a magic word is pretty rude really.

The series is fine, it's documented, it works well, it solves a problem
the core code changes are small and reusable, and nobody has pointed out
a bug.

So at this point, just get over it. Do some patches for x86 on top of it=20
later when you have some time. Or Rik might. None of the patches in my=20
series prevents that. I'll be happy to review your changes or adjust=20
some of the code added in this series so it's usable by x86 if you need.
The x86 work could have bee done already with the time bickering about=20
this.

Thanks,
Nick
