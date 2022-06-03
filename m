Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8453C81D
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 12:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiFCKI6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiFCKI4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 06:08:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B007B3B02C;
        Fri,  3 Jun 2022 03:08:55 -0700 (PDT)
Received: from mail-yw1-f181.google.com ([209.85.128.181]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhULz-1nJagI3kax-00eeye; Fri, 03 Jun 2022 12:08:54 +0200
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-30ce6492a60so77133517b3.8;
        Fri, 03 Jun 2022 03:08:53 -0700 (PDT)
X-Gm-Message-State: AOAM531qmQ1fneuOwtxJ7t6powi+Yhf1xlaunKW0311lBi9hDbMvWB+W
        HC1ODCoffdwMbl3plNRZz3RglfJyntH1ATkp0Sk=
X-Google-Smtp-Source: ABdhPJwMLIGdi1PNW1jOKJgngerdyDn06BuV6UNj9c7cH2GfoinWyEn6pRpJxBn6voIILAtnv3gEzKaiRN5m4SupqA8=
X-Received: by 2002:a0d:efc2:0:b0:2fe:d2b7:da8 with SMTP id
 y185-20020a0defc2000000b002fed2b70da8mr10241968ywe.42.1654250932363; Fri, 03
 Jun 2022 03:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-12-chenhuacai@loongson.cn> <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
 <dab96b787bef91240c719ea1a100396350135f99.camel@xry111.site> <f7b53d2b-759c-bc5b-e2ed-a251b879f450@xen0n.name>
In-Reply-To: <f7b53d2b-759c-bc5b-e2ed-a251b879f450@xen0n.name>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Jun 2022 12:08:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3VxN8_63G1+vbFiy4=mjkAHoHpZwo48UVr55HOfBSmFQ@mail.gmail.com>
Message-ID: <CAK8P3a3VxN8_63G1+vbFiy4=mjkAHoHpZwo48UVr55HOfBSmFQ@mail.gmail.com>
Subject: Re: Steps forward for the LoongArch UEFI bringup patch? (was: Re:
 [PATCH V14 11/24] LoongArch: Add boot and setup routines)
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OB5x7qgklN1NkyMxirtVh/vMvPr9nVsm9XsrIOgTJ2X89GtQRKH
 QRp0Md5FetpQ8nV8Qsk7R9+/pbSbN+wudoQSHfmOy0LrH+BhwtuOPVFiflz6Z+s85XDrDWG
 0DKApkZEfdcE9amNyo9uVFortdvCGNS9jm6fQp/GUuRhdgoc58xMXcfslhTvnNuxO9PiV/X
 unXn5PsyowvwM6/CU5y8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HLzlSqTG/oE=:2o9WIAFOtP7ToyY4QsnqAc
 k/+bOSvo6cIpNpNLhN+ZIjYTmhbnk0EYCCnr3q/ujw9Hcrs/qoweMVohpqCy2L/4aHryAZzdo
 nF8qz5O7clnjH3cXg27TATVVahQehECoeRYa/15/1HZVG+LlZdt0Q8ycf2qLdsIv13KGCDgNk
 npHaHlNhJ3TCdESXci2y4XrMn1g4xq1JiMVYigsb6OySUA7nu5jkZvJ8PlE1AkLBFBYQmgVy/
 tfNROxj8Kzf7vViYbatxCS9E5K0hGlGgaf1kxyoH3V4xsmPbktsdq1SMQ+Pm5r+JfMH0P+boO
 nooUA+7LP8foaD+d3SINBB0NaZOIzr7YtIrKYFHP+gLgn0jN8lK0F+hn+3apc8fQh08x0bHCy
 oehu/wm13fugxrN0YAeZiKaMimz5lmTSXodeWS9rLQHFDxDGin7ZyquyPW4kOy/0uzPxY+tgB
 vexWW0zEFI56gP1BiagWulMwb8biJrISdFge/yjtTvSMPhZueKPWN5MezUbV88KUvywQi7NVR
 HN8F4aS3neb/CbXpJJcw0HNtkB2JBZBiIAN5/uT8bdyR+0uPHV3RfFFfffCFWMcYPOO9k9pv5
 Pw5Yh50H1s3Ej21m8PaCw7mL6+2kMVahdTDw5adcipnz2B32VNMAoNfwQTu2sQmMunWBBAnXS
 dQ5l0RXwylqA6MZLLBX9P8C3FEZHvVE3EVNKBlBJbt5lMS892niTiR4HHLoA2SNDcJHy6gjB8
 IN8m/vgt2W5eEk0KgW4hnkOtse1+mG7svEdq26NZaj5NXvFlUUDFYVsnxAP7b8btyKR8Fm8/F
 H3a0BCwDkWeHxCZjocZLh7Kdwfkn9ALpCyF2Htah3DimBrmJY3kw6XzPyl37lfaOHttIJOuzu
 fwT4YjxWyYCD7LuZI/Zw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 3, 2022 at 11:48 AM WANG Xuerui <kernel@xen0n.name> wrote:
> On 6/3/22 17:32, Xi Ruoyao wrote:
> > On Thu, 2022-06-02 at 22:09 +0800, WANG Xuerui wrote:
> >
> > old firmware -> bootloongarch.efi -> customized u-boot -> bootloongarch64.efi (grub) -> efi stub (kernel)
> >                  --------- compatibility layer --------    ^^^^^^^^ normal UEFI compatible stuff ^^^^^^^^^
> >
> > new firmware -> bootloongarch64.efi (grub) -> efi stub (kernel)
> >
> > The old firmware route would be similar to the booting procedure of
> > Asahi Linux.  I think this can be implemented because it's already
> > implemented on M1 even while Apple is almost completely uncooperative.

It should be a little easier here, as the firmware can already boot a version
of grub from disk. I would hope that there could simply be two different
file names for the grub executable, with the existing firmware booting
an old image, and new firmware looking for a different file name first,
which would contain a regular EFI executable (grub, kernel or anything
else). If either of the two versions of grub gets loaded by the firmware,
that should then be able to boot a modern kernel through efistub.

> This is a bit off-topic (we're basically hurrying up to get the port
> into v5.19-rc1 and discussing ways to achieve that), but yeah
> definitely. I've had the same idea right after knowing the LoongArch
> firmware would also have "new-world" variant, then I contacted some
> firmware engineers working on LoongArch boards, I think they agreed on
> the approach overall.
>
> However, making the kernel itself capable of booting on both BPI and
> new-world UEFI firmware flavors may have its merits after all; one
> scenario I could come up with is that user reboots and upgrades their
> firmware, *before* updating their old-world kernel, and bang! system
> soft-bricked. All such cases involve old-world distros that already
> deviate a little bit from vanilla upstream code, so such BPI support
> needn't be mainlined for avoiding this scenario.

The problem here is that this is very hard to ever get rid of. If
having the compatibility layer in grub works, I think that is better
for the long run.

        Arnd
