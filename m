Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66839C54A
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 04:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFECzR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 22:55:17 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:37867 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECzQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 22:55:16 -0400
Received: by mail-pg1-f169.google.com with SMTP id t9so9327503pgn.4;
        Fri, 04 Jun 2021 19:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=JOIBq+kEIRNe1HY/dU/O4ueknvMC0Jdakk1cdBJSPGw=;
        b=bmjRiedlJqGYPmfoB1i8FSdNGJRe69WfRRrbZKLnzmCjCN6oYAc7C+cA6rGIaualIa
         l4qfmOQJIsm7mhy2xoCiiJH+FQPWEeFsp+EXdX5NbUH6NsMQaY+MlseKfd3Hvx4uOVGn
         UXRafGp2Fj88+KWaP6+yFK6VGS1/vyvOtdyFE0a+tsXogRE4WZXsTm1ULstUvITaipP4
         epBUGZ2XXQp+BJ0jYpiTueNcZ4TaFVTYz7io/EVMlyKqefZueRmwrZW5ZOgK9kQvVamJ
         /MZu3JkZo3Q7ZQFVUbpZ+xH0misk9s54/+KbVu0/tQItvT6W0oLt0ZQJdJOPg0+V+cNY
         fYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=JOIBq+kEIRNe1HY/dU/O4ueknvMC0Jdakk1cdBJSPGw=;
        b=DZEOS0/9Afz8i8fqjnFVB2Z2id+sigeKBrLZPmBb+GnGUjVfSt8qxtQ2sKwFhcvcSC
         ArynL0t7TyYw1ohbLSwVwW/dhQ+LgRLff7Ojip6e/D86hO6R0Aruv/nmm13g67aXN9ts
         t6ppsiCIwO4LrfaMWxJzYdncsKl9hC5aFEBDyNuwUgrJV+6qnrVohWRnVDdIbCA2mlnr
         qCimqX6cbWJ+MpRlBLcSJ2Pf/RmQkdiZYa5Dg6t2aqi8nG5plPqlyJzI+zqhqXO/dclG
         GeEgHaRKeNlSslXopWvtw+9+3sS97Tib39fLHIOLj4a8pXdKgnY4zmgp35Eel+ZF0E7+
         ooNQ==
X-Gm-Message-State: AOAM531O5/S7l78mekJbs6N9IGJQSgELjKk0wdpHiP4moZCqMAApR9O0
        8PhajBR0EB5GQwtd0k1r9aI=
X-Google-Smtp-Source: ABdhPJxvqDGzb9ptMsdZWbbSUmPkKDSnpbG8bYthCJXvTG4JTcEDkvH65Y6fagb+39d85vOfUJU5mA==
X-Received: by 2002:a62:7b4c:0:b029:2e9:cec2:e252 with SMTP id w73-20020a627b4c0000b02902e9cec2e252mr7446083pfc.56.1622861549693;
        Fri, 04 Jun 2021 19:52:29 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id iq15sm3337816pjb.53.2021.06.04.19.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:52:29 -0700 (PDT)
Date:   Sat, 05 Jun 2021 12:52:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/4] shoot lazy tlbs
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>
References: <20210601062303.3932513-1-npiggin@gmail.com>
        <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
        <991660c3-c2bf-c303-a55c-7454f0cc45f7@kernel.org>
        <1622851909.wxi3vcx3m8.astroid@bobo.none>
        <1622852601.xyhcpcfd7y.astroid@bobo.none>
In-Reply-To: <1622852601.xyhcpcfd7y.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1622861133.mb1njgfop9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of June 5, 2021 10:26 am:
> Excerpts from Nicholas Piggin's message of June 5, 2021 10:17 am:
>> Excerpts from Andy Lutomirski's message of June 5, 2021 3:05 am:
>>> On 6/4/21 9:54 AM, Andy Lutomirski wrote:
>>>> On 5/31/21 11:22 PM, Nicholas Piggin wrote:
>>>>> There haven't been objections to the series since last posting, this
>>>>> is just a rebase and tidies up a few comments minor patch rearranging=
.
>>>>>
>>>>=20
>>>> I continue to object to having too many modes.  I like my more generic
>>>> improvements better.  Let me try to find some time to email again.
>>>>=20
>>>=20
>>> Specifically, this:
>>>=20
>>> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?=
h=3Dx86/mm
>>=20
>> That's worse than what powerpc does with the shoot lazies code so=20
>> we wouldn't use it anyway.
>>=20
>> The fact is mm-cpumask and lazy mm is very architecture specific, so I=20
>> don't really see that another "mode" is such a problem, it's for the=20
>> most part "this is what powerpc does" -> "this is what powerpc does".
>> The only mode in the context switch is just "take a ref on the lazy mm"
>> or "don't take a ref". Surely that's not too onerous to add!?
>>=20
>> Actually the bigger part of it is actually the no-lazy mmu mode which
>> is not yet used, I thought it was a neat little demonstrator of how code
>> works with/without lazy but I will get rid of that for submission.
>=20
> I admit that does add a bit more churn than necessary maybe that was
> the main objection.
>=20
> Here is the entire kernel/sched/core.c change after that is removed.
> Pretty simple now. I'll resubmit.

If it gives you some concerns about a great complex new mode, I'll
put it a different way -- all this allows is the arch to say that it
does not use lazy tlb mms beyond their refcounted lifetime, so there
is no need to refcount the lazy tlb reference.

That's all it is. One implementation of that is shoot lazies, and that
could be done entirely in arch/powerpc via destroy_context (I just put=20
it in mm/ in case it is useful to others, but that's no real=20
difference).

So you see it's really just about management of lazies, the refcounting
is just a bit on the side. And lazy management is highly arch specific,
x86 being one of the really different complex ones there including
very complex and unique interactions with membarrier ordering, so that
can't be a fair objection.

Thanks,
Nick

