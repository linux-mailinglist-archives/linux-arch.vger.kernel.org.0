Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05196CCAF0
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjC1Twv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 15:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC1Twu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 15:52:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E81BEF;
        Tue, 28 Mar 2023 12:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F12A1B81DF4;
        Tue, 28 Mar 2023 19:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E59DC433EF;
        Tue, 28 Mar 2023 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680033166;
        bh=3tCsQlZNxjpj6kRrRVaA2+D40G/G8omyRmcPC6eNHcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8c83d6zKDAseuUsmPwdWmhujxfPqFtrEXrW653rlLKUrkNLZqsnZfSf2rOmri2lF
         eblSB48mq0XMv5XNxHk/TSur5NY0H94GtwFqxAhZ6B6xyq1OXzxumv5C57bm/PmnUr
         LGRSRFfPPY+g8EPNJLtDGbY3jQipSeiMah3zR0CxiBcHrfFH/IaWe3ezeGGsKGsqVL
         HhFiGKP/Y3OixbpkKK47mEFSa82RCJrr2ju3/yTReI8G6JPU/aJSZhLacNNDrOUcVP
         nJtW4msn5ahphR3iPD5l/7lxjqeME9MNH7aqUZAfUpdDk4aJTni2/afC89IWzIX0WV
         aJGQepl2T6dUQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8F6F4052D; Tue, 28 Mar 2023 16:52:43 -0300 (-03)
Date:   Tue, 28 Mar 2023 16:52:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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
Message-ID: <ZCNFi65T4anhk6hH@kernel.org>
References: <20221012233500.156764-1-masahiroy@kernel.org>
 <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
 <ZBzAp457rrO52FPy@aurel32.net>
 <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
 <CAK7LNASdsWMP2jud4niOkrR5+a2jG-Vfo0XEa63bh3L3W6_t0Q@mail.gmail.com>
 <CAK7LNASUbyDV-kMi3fuihUdfnhtzHnk9wosQ0w-fuamDcT2ZBg@mail.gmail.com>
 <2d8f0889da0e3dfa9c1c8fe9da301d54636a2e6d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8f0889da0e3dfa9c1c8fe9da301d54636a2e6d.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Tue, Mar 28, 2023 at 01:33:29PM +0300, Eduard Zingerman escreveu:
> On Sat, 2023-03-25 at 20:42 +0900, Masahiro Yamada wrote:
> [...]
> > > Strange.
> > > 
> > > I used the .config file Aurelien provided, but
> > > I still cannot reproduce this issue.
> > > 
> > > The vmlinux size is small as-is in the current mainline.
> > > 
> > > [mainline]
> > > 
> > > masahiro@zoe:~/ref/linux(master)$ git log --oneline -1
> > > 65aca32efdcb (HEAD -> master, origin/master, origin/HEAD) Merge tag
> > > 'mm-hotfixes-stable-2023-03-24-17-09' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-size  vmlinux
> > >    text    data     bss     dec     hex filename
> > > 24561282 8186912 622032 33370226 1fd3072 vmlinux
> > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-readelf -S
> > > vmlinux | grep -A1 BTF
> > >   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
> > >        000000000048209c  0000000000000000   A       0     0     1
> > >   [16] .BTF_ids          PROGBITS         ffff8000096427a4  016527a4
> > >        0000000000000a1c  0000000000000000   A       0     0     1
> > > 
> > > [mainline + revert 994b7ac]
> > > 
> > > masahiro@zoe:~/ref/linux2(testing)$ git log --oneline -2
> > > 856c80dd789c (HEAD -> testing) Revert "arm64: remove special treatment
> > > for the link order of head.o"
> > > 65aca32efdcb (origin/master, origin/HEAD, master) Merge tag
> > > 'mm-hotfixes-stable-2023-03-24-17-09' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-size  vmlinux
> > >    text    data     bss     dec     hex filename
> > > 24561329 8186912 622032 33370273 1fd30a1 vmlinux
> > > masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-readelf -S
> > > vmlinux | grep -A1 BTF
> > >   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
> > >        00000000004820cb  0000000000000000   A       0     0     1
> > >   [16] .BTF_ids          PROGBITS         ffff8000096427d4  016527d4
> > >        0000000000000a1c  0000000000000000   A       0     0     1
> > > 
> > > 
> > > 
> > > I still do not know what affects reproducibility.
> > > (compiler version, pahole version, etc. ?)
> > > 
> > > 
> > > 
> > > 
> > > Aurelien used GCC 12 + binutils 2.40, but
> > > my toolchain is a bit older.
> > > 
> > > FWIW, I tested this on Ubuntu 22.04LTS.
> > > 
> > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-gcc --version
> > > aarch64-linux-gnu-gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
> > > Copyright (C) 2021 Free Software Foundation, Inc.
> > > This is free software; see the source for copying conditions.  There is NO
> > > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > > 
> > > masahiro@zoe:~/ref/linux(master)$ pahole --version
> > > v1.22
> > > 
> > > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-as --version
> > > GNU assembler (GNU Binutils for Ubuntu) 2.38
> > > Copyright (C) 2022 Free Software Foundation, Inc.
> > > This program is free software; you may redistribute it under the terms of
> > > the GNU General Public License version 3 or later.
> > > This program has absolutely no warranty.
> > > This assembler was configured for a target of `aarch64-linux-gnu'.
> > 
> > I did the same things in Deiban sid
> > in order to use newer versions of tools.
> 
> 
> Hi Masahiro,
> 
> An upgrade from gcc 11 to gcc 12, BTF section increase and a number of
> duplicate IDs reported by resolve_btfids matches the description of
> the following thread:
> 
> https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/
> 
> The issue is caused by change in GNU assembler DWARF generation.
> I've sent a patch to fix it a few weeks ago and it is merged in
> dwarves master:
> 
> a9498899109d ("dwarf_loader: Fix for BTF id drift caused by adding unspecified types")
> 
> Could you please grab a fresh version of dwarves from:
> 
> git@github.com:acmel/dwarves.git
> 
> compile 'pahole' and try with?

pahole 1.25 is long overdue, so let see if this got fixed with what is
in master, please take a look, you can as well get it from:

git://git.kernel.org/pub/scm/devel/pahole/pahole.git

- Arnald o
