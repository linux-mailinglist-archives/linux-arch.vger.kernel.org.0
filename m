Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ECC34D07D
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 14:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhC2Mxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 08:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbhC2MxK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 08:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2665A61934;
        Mon, 29 Mar 2021 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617022390;
        bh=ZtH+hMquy7Na1NKF/yxIB+LhxXUi37ByQKiTFk9d38U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iy/yWInWB8DBRPxhLE7cb8nnL6SjCZMkWAdqdfKqXrpShBLHbTyVWa0wYkSN/tX5v
         Iu2rpPH80kkfOhq/UaN9/SA2YdB+x9RzSUizC5xp3FbagOGD5b8lWF+eiPxaQmBmsG
         8mQrC67o6eRGU77PTSiyD5FqmWZB/XMtgSQ5Lr9cr8/1EInyzd3Enz3sAFQtKWMDis
         x3GYxZ0FAXmMllpi+MTFzy++LKlizjyA1MYaBsoE2fzmId5Zv5Q27wwu0mWOSFEudJ
         MXKxlcT5oSR+vVk0rlL8s5NVNMSWLEZchX3yY/jaxKeq8CZH6LQBvCanFjA1q171Om
         P1oxZoWMTKRBQ==
Received: by mail-lf1-f41.google.com with SMTP id o10so18223327lfb.9;
        Mon, 29 Mar 2021 05:53:10 -0700 (PDT)
X-Gm-Message-State: AOAM533cSk97HasmT8nByVThJULtDdqVPyK13bf2i1w0RLRFzSF8Li8M
        CVz+iN9B15UZU561UOhAEZN+6nbU59L6+hzz1NM=
X-Google-Smtp-Source: ABdhPJzKyxFt/x88AyNxVA443wYhozA+/lh8xw56UgIWl+92QcqgMI4gEBYMXLqoZdXoDirHF7Uz5bRUqUYJrcU8Gu8=
X-Received: by 2002:a19:f501:: with SMTP id j1mr17188294lfb.231.1617022388450;
 Mon, 29 Mar 2021 05:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net> <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
In-Reply-To: <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 29 Mar 2021 20:52:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
Message-ID: <CAJF2gTRwd0QpUZumDFUN1J=effv67ucUdsQ96PJwjBhPgJ1npw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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

On Mon, Mar 29, 2021 at 7:31 PM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Mon, Mar 29, 2021 at 01:16:53PM +0200, Peter Zijlstra wrote:
> > Anyway, an additional 'funny' is that I suspect you cannot prove fwd
> > progress of the entire primitive with any of this on. But who cares
> > about details anyway.. :/
>
> What's the architectural guarantee on LL/SC progress for RISC-V ?

funct5    | aq | rl   | rs2 |  rs1  | funct3 | rd | opcode
     5          1    1      5       5         3        5          7
LR.W/D  ordering  0     addr    width   dest    AMO
SC.W/D  ordering  src  addr    width   dest    AMO

LR.W loads a word from the address in rs1, places the sign-extended
value in rd, and registers a reservation set=E2=80=94a set of bytes that
subsumes the bytes in the addressed word. SC.W conditionally writes a
word in rs2 to the address in rs1: the SC.W succeeds only if the
reservation is still valid and the reservation set contains the bytes
being written. If the SC.W succeeds, the instruction writes the word
in rs2 to memory, and it writes zero to rd. If the SC.W fails, the
instruction does not write to memory, and it writes a nonzero value to
rd. Regardless of success or failure, executing an SC.W instruction
*invalidates any reservation held by this hart*.

More details, ref:
https://github.com/riscv/riscv-isa-manual

> And what if you double loop it like cmpxchg() ?
Can you give a code snippet?


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
