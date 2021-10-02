Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5841FAF5
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhJBKzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 06:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhJBKzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 06:55:35 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00117C061570;
        Sat,  2 Oct 2021 03:53:49 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x1so14200282vsp.12;
        Sat, 02 Oct 2021 03:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8AMvlzdTkejVxsXWrKsf8n98oO9XTyRrRx8u9e01JA=;
        b=mAzt/HA+CIYNMZlJW6XxNwlMC5YmuF+mVinP76jsN76NU5hM+CHrpKGFycQVbM2Fbh
         W6SoyHlLzjSVwJfIRAa+j2bA23Aagt4hNflg+v948dOCE8EL9f7RZNEwMECl/UZPFFmf
         k7/dvLKQ4JbjkZCVwDL7V4PEFRj7nUJ5V/Q9I0Xw6FjjcB40bADihBgPWO9MCfFZ1OoZ
         GEfsqBEOgS3fkBHCfVnGFwbx5Hdsyu1IpGboSp8u+EVG+UGwR/Cv/7jF02DhAjuf4SFv
         GzUvHbqi6Dze0GDc6rJB8Qrb9KOUL0TIAUjVqDgzedQgpHeNnaSa9dbjhAmmYUg9j0gE
         wmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8AMvlzdTkejVxsXWrKsf8n98oO9XTyRrRx8u9e01JA=;
        b=5Jo9TLYo63MT1LGG2xYzd2zzCkVlUSxondW24XMwVe+mtu96KIyKFebaB/pSSg+QOD
         n443Kf1ENSrYVxhTOoffjn0WKApqStudGH2PhsfQwCviCO3BESyB76mzdnhAQ8X4/2Kk
         b3l2NzH1bnuCxioEQVNjNG0h1lsCpwQV5hf7avjM+6PhXsFiZ+kk3lj+Cs31PEd3fTF4
         op5E0ij+YGp1U6tvAIuy1UuD1oqMM3bKlcPNH/uEbNenE+FVupTtAi/RTrwk6NL2bmp7
         G58H/SYUSL4QMWwhT559Ptol+IOTWsyc6wTg5+hLbdHg5Wuify12sLXRVb2mFvgj4u9U
         L9Jg==
X-Gm-Message-State: AOAM532cKRSvikO7thUBQlfKGpuHxm8OzvBPOrvSdzXzteg7Z6K9Ddk/
        +VfLUOMvS0mw6vlPwJQh4Zj8bjovkzM7Ps+vAAc=
X-Google-Smtp-Source: ABdhPJycNzslYkqewwAUOxVjedhgvWNh8sdMsYSbO8n4dKO778ubzmg+9g0x9Co6fgBsYA549fG22gUQCoBIxy0C+hM=
X-Received: by 2002:a05:6102:2757:: with SMTP id p23mr8117038vsu.61.1633172029191;
 Sat, 02 Oct 2021 03:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-20-chenhuacai@loongson.cn> <f6fc1fa8bf4decf97d76900a64fe0bc2bf25576d.camel@mengyan1223.wang>
In-Reply-To: <f6fc1fa8bf4decf97d76900a64fe0bc2bf25576d.camel@mengyan1223.wang>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 18:53:37 +0800
Message-ID: <CAAhV-H6WWPeYfYsAM2UfKH1GYVA=Ww2k1akAy-ve28u3kJL4pA@mail.gmail.com>
Subject: Re: [PATCH V4 19/22] LoongArch: Add VDSO and VSYSCALL support
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ruoyao,

On Thu, Sep 30, 2021 at 11:43 PM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Mon, 2021-09-27 at 14:42 +0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/vdso/gen_vdso_offsets.sh
> > b/arch/loongarch/vdso/gen_vdso_offsets.sh
> > new file mode 100755
> > index 000000000000..7da255fea213
> > --- /dev/null
> > +++ b/arch/loongarch/vdso/gen_vdso_offsets.sh
> > @@ -0,0 +1,14 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +#
> > +# Derived from RISC-V and ARM64:
> > +# Author: Will Deacon <will.deacon@arm.com>
> > +#
> > +# Match symbols in the DSO that look like VDSO_*; produce a header
> > file
> > +# of constant offsets into the shared object.
> > +#
> > +
> > +LC_ALL=C
>
> I'm wondering whether this line is really useful... There is no "export"
> here so the variable won't be passed to the environment of the sed
> command below.
Have you encountered some problems with this? It just works for me,
and both ARM64 and RISCV are the same.

Huacai
>
> > +sed -n -e 's/^00*/0/' -e \
> > +'s/^\([0-9a-fA-F]*\) . VDSO_\([a-zA-Z0-9_]*\)$/\#define
> > vdso_offset_\2\t0x\1/p'
