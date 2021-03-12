Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46533924A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 16:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhCLPu7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 10:50:59 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:33783 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhCLPu2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Mar 2021 10:50:28 -0500
Received: by mail-vk1-f181.google.com with SMTP id b10so1331909vkl.0;
        Fri, 12 Mar 2021 07:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCfkIhb98hO8prK8G14q0f8cJZYCOLvGnWWBybf+4M4=;
        b=qDjjPnm4GsWqw9arX7YS4JbnoF/uimOrXYR+F2Md6rJtXsHumdkyauGoG9vFN34U3a
         jfjNNFWGgrBZFvvO8hB1QbFxAwsa7QG3Fglp5mXM5cGgFlz4+P6zlCl+rGDh+IGTNTBv
         0rQOPY5hJ8cMF1rxuiWjHEzHC4QrjVujR75wNKu36h4n3bZt2Ra9MvJ8mWV02H5zp80R
         zuvanIPriaGdTMFbabBKgdvQ7Wfi9z3iJrSHnrGA1126A0H8yaBBE0EI5o584EHdf1TW
         T+KqbTO8bL7AzzOJqiWQ8PBVDg8WaoRh1PVo0LfkFbdWI89yf77yNtTruhx6phmYxdW7
         jtwA==
X-Gm-Message-State: AOAM531lwpnEFOcLsY2YI8zRB7ofbrlZhLTkSCFNb8OeKjdmR9UnxFWQ
        JcR+XWfElrg0ODvyFYg38dJ52UFvErn81ejHLAw=
X-Google-Smtp-Source: ABdhPJwsMcqnQfXHsxIHY91a/cjGAOuKpduZxiaHjuntYgfG+B2bSXLd5roumZI4ThaBStcLstXBt5hqmJwMf4W7HfQ=
X-Received: by 2002:a1f:e543:: with SMTP id c64mr4486729vkh.2.1615564227436;
 Fri, 12 Mar 2021 07:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20201119003829.1282810-1-atish.patra@wdc.com> <20201119003829.1282810-4-atish.patra@wdc.com>
 <CAMuHMdUjh9znKTLZ+bST6aDUFdZzvmv2SGVy=sRQ6+D=pYM9cg@mail.gmail.com>
In-Reply-To: <CAMuHMdUjh9znKTLZ+bST6aDUFdZzvmv2SGVy=sRQ6+D=pYM9cg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Mar 2021 16:50:16 +0100
Message-ID: <CAMuHMdUfQCSyuHxf+TjuOGDtLMAv30x2LazvO8BQwE1=B1kzVg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] riscv: Separate memory init from paging init
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Atish,

On Wed, Mar 10, 2021 at 5:41 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Nov 19, 2020 at 1:40 AM Atish Patra <atish.patra@wdc.com> wrote:
> > Currently, we perform some memory init functions in paging init. But,
> > that will be an issue for NUMA support where DT needs to be flattened
> > before numa initialization and memblock_present can only be called
> > after numa initialization.
> >
> > Move memory initialization related functions to a separate function.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> This is now commit cbd34f4bb37d62d8 in v5.12-rc1, breaking the boot on
> Vexriscv:
>
> [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> [    0.000000] printk: bootconsole [sbi0] enabled
> [    0.000000] printk: debug: ignoring loglevel setting.
> [    0.000000] Initial ramdisk at: 0x(ptrval) (8388608 bytes)
> [    0.000000] Unable to handle kernel paging request at virtual
> address c8000008

> Note that I have "[PATCH v2 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32"[1]
> applied, to avoid another crash (7c4fc8e3e982 = v5.11 + [1] +
> cherry-picked commits from the riscv-for-linus-5.12-mw0 pull request).
>
> If I revert the L1_CACHE_BYTES change, the boot continues, but I'm back
> to the old issue fixed by [1]:
>
> [   22.126687] Freeing initrd memory: 8192K
> [   22.321811] workingset: timestamp_bits=30 max_order=15 bucket_order=0
> [   29.001509] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 253)
> [   29.021555] io scheduler mq-deadline registered
> [   29.033692] io scheduler kyber registered
> [   29.141294] Unable to handle kernel paging request at virtual
> address 69726573

> Will have a deeper look later...

I found the core issue, and sent a fix: "[PATCH] RISC-V: Fix
out-of-bounds accesses in init_resources()"
https://lore.kernel.org/linux-riscv/20210312154634.3541844-1-geert@linux-m68k.org/

It works now with either value of L1_CACHE_SHIFT, so patch "[PATCH v2
3/4] RISC-V: Fix L1_CACHE_BYTES for RV32" is no longer needed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
