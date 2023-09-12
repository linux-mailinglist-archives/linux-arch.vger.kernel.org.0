Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D779C1EA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 03:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjILBtF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 21:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjILBs4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 21:48:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51891190D6;
        Mon, 11 Sep 2023 18:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9CBC4AF5D;
        Tue, 12 Sep 2023 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694481021;
        bh=PmwGDpdmz+0+pysYVIXZ7fXJiKs9e5dF+HbkGIVF5as=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jlD2mnVQkJ9dQNUIk9R3CuYjHhgHwvQV9BhYB1UVI/cUqGd1sykjzR7mLUJXtptJQ
         NIcmajdfgGqmN141W+e/2moBeBsQ93VfXgkY756hKejSyMHUxmias79eLYxIk5i1fj
         RpG7XZhT0/QpfIOm9R+4s+TTfXVTs3mJLrFUOGrNuuR9EiYzZydLJb4+3YAxrr1fPe
         aVSHdeSKu6CiukMnrRolU4G0aHeMwoD4BC0P72Lhwxgwtm0U8rzMK1eNx9FhSKN99G
         LBKsEGYVTjxFRF0hMp9PerExCBewvbvQmTedyMML8itsk1hKn8wlEig78uT1o09Uyt
         qJOcV6g7C8dmA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9ad810be221so39476366b.2;
        Mon, 11 Sep 2023 18:10:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YyproEC8NVJMXpOUpwsyMeJyPUN2r/JMcxo8eJ8GhlCRigQLH8B
        7jf9ppLevSni06ea1m2T74YQdRsoqxc0Qlsls20=
X-Google-Smtp-Source: AGHT+IG7WPf4ZfuTXYhS8Pfr8Yz7DCWBDmRzYNhYtX5DScRQNAK6kZJN4KaH0XTWTAZy+qE6WP41Hn0WlXiCnlA9WtA=
X-Received: by 2002:a17:906:214:b0:9a2:86b:bb18 with SMTP id
 20-20020a170906021400b009a2086bbb18mr11141293ejd.26.1694481020090; Mon, 11
 Sep 2023 18:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com> <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
 <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com>
In-Reply-To: <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Sep 2023 09:10:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ3Q7f+FGorVTR66c6TGWsSeeKVvLF+LH1_m3kSHrm0yA@mail.gmail.com>
Message-ID: <CAJF2gTQ3Q7f+FGorVTR66c6TGWsSeeKVvLF+LH1_m3kSHrm0yA@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11, 2023 at 9:03=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 9/10/23 23:09, Guo Ren wrote:
> > On Mon, Sep 11, 2023 at 10:35=E2=80=AFAM Waiman Long <longman@redhat.co=
m> wrote:
> >>
> >> On 9/10/23 04:28, guoren@kernel.org wrote:
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> The target of xchg_tail is to write the tail to the lock value, so
> >>> adding prefetchw could help the next cmpxchg step, which may
> >>> decrease the cmpxchg retry loops of xchg_tail. Some processors may
> >>> utilize this feature to give a forward guarantee, e.g., RISC-V
> >>> XuanTie processors would block the snoop channel & irq for several
> >>> cycles when prefetch.w instruction (from Zicbop extension) retired,
> >>> which guarantees the next cmpxchg succeeds.
> >>>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>> ---
> >>>    kernel/locking/qspinlock.c | 5 ++++-
> >>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> >>> index d3f99060b60f..96b54e2ade86 100644
> >>> --- a/kernel/locking/qspinlock.c
> >>> +++ b/kernel/locking/qspinlock.c
> >>> @@ -223,7 +223,10 @@ static __always_inline void clear_pending_set_lo=
cked(struct qspinlock *lock)
> >>>     */
> >>>    static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 t=
ail)
> >>>    {
> >>> -     u32 old, new, val =3D atomic_read(&lock->val);
> >>> +     u32 old, new, val;
> >>> +
> >>> +     prefetchw(&lock->val);
> >>> +     val =3D atomic_read(&lock->val);
> >>>
> >>>        for (;;) {
> >>>                new =3D (val & _Q_LOCKED_PENDING_MASK) | tail;
> >> That looks a bit weird. You pre-fetch and then immediately read it. Ho=
w
> >> much performance gain you get by this change alone?
> >>
> >> Maybe you can define an arch specific primitive that default back to
> >> atomic_read() if not defined.
> > Thx for the reply. This is a generic optimization point I would like
> > to talk about with you.
> >
> > First, prefetchw() makes cacheline an exclusive state and serves for
> > the next cmpxchg loop semantic, which writes the idx_tail part of
> > arch_spin_lock. The atomic_read only makes cacheline in the shared
> > state, which couldn't give any guarantee for the next cmpxchg loop
> > semantic. Micro-architecture could utilize prefetchw() to provide a
> > strong forward progress guarantee for the xchg_tail, e.g., the T-HEAD
> > XuanTie processor would hold the exclusive cacheline state until the
> > next cmpxchg write success.
> >
> > In the end, Let's go back to the principle: the xchg_tail is an atomic
> > swap operation that contains write eventually, so giving a prefetchw()
> > at the beginning is acceptable for all architectures..
> > =E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=
=A2=E2=80=A2=E2=80=A2=E2=80=A2=E2=80=A2
>
> I did realize afterward that prefetchw gets the cacheline in exclusive
> state. I will suggest you mention that in your commit log as well as
> adding a comment about its purpose in the code.
Okay, I would do that in v12, thx.

>
> Thanks,
> Longman
>
> >> Cheers,
> >> Longman
> >>
> >
>


--=20
Best Regards
 Guo Ren
