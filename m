Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985B33A5C40
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 06:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhFNEtp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 00:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNEto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 00:49:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1CC061574;
        Sun, 13 Jun 2021 21:47:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k15so9639753pfp.6;
        Sun, 13 Jun 2021 21:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=GgivP6wfXR9rSJg48GusfXouXjNtu1u2kxviIHXQuek=;
        b=GZiYNnrjLROl4HyLAb1Mi2k99nTMkX9k32Y7sI+jUqtOAjqoW3wdE0Qdbt4QA71LiF
         C+FQqQ6cmSI5/FCaehqw9Arzp2qtNurvxDjI8iXd3w9Ug18cI2wMQDoKuUPwD0BAjmp7
         NCphqgGDRD5VVe9OBOuEDw5GoRYIu80f1T9t/hdYYZ3kXxuvwNkL+d7ehrI8xkZS1DJB
         N4nbeqsst9z1BsNQkALQgBUw0Baf8ya8r3IQNlc2irR8dPByGvZEzBWy1MV9SHmpCtLv
         sY6INd/ayKtGKD5s/pw4gSseUZdOiY+gBCyVYUMhNYleCr5gj9Vm85IWBIDzT4sNVX8N
         4vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=GgivP6wfXR9rSJg48GusfXouXjNtu1u2kxviIHXQuek=;
        b=Rpgsv/BT4zYgSM+yReDHc31GF7jBEeM6OtkOE/K7cEvteqG/mF2uYrsa7zGVV0JFCg
         OaI5CIiPsA6SM1sGJNSXGBGoPwM7ZIgst8NRBSRj2CdmL1ypeB/raQPGcKOxIUA2Knxh
         lr62envknLFC1GS7qrprKyfz77chSzDtx0x1Uazz4jh7LzvOrjfC0FKx5/VhJCFla+ZW
         4BbsRuydVt4UecCfUFDjImkxxBmEgT022I9EX+FskMQPwxqHG0TgJyIZWxnZ6zy9GcDl
         WU79kj++3Tj3vg5oMJPLxdx8Mz+P9yIQ6rqCNUDKqu0tEdKhUGwU9qAhFStfnW+tNQL6
         zm+Q==
X-Gm-Message-State: AOAM531mC7Ci3ebl3p7NeluSaM5dUvHYU2rK2GTmKoRCja4iQB90KwFh
        pidkuU8YeDscdmyoeGOk//8=
X-Google-Smtp-Source: ABdhPJyIN740d4qJI/bTT+yC6qUfvPgxGu4p98oZQFvuxVV+BViUMjiMYqB8otWkz+zKlzMhlykc6Q==
X-Received: by 2002:a63:5d65:: with SMTP id o37mr1063970pgm.79.1623646047034;
        Sun, 13 Jun 2021 21:47:27 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id mr23sm11061887pjb.12.2021.06.13.21.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 21:47:26 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:47:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-3-npiggin@gmail.com>
        <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
        <1623629185.fxzl5xdab6.astroid@bobo.none>
        <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
        <1623643443.b9twp3txmw.astroid@bobo.none>
In-Reply-To: <1623643443.b9twp3txmw.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1623645385.u2cqbcn3co.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of June 14, 2021 2:14 pm:
> Excerpts from Andy Lutomirski's message of June 14, 2021 1:52 pm:
>> On 6/13/21 5:45 PM, Nicholas Piggin wrote:
>>> Excerpts from Andy Lutomirski's message of June 9, 2021 2:20 am:
>>>> On 6/4/21 6:42 PM, Nicholas Piggin wrote:
>>>>> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb=
 mm
