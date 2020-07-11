Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24C21C546
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jul 2020 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgGKQcr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jul 2020 12:32:47 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51923 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728412AbgGKQcr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Jul 2020 12:32:47 -0400
Received: from [192.168.0.6] (ip5f5af27f.dynamic.kabel-deutschland.de [95.90.242.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1B9102002EE32;
        Sat, 11 Jul 2020 18:32:42 +0200 (CEST)
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
References: <20200624203200.78870-1-samitolvanen@google.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de>
Date:   Sat, 11 Jul 2020 18:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dear Sami,


Am 24.06.20 um 22:31 schrieb Sami Tolvanen:
> This patch series adds support for building x86_64 and arm64 kernels
> with Clang's Link Time Optimization (LTO).
> 
> In addition to performance, the primary motivation for LTO is to allow
> Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> Pixel devices have shipped with LTO+CFI kernels since 2018.
> 
> Most of the patches are build system changes for handling LLVM bitcode,
> which Clang produces with LTO instead of ELF object files, postponing
> ELF processing until a later stage, and ensuring initcall ordering.
> 
> Note that first objtool patch in the series is already in linux-next,
> but as it's needed with LTO, I'm including it also here to make testing
> easier.

[…]

Thank you very much for sending these changes.

Do you have a branch, where your current work can be pulled from? Your 
branch on GitHub [1] seems 15 months old.

Out of curiosity, I applied the changes, allowed the selection for i386 
(x86), and with Clang 1:11~++20200701093119+ffee8040534-1~exp1 from 
Debian experimental, it failed with `Invalid absolute R_386_32 
relocation: KERNEL_PAGES`:

> make -f ./scripts/Makefile.build obj=arch/x86/boot arch/x86/boot/bzImage
> make -f ./scripts/Makefile.build obj=arch/x86/boot/compressed arch/x86/boot/compressed/vmlinux
>   llvm-nm vmlinux | sed -n -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW] \(_text\|__bss_start\|_end\)$/#define VO_ _AC(0x,UL)/p' > arch/x86/boot/compressed/../voffset.h
>   clang -Wp,-MMD,arch/x86/boot/compressed/.misc.o.d -nostdinc -isystem /usr/lib/llvm-11/lib/clang/11.0.0/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Qunused-arguments -m32 -O2 -fno-strict-aliasing -fPIE -DDISABLE_BRANCH_PROFILING -march=i386 -mno-mmx -mno-sse -ffreestanding -fno-stack-protector -Wno-address-of-packed-member -Wno-gnu -Wno-pointer-sign -fmacro-prefix-map=./= -fno-asynchronous-unwind-tables    -DKBUILD_MODFILE='"arch/x86/boot/compressed/misc"' -DKBUILD_BASENAME='"misc"' -DKBUILD_MODNAME='"misc"' -D__KBUILD_MODNAME=misc -c -o arch/x86/boot/compressed/misc.o arch/x86/boot/compressed/misc.c
>   llvm-objcopy  -R .comment -S vmlinux arch/x86/boot/compressed/vmlinux.bin
>   arch/x86/tools/relocs vmlinux > arch/x86/boot/compressed/vmlinux.relocs;arch/x86/tools/relocs --abs-relocs vmlinux
> Invalid absolute R_386_32 relocation: KERNEL_PAGES
> make[2]: *** [arch/x86/boot/compressed/Makefile:134: arch/x86/boot/compressed/vmlinux.relocs] Error 1
> make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> make[1]: *** [arch/x86/boot/Makefile:115: arch/x86/boot/compressed/vmlinux] Error 2
> make: *** [arch/x86/Makefile:268: bzImage] Error 2


Kind regards,

Paul



[1]: https://github.com/samitolvanen/linux/tree/clang-lto
