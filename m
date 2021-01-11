Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DA2F2059
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jan 2021 21:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391346AbhAKUEW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jan 2021 15:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391041AbhAKUEV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jan 2021 15:04:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847AAC061786
        for <linux-arch@vger.kernel.org>; Mon, 11 Jan 2021 12:03:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t22so609443pfl.3
        for <linux-arch@vger.kernel.org>; Mon, 11 Jan 2021 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZrJB+VMtGpCDCw4tM56I2rie2eVd0wx7yFHoaKknnYg=;
        b=UAs6pdpvplb3evozh776RK+Y7oY1aYI/sHPY0xeva0O56+dVywtAJM/5eecmlvKLta
         tPbZQDW5ISleDtiey5TcQZ5Y3f4maAZrQDtNDpkslUXrcPyimVGjvXpJfDJ3973aeMhc
         mxbOHCIhelpxcXsND8NVkjbAFc4b6kiWm3u2mjKaB8aQxs8C0+XIk+42KfE2QoHi8D5t
         +FNO3rjcYNoA45249wLHza+GO79FF+UhYeBADcsUG2okqIym5LCDQB7tpM0YpSPv4Rsk
         7ZsRNCWaE5gcxdS+xGL7THXqaZCywa8lprgs0Fq/LSWEGTmrbBE++eWm08ti9fXEH2/q
         a5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZrJB+VMtGpCDCw4tM56I2rie2eVd0wx7yFHoaKknnYg=;
        b=GxDl4cDEEDdneCAykOK8GmNd7p13zW163RZL4LqFVVJwowKHb1RZ3CecOEYKWYTcrd
         MZaIWVqxo/m5SG7GtErTLDyJWiYGaeWt7eQHFMwuFtHire9+avm74W8FmtBbIAofZ2gA
         OPcMrGVcTMYq82vvnCVSC+NoukBOTneDTBB9sC860wBJF75FifUCmjodNbM/Tfuuvoug
         cd3OESi9DNGI7MIijT13BIiA+IIjCtcb643Ir9btypXJ/s8jpH/kT0cFb4TB+wXrEqE/
         osq+EBdk+RruzZ0pok5uc/GWS4Ah/j6OY7k+x4eS59resQWKaFlRnhH620ocYekckLRV
         f1bw==
X-Gm-Message-State: AOAM531Q4zzxu1qnj27EyUzphp9ufMmQmTNMkShzoTW3Hu75/2oxAhNb
        FL7ghJhzKmhMICyP5hEdm6dkI+aowS2LxUUgqVA6hw==
X-Google-Smtp-Source: ABdhPJxuoye7X2mfkcy+WoKggyaSsMD8piRi3S8uQqJDMwkZ5+yLuLV+oH/Qv5jPm+Cx/V9ac7+aWmlZJXrLL1hmiL0=
X-Received: by 2002:a63:5701:: with SMTP id l1mr1118729pgb.381.1610395420744;
 Mon, 11 Jan 2021 12:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20210109171058.497636-1-alobakin@pm.me> <CAKwvOdmV2tj4Uyz1iDkqCj+snWPpnnAmxJyN+puL33EpMRPzUw@mail.gmail.com>
 <20210109191457.786517-1-alobakin@pm.me>
In-Reply-To: <20210109191457.786517-1-alobakin@pm.me>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Jan 2021 12:03:29 -0800
Message-ID: <CAKwvOdnOXXaz+S1agu5kCQLm+qEkXE2Hpd2_V8yPsbUTQH7JZw@mail.gmail.com>
Subject: Re: [BUG mips llvm] MIPS: malformed R_MIPS_{HI16,LO16} with LLVM
To:     Alexander Lobakin <alobakin@pm.me>,
        Fangrui Song <maskray@google.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexander,
I'm genuinely trying to reproduce/understand this report, questions below:

On Sat, Jan 9, 2021 at 11:15 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Sat, 9 Jan 2021 09:50:44 -0800
>
> > On Sat, Jan 9, 2021 at 9:11 AM Alexander Lobakin <alobakin@pm.me> wrote=
:
> >>
> >> Machine: MIPS32 R2 Big Endian (interAptiv (multi))
> >>
> >> While testing MIPS with LLVM, I found a weird and very rare bug with
> >> MIPS relocs that LLVM emits into kernel modules. It happens on both
> >> 11.0.0 and latest git snapshot and applies, as I can see, only to
> >> references to static symbols.
> >>
> >> When the kernel loads the module, it allocates a space for every
> >> section and then manually apply the relocations relative to the
> >> new address.
> >>
> >> Let's say we have a function phy_probe() in drivers/net/phy/libphy.ko.
> >> It's static and referenced only in phy_register_driver(), where it's
> >> used to fill callback pointer in a structure.
> >>
> >> The real function address after module loading is 0xc06c1444, that
> >> is observed in its ELF st_value field.
> >> There are two relocs related to this usage in phy_register_driver():
> >>
> >> R_MIPS_HI16 refers to 0x3c010000
> >> R_MIPS_LO16 refers to 0x24339444

