Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73F7A620F
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 14:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjISMI0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 08:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjISMIY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 08:08:24 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49850F4;
        Tue, 19 Sep 2023 05:08:18 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-495e049a28bso2344995e0c.1;
        Tue, 19 Sep 2023 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695125297; x=1695730097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2iPmpjEwyRg01FPSaJcAL+Fk1h/zdCL91gxz6OrpHQ=;
        b=QRtDcdTofcZUtiIljqk3fgNdOhbzyePHrSeHB7Uqaeabu3awTy+5kxq2pZN9x4+Nwi
         C2naV6JB9LGJRR22yGtPF9UBRAfh5y12n12Evwp8e8/aXEr3wmyu8qUEzxSnF9fUEpnM
         z+cjuXlyFYbkf6iTdFxtpLWfFVOey0Ex+0KTwD3d/C4b0nn92kwEKR3wrOC8kEOHEKgm
         LJ6+q1ZFM0LiT3wOOFtzlNiLYJoec2R/IWu65N7DNtUdjzkw9SVHsrdydvdoNyeLgHsF
         Ymp1/fR3ME5lkPBssVkjfY1YVfwCJYtN0sSzLGa0IOpVkSAq6b4t9H0cRJ6nIpaHyEaz
         AGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125297; x=1695730097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2iPmpjEwyRg01FPSaJcAL+Fk1h/zdCL91gxz6OrpHQ=;
        b=v9qRWO0bS0ydMeP+jWmAZH5YbWrl5UD/Dp9wLhrl+zUj6jYlTiZEtevf4jS0nVIiHO
         M5MjnXUQf+IsCqHxl4RPJ7nIl6ZPHrnAdq9Cj27G6JTECiWWJyZ+/hGOziH5oCPtpUs9
         B3jZa1WISfgKb4anrMsPoC+5WGqgIuBj1rG9pi0Jt8z1AOV+tRHPdu1wqSwogRDbvcdM
         1a0VwTaaMiCdshOSfD8OdE0LRWfFR+L/QEgD464+MRJVMOCC+gBUnCkvqCZXBHznpM09
         zMQhBilfaOFMCT1EtK0n7F6djWWLmZijjGqLt2Irv9pV8kulMo8fbwWpcJJePF5YgqJk
         ca+Q==
X-Gm-Message-State: AOJu0YxrKghN8C74GKO6VHQ03JUS7DCoiACZgPeZJsgHamQgSGWxrKMu
        AO6eKcJZOayQw+6S2NSDbBQAWUxSlXm6oYdaCfE=
X-Google-Smtp-Source: AGHT+IH7TN3P7HJQ05oem8BOcqLZTDht3nkk5RIet6AG+k4/cvg4jSeSddT/b2QnHf7bMT6zLQnkiWr6pF/YfiLXevU=
X-Received: by 2002:a1f:cc01:0:b0:48f:e2eb:6dd9 with SMTP id
 c1-20020a1fcc01000000b0048fe2eb6dd9mr8987999vkg.8.1695125297222; Tue, 19 Sep
 2023 05:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230911131224.61924-1-alexghiti@rivosinc.com> <20230911131224.61924-3-alexghiti@rivosinc.com>
In-Reply-To: <20230911131224.61924-3-alexghiti@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 19 Sep 2023 13:07:51 +0100
Message-ID: <CA+V-a8soezvPad=m4m2CN5QJ5qVOAxyjA6z=w3fUu7h8EF_B-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
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

On Mon, Sep 11, 2023 at 2:14=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> flush_tlb_range() uses a fixed stride of PAGE_SIZE and in its current for=
m,
> when a hugetlb mapping needs to be flushed, flush_tlb_range() flushes the
> whole tlb: so set a stride of the size of the hugetlb mapping in order to
> only flush the hugetlb mapping. However, if the hugepage is a NAPOT regio=
n,
> all PTEs that constitute this mapping must be invalidated, so the stride
> size must actually be the size of the PTE.
>
> Note that THPs are directly handled by flush_pmd_tlb_range().
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/mm/tlbflush.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #
On RZ/Five SMARC

Cheers,
Prabhakar

> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index fa03289853d8..5bda6d4fed90 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -3,6 +3,7 @@
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/sched.h>
> +#include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
>
> @@ -147,7 +148,43 @@ void flush_tlb_page(struct vm_area_struct *vma, unsi=
gned long addr)
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end)
>  {
> -       __flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
> +       unsigned long stride_size;
> +
> +       stride_size =3D is_vm_hugetlb_page(vma) ?
> +                               huge_page_size(hstate_vma(vma)) :
> +                               PAGE_SIZE;
> +
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +       /*
> +        * As stated in the privileged specification, every PTE in a NAPO=
T
> +        * region must be invalidated, so reset the stride in that case.
> +        */
> +       if (has_svnapot()) {
> +               unsigned long order, napot_size;
> +
> +               for_each_napot_order(order) {
> +                       napot_size =3D napot_cont_size(order);
> +
> +                       if (stride_size !=3D napot_size)
> +                               continue;
> +
> +                       if (napot_size >=3D PGDIR_SIZE)
> +                               stride_size =3D PGDIR_SIZE;
> +                       else if (napot_size >=3D P4D_SIZE)
> +                               stride_size =3D P4D_SIZE;
> +                       else if (napot_size >=3D PUD_SIZE)
> +                               stride_size =3D PUD_SIZE;
> +                       else if (napot_size >=3D PMD_SIZE)
> +                               stride_size =3D PMD_SIZE;
> +                       else
> +                               stride_size =3D PAGE_SIZE;
> +
> +                       break;
> +               }
> +       }
> +#endif
> +
> +       __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>  }
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
> --
> 2.39.2
>
