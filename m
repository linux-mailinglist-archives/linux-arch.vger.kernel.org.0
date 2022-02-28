Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89C4C6AB6
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiB1LiB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 06:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiB1Lh6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 06:37:58 -0500
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 03:37:19 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F8C70F77;
        Mon, 28 Feb 2022 03:37:19 -0800 (PST)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLR5f-1nh8rj1OvT-00IVk2; Mon, 28 Feb 2022 12:24:40 +0100
Received: by mail-wr1-f48.google.com with SMTP id s1so14855590wrg.10;
        Mon, 28 Feb 2022 03:24:40 -0800 (PST)
X-Gm-Message-State: AOAM533VZ+zedlRLSkOHfL8O757zEzvIUDFRiVTJh6jWptMe0JRFSjnL
        FmPgPBCdJ7sDb4xpvgEakSd+LWBPqr36BCuRebQ=
X-Google-Smtp-Source: ABdhPJxsHhv9ZGMkqj+1xQqmNgWDzHJw3IWMK33HgSuLr4EGxfWw9ZOzndK9wjWGvid3acqW9xY0RN9FzlS1KN4eDoI=
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id
 v3-20020adfedc3000000b001ec5f115415mr13527155wro.317.1646047479895; Mon, 28
 Feb 2022 03:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
 <20220226110338.77547-10-chenhuacai@loongson.cn> <CAMj1kXHWRZcjF9H2jZ+p-HNuXyPs-=9B8WiYLsrDJGpipgKo_w@mail.gmail.com>
 <YhupaVZvbipgke2Z@kroah.com> <CAAhV-H6hmvyniHP-CMxtOopRHp6XYaF58re13snMrk_Umj+wSQ@mail.gmail.com>
 <CAMj1kXFa447Z21q3uu0UFExDDDG9Y42ZHtiUppu6QpuNA_5bhA@mail.gmail.com>
 <CAAhV-H7X+Txq4HaaF49QZ9deD=Dwx_GX-2E9q_nA8P76ZRDeXg@mail.gmail.com>
 <CAMj1kXGH1AtL8_KbFkK+FRgWQPzPm1dCdvEF0A2KksREGTSeCg@mail.gmail.com> <CAAhV-H6fdJwbVG_m0ZL_JGROKCrCbc-fKpj3dnOowaEUA+3ujQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6fdJwbVG_m0ZL_JGROKCrCbc-fKpj3dnOowaEUA+3ujQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Feb 2022 12:24:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2hr2rjyLpkeG1EKiOVGrY4UCB61OHGj5nzft-KCS3jYA@mail.gmail.com>
Message-ID: <CAK8P3a2hr2rjyLpkeG1EKiOVGrY4UCB61OHGj5nzft-KCS3jYA@mail.gmail.com>
Subject: Re: [PATCH V6 09/22] LoongArch: Add boot and setup routines
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wyAVrkZQ9dhz0EiWTUNl5iK9wV5bwB9HxL4qTjUVD2+rbG7/Wig
 wyqTDiAqGrs1iVKsCthNwyzoPv8MefXM/QxnkQqzvrGMNzG3weGgWoptCSZUGamBeL9MfpZ
 KgKmBq8rnITrsv1e0tuQ89dg6NUjifkaWnf66UJL9OHsQxk+IbZCBBkTojXi3w8XlzK3fX4
 8gzZj331JKyaxrMhfZ17g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qqfNnNNOh2s=:Y9XUL3h6+xj6P3Xs3b68Zd
 g9clv8i4Qf94p/T7AH+JhTec1ZZZygmZTPEaimeoLMEGMP1ZhnG7Z0P9RBkLIniQ69rNKEpJX
 69mbaIGJVqUEo2IeOJ5fdfD4c9fDsCRMW4EIXewNnnwvSU/yehyY12fJtSLCGbgKWmAvnWu2U
 EQwdXawtqv7Y7Kv4rFoEr98I7jewg5E2dpOIK+U08IVX/zl5wK3JFEBB3ISo/ytv2HYrvnrcu
 +tEDssEY8Xc3wQB30xB9qFHf5Q/KSnspxW154hw4FVDC0i5lsL6VoYnsLwiVc/4TsdHTfD8Hu
 EggIfjYyk2LF3qVC9GP4u2CX5r2g99fpMVAvRvlLxYOA7L4ZfdtJcJhs0WEoWKLrr2JbdhFRF
 T6Ia3wSsU3oOBM19DaanS++kRC92qlWcY7zwjvaihLMpUMi08ClUdgimuZG0rLs/9eQ8DIVOJ
 SbNVjkTaqzHFs3SMJHJHqR5eab2eHtAzXPz3w1coVpzb7dp2ksFz5prkIzXZrB9ZdXLc2l69u
 883q5f71hiXIbsT7VKPFZJiNNl/k5xb06wdr/mSrzfl5Hp3kKiCgM9EbhVhny8MPNZEYvWtN/
 7Ws/zkUzVsyCsavL6ajvLZFhSVwinKP7INSuad6TPwnW8jumUHJ0aREhZqFD+u56JRI2POjjd
 r8I4td9tVBPXhQFdC9LlLaHYjAGl5LA3UqoxVJO7emxpwl6LmqxKTbfZoGJBTxCrJBd8FkzAb
 pYonxfp2O4H+erVconiHCwOgQwYJj2XTho0561hX48PpZ4D8r7jFTkiSRg+HGlTnptK3vycF2
 CcHOqw8py+CCgY7JUkxNST05EFBfEonysPVMS3hfyimeWPKXww=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 11:42 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Mon, Feb 28, 2022 at 4:52 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Mon, 28 Feb 2022 at 09:38, Huacai Chen <chenhuacai@gmail.com> wrote:
> > > >
> > > > RISC-V is a useful reference for the changes needed - this is the most
> > > > recent addition to the EFI stub, and avoids some legacy stuff that new
> > > > architectures have no need for.
> > > We still want to support the raw elf kernel (RISC-V also does),
> > > because LoongArch also has MCU and SoC and we want to support FDT (I
> > > think this is reasonable, because RISC-V also supports raw elf).
> > >
> >
> > That is fine. So perhaps the best course of action is to omit the
> > UEFI/ACPI parts entirely for now, and focus on the DT/embedded use
> > case. Once all the spec pieces are in place, the UEFI + ACPI changes
> > can be presented as a single coherent set.
> It seems that I made you confusing. :)
> There are big CPUs and small CPUs (MCU and SoC), big CPUs use
> UEFI+ACPI, while small CPUs use FDT.
> At present, the only matured LoongArch CPU is Loongson-3A5000 (big
> CPU) which uses UEFI+ACPI.
> We want to support raw elf because it can run on both ACPI firmware
> and FDT firmware, but at present we only have ACPI firmware.

Can't you just use the UEFI protocol for kernel entry regardless
of the bootloader? It seems odd to use a different protocol for loading
grub and the kernel, especially if that means you end up having to
support both protocols inside of u-boot and grub, in order to chain-load
a uefi application like grub.

       Arnd
