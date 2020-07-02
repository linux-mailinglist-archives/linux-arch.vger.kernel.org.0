Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388F62128CB
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgGBP5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGBP5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 11:57:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9CC08C5DD
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 08:57:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w19so791058ply.9
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YgPSxrVcL5/+2trP8Y9tIB9bY9o4biAaserhf1XxerA=;
        b=jwLT0yOQjefPIZKemT4Q0cOJnhCjiUutFEeWs95700So98cfaPXpUxHm5TElQ8vHOG
         /zINNII93zXuYoMVbpavK0k++wloLCRYyGkhPw6KK96Wq5F5orsUyCmwVPvsTyV+AEWt
         JDDNEq+AdCjIHkN6niTjXvjyepdtZbk/3bhac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YgPSxrVcL5/+2trP8Y9tIB9bY9o4biAaserhf1XxerA=;
        b=DtOuNl8X+oxAttmvF5l+MRfLyNShia2Knwrniyq1DMBn8HUjIRZMB7guGs4qKIjWjj
         6NGrmWJaEYa3X9jF8f5h3bjWlNHKU8NQfuLaew+xlQdMWCHULI8Co3c5hGvVZJq8RQ/T
         oP4825OcUWpBwAdEXo4T2r21BoSMwQJTnPZicYXv3FWVDdwO5NgD3PEaGC6HJYqJLa0c
         dm1ixM2S0Vt+X+Fyc2Y7yGqx2InCcJ+bcqjssKmNBOW49W9YKIDzyapx8sUgIAejTqLy
         AyCU2Fo9p6Kigu8YkRsVutpZENnuOXA6eAXduqQsST0+g+RSLEVRjkVdeKtwbt75uRXS
         zg5A==
X-Gm-Message-State: AOAM533o6/7VWeZicjHg5sa4UEeSdHYRX3mPkXSP72URx7L4PMyuyWr/
        mI18AsR89vPsvZmeMjnsNBAlwQ==
X-Google-Smtp-Source: ABdhPJxInVGBJIUxROAK9085rrHggVy8LJffKTA+HKKkF+e8eGq3dMOWeKJxsX7poAadOvz7DKID1Q==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr27320510plt.3.1593705457169;
        Thu, 02 Jul 2020 08:57:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k100sm8517452pjb.57.2020.07.02.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:57:36 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:57:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] vmlinux.lds: add PGO and AutoFDO input sections
Message-ID: <202007020856.78DDE23F4A@keescook>
References: <20200622231536.7jcshis5mdn3vr54@google.com>
 <20200625184752.73095-1-ndesaulniers@google.com>
 <CAKwvOd=cum+BNHOk2djXx5JtAcCBwq2Bxy=j5ucRd2RcLWwDZQ@mail.gmail.com>
 <CAK8P3a1mBCC=hBMzxZVukHhrWhv=LiPOfV6Mgnw1QpNg=MpONg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1mBCC=hBMzxZVukHhrWhv=LiPOfV6Mgnw1QpNg=MpONg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 02, 2020 at 10:19:40AM +0200, Arnd Bergmann wrote:
> On Wed, Jul 1, 2020 at 11:54 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > Hi Arnd,
> > I usually wait longer to bump threads for review, but we have a
> > holiday in the US so we're off tomorrow and Friday.
> > scripts/get_maintainer.pl recommend you for this patch.  Would you
> > take a look at it for us, please?
> 
> Hi Nick
> 
> While I'm listed as the maintainer for include/asm-generic, linker scripts
> are really not my expertise and I have no way of knowing whether the
> change is good or not.
> 
> Your description looks very reasonable of course and I have no problem
> with having someone else pick it up. You mentioned that Kees is already
> looking at some related work and he's already done more changes to
> this file than anyone else. If he can provide an Ack for this patch,
> you can add mine as well to send it to akpm, or I can pick it up in the
> asm-generic tree.

