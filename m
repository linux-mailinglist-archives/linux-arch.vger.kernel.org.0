Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031BC362CB6
	for <lists+linux-arch@lfdr.de>; Sat, 17 Apr 2021 03:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhDQBgw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 21:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQBgw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Apr 2021 21:36:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8316661152;
        Sat, 17 Apr 2021 01:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618623382;
        bh=ZGiW7XjMqPnX23vPoAublY1GvetP+oWUwxHm3Gl4bys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WYWIrAO0aznXudfwyArZZchGzW//lTcOIanP2Dwv4MwsOGn6vnJEiw/4XXM/6/tSP
         jfom0wQ/Wj/VtkFvJKIzn7/oIXwHz71T2CRQ6XeIxheHO0qw1h+w5WM8Zw3LEvxmTJ
         e/jf/DdexeAeRRm9CsR8N4jgNSt4Cz2q6YwjsagB8zb8P6/wib1J1KWliDaVv4x4Vr
         uvvtPDHzqTYHEFgYdV7x7Eg7nOqy22WUbVg/39LBgX2asBS5K2qEy5fgVAJIMnZ/9K
         r0NgoVxjbVyrFtpCEkPjnoFwM36Wy9C2yW/gN0PGaTaXzvs4efl+7WYR8SXKKqiaPV
         iP0W0AMhSjGXQ==
Received: by mail-lf1-f42.google.com with SMTP id j18so47581624lfg.5;
        Fri, 16 Apr 2021 18:36:22 -0700 (PDT)
X-Gm-Message-State: AOAM533uOWRTaMelFZguDA3SQ2XuDs+Exq+Dbi4huSOx2aMhDms6rdJK
        040pGxIKVCdxP+aiuxk5LsZ6P2OIHN01twItW0U=
X-Google-Smtp-Source: ABdhPJxTCiLOcyZP0px1a402RFobt2UPKd4ESZA4RmjuKj/Df+3QjO9s2AEmxJ7uCDt4RbfEfMedzHX8FW2hLzoHu5c=
X-Received: by 2002:a19:e34c:: with SMTP id c12mr4894188lfk.555.1618623380992;
 Fri, 16 Apr 2021 18:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <1618472362-85193-1-git-send-email-guoren@kernel.org> <YHf+z0AotZmjvaJ/@hirez.programming.kicks-ass.net>
In-Reply-To: <YHf+z0AotZmjvaJ/@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 17 Apr 2021 09:36:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQkPauGnLXUfs4sPvDx1MhXvCmb9ouGOAANsuEFU2qz1A@mail.gmail.com>
Message-ID: <CAJF2gTQkPauGnLXUfs4sPvDx1MhXvCmb9ouGOAANsuEFU2qz1A@mail.gmail.com>
Subject: Re: [PATCH] riscv: atomic: Using ARCH_ATOMIC in asm/atomic.h
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 15, 2021 at 4:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 15, 2021 at 07:39:22AM +0000, guoren@kernel.org wrote:
> >  - Add atomic_andnot_* operation
>
> > @@ -76,6 +59,12 @@ ATOMIC_OPS(sub, add, -i)
> >  ATOMIC_OPS(and, and,  i)
> >  ATOMIC_OPS( or,  or,  i)
> >  ATOMIC_OPS(xor, xor,  i)
> > +ATOMIC_OPS(andnot, and,  -i)
>
> ~i, surely.

Thx for correct me. I'll fix it in the next version patch.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
