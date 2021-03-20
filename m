Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A80D342CEE
	for <lists+linux-arch@lfdr.de>; Sat, 20 Mar 2021 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCTNAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Mar 2021 09:00:51 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:50809 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhCTNAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Mar 2021 09:00:39 -0400
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D5C353B566D;
        Sat, 20 Mar 2021 08:49:40 +0000 (UTC)
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 39AEC40003;
        Sat, 20 Mar 2021 08:48:14 +0000 (UTC)
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
Message-ID: <fdc52c40-3324-fc9a-ffda-926ced856a80@ghiti.fr>
Date:   Sat, 20 Mar 2021 04:48:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <mhng-cf5d29ec-e941-4579-8c42-2c11799a8f2f@penguin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

I have just tried to rebase this on for-next, and that quite conflicts 
with Vitaly's XIP patch, I'm fixing this and post a v3.

Alex
