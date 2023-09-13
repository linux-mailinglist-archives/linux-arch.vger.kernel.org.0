Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D1A79E1F4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjIMIYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjIMIYY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 04:24:24 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4937010C0;
        Wed, 13 Sep 2023 01:24:20 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49032a0ff13so2382666e0c.0;
        Wed, 13 Sep 2023 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694593459; x=1695198259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvSkwLLGuwL6+FzTiaUPYz7u0MiA133oxHxQzz8keyY=;
        b=f3NkL39qpplvUFN3+/u9KzP5YUp4KczTSkjEUNDgN4Yu4Hf+c2FY3qNsl6Wskwbxlg
         sh3SpIqQIJ5jbm/mfU8gBKRSuijxsL8Hk7BjfGie6zGm0/pumK1k+JR+JS9VwWbOl9Ix
         z7n8gzVL7pe/K7TOwx14Am6ietoIn2FFf5E3Mx2CDrLuSDUnHGzdjl2hUoW7pBtWB7CU
         pLUwfp+KVyomlTHUCw3f5uPOYeGcIQyLhMdhYSQ7aLjMQkgjlYFo5aUlPA6lR4geY89q
         5zK+kCYcqcIAlF7u75dxzuVg+S1xjtBxz4VBYwpHz1N7guIJx0mY6Swxr3bqvNDHNS99
         Nhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593459; x=1695198259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvSkwLLGuwL6+FzTiaUPYz7u0MiA133oxHxQzz8keyY=;
        b=ilEQKFqftNMuQISc3rV9+RU2RiIYrTKuMdD6J9qkHOhDjETWKrqS4Je4/1ltzieoMv
         Dd4vQuDWPp/xcb3gknoD7jOppkh6QaBN2O8O3CVE292zMJvOk2bZXoMeOpsKvzHN5UOy
         h7Bf1jIx9BURCjvff0N3iZLTAPZ0Z12JKWWKjcJDDQnREHfJIZjSyHPHH57nnWCzjZ7/
         oTUt3teBfPob5ktRQsRAVXGpKKqmsTIzrI0AF1cT9YTaJeSlYGExWSk/++50SzBD4sXd
         QrbQ2caXKlMQvxUSyswTlHEefk+PuspANwV3OkF8TCM/N5OOAnxSxmzu2o8sStc27SGd
         bEow==
X-Gm-Message-State: AOJu0YxPqM7q4SiLCUqLvkF7xpyfmaOMPLg+TE3033sdu0/vmY+Guhaj
        vlG481g70oT/b/A4FzNfaZhLOiOrrLEA3o2O5SM=
X-Google-Smtp-Source: AGHT+IFO0NSs41b73GFK5JRqE11oXhcmyBkl1ReBcxdhr7hcXRn9Fd+MyqqH9Ssyk1jO/UvqE7kpKxzJ24mPzPRKrQc=
X-Received: by 2002:a1f:6d03:0:b0:48d:2a1:5d26 with SMTP id
 i3-20020a1f6d03000000b0048d02a15d26mr2126287vkc.4.1694593459187; Wed, 13 Sep
 2023 01:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
 <20230911131224.61924-5-alexghiti@rivosinc.com> <CAHVXubiVH=q9pnTLQyjS3X3W-hvuA=ZMM2D2xYPFkGjFnAgbWg@mail.gmail.com>
In-Reply-To: <CAHVXubiVH=q9pnTLQyjS3X3W-hvuA=ZMM2D2xYPFkGjFnAgbWg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 13 Sep 2023 09:23:08 +0100
Message-ID: <CA+V-a8tYzee-cX8rMiQ66ENWb+rLLFHmkOdovft0L-8ASQ3eog@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexandre,

On Wed, Sep 13, 2023 at 9:04=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> @Lad, Prabhakar Any chance you give a try to this new patchset? So
> that we make sure Samuel found your issue :)
>
I have given the patches a try and not seen the module load failures
as seen previously. I have some rigorous tests which test the complete
platform. I'm just waiting for it to complete before I give Tested by.

Cheers,
Prabhakar

> On Mon, Sep 11, 2023 at 3:16=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
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
> >  arch/riscv/include/asm/tlbflush.h | 11 ++++++-----
> >  arch/riscv/mm/tlbflush.c          | 33 ++++++++++++++++++++++---------
> >  2 files changed, 30 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm=
/tlbflush.h
> > index 170a49c531c6..8f3418c5f172 100644
> > --- a/arch/riscv/include/asm/tlbflush.h
> > +++ b/arch/riscv/include/asm/tlbflush.h
> > @@ -40,6 +40,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
> >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
> >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >                      unsigned long end);
> > +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long sta=
rt,
> > @@ -56,15 +57,15 @@ static inline void flush_tlb_range(struct vm_area_s=
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
> > index 2c1136d73411..28cd8539b575 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -97,19 +97,27 @@ static void __flush_tlb_range(struct mm_struct *mm,=
 unsigned long start,
> >                               unsigned long size, unsigned long stride)
> >  {
> >         struct flush_tlb_range_data ftd;
> > -       struct cpumask *cmask =3D mm_cpumask(mm);
> > +       struct cpumask *cmask, full_cmask;
> >         unsigned long asid =3D FLUSH_TLB_NO_ASID;
> > -       unsigned int cpuid;
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
> >
> > -       cpuid =3D get_cpu();
> > -       /* check if the tlbflush needs to be sent to other CPUs */
> > -       broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
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
> > -       if (static_branch_unlikely(&use_asid_allocator))
> > +       if (static_branch_unlikely(&use_asid_allocator) && mm)
> >                 asid =3D atomic_long_read(&mm->context.id) & asid_mask;
> >
> >         if (broadcast) {
> > @@ -128,7 +136,8 @@ static void __flush_tlb_range(struct mm_struct *mm,=
 unsigned long start,
> >                 local_flush_tlb_range_asid(start, size, stride, asid);
> >         }
> >
> > -       put_cpu();
> > +       if (mm)
> > +               put_cpu();
> >  }
> >
> >  void flush_tlb_mm(struct mm_struct *mm)
> > @@ -189,6 +198,12 @@ void flush_tlb_range(struct vm_area_struct *vma, u=
nsigned long start,
> >
> >         __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
> >  }
> > +
> > +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> > +{
> > +       __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> > +}
> > +
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long sta=
rt,
> >                         unsigned long end)
> > --
> > 2.39.2
> >
