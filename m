Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316462F87F0
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbhAOVwG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhAOVwC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:52:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113F7C0613D3
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:51:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c22so6830218pgg.13
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDXCYaPPP0GIkxQ0+LDG4H4iGHCT3lB0lv11EmEvqJo=;
        b=aYNVZ9aKSBpd8Mj3qDl38GWChq0Ec/arFQZ2fyibRnqtvci54awJw4bKSPn83e0O+u
         diq+Q83kTaNzVQbuxf9IRHQwgX5p1vR6KFr65Yi9hjHKOMo+9oD0CR+AEdlYWasYnaYV
         3U8wZvAJFLgDkWrsByVsKP/VrszQuRDcKYY9V5NUXg2RrmlvAum7f67WLiTWP9nQpmrf
         G6yEKJusEODXTZjrgDL/HY2AACHiapX4rviYH0tInQxHWw6qLkKO38OwfAvUYS2blIF6
         /1rNSdy82Ty4hrC/Og+jxRHKkSqimI/xgcpG4GeflDzLPjpu6y97krH2SIztsjKMMp6L
         Sp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDXCYaPPP0GIkxQ0+LDG4H4iGHCT3lB0lv11EmEvqJo=;
        b=b3C8EzcxalPKoMqEuHxwsc1umBRldZZHPLaVSBU/k/idOTK0N6K62V00BtEp0zSgXz
         yaCBzbYssvqydWQcUP8hefxn7r4IWpwyOjNF8TNTOFAz8yKB1pYKmQ7lM9HNdwWGHv6S
         CCAxyaNB//RLmDNxXNQYnaQDxu3rY5cCvT2XEiwkZCE09RvuZ8dS7NjkcaIa79BTaXWz
         +HYzk1o2NOT6D6OMgcAFeOYqPFAVSDVhwKDst0vyHEIKZ8OJCIG2hUTbDdvGMq6Is5td
         joX6b3UFUf50b5tbmvgQ5ds4V2VXHvUB8g2O3xEZSG/ZbTfg4A3Hc5HBmQxJQ01pjsnv
         JNtw==
X-Gm-Message-State: AOAM530byulVEqP6vvS6KzDB0s1q7HfXCA6Dd+uBMvZk+RryDLsXJSmy
        3YwBJH0zm1ubm6Wl8jYoqTRH+4WfR39HV14c8L9/Hg==
X-Google-Smtp-Source: ABdhPJxZuanyAw4Z57+/EwtC8G2Fw9A0treLl50nhmo2Y2OQ+I8eff+axH/1uLMQvRgcTcNhiS9fIEkO02ZBmBDblUs=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr14843937pfy.15.1610747481454; Fri, 15
 Jan 2021 13:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-2-ndesaulniers@google.com> <CA+icZUVtodEz=E+TG0Pt_OUDgW5-0x2WzVOhzQDbyuVR1igU6Q@mail.gmail.com>
In-Reply-To: <CA+icZUVtodEz=E+TG0Pt_OUDgW5-0x2WzVOhzQDbyuVR1igU6Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jan 2021 13:51:10 -0800
Message-ID: <CAKwvOd==3r8HNe8P5SuoumRtQ3w7iZkGhhVNhAEyh=rSFDNtKw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
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

On Fri, Jan 15, 2021 at 1:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > From: Masahiro Yamada <masahiroy@kernel.org>
> >
> > The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
> >
> > You can see it at https://godbolt.org/z/6ed1oW
> >
> >   For gcc 4.5.3 pane,    line 37:    .value 0x4
> >   For clang 10.0.1 pane, line 117:   .short 4
> >
> > Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
> > version, this cc-option is unneeded.
> >
> > Note
> > ----
> >
> > CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
> >
> > As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
> >
> >   ifdef CONFIG_DEBUG_INFO_DWARF4
> >   DEBUG_CFLAGS    += -gdwarf-4
> >   endif
> >
> > This flag is used when compiling *.c files.
> >
> > On the other hand, the assembler is always given -gdwarf-2.
> >
> >   KBUILD_AFLAGS   += -Wa,-gdwarf-2
> >
> > Hence, the debug info that comes from *.S files is always DWARF v2.
> > This is simply because GAS supported only -gdwarf-2 for a long time.
> >
> > Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
> > And, also we have Clang integrated assembler. So, the debug info
> > for *.S files might be improved if we want.
> >
> > In my understanding, the current code is intentional, not a bug.
> >
> > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Subject misses a "kbuild:" label like in all other patches.
> You have:
> "Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4"

Ack, I wonder how that happened? Ah well, will fix in v6; thanks for
the feedback.

>
> - Sedat -
>
> > ---
> >  lib/Kconfig.debug | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 78361f0abe3a..dd7d8d35b2a5 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
> >
> >  config DEBUG_INFO_DWARF4
> >         bool "Generate dwarf4 debuginfo"
> > -       depends on $(cc-option,-gdwarf-4)
> >         help
> >           Generate dwarf4 debug info. This requires recent versions
> >           of gcc and gdb. It makes the debug information larger.
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >



-- 
Thanks,
~Nick Desaulniers
