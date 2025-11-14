Return-Path: <linux-arch+bounces-14753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F7C5D98F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 15:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32496364D74
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95509320A3B;
	Fri, 14 Nov 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6kGJMPG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CD31AF0E
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129889; cv=none; b=bp1OwNZD6DA5dUQxBLtl1VzHyY8ubldPlrHWp+OYXgJt0wH9/Nm0d4jjvfkVet5yv1Ytg3rVOmdzm2e6yOOpHGG/2kDF+RKxKaNwm13fOuS0J2zjWXq7JKN6Bg/E51Pc8QUYIb17UEXJxGfduBOwnCkq6BZG+p1OIAMsFZ/ZF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129889; c=relaxed/simple;
	bh=FAWHKTbojrVdbFJ8884Lh9DTaMatsBJR+ahGaIp46Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGaD9WZK9zcE9rkgXsdVWsiNXsFx+6wwPBFJNxyVVnWHVRK85R5DWV72ASp8Wf0VQdZgbnpJz/kGbv1VbeW8Jubt2I6Ezghhw4Lw7YxTntSbXM15GeYwyWTwPhP2t4xEakjE22k4BpqrqX6tnFQ7kAhVA2YpV5Ul4HCSBrXbnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6kGJMPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A35DC2BCB0
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763129889;
	bh=FAWHKTbojrVdbFJ8884Lh9DTaMatsBJR+ahGaIp46Mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p6kGJMPGPO4zhpMUmlK1tkVdWLKi0QGIypBU+p95zDqcd+pZowWKhEf6ejWqW4yoZ
	 ppDZobHsg4oFBstR9nfLvP7LotZhd03W0gLFcgXkdbIl9gzSd8NzEtcmAKiX8JNkEq
	 AkfuN0V/0mNO/ac65VkYiv5phg2ILI8Y4QOjMVL4KPqgSEuDas+wGNlmtQk/xTdxZB
	 LAhoMr1qcbKLx+FqvqyKVAQfLmhOZ+LqeNleJvo7L9SmaaqrZwafDKouEuEOKyWY8A
	 bjynM/Z2VdSW/VCRw9yYO3zav1+Un7AYJtdn5oQHqA28L5S0Dgb0JOQortqUBXJCOk
	 6QZCfGCd7yKPQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b737502f77bso51211066b.2
        for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 06:18:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1d59xKBWuKkKI5AkQ2417caADE4WmwOykd1sQlQG7aNgSBE19UF41FM3xk0VZbBsBDH2VnVZHbCD5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcj2FW18QZhkhvv7vuKYygj5cGWTUxh4hIma5gxbvQyR1mMrtF
	J53AhV2cM1A69Yngegf7Oat4uIkxKMAS2GQTU44RKKWbHzUzSbxluey03NR8yQ7l/KLYfViWt4D
	SwdrcpdR4ATISEIhiu5ZjioKqp+ovPSA=
X-Google-Smtp-Source: AGHT+IH2APpWlx01lvRmsEjk25T/BroXvRMmdJoqcqdhkk/l43ih7kDnYxsJFdqG1+mvDKp0yNH6Z0TrYw4LGkrxjmI=
X-Received: by 2002:a17:907:748:b0:b70:b661:cfcb with SMTP id
 a640c23a62f3a-b73678ee3a8mr261903966b.31.1763129887364; Fri, 14 Nov 2025
 06:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763117269.git.zhengqi.arch@bytedance.com> <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
In-Reply-To: <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Nov 2025 22:17:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
X-Gm-Features: AWmQ_bnB_yOPM8We43AKxCyF0R_mmEJVAbU9qloFW-YqOpGJ4QJ0yARhVtFDLLs
Message-ID: <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
Subject: Re: [PATCH 3/7] loongarch: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org, 
	david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qi Zheng,

We usually use LoongArch rather than loongarch, but if you want to
keep consistency for all patches, just do it.

On Fri, Nov 14, 2025 at 7:13=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> ---
>  arch/loongarch/Kconfig               | 1 +
>  arch/loongarch/include/asm/pgalloc.h | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 5b1116733d881..3bf2f2a9cd647 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -210,6 +210,7 @@ config LOONGARCH
>         select USER_STACKTRACE_SUPPORT
>         select VDSO_GETRANDOM
>         select ZONE_DMA32
> +       select MMU_GATHER_RCU_TABLE_FREE
Please use alpha-betical order.

>
>  config 32BIT
>         bool
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/includ=
e/asm/pgalloc.h
> index 1c63a9d9a6d35..0539d04bf1525 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -79,7 +79,8 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm=
, unsigned long address)
>         return pmd;
>  }
>
> -#define __pmd_free_tlb(tlb, x, addr)   pmd_free((tlb)->mm, x)
> +#define __pmd_free_tlb(tlb, x, addr)   \
> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
I think we can define it in one line.

>
>  #endif
>
> @@ -99,7 +100,8 @@ static inline pud_t *pud_alloc_one(struct mm_struct *m=
m, unsigned long address)
>         return pud;
>  }
>
> -#define __pud_free_tlb(tlb, x, addr)   pud_free((tlb)->mm, x)
> +#define __pud_free_tlb(tlb, x, addr)   \
> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
The same.

Other patches have the same problem.

Huacai

>
>  #endif /* __PAGETABLE_PUD_FOLDED */
>
> --
> 2.20.1
>

