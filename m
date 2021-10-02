Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D9E41FBD5
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhJBMqP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJBMqO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 08:46:14 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE5C0613EC;
        Sat,  2 Oct 2021 05:44:29 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id g15so5605319vke.5;
        Sat, 02 Oct 2021 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVIHqE0I61g4bwFIRyCXREcL44LmpaJhAtYvd0UBohs=;
        b=O81kD0SWRHC5D7i/OFsi1xsF767IV986zqG2VQJm20CrrDzz3B9ryfk8n+uEv3ZTuG
         vqauc1QwHsm6zCfLKIH+5Qqz9ilgXdzJZwv2QaFDyH2VkRjJgLDp8/pcnx4Sk7pbFq1S
         bOv5G970ZdzF5dC9XNJGg7XsFsoVB+BNxnCZ/IHrZNpQyggmkASjaWkc3nai6OtFHdEw
         J0hTvDQwEIPzNT8F1p05PG3mVjSH698S7wrSRZtVReHzoBGkDKPC6Xv2EpJ5tuCDrcLK
         M5rMwm0VFoApXPG7RI5m13umjQ5RdkhPJCe/4Z5jefwuo0xiz/71HOK8V6p0RoARcXkh
         f6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVIHqE0I61g4bwFIRyCXREcL44LmpaJhAtYvd0UBohs=;
        b=LAOk+cadXue9ciGBqNzpB74GVFwsb5Bm7K3nmT4oKvdao/bvNzWuBp+1rNmJT07at3
         9C6L5cmoLQbvGuacqRvxkdj3tAuFbBwwduktsiZYjGTeI/1SwxLP8ayfJndC0FILIxmr
         zqrTpvMVcnC2yfbIsqEsx8IH2NOAKAKuRStxDCK7dhUOYRQXoQeAIegxoItk5Q7DtWvY
         pOePknQweMO2XVOuO2DZpUwzSzooX4eo5VNepMp5r4pRp5h1jmnyeRltK/Vgrz4UUiqX
         1B/fXtrWPO7HP7xowmFm9eftEt4dNe1Rh5l5eqWNCQb528ZlVkaP3ARuh4pYgvihxFTM
         1M7Q==
X-Gm-Message-State: AOAM533ddhgI+w/v4CU7OMhbJ2nSsgBCbFFznDMjqaM3tHNOx83VbfJ1
        vH5LrzDfrIIruNHsfSaiAO7YB3ZLYkIpRomQtUM=
X-Google-Smtp-Source: ABdhPJynzQbo/b3iTy5fT21k0OcTl5MoO1jbyU4OMkOJrf7h23jwu1tBxcEnL/bc09spvpYsZy10dRqfbsP8PKn1zjE=
X-Received: by 2002:a05:6122:a24:: with SMTP id 36mr10923583vkn.25.1633178668176;
 Sat, 02 Oct 2021 05:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-20-chenhuacai@loongson.cn> <f6fc1fa8bf4decf97d76900a64fe0bc2bf25576d.camel@mengyan1223.wang>
 <CAAhV-H6WWPeYfYsAM2UfKH1GYVA=Ww2k1akAy-ve28u3kJL4pA@mail.gmail.com> <7805af604610508cec679a160d92025e8975132b.camel@mengyan1223.wang>
In-Reply-To: <7805af604610508cec679a160d92025e8975132b.camel@mengyan1223.wang>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 20:44:16 +0800
Message-ID: <CAAhV-H5ydR5bwz1+qZkCUZSF0TWmhoZi4Rq2tBFu4U3kQkw9Sg@mail.gmail.com>
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

On Sat, Oct 2, 2021 at 8:14 PM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Sat, 2021-10-02 at 18:53 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > On Thu, Sep 30, 2021 at 11:43 PM Xi Ruoyao <xry111@mengyan1223.wang>
> > wrote:
> > >
> > > On Mon, 2021-09-27 at 14:42 +0800, Huacai Chen wrote:
> > > > diff --git a/arch/loongarch/vdso/gen_vdso_offsets.sh
> > > > b/arch/loongarch/vdso/gen_vdso_offsets.sh
> > > > new file mode 100755
> > > > index 000000000000..7da255fea213
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/vdso/gen_vdso_offsets.sh
> > > > @@ -0,0 +1,14 @@
> > > > +#!/bin/sh
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#
> > > > +# Derived from RISC-V and ARM64:
> > > > +# Author: Will Deacon <will.deacon@arm.com>
> > > > +#
> > > > +# Match symbols in the DSO that look like VDSO_*; produce a
> > > > header
> > > > file
> > > > +# of constant offsets into the shared object.
> > > > +#
> > > > +
> > > > +LC_ALL=C
> > >
> > > I'm wondering whether this line is really useful... There is no
> > > "export"
> > > here so the variable won't be passed to the environment of the sed
> > > command below.
> > Have you encountered some problems with this? It just works for me,
> > and both ARM64 and RISCV are the same.
>
> No problems, and I also seen those in ARM64 & RISCV.  But AFAIK this
> line really does nothing and can be removed.
>
> If LC_ALL=C is really necessary for the sed to operate correctly, it
> should be "exported" as
>
> LC_ALL=C
> export LC_ALL
>
> ("export LC_ALL=C" will work under bash, but it's not POSIX.)
>
> Or, explicitly pass LC_ALL to sed with:
>
> LC_ALL=C sed ...
OK, I think this way is better. Thanks.

Huacai
> --
> Xi Ruoyao <xry111@mengyan1223.wang>
> School of Aerospace Science and Technology, Xidian University
