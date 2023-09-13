Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9979E85C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 14:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbjIMMwx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 08:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjIMMwj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 08:52:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7842211C;
        Wed, 13 Sep 2023 05:52:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D5C433AB;
        Wed, 13 Sep 2023 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694609551;
        bh=D2yTmI5mmzTW+iHmuYtFAVHVgFprFMquzoJG0XHk9mY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jLbYg9+lvwvF9g6Gzkp32rLzFct1AYEvyFblrgfdogy3rFxqbyRNys4dniNEV2uY5
         nOe5Uz3nolhE3FN39BV/UqGkWDbU4ziXFzFWK6u3xLWpElf/wkqfKZg75txI3/Xdl1
         u2aVr3lYI5QcjC8PEEAnMVH/i2l25qtLPa5KssBR/umBr395+GeU1u7dgSHF4+nMld
         Jc6iurwNwapx7fV0M4ByfPLNdLGNpswYYe8Gol96hkHCT7wu3X1mV56n9E+C+hEXq0
         0BYlIzcAxZJt0l8+Urs6wHHPXm5OAVzYdAoC9xpvcxlU1+jpgItMkzmY7R7ICI6TC/
         9rSlusN9Qdzag==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bf66a32f25so89752011fa.2;
        Wed, 13 Sep 2023 05:52:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzvmi0iv4E+6Vd/CXrdkB8xadPCfdxypGYDXoPMgMJkiNPhcJAM
        OAE3YXDyhKd/+gskXs8bUMp43KP49DCWyvPGjZ0=
X-Google-Smtp-Source: AGHT+IGLa36Mv9VZMwcFAm7pr5KGpJYN8bFmsK6RHp2UXPGlGeRTY2NMaKQac0gjfg8fITbp0O+QfICTV/S409jzbrQ=
X-Received: by 2002:a2e:9f06:0:b0:2bd:beb:4aca with SMTP id
 u6-20020a2e9f06000000b002bd0beb4acamr2237707ljk.13.1694609549439; Wed, 13 Sep
 2023 05:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com> <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
 <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com> <CAJF2gTQ3Q7f+FGorVTR66c6TGWsSeeKVvLF+LH1_m3kSHrm0yA@mail.gmail.com>
 <ZQF49GIZoFceUGYH@redhat.com>
In-Reply-To: <ZQF49GIZoFceUGYH@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Sep 2023 20:52:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTHdCr-FQVSGUc+LapkJPmDiEYYa_1P6T86uCjRujgnTg@mail.gmail.com>
Message-ID: <CAJF2gTTHdCr-FQVSGUc+LapkJPmDiEYYa_1P6T86uCjRujgnTg@mail.gmail.com>
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number
 of cpus >= 16k
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, paul.walmsley@sifive.com,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, palmer@rivosinc.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 4:55=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Tue, Sep 12, 2023 at 09:10:08AM +0800, Guo Ren wrote:
> > On Mon, Sep 11, 2023 at 9:03=E2=80=AFPM Waiman Long <longman@redhat.com=
> wrote:
> > >
> > > On 9/10/23 23:09, Guo Ren wrote:
> > > > On Mon, Sep 11, 2023 at 10:35=E2=80=AFAM Waiman Long <longman@redha=
t.com> wrote:
> > > >>
> > > >> On 9/10/23 04:28, guoren@kernel.org wrote:
> > > >>> From: Guo Ren <guoren@linux.alibaba.com>
> > > >>>
> > > >>> The target of xchg_tail is to write the tail to the lock value, s=
o
> > > >>> adding prefetchw could help the next cmpxchg step, which may
> > > >>> decrease the cmpxchg retry loops of xchg_tail. Some processors ma=
y
> > > >>> utilize this feature to give a forward guarantee, e.g., RISC-V
> > > >>> XuanTie processors would block the snoop channel & irq for severa=
l
> > > >>> cycles when prefetch.w instruction (from Zicbop extension) retire=
d,
> > > >>> which guarantees the next cmpxchg succeeds.
> > > >>>
> > > >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> > > >>> ---
> > > >>>    kernel/locking/qspinlock.c | 5 ++++-
> > > >>>    1 file changed, 4 insertions(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinloc=
k.c
> > > >>> index d3f99060b60f..96b54e2ade86 100644
> > > >>> --- a/kernel/locking/qspinlock.c
> > > >>> +++ b/kernel/locking/qspinlock.c
> > > >>> @@ -223,7 +223,10 @@ static __always_inline void clear_pending_se=
t_locked(struct qspinlock *lock)
> > > >>>     */
> > > >>>    static __always_inline u32 xchg_tail(struct qspinlock *lock, u=
32 tail)
> > > >>>    {
> > > >>> -     u32 old, new, val =3D atomic_read(&lock->val);
> > > >>> +     u32 old, new, val;
> > > >>> +
> > > >>> +     prefetchw(&lock->val);
> > > >>> +     val =3D atomic_read(&lock->val);
> > > >>>
> > > >>>        for (;;) {
> > > >>>                new =3D (val & _Q_LOCKED_PENDING_MASK) | tail;
> > > >> That looks a bit weird. You pre-fetch and then immediately read it=
. How
> > > >> much performance gain you get by this change alone?
> > > >>
> > > >> Maybe you can define an arch specific primitive that default back =
to
> > > >> atomic_read() if not defined.
> > > > Thx for the reply. This is a generic optimization point I would lik=
e
> > > > to talk about with you.
> > > >
> > > > First, prefetchw() makes cacheline an exclusive state and serves fo=
r
> > > > the next cmpxchg loop semantic, which writes the idx_tail part of
> > > > arch_spin_lock. The atomic_read only makes cacheline in the shared
> > > > state, which couldn't give any guarantee for the next cmpxchg loop
> > > > semantic. Micro-architecture could utilize prefetchw() to provide a
> > > > strong forward progress guarantee for the xchg_tail, e.g., the T-HE=
AD
> > > > XuanTie processor would hold the exclusive cacheline state until th=
e
> > > > next cmpxchg write success.
> > > >
> > > > In the end, Let's go back to the principle: the xchg_tail is an ato=
mic
> > > > swap operation that contains write eventually, so giving a prefetch=
w()
> > > > at the beginning is acceptable for all architectures..
> > > > =E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=
=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2
> > >
> > > I did realize afterward that prefetchw gets the cacheline in exclusiv=
e
> > > state. I will suggest you mention that in your commit log as well as
> > > adding a comment about its purpose in the code.
> > Okay, I would do that in v12, thx.
>
> I would suggest adding a snippet from the ISA Extenstion doc:
>
> "A prefetch.w instruction indicates to hardware that the cache block whos=
e
> effective address is the sum of the base address specified in rs1 and the
> sign-extended offset encoded in imm[11:0], where imm[4:0] equals 0b00000,
> is likely to be accessed by a data write (i.e. store) in the near future.=
"
Good point, thx.

>
> Other than that,
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
>
>
> >
> > >
> > > Thanks,
> > > Longman
> > >
> > > >> Cheers,
> > > >> Longman
> > > >>
> > > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren
