Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BF129C9C
	for <lists+linux-arch@lfdr.de>; Tue, 24 Dec 2019 03:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfLXCOv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Dec 2019 21:14:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39587 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXCOv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Dec 2019 21:14:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so16987919qtm.6;
        Mon, 23 Dec 2019 18:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mXoFmqw2vJeUhs1GIs2JTlEy1nHGN2qgfTl1gP/Lo+A=;
        b=qlx5H5ZQO5QKJynv7TLWbTd3ZraXF/vFCdjn9duGW9JwZyB+m8+nI9iDliBwLynbDB
         8swFw5xiuZIHmDt7XHx+nuIMi0GoFI9DskqcOv2C/vuKjXRyzOvuHd1pW0OtplKGGBbB
         ZdlIePGJFnI+pIk67KdY6TL7AmnpVOHApUgxMsvUBo5ix/HWyg8SxoueUrYRU+h6Ic5d
         2PRB8CYNprHBboI3Yb5Fguc6FdJh27hEnLbScWjfLQLcyuz2lHAFhx18CmE+QcqimFAX
         zcSokQ9FSAsnQscLKDzqlTxycJRBIDMF5WH+IplkQjpRCruGxGc2qw6wfCz/JnaVgvCO
         2zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mXoFmqw2vJeUhs1GIs2JTlEy1nHGN2qgfTl1gP/Lo+A=;
        b=AMm3an0vqLzmrIYxJ8vJx+RRLpyaElsG01P9rPSK29HAnnhU7uPJ1/vabIa5SP7sNn
         h2ZkrD+LI69XmUcfIBiccaYzzJyLdSKngRLpjW0oQR1dGkfJwP/NUYZsn2be1hXDL/vT
         42JZbm4uubIIKSPERIk6dsUZVsu1/ZWxuBVblUWwce+4jziGmrk0bcjPocjQ6iWp6Mkb
         qZnX1TEWMXmfGf3PVodu1mpt4jJZja/ao6PVlmtnC9zR6mUWRdXyWYP45c3QKL+Mj4Ed
         ooMeUAhoQ3E4RNpCMr/KCYBBHC82yIfT6gWM5dXlNa3UfvOYb5o6szuJb+a7ItdnS/eE
         tWJA==
X-Gm-Message-State: APjAAAWrqKrzHNZnpR4WWgSijbMB53osYwZFl0UT2aBajX7PkaJescF6
        +voCYaTUTwOMIbXbn3gCLnhGJozpftRWMJtyopY=
X-Google-Smtp-Source: APXvYqyN/g9RjJwDYi2yDKRvGxF6/O62Sp5RNIcsaiSG5y1QS+Kk13wibiipdUnXIjMiqdQbhQqZJR2Ucn/uyr7RaoI=
X-Received: by 2002:ac8:5548:: with SMTP id o8mr26178455qtr.338.1577153690354;
 Mon, 23 Dec 2019 18:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20191223110004.2157-1-rppt@kernel.org> <20191223110004.2157-3-rppt@kernel.org>
