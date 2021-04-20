Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53943364FD0
	for <lists+linux-arch@lfdr.de>; Tue, 20 Apr 2021 03:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhDTBXR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 21:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhDTBXR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 21:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 863F561026;
        Tue, 20 Apr 2021 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618881766;
        bh=SSh/fCkAeoAWllWsDSR3ydZ10BhcC+iH1ETqUqxNxqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AtKaVklDeGRTzVhY+VZa+8zYM1l1j0puh23Gm/qFyb/1hzEamHdxXSx4RBkYqz0j3
         T6WRibKOcfZlWhyy2CAcH1Os5dO5W/II8O93C6xbXCtVHB0lX7sxl9rBFPfbsk50kp
         DNaGI/T4WKpUxdUlt+6h3jEAeDD2u6ivUsQUzoMyXWW7WqKa5ROPBND8YoJVEcSMOH
         nuW5KPzInhdvVotlFS3lab8wVXAhNLVRA+WidkMd2L+Ln/vPjTwgc4FdnvlI1kzbly
         eZCIOD88XVEtZLTFDqIWODgMaY3sfbOUYHbDzCpbuEwWP1Av1/JL/VH9NAwA43gOeq
         mDxqzPgZ2IfOg==
Received: by mail-lf1-f47.google.com with SMTP id x19so28559904lfa.2;
        Mon, 19 Apr 2021 18:22:46 -0700 (PDT)
X-Gm-Message-State: AOAM533ScPmtd1mrt6m2pvP8lfJwARvtpdsZ37GsdDt+cEeNYteX6wGo
        PQxJE8p25eY1LZbmhyxvObQEZY/D/yUDCd40+LQ=
X-Google-Smtp-Source: ABdhPJyNkQ4waQWIRsWkLecTECs70MszIvNEP1jOKg4Id9kxfy7inXyBd0MPgLbxDuc0+3tpeauHn3eDAQDDCpZY2gY=
X-Received: by 2002:a05:6512:3050:: with SMTP id b16mr6731861lfb.24.1618881764817;
 Mon, 19 Apr 2021 18:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <1618634729-88821-1-git-send-email-guoren@kernel.org>
 <1618634729-88821-2-git-send-email-guoren@kernel.org> <CAK8P3a1ygwS7jTXqYXCfppEEonCASqG_5GM9O_AtE9YgdgNqVQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1ygwS7jTXqYXCfppEEonCASqG_5GM9O_AtE9YgdgNqVQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Apr 2021 09:22:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRkWD6NcfriQhLBYL0eBafNmLx1Kw_Rmaex3851SzVBWQ@mail.gmail.com>
Message-ID: <CAJF2gTRkWD6NcfriQhLBYL0eBafNmLx1Kw_Rmaex3851SzVBWQ@mail.gmail.com>
Subject: Re: [PATCH v2 (RESEND) 2/2] riscv: atomic: Using ARCH_ATOMIC in asm/atomic.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 19, 2021 at 7:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Apr 17, 2021 at 6:45 AM <guoren@kernel.org> wrote:
> > +#define arch_atomic_read(v)                    __READ_ONCE((v)->counter)
> > +#define arch_atomic_set(v, i)                  __WRITE_ONCE(((v)->counter), (i))
>
> > +#define ATOMIC64_INIT                          ATOMIC_INIT
> > +#define arch_atomic64_read                     arch_atomic_read
> > +#define arch_atomic64_set                      arch_atomic_set
> >  #endif
>
> I think it's a bit confusing to define arch_atomic64_read() etc in terms
> of arch_atomic_read(), given that they operate on different types.
>
> IMHO the clearest would be to define both in terms of the open-coded
> version you have for the 32-bit atomics.
Okay:

 +#define arch_atomic64_read                     __READ_ONCE((v)->counter)
 +#define arch_atomic64_set
__WRITE_ONCE(((v)->counter), (i))

>
> Also, given that all three architectures (x86, arm64, riscv) use the same
> definitions for the six macros above, maybe those can just get moved
> into a common file with a possible override?
I'll try it with a separate patch.

>
> x86 uses an inline function here instead of the macro. This would also
> be my preference, but it may add complexity to avoid circular header
> dependencies.
>
> The rest of this patch looks good to me.
>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
