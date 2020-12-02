Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6922CB2E8
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 03:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgLBCum (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 21:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgLBCum (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 21:50:42 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2823C0613CF;
        Tue,  1 Dec 2020 18:49:59 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l11so307827plt.1;
        Tue, 01 Dec 2020 18:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=kK3Q9wTcGhoxGEIMY0Ll+QkOAdyw6ggQzHJw4qOuYBo=;
        b=pdL+rHdqu9vZr8iSAMFhpbbe1/kXYhSgOjwbgZIvhE/l3SVZzO1LhnQjnoaLWGVZl4
         M8c+NjJu2tub2F6H8k8gWWjXcgbDJp4gKUa4j1+U9N4XPzuCaWDIyztRbcztPyG3ztJx
         mnbn7XKo0qZCxNPxMHgwUJS8r+TtX0KOSXD/9QAArw2VisEk5mEtscjd6SeBtv9b4Hoi
         tWCCSUMhpeKm5oCwErlUeXm/kxSr524TEn1wjfLo4B+EYEAh1va4Ji9yppYQNEQsxMEY
         jCWQmFaKYEiI2A51naOLEBqu4aXSWyKOU2W+ekS9bj9SLU21fHSjE8JrSZY0g8CxoJ5Z
         PMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=kK3Q9wTcGhoxGEIMY0Ll+QkOAdyw6ggQzHJw4qOuYBo=;
        b=GdzhTkyYJQ7/vCducPUc8GKLxl1af+gmUPvBSU0mxX5z79UQmyUpq6M36uZz0kEYf3
         hHaJ6iOzSRuSiDCayaBncDRuR/ZMDGRSwSNIpTBhR4h8YK6shq8mkLI0GuTyj8WCR2ZO
         IJLhhIsjQw317/YF48WtzDLAoolIwFkOPxocaIUBgdqXtpR2sjc6OpdpC56S9QW4lazR
         9N3Rx3n1B/yVPtQuF0wxx4ex3j27W2Z+n30qRAWioPFiWq5mFBrJ3M7r7Iw/BiVLCnDI
         YCG8iNNXOTtvTW/B2PqZvQCleJ7jZML/pabZ8mueiFHYn91M3TzS1HnGIERSmIj21Ily
         SxmA==
X-Gm-Message-State: AOAM531EgoPyuODzQddDkF6JcLdoLL1rUoPsO0O2O/WAkvEMQ79mMnqQ
        zr/JbNBVGkLCw3eynEKynDBXS5/7REs=
X-Google-Smtp-Source: ABdhPJyWh9QiGaql1Lp94BlZmVG3HCxLBZGBrbL9Z7xBftB8HeziAbVbGnP4a+X0o3l7pddCcYYVEA==
X-Received: by 2002:a17:902:fe05:b029:da:7345:c773 with SMTP id g5-20020a170902fe05b02900da7345c773mr664641plj.20.1606877399319;
        Tue, 01 Dec 2020 18:49:59 -0800 (PST)
Received: from localhost ([1.132.177.56])
        by smtp.gmail.com with ESMTPSA id h8sm223576pgg.79.2020.12.01.18.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 18:49:58 -0800 (PST)
Date:   Wed, 02 Dec 2020 12:49:51 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/8] lazy tlb: allow lazy tlb mm switching to be
 configurable
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <20201128160141.1003903-1-npiggin@gmail.com>
        <20201128160141.1003903-6-npiggin@gmail.com>
        <CALCETrWz3hqptsmTHAu1Qb=E8FPhYRVfcO1nhTVHwOpTNq6w1w@mail.gmail.com>
In-Reply-To: <CALCETrWz3hqptsmTHAu1Qb=E8FPhYRVfcO1nhTVHwOpTNq6w1w@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1606876546.8oyicax8hw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of November 29, 2020 10:36 am:
> On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> NOMMU systems could easily go without this and save a bit of code
>> and the refcount atomics, because their mm switch is a no-op. I
>> haven't flipped them over because haven't audited all arch code to
>> convert over to using the _lazy_tlb refcounting.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/Kconfig             | 11 +++++++
>>  include/linux/sched/mm.h | 13 ++++++--
>>  kernel/sched/core.c      | 68 +++++++++++++++++++++++++++++-----------
>>  kernel/sched/sched.h     |  4 ++-
>>  4 files changed, 75 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 56b6ccc0e32d..596bf589d74b 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -430,6 +430,17 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>>           irqs disabled over activate_mm. Architectures that do IPI base=
d TLB
>>           shootdowns should enable this.
>>
>> +# Should make this depend on MMU, because there is little use for lazy =
mm switching
>> +# with NOMMU. Must audit NOMMU architecture code for lazy mm refcountin=
g first.
>> +config MMU_LAZY_TLB
>> +       def_bool y
>> +       help
>> +         Enable "lazy TLB" mmu context switching for kernel threads.
>> +
>> +config MMU_LAZY_TLB_REFCOUNT
>> +       def_bool y
>> +       depends on MMU_LAZY_TLB
>> +
>=20
> This could use some documentation as to what "no" means.

Sure I can add a bit more.

>=20
>>  config ARCH_HAVE_NMI_SAFE_CMPXCHG
>>         bool
>>
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index 7157c0f6fef8..bd0f27402d4b 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -51,12 +51,21 @@ static inline void mmdrop(struct mm_struct *mm)
>>  /* Helpers for lazy TLB mm refcounting */
>>  static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
>>  {
>> -       mmgrab(mm);
>> +       if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
>> +               mmgrab(mm);
>>  }
>>
>>  static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
>>  {
>> -       mmdrop(mm);
>> +       if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
>> +               mmdrop(mm);
>> +       } else {
>> +               /*
>> +                * mmdrop_lazy_tlb must provide a full memory barrier, s=
ee the
>> +                * membarrier comment finish_task_switch.
>=20
> "membarrier comment in finish_task_switch()", perhaps?

Sure.

Thanks,
Nick

