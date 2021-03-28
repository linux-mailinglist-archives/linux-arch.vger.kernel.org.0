Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C577634BA63
	for <lists+linux-arch@lfdr.de>; Sun, 28 Mar 2021 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhC1BvT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 21:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhC1BvD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Mar 2021 21:51:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E726199F;
        Sun, 28 Mar 2021 01:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616896262;
        bh=BUNgSqvKCD1KhF3NeU2ADrUH6ViHHRa1+b6YkOC3oZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mXgn7fkgHaKx1wyAyVt+m5lJNJR0MzrE5OrAMbPfJPMq5Pg60W+BTvSMElW0NSsuT
         KUK5vc0PysUqrztNBlXk6YoPv2cxfSDSDF5Ufxb6AVbMaWxS17bHEvmkWBoHyK1kac
         gS2SHu2OPT8GqCphEMfoQ7tJOmDkwoXtyK69fIphdEPGJUbJs6dVRo/7S3vdRta+8A
         xh0qvvCfqrw/lkax7EDQVn9h8cfDK5xudZJNNpjdPAkleyXyFbkvo9W2zeAMEWVJI8
         6LsAs+m19cTaes6i1gyj8TAPGFYeO9YA3y/xrFdG11F9Vn0cakibZaJAN79m+0UPQB
         obgkouu9nS3Kg==
Received: by mail-lj1-f169.google.com with SMTP id 184so11821979ljf.9;
        Sat, 27 Mar 2021 18:51:02 -0700 (PDT)
X-Gm-Message-State: AOAM532uYaG+Abh2Aj5/tC51vyEKY8CfS5JY/IAGDQFsPvzKM75CQKca
        Tm0Y5VUdKLCG0wCn7TR++77/tdRZeb6RCZ1Ijyk=
X-Google-Smtp-Source: ABdhPJwOo1LYn6W8dv8w9E8xhDuwCGJKtTINJ/V9CDbT+ATTN6EFhh/n5CyatHU/ICm8j1lw1imnRI+VEW+DCIiuk8o=
X-Received: by 2002:a2e:2c0d:: with SMTP id s13mr13299541ljs.105.1616896260724;
 Sat, 27 Mar 2021 18:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-3-git-send-email-guoren@kernel.org> <CAK8P3a0FG3cpqBNUP7kXj3713cMUqV1WcEh-vcRnGKM00WXqxw@mail.gmail.com>
In-Reply-To: <CAK8P3a0FG3cpqBNUP7kXj3713cMUqV1WcEh-vcRnGKM00WXqxw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 28 Mar 2021 09:50:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSnrAasbGdpjcNk6xFDP5-06ZjQK+AWB6jJ7M3GXbZ9Q@mail.gmail.com>
Message-ID: <CAJF2gTTSnrAasbGdpjcNk6xFDP5-06ZjQK+AWB6jJ7M3GXbZ9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] riscv: cmpxchg.h: Merge macros
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Clark <michaeljclark@mac.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Arnd,

On Sun, Mar 28, 2021 at 5:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 27, 2021 at 7:06 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > To reduce assembly codes, let's merge duplicate codes into one
> > (xchg_acquire, xchg_release, cmpxchg_release).
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>
> This is a nice cleanup, but I wonder if you can go even further by using
> the definitions from atomic-arch-fallback.h like arm64 and x86 do.
Ok, I'll separate it from the qspinlock patchset and try atomic-arch-fallback.h.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
