Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4E4BE99F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348213AbiBULzL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 06:55:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356969AbiBULzG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 06:55:06 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738071EEED;
        Mon, 21 Feb 2022 03:54:41 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id u10so17225797vsu.13;
        Mon, 21 Feb 2022 03:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9glkrk7WFBjBWlhxGJJjxKdsiWpb+Qpxc6YsbbmFGE=;
        b=WEIXnCdMIoqOxNuwXX78kcR4LqeBB7YRIdCysJLbhmbo1D9EO3Sj7heLsJPkgwh1I7
         Lyw5a5SQdQcPSRY+30lYw5S4LNe4pCLYNvi+anRpPRbAFiieofPpfuuFTdStC56yaYK7
         wxv+Q1ups177Re4FuPQ+pbxVXvMVPl0KW6tV1oYqSdjfA+nifRX3yVZiuJYJhUxNIDV9
         6ijtnvcHWt/gKAGQ5Z8vD931Jegu7zR0Gjy2ZfzzV+seiW5XPC4L+G2Dfxg2xQcnmi+1
         NM9X5lyiVv7lAZbyZvh2sIfUTaX1w6UpgXUOUgOy4uBkJFlmIhmOSQdHTu7uIcqJJXHk
         yH7Q==
X-Gm-Message-State: AOAM530HO39jN2B8/GiTD7qGIRGZtPHG9yCkoRm/udYFk+2cMtP56zao
        rmF1CJulFlfP9Xz6LoSENXySsK7HkkoXBA==
X-Google-Smtp-Source: ABdhPJyh1G2tM1yuaBb14wanBkfA8XBta8okdeqN1cA4hCMtWIremTrS/pMgq3OMx9Is8YvJt0sb6g==
X-Received: by 2002:a05:6102:418a:b0:31a:1d33:6803 with SMTP id cd10-20020a056102418a00b0031a1d336803mr7910313vsb.40.1645444480412;
        Mon, 21 Feb 2022 03:54:40 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id i13sm646550uap.12.2022.02.21.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 03:54:40 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id 110so5849721uak.4;
        Mon, 21 Feb 2022 03:54:39 -0800 (PST)
X-Received: by 2002:a9f:360f:0:b0:341:8a12:8218 with SMTP id
 r15-20020a9f360f000000b003418a128218mr6031609uad.14.1645444479570; Mon, 21
 Feb 2022 03:54:39 -0800 (PST)
MIME-Version: 1.0
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com> <1645425519-9034-9-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1645425519-9034-9-git-send-email-anshuman.khandual@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Feb 2022 12:54:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUrA4u5BTRuqTSn++vXFNn0w=HRmp9ZD_8SNZ1wMUKwwQ@mail.gmail.com>
Message-ID: <CAMuHMdUrA4u5BTRuqTSn++vXFNn0w=HRmp9ZD_8SNZ1wMUKwwQ@mail.gmail.com>
Subject: Re: [PATCH V2 08/30] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Anshuman,

On Mon, Feb 21, 2022 at 9:45 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks for your patch!

> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -128,3 +128,107 @@ void __init mem_init(void)
>         memblock_free_all();
>         init_pointer_tables();
>  }
> +
> +#ifdef CONFIG_COLDFIRE
> +/*
> + * Page protections for initialising protection_map. See mm/mmap.c
> + * for use. In general, the bit positions are xwr, and P-items are
> + * private, the S-items are shared.
> + */
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)

Wouldn't it make more sense to add this to arch/m68k/mm/mcfmmu.c?

> +{
> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +       case VM_NONE:
> +               return PAGE_NONE;
> +       case VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE);
> +       case VM_WRITE:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_WRITABLE);
> +       case VM_WRITE | VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE | CF_PAGE_WRITABLE);
> +       case VM_EXEC:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_EXEC);
> +       case VM_EXEC | VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE | CF_PAGE_EXEC);
> +       case VM_EXEC | VM_WRITE:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_WRITABLE | CF_PAGE_EXEC);
> +       case VM_EXEC | VM_WRITE | VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE | CF_PAGE_WRITABLE |
> +                               CF_PAGE_EXEC);
> +       case VM_SHARED:
> +               return PAGE_NONE;
> +       case VM_SHARED | VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE);

This is the same as the plain VM_READ case.
Perhaps they can be merged?

> +       case VM_SHARED | VM_WRITE:
> +               return PAGE_SHARED;
> +       case VM_SHARED | VM_WRITE | VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE | CF_PAGE_SHARED);
> +       case VM_SHARED | VM_EXEC:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_EXEC);

Same as plain VM_EXEC.

> +       case VM_SHARED | VM_EXEC | VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE | CF_PAGE_EXEC);

Same as plain VM_EXEC | VM_READ.

> +       case VM_SHARED | VM_EXEC | VM_WRITE:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_SHARED | CF_PAGE_EXEC);
> +       case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
> +               return __pgprot(CF_PAGE_VALID | CF_PAGE_ACCESSED |
> +                               CF_PAGE_READABLE | CF_PAGE_SHARED |
> +                               CF_PAGE_EXEC);
> +       default:
> +               BUILD_BUG();
> +       }
> +}
> +#endif
> +
> +#ifdef CONFIG_SUN3
> +/*
> + * Page protections for initialising protection_map. The sun3 has only two
> + * protection settings, valid (implying read and execute) and writeable. These
> + * are as close as we can get...
> + */
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)

Wouldn't it make more sense to add this to arch/m68k/mm/sun3mmu.c?

