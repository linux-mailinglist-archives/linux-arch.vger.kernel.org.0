Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D074746E7C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGDKYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 06:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjGDKYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 06:24:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0175135;
        Tue,  4 Jul 2023 03:23:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991ef0b464cso980836466b.0;
        Tue, 04 Jul 2023 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688466238; x=1691058238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vx7ppah8AFGnktLnnie0w36X7NdKzmPV1iXgMAT5r4s=;
        b=mOwGBPhiUibe9TZEveAD5uwTEzZO42X9132eJViv6MRt+PGT9b5GJMp5GwYq7tV296
         vsqRJpvLfzby4/86k//5QIA5DHCQdyL8tawK4VrDht4jCbFfP6nSi/mx8DyFGlqQ8ar5
         1jSxs6wI61xswGUk2RQwyh8WuHWiwzPuEFF/KpNMRkaXAM7RhbTrnXaqs4x3RZQR0gKP
         /KKfv0mm92IddImVSz+aZ9cBN4qn5gjpBw2ZfOUe3Df1KzcFIXSKyC2z0E3VxwoJbdzw
         NrvthTtklqwh1ZBSsYNuj2Nuv6aeNsi72NbC8TEotLJ55UI4etsuJdyqfjPWdy/yrmg/
         gTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688466238; x=1691058238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vx7ppah8AFGnktLnnie0w36X7NdKzmPV1iXgMAT5r4s=;
        b=ViONMvyYl5hMuiezcFknb+BronyhMACWUzP9NntLuLQBhsgUhEOaEL83RBTLiCk1Bm
         FiPDn0xJnG/kFZPapQaWXmlxGkKpBgvtHmpV4wLaHX6KzmiokFFAztvtvVTY4jlXTtLu
         1CLjdaY/UH7jmlJfALqyCZAqQnrObR2QBy8lvntWBHxqCweKZWqQxjMgp8hd6du0rOK/
         xbUp6E+Se155QP3E7RGzPPVc4HkArw0Wn0fDxDDP80kLdRS/V6/61b7+jB/yex5Vj2Fc
         df0hRv4QMqSCFdrGixluLy0HCMPpl4ustxjGWVoLRpMGcwTntx/jrBQ1P8wIxrWeNHgP
         ZURw==
X-Gm-Message-State: ABy/qLZvPgToqlExv8qIifdrItxbTqB/zIB+VuIvaWctFzWHxDH12YIz
        gOT0j9RFt/dyazy8Rd/uQryImQDmA1+lFBmqyRI=
X-Google-Smtp-Source: APBJJlEAlGOxHf9AN/Vw4ySd7uIusXyxdktq7C6hpD1W72WxF0+WYXaZ3XEi4FK7aHV0ixLwVlFpErv9bnrqsTnnl+4=
X-Received: by 2002:a17:906:c3a4:b0:98d:4ae:8db9 with SMTP id
 t36-20020a170906c3a400b0098d04ae8db9mr11136259ejz.19.1688466238030; Tue, 04
 Jul 2023 03:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <87ttukdcow.fsf@laura> <20230704094627.GS4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230704094627.GS4253@hirez.programming.kicks-ass.net>
From:   Jonathan Wakely <jwakely.gcc@gmail.com>
Date:   Tue, 4 Jul 2023 11:23:46 +0100
Message-ID: <CAH6eHdQQWO2AYQRXnAATt6nvcyDjKj-_5Ktt2ze6F158hBon=Q@mail.gmail.com>
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Olivier Dion <odion@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rnk@google.com, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 4 Jul 2023 at 10:47, Peter Zijlstra wrote:
>
> On Mon, Jul 03, 2023 at 03:20:31PM -0400, Olivier Dion wrote:
>
> >   int x = 0;
> >   int y = 0;
> >   int r0, r1;
> >
> >   int dummy;
> >
> >   void t0(void)
> >   {
> >           __atomic_store_n(&x, 1, __ATOMIC_RELAXED);
> >
> >           __atomic_exchange_n(&dummy, 1, __ATOMIC_SEQ_CST);
> >           __atomic_thread_fence(__ATOMIC_SEQ_CST);
> >
> >           r0 = __atomic_load_n(&y, __ATOMIC_RELAXED);
> >   }
> >
> >   void t1(void)
> >   {
> >           __atomic_store_n(&y, 1, __ATOMIC_RELAXED);
> >           __atomic_thread_fence(__ATOMIC_SEQ_CST);
> >           r1 = __atomic_load_n(&x, __ATOMIC_RELAXED);
> >   }
> >
> >   // BUG_ON(r0 == 0 && r1 == 0)
> >
> > On x86-64 (gcc 13.1 -O2) we get:
> >
> >   t0():
> >           movl    $1, x(%rip)
> >           movl    $1, %eax
> >           xchgl   dummy(%rip), %eax
> >           lock orq $0, (%rsp)       ;; Redundant with previous exchange.
> >           movl    y(%rip), %eax
> >           movl    %eax, r0(%rip)
> >           ret
> >   t1():
> >           movl    $1, y(%rip)
> >           lock orq $0, (%rsp)
> >           movl    x(%rip), %eax
> >           movl    %eax, r1(%rip)
> >           ret
>
> So I would expect the compilers to do better here. It should know those
> __atomic_thread_fence() thingies are superfluous and simply not emit
> them. This could even be done as a peephole pass later, where it sees
> consecutive atomic ops and the second being a no-op.

Right, I don't see why we need a whole set of new built-ins that say
"this fence isn't needed if the adjacent atomic op already implies a
fence". If the adjacent atomic op already implies a fence for a given
ISA, then the compiler should already be able to elide the explicit
fence.

So just write your code with the explicit fence, and rely on the
compiler to optimize it properly. Admittedly, today's compilers don't
do that optimization well, but they also don't support your proposed
built-ins, so you're going to have to wait for compilers to make
improvements either way.

https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/n4455.html
discusses that compilers could (and should) optimize around atomics
better.

>
> > On x86-64 (clang 16 -O2) we get:
> >
> >   t0():
> >           movl    $1, x(%rip)
> >           movl    $1, %eax
> >           xchgl   %eax, dummy(%rip)
> >           mfence                    ;; Redundant with previous exchange.
>
> And that's just terrible :/ Nobody should be using MFENCE for this. And
> using MFENCE after a LOCK prefixes instruction (implicit in this case)
> is just fail, because I don't think C++ atomics cover MMIO and other
> such 'lovely' things.
>
> >           movl    y(%rip), %eax
> >           movl    %eax, r0(%rip)
> >           retq
> >   t1():
> >           movl    $1, y(%rip)
> >           mfence
> >           movl    x(%rip), %eax
> >           movl    %eax, r1(%rip)
> >           retq
>
