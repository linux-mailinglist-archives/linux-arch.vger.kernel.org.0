Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5917A622B
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 14:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjISMJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjISMJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 08:09:52 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F2A9;
        Tue, 19 Sep 2023 05:09:46 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-495c10cec8aso2066481e0c.1;
        Tue, 19 Sep 2023 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695125385; x=1695730185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2TeDM1ujR0ck1FRETeocvVKHFWipuxs4eJXy3roKNQ=;
        b=Io0J27YRZbEVVsQKP42oCzuZhZ5cWZDqfMRFW276k88L2onNab0JSRz/e7JxAA4Hpm
         DZMMb8AFCavrgYGFIx6NWlNYp6cQlqoqbllH4Mi1hVjbK/yvZLtg6Cgd7c886XgUzgtB
         fT1ULH4KjMjA8NKPQUmpobZeHmK27P+e5dUpUNgVQmIvQRHekrxEaYfyJkT7qGm0kV5D
         sN+BMjlB78Ov47t3Cvq1Tr7wB5wg3BEGDBxAY0RqfybcZis8FZoAM3azHvjH8R/FpMpb
         AA5JJDLRhgn3a1/9PqhnF2foux8lQmghlIW3G0Vkc5cDdSRoR29cLEtRExgwkX1iceXB
         dZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125385; x=1695730185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2TeDM1ujR0ck1FRETeocvVKHFWipuxs4eJXy3roKNQ=;
        b=GJ1suWLcu9TEeGSqs85K6mmschj/nO66/QncYtLr1GiEhGIBsnk/3hAliT4igWdy6L
         Sh8OmLPk+OYQ6w2XLLCmO2g39u76CqxKXMxoNYr6bYzn3kl46iWt+Dmt9VFRV3GL4c1A
         dP/zDM4qdcQZeForYdSYVv7lFSERJcYvnOrliqc0uw+VcAoSHXoS3QweSTOD7Yh/wGIq
         fMxhYl0wRnG8Z+lW3S++O7H6uePYf64MpIpq5gcNqYTkYPURMOmUg5PeVu7lOmf5rCO2
         fCTVdd5IGwBV6vOu4it2yT1L1NlSVmfg+31zGWhj05v7wQL9vHXyOMIjiYknM+0hlMm0
         6gEg==
X-Gm-Message-State: AOJu0Yythu/F5Xr+D22Z2yzMmftV9KGWfMUUAeLVTpA0Ff/ruykYi3mA
        G51kOArlyWqAnogWGrlxN0Yqjd8i2MsZKF1dXSc=
X-Google-Smtp-Source: AGHT+IGjusJlmZ8fxVb1jKIdwHgKaKEeXTFuXxEJK4Dlz9gvhqLsIJR2q40lRaaX1DXsIoz8gnKXZ6ZL6gGJpVoMC8Y=
X-Received: by 2002:a1f:4a47:0:b0:48f:280a:1d58 with SMTP id
 x68-20020a1f4a47000000b0048f280a1d58mr9241951vka.5.1695125385356; Tue, 19 Sep
 2023 05:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com> <20230911131224.61924-4-alexghiti@rivosinc.com>
