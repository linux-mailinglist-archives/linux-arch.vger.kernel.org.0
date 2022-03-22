Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B794E3B53
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 10:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiCVJBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 05:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiCVJBr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 05:01:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5362DE97;
        Tue, 22 Mar 2022 02:00:19 -0700 (PDT)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MKsaz-1nmtPJ2Yqz-00LGhI; Tue, 22 Mar 2022 10:00:16 +0100
Received: by mail-wr1-f44.google.com with SMTP id r13so8890534wrr.9;
        Tue, 22 Mar 2022 02:00:16 -0700 (PDT)
X-Gm-Message-State: AOAM5323lrNfjkjIt385uW2kxCR0p87FIr/EhYJrs2p5XN9Ip8vA9HLR
        ONLNw+KImh2rDv5xio/5sN3LGLctfS2ErN2pWhA=
X-Google-Smtp-Source: ABdhPJz+0N9qi9MDERkBo94wRqfVEQA+BUZLonIFsmSQAIgn4FGS8f4CYsBn+NI2HJG468ewXScxwPyLNX/EnR1d1PI=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr21833938wrh.407.1647939616226; Tue, 22
 Mar 2022 02:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-4-chenhuacai@loongson.cn>
 <CAK8P3a1ST1hBnhepvoQ9UTbAM=56JEU=-OiBAFQeK2rgaZ5aWw@mail.gmail.com> <CAAhV-H7akp8RNyw=7qJPgWeApAzf0u4kBNbOHzgQN9Mx3PfzcQ@mail.gmail.com>
In-Reply-To: <CAAhV-H7akp8RNyw=7qJPgWeApAzf0u4kBNbOHzgQN9Mx3PfzcQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Mar 2022 10:00:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0WzntBkQiEK+nBrfUNw8TMyQwBQ=cQ+=3EeXLYNT+=iw@mail.gmail.com>
Message-ID: <CAK8P3a0WzntBkQiEK+nBrfUNw8TMyQwBQ=cQ+=3EeXLYNT+=iw@mail.gmail.com>
Subject: Re: [PATCH V8 11/22] LoongArch: Add process management
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KFGabE3KmUmB0m4i/4yl/TwS2C6ATJnFZbMOZ+WZLRJU8+DoTBQ
 sOM70tgz42K5PzeLtdTrm52MW74lExLaDbcTAOSGeUv7aul0QBaT9OBre6ZJxrrjDqVFGjB
 /ZsBC1l/CWq28yZDxO1jOtBqj7nc/NV3YyZRQtS/6vTQJSeAj/Vv8v+PcTh5qYgkzPfwvmU
 gvNSyAdoSVknJ8aNiao2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5JVpZtY7/U4=:gb8fRQ/fpADc4MpWQVGP5q
 9ZYv43cERUZjnocWIS0aRF9icv88LkUpGslot3EbZoQGBLkpMkiH86no9SnBnuXGzdK+z4yVb
 S3aieZOvk06AFo9u4UgArN46VSYqTWWwBlEuXkk5X+LYSE96vceNdSI3jvaXo55UnjQK3OXxX
 aYXz57aO4FwO/iXIAA3/4JLhwmhaueAhw2MTVepxCG/xM9f6t5SRJ2eKfKsJwxydtjyaiJH+Q
 +BHGKT/mwBILPFUvQyZeeRc8iOlGSt29eBtLWXcq0bwot86kUv6EEVicbD4e3JryEPrmRXWK5
 4CSB6LxNgyoKBDh677L1TOOkbuPKxHbxtmBHvF/h22BsMArVOSyctJHj8abmZGZFUCrqNhvBn
 1DA66U86/+21f7eJfk0j/QbWoyfpCBYZYsvxm/yOxcX50w5KZWuW8jzec1AThu1u9F3UjCGxB
 DJsKXls9/yGbYjK168pWXojyJ0Lh0oIrZFI3dPpFX0twqHiT5T0ris/HhdqIckLrfN2lejvtO
 KSVG3AGsgAYIlz6+IH1J5SUtix7feVPqXWI9KQWsWV7fcF2uw4z2jUtkl2DrAV82QwXZCrfjL
 //E7idE8wykGDTSpl/Dlegafot1YgrBH+1eLqhYleHL6Wh06oUBbn3lK9SItwWvwhz5xAwSBN
 mRX0FrRD6+q+WwLaMnjtPCkuTeqIbVzGtrnq36zO60uu1MlmtkgTCfgIi0UBxLc4bZ0fukJoz
 lqqQQrBkrbXtvcXasPy53POG39dYC+0ZecgIjnCM23xlkAyuKrsQdsS5RVy05KsTLIXWVnYxv
 u12szQQj/6xMXggBf/cxMW3e87u2lN4wlaCATpI1LwOu64RDGc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 4:07 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Mon, Mar 21, 2022 at 4:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > > +#ifdef CONFIG_PAGE_SIZE_64KB
> > > +#define THREAD_SIZE_ORDER (0)
> > > +#endif
> > > +
> > > +#define THREAD_SIZE (PAGE_SIZE << THREAD_SIZE_ORDER)
> > > +#define THREAD_MASK (THREAD_SIZE - 1UL)
> > > +
> >
> > Having a 64KB stack area is rather wasteful. I think you should use a sub-page
> > allocation in this configuration, or possibly disallow 64KB page configuration
> > entirely.
> >
> > Note that you have to use full pages when using CONFIG_VMAP_STACK, but
> > you don't seem to support that at the moment, so allocating only 16KB stacks
> > on a 64KB page config should still work.
> I think using a 16KB stack for all configurations (4KB/16KB/64KB) is
> the simplest way. Right?

Yes, I agree. 16KB is what almost all 64-bit architectures use, though when
you add 32-bit support that can probably be limited to 8KB like most others.

As a side note, you should definitely consider supporting both separate
IRQ stacks and CONFIG_VMAP_STACK if you don't do that already.
Running with those two enabled makes the kernel more robust both
against accidental stack overflow and against malicious code that
attempts to abuse a potential overflow code path.

        Arnd
