Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE837616B
	for <lists+linux-arch@lfdr.de>; Fri,  7 May 2021 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbhEGHse (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 May 2021 03:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235710AbhEGHsc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 May 2021 03:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5350661132;
        Fri,  7 May 2021 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620373640;
        bh=XFqW5/0INXkY7fiA03jYF2gDpE6cWawWuPSZmXlC8s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqiXPuGjge0oMUa49t2d0omFSMtna+bT91ylp6Oqkyx2pRb9umJaFAZe4WlPT6gfD
         eud1JN3+NvEHqOoiyi9w5K3l7icH4HGodFnB2z1hRJFjTSLKHW5F+EMJq3FklvMStz
         0C4JjTcjpc9tsScwQYCF7lXu9oHA1dTB2fGF5z1EchN8EPkIbRSJMJ9s1hs87PHYv0
         Yml3/2bm8UmFHXa5QedKYc9/Qe0NVPDpsWyJ0m9+KALHB3YGN7UOofdLRDSyJLnizK
         ehLfohPefUL0qNRHhki4CfdIiHW02h3tRJDjNs6PBKXqoUYtgnRK5eZEG2NFXQ1MgV
         pT7vGXQ9Iga3Q==
Date:   Fri, 7 May 2021 00:47:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [BUG mips llvm] MIPS: malformed R_MIPS_{HI16,LO16} with LLVM
Message-ID: <YJTwglbUOb67r733@archlinux-ax161>
References: <20210109171058.497636-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109171058.497636-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 09, 2021 at 05:11:18PM +0000, Alexander Lobakin wrote:
> Machine: MIPS32 R2 Big Endian (interAptiv (multi))
> 
> While testing MIPS with LLVM, I found a weird and very rare bug with
> MIPS relocs that LLVM emits into kernel modules. It happens on both
> 11.0.0 and latest git snapshot and applies, as I can see, only to
> references to static symbols.
> 
> When the kernel loads the module, it allocates a space for every
> section and then manually apply the relocations relative to the
> new address.
> 
> Let's say we have a function phy_probe() in drivers/net/phy/libphy.ko.
> It's static and referenced only in phy_register_driver(), where it's
> used to fill callback pointer in a structure.
> 
> The real function address after module loading is 0xc06c1444, that
> is observed in its ELF st_value field.
> There are two relocs related to this usage in phy_register_driver():
> 
> R_MIPS_HI16 refers to 0x3c010000
> R_MIPS_LO16 refers to 0x24339444
> 
> The address of .text is 0xc06b8000. So the destination is calculated
> as follows:
> 
> 0x00000000 from hi16;
> 0xffff9444 from lo16 (sign extend as it's always treated as signed);
> 0xc06b8000 from base.
> 
> = 0xc06b1444. The value is lower than the real phy_probe() address
> (0xc06c1444) by 0x10000 and is lower than the base address of
> module's .text, so it's 100% incorrect.
> 
> This results in:
> 
> [    2.204022] CPU 3 Unable to handle kernel paging request at virtual
> address c06b1444, epc == c06b1444, ra == 803f1090
> 
> The correct instructions should be:
> 
> R_MIPS_HI16 0x3c010001
> R_MIPS_LO16 0x24339444
> 
> so there'll be 0x00010000 from hi16.
> 
> I tried to catch those bugs in arch/mips/kernel/module.c (by checking
> if the destination is lower than the base address, which should never
> happen), and seems like I have only 3 such places in libphy.ko (and
> one in nf_tables.ko).
> I don't think it should be handled somehow in mentioned source code
> as it would look rather ugly and may break kernels build with GNU
> stack, which seems to not produce such bad codes.
> 
> If I should report this to any other resources, please let me know.
> I chose clang-built-linux and LKML as it may not happen with userland
> (didn't tried to catch).
> 
> Thanks,
> Al
> 

Hi Alexander,

Doubling back around to this as I was browsing through the LLVM 12.0.1
blockers on LLVM's bug tracker and I noticed a commit that could resolve
this? It refers to the same relocations that you reference here.

https://bugs.llvm.org/show_bug.cgi?id=49821

http://github.com/llvm/llvm-project/commit/7e83a7f1fdfcc2edde61f0a535f9d7a56f531db9

I think that Debian's apt.llvm.org repository should have a build
available with that commit in it. Otherwise, building it from source is
not too complicated with my script:

https://github.com/ClangBuiltLinux/tc-build

$ ./build-llvm.py --build-stage1-only --install-stage1-only --projects "clang;lld" --targets "Mips;X86"

would get you a working toolchain relatively quickly.

Cheers,
Nathan
