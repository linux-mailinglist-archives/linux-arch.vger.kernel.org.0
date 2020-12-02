Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A282CB2EC
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 03:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgLBCus (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 21:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgLBCur (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 21:50:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6986C0613D6;
        Tue,  1 Dec 2020 18:50:06 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so286461pfn.6;
        Tue, 01 Dec 2020 18:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=rrxTVjl50w/hvvFu6753KKn1qpO44MFkmA/m2ENQPW0=;
        b=U3Sz0euxPXDrCmFLKwiYimm6yyBF1CGZXzT+k7baShme0K69SttxGDVElTYP7xD81J
         2NwdKEYT3Zs9274B6kIHynUHQPZ00KgUdGXc5ha6W25qHfVhMjyjdck0nx62b5X0C5To
         1P9o/31CYlfFtSMNCjiOGhQYR+PUawAmO+HbR9rqzp7uxjtqn81AbD7uKh21gQTcRclr
         sKwpc0TgjomEW3W/Rh8pgDEiycq5f03ojFi19mo+lIT5VM/sT2AJ3raUjTw0OeqLxxxI
         DeTkpxfBTV9HwMT81IfJ5wjehPhqTvkZsBC5tEDMDQr4JcEUe4akPkazAtZiJqIKHcrf
         R1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=rrxTVjl50w/hvvFu6753KKn1qpO44MFkmA/m2ENQPW0=;
        b=GUZTJ0i9FRNulnA84s9vNrjFHDyWrjezX0ybZouULAdZaO1sAXoPcH8dfeQNwDgtp6
         XBQsgEuWXyNUODdiF3tkgzQzZsYE+IydK53uv+dvgIuT6utUVqis4HL/JyZ3FNdDP2hf
         1dX0fy81HUnh5Vksnz5IUg4tX9zVzqADNtHom2ynGbGIaTzB9kZqTxnmK+Mn6/EV0h7a
         wCgjA57rRhjPLJ7vRakTemgbbBYKP1wpjlNlxSHi2X1N21In7GucYmDEMMC9rfCYlEIz
         bq9GgkHsXiN2B6RjUvL5cthqtP+Aj0ThST6GeFPtLXNYBs8mHnCavuOVc2VG4aqzyXR2
         GpIQ==
X-Gm-Message-State: AOAM532IIplIkwTv5gj/ykR1B/a0bHbrWTFqnBcvSq05CsufPtVLkD4s
        boG9YBksk94MuJdhtkl2y4BuH8b4wmAicA==
X-Google-Smtp-Source: ABdhPJx49rJhgYL4DLrmhR3Y7knh5z14lnmGYVTfXlFaVAba7Ker02/OzbTVZiRE1EQln20cmYd6WQ==
X-Received: by 2002:a62:188a:0:b029:19a:cdab:9841 with SMTP id 132-20020a62188a0000b029019acdab9841mr496648pfy.12.1606877406324;
        Tue, 01 Dec 2020 18:50:06 -0800 (PST)
Received: from localhost ([1.132.177.56])
        by smtp.gmail.com with ESMTPSA id z17sm100444pjn.46.2020.12.01.18.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 18:50:05 -0800 (PST)
Date:   Wed, 02 Dec 2020 12:49:58 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/8] lazy tlb: introduce exit_lazy_tlb
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <20201128160141.1003903-1-npiggin@gmail.com>
        <20201128160141.1003903-2-npiggin@gmail.com>
        <CALCETrVbFm7gZ7G_5DWa6UGYtCzZTQvC_CPRVDZ0Lb-tiMnjSg@mail.gmail.com>
In-Reply-To: <CALCETrVbFm7gZ7G_5DWa6UGYtCzZTQvC_CPRVDZ0Lb-tiMnjSg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1606876111.f9oqzur49r.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of November 29, 2020 10:38 am:
> On Sat, Nov 28, 2020 at 8:01 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> This is called at points where a lazy mm is switched away or made not
>> lazy (by its owner switching back).
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/arm/mach-rpc/ecard.c            |  1 +
>>  arch/powerpc/mm/book3s64/radix_tlb.c |  1 +
>>  fs/exec.c                            |  6 ++++--
>>  include/asm-generic/mmu_context.h    | 21 +++++++++++++++++++++
>>  kernel/kthread.c                     |  1 +
>>  kernel/sched/core.c                  |  2 ++
>>  6 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
>> index 827b50f1c73e..43eb1bfba466 100644
>> --- a/arch/arm/mach-rpc/ecard.c
>> +++ b/arch/arm/mach-rpc/ecard.c
>> @@ -253,6 +253,7 @@ static int ecard_init_mm(void)
>>         current->mm =3D mm;
>>         current->active_mm =3D mm;
>>         activate_mm(active_mm, mm);
>> +       exit_lazy_tlb(active_mm, current);
>>         mmdrop(active_mm);
>>         ecard_init_pgtables(mm);
>>         return 0;
>> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book=
3s64/radix_tlb.c
>> index b487b489d4b6..ac3fec03926a 100644
>> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
>> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
>> @@ -661,6 +661,7 @@ static void do_exit_flush_lazy_tlb(void *arg)
>>                 mmgrab(&init_mm);
>>                 current->active_mm =3D &init_mm;
>>                 switch_mm_irqs_off(mm, &init_mm, current);
>> +               exit_lazy_tlb(mm, current);
>>                 mmdrop(mm);
>>         }
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 547a2390baf5..4b4dea1bb7ba 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1017,6 +1017,8 @@ static int exec_mmap(struct mm_struct *mm)
>>         if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
>>                 local_irq_enable();
>>         activate_mm(active_mm, mm);
>> +       if (!old_mm)
>> +               exit_lazy_tlb(active_mm, tsk);
>>         if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
>>                 local_irq_enable();
>>         tsk->mm->vmacache_seqnum =3D 0;
>> @@ -1028,9 +1030,9 @@ static int exec_mmap(struct mm_struct *mm)
>>                 setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
>>                 mm_update_next_owner(old_mm);
>>                 mmput(old_mm);
>> -               return 0;
>> +       } else {
>> +               mmdrop(active_mm);
>>         }
>> -       mmdrop(active_mm);
>=20
> This looks like an unrelated change.

