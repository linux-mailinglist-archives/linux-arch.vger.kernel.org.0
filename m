Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF8515C55
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiD3Kvt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiD3Kvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 06:51:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD295499;
        Sat, 30 Apr 2022 03:48:21 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwQKp-1o1BTC1i8j-00sOOA; Sat, 30 Apr 2022 12:48:19 +0200
Received: by mail-yb1-f177.google.com with SMTP id d12so18534069ybc.4;
        Sat, 30 Apr 2022 03:48:19 -0700 (PDT)
X-Gm-Message-State: AOAM5339bAUwu+qUmnymsiXelobcYRZ1ShdCZtZ4E43aMBum0im16TmY
        fOMttPf5ZHiG4Zrw+J03x3l7RgOVwbx2PD3YWpY=
X-Google-Smtp-Source: ABdhPJwpzn9EC0RwN/J7S1C0YhM4S7/xT03EODVmCgkuoTRktIMKwUMUL90gkxIf9qXlOUH0npNethOfeHG9D6/pL7I=
X-Received: by 2002:a25:c50a:0:b0:647:b840:df2c with SMTP id
 v10-20020a25c50a000000b00647b840df2cmr3193581ybe.106.1651315335679; Sat, 30
 Apr 2022 03:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-17-chenhuacai@loongson.cn> <CAK8P3a097Z_DKXbrLrCB7JZUB0J0duSmZRHSJkjRM5=rteit6g@mail.gmail.com>
 <CAAhV-H4COmSy1RNBKi1XCDerAhiQb1Z=g4rEmBz4xgLkSpKmmA@mail.gmail.com>
In-Reply-To: <CAAhV-H4COmSy1RNBKi1XCDerAhiQb1Z=g4rEmBz4xgLkSpKmmA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 12:41:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Cnp-SNiXnSbnUdbw9jC+aT1TxEjckK2jFYgwT-CSpcw@mail.gmail.com>
Message-ID: <CAK8P3a1Cnp-SNiXnSbnUdbw9jC+aT1TxEjckK2jFYgwT-CSpcw@mail.gmail.com>
Subject: Re: [PATCH V9 16/24] LoongArch: Add misc common routines
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7KAKj9I+D5At570gbNGr3cglDF4vT1MGlSQ6gRQI5WKGPBqqhXN
 rSU6LIxKBM1mX77Y49GAJ8oHRNK+f0d+75I0IM7hXJA/mG2wEKp/N21qMfcYH4qAtWF/aJ8
 E7VlGyPy8xSrlCcULZ69Iv5lVOIKmquTHlildb4eU77VSFUQoBBPf1qoRtAdhoKkPVavx/m
 oWqYr89xL8luxaH9PC9tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:avuFvZTkDnI=:LCL8ARtw02iWBlwVmCDdwM
 GGOqcejykQPT9n5mOtxsKPpB2xclvbwZzOigMweQE/nQw7Sn3lypQ6mLCYJPFZlyOX4BGXY+f
 01XmYuuvoHgUw8bjiLbvGXk/tzbzOXCmCYuPvIBz9QiM1jfYsXNNOaFDeaSRI6ahRjuPbt1zg
 fkiPa2/pN53poTpZzdKWYSWC3QAboSTUq1lCeHLbhVQdeZ+/1L/1EeF94WVtMcZ+ejpyb956d
 I4wsN+iwFWSDpmuuw0GjDZE+0rduO/GmvK1etFFgM9IYrcPfUfcL9QUbvPMrJ5UDM/Wknc8JP
 s7fJBtRzEB9UJ67NbhkEyqLknEvv8DpQbduELrQgKFwdqbDRuO8dI2LGyEQc8suE2nfKPkB9l
 StyMPhfdBmGsoF6ZLjYaYnFTeT5bg/oTdKEWcrn0a+EZDzlGAqYfdsE9oOxJ9Y8WnqPSwW58O
 QtsyYF0OfBW+Gq1HBKxyVddgXeH3fb9di/zFJNhevnMcUci/LsEjYspUTct9tJ1SEFY60nTSB
 dJ4yBE0mfD3dlUwrOswqdV8mlIQp2uj/99oe1FyoBC0Z/oFV9Je12MnKCfl4q4aXAl8tCp2pO
 bi38wW5mNT69macSgvUB6Pi9XyzPJhzhO88qAUafoOCgzpD3+/0lis7CAsAIXw9+AuGGkLI+p
 gySBbeHZWOtRLxveU/iLs9eoay50Z6xxHKZ2K+RthSzL31OxeNVw0YhRK6jz7n3ukilHNCrPH
 XKeR9XDGhngrb6Th0Pn5dgDNRiqGX20I0GCNoMS7xol8kQ8rje6CdnUoTDTMG0tF/2UeIWatb
 ZALBjQqmus19tgo6NpzjVvBO723wFjqqFPAg4uJWsVFSyQ/hS/cToPgz1Z9GNeY28GKSGZR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 12:00 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>
> On Sat, Apr 30, 2022 at 5:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > > +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> > > +{
> > > +       u32 old32, mask, temp;
> > > +       volatile u32 *ptr32;
> > > +       unsigned int shift;
> > > +
> > > +       /* Check that ptr is naturally aligned */
> >
> > As discussed, please remove this function and all the references to it.
>
> It seems that "generic ticket spinlock" hasn't been merged in 5.18?

No, but we can merge it together with the loongarch architecture for 5.19.

I suggested you coordinate with Guo Ren and Palmer Dabbelt about how
to best merge it. The latest version was pasted two weeks ago [1], and
it sounds like there are only minor issues to work out and that I can merge
v4 into the asm-generic tree before merging the loongarch code in the
same place.

     Arnd

[1] https://lore.kernel.org/lkml/20220414220214.24556-1-palmer@rivosinc.com/
