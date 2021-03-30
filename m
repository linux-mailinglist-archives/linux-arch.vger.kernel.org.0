Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64D34E133
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 08:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhC3G1V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 02:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhC3G1I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Mar 2021 02:27:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9BE161883;
        Tue, 30 Mar 2021 06:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617085628;
        bh=h6cKQgQFDqsLu4Ml7eftReo0sJ4UfligyxpKGMYILac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PWca1KOipGtF8ucMYRs6NUnHKrjzW03+icqoPY9JWguAMsTDCDgpwOjqHlpWoAPBI
         hB8/kIl6wdzABAvkLwVB98MuzAX7dDKsp7aJCCagqHyMMJYoVHUjX99quQLro1BU3Z
         VwW9mZtNUTzYAUu71GvUs5KUunVSlmb2vGMcZWcry+SeW9k5aB3ZlMEbmb8uBpDVl8
         bowNY+14RsonlZN7HuXUZ136srCf6Ocj8G0KVeu7FtM9pB9Bj6O24ra4BBzWqoixpu
         TqaVqrNNGrLG81whJKWDk21thY6QjljLSvjHspGYtsDORO57hiTZ/s3gcue7uz/xRU
         VvV05fpBDv8iA==
Received: by mail-lf1-f45.google.com with SMTP id d12so984823lfv.11;
        Mon, 29 Mar 2021 23:27:07 -0700 (PDT)
X-Gm-Message-State: AOAM531HamRoIou415+eKgDUWmxtIcnZ/IbOXLf/BMvrnACZEtQJEZ//
        ESw6RcAXCplH3F9y1kHAqeqGurF8I6IxR25RClI=
X-Google-Smtp-Source: ABdhPJxLeSaTtjmcrRLf806pyTkgjzTpAHH9sXcEEvO300obxedt4igu/AiweHqndo77BbWaClF/jdPoXSfN5I7ZLNQ=
X-Received: by 2002:a19:f501:: with SMTP id j1mr19681109lfb.231.1617085625933;
 Mon, 29 Mar 2021 23:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
 <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
 <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com>
 <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com> <CAAhSdy3UWZuiFKxMPiQD+QTXuwk7LuvxkHJNE1zs2EtErHdt5Q@mail.gmail.com>
In-Reply-To: <CAAhSdy3UWZuiFKxMPiQD+QTXuwk7LuvxkHJNE1zs2EtErHdt5Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Mar 2021 14:26:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTnxRfv9xYLn6rHaoPQEAd0V7acjECfJ-bqoB=D+BUG=w@mail.gmail.com>
Message-ID: <CAJF2gTTnxRfv9xYLn6rHaoPQEAd0V7acjECfJ-bqoB=D+BUG=w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Anup Patel <anup@brainfault.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 1:51 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Mar 30, 2021 at 7:56 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 9:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 2:52 PM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Mon, Mar 29, 2021 at 7:31 PM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> > > > >
> > > > > On Mon, Mar 29, 2021 at 01:16:53PM +0200, Peter Zijlstra wrote:
> > > > > > Anyway, an additional 'funny' is that I suspect you cannot prov=
e fwd
> > > > > > progress of the entire primitive with any of this on. But who c=
ares
> > > > > > about details anyway.. :/
> > > > >
> > > > > What's the architectural guarantee on LL/SC progress for RISC-V ?
> > > >
> > > > funct5    | aq | rl   | rs2 |  rs1  | funct3 | rd | opcode
> > > >      5          1    1      5       5         3        5          7
> > > > LR.W/D  ordering  0     addr    width   dest    AMO
> > > > SC.W/D  ordering  src  addr    width   dest    AMO
> > > >
> > > > LR.W loads a word from the address in rs1, places the sign-extended
> > > > value in rd, and registers a reservation set=E2=80=94a set of bytes=
 that
> > > > subsumes the bytes in the addressed word. SC.W conditionally writes=
 a
> > > > word in rs2 to the address in rs1: the SC.W succeeds only if the
> > > > reservation is still valid and the reservation set contains the byt=
es
> > > > being written. If the SC.W succeeds, the instruction writes the wor=
d
> > > > in rs2 to memory, and it writes zero to rd. If the SC.W fails, the
> > > > instruction does not write to memory, and it writes a nonzero value=
 to
> > > > rd. Regardless of success or failure, executing an SC.W instruction
> > > > *invalidates any reservation held by this hart*.
> > > >
> > > > More details, ref:
> > > > https://github.com/riscv/riscv-isa-manual
> > >
> > > I think section "3.5.3.2 Reservability PMA" [1] would be a more relev=
ant
> > > link, as this defines memory areas that either do or do not have
> > > forward progress guarantees, including this part:
> > >
> > >    "When LR/SC is used for memory locations marked RsrvNonEventual,
> > >      software should provide alternative fall-back mechanisms used wh=
en
> > >      lack of progress is detected."
> > >
> > > My reading of this is that if the example you tried stalls, then eith=
er
> > > the PMA is not RsrvEventual, and it is wrong to rely on ll/sc on this=
,
> > > or that the PMA is marked RsrvEventual but the implementation is
> > > buggy.
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
> >
> > [1] https://github.com/c-sky/csky-linux/commit/e837aad23148542771794d8a=
2fcc52afd0fcbf88
>
> Is this about your C-sky architecture or your RISC-V implementation.
It's in RISC-V implementation.

>
> If these PTE bits are in your RISC-V implementation then clearly your
> RISC-V implementation is not compliant with the RISC-V privilege spec
> because these bits are not defined in RISC-V privilege spec.
We could disable it if the vendor's SOC has a coherency interconnect
bus, so C910 is compliant with standard privilege spec.

ps:
I remember someone has mentioned a similar design in 1.12-draft-VM-TASKGROU=
P:

"Bit 63 indicates that the PTE uses a custom implementation-specific
encoding. If bit 63 is set, the algorithm for virtual-to-physical
address translation is implementation-defined. If bit 63 is not set,
the algorithm for virtual-to-physical address translation is described
in Section 4.4.2.

Bit 62 indicates the use of naturally aligned power-of-two (NAPOT)
address translation contiguity, as described in Section 4.4.2.

Bits 61=E2=80=93xx indicate cacheability attributes associated with the
virtual address in question, as de-scribed in Section 4.4.3.

Bits xx=E2=80=9354 are reserved for future use."


>
> Regards,
> Anup
> >
> > >
> > > It also seems that the current "amoswap" based implementation
> > > would be reliable independent of RsrvEventual/RsrvNonEventual.
> > Yes, the hardware implementation of AMO could be different from LR/SC.
> > AMO could use ACE snoop holding to lock the bus in hw coherency
> > design, but LR/SC uses an exclusive monitor without locking the bus.
> >
> > > arm64 is already in the situation of having to choose between
> > > two cmpxchg() implementation at runtime to allow falling back to
> > > a slower but more general version, but it's best to avoid that if you
> > > can.
> > Current RISC-V needn't multiple versions to select, and all AMO &
> > LR/SC has been defined in the spec.
> >
> > RISC-V hasn't CAS instructions, and it uses LR/SC for cmpxchg. I don't
> > think LR/SC would be slower than CAS, and CAS is just good for code
> > size.
> >
> > >
> > >          Arnd
> > >
> > > [1] http://www.five-embeddev.com/riscv-isa-manual/latest/machine.html=
#atomicity-pmas
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
