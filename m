Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116B32F031F
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbhAITQY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 14:16:24 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:16226 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbhAITQX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 14:16:23 -0500
Date:   Sat, 09 Jan 2021 19:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1610219739; bh=HTNhGxaumyEfFhC9Rh9YxptEn03qWU8vZ3Aojfr4I3Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=efJi1H69hfjRY1dichxq85cJ30sh0bLohwHaOzEbHMfKM/BofFpXOlVhw4wGix8sQ
         Ydq5ZKEnP0O4JjkQ/IRkxH/Cwkr0+x4tmH8qzJkeeBVGdtYLifRvg7zzAuXPJF5PQ6
         U8rqimZEaDPUSBIUNW2x5NSFk+W63WkYxFq6fTddAnwEBX8atDxWt32/h7v6P77a+y
         rp+B8i8AuTrcKx4/67h082VgculI/UbrLmeEeMNRDr9cbVer/6LacAmBePatLKpqAr
         1hoA1r0tpMIMJ4rH/OpQ6HQFH7hGTrlEx79c2GFKWNUI9AmXKgMjfAm97/HUUfGbxN
         o77cf55f6nF8g==
To:     Nick Desaulniers <ndesaulniers@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [BUG mips llvm] MIPS: malformed R_MIPS_{HI16,LO16} with LLVM
Message-ID: <20210109191457.786517-1-alobakin@pm.me>
In-Reply-To: <CAKwvOdmV2tj4Uyz1iDkqCj+snWPpnnAmxJyN+puL33EpMRPzUw@mail.gmail.com>
References: <20210109171058.497636-1-alobakin@pm.me> <CAKwvOdmV2tj4Uyz1iDkqCj+snWPpnnAmxJyN+puL33EpMRPzUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Sat, 9 Jan 2021 09:50:44 -0800

> On Sat, Jan 9, 2021 at 9:11 AM Alexander Lobakin <alobakin@pm.me> wrote:
>>
>> Machine: MIPS32 R2 Big Endian (interAptiv (multi))
>>
>> While testing MIPS with LLVM, I found a weird and very rare bug with
>> MIPS relocs that LLVM emits into kernel modules. It happens on both
>> 11.0.0 and latest git snapshot and applies, as I can see, only to
>> references to static symbols.
>>
>> When the kernel loads the module, it allocates a space for every
>> section and then manually apply the relocations relative to the
>> new address.
>>
>> Let's say we have a function phy_probe() in drivers/net/phy/libphy.ko.
>> It's static and referenced only in phy_register_driver(), where it's
>> used to fill callback pointer in a structure.
>>
>> The real function address after module loading is 0xc06c1444, that
>> is observed in its ELF st_value field.
>> There are two relocs related to this usage in phy_register_driver():
>>
>> R_MIPS_HI16 refers to 0x3c010000
>> R_MIPS_LO16 refers to 0x24339444
>>
>> The address of .text is 0xc06b8000. So the destination is calculated
>> as follows:
>>
>> 0x00000000 from hi16;
>> 0xffff9444 from lo16 (sign extend as it's always treated as signed);
>> 0xc06b8000 from base.
>>
>> =3D 0xc06b1444. The value is lower than the real phy_probe() address
>> (0xc06c1444) by 0x10000 and is lower than the base address of
>> module's .text, so it's 100% incorrect.
>>
>> This results in:
>>
>> [    2.204022] CPU 3 Unable to handle kernel paging request at virtual
>> address c06b1444, epc =3D=3D c06b1444, ra =3D=3D 803f1090
>>
>> The correct instructions should be:
>>
>> R_MIPS_HI16 0x3c010001
>> R_MIPS_LO16 0x24339444
>>
>> so there'll be 0x00010000 from hi16.
>>
>> I tried to catch those bugs in arch/mips/kernel/module.c (by checking
>> if the destination is lower than the base address, which should never
>> happen), and seems like I have only 3 such places in libphy.ko (and
>> one in nf_tables.ko).
>> I don't think it should be handled somehow in mentioned source code
>> as it would look rather ugly and may break kernels build with GNU
>> stack, which seems to not produce such bad codes.
>>
>> If I should report this to any other resources, please let me know.
>> I chose clang-built-linux and LKML as it may not happen with userland
>> (didn't tried to catch).
>
> Thanks for the report.  Sounds like we may indeed be producing an
> incorrect relocation.  This is only seen for big endian triples?

Unfortunately I don't have a LE board to play with, so can confirm
only Big Endian.

(BTW, if someone can say if it's possible for MIPS (and how if it is)
to launch a LE kernel from BE-booted preloader and U-Boot, that would
be super cool)

> Getting a way for us to deterministically reproduce would be a good
> first step.  Which config or configs beyond defconfig, and which
> relocations specifically are you observing this with?

I use `make 32r2_defconfig` which combines several configs from
arch/mips/configs:
 - generic_defconfig;
 - generic/32r2.config;
 - generic/eb.config.

Aside from that, I enable a bunch of my WIP drivers and the
Netfilter. On my setup, this bug is always present in libphy.ko,
so CONFIG_PHYLIB=3Dm (with all deps) should be enough.

The three failed relocs belongs to this part of code: [0]

llvm-readelf on them:

Relocation section '.rel.text' at offset 0xbf60 contains 2281 entries:=
=C2=AC
[...]
00005740  00029305 R_MIPS_HI16            00000000   .text
00005744  00029306 R_MIPS_LO16            00000000   .text
00005720  00029305 R_MIPS_HI16            00000000   .text
00005748  00029306 R_MIPS_LO16            00000000   .text
0000573c  00029305 R_MIPS_HI16            00000000   .text
0000574c  00029306 R_MIPS_LO16            00000000   .text

The first pair is the one from my first mail:
0x3c010000 <-- should be 0x3c010001 to work properly
0x24339444

I'm planning to hunt for more now, will let you know.

[0] https://elixir.bootlin.com/linux/v5.11-rc2/source/drivers/net/phy/phy_d=
evice.c#L2989

> Thanks,
> ~Nick Desaulniers

Thanks,
Al

