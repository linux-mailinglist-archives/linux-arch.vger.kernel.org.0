Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE234F7C8
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 06:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCaETd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 00:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhCaETK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 00:19:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 703E8619DA;
        Wed, 31 Mar 2021 04:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617164349;
        bh=0XKwss4Hof3X25r6bjrJJVKM4RoMnNg6Pao3M+Ls9mU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EmuXNN/8sS0Dbso4e+1fSvCIBEJnh+7frW86Bh5XC1AUpZmbWTLOztPmx9K3uJXOM
         XBjKOBGQRd5WESSU341/Fj2LGYqIqANNSNcbbP4Iz8pbzppxUGPJCzBEVO2mCLSif5
         sFMyg0u7/FAWyEc0Rmc/nL2cI3ttI5QT0+3+GzQdaLGDZjeuSNKuLCoGWk4Q2Bew0a
         xXA9RdzeIfZo0kowdTCLO8qKjGyUebWKh3tPaPok32BdzmvKg/gN8IWaL7gQq+1ZCX
         LmPqiyI+grbC3WBT/AE1TNi1A2p9q73bVbaM6r94gNfERYwzTn4jNvcEzvmx4stWDn
         7thLSj1O4gduQ==
Received: by mail-lf1-f50.google.com with SMTP id d13so6112689lfg.7;
        Tue, 30 Mar 2021 21:19:09 -0700 (PDT)
X-Gm-Message-State: AOAM5331z8wbONkLk2WtqB1Aq1FwAXX/y6BzQFOoBAwewNK7oTUK2XOX
        eLSyzVRkdIi7LiJRmhwPk25TZMlHXD5vYs/u0ss=
X-Google-Smtp-Source: ABdhPJx+ii4cISAbi0jdeMRF01vf8KEr9bLID6axyIdKr+61ZHMDTxRv3u6V5SiTCLty4Ct/I0NqsI5Om8KadMxQvUE=
X-Received: by 2002:a05:6512:ba2:: with SMTP id b34mr970839lfv.24.1617164347742;
 Tue, 30 Mar 2021 21:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
 <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
 <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com>
 <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com> <CAK8P3a0DkbM=4oBBhA2DWvzMV7DwN1sqOU8Wa1qFtpd_w7iWmQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0DkbM=4oBBhA2DWvzMV7DwN1sqOU8Wa1qFtpd_w7iWmQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 31 Mar 2021 12:18:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSGLn7katm6YAtkKWJcQRqw36_yqn+aK1pKUSRM5V1zUg@mail.gmail.com>
Message-ID: <CAJF2gTSGLn7katm6YAtkKWJcQRqw36_yqn+aK1pKUSRM5V1zUg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Arnd Bergmann <arnd@arndb.de>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 30, 2021 at 4:26 AM Guo Ren <guoren@kernel.org> wrote:
> > On Mon, Mar 29, 2021 at 9:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Mon, Mar 29, 2021 at 2:52 PM Guo Ren <guoren@kernel.org> wrote:
> > > > On Mon, Mar 29, 2021 at 7:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > What's the architectural guarantee on LL/SC progress for RISC-V ?
> > >
> > >    "When LR/SC is used for memory locations marked RsrvNonEventual,
> > >      software should provide alternative fall-back mechanisms used when
> > >      lack of progress is detected."
> > >
> > > My reading of this is that if the example you tried stalls, then either
> > > the PMA is not RsrvEventual, and it is wrong to rely on ll/sc on this,
> > > or that the PMA is marked RsrvEventual but the implementation is
> > > buggy.
> >
> > Yes, PMA just defines physical memory region attributes, But in our
> > processor, when MMU is enabled (satp's value register > 2) in s-mode,
> > it will look at our custom PTE's attributes BIT(63) ref [1]:
> >
> >    PTE format:
> >    | 63 | 62 | 61 | 60 | 59 | 58-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> >      SO   C    B    SH   SE    RSW   D   A   G   U   X   W   R   V
> >      ^    ^    ^    ^    ^
> >    BIT(63): SO - Strong Order
> >    BIT(62): C  - Cacheable
> >    BIT(61): B  - Bufferable
> >    BIT(60): SH - Shareable
> >    BIT(59): SE - Security
> >
> > So the memory also could be RsrvNone/RsrvEventual.
>
> I was not talking about RsrvNone, which would clearly mean that
> you cannot use lr/sc at all (trap would trap, right?), but "RsrvNonEventual",
> which would explain the behavior you described in an earlier reply:
>
> | u32 a = 0x55aa66bb;
> | u16 *ptr = &a;
> |
> | CPU0                       CPU1
> | =========             =========
> | xchg16(ptr, new)     while(1)
> |                                     WRITE_ONCE(*(ptr + 1), x);
> |
> | When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
>
> As I understand, this example must not cause a deadlock on
> a compliant hardware implementation when the underlying memory
> has RsrvEventual behavior, but could deadlock in case of
> RsrvNonEventual
Thx for the nice explanation:
 - RsrvNonEventual - depends on software fall-back mechanisms, and
just I'm worried about.
 - RsrvEventual - HW would provide the eventual success guarantee.

>
> > [1] https://github.com/c-sky/csky-linux/commit/e837aad23148542771794d8a2fcc52afd0fcbf88
> >
> > >
> > > It also seems that the current "amoswap" based implementation
> > > would be reliable independent of RsrvEventual/RsrvNonEventual.
> >
> > Yes, the hardware implementation of AMO could be different from LR/SC.
> > AMO could use ACE snoop holding to lock the bus in hw coherency
> > design, but LR/SC uses an exclusive monitor without locking the bus.
> >
> > RISC-V hasn't CAS instructions, and it uses LR/SC for cmpxchg. I don't
> > think LR/SC would be slower than CAS, and CAS is just good for code
> > size.
>
> What I meant here is that the current spinlock uses a simple amoswap,
> which presumably does not suffer from the lack of forward process you
> described.
Does that mean we should prevent using LR/SC (if RsrvNonEventual)?

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
