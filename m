Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9534F1D51
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 23:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380530AbiDDVax (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380146AbiDDTDV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 15:03:21 -0400
X-Greylist: delayed 21239 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 12:01:23 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140533E00;
        Mon,  4 Apr 2022 12:01:23 -0700 (PDT)
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N7iKo-1o5ov53WEc-014k9c; Mon, 04 Apr 2022 21:01:21 +0200
Received: by mail-wm1-f47.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so132869wms.2;
        Mon, 04 Apr 2022 12:01:21 -0700 (PDT)
X-Gm-Message-State: AOAM530TCueyV+FE0/vD8O7Tks5eio/TulFAQL32gRmctjU+/8nvFrNF
        KFSh5/xopwSQWgXFW9JjfVvb+9DK7+W/9PU1u64=
X-Google-Smtp-Source: ABdhPJwz/M4LKrm3IRclV8UgrUcDHyP4nLiAeM9chnwMC8xte+ec0eWR310JC5CzRN6KPW7x0SBYcBjNd+/TV08TLsg=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr474508wmc.94.1649098881420; Mon, 04 Apr
 2022 12:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMo8BfKgn0T5RtUTb89fPvygNJJYLy7r1=RZTmTTm=jiDfx1hQ@mail.gmail.com>
In-Reply-To: <CAMo8BfKgn0T5RtUTb89fPvygNJJYLy7r1=RZTmTTm=jiDfx1hQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 21:01:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0J1--WSyWY+TptFa0nn5d-mOxapadCE1csGRkfhSPbVw@mail.gmail.com>
Message-ID: <CAK8P3a0J1--WSyWY+TptFa0nn5d-mOxapadCE1csGRkfhSPbVw@mail.gmail.com>
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
X-Provags-ID: V03:K1:jGFNqhM4dIFnhH1crk1UVV07OPTBQhiimiupzrSkXwuZ9o/RtZS
 ce2dWxclh3NM1z+dTa6dUW5EB7GOpkfiFOrifVIv77uNICEOMvNHFgfWVNZ0zabYqXRE7xj
 W8C2lKOwuzjEyX2b7dI9CfnLS/EPgqD/wVS4o+rUFE5ecWCwjtz020QwqHijVQ6dpL4VUQq
 Zy09C+JPFQXysIgVsD8cA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1YIjIfRsLSU=:o6rIvbCNXNxPzEMBqlC6My
 cGC6pjjrV8zzpIG0GVfRRpzUuIFG4cRUNwBD02Ia0ZXJPf3ivH3keNqJiDI2HOD6kPGGpRuhj
 tanw5nu6j67GnRnOql5sRPnkuDV1MXTSGhWnRaVuIcH9W97RTE4rtbNOp7xxqMv/D2IvP4V4c
 pZLOlQmWR+botrOZ0Ia2doWK9qNmkIHcLUXjPBGWhVU2anjz0w3Ra8ADa//msEI1pXxzB85ir
 K8XSBWOE1t6EV7L2V7TvaUZ5tu3zHidzRNCuBthiJNOw7Z/ZQi/wNlrc7EGDHMGbhygSVrdDI
 nm8NW10HFriS7YhLQy39UT1ks0OU9RWCQgjv04SdYXcZjwQLevxuwLKtXwPYQ2GMSiYodPTh/
 xTMj2Uvc5dIhdTtbko9lHOpMy/8vETJj0vvd0nSYey7GUxGZxN/t9YYaF+Mc4c/DyB4qijL0L
 zqqcBV5WbH9L0QwBpVeYW4BW73lVhNLD16g1Ac0A15TbpTw7VH01H97P0mkL21b3toUyXw7pq
 KHCYwEywOrVDV2aKAVTotDFDi034wNf0kcdVHO10rYdfoTUg5ZpRY+IAfQOhDdqQqKGAqhQzA
 rlQqq0NoKYDuRIRIR0ktUDDzC24EGb5+BiMk9x51otUWQfuAdXO7QMAskumMtM6rN4BNUvFqH
 cCE/zRPTtpRnmFPevpIpkVRHn5ExpMCflw//4O42zqh1RiuKJ9Bgz7wCxdKQ0gZ10Fe8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 7:57 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Arnd,
>
> On Mon, Apr 4, 2022 at 6:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > 1. xtensa nommu has does not compile in mainline and as far as I can
> > tell never did
>
> I have a different picture here. If you look at the logs at
>   https://kerneltests.org/builders/qemu-xtensa-master/
>
> there's a line for noMMU config in every one of them:
>   Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... running
> ............ passed
>
> Please let me know if you observe any specific build/runtime issues.

This is what I get:

$ make ARCH=xtensa O=build/xtensa nommu_kc705_defconfig vmlinux V=1
....
xtensa-linux-gcc-11.1.0 -DKCONFIG_SEED=
-Wp,-MMD,arch/xtensa/kernel/.head.o.d -nostdinc
-I/git/arm-soc/arch/xtensa/include -I./arch/xtensa/include/generated
-I/git/arm-soc/include -I./include
-I/git/arm-soc/arch/xtensa/include/uapi
-I./arch/xtensa/include/generated/uapi -I/git/arm-soc/include/uapi
-I./include/generated/uapi -include
/git/arm-soc/include/linux/compiler-version.h -include
/git/arm-soc/include/linux/kconfig.h -D__KERNEL__
-I/git/arm-soc/arch/xtensa/variants/de212/include
-I/git/arm-soc/arch/xtensa/platforms/xtfpga/include
-fmacro-prefix-map=/git/arm-soc/= -D__ASSEMBLY__ -fno-PIE -mlongcalls
-mtext-section-literals -Wa,--fatal-warnings -I
/git/arm-soc/arch/xtensa/kernel -I ./arch/xtensa/kernel    -c -o
arch/xtensa/kernel/head.o /git/arm-soc/arch/xtensa/kernel/head.S
/git/arm-soc/arch/xtensa/kernel/head.S: Assembler messages:
/git/arm-soc/arch/xtensa/kernel/head.S:87: Error: invalid register
'atomctl' for 'wsr' instruction

I think there were other errors in the past, but every time I tried
it, the build failed for me.

        Arnd
