Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44923793C14
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjIFMCP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 08:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjIFMCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 08:02:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB501985
        for <linux-arch@vger.kernel.org>; Wed,  6 Sep 2023 05:01:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31f4950333cso2518804f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 06 Sep 2023 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694001709; x=1694606509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp8EZRgwEyyTmPheARIzvhEwRO9ZLG7z8fbcdxO2Tiw=;
        b=hU/AqF7GIRAB8oT4N9Ws4ccnyTADv9k8kqWFV0Mf6s9Zxi0gySh/EaTPSs6gWzEQUN
         NGK3zKaxg/hHrMcYPRikzocElEvkKBExor3mWs+b8m6sy1KDc7AHhdsU/WlpmfnV10e1
         5k6yw6TIxO/ZAfI+tqzp5VItPGZEk0zQgj46Tulk46AOC/wAQ3lJ82HGh4ahX0QwmGBW
         JUtv/tnDwk4mkatfCt8shKVqepbqZldGX6FuljnsShWkeAIU8Zskcja0WXy1ahn55wAA
         8+ELSOGdB4pPPPQF1bH80QIi0q58xeHoM29IXSujsqcBtWajvgUrI09T4PlZjSjLfiuZ
         RtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001709; x=1694606509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp8EZRgwEyyTmPheARIzvhEwRO9ZLG7z8fbcdxO2Tiw=;
        b=a90PH3Yx5x3e/M9ozOLniXSqunEhOKVrAC/eI+MZi9ArXAC6ypyh8JGtwQMWyTd9VZ
         FG8vGgHB82vR3M7ZghSzylBvcezPRFXBF/CRJV/0PHyRpMxMXfeEHd0D1rIYE+n1Rm56
         BuRY3R8oEGjjwJUW7DYmgKS2he8lM0wJUduWROIQxgxvrJTwlYfkwODA6Q3bIOfxpSiO
         D27dbSz2+AKwaHEGP6Rubrs/VpmK0NskzWZ8Vt/ykYVBD8lWmAsyYoCmRFl0VXO7vzOa
         qWbiipT5B9PHTeU0M8n8m/x8ZF9UgWkXI85lS48C/pWEGbYmXUWyCsL/yOd0BcrquOrc
         bmLA==
X-Gm-Message-State: AOJu0YyMNzbuyP4Fz7tOtAzxZEhnyZgQnlf9YW6Qy6St5py5v+bwxV/n
        JE7UGclPjbkQepQnYr3bRejfR7e9tkiMM7vulgJGvA==
X-Google-Smtp-Source: AGHT+IEhIllMnM0PjECRqiitAitNZCsEvGEterT8Gl6AxXRapewVRPWj9ivnFDU+enq8y+LvA5OL44z2Ha1PBTDFPVs=
X-Received: by 2002:a5d:6e88:0:b0:319:6b5e:85e3 with SMTP id
 k8-20020a5d6e88000000b003196b5e85e3mr1878514wrz.71.1694001708759; Wed, 06 Sep
 2023 05:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com> <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
In-Reply-To: <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 6 Sep 2023 14:01:38 +0200
Message-ID: <CAHVXubiENHt36LrcSBoNU0rAMQ8EoT6tde9M8vLP3Hw2nwMm8g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Prabhakar,

On Wed, Sep 6, 2023 at 1:49=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Alexandre,
>
> On Tue, Aug 1, 2023 at 9:58=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > This function used to simply flush the whole tlb of all harts, be more
> > subtile and try to only flush the range.
> >
> > The problem is that we can only use PAGE_SIZE as stride since we don't =
know
> > the size of the underlying mapping and then this function will be impro=
ved
> > only if the size of the region to flush is < threshold * PAGE_SIZE.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/tlbflush.h | 11 +++++-----
> >  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++--------
> >  2 files changed, 31 insertions(+), 14 deletions(-)
> >
> After applying this patch, I am seeing module load issues on RZ/Five
> (complete log [0]). I am testing defconfig + [1] (rz/five related
> configs).
>
> Any pointers on what could be an issue here?

