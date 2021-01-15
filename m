Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD92F87D2
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAOVnR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbhAOVnQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:43:16 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8CBC061757;
        Fri, 15 Jan 2021 13:42:35 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q1so20955069ion.8;
        Fri, 15 Jan 2021 13:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KrJ2mYVoEchRR2uOsqZY+9xKiUZ8oXU02si2kBeet+s=;
        b=JddejzpwdZ+xHh+Mu9RkK/LncpeptkmDLu/UhOCGBNd5pr6p2Ka1IEKDNU2wde8KSj
         g4mys6dnDhYHQwP34ksbSNZzIYF2JxS6mtZMF86hZT3Q1dey77VhUQ+qxG5yHRUZhMIZ
         MYHEUUQnbBy/xJ80XZ/viXhoCwgcZQ/CBRfwivFuqozf3F3oHzUE8/ZLsBRp8CPQ1vLn
         v3XzJaYelgHvB7Psyw471Fv9JsuXJmdq9ESvByAmNZ95b+kxL+5ZBQBNlwO5mBHXZ3Vf
         SV6thLVL9qGJm217fFsPJqDUZHC+vzrzFdUOAHPrWz5A1YdkjkADwMkyq3R4eIo4mUHr
         3MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KrJ2mYVoEchRR2uOsqZY+9xKiUZ8oXU02si2kBeet+s=;
        b=r+LLHSojJ6+KXNwcpgZBDvEflfQGDehWf0Rj8V9hHdUV4wRJZTmZ3UUK4K8sjHNt5l
         DhIh7Zayx8da+d2ICT1tEaOGpKLlnalWrzUwOxudkkWuhdkgN11nem6OBzVOzdKoN+2o
         OBJluceSvxMonoDxroVzfqxYGhx8caU3/zT1F3UJsJOqbtugFFZTRedRRKmmAAzSbIER
         bJR4Z5XWix0eddktkLU3oO8Ab1ed5bVrI4FL8epV/TQ3w/SrGGXB+gIKjsQoBwsU4wCh
         fTrT04dgIBX4wkrv2gDm+xhZW0TVPtJhqZIt/F5ptoC4XpudvbourFE6/7pQSgxKAYdS
         VsgA==
X-Gm-Message-State: AOAM533eRxnEnMbNcYImzpUr7qOJHOOs2b62EjbzZEqL8ETcCC6beltD
        fsDnIF1lZa8hp7/Xx+HHAcDbbi81GknNVufHvSS7W6MdrNatMA==
X-Google-Smtp-Source: ABdhPJznYYOZiD/MY7wFS6nPFmr+C64FWP+vZvQAeSJT4Yf+ZPZpNH+hV5+GyakXc/VPMUlgrkfCciqcIWUvSyqM0OA=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr11926529jal.30.1610746955254;
 Fri, 15 Jan 2021 13:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com> <20210115210616.404156-3-ndesaulniers@google.com>
In-Reply-To: <20210115210616.404156-3-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 22:42:23 +0100
Message-ID: <CA+icZUXYFdrHQYkM6J5WajaP6zCBHB2gEnDt6p1W6gRsTk__Zg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Kbuild: make DWARF version a choice
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
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
>  DEBUG_CFLAGS   += -g
>  endif
>
> -ifneq ($(LLVM_IAS),1)
> -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> -endif
> -
> -ifdef CONFIG_DEBUG_INFO_DWARF4
> -DEBUG_CFLAGS   += -gdwarf-4
> -endif
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> +# Binutils 2.35+ required for -gdwarf-4+ support.
> +dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> +KBUILD_AFLAGS  += $(dwarf-aflag)
>
>  ifdef CONFIG_DEBUG_INFO_REDUCED
>  DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index dd7d8d35b2a5..e80770fac4f0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -256,13 +256,24 @@ config DEBUG_INFO_SPLIT
>           to know about the .dwo files and include them.
>           Incompatible with older versions of ccache.
>
> +choice
> +       prompt "DWARF version"

Here you use "DWARF version" so keep this for v2 and v4.

> +       help
> +         Which version of DWARF debug info to emit.
> +
> +config DEBUG_INFO_DWARF2
> +       bool "Generate DWARF Version 2 debuginfo"

s/DWARF Version/DWARF version

> +       help
> +         Generate DWARF v2 debug info.
> +
>  config DEBUG_INFO_DWARF4
> -       bool "Generate dwarf4 debuginfo"
> +       bool "Generate DWARF Version 4 debuginfo"

Same here: s/DWARF Version/DWARF version

- Sedat -

>         help
> -         Generate dwarf4 debug info. This requires recent versions
> -         of gcc and gdb. It makes the debug information larger.
> -         But it significantly improves the success of resolving
> -         variables in gdb on optimized code.
> +         Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
> +         It makes the debug information larger, but it significantly
> +         improves the success of resolving variables in gdb on optimized code.
> +
> +endchoice # "DWARF version"
>
>  config DEBUG_INFO_BTF
>         bool "Generate BTF typeinfo"
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
