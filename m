Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B772FDB0A
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 21:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbhATUmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 15:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389851AbhATUlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 15:41:09 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B7C0613C1;
        Wed, 20 Jan 2021 12:40:29 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z11so26675136qkj.7;
        Wed, 20 Jan 2021 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gxB8AfTLt5DLjXBLjHmtRDYzaevCzykdpksY10jMx9U=;
        b=kekq3VqXQxYIkqbirNrLu6M34nJp051Fn63E3Q9ACWhiSMvefiA4lpfdSAm18Thk6N
         wFaLJ/gCNfX6/zullYHERayj2qKWiHwDDJH3FbVeFCA0EjnkvdRuzvsFptrl+qLEHWI7
         e6kriNiAqbrbIyC/A9CF1n5GD6MUIuJhV2VsDxz58Dez3tWrmrup/9258gx7ZG+2q2Hi
         Hkstwc3qtmCd3T9/5BFVp+kpMMrH7KBBRkQtl7wczgWv27Q1SkcsIqf9tuH3vaLurmkU
         KxzGV5v9dzljKFkwzWsVTdvbdrraUnT8BZSFgBD8ovaAp9ocPGagL6ejdxPCFhCNP+2h
         mj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gxB8AfTLt5DLjXBLjHmtRDYzaevCzykdpksY10jMx9U=;
        b=JdhADgkshvteD8E1b/+DjwXUA+ImqGGV4Keb63/r1NKr85Yp8EgzJWhc3sasExCnos
         pdrckdk232SeL2UGjb9X6IgNC9c8qtju+iJ7HdEMaQ9QrQ4bORAWc9MuXhJBiRM0x0lB
         5rBfvsaWQcwp2wFxd7wABAUQ8woIRsrIVQc2ritktzRN22eNJh28mxKWUKHlNHGfst4s
         kj4C+TCPuoYfy+dRizrIdqP3K/lKgvm0yJ4QyNJwDuQQan/SG4AMYeahC+Qa12Kd+u05
         cOHM2WXHMBzXmnLJTECUltATjJMdEJf8NkG4n58vD8OGUb5IdsbJRnZ16BBqTQ2NS0LZ
         mFow==
X-Gm-Message-State: AOAM530KVdnuefiZ1B6/T9z1GaPKQhrp5Gfrks7foVA27Cdnt+PogxDD
        1eomD2JEucC/phs8vBVrwts=
X-Google-Smtp-Source: ABdhPJyZrzCkt1Qy4R36qlqDL/Q+eaDZg3xK79INAAJDMFm/HUAjJHF8eREKN7QVERPAS3YDkgA7Eg==
X-Received: by 2002:a05:620a:5aa:: with SMTP id q10mr2266894qkq.103.1611175228532;
        Wed, 20 Jan 2021 12:40:28 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id u63sm2151266qkc.115.2021.01.20.12.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:40:27 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:40:25 -0700
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
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 2/3] Kbuild: make DWARF version a choice
Message-ID: <20210120204025.GA548985@ubuntu-m3-large-x86>
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115210616.404156-3-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 01:06:15PM -0800, Nick Desaulniers wrote:
> Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> way that's forward compatible with existing configs, and makes adding
> future versions more straightforward.
> 
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Makefile          | 13 ++++++-------
>  lib/Kconfig.debug | 21 ++++++++++++++++-----
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d49c3f39ceb4..4eb3bf7ee974 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -826,13 +826,12 @@ else
>  DEBUG_CFLAGS	+= -g
>  endif
>  
> -ifneq ($(LLVM_IAS),1)
> -KBUILD_AFLAGS	+= -Wa,-gdwarf-2
> -endif

Aren't you regressing this with this patch? Why is the hunk from 3/3
that adds

ifdef CONFIG_CC_IS_CLANG
ifneq ($(LLVM_IAS),1)

not in this patch?

> -ifdef CONFIG_DEBUG_INFO_DWARF4
> -DEBUG_CFLAGS	+= -gdwarf-4
> -endif
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
> +# Binutils 2.35+ required for -gdwarf-4+ support.
> +dwarf-aflag	:= $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> +KBUILD_AFLAGS	+= $(dwarf-aflag)
>  
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
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
