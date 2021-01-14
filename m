Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697542F5B58
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jan 2021 08:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbhANHbO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jan 2021 02:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhANHbN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jan 2021 02:31:13 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF15AC061794;
        Wed, 13 Jan 2021 23:30:32 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y19so9409232iov.2;
        Wed, 13 Jan 2021 23:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uFtdlQoHIBqtlNN3COyOHRiq8y2N2thTqQM79nLyg/0=;
        b=DV/W7mAnjR7oWgN8iiPkfXBhmxlmhDE4a6qI4WV+fTHdADo5zsHN6xrTbk1OsJwv21
         xgvF26ySPIJhnmDutk8VHY2rKtS/A2yNS/mLtvmE/8iZx7ml7tSbvZgqXv4uJV0r1oXO
         wPVsoBUw4J0CFwE7smmaLLwIBcN4NKL7O8qjr8q3iSFvk4glUFeANSTwaHUL+8eGrp1N
         SrOBOBTfExdiSDcPsYRqwpfRObx7QLphPG+D1Ih1ILxfwASUX9kzNv7I5zZIYjg8EF2M
         KaqepY2UWviA1M7ohU3gNLkSnVt50FkXIbF1HncsBJzWK3CVgIecnTzjLC6Bs8sg31Ec
         WU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=uFtdlQoHIBqtlNN3COyOHRiq8y2N2thTqQM79nLyg/0=;
        b=peKQ72ernm+nrpQuvXD0jqc5eCAtRm92Ho1kwlVGlOlehGQ5Br/8TcTId6gWVWjYzi
         4F0UTOuIb7nzUQFuehHE30CHDe7esKGqQu+gzF/QaMhPbPoYRGJ3Yd7ODiUBuefKvLEQ
         Wy72SPOQl2XAyb6BrJEAKmBulKFRstmd61dYjXBzZbLuPTKbjcwgI/g4fnchba/MNOaH
         8BZfs7AaVZdDyS8Bb9Fc2HlemlXiRr/Yc5gB/9osverPcgvAirNzYMg7oj0T28GAUJGs
         xsRLb39vLgII6lrcoHya7Os20pYW+NtMZqgwupu/FDzXsM8JEk7wbp5AB1oIe5zv5Yof
         4e5Q==
X-Gm-Message-State: AOAM530iHygSF+SStup6OnatKBP/n2I/r7EkfPD1GU5+j8IOHt9D9Am9
        kj7GAwnn6Bjg5ihLKabwCX5ePEna7wx9U5rfxXM=
X-Google-Smtp-Source: ABdhPJwIB+yE5uV300sjxqqQQYxzKhkLtOSOq1GcI+hPYacLd7J3tyUzqGB804DeZgAHHD3EtrQq4GIpNP2ZS1ZW7AI=
X-Received: by 2002:a05:6638:48:: with SMTP id a8mr5367157jap.138.1610609432199;
 Wed, 13 Jan 2021 23:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20210113003235.716547-1-ndesaulniers@google.com>
 <20210113003235.716547-3-ndesaulniers@google.com> <CA+icZUV6pNP1AN_JEhqon6Hgk3Yfq0_VNghvRX0N9mw6pGtpVw@mail.gmail.com>
 <CAKwvOdm40Z3YutxwWyV922XdchN7Dz+v9kJNjF13vKxNUXrJnQ@mail.gmail.com> <CA+icZUWySPfGGswqEBZkCQ+OjogmMqzBvik3ddLHPWJ2w8EC3A@mail.gmail.com>
In-Reply-To: <CA+icZUWySPfGGswqEBZkCQ+OjogmMqzBvik3ddLHPWJ2w8EC3A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 08:30:21 +0100
Message-ID: <CA+icZUXcZiNqPC-k3TsNsLdXLJ6EQK5ZVwOOtQ+BqzYNNUzpcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Kbuild: make DWARF version a choice
To:     Nick Desaulniers <ndesaulniers@google.com>
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
        Nick Clifton <nickc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 14, 2021 at 8:20 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 12:27 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Sedat,
