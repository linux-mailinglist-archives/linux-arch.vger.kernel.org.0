Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD564F1D4E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 23:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382527AbiDDVan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 17:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380344AbiDDTiD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 15:38:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9E13F10;
        Mon,  4 Apr 2022 12:36:05 -0700 (PDT)
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MCbMx-1njTEW44DD-009jfe; Mon, 04 Apr 2022 21:36:04 +0200
Received: by mail-wm1-f51.google.com with SMTP id n38-20020a05600c502600b0038e4a0fc5easo213006wmr.3;
        Mon, 04 Apr 2022 12:36:03 -0700 (PDT)
X-Gm-Message-State: AOAM530e3QZh9j+3Ooh3C0vd1rJqdVrpEYpJ4xevEjcsg9wHhQ/FD8IZ
        EK41q4GhFhMNvGHap+YyW6nhSnhr8aPX/mbmF/4=
X-Google-Smtp-Source: ABdhPJxpqVUnzSThWxFis0+czy1waV2fEyvClqHAXtfCqV11EeZgFuDvKELwz3h19yH6dPE8NNhk9binn9y/5RzmubM=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr626838wmj.20.1649100963560; Mon, 04 Apr
 2022 12:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMo8BfKgn0T5RtUTb89fPvygNJJYLy7r1=RZTmTTm=jiDfx1hQ@mail.gmail.com>
 <CAK8P3a0J1--WSyWY+TptFa0nn5d-mOxapadCE1csGRkfhSPbVw@mail.gmail.com> <CAMo8BfLT8vMw3aGQPs1+9ry7W63SQphmDc4Tt4A3JvADHJhxiQ@mail.gmail.com>
In-Reply-To: <CAMo8BfLT8vMw3aGQPs1+9ry7W63SQphmDc4Tt4A3JvADHJhxiQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 21:35:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3iFb+ZacZ40d8PC_xcJpLVFXT0Qc-oYEZNkFqXdsfNZw@mail.gmail.com>
Message-ID: <CAK8P3a3iFb+ZacZ40d8PC_xcJpLVFXT0Qc-oYEZNkFqXdsfNZw@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:Na3Qbp5Gp6zqpmOBXFOCu/SbbvSoNPqbD2qfv/xtPRYs5dDgRg8
 mIdvfyyz7e473bmnPVXYgmko/IBAFkN0E/0D7L82k9H4z0qRYeIYCVhV+iBQaif2iegOb1n
 G5GibOdTpi5drETUpiRkAyzxuEliV1e4OIvYnLs7V+EvzmsZHy+EQlKk4xe7MwQlb5by+Gj
 apal2zq108Xa8Zht5qXpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:48eYd4DVt+g=:4SxC9dH5qGnv0NPa9/lmmK
 UAUr1kr+bxQ+cT9ipiNeobPoYMARqZ1sXLPPb3RBuM/FeNM7LQl77+5LxFq0kVfxe8KDYB4vN
 Z8JggpZz9US2JF8u4D1euzH3LMC0rUGjLA6xk2QeqlKzQNxztcyfiaKL7kCPK5lvF7/NhjJjm
 Swp1pisPzQ9HvqHjNeMJkJ2a4rD3LV4/lQCYUUTteh05i3GBs1z3KUY9h+u4vOJsahunt9u/7
 UEWXIJ5FHaY+Kg5OddLjsQNqdG/IzYDl2M90gSCz3do1klkpweaHIPLfcDxJ0vetqH/Vggist
 5lDFBLF4Wo25IJOCBa18M/BKIdtH8rl23rqLFf5Fvcet2m0VvUD7U8HP6yKV8ymGG6/ov8aZe
 gQxJKJbIENHMLnE5megUW5rVZtr354v9QVUuFdzh9dagMhLLpKUEKs8vTJ7BN+3gE8GYdZGpL
 Bo/xYSaz0uLLPNOpOqG1kfthmEe7l3+plFBLCIIazo+4Mcqx+7ZNShmqkypDmA/xIcKtBQ8dc
 NmzLqnCgrQ9/2IVEmwctfWzPjKTtnUCedPdKJSdQ/qssI4tEDRqVpkxp1acvz5NNBTgTxUELX
 uqB979KDMIR3cGeZugP1tN4TZ38aXn7B5irg5iPGIrQPRCO1/vd6dfEbrSnw5BZRpfnYXyDcq
 u3A3XldZFbTmEWmghOVIWe9qIjVUliUudF01SMdQYIT6uzOIqWyXXpOOsCI+qcaB35QVCkt9O
 uF4Lu3l3rij+1BQ33ZXHCR2EL9GONZ8qmcUv3u8ZH3cy1aJCehhrzUJ5EUkg2iRvthWeHiHVf
 YjqmX4js+KyPmAuMSzHGB2eGmBBtP1KClfsYLfBtY2d0HB90eQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 9:14 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Mon, Apr 4, 2022 at 12:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Apr 4, 2022 at 7:57 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > Please let me know if you observe any specific build/runtime issues.
> > xtensa-linux-gcc-11.1.0 -DKCONFIG_SEED=
> ...
> > /git/arm-soc/arch/xtensa/kernel/head.S: Assembler messages:
> > /git/arm-soc/arch/xtensa/kernel/head.S:87: Error: invalid register
> > 'atomctl' for 'wsr' instruction
>
> Sure, one cannot use an arbitrary xtensa compiler for the kernel
> build, the compiler configuration must match the core variant selected
> in the linux configuration. Specifically, for the nommu_kc705_defconfig
> the following compiler can be used:
>
> https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-de212-elf.tar.gz
>
> If you build the toolchain yourself using crosstool-ng or buildroot they
> accept the 'configuration overlay' parameter that does the compiler
> customization.
>
> Perhaps the documentation for this part is what needs to be improved.

It sounds like a bug in the kernel Makefile. On all other architectures,
you can generally just pick any (recent) compiler and build any kernel,
as the compiler arguments set the exact target machine type based
on the kernel config. You can't normally rely on the compiler defaults
for kernel builds.

         Arnd
