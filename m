Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7722203A
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 12:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgGPKDo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 06:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgGPKDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 06:03:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E9CC061755;
        Thu, 16 Jul 2020 03:03:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k5so3638795plk.13;
        Thu, 16 Jul 2020 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=HzIbutGmLrLif9xBPq32ksQXCD4wvXBqbvefIYna8wU=;
        b=bl7dbS4T4uDjdhahJk0bCdTaM3dC1r+F5i8++IxyKP2qnF2Kf/rLnM18Ahb2BQj84+
         X8rk719vY3DynXplaAKcF6U2zU6SW98a3GhFzdFE8OGuy8RFhP7fGa6EV1ETGVQEWTd1
         Mf7XSgUl+AIvYgwE2i17W/Z1qPH34WVz3AxetZZeUeTCl0udyR+Zpi1gXsEDzHchQB5K
         SRsEl2UQID0/PTfY+V12/dgTQxru9rz1uX91W3Ay1wB1rNmszHGR0jNnXufPtbZ7agzA
         GRg3qZAPwI2+KnlBfnWqXmc320TXESStI+zEl+6Cv3EcyGSD+QmPeMPqa26dtaIVA6h/
         j7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=HzIbutGmLrLif9xBPq32ksQXCD4wvXBqbvefIYna8wU=;
        b=rClRJAoGg9J/3Zy/6h2BjOJkX2zMLTFg9awpXBDGchaznekyOFZW8YUKHElNaURWZ0
         Y9TUoQPGYmGqjFQI5+xtWZfzpUukkErK7uG8BJoCpLn55X9GnDjuPZLYlk3vjtBaCfJz
         iJTD1CazzhLyJAqcfLR9lBMarKr8Bv5mIO8IO2PEesqA/0Etccp2GyKQ0A0kLhn3YE5Y
         aeGFFlo0ZDVw5GalpBzvCOeZPWXIcH45CdkMI+CFxFUO21GsTwS4rzXyGu6zL7QyeOg6
         fnlozSkvxbLzX+iI95ZQILpWR9nBPnChOuPagzYyu+kbQGFUdLIKFcTnbgsfexFhhHm4
         6jag==
X-Gm-Message-State: AOAM532WQGIL3JslXZ4ubifqeF2bnIJZqwNOC/kcExXyoCg5wyiXkse6
        zGwsvkL7hHd+l320NI8La38=
X-Google-Smtp-Source: ABdhPJz/0JtE0/eGZGAu9L0wDX7GXQ/CJQgKm6kh7sieTO8a1OloSXoQV79VZaFvU7UdYKEcVxmDrw==
X-Received: by 2002:a17:90b:2351:: with SMTP id ms17mr4083381pjb.105.1594893823195;
        Thu, 16 Jul 2020 03:03:43 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id s194sm4639978pgs.24.2020.07.16.03.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:03:42 -0700 (PDT)
Date:   Thu, 16 Jul 2020 20:03:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86 <x86@kernel.org>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
        <20200716085032.GO10769@hirez.programming.kicks-ass.net>
In-Reply-To: <20200716085032.GO10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1594892300.mxnq3b9a77.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 16, 2020 6:50 pm:
> On Wed, Jul 15, 2020 at 10:18:20PM -0700, Andy Lutomirski wrote:
>> > On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> wrote=
:
>=20
>> > CPU0                     CPU1
>> >                         1. user stuff
>> > a. membarrier()          2. enter kernel
>> > b. read rq->curr         3. rq->curr switched to kthread
>> > c. is kthread, skip IPI  4. switch_to kthread
>> > d. return to user        5. rq->curr switched to user thread
>> >                 6. switch_to user thread
>> >                 7. exit kernel
>> >                         8. more user stuff
>=20
>> I find it hard to believe that this is x86 only. Why would thread
>> switch imply core sync on any architecture?  Is x86 unique in having a
>> stupid expensive core sync that is heavier than smp_mb()?
>=20
> smp_mb() is nowhere near the most expensive barrier we have in Linux,
> mb() might qualify, since that has some completion requirements since it
> needs to serialize against external actors.
>=20
> On x86_64 things are rather murky, we have:
>=20
> 	LOCK prefix -- which implies smp_mb() before and after RmW
> 	LFENCE -- which used to be rmb like, until Spectre, and now it
> 		  is ISYNC like. Since ISYNC ensures an empty pipeline,
> 		  it also implies all loads are retired (and therefore
> 		  complete) it implies rmb.
> 	MFENCE -- which is a memop completion barrier like, it makes
> 		  sure all previously issued memops are complete.
>=20
> if you read that carefully, you'll note you'll have to use LFENCE +
> MFENCE to order against non-memops instructions.
>=20
> But none of them imply dumping the instruction decoder caches, that only
> happens on core serializing instructions like CR3 writes, IRET, CPUID
> and a few others, I think we recently got a SERIALIZE instruction to add
> to this list.
>=20
>=20
> On ARM64 there's something a whole different set of barriers, and again
> smp_mb() isn't nowhere near the top of the list. They have roughly 3
> classes:
>=20
> 	ISB -- instruction sync barrier
> 	DMB(x) -- memory ordering in domain x
> 	DSB(x) -- memory completion in domain x
>=20
> And they have at least 3 domains (IIRC), system, outer, inner.
>=20
> The ARM64 __switch_to() includes a dsb(sy), just like PowerPC used to
> have a SYNC, but since PowerPC is rare for only having one rediculously
> heavy serializing instruction, we got to re-use the smp_mb() early in
> __schedule() instead, but ARM64 can't do that.
>=20
>=20
> So rather than say that x86 is special here, I'd say that PowerPC is
> special here.

PowerPC is "special", I'll agree with you there :)

It does have a SYNC (HWSYNC) instruction that is mb(). It does not
serialize the core.

ISYNC is a nop. ICBI ; ISYNC does serialize the core.

Difference between them is probably much the same as difference between
MFENCE and CPUID on x86 CPUs. Serializing the core is almost always=20
pretty expensive. HWSYNC/MFENCE can be expensive if you have a lot of
or difficult (not exclusive in cache) outstanding with critical reads
after the barrier, but it can also be somewhat cheap if there are few
writes, and executed past, it only needs to hold up subsequent reads.

That said... implementation details. powerpc CPUs have traditionally
had fairly costly HWSYNC.


>> But I=E2=80=99m wondering if all this deferred sync stuff is wrong. In t=
he
>> brave new world of io_uring and such, perhaps kernel access matter
>> too.  Heck, even:
>=20
> IIRC the membarrier SYNC_CORE use-case is about user-space
> self-modifying code.
>=20
> Userspace re-uses a text address and needs to SYNC_CORE before it can be
> sure the old text is forgotten. Nothing the kernel does matters there.
>=20
> I suppose the manpage could be more clear there.

True, but memory ordering of kernel stores from kernel threads for
regular mem barrier is the concern here.

Does io_uring update completion queue from kernel thread or interrupt,
for example? If it does, then membarrier will not order such stores
with user memory accesses.

Thanks,
Nick
