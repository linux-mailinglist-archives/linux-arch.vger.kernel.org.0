Return-Path: <linux-arch+bounces-1139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2C819705
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 04:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6DE281718
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 03:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0498BF6;
	Wed, 20 Dec 2023 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XrXFybqQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48518F59
	for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1eb39505ba4so3096727fac.0
        for <linux-arch@vger.kernel.org>; Tue, 19 Dec 2023 18:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703041174; x=1703645974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apsQTMh+wzleRxg4vNWLqcpSsKcn0wPXDH5u/impo2s=;
        b=XrXFybqQ52PeAe4YxMhvZuWcT22D3Vdz0+pFgUEhdV5DIIfoitW3/yYhHhLo8wMuAl
         4Ynv4X9rVKMB1jVHR1FojAYCsVBk/tuLe8KNWfYztKjVSueX/QAlBup92VhgcHMQ6UWo
         rVJFQEO83uvtEGU4P2nQEa3F9ednsrNI9sO8ZtOjrbl2nWRRhc4U4R+S7/CtIAhUdGyK
         wnWYv6c3A6Jjhu8Y+GRiAgKNcg/nk1WwVuV9IaHWtgBfLpyG7v/jdrJN6Hst8NLR1OI0
         eCD243FfUtEO0dflxJ5A40ewN84SD7nCjWfu6W/2WQmYemDoq7NZLcice61kdWd8E5/R
         MDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703041174; x=1703645974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apsQTMh+wzleRxg4vNWLqcpSsKcn0wPXDH5u/impo2s=;
        b=VItCo/kw/mN/2nCX/jEPGlX6WjKH1T7uHw1mMOpRXxRnaNrKqu47OJVYzGHQNISkHZ
         pVcHng+7YEUkk9JxjkIkCL1aqV6qMiE91rrf3cuhtf/PyEafwLu2GqLwsOq2yCJdkFDX
         B1sFGl1xi/Z/mJhmRUugDHtUrhmu4evEaPzj4aeTzGzaQyBl9QF3C5qSpU8uRgoSIjKp
         KFGOcJ0ueWP+PXoCTjw451LUlK/IqoRqI4Jr6rSDeGTaQmPAsjxoG9/k2ryN2hlASvNA
         fEV1mKWv34gypbptQOtfnLdj7IXmXjXq29guUGKjyM2VGVD8FB3qpzNafK38pNZctLNg
         6mCA==
X-Gm-Message-State: AOJu0YyShQ5t7pBwS3Xtklj8bHXSNMLAvgg70vLrSmfQEQRM7aZuK6y7
	OTx14fORungVYwEdJTc/4f3WRncZypY7jsW2z+sZag==
X-Google-Smtp-Source: AGHT+IHkJO5ZOUzVzVAm0OW2c+XOHReGlsuOrQcjDbsf2O8ij6x/MrBLjV3275c/hmg9Ct7seUt4KRT1EBT+KWFvojQ=
X-Received: by 2002:a05:6870:3929:b0:204:20b:2de with SMTP id
 b41-20020a056870392900b00204020b02demr1067684oap.35.1703041173827; Tue, 19
 Dec 2023 18:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219175046.2496-1-jszhang@kernel.org> <20231219175046.2496-3-jszhang@kernel.org>
In-Reply-To: <20231219175046.2496-3-jszhang@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 20 Dec 2023 10:59:22 +0800
Message-ID: <CAEEQ3wn6j0N-NSQjEqE8Ee9dGzGMJJ4CW2Yhw_njAaOgR8G_eQ@mail.gmail.com>
Subject: Re: [External] [PATCH 2/4] riscv: tlb: convert __p*d_free_tlb() to
 inline functions
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Wed, Dec 20, 2023 at 2:04=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> This is to prepare for enabling MMU_GATHER_RCU_TABLE_FREE.
> No functionality changes.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/pgalloc.h | 54 +++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pg=
alloc.h
> index a12fb83fa1f5..3c5e3bd15f46 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -95,13 +95,16 @@ static inline void pud_free(struct mm_struct *mm, pud=
_t *pud)
>                 __pud_free(mm, pud);
>  }
>
> -#define __pud_free_tlb(tlb, pud, addr)                                 \
> -do {                                                                   \
> -       if (pgtable_l4_enabled) {                                       \
> -               pagetable_pud_dtor(virt_to_ptdesc(pud));                \
> -               tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));     \
> -       }                                                               \
> -} while (0)
> +static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
> +                                 unsigned long addr)
> +{
> +       if (pgtable_l4_enabled) {
> +               struct ptdesc *ptdesc =3D virt_to_ptdesc(pud);
> +
> +               pagetable_pud_dtor(ptdesc);
> +               tlb_remove_page_ptdesc(tlb, ptdesc);
> +       }
> +}
>
>  #define p4d_alloc_one p4d_alloc_one
>  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long a=
ddr)
> @@ -130,11 +133,12 @@ static inline void p4d_free(struct mm_struct *mm, p=
4d_t *p4d)
>                 __p4d_free(mm, p4d);
>  }
>
> -#define __p4d_free_tlb(tlb, p4d, addr)                                 \
> -do {                                                                   \
> -       if (pgtable_l5_enabled)                                         \
> -               tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));     \
> -} while (0)
> +static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> +                                 unsigned long addr)
> +{
> +       if (pgtable_l5_enabled)
> +               tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
> +}
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
>  static inline void sync_kernel_mappings(pgd_t *pgd)
> @@ -159,19 +163,25 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm=
)
>
>  #ifndef __PAGETABLE_PMD_FOLDED
>
> -#define __pmd_free_tlb(tlb, pmd, addr)                         \
> -do {                                                           \
> -       pagetable_pmd_dtor(virt_to_ptdesc(pmd));                \
> -       tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));     \
> -} while (0)
> +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
> +                                 unsigned long addr)
> +{
> +       struct ptdesc *ptdesc =3D virt_to_ptdesc(pmd);
> +
> +       pagetable_pmd_dtor(ptdesc);
> +       tlb_remove_page_ptdesc(tlb, ptdesc);
> +}
>
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
> -#define __pte_free_tlb(tlb, pte, buf)                  \
> -do {                                                   \
> -       pagetable_pte_dtor(page_ptdesc(pte));           \
> -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
> -} while (0)
> +static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> +                                 unsigned long addr)
> +{
> +       struct ptdesc *ptdesc =3D page_ptdesc(pte);
> +
> +       pagetable_pte_dtor(ptdesc);
> +       tlb_remove_page_ptdesc(tlb, ptdesc);
> +}
>  #endif /* CONFIG_MMU */
>
>  #endif /* _ASM_RISCV_PGALLOC_H */
> --
> 2.40.0
>

Why is it necessary to convert to inline functions?

Thanks,
Yunhui

