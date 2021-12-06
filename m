Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D774694C2
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 12:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbhLFLL4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 06:11:56 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51225 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhLFLLz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 06:11:55 -0500
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ECAD0E0018;
        Mon,  6 Dec 2021 11:08:19 +0000 (UTC)
Message-ID: <ae3be66c-755a-b068-e224-08cd733c53e1@ghiti.fr>
Date:   Mon, 6 Dec 2021 12:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 00/13] Introduce sv48 support without relocatable
 kernel
Content-Language: en-US
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
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
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

And I messed Atish address, I was pretty sure I could recall it without 
checking, I guess I'm wrong :)

Sorry for the noise,

Alex

On 12/6/21 11:46, Alexandre Ghiti wrote:
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
>    - qemu rv64 sv39: OK
>    - qemu rv64 sv48: OK
>    - qemu rv64 sv39 + kasan: OK
>    - qemu rv64 sv48 + kasan: OK
>    - qemu rv32: OK
>
> Changes in v3:
>    - Fix SZ_1T, thanks to Atish
>    - Fix warning create_pud_mapping, thanks to Atish
>    - Fix k210 nommu build, thanks to Atish
>    - Fix wrong rebase as noted by Samuel
>    - * Downgrade to sv39 is only possible if !KASAN (see commit changelog) *
>    - * Move KASAN next to the kernel: virtual layouts changed and kasan population *
>
> Changes in v2:
>    - Rebase onto for-next
>    - Fix KASAN
>    - Fix stack canary
>    - Get completely rid of MAXPHYSMEM configs
>    - Add documentation
>
> Alexandre Ghiti (13):
>    riscv: Move KASAN mapping next to the kernel mapping
>    riscv: Split early kasan mapping to prepare sv48 introduction
>    riscv: Introduce functions to switch pt_ops
>    riscv: Allow to dynamically define VA_BITS
>    riscv: Get rid of MAXPHYSMEM configs
>    asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
>    riscv: Implement sv48 support
>    riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
>    riscv: Explicit comment about user virtual address space size
>    riscv: Improve virtual kernel memory layout dump
>    Documentation: riscv: Add sv48 description to VM layout
>    riscv: Initialize thread pointer before calling C functions
>    riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
>
>   Documentation/riscv/vm-layout.rst             |  48 ++-
>   arch/riscv/Kconfig                            |  37 +-
>   arch/riscv/configs/nommu_k210_defconfig       |   1 -
>   .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
>   arch/riscv/configs/nommu_virt_defconfig       |   1 -
>   arch/riscv/include/asm/csr.h                  |   3 +-
>   arch/riscv/include/asm/fixmap.h               |   1
>   arch/riscv/include/asm/kasan.h                |  11 +-
>   arch/riscv/include/asm/page.h                 |  20 +-
>   arch/riscv/include/asm/pgalloc.h              |  40 ++
>   arch/riscv/include/asm/pgtable-64.h           | 108 ++++-
>   arch/riscv/include/asm/pgtable.h              |  47 +-
>   arch/riscv/include/asm/sparsemem.h            |   6 +-
>   arch/riscv/kernel/cpu.c                       |  23 +-
>   arch/riscv/kernel/head.S                      |   4 +-
>   arch/riscv/mm/context.c                       |   4 +-
>   arch/riscv/mm/init.c                          | 408 ++++++++++++++----
>   arch/riscv/mm/kasan_init.c                    | 250 ++++++++---
>   drivers/firmware/efi/libstub/efi-stub.c       |   2
>   drivers/pci/controller/pci-xgene.c            |   2 +-
>   include/asm-generic/pgalloc.h                 |  24 +-
>   include/linux/sizes.h                         |   1
>   22 files changed, 833 insertions(+), 209 deletions(-)
>
> --
> 2.32.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
