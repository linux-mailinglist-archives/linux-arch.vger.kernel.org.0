Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD92F87E1
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbhAOVsk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbhAOVsk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:48:40 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E7C061757;
        Fri, 15 Jan 2021 13:48:00 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n2so3845896iom.7;
        Fri, 15 Jan 2021 13:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=zYYFMiVWZRWVRKnudyq1lNHacc6UniMAU/JKqtSTWp8=;
        b=i8x4NwEnmjRo6MH0hWEVsP7+ZKONZUSwlLn54xMqjtGHQfwel5ZXpK3x/1MPu6dpem
         kVN5lmRw4o1dYyhNQY1Rmyn9dkVHy9P8ZpmGDjUJHac7cLnmdxicPB7g4DogBPCV4eRh
         9YzIIrYoXnMBJ3sjgtAGi4uMCoeZgVI/vKjiZZMil13wQ7w9tIrGkm3IBtERIFNsQqp6
         mFH1vuG3g3loN3IYZwQFQDM5tDBiTs9a8Tdc/zJ4sd4EJwusXFBTLEJ8Ayc8Cv4YkQCb
         Nbnyhz63r52s+NENwuFkCKjhE25T6ZYwrt4k0D7ZBJCGlhxLM14lHf2+Slm9JbwgGj6w
         zCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=zYYFMiVWZRWVRKnudyq1lNHacc6UniMAU/JKqtSTWp8=;
        b=EC/4Gw3+d9TmYf1jVSY6EU9TYwmmu2HfH/7yzWF4xnsZOML3s+lDfA43sUVsTRgPf1
         GUHD60qrJ6eR+jIl0aXZedLEJJXx5oxkwuQrEFtjPueXnK9sA5Ub79ZGMmmZhnmI4rWn
         +qphr31owZooiY+5AMQ/PdsoIFGjNcRcGqY3gyfAfUg+tJAoF6JEYbf49kfStg68cV0l
         vApHIihb9s95uuPKJ8vR1LuLlSe8YmXXzaM+dUjA12CpazX1W9sXOOm2s2Oqxrc6UhoU
         PvyUFAo0rtMAn9bLXZz/5XJPjv+lG7Rkb+kaN8EvKplBuwrmPYYwZldg4a7l9QOAue4G
         XUSQ==
X-Gm-Message-State: AOAM533ReEbYRZuteDQAatEprdDjgcOJuJIebGNilyekEtRxDjPDtomA
        GxgqU3GTOjRhDY3hahCK6HXPNN1qqnJpq16GWtY511+BP+CjLw==
X-Google-Smtp-Source: ABdhPJyUU9Aew3LmTFjd14W1jH2MDrUSQxqDQD1HVZWyRzOK3290bbFCxMbDzWATQmCdgee5qKt3uEhzB+auCdfhWW8=
X-Received: by 2002:a92:c692:: with SMTP id o18mr12747830ilg.215.1610747279317;
 Fri, 15 Jan 2021 13:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com> <20210115210616.404156-2-ndesaulniers@google.com>
In-Reply-To: <20210115210616.404156-2-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 22:47:48 +0100
Message-ID: <CA+icZUVtodEz=E+TG0Pt_OUDgW5-0x2WzVOhzQDbyuVR1igU6Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
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
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> From: Masahiro Yamada <masahiroy@kernel.org>
>
> The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
>
> You can see it at https://godbolt.org/z/6ed1oW
>
>   For gcc 4.5.3 pane,    line 37:    .value 0x4
>   For clang 10.0.1 pane, line 117:   .short 4
>
> Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
> version, this cc-option is unneeded.
>
> Note
> ----
>
> CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
>
> As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
>
>   ifdef CONFIG_DEBUG_INFO_DWARF4
>   DEBUG_CFLAGS    += -gdwarf-4
>   endif
>
> This flag is used when compiling *.c files.
>
> On the other hand, the assembler is always given -gdwarf-2.
>
>   KBUILD_AFLAGS   += -Wa,-gdwarf-2
>
> Hence, the debug info that comes from *.S files is always DWARF v2.
> This is simply because GAS supported only -gdwarf-2 for a long time.
>
> Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
> And, also we have Clang integrated assembler. So, the debug info
> for *.S files might be improved if we want.
>
> In my understanding, the current code is intentional, not a bug.
>
> [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Subject misses a "kbuild:" label like in all other patches.
You have:
"Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4"

- Sedat -

> ---
>  lib/Kconfig.debug | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 78361f0abe3a..dd7d8d35b2a5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
>
>  config DEBUG_INFO_DWARF4
>         bool "Generate dwarf4 debuginfo"
> -       depends on $(cc-option,-gdwarf-4)
>         help
>           Generate dwarf4 debug info. This requires recent versions
>           of gcc and gdb. It makes the debug information larger.
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
