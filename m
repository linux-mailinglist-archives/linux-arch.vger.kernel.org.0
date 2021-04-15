Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0F360A52
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhDONQJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 09:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhDONQI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 09:16:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 629C161249;
        Thu, 15 Apr 2021 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618492545;
        bh=CBNjr3AxBARmjy8Ci1TwNIUkQ2u/unZwMvqua1P3OmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lAe/oBzGAkjcRpE1psbxEBjcOuUPSnZHWgAIP492dc+WaHiyaFzNP/blo5D0aM9s5
         kcpPAxWNPbzRdR+sDHpnds82ItqaKSM4IePKgU2ZP2pjFcSoixJGFFBXDLlv1rD5Tx
         396TxqC5l+hq7FCVtrdZ92WLqeQQr3ReAVSmuoPho8YwOAGKephnWH2wNDRufWzhCo
         8Rrd9BYz/7XrTHvUsyNHl5IETovmtbxxjMCI4eZt+t6BrRMuGJIFB7D0gHpBl98bjN
         0LTebYclB0ln647iF2s6F82eHUjdSaeM5wEzFp7pVdo/uFg42VRGETrMQxjTSJYKU7
         nJ1uqORBC0g/Q==
Received: by mail-lf1-f48.google.com with SMTP id 12so39001046lfq.13;
        Thu, 15 Apr 2021 06:15:45 -0700 (PDT)
X-Gm-Message-State: AOAM530dpbQ/W+jrfWeicNub8+EAmoI039jw5Ck1gW57NoFp8tcVCKoJ
        Dzfd7PJ8/DuZ3CPSh/CrcSFJtLDyADvHPtZWD0g=
X-Google-Smtp-Source: ABdhPJzwnmsP4WZeNpgfK/xKMZPMcbAQIJRnbGcOLkvM8+Q7NnxMly071ZBmAQhcthXX2SrLsntKAnToaUnnxNkn9gE=
X-Received: by 2002:ac2:55b8:: with SMTP id y24mr2529050lfg.24.1618492543822;
 Thu, 15 Apr 2021 06:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <1618472362-85193-1-git-send-email-guoren@kernel.org> <YHf+z0AotZmjvaJ/@hirez.programming.kicks-ass.net>
In-Reply-To: <YHf+z0AotZmjvaJ/@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 15 Apr 2021 21:15:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT7ft8xNkQcAef1XFuWsVdNHcoGMZt-mWFmk47fKh0ecg@mail.gmail.com>
Message-ID: <CAJF2gTT7ft8xNkQcAef1XFuWsVdNHcoGMZt-mWFmk47fKh0ecg@mail.gmail.com>
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

Sorry, forgot riscv32. I would fix that.

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



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
