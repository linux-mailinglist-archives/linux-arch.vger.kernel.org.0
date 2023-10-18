Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7257CDA42
	for <lists+linux-arch@lfdr.de>; Wed, 18 Oct 2023 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjJRL0m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Oct 2023 07:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjJRL0l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2023 07:26:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BC112
        for <linux-arch@vger.kernel.org>; Wed, 18 Oct 2023 04:26:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32db8924201so2347423f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 18 Oct 2023 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697628396; x=1698233196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo7B+cdiTA7QkXzogWs+Pqnw9GSLWygwDRl43SgG4dc=;
        b=hDSJHTw6KFJp97jETOV2GRIONRsn/wO2k4STSHYThukIZ/pfWMd69mKW95WwnHdarh
         03pqqrCcvOaeuueBFXLm2EPg8XipZhzRZwg82RzdmFTiqmcFRpWQOlJLscMwQsc50zHo
         EnRgCZ96YMbCA6QjZT6zJWJnDpb0EK3QtWX6qQPlMw7VTCBcgpiqmUhI3DB5kaiMq0OK
         QO7WqVqcXy8H/CMxdqhuvtP3hJRdXRoTaZC7w/5Fxmb6lJ8y3TDcKXZxyKvka0A+0GJG
         D1N0SB8lAgKn7ZX/DaRqGRl5XuuTIi+FojQtwVk7OpgBh/sf2jL36trqBQ4UkqoYXLHH
         e35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697628396; x=1698233196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo7B+cdiTA7QkXzogWs+Pqnw9GSLWygwDRl43SgG4dc=;
        b=QEzw78DBGzxtEAD3pe4jcTCCIuDLA0imerTI/gm6gx7Z/i+uNmSYq1Z1JFuP1ztH/H
         2wKo5SUpyWeCj1rUz96jrth22AXBfqZs+2haFMRty4fQSAod7uh0s5zDvJaLrWLkSQpF
         CJ6KSWh6DEvNstxhZ79QG/KMguVpXdwGLQsUP/Ey+usnBGIH67Y22QnRWUdlsG+ffrdV
         T13exsAg3HtRMsiHcEkEwDGFWRtfxl0HcHIHy5I0maXppsZJFsff8x+n0XZPZrleVdzv
         aRhjb/T+Gwvv3B59/MwaPw5azwDaTAHmQWS9zht7rck5iJsAnwzin0ffcq+qgR219PcB
         xrnw==
X-Gm-Message-State: AOJu0YxBezMSRyvBE5OG4n+Z7jAXu+gTrVUrWDRwjezdqoS4OKq6CPdt
        ZOQ3m/Jyw03onOypbIQwZMLYE4fUJtUDCioRoS8+JxWjkvjJYm3V
X-Google-Smtp-Source: AGHT+IEGTdYVt+EPdhZK2SJoJGQwAAt5GzCSXuLlL/UEP8u+GheBaAJrwgwf37URmrStLQQQxRBRAHFjOKB/q7DtxmM=
X-Received: by 2002:a5d:58da:0:b0:32d:b051:9a2b with SMTP id
 o26-20020a5d58da000000b0032db0519a2bmr4179536wrf.2.1697628396063; Wed, 18 Oct
 2023 04:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com>
 <20230911131224.61924-2-alexghiti@rivosinc.com> <2047b2c2-bf37-4c02-9297-d89f95863ed5@sifive.com>
In-Reply-To: <2047b2c2-bf37-4c02-9297-d89f95863ed5@sifive.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 18 Oct 2023 13:26:25 +0200
Message-ID: <CAHVXubiM=JPRZXjsdK1JTGBbywxT_tYRNminZw8ZLo=jAj8N+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] riscv: Improve flush_tlb()
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Samuel,

On Mon, Oct 9, 2023 at 7:53=E2=80=AFPM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> On 2023-09-11 8:12 AM, Alexandre Ghiti wrote:
> > For now, flush_tlb() simply calls flush_tlb_mm() which results in a
>
> s/flush_tlb/tlb_flush/ here and in the subject.
>
> Otherwise:
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

Ahah good catch, thanks for that and the RB!

Alex

>
> > flush of the whole TLB. So let's use mmu_gather fields to provide a mor=
e
> > fine-grained flush of the TLB.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/tlb.h      | 8 +++++++-
> >  arch/riscv/include/asm/tlbflush.h | 3 +++
> >  arch/riscv/mm/tlbflush.c          | 7 +++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.=
h
> > index 120bcf2ed8a8..1eb5682b2af6 100644
> > --- a/arch/riscv/include/asm/tlb.h
> > +++ b/arch/riscv/include/asm/tlb.h
> > @@ -15,7 +15,13 @@ static void tlb_flush(struct mmu_gather *tlb);
> >
> >  static inline void tlb_flush(struct mmu_gather *tlb)
> >  {
> > -     flush_tlb_mm(tlb->mm);
> > +#ifdef CONFIG_MMU
> > +     if (tlb->fullmm || tlb->need_flush_all)
> > +             flush_tlb_mm(tlb->mm);
> > +     else
> > +             flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
> > +                                tlb_get_unmap_size(tlb));
> > +#endif
> >  }
> >
> >  #endif /* _ASM_RISCV_TLB_H */
> > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm=
/tlbflush.h
> > index a09196f8de68..f5c4fb0ae642 100644
> > --- a/arch/riscv/include/asm/tlbflush.h
> > +++ b/arch/riscv/include/asm/tlbflush.h
> > @@ -32,6 +32,8 @@ static inline void local_flush_tlb_page(unsigned long=
 addr)
> >  #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
> >  void flush_tlb_all(void);
> >  void flush_tlb_mm(struct mm_struct *mm);
> > +void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> > +                     unsigned long end, unsigned int page_size);
> >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
> >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> >                    unsigned long end);
> > @@ -52,6 +54,7 @@ static inline void flush_tlb_range(struct vm_area_str=
uct *vma,
> >  }
> >
> >  #define flush_tlb_mm(mm) flush_tlb_all()
> > +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> >  #endif /* !CONFIG_SMP || !CONFIG_MMU */
> >
> >  /* Flush a range of kernel pages */
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 77be59aadc73..fa03289853d8 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -132,6 +132,13 @@ void flush_tlb_mm(struct mm_struct *mm)
> >       __flush_tlb_range(mm, 0, -1, PAGE_SIZE);
> >  }
> >
> > +void flush_tlb_mm_range(struct mm_struct *mm,
> > +                     unsigned long start, unsigned long end,
> > +                     unsigned int page_size)
> > +{
> > +     __flush_tlb_range(mm, start, end - start, page_size);
> > +}
> > +
> >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> >  {
> >       __flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
>