> +{
> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +       case VM_NONE:
> +               return PAGE_NONE;
> +       case VM_READ:
> +               return PAGE_READONLY;
> +       case VM_WRITE:
> +       case VM_WRITE | VM_READ:

So you did merge some of them...

> +               return PAGE_COPY;
> +       case VM_EXEC:
> +       case VM_EXEC | VM_READ:
> +               return PAGE_READONLY;

But not all? More below...

> +       case VM_EXEC | VM_WRITE:
> +       case VM_EXEC | VM_WRITE | VM_READ:
> +               return PAGE_COPY;
> +       case VM_SHARED:
> +               return PAGE_NONE;
> +       case VM_SHARED | VM_READ:
> +               return PAGE_READONLY;
> +       case VM_SHARED | VM_WRITE:
> +       case VM_SHARED | VM_WRITE | VM_READ:
> +               return PAGE_SHARED;
> +       case VM_SHARED | VM_EXEC:
> +       case VM_SHARED | VM_EXEC | VM_READ:
> +               return PAGE_READONLY;
> +       case VM_SHARED | VM_EXEC | VM_WRITE:
> +       case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
> +               return PAGE_SHARED;
> +       default:
> +               BUILD_BUG();
> +       }
> +}
> +#endif
> +EXPORT_SYMBOL(vm_get_page_prot);
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index ecbe948f4c1a..495ba0ea083c 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -400,12 +400,9 @@ void __init paging_init(void)
>
>         /* Fix the cache mode in the page descriptors for the 680[46]0.  */
>         if (CPU_IS_040_OR_060) {
> -               int i;
>  #ifndef mm_cachebits
>                 mm_cachebits = _PAGE_CACHE040;
>  #endif
> -               for (i = 0; i < 16; i++)
> -                       pgprot_val(protection_map[i]) |= _PAGE_CACHE040;
>         }
>
>         min_addr = m68k_memory[0].addr;
> @@ -483,3 +480,48 @@ void __init paging_init(void)
>         max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
>         free_area_init(max_zone_pfn);
>  }
> +
> +/*
> + * The m68k can't do page protection for execute, and considers that
> + * the same are read. Also, write permissions imply read permissions.
> + * This is the closest we can get..
> + */
> +pgprot_t vm_get_page_prot(unsigned long vm_flags)

Good, this one is in arch/m68k/mm/motorola.c :-)

> +{
> +       unsigned long cachebits = 0;
> +
> +       if (CPU_IS_040_OR_060)
> +               cachebits = _PAGE_CACHE040;

If you would use the non-"_C"-variants (e.g. PAGE_NONE instead of
PAGE_NONE_C) below, you would get the cachebits handling for free!
After that, the "_C" variants are no longer used, and can be removed.
Cfr. arch/m68k/include/asm/motorola_pgtable.h:

    #define PAGE_NONE       __pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED |
mm_cachebits)
    #define PAGE_SHARED     __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED |
mm_cachebits)
    #define PAGE_COPY       __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
_PAGE_ACCESSED | mm_cachebits)
    #define PAGE_READONLY   __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
_PAGE_ACCESSED | mm_cachebits)
    #define PAGE_KERNEL     __pgprot(_PAGE_PRESENT | _PAGE_DIRTY |
_PAGE_ACCESSED | mm_cachebits)

    /* Alternate definitions that are compile time constants, for
       initializing protection_map.  The cachebits are fixed later.  */
    #define PAGE_NONE_C     __pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
    #define PAGE_SHARED_C   __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
    #define PAGE_COPY_C     __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
_PAGE_ACCESSED)
    #define PAGE_READONLY_C __pgprot(_PAGE_PRESENT | _PAGE_RONLY |
_PAGE_ACCESSED)

BTW, this shows you left a reference in a comment to the now-gone
"protection_map".  There are several more across the tree.

> +
> +       switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
> +       case VM_NONE:
> +               return __pgprot(pgprot_val(PAGE_NONE_C) | cachebits);
> +       case VM_READ:
> +               return __pgprot(pgprot_val(PAGE_READONLY_C) | cachebits);
> +       case VM_WRITE:
> +       case VM_WRITE | VM_READ:
> +               return __pgprot(pgprot_val(PAGE_COPY_C) | cachebits);
> +       case VM_EXEC:
> +       case VM_EXEC | VM_READ:
> +               return __pgprot(pgprot_val(PAGE_READONLY_C) | cachebits);
> +       case VM_EXEC | VM_WRITE:
> +       case VM_EXEC | VM_WRITE | VM_READ:
> +               return __pgprot(pgprot_val(PAGE_COPY_C) | cachebits);
> +       case VM_SHARED:
> +               return __pgprot(pgprot_val(PAGE_NONE_C) | cachebits);

Same as the VM_NONE case.  More to be merged below...

> +       case VM_SHARED | VM_READ:
> +               return __pgprot(pgprot_val(PAGE_READONLY_C) | cachebits);
> +       case VM_SHARED | VM_WRITE:
> +       case VM_SHARED | VM_WRITE | VM_READ:
> +               return __pgprot(pgprot_val(PAGE_SHARED_C) | cachebits);
> +       case VM_SHARED | VM_EXEC:
> +       case VM_SHARED | VM_EXEC | VM_READ:
> +               return __pgprot(pgprot_val(PAGE_READONLY_C) | cachebits);
> +       case VM_SHARED | VM_EXEC | VM_WRITE:
> +       case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
> +               return __pgprot(pgprot_val(PAGE_SHARED_C) | cachebits);
> +       default:
> +               BUILD_BUG();
> +       }
> +}
> +EXPORT_SYMBOL(vm_get_page_prot);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