Can you give me the exact version of the kernel you use? The trap
addresses are vmalloc addresses, and a fix for those landed very late
in the release cycle.

>
> [0] https://paste.debian.net/1291116/
> [1] https://paste.debian.net/1291118/
>
> Cheers,
> Prabhakar
>
> > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm=
/tlbflush.h
> > index f5c4fb0ae642..7426fdcd8ec5 100644
> > --- a/arch/riscv/include/asm/tlbflush.h
> > +++ b/arch/riscv/include/asm/tlbflush.h
> > @@ -37,6 +37,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
> >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
> >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >                      unsigned long end);
> > +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long sta=
rt,
> > @@ -53,15 +54,15 @@ static inline void flush_tlb_range(struct vm_area_s=
truct *vma,
> >         local_flush_tlb_all();
> >  }
> >
> > -#define flush_tlb_mm(mm) flush_tlb_all()
> > -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> > -#endif /* !CONFIG_SMP || !CONFIG_MMU */
> > -
> >  /* Flush a range of kernel pages */
> >  static inline void flush_tlb_kernel_range(unsigned long start,
> >         unsigned long end)
> >  {
> > -       flush_tlb_all();
> > +       local_flush_tlb_all();
> >  }
> >
> > +#define flush_tlb_mm(mm) flush_tlb_all()
> > +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> > +#endif /* !CONFIG_SMP || !CONFIG_MMU */
> > +
> >  #endif /* _ASM_RISCV_TLBFLUSH_H */
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 0c955c474f3a..687808013758 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -120,18 +120,27 @@ static void __flush_tlb_range(struct mm_struct *m=
m, unsigned long start,
> >                               unsigned long size, unsigned long stride)
> >  {
> >         struct flush_tlb_range_data ftd;
> > -       struct cpumask *cmask =3D mm_cpumask(mm);
> > -       unsigned int cpuid;
> > +       struct cpumask *cmask, full_cmask;
> >         bool broadcast;
> >
> > -       if (cpumask_empty(cmask))
> > -               return;
> > +       if (mm) {
> > +               unsigned int cpuid;
> > +
> > +               cmask =3D mm_cpumask(mm);
> > +               if (cpumask_empty(cmask))
> > +                       return;
> > +
> > +               cpuid =3D get_cpu();
> > +               /* check if the tlbflush needs to be sent to other CPUs=
 */
> > +               broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_id=
s;
> > +       } else {
> > +               cpumask_setall(&full_cmask);
> > +               cmask =3D &full_cmask;
> > +               broadcast =3D true;
> > +       }
> >
> > -       cpuid =3D get_cpu();
> > -       /* check if the tlbflush needs to be sent to other CPUs */
> > -       broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> >         if (static_branch_unlikely(&use_asid_allocator)) {
> > -               unsigned long asid =3D atomic_long_read(&mm->context.id=
) & asid_mask;
> > +               unsigned long asid =3D mm ? atomic_long_read(&mm->conte=
xt.id) & asid_mask : 0;
> >
> >                 if (broadcast) {
> >                         if (riscv_use_ipi_for_rfence()) {
> > @@ -165,7 +174,8 @@ static void __flush_tlb_range(struct mm_struct *mm,=
 unsigned long start,
> >                 }
> >         }
> >
> > -       put_cpu();
> > +       if (mm)
> > +               put_cpu();
> >  }
> >
> >  void flush_tlb_mm(struct mm_struct *mm)
> > @@ -196,6 +206,12 @@ void flush_tlb_range(struct vm_area_struct *vma, u=
nsigned long start,
> >
> >         __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
> >  }
> > +
> > +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > +{
> > +       __flush_tlb_range(NULL, start, end, PAGE_SIZE);
> > +}
> > +
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long sta=
rt,
> >                         unsigned long end)
> > --
> > 2.39.2
> >
> >
