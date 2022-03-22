Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B11D4E3739
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 04:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiCVDF1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 23:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiCVDF0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 23:05:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB1F55AA;
        Mon, 21 Mar 2022 20:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E583B817C1;
        Tue, 22 Mar 2022 03:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E601DC340E8;
        Tue, 22 Mar 2022 03:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918236;
        bh=1icat6y1B92fIa7Mnw0eafB0AwEwehWLJT5Pq35XCCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WKgkcoO0JwbTz/5OdeN+48vs/f65YJm7psOdaDm7ipUWWoQiSthPmp7P/D7mi9Fhf
         N/DoHm2uHVDtIz5pKXEckLmR9LyVcxNIVunqUIstbYHQFsQ+063/3hS2NsiXRka6Vn
         3EjZeHCg7/UFHvEahmLxs7yxr4RKhm0ndAppsE+l3jYeTp++vegujH1MA/9+POiftc
         5kSP8qVcR5DNtGkrmUE8YtEkTkPdFJiA1wRlyHSLC7j8HVMfUxpHZN5qlC/lrcF9vM
         xmqrSASvSwvb0K2WjDXT75akJ1GDJ4HHFZT9w51JLgzkykHACuVJATvpqVlut+Xbt2
         jEnUADaPHdQWw==
Received: by mail-vs1-f51.google.com with SMTP id y198so1297238vsy.10;
        Mon, 21 Mar 2022 20:03:56 -0700 (PDT)
X-Gm-Message-State: AOAM531m1I0Qs926xC9UoVb4uYWX61o0uIF86s0NJxw6X5kbL1N7nW/h
        RhPRCiKlY+1XwsmGKd7BlfE4J3T5INXXQfAVAb8=
X-Google-Smtp-Source: ABdhPJyVTPBTmd5lFxhb6dcac1UnuIJKVKYYEdTci8phgh/CzGhQXvOXWe75x7bP2X532SZf+eN0JVFUslz8wLuIa9k=
X-Received: by 2002:a05:6102:5490:b0:325:2ca5:14f with SMTP id
 bk16-20020a056102549000b003252ca5014fmr1737056vsb.40.1647918235954; Mon, 21
 Mar 2022 20:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143130.1026432-1-chenhuacai@loongson.cn> <20220319143130.1026432-7-chenhuacai@loongson.cn>
 <CAK8P3a0wVKWFASv6cVDOZmX=1h7EeAVyrxLFXmoH5REVaAoNhQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0wVKWFASv6cVDOZmX=1h7EeAVyrxLFXmoH5REVaAoNhQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Mar 2022 11:03:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6zddef+ezmXhK+K3eZtvVECqq-nujyr9H2RjS1iJndrg@mail.gmail.com>
Message-ID: <CAAhV-H6zddef+ezmXhK+K3eZtvVECqq-nujyr9H2RjS1iJndrg@mail.gmail.com>
Subject: Re: [PATCH V8 07/22] LoongArch: Add atomic/locking headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Huacai Chen <chenhuacai@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Mar 21, 2022 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 19, 2022 at 3:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > LoongArch has no native sub-word xchg/cmpxchg instructions now, but
> > LoongArch-based CPUs support NUMA (e.g., quad-core Loongson-3A5000
> > supports as many as 16 nodes, 64 cores in total). So, we emulate sub-
> > word xchg/cmpxchg in software and use qspinlock/qrwlock rather than
> > ticket locks.
> ...
> > +extern unsigned long __xchg_small(volatile void *ptr, unsigned long x,
> > +                                 unsigned int size);
> > +
> > +static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> > +                                  int size)
> > +{
> > +       switch (size) {
> > +       case 1:
> > +       case 2:
> > +               return __xchg_small(ptr, x, size);
> > +
>
> I think it's better to not define the "small" versions at all, since they are
> inefficient and probably not safe to use for the few things that try to call
> them, such as the qspinlock implementation.
>
> I have an experimental patch set that removes these from the kernel
> altogether and makes xchg()/cmpxchg() only work on 32-bit or
> 64-bit values.
>
> > diff --git a/arch/loongarch/include/asm/spinlock.h b/arch/loongarch/include/asm/spinlock.h
> > new file mode 100644
> > index 000000000000..7cb3476999be
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/spinlock.h
> > +
> > +#include <asm/processor.h>
> > +#include <asm/qspinlock.h>
> > +#include <asm/qrwlock.h>
> > +
>
> There is a patch series from Peter Zijlstra, Palmer Dabbelt and Guo Ren
> that is currently under review for risc-v and csky, to add a generic ticket lock
> implementation that does not rely on sub-word atomics [1]. I think we
> also want to convert mips, xtensa, openrisc, and sparc64 to use that,
> since they have the same issue with the lack of 16-bit atomics.
>
> Please coordinate the inclusion of the patches with them and use that
> spinlock implementation for the initial merge, to avoid further discussion
> on the topic. If at a later point you are able to come up with a qspinlock
> implementation that has convincing forward-progress guarantees and
> can be shown to be better, we can revisit this.
In my opinion, forward-progress is solved in V2, since we have
reworked __xchg_small()/__cmpxchg_small(), and qspinlock is needed by
NUMA.
However, if the generic ticket lock is merged later, I will try to use
it at present.

Huacai
>
>       Arnd
>
> [1] https://lore.kernel.org/lkml/20220319035457.2214979-1-guoren@kernel.org/
