Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F4079E22F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbjIMIca (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbjIMIca (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 04:32:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E708E73
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 01:32:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31ad9155414so5947335f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694593944; x=1695198744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnTWLbskqt//nMg0mFaFHPq2gBLre/x26wIHG0UioHY=;
        b=yv5lidArENEuIvkzHDJ60QNm8POGBK9AVAqc9Wy4rp0yFZd+MVQZ59n3EmX8jF1+MD
         1t4Gp/uDrYf/lwAKWobzjmJXgTOAOqLM+XmFVKZ/zWqaU0YbVglH6xEH+t2LanDh6uJP
         Jm2manHcMnacrLStHjHO4rq1CBhZZtoW0OrdqMuwN9Z6D/r9kauqUr1wlQ7DBDBgZkv7
         6zl3M2F9+gZPLYsJgokxvGrlvIG4GTTY6Kw8xbzXSvY6uAttCSHddhRDoSGWYWSCfvN5
         8cX1Yv558SLq4mLH1OZKVxSN5dpOnqPhMDlhPSF+/LItzwoERlysC62Bnbcrg7BDTtNM
         lOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593944; x=1695198744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnTWLbskqt//nMg0mFaFHPq2gBLre/x26wIHG0UioHY=;
        b=C6IXq1lCQzoW/eSu8hA0ndllSWE11pcIFExHjfqJYsDM2Sx9PkuxSqdg3DpfHhv28f
         bwePKmtajHGBj4q7nIMKaiRTyjsU1qKSoquJOEE7GshvNU/PbZMyHINaVywu+kuQVrMq
         QCSR8XfXUho2sVQmZsfDocSEFUnFcuYxtS6mRZjqPjI8A9+CS6bZmYQREoSvI5bqkHmk
         8FxT31Usrh9svj8RqxqNyL7y3PlwlL7Nq2A0lvBDSz92qIJS3ETp9XH9PKwFE7b1f+hN
         awavShF+hwspL1tjt/KligAV1Kig776XzNP7hqFzXH3IJvzFNIPd11uIQAkEINwz2p4S
         7i6g==
X-Gm-Message-State: AOJu0Yx5mvXSn1RI/Iv4wUn9uKRPTS2VIbYF+yYH+0QRewb0YLBnQZg4
        vEhvte6IJhsYlOuHdgkBS+9XFRc78cjLXXTxHj3pIMqShwt9V6fqJGY=
X-Google-Smtp-Source: AGHT+IGEhCPdcCrXcmWUhJSPWmCvw+1W5qAcDduQR77c6UrkXb5UorlQyiK1+gYg5kjtoL67a1RhfxqWPgumpB4OPEY=
X-Received: by 2002:a5d:6589:0:b0:319:84dd:4596 with SMTP id
 q9-20020a5d6589000000b0031984dd4596mr1641330wru.5.1694593944637; Wed, 13 Sep
 2023 01:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
 <20230911131224.61924-5-alexghiti@rivosinc.com> <CAHVXubiVH=q9pnTLQyjS3X3W-hvuA=ZMM2D2xYPFkGjFnAgbWg@mail.gmail.com>
 <CA+V-a8tYzee-cX8rMiQ66ENWb+rLLFHmkOdovft0L-8ASQ3eog@mail.gmail.com>
In-Reply-To: <CA+V-a8tYzee-cX8rMiQ66ENWb+rLLFHmkOdovft0L-8ASQ3eog@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 13 Sep 2023 10:32:13 +0200
Message-ID: <CAHVXubjYpkaOhP3oJwAQVHJLON7pNt+D0A7enqr3n5UuKC13UQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] riscv: Improve flush_tlb_kernel_range()
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 10:24=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Alexandre,
>
> On Wed, Sep 13, 2023 at 9:04=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > @Lad, Prabhakar Any chance you give a try to this new patchset? So
> > that we make sure Samuel found your issue :)
> >
> I have given the patches a try and not seen the module load failures
> as seen previously. I have some rigorous tests which test the complete
> platform. I'm just waiting for it to complete before I give Tested by.
>

Awesome, thanks for the update! Well done @Samuel Holland