Sorry, how are these calculated?  (Explicit shell commands invoked
would be appreciated)

I'm doing:
$ ARCH=3Dmips CROSS_COMPILE=3Dmips-linux-gnu- make CC=3Dclang -j71 32r2_def=
config
$ ARCH=3Dmips CROSS_COMPILE=3Dmips-linux-gnu- make CC=3Dclang -j71 modules
$ llvm-nm --format=3Dsysv drivers/net/phy/phy_device.o | grep phy_probe
$ llvm-objdump -Dr --disassemble-symbols=3Dphy_driver_register
drivers/net/phy/phy_device.o
$ llvm-readelf -r drivers/net/phy/phy_device.o  | grep -e R_MIPS_HI16
-e R_MIPS_LO16

for some of the commands trying to verify.

> >>
> >> The address of .text is 0xc06b8000. So the destination is calculated
> >> as follows:
> >>
> >> 0x00000000 from hi16;
> >> 0xffff9444 from lo16 (sign extend as it's always treated as signed);
> >> 0xc06b8000 from base.
> >>
> >> =3D 0xc06b1444. The value is lower than the real phy_probe() address
> >> (0xc06c1444) by 0x10000 and is lower than the base address of
> >> module's .text, so it's 100% incorrect.

The disassembly for me produces:
    399c: 3c 03 00 00   lui     $3, 0 <phy_device_free>
                        0000399c:  R_MIPS_HI16  .text
...
    39a8: 24 63 3a 5c   addiu   $3, $3, 14940 <phy_probe>
                        000039a8:  R_MIPS_LO16  .text

I'm not really sure how to manually resolve the relocations; Fangrui
do you have any tips? (I'm coincidentally reading through Linkers &
Loaders currently, but only just started chpt. 4).

> >>
> >> This results in:
> >>
> >> [    2.204022] CPU 3 Unable to handle kernel paging request at virtual
> >> address c06b1444, epc =3D=3D c06b1444, ra =3D=3D 803f1090
> >>
> >> The correct instructions should be:
> >>
> >> R_MIPS_HI16 0x3c010001
> >> R_MIPS_LO16 0x24339444
> >>
> >> so there'll be 0x00010000 from hi16.
> >>
> >> I tried to catch those bugs in arch/mips/kernel/module.c (by checking
> >> if the destination is lower than the base address, which should never
> >> happen), and seems like I have only 3 such places in libphy.ko (and
> >> one in nf_tables.ko).
> >> I don't think it should be handled somehow in mentioned source code
> >> as it would look rather ugly and may break kernels build with GNU
> >> stack, which seems to not produce such bad codes.
> >>
> >> If I should report this to any other resources, please let me know.
> >> I chose clang-built-linux and LKML as it may not happen with userland
> >> (didn't tried to catch).
> >
> > Thanks for the report.  Sounds like we may indeed be producing an
> > incorrect relocation.  This is only seen for big endian triples?
>
> Unfortunately I don't have a LE board to play with, so can confirm
> only Big Endian.
>
> (BTW, if someone can say if it's possible for MIPS (and how if it is)
> to launch a LE kernel from BE-booted preloader and U-Boot, that would
> be super cool)
>
> > Getting a way for us to deterministically reproduce would be a good
> > first step.  Which config or configs beyond defconfig, and which
> > relocations specifically are you observing this with?
>
> I use `make 32r2_defconfig` which combines several configs from
> arch/mips/configs:
>  - generic_defconfig;
>  - generic/32r2.config;
>  - generic/eb.config.
>
> Aside from that, I enable a bunch of my WIP drivers and the
> Netfilter. On my setup, this bug is always present in libphy.ko,
> so CONFIG_PHYLIB=3Dm (with all deps) should be enough.
>
> The three failed relocs belongs to this part of code: [0]
>
> llvm-readelf on them:
>
> Relocation section '.rel.text' at offset 0xbf60 contains 2281 entries:=C2=
=AC
> [...]
> 00005740  00029305 R_MIPS_HI16            00000000   .text
> 00005744  00029306 R_MIPS_LO16            00000000   .text
> 00005720  00029305 R_MIPS_HI16            00000000   .text
> 00005748  00029306 R_MIPS_LO16            00000000   .text
> 0000573c  00029305 R_MIPS_HI16            00000000   .text
> 0000574c  00029306 R_MIPS_LO16            00000000   .text
>
> The first pair is the one from my first mail:
> 0x3c010000 <-- should be 0x3c010001 to work properly
> 0x24339444
>
> I'm planning to hunt for more now, will let you know.
>
> [0] https://elixir.bootlin.com/linux/v5.11-rc2/source/drivers/net/phy/phy=
_device.c#L2989
>
> > Thanks,
> > ~Nick Desaulniers
>
> Thanks,
> Al
>


--=20
Thanks,
~Nick Desaulniers
