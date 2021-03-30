Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683F734E0E1
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 07:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhC3Fva (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 01:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhC3FvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 01:51:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECCC061764
        for <linux-arch@vger.kernel.org>; Mon, 29 Mar 2021 22:51:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f16so18579864ljm.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Mar 2021 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q6lEE2mLxUSxwFUa7GfL5LXw+GX8ZqMED2HXvAcd790=;
        b=QWDQj/k//08OQqkLgKt3T0BFbwXuqS+LZt6L6iSTc0BsCjEFYh0/VLD9npTeuxxWsQ
         97fkc+OgI/HFewPYFVTQjqec9xguXnT4goiwh7cv91Uvzs+fQgLuBy3pfDnHx537JOv+
         pBulm1ChNlHQ6wlKqEXZndfqsxQ94GixOKN5sePQBcRIfXZ7lDgwolWcdjeDr2xUtHXI
         2a1bUSdW6O31D8XCrS66t7QBaOjTf/YCYiaVLIf2VPF3dI0v34NGPxnf1K6KB45Ftkgr
         GyBjG9C9MLS1CBL0YWsXov3mtTF1kpCQcG7HMQAUjcL6Wcvqv0it5T+c6D2/A565YeEK
         Rsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q6lEE2mLxUSxwFUa7GfL5LXw+GX8ZqMED2HXvAcd790=;
        b=YdFkx/MXOlt4keQUG2a1tcYE4NCrlzpmJp7GFkDKbWg1OH8/QYsqJLonD09WI1QoUF
         5Uhq8lU5GOCVpdomYFVkXsw7Zz8m01HZqJyZkQF0byYUIK9ToZV933pHb9iqA9GS1VR0
         kcPo5dpEC+QfaDCK/8veweKS+V/HfuomVaHgHQ1Cma27TDRyJhu8rpolwpY5pOo33noo
         cm3Qaug2Lad6/Dhiv/VL/39OQhCVAq5oiDJXY7FahNue3mabsXJcRy/DsXfPl9s62slH
         +0wSCsfUE5ilnuVvBLcozsIoDykVogVPH9Z1pvZodQ4G34ONJySX6s1cEZOwFZp6RKkb
         /gIA==
X-Gm-Message-State: AOAM533m4S7gvQMAn1Zy/vspzIPMhOQdLF3lnYlhmKhRrqejx0xH2E0g
        chxH0lhL7Jy+ctADZ66e45KY7GnKEwgmgVI8kR7fA0BCaIY=
X-Google-Smtp-Source: ABdhPJwiUwnbbZmlObvrahOjCJ6o2HFElpU0UGc8nhlBKt2fEzygnVd4qkLRnIKdDWUW9FsXtGj8y7/NGKgsZ/G7KGM=
X-Received: by 2002:a2e:8114:: with SMTP id d20mr20111828ljg.83.1617083483493;
 Mon, 29 Mar 2021 22:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
 <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
 <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com> <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com>
In-Reply-To: <CAJF2gTSpnHndT9NkrzvNP6xvqV51_DENwh2BHaduUnGyUE=Jaw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 30 Mar 2021 11:21:12 +0530
Message-ID: <CAAhSdy3UWZuiFKxMPiQD+QTXuwk7LuvxkHJNE1zs2EtErHdt5Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Guo Ren <guoren@kernel.org>
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

On Tue, Mar 30, 2021 at 7:56 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 9:56 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Mar 29, 2021 at 2:52 PM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 7:31 PM Peter Zijlstra <peterz@infradead.org>=
 wrote:
> > > >
> > > > On Mon, Mar 29, 2021 at 01:16:53PM +0200, Peter Zijlstra wrote:
> > > > > Anyway, an additional 'funny' is that I suspect you cannot prove =
fwd
> > > > > progress of the entire primitive with any of this on. But who car=
es
> > > > > about details anyway.. :/
> > > >
> > > > What's the architectural guarantee on LL/SC progress for RISC-V ?
> > >
> > > funct5    | aq | rl   | rs2 |  rs1  | funct3 | rd | opcode
> > >      5          1    1      5       5         3        5          7
> > > LR.W/D  ordering  0     addr    width   dest    AMO
> > > SC.W/D  ordering  src  addr    width   dest    AMO
> > >
> > > LR.W loads a word from the address in rs1, places the sign-extended
> > > value in rd, and registers a reservation set=E2=80=94a set of bytes t=
hat
> > > subsumes the bytes in the addressed word. SC.W conditionally writes a
> > > word in rs2 to the address in rs1: the SC.W succeeds only if the
> > > reservation is still valid and the reservation set contains the bytes
> > > being written. If the SC.W succeeds, the instruction writes the word
> > > in rs2 to memory, and it writes zero to rd. If the SC.W fails, the
> > > instruction does not write to memory, and it writes a nonzero value t=
o
> > > rd. Regardless of success or failure, executing an SC.W instruction
> > > *invalidates any reservation held by this hart*.
> > >
> > > More details, ref:
> > > https://github.com/riscv/riscv-isa-manual
> >
> > I think section "3.5.3.2 Reservability PMA" [1] would be a more relevan=
t
> > link, as this defines memory areas that either do or do not have
> > forward progress guarantees, including this part:
> >
> >    "When LR/SC is used for memory locations marked RsrvNonEventual,
> >      software should provide alternative fall-back mechanisms used when
> >      lack of progress is detected."
> >
> > My reading of this is that if the example you tried stalls, then either
> > the PMA is not RsrvEventual, and it is wrong to rely on ll/sc on this,
> > or that the PMA is marked RsrvEventual but the implementation is
> > buggy.
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
>
> [1] https://github.com/c-sky/csky-linux/commit/e837aad23148542771794d8a2f=
cc52afd0fcbf88

Is this about your C-sky architecture or your RISC-V implementation.

If these PTE bits are in your RISC-V implementation then clearly your
RISC-V implementation is not compliant with the RISC-V privilege spec
because these bits are not defined in RISC-V privilege spec.

Regards,
Anup
>
> >
> > It also seems that the current "amoswap" based implementation
> > would be reliable independent of RsrvEventual/RsrvNonEventual.
> Yes, the hardware implementation of AMO could be different from LR/SC.
> AMO could use ACE snoop holding to lock the bus in hw coherency
> design, but LR/SC uses an exclusive monitor without locking the bus.
>
> > arm64 is already in the situation of having to choose between
> > two cmpxchg() implementation at runtime to allow falling back to
> > a slower but more general version, but it's best to avoid that if you
> > can.
> Current RISC-V needn't multiple versions to select, and all AMO &
> LR/SC has been defined in the spec.
>
> RISC-V hasn't CAS instructions, and it uses LR/SC for cmpxchg. I don't
> think LR/SC would be slower than CAS, and CAS is just good for code
> size.
>
> >
> >          Arnd
> >
> > [1] http://www.five-embeddev.com/riscv-isa-manual/latest/machine.html#a=
tomicity-pmas
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
