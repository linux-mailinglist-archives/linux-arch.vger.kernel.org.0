Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3E494B57
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jan 2022 11:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359717AbiATKGE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Jan 2022 05:06:04 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40070
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359708AbiATKGD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jan 2022 05:06:03 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 171E24005A
        for <linux-arch@vger.kernel.org>; Thu, 20 Jan 2022 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642673158;
        bh=w26SyRlRb1I1H6K/gmJqzdX3K4fWh5zNRWtuBCu0Vhg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=VNMt+JsWEOJJunb/ly1GHJWU07VqTDZ1ukJy7obr5XJrK+UViouHuR23qFNNMnVZO
         67nRg6dKQ2dKbQL+XFUnaEe+wnVsMXj4k9U2pTK5b0xPLDKTJE6HnVz2xmV2ggSTY1
         PsbX+QkEDvo/vWbu0nc5lmHnEltsKcgmHrUHGHJnckwYZT2rJHarRIC+I6P2BfTg/X
         P9d3VxbH6MUbXClmwcPEJWLdrVhz48XxTQU/xR0Jx8CftPlGoG8bRMcaYMzYNBxbU7
         e/3o4gypvdmAXYMAVDYiHT2uJVdTDCQTcOeZ6xmOBnVQvBezZJd74BYM64Zmz8vnrh
         RplF8oYkvc7YQ==
Received: by mail-ed1-f70.google.com with SMTP id k10-20020a50cb8a000000b00403c8326f2aso5464577edi.6
        for <linux-arch@vger.kernel.org>; Thu, 20 Jan 2022 02:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w26SyRlRb1I1H6K/gmJqzdX3K4fWh5zNRWtuBCu0Vhg=;
        b=osNy/68KU0flKpvY0zAj4rP59GAsyQi11Ji7d+ZtbWNRESypBGSWcfpF1HUoHD3xiz
         jSs9Mth7LHJixfGJ+pHNXSZIAjWcgEXTAS/1dNJXuKHMLVBAV+gW6FVRzr9Lm8Ssd6E0
         2kVucR3sx2WrzDubm5g88aa1wC9PMI6iVojVrudUTox3UbD93e5acVOQNWk46dP7KPNK
         YdKQpzoPAoQpg/iKBNsAyg8rzz+TR8n67BhGMiSNVMy270WppHUjd2bNYuvMoRoW3ltz
         l3Hgh2RvYrfpQCjKyL1HBWBji1QjC39jZ5ZJ4KZaK0I0ZomSJ5RgLqfrgqp6lCeJTTUC
         YOaw==
X-Gm-Message-State: AOAM533U45spI7fg1xHzLWfTJk3+YRgVdkRcgSZHSjzC5ePQRMJ2JPNC
        5h6ucChzy5KfgPKAN12KFUcs2xYZVIG5UrASHdIRxlLGkFyXbILtv7XLWoy0nbJIEZNNa8P4FKI
        UhnVh2ELW+7da4A1DXK0BTP0ziP0sflXD/4f3FS6bwAednuV4D06eSDk=
X-Received: by 2002:a05:6402:b33:: with SMTP id bo19mr7643855edb.70.1642673157485;
        Thu, 20 Jan 2022 02:05:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynv0ocn7NF6vgUdF1oJY52IvmBizAszTcAGapgjCakCzI58Vihpn2W5C5OjIWMX2LmXdeXWqskyns8624yTaM=
X-Received: by 2002:a05:6402:b33:: with SMTP id bo19mr7643811edb.70.1642673157166;
 Thu, 20 Jan 2022 02:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
 <mhng-cdec292e-aea2-4b76-8853-b8465521e94f@palmer-ri-x1c9> <CA+zEjCuTSjOCmNExSN1jO50tsuXNzL9x6K6jWjG4+vVky5eWsw@mail.gmail.com>
In-Reply-To: <CA+zEjCuTSjOCmNExSN1jO50tsuXNzL9x6K6jWjG4+vVky5eWsw@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 20 Jan 2022 11:05:46 +0100
Message-ID: <CA+zEjCuTYmk-dLPhJ=9CkNrqf7VbCNyRDSZUGYkJSUWqZDWHpA@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Introduce sv48 support without relocatable kernel
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, zong.li@sifive.com, anup@brainfault.org,
        Atish.Patra@rivosinc.com, Christoph Hellwig <hch@lst.de>,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        keescook@chromium.org, guoren@linux.alibaba.com,
        heinrich.schuchardt@canonical.com, mchitale@ventanamicro.com,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 20, 2022 at 8:30 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Thu, Jan 20, 2022 at 5:18 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Mon, 06 Dec 2021 02:46:44 PST (-0800), alexandre.ghiti@canonical.com wrote:
