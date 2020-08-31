Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF72581ED
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 21:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgHaTl1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgHaTl0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 15:41:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F1C061755
        for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2020 12:41:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so1196364pfc.12
        for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2020 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BoCMpob6AiQsu+kxWHd5oJKfOs4R1dZWuQK+Zd6WM1s=;
        b=KH/wZ6f6GafyFg7fXLcCmcuRM9IwWFjcR/5mxZZvaELD+oD8nOi9GJ9SorhVHrNeH8
         i6sEt+KoiVtmsZYyflDKVB1S1cLms++KSb0B8VQzxyEgSD+gXalOf/67a3Kum0FiM+sB
         sfcc3KwCqh5s7wlM9Eq9+gvbDXqUKSyIgeEe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BoCMpob6AiQsu+kxWHd5oJKfOs4R1dZWuQK+Zd6WM1s=;
        b=aRP/YPGDcziQAwbnD9AF07GQDlOHxogjDlJOHNCbHQsvYiQl+O6J5/EZEvAaxQuInh
         168bI4Tuo5e7AprZmqfYvjvFkXYH/EdhGEEBoqI6etAtFTI+wk1XjEFetSMQm3yQUz+6
         zGxRNhH1nPf1OyKkMvQoWSYDhmK67xvhGAJxdgWBv3PYh23UCxm2xJK6ObeUn7p3OfjB
         GX27bOG553QWBc4D7FPNHKqP6lu0rNx5l/eq3QL+oO4FpOMAlxkfi1af5e9unyirwqr2
         StO3IZhOUXzTzivMvw2g648VbPFi92+Wtx6tL8gYHeYSs7i8QHduIXq2IDQXvB6fSbnA
         rBUg==
X-Gm-Message-State: AOAM531xg+efNjZTWhI0yLEOHrVvcInEHs7G1L5EtaSyEDQKqHS5Ez3f
        0864+kxp9UchXoVjjf/QUCh8IA==
X-Google-Smtp-Source: ABdhPJwA0imUxzKirhLfL59+/439BkhdAOMtESFs9lnafMybqpg7F7nAQsaduV5YosQ9+SDVDnAvfg==
X-Received: by 2002:a63:e018:: with SMTP id e24mr2361162pgh.175.1598902885705;
        Mon, 31 Aug 2020 12:41:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s28sm4183844pfd.111.2020.08.31.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 12:41:24 -0700 (PDT)
Date:   Mon, 31 Aug 2020 12:41:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
Message-ID: <202008311240.9F94A39@keescook>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 12:42:41PM -0700, Kees Cook wrote:
> Hi Ingo,
> 
> Based on my testing, this is ready to go. I've reviewed the feedback on
> v5 and made a few small changes, noted below.

If no one objects, I'll pop this into my tree for -next. I'd prefer it
go via -tip though! :)

Thanks!

-Kees

> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/warn/v6
> 
> v6:
> - rebase to -tip x86/boot
> - remove 0-sized NOLOAD
> - move .got.plt to end with INFO (NOLOAD warns)
> - add Reviewed-bys
> v5: https://lore.kernel.org/lkml/20200731230820.1742553-1-keescook@chromium.org/
> v4: https://lore.kernel.org/lkml/20200629061840.4065483-1-keescook@chromium.org/
> v3: https://lore.kernel.org/lkml/20200624014940.1204448-1-keescook@chromium.org/
> v2: https://lore.kernel.org/lkml/20200622205815.2988115-1-keescook@chromium.org/
> v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/
> 
> A recent bug[1] was solved for builds linked with ld.lld, and tracking
> it down took way longer than it needed to (a year). Ultimately, it
> boiled down to differences between ld.bfd and ld.lld's handling of
> orphan sections. Similar situation have continued to recur, and it's
> clear the kernel build needs to be much more explicit about linker
> sections. Similarly, the recent FGKASLR series brought up orphan section
> handling too[2]. In all cases, it would have been nice if the linker was
> running with --orphan-handling=warn so that surprise sections wouldn't
> silently get mapped into the kernel image at locations up to the whim
> of the linker's orphan handling logic. Instead, all desired sections
> should be explicitly identified in the linker script (to be either kept,
> discarded, or verified to be zero-sized) with any orphans throwing a
> warning. The powerpc architecture has actually been doing this for some
> time, so this series just extends that coverage to x86, arm, and arm64.
> 
> This has gotten sucecssful build testing under the following matrix:
> 
> compiler/linker: gcc+ld.bfd, clang+ld.lld
> targets: defconfig, allmodconfig
> architectures: x86, i386, arm64, arm
> versions: -tip x86/boot
> 
> All three architectures depend on the first several commits to
> vmlinux.lds.h. x86 depends on Arvind's GOT series (in -tip x86/boot now).
> arm64 depends on the efi/libstub patch. As such, I'd like to land this
> series as a whole. Ingo has suggested he'd take it into -tip.
> 
> Thanks!
> 
> -Kees
> 
> [1] https://github.com/ClangBuiltLinux/linux/issues/282
> [2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/
> 
> Kees Cook (28):
>   vmlinux.lds.h: Create COMMON_DISCARDS
>   vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
>   vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
>   vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG
>   vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
>   efi/libstub: Disable -mbranch-protection
>   arm64/mm: Remove needless section quotes
>   arm64/kernel: Remove needless Call Frame Information annotations
>   arm64/build: Remove .eh_frame* sections due to unwind tables
>   arm64/build: Use common DISCARDS in linker script
>   arm64/build: Add missing DWARF sections
>   arm64/build: Assert for unwanted sections
>   arm64/build: Warn on orphan section placement
>   arm/build: Refactor linker script headers
>   arm/build: Explicitly keep .ARM.attributes sections
>   arm/build: Add missing sections
>   arm/build: Assert for unwanted sections
>   arm/build: Warn on orphan section placement
>   arm/boot: Handle all sections explicitly
>   arm/boot: Warn on orphan section placement
>   x86/asm: Avoid generating unused kprobe sections
>   x86/build: Enforce an empty .got.plt section
>   x86/build: Assert for unwanted sections
>   x86/build: Warn on orphan section placement
>   x86/boot/compressed: Reorganize zero-size section asserts
>   x86/boot/compressed: Remove, discard, or assert for unwanted sections
>   x86/boot/compressed: Add missing debugging sections to output
>   x86/boot/compressed: Warn on orphan section placement
> 
> Nick Desaulniers (1):
>   vmlinux.lds.h: add PGO and AutoFDO input sections
> 
>  arch/alpha/kernel/vmlinux.lds.S               |  1 +
>  arch/arc/kernel/vmlinux.lds.S                 |  1 +
>  arch/arm/Makefile                             |  4 ++
>  arch/arm/boot/compressed/Makefile             |  2 +
>  arch/arm/boot/compressed/vmlinux.lds.S        | 20 +++----
>  .../arm/{kernel => include/asm}/vmlinux.lds.h | 30 ++++++++--
>  arch/arm/kernel/vmlinux-xip.lds.S             |  8 ++-
>  arch/arm/kernel/vmlinux.lds.S                 |  8 ++-
>  arch/arm64/Makefile                           |  9 ++-
>  arch/arm64/kernel/smccc-call.S                |  2 -
>  arch/arm64/kernel/vmlinux.lds.S               | 28 +++++++--
>  arch/arm64/mm/mmu.c                           |  2 +-
>  arch/csky/kernel/vmlinux.lds.S                |  1 +
>  arch/hexagon/kernel/vmlinux.lds.S             |  1 +
>  arch/ia64/kernel/vmlinux.lds.S                |  1 +
>  arch/mips/kernel/vmlinux.lds.S                |  1 +
>  arch/nds32/kernel/vmlinux.lds.S               |  1 +
>  arch/nios2/kernel/vmlinux.lds.S               |  1 +
>  arch/openrisc/kernel/vmlinux.lds.S            |  1 +
>  arch/parisc/boot/compressed/vmlinux.lds.S     |  1 +
>  arch/parisc/kernel/vmlinux.lds.S              |  1 +
>  arch/powerpc/kernel/vmlinux.lds.S             |  2 +-
>  arch/riscv/kernel/vmlinux.lds.S               |  1 +
>  arch/s390/kernel/vmlinux.lds.S                |  1 +
>  arch/sh/kernel/vmlinux.lds.S                  |  1 +
>  arch/sparc/kernel/vmlinux.lds.S               |  1 +
>  arch/um/kernel/dyn.lds.S                      |  2 +-
>  arch/um/kernel/uml.lds.S                      |  2 +-
>  arch/x86/Makefile                             |  4 ++
>  arch/x86/boot/compressed/Makefile             |  2 +
>  arch/x86/boot/compressed/vmlinux.lds.S        | 58 +++++++++++++------
>  arch/x86/include/asm/asm.h                    |  6 +-
>  arch/x86/kernel/vmlinux.lds.S                 | 39 ++++++++++++-
>  drivers/firmware/efi/libstub/Makefile         |  9 ++-
>  include/asm-generic/vmlinux.lds.h             | 49 +++++++++++++---
>  35 files changed, 241 insertions(+), 60 deletions(-)
>  rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (84%)
> 
> -- 
> 2.25.1
> 

-- 
Kees Cook
