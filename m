Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015A6209877
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 04:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbgFYC0v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 22:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbgFYC0u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 22:26:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE58C061573;
        Wed, 24 Jun 2020 19:26:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so1883931oty.11;
        Wed, 24 Jun 2020 19:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZQNZYHZs3Rf5u37OLrL6y0pvgTgU4h8M5jVmsv5Nrec=;
        b=AZcqU08vwZw9lrCsZsKBlLyXkNyZa4Z91/EmPbGeOoW2ao/UQMOSfq81bN29+UrCso
         7XPCJ68zo766UgdGF3xas4X6/4NGojSucMUgoIYWA6qPtQ80X69hWEj5o2B37QuhSRyy
         p3T5MPqVetLqV6OVPTWY3BhiYkewqHCVhjDURFb/o2OBxrl4wtZ70UcwJ6PC2x35PBHU
         a+5QytEgeiUH6+TzQCmECEq9Gjrx76ilvOkvVCK2qPGIbt8zlhiBAAvrmfbAx2O7mbJe
         QlK6xMcNBCWbtNdDmUQ+DHQHM9dT2zR7aGR7uZ05zx+3QEHSIhDQ9TVdZSL7xdC/foKW
         khWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZQNZYHZs3Rf5u37OLrL6y0pvgTgU4h8M5jVmsv5Nrec=;
        b=oWjQg2G3t7YzrkI6b9s2jthNsFbPEEdm/EV7rpGHxglhHuxVz9mQObmV1oXDq09hHd
         bdq6NkVBHa8jIgBcf2lAp27AWahE40tFTthn3nQyALdQUacqi/JkTHFM3ITRIqMmQSkc
         fvhVHnw9VFXPkQTn/VgYqOxPBqvWFPBcXB/uq68NsrnDw4O/zt3hlil69OfL8NXhScEo
         2yb0XPqZsr8/28kKaGWZPG7BTnScWntZcJ+DVc5B3o1p5a5TCa0korLN5jQDNthI0D2b
         TDuyyZq0xYXyb7EEEiE9g2PUPtXnrMqXflPh2Vazp0AuROMzAyLFVGW6jo9EKkuGxTe8
         hQTg==
X-Gm-Message-State: AOAM531CzRjCaM9dOx1FmuvK4Aq75ozZIBjo3LISkKIw+vNmtRqSWmzY
        h0NoKsULOYe32VJdt4+mJFjbOVAJGcU=
X-Google-Smtp-Source: ABdhPJw1AzgRgryeo1cu/6FpvQVFO+54yG3gpbWyWO2n0QHC6FG7I1bntUQA1AKQNkHP8ISfYtWv5g==
X-Received: by 2002:a9d:32a1:: with SMTP id u30mr5549372otb.264.1593052009657;
        Wed, 24 Jun 2020 19:26:49 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id p1sm5444990oot.34.2020.06.24.19.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 19:26:49 -0700 (PDT)
Date:   Wed, 24 Jun 2020 19:26:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 02/22] kbuild: add support for Clang LTO
Message-ID: <20200625022647.GB2871607@ubuntu-n2-xlarge-x86>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624203200.78870-3-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sami,

