Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8183951D6E4
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391460AbiEFLpo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391464AbiEFLpn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 07:45:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146DF64708;
        Fri,  6 May 2022 04:41:56 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M7aqD-1njNRn3nA5-0086j6; Fri, 06 May 2022 13:41:55 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f7d19cac0bso77892637b3.13;
        Fri, 06 May 2022 04:41:54 -0700 (PDT)
X-Gm-Message-State: AOAM531Sjh7Q45UDmZ/dNzvtvCSOV36srmPmVSs1ZzLT/GQ/8p7NsjAU
        gZeYQxQPAejOjygOBOJnNyoZuWeMWkbGlVwPzx4=
X-Google-Smtp-Source: ABdhPJywspxQxLYUg/eOOLFrgtyTJ05Ld5wI7gPuDubfD9OWObUtSEcGtfhDxXCtuquUvGM12QufsEjCeeQ7Z/PAEvg=
X-Received: by 2002:a81:2305:0:b0:2f7:dadb:2162 with SMTP id
 j5-20020a812305000000b002f7dadb2162mr2092280ywj.42.1651837313474; Fri, 06 May
 2022 04:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-21-chenhuacai@loongson.cn> <CAK8P3a2SPTLLrZtSz0LT0LqMpq4SKCScD4vLvr+DJn+u5W_CdA@mail.gmail.com>
 <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com>
 <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
 <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com> <a6afaa3f-cb9f-2086-0e02-5ec21ba535d4@xen0n.name>
In-Reply-To: <a6afaa3f-cb9f-2086-0e02-5ec21ba535d4@xen0n.name>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 May 2022 13:41:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0xuh1aAM7iwE-jiBbR-OOF5YVfhmU0Nygbpviso3tmbQ@mail.gmail.com>
Message-ID: <CAK8P3a0xuh1aAM7iwE-jiBbR-OOF5YVfhmU0Nygbpviso3tmbQ@mail.gmail.com>
Subject: Re: [PATCH V9 20/24] LoongArch: Add efistub booting support
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3kKuw8Z9zKIZX8wYjoygIzYKmuNhyVykuNFk32CspPPPKzWZaZ/
 vZz7HsCc6h4T+l8r2NDeBOt0mALrlv0pJNaEPm0fbFc5DN0Ec7tlLl6RBAmffvmFvZ4jqhY
 ep3CKqyWVhpaOBxUfAN1ajsW0ByffWC/0uw1JFwQSZDdMwUOJ5tTjyALIe2YfdXT6xdJtSL
 hvQAIVNpZGylF2FsfVT7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NslH1lIbwxo=:Cnfd57ShCXlhhGYkGMK+HD
 HoAru0SImj9csa9RXP9VJwG5mzMN4eqOF54dXYFgY3IFkfLQ4UnDM/SKh/viKP86iw0wTRDwS
 KporuMOFJUZfO+B7qNo4LgMimx5xiEMhzpu3wV1lHoGMISrdxmCHm081LhpB3D0h1qdELPQ5a
 SxcwQqPDXG1NVoC06S5cIbLdR7JUhoIzZ3Jf59wRiRCAb3TMAuHhqK+yBFv8XBf6egf10tvU4
 2/etMN6cKuVEA28aarV6mul/mEvMrIfy9DbUJzjutRoVJ3r00ZFCtjBbR608YBwBtUV/IkRt5
 Hj+ZkxhrFDNR1IXr/azix0XQdRix2yQWqXhlk8GJK57pvygLkoFioGAjRHwBRH6f5upkepGg+
 gttEH/I+nX0S8GiXy7u7MkmWLEPkLyycGNMipAUzbfu+H0c4u9jNO9UG1Oq7LDOKXO2GcJ5iu
 SjM4jkDknL5HrzlxHZNLb2ZSkx0b2bjDCps30BduYiJEPMXfi+psROiR5kvGQGgg63/CJgD/Q
 gP1wElCblVptrpiEYwDkn+7JLj1SoSPosCVyBi8DkJLeg+ilM1BoqEQn4QANuMVymH2O3oSuP
 eNz0giC31VdwElnGFOC5DqGocUi6uPPozbWFMSn3GgiTc4iLXmp68gpjGOOR1s8eMo9AXO1DL
 s1pJk2EKyYHKVOM7RxyH8H5XZ/SJxH69/fB4itmo02kkCgKsK83v98EKWjs91I/+swLY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 6, 2022 at 1:26 PM WANG Xuerui <kernel@xen0n.name> wrote:
> On 5/6/22 16:14, Ard Biesheuvel wrote:

> Or is there compatibility at all?
>
> It turns out that this port is already incompatible with shipped
> systems, in other ways, at least since the March revision or so.

I think we can treat user space compatibility separately from firmware
compatibility.

> So, in effect, this port is starting from scratch, and taking the chance
> to fix early mistakes and oversights all over; hence my opinion is,
> better do the Right Thing (tm) and give the generic codepath a chance.
>
> For the Loongson devs: at least, declare the struct boot_params flow
> deprecated from day one, then work to eliminate it from future products,
> if you really don't want to delay merging even further (it's already
> unlikely to land in 5.19, given the discussion happening in LKML [3]).
> It's not embarrassing to admit mistakes; we all make mistakes, and
> what's important is to learn from them so we don't collectively repeat
> ourselves.

Agreed. I think there can be limited compatibility support for old
firmware though, at least to help with the migration: As long as
the interface between grub and linux has a proper definition following
the normal UEFI standard, there can be both a modern grub
that is booted using the same protocol and a backwards-compatible
grub that can be booted from existing firmware and that is able
to boot the kernel.

The compatibility version of grub can be retired after the firmware
itself is able to speak the normal boot protocol.

       Arnd