>>>>> when it is context switched. This can be disabled by architectures th=
at
>>>>> don't require this refcounting if they clean up lazy tlb mms when the
>>>>> last refcount is dropped. Currently this is always enabled, which is
>>>>> what existing code does, so the patch is effectively a no-op.
>>>>>
>>>>> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
>>>>
>>>> I am in favor of this approach, but I would be a lot more comfortable
>>>> with the resulting code if task->active_mm were at least better
>>>> documented and possibly even guarded by ifdefs.
>>>=20
>>> active_mm is fairly well documented in Documentation/active_mm.rst IMO.
>>> I don't think anything has changed in 20 years, I don't know what more
>>> is needed, but if you can add to documentation that would be nice. Mayb=
e
>>> moving a bit of that into .c and .h files?
>>>=20
>>=20
>> Quoting from that file:
>>=20
>>   - however, we obviously need to keep track of which address space we
>>     "stole" for such an anonymous user. For that, we have "tsk->active_m=
m",
>>     which shows what the currently active address space is.
>>=20
>> This isn't even true right now on x86.
>=20
> From the perspective of core code, it is. x86 might do something crazy=20
> with it, but it has to make it appear this way to non-arch code that
> uses active_mm.
>=20
> Is x86's scheme documented?
>=20
>> With your patch applied:
>>=20
>>  To support all that, the "struct mm_struct" now has two counters: a
>>  "mm_users" counter that is how many "real address space users" there ar=
e,
>>  and a "mm_count" counter that is the number of "lazy" users (ie anonymo=
us
>>  users) plus one if there are any real users.
>>=20
>> isn't even true any more.
>=20
> Well yeah but the active_mm concept hasn't changed. The refcounting=20
> change is hopefully reasonably documented?
>=20
>>=20
>>=20
>>>> x86 bare metal currently does not need the core lazy mm refcounting, a=
nd
>>>> x86 bare metal *also* does not need ->active_mm.  Under the x86 scheme=
,
>>>> if lazy mm refcounting were configured out, ->active_mm could become a
>>>> dangling pointer, and this makes me extremely uncomfortable.
>>>>
>>>> So I tend to think that, depending on config, the core code should
>>>> either keep ->active_mm [1] alive or get rid of it entirely.
>>>=20
>>> I don't actually know what you mean.
>>>=20
>>> core code needs the concept of an "active_mm". This is the mm that your=
=20
>>> kernel threads are using, even in the unmerged CONFIG_LAZY_TLB=3Dn patc=
h,
>>> active_mm still points to init_mm for kernel threads.
>>=20
>> Core code does *not* need this concept.  First, it's wrong on x86 since
>> at least 4.15.  Any core code that actually assumes that ->active_mm is
>> "active" for any sensible definition of the word active is wrong.
>> Fortunately there is no such code.
>>=20
>> I looked through all active_mm references in core code.  We have:
>>=20
>> kernel/sched/core.c: it's all refcounting, although it's a bit tangled
>> with membarrier.
>>=20
>> kernel/kthread.c: same.  refcounting and membarrier stuff.
>>=20
>> kernel/exit.c: exit_mm() a BUG_ON().
>>=20
>> kernel/fork.c: initialization code and a warning.
>>=20
>> kernel/cpu.c: cpu offline stuff.  wouldn't be needed if active_mm went a=
way.
>>=20
>> fs/exec.c: nothing of interest
>=20
> I might not have been clear. Core code doesn't need active_mm if=20
> active_mm somehow goes away. I'm saying active_mm can't go away because
> it's needed to support (most) archs that do lazy tlb mm switching.
>=20
> The part I don't understand is when you say it can just go away. How?=20
>=20
>> I didn't go through drivers, but I maintain my point.  active_mm is
>> there for refcounting.  So please don't just make it even more confusing
>> -- do your performance improvement, but improve the code at the same
>> time: get rid of active_mm, at least on architectures that opt out of
>> the refcounting.
>=20
> powerpc opts out of the refcounting and can not "get rid of active_mm".
> Not even in theory.

That is to say, it does do a type of reference management that requires=20
active_mm so you can argue it has not entirely opted out of refcounting.
But we're not just doing refcounting for the sake of refcounting! That
would make no sense.

active_mm is required because that's the mm that we have switched to=20
(from core code's perspective), and it is integral to know when to=20
switch to a different mm. See how active_mm is a fundamental concept
in core code? It's part of the contract between core code and the
arch mm context management calls. reference counting follows from there
but it's not the _reason_ for this code.

Pretend the reference problem does not exit (whether by refcounting or=20
shootdown or garbage collection or whatever). We still can't remove=20
active_mm! We need it to know how to call into arch functions like=20
switch_mm.

I don't know if you just forgot that critical requirement in your above=20
list, or you actually are entirely using x86's mental model for this=20
code which is doing something entirely different that does not need it=20
at all. If that is the case I really don't mind some cleanup or wrapper=20
functions for x86 do entirely do its own thing, but if that's the case
you can't criticize core code's use of active_mm due to the current
state of x86. It's x86 that needs documentation and cleaning up.

Thanks,
Nick