On Wed, Jun 24, 2020 at 01:31:40PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> This change adds build system support for Clang's Link Time
> Optimization (LTO). With -flto, instead of ELF object files, Clang
> produces LLVM bitcode, which is compiled into native code at link
> time, allowing the final binary to be optimized globally. For more
> details, see:
> 
>   https://llvm.org/docs/LinkTimeOptimization.html
> 
> The Kconfig option CONFIG_LTO_CLANG is implemented as a choice,
> which defaults to LTO being disabled. To use LTO, the architecture
> must select ARCH_SUPPORTS_LTO_CLANG and support:
> 
>   - compiling with Clang,
>   - compiling inline assembly with Clang's integrated assembler,
>   - and linking with LLD.
> 
> While using full LTO results in the best runtime performance, the
> compilation is not scalable in time or memory. CONFIG_THINLTO
> enables ThinLTO, which allows parallel optimization and faster
> incremental builds. ThinLTO is used by default if the architecture
> also selects ARCH_SUPPORTS_THINLTO:
> 
>   https://clang.llvm.org/docs/ThinLTO.html
> 
> To enable LTO, LLVM tools must be used to handle bitcode files. The
> easiest way is to pass the LLVM=1 option to make:
> 
>   $ make LLVM=1 defconfig
>   $ scripts/config -e LTO_CLANG
>   $ make LLVM=1
> 
> Alternatively, at least the following LLVM tools must be used:
> 
>   CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
> 
> To prepare for LTO support with other compilers, common parts are
> gated behind the CONFIG_LTO option, and LTO can be disabled for
> specific files by filtering out CC_FLAGS_LTO.
> 
> Note that support for DYNAMIC_FTRACE and MODVERSIONS are added in
> follow-up patches.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  Makefile                          | 16 ++++++++
>  arch/Kconfig                      | 66 +++++++++++++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 11 ++++--
>  scripts/Makefile.build            |  9 ++++-
>  scripts/Makefile.modfinal         |  9 ++++-
>  scripts/Makefile.modpost          | 24 ++++++++++-
>  scripts/link-vmlinux.sh           | 32 +++++++++++----
>  7 files changed, 151 insertions(+), 16 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ac2c61c37a73..0c7fe6fb2143 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -886,6 +886,22 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
>  export CC_FLAGS_SCS
>  endif
>  
> +ifdef CONFIG_LTO_CLANG
> +ifdef CONFIG_THINLTO
> +CC_FLAGS_LTO_CLANG := -flto=thin $(call cc-option, -fsplit-lto-unit)
> +KBUILD_LDFLAGS	+= --thinlto-cache-dir=.thinlto-cache
> +else
> +CC_FLAGS_LTO_CLANG := -flto
> +endif
> +CC_FLAGS_LTO_CLANG += -fvisibility=default
> +endif
> +
> +ifdef CONFIG_LTO
> +CC_FLAGS_LTO	:= $(CC_FLAGS_LTO_CLANG)
> +KBUILD_CFLAGS	+= $(CC_FLAGS_LTO)
> +export CC_FLAGS_LTO
> +endif
> +
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8cc35dc556c7..e00b122293f8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -552,6 +552,72 @@ config SHADOW_CALL_STACK
>  	  reading and writing arbitrary memory may be able to locate them
>  	  and hijack control flow by modifying the stacks.
>  
> +config LTO
> +	bool
> +
> +config ARCH_SUPPORTS_LTO_CLANG
> +	bool
> +	help
> +	  An architecture should select this option if it supports:
> +	  - compiling with Clang,
> +	  - compiling inline assembly with Clang's integrated assembler,
> +	  - and linking with LLD.
> +
> +config ARCH_SUPPORTS_THINLTO
> +	bool
> +	help
> +	  An architecture should select this option if it supports Clang's
> +	  ThinLTO.
> +
> +config THINLTO
> +	bool "Clang ThinLTO"
> +	depends on LTO_CLANG && ARCH_SUPPORTS_THINLTO
> +	default y
> +	help
> +	  This option enables Clang's ThinLTO, which allows for parallel
> +	  optimization and faster incremental compiles. More information
> +	  can be found from Clang's documentation:
> +
> +	    https://clang.llvm.org/docs/ThinLTO.html
> +
> +choice
> +	prompt "Link Time Optimization (LTO)"
> +	default LTO_NONE
> +	help
> +	  This option enables Link Time Optimization (LTO), which allows the
> +	  compiler to optimize binaries globally.
> +
> +	  If unsure, select LTO_NONE.
> +
> +config LTO_NONE
> +	bool "None"
> +
> +config LTO_CLANG
> +	bool "Clang's Link Time Optimization (EXPERIMENTAL)"
> +	depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD

I am curious, what is the reason for gating this at clang 11.0.0?

Presumably this? https://github.com/ClangBuiltLinux/linux/issues/510

It might be nice to notate this so that we do not have to wonder :)

Cheers,
Nathan
