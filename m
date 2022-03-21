Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C34E33F9
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 00:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiCUXBG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 19:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiCUW6b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 18:58:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D62459006;
        Mon, 21 Mar 2022 15:36:44 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MN4qp-1npJtI3mRJ-00J5EQ; Mon, 21 Mar 2022 22:55:25 +0100
Received: by mail-wr1-f45.google.com with SMTP id u16so21508673wru.4;
        Mon, 21 Mar 2022 14:55:25 -0700 (PDT)
X-Gm-Message-State: AOAM530RMxgk3jwFb0JEJYnUYEgIrgliaJYGuAwTZ5ezEyLz5TYH6vAj
        u51yL9F8v1mBTEmy2GOsCbnBAsDvrd20fH6TlqU=
X-Google-Smtp-Source: ABdhPJzwh5VrdiI1bc3kA/qP0tQTiqByLF123LNSVb5g7hlw9GovPGy8qh6+Cx7cu+lXNoLCe/LDwLKoy2W/g1NPcQo=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr8462867wrg.219.1647899725513; Mon, 21
 Mar 2022 14:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com> <CAHk-=wj81Cgjb5xj=ghB0oEA4ronnc=WKZLTPGpJYPUn=QcQ5g@mail.gmail.com>
In-Reply-To: <CAHk-=wj81Cgjb5xj=ghB0oEA4ronnc=WKZLTPGpJYPUn=QcQ5g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 22:55:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a33TZm2NZg28KbCCeLzLvf759_5r8hr-rcWftci9qinog@mail.gmail.com>
Message-ID: <CAK8P3a33TZm2NZg28KbCCeLzLvf759_5r8hr-rcWftci9qinog@mail.gmail.com>
Subject: Re: [PATCH V8 00/22] arch: Add basic LoongArch support
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+7UIanepdnWa2y7TiiQIeUT8W83/7V7wzhsPgFRjHFNqvuxf6Ea
 4jG1C00t5AA4MofPcfSmyU1it8aKVVsCO2chwy50b7NQk56Qhithtgnyc9ihjzcBWNpAIF/
 PmecXMghJ1mJDiA2zrBX01SNt7jxEA7W6XyECNg4WIxaRPTwoH4MPP6BqO1KJr1gMuKT1Za
 KXX5/2ySt9N9Z9SmBq8+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aEu/Ol8GpwM=:0fBGCWKS7vVuj3OtDQgSgs
 VC3AifaiTuHSZGdq5SX073YeMRn/29OpYFprppfViOnPyoFkVkVZjSsptCMIeeYatDLbDISRq
 l/VVvlP1PAV6EdbGRFyNtvI/AdRrWroQE+6CzpcAuNrHqv8pHyfAE53igm5Aj7Y5hwyN02LEv
 5Ja6moSRj6p5npZMGQRWtm7jQFNw3u3jOiMT1Y2Zwt5Dx0jzq9kukL+IJv15ETytYUYzCJAsg
 DIggBItQzwfZz3FnUwxCbJ6UKl8XPKL5r1JnG03PNhC1IQVLBKbMo3GLE/yKPXR/FII8I3S/E
 ysv3sGlJCXrkYU0dP7Nco4yGPAJI0caJw664rKlu3rydYJx/mLm27WG0GeQG5c/dAoVCB1f2I
 dv3FW1NDO9jXYQgiYwgpIKP3MGA2jtGk/cDRqA5jfn1utA6Ptax6Bj8wYzXxHkvdDI0ocOohE
 HpuSf/8Ctfk/PnMLbO+vmq5BhlXyctzvm5FY5LUOBdwCqiUGhhjpFOU5N8FuNjz6JgY4wRgcJ
 93iJ0bGbjnrsvWcvrkmOqVNw8si/b5MbKirzljAFIfPfz5/5SA3XcAZw+23N/sCfnMjKXiZjQ
 gYpLUHrNk20ItwOZUlmx+vyOx+4B5T+lRyq/XAKX61S2hERczmzXnvocUTdgKYEBNL2PR+SgI
 ZtAQRa6X9Y9poY3jZLV5f/eVbKgIq+ba/pdZzKf0oIlNDISzy0Cd2udCw6uyMKTobjsdh3AKm
 h9iiMU6CMIL0vF1kOdJvqEfRPRI73vQiECJk+bFaYrHoa0yQFzj5vkeV4lFJCwA6BFyhGIzY8
 tPxkefWPpcB4Z6vxJEI3nh1ew/Gctq3BRn8aDL4LJ6ybReJX5k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 21, 2022 at 5:59 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 21, 2022 at 4:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > This looks fine to me for the most part [...]
>
> So it looks like this is getting there.. Do we have a way forward for
> this to be merged?
>
> I obviously can take the patches, but it would be even nicer to have a
> pull request, and you'd be the obvious person since you are - whether
> you like it or not - the "odd architecture guy".

I can prepare a pull request when it gets to that, but I think the boot protocol
should be fixed first, and that makes it 5.19 material.

The TL;DR version here is that LoongArch requires the use of ACPI/UEFI
firmware, but does not currently enter the kernel using the UEFI protocol.

Instead, grub gets loaded by the firmware (not sure using which protocol),
and it then loads the kernel from disk, entering it through an ad-hoc
method passing data from grub to the kernel using a combination of
CPU registers and in-memory data structures that are different from
how UEFI passes the same information using the drivers/firmware/efi
stub entry.

We have already discussed that this will be replaced with a regular
UEFI entry using the same code that x86 and arm64 have, but at the
moment, neither the specification nor the code is there.

Merging the current version and changing it to the standard boot
protocol later would mean they'd have to keep both protocols in
the kernel, which adds complexity.

         Arnd
