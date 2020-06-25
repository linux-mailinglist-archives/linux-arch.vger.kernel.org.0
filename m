Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA420A2B3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405929AbgFYQNs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbgFYQNr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 12:13:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F134C08C5DB
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:13:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cv18so660038pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tN3RRFkW8H40rA8SGu1JDOigZLSzT5qVO0+D16XtuLc=;
        b=FNy/7DFbxnBgI72+dWF1OpzoyRqVVhI3k7b313hoPAknwI2gtcpnrbI/QxduZaLChO
         XsS20NJXJUX+BgZZni3WHhBJhCOxGeey5qw4s+h96KkQc1DbqtdERktvlQbbWfMI5Qtj
         CMFRos0WWK71LdR3xO8mzueiOZZD/HrvnbZcL7TWPhuTj08pp29CzK2iwQtWYxS/KzPS
         DbZRhxXQXIM+BXTF2MYRYYBA9EL7Z4t+n9j3emOXcA8xRPQhjqftNQZaWno22ZXuxY9B
         OJCpp0YifwADaKWWU1uXVBh+ae7gxCNBEpNdOASG/NzMPjRUdcy8BrCxoR+02HHMW5zQ
         TEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tN3RRFkW8H40rA8SGu1JDOigZLSzT5qVO0+D16XtuLc=;
        b=OyEZ/d5nTXSzxq68BHAUTwyowP0P/nq2Oix9JPjc+HSCbV/gbfmvzusFyGuh7/lOV+
         sxuytBm6tXwVXeqUbbLzzI6Uq+P76mVVXGs/WmL76175E6lWBIMpovt2c1lxca9ZPK6W
         4YurzTLbVnGpZIhI5lHvDlJJ31H2N2OhuxkbVJuvDWHyytL2Ed46pXg/8pO8JXmZs/5u
         M1t41OaXTsCTcIWO9SxGzRb2JE3lF3f1y/InAwVoOkjhIi+LcI02naFbp8M4WYTPt2YW
         l+eZm5BDKVXMPeVCNMHFr1NKeAsRyBCthsDRKphVBldBe7IuUFjLof5rrxBkgLF1B6sJ
         MNMA==
X-Gm-Message-State: AOAM532Z88mFLZO8pVj95sAU472ThvVLQRf/zOGtouiN68NZgwex2SXA
        Moou5+DN0s0R8Ow2GJy2v9mDDA==
X-Google-Smtp-Source: ABdhPJxZZxKF0/AUF+MScBXa8zZXuQ+lX7KkH7oqN3X8Y0ebQY5u9x4x5ou8dadW03hvgkUjiMZCBw==
X-Received: by 2002:a17:90a:7c4e:: with SMTP id e14mr4310401pjl.52.1593101626297;
        Thu, 25 Jun 2020 09:13:46 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id v7sm22710119pfn.147.2020.06.25.09.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:13:45 -0700 (PDT)
Date:   Thu, 25 Jun 2020 09:13:39 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
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
Message-ID: <20200625161339.GA173089@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-3-samitolvanen@google.com>
 <20200625022647.GB2871607@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625022647.GB2871607@ubuntu-n2-xlarge-x86>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 07:26:47PM -0700, Nathan Chancellor wrote:
> Hi Sami,
> 
> On Wed, Jun 24, 2020 at 01:31:40PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> > This change adds build system support for Clang's Link Time
> > Optimization (LTO). With -flto, instead of ELF object files, Clang
> > produces LLVM bitcode, which is compiled into native code at link
> > time, allowing the final binary to be optimized globally. For more
> > details, see:
> > 
> >   https://llvm.org/docs/LinkTimeOptimization.html
> > 
> > The Kconfig option CONFIG_LTO_CLANG is implemented as a choice,
> > which defaults to LTO being disabled. To use LTO, the architecture
> > must select ARCH_SUPPORTS_LTO_CLANG and support:
> > 
> >   - compiling with Clang,
> >   - compiling inline assembly with Clang's integrated assembler,
> >   - and linking with LLD.
> > 
> > While using full LTO results in the best runtime performance, the
> > compilation is not scalable in time or memory. CONFIG_THINLTO
> > enables ThinLTO, which allows parallel optimization and faster
> > incremental builds. ThinLTO is used by default if the architecture
> > also selects ARCH_SUPPORTS_THINLTO:
> > 
> >   https://clang.llvm.org/docs/ThinLTO.html
> > 
> > To enable LTO, LLVM tools must be used to handle bitcode files. The
> > easiest way is to pass the LLVM=1 option to make:
> > 
> >   $ make LLVM=1 defconfig
> >   $ scripts/config -e LTO_CLANG
> >   $ make LLVM=1
> > 
> > Alternatively, at least the following LLVM tools must be used:
> > 
> >   CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
> > 
> > To prepare for LTO support with other compilers, common parts are
> > gated behind the CONFIG_LTO option, and LTO can be disabled for
> > specific files by filtering out CC_FLAGS_LTO.
> > 
> > Note that support for DYNAMIC_FTRACE and MODVERSIONS are added in
> > follow-up patches.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  Makefile                          | 16 ++++++++
> >  arch/Kconfig                      | 66 +++++++++++++++++++++++++++++++
> >  include/asm-generic/vmlinux.lds.h | 11 ++++--
> >  scripts/Makefile.build            |  9 ++++-
> >  scripts/Makefile.modfinal         |  9 ++++-
> >  scripts/Makefile.modpost          | 24 ++++++++++-
> >  scripts/link-vmlinux.sh           | 32 +++++++++++----
> >  7 files changed, 151 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index ac2c61c37a73..0c7fe6fb2143 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -886,6 +886,22 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
> >  export CC_FLAGS_SCS
> >  endif
> >  
> > +ifdef CONFIG_LTO_CLANG
> > +ifdef CONFIG_THINLTO
> > +CC_FLAGS_LTO_CLANG := -flto=thin $(call cc-option, -fsplit-lto-unit)
> > +KBUILD_LDFLAGS	+= --thinlto-cache-dir=.thinlto-cache
> > +else
> > +CC_FLAGS_LTO_CLANG := -flto
> > +endif
> > +CC_FLAGS_LTO_CLANG += -fvisibility=default
> > +endif
> > +
> > +ifdef CONFIG_LTO
> > +CC_FLAGS_LTO	:= $(CC_FLAGS_LTO_CLANG)
> > +KBUILD_CFLAGS	+= $(CC_FLAGS_LTO)
> > +export CC_FLAGS_LTO
> > +endif
> > +
> >  # arch Makefile may override CC so keep this after arch Makefile is included
> >  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> >  
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 8cc35dc556c7..e00b122293f8 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -552,6 +552,72 @@ config SHADOW_CALL_STACK
> >  	  reading and writing arbitrary memory may be able to locate them
> >  	  and hijack control flow by modifying the stacks.
> >  
> > +config LTO
> > +	bool
> > +
> > +config ARCH_SUPPORTS_LTO_CLANG
> > +	bool
> > +	help
> > +	  An architecture should select this option if it supports:
> > +	  - compiling with Clang,
> > +	  - compiling inline assembly with Clang's integrated assembler,
> > +	  - and linking with LLD.
> > +
> > +config ARCH_SUPPORTS_THINLTO
> > +	bool
> > +	help
> > +	  An architecture should select this option if it supports Clang's
> > +	  ThinLTO.
> > +
> > +config THINLTO
> > +	bool "Clang ThinLTO"
> > +	depends on LTO_CLANG && ARCH_SUPPORTS_THINLTO
> > +	default y
> > +	help
> > +	  This option enables Clang's ThinLTO, which allows for parallel
> > +	  optimization and faster incremental compiles. More information
> > +	  can be found from Clang's documentation:
> > +
> > +	    https://clang.llvm.org/docs/ThinLTO.html
> > +
> > +choice
> > +	prompt "Link Time Optimization (LTO)"
> > +	default LTO_NONE
> > +	help
> > +	  This option enables Link Time Optimization (LTO), which allows the
> > +	  compiler to optimize binaries globally.
> > +
> > +	  If unsure, select LTO_NONE.
> > +
> > +config LTO_NONE
> > +	bool "None"
> > +
> > +config LTO_CLANG
> > +	bool "Clang's Link Time Optimization (EXPERIMENTAL)"
> > +	depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD
> 
> I am curious, what is the reason for gating this at clang 11.0.0?
> 
> Presumably this? https://github.com/ClangBuiltLinux/linux/issues/510
> 
> It might be nice to notate this so that we do not have to wonder :)

Yes, that's the reason. I'll add a note about it. Thanks!

Sami
