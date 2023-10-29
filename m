Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB97DAE2D
	for <lists+linux-arch@lfdr.de>; Sun, 29 Oct 2023 21:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjJ2UR6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Oct 2023 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJ2UR6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 Oct 2023 16:17:58 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EBBC0;
        Sun, 29 Oct 2023 13:17:52 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4a8158e8613so1519222e0c.3;
        Sun, 29 Oct 2023 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698610672; x=1699215472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qknPkF/GhioNTqsfL8PFnCh2jVNaQR/cXCoqmSLii5U=;
        b=Z9OAnamaTVxuXra/pe9fhAzYBshFIaCM+iras58b9g5+2cEnmoPZ+RR8ARDGBurSRS
         itJoKxwIsUkLp1KsNOV3IX+hhuAdcQ9LXGAQ1PkpRqz1dYLimNzZnewG5WRkIQgOXMK2
         6717RtEhQy317zQggd87hh0+mLSyv8+SPEn7uegjmdFDopywGD/t4G8S2oAzb8a+SWDp
         GmZOBOD/YdmYyugAK+8MTEV3Xb4UlVQqUwNhdhoy1HylhAJCQcEJCKc3Mgc2+bTPKc8s
         1PNMcAySOESJTp47Z1lbKy5ByHMXkUcf/OQcHhSP1YQUfBoUIabER80NsTsdSHXg9Nam
         +a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698610672; x=1699215472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qknPkF/GhioNTqsfL8PFnCh2jVNaQR/cXCoqmSLii5U=;
        b=UMI0W+Gb963cUxik2VxgQn8KkaZofbKK4nFTRKlna6jW1o6DiGzW8d4BksKk+Js9uM
         e4YUHBdOuYMhnLSsQc2qqKZCPxIW+doG/NP6h8TFzt/EAgb0b1unsRzILvrNpciDjhsJ
         qR9aJcb5WWGNZC5XVT/dNyzkJrsGFbn3TV7qkqhYaC36J+PmgE1JJbF35k4jSBjFyYSR
         8PyS8NfdIY1fuojNCK682+7p9ia+toSpSjKkxx3zzPoJEil0tXHN1mdVydInLYYX8gBy
         Z/knsQrr7fkergb869xkBNp5mM29xkg21qU6RPc7StOaufvLzLnWoQKVIM6oRWUm2fxl
         56DQ==
X-Gm-Message-State: AOJu0YyJQv6PbJ656WLJXKUgQ8FRAve1KEB4+b2LzU3WS03+YO+NuHlz
        69gUuj+rqN7mcJ7ZFVDJxl9cXom36tQEkMdrnlU=
X-Google-Smtp-Source: AGHT+IE5zqFYBvu9XQ7wx3aCUfgWrL3jx20mGsGKxg8tg0GI13mG8EhWtlf6S8LkhPqjgCQ9LcKtSnt1Q9U/FbEwrnk=
X-Received: by 2002:a1f:ad04:0:b0:495:cace:d59c with SMTP id
 w4-20020a1fad04000000b00495caced59cmr6820612vke.0.1698610671799; Sun, 29 Oct
 2023 13:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231019140151.21629-1-alexghiti@rivosinc.com> <20231019140151.21629-3-alexghiti@rivosinc.com>
In-Reply-To: <20231019140151.21629-3-alexghiti@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 29 Oct 2023 20:17:25 +0000
Message-ID: <CA+V-a8sjeT3_BR2waskiZ1zCXFi+R2z67R7SznyjV_2+vGzU8A@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] riscv: Improve flush_tlb_range() for hugetlb pages
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
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
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

On Thu, Oct 19, 2023 at 3:04=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
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
> ---
>  arch/riscv/mm/tlbflush.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #
On RZ/Five SMARC

Cheers,
Prabhakar

> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index fa03289853d8..5933744df91a 100644
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
> @@ -147,7 +148,35 @@ void flush_tlb_page(struct vm_area_struct *vma, unsi=
gned long addr)
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end)
>  {
> -       __flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
> +       unsigned long stride_size;
> +
> +       if (!is_vm_hugetlb_page(vma)) {
> +               stride_size =3D PAGE_SIZE;
> +       } else {
> +               stride_size =3D huge_page_size(hstate_vma(vma));
> +
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +               /*
> +                * As stated in the privileged specification, every PTE i=
n a
> +                * NAPOT region must be invalidated, so reset the stride =
in that
> +                * case.
> +                */
> +               if (has_svnapot()) {
> +                       if (stride_size >=3D PGDIR_SIZE)
> +                               stride_size =3D PGDIR_SIZE;
> +                       else if (stride_size >=3D P4D_SIZE)
> +                               stride_size =3D P4D_SIZE;
> +                       else if (stride_size >=3D PUD_SIZE)
> +                               stride_size =3D PUD_SIZE;
> +                       else if (stride_size >=3D PMD_SIZE)
> +                               stride_size =3D PMD_SIZE;
> +                       else
> +                               stride_size =3D PAGE_SIZE;
> +               }
> +#endif
> +       }
> +
> +       __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>  }
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start=
,
> --
> 2.39.2
>