> > Thanks for testing, and congrats on https://lwn.net/Articles/839772/.
> > I always appreciate you taking the time to help test my work, and
> > other Clang+Linux kernel patches!
> >
>
> Hi Nick,
>
> cool, again in the top 15 :-).
>
> I should ask Mr. Corbet for a LWN subscription.
>
> > On Wed, Jan 13, 2021 at 1:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Wed, Jan 13, 2021 at 1:32 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -826,12 +826,16 @@ else
> > > >  DEBUG_CFLAGS   += -g
> > > >  endif
> > > >
> > > > -ifneq ($(LLVM_IAS),1)
> > > > -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > > +DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
> >
> > ^ DEBUG_CFLAGS are set for everyone (all toolchains) if
> > CONFIG_DEBUG_INFO is defined.
> >
> > > > +ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
> >
> > ^ "If not using dwarf 2 and LLVM_IAS=1", ie. CONFIG_DEBUG_INFO_DWARF5
> > && CONFIG_CC_IS_GCC
> >
>
> OK, I know DWARF v2 and LLVM_IAS=1 is broken.
>
> Looks like DWARF v5 with GCC v10.2.1 and binutils v2.35.1 is currently
> (here) no good choice.
>
> > > > +# Binutils 2.35+ required for -gdwarf-4+ support.
> > > > +dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> > > > +ifdef CONFIG_CC_IS_CLANG
> >
> > ^ "if clang"
> >
> > > > +DEBUG_CFLAGS   += $(dwarf-aflag)
> > > >  endif
> > >
> > > Why is that "ifdef CONFIG_CC_IS_CLANG"?
> >
> > That's what Arvind requested on v2, IIUC:
> > https://lore.kernel.org/lkml/X8psgMuL4jMjP%2FOy@rani.riverdale.lan/
> >
> > > When I use GCC v10.2.1 DEBUG_CFLAGS are not set.
> >
> > You should have -gdwarf-4 (and not -Wa,-gwarf-4) set for DEBUG_CFLAGS
> > when compiling with GCC and enabling CONFIG_DEBUG_INFO_DWARF4. Can you
> > please confirm? (Perhaps you may have accidentally disabled
> > CONFIG_DEBUG_INFO by rerunning `make defconfig`?)
> >
>
> $ egrep 'CC_IS_|LD_IS|BTF|DWARF'
> config-5.11.0-rc3-5-amd64-gcc10-llvm11 | grep ^CONFIG
> CONFIG_CC_IS_GCC=y
> CONFIG_LD_IS_LLD=y
> CONFIG_DEBUG_INFO_DWARF4=y
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y
>
> $ grep '\-Wa,-gdwarf-4' build-log_5.11.0-rc3-5-amd64-gcc10-llvm11.txt
> | wc -l
> 156

I wonder why I see GNU/as here (see above CONFIG_LD_IS_LLD=y)?

$ llvm-dwarfdump-11 vmlinux | head -20 | egrep
'debug_info|format|version|DW_AT_producer'
vmlinux:        file format elf64-x86-64
.debug_info contents:
0x00000000: Compile Unit: length = 0x0000001e, format = DWARF32,
version = 0x0004, abbr_offset = 0x0000, addr_size = 0x08 (next unit at
0x00000022)
             DW_AT_producer    ("GNU AS 2.35.1")
0x00000022: Compile Unit: length = 0x0000c1d2, format = DWARF32,
version = 0x0004, abbr_offset = 0x0012, addr_size = 0x08 (next unit at
0x0000c1f8)
             DW_AT_producer    ("GNU C89 10.2.1 20210110 -mno-sse
-mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387
-mno-fp-ret-in-387 -mpreferred-stack-boundary
=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel
-mindirect-branch=thunk-extern -mindirect-branch-register
-mrecord-mcount -mfentry -march=x86-64 -g -g
dwarf-4 -O2 -std=gnu90 -fno-strict-aliasing -fno-common -fshort-wchar
-fno-PIE -falign-jumps=1 -falign-loops=1
-fno-asynchronous-unwind-tables -fno-jump-tables -fno-de
lete-null-pointer-checks -fno-allow-store-data-races
-fstack-protector-strong -fno-strict-overflow -fstack-check=no
-fconserve-stack -fcf-protection=none -fno-stack-pr
otector")

Maybe, I should set all LLVM utils and linker manually, not using LLVM=1.

- Sedat -