In-Reply-To: <20230911131224.61924-4-alexghiti@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 19 Sep 2023 13:09:18 +0100
Message-ID: <CA+V-a8vJRdgq0zYZL7w2cDYfChr=L+ogF7GzRtD5Xp88NuEU2Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] riscv: Make __flush_tlb_range() loop over pte
 instead of flushing the whole tlb
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11, 2023 at 2:15=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Currently, when the range to flush covers more than one page (a 4K page o=
r
> a hugepage), __flush_tlb_range() flushes the whole tlb. Flushing the whol=
e
> tlb comes with a greater cost than flushing a single entry so we should
> flush single entries up to a certain threshold so that:
> threshold * cost of flushing a single entry < cost of flushing the whole
> tlb.
>
> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h      |   3 -
>  arch/riscv/include/asm/tlbflush.h |   3 +
>  arch/riscv/kernel/sbi.c           |  32 +++------
>  arch/riscv/mm/tlbflush.c          | 115 +++++++++++++++---------------
>  4 files changed, 72 insertions(+), 81 deletions(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #
On RZ/Five SMARC

Cheers,
Prabhakar

> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 5b4a1bf5f439..b79d0228144f 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -273,9 +273,6 @@ void sbi_set_timer(uint64_t stime_value);
>  void sbi_shutdown(void);
>  void sbi_send_ipi(unsigned int cpu);
>  int sbi_remote_fence_i(const struct cpumask *cpu_mask);
> -int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
> -                          unsigned long start,
> -                          unsigned long size);
>
>  int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
>                                 unsigned long start,
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index f5c4fb0ae642..170a49c531c6 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -11,6 +11,9 @@
>  #include <asm/smp.h>
>  #include <asm/errata_list.h>
>
> +#define FLUSH_TLB_MAX_SIZE      ((unsigned long)-1)
> +#define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
> +
>  #ifdef CONFIG_MMU
>  extern unsigned long asid_mask;
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index c672c8ba9a2a..5a62ed1da453 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -11,6 +11,7 @@
>  #include <linux/reboot.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
> +#include <asm/tlbflush.h>
>
>  /* default SBI version is 0.1 */
>  unsigned long sbi_spec_version __ro_after_init =3D SBI_SPEC_VERSION_DEFA=
ULT;
> @@ -376,32 +377,15 @@ int sbi_remote_fence_i(const struct cpumask *cpu_ma=
sk)
>  }
>  EXPORT_SYMBOL(sbi_remote_fence_i);
>
> -/**
> - * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given re=
mote
> - *                          harts for the specified virtual address rang=
e.
> - * @cpu_mask: A cpu mask containing all the target harts.
> - * @start: Start of the virtual address
> - * @size: Total size of the virtual address range.
> - *
> - * Return: 0 on success, appropriate linux error code otherwise.
> - */
> -int sbi_remote_sfence_vma(const struct cpumask *cpu_mask,
> -                          unsigned long start,
> -                          unsigned long size)
> -{
> -       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> -                           cpu_mask, start, size, 0, 0);
> -}
> -EXPORT_SYMBOL(sbi_remote_sfence_vma);
> -
>  /**
>   * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on giv=
en
> - * remote harts for a virtual address range belonging to a specific ASID=
.
> + * remote harts for a virtual address range belonging to a specific ASID=
 or not.
>   *
>   * @cpu_mask: A cpu mask containing all the target harts.
>   * @start: Start of the virtual address
>   * @size: Total size of the virtual address range.
> - * @asid: The value of address space identifier (ASID).
> + * @asid: The value of address space identifier (ASID), or FLUSH_TLB_NO_=
ASID
> + * for flushing all address spaces.
>   *
>   * Return: 0 on success, appropriate linux error code otherwise.
>   */
> @@ -410,8 +394,12 @@ int sbi_remote_sfence_vma_asid(const struct cpumask =
*cpu_mask,
>                                 unsigned long size,
>                                 unsigned long asid)
>  {
> -       return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> -                           cpu_mask, start, size, asid, 0);
> +       if (asid =3D=3D FLUSH_TLB_NO_ASID)
> +               return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> +                                   cpu_mask, start, size, 0, 0);
> +       else
> +               return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID=
,
> +                                   cpu_mask, start, size, asid, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 5bda6d4fed90..2c1136d73411 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -9,28 +9,50 @@
>
>  static inline void local_flush_tlb_all_asid(unsigned long asid)
>  {
> -       __asm__ __volatile__ ("sfence.vma x0, %0"
> -                       :
> -                       : "r" (asid)
> -                       : "memory");
> +       if (asid !=3D FLUSH_TLB_NO_ASID)
> +               __asm__ __volatile__ ("sfence.vma x0, %0"
> +                               :
> +                               : "r" (asid)
> +                               : "memory");
> +       else
> +               local_flush_tlb_all();
>  }
>
>  static inline void local_flush_tlb_page_asid(unsigned long addr,
>                 unsigned long asid)
>  {
> -       __asm__ __volatile__ ("sfence.vma %0, %1"
> -                       :
> -                       : "r" (addr), "r" (asid)
> -                       : "memory");
> +       if (asid !=3D FLUSH_TLB_NO_ASID)
> +               __asm__ __volatile__ ("sfence.vma %0, %1"
> +                               :
> +                               : "r" (addr), "r" (asid)
> +                               : "memory");
> +       else
> +               local_flush_tlb_page(addr);
>  }
>
> -static inline void local_flush_tlb_range(unsigned long start,
> -               unsigned long size, unsigned long stride)
> +/*
> + * Flush entire TLB if number of entries to be flushed is greater
> + * than the threshold below.
> + */
> +static unsigned long tlb_flush_all_threshold __read_mostly =3D 64;
> +
> +static void local_flush_tlb_range_threshold_asid(unsigned long start,
> +                                                unsigned long size,
> +                                                unsigned long stride,
> +                                                unsigned long asid)
>  {
> -       if (size <=3D stride)
> -               local_flush_tlb_page(start);
> -       else
> -               local_flush_tlb_all();
> +       u16 nr_ptes_in_range =3D DIV_ROUND_UP(size, stride);
> +       int i;
> +
> +       if (nr_ptes_in_range > tlb_flush_all_threshold) {
> +               local_flush_tlb_all_asid(asid);
> +               return;
> +       }
> +
> +       for (i =3D 0; i < nr_ptes_in_range; ++i) {
> +               local_flush_tlb_page_asid(start, asid);
> +               start +=3D stride;
> +       }
>  }
>
>  static inline void local_flush_tlb_range_asid(unsigned long start,
> @@ -38,8 +60,10 @@ static inline void local_flush_tlb_range_asid(unsigned=
 long start,
>  {
>         if (size <=3D stride)
>                 local_flush_tlb_page_asid(start, asid);
> -       else
> +       else if (size =3D=3D FLUSH_TLB_MAX_SIZE)
>                 local_flush_tlb_all_asid(asid);
> +       else
> +               local_flush_tlb_range_threshold_asid(start, size, stride,=
 asid);
>  }
>
>  static void __ipi_flush_tlb_all(void *info)
> @@ -52,7 +76,7 @@ void flush_tlb_all(void)
>         if (riscv_use_ipi_for_rfence())
>                 on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
>         else
> -               sbi_remote_sfence_vma(NULL, 0, -1);
> +               sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
>  }
>
>  struct flush_tlb_range_data {
> @@ -69,18 +93,12 @@ static void __ipi_flush_tlb_range_asid(void *info)
>         local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid)=
;
>  }
>
> -static void __ipi_flush_tlb_range(void *info)
> -{
> -       struct flush_tlb_range_data *d =3D info;
> -
> -       local_flush_tlb_range(d->start, d->size, d->stride);
> -}
> -
>  static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>                               unsigned long size, unsigned long stride)
>  {
>         struct flush_tlb_range_data ftd;
>         struct cpumask *cmask =3D mm_cpumask(mm);
> +       unsigned long asid =3D FLUSH_TLB_NO_ASID;
>         unsigned int cpuid;
>         bool broadcast;
>
> @@ -90,39 +108,24 @@ static void __flush_tlb_range(struct mm_struct *mm, =
unsigned long start,
>         cpuid =3D get_cpu();
>         /* check if the tlbflush needs to be sent to other CPUs */
>         broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> -       if (static_branch_unlikely(&use_asid_allocator)) {
> -               unsigned long asid =3D atomic_long_read(&mm->context.id) =
& asid_mask;
> -
> -               if (broadcast) {
> -                       if (riscv_use_ipi_for_rfence()) {
> -                               ftd.asid =3D asid;
> -                               ftd.start =3D start;
> -                               ftd.size =3D size;
> -                               ftd.stride =3D stride;
> -                               on_each_cpu_mask(cmask,
> -                                                __ipi_flush_tlb_range_as=
id,
> -                                                &ftd, 1);
> -                       } else
> -                               sbi_remote_sfence_vma_asid(cmask,
> -                                                          start, size, a=
sid);
> -               } else {
> -                       local_flush_tlb_range_asid(start, size, stride, a=
sid);
> -               }
> +
> +       if (static_branch_unlikely(&use_asid_allocator))
> +               asid =3D atomic_long_read(&mm->context.id) & asid_mask;
> +
> +       if (broadcast) {
> +               if (riscv_use_ipi_for_rfence()) {
> +                       ftd.asid =3D asid;
> +                       ftd.start =3D start;
> +                       ftd.size =3D size;
> +                       ftd.stride =3D stride;
> +                       on_each_cpu_mask(cmask,
> +                                        __ipi_flush_tlb_range_asid,
> +                                        &ftd, 1);
> +               } else
> +                       sbi_remote_sfence_vma_asid(cmask,
> +                                                  start, size, asid);
>         } else {
> -               if (broadcast) {
> -                       if (riscv_use_ipi_for_rfence()) {
> -                               ftd.asid =3D 0;
> -                               ftd.start =3D start;
> -                               ftd.size =3D size;
> -                               ftd.stride =3D stride;
> -                               on_each_cpu_mask(cmask,
> -                                                __ipi_flush_tlb_range,
> -                                                &ftd, 1);
> -                       } else
> -                               sbi_remote_sfence_vma(cmask, start, size)=
;
> -               } else {
> -                       local_flush_tlb_range(start, size, stride);
> -               }
> +               local_flush_tlb_range_asid(start, size, stride, asid);
>         }
>
>         put_cpu();
> @@ -130,7 +133,7 @@ static void __flush_tlb_range(struct mm_struct *mm, u=
nsigned long start,
>
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -       __flush_tlb_range(mm, 0, -1, PAGE_SIZE);
> +       __flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>  }
>
>  void flush_tlb_mm_range(struct mm_struct *mm,
> --
> 2.39.2
>
