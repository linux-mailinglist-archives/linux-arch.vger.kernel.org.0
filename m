Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FB227C6E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgGUKEh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgGUKEh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:04:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C48C061794;
        Tue, 21 Jul 2020 03:04:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so3239890wrl.4;
        Tue, 21 Jul 2020 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=9kfZnFlxwbeCeY/sHPCuLSh6ZnXJJMmz+SDIwwbdu9E=;
        b=PKb38cekHSneOmGXC/KZtGcmxXFzo0uUDo9PKOuabHRjjJmTO/z6Rf6B8GM7bpGN2l
         v27E6x4JeQEw+OW9xgdYfjdsPaTbXlp28g77WcgyAvJBTdNXLRhqSncfs9qbTW6Zp7f0
         0ZicUgppvRM/IR1tISm7xSLVgjgktfeqSNut3z+JHVfqHG+WrBNpg4DbP20tQvKwtK1r
         VbtlCDJCISSACgViqAm3m64V97OEEjH0oIcMKkGQWsLszRIAPD7qHrRuLdvN24277gvp
         LN24jlhKmHcf74zx4absN617y+sHbCDBde6REsImTnErRZqqZaLozMgfqAJQ+nMNRIS8
         RgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=9kfZnFlxwbeCeY/sHPCuLSh6ZnXJJMmz+SDIwwbdu9E=;
        b=oveORW5nrXSrQwUDC7gYoH7/PZ7BIda0xqxbbMy2TsuZS5c8U8s6VEfvpeOuReE+UB
         U20NgGNVQv+1jz8s9m4SFSpI4YUJm6FOcQ2ojX1GZoHbvLjc58tC4my3645gPfE6QPiB
         +3v/qZkIH7JoqQlIITrKLAGeKW18pG+ZZgVreE23GDVZfXLnPh/DRtpuF/0Kvw4taBbp
         c/al29WtuckRj+dN2Q17ZLDOeBHJ+Dutb6GQNo2mC14KeFJKaQQ6Rw1yuek3iZ0Xyo8A
         VBaK6ORmpc5+xOo+UUhZ97IsbOv8LTkFGamEfd/i29xEkdtC2Tbw9ucW1LFx6puNo5+q
         pCIw==
X-Gm-Message-State: AOAM530TBlaGBFmXpIPJlXjrpjmkVRf5+UnHYFoBCcs2lN/jh6KI/v66
        w/sdD5V+Utztl+3/pRwOWM7vxzDt
X-Google-Smtp-Source: ABdhPJxkreA8D1lZyT9flEpAyH6rQPt9aOtx31oJEByOFhUEoc5b9sDelo+U3/xY9rHr9llxABm3ZQ==
X-Received: by 2002:adf:e68f:: with SMTP id r15mr17440922wrm.196.1595325875740;
        Tue, 21 Jul 2020 03:04:35 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id s4sm30338553wre.53.2020.07.21.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 03:04:34 -0700 (PDT)
Date:   Tue, 21 Jul 2020 20:04:27 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
        <20200716085032.GO10769@hirez.programming.kicks-ass.net>
        <1594892300.mxnq3b9a77.astroid@bobo.none>
        <20200716110038.GA119549@hirez.programming.kicks-ass.net>
        <1594906688.ikv6r4gznx.astroid@bobo.none>
        <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
        <1595213677.kxru89dqy2.astroid@bobo.none>
        <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
In-Reply-To: <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Message-Id: <1595324577.x3bf55tpgu.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mathieu Desnoyers's message of July 21, 2020 2:46 am:
> ----- On Jul 19, 2020, at 11:03 PM, Nicholas Piggin npiggin@gmail.com wro=
te:
>=20
>> Excerpts from Mathieu Desnoyers's message of July 17, 2020 11:42 pm:
>>> ----- On Jul 16, 2020, at 7:26 PM, Nicholas Piggin npiggin@gmail.com wr=
ote:
>>> [...]
>>>>=20
>>>> membarrier does replace barrier instructions on remote CPUs, which do
>>>> order accesses performed by the kernel on the user address space. So
>>>> membarrier should too I guess.
>>>>=20
>>>> Normal process context accesses like read(2) will do so because they
>>>> don't get filtered out from IPIs, but kernel threads using the mm may
>>>> not.
>>>=20
>>> But it should not be an issue, because membarrier's ordering is only wi=
th
>>> respect
>>> to submit and completion of io_uring requests, which are performed thro=
ugh
>>> system calls from the context of user-space threads, which are called f=
rom the
>>> right mm.
>>=20
>> Is that true? Can io completions be written into an address space via a
>> kernel thread? I don't know the io_uring code well but it looks like
>> that's asynchonously using the user mm context.
>=20
> Indeed, the io completion appears to be signaled asynchronously between k=
ernel
> and user-space.

Yep, many other places do similar with use_mm.

[snip]

> So as far as membarrier memory ordering dependencies are concerned, it re=
lies
> on the store-release/load-acquire dependency chain in the completion queu=
e to
> order against anything that was done prior to the completed requests.
>=20
> What is in-flight while the requests are being serviced provides no memor=
y
> ordering guarantee whatsoever.

Yeah you're probably right in this case I think. Quite likely most kernel=20
tasks that asynchronously write to user memory would at least have some=20
kind of producer-consumer barriers.

But is that restriction of all async modifications documented and enforced
anywhere?

>> How about other memory accesses via kthread_use_mm? Presumably there is
>> still ordering requirement there for membarrier,
>=20
> Please provide an example case with memory accesses via kthread_use_mm wh=
ere
> ordering matters to support your concern.

I think the concern Andy raised with io_uring was less a specific=20
problem he saw and more a general concern that we have these memory=20
accesses which are not synchronized with membarrier.

>> so I really think
>> it's a fragile interface with no real way for the user to know how
>> kernel threads may use its mm for any particular reason, so membarrier
>> should synchronize all possible kernel users as well.
>=20
> I strongly doubt so, but perhaps something should be clarified in the doc=
umentation
> if you have that feeling.

I'd rather go the other way and say if you have reasoning or numbers for=20
why PF_KTHREAD is an important optimisation above rq->curr =3D=3D rq->idle
then we could think about keeping this subtlety with appropriate=20
documentation added, otherwise we can just kill it and remove all doubt.

That being said, the x86 sync core gap that I imagined could be fixed=20
by changing to rq->curr =3D=3D rq->idle test does not actually exist becaus=
e
the global membarrier does not have a sync core option. So fixing the
exit_lazy_tlb points that this series does *should* fix that. So
PF_KTHREAD may be less problematic than I thought from implementation
point of view, only semantics.

Thanks,
Nick
