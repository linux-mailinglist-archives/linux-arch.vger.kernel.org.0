Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC582588D8
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 09:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAHO5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAHO4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 03:14:56 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18970C0612AC;
        Tue,  1 Sep 2020 00:14:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i13so182783pjv.0;
        Tue, 01 Sep 2020 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/al16fY+oG7wi8gO1nM/m78+AsYvlumHk2pMFQ3TMsk=;
        b=FzFP0Eel9iYvlia4Nc5BLKhYQ54+BGAO1V2tU/sGXdJi8MQOW6L4pqSSrXN/K6KAXe
         a25uqaPQexMChZ0hBxdfINVvfgzS10W82DNoflEcaI5aMXG5toT7JTuHzaNT0FV8KRr/
         B18beaCY809MMTEtF6Ef2ysrZGWifvmgAlU5X+rxwdirukbTi8/kAgwSlgZ3m7Cuywc9
         QEXehQYQmWmJN4dnov52qhMFMN+vk2Bmyrgpk4i7J7i+RSmIIwb0aDtJy+qGCHuJ5Xdv
         gBFQhGiqxOr/OkbwEPk8j4NEv3747Nbg/NQS1PDVLYmftJSPwqJF/rkesYa1xp8HJkvK
         jseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/al16fY+oG7wi8gO1nM/m78+AsYvlumHk2pMFQ3TMsk=;
        b=hXMqPQF2IdZzrjZyovmRmcMfX17E3p6gGcUOLbNO851aRIQ9dP7XpwmbZPwGTPvTtP
         hCvKZ11Us9a+EpdXA1C1Pt9I/CtMSbNyB1yB0new2xsSnIkcu/pRyGDLIHPAHBFPIA/M
         fI7FeWOxuvFyBlg2bq7YM/HNWoutHOi8UegyACwsLabv2ZCAbS+jSafALNtYft8/vltT
         x5ht6YPuLZcQq1DDzFE5G+O98wCzibiGVNpyNz/V7seBYTFXq2hoNoZIFPog8e556YwF
         ZTNqowlPmX+9RFFxxCJybFkXIOE9H8FH6sTH3z1zAg0KJkdN3RYdQY9wKjGNYMBhNhzu
         A3nA==
X-Gm-Message-State: AOAM532pIrAlCsKzNYEBQjhpGXHz+t8ie4HelvHxmdabUjQ2b2YhrVOQ
        HmjDAoGMhJWRfCyuVMlUcB0=
X-Google-Smtp-Source: ABdhPJy9bArofpAKo5x0vO2HmR7rXYEt3ff/ZWj+qQcrpne0DH/wDOxuF4qjlER9qSn3Qx7ZbAzskQ==
X-Received: by 2002:a17:90b:40cb:: with SMTP id hj11mr294026pjb.67.1598944495637;
        Tue, 01 Sep 2020 00:14:55 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id y7sm555814pfm.68.2020.09.01.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 00:14:55 -0700 (PDT)
Date:   Tue, 01 Sep 2020 17:14:49 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 01/23] asm-generic: add generic MMU versions of mmu
 context functions
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200826145249.745432-1-npiggin@gmail.com>
        <20200826145249.745432-2-npiggin@gmail.com>
        <20200901064942.GD432455@kernel.org>
In-Reply-To: <20200901064942.GD432455@kernel.org>
MIME-Version: 1.0
Message-Id: <1598944165.q4bl4ks3dk.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mike Rapoport's message of September 1, 2020 4:49 pm:
> On Thu, Aug 27, 2020 at 12:52:27AM +1000, Nicholas Piggin wrote:
>> Many of these are no-ops on many architectures, so extend mmu_context.h
>> to cover MMU and NOMMU, and split the NOMMU bits out to nommu_context.h
>>=20
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/microblaze/include/asm/mmu_context.h |  2 +-
>>  arch/sh/include/asm/mmu_context.h         |  2 +-
>>  include/asm-generic/mmu_context.h         | 57 +++++++++++++++++------
>>  include/asm-generic/nommu_context.h       | 19 ++++++++
>>  4 files changed, 64 insertions(+), 16 deletions(-)
>>  create mode 100644 include/asm-generic/nommu_context.h
>>=20
>> diff --git a/arch/microblaze/include/asm/mmu_context.h b/arch/microblaze=
/include/asm/mmu_context.h
>> index f74f9da07fdc..34004efb3def 100644
>> --- a/arch/microblaze/include/asm/mmu_context.h
>> +++ b/arch/microblaze/include/asm/mmu_context.h
>> @@ -2,5 +2,5 @@
>>  #ifdef CONFIG_MMU
>>  # include <asm/mmu_context_mm.h>
>>  #else
>> -# include <asm-generic/mmu_context.h>
>> +# include <asm-generic/nommu_context.h>
>>  #endif
>> diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu=
_context.h
>> index f664e51e8a15..461b1304580b 100644
>> --- a/arch/sh/include/asm/mmu_context.h
>> +++ b/arch/sh/include/asm/mmu_context.h
>> @@ -133,7 +133,7 @@ static inline void switch_mm(struct mm_struct *prev,
>>  #define set_TTB(pgd)			do { } while (0)
>>  #define get_TTB()			(0)
>> =20
>> -#include <asm-generic/mmu_context.h>
>> +#include <asm-generic/nommu_context.h>
>> =20
>>  #endif /* CONFIG_MMU */
>> =20
>> diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu=
_context.h
>> index 6be9106fb6fb..86cea80a50df 100644
>> --- a/include/asm-generic/mmu_context.h
>> +++ b/include/asm-generic/mmu_context.h
>> @@ -3,44 +3,73 @@
>>  #define __ASM_GENERIC_MMU_CONTEXT_H
>> =20
>>  /*
>> - * Generic hooks for NOMMU architectures, which do not need to do
>> - * anything special here.
>> + * Generic hooks to implement no-op functionality.
>>   */
>> =20
>> -#include <asm-generic/mm_hooks.h>
>> -
>>  struct task_struct;
>>  struct mm_struct;
>> =20
>> +/*
>> + * enter_lazy_tlb - Called when "tsk" is about to enter lazy TLB mode.
>> + *
>> + * @mm:  the currently active mm context which is becoming lazy
>> + * @tsk: task which is entering lazy tlb
>> + *
>> + * tsk->mm will be NULL
>> + */
>> +#ifndef enter_lazy_tlb
>>  static inline void enter_lazy_tlb(struct mm_struct *mm,
>>  			struct task_struct *tsk)
>>  {
>>  }
>> +#endif
>> =20
>> +/**
>> + * init_new_context - Initialize context of a new mm_struct.
>> + * @tsk: task struct for the mm
>> + * @mm:  the new mm struct
>=20
> 'make *docs' will complain here about missing Return: description

Thanks, I added something. Looks like we can't get rid of it, sparc
and um can return error. Oh well.

>> + */
>> +#ifndef init_new_context
>>  static inline int init_new_context(struct task_struct *tsk,
>>  			struct mm_struct *mm)
>>  {
>>  	return 0;
>>  }
>> +#endif
>=20
> Most architectures have non-trivial init_new_context, maybe this
> should go into nommu_context.h?

Hmm, I guess you could go either way. A few do have no-op functions so I=20
think that qualifies them if the rule is less ambiguous and we provide=20
no-op for functions unless it does not make any sense (e.g., switch_mm=20
for MMU). More importantly I already have the code written and am lazy =20
:)

Thanks,
Nick
