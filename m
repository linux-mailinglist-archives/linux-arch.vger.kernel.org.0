Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214254F1D39
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 23:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379986AbiDDVa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 17:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380361AbiDDTqo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 15:46:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB5C31225;
        Mon,  4 Apr 2022 12:44:47 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N17cq-1nzCXH2wKw-012bHf; Mon, 04 Apr 2022 21:44:45 +0200
Received: by mail-wr1-f43.google.com with SMTP id w4so16093476wrg.12;
        Mon, 04 Apr 2022 12:44:45 -0700 (PDT)
X-Gm-Message-State: AOAM531bPpPiXsyBuu1Yr8dOuiJWOEbyTNC5wCcidziOUplTMbkUXomW
        wRILfUd3mFBk2LOwTW6lxnZEaQTZU7t70MvZnAk=
X-Google-Smtp-Source: ABdhPJyRqH0qibkfjPRGnJDcURrE8ZPrQIGLNSwn/9l1FUg/Sz1o5iKs76jxTh4W551VdZ+S32lMVfdTx28z5w2iC30=
X-Received: by 2002:a05:6000:10c7:b0:206:135e:c84e with SMTP id
 b7-20020a05600010c700b00206135ec84emr984244wrx.12.1649101485314; Mon, 04 Apr
 2022 12:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMo8BfKgn0T5RtUTb89fPvygNJJYLy7r1=RZTmTTm=jiDfx1hQ@mail.gmail.com>
 <CAK8P3a0J1--WSyWY+TptFa0nn5d-mOxapadCE1csGRkfhSPbVw@mail.gmail.com>
 <CAMo8BfLT8vMw3aGQPs1+9ry7W63SQphmDc4Tt4A3JvADHJhxiQ@mail.gmail.com> <CAK8P3a3iFb+ZacZ40d8PC_xcJpLVFXT0Qc-oYEZNkFqXdsfNZw@mail.gmail.com>
In-Reply-To: <CAK8P3a3iFb+ZacZ40d8PC_xcJpLVFXT0Qc-oYEZNkFqXdsfNZw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 21:44:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1goN3c772xiFtz13kHZs0XEDSxfXX=ub7OH3S98Mddsw@mail.gmail.com>
Message-ID: <CAK8P3a1goN3c772xiFtz13kHZs0XEDSxfXX=ub7OH3S98Mddsw@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Qw+lTynQ9FdEIf/dV0Hp8dxBMWgXsLK2Hu91jlgCSXci/9G/4Qc
 LhhlwV8BuRehAQq6IqnNWf8tdRoO1iPeJrjM21R41fRtfu83xVpvU2pqw5CdITVmh8XS0Lk
 3XNIJxiYBwAGyXKzZWz0mIOxTUV7ApES9AyWxPi+JQCvTVxx4xxA2YAu9KCgIyADBkf8RPP
 15kIpgfD1xMa9hbZDD3KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8B+XYFobVuQ=:9dNh0l+zhbsBsyfsmjDetF
 t09Tnj6ird7kCuEKoLpCBUo6Sl+7KzqmNJ4Fb4YmFJevUKFBA9NKFYIrSnGRMnauCp40cULvm
 Diw38BGNYWCiKoAhXJbz0RKPtHdq+zqx58oWsFwIZ/Lbgh4UiOY0g0V925e8eQWaj/4iVajN8
 9sUo4HkUcRFFYS0ax+5bwB6CO87e06MRTmYFzS9f+3VlRcqKDxejmGvelEuDASJ0bfSLgDDR3
 mKvnax+e/VNeWOlp2yBPwLztUTEXo81O+oeh6UTiVJemBAduOef3K7oUTfrjoNyrmvlKsDXb5
 v6kS8Kxm/TITqpnCsk4QpIp/GHF86SYKemT9E5gslt3Jom7Ii9rgFYoMqQXFnVgPRe8kDkxfN
 Om5DxEjB9KrDYBJSlFw+vCtsxj+GNK4RUToFDC6nR9bXRVu02Kljr30xaQCMbo7sor6+q2PMh
 aas5WrGIjG8nFxN7Z/hIA+kq4vDggcfEFoFwUQ6Njg1JGHlSxig3mep/yGI414qOMetQ55Q+u
 Pb+C5yFR6sMBsVt8nwV4KQKxHId8/MYTVIcsHq2KuwGFud/CeFPqmUMWewDZoB0Fe8VjhZFhx
 Ih2QrOtLgE4w1p62yki7mhccVS5LTWPCU5FKuu6lEuD8eMU7I7DSVjm8bjdkxfNYduU72ZTkB
 LbULHP7j1Ox/UCi9AHHW10IXpLthI1elT++Kev+3GlaQyu7y2DriiMAwF2LqHj+o9+9CT2UAn
 TgX3/N46OXL/SnWHuY00AV62H3sBOSblleHiMTwEPwWkv3IEuAHGYMUn5tn0ouDUpLkOIwkH4
 /kgor7hwSb5nKlOgx6S8Ht5+fpC6oARD8C8QLTR/JvkZZtDxoA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 9:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 4, 2022 at 9:14 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Mon, Apr 4, 2022 at 12:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Apr 4, 2022 at 7:57 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > > Please let me know if you observe any specific build/runtime issues.
> > > xtensa-linux-gcc-11.1.0 -DKCONFIG_SEED=
> > ...
> > > /git/arm-soc/arch/xtensa/kernel/head.S: Assembler messages:
> > > /git/arm-soc/arch/xtensa/kernel/head.S:87: Error: invalid register
> > > 'atomctl' for 'wsr' instruction
> >
> > Sure, one cannot use an arbitrary xtensa compiler for the kernel
> > build, the compiler configuration must match the core variant selected
> > in the linux configuration. Specifically, for the nommu_kc705_defconfig
> > the following compiler can be used:
> >
> > https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-de212-elf.tar.gz
> >
> > If you build the toolchain yourself using crosstool-ng or buildroot they
> > accept the 'configuration overlay' parameter that does the compiler
> > customization.
> >
> > Perhaps the documentation for this part is what needs to be improved.
>
> It sounds like a bug in the kernel Makefile. On all other architectures,
> you can generally just pick any (recent) compiler and build any kernel,
> as the compiler arguments set the exact target machine type based
> on the kernel config. You can't normally rely on the compiler defaults
> for kernel builds.

FWIW, the compiler I used is the one I built for kernel.org [1] using unmodified
upstream sources The config I used for this is

${SRCTREE}/configure ../log-gcc-configure /home/arnd/git/gcc/configure
--target=xtensa-linux --enable-targets=all
--prefix=/home/arnd/cross/x86_64/gcc-11.1.0-nolibc/xtensa-linux
--enable-languages=c --without-headers --disable-bootstrap
--disable-nls --disable-threads --disable-shared --disable-libmudflap
--disable-libssp --disable-libgomp --disable-decimal-float
--disable-libquadmath --disable-libatomic --disable-libcc1
--disable-libmpx --enable-checking=release

Let me know if I need to enable additional options to get a compiler
that works for all xtensa targets. Usually the --enable-targets=all
is meant to be sufficient.

        Arnd

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/
