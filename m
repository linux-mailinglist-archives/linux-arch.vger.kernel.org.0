Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8844E25A8E6
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIBJs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 05:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIBJs4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2020 05:48:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D6C061244;
        Wed,  2 Sep 2020 02:48:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d19so2266523pgl.10;
        Wed, 02 Sep 2020 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ux3HYVB/twlQxBcSTqnhWPU2AHJs+FvCx+/z5WDVFJA=;
        b=QLpYc9FBvtf6jo9nK102wCzMR9/mge0/dioBMTh/v1a4B+JEU/RenX7oalAr56yIZn
         Vw2hcZQ5uRDbXZFueRaM8oVZPG0YRCw31NJIVVC4EIoPjBwdHPXQoxAirsz12JdleEpZ
         c/LNuVRZKxnX+Ok5jSv8Dcx6PdpAzitK30c4CJKUg1abwFyWXck4hjp03VMhAKbrEOO0
         sskujutTj9SZak6W74eCKFWdUgCPpAq3ZYu69/1UgqYEdSjJQwo/yto74hobN8h2uuqY
         iJvsu8wROTb6Do/xdyM4sruaXLKl48VhMRHt69NLg1fHzE/D/k1rMJ6pMfQNXYwaCPRF
         VQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ux3HYVB/twlQxBcSTqnhWPU2AHJs+FvCx+/z5WDVFJA=;
        b=Z9JW96R4ZX5sQZmsfQ/UCKBZt9BD0jpRMkqPWro9iI9OrWwer0CP99YsVcg6ENfxU3
         zW7BjXko4IdSn8v0bpwY/NhRYjDapoddNaytQVwvujo+8UJaAlS4j7nPbRhjTGY0Pezf
         y7qBUD0LYpkKmNCgXD3jffVnCsWyahD4q7/1jWjzsi5Fl5upTdYaVa9kvELXLwd15tLI
         ws/xu+lyQ3DJsjwmc+4NH1jvuKUjjP+xw0/CK0hSEsN299C3gNADRRnQatKZecf4j63d
         zSKEeR3n+kwDAghXqbylTworeGsi5hmjYap6cBf///TglB7YD9MhCeDnHhqFS+X2Y30H
         gaEw==
X-Gm-Message-State: AOAM532VhmCzxkwr+sHkG0FhMC89WgabHnZBhZlt+ZY+/iIp53eV6F8Z
        4lppBDoeqTKuVwxD1Pw1w3CEv+PCmN0=
X-Google-Smtp-Source: ABdhPJw2Gdu85lsEOOBHC+PCTNvx970ucNEWXKOugZTaqo6EkmkDIuAOpg0ck/tyA4uRQCobvrmPXg==
X-Received: by 2002:a63:a08:: with SMTP id 8mr1218714pgk.300.1599040134303;
        Wed, 02 Sep 2020 02:48:54 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id q201sm4899665pfq.80.2020.09.02.02.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:48:53 -0700 (PDT)
Date:   Wed, 02 Sep 2020 19:48:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/4] powerpc/64s/radix: Fix mm_cpumask trimming race vs
 kthread_use_mm
To:     linux-mm@kvack.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20200828100022.1099682-1-npiggin@gmail.com>
        <20200828100022.1099682-5-npiggin@gmail.com>
        <87pn751zcb.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pn751zcb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-Id: <1599040088.z7acx6fvvf.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Michael Ellerman's message of September 1, 2020 10:00 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Commit 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of
>> single-threaded mm_cpumask") added a mechanism to trim the mm_cpumask of
>> a process under certain conditions. One of the assumptions is that
>> mm_users would not be incremented via a reference outside the process
>> context with mmget_not_zero() then go on to kthread_use_mm() via that
>> reference.
>>
>> That invariant was broken by io_uring code (see previous sparc64 fix),
>> but I'll point Fixes: to the original powerpc commit because we are
>> changing that assumption going forward, so this will make backports
>> match up.
>>
>> Fix this by no longer relying on that assumption, but by having each CPU
>> check the mm is not being used, and clearing their own bit from the mask
>> if it's okay. This fix relies on commit 38cf307c1f20 ("mm: fix
>> kthread_use_mm() vs TLB invalidate") to disable irqs over the mm switch,
>> and ARCH_WANT_IRQS_OFF_ACTIVATE_MM to be enabled.
>=20
> You could use:
>=20
> Depends-on: 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB invalidate")

Good idea I wil.

>> Fixes: 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of singl=
e-threaded mm_cpumask")
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/include/asm/tlb.h       | 13 -------------
>>  arch/powerpc/mm/book3s64/radix_tlb.c | 23 ++++++++++++++++-------
>>  2 files changed, 16 insertions(+), 20 deletions(-)
>=20
> One minor nit below if you're respinning anyway.
>=20
> You know this stuff better than me, but I still reviewed it and it seems
> good to me.
>=20
> Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks.

>=20
>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/t=
lb.h
>> index fbc6f3002f23..d97f061fecac 100644
>> --- a/arch/powerpc/include/asm/tlb.h
>> +++ b/arch/powerpc/include/asm/tlb.h
>> @@ -66,19 +66,6 @@ static inline int mm_is_thread_local(struct mm_struct=
 *mm)
>>  		return false;
>>  	return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
>>  }
>> -static inline void mm_reset_thread_local(struct mm_struct *mm)
>> -{
>> -	WARN_ON(atomic_read(&mm->context.copros) > 0);
>> -	/*
>> -	 * It's possible for mm_access to take a reference on mm_users to
>> -	 * access the remote mm from another thread, but it's not allowed
>> -	 * to set mm_cpumask, so mm_users may be > 1 here.
>> -	 */
>> -	WARN_ON(current->mm !=3D mm);
>> -	atomic_set(&mm->context.active_cpus, 1);
>> -	cpumask_clear(mm_cpumask(mm));
>> -	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
>> -}
>>  #else /* CONFIG_PPC_BOOK3S_64 */
>>  static inline int mm_is_thread_local(struct mm_struct *mm)
>>  {
>> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book=
3s64/radix_tlb.c
>> index 0d233763441f..a421a0e3f930 100644
>> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
>> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
>> @@ -645,19 +645,29 @@ static void do_exit_flush_lazy_tlb(void *arg)
>>  	struct mm_struct *mm =3D arg;
>>  	unsigned long pid =3D mm->context.id;
>> =20
>> +	/*
>> +	 * A kthread could have done a mmget_not_zero() after the flushing CPU
>> +	 * checked mm_users =3D=3D 1, and be in the process of kthread_use_mm =
when
>                                 ^
>                                 in mm_is_singlethreaded()
>=20
> Adding that reference would help join the dots for a new reader I think.

Yes you're right I can change that.

Thanks,
Nick
