Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39E7CDA70
	for <lists+linux-arch@lfdr.de>; Wed, 18 Oct 2023 13:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjJRLcp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Oct 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjJRLcn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2023 07:32:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20618B
        for <linux-arch@vger.kernel.org>; Wed, 18 Oct 2023 04:32:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so5795050f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 18 Oct 2023 04:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697628755; x=1698233555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHg4mM71KXb5DEEj0eqsenmzI1spOu0jlYYbZtbcLDI=;
        b=Rb7AoKmqxPkjisuOjJrROZLZW3sWUFlo5t7cigeAb2dy/ppJTK0m1R9yMnT43yYgha
         D0IhrtQJP2EffAqOHDZYg/PHvFWPMi4tX3WePuZBR+nHSS3wL7KYgENIqtZjfCoUI1rS
         gW51HnDaskOiPkisgvUHVhkj3yf0ryKsomGKULwHDEm5hTcs3Yd1twFYMqCNyqoCzGrL
         kIPH3uagFtsCMSSODSLkUY1UqLKY0o0f2MCdPu8Q4JOvcboaiZHpZrSjuZN918DY6Vsr
         8cDAw3aNbmggm1FYCyruT2uZeHaB418jtxTuKi0t52aIFtWIIkFBwUOm1pyb7/LWang+
         23hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628755; x=1698233555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHg4mM71KXb5DEEj0eqsenmzI1spOu0jlYYbZtbcLDI=;
        b=Tojyn/krX6yHB5PMWeM+VhHEDNnaAoFAXYCsDr7FqgY82dVb4tg4CGwMV2pubcDP32
         P5PGiaGO3lPey7FOEMmOn9nf4ABJw3ZIrvxdZxxmsfXah+e8O3F+89kGUAhP2n4fmENB
         i4QdwmMF8s/kM3Dcb/tPctRkXIary1L1vqIeC5oxeHbGJ6Tp2wiuli4EodlFwB1mbjGF
         KgXPRG/gj3TcT1e8Yx9lt/MdpFJlGAmx7ozYQ4PUfK02E6/I7ZHxmYmi6RhDlkvtNCXe
         S0WEq6BUNLVmis8NXXQuhopqUKTz4xZW4WinlhTex+3fJg911UDXqNl92PcQEzu2fTD2
         OsfQ==
X-Gm-Message-State: AOJu0YwLrjoVG3HXwkRlbZviHIZJM7sTqs8VzjeaoLpPDji7ej8G2mF4
        fBVZiq4VHJz4NIM+WPNhPSM/dLVcoPZEgdCPk3R5NO0NOtfjn5Xs
X-Google-Smtp-Source: AGHT+IE7XG0RKk8s+uBzZafDLTDJ6fdrdFzovu8zj80LYFemlglr4j6DZXpsSClEETmOBCTzjgEKBb3b1Jy3x7exweE=
X-Received: by 2002:a5d:668d:0:b0:32d:9789:6066 with SMTP id
 l13-20020a5d668d000000b0032d97896066mr4216230wru.5.1697628755552; Wed, 18 Oct
 2023 04:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
 <20230911131224.61924-3-alexghiti@rivosinc.com> <79d8ca23-478d-4f88-afb3-343a85ed0fe6@sifive.com>
In-Reply-To: <79d8ca23-478d-4f88-afb3-343a85ed0fe6@sifive.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 18 Oct 2023 13:32:24 +0200
Message-ID: <CAHVXubiaYwQ3PeiA-688cKuBscdEb5QpNerbYSMWYqiXCm-FRw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 9, 2023 at 7:53=E2=80=AFPM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Hi Alex,
>
> On 2023-09-11 8:12 AM, Alexandre Ghiti wrote:
> > flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current f=
orm,
> > when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes t=
he
> > whole tlb: so set a stride of the size of the hugetlb mapping in order =
to
> > only flush the hugetlb mapping. However, if the hugepage is a NAPOT reg=
ion,
> > all PTEs that constitute this mapping must be invalidated, so the strid=
e
> > size must actually be the size of the PTE.
> >
> > Note that THPs are directly handled by flush_pmd_tlb_range().
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/mm/tlbflush.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index fa03289853d8..5bda6d4fed90 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/smp.h>
> >  #include <linux/sched.h>
> > +#include <linux/hugetlb.h>
> >  #include <asm/sbi.h>
> >  #include <asm/mmu_context.h>
> >
> > @@ -147,7 +148,43 @@ void flush_tlb_page(struct vm_area_struct *vma, un=
signed long addr)
> >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >                    unsigned long end)
> >  {
> > -     __flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
> > +     unsigned long stride_size;
> > +
> > +     stride_size =3D is_vm_hugetlb_page(vma) ?
> > +                             huge_page_size(hstate_vma(vma)) :
> > +                             PAGE_SIZE;
> > +
> > +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> > +     /*
> > +      * As stated in the privileged specification, every PTE in a NAPO=
T
> > +      * region must be invalidated, so reset the stride in that case.
> > +      */
> > +     if (has_svnapot()) {
>
> This whole block should probably go inside the is_vm_hugetlb_page(vma) ch=
eck,
> since we have to perform that check anyway.

Yes, you're right.

>
> > +             unsigned long order, napot_size;
> > +
> > +             for_each_napot_order(order) {
> > +                     napot_size =3D napot_cont_size(order);
> > +
> > +                     if (stride_size !=3D napot_size)
> > +                             continue;
> > +
> > +                     if (napot_size >=3D PGDIR_SIZE)
>
> Can you check stride_size here directly, and drop the loop? We should be =
able to
> assume that the huge page size is valid. Non-NAPOT hugepages will hit one=
 of the
> equal-to cases below, which is fine.

Yes, again, you're right.

I'll respin a new version now, let it go through our CI and send it tomorro=
w,

Thanks,

Alex

>
> Regards,
> Samuel
>
> > +                             stride_size =3D PGDIR_SIZE;
> > +                     else if (napot_size >=3D P4D_SIZE)
> > +                             stride_size =3D P4D_SIZE;
> > +                     else if (napot_size >=3D PUD_SIZE)
> > +                             stride_size =3D PUD_SIZE;
> > +                     else if (napot_size >=3D PMD_SIZE)
> > +                             stride_size =3D PMD_SIZE;
> > +                     else
> > +                             stride_size =3D PAGE_SIZE;
> > +
> > +                     break;
> > +             }
> > +     }
> > +#endif
> > +
> > +     __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
> >  }
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long sta=
rt,
>
