Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B457853AAA5
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiFAQCe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355949AbiFAQC2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 12:02:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3135274;
        Wed,  1 Jun 2022 09:02:24 -0700 (PDT)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MtfRv-1nf1hg15eJ-00v4pu; Wed, 01 Jun 2022 18:02:23 +0200
Received: by mail-yb1-f169.google.com with SMTP id h75so3728550ybg.4;
        Wed, 01 Jun 2022 09:02:22 -0700 (PDT)
X-Gm-Message-State: AOAM53108KG6iiqKAualLgD4qXUEQ+1v7Jcd0CuhJeZhkOV5ystJH0zO
        XZTuC7mBR03nWpXD/GJ1J7ejo0Lmj24iHh+B8ok=
X-Google-Smtp-Source: ABdhPJxXBt6t9Kpb18+45Z/4gGcabfaHsQkc7yNqpiwzF/WmyhE92OTDPGbAW+JZrCLtodw8qttgNxuQpK4z7UBz8ME=
X-Received: by 2002:a25:1209:0:b0:65d:63f9:e10a with SMTP id
 9-20020a251209000000b0065d63f9e10amr453686ybs.480.1654099341931; Wed, 01 Jun
 2022 09:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-8-chenhuacai@loongson.cn> <ddf17a99-5c68-4be9-d073-124538b9d51e@infradead.org>
In-Reply-To: <ddf17a99-5c68-4be9-d073-124538b9d51e@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jun 2022 18:02:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3j1h2h_yWN7oaBPx7Z-WaJs-rMupWo3Q4UUTAi2m3tqQ@mail.gmail.com>
Message-ID: <CAK8P3a3j1h2h_yWN7oaBPx7Z-WaJs-rMupWo3Q4UUTAi2m3tqQ@mail.gmail.com>
Subject: Re: [PATCH V12 07/24] LoongArch: Add build infrastructure
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BnZSg9eP17vALy19M2awOWIxYR0CHSN2wN9tVTWraj70vTg7PDz
 5jBCc0CvVUjRqX2arSMKOyJUhsaUaqT0ZXy2B0NFFfprFlrsGJN2RLFwkHb5LHgzlu2jVTR
 uan3XtADusSD5xIOuzWTtXg5GmPHGqXnncQO9lO6+uXIqu+sW0oFslEWFQM97Ae9x1hg3UO
 v0709KNMn6xVBVGouiyIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqQ1xqz9yt0=:h+mWvQkrrAW4wJnju2cd4X
 QC0/D2jjFnn9AmEZBkBwfPfc560lzeCKoiS/JOatuaxOQwP9w4gnwuIW7a/IMqIUWtfjteWAQ
 xL0e4SsT88Spk6jqzSJRDVityxj43JyiednDwFfV8wHC6tpuqLv2uR1hlJqy+lwAwk4mryIGA
 NY5kk5lnviqA+buxefNgJSIgTn1/ISkQFqi5AS/6xkvTskIFUb/cxzIEqYPDvKfdhIoHJq79s
 HqX0JGjZsCPz0l60Co6Sk21DNAdyGlXvYFFhjDj1eRTyux6fAt9k4alGVWMCZqGBYljNao0sF
 BOSbY/mCXOqBwWzeXffUxEpm4QKVSl6dGVVp0eHZ8BitCDEVaBdonLP4Y2ks7Fa1UgxDMBF4t
 6Fhd6qhJTWB7FGrBs/RzOPgc/hAN2iMcuq1A6HHCABcXEuLMmBeN+X95dT6rLJflyPPalvTPI
 eI1F5pIokoDWxWHWyKtj474sSRr4dsO1IJt1ap1qoKyoWC5Paryn6xJV6F+Dk4t4dezIS5vMQ
 swXymtE1JvkArm1yUMlAYx4kkwFFEqEHFM2iKhExzibzYS3ZTWrLAJlCL2nB9l9z8zAZ+6OXa
 +6AK6fyVe9kiqYhLIFCNpqgMYlTMRGI368ETn2o1U7CWe+r+PHFkVg6Vy+1a6XD6Y6erKqMXC
 oDlOg2sKZ8vH9AMfSnwNUncM3q0XDjwaNxO7o4bDsSBnz+Jact96T4zKh86P0HHoFvKkeR2d+
 0utV9DRqJX4rjZ8+LVrS0IPve41grQw2AzcNPw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 1, 2022 at 5:47 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 6/1/22 02:59, Huacai Chen wrote:
> > +config 32BIT
> > +     bool
> > +
> > +config 64BIT
> > +     def_bool y
> > +
>
> I don't see a way to set (enable) 32BIT.
> Please explain how to do that.

It can't be enabled at the moment, but support is planned for a future release.
There are remnants of the 32-bit support in various places of the codebase,
but removing those just to add them back later does not seem too important.

         Arnd
