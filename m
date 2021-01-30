Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E1B30941B
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jan 2021 11:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhA3KMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jan 2021 05:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhA3BxK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Jan 2021 20:53:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C79C964DA1;
        Sat, 30 Jan 2021 01:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611971545;
        bh=QD1brHT/zuOqCDivveiwXFVorG1yCZ8pm304EyrgY0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1JKUKDRjf5UBTHPYfc/X9l82lp25ebqm9xoQZMENT8ZUjLUHh1D1WFTJ705hZ5TM
         EnyS/G1rcEYn/8nKxB1U9qPTnsw9OZUfp4qDBf2NzoSeYm6ymmi7FdxWp/955b+AdJ
         0gKnEKEDa/hKUoBTRO4DzeE8I2l35EqeXMhJZhx2rld5E/3+EWPmN310hENeGoI6Dm
         bklzv0TJfPp/dA3hbv9rj4luy5EkwD0jx0ASf4O3Hp0F4FAOdSFCLntrFUUOvBvxWY
         lqgfCHzSY0wIOaMXWAQTFUYsev1zwTBBpPI7J7ZrWKxVS4iac2JU89pYtiXHCbXUgt
         DhdL6swAHCuLw==
Date:   Fri, 29 Jan 2021 18:52:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v7 1/2] Kbuild: make DWARF version a choice
Message-ID: <20210130015222.GC2709570@localhost>
References: <20210130004401.2528717-1-ndesaulniers@google.com>
 <20210130004401.2528717-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130004401.2528717-2-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 04:44:00PM -0800, Nick Desaulniers wrote:
> Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
> the default. Does so in a way that's forward compatible with existing
> configs, and makes adding future versions more straightforward.
> 
> GCC since ~4.8 has defaulted to this DWARF version implicitly.
> 
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

One comment below:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  Makefile          |  5 ++---
>  lib/Kconfig.debug | 16 +++++++++++-----
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 95ab9856f357..d2b4980807e0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
>  KBUILD_AFLAGS	+= -Wa,-gdwarf-2

It is probably worth a comment somewhere that assembly files will still
have DWARF v2.

>  endif
>  
> -ifdef CONFIG_DEBUG_INFO_DWARF4
> -DEBUG_CFLAGS	+= -gdwarf-4
> -endif
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
>  
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e906ea906cb7..94c1a7ed6306 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -256,13 +256,19 @@ config DEBUG_INFO_SPLIT
>  	  to know about the .dwo files and include them.
>  	  Incompatible with older versions of ccache.
>  
> +choice
> +	prompt "DWARF version"
> +	help
> +	  Which version of DWARF debug info to emit.
> +
>  config DEBUG_INFO_DWARF4
> -	bool "Generate dwarf4 debuginfo"
> +	bool "Generate DWARF Version 4 debuginfo"
>  	help
> -	  Generate dwarf4 debug info. This requires recent versions
> -	  of gcc and gdb. It makes the debug information larger.
> -	  But it significantly improves the success of resolving
> -	  variables in gdb on optimized code.
> +	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> +	  It makes the debug information larger, but it significantly
> +	  improves the success of resolving variables in gdb on optimized code.
> +
> +endchoice # "DWARF version"
>  
>  config DEBUG_INFO_BTF
>  	bool "Generate BTF typeinfo"
> -- 
> 2.30.0.365.g02bc693789-goog
> 
