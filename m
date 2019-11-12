Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831F3F8B78
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfKLJOI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 12 Nov 2019 04:14:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38968 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLJOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 04:14:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id v138so14138244oif.6;
        Tue, 12 Nov 2019 01:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CcFia2f8UjT7Hz7B3H/t2zQe97c4U387QE8r5XjOH8A=;
        b=t/3EoTXZwO4A4ZgrzT+/BHLcbzStTaLy3bem4ZjRM7T30rdHPt34rcy5vJKRfzNk3d
         ewOd1cHrQa14znwpmvwgFadYJHaua/0hxTn6xlYa1nJL1puH+2Hepea+z+vNUzMTBZEL
         z5ErdNK97ZwftHn/8POHHy+TViSd4hkPSy+9vTn8pvCgtGmsB+ZH3Hs/vdOzodLJUPVL
         oJoKaQfxvkPq5ad6p6XDJEsUTO369ZWWf117DcJ2U/xfvT4YH+64ZKKfMVSdkw94AoVa
         tfks1wzNfv1IFmZw/BT0Vlazs413Y6sFVF/rGY2RIjAQsZuApnFeeJyySO8iq+3Ehic3
         25Xw==
X-Gm-Message-State: APjAAAUeA30wiBquYZS+QrX1HQ50wpB+OqUJNpErqBBmFw0rADj2wWCx
        LuOj5Q4WY/qLCBdkinvJQYJBcTnBs6GvJ8pEfLs=
X-Google-Smtp-Source: APXvYqxbSiMMCm9vOSRUI81fzjT2IZ3Fd4CYajnzFOk7q7brNKIrKnb1uqJhXwzzLHRJu12wVQ5KC28YV3eKlUAChCc=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr2951038oia.131.1573550045207;
 Tue, 12 Nov 2019 01:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-12-keescook@chromium.org>
 <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
 <201911110922.17A2112B0@keescook> <CAMuHMdUJ8QPvqf51nVmOg1Zm20SNT7pXR72z=qmco=ecwawZ7A@mail.gmail.com>
 <20191112090736.GA32336@zn.tnic>
In-Reply-To: <20191112090736.GA32336@zn.tnic>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Nov 2019 10:13:53 +0100
Message-ID: <CAMuHMdXayF+z4z+Ds-gm4+YFA=BCMo0_9Q3uXcbQQgQkLxZ4uw@mail.gmail.com>
Subject: Re: [PATCH v2 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Borislav,

On Tue, Nov 12, 2019 at 10:08 AM Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Nov 11, 2019 at 07:08:51PM +0100, Geert Uytterhoeven wrote:
> > vmlinux-std.lds: All other classic 680x0 targets with an MMU, e.g. plain
> >                  defconfig aka multi_defconfig.
>
> FWIW, the defconfig doesn't build with the cross compiler¹ here, even with Kees'
> patch applied but for a different reason:
>
> $ make.cross ARCH=m68k defconfig
> ...
>
> $make.cross ARCH=m68k 2>w.log
> ...
> drivers/video/fbdev/c2p_planar.o: In function `transp8':
> c2p_planar.c:(.text+0x13a): undefined reference to `c2p_unsupported'
> c2p_planar.c:(.text+0x1de): undefined reference to `c2p_unsupported'
> drivers/video/fbdev/c2p_iplan2.o: In function `transp4x.constprop.0':
> c2p_iplan2.c:(.text+0x98): undefined reference to `c2p_unsupported'
> make: *** [Makefile:1094: vmlinux] Error 1

The fix for that regression (finally) made it in rc7:
b330f3972f4f2a82 ("fbdev: c2p: Fix link failure on non-inlining").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
