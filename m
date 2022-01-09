Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1D488C23
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 20:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiAITvZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 14:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiAITvY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 14:51:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DCFC06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 11:51:24 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so13841443pjp.0
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=98dpyh8A9USpV8otJk3CFmzicRBFu3ow+x4BkZ38Ivk=;
        b=ZaH2tYY1fYhJSIjzZP3/jYryCAwtbZx6rgvgOs3fVITcFtZw3Cv29hErhN4RWteaU5
         MDDcaYde/ybtSJ8ul3SpoDLiOtC/evCoGm+zzMBTrdeJ5DV66jgkhrx7KyBIQY8sHnzd
         op8FSPRpAcfZ35E3okxK4BD3JEG6DOXWciJej5tl+l0QVuPzbf1qB4Ss3xq3yW/iWc5b
         Wd2m6Kt7osJS6XuZXk8+OSTNK30zQGb3XH3D7M+gidbd7H8hWbN0XfakQNOgs6A1jtMt
         n6LkAlnT/XOAo6G0mSjyjZcfZcOUfERucEDATrwHBxbQMCZ8sexAVWOtAO6sWsEM28pN
         zHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=98dpyh8A9USpV8otJk3CFmzicRBFu3ow+x4BkZ38Ivk=;
        b=vhGMarj+VPxpHOjtOlNp4FUVR0AgwgTcDha0JrFbKk/uPU7Nvaob8hctQioUlMv0KS
         vxco+6ynTqYf+IBWNK39ys7qR1906fHjKYYEkFFv39n0mDR5WYuSMe4QueUdeAdMaTbi
         LuAqftyssx0tUS4bqkBZ/XU7RBAOol0LCuJOG7cPHa4EJ4RoI664GGEHyDm1NrZYks4h
         tv7kEqi3xBK2K86HFqSdd68g0cMo1v+ZqZ71IsDxpDqWSzHYXrdkJPEo8JqdWvo/KzPP
         awVBhVka8qj/8EBwgmTkqxtUi8ifeuVJwybaC+XUZslpPfseLnsVtVU4KqafOXjzT7dT
         wgbw==
X-Gm-Message-State: AOAM530kJGGQ0FCXaaxeDdPoaY+tSeQOcHg1lmVtO1yWkivBcVN+reqC
        SDvW4YaqnhpZ+4H/X5FlTystRI+nOMo=
X-Google-Smtp-Source: ABdhPJzOXh1A+aGz0wFTVLNZ1gmi3kTN7lCOM8srwrAQJSH4YegG3qDGPJijMmA3uHYzumuwB+Bs1Q==
X-Received: by 2002:a17:90a:6843:: with SMTP id e3mr10729111pjm.55.1641757883893;
        Sun, 09 Jan 2022 11:51:23 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id a9sm4302575pfo.169.2022.01.09.11.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jan 2022 11:51:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy
 mms
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <803a5d61426b149abf08e19759e086893e379382.camel@surriel.com>
Date:   Sun, 9 Jan 2022 11:51:21 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C459519-AF2B-457F-8E99-8957BC1FB61F@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
 <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
 <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
 <ba2522fbabc8a81befd27ef20588f9356f7b885b.camel@surriel.com>
 <1B6896F0-7A51-4936-8B50-0B86551FA3B7@gmail.com>
 <803a5d61426b149abf08e19759e086893e379382.camel@surriel.com>
To:     Rik van Riel <riel@surriel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 9, 2022, at 11:37 AM, Rik van Riel <riel@surriel.com> wrote:
>=20
> On Sun, 2022-01-09 at 11:34 -0800, Nadav Amit wrote:
>>=20
>>=20
>>> On Jan 9, 2022, at 11:22 AM, Rik van Riel <riel@surriel.com> wrote:
>>>=20
>>> On Sun, 2022-01-09 at 00:49 -0800, Nadav Amit wrote:
>>>>=20
>>>> It is possible for instance to get rid of is_lazy, keep the CPU
>>>> on mm_cpumask when switching to kernel thread, and then if/when
>>>> an IPI is received remove it from cpumask to avoid further
>>>> unnecessary TLB shootdown IPIs.
>>>>=20
>>>> I do not know whether it is a pure win, but there is a tradeoff.
>>>=20
>>> That's not a win at all. It is what we used to have before
>>> the lazy mm stuff was re-introduced, and it led to quite a
>>> few unnecessary IPIs, which are especially slow on virtual
>>> machines, where the target CPU may not be running.
>>=20
>> You make a good point about VMs.
>>=20
>> IIUC Lazy-TLB serves several goals:
>>=20
>> 1. Avoid arch address-space switch to save switching time and
>>    TLB misses.
>> 2. Prevent unnecessary IPIs while kernel threads run.
>> 3. Avoid cache-contention on mm_cpumask when switching to a kernel
>>    thread.
>>=20
>> Your concern is with (2), and this one is easy to keep regardless
>> of the rest.
>>=20
>> I am not sure that (3) is actually helpful, since it might lead
>> to more cache activity than without lazy-TLB, but that is somewhat
>> orthogonal to everything else.
>=20
> I have seen problems with (3) in practice, too.
>=20
> For many workloads, context switching is much, much more
> of a hot path than TLB shootdowns, which are relatively
> infrequent by comparison.
>=20
> Basically ASID took away only the first concern from your
> list above, not the other two.

I agree, but the point I was trying to make is that you can keep lazy
TLB for (2) and (3), but still switch the address-space. If you
already accept PTI, then the 600 cycles or so of switching the
address space back and forth, which should occur more infrequently
than those on syscalls/exceptions, are not that painful.

You can also make a case that it is =E2=80=9Csafer=E2=80=9D to switch =
the address
space, although SMAP/SMEP protection provides similar properties.=