> > > * Please note notable changes in memory layouts and kasan population *
> > >
> > > This patchset allows to have a single kernel for sv39 and sv48 without
> > > being relocatable.
> > >
> > > The idea comes from Arnd Bergmann who suggested to do the same as x86,
> > > that is mapping the kernel to the end of the address space, which allows
> > > the kernel to be linked at the same address for both sv39 and sv48 and
> > > then does not require to be relocated at runtime.
> > >
> > > This implements sv48 support at runtime. The kernel will try to
> > > boot with 4-level page table and will fallback to 3-level if the HW does not
> > > support it. Folding the 4th level into a 3-level page table has almost no
> > > cost at runtime.
> > >
> > > Note that kasan region had to be moved to the end of the address space
> > > since its location must be known at compile-time and then be valid for
> > > both sv39 and sv48 (and sv57 that is coming).
> > >
> > > Tested on:
> > >   - qemu rv64 sv39: OK
> > >   - qemu rv64 sv48: OK
> > >   - qemu rv64 sv39 + kasan: OK
> > >   - qemu rv64 sv48 + kasan: OK
> > >   - qemu rv32: OK
> > >
> > > Changes in v3:
> > >   - Fix SZ_1T, thanks to Atish
> > >   - Fix warning create_pud_mapping, thanks to Atish
> > >   - Fix k210 nommu build, thanks to Atish
> > >   - Fix wrong rebase as noted by Samuel
> > >   - * Downgrade to sv39 is only possible if !KASAN (see commit changelog) *
> > >   - * Move KASAN next to the kernel: virtual layouts changed and kasan population *
> > >
> > > Changes in v2:
> > >   - Rebase onto for-next
> > >   - Fix KASAN
> > >   - Fix stack canary
> > >   - Get completely rid of MAXPHYSMEM configs
> > >   - Add documentation
> > >
> > > Alexandre Ghiti (13):
> > >   riscv: Move KASAN mapping next to the kernel mapping
> > >   riscv: Split early kasan mapping to prepare sv48 introduction
> > >   riscv: Introduce functions to switch pt_ops
> > >   riscv: Allow to dynamically define VA_BITS
> > >   riscv: Get rid of MAXPHYSMEM configs
> > >   asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
> > >   riscv: Implement sv48 support
> > >   riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
> > >   riscv: Explicit comment about user virtual address space size
> > >   riscv: Improve virtual kernel memory layout dump
> > >   Documentation: riscv: Add sv48 description to VM layout
> > >   riscv: Initialize thread pointer before calling C functions
> > >   riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
> > >
> > >  Documentation/riscv/vm-layout.rst             |  48 ++-
> > >  arch/riscv/Kconfig                            |  37 +-
> > >  arch/riscv/configs/nommu_k210_defconfig       |   1 -
> > >  .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
> > >  arch/riscv/configs/nommu_virt_defconfig       |   1 -
> > >  arch/riscv/include/asm/csr.h                  |   3 +-
> > >  arch/riscv/include/asm/fixmap.h               |   1
> > >  arch/riscv/include/asm/kasan.h                |  11 +-
> > >  arch/riscv/include/asm/page.h                 |  20 +-
> > >  arch/riscv/include/asm/pgalloc.h              |  40 ++
> > >  arch/riscv/include/asm/pgtable-64.h           | 108 ++++-
> > >  arch/riscv/include/asm/pgtable.h              |  47 +-
> > >  arch/riscv/include/asm/sparsemem.h            |   6 +-
> > >  arch/riscv/kernel/cpu.c                       |  23 +-
> > >  arch/riscv/kernel/head.S                      |   4 +-
> > >  arch/riscv/mm/context.c                       |   4 +-
> > >  arch/riscv/mm/init.c                          | 408 ++++++++++++++----
> > >  arch/riscv/mm/kasan_init.c                    | 250 ++++++++---
> > >  drivers/firmware/efi/libstub/efi-stub.c       |   2
> > >  drivers/pci/controller/pci-xgene.c            |   2 +-
> > >  include/asm-generic/pgalloc.h                 |  24 +-
> > >  include/linux/sizes.h                         |   1
> > >  22 files changed, 833 insertions(+), 209 deletions(-)
> >
> > Sorry this took a while.  This is on for-next, with a bit of juggling: a
> > handful of trivial fixes for configs that were failing to build/boot and
> > some merge issues.  I also pulled out that MAXPHYSMEM fix to the top, so
> > it'd be easier to backport.  This is bigger than something I'd normally like to
> > take late in the cycle, but given there's a lot of cleanups, likely some fixes,
> > and it looks like folks have been testing this I'm just going to go with it.
> >
>
> Yes yes yes! That's fantastic news :)
>
> > Let me know if there's any issues with the merge, it was a bit hairy.
> > Probably best to just send along a fixup patch at this point.
>
> I'm going to take a look at that now, and I'll fix anything that comes
> up quickly :)

I see in for-next that you did not take the following patches:

  riscv: Improve virtual kernel memory layout dump
  Documentation: riscv: Add sv48 description to VM layout
  riscv: Initialize thread pointer before calling C functions
  riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN

I'm not sure this was your intention. If it was, I believe that at
least the first 2 patches are needed in this series, the 3rd one is a
useful fix and we can discuss the 4th if that's an issue for you.

I tested for-next on both sv39 and sv48 successfully, I took a glance
at the code and noticed you fixed the PTRS_PER_PGD error, thanks for
that. Otherwise nothing obvious has popped.

Thanks again,

Alex

>
> Thanks!
>
> Alex
>
> >
> > Thanks!
