Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A482F4877
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 11:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhAMKRZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 05:17:25 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:35677 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbhAMKRZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 05:17:25 -0500
Date:   Wed, 13 Jan 2021 10:16:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1610533002; bh=sagEb4FSciHpuF7KnzebH5pdU2XwaUc8mW9H7JIBct0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=EOEo6r1PznGwaYYnKKtdkqlbesj8l4RIr0S/RiZTV3I+mraabFQHiotI0xL2vhVBt
         hmDpg1ZNLu3aErLdgfYXS1Ri3LyuGVpsb5oLErdzLq4oyxdUfvVRgDUW0N03vgkjz6
         d6SqCvQRjnihmhDN6HAFAZDm4y4fZfk8cL/JrrQKBOCP0m4A+bBAdcR0bX7pfET5Mq
         pUbx1sG07z62IXPnaJGodXCAICEqF124qQ2YwGxtcClefOFs36HEhRyJhSsakpYngb
         iu8Kff07VfNLlWqq2AuGtkqyTcty82QHq6DFoWEhk5jL1plylCCPiSaw1Gd/ChCm4t
         yvjemgqdVDldw==
To:     Nick Desaulniers <ndesaulniers@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [BUG mips llvm] MIPS: malformed R_MIPS_{HI16,LO16} with LLVM
Message-ID: <20210113101623.3020-1-alobakin@pm.me>
In-Reply-To: <CAKwvOdnvd1NaBQEJ0fPsYiGff4=tUdrcuAR0no9FUMqnOZSu6Q@mail.gmail.com>
References: <20210109171058.497636-1-alobakin@pm.me> <CAKwvOdmV2tj4Uyz1iDkqCj+snWPpnnAmxJyN+puL33EpMRPzUw@mail.gmail.com> <20210109191457.786517-1-alobakin@pm.me> <CAKwvOdnOXXaz+S1agu5kCQLm+qEkXE2Hpd2_V8yPsbUTQH7JZw@mail.gmail.com> <20210111204936.17905-1-alobakin@pm.me> <CAKwvOdnvd1NaBQEJ0fPsYiGff4=tUdrcuAR0no9FUMqnOZSu6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,MONEY_NOHTML
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 12 Jan 2021 14:14:58 -0800

> On Mon, Jan 11, 2021 at 12:50 PM Alexander Lobakin <alobakin@pm.me> wrote=
:
>>
>>> The disassembly for me produces:
>>>     399c: 3c 03 00 00   lui     $3, 0 <phy_device_free>
>>>                         0000399c:  R_MIPS_HI16  .text
>>> ...
>>>     39a8: 24 63 3a 5c   addiu   $3, $3, 14940 <phy_probe>
>>>                         000039a8:  R_MIPS_LO16  .text
>>
>> So, in your case the values of the instructions that relocs refer are:
>>
>> 0x3c030000 R_MIPS_HI16
>> 0x24633a5c R_MIPS_LO16
>>
>> Mine were:
>>
>> 0x3c010000
>> 0x24339444
>>
>> Your second one doesn't have bit 15 set, so I think this pair won't
>> break the code.
>> Try to hunt for R_MIPS_LO16 that have this bit set, i.e. they have
>> '8', '9', 'a', 'b', 'c', 'd' or 'e' as their [15:12].
>
> I don't think any of my R_MIPS_LO16 in that file have that bit set.
> See attached.

Well, seems like you got lucky here.
You can try to check for other modules if any of them have
R_MIPS_LO16 with bit 15 set.

Also, you can try to enable:
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy
CONFIG_TRIM_UNUSED_KSYMS=3Dy

to alter the build process. These options didn't change anything
in terms of relocs for me though.

> --
> Thanks,
> ~Nick Desaulniers

Thanks,
Al

