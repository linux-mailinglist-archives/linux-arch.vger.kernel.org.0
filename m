Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0E469440
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 11:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbhLFKxf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 05:53:35 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42209 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbhLFKxe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 05:53:34 -0500
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B1A846000F;
        Mon,  6 Dec 2021 10:49:55 +0000 (UTC)
Message-ID: <3283761f-0506-464b-d351-af8ddecafa9b@ghiti.fr>
Date:   Mon, 6 Dec 2021 11:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 00/10] Introduce sv48 support without relocatable
 kernel
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
 <2700575.YIZvDWadBg@diego>
From:   Alexandre ghiti <alex@ghiti.fr>
In-Reply-To: <2700575.YIZvDWadBg@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/25/21 00:29, Heiko Stübner wrote:
> Am Mittwoch, 29. September 2021, 16:51:03 CET schrieb Alexandre Ghiti:
>> This patchset allows to have a single kernel for sv39 and sv48 without
>> being relocatable.
>>                                                                                   
>> The idea comes from Arnd Bergmann who suggested to do the same as x86,
>> that is mapping the kernel to the end of the address space, which allows
>> the kernel to be linked at the same address for both sv39 and sv48 and
>> then does not require to be relocated at runtime.
>>                                                                                   
>> This implements sv48 support at runtime. The kernel will try to
>> boot with 4-level page table and will fallback to 3-level if the HW does not
>> support it. Folding the 4th level into a 3-level page table has almost no
>> cost at runtime.
>>                                                                                   
>> Tested on:
>>    - qemu rv64 sv39: OK
>>    - qemu rv64 sv48: OK
>>    - qemu rv64 sv39 + kasan: OK
>>    - qemu rv64 sv48 + kasan: OK
>>    - qemu rv32: OK
>>    - Unmatched: OK
> On a beagleV (which supports only sv39) I've tested both the limit via
> the mmu-type in the devicetree and also that the fallback works when
> I disable the mmu-type in the dt, so
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>

Thanks Heiko for testing this, unfortunately I could not add this tag to 
the latest version as significant changes came up.

Thanks again for taking the time to test this,

Alex


>>    
>>                                                                                   
>> Changes in v2:
>>    - Rebase onto for-next
>>    - Fix KASAN
>>    - Fix stack canary
>>    - Get completely rid of MAXPHYSMEM configs
>>    - Add documentation
>>
>> Alexandre Ghiti (10):
>>    riscv: Allow to dynamically define VA_BITS
>>    riscv: Get rid of MAXPHYSMEM configs
>>    asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
>>    riscv: Implement sv48 support
>>    riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
>>    riscv: Explicit comment about user virtual address space size
>>    riscv: Improve virtual kernel memory layout dump
>>    Documentation: riscv: Add sv48 description to VM layout
>>    riscv: Initialize thread pointer before calling C functions
>>    riscv: Allow user to downgrade to sv39 when hw supports sv48
>>
>>   Documentation/riscv/vm-layout.rst             |  36 ++
>>   arch/riscv/Kconfig                            |  35 +-
>>   arch/riscv/configs/nommu_k210_defconfig       |   1 -
>>   .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
>>   arch/riscv/configs/nommu_virt_defconfig       |   1 -
>>   arch/riscv/include/asm/csr.h                  |   3 +-
>>   arch/riscv/include/asm/fixmap.h               |   1 +
>>   arch/riscv/include/asm/kasan.h                |   2 +-
>>   arch/riscv/include/asm/page.h                 |  10 +
>>   arch/riscv/include/asm/pgalloc.h              |  40 +++
>>   arch/riscv/include/asm/pgtable-64.h           | 108 +++++-
>>   arch/riscv/include/asm/pgtable.h              |  30 +-
>>   arch/riscv/include/asm/sparsemem.h            |   6 +-
>>   arch/riscv/kernel/cpu.c                       |  23 +-
>>   arch/riscv/kernel/head.S                      |   4 +-
>>   arch/riscv/mm/context.c                       |   4 +-
>>   arch/riscv/mm/init.c                          | 323 +++++++++++++++---
>>   arch/riscv/mm/kasan_init.c                    |  91 +++--
>>   drivers/firmware/efi/libstub/efi-stub.c       |   2 +
>>   include/asm-generic/pgalloc.h                 |  24 +-
>>   include/linux/sizes.h                         |   1 +
>>   21 files changed, 615 insertions(+), 131 deletions(-)
>>
>>
>
>
>