> Cheers,
> Prabhakar
>
> > On Mon, Sep 11, 2023 at 3:16=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > This function used to simply flush the whole tlb of all harts, be mor=
e
> > > subtile and try to only flush the range.
> > >
> > > The problem is that we can only use PAGE_SIZE as stride since we don'=
t know
> > > the size of the underlying mapping and then this function will be imp=
roved
> > > only if the size of the region to flush is < threshold * PAGE_SIZE.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/tlbflush.h | 11 ++++++-----
> > >  arch/riscv/mm/tlbflush.c          | 33 ++++++++++++++++++++++-------=
--
> > >  2 files changed, 30 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/a=
sm/tlbflush.h
> > > index 170a49c531c6..8f3418c5f172 100644
> > > --- a/arch/riscv/include/asm/tlbflush.h
> > > +++ b/arch/riscv/include/asm/tlbflush.h
> > > @@ -40,6 +40,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsig=
ned long start,
> > >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
> > >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
> > >                      unsigned long end);
> > > +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > >  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> > >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long s=
tart,
> > > @@ -56,15 +57,15 @@ static inline void flush_tlb_range(struct vm_area=
_struct *vma,
> > >         local_flush_tlb_all();
> > >  }
> > >
> > > -#define flush_tlb_mm(mm) flush_tlb_all()
> > > -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all(=
)
> > > -#endif /* !CONFIG_SMP || !CONFIG_MMU */
> > > -
> > >  /* Flush a range of kernel pages */
> > >  static inline void flush_tlb_kernel_range(unsigned long start,
> > >         unsigned long end)
> > >  {
> > > -       flush_tlb_all();
> > > +       local_flush_tlb_all();
> > >  }
> > >
> > > +#define flush_tlb_mm(mm) flush_tlb_all()
> > > +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all(=
)
> > > +#endif /* !CONFIG_SMP || !CONFIG_MMU */
> > > +
> > >  #endif /* _ASM_RISCV_TLBFLUSH_H */
> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > > index 2c1136d73411..28cd8539b575 100644
> > > --- a/arch/riscv/mm/tlbflush.c
> > > +++ b/arch/riscv/mm/tlbflush.c
> > > @@ -97,19 +97,27 @@ static void __flush_tlb_range(struct mm_struct *m=
m, unsigned long start,
> > >                               unsigned long size, unsigned long strid=
e)
> > >  {
> > >         struct flush_tlb_range_data ftd;
> > > -       struct cpumask *cmask =3D mm_cpumask(mm);
> > > +       struct cpumask *cmask, full_cmask;
> > >         unsigned long asid =3D FLUSH_TLB_NO_ASID;
> > > -       unsigned int cpuid;
> > >         bool broadcast;
> > >
> > > -       if (cpumask_empty(cmask))
> > > -               return;
> > > +       if (mm) {
> > > +               unsigned int cpuid;
> > > +
> > > +               cmask =3D mm_cpumask(mm);
> > > +               if (cpumask_empty(cmask))
> > > +                       return;
> > >
> > > -       cpuid =3D get_cpu();
> > > -       /* check if the tlbflush needs to be sent to other CPUs */
> > > -       broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> > > +               cpuid =3D get_cpu();
> > > +               /* check if the tlbflush needs to be sent to other CP=
Us */
> > > +               broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_=
ids;
> > > +       } else {
> > > +               cpumask_setall(&full_cmask);
> > > +               cmask =3D &full_cmask;
> > > +               broadcast =3D true;
> > > +       }
> > >
> > > -       if (static_branch_unlikely(&use_asid_allocator))
> > > +       if (static_branch_unlikely(&use_asid_allocator) && mm)
> > >                 asid =3D atomic_long_read(&mm->context.id) & asid_mas=
k;
> > >
> > >         if (broadcast) {
> > > @@ -128,7 +136,8 @@ static void __flush_tlb_range(struct mm_struct *m=
m, unsigned long start,
> > >                 local_flush_tlb_range_asid(start, size, stride, asid)=
;
> > >         }
> > >
> > > -       put_cpu();
> > > +       if (mm)
> > > +               put_cpu();
> > >  }
> > >
> > >  void flush_tlb_mm(struct mm_struct *mm)
> > > @@ -189,6 +198,12 @@ void flush_tlb_range(struct vm_area_struct *vma,=
 unsigned long start,
> > >
> > >         __flush_tlb_range(vma->vm_mm, start, end - start, stride_size=
);
> > >  }
> > > +
> > > +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > > +{
> > > +       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> > > +}
> > > +
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long s=
tart,
> > >                         unsigned long end)
> > > --
> > > 2.39.2
> > >
