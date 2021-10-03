Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7880E420100
	for <lists+linux-arch@lfdr.de>; Sun,  3 Oct 2021 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhJCJM5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Oct 2021 05:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJCJM5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Oct 2021 05:12:57 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC8C0613EC;
        Sun,  3 Oct 2021 02:11:10 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id u66so543857vku.4;
        Sun, 03 Oct 2021 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPleIos8zuocYDdWZp8SNu5UWPdQdIHw7rKBa26GVq8=;
        b=V/pFiv8W0GUSl3MEfw9m5XmzXy4J28eDIm9TdnXbyqy5ibrfvn+1SqAfU1RXho4QP/
         yLGqDkfegiQx9ZeYcIlTICQNhvtOy3knSN43E9dIrYObKk2cA4DoJoi09yb0G9909FhW
         Jqs0WUgBhZJT7yg/Or4pMSFxAJGQkbW6pTz+e5L2SNNq8ja3tJzPQOnAvT8eua1sDM4F
         jkECM8m1cbaksHsolQjlKk+zlqkcRIlGxlf+DDvIbKfUnItb+vIOA5foy/h9e0y8kN03
         GwwVzfVCx97BRXRKZI49TqA/4GvFJ+MVE9Oop8cp/soiosqNt3ckHkha0o4C7xOcK8i8
         LSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPleIos8zuocYDdWZp8SNu5UWPdQdIHw7rKBa26GVq8=;
        b=NiP1srNMLsI3pC7Eam9DkYxEMciqIAK3fj2Xy7RF2mRVIkIXWsu0LtlK+goEL36qbt
         zfjCK9G2pKaUA5m8aiZvMN9XJHnu+Q2zp9IRPhVadP6uNnl/Js5GQOJILeizQqh0Jtbw
         0Pfaj58mBkTwVBJ5fxgEtD5PZW33RjFJ1l/bXWPTwF2WjtvuIfZdiQMZIhXirpfM1ArR
         zPYTFIUoRnPb0x4Zn4gD5cx22moxLooBeQ1fTqLCQmRSUU6fH3Hu8Jnyjw2YBp40OTF0
         7VkOJaMEV2dnwWRIaZ5UvE59bR64dFzBvPHq3F8hF9p8NibgkCgxHgV1cUZ1kebbPYRI
         Yllw==
X-Gm-Message-State: AOAM532vQkSmCpwQTZxky4Oz0aNipVkudjHT9C7BoU/XFsb72R8RLORf
        QkPr0d1BozPY3X+vj24J5f4kEAbUKx6uSvRpYQ4=
X-Google-Smtp-Source: ABdhPJy7h5pk1kzVx4IF5Lq7FWIXift5eu5mcCsilcdds9wFERzQpH+cg/XWA38awf0/pOGRQVF5wgcsN3jzTv/bJXk=
X-Received: by 2002:a1f:2cd1:: with SMTP id s200mr12167838vks.3.1633252269396;
 Sun, 03 Oct 2021 02:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-12-chenhuacai@loongson.cn> <YVkZ7jLWJpvZz9us@zeniv-ca.linux.org.uk>
In-Reply-To: <YVkZ7jLWJpvZz9us@zeniv-ca.linux.org.uk>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 3 Oct 2021 17:10:58 +0800
Message-ID: <CAAhV-H5ndJvpcZ3P0P-65_-MFmpLuZ7k8Be6vUAFaL--sXDtxg@mail.gmail.com>
Subject: Re: [PATCH V4 11/22] LoongArch: Add process management
To:     Al Viro <viro@zeniv.linux.org.uk>
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

Hi, Al,

On Sun, Oct 3, 2021 at 10:50 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Sep 27, 2021 at 02:42:48PM +0800, Huacai Chen wrote:
>
> > +/*
> > + * Does the process account for user or for system time?
> > + */
> > +#define user_mode(regs) (((regs)->csr_prmd & PLV_MASK) == PLV_USER)
> > +
> > +static inline int is_syscall_success(struct pt_regs *regs)
> > +{
> > +     return !regs->regs[7];
> > +}
> >
> > +static inline long regs_return_value(struct pt_regs *regs)
> > +{
> > +     if (is_syscall_success(regs) || !user_mode(regs))
> > +             return regs->regs[4];
> > +     else
> > +             return -regs->regs[4];
> > +}
>
> Huh???  That looks like you've copied those from MIPS, but on MIPS we have
> things like
>         li      t0, -EMAXERRNO - 1      # error?
>         sltu    t0, t0, v0
>         sd      t0, PT_R7(sp)           # set error flag
>         beqz    t0, 1f
>
>         ld      t1, PT_R2(sp)           # syscall number
>         dnegu   v0                      # error
>         sd      t1, PT_R0(sp)           # save it for syscall restarting
> 1:      sd      v0, PT_R2(sp)           # result
> right after the call of sys_...(), along with the restart logics
> looking like
>         if (regs->regs[0]) {
>                 switch(regs->regs[2]) {
>                 case ERESTART_RESTARTBLOCK:
>                 case ERESTARTNOHAND:
> IOW, syscall return values from -EMAXERRNO to -1 are negated, with
> regs[7] set accordingly.  Nothing of that sort is done in your
> patchset after syscall, and if it had been, your restart logics in
> signal handling would've been wrong anyway.
>
> What's going on there?
Sorry, the code derived from MIPS is wrong here, regs_return_value
should simply return regs->regs[4].

Huacai
