Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E357246FF02
	for <lists+linux-arch@lfdr.de>; Fri, 10 Dec 2021 11:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhLJKxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Dec 2021 05:53:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36390 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbhLJKxi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Dec 2021 05:53:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B19A8CE2A78;
        Fri, 10 Dec 2021 10:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D47C341CA;
        Fri, 10 Dec 2021 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639133400;
        bh=UihNu6COUMxpwtIho6XydfuI5rt6RIkfKQZSbPH2tXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VwJVFAMM08SEUuV2rTSpBu3T+tMM9x5PDHZH5SdQ0vo+BWGZZWdEYgwmRtZZsPOAN
         tnOYgBG8/kmmKEEHc6At7xbpuWqP5l4Wgu5uUbCYW808nxnEyRUeYxzoKoqftoXSCG
         Alc8dLWGTAuNWdakOCLs8zqiDrAb8kD0Sb6/B1DBODVE2n6CTDf1xQKMw6+LWdJIp7
         lPiSQLbzevIhI3QoqURapxvt8QYb+5feKEMdJr2lgjw7TyxtLY9q/I8RyqjqIvFCIS
         khVD+PAa721uQ4xjqV6ey31NNM8tdT0l9bCmt7fNINKHuH1qNVGnySt0VbfC976fBh
         VTNL+pRUxn1fg==
Received: by mail-wr1-f41.google.com with SMTP id u1so14133369wru.13;
        Fri, 10 Dec 2021 02:49:59 -0800 (PST)
X-Gm-Message-State: AOAM532Hfo6c8YBEAqwPNgjKVQDMer1SE4oCDtWSAIYy8Ytp7xPGGSih
        o1BWDq2MYLIm9o+DapxV5fQqFef+SoswvdqzHok=
X-Google-Smtp-Source: ABdhPJyZGgQtOe+9a3VMoC6FsmMk7PBQfc6X6IcZo5cHZZyqsyM1wdwTH5ecyFajtYl/RdstFR1ZxOxYvw6Q53aMxF8=
X-Received: by 2002:adf:d091:: with SMTP id y17mr13756102wrh.418.1639133398302;
 Fri, 10 Dec 2021 02:49:58 -0800 (PST)
MIME-Version: 1.0
References: <20211126095852.455492-1-arnd@kernel.org> <YbMuYlTwaedpI6iz@gmail.com>
In-Reply-To: <YbMuYlTwaedpI6iz@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 10 Dec 2021 11:49:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3tqg2eewMA1jvg==hV-XfK4kMGimx9-oD8A1P69-K6ew@mail.gmail.com>
Message-ID: <CAK8P3a3tqg2eewMA1jvg==hV-XfK4kMGimx9-oD8A1P69-K6ew@mail.gmail.com>
Subject: Re: [PATCH] futex: Fix sparc32/m68k/nds32 build regression
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 10, 2021 at 11:39 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>

> Doesn't solve the regression on MIPS defconfig:
> ./arch/mips/include/asm/futex.h: In function 'arch_futex_atomic_op_inuser':
> ./arch/mips/include/asm/futex.h:89:23: error: implicit declaration of function 'arch_futex_atomic_op_inuser_local'; did you mean 'futex_atomic_op_inuser_local'? [-Werror=implicit-function-declaration]
>    89 |                 ret = arch_futex_atomic_op_inuser_local(op, oparg, oval,\

Right, mips and xtensa still have the same problem that I fixed for
the others, I posted
another fix after the 0day bot reported it. I think

https://lore.kernel.org/lkml/20211203080823.2938839-1-arnd@kernel.org/

should address the remaining regression.

       Arnd
