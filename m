Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40E549465C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Jan 2022 05:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiATESM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jan 2022 23:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358435AbiATESM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2022 23:18:12 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E9C061574
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 20:18:11 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id f13so4199625plg.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 20:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iT9AIdLj55ev5yKtI8ieivVAM11HecgPIKI9gy4uM7k=;
        b=DjFVfnxNhRsSwTU9uitv8nBpFpyZoEPgLUZGOan4mUiDJt5pyEAxtehajlOQCbWuf+
         /Wjdh7DhgpSJaOBKQcAeHHxixW7eFCUvdDKg6lUNhXHDmqVHrM+vGbW1YNCk/pnL2Fb+
         /l4sOvXHcX9kI7Wg+EfiCvfAtA8uMqltpslD66ck7p8Tj+0tG0/m2Jm3lZq4SLynRqd9
         zGEBqh8D4eyb1NsEzrJm1GJm+NJ0PoLGMh2MRSomAS3e/GfM40ehvEFp0lqMAHB9Co7V
         HjCJ2aVf4gQRo6MRUM00cNV8hkz/QJ039gPSXx1OA41uYuRcqVgacGfEEJJaFfPWgjqK
         Ez4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iT9AIdLj55ev5yKtI8ieivVAM11HecgPIKI9gy4uM7k=;
        b=M8f0Cmi4U0TxG1mJdnDCFc3JmsTlG7OchfHJSEIsVFI3fuoAUjvz2AHcGot1GOkT8K
         bZ4EvcX0SIsyelYezpl1ekukG7AHhmC1YwTjXGs02twdaxLieuQn9KI0XrWQQznZ0WeT
         Sy10aBPrEMlEdJINt6PuG85XrFLWdsNTZBUfyr9uvYGLp3BYgg9yURgCSnP18xeBWPmO
         g1qR6KTF8fHbM5eHOQcCxaVxszeGFkBt4pUQgHpHrEOb4k73wNvr2zLRa3Td9S16BC/D
         wKnBrUO7dxGewl/Q+XBd6BSIYFZfIcbHpqDq6zyYTw0O522B9LALvl51hng5cO3RblkV
         t2BA==
X-Gm-Message-State: AOAM533O5WTvftduG90G3d1u+znhmkjcjc+kzUDpXzVsk5vNvneIm1UC
        MO1hxCgTTuXEjqQI196L0gl7iQ==
X-Google-Smtp-Source: ABdhPJwAFUf4SqZ74zUYUmkHi3E/lwX3x/hS+sVaKeSaIBNtbyJOTOIUjLud5tljRhqKM56Yf7lGNA==
X-Received: by 2002:a17:902:704c:b0:14a:fd51:3b5d with SMTP id h12-20020a170902704c00b0014afd513b5dmr3945207plt.172.1642652291221;
        Wed, 19 Jan 2022 20:18:11 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id t7sm1081924pfj.138.2022.01.19.20.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 20:18:10 -0800 (PST)
Date:   Wed, 19 Jan 2022 20:18:10 -0800 (PST)
X-Google-Original-Date: Wed, 19 Jan 2022 20:13:10 PST (-0800)
Subject:     Re: [PATCH v3 00/13] Introduce sv48 support without relocatable kernel
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
CC:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, zong.li@sifive.com, anup@brainfault.org,
        Atish.Patra@rivosinc.com, Christoph Hellwig <hch@lst.de>,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        keescook@chromium.org, guoren@linux.alibaba.com,
        heinrich.schuchardt@canonical.com, mchitale@ventanamicro.com,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, alexandre.ghiti@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-cdec292e-aea2-4b76-8853-b8465521e94f@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 06 Dec 2021 02:46:44 PST (-0800), alexandre.ghiti@canonical.com wrote:
