Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1BB2F89A5
	for <lists+linux-arch@lfdr.de>; Sat, 16 Jan 2021 00:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbhAOXzm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 18:55:42 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52332 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbhAOXzm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 18:55:42 -0500
X-Greylist: delayed 71991 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2021 18:55:41 EST
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 10FNskgH004013;
        Sat, 16 Jan 2021 08:54:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 10FNskgH004013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610754886;
        bh=0dGmFEa9ilYXRN0NxJbL4xcI2a0rn0KztsLjZt1VYKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gZHUbr4ftVVeKIwsv6M+WeWXvOH5j3BIKKBdzanVs6NqMkpxpFEX/nAY8pqug6Xux
         aOAotIohR6ZT5Fy6eznn3kdqsWWvgqNVlmv8HB+h0MxZy4QW8mlhX0Z+ntug0DPrXr
         m+fC03IlD9R1ctOq1QEEjIWgiSxMyt7MvZRde1x0DX3Pg5Qu03T7Z81f03svvu3lwJ
         3uHeO8Gy5/jlQZJmaOZsylKBUR7Cr6bzWRi6HokVuCi0IztNENkFoxEqWxQ7kawyf8
         ciiuotQa+kAf0ZkZPQIBPiwli4lkEIu9gJ4aNbE6DmT0SVKh/UcXPj9f7n/pEoYrZ8
         SYoSx+xvYVmcA==
X-Nifty-SrcIP: [209.85.214.182]
Received: by mail-pl1-f182.google.com with SMTP id be12so5518707plb.4;
        Fri, 15 Jan 2021 15:54:46 -0800 (PST)
X-Gm-Message-State: AOAM532IDN4KHHn95iUNExrVdEK4GMInqdwz8wciwUE5QVxvcRb2SWol
        1Nipr8/XjG7u71/UaOvknXaKvv07H55lR4AsGJw=
X-Google-Smtp-Source: ABdhPJz97JlhTBQ4YLi7K5Z06rqgj93A12Cu2ep9qdvYjAUNFWj4elbHFJHQaL4Gfj8L0bf6pF7ZYovdVswog9Kp6lM=
X-Received: by 2002:a17:90a:3481:: with SMTP id p1mr4363127pjb.198.1610754885822;
 Fri, 15 Jan 2021 15:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <20210115210616.404156-2-ndesaulniers@google.com> <CA+icZUVtodEz=E+TG0Pt_OUDgW5-0x2WzVOhzQDbyuVR1igU6Q@mail.gmail.com>
 <CAKwvOd==3r8HNe8P5SuoumRtQ3w7iZkGhhVNhAEyh=rSFDNtKw@mail.gmail.com>
In-Reply-To: <CAKwvOd==3r8HNe8P5SuoumRtQ3w7iZkGhhVNhAEyh=rSFDNtKw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 16 Jan 2021 08:54:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAAZ_LH_q8x9A7FwBy=kqMd8Z0rVm-wuC1QqxpgsnBQg@mail.gmail.com>
Message-ID: <CAK7LNATAAZ_LH_q8x9A7FwBy=kqMd8Z0rVm-wuC1QqxpgsnBQg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
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

On Sat, Jan 16, 2021 at 6:51 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jan 15, 2021 at 1:48 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > From: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.
> > >
> > > You can see it at https://godbolt.org/z/6ed1oW
> > >
> > >   For gcc 4.5.3 pane,    line 37:    .value 0x4
> > >   For clang 10.0.1 pane, line 117:   .short 4
> > >
> > > Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
> > > version, this cc-option is unneeded.
> > >
> > > Note
> > > ----
> > >
> > > CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.
> > >
> > > As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.
> > >
> > >   ifdef CONFIG_DEBUG_INFO_DWARF4
> > >   DEBUG_CFLAGS    += -gdwarf-4
> > >   endif
> > >
> > > This flag is used when compiling *.c files.
> > >
> > > On the other hand, the assembler is always given -gdwarf-2.
> > >
> > >   KBUILD_AFLAGS   += -Wa,-gdwarf-2
> > >
> > > Hence, the debug info that comes from *.S files is always DWARF v2.
> > > This is simply because GAS supported only -gdwarf-2 for a long time.
> > >
> > > Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
> > > And, also we have Clang integrated assembler. So, the debug info
> > > for *.S files might be improved if we want.
> > >
> > > In my understanding, the current code is intentional, not a bug.
> > >
> > > [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d
> > >
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Subject misses a "kbuild:" label like in all other patches.
> > You have:
> > "Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4"
>
> Ack, I wonder how that happened? Ah well, will fix in v6; thanks for
> the feedback.



I will apply this in my tree,
adding "kbuild:" and fixing the typo pointed out by Fangrui.

You do not need to resend this one.








> >
> > - Sedat -
> >
> > > ---
> > >  lib/Kconfig.debug | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 78361f0abe3a..dd7d8d35b2a5 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
> > >
> > >  config DEBUG_INFO_DWARF4
> > >         bool "Generate dwarf4 debuginfo"
> > > -       depends on $(cc-option,-gdwarf-4)
> > >         help
> > >           Generate dwarf4 debug info. This requires recent versions
> > >           of gcc and gdb. It makes the debug information larger.
> > > --
> > > 2.30.0.284.gd98b1dd5eaa7-goog
> > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards
Masahiro Yamada
