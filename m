Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0886F23A4
	for <lists+linux-arch@lfdr.de>; Sat, 29 Apr 2023 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjD2Hrf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Apr 2023 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjD2Hre (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Apr 2023 03:47:34 -0400
X-Greylist: delayed 1044 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Apr 2023 00:47:33 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234BB1BF2
        for <linux-arch@vger.kernel.org>; Sat, 29 Apr 2023 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=ncDaDqDwwscytnxZqksS1TxOdUdsbxUd69f/Fut6Lo4=; b=cAYErngPgHPVbC8ryW4Rp8W9/P
        IVMED0TPs9sVG9KZ9rz1T75JQtLdq+BPoDB0VJUiKaXrRbIbKGK5vnR8LFLDjZOYV5zx/QtpLDztP
        OUQmRGn5rqgjR0Ae9lNnub8ad2yx2yFtRubTLBdlLXN28kWiIZVgN6XtUX4VVjSDu1XfM1vkocRdw
        G6JB3RjPJ5g3FZZA80Ys+h+YKuoXl6nVVgMl9xhImAAJLS5e6JMFsuF7FgkoDs+ozdrMwJOxtPsT1
        yPgglJbWeOHl+FqUpDn3lNuKUpPUz7hfkhkgccVY4beL0I1k8AlsC903Mf1z9tBMmn5HAKae3TzPL
        bOeKUzLQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1psf1d-00CzBD-UU; Sat, 29 Apr 2023 09:29:45 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1psf1c-009rOz-1w;
        Sat, 29 Apr 2023 09:29:44 +0200
Date:   Sat, 29 Apr 2023 09:29:44 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Eduard Zingerman <eddyz87@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>
Subject: Re: [PATCH] arm64: remove special treatment for the link order of
 head.o
Message-ID: <ZEzHaJUP21Ln5XBt@aurel32.net>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" <bpf@vger.kernel.org>
References: <20221012233500.156764-1-masahiroy@kernel.org>
 <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
 <ZBzAp457rrO52FPy@aurel32.net>
 <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
 <CAK7LNASdsWMP2jud4niOkrR5+a2jG-Vfo0XEa63bh3L3W6_t0Q@mail.gmail.com>
 <CAK7LNASUbyDV-kMi3fuihUdfnhtzHnk9wosQ0w-fuamDcT2ZBg@mail.gmail.com>
 <2d8f0889da0e3dfa9c1c8fe9da301d54636a2e6d.camel@gmail.com>
 <ZCNFi65T4anhk6hH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCNFi65T4anhk6hH@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-03-28 16:52, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 28, 2023 at 01:33:29PM +0300, Eduard Zingerman escreveu:
> > On Sat, 2023-03-25 at 20:42 +0900, Masahiro Yamada wrote:
> > [...]
> > > > Strange.
> > > > 
> > > > I used the .config file Aurelien provided, but
> > > > I still cannot reproduce this issue.
> > > > 
> > > > The vmlinux size is small as-is in the current mainline.
> > > > 
> > > > [mainline]
> > > > 
> > > > masahiro@zoe:~/ref/linux(master)$ git log --oneline -1
> > > > 65aca32efdcb (HEAD -> master, origin/master, origin/HEAD) Merge tag
> > > > 'mm-hotfixes-stable-2023-03-24-17-09' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-size  vmlinux
> > > >    text    data     bss     dec     hex filename
> > > > 24561282 8186912 622032 33370226 1fd3072 vmlinux
> > > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-readelf -S
> > > > vmlinux | grep -A1 BTF
> > > >   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
> > > >        000000000048209c  0000000000000000   A       0     0     1
> > > >   [16] .BTF_ids          PROGBITS         ffff8000096427a4  016527a4
> > > >        0000000000000a1c  0000000000000000   A       0     0     1
> > > > 
> > > > [mainline + revert 994b7ac]
> > > > 
> > > > masahiro@zoe:~/ref/linux2(testing)$ git log --oneline -2
> > > > 856c80dd789c (HEAD -> testing) Revert "arm64: remove special treatment
> > > > for the link order of head.o"
> > > > 65aca32efdcb (origin/master, origin/HEAD, master) Merge tag
> > > > 'mm-hotfixes-stable-2023-03-24-17-09' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-size  vmlinux
> > > >    text    data     bss     dec     hex filename
> > > > 24561329 8186912 622032 33370273 1fd30a1 vmlinux
> > > > masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-readelf -S
> > > > vmlinux | grep -A1 BTF
> > > >   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
> > > >        00000000004820cb  0000000000000000   A       0     0     1
> > > >   [16] .BTF_ids          PROGBITS         ffff8000096427d4  016527d4
> > > >        0000000000000a1c  0000000000000000   A       0     0     1
> > > > 
> > > > 
> > > > 
> > > > I still do not know what affects reproducibility.
> > > > (compiler version, pahole version, etc. ?)
> > > > 
> > > > 
> > > > 
> > > > 
> > > > Aurelien used GCC 12 + binutils 2.40, but
> > > > my toolchain is a bit older.
> > > > 
> > > > FWIW, I tested this on Ubuntu 22.04LTS.
> > > > 
> > > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-gcc --version
> > > > aarch64-linux-gnu-gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
> > > > Copyright (C) 2021 Free Software Foundation, Inc.
> > > > This is free software; see the source for copying conditions.  There is NO
> > > > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > > > 
> > > > masahiro@zoe:~/ref/linux(master)$ pahole --version
> > > > v1.22
> > > > 
> > > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-as --version
> > > > GNU assembler (GNU Binutils for Ubuntu) 2.38
> > > > Copyright (C) 2022 Free Software Foundation, Inc.
> > > > This program is free software; you may redistribute it under the terms of
> > > > the GNU General Public License version 3 or later.
> > > > This program has absolutely no warranty.
> > > > This assembler was configured for a target of `aarch64-linux-gnu'.
> > > 
> > > I did the same things in Deiban sid
> > > in order to use newer versions of tools.
> > 
> > 
> > Hi Masahiro,
> > 
> > An upgrade from gcc 11 to gcc 12, BTF section increase and a number of
> > duplicate IDs reported by resolve_btfids matches the description of
> > the following thread:
> > 
> > https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/
> > 
> > The issue is caused by change in GNU assembler DWARF generation.
> > I've sent a patch to fix it a few weeks ago and it is merged in
> > dwarves master:
> > 
> > a9498899109d ("dwarf_loader: Fix for BTF id drift caused by adding unspecified types")
> > 
> > Could you please grab a fresh version of dwarves from:
> > 
> > git@github.com:acmel/dwarves.git
> > 
> > compile 'pahole' and try with?
> 
> pahole 1.25 is long overdue, so let see if this got fixed with what is
> in master, please take a look, you can as well get it from:
> 
> git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 

pahole 1.25 has been released, so I have tried a kernel build with it,
and I confirm it fixes the issue. Thanks for the help.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
