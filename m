Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE91C5161E2
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 07:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiEAFPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 01:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEAFPj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 01:15:39 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F850E10;
        Sat, 30 Apr 2022 22:12:15 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id e144so5371269vke.9;
        Sat, 30 Apr 2022 22:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KX3hGhBdd+XtRcdHNUxbUkkuICp1yweLna1e0YtZ2H0=;
        b=ArxpYma4yJaM4WntqJHd5wjwLLHhyQdqwBWYeuHBuvHFeDo9gbWZ03NbB7sdKdZBBS
         25+QJrMwUIDnTmKfVl8Lc6wFAiEkZWMrHHt0b4z7bXvni0Ov4wWY+R1cDppvDltdL0De
         IIO0iwVUvvFEtxm6g3+xJyPtihtYGyAeiv7G6OMYEhVZX59Lx0dzvB5AAtuA9maYXmjA
         psZqUepwWpiPdrjYOHdOaH7aRSjIqY+XcIIhdQbsg9ZDwScYfAXtzYReKypLAXQiXwEF
         KPDjEMNTvzz10NjVodbEDw7PUZKj2OSTaPZqvMy9OQH8WPGMMMBp8hZM3PD5Wcyj97Re
         0JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KX3hGhBdd+XtRcdHNUxbUkkuICp1yweLna1e0YtZ2H0=;
        b=fJLEu1Q0PfDOZxjVauUVQPYlo9Mz+eHludCBicYW1a+iIeM9uQZ6FhGmkZJhQ2N372
         rbndt4hs1SvfEbFWNuXyEqXjNMLtgnRZ8H7NBIATn8kdJ/rkbeOC+CeT6goVOQcLZgEh
         8PJ110TiPzq6KD6VjLIraaJd7YUfF9JfWBcml/ApL9mppD2FGUzfutIay2Gu+HarU7Sp
         E2NTPhrpkrwJaB9q1Po67NSNoJDSBjmjr2o/bDhnwzo2pQfXGpK6bXoRNQY6EOYhpF36
         3KtejBbvUtmQGynOjlKqJI2Z8d1Ky6/jMBNv+fXHCeZLPtayn7Dq6Y9T1p8NASAmbsZ6
         TK6A==
X-Gm-Message-State: AOAM530DrUbXwzyS6HL/LvStq46yttLYzke6Ny01fR3T1x0vwJwjFQsm
        gxCofmGujse/I+DkVgGe+MCqocL8R/damAsx3cT6BnYUJus=
X-Google-Smtp-Source: ABdhPJx5zbqRsv5kbRNC5CwWH0FwZnUIS6m/lkdFIl2rD0gv27WzYcODLE8zl36MwIQELKIKI2xKW5VRY93Yg1smGgQ=
X-Received: by 2002:ac5:c30e:0:b0:34e:9da2:5163 with SMTP id
 j14-20020ac5c30e000000b0034e9da25163mr427837vkk.30.1651381934505; Sat, 30 Apr
 2022 22:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1Cnp-SNiXnSbnUdbw9jC+aT1TxEjckK2jFYgwT-CSpcw@mail.gmail.com>
 <mhng-aac79f77-a392-42cd-a885-247e7625046c@palmer-mbp2014>
In-Reply-To: <mhng-aac79f77-a392-42cd-a885-247e7625046c@palmer-mbp2014>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 1 May 2022 13:12:03 +0800
Message-ID: <CAAhV-H7zX+FdVLRuNDd6Nt4YJGumUsWgoJnEe4E3RuR+dXPraw@mail.gmail.com>
Subject: Re: [PATCH V9 16/24] LoongArch: Add misc common routines
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, guoren@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Palmer,

On Sat, Apr 30, 2022 at 9:22 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sat, 30 Apr 2022 03:41:59 PDT (-0700), Arnd Bergmann wrote:
> > On Sat, Apr 30, 2022 at 12:00 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> >>
> >> On Sat, Apr 30, 2022 at 5:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> >
> >> > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >> >
> >> > > +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
> >> > > +{
> >> > > +       u32 old32, mask, temp;
> >> > > +       volatile u32 *ptr32;
> >> > > +       unsigned int shift;
> >> > > +
> >> > > +       /* Check that ptr is naturally aligned */
> >> >
> >> > As discussed, please remove this function and all the references to it.
> >>
> >> It seems that "generic ticket spinlock" hasn't been merged in 5.18?
> >
> > No, but we can merge it together with the loongarch architecture for 5.19.
> >
> > I suggested you coordinate with Guo Ren and Palmer Dabbelt about how
> > to best merge it. The latest version was pasted two weeks ago [1], and
> > it sounds like there are only minor issues to work out and that I can merge
> > v4 into the asm-generic tree before merging the loongarch code in the
> > same place.
> >
> >      Arnd
> >
> > [1] https://lore.kernel.org/lkml/20220414220214.24556-1-palmer@rivosinc.com/
>
> I can just send another version, IIRC it was just that discussion about
> the memory barrier and there's already prototype code so it shouldn't be
> too bad.  I was hoping to do it sooner, sorry.
I've seen your v4 patches, then I will adjust LoongArch code to use
generic ticket spinlocks.

Huacai
