Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95F4206AA
	for <lists+linux-arch@lfdr.de>; Mon,  4 Oct 2021 09:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhJDHdb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Oct 2021 03:33:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40424
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhJDHda (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Oct 2021 03:33:30 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 542BE402D7
        for <linux-arch@vger.kernel.org>; Mon,  4 Oct 2021 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633332701;
        bh=yMz7a2U4h7tYNWu8HY/sX3yR4RwoKAQESOaigGzONNc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rzrp8eHoUu/E0MdyIqiNeLjtLUTo5RU1aQSi400AAWw97HpP9MfAqwqmGFJV0UeUV
         nHfYSJEFH9wo1vSNaGjgZkDhU1/t+h+sxtwFSK7HpC9jBPyKcY1vaKhOHM++gDTfvF
         MsSPc3vYZMKfHom9X/V7jh8GIhowcJWG3a+et5nkAD+uJHPeo6dM4q+lFQM3BFqean
         +6luO2A6mfDCwF6sBYjEXnw/TXQHZty4LOohtkIYoy0XA/48T8z6ZkNvBfdZ634YWB
         2YRp7sxx1PZv4Ii7Vxp/IGEmqKNveu3N0vMGtvzU57Du4gJSzSuBSvbjCPSuesnkZ1
         KYDh0UJTEgvuw==
Received: by mail-ed1-f69.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so15972139edj.21
        for <linux-arch@vger.kernel.org>; Mon, 04 Oct 2021 00:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMz7a2U4h7tYNWu8HY/sX3yR4RwoKAQESOaigGzONNc=;
        b=hrzYU7PxSkrSjh7Y2c9PpftYXX1tyBVes8LPX5zP40TAYvzTVa9TbaKAkfNwce7yO0
         4qzVGi0gdmHknsLTKlYJxpTGHgWusS9OE1be4hdymE74DwH3mRW8mks9Wlu3tBNRAJhQ
         y8CkbIIKoxoaIoL2688t7bCCNzmOLqjo4NvKUBtcR61MZdbLNd/y/MO6Si1MTUMBOUu2
         YAwFZc4McroWbAj7pElSSEnZ+gXsZof70qRsSsrqhWQRxTdGiyAUpm1OY40z5lpYdo4J
         Xt14Ow14RY1kpHBSdt6nEmQgNMp1w0CHOjFYW2RlNmiSCqBN9tUuyk013+UdNafGrJz3
         7YpQ==
X-Gm-Message-State: AOAM532HswA6LI7zmzOM8KY3jhls0tB8SqgyEPXD0EjLbIw3hvBAUiSk
        G/Yzv73Cs3Y0LoJkCVZ+AePwZbf5zIUxhv+9vjPr287hJsXZVq+rzDs5ZSMCFb13ypUPvLWV44e
        OQdHr0gPzkppzwyADXBeK4Im3aWv9En9aZCgZTvTd4QJr/6Imkl7mF1g=
X-Received: by 2002:a17:906:ed1:: with SMTP id u17mr16035054eji.304.1633332699389;
        Mon, 04 Oct 2021 00:31:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHAhKgffAcQ9Ok5Z/TiUwt7wu3AralX9OFoEmbqnI+tZ2U37Ef48COxQfqHUgegwirzhI9KM/V5gt3fvDAjXQ=
X-Received: by 2002:a17:906:ed1:: with SMTP id u17mr16035032eji.304.1633332699195;
 Mon, 04 Oct 2021 00:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
 <20210929145113.1935778-5-alexandre.ghiti@canonical.com> <748a2c58-4d69-6457-0aa5-89797cb45a5c@sholland.org>
In-Reply-To: <748a2c58-4d69-6457-0aa5-89797cb45a5c@sholland.org>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Mon, 4 Oct 2021 09:31:26 +0200
Message-ID: <CA+zEjCv-2ONyXykRLP2dabELimYbbCmREP5v6DfeV5zk5T+zRg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] riscv: Implement sv48 support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-doc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 4, 2021 at 3:34 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 9/29/21 9:51 AM, Alexandre Ghiti wrote:
> > By adding a new 4th level of page table, give the possibility to 64bit
> > kernel to address 2^48 bytes of virtual address: in practice, that offers
> > 128TB of virtual address space to userspace and allows up to 64TB of
> > physical memory.
> >
> > If the underlying hardware does not support sv48, we will automatically
> > fallback to a standard 3-level page table by folding the new PUD level into
> > PGDIR level. In order to detect HW capabilities at runtime, we
> > use SATP feature that ignores writes with an unsupported mode.
> >
> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > ---
> >  arch/riscv/Kconfig                      |   4 +-
> >  arch/riscv/include/asm/csr.h            |   3 +-
> >  arch/riscv/include/asm/fixmap.h         |   1 +
> >  arch/riscv/include/asm/kasan.h          |   2 +-
> >  arch/riscv/include/asm/page.h           |  10 +
> >  arch/riscv/include/asm/pgalloc.h        |  40 ++++
> >  arch/riscv/include/asm/pgtable-64.h     | 108 ++++++++++-
> >  arch/riscv/include/asm/pgtable.h        |  13 +-
> >  arch/riscv/kernel/head.S                |   3 +-
> >  arch/riscv/mm/context.c                 |   4 +-
> >  arch/riscv/mm/init.c                    | 237 ++++++++++++++++++++----
> >  arch/riscv/mm/kasan_init.c              |  91 +++++++--
> >  drivers/firmware/efi/libstub/efi-stub.c |   2 +
> >  13 files changed, 453 insertions(+), 65 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 13e9c4298fbc..69c5533955ed 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -149,7 +149,7 @@ config PAGE_OFFSET
> >       hex
> >       default 0xC0000000 if 32BIT
> >       default 0x80000000 if 64BIT && !MMU
> > -     default 0xffffffe000000000 if 64BIT
> > +     default 0xffffc00000000000 if 64BIT
> >
> >  config ARCH_FLATMEM_ENABLE
> >       def_bool !NUMA
> > @@ -197,7 +197,7 @@ config FIX_EARLYCON_MEM
> >
> >  config PGTABLE_LEVELS
> >       int
> > -     default 3 if 64BIT
> > +     default 4 if 64BIT
> >       default 2
> >
> >  config LOCKDEP_SUPPORT
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > index 87ac65696871..3fdb971c7896 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -40,14 +40,13 @@
> >  #ifndef CONFIG_64BIT
> >  #define SATP_PPN     _AC(0x003FFFFF, UL)
> >  #define SATP_MODE_32 _AC(0x80000000, UL)
> > -#define SATP_MODE    SATP_MODE_32
> >  #define SATP_ASID_BITS       9
> >  #define SATP_ASID_SHIFT      22
> >  #define SATP_ASID_MASK       _AC(0x1FF, UL)
> >  #else
> >  #define SATP_PPN     _AC(0x00000FFFFFFFFFFF, UL)
> >  #define SATP_MODE_39 _AC(0x8000000000000000, UL)
> > -#define SATP_MODE    SATP_MODE_39
> > +#define SATP_MODE_48 _AC(0x9000000000000000, UL)
> >  #define SATP_ASID_BITS       16
> >  #define SATP_ASID_SHIFT      44
> >  #define SATP_ASID_MASK       _AC(0xFFFF, UL)
> > diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> > index 54cbf07fb4e9..58a718573ad6 100644
> > --- a/arch/riscv/include/asm/fixmap.h
> > +++ b/arch/riscv/include/asm/fixmap.h
> > @@ -24,6 +24,7 @@ enum fixed_addresses {
> >       FIX_HOLE,
> >       FIX_PTE,
> >       FIX_PMD,
> > +     FIX_PUD,
> >       FIX_TEXT_POKE1,
> >       FIX_TEXT_POKE0,
> >       FIX_EARLYCON_MEM_BASE,
> > diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> > index a2b3d9cdbc86..1dcf5fa93aa0 100644
> > --- a/arch/riscv/include/asm/kasan.h
> > +++ b/arch/riscv/include/asm/kasan.h
> > @@ -27,7 +27,7 @@
> >   */
> >  #define KASAN_SHADOW_SCALE_SHIFT     3
> >
> > -#define KASAN_SHADOW_SIZE    (UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
> > +#define KASAN_SHADOW_SIZE    (UL(1) << ((VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
>
> Does this change belong in patch 1, where you remove CONFIG_VA_BITS?

Indeed, I fixed KASAN in this version and wrongly rebased the changes.

Thanks!

Alex

>
> Regards,
> Samuel
