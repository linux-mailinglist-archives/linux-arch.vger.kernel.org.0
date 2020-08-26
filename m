Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB852530FD
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHZOPC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgHZOPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:15:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C05C061574;
        Wed, 26 Aug 2020 07:14:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nv17so947272pjb.3;
        Wed, 26 Aug 2020 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=asc1bPjanltrvBpfscIPJeoYc9ISOE48o+/hEQQ6Ews=;
        b=DGUxc1IVrNmfVHRQz38+Vr81E26RqaxVttKM+fqXiG/HNKLGKb5OdHvoJ+QoAYigD4
         XOavGM7i2p8DowniadyrURPXd132ZetOW2PvfBNAu/yhru8QZmAfw98CfUsxpK8fuzK+
         u5q+2EYm6WtOyCXVWD0u9E55hG5tHrJPyMjc3rBkd+58NmaH7tOr8L0gVcTqml/0cu7Z
         Izmnu2rqPGZ3TnBymDB8TWMbmmUBwOXiYDeXg2/xsN579mSXA8+nT6C/KCC8mQjdfVjg
         Gq+ZkEbboLjBsXEBrT194dsOEqelnlFqv47QtLBBPu9oJ5cg+Jqf4G/M0UuVQipGR+/Z
         Avmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=asc1bPjanltrvBpfscIPJeoYc9ISOE48o+/hEQQ6Ews=;
        b=BFlbGvoShBl7Gz1JBCpfBd6YQ4lLXTAVJQ4LrRlGI6tAjhS3h+7DLPLFy3pZX2dOuA
         Bcc+gbDgqsUTXyLH6uY9Bq+n2LKAGLTd43F2ZbD492DgXwmDUZZ0peIW6SSBj9JhIoWH
         51Zz+OBlLnzHU+o3rsAcRkCH0rZ59QpltFqN0zTtNsMBEdltvE3ArpfYggqBdtwnUqlW
         gf2bJIFSRO7AWKVIt0BT7Id303N4jYkNMIWdLsH3/dykN6qt/vDWurt/pNlQbESKNkAg
         pwhvL3vGkh3dDLFDmtUjR/D/2DjhdUGTwwt40j1B6pP1nUAkJpQzqLebfHe+OUR8nfSC
         +aDQ==
X-Gm-Message-State: AOAM533g8sBkkhHAGJJvSW69lMH9kDb96XJWPIt1TInmJB7EX/aSozPH
        b/PrgTJ3XKRuI2aDNSb3QAk6KhO+PQ0=
X-Google-Smtp-Source: ABdhPJyp0KMkicGuVPOzUU9zBQgZCPRN7FDrFvKBeMgrVyfAcfhOGXBdnUGAbBgHTxo7CBRwX+PEag==
X-Received: by 2002:a17:90a:de17:: with SMTP id m23mr6439822pjv.51.1598451298010;
        Wed, 26 Aug 2020 07:14:58 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id a12sm3267771pfr.217.2020.08.26.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:14:57 -0700 (PDT)
Date:   Thu, 27 Aug 2020 00:14:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 04/24] arm: use asm-generic/mmu_context.h for no-op
 implementations
To:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        arcml <linux-snps-arc@lists.infradead.org>
References: <20200728033405.78469-1-npiggin@gmail.com>
        <20200728033405.78469-5-npiggin@gmail.com>
        <86611bf1-13b2-65e5-50d5-b0701020cd3e@synopsys.com>
