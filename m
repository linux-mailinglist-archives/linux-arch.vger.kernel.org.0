Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9264E5D39
	for <lists+linux-arch@lfdr.de>; Thu, 24 Mar 2022 03:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbiCXCeI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Mar 2022 22:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCXCeI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2022 22:34:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D51939B1;
        Wed, 23 Mar 2022 19:32:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k14so2740136pga.0;
        Wed, 23 Mar 2022 19:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JCu2rchO2mLo2ocjFa7FXnEzu0+qIWGmr+CpcJYkME=;
        b=omFiFyrBIaDd9kG2A8zDsIjZricwiOad7au0Id2doy9ddFqy8Ez55YIQlO2T5Aradx
         SydyoSdKGKqmae7v8YDImg9Sp975lTYxFMn8DdYIkkOCCT3pDt9a/1OYryomUkYPAa0v
         FEkBNpEjKjfetnegTq1FVqOlqhqTjRuFBHOOTdSCYePx4WkFeRd4eRsrd3GdkzzaWf9w
         XBioUYa/2dV7xuvLD/CzWzYJ7RcJglipJPd5ve8jxcBiRcc5I1okYlV3BKKuvNB+49uv
         wA0GGDYk9C/muZ4Vhk4ymS1cpqAQa8KE7z1Dl3qiKDVoZR1ZYOVYmLkZJhUb7jtYNRL9
         Gbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JCu2rchO2mLo2ocjFa7FXnEzu0+qIWGmr+CpcJYkME=;
        b=RRnTE+FgfK/BTrWFpZV8hZcS994Zi5y4a83gWRo7q+kmt10O6zndlBU3v+MjEplXbj
         TuAOjD33H+qz4R1vxxcsAvMcC8q8572VlnYC7GOc1l7XI8p8hzTb4j9ZvBbVxORdz66L
         21wY6VsYTCtgRModPv/tejnEnEJAW4G5F5SVEiInr6apRKuQcCHR5hb+NjYjrPhOaJrm
         GR3DJNnlr7rd/KDX3aknggBFraCZwnpmekns0aoysU8aK6WnHQkNl9F2nbK5ZRZzX5hz
         xL1DVZ3kNYBlsko9dA75A9maRn5dSXRXM07l0HdHcUtK019DAL70sS6bGEz1kxm4Z3/G
         AzbQ==
X-Gm-Message-State: AOAM532oHHeBDFAKFHTS6GWRsB/ePiwa6m831R8AVCzMCRCnPN6/M0F2
        q+dHCSh8uEJBwN9zhhMKUXjIt0/QGvfgA4hzURuicCPHjCCHqQ==
X-Google-Smtp-Source: ABdhPJxrz0JrJ37/ep6Ttsy6vk1ZKwcClvYc1axasbbOj9eEuClvembSfrhUCbYMq1lxtzZ5cu223yAUtTTJ58wNHqQ=
X-Received: by 2002:a05:6a00:890:b0:4f6:686e:a8a9 with SMTP id
 q16-20020a056a00089000b004f6686ea8a9mr2958051pfj.83.1648089153763; Wed, 23
 Mar 2022 19:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-6-chenhuacai@loongson.cn>
 <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com>
 <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
 <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com> <20220322160234.hxyiugzm3qstyun2@wittgenstein>
In-Reply-To: <20220322160234.hxyiugzm3qstyun2@wittgenstein>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Thu, 24 Mar 2022 10:32:22 +0800
Message-ID: <CACWXhKmh7=mTZRgV=7PMxnMub1hTaLZ==Fo996Qggns=dSHTMg@mail.gmail.com>
Subject: Re: [PATCH V8 13/22] LoongArch: Add system call support
To:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "H.J. Lu" <hjl.tools@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 23 Mar 2022 at 00:02, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Mar 21, 2022 at 10:47:49AM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 21, 2022 at 10:41 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > On Mon, Mar 21, 2022 at 5:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > >
> > > > > This patch adds system call support and related uaccess.h for LoongArch.
> > > > >
> > > > > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > > > > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> > > > >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> > > > >    bit platforms still use newstat now.
> > > > >
> > > > > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > > > > A: The latest glibc release (2.34) has some basic support for clone3 but
> > > > >    it isn't complete. E.g., pthread_create() and spawni() have converted
> > > > >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> > > > >    related applications can still not work perfectly with clone3.
> > > >
> > > > Please leave those out of the mainline kernel support though: Any users
> > > > of existing glibc binaries can keep using patched kernels for the moment,
> > > > and then later drop those pages when the proper glibc support gets
> > > > merged.
> > > The glibc commit d8ea0d0168b190bdf138a20358293c939509367f ("Add an
> > > internal wrapper for clone, clone2 and clone3") modified nearly
> > > everything in order to move to clone3(), except arch_fork() which used
> > > by fork(). And I cannot find any submitted patches to solve it. So I
> > > don't think this is just a forget, maybe there are other fundamental
> > > problems?
> >
> > I don't think there are fundamental issues, they probably did not consider
> > it necessary because so far all architectures supported clone().
> >
> > Adding Christian Brauner and H.J. Lu for clarificatoin.
>
> Probably, yes. I don't know of any fundamental problems there either.
>

Hi, Arnd, Christian,

As far as I know, software that uses the linux sandbox is still using clone(),
such as chromium:

commit 218438259dd795456f0a48f67cbe5b4e520db88b
Author: Matthew Denton <mpdenton@chromium.org>
Date: Thu Jun 3 20:06:13 2021 +0000

    Linux sandbox: return ENOSYS for clone3

    Because clone3 uses a pointer argument rather than a flags argument, we
    cannot examine the contents with seccomp, which is essential to
    preventing sandboxed processes from starting other processes. So, we
    won't be able to support clone3 in Chromium. This CL modifies the
    BPF policy to return ENOSYS for clone3 so glibc always uses the fallback
    to clone.

    Bug: 1213452
    Change-Id: I7c7c585a319e0264eac5b1ebee1a45be2d782303
    Reviewed-on:
https://chromium-review.googlesource.com/c/chromium/src/+/2936184
    Reviewed-by: Robert Sesek <rsesek@chromium.org>
    Commit-Queue: Matthew Denton <mpdenton@chromium.org>
    Cr-Commit-Position: refs/heads/master@{#888980}

Besides arch_fork(), I think removing clone() may lead to more problems.

Thanks,
Feiyang
