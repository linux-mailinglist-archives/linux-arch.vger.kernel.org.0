Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1045C3F93B2
	for <lists+linux-arch@lfdr.de>; Fri, 27 Aug 2021 06:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhH0E16 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Aug 2021 00:27:58 -0400
Received: from mengyan1223.wang ([89.208.246.23]:36706 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhH0E16 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Aug 2021 00:27:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 961636618C;
        Fri, 27 Aug 2021 00:27:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1630038429;
        bh=HQ5lvpjI4XUtZdLwCt9ajrrIpUohiLWau8D3VdTfHXY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xXcXyQOTRAghOhepy4R+uAIDJLZl3lNGYwEykybT6y3d8N6tsTezDNCrDKjdyj5LT
         ONTJ94Sj6tBfSTFW8F8rcUtvJ+lzICzuNnE9MFXB7yyIVcll8d+RDv8FBXxx8tGoKe
         J0leJcEIdK6X7obt2VPk1caPuO0IVGujoPeTk68sMmPDZUIrtcGYJ/9/3cm+Dk2qTD
         mUGRLaHDQTNwTi1zfQChAUWZsXPXecmolKz9y/M+I/9aYhhBXp4KM2XdeDVoBjicj5
         aP+AIHGQxihoCN0ClXuF7tUo/xOBmcGWE+iw0uXEbvW6+Vv/B3ZJu5upk2iomzj9Fp
         GeRU/r/CFLCfQ==
Message-ID: <68d81c5ef4d877456aa44cac33fe6c87afc1ec45.camel@mengyan1223.wang>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Fri, 27 Aug 2021 12:27:05 +0800
In-Reply-To: <CAAhV-H5UQQ81=P+i+5Xr3cRU_EqixO2EFHB1yjfi_ioV0cEfhA@mail.gmail.com>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
         <20210706041820.1536502-11-chenhuacai@loongson.cn>
         <df1260f044186d0bbb56b297c88ac3658a888f98.camel@mengyan1223.wang>
         <CAAhV-H5UQQ81=P+i+5Xr3cRU_EqixO2EFHB1yjfi_ioV0cEfhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2021-08-27 at 12:23 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
> 
> On Fri, Aug 27, 2021 at 12:44 AM Xi Ruoyao <xry111@mengyan1223.wang>
> wrote:
> > 
> > On Tue, 2021-07-06 at 12:18 +0800, Huacai Chen wrote:
> > 
> > > +/**
> > > + * struct ucontext - user context structure
> > > + * @uc_flags:
> > > + * @uc_link:
> > > + * @uc_stack:
> > > + * @uc_mcontext:       holds basic processor state
> > > + * @uc_sigmask:
> > > + * @uc_extcontext:     holds extended processor state
> > > + */
> > > +struct ucontext {
> > > +       /* Historic fields matching asm-generic */
> > > +       unsigned long           uc_flags;
> > > +       struct ucontext         *uc_link;
> > > +       stack_t                 uc_stack;
> > > +       struct sigcontext       uc_mcontext;
> > > +       sigset_t                uc_sigmask;
> > > +
> > > +       /* Extended context structures may follow ucontext */
> > > +       unsigned long long      uc_extcontext[0];
> > > +};
> > > +
> > > +#endif /* __LOONGARCH_UAPI_ASM_UCONTEXT_H */
> > 
> > Hi Huacai,
> > 
> > Maybe this is off topic, but I just seen something damn particular
> > in
> > your workmates' glibc repo:
> > 
> > https://github.com/loongson/glibc/commit/86d7512949640642cdf767fb6beb077d446b2857
> > "Modify struct mcontext_t and ucontext_t layout":
> The V1 of kernel patchset "match" the old, un-pulblic toolchain, and
> the new public toolchain (which you have seen) adjust ucontext, and
> the V2 of kernel patchset will be also update ucontext. But anyway,
> thank you very much!

Thanks for the explaination! I'll try to incorporate the change into my
next round of system build.
> 

