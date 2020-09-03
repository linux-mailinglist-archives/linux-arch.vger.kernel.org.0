Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3725CD2B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 00:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgICWJD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 18:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgICWJC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 18:09:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F47C061245
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 15:09:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so3219545pgl.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1TFkAeGi9KR3Vg+6dLLM1QKXoNn5coQYzJIjZ0tVjI0=;
        b=RMbQl2aWLhRmRg/xlWTquty6EAETDxVrOPrJsvxj3D3ziQggwm1LR9Z+7lvF/RBSAh
         rdDSpm9JIeEpDa886F9HHLV4dstrmldnU0gSRqvqiZwoQrPW2lTBh5oU/X/4TrS8pCra
         DV/jID9deoswwRtNn+Jy77/ci1g1OxqByrPxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1TFkAeGi9KR3Vg+6dLLM1QKXoNn5coQYzJIjZ0tVjI0=;
        b=HMGmXDIoLglnnKaNSNNPr2F82Bf8zf1a7HpSkSKHNiItU0116hfZMHJFWNzQ6CEcsH
         j/txS0oMT8+xiNKqdVy7tdkRbW4NXAdGjF2XMGHGofdNN+vEPVL/Y9v43XRJyIJJAGzK
         RXxgEYf0m8CoIE9YuXqlM/3JSlxrkoZeHnAm72SqIrm3bDPQvaE2Uegm/F8A21PR8hAW
         WDza4rRtgBGwZ8tyeXVEYRAYy1MlBUa0+5GzXYFB7+RD8Sy7wBv//glS5sbow0LY1RzB
         LBWeIk5NTRYDRo0G8ALTkD8ay0xnzLcTmd8X8UdW8hzjasRNWnpSfGRrk+UN1Kf1i1XF
         pDFA==
X-Gm-Message-State: AOAM5301HSs8uJL0QmnzcpmcbnuUk71TeTlq8AtU374qPk+edDwXKQqF
        ymTWJKqJjiS/b6Zz+T0myatv5g==
X-Google-Smtp-Source: ABdhPJxtv6qZk8AFQNSEBhXOHhLxWmSvOpKmtDAl4TWDKr3eiSBk8TPdIQLGddmagxPcGUhPAwGmGg==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr5953492pfp.6.1599170941115;
        Thu, 03 Sep 2020 15:09:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t11sm4160655pfe.165.2020.09.03.15.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:09:00 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:08:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 09/28] kbuild: add support for Clang LTO
Message-ID: <202009031504.07098D6F8@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-10-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:34PM -0700, Sami Tolvanen wrote:
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

I remain crazy excited about being able to use this in upstream. :)

The only suggestion I have here, if it might help with clarity, would be
to remove DISABLE_LTO globally as a separate patch, since it's entirely
unused in the kernel right now. This series removes it as it goes, which
I think is fine, but it might cause some reviewers to ponder "what's
this DISABLE_LTO thing? Don't we need that?" without realizing currently
unused in the kernel.

I'm glad to see the general CONFIG_LTO, as I think it should be easy for
GCC LTO support to get added when someone steps up to do it. The bulk of
the changed needed to support GCC LTO are part of this series already,
since the build problems involving non-ELF .o files and init ordering
are shared by Clang and GCC AFAICT.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