This looks good to me. Do you want me to carry it as part of the orphan
series? (It doesn't look like it'll collide, so that's not needed, but I
can if that makes things easier.)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
>        Arnd
> 
> > On Thu, Jun 25, 2020 at 11:48 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Basically, consider .text.{hot|unlikely|unknown}.* part of .text, too.
> > >
> > > When compiling with profiling information (collected via PGO
> > > instrumentations or AutoFDO sampling), Clang will separate code into
> > > .text.hot, .text.unlikely, or .text.unknown sections based on profiling
> > > information. After D79600 (clang-11), these sections will have a
> > > trailing `.` suffix, ie.  .text.hot., .text.unlikely., .text.unknown..
> > >
> > > When using -ffunction-sections together with profiling infomation,
> > > either explicitly (FGKASLR) or implicitly (LTO), code may be placed in
> > > sections following the convention:
> > > .text.hot.<foo>, .text.unlikely.<bar>, .text.unknown.<baz>
> > > where <foo>, <bar>, and <baz> are functions.  (This produces one section
> > > per function; we generally try to merge these all back via linker script
> > > so that we don't have 50k sections).
> > >
> > > For the above cases, we need to teach our linker scripts that such
> > > sections might exist and that we'd explicitly like them grouped
> > > together, otherwise we can wind up with code outside of the
> > > _stext/_etext boundaries that might not be mapped properly for some
> > > architectures, resulting in boot failures.
> > >
> > > If the linker script is not told about possible input sections, then
> > > where the section is placed as output is a heuristic-laiden mess that's
> > > non-portable between linkers (ie. BFD and LLD), and has resulted in many
> > > hard to debug bugs.  Kees Cook is working on cleaning this up by adding
> > > --orphan-handling=warn linker flag used in ARCH=powerpc to additional
> > > architectures. In the case of linker scripts, borrowing from the Zen of
> > > Python: explicit is better than implicit.
> > >
> > > Also, ld.bfd's internal linker script considers .text.hot AND
> > > .text.hot.* to be part of .text, as well as .text.unlikely and
> > > .text.unlikely.*. I didn't see support for .text.unknown.*, and didn't
> > > see Clang producing such code in our kernel builds, but I see code in
> > > LLVM that can produce such section names if profiling information is
> > > missing. That may point to a larger issue with generating or collecting
> > > profiles, but I would much rather be safe and explicit than have to
> > > debug yet another issue related to orphan section placement.
> > >
> > > Cc: stable@vger.kernel.org
> > > Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=add44f8d5c5c05e08b11e033127a744d61c26aee
> > > Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1de778ed23ce7492c523d5850c6c6dbb34152655
> > > Link: https://reviews.llvm.org/D79600
> > > Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1084760
> > > Reported-by: Jian Cai <jiancai@google.com>
> > > Debugged-by: Luis Lozano <llozano@google.com>
> > > Suggested-by: Fāng-ruì Sòng <maskray@google.com>
> > > Tested-by: Luis Lozano <llozano@google.com>
> > > Tested-by: Manoj Gupta <manojgupta@google.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > > Changes V1 -> V2:
> > > * Add .text.unknown.*.  It's not strictly necessary for us yet, but I
> > >   really worry that it could become a problem for us. Either way, I'm
> > >   happy to drop for a V3, but I'm suggesting we not.
> > > * Beef up commit message.
> > > * Drop references to LLD; the LLVM change had nothing to do with LLD.
> > >   I've realized I have a Pavlovian-response to changes from Fāng-ruì
> > >   that I associate with LLD.  I'm seeking professional help for my
> > >   ailment. Forgive me.
> > > * Add link to now public CrOS bug.
> > >
> > >  include/asm-generic/vmlinux.lds.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > index d7c7c7f36c4a..245c1af4c057 100644
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -560,7 +560,10 @@
> > >   */
> > >  #define TEXT_TEXT                                                      \
> > >                 ALIGN_FUNCTION();                                       \
> > > -               *(.text.hot TEXT_MAIN .text.fixup .text.unlikely)       \
> > > +               *(.text.hot .text.hot.*)                                \
> > > +               *(TEXT_MAIN .text.fixup)                                \
> > > +               *(.text.unlikely .text.unlikely.*)                      \
> > > +               *(.text.unknown .text.unknown.*)                        \
> > >                 NOINSTR_TEXT                                            \
> > >                 *(.text..refcount)                                      \
> > >                 *(.ref.text)                                            \
> > > --
> > > 2.27.0.111.gc72c7da667-goog
> > >

-- 
Kees Cook
