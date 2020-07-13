Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497FF21DDD6
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgGMQsW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGMQsW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 12:48:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F8EC061755;
        Mon, 13 Jul 2020 09:48:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s189so1217182pgc.13;
        Mon, 13 Jul 2020 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=INPs3nxni2V4l7Wi5FNDIFPFwYguU/xf1qgvb0BuhC4=;
        b=R+6LRuLZbvncOfmOwYY5q8IVDwZiV+RDPEu6DkwQ7DghW24zrjlhrUTVAvXZR3UUHH
         mkBdeBPq/GcwQRrBAUjLvieWEIgcEhNfLRhInWKe9n46bjAtdCWUhOcKDGBJWiwjkxgR
         6Rj9VkbiyOt3ADuG2ZXGxNQKLMZBBmZCoDqbFodM2xjHs/iLWVOY/Bl5KLgNhYdeleLA
         edC+A3d9UvHuGkddJK37cHRQypGFRiX+ha42c3w/yAXtJr1q/VMTuk7Vb7ki7dk5K3bW
         ZS52GW3lsY3/2uK3rwUG7dp8gk5XfTe7av83x249Xfkf9EShHRcn4+fBVSnTnIstdvKZ
         5a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=INPs3nxni2V4l7Wi5FNDIFPFwYguU/xf1qgvb0BuhC4=;
        b=rv5AQMlSA8PFstTuWDmCpdrMdEzxh7NCQyfTxnFnYruzQpVIzMiHVid7x3AGURvLJ6
         a1h1HdgibBqDKQq1jQEO7kEmaGxS3gHA8Xj+wW5CUoiyqpFk4yXdbovH3PQMK6XWofnH
         KFI4pHlGHKEbfc0xS6145dqJwW25EQZ5VfapGMviNVGi9eXj4TLASYoWsAPeCmBouVz/
         59YAt5wJya0SZid0RAsErtr1eHJCNl7wyFyOqgfRY7bcZ/jwzYZ06SUQfd90yjAHgvw7
         RXXC0kx9zKkglJWl/G7U7ujy0LLZq+ypw2lDzV6EforI2awiXkAcmY1dJK1cib83qLmP
         ePiA==
X-Gm-Message-State: AOAM533EAKdOeMha4FqwoZ1Vx0rdFef0MJkE9KHvU5UpO6Rb9dHNIL/9
        62q4FKwqrg6HYsT2wprkPd4=
X-Google-Smtp-Source: ABdhPJyzYE/gbgNRIvd8T1nEKwOmWyQ0D6wBLrY+CaPnFOU0pgGH0kYtLwOHfmaSiihyfPeLfiiMRg==
X-Received: by 2002:aa7:8ac3:: with SMTP id b3mr723937pfd.45.1594658901764;
        Mon, 13 Jul 2020 09:48:21 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id m68sm121909pje.24.2020.07.13.09.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:48:21 -0700 (PDT)
Date:   Tue, 14 Jul 2020 02:48:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-8-npiggin@gmail.com>
        <CALCETrWbD=3SUOuq9P7Syb+a1DoBjjem8hq9_HCvn7wyqETkpw@mail.gmail.com>
In-Reply-To: <CALCETrWbD=3SUOuq9P7Syb+a1DoBjjem8hq9_HCvn7wyqETkpw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1594658283.qabzoxga67.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of July 14, 2020 1:59 am:
> On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> On big systems, the mm refcount can become highly contented when doing
>> a lot of context switching with threaded applications (particularly
>> switching between the idle thread and an application thread).
>>
>> Abandoning lazy tlb slows switching down quite a bit in the important
>> user->idle->user cases, so so instead implement a non-refcounted scheme
>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
>> any remaining lazy ones.
>>
>> On a 16-socket 192-core POWER8 system, a context switching benchmark
>> with as many software threads as CPUs (so each switch will go in and
>> out of idle), upstream can achieve a rate of about 1 million context
>> switches per second. After this patch it goes up to 118 million.
>>
>=20
> I read the patch a couple of times, and I have a suggestion that could
> be nonsense.  You are, effectively, using mm_cpumask() as a sort of
> refcount.  You're saying "hey, this mm has no more references, but it
> still has nonempty mm_cpumask(), so let's send an IPI and shoot down
> those references too."  I'm wondering whether you actually need the
> IPI.  What if, instead, you actually treated mm_cpumask as a refcount
> for real?  Roughly, in __mmdrop(), you would only free the page tables
> if mm_cpumask() is empty.  And, in the code that removes a CPU from
> mm_cpumask(), you would check if mm_users =3D=3D 0 and, if so, check if
> you just removed the last bit from mm_cpumask and potentially free the
> mm.
>=20
> Getting the locking right here could be a bit tricky -- you need to
> avoid two CPUs simultaneously exiting lazy TLB and thinking they
> should free the mm, and you also need to avoid an mm with mm_users
> hitting zero concurrently with the last remote CPU using it lazily
> exiting lazy TLB.  Perhaps this could be resolved by having mm_count
> =3D=3D 1 mean "mm_cpumask() is might contain bits and, if so, it owns the
> mm" and mm_count =3D=3D 0 meaning "now it's dead" and using some careful
> cmpxchg or dec_return to make sure that only one CPU frees it.
>=20
> Or maybe you'd need a lock or RCU for this, but the idea would be to
> only ever take the lock after mm_users goes to zero.

I don't think it's nonsense, it could be a good way to avoid IPIs.

I haven't seen much problem here that made me too concerned about IPIs=20
yet, so I think the simple patch may be good enough to start with
for powerpc. I'm looking at avoiding/reducing the IPIs by combining the
unlazying with the exit TLB flush without doing anything fancy with
ref counting, but we'll see.

Thanks,
Nick
