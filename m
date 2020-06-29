Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1458620E941
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgF2XVG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 19:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgF2XVG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 19:21:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02AC03E979
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 16:21:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so8559780pfn.7
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y3eOZWqjsfvFABJlAWadxHNb9WOoW2QZW11FNR7qgIM=;
        b=wE7nxuQQ8Ee1SyIlOGu96foC1kguVLhQnWfsM449qkfn/VoKBCtsVMOqOmKx7IZI4C
         RVaEjdafrzkZKrdHnHpUfIuUaR+nDUOQdXro+nnJx5XibnwFB04m0UpfLU8lcAfNzunK
         FH4vq/4AmRKx0OXYjTpIwOSmyWjemlGQQrsAim9D+osZfnHYYrMcyKBMOA6AcmZTCt7D
         SC8HEZlX2KwR8OsKRbEGGGO82nQHiO6QrFnPdGaYVsrLOIGowYuaQm3rOF21PeyeGPnP
         uhJe537nfOotmxkifcJzP2KlYRs06hCp+YYdixCMO/J34Bhc2jSz49ZJoQbscAlwSyYN
         PnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y3eOZWqjsfvFABJlAWadxHNb9WOoW2QZW11FNR7qgIM=;
        b=Fb6AHVxNFnny9mHtOT4y7QunsAfUoyv7dG7LQFHcWmhoGzjIO7AU8sKmNNF7Fz1DIh
         SE4ZdBAuSb7S6K2CHfj0xn+x5PyBJpRfQRGwjojQBncWRNmYnF9PwlRlIz5szcFXbO9+
         ePIf6TNmTqdg+3TmkWnnDX5pFXqEiQqIPH1DsdOSCqLLfPCVQj37digCurB3srZYjLZD
         YrRfdBob7ENLfJuOLPqzTBo5UoHgBuZXCy2zCMwiYQCUNQDOJ+9yByXomrdDgmj/wKHz
         7AhE/ODj4xkUtAVnXd/PWB6+5ifOwg45SD/vSb+J4iDUsZJsavufWe9Ft/kf0z8vydMb
         a3Lw==
X-Gm-Message-State: AOAM5335ikfvMa60H554gmzZ7zm5gywIiWAxFUwwQ2S/CXUtmPLeO1HU
        jBXR0xzOu1YGlgQvaU4et8UXxw==
X-Google-Smtp-Source: ABdhPJyWjBAVW07I/bBTVGZOBkIjcBIoUitijR4kfg05/memnxRwz5hP6QJZ8z5KUGyU1tHG6QOWdA==
X-Received: by 2002:a62:ce48:: with SMTP id y69mr15584876pfg.208.1593472865320;
        Mon, 29 Jun 2020 16:21:05 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id d9sm722596pgg.74.2020.06.29.16.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:21:04 -0700 (PDT)
Date:   Mon, 29 Jun 2020 16:20:59 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200629232059.GA3787278@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro,

On Mon, Jun 29, 2020 at 01:56:19AM +0900, Masahiro Yamada wrote:
> On Thu, Jun 25, 2020 at 5:32 AM 'Sami Tolvanen' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is to allow
> > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > Pixel devices have shipped with LTO+CFI kernels since 2018.
> >
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> >
> > Note that first objtool patch in the series is already in linux-next,
> > but as it's needed with LTO, I'm including it also here to make testing
> > easier.
> 
> 
> I put this series on a testing branch,
> and 0-day bot started reporting some issues.

Yes, I'll fix those issues in v2.

> (but 0-day bot is quieter than I expected.
> Perhaps, 0-day bot does not turn on LLVM=1 ?)

In order for it to test an LTO build, it would need to enable LTO_CLANG
explicitly though, in addition to LLVM=1.

> I also got an error for
> ARCH=arm64 allyesconfig + CONFIG_LTO_CLANG=y
> 
> 
> 
> $ make ARCH=arm64 LLVM=1 LLVM_IAS=1
> CROSS_COMPILE=~/tools/aarch64-linaro-7.5/bin/aarch64-linux-gnu-
> -j24
> 
>   ...
> 
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   GEN     .tmp_initcalls.lds
>   GEN     .tmp_symversions.lds
>   LTO     vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.kallsyms1
> ld.lld: error: undefined symbol: __compiletime_assert_905
> >>> referenced by irqbypass.c
> >>>               vmlinux.o:(jeq_imm)
> make: *** [Makefile:1161: vmlinux] Error 1

I can reproduce this with ToT LLVM and it's BUILD_BUG_ON_MSG(..., "value
too large for the field") in drivers/net/ethernet/netronome/nfp/bpf/jit.c.
Specifically, the FIELD_FIT / __BF_FIELD_CHECK macro in ur_load_imm_any.

This compiles just fine with an earlier LLVM revision, so it could be a
relatively recent regression. I'll take a look. Thanks for catching this!

Sami
