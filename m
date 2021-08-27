Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0305C3F9380
	for <lists+linux-arch@lfdr.de>; Fri, 27 Aug 2021 06:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhH0EYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Aug 2021 00:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhH0EYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Aug 2021 00:24:11 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FBFC061757
        for <linux-arch@vger.kernel.org>; Thu, 26 Aug 2021 21:23:22 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id m39so2740137uad.9
        for <linux-arch@vger.kernel.org>; Thu, 26 Aug 2021 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5kPlsj0klCZK+0JoyMyicjpBf4mxa4BaBWw3/2qMY8=;
        b=BCqCcJW8vXNpa1J3Or4GMSVJ4eknXVRq1XRHV86/JIpo9dnRwKVCIaFf87PbVCWDwk
         5NORxVX5Ly5T4BgAw9dl0dX6KzLUWVYRTLP31Yx2HCbtldG2GT0JOQLkrHNLbHspO1u2
         YmRTHgvVrggTKFD/khQCeSz81gvZ9MHxOOEzsamo0T9WziS/2aHk+EIs62DFKY87vfE0
         5npGxVDzuCnGpbOwUcztpVAsm7HBBN/tOVhY8MoNIQuawYHFF5FL/7QQYMBgpdVcbgWz
         GuCa7tNzt4FtChSh93nvnKxOnt2up38rhyMTVOcsKGuYpO/BB1dmN9VRqAxhWm/W+cnb
         cKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5kPlsj0klCZK+0JoyMyicjpBf4mxa4BaBWw3/2qMY8=;
        b=JvJKky4xjEouIG5VjzGAZGuLq6vlf3dli548JkEpabXB3nuR9EK5hCwJCojsWsF7Lb
         BporSUZFqibm3R/ptGufn79CTEyPVbHqDLgp6j/by9fCZ53ZmuZj/PFErfRD9tMj2tXd
         NsWszJcIILTI9xuNDtvtAhyWdlyW4zWTvH2b/pcT/CPISrK1Y6aGRQbhXDSI9tPuHyWf
         +/cngi+oohhakK0S4V/n6qCBW4k54R9WzC0QfFUiEqI9aOQCyL+ZFDwlNMr6RtUVFPRi
         141E+MGcSy/+dJT5Q+GwTlTWqFtAjcIY/OG1fEx6JuQpqkJ0E04vUC9OxVIbO2eFf3mY
         LanQ==
X-Gm-Message-State: AOAM533iVJIWFLLnnHKeDYPwdy7tME2FTrIW+r0STdAi1gS5M+VaUzZM
        X0An1dVfkjIULOrwd3V1yooqXPowAVXnkng13MvJbqnc4NY=
X-Google-Smtp-Source: ABdhPJy8iHGWUfcBYbQKCQJWW7jR//YD34b7hmPWmsNRifC/J5uZuVD1Cb/6asAvBtsfeKXy2E43ThUi+mgHaSwNISc=
X-Received: by 2002:a9f:21f1:: with SMTP id 104mr5284749uac.143.1630038201801;
 Thu, 26 Aug 2021 21:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-11-chenhuacai@loongson.cn> <df1260f044186d0bbb56b297c88ac3658a888f98.camel@mengyan1223.wang>
In-Reply-To: <df1260f044186d0bbb56b297c88ac3658a888f98.camel@mengyan1223.wang>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 27 Aug 2021 12:23:10 +0800
Message-ID: <CAAhV-H5UQQ81=P+i+5Xr3cRU_EqixO2EFHB1yjfi_ioV0cEfhA@mail.gmail.com>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
To:     Xi Ruoyao <xry111@mengyan1223.wang>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ruoyao,

On Fri, Aug 27, 2021 at 12:44 AM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Tue, 2021-07-06 at 12:18 +0800, Huacai Chen wrote:
>
> > +/**
> > + * struct ucontext - user context structure
> > + * @uc_flags:
> > + * @uc_link:
> > + * @uc_stack:
> > + * @uc_mcontext:       holds basic processor state
> > + * @uc_sigmask:
> > + * @uc_extcontext:     holds extended processor state
> > + */
> > +struct ucontext {
> > +       /* Historic fields matching asm-generic */
> > +       unsigned long           uc_flags;
> > +       struct ucontext         *uc_link;
> > +       stack_t                 uc_stack;
> > +       struct sigcontext       uc_mcontext;
> > +       sigset_t                uc_sigmask;
> > +
> > +       /* Extended context structures may follow ucontext */
> > +       unsigned long long      uc_extcontext[0];
> > +};
> > +
> > +#endif /* __LOONGARCH_UAPI_ASM_UCONTEXT_H */
>
> Hi Huacai,
>
> Maybe this is off topic, but I just seen something damn particular in
> your workmates' glibc repo:
>
> https://github.com/loongson/glibc/commit/86d7512949640642cdf767fb6beb077d446b2857
> "Modify struct mcontext_t and ucontext_t layout":
The V1 of kernel patchset "match" the old, un-pulblic toolchain, and
the new public toolchain (which you have seen) adjust ucontext, and
the V2 of kernel patchset will be also update ucontext. But anyway,
thank you very much!

Huacai

>
> > @@ -75,8 +73,8 @@ typedef struct ucontext_t
> >    unsigned long int __uc_flags;
> >    struct ucontext_t *uc_link;
> >    stack_t uc_stack;
> > -  mcontext_t uc_mcontext;
> >    sigset_t uc_sigmask;
> > +  mcontext_t uc_mcontext;
> >  } ucontext_t;
>
> AFAIK if this doesn't match the struct ucontext definition above, the
> system will just blow up?  Have you coordinated with the change?
>
