Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94502F5496
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 22:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbhAMV0P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jan 2021 16:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbhAMVZA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jan 2021 16:25:00 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDD0C061575;
        Wed, 13 Jan 2021 13:24:11 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u17so7143621iow.1;
        Wed, 13 Jan 2021 13:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UpKWiYtPM8GQXk0Is548IYPtxVA4MVO0jtllMXNFedg=;
        b=jFEd2NzQHJicdAZJpSO86WQL6Pyz2KLdPuF8gwRjoQQgJKSKRe6pCzzGGUKWKcJYTE
         ifUpvBaRYrR6JiJCG55Hn9fCX3MmshplyXTqOEWaKP/8v1XMEaLmaOC7Lpd9DC2fG9c3
         EpM1Ct01OjUjbiQKE1fvog7ROEKzTXclee0JK56J4/D+3qy32gAQZ/MAorp7wfgw1HU5
         rPBnTryqXb7odcD54fVwqaoTocn80+gH5FIN537N4C/6f1VGo7mALSRqso3T7Xyeyqkr
         yV2sN3uwcOnqMZSaaRYstiIqEr705vf/gjaKF6kGk69a1dqoaaK4denn/0OitJ1lKtzc
         fhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UpKWiYtPM8GQXk0Is548IYPtxVA4MVO0jtllMXNFedg=;
        b=RlGBckSXjzSQ8uXMW4jOKDak3FAEHVo0ECNCFEu2+F0lMbmcvtAk2hEyoZxZL4UCvL
         3H0UmMnKMqaNBiRYTdJxK4JSzWyRN56e4GU/kSxmDKU6Qxsufj75BcTYs0GzZpPb7XLQ
         rmAPffnoaCuSKvuLg5ctCMAIoWTfzCwFShOPbQVDX/sT8bIGs8++lTSQffOzZROb4k/u
         7IUrL7hv3h5iJuFOJ0Ob3sdaXn5h9TzIKsCDUtr8LAVZrA06tMFZteNz5LUHIMBztGtG
         PAunoqmlxdd1W1kO+9UfYxfaLAORNu66Co5auvuRWIMYIcjHH+BOo7/dUznuEakTTb0U
         Tqxw==
X-Gm-Message-State: AOAM530x/OCAbeDQcz0o811xTFbNvWcVzARM6HTdgMuel886R7yGOTRG
        2h0bp4WgZ3+T+KbeCBh90SWdRJd+57gWT9licoib2i3jwvSQlQ==
X-Google-Smtp-Source: ABdhPJxpzXvUeRTDVlh68s3DvLQRddSvhHnzpvRehHrff3t/TZydCewnwIbSh5Lgu35UYmUNvALR+oyfjq3o7c0wSjY=
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr3977808ilj.209.1610573051220;
 Wed, 13 Jan 2021 13:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20210113003235.716547-1-ndesaulniers@google.com> <20210113003235.716547-3-ndesaulniers@google.com>
In-Reply-To: <20210113003235.716547-3-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 13 Jan 2021 22:24:00 +0100
Message-ID: <CA+icZUV6pNP1AN_JEhqon6Hgk3Yfq0_VNghvRX0N9mw6pGtpVw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Kbuild: make DWARF version a choice
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
        Nick Clifton <nickc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 13, 2021 at 1:32 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
> explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
> way that's forward compatible with existing configs, and makes adding
> future versions more straightforward.
>
> Suggested-by: Fangrui Song <maskray@google.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
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
>  DEBUG_CFLAGS   += -g
>  endif
>
> -ifneq ($(LLVM_IAS),1)
> -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> +DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> +ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
> +# Binutils 2.35+ required for -gdwarf-4+ support.
> +dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> +ifdef CONFIG_CC_IS_CLANG
> +DEBUG_CFLAGS   += $(dwarf-aflag)
>  endif

Why is that "ifdef CONFIG_CC_IS_CLANG"?
When I use GCC v10.2.1 DEBUG_CFLAGS are not set.

- Sedat -

> -
> -ifdef CONFIG_DEBUG_INFO_DWARF4
> -DEBUG_CFLAGS   += -gdwarf-4
> +KBUILD_AFLAGS  += $(dwarf-aflag)
>  endif
>
>  ifdef CONFIG_DEBUG_INFO_REDUCED
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
> +       help
> +         Which version of DWARF debug info to emit.
> +
> +config DEBUG_INFO_DWARF2
> +       bool "Generate DWARF Version 2 debuginfo"
> +       help
> +         Generate DWARF v2 debug info.
> +
>  config DEBUG_INFO_DWARF4
> -       bool "Generate dwarf4 debuginfo"
> +       bool "Generate DWARF Version 4 debuginfo"
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
