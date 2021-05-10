Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC11C378F35
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhEJNj7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 09:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352184AbhEJNOI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 May 2021 09:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012C56128D;
        Mon, 10 May 2021 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620652384;
        bh=PSzgBT970qRtHokrpRLHj29TDKDvchKrZWRzijLqSCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MUrtxCT/+rGukywuzRkfaC1xwjapGbNy2+3e8bzZ3aQ0cOAmyYUq3azbb6IhtO0Nw
         p5XyHu4VOgBYEa957EVxU3BgA230WNLISuTb4U+Pxccg2CidCpYSBYUsyP2pl1C4D6
         Ssp9VBJpOqOM9as1+ff4+s82GbQYrLj4/Ccvp6Fe5+4Wjf0bmQsntVsK1aQkAHLaNN
         OiwPqMreqj7coc2PgsKzQusD9bUl92VBwDav2aumK3/lvRA4sE3dFXc1aRT3/acR7J
         3ZcBejsOp9FNMrKrm2GMmyruGRR0lg3Ay1HMkJhYM5TQBY6g2bR+aDaeYkug9UNRRC
         ZfVFhhHeOiFKw==
Received: by mail-wr1-f46.google.com with SMTP id s8so16591678wrw.10;
        Mon, 10 May 2021 06:13:03 -0700 (PDT)
X-Gm-Message-State: AOAM530yLHNKu70tP3ZjE5Rfa0f7Af+BTvdHN58iYf7/Bd/8PSIEi1ZQ
        n4iy879wTfBE8H+d7X/3M6VzC4naLMBWVuYiF1Q=
X-Google-Smtp-Source: ABdhPJx5k3kdp4Lxo7eGFl+4v6Wmh8JO5Yw79c4lK0swD2DYw4OcpNkLlTJxYpDd9aQetiy3UvM5cENTcxibXnZaD3k=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr31871475wrw.361.1620652382506;
 Mon, 10 May 2021 06:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-2-arnd@kernel.org>
 <CAMuHMdV1=mJzbr1cLwo-zUnThh9J8BmdW870dJCvp_Kft8kM2w@mail.gmail.com>
In-Reply-To: <CAMuHMdV1=mJzbr1cLwo-zUnThh9J8BmdW870dJCvp_Kft8kM2w@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 10 May 2021 15:12:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15W5vV9ivk6YnR2aGMvDjTrPGrzsszf2kD6kv1TfrpbQ@mail.gmail.com>
Message-ID: <CAK8P3a15W5vV9ivk6YnR2aGMvDjTrPGrzsszf2kD6kv1TfrpbQ@mail.gmail.com>
Subject: Re: [RFC 01/12] asm-generic: use asm-generic/unaligned.h for most architectures
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 10, 2021 at 12:16 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, May 8, 2021 at 12:09 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > There are several architectures that just duplicate the contents
> > of asm-generic/unaligned.h, so change those over to use the
> > file directly, to make future modifications easier.
> >
> > The exceptions are:
> >
> > - arm32 sets HAVE_EFFICIENT_UNALIGNED_ACCESS, but wants the
> >   unaligned-struct version
> >
> > - ppc64le disables HAVE_EFFICIENT_UNALIGNED_ACCESS but includes
> >   the access-ok version
> >
> > - m68k (non-dragonball) also uses the access-ok version without
> >   setting HAVE_EFFICIENT_UNALIGNED_ACCESS.
>
> This not only applies to dragonball, which has the CPU32 core, but also
> to plain 68000, and any SoCs including the 68EC000 core.

I meant out of the machines that are currently supported in the kernel.
As far as I can tell, the only 68000 variants that are supported are
all Dragonball CONFIG_M68328, CONFIG_M68EZ328 and
CONFIG_M68VZ328.

CONFIG_MCPU32 has been dead since a3595962d824 ("m68knommu:
remove obsolete 68360 support")

> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

        Arnd
