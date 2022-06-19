Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DB6550872
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jun 2022 06:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiFSE22 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jun 2022 00:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiFSE2X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jun 2022 00:28:23 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803FB1EF
        for <linux-arch@vger.kernel.org>; Sat, 18 Jun 2022 21:28:19 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j9so1218890ilr.0
        for <linux-arch@vger.kernel.org>; Sat, 18 Jun 2022 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40/WI875nuyCI9z3V/fsTibM7HMNns0n2ceN1/6cSE8=;
        b=Y4csF/qMNgR8GImvH1LrZLE491Jdlz9yO6Afk3BwI2psEIZyKcaNGBE1xl+/NuLZs6
         AJpPEKMiyz7jjsG8p5QoKr2u7wyHzjog9ae+MaK7H1DfLax8okjHvAaVZmtqznncmTXZ
         PidK0t5GYpmtAOycLaOCaG7xbq2RwIGc1yH6C6jcSY1qeoq2BqB8ToHgDbFmUg05cgzB
         q8jNEP6ts7JTRmeJ1LgYt2hKuXsTDMBQQQeT9jp6H5rX/xg1r2E1zCA7bHhctUfDqN+G
         FgjBWT7GgLCRw01MfgwXo3T2JcQ/oMw4LTUwh2yguhqPaACOaItQEMmkuhq1usvIyAPf
         euUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40/WI875nuyCI9z3V/fsTibM7HMNns0n2ceN1/6cSE8=;
        b=qd/FKt9wujwzmyIg9IcBGpdNClm54WSsP/VBcy5IsQv/DF/Z27heRS/HUgEokVgOh9
         Vf60XEUBiKml1mAHEtfFDmTSO3yyn7QL+ykrxgCL9TdcI8E9rA7B8DmDPXiYt3/50lSP
         rKiAJAT51qFIgjHU6iI1LaCueDoNnBW3XbrwY5f5dyyy4yc/mGw2rbP/beSs9Zy1UTnK
         1zvZ0XkjrbSb0M6VIJExkdEFqXXShnKWZd3ULOFNw5zdgrwe0zrDHuPakKk79mLEBRL4
         UBLbQ47bpIla5c1xxQA+Lxx6OY2bpfb+sP7kPGlJfi6TbVvnGfqZF3yLTs+eRI1d01aj
         zlEQ==
X-Gm-Message-State: AJIora/bKaCP43jlBMLygqfdPUFG5tfGHFb/tDUp+BdigFtWHxS/oExv
        vIvZq7Rwim8JqkcTturOQY1UpYwxa0Q6HhjcjAfIdfVHkaHzaWZK
X-Google-Smtp-Source: AGRyM1sr2Yr7XchAcGFeWgt5Lyh+6Nfa0k2CQiJom6AlN4aDw6Cmjqu8x9HNvbbJVuzVDsp8QN4PRFsL2Dd4mYZDjPo=
X-Received: by 2002:a92:d90c:0:b0:2d9:54f:85f7 with SMTP id
 s12-20020a92d90c000000b002d9054f85f7mr977875iln.157.1655612899119; Sat, 18
 Jun 2022 21:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com> <bcc38a55-30dc-98a8-cbfc-5a51924b9373@xen0n.name>
In-Reply-To: <bcc38a55-30dc-98a8-cbfc-5a51924b9373@xen0n.name>
From:   hev <r@hev.cc>
Date:   Sun, 19 Jun 2022 12:28:08 +0800
Message-ID: <CAHirt9goPWs-_EpSpUOY4DWpK1nbaJxM2rSM3oLUqnCh5fVi4Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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

Hello,

On Sat, Jun 18, 2022 at 8:59 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 6/18/22 01:45, Guo Ren wrote:
> >
> >> I see that the qspinlock() code actually calls a 'relaxed' version of xchg16(),
> >> but you only implement the one with the full barrier. Is it possible to
> >> directly provide a relaxed version that has something less than the
> >> __WEAK_LLSC_MB?
> > I am also curious that __WEAK_LLSC_MB is very magic. How does it
> > prevent preceded accesses from happening after sc for a strong
> > cmpxchg?
> >
> > #define __cmpxchg_asm(ld, st, m, old, new)                              \
> > ({                                                                      \
> >          __typeof(old) __ret;                                            \
> >                                                                          \
> >          __asm__ __volatile__(                                           \
> >          "1:     " ld "  %0, %2          # __cmpxchg_asm \n"             \
> >          "       bne     %0, %z3, 2f                     \n"             \
> >          "       or      $t0, %z4, $zero                 \n"             \
> >          "       " st "  $t0, %1                         \n"             \
> >          "       beq     $zero, $t0, 1b                  \n"             \
> >          "2:                                             \n"             \
> >          __WEAK_LLSC_MB                                                  \
> >
> > And its __smp_mb__xxx are just defined as a compiler barrier()?
> > #define __smp_mb__before_atomic()       barrier()
> > #define __smp_mb__after_atomic()        barrier()
> I know this one. There is only one type of barrier defined in the v1.00
> of LoongArch, that is the full barrier, but this is going to change.
> Huacai hinted in the bringup patchset that 3A6000 and later models would
> have finer-grained barriers. So these indeed could be relaxed in the
> future, just that Huacai has to wait for their embargo to expire.
>

IIRC, The Loongson LL/SC behaves differently than others:

Loongson:
LL: Full barrier + Load exclusive
SC: Store conditional + Full barrier

Others:
LL: Load exclusive + Acquire barrier
SC: Release barrier + Store conditional

So we just need to prevent compiler reorder before/after atomic.
And this is why we need __WEAK_LLSC_MB to prevent runtime reorder for
loads after LL.

hev
