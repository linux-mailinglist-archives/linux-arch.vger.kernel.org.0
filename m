Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BEF793BB8
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIFLta (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjIFLt2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 07:49:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B003CF;
        Wed,  6 Sep 2023 04:49:24 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7951f0e02ecso148900439f.0;
        Wed, 06 Sep 2023 04:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694000963; x=1694605763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=802AAgv3wz2LTyeTpPVTFVHu+dHOc2J+fZFm2H+OBEw=;
        b=kJx8N5GMF04Yc7kBmIBQWcjxMipr4kZ+mYPVQlBGVCtyFzGPj38W7LlLpLmwGxVvOq
         hkbN00osAhfvBRqRozixeEUWnQYreQdLONGn7gohz3BJuBqNIvMW0vDUYq4/iw09EHpB
         fwXj43/oXVHIEQ3HPKmALNnJu3ONBpTIeEs65HubgBHLQLqlIyEohH9cfHj3ozuUs/lW
         V1eNDSFS/nMet1hQ6UnHKt6W5p3SzJFUQgWyyLF+y3j09tX7YKnH4c88+1PKeGhqh6KO
         odqwDpXXpOedA8rxw+dzj971dtS57lO7XhyES+DnyWWh8yi6tmB99N7XsRIOh5akkRDN
         yE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694000963; x=1694605763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=802AAgv3wz2LTyeTpPVTFVHu+dHOc2J+fZFm2H+OBEw=;
        b=iQ3hCRAbfsTb+z9s6I9LBdGm1md+q2eN5b07E+ams7HSf3bOE8JRgGONFe0kXLWUHt
         RtxvqoHKF1sxH6J7ItWh2a9SATxq6yr5H9Ke0ESfYDnsNVBgMXK787k+xh7uCovtbwZX
         ckBZbO/s22rCvdKunpA45EXArwlIs8tupqzxtghVidhfdEt4ekps0p2GCd8XIsp5v38J
         3eaV3A9x2odwsyBBfFq38ixH83pdwedPxmDXnnap76choLjIUsAPLuAfvwayHNEJ5IjN
         tTu/bKwQZw2et1q2ZciQL+EjZ4Dr2biQJDDfoXgwWn6OhVUm8LJL8D4mo4jUDDP/LEcW
         H7PQ==
X-Gm-Message-State: AOJu0Yym5Gkmz7dRCX2bJHBnWvtOu5zfnRat6QMST3OHTHJFGKASt1Ft
        HYgQbiGN8RG9PpTPmQfnJC+fTI0DSHdzsa7pUSY=
X-Google-Smtp-Source: AGHT+IH6DsqPi8SdheBZsKbjp3rpBzMgs3khBwXDcwUm7Ggzj9VNJPHEk/gmeAu63HwwnE9vy9hfNu4uF24UTfDzyME=
X-Received: by 2002:a05:6602:2246:b0:792:72b8:b8a with SMTP id
 o6-20020a056602224600b0079272b80b8amr16942731ioo.18.1694000963404; Wed, 06
 Sep 2023 04:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com> <20230801085402.1168351-5-alexghiti@rivosinc.com>
In-Reply-To: <20230801085402.1168351-5-alexghiti@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 6 Sep 2023 12:48:57 +0100
Message-ID: <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexandre,

On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> This function used to simply flush the whole tlb of all harts, be more
> subtile and try to only flush the range.
>
> The problem is that we can only use PAGE_SIZE as stride since we don't kn=
ow
> the size of the underlying mapping and then this function will be improve=
d
> only if the size of the region to flush is < threshold * PAGE_SIZE.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
>  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 14 deletions(-)
>
After applying this patch, I am seeing module load issues on RZ/Five
(complete log [0]). I am testing defconfig + [1] (rz/five related
configs).

Any pointers on what could be an issue here?

[0] https://paste.debian.net/1291116/
[1] https://paste.debian.net/1291118/

Cheers,
Prabhakar

> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index f5c4fb0ae642..7426fdcd8ec5 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -37,6 +37,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned =
long start,
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end);
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
> @@ -53,15 +54,15 @@ static inline void flush_tlb_range(struct vm_area_str=
uct *vma,
>         local_flush_tlb_all();
>  }
>
> -#define flush_tlb_mm(mm) flush_tlb_all()
> -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> -#endif /* !CONFIG_SMP || !CONFIG_MMU */
> -
>  /* Flush a range of kernel pages */
>  static inline void flush_tlb_kernel_range(unsigned long start,
>         unsigned long end)
>  {
> -       flush_tlb_all();
> +       local_flush_tlb_all();
>  }
>
> +#define flush_tlb_mm(mm) flush_tlb_all()
> +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> +#endif /* !CONFIG_SMP || !CONFIG_MMU */
> +
>  #endif /* _ASM_RISCV_TLBFLUSH_H */
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 0c955c474f3a..687808013758 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -120,18 +120,27 @@ static void __flush_tlb_range(struct mm_struct *mm,=
 unsigned long start,
>                               unsigned long size, unsigned long stride)
>  {
>         struct flush_tlb_range_data ftd;
> -       struct cpumask *cmask =3D mm_cpumask(mm);
> -       unsigned int cpuid;
> +       struct cpumask *cmask, full_cmask;
>         bool broadcast;
>
> -       if (cpumask_empty(cmask))
> -               return;
> +       if (mm) {
> +               unsigned int cpuid;
> +
> +               cmask =3D mm_cpumask(mm);
> +               if (cpumask_empty(cmask))
> +                       return;
> +
> +               cpuid =3D get_cpu();
> +               /* check if the tlbflush needs to be sent to other CPUs *=
/
> +               broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> +       } else {
> +               cpumask_setall(&full_cmask);
> +               cmask =3D &full_cmask;
> +               broadcast =3D true;
> +       }
>
> -       cpuid =3D get_cpu();
> -       /* check if the tlbflush needs to be sent to other CPUs */
> -       broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>         if (static_branch_unlikely(&use_asid_allocator)) {
> -               unsigned long asid =3D atomic_long_read(&mm->context.id) =
& asid_mask;
> +               unsigned long asid =3D mm ? atomic_long_read(&mm->context=
.id) & asid_mask : 0;
>
>                 if (broadcast) {
>                         if (riscv_use_ipi_for_rfence()) {
> @@ -165,7 +174,8 @@ static void __flush_tlb_range(struct mm_struct *mm, u=
nsigned long start,
>                 }
>         }
>
> -       put_cpu();
> +       if (mm)
> +               put_cpu();
>  }
>
>  void flush_tlb_mm(struct mm_struct *mm)
> @@ -196,6 +206,12 @@ void flush_tlb_range(struct vm_area_struct *vma, uns=
igned long start,
>
>         __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>  }
> +
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +       __flush_tlb_range(NULL, start, end, PAGE_SIZE);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
>                         unsigned long end)
> --
> 2.39.2
>
>
