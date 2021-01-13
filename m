Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D222F5170
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 18:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbhAMRwH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 12:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAMRwH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 12:52:07 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48491C061575;
        Wed, 13 Jan 2021 09:51:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id w79so2959562qkb.5;
        Wed, 13 Jan 2021 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=phNMVGOT8C1SF9CCO/PujkTaq0U+NXoha8y1/r4kCQY=;
        b=kT4D5XuLD2lvcKR+ovpDo4Eh/HtUuSJFKh0+5hJbBIgDVlSsh8/yMC2KAUTSNcsR6Q
         6Tqbi0+2IOrctM/0PBwx452S4rw9x9xtWxNNCP7MAv3gmv9yUWGyAchKgll6r39N6xaB
         JqXNbOOD8YgqId8PzKj0Ssfgto75YwbWZrAj4MaJ8WBpNe+ZTgu5s0cRMN0AfJ1Q3IZd
         NR+tPpRB/9qZy6iDrJyhoZv+qk6QNZT5+qeKaWEgySJbBRqICAs3TFAD08TrZ3VjW7pF
         p4xZnYJd3SWwwnv7o+ZaJVcBTvY3+SRCl0A2FLmysteyL1KiOyE/cPtJNJeFhcqA2uKD
         WLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=phNMVGOT8C1SF9CCO/PujkTaq0U+NXoha8y1/r4kCQY=;
        b=GlDFo0eD4+wI2btRmCzolsNk55EasZOucb+F8xAq1Houg/BbopzsZ2rA2zPgdMlWfR
         cZd/6i6NtQE68fMMZwcR9HHXg6KRJKinIGun+8+aKWpcwZaUQCTSOsxjt5x3EjT/0Whm
         HuCxHUlT/rycI1iX0SoWcx/mp4feMgOLL0uuZP4rkJ6ihVDAXcjCQtEZPfJBOq2GVspr
         iIzzwI5B0qH6IclSgZfCRrIUl80TkdZUbbdOEXnDOKsKH4JH7Y69ADtkqGvjEXBaiN+o
         y/GALryXbkxFDo4N1yst9e5A7bU13ZlQ9lupMqph47BV7YZGj8E0bBP6jRcb+lejKJDX
         YOXQ==
X-Gm-Message-State: AOAM533i00SYmkuI3ZkuVsCA6TJJwLQHSSIrGsm+EvAM1DgBkzhnCkkh
        nf9uoMWhLBAl+0D6n790/cM=
X-Google-Smtp-Source: ABdhPJxs33thgKGgieEbI1p2yYVwC5v03/TUhLo1O0DVEAGaAnGckUHh8P1SNcdLqKgSEvAqdPXsJw==
X-Received: by 2002:ae9:ef12:: with SMTP id d18mr3347716qkg.473.1610560286030;
        Wed, 13 Jan 2021 09:51:26 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id k7sm1340519qtg.65.2021.01.13.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:51:25 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:51:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>
Subject: Re: [PATCH v4 2/3] Kbuild: make DWARF version a choice
Message-ID: <20210113175123.GB4158893@ubuntu-m3-large-x86>
References: <20210113003235.716547-1-ndesaulniers@google.com>
 <20210113003235.716547-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113003235.716547-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 12, 2021 at 04:32:34PM -0800, Nick Desaulniers wrote:
> Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> way that's forward compatible with existing configs, and makes adding
> future versions more straightforward.
> 
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  Makefile          | 14 +++++++++-----
>  lib/Kconfig.debug | 21 ++++++++++++++++-----
>  2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d49c3f39ceb4..656fff17b331 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -826,12 +826,16 @@ else
>  DEBUG_CFLAGS	+= -g
>  endif
>  
> -ifneq ($(LLVM_IAS),1)
> -KBUILD_AFLAGS	+= -Wa,-gdwarf-2
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
> +ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
> +# Binutils 2.35+ required for -gdwarf-4+ support.
> +dwarf-aflag	:= $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> +ifdef CONFIG_CC_IS_CLANG
> +DEBUG_CFLAGS	+= $(dwarf-aflag)
>  endif
> -
> -ifdef CONFIG_DEBUG_INFO_DWARF4
> -DEBUG_CFLAGS	+= -gdwarf-4
> +KBUILD_AFLAGS	+= $(dwarf-aflag)
>  endif
>  
>  ifdef CONFIG_DEBUG_INFO_REDUCED
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index dd7d8d35b2a5..e80770fac4f0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -256,13 +256,24 @@ config DEBUG_INFO_SPLIT
>  	  to know about the .dwo files and include them.
>  	  Incompatible with older versions of ccache.
>  
> +choice
> +	prompt "DWARF version"
> +	help
> +	  Which version of DWARF debug info to emit.
> +
> +config DEBUG_INFO_DWARF2
> +	bool "Generate DWARF Version 2 debuginfo"
> +	help
> +	  Generate DWARF v2 debug info.
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
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
