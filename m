Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C50128EC74
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 06:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgJOExv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 00:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgJOExv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Oct 2020 00:53:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75696C0613D2
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 21:53:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d23so927194pll.7
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnT7VxOT22lB70S274n8jv3DY8IooahSVVXzJOT5Npo=;
        b=ErrZa3fPnuCZhR9OKjBG0KwI9Dy24n9g1z/rXD+KQJT6GVNwvzKJ/zcljR37vCMyqU
         udTVtqjX0T9o8HnDCwYanc81u4uNT5ni0xwqQU4VGEYbfroj6bLhLGL5ONCbioSV9MwN
         IzEQoyGCYEVxE0XCOgEdc3CYSRrS+uuPeJSLcY2v5oxUUe/+/jukunvhp9/MDwy4gWwv
         uSeqpZwdbnL67KJIqUBykeqKpL3c9ctQ8IUzN9bKSequgA7hJmBeobS4QeukTr29Ee4o
         ZiLMZqMQ0pmJSgTL0sMu34/4S7XhdEv6u/W7M1FDkmSs3akxSPuVSNGxNqqvVLYsAN4J
         DqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnT7VxOT22lB70S274n8jv3DY8IooahSVVXzJOT5Npo=;
        b=gc6DtczSzV3SoVSIs4ZuOsDzztVTJS449cDbHMoG4lz2kBSxUkt83OfcFR8lKStXbF
         tq2ISd4nHQTNGfwxqx1tx7+iUKGwGOCMEOlEyt7BIedhV9Ol3I/8d0lscSZdLMa5fADu
         /jbKizHSKNIVUwBngQ49F1lolabUkZdehID7I3puLQhIB42PKk6AkaBh8u4o0ffrjwwR
         qZywg/1e+gNDMLR+aMCd0vyxVnI0wWiRQAyLcS9RZeqqPwESdhh0oCP4WQfQ9wkY/2vW
         yfrVWnqSudfI6vPIS1M+TUH8Ao9DeuO1otKX9/KNzCizwXKO7Lqgs3S8yUeFOc5VHwVL
         Az9Q==
X-Gm-Message-State: AOAM533luJ/rgCsWpcTbkLesB1WqV2dnA5O5fCFuJ/ymL3E4fPnOTjhn
        SspkyOubH5Xo6Gopu+y+/dsKxbKzdF5SWwcdiy1N0w==
X-Google-Smtp-Source: ABdhPJyY9a0giGK+FW30vhQv1gy/nWuAfpUG4NgMwHxz1j3magMSXSe1Cvfc7EDaUkMYxwdgCJlw14xz0QZShNEivgk=
X-Received: by 2002:a17:90a:8002:: with SMTP id b2mr2638763pjn.47.1602737630777;
 Wed, 14 Oct 2020 21:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201005025720.2599682-1-keescook@chromium.org> <202010141603.49EA0CE@keescook>
In-Reply-To: <202010141603.49EA0CE@keescook>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Wed, 14 Oct 2020 21:53:39 -0700
Message-ID: <CAFP8O3LvTkqUK3rp9Q17fmyN+xApZXA8Cs=MNvxrZ3SDCDRX3A@mail.gmail.com>
Subject: Re: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 4:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Oct 04, 2020 at 07:57:20PM -0700, Kees Cook wrote:
> > Under some circumstances, the compiler generates .ctors.* sections. This
> > is seen doing a cross compile of x86_64 from a powerpc64el host:
> >
> > x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/trace_clock.o' being
> > placed in section `.ctors.65435'
> > x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ftrace.o' being
> > placed in section `.ctors.65435'
> > x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ring_buffer.o' being
> > placed in section `.ctors.65435'
> >
> > Include these orphans along with the regular .ctors section.
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Ping -- please take this for tip/urgent, otherwise we're drowning sfr in
> warnings. :)
>
> -Kees
>
> > ---
> > v2: brown paper bag version: fix whitespace for proper backslash alignment
> > ---
> >  include/asm-generic/vmlinux.lds.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 5430febd34be..b83c00c63997 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -684,6 +684,7 @@
> >  #ifdef CONFIG_CONSTRUCTORS
> >  #define KERNEL_CTORS()       . = ALIGN(8);                      \
> >                       __ctors_start = .;                 \
> > +                     KEEP(*(SORT(.ctors.*)))            \
> >                       KEEP(*(.ctors))                    \
> >                       KEEP(*(SORT(.init_array.*)))       \
> >                       KEEP(*(.init_array))               \
> > --
> > 2.25.1
> >
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202010141603.49EA0CE%40keescook.

I think it would be great to figure out why these .ctors.* .dtors.*
are generated.
~GCC 4.7 switched to default to .init_array/.fini_array if libc
supports it. I have some refactoring in this area of Clang as well
(e.g. https://reviews.llvm.org/D71393)

And I am not sure SORT(.init_array.*) or SORT(.ctors.*) will work. The
correct construct is SORT_BY_INIT_PRIORITY(.init_array.*)
