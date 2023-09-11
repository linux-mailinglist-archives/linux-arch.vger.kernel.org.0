Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E8379A1A1
	for <lists+linux-arch@lfdr.de>; Mon, 11 Sep 2023 05:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjIKDKR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjIKDKQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 23:10:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0439D103;
        Sun, 10 Sep 2023 20:10:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A514C43395;
        Mon, 11 Sep 2023 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694401811;
        bh=UONvhmizn0JJhF+HaALbacTSzlI5SR6Is+F9ac10n7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C6RvUKn4NRYtphWoqfwaddafP0zABGlMvpxOoSnLUI6Y/ROq6HSQrhQG/jwc/oV9R
         UYXqZweYL0YYfBgtBO1SYP81TJJfLl54UfWKfPZ/E8kD+wyqeNDzvyvN+QMP9sMC6O
         1qATIkJ5YjPAGZXg7sxkkLYdqSvQBn9KaKqX3GVGxhhUCBMpVe54CMJZ4Qz2pIxkII
         LRjry0c01jnCWvarBpA/cmMGgPZlGCeVpJXsE94yF2bcDzEC5zvX1tk/AZ5lMzBBTy
         F1bfSEe5HzGa+zQNFY+Dv2+V/6bIiCu0ywQB73nfOLvYqo0FrzXW1C6sCi5jdYJams
         aChRK7d+p6JrQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso512900866b.2;
        Sun, 10 Sep 2023 20:10:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPAzCBv3SS8gTjIJrEdhJF5RdCUZWAaMbtJ71lASG+5aXZgNCi
        SB1gfardIZCujhgEMol+uvHOVCqSkl9Ua8Jl8LY=
X-Google-Smtp-Source: AGHT+IEXrD5I7ibaP2mQt3kJW4nPV6v0QD/O5Y3rF3MfAruuPpiiUMuOKBJ5qG3F9j3sqa55PILnojVoXbzY49w8TF8=
X-Received: by 2002:a17:907:7795:b0:9a1:db97:62a1 with SMTP id
 ky21-20020a170907779500b009a1db9762a1mr6313893ejc.46.1694401809871; Sun, 10
 Sep 2023 20:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
In-Reply-To: <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 11 Sep 2023 11:09:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
Message-ID: <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number
 of cpus >= 16k
To:     Waiman Long <longman@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11, 2023 at 10:35=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
>
> On 9/10/23 04:28, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The target of xchg_tail is to write the tail to the lock value, so
> > adding prefetchw could help the next cmpxchg step, which may
> > decrease the cmpxchg retry loops of xchg_tail. Some processors may
> > utilize this feature to give a forward guarantee, e.g., RISC-V
> > XuanTie processors would block the snoop channel & irq for several
> > cycles when prefetch.w instruction (from Zicbop extension) retired,
> > which guarantees the next cmpxchg succeeds.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   kernel/locking/qspinlock.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index d3f99060b60f..96b54e2ade86 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -223,7 +223,10 @@ static __always_inline void clear_pending_set_lock=
ed(struct qspinlock *lock)
> >    */
> >   static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail=
)
> >   {
> > -     u32 old, new, val =3D atomic_read(&lock->val);
> > +     u32 old, new, val;
> > +
> > +     prefetchw(&lock->val);
> > +     val =3D atomic_read(&lock->val);
> >
> >       for (;;) {
> >               new =3D (val & _Q_LOCKED_PENDING_MASK) | tail;
>
> That looks a bit weird. You pre-fetch and then immediately read it. How
> much performance gain you get by this change alone?
>
> Maybe you can define an arch specific primitive that default back to
> atomic_read() if not defined.
Thx for the reply. This is a generic optimization point I would like
to talk about with you.

First, prefetchw() makes cacheline an exclusive state and serves for
the next cmpxchg loop semantic, which writes the idx_tail part of
arch_spin_lock. The atomic_read only makes cacheline in the shared
state, which couldn't give any guarantee for the next cmpxchg loop
semantic. Micro-architecture could utilize prefetchw() to provide a
strong forward progress guarantee for the xchg_tail, e.g., the T-HEAD
XuanTie processor would hold the exclusive cacheline state until the
next cmpxchg write success.

In the end, Let's go back to the principle: the xchg_tail is an atomic
swap operation that contains write eventually, so giving a prefetchw()
at the beginning is acceptable for all architectures..

>
> Cheers,
> Longman
>


--=20
Best Regards
 Guo Ren
