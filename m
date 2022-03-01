Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7854C8D2C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiCAOBZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 09:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCAOBY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 09:01:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D928290CD0;
        Tue,  1 Mar 2022 06:00:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74A126152D;
        Tue,  1 Mar 2022 14:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EF5C340F7;
        Tue,  1 Mar 2022 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646143242;
        bh=OCDdNe18bifA05pJN6Z3cL5GH76Vx+vSN/tAl+9N2NY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BXoUaM8AeIN8f71PC8fIcrdCRd3XA5bTRsNaI55YrB3n8AdYcHHNQ5PfFONmNJdx9
         3/CPcWQI6xI4q3njZfKJ//7qUb0OLv2P2whtuS8vVnMjqGPoCVcBgHyuiPi2wNTcJ+
         KSByydI8JzRxlo4gWWoVzIU41cydpMN+5Nu46TbYtJPRxdtzH4yMR64LlBcFEmPqIp
         3wzu1lY8fiIAXNFPydAfWfshcQxjaRgRJyXZ322mrYl9USFIgjN6ICC0+WR+CyrjeE
         Jxihmtaod4/dKtcpNMu61/NIh4k/DY+2ax2xbrEVmUuihjdGPL4LSD/jeHzVTjPcDD
         a2kZEW+hgrGpQ==
Received: by mail-vk1-f179.google.com with SMTP id k15so6861271vkn.13;
        Tue, 01 Mar 2022 06:00:42 -0800 (PST)
X-Gm-Message-State: AOAM532svOJnKNVCpOs0IlDGjZXcO4evCD1SPI7pm5Nj7EyslyoRbkPD
        vJdwhXeldF8Otfh+pRp8enOgJ/Ks45erGexiw6s=
X-Google-Smtp-Source: ABdhPJwoZPlQG03sWsMv2LaiAVeC86gQ0+wyv+RzPw7RH1ttQNeeKqagstcZB00XUabb5ygCz6Zjo4KWbVCaIqQUo1I=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr10404475vkf.35.1646143241667; Tue, 01 Mar
 2022 06:00:41 -0800 (PST)
MIME-Version: 1.0
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com> <1646045273-9343-20-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1646045273-9343-20-git-send-email-anshuman.khandual@arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Mar 2022 22:00:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRSE-=-rDkMTD8D-bNw5inb4Yb_8S-AzXAuAthn9PCJmA@mail.gmail.com>
Message-ID: <CAJF2gTRSE-=-rDkMTD8D-bNw5inb4Yb_8S-AzXAuAthn9PCJmA@mail.gmail.com>
Subject: Re: [PATCH V3 19/30] csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Mon, Feb 28, 2022 at 7:10 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-csky@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/csky/Kconfig               |  1 +
>  arch/csky/include/asm/pgtable.h | 18 ------------------
>  arch/csky/mm/init.c             | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 132f43f12dd8..209dac5686dd 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -6,6 +6,7 @@ config CSKY
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +       select ARCH_HAS_VM_GET_PAGE_PROT
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
> diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
> index 151607ed5158..2c6b1cfb1cce 100644
> --- a/arch/csky/include/asm/pgtable.h
> +++ b/arch/csky/include/asm/pgtable.h
> @@ -76,24 +76,6 @@
>  #define MAX_SWAPFILES_CHECK() \
>                 BUILD_BUG_ON(MAX_SWAPFILES_SHIFT != 5)
>
> -#define __P000 PAGE_NONE
> -#define __P001 PAGE_READ
> -#define __P010 PAGE_READ
> -#define __P011 PAGE_READ
> -#define __P100 PAGE_READ
> -#define __P101 PAGE_READ
> -#define __P110 PAGE_READ
> -#define __P111 PAGE_READ
> -
> -#define __S000 PAGE_NONE
> -#define __S001 PAGE_READ
> -#define __S010 PAGE_WRITE
> -#define __S011 PAGE_WRITE
> -#define __S100 PAGE_READ
> -#define __S101 PAGE_READ
> -#define __S110 PAGE_WRITE
> -#define __S111 PAGE_WRITE
> -
>  extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define ZERO_PAGE(vaddr)       (virt_to_page(empty_zero_page))
>
> diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
> index bf2004aa811a..f9babbed17d4 100644
> --- a/arch/csky/mm/init.c
> +++ b/arch/csky/mm/init.c
> @@ -197,3 +197,35 @@ void __init fixaddr_init(void)
>         vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
>         fixrange_init(vaddr, vaddr + PMD_SIZE, swapper_pg_dir);
>  }
> +
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +       case VM_NONE:
> +               return PAGE_NONE;
> +       case VM_READ:
> +       case VM_WRITE:
> +       case VM_WRITE | VM_READ:
> +       case VM_EXEC:
> +       case VM_EXEC | VM_READ:
> +       case VM_EXEC | VM_WRITE:
> +       case VM_EXEC | VM_WRITE | VM_READ:
> +               return PAGE_READ;
> +       case VM_SHARED:
> +               return PAGE_NONE;
> +       case VM_SHARED | VM_READ:
> +               return PAGE_READ;
> +       case VM_SHARED | VM_WRITE:
> +       case VM_SHARED | VM_WRITE | VM_READ:
> +               return PAGE_WRITE;
> +       case VM_SHARED | VM_EXEC:
> +       case VM_SHARED | VM_EXEC | VM_READ:
> +               return PAGE_READ;
> +       case VM_SHARED | VM_EXEC | VM_WRITE:
> +       case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
> +               return PAGE_WRITE;
> +       default:
> +               BUILD_BUG();
> +       }
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
