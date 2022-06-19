Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67149550BDE
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jun 2022 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiFSPi3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jun 2022 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiFSPi3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jun 2022 11:38:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA0646B
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 08:38:27 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s17so2631077iob.7
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tM8O+xkuaCIyuZXLINVOSy+TYLUrRj5V+dI6D9B0EI=;
        b=JKWzm9GaEyXFJ5CP8b9pr/tNfyo0L6CtnOYtwyPeiMJcCtG2jLofIDUCFvYlIxjd+Q
         V4QfrLXtQqXuDWXdTufDECD6pO1MYSEc9rXabsTR1zjl0z0BqBPCHH9jGtgK2yJksx0w
         eBiK6JCWHF8ATM7dLQLheO4VGpkQGeIP7Y0C8a0ktiJ/k5ugJFnb3gkfMz3ZcJ55xQ4A
         oZVoJivg3hSVTIMMnWoc7DrtfxL/uVOaXz7sTLcZRsWWtPV4TQKq8A3pd8eD91gE4HDN
         xUJuPnlSMJMQmOeZmxNXUK20OQ7XDWJ1k9lfGT2c9oPXDz4TKZzAq5dZZzBn9/+XY9iE
         GQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tM8O+xkuaCIyuZXLINVOSy+TYLUrRj5V+dI6D9B0EI=;
        b=tdFdmDWYBEIaPvdrwpupieq17wwZOTcGl8GAGvQeT9nsaawMYp3guW/a4HiBwjJjLL
         YxCEXny7xeCAQuqc3NP2l2krEBy/aK8tOHzujd8p9pLTf4kIQx5R98BjhWpJJbEnIok5
         dojjlT5FY/TDTLzMpdoO8NnhZ9HdUutmvPC3bTV8hvX8T2Uo6+iEdLJOvFmS+KTKp+nH
         947DkaLSB7G69lRzI7gczmmsoK6YMj+wk0TO70hZPVcT9l2hu2EE6061EGm6Bu37urEC
         hK+7z6ZhP2nrycO+c2x+aZeBWVlFTop2Qk8MZp+Jm1H64/Q+Du7L/MsU0pYkpjTXAgW0
         7ViQ==
X-Gm-Message-State: AJIora++hEQS8y0+Z7/q8HAtb2LHgIvJ6cz/NMM2XWpSOuqcwWQPDhzz
        HkQ0QRxlxmRjMU6SdrxYeGw3oiu2yXZR0dwpXPPHmQ==
X-Google-Smtp-Source: AGRyM1sSstpRHPKLkSjZ24IwBRJKywWh28xqzFAmxMukDjmYUY342goiYySEJKHCHp/aDaomOBbxLied3A8JISuA26c=
X-Received: by 2002:a05:6602:1212:b0:669:d627:acf4 with SMTP id
 y18-20020a056602121200b00669d627acf4mr9637501iot.82.1655653107109; Sun, 19
 Jun 2022 08:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
 <bcc38a55-30dc-98a8-cbfc-5a51924b9373@xen0n.name> <CAHirt9goPWs-_EpSpUOY4DWpK1nbaJxM2rSM3oLUqnCh5fVi4Q@mail.gmail.com>
 <CAJF2gTQbb_RmF6Hn5E91waamecRZ+B7FRxo_GT23wkc0ydN4ug@mail.gmail.com>
In-Reply-To: <CAJF2gTQbb_RmF6Hn5E91waamecRZ+B7FRxo_GT23wkc0ydN4ug@mail.gmail.com>
From:   hev <r@hev.cc>
Date:   Sun, 19 Jun 2022 23:38:16 +0800
Message-ID: <CAHirt9jJpX0N=z1mLJtvsdsv7hPqAX+t+Eg1nr-_QQRLrt5wuw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 19, 2022 at 11:06 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Jun 19, 2022 at 12:28 PM hev <r@hev.cc> wrote:
> >
> > Hello,
> >
> > On Sat, Jun 18, 2022 at 8:59 PM WANG Xuerui <kernel@xen0n.name> wrote:
> > >
> > > On 6/18/22 01:45, Guo Ren wrote:
> > > >
> > > >> I see that the qspinlock() code actually calls a 'relaxed' version of xchg16(),
> > > >> but you only implement the one with the full barrier. Is it possible to
> > > >> directly provide a relaxed version that has something less than the
> > > >> __WEAK_LLSC_MB?
> > > > I am also curious that __WEAK_LLSC_MB is very magic. How does it
> > > > prevent preceded accesses from happening after sc for a strong
> > > > cmpxchg?
> > > >
> > > > #define __cmpxchg_asm(ld, st, m, old, new)                              \
> > > > ({                                                                      \
> > > >          __typeof(old) __ret;                                            \
> > > >                                                                          \
> > > >          __asm__ __volatile__(                                           \
> > > >          "1:     " ld "  %0, %2          # __cmpxchg_asm \n"             \
> > > >          "       bne     %0, %z3, 2f                     \n"             \
> > > >          "       or      $t0, %z4, $zero                 \n"             \
> > > >          "       " st "  $t0, %1                         \n"             \
> > > >          "       beq     $zero, $t0, 1b                  \n"             \
> > > >          "2:                                             \n"             \
> > > >          __WEAK_LLSC_MB                                                  \
> > > >
> > > > And its __smp_mb__xxx are just defined as a compiler barrier()?
> > > > #define __smp_mb__before_atomic()       barrier()
> > > > #define __smp_mb__after_atomic()        barrier()
> > > I know this one. There is only one type of barrier defined in the v1.00
> > > of LoongArch, that is the full barrier, but this is going to change.
> > > Huacai hinted in the bringup patchset that 3A6000 and later models would
> > > have finer-grained barriers. So these indeed could be relaxed in the
> > > future, just that Huacai has to wait for their embargo to expire.
> > >
> >
> > IIRC, The Loongson LL/SC behaves differently than others:
> >
> > Loongson:
> > LL: Full barrier + Load exclusive
> > SC: Store conditional + Full barrier
> How about your "am"#asm_op"_db."?
>
> Full barrier + AMO + Full barrier ?

Yes. AMO without '_db' is relaxed.

hev