I thought the old style was pointless and made me look twice to make=20
sure we weren't mmdrop()ing the lazy.

>=20
>>         return 0;
>>  }
>>
>> diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu=
_context.h
>> index 91727065bacb..4626d0020e65 100644
>> --- a/include/asm-generic/mmu_context.h
>> +++ b/include/asm-generic/mmu_context.h
>> @@ -24,6 +24,27 @@ static inline void enter_lazy_tlb(struct mm_struct *m=
m,
>>  }
>>  #endif
>>
>> +/*
>> + * exit_lazy_tlb - Called after switching away from a lazy TLB mode mm.
>> + *
>> + * mm:  the lazy mm context that was switched
>> + * tsk: the task that was switched to (with a non-lazy mm)
>> + *
>> + * mm may equal tsk->mm.
>> + * mm and tsk->mm will not be NULL.
>> + *
>> + * Note this is not symmetrical to enter_lazy_tlb, this is not
>> + * called when tasks switch into the lazy mm, it's called after the
>> + * lazy mm becomes non-lazy (either switched to a different mm or the
>> + * owner of the mm returns).
>> + */
>> +#ifndef exit_lazy_tlb
>> +static inline void exit_lazy_tlb(struct mm_struct *mm,
>=20
> Maybe name this parameter prev_lazy_mm?
>=20

mm is better because it's the mm that we're "exiting lazy" from, the=20
function name gives the context.

prev might suggest it was the previous but it's the current one, or
that we're switching to another mm but we may not be at all.

Thanks,
Nick
