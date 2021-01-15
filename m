Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F322F881B
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 23:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbhAOWEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 17:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhAOWEF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 17:04:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BBC061757;
        Fri, 15 Jan 2021 14:03:25 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z5so21018110iob.11;
        Fri, 15 Jan 2021 14:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tH8Dd34wEyfZ8To5q7YwlSddVn5ZC+wDT5td0wwyUuk=;
        b=dYvn+9zA8P3938yyld3jbcIUaxmBOhcHz64JaegN4ZtOxkFwFJiAK7+rcU1eKEHPdn
         ORGa5on80grzxAz8UG7eUjKuXOKbUvtdRnfqIYS6EWgYYsjT1HaZAOhXktZzti77b0+4
         s5ew8kSS/vmdtEMC85XSGSYgc7OWs4Uad5S8BHb+kU6hutLIsJ4Bd7lwCHNq9b8N7vbS
         X50kDtHThbWqhswHsqh5i1DNgZntvB5DwtcUfUexRDMlG9S1wQMtlfG/7s1pO4B7gGFO
         Cmt8U01g5UT6HYv3W8DOLCNL5V7j7dK9Fjgbc2ZO0uS+jgs0AgEQCYuUvpmPwBah6FTC
         xCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tH8Dd34wEyfZ8To5q7YwlSddVn5ZC+wDT5td0wwyUuk=;
        b=ZwMi68o9DlEPKIFSMF03IbUkB7ZiziqKnkuR4bBffRpk+KRr109hZRKWg1amSxKyUX
         BRnkIRpogy2M59XsDkjDu8ZKuTxuP3FwC+IBZGs7bN0Aohcz8M1DCMRGxktwzqKvRJCO
         x+5EoAsobPXfbxAps2BA4ySfMw2TxaFNY4T9tBzh6RRUGPx81rOP2kWQorRl56k9uZAN
         d89lSlYzDuQQF3Uy8eNRUqn6x8WfXwj/5yqQdmFRAB3CeacULJMbuWkB8h/54OjsOibh
         rfj23Ycnr7CJaHtmDE8mDuyQVDzEDTNWF7xJhbeZxy/KTucTHPyjCZLhY+ot/dj3EwyM
         H1Rw==
X-Gm-Message-State: AOAM5322IN/WpX0yIQAY3dlQSGYWXqGPM0oaIuls2UI7lkisPq91oIfU
        OQvYO7MFn+cgQbe7Snjffq/BSDr/M+R/WmPSG1c=
X-Google-Smtp-Source: ABdhPJz44cWsXYPea/ZZKcd88vD/2n0dS0mjhpWGfDguMnuAnasVTEECqFKeVHNGUB/QnrPwcNPIENzJZusFSvQNplI=
X-Received: by 2002:a02:b78e:: with SMTP id f14mr4458589jam.97.1610748204486;
 Fri, 15 Jan 2021 14:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-2-ndesaulniers@google.com> <20210115215958.3cqewpk7hycfr3hm@google.com>
In-Reply-To: <20210115215958.3cqewpk7hycfr3hm@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 23:03:13 +0100
Message-ID: <CA+icZUXjiNaHgYpBXB_DO76XznfqOG-rpH5i6NzhBx-gGoN=ZA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 15, 2021 at 11:00 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2021-01-15, Nick Desaulniers wrote:
> >From: Masahiro Yamada <masahiroy@kernel.org>
> >
> >The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
> >
> >You can see it at https://godbolt.org/z/6ed1oW
> >
> >  For gcc 4.5.3 pane,    line 37:    .value 0x4
> >  For clang 10.0.1 pane, line 117:   .short 4
> >
> >Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
> >version, this cc-option is unneeded.
> >
> >Note
> >----
> >
> >CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
> >
> >As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
> >
> >  ifdef CONFIG_DEBUG_INFO_DWARF4
> >  DEBUG_CFLAGS    += -gdwarf-4
> >  endif
> >
> >This flag is used when compiling *.c files.
> >
> >On the other hand, the assembler is always given -gdwarf-2.
> >
> >  KBUILD_AFLAGS   += -Wa,-gdwarf-2
> >
> >Hence, the debug info that comes from *.S files is always DWARF v2.
> >This is simply because GAS supported only -gdwarf-2 for a long time.
> >
> >Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
>
> The gas commit description has a typo. The supported options are -gdwarf-[345] or --gdwarf-[345].
> -gdwarf2 and --gdwarf2 are kept for compatibility.
>
> Looks good otherwise.
>

Good catch Fangrui.
Yesterday, I wondered - after a cut-n-paste from the patch's changelog
- why I did not see anything --dwarfX related in my logs.

- Sedat -

> >And, also we have Clang integrated assembler. So, the debug info
> >for *.S files might be improved if we want.
> >
> >In my understanding, the current code is intentional, not a bug.
> >
> >[1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
> >
> >Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> >Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >---
> > lib/Kconfig.debug | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >index 78361f0abe3a..dd7d8d35b2a5 100644
> >--- a/lib/Kconfig.debug
> >+++ b/lib/Kconfig.debug
> >@@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
> >
> > config DEBUG_INFO_DWARF4
> >       bool "Generate dwarf4 debuginfo"
> >-      depends on $(cc-option,-gdwarf-4)
> >       help
> >         Generate dwarf4 debug info. This requires recent versions
> >         of gcc and gdb. It makes the debug information larger.
> >--
> >2.30.0.284.gd98b1dd5eaa7-goog
> >
