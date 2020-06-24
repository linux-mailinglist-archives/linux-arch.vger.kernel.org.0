Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF1207E25
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbgFXVJy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388763AbgFXVJx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:09:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64BC0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:09:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x207so1804232pfc.5
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2jIkhYgexjs9KkwlPySDcA/4RhGGwlAKSrpoMnhGmk=;
        b=ulgAO6kyxk2umRKRWH6nMJnay5+JI9S+MN+66ac15rcJgmGZtAYk+H5+fPCQqHCN4n
         YwMVU0XBQEhTdVY5OHD749qpd8Pozz/SM+1Buf2jPE/xGsC+B8G3MYh7c8rCA848s7mL
         3wpkBMp2MTJmyiCiTEBPNG6vBbmHu+xghA1mKpCcjOJyJnqEFuFwGJ/pFH0IcAb5JQC+
         A2lLOE//kF+ciANNdx3Etcs1w4HXCok/pytM4pC9m2UbLu8T+ZNQiWPiX0fGAsI8+xBJ
         v8AHa7fV3npUoZ0xdjzOFVVo0SV0pKjAQOJojHM+9coxAbL/MqHPcTuHuRnLuuT3AK8g
         iPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2jIkhYgexjs9KkwlPySDcA/4RhGGwlAKSrpoMnhGmk=;
        b=NHZajoObPJ5a9AQXMTSlpaTTf/PkfxLYBv4h303Ugc6MxRAasi96ITj5QQNAEuF2O3
         o8p79VFvdQkyvj8jQ2vyy0T9Br4k2LcZXBfgp9WxqywffaRZ6a7+nIxDHQ//24SqSzzk
         2xCNJkymmWA3qtK9rU9lyFH1EOQIHFPuF8UVq0tYthmz7O8+WFLUK5jE5ptU0oEfMzbW
         L8IAOucakU6pXiWM/hRBGLzBGIpTKsWicuOgkYNqOOqpLxBf4GVFFJQvva5pp6B0LPc9
         B3qn6G/FWX/4i/DE8MGVZ7/33EjTA0GAKPFKow0wCSDVeeqdL9d2HHJ3PjLQY2CaDvWZ
         6vdQ==
X-Gm-Message-State: AOAM53007pm8Aw5PDhso2dNE3aWgYM1m/cYUElaA6RXKKosSDrByq5ec
        YzOifX8wYfjtWHmENiXsElxDjVtFNJBhzNtqYjTNyQ==
X-Google-Smtp-Source: ABdhPJyx7J+Crf2HbQKcuBNOiCwJq3seEefhf6EE+jeFP724rCfUEgtaO9Vi1jID9/eG3LhJZ3IQ+YfzgYs3IE2HM8s=
X-Received: by 2002:a63:5644:: with SMTP id g4mr22699481pgm.381.1593032992558;
 Wed, 24 Jun 2020 14:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com> <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
In-Reply-To: <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 14:09:40 -0700
Message-ID: <CAKwvOdm_EBfmV+GvDE-COoDwpEm9snea4_KtuFyorA5KEU6FbQ@mail.gmail.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 1:58 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Filter out CC_FLAGS_LTO for the vDSO.
>
> Just curious about this patch (and the following one for x86's vdso),
> do you happen to recall specifically what the issues with the vdso's
> are?

+ Andi (tangential, I actually have a bunch of tabs open with slides
from http://halobates.de/ right now)
58edae3aac9f2
67424d5a22124
$ git log -S DISABLE_LTO

>
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/kernel/vdso/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index 556d424c6f52..cfad4c296ca1 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -29,8 +29,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
> >  ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
> >  ccflags-y += -DDISABLE_BRANCH_PROFILING
> >
> > -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
> > -KBUILD_CFLAGS                  += $(DISABLE_LTO)
> > +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> > +                               $(CC_FLAGS_LTO)
> >  KASAN_SANITIZE                 := n
> >  UBSAN_SANITIZE                 := n
> >  OBJECT_FILES_NON_STANDARD      := y
> > --

-- 
Thanks,
~Nick Desaulniers
