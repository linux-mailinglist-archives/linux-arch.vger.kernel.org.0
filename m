Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAB53C8D4
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 12:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbiFCKhP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbiFCKhP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 06:37:15 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C0EDF26;
        Fri,  3 Jun 2022 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1654252628; bh=mKfMzdoRncVvxs4/8Auvz1NfRkjCux+UfdwXemx3UkI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oJOqt8+nrUPl4Y87BixC1O6AeT/9iA7k7O8eStChkLTQ8dgSilBYgxoJY+R0ReUJZ
         M8K2A5GTQmdDP35GAF98jRsnyrlG+7D6nUjVQrduR8DI0j/qF7bs/GN5AXZNqlf7Nq
         K0Pg0ytMOGgQdK1XuOhDcGS/42ALBJhwRU4sUw3Y=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7C72160104;
        Fri,  3 Jun 2022 18:37:07 +0800 (CST)
Message-ID: <fcdbe7bd-bb4a-fc50-a96d-c2dd1456bc9b@xen0n.name>
Date:   Fri, 3 Jun 2022 18:37:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101
 Thunderbird/103.0a1
Subject: Re: [PATCH V15 11/24] LoongArch: Add boot and setup routines
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>
References: <20220603072053.35005-1-chenhuacai@loongson.cn>
 <20220603072053.35005-12-chenhuacai@loongson.cn>
 <4213df91-c762-ae56-f08d-8c925759fa63@xen0n.name>
 <CAK8P3a2mW7KmgxqWsaf76Q4V++B+0e6bH=tb4w4cA0XkZYuSLA@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAK8P3a2mW7KmgxqWsaf76Q4V++B+0e6bH=tb4w4cA0XkZYuSLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/3/22 18:02, Arnd Bergmann wrote:
> On Fri, Jun 3, 2022 at 11:27 AM WANG Xuerui <kernel@xen0n.name> wrote:
>> On 6/3/22 15:20, Huacai Chen wrote:
>>> Add basic boot, setup and reset routines for LoongArch. Now, LoongArch
>>> machines use UEFI-based firmware. The firmware passes configuration
>>> information to the kernel via ACPI and DMI/SMBIOS.
>>>
>>> Currently an existing interface between the kernel and the bootloader
>>> is implemented. Kernel gets 2 values from the bootloader, passed in
>>> registers a0 and a1; a0 is an "EFI boot flag" distinguishing UEFI and
>>> non-UEFI firmware, while a1 is a pointer to an FDT with systable,
>>> memmap, cmdline and initrd information.
>>>
>>> The standard UEFI boot protocol (EFISTUB) will be added later.
>>>
>>> Cc: linux-efi@vger.kernel.org
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Reviewed-by: WANG Xuerui <git@xen0n.name>
>>> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Co-developed-by: Yun Liu <liuyun@loongson.cn>
>>> Signed-off-by: Yun Liu <liuyun@loongson.cn>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> Would you please look at this patch, which has all the arch-independent
>> changes backed out, and Ack if it is fit for mainlining?
>>
>> I communicated a little with Huacai about the approach for supporting
>> alternative boot protocols down the road, and we agreed to carry the
>> respective changes downstream. And if needs truly arise for modifying
>> common EFI logic, we can do so in a non-rushed manner later.
>>
>> For the current status of the code, apparently it just accepts the
>> standard efistub-shape FDT pointer from (whatever booting the image),
>> and everything onwards are fully using the common code without
>> modification as you can see from the diffstat. I rebased my BPI support
>> patch on top of this (basically translating Loongson BPI data structures
>> into the expected FDT form), and can confirm the boot can progress to
>> the same point as before -- indeed the SVAM changes etc. are not
>> necessary for a working system, and the code remains working.
> I'm a bit lost here: Does this mean the v15 version is back to the old
> pre-efistub interface and allows booting with existing firmware, or
> is it now left out completely? I still see a kernel_entry() function
> in head.S, and I see references to loongson_sysconf, but I don't
> see if that is what gets passed in from the bootloader.
It's not the same interface as in some of the very early revisions; the 
earlier versions relied on "struct bootparamsinterface" or BPI, while 
it's the same FDT-based interface to initialize EFI from, as in 
arch/arm64 and arch/riscv I believe. No Loongson-specific things remain now.
>
> I really want to make sure that without the EFI stub, there is no
> other way to boot the kernel that would have to get maintained
> in the long run.
Yeah this is the case right now. No LoongArch bootloader that I know of 
can prepare the EFI stub-shaped FDT that the current code expects, and I 
don't know of any future Loongson plan to do that either (Loongson's 
previous in-house efforts all looked something different). So it's 
pretty safe to say the current code wouldn't get frozen once mainlined.
>
>          Arnd
