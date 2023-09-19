Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68B07A620A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjISMHr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjISMHq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 08:07:46 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F294EA9;
        Tue, 19 Sep 2023 05:07:39 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a803afa8c5so1930987241.0;
        Tue, 19 Sep 2023 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695125259; x=1695730059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJltkCrkvXnqlCGBVJnlNJKBiks9lWDJ9wT58GRKfUo=;
        b=fE9ymE3oIwK6YSuP2wZ/gnbJ7YGmzJGOIfcXbIScvDPsVsKAMNDIhH+cHurZsTlFA7
         xc9tiNUfrlCtnPTK1iAaPze9/tvXvg8xn+XGvLKpmuAgU2/UV+Zhkf3SV1FF4fgdd3SX
         P1QW5iqfjvXLZP4VoOwRQtJT7DV88+dkfesdss2K5QiZrrWnQzAyeZBTdiPWAqGVPNpa
         9BdxSyBleBto1FB5SC4XR/FUwbOL0LBFra6BJoYPqawg5fSytnA50p6kTnrCTD/m+/kF
         LUvejFIQ3UZh4Oa3E/qYRpeOnGDv2KH/1M7C+eCZdQhu07Cc4ZlykowP2Xpn2umT4euh
         j2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125259; x=1695730059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJltkCrkvXnqlCGBVJnlNJKBiks9lWDJ9wT58GRKfUo=;
        b=e3JMSVohaGbDn0OtLFuzeC2ocSTZKWBHFQ5FfkvwFDKAeOz1HbPamOaD4CEr7rn63v
         TbnUXcckdvY60bVCJDb0vJ6s198eOsMJ7Vj6Fte2y9AJ2uzVWnxGF3+D10W5EsaD7/xv
         6rwOPpO96e7XX661qAxvmYzV9JkrK1T56DuNwtIcWqpus16yzF0vAiFC7Ctea+w3+qUY
         lVU/SIEPjrSz8k7jClJYiUMK0L5eXBgSx0xsnVtjz2LMeJEXPqXvlnd1RetPrHB813Ln
         GRGY9xtlw6eR8ZwDCe4yAwHKB2s5xJOsnnY2cKRBTld51Kapk+wfkZGPzofezazscmD6
         cOkA==
X-Gm-Message-State: AOJu0YwQ7OIR7aLnrAZ0RSLEfBULEjkcprd04G8tFwQ0o8SqLdc0mPQi
        RD5s+KKn8LnazidpGBx7EzPBz5yYKPsjjA6Bua7x+gOaQfxBWg==
X-Google-Smtp-Source: AGHT+IFafZT6XJJv7X6AlrUpzvAuX5vIPbFV8GFxqI1svCGaqZLPKRCktqSUX/D6r+7xZdGTMbeSMlelrM5gI479ej8=
X-Received: by 2002:a1f:e741:0:b0:495:f061:f2c7 with SMTP id
 e62-20020a1fe741000000b00495f061f2c7mr9571105vkh.3.1695125258959; Tue, 19 Sep
 2023 05:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com> <20230911131224.61924-2-alexghiti@rivosinc.com>
In-Reply-To: <20230911131224.61924-2-alexghiti@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 19 Sep 2023 13:07:12 +0100
Message-ID: <CA+V-a8tb8=nLz4vazd=B_zibkbk0kpqymCTmKMTabK1LT=pumQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] riscv: Improve flush_tlb()
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

On Mon, Sep 11, 2023 at 2:13=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> For now, flush_tlb() simply calls flush_tlb_mm() which results in a
> flush of the whole TLB. So let's use mmu_gather fields to provide a more
> fine-grained flush of the TLB.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/tlb.h      | 8 +++++++-
>  arch/riscv/include/asm/tlbflush.h | 3 +++
>  arch/riscv/mm/tlbflush.c          | 7 +++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #
On RZ/Five SMARC

Cheers,
Prabhakar

> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> index 120bcf2ed8a8..1eb5682b2af6 100644
> --- a/arch/riscv/include/asm/tlb.h
> +++ b/arch/riscv/include/asm/tlb.h
> @@ -15,7 +15,13 @@ static void tlb_flush(struct mmu_gather *tlb);
>
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
> -       flush_tlb_mm(tlb->mm);
> +#ifdef CONFIG_MMU
> +       if (tlb->fullmm || tlb->need_flush_all)
> +               flush_tlb_mm(tlb->mm);
> +       else
> +               flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
> +                                  tlb_get_unmap_size(tlb));
> +#endif
>  }
>
>  #endif /* _ASM_RISCV_TLB_H */
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index a09196f8de68..f5c4fb0ae642 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -32,6 +32,8 @@ static inline void local_flush_tlb_page(unsigned long a=
ddr)
>  #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>  void flush_tlb_all(void);
>  void flush_tlb_mm(struct mm_struct *mm);
> +void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> +                       unsigned long end, unsigned int page_size);
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end);
> @@ -52,6 +54,7 @@ static inline void flush_tlb_range(struct vm_area_struc=
t *vma,
>  }
>
>  #define flush_tlb_mm(mm) flush_tlb_all()
> +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
>  #endif /* !CONFIG_SMP || !CONFIG_MMU */
>
>  /* Flush a range of kernel pages */
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 77be59aadc73..fa03289853d8 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -132,6 +132,13 @@ void flush_tlb_mm(struct mm_struct *mm)
>         __flush_tlb_range(mm, 0, -1, PAGE_SIZE);
>  }
>
> +void flush_tlb_mm_range(struct mm_struct *mm,
> +                       unsigned long start, unsigned long end,
> +                       unsigned int page_size)
> +{
> +       __flush_tlb_range(mm, start, end - start, page_size);
> +}
> +
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
>         __flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
> --
> 2.39.2
>
