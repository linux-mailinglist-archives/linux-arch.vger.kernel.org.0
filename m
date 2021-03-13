Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B5339D40
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 10:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhCMJ1T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 04:27:19 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45627 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhCMJ0v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Mar 2021 04:26:51 -0500
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8C6861C0008;
        Sat, 13 Mar 2021 09:26:47 +0000 (UTC)
Subject: Re: [PATCH 0/3] Move kernel mapping outside the linear mapping
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <mhng-cf5d29ec-e941-4579-8c42-2c11799a8f2f@penguin>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <0bb85388-c4e1-523a-9bf3-0ccec6c4041e@ghiti.fr>
Date:   Sat, 13 Mar 2021 04:26:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <mhng-cf5d29ec-e941-4579-8c42-2c11799a8f2f@penguin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer,

Le 3/9/21 à 9:54 PM, Palmer Dabbelt a écrit :
> On Thu, 25 Feb 2021 00:04:50 PST (-0800), alex@ghiti.fr wrote:
>> I decided to split sv48 support in small series to ease the review.
>>
>> This patchset pushes the kernel mapping (modules and BPF too) to the last
>> 4GB of the 64bit address space, this allows to:
>> - implement relocatable kernel (that will come later in another
>>   patchset) that requires to move the kernel mapping out of the linear
>>   mapping to avoid to copy the kernel at a different physical address.
>> - have a single kernel that is not relocatable (and then that avoids the
>>   performance penalty imposed by PIC kernel) for both sv39 and sv48.
>>
>> The first patch implements this behaviour, the second patch introduces a
>> documentation that describes the virtual address space layout of the 
>> 64bit
>> kernel and the last patch is taken from my sv48 series where I simply 
>> added
>> the dump of the modules/kernel/BPF mapping.
>>
>> I removed the Reviewed-by on the first patch since it changed enough from
>> last time and deserves a second look.
>>
>> Alexandre Ghiti (3):
>>   riscv: Move kernel mapping outside of linear mapping
>>   Documentation: riscv: Add documentation that describes the VM layout
>>   riscv: Prepare ptdump for vm layout dynamic addresses
>>
>>  Documentation/riscv/index.rst       |  1 +
>>  Documentation/riscv/vm-layout.rst   | 61 ++++++++++++++++++++++
>>  arch/riscv/boot/loader.lds.S        |  3 +-
>>  arch/riscv/include/asm/page.h       | 18 ++++++-
>>  arch/riscv/include/asm/pgtable.h    | 37 +++++++++----
>>  arch/riscv/include/asm/set_memory.h |  1 +
>>  arch/riscv/kernel/head.S            |  3 +-
>>  arch/riscv/kernel/module.c          |  6 +--
>>  arch/riscv/kernel/setup.c           |  3 ++
>>  arch/riscv/kernel/vmlinux.lds.S     |  3 +-
>>  arch/riscv/mm/fault.c               | 13 +++++
>>  arch/riscv/mm/init.c                | 81 +++++++++++++++++++++++------
>>  arch/riscv/mm/kasan_init.c          |  9 ++++
>>  arch/riscv/mm/physaddr.c            |  2 +-
>>  arch/riscv/mm/ptdump.c              | 67 +++++++++++++++++++-----
>>  15 files changed, 258 insertions(+), 50 deletions(-)
>>  create mode 100644 Documentation/riscv/vm-layout.rst
> 
> This generally looks good, but I'm getting a bunch of checkpatch 
> warnings and some conflicts, do you mind fixing those up (and including 
> your other kasan patch, as that's likely to conflict)?


I fixed a few checkpatch warnings and rebased on top of for-next but had 
not conflicts.

I have just sent the v2.

Thanks,

Alex
