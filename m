Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE0F8B60
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 10:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLJIP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 04:08:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfKLJIO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Nov 2019 04:08:14 -0500
Received: from zn.tnic (p2E584DC9.dip0.t-ipconnect.de [46.88.77.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B7B2B1EC0CA6;
        Tue, 12 Nov 2019 10:08:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573549692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgSHUZN/Tc3i/urvdGyHhzYbE4TfA+OAcjxyh6wdl0g=;
        b=TXMJi5aaVamyTSkyaP9txWDmgil75yVNGXtDUK2qSQN3N80SBfbaeRkTqeGgjmWl075E2M
        Kt8DTCIeiyBtyF1bzFcLzy3ueZApeoMic9zdYDtq0MMAzlOQB5cV9nqr1C/S/PPR32Bt9a
        r2knCvp2XhycAsilLgrafbGrFBj7hRs=
Date:   Tue, 12 Nov 2019 10:07:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/29] vmlinux.lds.h: Replace RODATA with RO_DATA
Message-ID: <20191112090736.GA32336@zn.tnic>
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-12-keescook@chromium.org>
 <CAMuHMdXfPyti1wFBb0hhf3CeDSQ=zVv7cV-taeYCmDswMQkXPQ@mail.gmail.com>
 <201911110922.17A2112B0@keescook>
 <CAMuHMdUJ8QPvqf51nVmOg1Zm20SNT7pXR72z=qmco=ecwawZ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUJ8QPvqf51nVmOg1Zm20SNT7pXR72z=qmco=ecwawZ7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 11, 2019 at 07:08:51PM +0100, Geert Uytterhoeven wrote:
> vmlinux-std.lds: All other classic 680x0 targets with an MMU, e.g. plain
>                  defconfig aka multi_defconfig.

FWIW, the defconfig doesn't build with the cross compiler¹ here, even with Kees'
patch applied but for a different reason:

$ make.cross ARCH=m68k defconfig
...

$make.cross ARCH=m68k 2>w.log
...
drivers/video/fbdev/c2p_planar.o: In function `transp8':
c2p_planar.c:(.text+0x13a): undefined reference to `c2p_unsupported'
c2p_planar.c:(.text+0x1de): undefined reference to `c2p_unsupported'
drivers/video/fbdev/c2p_iplan2.o: In function `transp4x.constprop.0':
c2p_iplan2.c:(.text+0x98): undefined reference to `c2p_unsupported'
make: *** [Makefile:1094: vmlinux] Error 1


¹ https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