In-Reply-To: <20191223110004.2157-3-rppt@kernel.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 24 Dec 2019 10:14:13 +0800
Message-ID: <CAEbi=3e0Bh__ROAx_HRD1EM25scPwTcVVwDa3eFrJnG8g3-5ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] nds32: fix build failure caused by page table folding updates
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Mike Rapoport <rppt@kernel.org> =E6=96=BC 2019=E5=B9=B412=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The commit 7c2763c42326 ("nds32: use pgtable-nopmd instead of
> 4level-fixup") missed the pmd_off_k() macro which caused the following
> build error:
>
>   CC      arch/nds32/mm/highmem.o
> In file included from arch/nds32/include/asm/page.h:57,
>                  from include/linux/mm_types_task.h:16,
>                  from include/linux/mm_types.h:5,
>                  from include/linux/mmzone.h:21,
>                  from include/linux/gfp.h:6,
>                  from include/linux/xarray.h:14,
>                  from include/linux/radix-tree.h:18,
>                  from include/linux/fs.h:15,
>                  from include/linux/highmem.h:5,
>                  from arch/nds32/mm/highmem.c:5:
> arch/nds32/mm/highmem.c: In function 'kmap_atomic':
> arch/nds32/include/asm/pgtable.h:360:44: error: passing argument 1 of 'pm=
d_offset' from incompatible pointer type [-Werror=3Dincompatible-pointer-ty=
pes]
>  #define pgd_offset(mm, address) ((mm)->pgd + pgd_index(address))
>                                  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> arch/nds32/include/asm/memory.h:33:29: note: in definition of macro '__ph=
ys_to_virt'
>  #define __phys_to_virt(x) ((x) - PHYS_OFFSET + PAGE_OFFSET)
>                              ^
> arch/nds32/include/asm/pgtable.h:193:55: note: in expansion of macro '__v=
a'
>  #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) =
& PAGE_MASK))
>                                                        ^~~~
> include/asm-generic/pgtable-nop4d.h:41:24: note: in expansion of macro 'p=
gd_val'
>  #define p4d_val(x)    (pgd_val((x).pgd))
>                         ^~~~~~~
> include/asm-generic/pgtable-nopud.h:50:24: note: in expansion of macro 'p=
4d_val'
>  #define pud_val(x)    (p4d_val((x).p4d))
>                         ^~~~~~~
> include/asm-generic/pgtable-nopmd.h:49:24: note: in expansion of macro 'p=
ud_val'
>  #define pmd_val(x)    (pud_val((x).pud))
>                         ^~~~~~~
> arch/nds32/include/asm/pgtable.h:193:60: note: in expansion of macro 'pmd=
_val'
>  #define pmd_page_kernel(pmd)         ((unsigned long) __va(pmd_val(pmd) =
& PAGE_MASK))
>                                                             ^~~~~~~
> arch/nds32/include/asm/pgtable.h:190:56: note: in expansion of macro 'pmd=
_page_kernel'
>  #define pte_offset_kernel(dir, address)      ((pte_t *)pmd_page_kernel(*=
(dir)) + pte_index(address))
>                                                         ^~~~~~~~~~~~~~~
> arch/nds32/mm/highmem.c:52:9: note: in expansion of macro 'pte_offset_ker=
nel'
>   ptep =3D pte_offset_kernel(pmd_off_k(vaddr), vaddr);
>          ^~~~~~~~~~~~~~~~~
> arch/nds32/include/asm/pgtable.h:362:33: note: in expansion of macro 'pgd=
_offset'
>  #define pgd_offset_k(addr)      pgd_offset(&init_mm, addr)
>                                  ^~~~~~~~~~
> arch/nds32/include/asm/pgtable.h:198:39: note: in expansion of macro 'pgd=
_offset_k'
>  #define pmd_off_k(address) pmd_offset(pgd_offset_k(address), address)
>                                        ^~~~~~~~~~~~
> arch/nds32/mm/highmem.c:52:27: note: in expansion of macro 'pmd_off_k'
>   ptep =3D pte_offset_kernel(pmd_off_k(vaddr), vaddr);
>                            ^~~~~~~~~
> In file included from arch/nds32/include/asm/pgtable.h:7,
>                  from include/linux/mm.h:99,
>                  from include/linux/highmem.h:8,
>                  from arch/nds32/mm/highmem.c:5:
> include/asm-generic/pgtable-nopmd.h:44:42: note: expected 'pud_t *' {aka =
'struct <anonymous> *'} but argument is of type 'pgd_t *' {aka 'long unsign=
ed int *'}
>  static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
>                                   ~~~~~~~~^~~
> In file included from arch/nds32/include/asm/page.h:57,
>                  from include/linux/mm_types_task.h:16,
>                  from include/linux/mm_types.h:5,
>                  from include/linux/mmzone.h:21,
>                  from include/linux/gfp.h:6,
>                  from include/linux/xarray.h:14,
>                  from include/linux/radix-tree.h:18,
>                  from include/linux/fs.h:15,
>                  from include/linux/highmem.h:5,
>                  from arch/nds32/mm/highmem.c:5:
>
> Updating the pmd_off_k() macro to use the correct page table unfolding
> fixes the issue.
>
> Fixes: 7c2763c42326 ("nds32: use pgtable-nopmd instead of 4level-fixup")
> Link: https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/nds32/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pg=
table.h
> index 0214e4150539..6abc58ac406d 100644
> --- a/arch/nds32/include/asm/pgtable.h
> +++ b/arch/nds32/include/asm/pgtable.h
> @@ -195,7 +195,7 @@ extern void paging_init(void);
>  #define pte_unmap(pte)         do { } while (0)
>  #define pte_unmap_nested(pte)  do { } while (0)
>
> -#define pmd_off_k(address)     pmd_offset(pgd_offset_k(address), address=
)
> +#define pmd_off_k(address)     pmd_offset(pud_offset(p4d_offset(pgd_offs=
et_k(address), (address)), (address)), (address))
>
>  #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
>  /*

Thank you, Mike.
Reviewed-by: Greentime Hu <green.hu@gmail.com>
