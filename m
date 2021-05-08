Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CA93772F6
	for <lists+linux-arch@lfdr.de>; Sat,  8 May 2021 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhEHQay (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 May 2021 12:30:54 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:46318 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhEHQav (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 May 2021 12:30:51 -0400
Date:   Sat, 08 May 2021 16:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1620491388; bh=5rNl+kAanqy5Ow6PHG0Nk/iTcHfaHO7mTi0wPOmmCc0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=WyD5ez/5my30NXYcWHdga/2UTQhj3s1Mai4b6T2yCM7pXPFqSIyVDLZr44wTS1Sz6
         9JnHA0T8xPqHDnBBEngpRZ9z/HlmGq5WdFMsxgIQyE6HZQi/WcWkpStY4jdMmBFZ03
         QmWx1tyQKZv31lXLsZOPWM/yc3JUTdeIzzNZZ0YuWUrQPIe41RMeeFT1ZOQu5EPlQX
         eeNtYz6tMydBuvU/l1YDzPcaWpKbnohxfwvDNkRMAKXeILIBtFlCwdW0UFvOHYfEB5
         TLfd8iAn6ysn8OTtXLzEE5aHuj0aWwGlEnLwHk+Lfn9UG2BhGfJRD4BAXwsPqHGwlQ
         liOPHHS4GgHVQ==
To:     Nathan Chancellor <nathan@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [BUG mips llvm] MIPS: malformed R_MIPS_{HI16,LO16} with LLVM
Message-ID: <s6F4SDP26btK3zHEtGxYELVAR2oXYQu1JaXYCbCj4VyBigG5ROOk2JTLIw4Gs8fVC6SALoV7tgH7uJ7_fg0cQdpJ9TXJZmQSychOLMczMC4=@pm.me>
In-Reply-To: <YJTwglbUOb67r733@archlinux-ax161>
References: <20210109171058.497636-1-alobakin@pm.me> <YJTwglbUOb67r733@archlinux-ax161>
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

From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 7 May 2021 00:47:14 -0700

> On Sat, Jan 09, 2021 at 05:11:18PM +0000, Alexander Lobakin wrote:
> > Machine: MIPS32 R2 Big Endian (interAptiv (multi))
> >
> > While testing MIPS with LLVM, I found a weird and very rare bug with
> > MIPS relocs that LLVM emits into kernel modules. It happens on both
> > 11.0.0 and latest git snapshot and applies, as I can see, only to
> > references to static symbols.
> >
> > When the kernel loads the module, it allocates a space for every
> > section and then manually apply the relocations relative to the
> > new address.
> >
> > Let's say we have a function phy_probe() in drivers/net/phy/libphy.ko.
> > It's static and referenced only in phy_register_driver(), where it's
> > used to fill callback pointer in a structure.
> >
> > The real function address after module loading is 0xc06c1444, that
> > is observed in its ELF st_value field.
> > There are two relocs related to this usage in phy_register_driver():
> >
> > R_MIPS_HI16 refers to 0x3c010000
> > R_MIPS_LO16 refers to 0x24339444
> >
> > The address of .text is 0xc06b8000. So the destination is calculated
> > as follows:
> >
> > 0x00000000 from hi16;
> > 0xffff9444 from lo16 (sign extend as it's always treated as signed);
> > 0xc06b8000 from base.
> >
> > =3D3D 0xc06b1444. The value is lower than the real phy_probe() address
> > (0xc06c1444) by 0x10000 and is lower than the base address of
> > module's .text, so it's 100% incorrect.
> >
> > This results in:
> >
> > [    2.204022] CPU 3 Unable to handle kernel paging request at virtual
> > address c06b1444, epc =3D3D=3D3D c06b1444, ra =3D3D=3D3D 803f1090
> >
> > The correct instructions should be:
> >
> > R_MIPS_HI16 0x3c010001
> > R_MIPS_LO16 0x24339444
> >
> > so there'll be 0x00010000 from hi16.
> >
> > I tried to catch those bugs in arch/mips/kernel/module.c (by checking
> > if the destination is lower than the base address, which should never
> > happen), and seems like I have only 3 such places in libphy.ko (and
> > one in nf_tables.ko).
> > I don't think it should be handled somehow in mentioned source code
> > as it would look rather ugly and may break kernels build with GNU
> > stack, which seems to not produce such bad codes.
> >
> > If I should report this to any other resources, please let me know.
> > I chose clang-built-linux and LKML as it may not happen with userland
> > (didn't tried to catch).
> >
> > Thanks,
> > Al
> >
>
> Hi Alexander,

Hi!

> Doubling back around to this as I was browsing through the LLVM 12.0.1
> blockers on LLVM's bug tracker and I noticed a commit that could resolve
> this? It refers to the same relocations that you reference here.
>
> https://bugs.llvm.org/show_bug.cgi?id=3D3D49821
>
> http://github.com/llvm/llvm-project/commit/7e83a7f1fdfcc2edde61f0a535f9d7=
a=3D
> 56f531db9

This really seems very related to the bug I encountered.
Currently I don't have a MIPS setup to try since I've moved to
another country, but I should "deploy" it again soon. So I'll
definitely take a look a bit later, thanks for pointing on this
commit!

> I think that Debian's apt.llvm.org repository should have a build
> available with that commit in it. Otherwise, building it from source is
> not too complicated with my script:
>
> https://github.com/ClangBuiltLinux/tc-build
>
> $ ./build-llvm.py --build-stage1-only --install-stage1-only --projects "c=
l=3D
> ang;lld" --targets "Mips;X86"
>
> would get you a working toolchain relatively quickly.

I could just build llvm-git from Arch Linux User Repository :) I did
that last time when was checking if the latest snapshot also suffers
from the bug, and I think it didn't take much time to build.

> Cheers,
> Nathan

Thanks,
Al
