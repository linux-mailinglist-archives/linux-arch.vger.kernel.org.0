Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20C234D1F4
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC2N4r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 29 Mar 2021 09:56:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhC2N4e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 09:56:34 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MpDRp-1lz7PW2Xst-00qjrS; Mon, 29 Mar 2021 15:56:29 +0200
Received: by mail-oi1-f178.google.com with SMTP id f9so13140969oiw.5;
        Mon, 29 Mar 2021 06:56:29 -0700 (PDT)
X-Gm-Message-State: AOAM5328ryP4bPtdXoqyPt4r4CIKMoXYUYXImDwk9uyNc6Mz0d9W9JID
        13kD1HSI+inwMft4Prd3bia0tgC2e9llRLC/CNo=
X-Google-Smtp-Source: ABdhPJy0vJalLgX9WOoI4FQEZJ7ly3VUocO7/EsGYULttaQFdCVk5swQHlGoklL1MAn8jh7Q3Vrvjf5tWz+qCh9IZ/U=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr18216138oie.67.1617026188151;
 Mon, 29 Mar 2021 06:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
 <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
In-Reply-To: <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Mar 2021 15:56:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com>
Message-ID: <CAK8P3a3jpQ7dDiVG0s_DQiL6n_MdnhYHMjqFfJ92JJBJFPQZPQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:dmtIqfkAnwfuOb33wbiLKllUprvh9DHR635YnFbWvX+s8NaTKOv
 bEm7HAjcfLFBJmoMCSqxcOhvOqwRHlv18OQwN5xZ0v2jbRu2XCvHXmA8LoGYq7jyvrG/eS6
 vHvriOahkJF6hthnWkg04JggI8P3HJiTKiJCpxMWyNvtC/M31Hb6k96cVnpIvan7wM2VX+c
 +UAl1iE7sDyjJ9zn3n5cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wzwbNUZfmG0=:l6Qtv7KmQhgj4T0woVP72b
 DRSDQusLaTxs2pej+VZwjFdK1hWGUe+dZ6Yy8S2h4AnTQydA/HE8t0VlKPuguUgFfFIawD7Rp
 U9gJQxes9keHnlnUojeV025+18RjAqU4vbYHaSMEx0ay1+U2H/lSKa7OhgOcVAbG21gh719+2
 BudNEG3RMhX64EkVhksYfI5bdHLA7DjFYR1jR423+ImmihDA9iv3nayMSaSPaUxOQ00JoFIH2
 UO84Vvb+VOpecB0scXDQLpQHBgbvsvT04i9KZAXFBiFjeePf+/NXIwMNdDc8vox2rBVfgEPRt
 XzURvBV2hB6YOCSKPjDDGbgcGwneJGoToX30yHE9o2fpc9yNnrgoEyyJq1UcJDCLUH9uNqwdf
 7xCIIzxBBDgABUpc9zyvtW5B5+gT3WZjmHmgD6MuxFSK0ReOJ5rOBqx0bpcAg39HHdVga7gdX
 azgGbOYqj5wyNh0943eRftBdbOy76PQ=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 2:52 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 7:31 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Mar 29, 2021 at 01:16:53PM +0200, Peter Zijlstra wrote:
> > > Anyway, an additional 'funny' is that I suspect you cannot prove fwd
> > > progress of the entire primitive with any of this on. But who cares
> > > about details anyway.. :/
> >
> > What's the architectural guarantee on LL/SC progress for RISC-V ?
>
> funct5    | aq | rl   | rs2 |  rs1  | funct3 | rd | opcode
>      5          1    1      5       5         3        5          7
> LR.W/D  ordering  0     addr    width   dest    AMO
> SC.W/D  ordering  src  addr    width   dest    AMO
>
> LR.W loads a word from the address in rs1, places the sign-extended
> value in rd, and registers a reservation set—a set of bytes that
> subsumes the bytes in the addressed word. SC.W conditionally writes a
> word in rs2 to the address in rs1: the SC.W succeeds only if the
> reservation is still valid and the reservation set contains the bytes
> being written. If the SC.W succeeds, the instruction writes the word
> in rs2 to memory, and it writes zero to rd. If the SC.W fails, the
> instruction does not write to memory, and it writes a nonzero value to
> rd. Regardless of success or failure, executing an SC.W instruction
> *invalidates any reservation held by this hart*.
>
> More details, ref:
> https://github.com/riscv/riscv-isa-manual

I think section "3.5.3.2 Reservability PMA" [1] would be a more relevant
link, as this defines memory areas that either do or do not have
forward progress guarantees, including this part:

   "When LR/SC is used for memory locations marked RsrvNonEventual,
     software should provide alternative fall-back mechanisms used when
     lack of progress is detected."

My reading of this is that if the example you tried stalls, then either
the PMA is not RsrvEventual, and it is wrong to rely on ll/sc on this,
or that the PMA is marked RsrvEventual but the implementation is
buggy.

It also seems that the current "amoswap" based implementation
would be reliable independent of RsrvEventual/RsrvNonEventual.
arm64 is already in the situation of having to choose between
two cmpxchg() implementation at runtime to allow falling back to
a slower but more general version, but it's best to avoid that if you
can.

         Arnd

[1] http://www.five-embeddev.com/riscv-isa-manual/latest/machine.html#atomicity-pmas
