Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A8D79E16E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 10:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbjIMIEo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbjIMIEo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 04:04:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453A198C
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 01:04:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401da71b85eso70736025e9.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 01:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694592278; x=1695197078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPWN3g7ekkDjnkl2bbqC6JeTQY1RKOcv/b55LHoasX4=;
        b=csrFx/FGn5VwPfxI/PpcZ/+ogHKFn4phoBDoVWKc3n47c9LF0/fj9Vka15eKJvKgHp
         2PIzsdQY8hExCmcZkjpTN4FbfviFOpD03dNoU7rHicej/Ux4GFUKecng/XLZSeyiGcHE
         bfry1HchVjpznPa7H/j9bjfrexPfcWi2niZbJpFMtsoImd6nG0XBcsBH/zU8qRnYdkLx
         fglxGL6O5sDzhthJUHBlmXtDGcBde4A+BGsA71NUGEGif89dvSEst2XT4klo1LN3AN2D
         J1Q5HjwPjEYVOqOc+2fTp34x1pIf1zlkAvEwS4T1Ug23fyFY1rCHDCGCH49/mA3KG1Qr
         lP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592278; x=1695197078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPWN3g7ekkDjnkl2bbqC6JeTQY1RKOcv/b55LHoasX4=;
        b=Lmeke96HZBzDNwWB4kQb3KzDisJu1DhJNS/tO1QvI+EKzLdyUy7gJNR3jO83t4P7OY
         ia3kya1DMlVjGouyy/cNCQx+8+QeV5eEg3m5HrlEamUJyV4gdKeHxh1oZwSuXnT3kVwH
         zc9IlhEjyg9LTDYBqIhAUkYBvDtzg1W0ICXh5OTDE0grLKicyA94SImbHlRyHNFbKmwN
         4+rHeEjT3iSJeQPXwfCPshV/GNgSM0L49mbdOjIvP0LYgkjRcg0zcruEcvFglRo2p4Ue
         sFPobjWL53g3uP9k7PstnIEW/x1v68e9aU8JnXGqfSIXjkS5yJfIpJggzVPxLqAFnDfj
         1F5w==
X-Gm-Message-State: AOJu0YzRIgTzAN0054WMosmT6df8L1wfaQWYeW1abPN1Q4qvdpgRbEy1
        u3I2fjVNlpsH2uldKq1oXN0ANYQ7fR5zn0ScXE8h1w==
X-Google-Smtp-Source: AGHT+IFHcnsSPP5H7mpSp2WLQ1AsmP2vnqPuf5kEEIlg3PcRjIDekEMoUd66v/YNaqjRaATFe+JBJQROFg/wYya6n0c=
X-Received: by 2002:a7b:cbc8:0:b0:3fe:111a:d1d9 with SMTP id
 n8-20020a7bcbc8000000b003fe111ad1d9mr1465328wmi.25.1694592278218; Wed, 13 Sep
 2023 01:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com> <20230911131224.61924-5-alexghiti@rivosinc.com>
In-Reply-To: <20230911131224.61924-5-alexghiti@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 13 Sep 2023 10:04:27 +0200
Message-ID: <CAHVXubiVH=q9pnTLQyjS3X3W-hvuA=ZMM2D2xYPFkGjFnAgbWg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] riscv: Improve flush_tlb_kernel_range()
To:     Will Deacon <will@kernel.org>,
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
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

@Lad, Prabhakar Any chance you give a try to this new patchset? So
that we make sure Samuel found your issue :)

On Mon, Sep 11, 2023 at 3:16=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
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
