Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609A834DE58
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 04:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC3C1F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 22:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhC3C0e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 22:26:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3804619A7;
        Tue, 30 Mar 2021 02:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617071194;
        bh=DsNUDKNJ0Zn7ha019DqF6JpRF6ePLDXBpY2fY4Rt5zI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d4cb+mFmuvef/cwfP2zNQ3obGFGjzuzoUwV/X2Zigv4nsZNUWKslRrqdL34xGoLxn
         96WVK3ko/y5YsTXEzBvfqnWDjP0ijpDer3lLY8MPYAeN9i8JVTGiO6vGNYDOowoWHZ
         KWY83N80nfMGMh9gQ6f3pRmEufiZZ3fe3+W58B6HXt6U/owpCK++KKZV9lfwu7cmZz
         lTuJ2/F7BpyWD8Hb7PUf5J1BMo6rogzywecLGkdu3g9KM5rt+XesuBAdPnMbzL2Pt2
         XB8jdv3pb5/7T1ey8dbagvED+OrQQDtvAHHbre4u+uDUBm39lzH+oKQlmdvbJDGg+r
         t8BC3M/LaSv4g==
Received: by mail-lf1-f43.google.com with SMTP id g8so21404523lfv.12;
        Mon, 29 Mar 2021 19:26:33 -0700 (PDT)
X-Gm-Message-State: AOAM532xQGkROV/T4XoBJzMcIh/pLwC3669/assFnQO22haLivakrhSm
        AcOEQaqwBWVxJflh+IZuY3vtGDVdPuQ/n5hcWjw=
X-Google-Smtp-Source: ABdhPJxU6mxcUsuISjomLk93VoCYmMFU/zeXtni2UcWWrrqJGhcLnr4AAMCcANyUFGhKFwrj3dIEI2b9d5by4xErFtM=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr18679032lfg.355.1617071192050;
 Mon, 29 Mar 2021 19:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
 <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com> <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Mar 2021 10:26:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com>
Message-ID: <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 9:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 29, 2021 at 2:52 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 7:31 PM Peter Zijlstra <peterz@infradead.org> w=
rote:
> > >
> > > On Mon, Mar 29, 2021 at 01:16:53PM +0200, Peter Zijlstra wrote:
> > > > Anyway, an additional 'funny' is that I suspect you cannot prove fw=
d
> > > > progress of the entire primitive with any of this on. But who cares
> > > > about details anyway.. :/
> > >
> > > What's the architectural guarantee on LL/SC progress for RISC-V ?
> >
> > funct5    | aq | rl   | rs2 |  rs1  | funct3 | rd | opcode
> >      5          1    1      5       5         3        5          7
> > LR.W/D  ordering  0     addr    width   dest    AMO
> > SC.W/D  ordering  src  addr    width   dest    AMO
> >
> > LR.W loads a word from the address in rs1, places the sign-extended
> > value in rd, and registers a reservation set=E2=80=94a set of bytes tha=
t
> > subsumes the bytes in the addressed word. SC.W conditionally writes a
> > word in rs2 to the address in rs1: the SC.W succeeds only if the
> > reservation is still valid and the reservation set contains the bytes
> > being written. If the SC.W succeeds, the instruction writes the word
> > in rs2 to memory, and it writes zero to rd. If the SC.W fails, the
> > instruction does not write to memory, and it writes a nonzero value to
> > rd. Regardless of success or failure, executing an SC.W instruction
> > *invalidates any reservation held by this hart*.
> >
> > More details, ref:
> > https://github.com/riscv/riscv-isa-manual
>
> I think section "3.5.3.2 Reservability PMA" [1] would be a more relevant
> link, as this defines memory areas that either do or do not have
> forward progress guarantees, including this part:
>
>    "When LR/SC is used for memory locations marked RsrvNonEventual,
>      software should provide alternative fall-back mechanisms used when
>      lack of progress is detected."
>
> My reading of this is that if the example you tried stalls, then either
> the PMA is not RsrvEventual, and it is wrong to rely on ll/sc on this,
> or that the PMA is marked RsrvEventual but the implementation is
> buggy.
Yes, PMA just defines physical memory region attributes, But in our
processor, when MMU is enabled (satp's value register > 2) in s-mode,
it will look at our custom PTE's attributes BIT(63) ref [1]:

   PTE format:
   | 63 | 62 | 61 | 60 | 59 | 58-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
     SO   C    B    SH   SE    RSW   D   A   G   U   X   W   R   V
     ^    ^    ^    ^    ^
   BIT(63): SO - Strong Order
   BIT(62): C  - Cacheable
   BIT(61): B  - Bufferable
   BIT(60): SH - Shareable
   BIT(59): SE - Security

So the memory also could be RsrvNone/RsrvEventual.

[1] https://github.com/c-sky/csky-linux/commit/e837aad23148542771794d8a2fcc=
52afd0fcbf88

>
> It also seems that the current "amoswap" based implementation
> would be reliable independent of RsrvEventual/RsrvNonEventual.
Yes, the hardware implementation of AMO could be different from LR/SC.
AMO could use ACE snoop holding to lock the bus in hw coherency
design, but LR/SC uses an exclusive monitor without locking the bus.

> arm64 is already in the situation of having to choose between
> two cmpxchg() implementation at runtime to allow falling back to
> a slower but more general version, but it's best to avoid that if you
> can.
Current RISC-V needn't multiple versions to select, and all AMO &
LR/SC has been defined in the spec.

RISC-V hasn't CAS instructions, and it uses LR/SC for cmpxchg. I don't
think LR/SC would be slower than CAS, and CAS is just good for code
size.

>
>          Arnd
>
> [1] http://www.five-embeddev.com/riscv-isa-manual/latest/machine.html#ato=
micity-pmas

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