In-Reply-To: <86611bf1-13b2-65e5-50d5-b0701020cd3e@synopsys.com>
MIME-Version: 1.0
Message-Id: <1598450646.p1afhqiz8e.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Vineet Gupta's message of July 28, 2020 2:14 pm:
> On 7/27/20 8:33 PM, Nicholas Piggin wrote:
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/arm/include/asm/mmu_context.h | 26 +++-----------------------
>>  1 file changed, 3 insertions(+), 23 deletions(-)
>>=20
>> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/m=
mu_context.h
>> index f99ed524fe41..84e58956fcab 100644
>> --- a/arch/arm/include/asm/mmu_context.h
>> +++ b/arch/arm/include/asm/mmu_context.h
>> @@ -26,6 +26,8 @@ void __check_vmalloc_seq(struct mm_struct *mm);
>>  #ifdef CONFIG_CPU_HAS_ASID
>> =20
>>  void check_and_switch_context(struct mm_struct *mm, struct task_struct =
*tsk);
>> +
>> +#define init_new_context init_new_context
>>  static inline int
>>  init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>>  {
>> @@ -92,32 +94,10 @@ static inline void finish_arch_post_lock_switch(void=
)
>> =20
>>  #endif	/* CONFIG_MMU */
>> =20
>> -static inline int
>> -init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>> -{
>> -	return 0;
>> -}
>> -
>> -
>>  #endif	/* CONFIG_CPU_HAS_ASID */
>> =20
>> -#define destroy_context(mm)		do { } while(0)
>>  #define activate_mm(prev,next)		switch_mm(prev, next, NULL)
>=20
> Actually this can also go away too.
>=20
> ARM switch_mm(prev, next, tsk) -> check_and_switch_context(next, tsk) but=
 latter
> doesn't use @tsk at all. With patch below, you can remove above as well..=
.

Thanks for reviewing. I did notice that might be possible but I was=20
avoiding any change that wasn't completely trivial. It's a good point
to continue consolidating and simplifying though.

Thanks,
Nick

>=20
> -------->
> From 672e0f78a94892794057a5a7542d85b71c1369c4 Mon Sep 17 00:00:00 2001
> From: Vineet Gupta <vgupta@synopsys.com>
> Date: Mon, 27 Jul 2020 21:12:42 -0700
> Subject: [PATCH] ARM: mm: check_and_switch_context() doesn't use @tsk arg
>=20
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arm/include/asm/efi.h         | 2 +-
>  arch/arm/include/asm/mmu_context.h | 5 ++---
>  arch/arm/mm/context.c              | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> index 5dcf3c6011b7..0995b308149d 100644
> --- a/arch/arm/include/asm/efi.h
> +++ b/arch/arm/include/asm/efi.h
> @@ -37,7 +37,7 @@ int efi_set_mapping_permissions(struct mm_struct *mm,
> efi_memory_desc_t *md);
>=20
>  static inline void efi_set_pgd(struct mm_struct *mm)
>  {
> -	check_and_switch_context(mm, NULL);
> +	check_and_switch_context(mm);
>  }
>=20
>  void efi_virtmap_load(void);
> diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mm=
u_context.h
> index f99ed524fe41..c96360fa3466 100644
> --- a/arch/arm/include/asm/mmu_context.h
> +++ b/arch/arm/include/asm/mmu_context.h
> @@ -25,7 +25,7 @@ void __check_vmalloc_seq(struct mm_struct *mm);
>=20
>  #ifdef CONFIG_CPU_HAS_ASID
>=20
> -void check_and_switch_context(struct mm_struct *mm, struct task_struct *=
tsk);
> +void check_and_switch_context(struct mm_struct *mm);
>  static inline int
>  init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {
> @@ -47,8 +47,7 @@ static inline void a15_erratum_get_cpumask(int this_cpu=
, struct
> mm_struct *mm,
>=20
>  #ifdef CONFIG_MMU
>=20
> -static inline void check_and_switch_context(struct mm_struct *mm,
> -					    struct task_struct *tsk)
> +static inline void check_and_switch_context(struct mm_struct *mm)
>  {
>  	if (unlikely(mm->context.vmalloc_seq !=3D init_mm.context.vmalloc_seq))
>  		__check_vmalloc_seq(mm);
> diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> index b7525b433f3e..86c411e1d7cb 100644
> --- a/arch/arm/mm/context.c
> +++ b/arch/arm/mm/context.c
> @@ -234,7 +234,7 @@ static u64 new_context(struct mm_struct *mm, unsigned=
 int cpu)
>  	return asid | generation;
>  }
>=20
> -void check_and_switch_context(struct mm_struct *mm, struct task_struct *=
tsk)
> +void check_and_switch_context(struct mm_struct *mm)
>  {
>  	unsigned long flags;
>  	unsigned int cpu =3D smp_processor_id();
> --=20
> 2.20.1
>=20
>=20
