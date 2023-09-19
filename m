Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59E7A6230
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjISMKa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 08:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjISMK3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 08:10:29 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34065F9;
        Tue, 19 Sep 2023 05:10:23 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a86f1befb3so2225167241.1;
        Tue, 19 Sep 2023 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695125422; x=1695730222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otH2l7DgYxaFQnjXnKhV0+9aJ0UN2k5pI6WFG4Jn/ls=;
        b=lqM5GLMF1tplLXAYGb4I9q6dSrOXQNEWh272VlhK+epWaHfR+GxhEh2ExePr3qFaQj
         dEGIq8uYjq9wzHm6I+4A/fWqpjt3dHT+nURU8+flA8tYNGAuLYL49g+s573KqO4O8iOU
         C3l3e6zpv3AWLNdxPHaNuZGcJeBwjqmvwDeyVLGKbICWMJWezc0w14sdu7pK7X12Uw08
         jemSYl/EuIIXNzAHe/mXmZmleUMutqDcJLbdKxR/sfGVyNu1V1VXCEAxrJ4/Tjf9QUqG
         CPrOYmn1gWBtQS1HyFMo09eO1N6M26PdoaUU7kfzyA1gxCKKXOhm1hVoqvkqLLSCNyRf
         IPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125422; x=1695730222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otH2l7DgYxaFQnjXnKhV0+9aJ0UN2k5pI6WFG4Jn/ls=;
        b=JidoMSSJK+TX0snJcXkiAzdtMKsMzJ7eCFDSlb59cUEGOwf2QuRcKq4TYgyJhqTnpM
         NgXEPKKjdelNDP5AwT7LWrNNSbKvwtJnf6N2FQ3e/Th+U1tlSJKR35o0W0+4B7UjZbdR
         eDeXZyniCkpc26hZx1R0MmPwjYnHO4DUN2DUoVjAhwX73POnx+HGvWouKjQHLg0u+eD0
         si5wVtcsrwwatseucz2WkUlgWYutozqFgsfmjni/KHtEWUgfo0miuMWVqNF/1UhY+4Q5
         4xG63egUKHWakrJbXbz4Y8QgiSnb3m2m/foCd83pJykqbDQb+j7FBp9xvkgWKWzgIWw7
         03Ew==
X-Gm-Message-State: AOJu0YwcTuv2DTgum1cXzIoSd+M17SPDylylThQV9IANWl74pVWZp6Xk
        Y83207Y0zZ/aBoOB1YgJvbVHxt8TYh/7HgtsoHk=
X-Google-Smtp-Source: AGHT+IFUoRUYdeh3aal3s8ZGxXglp4Zw/7X1D+5aoErFjGOGnaS1NN/Gz7027xrOyGCLYjU43a35Fj6he61azzqvzWY=
X-Received: by 2002:a1f:c942:0:b0:496:248e:43fc with SMTP id
 z63-20020a1fc942000000b00496248e43fcmr8950298vkf.8.1695125422241; Tue, 19 Sep
 2023 05:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com> <20230911131224.61924-5-alexghiti@rivosinc.com>
In-Reply-To: <20230911131224.61924-5-alexghiti@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 19 Sep 2023 13:09:56 +0100
Message-ID: <CA+V-a8tJUry9G=k-TgPTEFdVJKhhLzfhFO-MSNRRWDb5L3pdHg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] riscv: Improve flush_tlb_kernel_range()
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Will Deacon <will@kernel.org>,
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
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

On Mon, Sep 11, 2023 at 2:16=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
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
>  arch/riscv/include/asm/tlbflush.h | 11 ++++++-----
>  arch/riscv/mm/tlbflush.c          | 33 ++++++++++++++++++++++---------
>  2 files changed, 30 insertions(+), 14 deletions(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #
On RZ/Five SMARC

Cheers,
Prabhakar

> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 170a49c531c6..8f3418c5f172 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -40,6 +40,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned =
long start,
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end);
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
> @@ -56,15 +57,15 @@ static inline void flush_tlb_range(struct vm_area_str=
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
> index 2c1136d73411..28cd8539b575 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -97,19 +97,27 @@ static void __flush_tlb_range(struct mm_struct *mm, u=
nsigned long start,
>                               unsigned long size, unsigned long stride)
>  {
>         struct flush_tlb_range_data ftd;
> -       struct cpumask *cmask =3D mm_cpumask(mm);
> +       struct cpumask *cmask, full_cmask;
>         unsigned long asid =3D FLUSH_TLB_NO_ASID;
> -       unsigned int cpuid;
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
>
> -       cpuid =3D get_cpu();
> -       /* check if the tlbflush needs to be sent to other CPUs */
> -       broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
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
> -       if (static_branch_unlikely(&use_asid_allocator))
> +       if (static_branch_unlikely(&use_asid_allocator) && mm)
>                 asid =3D atomic_long_read(&mm->context.id) & asid_mask;
>
>         if (broadcast) {
> @@ -128,7 +136,8 @@ static void __flush_tlb_range(struct mm_struct *mm, u=
nsigned long start,
>                 local_flush_tlb_range_asid(start, size, stride, asid);
>         }
>
> -       put_cpu();
> +       if (mm)
> +               put_cpu();
>  }
>
>  void flush_tlb_mm(struct mm_struct *mm)
> @@ -189,6 +198,12 @@ void flush_tlb_range(struct vm_area_struct *vma, uns=
igned long start,
>
>         __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>  }
> +
> +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
>                         unsigned long end)
> --
> 2.39.2
>
