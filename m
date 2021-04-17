Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA8E36315F
	for <lists+linux-arch@lfdr.de>; Sat, 17 Apr 2021 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhDQRYH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Apr 2021 13:24:07 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41019 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhDQRYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Apr 2021 13:24:07 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C6153E0003;
        Sat, 17 Apr 2021 17:23:33 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] riscv: Move kernel mapping outside of linear
 mapping
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <20210409061500.14673-1-alex@ghiti.fr>
 <20210409061500.14673-2-alex@ghiti.fr> <20210416185139.GA42339@roeck-us.net>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <8c23ed42-d8c7-70be-71d8-0eb74ace8e67@ghiti.fr>
Date:   Sat, 17 Apr 2021 13:23:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416185139.GA42339@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guenter,

Le 4/16/21 à 2:51 PM, Guenter Roeck a écrit :
> On Fri, Apr 09, 2021 at 02:14:58AM -0400, Alexandre Ghiti wrote:
>> This is a preparatory patch for relocatable kernel and sv48 support.
>>
>> The kernel used to be linked at PAGE_OFFSET address therefore we could use
>> the linear mapping for the kernel mapping. But the relocated kernel base
>> address will be different from PAGE_OFFSET and since in the linear mapping,
>> two different virtual addresses cannot point to the same physical address,
>> the kernel mapping needs to lie outside the linear mapping so that we don't
>> have to copy it at the same physical offset.
>>
>> The kernel mapping is moved to the last 2GB of the address space, BPF
>> is now always after the kernel and modules use the 2GB memory range right
>> before the kernel, so BPF and modules regions do not overlap. KASLR
>> implementation will simply have to move the kernel in the last 2GB range
>> and just take care of leaving enough space for BPF.
>>
>> In addition, by moving the kernel to the end of the address space, both
>> sv39 and sv48 kernels will be exactly the same without needing to be
>> relocated at runtime.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> 
> In next-20210416, when booting a riscv32 image in qemu, this patch results in:
> 
> [    0.000000] Linux version 5.12.0-rc7-next-20210416 (groeck@desktop) (riscv32-linux-gcc (GCC) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP Fri Apr 16 10:38:09 PDT 2021
> [    0.000000] OF: fdt: Ignoring memory block 0x80000000 - 0xa0000000
> [    0.000000] Machine model: riscv-virtio,qemu
> [    0.000000] earlycon: uart8250 at MMIO 0x10000000 (options '115200')
> [    0.000000] printk: bootconsole [uart8250] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] Kernel panic - not syncing: init_resources: Failed to allocate 160 bytes
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.12.0-rc7-next-20210416 #1
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] Call Trace:
> [    0.000000] [<80005292>] walk_stackframe+0x0/0xce
> [    0.000000] [<809f4db8>] dump_backtrace+0x38/0x46
> [    0.000000] [<809f4dd4>] show_stack+0xe/0x16
> [    0.000000] [<809ff1d0>] dump_stack+0x92/0xc6
> [    0.000000] [<809f4fee>] panic+0x10a/0x2d8
> [    0.000000] [<80c02b24>] setup_arch+0x2a0/0x4ea
> [    0.000000] [<80c006b0>] start_kernel+0x90/0x628
> [    0.000000] ---[ end Kernel panic - not syncing: init_resources: Failed to allocate 160 bytes ]---
> 
> Reverting it fixes the problem. I understand that the version in -next is
> different to this version of the patch, but I also tried v4 and it still
> crashes with the same error message.
> 

I completely neglected 32b kernel in this series, I fixed that here:

Thank you for testing and reporting,

Alex

> Guenter
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
