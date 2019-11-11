Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E232CF79CB
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 18:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKKRXH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 12:23:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33747 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfKKRXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Nov 2019 12:23:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so11145986pfb.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2019 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yAajaC8HCWYzucX9F7lpdzKRK9O4DP5SS69z8MpuzC8=;
        b=X/LzmRNI+PAfGCx7iOXc7jITwTbPHloj6W9cE45iZE62pceyrxHDPEHiavfj9tEFm4
         3ssTDoHViE0PIaYRTxiES+N/vQ0V6XBCRSxJLkNHA5EmXVvGMUKq6TH0JVEbtbv7eJIs
         og7HVJoMSxXZSuRdEpfAiyzG2OcgsCx2ssepg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yAajaC8HCWYzucX9F7lpdzKRK9O4DP5SS69z8MpuzC8=;
        b=N+04ogKQMmkGcGcbU++4QTaHGIty675St793nL0EuOuOEu29z43mEPG6mNR/Zznyd7
         Mm6+7/VFbzUsUqv/6KbaglfV6vV1nr19b+LUdxCUPUSbiWNACIiaOhsDrRe+80tLKA4K
         UoL2dQLkV2VJYmdysoLXr9+Ak6gmTGJ0/mumtWeFnX5RDUcG/ZooWUMHye7K8Kx2kE5c
         ZfvrueSXnOpSYouoDSZApOgNojHNd1j7GHH+E9BB/l7HqiZS/3WuSuKOHskD4lJePiH7
         3upLWEfOzJiJLq3exmUQZzi1iLEn/FT3pq8MqZVinK1zlihyZLTF5tGG0S1VnB4AYgvE
         U2fg==
X-Gm-Message-State: APjAAAUa1unzaxyPqvgpeXLEuA20qFu6nbg71rjToBvOYJGMR3k2c7TJ
        kGbtgsvUhzaTB4SuUGkWrvtp8A==
X-Google-Smtp-Source: APXvYqyYRSzpwUPLuEiDxWQRl2mmu7HM3K81RSwKffyFA1Sp64Zbaq8qhH85VUnK4TNVxH3gOyo1gQ==
X-Received: by 2002:a17:90a:5d0e:: with SMTP id s14mr85161pji.55.1573492985697;
        Mon, 11 Nov 2019 09:23:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15sm22800000pgn.49.2019.11.11.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 09:23:04 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:23:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
Message-ID: <201911110922.17A2112B0@keescook>
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-12-keescook@chromium.org>
 <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 11, 2019 at 05:58:06PM +0100, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Fri, Oct 11, 2019 at 2:07 AM Kees Cook <keescook@chromium.org> wrote:
> > There's no reason to keep the RODATA macro: replace the callers with
> > the expected RO_DATA macro.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/alpha/kernel/vmlinux.lds.S      | 2 +-
> >  arch/ia64/kernel/vmlinux.lds.S       | 2 +-
> >  arch/microblaze/kernel/vmlinux.lds.S | 2 +-
> >  arch/mips/kernel/vmlinux.lds.S       | 2 +-
> >  arch/um/include/asm/common.lds.S     | 2 +-
> >  arch/xtensa/kernel/vmlinux.lds.S     | 2 +-
> >  include/asm-generic/vmlinux.lds.h    | 4 +---
> >  7 files changed, 7 insertions(+), 9 deletions(-)
> 
> Somehow you missed:
> 
>     arch/m68k/kernel/vmlinux-std.lds:  RODATA
>     arch/m68k/kernel/vmlinux-sun3.lds:      RODATA

Argh. I've sent a patch; sorry and thanks for catching this. For my own
cross-build testing, which defconfig targets will hit these two linker
scripts?

-Kees

> 
> Leading to build failures in next-20191111:
> 
>     /opt/cross/kisskb/gcc-4.6.3-nolibc/m68k-linux/bin/m68k-linux-ld:./arch/m68k/kernel/vmlinux.lds:29:
> syntax error
>     make[1]: *** [/kisskb/src/Makefile:1075: vmlinux] Error 1
> 
> Reported-by: noreply@ellerman.id.au
> http://kisskb.ellerman.id.au/kisskb/buildresult/14022846/
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Kees Cook
