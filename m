Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A5F2F5B2E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jan 2021 08:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhANHVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jan 2021 02:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbhANHVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jan 2021 02:21:23 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739D0C061786;
        Wed, 13 Jan 2021 23:20:42 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id b19so6810864ioa.9;
        Wed, 13 Jan 2021 23:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=mxmch7rl4egTEBXYfPlF0zYnqi6xJdFXG+QKIy1/Y8I=;
        b=eIH3XcvZt5LZzmQYeTgR0kWfAXt/LyPrhvg/sY/HMekpk9NEEkQSL3CAn2UiEWe6n1
         CAvkqBec0A15ELhyuf683EMldYKzEPeZD3WHdEI0dYo0+O514JlkhvvBr9u0GlnqTjrP
         DPNoIPxN4wgzMYcNzr9kU0j0m66V+NYse/W/BQ2J3oKAY9OVg4iWaRe7LNMtGnpQAKdX
         S9VbCd8JyUgMQ+7Y/1LclPYy/FZX5x+dcp/4UgfV3cXjwJTYQClzmmbAysQhD1UwFDeX
         kYDc/yohyrqIP02FwPpuf+7Ex6XyPZQIplkHMbxk175ovUAx/GfKPcurlMptLWa9qn03
         UQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=mxmch7rl4egTEBXYfPlF0zYnqi6xJdFXG+QKIy1/Y8I=;
        b=LEaFFYcqeUdc1RHLKfgydjIzz3oI1krUCsPr4FyX8JK63OSIrRUrScK6t00ZAn9O4a
         zzGc890OvpTHclxP3JyxsCIeWgGBtE7J2bi+ReOEoNjL89+HYZlhKm4sTq6B5QvXLPog
         iFXRNmh+UTRxyTxF/vLmwIZwsyCfIC+Ks5maUflx4XQPHr52b+UZkQcP+qpuH1dKHEGE
         UQllT4rkO5Cte+UYjJxUIaAUP2xCod/gpPc4dTLPzy+IKKLS4RsM3WbrWMWTujp8EZ/i
         OriFSG0UOhwH3mzaujNvSu+IJKh5gji+TYEyEpDJTMTjaYfLDzmHqrbwtaDj8CZ5bLhi
         DylA==
X-Gm-Message-State: AOAM532fiWZny1BxQcC5U1FZzn8//ccyLGmq3Nrjv9xUW6zU11qjzBlX
        /OTMHHZhdn/Pqgy6Xgq6ChW1OcV023wxc5KY8tY=
X-Google-Smtp-Source: ABdhPJwJr/PgXCsU3O6sOg5x0hrwEzoAJf2Pyb2OVKXY96+1O/mjXdx4M47frYxpZTpd4kltOebUzKMElpHakqUmvqo=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr5442115jal.30.1610608841857;
 Wed, 13 Jan 2021 23:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20210113003235.716547-1-ndesaulniers@google.com>
 <20210113003235.716547-3-ndesaulniers@google.com> <CA+icZUV6pNP1AN_JEhqon6Hgk3Yfq0_VNghvRX0N9mw6pGtpVw@mail.gmail.com>
 <CAKwvOdm40Z3YutxwWyV922XdchN7Dz+v9kJNjF13vKxNUXrJnQ@mail.gmail.com>
In-Reply-To: <CAKwvOdm40Z3YutxwWyV922XdchN7Dz+v9kJNjF13vKxNUXrJnQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jan 2021 08:20:30 +0100
Message-ID: <CA+icZUWySPfGGswqEBZkCQ+OjogmMqzBvik3ddLHPWJ2w8EC3A@mail.gmail.com>
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

On Thu, Jan 14, 2021 at 12:27 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Sedat,
> Thanks for testing, and congrats on https://lwn.net/Articles/839772/.
> I always appreciate you taking the time to help test my work, and
> other Clang+Linux kernel patches!
>

Hi Nick,

cool, again in the top 15 :-).

I should ask Mr. Corbet for a LWN subscription.

> On Wed, Jan 13, 2021 at 1:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Wed, Jan 13, 2021 at 1:32 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -826,12 +826,16 @@ else
> > >  DEBUG_CFLAGS   += -g
> > >  endif
> > >
> > > -ifneq ($(LLVM_IAS),1)
> > > -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > > +DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)
>
> ^ DEBUG_CFLAGS are set for everyone (all toolchains) if
> CONFIG_DEBUG_INFO is defined.
>
> > > +ifneq ($(dwarf-version-y)$(LLVM_IAS),21)
>
> ^ "If not using dwarf 2 and LLVM_IAS=1", ie. CONFIG_DEBUG_INFO_DWARF5
> && CONFIG_CC_IS_GCC
>

OK, I know DWARF v2 and LLVM_IAS=1 is broken.

Looks like DWARF v5 with GCC v10.2.1 and binutils v2.35.1 is currently
(here) no good choice.

> > > +# Binutils 2.35+ required for -gdwarf-4+ support.
> > > +dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> > > +ifdef CONFIG_CC_IS_CLANG
>
> ^ "if clang"
>
> > > +DEBUG_CFLAGS   += $(dwarf-aflag)
> > >  endif
> >
> > Why is that "ifdef CONFIG_CC_IS_CLANG"?
>
> That's what Arvind requested on v2, IIUC:
> https://lore.kernel.org/lkml/X8psgMuL4jMjP%2FOy@rani.riverdale.lan/
>
> > When I use GCC v10.2.1 DEBUG_CFLAGS are not set.
>
> You should have -gdwarf-4 (and not -Wa,-gwarf-4) set for DEBUG_CFLAGS
> when compiling with GCC and enabling CONFIG_DEBUG_INFO_DWARF4. Can you
> please confirm? (Perhaps you may have accidentally disabled
> CONFIG_DEBUG_INFO by rerunning `make defconfig`?)
>

$ egrep 'CC_IS_|LD_IS|BTF|DWARF'
config-5.11.0-rc3-5-amd64-gcc10-llvm11 | grep ^CONFIG
CONFIG_CC_IS_GCC=y
CONFIG_LD_IS_LLD=y
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y

$ grep '\-Wa,-gdwarf-4' build-log_5.11.0-rc3-5-amd64-gcc10-llvm11.txt
| wc -l
156