> * Please note notable changes in memory layouts and kasan population *
>
> This patchset allows to have a single kernel for sv39 and sv48 without
> being relocatable.
>
> The idea comes from Arnd Bergmann who suggested to do the same as x86,
> that is mapping the kernel to the end of the address space, which allows
> the kernel to be linked at the same address for both sv39 and sv48 and
> then does not require to be relocated at runtime.
>
> This implements sv48 support at runtime. The kernel will try to
> boot with 4-level page table and will fallback to 3-level if the HW does not
> support it. Folding the 4th level into a 3-level page table has almost no
> cost at runtime.
>
> Note that kasan region had to be moved to the end of the address space
> since its location must be known at compile-time and then be valid for
> both sv39 and sv48 (and sv57 that is coming).
>
> Tested on:
>   - qemu rv64 sv39: OK
>   - qemu rv64 sv48: OK
>   - qemu rv64 sv39 + kasan: OK
>   - qemu rv64 sv48 + kasan: OK
>   - qemu rv32: OK
>
> Changes in v3:
>   - Fix SZ_1T, thanks to Atish
>   - Fix warning create_pud_mapping, thanks to Atish
>   - Fix k210 nommu build, thanks to Atish
>   - Fix wrong rebase as noted by Samuel
>   - * Downgrade to sv39 is only possible if !KASAN (see commit changelog) *
>   - * Move KASAN next to the kernel: virtual layouts changed and kasan population *
>
> Changes in v2:
>   - Rebase onto for-next
>   - Fix KASAN
>   - Fix stack canary
>   - Get completely rid of MAXPHYSMEM configs
>   - Add documentation
>
> Alexandre Ghiti (13):
>   riscv: Move KASAN mapping next to the kernel mapping
>   riscv: Split early kasan mapping to prepare sv48 introduction
>   riscv: Introduce functions to switch pt_ops
>   riscv: Allow to dynamically define VA_BITS
>   riscv: Get rid of MAXPHYSMEM configs
>   asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
>   riscv: Implement sv48 support
>   riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
>   riscv: Explicit comment about user virtual address space size
>   riscv: Improve virtual kernel memory layout dump
>   Documentation: riscv: Add sv48 description to VM layout
>   riscv: Initialize thread pointer before calling C functions
>   riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
>
>  Documentation/riscv/vm-layout.rst             |  48 ++-
>  arch/riscv/Kconfig                            |  37 +-
>  arch/riscv/configs/nommu_k210_defconfig       |   1 -
>  .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
>  arch/riscv/configs/nommu_virt_defconfig       |   1 -
>  arch/riscv/include/asm/csr.h                  |   3 +-
>  arch/riscv/include/asm/fixmap.h               |   1
>  arch/riscv/include/asm/kasan.h                |  11 +-
>  arch/riscv/include/asm/page.h                 |  20 +-
>  arch/riscv/include/asm/pgalloc.h              |  40 ++
>  arch/riscv/include/asm/pgtable-64.h           | 108 ++++-
>  arch/riscv/include/asm/pgtable.h              |  47 +-
>  arch/riscv/include/asm/sparsemem.h            |   6 +-
>  arch/riscv/kernel/cpu.c                       |  23 +-
>  arch/riscv/kernel/head.S                      |   4 +-
>  arch/riscv/mm/context.c                       |   4 +-
>  arch/riscv/mm/init.c                          | 408 ++++++++++++++----
>  arch/riscv/mm/kasan_init.c                    | 250 ++++++++---
>  drivers/firmware/efi/libstub/efi-stub.c       |   2
>  drivers/pci/controller/pci-xgene.c            |   2 +-
>  include/asm-generic/pgalloc.h                 |  24 +-
>  include/linux/sizes.h                         |   1
>  22 files changed, 833 insertions(+), 209 deletions(-)

Sorry this took a while.  This is on for-next, with a bit of juggling: a 
handful of trivial fixes for configs that were failing to build/boot and 
some merge issues.  I also pulled out that MAXPHYSMEM fix to the top, so 
it'd be easier to backport.  This is bigger than something I'd normally like to
take late in the cycle, but given there's a lot of cleanups, likely some fixes,
and it looks like folks have been testing this I'm just going to go with it.

Let me know if there's any issues with the merge, it was a bit hairy.  
Probably best to just send along a fixup patch at this point.

Thanks!
