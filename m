Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECE22FE370
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 08:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbhAUHHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 02:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbhAUHG6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 02:06:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5F522396F;
        Thu, 21 Jan 2021 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212773;
        bh=+bR9mDjPABrW2I1N+ggiiIHfc5sdRePQ1Z2nWFNy3v8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kO1My+E6E5Z8kmHmyP/MKIPDBqje9m1WfAwCSmwq7fgrWDJHCOGHb7+obLXxVcVUf
         2bSRE/N9/kHF2ItTiCZAvOQ1FkgDiqz4//FdN+fnbPGUU8QueIzbjppd1RQnzRAxIa
         8/TTuHkWF+wlly55WkxMYD6vSihJoCB78ChXBxefrMcdxOTa6psEsrbGDD4LJb+Ve6
         eBaiCE056mVQglJpaM9WtrlxWxM6DIiS8a7qhw27P/3D8vV2kVClav8yzZG3uTPxg6
         agW0vDPfe5mjzno7f59umtfO0DNPZC0Gds3TBPwAHPBzYGTbM5NrdT/dyTj8DkvDSU
         Gb00+JArEjQJg==
Received: by mail-lj1-f172.google.com with SMTP id x23so1293769lji.7;
        Wed, 20 Jan 2021 23:06:12 -0800 (PST)
X-Gm-Message-State: AOAM530DW6WSV0Rdq8wIU4SoKINsadI+cfD/EMonffAre0R8VyTZw+u9
        9qqB5PTYWc0lCkdJOD7zs0uDrLnUaqRdMSCR2Bk=
X-Google-Smtp-Source: ABdhPJy+uqjQSznP0t82Diob/W2b6pomXLxlwX3tvtwMmaH/yL0+bnfafklzET/z2EdofQ8T7rS4I6hnaNNa15w41uE=
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr6599880ljf.18.1611212771058;
 Wed, 20 Jan 2021 23:06:11 -0800 (PST)
MIME-Version: 1.0
References: <1608478763-60148-1-git-send-email-guoren@kernel.org>
 <1608478763-60148-4-git-send-email-guoren@kernel.org> <X/cBV8Bll0K2PwTx@hirez.programming.kicks-ass.net>
In-Reply-To: <X/cBV8Bll0K2PwTx@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 21 Jan 2021 15:05:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQDs+mfr2QU2JqYWswdt9kV9CmC=K7=LwDHeE=rVaLf5A@mail.gmail.com>
Message-ID: <CAJF2gTQDs+mfr2QU2JqYWswdt9kV9CmC=K7=LwDHeE=rVaLf5A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] csky: Fixup asm/cmpxchg.h with correct ordering barrier
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Thu, Jan 7, 2021 at 8:41 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Dec 20, 2020 at 03:39:22PM +0000, guoren@kernel.org wrote:
>
>
> > +#define cmpxchg(ptr, o, n)                                   \
> > +({                                                           \
> > +     __typeof__(*(ptr)) __ret;                               \
> > +     __smp_release_fence();                                  \
> > +     __ret = cmpxchg_relaxed(ptr, o, n);                     \
> > +     __smp_acquire_fence();                                  \
> > +     __ret;                                                  \
> > +})
>
> So you failed to Cc me on patch #2 that introduces these barriers. I've
> dug it out, but I'm still terribly confused on all that.
>
> On first reading the above looks wrong.
>
> Could you also clarify the difference (if any) between your bar.brwarw
> and sync instruction?
>
> Specifically, about transitiviry, or whatever we seem to be calling that
> today.

bar.brwarw just like riscv fence.rwrw
bar means barrier
brw means before read and write would happen before the instruction.
arw means after read and write would happen after the instruction
So it also could be bar.brarw / bar.arw / bar.brw / bar.braw

sync means we need to wait until all instructions complete in the CPU
pipeline and then issue the next instructions.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
