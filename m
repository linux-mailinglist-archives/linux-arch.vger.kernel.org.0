Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B0E41FAF0
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhJBKv6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhJBKv5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 06:51:57 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F314EC061570;
        Sat,  2 Oct 2021 03:50:11 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id c33so8542960uae.9;
        Sat, 02 Oct 2021 03:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hApVBQxpxEC5vFy5Vo/ksJtoWpp3dT/2xS6YTcdOE2Y=;
        b=P4RPrTAKw+Xf8YTtm1ijdqPK6rNH7thWGY11M24OTN89QTWl5phavzvMYOnB841xaO
         r5MWL3qF0YjZMBCfKSLHQRRNKkUn7oUB7u1AB8WQ9VMVs/Z5Dcs9/3GSbjZyaPLZH8A2
         evdyYUhjPjgJHbpf+zYErf0n6OmVD5++ogTQblzFSFWscBYnRRW0PDibXMndfme0RWwB
         2fM6DeJixjQERPJAd0Hg7Or7bcDhf0AUJMEJb8JqRHpYpL/T6t+jwTcewby+QDbvSdQx
         9554NPbY9bEAtg7YGN95WBS5y3gWzoGLGS2MlqX7jJfRGQad1anu9rrz0/tbtbEQiY+u
         cOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hApVBQxpxEC5vFy5Vo/ksJtoWpp3dT/2xS6YTcdOE2Y=;
        b=uymqnCFHD+6bYu7Vhsud5hvIA18SypWr3nmXHyJqwpDQ8xabJ4YjgLjlX539ekf1J8
         +4GvPvwB0I9PvAKFB+hdgpHyuENxRY1B5ZZkAJihjvs4OILgzwNttcnBp2PSq41wjjWW
         Fw18nW4hWzDmVkU78AV0fhqmDeU3Czsy3jT5fqNxODHsbQDaDZj/K+5FBPwLbJUn7IwU
         6cVRjePHuR5DnedLJzTIEJky+Ez2L4U8xhjVL5FrEu2GktFcZ7m32R/VJBlHqpawf6hI
         G9bcvVK41FnieFnCdsLYUTgA2q1K0UtcZeMmsFsebwTcUBzOsoTO/APfQy84nGgutdKT
         es5w==
X-Gm-Message-State: AOAM532cCgyMtKRvWRx4K9f0s2mGfFpQvHho5J7nC5fvux3n+z6oKe8Q
        FziTmOraHPCgY8RDVRU35UnIGAYQwbOjKfO0Bzc=
X-Google-Smtp-Source: ABdhPJxrt0PHaUYomQoyBR7LSumjrjkCTVkFlD8OoKphsiOwEiX4pq6aBotbO+VWDsjqM++E1d15YgXCMvWwLVyq5kc=
X-Received: by 2002:ab0:550f:: with SMTP id t15mr1343048uaa.22.1633171810757;
 Sat, 02 Oct 2021 03:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
 <20210927064300.624279-7-chenhuacai@loongson.cn> <91d12c483421cc7bd69d8ee7f28243d65877a7af.camel@mengyan1223.wang>
In-Reply-To: <91d12c483421cc7bd69d8ee7f28243d65877a7af.camel@mengyan1223.wang>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 2 Oct 2021 18:49:59 +0800
Message-ID: <CAAhV-H6Pt5=DCC39PhJg6jHgpo+GyTGH=KonpncOVFMpD=__Ow@mail.gmail.com>
Subject: Re: [PATCH V4 06/22] LoongArch: Add CPU definition headers
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

On Thu, Sep 30, 2021 at 11:30 PM Xi Ruoyao <xry111@mengyan1223.wang> wrote:
>
> On Mon, 2021-09-27 at 14:42 +0800, Huacai Chen wrote:
>
> > +#define t0     $r12    /* caller saved */
> > +#define t1     $r13
> > +#define t2     $r14
> > +#define t3     $r15
> > +#define t4     $r16
> > +#define t5     $r17
> > +#define t6     $r18
> > +#define t7     $r19
> > +#define t8     $r20
> > +#define x0     $r21
>
> In the doc it's said x0 will be used to name a 256-bit vector register.
> Maybe it's better to rename this one?
OK, I want to rename it to u0 (U means Unused in userspace).

Huacai
>
