Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87A34E1CD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 09:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhC3HM2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 03:12:28 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36421 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhC3HMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 03:12:08 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2m3G-1ld3Gc1HJM-0138q1; Tue, 30 Mar 2021 09:12:06 +0200
Received: by mail-ot1-f52.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so14724361otr.4;
        Tue, 30 Mar 2021 00:12:05 -0700 (PDT)
X-Gm-Message-State: AOAM5312LOB1OQ+LBYTu/wZBy3A6sVxvfZeTukLGeMj1HbbkPnhNY4Ql
        x5FkXvVSQHkQlRU8MrwBcbzAzxmnXIn1J3BMayM=
X-Google-Smtp-Source: ABdhPJxrmSwVSZDP48DP+ikIRCBts1IlD1OfpYYF4tYk3/WxR/8UdJvAQaT3CYFMV6J7JYaeLxkX8qHf4eLpRGNv27Q=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr26882538otq.251.1617088324803;
 Tue, 30 Mar 2021 00:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
 <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
 <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com> <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com>
In-Reply-To: <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Mar 2021 09:11:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0DkbM=4oBBhA2DWvzMV7DwN1sqOU8Wa1qFtpd_w7iWmQ@mail.gmail.com>
Message-ID: <CAK8P3a0DkbM=4oBBhA2DWvzMV7DwN1sqOU8Wa1qFtpd_w7iWmQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dAc5/IYR3tPhlPw55hBn68XavOmrbOPoV9eDq5ASekeKo4KXdBt
 zG1nND9akWPe1zCpdB3g2XyNcD4NsEvHJIMPgk/mRumNTnCkQt1RQoMiYkNknXjTHkEOtSN
 IAKcvC5wsIideRGGjimmJ/lfGh9/wuWpx/XXQQJd62TauGO20yCg+FqVkcAj/VAYGrJg4My
 KAEK8nC3sztcuJUbOpvTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Ml0stvVTjU=:kt/2nob/5Op9UcVdXbiJ1B
 +CiIPVdQxeKZ9NN7g3MGau8DSrXSHN8K433EbhL0VRMFnPHHso0rmdopG2y6MzhgcGKzU6IKO
 AwInUVew1aIPfFigXoBbj0Hc2ckCA5VSs+WWzA7U7WMx9lE4DwzzpQJr8WRGhlmV54volstgG
 /d3jb2nLe4HS+yOPTLS9dxyM0s3BEQIV8kHdcQpiFGQ0ltoggLeTVspxm9ZksMEuFJp7RPN9A
 vmUldroy1LIE5rU6ppUKTI4U4BAlqeSxrQSFyGPFujb1PAlhUYvH6ycqMKgYr28ZS3uynl5mU
 xCuRIFl1pQTDamqXonXegn6O15R9wrgp7xzJR7Wv3hEUp++JuoHrrPG7ysvglxbb6+0zTyVg9
 dV5cTXI0iTfu+9W92s7ywrJLA3QXx38j3hkx58m10gY5KSY6Mit1DXkGM+jo9PZafxUCfVIAh
 KTPmigP+pbqNE8A4mX4i5q3Zf3uVZQFU3EA2njg63ToU029Ghwr7pDYBQH+gpvPKz0iaHZGsK
 V2cSLoK6g9vzoS7ZCHc8o1p+rTqfo59K2JztfZ6iHFlHsELaWp5JDNToR+Lp/9s9IvM/LOIjk
 zXkONm/ElG2sb+t6SVf+uyLG+1nUyvY+8X
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 4:26 AM Guo Ren <guoren@kernel.org> wrote:
> On Mon, Mar 29, 2021 at 9:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Mar 29, 2021 at 2:52 PM Guo Ren <guoren@kernel.org> wrote:
> > > On Mon, Mar 29, 2021 at 7:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > What's the architectural guarantee on LL/SC progress for RISC-V ?
> >
> >    "When LR/SC is used for memory locations marked RsrvNonEventual,
> >      software should provide alternative fall-back mechanisms used when
> >      lack of progress is detected."
> >
> > My reading of this is that if the example you tried stalls, then either
> > the PMA is not RsrvEventual, and it is wrong to rely on ll/sc on this,
> > or that the PMA is marked RsrvEventual but the implementation is
> > buggy.
>
> Yes, PMA just defines physical memory region attributes, But in our
> processor, when MMU is enabled (satp's value register > 2) in s-mode,
> it will look at our custom PTE's attributes BIT(63) ref [1]:
>
>    PTE format:
>    | 63 | 62 | 61 | 60 | 59 | 58-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>      SO   C    B    SH   SE    RSW   D   A   G   U   X   W   R   V
>      ^    ^    ^    ^    ^
>    BIT(63): SO - Strong Order
>    BIT(62): C  - Cacheable
>    BIT(61): B  - Bufferable
>    BIT(60): SH - Shareable
>    BIT(59): SE - Security
>
> So the memory also could be RsrvNone/RsrvEventual.

I was not talking about RsrvNone, which would clearly mean that
you cannot use lr/sc at all (trap would trap, right?), but "RsrvNonEventual",
which would explain the behavior you described in an earlier reply:

| u32 a = 0x55aa66bb;
| u16 *ptr = &a;
|
| CPU0                       CPU1
| =========             =========
| xchg16(ptr, new)     while(1)
|                                     WRITE_ONCE(*(ptr + 1), x);
|
| When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.

As I understand, this example must not cause a deadlock on
a compliant hardware implementation when the underlying memory
has RsrvEventual behavior, but could deadlock in case of
RsrvNonEventual

> [1] https://github.com/c-sky/csky-linux/commit/e837aad23148542771794d8a2fcc52afd0fcbf88
>
> >
> > It also seems that the current "amoswap" based implementation
> > would be reliable independent of RsrvEventual/RsrvNonEventual.
>
> Yes, the hardware implementation of AMO could be different from LR/SC.
> AMO could use ACE snoop holding to lock the bus in hw coherency
> design, but LR/SC uses an exclusive monitor without locking the bus.
>
> RISC-V hasn't CAS instructions, and it uses LR/SC for cmpxchg. I don't
> think LR/SC would be slower than CAS, and CAS is just good for code
> size.

What I meant here is that the current spinlock uses a simple amoswap,
which presumably does not suffer from the lack of forward process you
described.

        Arnd
