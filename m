Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1BC323B9C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhBXLyH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 06:54:07 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:64323 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhBXLxu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 06:53:50 -0500
Date:   Wed, 24 Feb 2021 11:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1614167582; bh=rmj4Lly7e2yo/vYcUEKGFZzDAc6rnvVPqHCHhRIbwaY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=PHXSzMSxRmaLS7MFt4ays/6/dt4JDFe5JXd4QbAhZJD6fATGc+zxzepIz+xytiIiY
         7fbgrezmNQVEUiH3H+5zFFsddUnnkbvoHRxiz73XXXcXb0ntv7dtlonrzeA7j8ro7P
         NvllO0TctJngE0dpAOynsPLIvyZr1QeLx1zOZbEd6l+Y2aY3FaTcJAKkA0FzuO2iHp
         rdubg4dtxfLOUKpAVyjsQvKCIGcwGSlQS/CwMz+99nwW7j5jADkmM/AHhMYifIPjCf
         CNSs2nfPmijLAAFSg9AW1X+D4djCWNncusfMIusXRcIG4OT8pSC3eJ0dKjv2iC+XBM
         quf+AFX18tPPw==
To:     Yury Norov <yury.norov@gmail.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH] arm64: enable  GENERIC_FIND_FIRST_BIT
Message-ID: <20210224115247.1618-1-alobakin@pm.me>
In-Reply-To: <20201205165406.108990-1-yury.norov@gmail.com>
References: <20201205165406.108990-1-yury.norov@gmail.com>
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

From: Yury Norov <yury.norov@gmail.com>
Date: Sat, 5 Dec 2020 08:54:06 -0800

Hi,

> ARM64 doesn't implement find_first_{zero}_bit in arch code and doesn't
> enable it in config. It leads to using find_next_bit() which is less
> efficient:
>
> 0000000000000000 <find_first_bit>:
>    0:=09aa0003e4 =09mov=09x4, x0
>    4:=09aa0103e0 =09mov=09x0, x1
>    8:=09b4000181 =09cbz=09x1, 38 <find_first_bit+0x38>
>    c:=09f9400083 =09ldr=09x3, [x4]
>   10:=09d2800802 =09mov=09x2, #0x40                  =09// #64
>   14:=0991002084 =09add=09x4, x4, #0x8
>   18:=09b40000c3 =09cbz=09x3, 30 <find_first_bit+0x30>
>   1c:=0914000008 =09b=093c <find_first_bit+0x3c>
>   20:=09f8408483 =09ldr=09x3, [x4], #8
>   24:=0991010045 =09add=09x5, x2, #0x40
>   28:=09b50000c3 =09cbnz=09x3, 40 <find_first_bit+0x40>
>   2c:=09aa0503e2 =09mov=09x2, x5
>   30:=09eb02001f =09cmp=09x0, x2
>   34:=0954ffff68 =09b.hi=0920 <find_first_bit+0x20>  // b.pmore
>   38:=09d65f03c0 =09ret
>   3c:=09d2800002 =09mov=09x2, #0x0                   =09// #0
>   40:=09dac00063 =09rbit=09x3, x3
>   44:=09dac01063 =09clz=09x3, x3
>   48:=098b020062 =09add=09x2, x3, x2
>   4c:=09eb02001f =09cmp=09x0, x2
>   50:=099a829000 =09csel=09x0, x0, x2, ls  // ls =3D plast
>   54:=09d65f03c0 =09ret
>
>   ...
>
> 0000000000000118 <_find_next_bit.constprop.1>:
>  118:=09eb02007f =09cmp=09x3, x2
>  11c:=09540002e2 =09b.cs=09178 <_find_next_bit.constprop.1+0x60>  // b.hs=
, b.nlast
>  120:=09d346fc66 =09lsr=09x6, x3, #6
>  124:=09f8667805 =09ldr=09x5, [x0, x6, lsl #3]
>  128:=09b4000061 =09cbz=09x1, 134 <_find_next_bit.constprop.1+0x1c>
>  12c:=09f8667826 =09ldr=09x6, [x1, x6, lsl #3]
>  130:=098a0600a5 =09and=09x5, x5, x6
>  134:=09ca0400a6 =09eor=09x6, x5, x4
>  138:=0992800005 =09mov=09x5, #0xffffffffffffffff    =09// #-1
>  13c:=099ac320a5 =09lsl=09x5, x5, x3
>  140:=09927ae463 =09and=09x3, x3, #0xffffffffffffffc0
>  144:=09ea0600a5 =09ands=09x5, x5, x6
>  148:=0954000120 =09b.eq=0916c <_find_next_bit.constprop.1+0x54>  // b.no=
ne
>  14c:=091400000e =09b=09184 <_find_next_bit.constprop.1+0x6c>
>  150:=09d346fc66 =09lsr=09x6, x3, #6
>  154:=09f8667805 =09ldr=09x5, [x0, x6, lsl #3]
>  158:=09b4000061 =09cbz=09x1, 164 <_find_next_bit.constprop.1+0x4c>
>  15c:=09f8667826 =09ldr=09x6, [x1, x6, lsl #3]
>  160:=098a0600a5 =09and=09x5, x5, x6
>  164:=09eb05009f =09cmp=09x4, x5
>  168:=09540000c1 =09b.ne=09180 <_find_next_bit.constprop.1+0x68>  // b.an=
y
>  16c:=0991010063 =09add=09x3, x3, #0x40
>  170:=09eb03005f =09cmp=09x2, x3
>  174:=0954fffee8 =09b.hi=09150 <_find_next_bit.constprop.1+0x38>  // b.pm=
ore
>  178:=09aa0203e0 =09mov=09x0, x2
>  17c:=09d65f03c0 =09ret
>  180:=09ca050085 =09eor=09x5, x4, x5
>  184:=09dac000a5 =09rbit=09x5, x5
>  188:=09dac010a5 =09clz=09x5, x5
>  18c:=098b0300a3 =09add=09x3, x5, x3
>  190:=09eb03005f =09cmp=09x2, x3
>  194:=099a839042 =09csel=09x2, x2, x3, ls  // ls =3D plast
>  198:=09aa0203e0 =09mov=09x0, x2
>  19c:=09d65f03c0 =09ret
>
>  ...
>
> 0000000000000238 <find_next_bit>:
>  238:=09a9bf7bfd =09stp=09x29, x30, [sp, #-16]!
>  23c:=09aa0203e3 =09mov=09x3, x2
>  240:=09d2800004 =09mov=09x4, #0x0                   =09// #0
>  244:=09aa0103e2 =09mov=09x2, x1
>  248:=09910003fd =09mov=09x29, sp
>  24c:=09d2800001 =09mov=09x1, #0x0                   =09// #0
>  250:=0997ffffb2 =09bl=09118 <_find_next_bit.constprop.1>
>  254:=09a8c17bfd =09ldp=09x29, x30, [sp], #16
>  258:=09d65f03c0 =09ret
>
> Enabling this functions would also benefit for_each_{set,clear}_bit().
> Would it make sense to enable this config for all such architectures by
> default?

I confirm that GENERIC_FIND_FIRST_BIT also produces more optimized and
fast code on MIPS (32 R2) where there is also no architecture-specific
bitsearching routines.
So, if it's okay for other folks, I'd suggest to go for it and enable
for all similar arches.

(otherwise, I'll publish a separate entry for mips-next after 5.12-rc1
 release and mention you in "Suggested-by:")

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..2b90ef1f548e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -106,6 +106,7 @@ config ARM64
>  =09select GENERIC_CPU_AUTOPROBE
>  =09select GENERIC_CPU_VULNERABILITIES
>  =09select GENERIC_EARLY_IOREMAP
> +=09select GENERIC_FIND_FIRST_BIT
>  =09select GENERIC_IDLE_POLL_SETUP
>  =09select GENERIC_IRQ_IPI
>  =09select GENERIC_IRQ_MULTI_HANDLER
> --
> 2.25.1

Thanks,
Al

