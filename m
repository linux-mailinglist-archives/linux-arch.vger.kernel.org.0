Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47B0527C17
	for <lists+linux-arch@lfdr.de>; Mon, 16 May 2022 04:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiEPCls (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 22:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbiEPClr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 22:41:47 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A42CDF1;
        Sun, 15 May 2022 19:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652668902; bh=7PghzBnaY7l+/iyB8x/83XEVoKFLqJ7Go7b3gh2Nsjc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OfAOjW+ygtQNAH0aRS6uBVxWWb0Xp8ylFCY/h1Lc/MvN3vZxBtj2lmpRTDOIrV47G
         wJowd+Hvixdd37B36UPU/I0WbdO6CiOt0APUerRuWoGcJ8KBpD4Z/arNS3K+pI/DDi
         6ZoXSWW+u0nFOn1k/Gju3Uv2NW78tYyrJCcamokY=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 26C44600B5;
        Mon, 16 May 2022 10:41:42 +0800 (CST)
Message-ID: <204b9bcf-07d3-1870-a7bb-ba8af7b27362@xen0n.name>
Date:   Mon, 16 May 2022 10:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V10 09/22] LoongArch: Add boot and setup routines
Content-Language: en-US
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-10-chenhuacai@loongson.cn>
 <e7616076-d8b1-defc-5762-b8ee91cb89fc@xen0n.name>
 <CAAhV-H6yUKgew018Dj=9AyxYu0ofbBpG9vO3yjmyWSZ9S77BAA@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H6yUKgew018Dj=9AyxYu0ofbBpG9vO3yjmyWSZ9S77BAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 5/15/22 20:38, Huacai Chen wrote:
>>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>>> new file mode 100644
>>> index 000000000000..f0b3e76bb762
>>> --- /dev/null
>>> +++ b/arch/loongarch/kernel/head.S
>>> @@ -0,0 +1,97 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
>>> + */
>>> +#include <linux/init.h>
>>> +#include <linux/threads.h>
>>> +
>>> +#include <asm/addrspace.h>
>>> +#include <asm/asm.h>
>>> +#include <asm/asmmacro.h>
>>> +#include <asm/regdef.h>
>>> +#include <asm/loongarch.h>
>>> +#include <asm/stackframe.h>
>>> +#include <generated/compile.h>
>>> +#include <generated/utsrelease.h>
>>> +
>>> +#ifdef CONFIG_EFI_STUB
>>> +
>>> +#include "efi-header.S"
>>> +
>>> +     __HEAD
>>> +
>>> +_head:
>>> +     .word   MZ_MAGIC                /* "MZ", MS-DOS header */
>>> +     .org    0x28
>>> +     .ascii  "Loongson\0"            /* Magic number for BootLoader */
>> If you must use a magic number, "Loongson" is not recommended, because
>> this string lacks uniqueness in the Loongson/LoongArch world. Too many
>> things are called "Loongson foo" right now, and the string is so
>> ordinary people don't immediately think of it as "magic".
>>
>> I recommended using some other interesting text (and encoding) for the
>> magic number, in a different communication venue, but I think that
>> proposal got ignored by you without any explanation whatsoever. For now
>> I'll just repeat myself:
>>
>> For an interesting magic number related to Loongson/LoongArch/Loong
>> (like dragons but not exactly the same, let's not expand on that front)
>> in general, it's perhaps better to use GB18030-encoded four-character
>> dragon-related idioms. It's GB18030 because one Chinese character is 2
>> bytes in this encoding, and being non-UTF-8 it's unlikely any user input
>> would accidentally resemble it. So we get 8 bytes that appear as huge
>> negative numbers if cast into C long, and random enough that collisions
>> are highly unlikely.
>>
>> For example, I chose 4 famous dragon-related phrases from the I Ching,
>> in both simplified and traditional characters:
>>
>> 潜龙勿用: 0xc7b1c1facef0d3c3
>> 见龙在田: 0xbcfbc1fad4daccef
>> 飞龙在天: 0xb7c9c1fad4daccec
>> 亢龙有悔: 0xbfbac1fad3d0bbda
>> 潛龍勿用: 0x9d93fd88cef0d3c3
>> 見龍在田: 0xd28afd88d4daccef
>> 飛龍在天: 0xef77fd88d4daccec
>> 亢龍有悔: 0xbfbafd88d3d0bbda
>>
>> and I think each of them is better than "Loongson".
> ARM64_IMAGE_MAGIC is "ARM64", RISCV_IMAGE_MAGIC is "RISCV", so I think
> we use "Loongson" as a magic is just OK.

Actually you made a good point here, that I failed to check for myself 
earlier.

Looking at the arm64 and riscv image header code more closely, it seems 
loongarch is trying to follow the now deprecated riscv-specific practice 
of using 8-byte magic (deprecated as of commit 474efecb65dce ("riscv: 
modify the Image header to improve compatibility with the ARM64 
header")). In doing this they also changed the offset of the magic: on 
riscv it's at 0x30, while here it's at 0x28 (riscv's "res2" field). This 
is just the exact kind of "proliferation of image header formats" that 
we would want to avoid.

Now for some additional but important bikeshedding...

The current arm64 and riscv magic numbers are all 4-byte long, at offset 
0x38, and they are cute little strings identifying their origin: 
"ARM\x64" and "RSC\x05" respectively. Thus, for loongarch, we probably 
want to do the same -- 4-byte nice little strings with a hint of 
LoongArch/Loong. Considering UTF-8 uses 3 bytes for most Chinese 
characters, and 4 bytes for characters outside of BMP, we could use a 
little bit of creativity here:

- "LA64", the "dullest" version with only ASCII characters, but I don't 
know if future LA32 systems will want to use the same image header format;
- "\xe9\xbe\x99\x64" ("龙\x64") or "\xe9\xbe\x8d\x64" ("龍\x64") -- 龙/龍 
means "loong/dragon", hence a variant of the above;
- "\xf0\x9f\x90\xb2" ("🐲") or "\xf0\x9f\x90\x89" ("🐉") -- the 
loong/dragon emoji, taking full advantage of the 4 bytes available while 
not mentioning bitness.

A case might be made for pure-ASCII magic numbers, that they're easier 
for naked-eye inspection, but (1) this is already not the case for the 
new riscv magic, and (2) given all other interesting fields are in 
binary it's already necessary to use hex editors for any task more 
complex than mere identification.

So, I think the bottom line is: don't use the 8-byte magic at offset 
0x28, switch to 4-byte magic at offset 0x38 to keep consistent with 
everyone else. I don't actually have a preference, but personally I'd 
prefer some freshness in the low-level land, if that doesn't hamper 
people's flows. ;-)

